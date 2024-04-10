Return-Path: <linux-kernel+bounces-137821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68E89E808
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA5D1C22FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B51125CD;
	Wed, 10 Apr 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nnlm3unx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64E10A01
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715016; cv=none; b=mODEoPhufIIEYg3IrvXvW0ZEtrYWu+QvHqt6Y77eWeV54tEz3fVNmJWpBjkXaXBDi54OjOAJ8lY5hS5DwpR5jlVLcS57I9z5RW30qUxmyQjEY3+X8cwg3H8yoUJeYbCcIdR1E9YmB5xaXhSuM3n7A5e/k2K53ZexiHmm/H8BWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715016; c=relaxed/simple;
	bh=DQeusfHho9+hT8qneJdFuRLOFHrtM4f8nTwIs8LP6XM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iRYauRncWnDVwfETYZfNV2JLtzyj52MwYIJsK40GZdrbJzbd+0VVFhr07JCdCvaPEjzixjPizfJEmRgtws/lnLSNkCvFP2JdZNg1VGYvO7d7v5lJFGB9AXfQAplhm0D4pNK8mSmFCNjhFMjXQKlN7oueD3JG1Dy8PzDNQqFfFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nnlm3unx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712715016; x=1744251016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQeusfHho9+hT8qneJdFuRLOFHrtM4f8nTwIs8LP6XM=;
  b=Nnlm3unxFdUzJFCdaAWoaES74N7RPMR6ldzSC0Qp7BfnRTHdw7WXKlAd
   htwF2D4ZyQg101OfBS0et8uQcdCpxKUnCjVO70dxYbRz6TI6bmKNkPU+0
   8RnWbYRz91H2idnIFLtgcg9tkUv8o4keB6NmgsFGAQeDTpAqzxP9shTAG
   TLgbf2ywCmcbId0JYyD0XPclqRaDjapm92Btu4XQNufGSn0XhLkFqFvqU
   D8O5GqL9rJiTw3cu7nWpppc26mhCfZKy0//dK5gX5R0FccaxPKur4WgEU
   5Q+UGl0Ug11Io0cZKHKJTWI5HPX/WU38ABbNyfS6OoEUhJw76ALzJgqxr
   Q==;
X-CSE-ConnectionGUID: XhXL92jPTO6SI/j3Ymy3eQ==
X-CSE-MsgGUID: 3dI3yYkURkKhxdG9ph2i2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7918579"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7918579"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:10:15 -0700
X-CSE-ConnectionGUID: pUFUDgUPSZSy1HxI14s1vQ==
X-CSE-MsgGUID: fqTHkzSPQ6aYfE/adKddAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20478899"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 19:10:12 -0700
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
Subject: [PATCH v2 05/12] iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
Date: Wed, 10 Apr 2024 10:08:37 +0800
Message-Id: <20240410020844.253535-6-baolu.lu@linux.intel.com>
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

The tlb_sync callback is called by the iommu core to flush a range of
caches for the affected domain. Use cache_tag_flush_range() in this
callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2af3e6f54af0..8ec69f09935d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4101,25 +4101,8 @@ static size_t intel_iommu_unmap_pages(struct iommu_domain *domain,
 static void intel_iommu_tlb_sync(struct iommu_domain *domain,
 				 struct iommu_iotlb_gather *gather)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long iova_pfn = IOVA_PFN(gather->start);
-	size_t size = gather->end - gather->start;
-	struct iommu_domain_info *info;
-	unsigned long start_pfn;
-	unsigned long nrpages;
-	unsigned long i;
-
-	nrpages = aligned_nrpages(gather->start, size);
-	start_pfn = mm_to_dma_pfn_start(iova_pfn);
-
-	xa_for_each(&dmar_domain->iommu_array, i, info)
-		iommu_flush_iotlb_psi(info->iommu, dmar_domain,
-				      start_pfn, nrpages,
-				      list_empty(&gather->freelist), 0);
-
-	if (dmar_domain->nested_parent)
-		parent_domain_flush(dmar_domain, start_pfn, nrpages,
-				    list_empty(&gather->freelist));
+	cache_tag_flush_range(to_dmar_domain(domain), gather->start,
+			      gather->end, list_empty(&gather->freelist));
 	put_pages_list(&gather->freelist);
 }
 
-- 
2.34.1


