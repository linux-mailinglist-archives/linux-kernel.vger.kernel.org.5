Return-Path: <linux-kernel+bounces-164215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 129D08B7AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3EF28506E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6B17557B;
	Tue, 30 Apr 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nznUFgrT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76FB175552
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489150; cv=none; b=VRz43d+vWjSIO0HsZ4XvcjsRSTH8exLXrrwZ/3O7BsmUrz/ALux8Ac2RKwxznqYL7Tp5zTGauMvJ85ckxSNnkdggoYRhQHtKJ0P91c1owX9mkN+jIyn6tT4A03S49FHT4deNRYELsbsW/+avkthzq0sPp8YaKPJm7wXR7jzyLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489150; c=relaxed/simple;
	bh=nackDiVCcjLRAorvRC+4p3xshffv/i1c1dhcW7Btwok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mhD40owmHJfb6zCJUmj9DbsaL8j6OMSYPfTMzsaOXeXss9418FkoVYkeBQfauAnurhZjfGGuYH75wyl+oJshlYltlcvQtgtkQg7HVaNWfY6nrWGXAxwLcKtBHDdEHcJR0SCecb2nfzcNC8bIjD/6hLySEqYf0sjJIsZSba65ubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nznUFgrT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489148; x=1746025148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nackDiVCcjLRAorvRC+4p3xshffv/i1c1dhcW7Btwok=;
  b=nznUFgrT+ClNMEUfCHBg7vjVXhrJUWtaZZmxKQ4o+p4LnDzdAi9cKBKY
   L0sMFhaZ6LzAfDPFAltQAuQ6K6xhrgnLBMoiT41WwB4s6hG06ET3pxItJ
   s+qzlda42WJHD+MtzgMnDqXRM3MHFCaUhZJH61Wqb1eOQ7YsdUsY6ijjk
   hFjrhi2NIV+tOkjciZNrK19nEVyfNaK7N2pKkMiVXBojwPl+fobmbY27A
   fCevRmE0a3XiiWVqDbsFPuUs9iq/EweQmnC1eg1WGfXawtvaRT8Hy5Cjr
   nY1C12IDU9ubXnO/TUpMfUACPTLdLaqbevaMwEnRSRY4vWxrbQ2QjbMLT
   A==;
X-CSE-ConnectionGUID: SZbvG9aeRbCEPyrw+yoSNg==
X-CSE-MsgGUID: OAbAhkF6Q4eM/n5j2APHLQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10059896"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10059896"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:59:08 -0700
X-CSE-ConnectionGUID: eAD2bWpWSIyOqJi5lHaJHA==
X-CSE-MsgGUID: aCbay7g0TCGsrfMxx209yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31282213"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:59:04 -0700
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
Subject: [PATCH v5 5/9] iommufd: Add iommufd fault object
Date: Tue, 30 Apr 2024 22:57:06 +0800
Message-Id: <20240430145710.68112-6-baolu.lu@linux.intel.com>
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

An iommufd fault object provides an interface for delivering I/O page
faults to user space. These objects are created and destroyed by user
space, and they can be associated with or dissociated from hardware page
table objects during page table allocation or destruction.

User space interacts with the fault object through a file interface. This
interface offers a straightforward and efficient way for user space to
handle page faults. It allows user space to read fault messages
sequentially and respond to them by writing to the same file. The file
interface supports reading messages in poll mode, so it's recommended that
user space applications use io_uring to enhance read and write efficiency.

