Return-Path: <linux-kernel+bounces-144455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94EA8A469B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9F41C216BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBFED29E;
	Mon, 15 Apr 2024 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cdiz6SHg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509E74C9F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713145194; cv=none; b=DZRdKWye8/o9H9P3/gdXi3FQdjtiwjISk9IfGCFU6Dk/NUmbGscYMx9kyVpdC4ryYqRLHgh+0cs/87wliv9FWtsDLSDisS8WS8R1SXhjt73TzRR765+Wg4vghSSsjUoCXidqkk+ODIHWTq80caQU77NVavXMt1O7QlBV/DWy7Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713145194; c=relaxed/simple;
	bh=HUEvqBRuByY66qC0pSqA1h8TLgqdNGRv8dQuJSw34YI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5o4vmFtSbTpL1kd+Ne6eD47D3zRK25Y2kSZXq1N85V9PGFa7C3RSErbAxPYxbAM/lRqFkbY4cIpdaHpZ3lzciDhhtDwRLHRW7TNPi+TJ2VESb0nDTEvAHroEyFSi+D89ug/JPaCcPgy+BdYGweHhP23ASaj4dIZCFqhR3kM9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cdiz6SHg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713145194; x=1744681194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HUEvqBRuByY66qC0pSqA1h8TLgqdNGRv8dQuJSw34YI=;
  b=Cdiz6SHgyGHuyZqsPtoC913CnPTnubDSbk4kzbqQMSLVIOUiKUWVBdMx
   5sQUVjl9NOglzP/K72/FdfMram3+OSIVkRiqx8b/fEoTDOEMSM1sRq2q1
   hTBOrSRoyaR9qSkqlZgBs0V/IrIMaj2v0lDtuxjAh58JLdMDJpmUEWfh1
   SiPS4kp+ncWJm2VQznyzY8ewaWonZ+1R5cxP8CHMDyQqyuoH+43cRv/nO
   Ge41q5mOYNY5W7x9Uc6GFMOAmn8aNHkjTvbbfDAyU645EhJkFNPv5Ut1C
   ivdmEbEas58ljwwMjXXyphBmgd9ykWbOR5R8gVJ6XdHQEBVI4cB4OW382
   A==;
X-CSE-ConnectionGUID: CK1DfORGRXKEzsIfAYIZWQ==
X-CSE-MsgGUID: b2H2XObtRO6gb2evk4heIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8641425"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8641425"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 18:39:53 -0700
X-CSE-ConnectionGUID: FavOMW5pRPiK2jC/zquw0Q==
X-CSE-MsgGUID: AOp5kS1cTr6QVD4Ly8P4/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21855545"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 14 Apr 2024 18:39:51 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 1/1] iommu/vt-d: Remove caching mode check before device TLB flush
Date: Mon, 15 Apr 2024 09:38:35 +0800
Message-Id: <20240415013835.9527-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Caching Mode (CM) of the Intel IOMMU indicates if the hardware
implementation caches not-present or erroneous translation-structure
entries except for the first-stage translation. The caching mode is
irrelevant to the device TLB, therefore there is no need to check it
before a device TLB invalidation operation.

Remove two caching mode checks before device TLB invalidation in the
driver. The removal of these checks doesn't change the driver's behavior
in critical map/unmap paths. Hence, there is no functionality or
performance impact, especially since commit <29b32839725f> ("iommu/vt-d:
Do not use flush-queue when caching-mode is on") has already disabled
flush-queue for caching mode. Therefore, caching mode will never call
intel_flush_iotlb_all().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Change log:
v3:
 - It turned out that the removals don't change the driver's behavior,
   hence change it from a fix patch to a cleanup one.
 - No functionality changes.
v2: https://lore.kernel.org/lkml/20240410055823.264501-1-baolu.lu@linux.intel.com/
 - Squash two patches into a single one.
 - No functionality changes.
v1: https://lore.kernel.org/linux-iommu/20240407144232.190355-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a7ecd90303dc..f0a67e9d9faf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1501,11 +1501,7 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 	else
 		__iommu_flush_iotlb_psi(iommu, did, pfn, pages, ih);
 
-	/*
-	 * In caching mode, changes of pages from non-present to present require
-	 * flush. However, device IOTLB doesn't need to be flushed in this case.
-	 */
-	if (!cap_caching_mode(iommu->cap) || !map)
+	if (!map)
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
@@ -1579,8 +1575,7 @@ static void intel_flush_iotlb_all(struct iommu_domain *domain)
 			iommu->flush.flush_iotlb(iommu, did, 0, 0,
 						 DMA_TLB_DSI_FLUSH);
 
-		if (!cap_caching_mode(iommu->cap))
-			iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
+		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
 	}
 
 	if (dmar_domain->nested_parent)
-- 
2.34.1


