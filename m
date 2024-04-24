Return-Path: <linux-kernel+bounces-156469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3345D8B030B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567E11C23CE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41F1586C0;
	Wed, 24 Apr 2024 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OW3Lcy3H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4761159599
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943122; cv=none; b=DBMgiuXsbMJwq/FJLgvqFxWeyJZxYj0tP0uNMYnh3l6jXLrWDvWYqBhb7daLOlH/AEg2qPU+6d+kuKs1BPg47MbCtcIfTdvgpjU1r68aTV0sw0nadb9JQSuPcl45I/p+Ha6Eoyh9xe4q2Vc1+gUYNPfxbVvcjb2TJpvMLwWlC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943122; c=relaxed/simple;
	bh=v8ptk/OkMMZJmJ2BHRUUJIZf4hor5s0nL7db6WdblRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQ3ay5We/5diRC2UGLtSaGmElRjx9FbUMOu61X3O1mEofZiUR4vcRgMTryZwysQD4dPfWFqFm6f3/QIUVIEvS+nGdOSFcQWSloy2Kz3l1ORjGajFvnakOo/fnLbC4MI6XuVHwGXfJa9YmGR2/hZDCSKoGwy2jQ88PX9oOIgWsDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OW3Lcy3H; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943121; x=1745479121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v8ptk/OkMMZJmJ2BHRUUJIZf4hor5s0nL7db6WdblRg=;
  b=OW3Lcy3HN/j8tdcWsnq7+XsDw9oXOw46MvnDNVHwLvehRolfdOYXKf8C
   BOh2Cp0FNSzeWNbaqFM+niiyFmD9YyHJnNkBtk6QxoDVosLFH2kbQbpiM
   LbQV5Tx7LFDi2q58DuTlpkNsgzqnOGpM7hUcMhoXQGUn2jTWJ5Ayo8T+R
   lCrO4Mlu1lCSRd5zWZkNTKXqkF0IoiSxp4FqrS9Pi2pXNbQGs69wqpCtk
   FFOlg8RBOhl+pSIuiFgpwbgadkJQwvIYcugK7KaXGixquWR6gPG2fVM5D
   mbJGB/RemCIYDH1/8Rm87sldCs2OgSkICYtfPGa41jg8mwxCPaH3eK6uX
   w==;
X-CSE-ConnectionGUID: sEIpJBBQQ/eGGx660sH8ow==
X-CSE-MsgGUID: jHL0FwCLSxa8YZEUfUeYDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073215"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073215"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:39 -0700
X-CSE-ConnectionGUID: AI2pGaz9Q8KOzrAHAtDqIg==
X-CSE-MsgGUID: ytLIl1kjSuOV8Hk9MTOWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24665605"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] iommu/vt-d: Cleanup use of iommu_flush_iotlb_psi()
Date: Wed, 24 Apr 2024 15:16:39 +0800
Message-Id: <20240424071644.178250-14-baolu.lu@linux.intel.com>
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

Use cache_tag_flush_range() in switch_to_super_page() to invalidate the
necessary caches when switching mappings from normal to super pages. The
iommu_flush_iotlb_psi() call in intel_iommu_memory_notifier() is
unnecessary since there should be no cache invalidation for the identity
domain.

Clean up iommu_flush_iotlb_psi() after the last call site is removed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240416080656.60968-8-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 171 +-----------------------------------
 1 file changed, 2 insertions(+), 169 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c9ac8a1b635f..b2bd96e7f03d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1390,157 +1390,6 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
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
@@ -1991,9 +1840,7 @@ static void switch_to_super_page(struct dmar_domain *domain,
 				 unsigned long end_pfn, int level)
 {
 	unsigned long lvl_pages = lvl_to_nr_pages(level);
-	struct iommu_domain_info *info;
 	struct dma_pte *pte = NULL;
-	unsigned long i;
 
 	while (start_pfn <= end_pfn) {
 		if (!pte)
@@ -2005,13 +1852,8 @@ static void switch_to_super_page(struct dmar_domain *domain,
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
@@ -3381,18 +3223,9 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
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


