Return-Path: <linux-kernel+bounces-137826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FEE89E810
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521D91C23915
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B229CFA;
	Wed, 10 Apr 2024 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inInR1bC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645A29CF2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715033; cv=none; b=XuoswkI+zTu2rsD26fVap/dnHTpRAaqupTpc9q8UEQkn/5EP+SpOcRGVVo2EW4KhkauJaLoNyLWcLxda48Ey7c+IvhqLUdLSAfpY0TLTvkM/MBcS6mOwzalj/+nyOP1vikF4+SuJzvpPDUp1mRC3gdZN7o/oY1yHLgLrrMC7tNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715033; c=relaxed/simple;
	bh=8uOaaxm9hTyzO9Aw/q0vgU9R2IfJCzDzjSxHWJxDukU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QBdx8tl3JFPd2Afad4xsB0e9HrJh3Yvg0wDi8h3v5l9edq5/do9196oLBPCLQuU9NFD3P3bz1YCwBiEOIDaV8flxHkNIn+vUHYg14zEAGG/5CLLPFLFKrGOTdYDDcMKHIBur/9t8OPMh+dZDb8zEs1DHBMamcPD15zTcBFteNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inInR1bC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712715033; x=1744251033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8uOaaxm9hTyzO9Aw/q0vgU9R2IfJCzDzjSxHWJxDukU=;
  b=inInR1bCWJryw+TC94CvYQ1B4rp/jGOPw2dygTWuouSIduxFXQwZkW+z
   gHQFyErMt5lfIElkZPiMR1pP9AS2jlfQ9dP2m+FwWqKVggg50UzkXJnWJ
   Z0Q8WN++ry8C3ItxQZJTPG1z1IWWUU86xQsQDgTHR8koxXyy+AJWPQ/XM
   i2dpHVUphocC8okqUASTEBEPGYLwKHWs5+L67pSYkknIz/JFtkjK3vbG/
   2OUQ/jayh6oQtIosUoZLiPh+IGz2ffYpzkAmVR5ij821Bsbq/v6NZgy1j
   jZPxyz8VsgK4cEIMtFtnvQ5EqYGi4lf7qoQjecYKvUFqaghodixjyDAyD
   Q==;
X-CSE-ConnectionGUID: gzJPafmKRBuQwNHB5RnkkA==
X-CSE-MsgGUID: 2LVECzpmRuOy7mETo0SDhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7918612"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7918612"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:10:30 -0700
X-CSE-ConnectionGUID: 5ff/sxeVT2eCB/5ogfr3Wg==
X-CSE-MsgGUID: iasNmo9gScia7A0L1BKg7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20478936"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 19:10:26 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 10/12] iommu/vt-d: Retire intel_svm_dev
Date: Wed, 10 Apr 2024 10:08:42 +0800
Message-Id: <20240410020844.253535-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410020844.253535-1-baolu.lu@linux.intel.com>
References: <20240410020844.253535-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.h |  15 +----
 drivers/iommu/intel/iommu.c |  30 ++++-----
 drivers/iommu/intel/svm.c   | 131 +++++++++++-------------------------
 3 files changed, 55 insertions(+), 121 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 5a42d6ee9119..90611ec08a7c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -650,6 +650,7 @@ struct dmar_domain {
 			struct list_head s2_link;
 		};
 	};
+	struct intel_svm *svm;
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
@@ -1144,23 +1145,13 @@ int intel_svm_finish_prq(struct intel_iommu *iommu);
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
@@ -1171,7 +1162,7 @@ static inline struct iommu_domain *intel_svm_domain_alloc(void)
 	return NULL;
 }
 
-static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+static inline void intel_svm_remove_dev_pasid(struct iommu_domain *domain)
 {
 }
 #endif
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 586b6a6afc23..d7f205cd0aac 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4377,18 +4377,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		goto out_tear_down;
 	dmar_domain = to_dmar_domain(domain);
 
-	/*
-	 * The SVA implementation needs to handle its own stuffs like the mm
-	 * notification. Before consolidating that code into iommu core, let
-	 * the intel sva code handle it.
-	 */
-	if (domain->type == IOMMU_DOMAIN_SVA) {
-		intel_svm_remove_dev_pasid(dev, pasid);
-		cache_tag_unassign_domain(dmar_domain,
-					  FLPT_DEFAULT_DID, dev, pasid);
-		goto out_tear_down;
-	}
-
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
@@ -4400,10 +4388,20 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	WARN_ON_ONCE(!dev_pasid);
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
-	did = domain_id_iommu(dmar_domain, iommu);
-	cache_tag_unassign_domain(dmar_domain, did, dev, pasid);
-	domain_detach_iommu(dmar_domain, iommu);
-	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+	/*
+	 * The SVA implementation needs to handle its own stuffs like the mm
+	 * notification. Before consolidating that code into iommu core, let
+	 * the intel sva code handle it.
+	 */
+	if (domain->type == IOMMU_DOMAIN_SVA) {
+		cache_tag_unassign_domain(dmar_domain, FLPT_DEFAULT_DID, dev, pasid);
+		intel_svm_remove_dev_pasid(domain);
+	} else {
+		did = domain_id_iommu(dmar_domain, iommu);
+		cache_tag_unassign_domain(dmar_domain, did, dev, pasid);
+		domain_detach_iommu(dmar_domain, iommu);
+		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+	}
 	kfree(dev_pasid);
 out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 751fab476fa2..0b767d16fb71 100644
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
@@ -187,7 +170,10 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
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
@@ -201,11 +187,13 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
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
 
@@ -214,47 +202,17 @@ static const struct mmu_notifier_ops intel_mmuops = {
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
@@ -265,7 +223,6 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 		svm->pasid = pasid;
 		svm->mm = mm;
-		INIT_LIST_HEAD_RCU(&svm->devs);
 
 		svm->notifier.ops = &intel_mmuops;
 		svm->domain = to_dmar_domain(domain);
@@ -283,26 +240,19 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
-	if (!sdev) {
-		ret = -ENOMEM;
+	dmar_domain->svm = svm;
+
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
 
 	ret = cache_tag_assign_domain(to_dmar_domain(domain),
 				      FLPT_DEFAULT_DID, dev, pasid);
 	if (ret)
-		goto free_sdev;
+		goto free_dev_pasid;
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -311,17 +261,19 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto unassign_tag;
 
-	list_add_rcu(&sdev->list, &svm->devs);
+	spin_lock_irqsave(&dmar_domain->lock, flags);
+	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
 	return 0;
 
 unassign_tag:
 	cache_tag_unassign_domain(to_dmar_domain(domain),
 				  FLPT_DEFAULT_DID, dev, pasid);
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
@@ -330,26 +282,17 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
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
 
@@ -737,8 +680,10 @@ struct iommu_domain *intel_svm_domain_alloc(void)
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


