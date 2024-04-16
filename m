Return-Path: <linux-kernel+bounces-146467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D070E8A65B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B611F235E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7872115AAB7;
	Tue, 16 Apr 2024 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPLLvX3b"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF213AA3A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254912; cv=none; b=fH68g95T0hcF907GKE8vjjAi1aWtPfpGLm+K2sqhVn2JrY9zI3dzLD2IlMpL6lJa28VfPj+K9z6VYkzLsDgZw4KMeKNVlscS+WtzjwhizQlGrYCXGKPVH1wLYyufLgZKAdto/0mcOXJutNQWlfS+8v5Gq61zWHReQcbvz/u43aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254912; c=relaxed/simple;
	bh=aqInf3xtpYbET9AdhI6kqKdlwS/7Y4QgMBashpQ0HNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDY59zldqwI3R5/nVSKasYPXSG7R3hpgZkFHkwAyHGVE8eUTIihp8YIYVmTARETrbBnjMeh35Vec9b8uvC12OK5OgZVF/rUSkgznwP+Rj+JOBMESofHZM8+M28TYvvy6rGaRt4syp1iFz9wJr/OiQkY1wiSkv6EoV9dVqFX91NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPLLvX3b; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254909; x=1744790909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aqInf3xtpYbET9AdhI6kqKdlwS/7Y4QgMBashpQ0HNk=;
  b=FPLLvX3be0SR4TqJum9E/3bS12mH+ySu6EfP6mPIgCzO8xuaPzyTGvZ3
   becVcH506sGzsf/Fdhc0HVyO0lEZQv/1TP5fLWqOlTHwqf9QxW1176y3Q
   XArScIpE2rkkNnak4Bjd2ZV0OYSV4yGA965wQHDlX9PsHm2O1B4yWBfJq
   qezae6d0jqTe+UKCLmxJPWZljcONyLq64yZEJ1rPu+6x3VSDvzK28HohY
   Tp1BOL2hlEX5e/qCvECCKJ5nw4wXt990Z9Iao/mOP5e/WTOnrb+1mF2gr
   uhZh3PMgW4WQbHbwHGAizll8qaMv9tH6bDyHQEVVTlfuANwUuIdvsFyem
   w==;
X-CSE-ConnectionGUID: mIioGbSCR/eNER4ucvKPCw==
X-CSE-MsgGUID: TsKgERlBQJ6PSAe10FuVGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466468"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466468"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:29 -0700
X-CSE-ConnectionGUID: cP6AFRR8Tv2T5Gfqcxn5kQ==
X-CSE-MsgGUID: VTi43koZSE25aLwVjGdSCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077718"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:27 -0700
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
Subject: [PATCH v3 05/12] iommu/vt-d: Use cache_tag_flush_range() in tlb_sync
Date: Tue, 16 Apr 2024 16:06:49 +0800
Message-Id: <20240416080656.60968-6-baolu.lu@linux.intel.com>
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

The tlb_sync callback is called by the iommu core to flush a range of
caches for the affected domain. Use cache_tag_flush_range() in this
callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4eca107389b4..6bf5b91b03c5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4103,25 +4103,8 @@ static size_t intel_iommu_unmap_pages(struct iommu_domain *domain,
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


