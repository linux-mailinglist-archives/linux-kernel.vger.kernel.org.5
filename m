Return-Path: <linux-kernel+bounces-130270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D7897624
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7F661C21031
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67F815359C;
	Wed,  3 Apr 2024 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8f7MHQG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67008152DEF;
	Wed,  3 Apr 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164561; cv=none; b=tbQNDWahFRTDkgWhEBDPJsoSITgDVTstNLpoJbvESFyFyHXb6GrtkLo0krhOFDxoTjVBryJUzc1JGw2zOLWMrXPSwpBvUe807OxEUT0jiKc8F4F9oVIE+YJCepsQe8ID/crzhYMkvb9MmWtMxyNnOOQq9IAcBPiSa6b6MHnC8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164561; c=relaxed/simple;
	bh=T8c7dxKGDR4IIIFl456ktFXws12USAZczZGdyZs7n5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8Z6Pyt5NUpBnTxTHliSzY7nhDeTtqh+vPGR4cq278F7wItCepxeZq8kUdrJJpJyzRJctuybZ7Jg1hJbO2Cd2E1+YU4L6+E4oaYcYXSudwlCkAEC3M/h7WrpFSQXjgcnjAAKwEO+obLf5cMSLFbN82ZrtIa17cpt8hpzzg/gVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8f7MHQG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712164560; x=1743700560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T8c7dxKGDR4IIIFl456ktFXws12USAZczZGdyZs7n5o=;
  b=l8f7MHQGl7NtKZFpUlvFUmss6xPwQRlB1mWVJZ8wH1MTgiEz5HfZweSh
   r0ZlMPbmPdXKpJ5B1Owu3rj3DGFFHnHUgsewsUI+GZfgN94qO58xSXztD
   DxN6eeWchyWGxeRAU4rOlBXhAcYKBKno3Yk9NaSp+8aigNFG41qVS4GIc
   GgmvUoyjw0uTb+1f4AzDXeP0gachqlGzuJW4vwBy6lEEehc1YCI50taHi
   j5s9ID8rCqhqHK8YqfsceM8zz7kfMCpZvfsknX+4TUbCQlOQiTjVCxO8n
   6tufCTvqY1xM4ib+EeE81Tad160Za/JBq6m/67yXlNeoazmKagNqxXS0i
   A==;
X-CSE-ConnectionGUID: BF05SrIeQN6L8wEgfjQxkg==
X-CSE-MsgGUID: 0iDCWQnKRme6YX19uPptZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18863556"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18863556"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 10:15:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937085338"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937085338"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 10:15:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AEAFF3E5; Wed,  3 Apr 2024 20:15:53 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/5] spi: pxa2xx: Remove DMA parameters from struct chip_data
Date: Wed,  3 Apr 2024 20:06:37 +0300
Message-ID: <20240403171550.1074644-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
References: <20240403171550.1074644-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA related fields are set once and never modified. It effectively
repeats the content of the same fields in struct pxa2xx_spi_controller.
With that, remove DMA parameters from struct chip_data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c | 22 ++------------------
 drivers/spi/spi-pxa2xx.c     | 40 +++++++-----------------------------
 drivers/spi/spi-pxa2xx.h     |  8 --------
 3 files changed, 9 insertions(+), 61 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index d77279c3acd8..08cb6e96ac94 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -68,8 +68,6 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 			   enum dma_transfer_direction dir,
 			   struct spi_transfer *xfer)
 {
-	struct chip_data *chip =
-		spi_get_ctldata(drv_data->controller->cur_msg->spi);
 	enum dma_slave_buswidth width;
 	struct dma_slave_config cfg;
 	struct dma_chan *chan;
@@ -94,14 +92,14 @@ pxa2xx_spi_dma_prepare_one(struct driver_data *drv_data,
 	if (dir == DMA_MEM_TO_DEV) {
 		cfg.dst_addr = drv_data->ssp->phys_base + SSDR;
 		cfg.dst_addr_width = width;
-		cfg.dst_maxburst = chip->dma_burst_size;
+		cfg.dst_maxburst = drv_data->controller_info->dma_burst_size;
 
 		sgt = &xfer->tx_sg;
 		chan = drv_data->controller->dma_tx;
 	} else {
 		cfg.src_addr = drv_data->ssp->phys_base + SSDR;
 		cfg.src_addr_width = width;
-		cfg.src_maxburst = chip->dma_burst_size;
+		cfg.src_maxburst = drv_data->controller_info->dma_burst_size;
 
 		sgt = &xfer->rx_sg;
 		chan = drv_data->controller->dma_rx;
@@ -225,19 +223,3 @@ void pxa2xx_spi_dma_release(struct driver_data *drv_data)
 		controller->dma_tx = NULL;
 	}
 }
-
-int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
-					   struct spi_device *spi,
-					   u8 bits_per_word, u32 *burst_code,
-					   u32 *threshold)
-{
-	struct driver_data *drv_data = spi_controller_get_devdata(spi->controller);
-	u32 dma_burst_size = drv_data->controller_info->dma_burst_size;
-
-	/* We use the default the DMA burst size and FIFO thresholds for now */
-	*burst_code = dma_burst_size;
-	*threshold = SSCR1_RxTresh(RX_THRESH_DFLT)
-		   | SSCR1_TxTresh(TX_THRESH_DFLT);
-
-	return 0;
-}
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 00aa33c937bf..3ba0f5816f7f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -934,11 +934,11 @@ static bool pxa2xx_spi_can_dma(struct spi_controller *controller,
 			       struct spi_device *spi,
 			       struct spi_transfer *xfer)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
