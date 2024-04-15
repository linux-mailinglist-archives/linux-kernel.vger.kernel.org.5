Return-Path: <linux-kernel+bounces-145342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966558A5320
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44A9A288585
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017DA763F9;
	Mon, 15 Apr 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyaVSFte"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5555763EC;
	Mon, 15 Apr 2024 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191078; cv=none; b=T8T1/2EHFImBoYzsh07tcYVEOFQzvMHhRgY9pkyEa9ilYL2hNTBmUDH3mrFru2i0D/kC5RvzHpAXzztMzJXWhB+4lzNOr+Dl4Dd/U98ifH60KO/Vv3weF+LZpakC4fi/gZdClqvVvtdRz+ug2RRSXLySHUx4pRojuDRNhvevXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191078; c=relaxed/simple;
	bh=xViPbkcrpJ9Mo16ZFL1goExXuNn9JNt4X6XivxBzM2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUcan6avRC4g6BnBO/LXmisFcZQt7tZxQdp2I7me+c6p73YqvJ88fbsLXuzTqhp01LFS6sIvbvUyWhmKBktR4XK5GeeX034cC2yIQiyxqEt5gcNdK7G08dJ07VcIu43uqNTnDWR2aScduKlydwya0Mzb+mtgTQTqoQ6CiO6xxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyaVSFte; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713191077; x=1744727077;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xViPbkcrpJ9Mo16ZFL1goExXuNn9JNt4X6XivxBzM2U=;
  b=kyaVSFte6pCxrxrx/rpGhgVA7OpxBjURZa94rbkH7eYIFSnYjeaRanVd
   GBR006zQFCf84rAFYY1JDnjS6yL+3mFA/DjnBXO1Tz7Wfuyg5tXx1BJn0
   6DkP92iQA2Jb/FfknZ7Rbvom46EkrMbFLJMF+b/HB4dSDERClocsI6A65
   ev0rrYmV6k2H6KjQ0vtx3WNifzmJypH7OY392z9uMnqShbks6MEVNjD2o
   VpKPRclCIq52MY6zr6F6i8YZHZQR4dWbuCTYXmR/cRUgEPevT994h5RFy
   DjzGlxlPvCBv1WKUhNqipGrgfX18Gjee6RZDW3oThw3lc1LIPHK9nq1HM
   A==;
X-CSE-ConnectionGUID: vvldl1pwQICLiRsKDU6LCg==
X-CSE-MsgGUID: wdhyY+NKTfKPsDdhuHryuQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8803392"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8803392"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 07:24:36 -0700
X-CSE-ConnectionGUID: EQ8qXC1uT/iwWVQx6suetg==
X-CSE-MsgGUID: otTrRRBXSuGZxFXVw8e52w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22356716"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 15 Apr 2024 07:24:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 510BA455; Mon, 15 Apr 2024 17:24:32 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] fpga: ice40-spi: Don't use "proxy" headers
Date: Mon, 15 Apr 2024 17:23:28 +0300
Message-ID: <20240415142428.853812-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

This is a replacement of previously sent:
fpga: ice40-spi: Remove unused of_gpio.h
fpga: ice40-spi: Remove redundant of_match_ptr() macros

 drivers/fpga/ice40-spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index c0028ae4c5b7..62c30266130d 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -10,8 +10,8 @@
 
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/stringify.h>
 
@@ -199,7 +199,7 @@ static struct spi_driver ice40_fpga_driver = {
 	.probe = ice40_fpga_probe,
 	.driver = {
 		.name = "ice40spi",
-		.of_match_table = of_match_ptr(ice40_fpga_of_match),
+		.of_match_table = ice40_fpga_of_match,
 	},
 	.id_table = ice40_fpga_spi_ids,
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


