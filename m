Return-Path: <linux-kernel+bounces-142992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F098A3300
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E2F1C20CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471D314901F;
	Fri, 12 Apr 2024 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mby8F6jc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CB14884C;
	Fri, 12 Apr 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937521; cv=none; b=OE4QTMc8bJ3etpmINNHKeZfJnMPLzsYoF7IDe022a+ISEES0WZJUBrHmiLQ7vyEyujTmIw8BsOhOvVWCtIe9383iuEnqlgU7yAehnbNbt3BgVaCd2nqz75EvkeL6uuDjYrDyT9/AQ1XRb2YKXZRaGsCmwdAG6gUNHGPfGfp2HCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937521; c=relaxed/simple;
	bh=uWba588n4UF9O6oCEqHQ/rQZoozxVX+XVJ77lMRZTzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oi7TEDSLJNeLxiqsRTIgDh1N1mBUy64OBQO148d5e6fHc90q5wpv8a1i+tgAltPL2xZk2+H3D5Knr066uUHV79C9XgtyPg/ssIA8dlhxm17CzBaQsQX2BBQUaFsh4ZyRpOulMd9kbJZunSt9xlqR52ud6yGh8OvRUhzOeJrd4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mby8F6jc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712937520; x=1744473520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uWba588n4UF9O6oCEqHQ/rQZoozxVX+XVJ77lMRZTzg=;
  b=Mby8F6jcFfvF+hnwg3MuRmEfbAiCpknie1VzbUZtSPOWyAPEqmLTOfQ0
   Xdld5rvfa2EyevpQTILXbMVI/svRkwATyY6HuUWmalfmXOy2uKmTn0Prc
   4c+VuYgxtjn2JtGIHNl/meycXcul7/jxrd9XSdtL8tavwKTgpaxYzaDIV
   ahMJ5lWVKOus12ovkV+PhYOlnDp7Br658jjelT2vMDkd6Fr9DtP7VL77u
   ax+qFklbls3PJAxV/Nj7qFVNS2zyORlJ/reAF5kB4ecs+Y1W3fg5nD6r4
   LHsulrim2BXqaMCYwrhpqW6sDEFJ8dCE9hexmEI2hDAr+aRW1y4qQ1ODz
   w==;
X-CSE-ConnectionGUID: phwb1nEqSeeRH4D9mDiBkw==
X-CSE-MsgGUID: ETwxBrKyQQKbILieWeSkhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8267137"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8267137"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 08:58:39 -0700
X-CSE-ConnectionGUID: vb7lRsB+SGma6h9FaBee4A==
X-CSE-MsgGUID: X8nCT/rBQHmfpd49t+pIzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21352506"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 12 Apr 2024 08:58:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BE135E7; Fri, 12 Apr 2024 18:58:35 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v1 1/1] fpga: ice40-spi: Remove redundant of_match_ptr() macros
Date: Fri, 12 Apr 2024 18:58:30 +0300
Message-ID: <20240412155830.96137-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the driver hi6421-regulator depends on CONFIG_OF,
it makes no difference to wrap of_match_ptr() here.

Remove of_match_ptr() macros to clean it up.

While at it, add missing mod_devicetable.h.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/r/20240412151147.22a059ff@canb.auug.org.au
Fixes: 5d04660b29fb ("fpga: ice40-spi: Remove unused of_gpio.h")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/fpga/ice40-spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 46927945f1b9..62c30266130d 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -10,6 +10,7 @@
 
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/stringify.h>
@@ -198,7 +199,7 @@ static struct spi_driver ice40_fpga_driver = {
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


