Return-Path: <linux-kernel+bounces-148370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3708A8199
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E33B21353
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480CA13DBB7;
	Wed, 17 Apr 2024 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0sZTOY1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8D913C8E6;
	Wed, 17 Apr 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351831; cv=none; b=btGUqtXXjL7MZL5Pj3nDfaolTFNd+WpmmEMU38pk3u3V//o9ceS45Tv2zlqDJ/2DLu2UZ02SuIM9Hg8lt+mBRyW6IvII/SZciyLQEZdLnQ6N2yv2HEv5Y9QsyZeMoxeYnLe0jl+tm1x+kjLE2J3Wnl94cnSxuoqbveCGtEDw3HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351831; c=relaxed/simple;
	bh=7sawocPjOagJUQ2+8wxEYpmTin9d1vFp3+a7/mwIYfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G62PIwtNb1LARIY0SgQ8yYokkfpEXlO9PfljIj6CpvcU+uCPUM88K3FXAWi8fxbcpWlJqlW+LBFcQYuleQgIJf+3mTlkKqNB0P8YA4czf/6medY4vRfL8ZqqtyRnzo829ncEmtFxFxUilR2UqNr3HQolqSjVTzJzFO2dzBkVpMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0sZTOY1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351827; x=1744887827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7sawocPjOagJUQ2+8wxEYpmTin9d1vFp3+a7/mwIYfc=;
  b=C0sZTOY1/JUvfgi8bASZRU/le36jk/j5mQBG7xYNl0T0u5nBY0kPJlCD
   bx4zFMbM9NGBvlCnHt57RUx30VZfiuLe1rvjMeHqIqEI/QRKxEMkoVo8Z
   g+sgDffq5HiztoPQ45ad0/ePziqWV7KGiHGXJAN524jzeP8SZMh1zfsbD
   hUdiORayR9rGBRC4+h0w21vQZa179LqNeArXL+CDYrgr4p+Ocbmbq7v+D
   5PGF72zZVyFtUyvBXVtniJjmD8Ir2s8CBZ2PiM40elV7iRyVPJH9xnLOj
   QZRQK4y1lStk6xF0kONPPqk0UOYkOqu8NU79m7QpDy0mvB+o3dWrvlhtl
   g==;
X-CSE-ConnectionGUID: ShePTBwfTkq+WEW0Sf4lqw==
X-CSE-MsgGUID: kmEtQreqRSyVtQjTcOboOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8698134"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8698134"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:03:40 -0700
X-CSE-ConnectionGUID: p/Zrm9xVRU21uEXEaLnLUA==
X-CSE-MsgGUID: RTEU5jY+TESOsi2V5D/y/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27380696"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2024 04:03:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 655EDBCD; Wed, 17 Apr 2024 14:03:36 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 2/9] spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
Date: Wed, 17 Apr 2024 13:54:29 +0300
Message-ID: <20240417110334.2671228-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since driver can parse num-cs device property, replace platform data
with this new approach. This pursues the following objectives:

- getting rid of the public header that barely used outside of
  the SPI subsystem (more specifically the SPI PXA2xx drivers)

- making a trampoline for the driver to support non-default number
  of the chip select pins in case the original code is going to be
  converted to Device Tree model

It's not expected to have more users in board files except this one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/arm/mach-pxa/spitz.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 318402ad685e..3c5f5a3cb480 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -18,10 +18,10 @@
 #include <linux/i2c.h>
 #include <linux/platform_data/i2c-pxa.h>
 #include <linux/platform_data/pca953x.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/corgi_lcd.h>
-#include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input-event-codes.h>
@@ -569,10 +569,6 @@ static struct spi_board_info spitz_spi_devices[] = {
 	},
 };
 
-static struct pxa2xx_spi_controller spitz_spi_info = {
-	.num_chipselect	= 3,
-};
-
 static struct gpiod_lookup_table spitz_spi_gpio_table = {
 	.dev_id = "spi2",
 	.table = {
@@ -583,10 +579,20 @@ static struct gpiod_lookup_table spitz_spi_gpio_table = {
 	},
 };
 
+static const struct property_entry spitz_spi_properties[] = {
+	PROPERTY_ENTRY_U32("num-cs", 3),
+	{ }
+};
+
+static const struct software_node spitz_spi_node = {
+	.properties = spitz_spi_properties,
+};
+
 static void __init spitz_spi_init(void)
 {
 	struct platform_device *pd;
 	int id = 2;
+	int err;
 
 	if (machine_is_akita())
 		gpiod_add_lookup_table(&akita_lcdcon_gpio_table);
@@ -601,8 +607,13 @@ static void __init spitz_spi_init(void)
 	if (pd == NULL) {
 		pr_err("pxa2xx-spi: failed to allocate device id %d\n", id);
 	} else {
-		pd->dev.platform_data = &spitz_spi_info;
-		platform_device_add(pd);
+		err = device_add_software_node(&pd->dev, &spitz_spi_node);
+		if (err) {
+			platform_device_put(pd);
+			pr_err("pxa2xx-spi: failed to add software node\n");
+		} else {
+			platform_device_add(pd);
+		}
 	}
 
 	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
-- 
2.43.0.rc1.1336.g36b5255a03ac


