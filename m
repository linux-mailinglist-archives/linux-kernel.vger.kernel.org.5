Return-Path: <linux-kernel+bounces-146464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6D78A65B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E8E1F22D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D440E158DB5;
	Tue, 16 Apr 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apqvXCLw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033115698B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254902; cv=none; b=IEni2zEodKznrBkgZBWdVm13F9gHcMGttDwriHh/hi15OGD8xWAx7EK9U+xqCauDzwEF3GGhxztDTtyJS1G9VbdY5nGYQv82/m6rfV/7wEAJbgcMLVnR06rCbXmJSG5/Nejg+2+MmQl8XkOz5kYj9pugU9RMuW36BQwl+tSyAoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254902; c=relaxed/simple;
	bh=ZtWgAoWGUL/nVL+ZR9BEyLZCV9AhoJ1Mc2RvsLUfG5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hmzil0vYsguuKE1o4Z9yrL+Zzzz+gDQ/XeyZ20dIg7QMPE6km4LOTw81E/5maSeo2LHYKrnFUfW/2OKWTGD2CKekUy87qP0B1e4OJ8dszPivCKZmV5TTFcHWZ41Vu2aseTjcJe7vFXHJfFFEGnCK+BfxnSeHUaDGEuKDjm33EcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apqvXCLw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254901; x=1744790901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZtWgAoWGUL/nVL+ZR9BEyLZCV9AhoJ1Mc2RvsLUfG5Y=;
  b=apqvXCLwnaYeJ64TKJZHfMjLas41OIc5uZJw+Veus0f0xF/GGnMWJm4w
   GFrJAzm0/EGYYWoq1dRmDhDtrSFOT0p52s7RD+bp6rU62XS3yXzMYAZVL
   YgeeeTfphb2qIz+GIEJabr110C0CO2QCF09nW9A8FV3ZSRXJSDYjQXTuX
   /hkHAUyZNPkDGNp8UndIDUDX8qf4soFTNMlano8IEjvcnueGy/QAMK95I
   hDXKJv1GZecuC0NZOFkVLJnSxN92ufIyRRAsQOK6x14spA9j260krKwfX
   8YqWQ1xpzxtuq//4sKhf1OPgbcCDXME12fmrrgl2U6q47uvRxYHSH8oI9
   w==;
X-CSE-ConnectionGUID: /jivw/TKQye96W/4bcLk2Q==
X-CSE-MsgGUID: hAqaok+yTnCnEzpGy9Aeiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466442"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466442"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:21 -0700
X-CSE-ConnectionGUID: 2vZgjkoBQF6gxLB6fh3Dbw==
X-CSE-MsgGUID: gMjiYGBBSyKdCMCJXNoKDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077686"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:19 -0700
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
Subject: [PATCH v3 02/12] iommu/vt-d: Add cache tag invalidation helpers
Date: Tue, 16 Apr 2024 16:06:46 +0800
Message-Id: <20240416080656.60968-3-baolu.lu@linux.intel.com>
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
index 52471f5337d5..e17683ecef4b 100644
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
 
@@ -1122,6 +1131,11 @@ int cache_tag_assign_domain(struct dmar_domain *domain,
 			    struct device *dev, ioasid_t pasid);
 void cache_tag_unassign_domain(struct dmar_domain *domain,
 			       struct device *dev, ioasid_t pasid);
+void cache_tag_flush_range(struct dmar_domain *domain, unsigned long start,
+			   unsigned long end, int ih);
+void cache_tag_flush_all(struct dmar_domain *domain);
+void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
+			      unsigned long end);
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 296f1645a739..0539275a9d20 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -12,6 +12,7 @@
 #include <linux/dmar.h>
 #include <linux/iommu.h>
 #include <linux/memory.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 
 #include "iommu.h"
@@ -212,3 +213,197 @@ void cache_tag_unassign_domain(struct dmar_domain *domain,
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
+	return ALIGN_DOWN(start, VTD_PAGE_SIZE << mask);
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
+		case CACHE_TAG_NESTING_IOTLB:
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
+		case CACHE_TAG_NESTING_DEVTLB:
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
+		case CACHE_TAG_NESTING_IOTLB:
+			if (domain->use_first_level)
+				qi_flush_piotlb(iommu, tag->domain_id,
+						tag->pasid, 0, -1, 0);
+			else
+				iommu->flush.flush_iotlb(iommu, tag->domain_id,
+							 0, 0, DMA_TLB_DSI_FLUSH);
+			break;
+		case CACHE_TAG_DEVTLB:
+		case CACHE_TAG_NESTING_DEVTLB:
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
+		    tag->type == CACHE_TAG_NESTING_IOTLB) {
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
index 0c0b8e493fda..ac413097058c 100644
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
 
@@ -1991,13 +1986,6 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
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


