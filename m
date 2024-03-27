Return-Path: <linux-kernel+bounces-121905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6919B88EF35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6811C2DB00
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F8A152E1A;
	Wed, 27 Mar 2024 19:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L00S3sVV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E6152512;
	Wed, 27 Mar 2024 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567912; cv=none; b=rBvaP9H3CGwjSSLe7PG87vBs/LZV9Rt42JSFJEI5bUmAYjc021hkvZ1tUUvi+b5vmx+0Do7PDqGkxCmGvabbWUt2zIhTdR9WAQTG9/SoHQvB/pH2MQwP9KDb56sZfibcWRLJCEHv0vwwMEb+HPng7BJUDyXgHV9CUQYwzfHfJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567912; c=relaxed/simple;
	bh=kgE+EkgRK0Q0USsISvasAwmIHSRztSfu+eyxHqW1wf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWyfQbgvBFNysgwWvUE0/wTCVk3Xp4rS0aPj3M5gl2vsp7Lbh8h4+Ttzi6EkwAYwf2upv3ABdUhe5grkzqYzOGaqbvU1APQAazT159toGg6BBvYVn2liDJQgUYuwCdXiwb036ATOK+AEMiLqueFWpbC1qnxyukTkKWY1iEyhNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L00S3sVV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711567910; x=1743103910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgE+EkgRK0Q0USsISvasAwmIHSRztSfu+eyxHqW1wf8=;
  b=L00S3sVVWJopznoQbRcqzrhQYccc4HWdYdZewy1mTdRkCXUg5huJQhxJ
   qqNS968DxxhLpt8UISEU1uyAq8YEWGxguvvRs9IGVzw2lHjSUK9WXM36A
   TQaHAYlR8SpUErvjsVCj/zBtPd2t2BVUxT0elU+LExcY7EclDPWY6+d7C
   cfRYHlykU364udNlk+de52K8r7CFPFA/tIsnxMCrI8UWCtWtXfvoDYqOh
   uvWoNQBl18kWNb42EcsU9To67O0byH1rJSMxworn0MJuurahkx6PKwxqz
   FqkvPxMlX6A6OWvOk3vYgeqYgGDly7jZ5jDuRcKNjB8aP/faRzNhfHF30
   Q==;
X-CSE-ConnectionGUID: zSLnaNYvRPecEEcDIYUMwQ==
X-CSE-MsgGUID: uIC2wkuYQCuRdTWjEWhsog==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="24187304"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="24187304"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 12:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="937075026"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="937075026"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Mar 2024 12:31:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 982124F6; Wed, 27 Mar 2024 21:31:42 +0200 (EET)
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
Subject: [PATCH v2 2/9] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Date: Wed, 27 Mar 2024 21:29:21 +0200
Message-ID: <20240327193138.2385910-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
References: <20240327193138.2385910-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop rather useless use of ACPI_PTR() and of_match_ptr().
It also removes the necessity to be dependent of.h inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1d43346b4436..75d208087748 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
@@ -1725,7 +1724,6 @@ static const struct dev_pm_ops pxa2xx_spi_pm_ops = {
 	RUNTIME_PM_OPS(pxa2xx_spi_runtime_suspend, pxa2xx_spi_runtime_resume, NULL)
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{ "80860F0E", LPSS_BYT_SSP },
 	{ "8086228E", LPSS_BSW_SSP },
@@ -1736,9 +1734,8 @@ static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
-#endif
 
-static const struct of_device_id pxa2xx_spi_of_match[] __maybe_unused = {
+static const struct of_device_id pxa2xx_spi_of_match[] = {
 	{ .compatible = "marvell,mmp2-ssp", .data = (void *)MMP2_SSP },
 	{}
 };
@@ -1748,8 +1745,8 @@ static struct platform_driver driver = {
 	.driver = {
 		.name	= "pxa2xx-spi",
 		.pm	= pm_ptr(&pxa2xx_spi_pm_ops),
-		.acpi_match_table = ACPI_PTR(pxa2xx_spi_acpi_match),
-		.of_match_table = of_match_ptr(pxa2xx_spi_of_match),
+		.acpi_match_table = pxa2xx_spi_acpi_match,
+		.of_match_table = pxa2xx_spi_of_match,
 	},
 	.probe = pxa2xx_spi_probe,
 	.remove_new = pxa2xx_spi_remove,
-- 
2.43.0.rc1.1.gbec44491f096


