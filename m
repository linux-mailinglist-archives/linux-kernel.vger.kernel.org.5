Return-Path: <linux-kernel+bounces-148944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EAC8A8975
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADCC284F11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE6171660;
	Wed, 17 Apr 2024 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XvWzwf5I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA5B17107D;
	Wed, 17 Apr 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373038; cv=none; b=IjPWv+KjTzChhFXY81m/h0AFjj3woGZK/Jy3WotWpnCt2AoOxnUVHEtG++uUqesQw5EgkFIYWFqXW9hG9MU2CtbNPzwcvNpniZdEh+MtDoNsAyp5YmS/VQWxLKZq6RRdYF8b2vr3yQI+PilAVkTRF1dwxunxzeDOgEDRbLQG1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373038; c=relaxed/simple;
	bh=EY0oW8gWzFx+UyQ5mI7eQESReZJaeFrBusZVAd3sm0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CwBFbaqSPTTqe2Jp+RBrMQXIBTsK4cXMcBmzGiSCPeINYOuI4jpIb5l2OEOdNws4fVdhdnMGeK3C7EjUt6YTbAkj/fNLVh4BWEupqC9jyReuHYchKxsRT+5Ik4sWvYARqECGBLiA30tAZ45BupBfmZ6eEHCgClgYkbLyaxlpCZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XvWzwf5I; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373038; x=1744909038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EY0oW8gWzFx+UyQ5mI7eQESReZJaeFrBusZVAd3sm0g=;
  b=XvWzwf5I9K4/KN9xVy0nLaCVDKtQM+5grCyoMPoCTToi39Oc9vCztft/
   DrYMEWm1Nrw1XT4Ivnb4GHHVwPkqA/AQES+V9LYAAhQdiwQBSF87WFFn4
   ygazXgy9YkWGL2OTZWUa8+1K6qBU9gCpn1MH2FQ1kEk6RJmElpNCFYxeP
   nKb3F4IzU+3Tmw45XS0q1rHA20NixlCHS8euPH1AaUouXg4dnvTKH2UsJ
   nRQoNJHi9AdCch6s7Y+jMPYX8zXz8wux2gr2oFUKw30k2qf27guZUwwtU
   QOOQ1DyO0QCrHF3I6mbvEXYT+vg9eGJRwQzKuc6JcZdCq09oV60OYgok8
   w==;
X-CSE-ConnectionGUID: FF9hUofhQRaaHP6HHtmR2w==
X-CSE-MsgGUID: ZafO1nk8TJaLmTz/3lj1bQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8737012"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8737012"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:57:15 -0700
X-CSE-ConnectionGUID: U7LXLfYBRfqoKFFlXjA0RA==
X-CSE-MsgGUID: KuzNvTAhTWiD4ahfD3nqEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22571635"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 17 Apr 2024 09:57:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 95DCA68; Wed, 17 Apr 2024 19:57:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH v1 1/5] mmc: atmel-mci: Get rid of platform data leftovers
Date: Wed, 17 Apr 2024 19:55:13 +0300
Message-ID: <20240417165708.2965612-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240417165708.2965612-1-andriy.shevchenko@linux.intel.com>
References: <20240417165708.2965612-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit d2c6d518c21d ("mmc: atmel-mci: move atmel MCI header file")
made sure that there is no in-kernel user of the platform data. But
at the same time it hadn't removed the code around that data structure.
Finish the job here and remove a dead code.

Fixes: d2c6d518c21d ("mmc: atmel-mci: move atmel MCI header file")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/atmel-mci.c | 43 +++++-------------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index dba826db739a..87c2855f64c2 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -226,13 +226,9 @@ struct mci_slot_pdata {
 
 /**
  * struct mci_platform_data - board-specific MMC/SDcard configuration
- * @dma_slave: DMA slave interface to use in data transfers.
- * @dma_filter: Filtering function to filter the DMA channel
  * @slot: Per-slot configuration data.
  */
 struct mci_platform_data {
-	void			*dma_slave;
-	dma_filter_fn		dma_filter;
 	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
 };
 
@@ -626,7 +622,6 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 			   &host->completed_events);
 }
 
-#if defined(CONFIG_OF)
 static const struct of_device_id atmci_dt_ids[] = {
 	{ .compatible = "atmel,hsmci" },
 	{ /* sentinel */ }
@@ -700,13 +695,6 @@ atmci_of_init(struct platform_device *pdev)
 
 	return pdata;
 }
-#else /* CONFIG_OF */
-static inline struct mci_platform_data*
-atmci_of_init(struct platform_device *dev)
-{
-	return ERR_PTR(-EINVAL);
-}
-#endif
 
 static inline unsigned int atmci_get_version(struct atmel_mci *host)
 {
@@ -2388,23 +2376,6 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 static int atmci_configure_dma(struct atmel_mci *host)
 {
 	host->dma.chan = dma_request_chan(&host->pdev->dev, "rxtx");
-
-	if (PTR_ERR(host->dma.chan) == -ENODEV) {
-		struct mci_platform_data *pdata = host->pdev->dev.platform_data;
-		dma_cap_mask_t mask;
-
-		if (!pdata || !pdata->dma_filter)
-			return -ENODEV;
-
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-
-		host->dma.chan = dma_request_channel(mask, pdata->dma_filter,
-						     pdata->dma_slave);
-		if (!host->dma.chan)
-			host->dma.chan = ERR_PTR(-ENODEV);
-	}
-
 	if (IS_ERR(host->dma.chan))
 		return PTR_ERR(host->dma.chan);
 
@@ -2492,13 +2463,11 @@ static int atmci_probe(struct platform_device *pdev)
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
 		return -ENXIO;
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		pdata = atmci_of_init(pdev);
-		if (IS_ERR(pdata)) {
-			dev_err(&pdev->dev, "platform data not available\n");
-			return PTR_ERR(pdata);
-		}
+
+	pdata = atmci_of_init(pdev);
+	if (IS_ERR(pdata)) {
+		dev_err(&pdev->dev, "platform data not available\n");
+		return PTR_ERR(pdata);
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -2701,7 +2670,7 @@ static struct platform_driver atmci_driver = {
 	.driver		= {
 		.name		= "atmel_mci",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-		.of_match_table	= of_match_ptr(atmci_dt_ids),
+		.of_match_table	= atmci_dt_ids,
 		.pm		= &atmci_dev_pm_ops,
 	},
 };
-- 
2.43.0.rc1.1336.g36b5255a03ac


