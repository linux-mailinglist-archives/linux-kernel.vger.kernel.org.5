Return-Path: <linux-kernel+bounces-156472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0598C8B030E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D1DEB24FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85415A4A1;
	Wed, 24 Apr 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHDVWdEp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70415991C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943128; cv=none; b=bYZcp5mOkTbQ3hGCkoYXa9QfB50j0OgZO4MxASnSMXWdNR10HWjdsrwtyCOPDyxHoFz6T9qZ4c2+ZKbBHrbT/eYGX/ThHWnhzz05N5WkRTM4q2jbCkVRI5DbTpvQ7DXrrmpEJ8X49/8oIkEG3w1ddLXrOqAqEdac0abg0HJGrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943128; c=relaxed/simple;
	bh=SmWZne3w6XmRAr21lr+07kDD8DzL2m4ixM5tI+ddpZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giyTuN9IkB+gnO5Bcrk4tI/6pJjeCJ7k/jh1fjBc5nnJEUkbL4UmlbPNsu25uovnQqDfrKq80wVlyE+yTs2HYHo0MBxvzfAs2fvFTVKeQCwYahsHCKXXih75qeXgGgDS/zQ6WzF0JDFm8hGmf2Y+J3Kj/lNtyeofj6Yd2w0JpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHDVWdEp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943127; x=1745479127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SmWZne3w6XmRAr21lr+07kDD8DzL2m4ixM5tI+ddpZc=;
  b=kHDVWdEp9riKWrjF9CRa6Nda5QosolCEvO/PVHrCJkEwhh7/GzYwSWHj
   k6t/k8zg/tNHO0SP0tBF17sczYN24VoMmBLJmS44LY5ZeXl46Om9dS3qQ
   iHUhjEhnKURU9kc5PFGfSCQZYtjE7LQzEkIrlurFe8/+igX3i5foEokZ0
   o7iX6gSrluSdEG9cn06KdxKvUd96GYk0t3hle6g/YJm2+w6EoWtTWL5Bz
   x72UOyM1Jnpz7z1TQxmLpM4fkS4CQIEcbqxHLRsr1UwvJMrh8HBFarnJI
   V9/SnqFO9wPHgzq4T0jJyEvP838CzP1zaMV/ZWpP+Ji2GA3PUxsqtNXIW
   w==;
X-CSE-ConnectionGUID: upSHF6oLQ+STPpcdlRG8pg==
X-CSE-MsgGUID: wlb04sciQ0WMkMm3/X/2WQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073244"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073244"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:46 -0700
X-CSE-ConnectionGUID: fSK2RfmVRJOjLfrhIjc2xg==
X-CSE-MsgGUID: TTr5xI7wTmOXf2AOaLWMHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665860"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:44 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] iommu/vt-d: Remove intel_svm_dev
Date: Wed, 24 Apr 2024 15:16:42 +0800
Message-Id: <20240424071644.178250-17-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel_svm_dev data structure used in the sva implementation for the
Intel IOMMU driver stores information about a device attached to an SVA
domain. It is a duplicate of dev_pasid_info that serves the same purpose.

Replace intel_svm_dev with dev_pasid_info and clean up the use of
intel_svm_dev.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-11-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h |  15 +----
 drivers/iommu/intel/iommu.c |   7 +-
 drivers/iommu/intel/svm.c   | 130 ++++++++++--------------------------
 3 files changed, 42 insertions(+), 110 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index fc0b4b048635..f16b0d10543f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -649,6 +649,7 @@ struct dmar_domain {
 			struct list_head s2_link;
 		};
 	};
+	struct intel_svm *svm;
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
@@ -1149,23 +1150,13 @@ int intel_svm_finish_prq(struct intel_iommu *iommu);
 void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 			     struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(void);
-void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+void intel_svm_remove_dev_pasid(struct iommu_domain *domain);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
 
-struct intel_svm_dev {
-	struct list_head list;
-	struct rcu_head rcu;
-	struct device *dev;
-	struct intel_iommu *iommu;
-	u16 did;
-	u16 sid, qdep;
-};
-
 struct intel_svm {
 	struct mmu_notifier notifier;
 	struct mm_struct *mm;
 	u32 pasid;
-	struct list_head devs;
 	struct dmar_domain *domain;
 };
 #else
@@ -1176,7 +1167,7 @@ static inline struct iommu_domain *intel_svm_domain_alloc(void)
 	return NULL;
 }
 
-static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static inline void intel_svm_remove_dev_pasid(struct iommu_domain *domain)
 {
 }
 #endif
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b2bd96e7f03d..7631d00cc882 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4387,11 +4387,8 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	 * notification. Before consolidating that code into iommu core, let
 	 * the intel sva code handle it.
 	 */
-	if (domain->type == IOMMU_DOMAIN_SVA) {
-		intel_svm_remove_dev_pasid(dev, pasid);
-		cache_tag_unassign_domain(dmar_domain, dev, pasid);
-		goto out_tear_down;
-	}
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		intel_svm_remove_dev_pasid(domain);
 
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5ba0a7baa455..e6568897042f 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -43,23 +43,6 @@ static void *pasid_private_find(ioasid_t pasid)
 	return xa_load(&pasid_private_array, pasid);
 }
 
