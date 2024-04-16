Return-Path: <linux-kernel+bounces-146469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBF38A65BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB821F239E4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57EE15AD9F;
	Tue, 16 Apr 2024 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEEe4uhW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C3915AAAD
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254916; cv=none; b=W4mpbhf7Hx5t1jYURIst7ukhNs4vtj9N9k/aDBS8KBPyeXPcGm4/3LewOgYUhLAH0XCt6TfL0ek6NiBIemRaKEc5lS6iN+Mfw7He0QyZzHT9CHh1B1uotOUSoQ7O0WRa6QozlcWeuLZcRLhhDAPE39LQ/RwsMm3apbvMQgbXM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254916; c=relaxed/simple;
	bh=Op6bHbF0/xJmuG+AQjk9uTyqGUuFQcIPYEmhgc2R9F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K2SQPeyaARTCOMadkL4VsV0ysSsL9DbxsKcMtRroO9Yca47CVJxS5UUXjdS/brvWJDzlo5IrmmNP6/qFZlN3zRVOnfQwx3Y4XJHSONvAVu+ylQ3UoT9qc6nPWSJtBl2wlz3Abr1iITrWc2eWzIZ/nXI42M0I44+Llk9CLtpbI5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEEe4uhW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254915; x=1744790915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Op6bHbF0/xJmuG+AQjk9uTyqGUuFQcIPYEmhgc2R9F4=;
  b=kEEe4uhW27xBllZkcuQRfC1BrQyzl42Ga7hfJNxdFJj6+F08hZQnkz9v
   SYQ6U4hgkBKr8lFMpKHoY4a00bGqZDO3iEExPEqbDLseblKOae9sWH9TX
   OTLFhlSLnOiL9fwUphh8ffMIRYUDd1jhjVSspqLDBDwF6xx6imo9Mb7cG
   YT9aMGGORbvVKGTn5O+Y3Xb8lltS8Xe0brHFx1qW0TU1gXRX1mM5sEwbJ
   CYLZy2w082QpYNQou42mb+xYVx8iaTXiI5OLoyELjK78RuR2M6k4ncGSF
   Klm8awacHCOYfa9rFzItphqPBaRLop8KgeZlmQ35WpNybQSBZa30ziw1h
   Q==;
X-CSE-ConnectionGUID: hoE/Jd7CQBWftKD4gxqnNg==
X-CSE-MsgGUID: AF5YtDExTNS/TyH1cDzcOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466485"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466485"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:35 -0700
X-CSE-ConnectionGUID: yo12o9dnT4WGHLZYbMeqdA==
X-CSE-MsgGUID: 4qG9JanuQa6EdDvtJOcm1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077763"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:33 -0700
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
Subject: [PATCH v3 07/12] iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
Date: Tue, 16 Apr 2024 16:06:51 +0800
Message-Id: <20240416080656.60968-8-baolu.lu@linux.intel.com>
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

Use cache_tag_flush_range() in switch_to_super_page() to invalidate the
necessary caches when switching mappings from normal to super pages. The
iommu_flush_iotlb_psi() call in intel_iommu_memory_notifier() is
unnecessary since there should be no cache invalidation for the identity
domain.

Clean up iommu_flush_iotlb_psi() after the last call site is removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 171 +-----------------------------------
 1 file changed, 2 insertions(+), 169 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c6a0d528ad19..fc6303940322 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1389,157 +1389,6 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep);
 }
 
