Return-Path: <linux-kernel+bounces-137825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5B89E80F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC701F24D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635F620304;
	Wed, 10 Apr 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMEDTuqh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3962747D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715028; cv=none; b=G7zZjZd8hoWy/3SQVh8+76iYWyVdv0MWBnKxvGRaUwwYqAvL6WhaXc90FNGErowCHrkEfdwojd/tPMv7i0nu5fpvFZnwIZLDuuCwU1BbiQdkfazcoqJwBh0SCqwYf57naQikkJHcclWHfdksExsM9kNZwy64Om7uJ38Uh139+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715028; c=relaxed/simple;
	bh=SMlefkTzrwr89MMQgB2wDx1oBzU0DcBlIgzd1/OsE2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kR1/vyOC8Vm9kj2Dx88aDrI4F0p5GdA37Eh1kbLSfvQny+0N3Mv03MrURrVWSi9ORIjBMW/+c74M3Y0RbSp7mpUKkGyIm2m8W45iyDGrs5unWAALVrOmmc44G7afJSNvUFYvDhb+YygUSe9trBjZ/KZliCGc/6LvjjQvQvVaQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMEDTuqh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712715028; x=1744251028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SMlefkTzrwr89MMQgB2wDx1oBzU0DcBlIgzd1/OsE2c=;
  b=jMEDTuqhHTsyHfdl50Se37oGp5oNcbm8p5DCocd+IqZsBqN4GRjhWo7T
   ZcCthcFlBmb6cN2mP+95hyK/tqF2xzhCK5bFxrXJSaSDNZN/Coq9saU7f
   t/lw0YTB9A6urWBritmqONaNSDDapH/DJEPpRoam5tQ15ZOzkXuO/rNq5
   rNYxd5I5AfR8P8sfzn1ZhLIhRSbTYNwYXrcN38S3r5e7kOvC5W+/79lJ1
   a+vU4PaLieL0U0jEY7Sot4lFtUgG2IY0w7GhWqd+dgmtMvvCrv6wKqEYg
   FrCubiHqs/CEWWtIxSgdni6RpXKA9jWsEg5tHYGtvoNatRSDt/9Fkjojg
   w==;
X-CSE-ConnectionGUID: 75E1xsKIR36Y7+LEMWwsDQ==
X-CSE-MsgGUID: q7Kie1/aQHO2qqRFdHyCzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7918605"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7918605"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:10:27 -0700
X-CSE-ConnectionGUID: nQP+uigZTh2VOKVh6sh0kw==
X-CSE-MsgGUID: v/xXe3YaQXexzUg+uSaQuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20478920"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 19:10:23 -0700
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
Subject: [PATCH v2 09/12] iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs
Date: Wed, 10 Apr 2024 10:08:41 +0800
Message-Id: <20240410020844.253535-10-baolu.lu@linux.intel.com>
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

The arch_invalidate_secondary_tlbs callback is called in the SVA mm
notification path. It invalidates all or a range of caches after the
CPU page table is modified. Use the cache tag helps in this path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/svm.c   | 76 +++----------------------------------
 2 files changed, 6 insertions(+), 71 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 90a300665962..5a42d6ee9119 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1161,6 +1161,7 @@ struct intel_svm {
 	struct mm_struct *mm;
 	u32 pasid;
 	struct list_head devs;
+	struct dmar_domain *domain;
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index d706226e84ee..751fab476fa2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -168,88 +168,20 @@ void intel_svm_check(struct intel_iommu *iommu)
 	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
 }
 
-static void __flush_svm_range_dev(struct intel_svm *svm,
-				  struct intel_svm_dev *sdev,
-				  unsigned long address,
-				  unsigned long pages, int ih)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(sdev->dev);
-
-	if (WARN_ON(!pages))
-		return;
-
-	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
-	if (info->ats_enabled) {
-		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
-					 svm->pasid, sdev->qdep, address,
-					 order_base_2(pages));
-		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
-					  svm->pasid, sdev->qdep);
-	}
-}
-
-static void intel_flush_svm_range_dev(struct intel_svm *svm,
-				      struct intel_svm_dev *sdev,
-				      unsigned long address,
-				      unsigned long pages, int ih)
-{
-	unsigned long shift = ilog2(__roundup_pow_of_two(pages));
-	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
-	unsigned long start = ALIGN_DOWN(address, align);
-	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
-
-	while (start < end) {
-		__flush_svm_range_dev(svm, sdev, start, align >> VTD_PAGE_SHIFT, ih);
-		start += align;
-	}
-}
-
-static void intel_flush_svm_range(struct intel_svm *svm, unsigned long address,
-				unsigned long pages, int ih)
-{
-	struct intel_svm_dev *sdev;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list)
-		intel_flush_svm_range_dev(svm, sdev, address, pages, ih);
-	rcu_read_unlock();
-}
-
-static void intel_flush_svm_all(struct intel_svm *svm)
-{
-	struct device_domain_info *info;
-	struct intel_svm_dev *sdev;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(sdev, &svm->devs, list) {
-		info = dev_iommu_priv_get(sdev->dev);
-
-		qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, 0, -1UL, 0);
-		if (info->ats_enabled) {
-			qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
-						 svm->pasid, sdev->qdep,
-						 0, 64 - VTD_PAGE_SHIFT);
-			quirk_extra_dev_tlb_flush(info, 0, 64 - VTD_PAGE_SHIFT,
-						  svm->pasid, sdev->qdep);
-		}
-	}
-	rcu_read_unlock();
-}
-
 /* Pages have been freed at this point */
 static void intel_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long start, unsigned long end)
 {
 	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
+	struct dmar_domain *domain = svm->domain;
 
 	if (start == 0 && end == -1UL) {
-		intel_flush_svm_all(svm);
+		cache_tag_flush_all(domain);
 		return;
 	}
 
-	intel_flush_svm_range(svm, start,
-			      (end - start + PAGE_SIZE - 1) >> VTD_PAGE_SHIFT, 0);
+	cache_tag_flush_range(domain, start, end, 0);
 }
 
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -336,6 +268,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
 		svm->notifier.ops = &intel_mmuops;
+		svm->domain = to_dmar_domain(domain);
 		ret = mmu_notifier_register(&svm->notifier, mm);
 		if (ret) {
 			kfree(svm);
@@ -803,6 +736,7 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 	if (!domain)
 		return NULL;
 	domain->domain.ops = &intel_svm_domain_ops;
+	domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->cache_lock);
 
-- 
2.34.1


