Return-Path: <linux-kernel+bounces-137818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A773789E805
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6E7283FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02747BA27;
	Wed, 10 Apr 2024 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8HsRsfq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9C78F6C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715009; cv=none; b=UfXJKuR73448cR7pNK3RnZnwFXXbKwJ0cQhJp422DwskPsAyXVq8PRd0FCQjvIopkCm18bYPTlvdVgHriVn+A8hcw1fnSe9WZUFt9a6vuhyYZaL2OaGk2OwtYiTZUAVJFi8D2iE5pJrjTdd7hdlU8zCxiWuu0oR09kt7uilTwtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715009; c=relaxed/simple;
	bh=tgJam1AA8RhybLELFvuMJfu2ggMrfQ1btbDCF0y2Kdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbfRvfNpUJGbF8rDl4gkT9w5skOAUhKcJ3Eqd4os5hDDbmgb5gjE2Z6RaexYrR1Bg+Roo1Qlof0R7C7p7c0HQMfTFB2aJb4vY9URmF1N/AbhnD9MGzqmK6+qeWruLVzo5NnDqDftrBInOYH/us4ZhfTK4Y6Mb4FUpPEIVHlZtc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8HsRsfq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712715008; x=1744251008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tgJam1AA8RhybLELFvuMJfu2ggMrfQ1btbDCF0y2Kdk=;
  b=Y8HsRsfqp2ztga+oPv4NU1YPzS95IruZC5Hccz9Bl8iusQ3YnkxhnVa4
   5MQ7Y52DsAmg8YPDFuXu1G+WcPcRO663LSo5ZoQziEukk4/V7rkqF1Hm9
   tgT71j3J5uU/JmRppMwtKSXEgqfL2YmwE1RWMJoMSgy7kK7czzAIJCDRw
   FV1yjxd66W4Op+sjERIyZpBETz7UWoX4rwpfHQpJpthlyDYi+ZXmbj7Gq
   eNd05kGkKPEj8nUxCIxeJ3PB1Aq3jaRBq/44oB9F3Fp0UugA2LWckW46Q
   JfV3BNnwW2jXTr6KxImZ4rKbUso6KkQgT/U6zg5VM8ax3fyPWH83eJll1
   g==;
X-CSE-ConnectionGUID: xmIhYvh3SKSgNdk5+Iif1Q==
X-CSE-MsgGUID: PmE94UdCSOSwo+4BCZ+BVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7918539"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7918539"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:10:07 -0700
X-CSE-ConnectionGUID: wVV8b4STSGO20CXD1PexxA==
X-CSE-MsgGUID: MYLMYFFTScqj16e31lr/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20478888"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 19:10:04 -0700
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
Subject: [PATCH v2 02/12] iommu/vt-d: Add cache tag invalidation helpers
Date: Wed, 10 Apr 2024 10:08:34 +0800
Message-Id: <20240410020844.253535-3-baolu.lu@linux.intel.com>
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

Add several helpers to invalidate the caches after mappings in the
affected domain are changed.

- cache_tag_flush_range() invalidates a range of caches after mappings
  within this range are changed. It uses the page-selective cache
  invalidation methods.

- cache_tag_flush_all() invalidates all caches tagged by a domain ID.
  It uses the domain-selective cache invalidation methods.

- cache_tag_flush_range_np() invalidates a range of caches when new
  mappings are created in the domain and the corresponding page table
  entries change from non-present to present.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  14 +++
 drivers/iommu/intel/cache.c | 195 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c |  12 ---
 3 files changed, 209 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6f6bffc60852..700574421b51 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -35,6 +35,8 @@
 #define VTD_PAGE_MASK		(((u64)-1) << VTD_PAGE_SHIFT)
 #define VTD_PAGE_ALIGN(addr)	(((addr) + VTD_PAGE_SIZE - 1) & VTD_PAGE_MASK)
 
+#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
+
 #define VTD_STRIDE_SHIFT        (9)
 #define VTD_STRIDE_MASK         (((u64)-1) << VTD_STRIDE_SHIFT)
 
@@ -1041,6 +1043,13 @@ static inline void context_set_sm_pre(struct context_entry *context)
 	context->lo |= BIT_ULL(4);
 }
 
+/* Returns a number of VTD pages, but aligned to MM page size */
+static inline unsigned long aligned_nrpages(unsigned long host_addr, size_t size)
+{
+	host_addr &= ~PAGE_MASK;
+	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT;
+}
+
 /* Convert value to context PASID directory size field coding. */
 #define context_pdts(pds)	(((pds) & 0x7) << 9)
 
