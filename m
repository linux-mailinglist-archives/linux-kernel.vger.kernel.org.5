Return-Path: <linux-kernel+bounces-156474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B98B0310
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09B7B2525F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1FB157A72;
	Wed, 24 Apr 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYVYhTTa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5B15A4B4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943132; cv=none; b=hXNZzYBmme1FvXM6G8zoYEbn3uRLQ7FChM4A6ToZ5ulOKUYn+sbMk70VyUdpbOaCqVe2G92ONT1Ib78RmiJ9Rxmozqhm0RBiqXRdFa7gDjgfk3wFVNYMpaCUTfbp/nocPEQMfJIrpCdLeihl6qoAzhk9KGo4Yu4PLMje9/3ceps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943132; c=relaxed/simple;
	bh=B6MZy1ihv73LlsGoSGweUZYScfPQb7CVTkYXx2P0tJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDVS50cb6XnmXMq+kK7V8NUVXBa3JSevl3mGVFvQTYpzV3qjfCrOhVe+nXIgzHN1576r432ioS6T8uIhfPr3zFobso5JhpPUvTekMtqW+/x5UyXZ07WQlp9I5wvqDdLfYfBrw0CyjgIJsEfPbRhZO+y3utD6Lr+A0flhDdf0rQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYVYhTTa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943131; x=1745479131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B6MZy1ihv73LlsGoSGweUZYScfPQb7CVTkYXx2P0tJc=;
  b=EYVYhTTawJJGwZtf4ehdAWVh01oH+V32rOdoSb7GBAwKXVoyJ7EyB1Qr
   0yukV12C/6N0IwBU6+zrfhiQ16EERVCQV+pscsD3lBrouzE5atn8KVl+1
   MOhHC0ibNT0Ba+pilansuoM7MW12+BRtWjUXwhPRDdc5xF00k+/3hVgpS
   I4xMgjDU4pVVjbZ83IhOKTUFMeMRdwX5rkawrsj6yOtBiNnpGB16pmLhy
   8mhCL1Y6gsyMeTqt92wr26h7MTWNexvbI0NhpIUS0LypTD4GQAhu+oNGi
   syt0OUFqx8Uc4kvyrJ+cWtE2Zw6bHSe5w+HDBH719a3wAT1OjBF0HJWJY
   Q==;
X-CSE-ConnectionGUID: b981Kd3ASMCAKJijCUAByg==
X-CSE-MsgGUID: XFOLG3H1TiC1abBoffAoRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073263"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073263"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:51 -0700
X-CSE-ConnectionGUID: dne8INHJSOyBbP6oKdbIEQ==
X-CSE-MsgGUID: xFl2lKReQFKnOUsqYmDy7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24666042"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/18] iommu/vt-d: Remove struct intel_svm
Date: Wed, 24 Apr 2024 15:16:44 +0800
Message-Id: <20240424071644.178250-19-baolu.lu@linux.intel.com>
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

The struct intel_svm was used for keeping attached devices info for sva
domain. Since sva domain is a kind of iommu_domain, the struct
dmar_domain should centralize all info of a sva domain, including the
info of attached devices. Therefore, retire struct intel_svm and clean up
the code.

Besides, register mmu notifier callback  in domain_alloc_sva() callback
which allows the memory management notifier lifetime to follow the lifetime
of the iommu_domain. Call mmu_notifier_put() in the domain free and defer
the real free to the mmu free_notifier callback.

Co-developed-by: Tina Zhang <tina.zhang@intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-13-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 26 ++++------
 drivers/iommu/intel/iommu.c | 11 +----
 drivers/iommu/intel/svm.c   | 99 ++++++++++---------------------------
 3 files changed, 37 insertions(+), 99 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f16b0d10543f..c9eef464cf5c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -648,8 +648,12 @@ struct dmar_domain {
 			/* link to parent domain siblings */
 			struct list_head s2_link;
 		};
+
+		/* SVA domain */
+		struct {
+			struct mmu_notifier notifier;
+		};
 	};
-	struct intel_svm *svm;
 
 	struct iommu_domain domain;	/* generic domain data structure for
 					   iommu core */
@@ -1149,26 +1153,16 @@ int intel_svm_enable_prq(struct intel_iommu *iommu);
 int intel_svm_finish_prq(struct intel_iommu *iommu);
 void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 			     struct iommu_page_response *msg);
-struct iommu_domain *intel_svm_domain_alloc(void);
-void intel_svm_remove_dev_pasid(struct iommu_domain *domain);
+struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
+					    struct mm_struct *mm);
 void intel_drain_pasid_prq(struct device *dev, u32 pasid);
-
-struct intel_svm {
-	struct mmu_notifier notifier;
-	struct mm_struct *mm;
-	u32 pasid;
-	struct dmar_domain *domain;
-};
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
 static inline void intel_drain_pasid_prq(struct device *dev, u32 pasid) {}
-static inline struct iommu_domain *intel_svm_domain_alloc(void)
-{
-	return NULL;
-}
-
-static inline void intel_svm_remove_dev_pasid(struct iommu_domain *domain)
+static inline struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
+							  struct mm_struct *mm)
 {
+	return ERR_PTR(-ENODEV);
 }
 #endif
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7631d00cc882..916cdb65d849 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3683,8 +3683,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
-	case IOMMU_DOMAIN_SVA:
-		return intel_svm_domain_alloc();
 	default:
 		return NULL;
 	}
@@ -4382,14 +4380,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		goto out_tear_down;
 	dmar_domain = to_dmar_domain(domain);
 
