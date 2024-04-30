Return-Path: <linux-kernel+bounces-164217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3186D8B7ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7081C23458
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893C0143740;
	Tue, 30 Apr 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fg2KkTMv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152D178CC0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489156; cv=none; b=n4eckb/4BO+5lANbouSDRiqMYNKmmaOZx2tshC5x86h1FHcR/10KZQzfuFvtAsBoebaBmRjdnNVPCHa7fda6hGiL2panK8ajvf2Dimi4IINc49tdJHODjc2llNTqAVICiNUP1pTokqDyL2p4TUv8fRmABTjR4LvmEpsZxNTxMpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489156; c=relaxed/simple;
	bh=bQcpzbrPa3TSjIzEthJ7rNM15NvbycZUp6WTHo4uJOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYc8wNW6gZMNy1Sj2BDkhvArbj468tPbUuo6jjvNNJWT6+xPS3CL/R4g+3Q24FdbnXHAkFlvRICYVj7cuajq4TWnompevBu83Z173aK2K9Qa4oJ+7OajJeEqP5/btZntb19476AyjzYZtBqdXMoTAFoM7Z4WA1DEyHbv4FHJ+e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fg2KkTMv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489155; x=1746025155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bQcpzbrPa3TSjIzEthJ7rNM15NvbycZUp6WTHo4uJOI=;
  b=fg2KkTMvnkA/8ELMcwfzKBa4yvuoMqhzyK+wJZQqdaQmmri3iMJa2xZB
   rtygEB3IyFahtHZqhGBFT3KuVQ61j4+eBMWjid7SgHuMfTXA2N8ZveQ15
   Kq9N1Gvt8T9eyUAAfpIPj25UtfW4KntFH8qqAu1VvgTL2uoIUCeJ+yRNZ
   3BwCijl1AJO7tiTbWPTnf4pg3yPOQjeEBNS9MNz+fjvOovocqxwD0ieRI
   L4fHYYAn1tjhgsbkCRNRKtSyCO6DAyfBFlXEoMsREC0Kq6vOKEUt7q5UF
   qOEVdiEk0dCMb1oun5huCC0hux0O+1p3lSvhNlFn+R8FyfJvFYjJv1nJI
   w==;
X-CSE-ConnectionGUID: xqDuHmbgR9O4rGU9AY000w==
X-CSE-MsgGUID: cjT9SqBHQdCeiJjpmI205A==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10059938"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10059938"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:59:15 -0700
X-CSE-ConnectionGUID: 9dCIZ7DTSJyfmaYYWFKA1w==
X-CSE-MsgGUID: rmJ0tdK9TqeRzFJOY+lTKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31282231"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:59:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 7/9] iommufd: Associate fault object with iommufd_hw_pgtable
Date: Tue, 30 Apr 2024 22:57:08 +0800
Message-Id: <20240430145710.68112-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430145710.68112-1-baolu.lu@linux.intel.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When allocating a user iommufd_hw_pagetable, the user space is allowed to
associate a fault object with the hw_pagetable by specifying the fault
object ID in the page table allocation data and setting the
IOMMU_HWPT_FAULT_ID_VALID flag bit.

On a successful return of hwpt allocation, the user can retrieve and
respond to page faults by reading and writing the file interface of the
fault object.

Once a fault object has been associated with a hwpt, the hwpt is
iopf-capable, indicated by fault_capable set to true. Attaching,
detaching, or replacing an iopf-capable hwpt to an RID or PASID will
differ from those that are not iopf-capable.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  9 +++++++
 include/uapi/linux/iommufd.h            |  8 ++++++
 drivers/iommu/iommufd/fault.c           | 17 ++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    | 35 +++++++++++++++++++------
 drivers/iommu/iommufd/main.c            |  2 +-
 5 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 18c8d7d38dcd..100c7b585e7e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -449,8 +449,17 @@ struct iommufd_fault {
 	struct wait_queue_head wait_queue;
 };
 