-static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
-				  u64 addr, unsigned mask)
-{
-	struct dev_pasid_info *dev_pasid;
-	struct device_domain_info *info;
-	unsigned long flags;
-
-	if (!domain->has_iotlb_device)
-		return;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link)
-		__iommu_flush_dev_iotlb(info, addr, mask);
-
-	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain) {
-		info = dev_iommu_priv_get(dev_pasid->dev);
-
-		if (!info->ats_enabled)
-			continue;
-
-		qi_flush_dev_iotlb_pasid(info->iommu,
-					 PCI_DEVID(info->bus, info->devfn),
-					 info->pfsid, dev_pasid->pasid,
-					 info->ats_qdep, addr,
-					 mask);
-	}
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
-static void domain_flush_pasid_iotlb(struct intel_iommu *iommu,
-				     struct dmar_domain *domain, u64 addr,
-				     unsigned long npages, bool ih)
-{
-	u16 did = domain_id_iommu(domain, iommu);
-	struct dev_pasid_info *dev_pasid;
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(dev_pasid, &domain->dev_pasids, link_domain)
-		qi_flush_piotlb(iommu, did, dev_pasid->pasid, addr, npages, ih);
-
-	if (!list_empty(&domain->devices))
-		qi_flush_piotlb(iommu, did, IOMMU_NO_PASID, addr, npages, ih);
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
-static void __iommu_flush_iotlb_psi(struct intel_iommu *iommu, u16 did,
-				    unsigned long pfn, unsigned int pages,
-				    int ih)
-{
-	unsigned int aligned_pages = __roundup_pow_of_two(pages);
-	unsigned long bitmask = aligned_pages - 1;
-	unsigned int mask = ilog2(aligned_pages);
-	u64 addr = (u64)pfn << VTD_PAGE_SHIFT;
-
-	/*
-	 * PSI masks the low order bits of the base address. If the
-	 * address isn't aligned to the mask, then compute a mask value
-	 * needed to ensure the target range is flushed.
-	 */
-	if (unlikely(bitmask & pfn)) {
-		unsigned long end_pfn = pfn + pages - 1, shared_bits;
-
-		/*
-		 * Since end_pfn <= pfn + bitmask, the only way bits
-		 * higher than bitmask can differ in pfn and end_pfn is
-		 * by carrying. This means after masking out bitmask,
-		 * high bits starting with the first set bit in
-		 * shared_bits are all equal in both pfn and end_pfn.
-		 */
-		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
-		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
-	}
-
-	/*
-	 * Fallback to domain selective flush if no PSI support or
-	 * the size is too big.
-	 */
-	if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iommu->cap))
-		iommu->flush.flush_iotlb(iommu, did, 0, 0,
-					 DMA_TLB_DSI_FLUSH);
-	else
-		iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
-					 DMA_TLB_PSI_FLUSH);
-}
-
-static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
-				  struct dmar_domain *domain,
-				  unsigned long pfn, unsigned int pages,
-				  int ih, int map)
-{
-	unsigned int aligned_pages = __roundup_pow_of_two(pages);
-	unsigned int mask = ilog2(aligned_pages);
-	uint64_t addr = (uint64_t)pfn << VTD_PAGE_SHIFT;
-	u16 did = domain_id_iommu(domain, iommu);
-
-	if (WARN_ON(!pages))
-		return;
-
-	if (ih)
-		ih = 1 << 6;
-
-	if (domain->use_first_level)
-		domain_flush_pasid_iotlb(iommu, domain, addr, pages, ih);
-	else
-		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
-
-	if (!map)
-		iommu_flush_dev_iotlb(domain, addr, mask);
-}
-
-/*
- * Flush the relevant caches in nested translation if the domain
- * also serves as a parent
- */
-static void parent_domain_flush(struct dmar_domain *domain,
-				unsigned long pfn,
-				unsigned long pages, int ih)
-{
-	struct dmar_domain *s1_domain;
-
-	spin_lock(&domain->s1_lock);
-	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
-		struct device_domain_info *device_info;
-		struct iommu_domain_info *info;
-		unsigned long flags;
-		unsigned long i;
-
-		xa_for_each(&s1_domain->iommu_array, i, info)
-			__iommu_flush_iotlb_psi(info->iommu, info->did,
-						pfn, pages, ih);
-
-		if (!s1_domain->has_iotlb_device)
-			continue;
-
-		spin_lock_irqsave(&s1_domain->lock, flags);
-		list_for_each_entry(device_info, &s1_domain->devices, link)
-			/*
-			 * Address translation cache in device side caches the
-			 * result of nested translation. There is no easy way
-			 * to identify the exact set of nested translations
-			 * affected by a change in S2. So just flush the entire
-			 * device cache.
-			 */
-			__iommu_flush_dev_iotlb(device_info, 0,
-						MAX_AGAW_PFN_WIDTH);
-		spin_unlock_irqrestore(&s1_domain->lock, flags);
-	}
-	spin_unlock(&domain->s1_lock);
-}
-
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
 	cache_tag_flush_all(to_dmar_domain(domain));
@@ -1990,9 +1839,7 @@ static void switch_to_super_page(struct dmar_domain *domain,
 				 unsigned long end_pfn, int level)
 {
 	unsigned long lvl_pages = lvl_to_nr_pages(level);
-	struct iommu_domain_info *info;
 	struct dma_pte *pte = NULL;
-	unsigned long i;
 
 	while (start_pfn <= end_pfn) {
 		if (!pte)
@@ -2004,13 +1851,8 @@ static void switch_to_super_page(struct dmar_domain *domain,
 					       start_pfn + lvl_pages - 1,
 					       level + 1);
 
-			xa_for_each(&domain->iommu_array, i, info)
-				iommu_flush_iotlb_psi(info->iommu, domain,
-						      start_pfn, lvl_pages,
-						      0, 0);
-			if (domain->nested_parent)
-				parent_domain_flush(domain, start_pfn,
-						    lvl_pages, 0);
+			cache_tag_flush_range(domain, start_pfn << VTD_PAGE_SHIFT,
+					      end_pfn << VTD_PAGE_SHIFT, 0);
 		}
 
 		pte++;
@@ -3380,18 +3222,9 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 	case MEM_OFFLINE:
 	case MEM_CANCEL_ONLINE:
 		{
-			struct dmar_drhd_unit *drhd;
-			struct intel_iommu *iommu;
 			LIST_HEAD(freelist);
 
 			domain_unmap(si_domain, start_vpfn, last_vpfn, &freelist);
-
-			rcu_read_lock();
-			for_each_active_iommu(iommu, drhd)
-				iommu_flush_iotlb_psi(iommu, si_domain,
-					start_vpfn, mhp->nr_pages,
-					list_empty(&freelist), 0);
-			rcu_read_unlock();
 			put_pages_list(&freelist);
 		}
 		break;
-- 
2.34.1


