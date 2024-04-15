Return-Path: <linux-kernel+bounces-146028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1008A5F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EBA1C20C19
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8F159591;
	Mon, 15 Apr 2024 23:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyYoVsYR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2C2E852;
	Mon, 15 Apr 2024 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225585; cv=none; b=DcNjjGrmQI/fKvBAB0qbMFaFWP6JwjM+H/S5M0pi5NrrcUVFXUFBP5idQ5faof/vuMgW3M1/sDClKQiuUVGbztrPqpEJ9EepIuB89/+muv0WAAHXoSMmfHFavNXpB4hJoxObDa6/32HkUqA+dfH2qHzLkhYb9S58MKGZBoFWhgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225585; c=relaxed/simple;
	bh=36JuRh2SKJHz16dUv8FbsOpHOCrNvhZxRz+zZwnKxvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fibk73xABc4GAupYYHXUSVlprQoFxn/liW65B6jmnjvWChBqwSvKWHv/K1NtuRqR2pHRJujarFYPUDPvlLuYjHCVYykaAVMrHHTTKxlZombFW8s5N3PNMaL7uD98f1DVNV4FEOfNeH+WVur/nNHgLIHD3vU6truIF6Y1CPpRahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DyYoVsYR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713225583; x=1744761583;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=36JuRh2SKJHz16dUv8FbsOpHOCrNvhZxRz+zZwnKxvA=;
  b=DyYoVsYRSQxygrQOBA4cDmIyGfbGm/olLaqsBgVCprD03MJZyrkR4Cg+
   lVqUvJLWWVtfr5065DHMt128RLhqqEAjKDlE4YPP12vhe1NC6xRtAp/iF
   EoQ3I5yZCRCNZFgNg74rriLPumBusVBBJmYooKtiV3/DEiUWqKxesuVn7
   atkPXryud7ZjOZs5JdK77BUUoptXO6AQB2i/Q3PszAOWHCUbrDHLvqj9G
   E8xt3wik+bjbljx2pOlRowiNNWKFDtDjhm/A84ksapJt83vMpV6f3mvu+
   9meWVboocr7Ki99DEnWOX7d9XNVWF5I+BneTRU9nyJiCHkmzD3quEHcCE
   g==;
X-CSE-ConnectionGUID: 7YVqgIntTA6+xEuz0wy9rg==
X-CSE-MsgGUID: 7YIGk6mhQbGqHQwfSq8wiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="11586062"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="11586062"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 16:59:42 -0700
X-CSE-ConnectionGUID: FE026Qz6RGqYEqgpFVJXAw==
X-CSE-MsgGUID: n0ghJefRTfikI2gS7WPn7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="26861109"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 16:59:42 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v3] fpga: dfl: remove unused member pdata from struct dfl_{afu,fme}
Date: Mon, 15 Apr 2024 19:59:37 -0400
Message-ID: <20240415235937.3121-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The member pdata in struct dfl_{afu,fme} is set in function
{afu,fme}_dev_init(), respectively, but never used.

Fixes: 857a26222ff7 ("fpga: dfl: afu: add afu sub feature support")
Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3:
- Do not wrap commit references and move to Fixes: tags.
v2:
- Remove unused member pdata from struct dfl_fme, too.
---
 drivers/fpga/dfl-afu-main.c | 2 --
 drivers/fpga/dfl-afu.h      | 3 ---
 drivers/fpga/dfl-fme-main.c | 2 --
 drivers/fpga/dfl-fme.h      | 2 --
 4 files changed, 9 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index c0a75ca360d6..6b97c073849e 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -858,8 +858,6 @@ static int afu_dev_init(struct platform_device *pdev)
 	if (!afu)
 		return -ENOMEM;
 
-	afu->pdata = pdata;
-
 	mutex_lock(&pdata->lock);
 	dfl_fpga_pdata_set_private(pdata, afu);
 	afu_mmio_region_init(pdata);
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 674e9772f0ea..7bef3e300aa2 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -67,7 +67,6 @@ struct dfl_afu_dma_region {
  * @regions: the mmio region linked list of this afu feature device.
  * @dma_regions: root of dma regions rb tree.
  * @num_umsgs: num of umsgs.
- * @pdata: afu platform device's pdata.
  */
 struct dfl_afu {
 	u64 region_cur_offset;
@@ -75,8 +74,6 @@ struct dfl_afu {
 	u8 num_umsgs;
 	struct list_head regions;
 	struct rb_root dma_regions;
-
-	struct dfl_feature_platform_data *pdata;
 };
 
 /* hold pdata->lock when call __afu_port_enable/disable */
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index a2b5da0093da..864924f68f5e 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -679,8 +679,6 @@ static int fme_dev_init(struct platform_device *pdev)
 	if (!fme)
 		return -ENOMEM;
 
-	fme->pdata = pdata;
-
 	mutex_lock(&pdata->lock);
 	dfl_fpga_pdata_set_private(pdata, fme);
 	mutex_unlock(&pdata->lock);
diff --git a/drivers/fpga/dfl-fme.h b/drivers/fpga/dfl-fme.h
index 4195dd68193e..a566dbc2b485 100644
--- a/drivers/fpga/dfl-fme.h
+++ b/drivers/fpga/dfl-fme.h
@@ -24,13 +24,11 @@
  * @mgr: FME's FPGA manager platform device.
  * @region_list: linked list of FME's FPGA regions.
  * @bridge_list: linked list of FME's FPGA bridges.
- * @pdata: fme platform device's pdata.
  */
 struct dfl_fme {
 	struct platform_device *mgr;
 	struct list_head region_list;
 	struct list_head bridge_list;
-	struct dfl_feature_platform_data *pdata;
 };
 
 extern const struct dfl_feature_ops fme_pr_mgmt_ops;
-- 
2.44.0


