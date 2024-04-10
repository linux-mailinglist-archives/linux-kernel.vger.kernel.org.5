Return-Path: <linux-kernel+bounces-137953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D583C89EA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048311C22177
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFB126291;
	Wed, 10 Apr 2024 05:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUOuL9HG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14953224EA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712728781; cv=none; b=fu4MLmUm4Q1O7VNpl3lWK6Xq/5tuWb/Vp/B9tJslqQ6gfWEJTMgyj31Sc/KRSaj1WaUeYVh50NDnSJHQghdBiMnJLSLOchco+pnLQjJU/VmMBxAVWHGoNPwpmHJJ8dFfBguhkuoK1xf20vMBcj+T3rtHvpN1twP79qfPGqI7w+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712728781; c=relaxed/simple;
	bh=kVXQ4bZM5bQZSi1MhboTtlK1NNrbVfyTWUnzwaNNWio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U3jVQ1406QQDoAuBcqyscWwN+DOa5WjwAvNnkpgRyM3rDIHOBzlCbbzwKvmsDuID6lTWbtsiMyGpGGUy/E6ZjH8jUF/edKGD1MfFZCdH4LHlRFAtdAQurzYE0099PZ6TiGhs7wtgGSENC4I6JJDA1VOFZt7Iz9+F5FIpW8ITXjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUOuL9HG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712728780; x=1744264780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kVXQ4bZM5bQZSi1MhboTtlK1NNrbVfyTWUnzwaNNWio=;
  b=MUOuL9HGST2OetHbxLA59ISL13hfFq8q87lqg9XBhpveya3uMwZgp5YX
   UmgpxRMuBC7VPkmT0ecTdjUXCqcSoopSUQIjGqwVHDMj4CT7bcVKbMBsT
   8geMinZwoAzOLsrqT5BTgeuGBuCeZCMFQzQN3WsAdGHq7MnxhXDvt8SEf
   KDyAXWTifjZ+eA7oBLRImYaB8+gTBGYtpoh166HTvPIKh91BcNdNS7yvd
   vtzbSZUUHi7tcwSLTAuVDL/TqTYhD+auwVmtDOWHygWRd2os0Xa6MvWfZ
   uP2xHmei+zfU/pTyBzFySlmWb8y6CLGPWorsT6fkjWqTMJmGLT7lJcaVy
   Q==;
X-CSE-ConnectionGUID: ythGzPmCQN2MGfGzi5amUw==
X-CSE-MsgGUID: w7D9zFdbQMKiGimVgbzizg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11913099"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11913099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:59:39 -0700
X-CSE-ConnectionGUID: 1QT0hvkWQS6nzDJrsST11g==
X-CSE-MsgGUID: jxcDG/cfSMCtYiMQw+t4cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20516501"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 09 Apr 2024 22:59:38 -0700
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
Subject: [PATCH v2 1/1] iommu/vt-d: Remove caching mode check before device TLB flush
Date: Wed, 10 Apr 2024 13:58:23 +0800
Message-Id: <20240410055823.264501-1-baolu.lu@linux.intel.com>
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
entries except the first-stage translation. The caching mode is
irrelevant to the device TLB , therefore there is no need to check
it before a device TLB invalidation operation.

iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
mode check before device TLB invalidation will cause device TLB
invalidation always issued if IOMMU is not running in caching mode.
This is wrong and causes unnecessary performance overhead.

The removal of caching mode check in intel_flush_iotlb_all() doesn't
impact anything no matter the IOMMU is working in caching mode or not.
Commit <29b32839725f> ("iommu/vt-d: Do not use flush-queue when
caching-mode is on") has already disabled flush-queue for caching mode,
hence caching mode will never call intel_flush_iotlb_all().

Fixes: bf92df30df90 ("intel-iommu: Only avoid flushing device IOTLB for domain ID 0 in caching mode")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Change log:

v2:
 - Squash two patches into a single one.
 - No functionality changes.

v1: https://lore.kernel.org/linux-iommu/20240407144232.190355-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50eb9aed47cc..681789b1258d 100644
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