A fault object can be associated with any iopf-capable iommufd_hw_pgtable
during the pgtable's allocation. All I/O page faults triggered by devices
when accessing the I/O addresses of an iommufd_hw_pgtable are routed
through the fault object to user space. Similarly, user space's responses
to these page faults are routed back to the iommu device driver through
the same fault object.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h                   |   3 +
 drivers/iommu/iommu-priv.h              |   4 +
 drivers/iommu/iommufd/iommufd_private.h |  24 +++
 include/uapi/linux/iommufd.h            |  18 ++
 drivers/iommu/iommufd/device.c          |   1 +
 drivers/iommu/iommufd/fault.c           | 238 ++++++++++++++++++++++++
 drivers/iommu/iommufd/main.c            |   6 +
 drivers/iommu/iommufd/Makefile          |   1 +
 8 files changed, 295 insertions(+)
 create mode 100644 drivers/iommu/iommufd/fault.c

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4ff68d50ae39..a7301b27e01f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -131,6 +131,9 @@ struct iopf_group {
 	struct iommu_attach_handle *attach_handle;
 	/* The device's fault data parameter. */
 	struct iommu_fault_param *fault_param;
+	/* Used by handler provider to hook the group on its own lists. */
+	struct list_head node;
+	u32 cookie;
 };
 
 /**
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index ae65e0b85d69..1a0450a83bd0 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -36,6 +36,10 @@ struct iommu_attach_handle {
 			struct device	*dev;
 			refcount_t	users;
 		};
+		/* attach data for IOMMUFD */
+		struct {
+			void		*idev;
+		};
 	};
 };
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 991f864d1f9b..acb89bbf9f8e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -128,6 +128,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_HWPT_NESTED,
 	IOMMUFD_OBJ_IOAS,
 	IOMMUFD_OBJ_ACCESS,
+	IOMMUFD_OBJ_FAULT,
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
@@ -395,6 +396,8 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	/* outstanding faults awaiting response indexed by fault group id */
+	struct xarray faults;
 };
 
 static inline struct iommufd_device *
