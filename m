Return-Path: <linux-kernel+bounces-148369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBD8A8196
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305B41F235F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8599113D525;
	Wed, 17 Apr 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gvw/aL19"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8FC13C9A7;
	Wed, 17 Apr 2024 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351830; cv=none; b=aNb75KDib6yqTPlg5rrqRz0do2oDt5HyJvVbc6uJCRT+1mp2AwoDhqvSjbDMYXDVgZnMyzOXFRSIVMBvUUWT/hvozT7z3SjfkEct1bac/Bz68ntFAgf80JA3yKRe6NVDJbkbuCAtQplMjFSnu/mAnCI3u8Aq7LwvTEKnvbOwdGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351830; c=relaxed/simple;
	bh=fcw6oS8bqcoF1z0F8TEGeK5SgUH/8wJTF4cXw541tEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY0n6hXOUfszI1DljZ2zIJz7qY/uYmhcZd4gv0M1kyLQyQmw3NMvoLZ21nH33yfAmNfd0DsNq2fE0Xu+uHj/rcz28dkGtZ/b6RM+3D80BDQ+nq0p/KPSVXHm6nxG4I+eR729nBHbPIGW1jzWW+mhdrOr2pL2XONmD0kS2fxfcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gvw/aL19; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351828; x=1744887828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fcw6oS8bqcoF1z0F8TEGeK5SgUH/8wJTF4cXw541tEA=;
  b=Gvw/aL19O5d0SiAL8DNuKPtVOpXmYCCsTjRGLfe9m4Fy80OLuFqHlb6d
   l4eewbrCX6JwK9kr73CapFozocFexZJhRp4O4salCzTCYhNupYptO5GkU
   Cwdyw2Wz6CgG9AkEzdZHIGtOlovnmvJVD6UVJW63ae9RYTBqwtnTLSzGE
   6sR/kgqmNo9obeKtVN5noIpgGjA2dStXe+udiNeYJUbW11t9hEaqpfT9t
   DWbGEff35Ob2r55i3b6ZGKa/Iuo9OWl+O5PQ+hsWWFkh9BWSS2uSnj8E5
   F+m7GtLthMOCRl4xpfR6gj/nFwoEfZ8i+KGXgpK974X0vP9jKl/VSdHH4
   w==;
X-CSE-ConnectionGUID: syA/YU2ZQWaHSrscTyPOMQ==
X-CSE-MsgGUID: Irn530xkSd6KKT5U6EWQqg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8698158"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8698158"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 04:03:43 -0700
X-CSE-ConnectionGUID: NiOePWkJTmar9IgsX+1sIA==
X-CSE-MsgGUID: mrw5q278QeaT6K1T2BscNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22653279"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2024 04:03:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9C647F69; Wed, 17 Apr 2024 14:03:36 +0300 (EEST)
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
Subject: [PATCH v3 6/9] spi: pxa2xx: Drop struct pxa2xx_spi_chip
Date: Wed, 17 Apr 2024 13:54:33 +0300
Message-ID: <20240417110334.2671228-7-andriy.shevchenko@linux.intel.com>
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

No more users.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c |  9 ++-------
 drivers/spi/spi-pxa2xx.c     | 25 -------------------------
 drivers/spi/spi-pxa2xx.h     | 14 --------------
 3 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 751cb0f77b62..d77279c3acd8 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -231,16 +231,11 @@ int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 					   u8 bits_per_word, u32 *burst_code,
 					   u32 *threshold)
 {
-	struct pxa2xx_spi_chip *chip_info = spi->controller_data;
 	struct driver_data *drv_data = spi_controller_get_devdata(spi->controller);
 	u32 dma_burst_size = drv_data->controller_info->dma_burst_size;
 
-	/*
-	 * If the DMA burst size is given in chip_info we use that,
-	 * otherwise we use the default. Also we use the default FIFO
-	 * thresholds for now.
-	 */
-	*burst_code = chip_info ? chip_info->dma_burst_size : dma_burst_size;
+	/* We use the default the DMA burst size and FIFO thresholds for now */
+	*burst_code = dma_burst_size;
 	*threshold = SSCR1_RxTresh(RX_THRESH_DFLT)
 		   | SSCR1_TxTresh(TX_THRESH_DFLT);
 
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index cc0e54f8d2c3..00aa33c937bf 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1154,7 +1154,6 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_controller *controller)
 
 static int setup(struct spi_device *spi)
 {
-	struct pxa2xx_spi_chip *chip_info;
 	struct chip_data *chip;
 	const struct lpss_config *config;
 	struct driver_data *drv_data =
@@ -1218,25 +1217,6 @@ static int setup(struct spi_device *spi)
 		chip->timeout = TIMOUT_DFLT;
 	}
 
-	/*
-	 * Protocol drivers may change the chip settings, so...
-	 * if chip_info exists, use it.
-	 */
-	chip_info = spi->controller_data;
-
-	/* chip_info isn't always needed */
-	if (chip_info) {
-		if (chip_info->timeout)
-			chip->timeout = chip_info->timeout;
-		if (chip_info->tx_threshold)
-			tx_thres = chip_info->tx_threshold;
-		if (chip_info->tx_hi_threshold)
-			tx_hi_thres = chip_info->tx_hi_threshold;
-		if (chip_info->rx_threshold)
-			rx_thres = chip_info->rx_threshold;
-		chip->dma_threshold = 0;
-	}
-
 	chip->cr1 = 0;
 	if (spi_controller_is_target(drv_data->controller)) {
 		chip->cr1 |= SSCR1_SCFR;
@@ -1256,11 +1236,6 @@ static int setup(struct spi_device *spi)
 		chip->lpss_tx_threshold = tx_thres;
 	}
 
-	/*
-	 * Set DMA burst and threshold outside of chip_info path so that if
-	 * chip_info goes away after setting chip->enable_dma, the burst and
-	 * threshold can still respond to changes in bits_per_word.
-	 */
 	if (chip->enable_dma) {
 		/* Set up legal burst and threshold for DMA */
 		if (pxa2xx_spi_set_dma_burst_and_threshold(chip, spi,
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index f1097c96c50f..ae9c99bc9f6c 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -35,20 +35,6 @@ struct pxa2xx_spi_controller {
 	struct ssp_device ssp;
 };
 
-/*
- * The controller specific data for SPI target devices
- * (resides in spi_board_info.controller_data),
- * copied to spi_device.platform_data ... mostly for
- * DMA tuning.
- */
-struct pxa2xx_spi_chip {
-	u8 tx_threshold;
-	u8 tx_hi_threshold;
-	u8 rx_threshold;
-	u8 dma_burst_size;
-	u32 timeout;
-};
-
 struct spi_controller;
 struct spi_device;
 struct spi_transfer;
-- 
2.43.0.rc1.1336.g36b5255a03ac


