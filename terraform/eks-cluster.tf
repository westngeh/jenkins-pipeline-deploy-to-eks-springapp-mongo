module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.5"
    cluster_name = "myapp-eks-cluster"
    cluster_version = "1.24"

    cluster_endpoint_public_access  = true

    vpc_id = module.myapp-vpc.vpc_id
    subnet_ids = module.myapp-vpc.private_subnets

    tags = {
        environment = "development"
        application = "myapp"
    }

  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t2.medium"]

      additional_tags = {
        Name = "myapp-eks-node"
      }

      launch_template = {
        id      = "lt-0a3c2461eeb261903" # Ensure this is correct and valid
        version = "1"
      }

      scaling_config = {
        min_size     = 1
        max_size     = 2
        desired_size = 1
      }

      update_config = {
        max_unavailable = 1  # Specify only one of max_unavailable or max_unavailable_percentage
      }
    }
  }
}