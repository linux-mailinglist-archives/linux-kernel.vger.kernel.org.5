Return-Path: <linux-kernel+bounces-128916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD08961D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C83BB23B81
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D614011190;
	Wed,  3 Apr 2024 01:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJPEE5Q8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CC175AB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712106993; cv=none; b=iFPXsak+sWRp1sdKWMB0qUI6xlEMvfkdOP/a+qIRmBT9sv2x/W2K/l18Qli5vD2+15i2iUQdc66VLqbkfTD//Hi2TL+xPpvWghhEKMRLob//dPZM9rwqJ97VxUyVBUFpfWPUvd3H+zanTf9VqSlZUUkwONlE3T3nQ9MqK2LrBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712106993; c=relaxed/simple;
	bh=bXMfbUrglKi+dnCSypeOisTs+5d9InL97S+y6S9p+Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sx/8FrDDn3trfhvO7MJwTH3CiOCEN3ACvQCDs+gHOYyGPPshzP85RyAgTFOqvdM46UO22PLXdcDpEwx6PuRfrtQJCr6vCnm/YzfeRfPD9ymMuiobhRpHo2ga1ieoUHCXoBCWLm69VsNXX4b+y3HGl5vaVnc354A/9xdGUebgDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJPEE5Q8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712106991; x=1743642991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXMfbUrglKi+dnCSypeOisTs+5d9InL97S+y6S9p+Hc=;
  b=TJPEE5Q8oRIwI3+T/nUnWsix/f8AqQOKrDdC94h6dwHHXAPvqdx/i829
   +ShSmIkg6Om3bFkIAD2nV7smb9OUc/vOwtfUp/hAX8kJeuOcbzzOJCErN
   pC7Kz8uxqBtdgquPphTCJi1GSaF5Lnm38qdlZ4Z9UYV1y00vzh7kU3bCD
   0MbbFEBVblYihoXoV6/K9Id1IH2lVdRIk4c2at1y28ggBXV2ugy73P5+6
   iYx1Bs2x0UMa2TrAs0Nv5m9Y4NS6KaZeCdGYgsj9vbUels37h6tjvZ7wy
   M8DwvHgz+uNjtX3G+NkBkCjTj8d8YVwj5m1yJuCz/v/zmw3aA/361g/rE
   A==;
X-CSE-ConnectionGUID: tpn3B8eFQ6O2IJwG5wpBMw==
X-CSE-MsgGUID: 5EQo8h1LTauL72Tep205TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7439734"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="7439734"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 18:16:30 -0700
X-CSE-ConnectionGUID: EhQuWFS4TdyzqbZrvpW4UA==
X-CSE-MsgGUID: qnqdTbTSS6ePQ9Te2RD6zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="22953273"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 02 Apr 2024 18:16:28 -0700
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
Subject: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
Date: Wed,  3 Apr 2024 09:15:12 +0800
Message-Id: <20240403011519.78512-3-baolu.lu@linux.intel.com>
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

The struct sva_iommu represents a bond of an SVA domain and a device.
It is functionally equivalent to the iommu_attach_handle. To avoid
code duplication, replace sva_iommu with the iommu_attach_handle and
remove the code that manages sva_iommu.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      | 28 +++++------------
 include/linux/uacce.h      |  2 +-
 drivers/dma/idxd/idxd.h    |  2 +-
 drivers/dma/idxd/cdev.c    |  4 +--
 drivers/iommu/iommu-sva.c  | 61 ++++++++++++++++----------------------
 drivers/misc/uacce/uacce.c |  2 +-
 6 files changed, 38 insertions(+), 61 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2e925b5eba53..be9c9a10169d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -39,7 +39,6 @@ struct iommu_domain;
 struct iommu_domain_ops;
 struct iommu_dirty_ops;
 struct notifier_block;
-struct iommu_sva;
 struct iommu_dma_cookie;
 struct iommu_fault_param;
 
@@ -986,20 +985,9 @@ struct iommu_fwspec {
 /* ATS is supported */
 #define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
 
-/**
- * struct iommu_sva - handle to a device-mm bond
- */
-struct iommu_sva {
-	struct device			*dev;
-	struct iommu_domain		*domain;
-	struct list_head		handle_item;
-	refcount_t			users;
-};
-
 struct iommu_mm_data {
 	u32			pasid;
 	struct list_head	sva_domains;
-	struct list_head	sva_handles;
 };
 
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
@@ -1527,24 +1515,24 @@ static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
 }
 
 void mm_pasid_drop(struct mm_struct *mm);
-struct iommu_sva *iommu_sva_bind_device(struct device *dev,
-					struct mm_struct *mm);
-void iommu_sva_unbind_device(struct iommu_sva *handle);
-u32 iommu_sva_get_pasid(struct iommu_sva *handle);
+struct iommu_attach_handle *iommu_sva_bind_device(struct device *dev,
+						  struct mm_struct *mm);
+void iommu_sva_unbind_device(struct iommu_attach_handle *handle);
+u32 iommu_sva_get_pasid(struct iommu_attach_handle *handle);
 struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 					    struct mm_struct *mm);
 #else
-static inline struct iommu_sva *
+static inline struct iommu_attach_handle *
 iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
-	return NULL;
+	return ERR_PTR(-ENODEV);
 }
 
-static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
+static inline void iommu_sva_unbind_device(struct iommu_attach_handle *handle)
 {
 }
 
