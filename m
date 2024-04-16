Return-Path: <linux-kernel+bounces-146468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6498A65B7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A404284CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E622156652;
	Tue, 16 Apr 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8RFCUV+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F315AAA8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254913; cv=none; b=rE1x61sSlDfN8S1oANxPdy1+SzbCF0fvka9wxJSzZV17xHDAERP2c4/J8FgRRn67Jc0IXOcuSfWON0BCphjkS2ZQ0Lwuk4Z3aNwWqG1Gj0Zs1I8baEXaSxktLP3PfZHZx+/ev2KPD/ZgdbmMoBU4xmi86wdUgRguZ84ixmmt+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254913; c=relaxed/simple;
	bh=PJqJeyftw3Iz4RPiHxp7Y3vDbtVPKOGn7eAP8+TK5Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTyb//S+/s65wGGvSMyqLqTwWePVi9pj4Eeb+hoQJFwS393iAenEa+pko2nAHxqqz5ttwfRkQyTyc5EX8ZSSCh80g1TjTxC0qviKk/gG7/P9qKOIzV8tsLDj9FNKUMdDvla0/r/+Uski4zOepuSBTTxA3llDaOYbapKQNedU6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8RFCUV+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713254912; x=1744790912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PJqJeyftw3Iz4RPiHxp7Y3vDbtVPKOGn7eAP8+TK5Hs=;
  b=X8RFCUV+PBGQ1ORYu1Lcd5V+W+2Ah8ieOl3FxHOnkm6xk7J0wrsYEcW/
   KuXlUUhPrpyz975aBfHnijUM6vy1K/MRUkYF2tPJYGySmrvRK+6wmbTCF
   IGVg+EXN0KfvjikcU0CoRDVwuKMTmCSCWAZ34vAUpBGcIN/KsLQtzwwSX
   N3RXaXX5o3EL8eTYHB/tmVNarf6Sub57V9Av/Kxi6n1t447+WWuCrVl4J
   FbNpiagJ6gBu4ISwL2A8jnSEQfSlFzDTpE2ufBJQzX2j5+v02AkQxyImo
   1/aXUyjzVexPtcb7eoKfll1sazcpzZbGzScihspsjAu9CQOiuhcrOBFTH
   g==;
X-CSE-ConnectionGUID: Sp8rtKNdRS2MgRDCNyHOdg==
X-CSE-MsgGUID: QeaqirLkROCF/+HOwViVrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="12466475"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="12466475"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 01:08:32 -0700
X-CSE-ConnectionGUID: K1v2qB1pTqWCskoi7OblPg==
X-CSE-MsgGUID: D3tiAYf5QDytCWHywEkdIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22077729"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 16 Apr 2024 01:08:30 -0700
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
Subject: [PATCH v3 06/12] iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map
Date: Tue, 16 Apr 2024 16:06:50 +0800
Message-Id: <20240416080656.60968-7-baolu.lu@linux.intel.com>
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

The iotlb_sync_map callback is called by the iommu core after non-present
to present mappings are created. The iommu driver uses this callback to
invalidate caches if IOMMU is working in caching mode and second-only
translation is used for the domain. Use cache_tag_flush_range_np() in this
callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6bf5b91b03c5..c6a0d528ad19 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1500,20 +1500,6 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
-/* Notification for newly created mappings */
-static void __mapping_notify_one(struct intel_iommu *iommu, struct dmar_domain *domain,
-				 unsigned long pfn, unsigned int pages)
-{
-	/*
-	 * It's a non-present to present mapping. Only flush if caching mode
-	 * and second level.
-	 */
-	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
-		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
-	else
-		iommu_flush_write_buffer(iommu);
-}
-
 /*
  * Flush the relevant caches in nested translation if the domain
  * also serves as a parent
@@ -4543,14 +4529,8 @@ static bool risky_device(struct pci_dev *pdev)
 static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				      unsigned long iova, size_t size)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	unsigned long pages = aligned_nrpages(iova, size);
-	unsigned long pfn = iova >> VTD_PAGE_SHIFT;
-	struct iommu_domain_info *info;
-	unsigned long i;
+	cache_tag_flush_range_np(to_dmar_domain(domain), iova, iova + size - 1);
 
-	xa_for_each(&dmar_domain->iommu_array, i, info)
-		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
 	return 0;
 }
 
-- 
2.34.1