@@ -1116,6 +1125,11 @@ int cache_tag_assign_domain(struct dmar_domain *domain, u16 did,
 			    struct device *dev, ioasid_t pasid);
 void cache_tag_unassign_domain(struct dmar_domain *domain, u16 did,
 			       struct device *dev, ioasid_t pasid);
+void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
+			   unsigned long end, int ih);
+void cache_tag_flush_all(struct dmar_domain *domain);
+void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
+			      unsigned long end);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index debbdaeff1c4..b2270dc8a765 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -12,6 +12,7 @@
 #include <linux/dmar.h>
 #include <linux/iommu.h>
 #include <linux/memory.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 
 #include "iommu.h"
@@ -194,3 +195,197 @@ void cache_tag_unassign_domain(struct dmar_domain *domain, u16 did,
 	if (domain->domain.type == IOMMU_DOMAIN_NESTED)
 		__cache_tag_unassign_parent_domain(domain->s2_domain, did, dev, pasid);
 }
+
+static unsigned long calculate_psi_aligned_address(unsigned long start,
+						   unsigned long end,
+						   unsigned long *_pages,
+						   unsigned long *_mask)
+{
+	unsigned long pages = aligned_nrpages(start, end - start + 1);
+	unsigned long aligned_pages = __roundup_pow_of_two(pages);
+	unsigned long bitmask = aligned_pages - 1;
+	unsigned long mask = ilog2(aligned_pages);
+	unsigned long pfn = IOVA_PFN(start);
+
+	/*
+	 * PSI masks the low order bits of the base address. If the
+	 * address isn't aligned to the mask, then compute a mask value
+	 * needed to ensure the target range is flushed.
+	 */
+	if (unlikely(bitmask & pfn)) {
+		unsigned long end_pfn = pfn + pages - 1, shared_bits;
+
+		/*
+		 * Since end_pfn <= pfn + bitmask, the only way bits
+		 * higher than bitmask can differ in pfn and end_pfn is
+		 * by carrying. This means after masking out bitmask,
+		 * high bits starting with the first set bit in
+		 * shared_bits are all equal in both pfn and end_pfn.
+		 */
+		shared_bits = ~(pfn ^ end_pfn) & ~bitmask;
+		mask = shared_bits ? __ffs(shared_bits) : BITS_PER_LONG;
+	}
+
+	*_pages = aligned_pages;
+	*_mask = mask;
+
+	return ALIGN_DOWN(start, VTD_PAGE_SIZE);
+}
+
+/*
+ * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
+ * when the memory mappings in the target domain have been modified.
+ */
+void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
+			   unsigned long end, int ih)
+{
+	unsigned long pages, mask, addr;
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		struct intel_iommu *iommu = tag->iommu;
+		struct device_domain_info *info;
+		u16 sid;
+
+		switch (tag->type) {
+		case CACHE_TAG_IOTLB:
+		case CACHE_TAG_PARENT_IOTLB:
+			if (domain->use_first_level) {
+				qi_flush_piotlb(iommu, tag->domain_id,
+						tag->pasid, addr, pages, ih);
+			} else {
+				/*
+				 * Fallback to domain selective flush if no
+				 * PSI support or the size is too big.
+				 */
+				if (!cap_pgsel_inv(iommu->cap) ||
+				    mask > cap_max_amask_val(iommu->cap))
+					iommu->flush.flush_iotlb(iommu, tag->domain_id,
+								 0, 0, DMA_TLB_DSI_FLUSH);
+				else
+					iommu->flush.flush_iotlb(iommu, tag->domain_id,
+								 addr | ih, mask,
+								 DMA_TLB_PSI_FLUSH);
+			}
+			break;
+		case CACHE_TAG_PARENT_DEVTLB:
+			/*
+			 * Address translation cache in device side caches the
+			 * result of nested translation. There is no easy way
+			 * to identify the exact set of nested translations
+			 * affected by a change in S2. So just flush the entire
+			 * device cache.
+			 */
+			addr = 0;
+			mask = MAX_AGAW_PFN_WIDTH;
+			fallthrough;
+		case CACHE_TAG_DEVTLB:
+			info = dev_iommu_priv_get(tag->dev);
+			sid = PCI_DEVID(info->bus, info->devfn);
+
+			if (tag->pasid == IOMMU_NO_PASID)
+				qi_flush_dev_iotlb(iommu, sid, info->pfsid,
+						   info->ats_qdep, addr, mask);
+			else
+				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
+							 tag->pasid, info->ats_qdep,
+							 addr, mask);
+
+			quirk_extra_dev_tlb_flush(info, addr, mask, tag->pasid, info->ats_qdep);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
+
+/*
+ * Invalidates all ranges of IOVA when the memory mappings in the target
+ * domain have been modified.
+ */
+void cache_tag_flush_all(struct dmar_domain *domain)
+{
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		struct intel_iommu *iommu = tag->iommu;
+		struct device_domain_info *info;
+		u16 sid;
+
+		switch (tag->type) {
+		case CACHE_TAG_IOTLB:
+		case CACHE_TAG_PARENT_IOTLB:
+			if (domain->use_first_level)
+				qi_flush_piotlb(iommu, tag->domain_id,
+						tag->pasid, 0, -1, 0);
+			else
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 0, 0, DMA_TLB_DSI_FLUSH);
+			break;
+		case CACHE_TAG_DEVTLB:
+		case CACHE_TAG_PARENT_DEVTLB:
+			info = dev_iommu_priv_get(tag->dev);
+			sid = PCI_DEVID(info->bus, info->devfn);
+
+			qi_flush_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep,
+					   0, MAX_AGAW_PFN_WIDTH);
+			quirk_extra_dev_tlb_flush(info, 0, MAX_AGAW_PFN_WIDTH,
+						  IOMMU_NO_PASID, info->ats_qdep);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
+
+/*
+ * Invalidate a range of IOVA when new mappings are created in the target
+ * domain.
+ *
+ * - VT-d spec, Section 6.1 Caching Mode: When the CM field is reported as
+ *   Set, any software updates to remapping structures other than first-
+ *   stage mapping requires explicit invalidation of the caches.
+ * - VT-d spec, Section 6.8 Write Buffer Flushing: For hardware that requires
+ *   write buffer flushing, software must explicitly perform write-buffer
+ *   flushing, if cache invalidation is not required.
+ */
+void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
+			      unsigned long end)
+{
+	unsigned long pages, mask, addr;
+	struct cache_tag *tag;
+	unsigned long flags;
+
+	addr = calculate_psi_aligned_address(start, end, &pages, &mask);
+
+	spin_lock_irqsave(&domain->cache_lock, flags);
+	list_for_each_entry(tag, &domain->cache_tags, node) {
+		struct intel_iommu *iommu = tag->iommu;
+
+		if (!cap_caching_mode(iommu->cap) || domain->use_first_level) {
+			iommu_flush_write_buffer(iommu);
+			continue;
+		}
+
+		if (tag->type == CACHE_TAG_IOTLB ||
+		    tag->type == CACHE_TAG_PARENT_IOTLB) {
+			/*
+			 * Fallback to domain selective flush if no
+			 * PSI support or the size is too big.
+			 */
+			if (!cap_pgsel_inv(iommu->cap) ||
+			    mask > cap_max_amask_val(iommu->cap))
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 0, 0, DMA_TLB_DSI_FLUSH);
+			else
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 addr, mask,
+							 DMA_TLB_PSI_FLUSH);
+		}
+	}
+	spin_unlock_irqrestore(&domain->cache_lock, flags);
+}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 17b8ce4b9154..4572624a275e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -54,11 +54,6 @@
 				__DOMAIN_MAX_PFN(gaw), (unsigned long)-1))
 #define DOMAIN_MAX_ADDR(gaw)	(((uint64_t)__DOMAIN_MAX_PFN(gaw)) << VTD_PAGE_SHIFT)
 
-/* IO virtual address start page frame number */
-#define IOVA_START_PFN		(1)
-
-#define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
 
@@ -1985,13 +1980,6 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
 				      domain_context_mapping_cb, domain);
 }
 
-/* Returns a number of VTD pages, but aligned to MM page size */
-static unsigned long aligned_nrpages(unsigned long host_addr, size_t size)
-{
-	host_addr &= ~PAGE_MASK;
-	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT;
-}
-
 /* Return largest possible superpage level for a given mapping */
 static int hardware_largepage_caps(struct dmar_domain *domain, unsigned long iov_pfn,
 				   unsigned long phy_pfn, unsigned long pages)
-- 
2.34.1