-static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+static inline u32 iommu_sva_get_pasid(struct iommu_attach_handle *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index e290c0269944..1548119c89ae 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -97,7 +97,7 @@ struct uacce_queue {
 	struct mutex mutex;
 	enum uacce_q_state state;
 	u32 pasid;
-	struct iommu_sva *handle;
+	struct iommu_attach_handle *handle;
 	struct address_space *mapping;
 };
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index a4099a1e2340..3ee89e9cb049 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -335,7 +335,7 @@ struct idxd_device {
 	struct idxd_wq **wqs;
 	struct idxd_engine **engines;
 
-	struct iommu_sva *sva;
+	struct iommu_attach_handle *sva;
 	unsigned int pasid;
 
 	int num_groups;
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 8078ab9acfbc..a029bda92615 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -45,7 +45,7 @@ struct idxd_user_context {
 	unsigned int pasid;
 	struct mm_struct *mm;
 	unsigned int flags;
-	struct iommu_sva *sva;
+	struct iommu_attach_handle *sva;
 	struct idxd_dev idxd_dev;
 	u64 counters[COUNTER_MAX];
 	int id;
@@ -225,7 +225,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	struct idxd_wq *wq;
 	struct device *dev, *fdev;
 	int rc = 0;
-	struct iommu_sva *sva;
+	struct iommu_attach_handle *sva;
 	unsigned int pasid;
 	struct idxd_cdev *idxd_cdev;
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 640acc804e8c..35ac2e4836e9 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -41,7 +41,6 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 	}
 	iommu_mm->pasid = pasid;
 	INIT_LIST_HEAD(&iommu_mm->sva_domains);
-	INIT_LIST_HEAD(&iommu_mm->sva_handles);
 	/*
 	 * Make sure the write to mm->iommu_mm is not reordered in front of
 	 * initialization to iommu_mm fields. If it does, readers may see a
@@ -67,13 +66,17 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
  *
  * On error, returns an ERR_PTR value.
  */
-struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
+struct iommu_attach_handle *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
 {
+	struct iommu_group *group = dev->iommu_group;
+	struct iommu_attach_handle *handle;
 	struct iommu_mm_data *iommu_mm;
 	struct iommu_domain *domain;
-	struct iommu_sva *handle;
 	int ret;
 
+	if (!group)
+		return ERR_PTR(-ENODEV);
+
 	mutex_lock(&iommu_sva_lock);
 
 	/* Allocate mm->pasid if necessary. */
@@ -83,18 +86,11 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_unlock;
 	}
 
-	list_for_each_entry(handle, &mm->iommu_mm->sva_handles, handle_item) {
-		if (handle->dev == dev) {
-			refcount_inc(&handle->users);
-			mutex_unlock(&iommu_sva_lock);
-			return handle;
-		}
-	}
-
-	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle) {
-		ret = -ENOMEM;
-		goto out_unlock;
+	/* A bond already exists, just take a reference`. */
+	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
+	if (handle) {
+		mutex_unlock(&iommu_sva_lock);
+		return handle;
 	}
 
 	/* Search for an existing domain. */
@@ -110,7 +106,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	domain = iommu_sva_domain_alloc(dev, mm);
 	if (!domain) {
 		ret = -ENOMEM;
-		goto out_free_handle;
+		goto out_unlock;
 	}
 
 	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
@@ -120,17 +116,14 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 	list_add(&domain->next, &mm->iommu_mm->sva_domains);
 
 out:
-	refcount_set(&handle->users, 1);
-	list_add(&handle->handle_item, &mm->iommu_mm->sva_handles);
+	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
 	mutex_unlock(&iommu_sva_lock);
-	handle->dev = dev;
-	handle->domain = domain;
+	handle->priv = dev;
+
 	return handle;
 
 out_free_domain:
 	iommu_domain_free(domain);
-out_free_handle:
-	kfree(handle);
 out_unlock:
 	mutex_unlock(&iommu_sva_lock);
 	return ERR_PTR(ret);
@@ -145,30 +138,26 @@ EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
  * not be issuing any more transaction for this PASID. All outstanding page
  * requests for this PASID must have been flushed to the IOMMU.
  */
-void iommu_sva_unbind_device(struct iommu_sva *handle)
+void iommu_sva_unbind_device(struct iommu_attach_handle *handle)
 {
 	struct iommu_domain *domain = handle->domain;
 	struct iommu_mm_data *iommu_mm = domain->mm->iommu_mm;
-	struct device *dev = handle->dev;
+	struct device *dev = handle->priv;
 
 	mutex_lock(&iommu_sva_lock);
-	if (!refcount_dec_and_test(&handle->users)) {
-		mutex_unlock(&iommu_sva_lock);
-		return;
-	}
-	list_del(&handle->handle_item);
-
-	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
-	if (--domain->users == 0) {
-		list_del(&domain->next);
-		iommu_domain_free(domain);
+	iommu_attach_handle_put(handle);
+	if (refcount_read(&handle->users) == 1) {
+		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
+		if (--domain->users == 0) {
+			list_del(&domain->next);
+			iommu_domain_free(domain);
+		}
 	}
 	mutex_unlock(&iommu_sva_lock);
-	kfree(handle);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
 
-u32 iommu_sva_get_pasid(struct iommu_sva *handle)
+u32 iommu_sva_get_pasid(struct iommu_attach_handle *handle)
 {
 	struct iommu_domain *domain = handle->domain;
 
diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index bdc2e6fda782..b325097421c1 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -106,7 +106,7 @@ static long uacce_fops_compat_ioctl(struct file *filep,
 static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
 {
 	u32 pasid;
-	struct iommu_sva *handle;
+	struct iommu_attach_handle *handle;
 
 	if (!(uacce->flags & UACCE_DEV_SVA))
 		return 0;
-- 
2.34.1


