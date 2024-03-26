Return-Path: <linux-kernel+bounces-119659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8825C88CBAC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256C91F84211
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9681272BD;
	Tue, 26 Mar 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUIQxt75"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4C8527A;
	Tue, 26 Mar 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476643; cv=none; b=OI4K9oHpotP1FHtYswi78IxnEeW9s3IRkDAqsXvYTNMsjGqgibBaOstZvGbRD3ereG3ZS5J2puMRZX0xZU9ej9vT7IZIPAfNKiubsf/re9PQSinLGpWBqVkMyEsz36xXOBA6wHPVNW7w80y8u7kGoDaGgDDY6FhWpx9gaVE/Ce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476643; c=relaxed/simple;
	bh=Oh3MUbUj1XxFveo7rtHk0ivojd56U90Z0wqM4ju1lRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4YOzmjpwI+6amm+32dR/vL9QTb8U3wfNtZGQXqmm7l9sr7C9IiHT2OnawnEvkrMlZDAzy25yCMVx44fo/HfWPWiVD1LqYF68uIFenhXy1eMj9WTcDs8z47eCoA/K2say/RRmu1hRUq1uGbeyxl0RJddLb3bsHyGaDGNe6MhJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUIQxt75; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476641; x=1743012641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oh3MUbUj1XxFveo7rtHk0ivojd56U90Z0wqM4ju1lRM=;
  b=dUIQxt75uZSrD5IDlFZagD1OUOuoGcj7x2zv2WvCfk+Cdjh/pexUZ/6y
   oQsUKaQaNaKSHHlXhmRICuQOZJSTBsxOhoyC7Zp1HHsQc0w83WP6u8Nen
   T8gZ//D4QSVHZyJT4TS0ztYhuNgxXE/t+SUIRJzA4YV5cbq3mFKWLXw9S
   nS9UX8Btoe688TaUN4xWeP7mkAQYJw2vRAa4layQocNL0IQ8d7PLyBh6B
   uBWBxLqlnhltg2Q1Oh71HLWkFPC+UrSGUUJi2vws3sOLaxX/40lBca3tq
   ISgBfDd1IMG6DFo2WNern3nttTcy4/NAKCgB2OxzsR01GPwjQrGI2TAgW
   g==;
X-CSE-ConnectionGUID: UNYDaGnBRSGpMTj8mNcifQ==
X-CSE-MsgGUID: J56FEiQqTUCFRjiICENRcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325675"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325675"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072938"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072938"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E35AA2CA; Tue, 26 Mar 2024 20:10:34 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 03/10] spi: pxa2xx: Switch to use dev_err_probe()
Date: Tue, 26 Mar 2024 20:07:53 +0200
Message-ID: <20240326181027.1418989-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to use dev_err_probe() to simplify the error path and
unify a message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 2c39d3ff498e..75d208087748 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1434,20 +1434,16 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	platform_info = dev_get_platdata(dev);
 	if (!platform_info) {
 		platform_info = pxa2xx_spi_init_pdata(pdev);
-		if (IS_ERR(platform_info)) {
-			dev_err(&pdev->dev, "missing platform data\n");
-			return PTR_ERR(platform_info);
-		}
+		if (IS_ERR(platform_info))
+			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform data\n");
 	}
 
 	ssp = pxa_ssp_request(pdev->id, pdev->name);
 	if (!ssp)
 		ssp = &platform_info->ssp;
 
-	if (!ssp->mmio_base) {
-		dev_err(&pdev->dev, "failed to get SSP\n");
-		return -ENODEV;
-	}
+	if (!ssp->mmio_base)
+		return dev_err_probe(dev, -ENODEV, "failed to get SSP\n");
 
 	if (platform_info->is_target)
 		controller = devm_spi_alloc_target(dev, sizeof(*drv_data));
@@ -1455,8 +1451,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		controller = devm_spi_alloc_host(dev, sizeof(*drv_data));
 
 	if (!controller) {
-		dev_err(&pdev->dev, "cannot alloc spi_controller\n");
-		status = -ENOMEM;
+		status = dev_err_probe(dev, -ENOMEM, "cannot alloc spi_controller\n");
 		goto out_error_controller_alloc;
 	}
 	drv_data = spi_controller_get_devdata(controller);
@@ -1510,7 +1505,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	status = request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
 			drv_data);
 	if (status < 0) {
-		dev_err(&pdev->dev, "cannot get IRQ %d\n", ssp->irq);
+		dev_err_probe(dev, status, "cannot get IRQ %d\n", ssp->irq);
 		goto out_error_controller_alloc;
 	}
 
@@ -1626,7 +1621,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, drv_data);
 	status = spi_register_controller(controller);
 	if (status) {
-		dev_err(&pdev->dev, "problem registering SPI controller\n");
+		dev_err_probe(dev, status, "problem registering SPI controller\n");
 		goto out_error_pm_runtime_enabled;
 	}
 
-- 
2.43.0.rc1.1.gbec44491f096


