provider "aws" {
  region = var.aws_region
}
module "autoscaling" {
  source = "https://github.com/suchitagithub/autoscaling_task.git?ref=1.0.0"
 
  ami_id             = ami-0075013580f6322a1
  instance_type      = var.instance_type
  security_group_id  = module.vpc.security_group_id
  user_data          = <<-EOF
                        #!/bin/bash
                        sudo apt-get update
                        sudo apt-get install -y nginx
                        sudo systemctl start nginx
                        sudo systemctl enable nginx
                        EOF
  subnet_ids         = module.vpc.private_subnet_ids
  min_size           = var.min_size
  max_size           = var.max_size
  desired_capacity   = var.desired_capacity
  target_group_arn   = module.loadbalancer.target_group_arn
}
