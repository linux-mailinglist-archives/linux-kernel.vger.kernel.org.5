Return-Path: <linux-kernel+bounces-137820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C06A89E807
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2627B22DFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10BA1095A;
	Wed, 10 Apr 2024 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSoVpZdJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C72C157
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712715014; cv=none; b=aGQGWLxd1a8fUKCXmRDOkeSWDPgMKHRuOFb5JJSEXAWEEo9m9CP4sjbAfYJmHD8pqWGxJKkeeunpSjKvRCXmZ8wndNzp2+HVqMA1VAh/5zSROyBbmJGmy0Um7bpBR8zvJitIVX+p2cfcDRTuejRsfiBIaUwieieQn1heg8uR4GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712715014; c=relaxed/simple;
	bh=P2L4NEAsMbZ06PB/7yZB1CdCqGYXQUk6ORyaaOMFzZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtmLEDtZ+g6klZktm6fwJRRJhjpeEcmO5mrs70zagRj9lNiWPCj3GFiw7FkZFF4RlCe4di1FOPB2mXzUOWJj/pnn/UAyB5H21B+jn5Ialrfzn1UIHiyjpOh3jlLIqgXommCBqt613bVxBGFhQQhqGOC4ejt0oONAA69GZVDObyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSoVpZdJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712715013; x=1744251013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2L4NEAsMbZ06PB/7yZB1CdCqGYXQUk6ORyaaOMFzZM=;
  b=SSoVpZdJxdxhl4OBey3vt7vKjrWu8oQCOsBzBEQ+zANfN2LG3ZlipHCh
   ua5hm3wkFdcG6iP31+IKXqHBk13jK5FbY5PZFvOFCrQv0fV4usZ5I9/sJ
   mc3W56qj6a77ypPp4Bv8W2+SI8HFpZszpZxDwK3ImxmQE0lo5PO3SxCAi
   TOSZ2FeJjxX+sly7az5n9n8V+SR3OCclAT5ytFPCBLPnI37mpMXWM4jE4
   l+zgDMBGQFtsMHoSYqI5CIlf6KSDJo/dk8V0l8UzRFU5HwaalD2cFgpaz
   wGua00jx/4G1/f9pBu2yfo1x9xYo3UeO7vmKyeiDugMyWdh9prFdx6/Y4
   w==;
X-CSE-ConnectionGUID: ByF9A2+cT/K4MTfuP+d50w==
X-CSE-MsgGUID: JOvUIH+bSpmzSpLwdiNBvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7918562"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7918562"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 19:10:13 -0700
X-CSE-ConnectionGUID: OOjbAe5lR+KiwsAFuPf28Q==
X-CSE-MsgGUID: en0+Aw15RKCzc3lcG3ZwpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20478895"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 19:10:10 -0700
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
Subject: [PATCH v2 04/12] iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_all
Date: Wed, 10 Apr 2024 10:08:36 +0800
Message-Id: <20240410020844.253535-5-baolu.lu@linux.intel.com>
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

The flush_iotlb_all callback is called by the iommu core to flush
all caches for the affected domain. Use cache_tag_flush_all() in
this callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4572624a275e..2af3e6f54af0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1556,25 +1556,7 @@ static void parent_domain_flush(struct dmar_domain *domain,
 
 static void intel_flush_iotlb_all(struct iommu_domain *domain)
 {
-	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
-	struct iommu_domain_info *info;
-	unsigned long idx;
-
-	xa_for_each(&dmar_domain->iommu_array, idx, info) {
-		struct intel_iommu *iommu = info->iommu;
-		u16 did = domain_id_iommu(dmar_domain, iommu);
-
-		if (dmar_domain->use_first_level)
-			domain_flush_pasid_iotlb(iommu, dmar_domain, 0, -1, 0);
-		else
-			iommu->flush.flush_iotlb(iommu, did, 0, 0,
-						 DMA_TLB_DSI_FLUSH);
-
-		iommu_flush_dev_iotlb(dmar_domain, 0, MAX_AGAW_PFN_WIDTH);
-	}
-
-	if (dmar_domain->nested_parent)
-		parent_domain_flush(dmar_domain, 0, -1, 0);
+	cache_tag_flush_all(to_dmar_domain(domain));
 }
 
 static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
-- 
2.34.1


