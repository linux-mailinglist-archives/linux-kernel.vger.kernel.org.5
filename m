Return-Path: <linux-kernel+bounces-134526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C009189B289
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037951C20EDA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA4241E7;
	Sun,  7 Apr 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1wJ8IVA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B3381BA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712501024; cv=none; b=X5sv29i/ZgDvGixAK0XI8G9gWvY5T7Mec65/EKnQDjJA5QQ6/olOI5wIpjzGeHh5kiPPPTGXkkc4zIAj7KxyHTbUFuAifTL77lrsMiF1so71hYLPNCT9F6RUFtcVtiU94qwVZc2lkwzCx0UvwvD/Qu/GFEluWFVrWQRghtGvxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712501024; c=relaxed/simple;
	bh=0mfpprZXYGxKzZyNx4TVkJXtwvzmtLRy2Ftcxt1I2yY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N34qS2aCFtIXqvBVqtrt1Ah/VPTRK4R+8nwZD4MkfgmScZBM9n9v5pSLQh4oy1phFLuwvrPWWq+yfxdUPnS6ga47bic1w5l404yzgBYPAoBoRBtciYpBM7cTmXnT37SgSVlfegKUspdX5eY/LWRMBqDHQbRIABgC0xLOFhMDZL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1wJ8IVA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712501022; x=1744037022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0mfpprZXYGxKzZyNx4TVkJXtwvzmtLRy2Ftcxt1I2yY=;
  b=m1wJ8IVAiA5zHCHzJg35ZF/ONcoGULD+KTVseOgGCJSqNl1JM1D81aF1
   faeGBzc90oG/Z0iLW1MTfKtIEobRUpaJrEgqMwg1PoU8NEHEBuWVuFEOb
   0afkYuv1Gd8EpSXPc3bz7jtZT+JuCzPSklnzqF8eFxb9QAQmOhR8CV3gi
   j1LsQjnZ9CTKQhK5deh0EbWCl5DYPAg8prsv8ayIaPbXhiKyL+dM8EQ7P
   OFalxfAjUbHYynbNT9/ZynGHl6zl12pFtCPOzbaDU5glwDF7bBHnyw+Cy
   pxc0mwOwNTvsSs2pfkt+yl2nNIEZ7jJ5hSOLrpxmq4ZMhBm5WAfi5USoy
   Q==;
X-CSE-ConnectionGUID: wcyKNzpuR1uX1/9VQ9Y0AQ==
X-CSE-MsgGUID: 8tAWA/4fRnWlGI/4h36MYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="11607278"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="11607278"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 07:43:42 -0700
X-CSE-ConnectionGUID: rXfPtQCcRI6idTnFo9xCqA==
X-CSE-MsgGUID: wsx/XXD/STqif26NWWu56A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="57102676"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 07 Apr 2024 07:43:39 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Avoid unnecessary device TLB flush in map path
Date: Sun,  7 Apr 2024 22:42:31 +0800
Message-Id: <20240407144232.190355-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_flush_iotlb_psi() is called in map and unmap paths. The caching
mode check before device TLB invalidation will cause device TLB
invalidation always issued if IOMMU is not running in the caching mode.
This is inefficient and causes performance overhead.

Make device TLB invalidation behavior consistent between batched mode
unmapping and strict mode unmapping. Device TLB invalidation should only
be requested in the unmap path if the IOMMU is not in caching mode.

Fixes: bf92df30df90 ("intel-iommu: Only avoid flushing device IOTLB for domain ID 0 in caching mode")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50eb9aed47cc..493b6a600394 100644
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
+	if (!cap_caching_mode(iommu->cap) && !map)
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
-- 
2.34.1