-	/*
-	 * The SVA implementation needs to handle its own stuffs like the mm
-	 * notification. Before consolidating that code into iommu core, let
-	 * the intel sva code handle it.
-	 */
-	if (domain->type == IOMMU_DOMAIN_SVA)
-		intel_svm_remove_dev_pasid(domain);
-
 	spin_lock_irqsave(&dmar_domain->lock, flags);
 	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain) {
 		if (curr->dev == dev && curr->pasid == pasid) {
@@ -4624,6 +4614,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.hw_info		= intel_iommu_hw_info,
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
+	.domain_alloc_sva	= intel_svm_domain_alloc,
 	.probe_device		= intel_iommu_probe_device,
 	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e6568897042f..268a0082d37f 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -26,23 +26,6 @@
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 
-static DEFINE_XARRAY_ALLOC(pasid_private_array);
-static int pasid_private_add(ioasid_t pasid, void *priv)
-{
-	return xa_alloc(&pasid_private_array, &pasid, priv,
-			XA_LIMIT(pasid, pasid), GFP_ATOMIC);
-}
-
-static void pasid_private_remove(ioasid_t pasid)
-{
-	xa_erase(&pasid_private_array, pasid);
-}
-
-static void *pasid_private_find(ioasid_t pasid)
-{
-	return xa_load(&pasid_private_array, pasid);
-}
-
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct iopf_queue *iopfq;
@@ -156,10 +139,9 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long start, unsigned long end)
 {
-	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
-	struct dmar_domain *domain = svm->domain;
+	struct dmar_domain *domain = container_of(mn, struct dmar_domain, notifier);
 
-	if (start == 0 && end == -1UL) {
+	if (start == 0 && end == ULONG_MAX) {
 		cache_tag_flush_all(domain);
 		return;
 	}
@@ -174,8 +156,7 @@ static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
-	struct dmar_domain *domain = svm->domain;
+	struct dmar_domain *domain = container_of(mn, struct dmar_domain, notifier);
 	struct dev_pasid_info *dev_pasid;
 	struct device_domain_info *info;
 	unsigned long flags;
@@ -202,9 +183,15 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 }
 
+static void intel_mm_free_notifier(struct mmu_notifier *mn)
+{
+	kfree(container_of(mn, struct dmar_domain, notifier));
+}
+
 static const struct mmu_notifier_ops intel_mmuops = {
 	.release = intel_mm_release,
 	.arch_invalidate_secondary_tlbs = intel_arch_invalidate_secondary_tlbs,
+	.free_notifier = intel_mm_free_notifier,
 };
 
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
@@ -215,40 +202,13 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
 	struct dev_pasid_info *dev_pasid;
-	struct intel_svm *svm;
 	unsigned long sflags;
 	unsigned long flags;
 	int ret = 0;
 
-	svm = pasid_private_find(pasid);
-	if (!svm) {
-		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
-		if (!svm)
-			return -ENOMEM;
-
-		svm->pasid = pasid;
-		svm->mm = mm;
-
-		svm->notifier.ops = &intel_mmuops;
-		svm->domain = to_dmar_domain(domain);
-		ret = mmu_notifier_register(&svm->notifier, mm);
-		if (ret) {
-			kfree(svm);
-			return ret;
-		}
-
-		ret = pasid_private_add(svm->pasid, svm);
-		if (ret) {
-			mmu_notifier_unregister(&svm->notifier, mm);
-			kfree(svm);
-			return ret;
-		}
-	}
-
-	dmar_domain->svm = svm;
 	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
 	if (!dev_pasid)
-		goto free_svm;
+		return -ENOMEM;
 
 	dev_pasid->dev = dev;
 	dev_pasid->pasid = pasid;
@@ -274,30 +234,10 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	cache_tag_unassign_domain(to_dmar_domain(domain), dev, pasid);
 free_dev_pasid:
 	kfree(dev_pasid);
-free_svm:
-	if (list_empty(&dmar_domain->dev_pasids)) {
-		mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(pasid);
-		kfree(svm);
-	}
 
 	return ret;
 }
 
-void intel_svm_remove_dev_pasid(struct iommu_domain *domain)
-{
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct intel_svm *svm = dmar_domain->svm;
-	struct mm_struct *mm = domain->mm;
-
-	if (list_empty(&dmar_domain->dev_pasids)) {
-		if (svm->notifier.ops)
-			mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(svm->pasid);
-		kfree(svm);
-	}
-}
-
 /* Page request queue descriptor */
 struct page_req_dsc {
 	union {
@@ -611,7 +551,10 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
 {
-	kfree(to_dmar_domain(domain));
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	/* dmar_domain free is deferred to the mmu free_notifier callback. */
+	mmu_notifier_put(&dmar_domain->notifier);
 }
 
 static const struct iommu_domain_ops intel_svm_domain_ops = {
@@ -619,13 +562,16 @@ static const struct iommu_domain_ops intel_svm_domain_ops = {
 	.free			= intel_svm_domain_free
 };
 
-struct iommu_domain *intel_svm_domain_alloc(void)
+struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
+					    struct mm_struct *mm)
 {
 	struct dmar_domain *domain;
+	int ret;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
 	domain->domain.ops = &intel_svm_domain_ops;
 	domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->dev_pasids);
@@ -633,5 +579,12 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 	spin_lock_init(&domain->cache_lock);
 	spin_lock_init(&domain->lock);
 
+	domain->notifier.ops = &intel_mmuops;
+	ret = mmu_notifier_register(&domain->notifier, mm);
+	if (ret) {
+		kfree(domain);
+		return ERR_PTR(ret);
+	}
+
 	return &domain->domain;
 }
-- 
2.34.1