+	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 
-	return chip->enable_dma &&
+	return drv_data->controller_info->enable_dma &&
 	       xfer->len <= MAX_DMA_LEN &&
-	       xfer->len >= chip->dma_burst_size;
+	       xfer->len >= drv_data->controller_info->dma_burst_size;
 }
 
 static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
@@ -947,9 +947,8 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 {
 	struct driver_data *drv_data = spi_controller_get_devdata(controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
-	u32 dma_thresh = chip->dma_threshold;
-	u32 dma_burst = chip->dma_burst_size;
 	u32 change_mask = pxa2xx_spi_get_ssrc1_change_mask(drv_data);
+	u32 dma_thresh;
 	u32 clk_div;
 	u8 bits;
 	u32 speed;
@@ -959,7 +958,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 	int dma_mapped;
 
 	/* Check if we can DMA this transfer */
-	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
+	if (transfer->len > MAX_DMA_LEN && drv_data->controller_info->enable_dma) {
 		/* Warn ... we force this to PIO mode */
 		dev_warn_ratelimited(&spi->dev,
 				     "DMA disabled for transfer length %u greater than %d\n",
@@ -995,19 +994,8 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *controller,
 		drv_data->read = drv_data->rx ? u32_reader : null_reader;
 		drv_data->write = drv_data->tx ? u32_writer : null_writer;
 	}
-	/*
-	 * If bits per word is changed in DMA mode, then must check
-	 * the thresholds and burst also.
-	 */
-	if (chip->enable_dma) {
-		if (pxa2xx_spi_set_dma_burst_and_threshold(chip,
-						spi,
-						bits, &dma_burst,
-						&dma_thresh))
-			dev_warn_ratelimited(&spi->dev,
-					     "DMA burst size reduced to match bits_per_word\n");
-	}
 
+	dma_thresh = SSCR1_RxTresh(RX_THRESH_DFLT) | SSCR1_TxTresh(TX_THRESH_DFLT);
 	dma_mapped = controller->can_dma &&
 		     controller->can_dma(controller, spi, transfer) &&
 		     controller->cur_msg_mapped;
@@ -1213,7 +1201,6 @@ static int setup(struct spi_device *spi)
 		if (!chip)
 			return -ENOMEM;
 
-		chip->enable_dma = drv_data->controller_info->enable_dma;
 		chip->timeout = TIMOUT_DFLT;
 	}
 
@@ -1236,20 +1223,6 @@ static int setup(struct spi_device *spi)
 		chip->lpss_tx_threshold = tx_thres;
 	}
 
-	if (chip->enable_dma) {
-		/* Set up legal burst and threshold for DMA */
-		if (pxa2xx_spi_set_dma_burst_and_threshold(chip, spi,
-						spi->bits_per_word,
-						&chip->dma_burst_size,
-						&chip->dma_threshold)) {
-			dev_warn(&spi->dev,
-				 "in setup: DMA burst size reduced to match bits_per_word\n");
-		}
-		dev_dbg(&spi->dev,
-			"in setup: DMA burst size set to %u\n",
-			chip->dma_burst_size);
-	}
-
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		chip->threshold = (QUARK_X1000_SSCR1_RxTresh(rx_thres)
@@ -1439,6 +1412,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		if (IS_ERR(platform_info))
 			return dev_err_probe(dev, PTR_ERR(platform_info), "missing platform data\n");
 	}
+	dev_dbg(dev, "DMA burst size set to %u\n", platform_info->dma_burst_size);
 
 	ssp = pxa_ssp_request(pdev->id, pdev->name);
 	if (!ssp)
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index ae9c99bc9f6c..10294ef209d9 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -79,9 +79,6 @@ struct chip_data {
 	u32 cr1;
 	u32 dds_rate;
 	u32 timeout;
-	u8 enable_dma;
-	u32 dma_burst_size;
-	u32 dma_threshold;
 	u32 threshold;
 	u16 lpss_rx_threshold;
 	u16 lpss_tx_threshold;
@@ -142,10 +139,5 @@ extern void pxa2xx_spi_dma_start(struct driver_data *drv_data);
 extern void pxa2xx_spi_dma_stop(struct driver_data *drv_data);
 extern int pxa2xx_spi_dma_setup(struct driver_data *drv_data);
 extern void pxa2xx_spi_dma_release(struct driver_data *drv_data);
-extern int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
-						  struct spi_device *spi,
-						  u8 bits_per_word,
-						  u32 *burst_code,
-						  u32 *threshold);
 
 #endif /* SPI_PXA2XX_H */
-- 
2.43.0.rc1.1.gbec44491f096


