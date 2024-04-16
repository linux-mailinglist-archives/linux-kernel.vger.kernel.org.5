Return-Path: <linux-kernel+bounces-146471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C01E58A65BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C31F23D30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E5615B14C;
	Tue, 16 Apr 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBZA/GJ4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9315B127
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254922; cv=none; b=SdI0JCGND1BCl2lEGooSg6As2FQKe5sthaZ6WjE3TOJWVjpAaZ0R6XU7hN1HFb0std+Q2OPzzUHHAKJ1eaKCwJbGqWTk7U6fS6AH8DZVsikkUwsVa1XcC6QqM25yp9kBYiCixylOFGVMfCCQtnmkdyxnHyoSUYK5dBJxTRUUPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254922; c=relaxed/simple;
	bh=V680ycHPUfqmVjuXb51HZ8jYdFB/NYvdXh4MnokrY/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A6VyPI5su5nJZv8Co9FFmN3rAQQzg1Slf/XrFHMNvt9OwEmoRyjDjtbWtkjQfFWuD0OU/HR65GkQI18k6yrtQojhthO42QKCy7Hjx8f7cxL65UmPaiDCYtfRiXSVnvn31t1l9SjMnVqQCHem4zOWpVrzn9dy7+BSj8rpe/o+fKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBZA/GJ4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254921; x=1744790921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V680ycHPUfqmVjuXb51HZ8jYdFB/NYvdXh4MnokrY/s=;
  b=CBZA/GJ4Xo5FoZv48JtyDl8JBQFXpCgThmjn8btW5C1B7ezjD3jvT+FR
   7owvyEsib0oZZxhIw7vXZCj2ziRzRz+7WdnUPJtkHWryzDq5Daf/OTYzW
   PVs6svAuzIVjHDlJPNdLOFB2ST+YqoGyKCJFuj4PcpPgNnYBrqVFqlRlq
   4N2zbAkC1WMo3CNvdzF7GaO/5+wUlYJSmjieaJ/bYmkBT3qS5jg01PO46
   +ShkLMt40MovoHfEsOMNTGzlJ8UebWAskHXxWSZ8dwek4guBPtZRAoaiu
   k0InOLcraV/xCTByofa7eXtjm3eqS6KDqweB8LD60pwxiPczsBhkpkjb7
   w==;
X-CSE-ConnectionGUID: 1G1v0AaDQva6CukgJIX5mA==
X-CSE-MsgGUID: 8bRCUG/IQhybUlhKM3BsJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466508"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466508"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:40 -0700
X-CSE-ConnectionGUID: Iorg2ExmQQeClEKGFxe7Sg==
X-CSE-MsgGUID: HpC6GngLT8uPCcGRZz3SLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077797"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:39 -0700
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
Subject: [PATCH v3 09/12] iommu/vt-d: Use cache helpers in arch_invalidate_secondary_tlbs
Date: Tue, 16 Apr 2024 16:06:53 +0800
Message-Id: <20240416080656.60968-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416080656.60968-1-baolu.lu@linux.intel.com>
References: <20240416080656.60968-1-baolu.lu@linux.intel.com>
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

The mm_types defines vm_end as the first byte after the end address
which is different from the iommu gather API, hence convert the end
parameter from mm_types to iommu gather scheme before calling the
cache_tag helper.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/svm.c   | 81 +++++--------------------------------
 2 files changed, 11 insertions(+), 71 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b1d04aa36d31..31bbce8ffe7e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1167,6 +1167,7 @@ struct intel_svm {
 	struct mm_struct *mm;
 	u32 pasid;
 	struct list_head devs;
+	struct dmar_domain *domain;
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 641d0cef3737..e6d25a0f25f6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -168,88 +168,25 @@ void intel_svm_check(struct intel_iommu *iommu)
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
+	/*
+	 * The mm_types defines vm_end as the first byte after the end address,
+	 * different from IOMMU subsystem using the last address of an address
+	 * range.
+	 */
+	cache_tag_flush_range(domain, start, end - 1, 0);
 }
 
 static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -336,6 +273,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
 		svm->notifier.ops = &intel_mmuops;
+		svm->domain = to_dmar_domain(domain);
 		ret = mmu_notifier_register(&svm->notifier, mm);
 		if (ret) {
 			kfree(svm);
@@ -801,6 +739,7 @@ struct iommu_domain *intel_svm_domain_alloc(void)
 	if (!domain)
 		return NULL;
 	domain->domain.ops = &intel_svm_domain_ops;
+	domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->cache_lock);
 
-- 
2.34.1


