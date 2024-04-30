Return-Path: <linux-kernel+bounces-164212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC27B8B7AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98541C23016
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041BA129E9F;
	Tue, 30 Apr 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jP10sAtg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89F77117
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714489141; cv=none; b=eWyqqAEpmsfNf4U3fdoV+lpaPQJyjQFJaNMgDHnbtjXuO3Xe83fYz4nYERVZoe6Fu4oq8mwnvZkRhYcIXrOIpyjLhXaFSWRhVZcLJgT2rL+/DA9tmyz89+knChaFT02PrpJZhkQfg8Ms5IGvw1I8d3uNfrTgM6Sircd2G14T+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714489141; c=relaxed/simple;
	bh=H+AJrUc9ZCkByr7T1GCK++YEnrHUWVMDktf/LRmmeCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTf8NvdzmvBpsLGPd4eEbTrHoMNKQiyy451BFeJ9Q4ri4a7b8EgFLh0KeG/Z9AcPuhUvigSHH1pE+G3wQnCau/TKyUZrLdokZzSYW1a2KD4Fsl7dXFjFphbjXcfFEA+fyEwFLMDngj0n7AntWCa26UaGMzsbsVKCgI0ny6JPxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jP10sAtg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714489140; x=1746025140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+AJrUc9ZCkByr7T1GCK++YEnrHUWVMDktf/LRmmeCw=;
  b=jP10sAtg+6HCcCvOF701rKVOcplrohFmK3OJ4VgbEfNvqtSoDQKnrnYE
   pl1+T/GbY1LGA6qQ4Ey2DfvXS4uXnBGmiDsQ393BE+pa6Y5Ve7Qn3XjHX
   FbMFvlhrAz/JTt4VmlL/YZUcDHMynM7PyuG/pMiLpTTKyqc/D91RCXW7y
   DoIgmTKST4ZDOsDSn4hfmrQpOedCZvEHEldBYbMPAl3ZpHYYCFoJorYiA
   qd3PdaXBSUVu7bAJgTfLgj/by+dvoeYo4oy0myqlDrzRIAADbRYrhzsZp
   jISqgqNDsN+FzVQp6PUITS37CkOfN+uj6fOYfeST+Ln5sU1/YWwv9+ytk
   w==;
X-CSE-ConnectionGUID: wn6QA7NHRdef7HHM9OPnMA==
X-CSE-MsgGUID: KrB8Zwe0QnS34lHvHAXNnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10059868"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10059868"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 07:59:00 -0700
X-CSE-ConnectionGUID: KfyaQy1YRHSL8PrqPvEEdg==
X-CSE-MsgGUID: P4r+VsbnSnGfOXnmSJh19Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="31282179"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 30 Apr 2024 07:58:56 -0700
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
Subject: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
Date: Tue, 30 Apr 2024 22:57:04 +0800
Message-Id: <20240430145710.68112-4-baolu.lu@linux.intel.com>
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

Previously, the domain that a page fault targets is stored in an
iopf_group, which represents a minimal set of page faults. With the
introduction of attachment handle, replace the domain with the handle
so that the fault handler can obtain more information as needed
when handling the faults.

iommu_report_device_fault() is currently used for SVA page faults,
which handles the page fault in an internal cycle. The domain is retrieved
with iommu_get_domain_for_dev_pasid() if the pasid in the fault message
is valid. This doesn't work in IOMMUFD case, where if the pasid table of
a device is wholly managed by user space, there is no domain attached to
the PASID of the device. Improve this code to try fetching the attachment
handle on a PASID if possible, otherwise try it on the RID.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      |  1 +
 drivers/iommu/io-pgfault.c | 34 ++++++++++++++--------------------
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index be9c9a10169d..4ff68d50ae39 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -128,6 +128,7 @@ struct iopf_group {
 	struct list_head pending_node;
 	struct work_struct work;
 	struct iommu_domain *domain;
+	struct iommu_attach_handle *attach_handle;
 	/* The device's fault data parameter. */
 	struct iommu_fault_param *fault_param;
 };
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 06d78fcc79fd..f19215d4ffa2 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -59,28 +59,19 @@ void iopf_free_group(struct iopf_group *group)
 }
 EXPORT_SYMBOL_GPL(iopf_free_group);
 
-static struct iommu_domain *get_domain_for_iopf(struct device *dev,
-						struct iommu_fault *fault)
+static int get_attach_handle_for_iopf(struct device *dev, ioasid_t pasid,
+				      struct iopf_group *group)
 {
-	struct iommu_domain *domain;
+	struct iommu_attach_handle *handle;
 
-	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
-		domain = iommu_get_domain_for_dev_pasid(dev, fault->prm.pasid, 0);
-		if (IS_ERR(domain))
-			domain = NULL;
-	} else {
-		domain = iommu_get_domain_for_dev(dev);
-	}
+	handle = iommu_attach_handle_get(dev->iommu_group, pasid, 0);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
 
-	if (!domain || !domain->iopf_handler) {
-		dev_warn_ratelimited(dev,
-			"iopf (pasid %d) without domain attached or handler installed\n",
-			 fault->prm.pasid);
+	group->attach_handle = handle;
+	group->domain = handle->domain;
 
-		return NULL;
-	}
-
-	return domain;
+	return 0;
 }
 
 /* Non-last request of a group. Postpone until the last one. */
@@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group == &abort_group)
 		goto err_abort;
 
-	group->domain = get_domain_for_iopf(dev, fault);
-	if (!group->domain)
+	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
+	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
+		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);
+
+	if (!group->attach_handle || !group->domain->iopf_handler)
 		goto err_abort;
 
 	/*
-- 
2.34.1


