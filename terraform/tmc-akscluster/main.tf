terraform {
  required_providers {
    tanzu-mission-control = {
      source  = "vmware/tanzu-mission-control"
      version = "1.2.3"
    }
  }
}

// Basic details needed to configure Tanzu Mission Control provider
provider "tanzu-mission-control" {
  endpoint            = var.tmc_endpoint
  vmw_cloud_api_token = var.vmw_cloud_api_token
}

resource "tanzu-mission-control_akscluster" "aks_cluster" {
  credential_name = var.azure_credential_name
  subscription_id = var.azure_subscription_id
  resource_group  = var.azure_resource_group
  name            = var.cluster_name
  meta {
    description = var.cluster_description
    labels      = var.cluster_labels
  }
  spec {
    cluster_group   = var.cluster_group_name
    config {
      location           = var.cluster_location
      kubernetes_version = var.kubernetes_version
      network_config {
        dns_prefix = var.cluster_dns_prefix
      }
    }
    nodepool {
      name = var.nodepool_1_name
      spec {
        count   = var.nodepool_1_count
        mode    = "SYSTEM"
        vm_size = var.nodepool_1_vm_size
        os_disk_size_gb = var.nodepool_1_node_disk_size_gb
        auto_scaling_config {
          enable    = var.nodepool_1_enable_auto_scaling
          max_count = var.nodepool_1_max_node_count
          min_count = var.nodepool_1_min_node_count
        }
      }
    }
  }
}