-static struct intel_svm_dev *
-svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
-{
-	struct intel_svm_dev *sdev = NULL, *t;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(t, &svm->devs, list) {
-		if (t->dev == dev) {
-			sdev = t;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return sdev;
-}
-
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct iopf_queue *iopfq;
@@ -192,7 +175,10 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
-	struct intel_svm_dev *sdev;
+	struct dmar_domain *domain = svm->domain;
+	struct dev_pasid_info *dev_pasid;
+	struct device_domain_info *info;
+	unsigned long flags;
 
 	/* This might end up being called from exit_mmap(), *before* the page
 	 * tables are cleared. And __mmu_notifier_release() will delete us from
@@ -206,11 +192,13 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * page) so that we end up taking a fault that the hardware really
 	 * *has* to handle gracefully without affecting other processes.
 	 */
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list)
-		intel_pasid_tear_down_entry(sdev->iommu, sdev->dev,
-					    svm->pasid, true);
-	rcu_read_unlock();
+	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
+		info = dev_iommu_priv_get(dev_pasid->dev);
+		intel_pasid_tear_down_entry(info->iommu, dev_pasid->dev,
+					    dev_pasid->pasid, true);
+	}
+	spin_unlock_irqrestore(&domain->lock, flags);
 
 }
 
@@ -219,47 +207,17 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.arch_invalidate_secondary_tlbs = intel_arch_invalidate_secondary_tlbs,
 };
 
-static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
-			     struct intel_svm **rsvm,
-			     struct intel_svm_dev **rsdev)
-{
-	struct intel_svm_dev *sdev = NULL;
-	struct intel_svm *svm;
-
-	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
-		return -EINVAL;
-
-	svm = pasid_private_find(pasid);
-	if (IS_ERR(svm))
-		return PTR_ERR(svm);
-
-	if (!svm)
-		goto out;
-
-	/*
-	 * If we found svm for the PASID, there must be at least one device
-	 * bond.
-	 */
-	if (WARN_ON(list_empty(&svm->devs)))
-		return -EINVAL;
-	sdev = svm_lookup_device_by_dev(svm, dev);
-
-out:
-	*rsvm = svm;
-	*rsdev = sdev;
-
-	return 0;
-}
-
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
-	struct intel_svm_dev *sdev;
+	struct dev_pasid_info *dev_pasid;
 	struct intel_svm *svm;
 	unsigned long sflags;
+	unsigned long flags;
 	int ret = 0;
 
 	svm = pasid_private_find(pasid);
@@ -270,7 +228,6 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 		svm->pasid = pasid;
 		svm->mm = mm;
-		INIT_LIST_HEAD_RCU(&svm->devs);
 
 		svm->notifier.ops = &intel_mmuops;
 		svm->domain = to_dmar_domain(domain);
@@ -288,25 +245,17 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
-	if (!sdev) {
-		ret = -ENOMEM;
+	dmar_domain->svm = svm;
+	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
+	if (!dev_pasid)
 		goto free_svm;
-	}
 
-	sdev->dev = dev;
-	sdev->iommu = iommu;
-	sdev->did = FLPT_DEFAULT_DID;
-	sdev->sid = PCI_DEVID(info->bus, info->devfn);
-	if (info->ats_enabled) {
-		sdev->qdep = info->ats_qdep;
-		if (sdev->qdep >= QI_DEV_EIOTLB_MAX_INVS)
-			sdev->qdep = 0;
-	}
+	dev_pasid->dev = dev;
+	dev_pasid->pasid = pasid;
 
 	ret = cache_tag_assign_domain(to_dmar_domain(domain), dev, pasid);
 	if (ret)
-		goto free_sdev;
+		goto free_dev_pasid;
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -315,16 +264,18 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto unassign_tag;
 
-	list_add_rcu(&sdev->list, &svm->devs);
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	return 0;
 
 unassign_tag:
 	cache_tag_unassign_domain(to_dmar_domain(domain), dev, pasid);
-free_sdev:
-	kfree(sdev);
+free_dev_pasid:
+	kfree(dev_pasid);
 free_svm:
-	if (list_empty(&svm->devs)) {
+	if (list_empty(&dmar_domain->dev_pasids)) {
 		mmu_notifier_unregister(&svm->notifier, mm);
 		pasid_private_remove(pasid);
 		kfree(svm);
@@ -333,26 +284,17 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	return ret;
 }
 
-void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
+void intel_svm_remove_dev_pasid(struct iommu_domain *domain)
 {
-	struct intel_svm_dev *sdev;
-	struct intel_svm *svm;
-	struct mm_struct *mm;
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+	struct intel_svm *svm = dmar_domain->svm;
+	struct mm_struct *mm = domain->mm;
 
-	if (pasid_to_svm_sdev(dev, pasid, &svm, &sdev))
-		return;
-	mm = svm->mm;
-
-	if (sdev) {
-		list_del_rcu(&sdev->list);
-		kfree_rcu(sdev, rcu);
-
-		if (list_empty(&svm->devs)) {
-			if (svm->notifier.ops)
-				mmu_notifier_unregister(&svm->notifier, mm);
-			pasid_private_remove(svm->pasid);
-			kfree(svm);
-		}
+	if (list_empty(&dmar_domain->dev_pasids)) {
+		if (svm->notifier.ops)
+			mmu_notifier_unregister(&svm->notifier, mm);
+		pasid_private_remove(svm->pasid);
+		kfree(svm);
 	}
 }
 
@@ -686,8 +628,10 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 		return NULL;
 	domain->domain.ops = &intel_svm_domain_ops;
 	domain->use_first_level = true;
+	INIT_LIST_HEAD(&domain->dev_pasids);
 	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->cache_lock);
+	spin_lock_init(&domain->lock);
 
 	return &domain->domain;
 }
-- 
2.34.1