@@ -426,6 +429,27 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+/*
+ * An iommufd_fault object represents an interface to deliver I/O page faults
+ * to the user space. These objects are created/destroyed by the user space and
+ * associated with hardware page table objects during page-table allocation.
+ */
+struct iommufd_fault {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct file *filep;
+
+	/* The lists of outstanding faults protected by below mutex. */
+	struct mutex mutex;
+	struct list_head deliver;
+	struct list_head response;
+
+	struct wait_queue_head wait_queue;
+};
+
+int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
+void iommufd_fault_destroy(struct iommufd_object *obj);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 83b45dce94a4..1819b28e9e6b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -50,6 +50,7 @@ enum {
 	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_FAULT_ALLOC,
 };
 
 /**
@@ -788,4 +789,21 @@ struct iommu_hwpt_page_response {
 	__u32 cookie;
 	__u32 reserved;
 };
+
+/**
+ * struct iommu_fault_alloc - ioctl(IOMMU_FAULT_ALLOC)
+ * @size: sizeof(struct iommu_fault_alloc)
+ * @flags: Must be 0
+ * @out_fault_id: The ID of the new FAULT
+ * @out_fault_fd: The fd of the new FAULT
+ *
+ * Explicitly allocate a fault handling object.
+ */
+struct iommu_fault_alloc {
+	__u32 size;
+	__u32 flags;
+	__u32 out_fault_id;
+	__u32 out_fault_fd;
+};
+#define IOMMU_FAULT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_ALLOC)
 #endif
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 873630c111c1..22e22969363a 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -215,6 +215,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
+	xa_init_flags(&idev->faults, XA_FLAGS_ALLOC1);
 
 	/*
 	 * If the caller fails after this success it must call
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
new file mode 100644
index 000000000000..13125c0feecb
--- /dev/null
+++ b/drivers/iommu/iommufd/fault.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2024 Intel Corporation
+ */
+#define pr_fmt(fmt) "iommufd: " fmt
+
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/iommufd.h>
+#include <linux/poll.h>
+#include <linux/anon_inodes.h>
+#include <uapi/linux/iommufd.h>
+
+#include "../iommu-priv.h"
+#include "iommufd_private.h"
+
+void iommufd_fault_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
+	struct iopf_group *group, *next;
+
+	/*
+	 * The iommufd object's reference count is zero at this point.
+	 * We can be confident that no other threads are currently
+	 * accessing this pointer. Therefore, acquiring the mutex here
+	 * is unnecessary.
+	 */
+	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+		list_del(&group->node);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+}
+
+static void iommufd_compose_fault_message(struct iommu_fault *fault,
+					  struct iommu_hwpt_pgfault *hwpt_fault,
+					  struct iommufd_device *idev,
+					  u32 cookie)
+{
+	hwpt_fault->size = sizeof(*hwpt_fault);
+	hwpt_fault->flags = fault->prm.flags;
+	hwpt_fault->dev_id = idev->obj.id;
+	hwpt_fault->pasid = fault->prm.pasid;
+	hwpt_fault->grpid = fault->prm.grpid;
+	hwpt_fault->perm = fault->prm.perm;
+	hwpt_fault->addr = fault->prm.addr;
+	hwpt_fault->length = 0;
+	hwpt_fault->cookie = cookie;
+}
+
+static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
+				       size_t count, loff_t *ppos)
+{
+	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
+	struct iommufd_fault *fault = filep->private_data;
+	struct iommu_hwpt_pgfault data;
+	struct iommufd_device *idev;
+	struct iopf_group *group;
+	struct iopf_fault *iopf;
+	size_t done = 0;
+	int rc;
+
+	if (*ppos || count % fault_size)
+		return -ESPIPE;
+
+	mutex_lock(&fault->mutex);
+	while (!list_empty(&fault->deliver) && count > done) {
+		group = list_first_entry(&fault->deliver,
+					 struct iopf_group, node);
+
+		if (list_count_nodes(&group->faults) * fault_size > count - done)
+			break;
+
+		idev = group->attach_handle->idev;
+		if (!idev)
+			break;
+
+		rc = xa_alloc(&idev->faults, &group->cookie, group,
+			      xa_limit_32b, GFP_KERNEL);
+		if (rc)
+			break;
+
+		list_for_each_entry(iopf, &group->faults, list) {
+			iommufd_compose_fault_message(&iopf->fault,
+						      &data, idev,
+						      group->cookie);
+			rc = copy_to_user(buf + done, &data, fault_size);
+			if (rc) {
+				xa_erase(&idev->faults, group->cookie);
+				break;
+			}
+			done += fault_size;
+		}
+
+		list_del(&group->node);
+	}
+	mutex_unlock(&fault->mutex);
+
+	return done;
+}
+
+static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *buf,
+					size_t count, loff_t *ppos)
+{
+	size_t response_size = sizeof(struct iommu_hwpt_page_response);
+	struct iommufd_fault *fault = filep->private_data;
+	struct iommu_hwpt_page_response response;
+	struct iommufd_device *idev = NULL;
+	struct iopf_group *group;
+	size_t done = 0;
+	int rc;
+
+	if (*ppos || count % response_size)
+		return -ESPIPE;
+
+	mutex_lock(&fault->mutex);
+	while (count > done) {
+		rc = copy_from_user(&response, buf + done, response_size);
+		if (rc)
+			break;
+
+		if (!idev || idev->obj.id != response.dev_id)
+			idev = container_of(iommufd_get_object(fault->ictx,
+							       response.dev_id,
+							       IOMMUFD_OBJ_DEVICE),
+					    struct iommufd_device, obj);
+		if (IS_ERR(idev))
+			break;
+
+		group = xa_erase(&idev->faults, response.cookie);
+		if (!group)
+			break;
+
+		iopf_group_response(group, response.code);
+		iopf_free_group(group);
+		done += response_size;
+
+		iommufd_put_object(fault->ictx, &idev->obj);
+	}
+	mutex_unlock(&fault->mutex);
+
+	return done;
+}
+
+static __poll_t iommufd_fault_fops_poll(struct file *filep,
+					struct poll_table_struct *wait)
+{
+	struct iommufd_fault *fault = filep->private_data;
+	__poll_t pollflags = EPOLLOUT;
+
+	poll_wait(filep, &fault->wait_queue, wait);
+	mutex_lock(&fault->mutex);
+	if (!list_empty(&fault->deliver))
+		pollflags |= EPOLLIN | EPOLLRDNORM;
+	mutex_unlock(&fault->mutex);
+
+	return pollflags;
+}
+
+static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
+{
+	struct iommufd_fault *fault = filep->private_data;
+
+	iommufd_ctx_put(fault->ictx);
+	refcount_dec(&fault->obj.users);
+	return 0;
+}
+
+static const struct file_operations iommufd_fault_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nonseekable_open,
+	.read		= iommufd_fault_fops_read,
+	.write		= iommufd_fault_fops_write,
+	.poll		= iommufd_fault_fops_poll,
+	.release	= iommufd_fault_fops_release,
+	.llseek		= no_llseek,
+};
+
+int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_fault_alloc *cmd = ucmd->cmd;
+	struct iommufd_fault *fault;
+	struct file *filep;
+	int fdno;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	fault = iommufd_object_alloc(ucmd->ictx, fault, IOMMUFD_OBJ_FAULT);
+	if (IS_ERR(fault))
+		return PTR_ERR(fault);
+
+	fault->ictx = ucmd->ictx;
+	INIT_LIST_HEAD(&fault->deliver);
+	mutex_init(&fault->mutex);
+	init_waitqueue_head(&fault->wait_queue);
+
+	filep = anon_inode_getfile("[iommufd-pgfault]", &iommufd_fault_fops,
+				   fault, O_RDWR);
+	if (IS_ERR(filep)) {
+		rc = PTR_ERR(filep);
+		goto out_abort;
+	}
+
+	refcount_inc(&fault->obj.users);
+	iommufd_ctx_get(fault->ictx);
+	fault->filep = filep;
+
+	fdno = get_unused_fd_flags(O_CLOEXEC);
+	if (fdno < 0) {
+		rc = fdno;
+		goto out_fput;
+	}
+
+	cmd->out_fault_id = fault->obj.id;
+	cmd->out_fault_fd = fdno;
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
+	iommufd_object_finalize(ucmd->ictx, &fault->obj);
+
+	fd_install(fdno, fault->filep);
+
+	return 0;
+out_put_fdno:
+	put_unused_fd(fdno);
+out_fput:
+	fput(filep);
+	refcount_dec(&fault->obj.users);
+	iommufd_ctx_put(fault->ictx);
+out_abort:
+	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->obj);
+
+	return rc;
+}
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 39b32932c61e..792db077d33e 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -332,6 +332,7 @@ union ucmd_buffer {
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_vfio_ioas vfio_ioas;
+	struct iommu_fault_alloc fault;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -381,6 +382,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 val64),
 	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
 		 __reserved),
+	IOCTL_OP(IOMMU_FAULT_ALLOC, iommufd_fault_alloc, struct iommu_fault_alloc,
+		 out_fault_fd),
 #ifdef CONFIG_IOMMUFD_TEST
 	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
 #endif
@@ -513,6 +516,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 		.destroy = iommufd_hwpt_nested_destroy,
 		.abort = iommufd_hwpt_nested_abort,
 	},
+	[IOMMUFD_OBJ_FAULT] = {
+		.destroy = iommufd_fault_destroy,
+	},
 #ifdef CONFIG_IOMMUFD_TEST
 	[IOMMUFD_OBJ_SELFTEST] = {
 		.destroy = iommufd_selftest_destroy,
diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index 34b446146961..b94a74366eed 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -6,6 +6,7 @@ iommufd-y := \
 	ioas.o \
 	main.o \
 	pages.o \
+	fault.o \
 	vfio_compat.o
 
 iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
-- 
2.34.1