+static inline struct iommufd_fault *
+iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
+{
+	return container_of(iommufd_get_object(ucmd->ictx, id,
+					       IOMMUFD_OBJ_FAULT),
+			    struct iommufd_fault, obj);
+}
+
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
+int iommufd_fault_iopf_handler(struct iopf_group *group);
 
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 				    struct iommufd_device *idev);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1819b28e9e6b..3d566c1ffcc6 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -357,10 +357,13 @@ struct iommu_vfio_ioas {
  *                                the parent HWPT in a nesting configuration.
  * @IOMMU_HWPT_ALLOC_DIRTY_TRACKING: Dirty tracking support for device IOMMU is
  *                                   enforced on device attachment
+ * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
+ *                             valid.
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
+	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
 };
 
 /**
@@ -412,6 +415,9 @@ enum iommu_hwpt_data_type {
  * @data_type: One of enum iommu_hwpt_data_type
  * @data_len: Length of the type specific data
  * @data_uptr: User pointer to the type specific data
+ * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
+ *            IOMMU_HWPT_FAULT_ID_VALID is set.
+ * @__reserved2: Padding to 64-bit alignment. Must be 0.
  *
  * Explicitly allocate a hardware page table object. This is the same object
  * type that is returned by iommufd_device_attach() and represents the
@@ -442,6 +448,8 @@ struct iommu_hwpt_alloc {
 	__u32 data_type;
 	__u32 data_len;
 	__aligned_u64 data_uptr;
+	__u32 fault_id;
+	__u32 __reserved2;
 };
 #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 6357229bf3b4..802d0f819b22 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -354,3 +354,20 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 
 	return rc;
 }
+
+int iommufd_fault_iopf_handler(struct iopf_group *group)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_fault *fault;
+
+	hwpt = group->domain->fault_data;
+	fault = hwpt->fault;
+
+	mutex_lock(&fault->mutex);
+	list_add_tail(&group->node, &fault->deliver);
+	mutex_unlock(&fault->mutex);
+
+	wake_up_interruptible(&fault->wait_queue);
+
+	return 0;
+}
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 33d142f8057d..f7d05e12dea1 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -8,6 +8,15 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
+{
+	if (hwpt->domain)
+		iommu_domain_free(hwpt->domain);
+
+	if (hwpt->fault)
+		iommufd_put_object(hwpt->fault->ictx, &hwpt->fault->obj);
+}
+
 void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_hwpt_paging *hwpt_paging =
@@ -22,9 +31,7 @@ void iommufd_hwpt_paging_destroy(struct iommufd_object *obj)
 					 hwpt_paging->common.domain);
 	}
 
-	if (hwpt_paging->common.domain)
-		iommu_domain_free(hwpt_paging->common.domain);
-
+	__iommufd_hwpt_destroy(&hwpt_paging->common);
 	refcount_dec(&hwpt_paging->ioas->obj.users);
 }
 
@@ -49,9 +56,7 @@ void iommufd_hwpt_nested_destroy(struct iommufd_object *obj)
 	struct iommufd_hwpt_nested *hwpt_nested =
 		container_of(obj, struct iommufd_hwpt_nested, common.obj);
 
-	if (hwpt_nested->common.domain)
-		iommu_domain_free(hwpt_nested->common.domain);
-
+	__iommufd_hwpt_destroy(&hwpt_nested->common);
 	refcount_dec(&hwpt_nested->parent->common.obj.users);
 }
 
@@ -213,7 +218,8 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags || !user_data->len || !ops->domain_alloc_user)
+	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	    !user_data->len || !ops->domain_alloc_user)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent)
 		return ERR_PTR(-EINVAL);
@@ -227,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
 
-	hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
+	hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
 					      parent->common.domain, user_data);
 	if (IS_ERR(hwpt->domain)) {
 		rc = PTR_ERR(hwpt->domain);
@@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		goto out_put_pt;
 	}
 
+	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
+		struct iommufd_fault *fault;
+
+		fault = iommufd_get_fault(ucmd, cmd->fault_id);
+		if (IS_ERR(fault)) {
+			rc = PTR_ERR(fault);
+			goto out_hwpt;
+		}
+		hwpt->fault = fault;
+		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
+		hwpt->domain->fault_data = hwpt;
+	}
+
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 792db077d33e..d8414ee9feae 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -359,7 +359,7 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
 		 __reserved),
 	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
-		 __reserved),
+		 __reserved2),
 	IOCTL_OP(IOMMU_HWPT_GET_DIRTY_BITMAP, iommufd_hwpt_get_dirty_bitmap,
 		 struct iommu_hwpt_get_dirty_bitmap, data),
 	IOCTL_OP(IOMMU_HWPT_INVALIDATE, iommufd_hwpt_invalidate,
-- 
2.34.1


