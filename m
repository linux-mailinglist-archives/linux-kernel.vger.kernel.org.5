Return-Path: <linux-kernel+bounces-137824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9044B89E80E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8B2B2339F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5970F22085;
	Wed, 10 Apr 2024 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbzeY6cn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378DA20304
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715024; cv=none; b=Sjr7PjqiyzLHcoDMXVkuNb59DAhA/tVXAUqI0YFtY+Whi5HgC2wo3Adk3kxsVbrxZ6k/2GuHYSfB0lz03Ay7OFsH9Zwtj52EPNtITxPGoXl5DAW+fwXJPrdDyM1bwCgcISthWnSXNgVRi6Gi5vlO0osu2rMqlh/TNsq/PbcYbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715024; c=relaxed/simple;
	bh=jYNsXY9ExG8M0Ob2c88oOkriVnbsWsmB8tTBDVSAhSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtCYXJbwG0m2epev4Fyiz/3sxUeAfYvTpAAEnRncX7RA59M1f+Qmnvwt2z8YWLx+Lx5rCnjtik+dxefeM+SRNOERP92veAK9DBfUxeqGTjsR0fI7spHqB2p5WgEoIbBrm6AgW9jQgw2Z96Jh3x60wxLQPHpZrwbUMgF0jhGHdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbzeY6cn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712715024; x=1744251024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jYNsXY9ExG8M0Ob2c88oOkriVnbsWsmB8tTBDVSAhSU=;
  b=gbzeY6cnW/Lz8CP5dCcv7iy9/V0VorLmj4wdn2JFzhwP7OJA5fxRpTzm
   cPv1liE/pEVzQNxGj36VLTYUX/Q6c0kjkODEdLbW/KDwoLa1kIVx124/R
   EoRcO6pnWW6NFB67BMOp45ht9Ill44l8KVAxt5mFlli5TPh+vgqLmrm7y
   yogAWSxrD6+KjOhvGZg239fW6UhBSDxzapTVB1WU80D0qEsxaj2XAfW2a
   /928ZRfeTUwGGa0Ei9+GO70N4ocKcJLymJR90vdZnVPzmq/2RjmVAn878
   dHo/kUpEUliYWvLxC5S9elsbwKEH4szjLyJgAg8yPzp5EMLwfx5wh7/R2
   w==;
X-CSE-ConnectionGUID: djnmZpSWRoCZW2CuiyhpqA==
X-CSE-MsgGUID: swP7iLRCTBukrc60DsadhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7918597"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7918597"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:10:23 -0700
X-CSE-ConnectionGUID: 4YiX2TjaS0i9jr50F3hCPA==
X-CSE-MsgGUID: mdlYYQcDTZ63xNocZDOROw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20478915"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 19:10:20 -0700
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
Subject: [PATCH v2 08/12] iommu/vt-d: Use cache_tag_flush_range() in cache_invalidate_user
Date: Wed, 10 Apr 2024 10:08:40 +0800
Message-Id: <20240410020844.253535-9-baolu.lu@linux.intel.com>
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

The cache_invalidate_user callback is called to invalidate a range
of caches for the affected user domain. Use cache_tag_flush_range()
in this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h  |  6 +++++
 drivers/iommu/intel/nested.c | 50 +++---------------------------------
 2 files changed, 9 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 700574421b51..90a300665962 100644
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
index 85c744099558..ffbd8d98a3b8 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -90,50 +90,6 @@ static void intel_nested_domain_free(struct iommu_domain *domain)
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
@@ -166,9 +122,9 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
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


