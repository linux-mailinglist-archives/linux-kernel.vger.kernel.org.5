Return-Path: <linux-kernel+bounces-128918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D308C8961DB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8973028A350
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F13B1BC4B;
	Wed,  3 Apr 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzYhH1sL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6AA18EBF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106999; cv=none; b=RA/Fto3rcVD9rsOuC6NeMAuRCyC9LSOBjJ6rQqaJ2l73KXjZXX5JpR4okHgVXFF47aDBm1g5r6IQ4ZKqaKmjCmq41J+/n5/CMpLduzoxUWTYO+Z2g+HRAsTtB0Exm3SF15CCaFY6wmFINesVPe6F5b3SJJoilGUTiHu88i4s0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106999; c=relaxed/simple;
	bh=yWMxywR9ri3JYm86TQhPsyU8lSI+jekctAR5j1zGsf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4OLQeofUHgx1zMra/5qYQLWxhq0aPK6QC/DwHHf/Vt0/N8royI47xK7nYviQpV9JMyrtGzlXbr8VdWidzBqOT8YUmi7xLrkTVxDaQE5S3w/VEHpW5xuFSKdDPWB3t1WZNqe8f4m2wBOkcW74IMCdXDbxh9LCcrUJyN5linzXVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzYhH1sL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712106997; x=1743642997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yWMxywR9ri3JYm86TQhPsyU8lSI+jekctAR5j1zGsf4=;
  b=ZzYhH1sLu16xp/DfHlXx+apPlBK82X+Za1XfeIIrNtXjk3uUGK9KsXF3
   /QsqCbHMRabt+PgY3b8pTg9K9QJ43K2ZnQPdiLIrTgEcEWf8L+lAwfrIi
   Y2a/aSTy+Fo062kysfxk72HYTVBNtkl0g8inOb6EFHtspPnmY4aVNtfDd
   xTAJZaByIhDlRTLjybYy/kCD4kTkaABVLOuFV3t5ezlt5kcwwNrA/gfI2
   Yw1v3HBr1xbYgDIpGDWJm7UdNELLrOzwpzxfVAdMfFtwl6KWZXnTgVqGv
   KPIBbSZVtYB01dP3H/CjL36nZ/VzNSL/l/fAXjzfbCNysdQ3M3jx8V3g8
   A==;
X-CSE-ConnectionGUID: titLBtr6SbemxMk33nu7Iw==
X-CSE-MsgGUID: pNTw9abYS9e32Eo3gaKsyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439766"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439766"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:37 -0700
X-CSE-ConnectionGUID: iNnkRohGRmq90DcdzMoRRQ==
X-CSE-MsgGUID: H0qwHFVcT2ycUkg4jew6fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953285"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:35 -0700
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
Subject: [PATCH v4 4/9] iommufd: Fault-capable hw page table attach/detach/replace
Date: Wed,  3 Apr 2024 09:15:14 +0800
Message-Id: <20240403011519.78512-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403011519.78512-1-baolu.lu@linux.intel.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iopf-capable hw page table attach/detach/replace helpers. The pointer
to iommufd_device is stored in the domain attachment handle, so that it
can be echo'ed back in the iopf_group.

The iopf-capable hw page tables can only be attached to devices that
support the IOMMU_DEV_FEAT_IOPF feature. On the first attachment of an
iopf-capable hw_pagetable to the device, the IOPF feature is enabled on
the device. Similarly, after the last iopf-capable hwpt is detached from
the device, the IOPF feature is disabled on the device.

The current implementation allows a replacement between iopf-capable and
non-iopf-capable hw page tables. This matches the nested translation use
case, where a parent domain is attached by default and can then be
replaced with a nested user domain with iopf support.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |   9 ++
 drivers/iommu/iommufd/device.c          |  15 +++-
 drivers/iommu/iommufd/fault.c           | 113 ++++++++++++++++++++++++
 drivers/iommu/iommufd/Makefile          |   1 +
 4 files changed, 135 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iommu/iommufd/fault.c

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 991f864d1f9b..047cfb47112a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -292,6 +292,7 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
+	bool fault_capable;
 };
 
 struct iommufd_hwpt_paging {
@@ -395,6 +396,7 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	bool iopf_enabled;
 };
 
 static inline struct iommufd_device *
@@ -426,6 +428,13 @@ void iopt_remove_access(struct io_pagetable *iopt,
 			u32 iopt_access_list_id);
 void iommufd_access_destroy_object(struct iommufd_object *obj);
 
+int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				    struct iommufd_device *idev);
+void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev);
+int iommufd_fault_domain_replace_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 873630c111c1..4fc183a83925 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -376,7 +376,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
+		if (hwpt->fault_capable)
+			rc = iommufd_fault_domain_attach_dev(hwpt, idev);
+		else
+			rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -402,7 +405,10 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		if (hwpt->fault_capable)
+			iommufd_fault_domain_detach_dev(hwpt, idev);
+		else
+			iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_is_paging(hwpt))
@@ -497,7 +503,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
+	if (old_hwpt->fault_capable || hwpt->fault_capable)
+		rc = iommufd_fault_domain_replace_dev(hwpt, idev);
+	else
+		rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
 	if (rc)
 		goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
new file mode 100644
index 000000000000..47d7c106d839
--- /dev/null
+++ b/drivers/iommu/iommufd/fault.c
@@ -0,0 +1,113 @@
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
+static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
+{
+	int ret;
+
+	if (idev->iopf_enabled)
+		return 0;
+
+	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+	if (ret)
+		return ret;
+
+	idev->iopf_enabled = true;
+
+	return 0;
+}
+
+static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
+{
+	if (!idev->iopf_enabled)
+		return;
+
+	iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+	idev->iopf_enabled = false;
+}
+
+int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				    struct iommufd_device *idev)
+{
+	struct iommu_attach_handle *handle;
+	int ret;
+
+	if (!hwpt->fault_capable)
+		return -EINVAL;
+
+	if (!idev->iopf_enabled) {
+		ret = iommufd_fault_iopf_enable(idev);
+		if (ret)
+			return ret;
+	}
+
+	ret = iommu_attach_group(hwpt->domain, idev->igroup->group);
+	if (ret) {
+		iommufd_fault_iopf_disable(idev);
+		return ret;
+	}
+
+	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID);
+	handle->priv = idev;
+	iommu_attach_handle_put(handle);
+
+	return 0;
+}
+
+void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev)
+{
+	if (WARN_ON(!hwpt->fault_capable))
+		return;
+
+	iommu_detach_group(hwpt->domain, idev->igroup->group);
+	iommufd_fault_iopf_disable(idev);
+}
+
+int iommufd_fault_domain_replace_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev)
+{
+	bool iopf_enabled_originally = idev->iopf_enabled;
+	struct iommu_attach_handle *handle;
+	int ret;
+
+	if (hwpt->fault_capable) {
+		ret = iommufd_fault_iopf_enable(idev);
+		if (ret)
+			return ret;
+	}
+
+	ret = iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
+	if (ret)
+		goto out_cleanup;
+
+	if (!hwpt->fault_capable)
+		iommufd_fault_iopf_disable(idev);
+
+	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID);
+	handle->priv = idev;
+	iommu_attach_handle_put(handle);
+
+	return 0;
+out_cleanup:
+	if (iopf_enabled_originally)
+		iommufd_fault_iopf_enable(idev);
+	else
+		iommufd_fault_iopf_disable(idev);
+
+	return ret;
+}
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


