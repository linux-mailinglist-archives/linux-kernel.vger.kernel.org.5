Return-Path: <linux-kernel+bounces-146470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98DF8A65BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EE11F23A94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB16415B105;
	Tue, 16 Apr 2024 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kb0+ra/R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47615ADAF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254919; cv=none; b=M+5PCnEjY1g0xOP4tUGl1vKSduFFUMb3tb1B0RiKT4GnxORc0rrf6IVxTiQ55M0UMd6YVpNjBkuAO03Xrrfw33uBzTESncZzSBNsJ+ZUo6DhxqYnX6/FyN1AlTH8IS9mKv2ujVt874A4RVkts/73uC3qKCAubXKe8yGT4CjpOaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254919; c=relaxed/simple;
	bh=+B1K+3RGNJMZ4qg4nKfxt0LCCXm/Psgjhstoi04IBCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYscQSwPN4JXbh09mbNoSqYbQ8PFebLuorjRbOPUruOB9o91OlcXqIbVLdwAf4cpDPTf50kqWhpBQU4m+k9m5Bgfh1WW71o+aGT3V5/Yxh666VElO8u9v0VYC/YBnXXnmHDyPg4ZIyXbiqmrbkHkRuMNcULOxMHKl/FvLUNzLMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kb0+ra/R; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254918; x=1744790918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+B1K+3RGNJMZ4qg4nKfxt0LCCXm/Psgjhstoi04IBCI=;
  b=Kb0+ra/RthTiMllmy/kbtUivtWn9eQJYH6D0CzNQ/trZerBuw+B1f9l5
   sknEechUe/ZutcD6PyjAfWNvrjCj+X6xKaskOA7G3L3NM9p9p9cUHB8/e
   Pzr6mxuvmRNMedjil57n4GvBq8y3PQ8tZPDBegHi6O6CIGTrTPqdF+42x
   TeuGYlkLcpeIJJKDr74u0EcIW3dP97imI3nR7WaIBpNXL9VFccXBJIV9+
   vrF4tmNWYmTy0vlkYQxPnpRtCQBa6mokCVlEycwZNXSXuqmbmIbP4lQYl
   2i/D4ggEtAPS7V3UUZolEpqtIj48ddEm3qD35mhIw5fSCsveYfETcCcKd
   A==;
X-CSE-ConnectionGUID: jiqhwyqNTPaIGzGX1mGTgQ==
X-CSE-MsgGUID: BGMtd0Y1T5KMeLpPmQ1aYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466497"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466497"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:37 -0700
X-CSE-ConnectionGUID: cCrMESowQOmPAg6FzGnh7w==
X-CSE-MsgGUID: sK9UMUfHRXqFSd68+c3Yqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077786"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:36 -0700
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
Subject: [PATCH v3 08/12] iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
Date: Tue, 16 Apr 2024 16:06:52 +0800
Message-Id: <20240416080656.60968-9-baolu.lu@linux.intel.com>
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

The cache_invalidate_user callback is called to invalidate a range
of caches for the affected user domain. Use cache_tag_flush_range()
in this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h  |  6 +++++
 drivers/iommu/intel/nested.c | 50 +++---------------------------------
 2 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index e17683ecef4b..b1d04aa36d31 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1050,6 +1050,12 @@ static inline unsigned long aligned_nrpages(unsigned long host_addr, size_t size
 	return PAGE_ALIGN(host_addr + size) >> VTD_PAGE_SHIFT;
 }
 
+/* Return a size from number of VTD pages. */
+static inline unsigned long nrpages_to_size(unsigned long npages)
+{
+	return npages << VTD_PAGE_SHIFT;
+}
+
 /* Convert value to context PASID directory size field coding. */
 #define context_pdts(pds)	(((pds) & 0x7) << 9)
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 13406ee742bf..16a2bcf5cfeb 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -88,50 +88,6 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
 	kfree(dmar_domain);
 }
 
-static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
-				   unsigned int mask)
-{
-	struct device_domain_info *info;
-	unsigned long flags;
-	u16 sid, qdep;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(info, &domain->devices, link) {
-		if (!info->ats_enabled)
-			continue;
-		sid = info->bus << 8 | info->devfn;
-		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				   qdep, addr, mask);
-		quirk_extra_dev_tlb_flush(info, addr, mask,
-					  IOMMU_NO_PASID, qdep);
-	}
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-
-static void intel_nested_flush_cache(struct dmar_domain *domain, u64 addr,
-				     u64 npages, bool ih)
-{
-	struct iommu_domain_info *info;
-	unsigned int mask;
-	unsigned long i;
-
-	xa_for_each(&domain->iommu_array, i, info)
-		qi_flush_piotlb(info->iommu,
-				domain_id_iommu(domain, info->iommu),
-				IOMMU_NO_PASID, addr, npages, ih);
-
-	if (!domain->has_iotlb_device)
-		return;
-
-	if (npages == U64_MAX)
-		mask = 64 - VTD_PAGE_SHIFT;
-	else
-		mask = ilog2(__roundup_pow_of_two(npages));
-
-	nested_flush_dev_iotlb(domain, addr, mask);
-}
-
 static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 					      struct iommu_user_data_array *array)
 {
@@ -164,9 +120,9 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 			break;
 		}
 
-		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
-					 inv_entry.npages,
-					 inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
+		cache_tag_flush_range(dmar_domain, inv_entry.addr,
+				      inv_entry.addr + nrpages_to_size(inv_entry.npages) - 1,
+				      inv_entry.flags & IOMMU_VTD_INV_FLAGS_LEAF);
 		processed++;
 	}
 
-- 
2.34.1


