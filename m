Return-Path: <linux-kernel+bounces-158944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1998B2736
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A751C23B82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED3714E2CB;
	Thu, 25 Apr 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0wJE4FD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4414D715;
	Thu, 25 Apr 2024 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064947; cv=none; b=ppdsEuy3XlavmuvgaruTRkYHwd6OK+PGxdlNr+eBLn3maxSVnYS2nFAxQGn5sLdG4bHGB9g3+aWHXHFEwuguTMMopvTe1ql5TnTVArXYr5wVmX593LKLCz8CKJG9I5BM961PyN/2jHz5oIwi+YIV3atl6mRUqyKHnM3kqRcPybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064947; c=relaxed/simple;
	bh=6/9sO9GFWOtUcX+qVb91FNhPTDtt7A0IxEGeFO8MRB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iO1+xY/6Tw9reBz+O2f5k9X7mx0CfWPjTutbimMSQCnnU8MEIAt9ezd+Jv3TUd65V3wwSFabh5BbF78GXYLhPkOnQLkkOYLMlzkgjhKoQCzXcM3MDJSJ7B95E3kB/qt/hLVNnedW4NMIa//0cvJTRisWXkm07raqijUcy2OkHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0wJE4FD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714064945; x=1745600945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6/9sO9GFWOtUcX+qVb91FNhPTDtt7A0IxEGeFO8MRB4=;
  b=G0wJE4FD/ivUUbPUSvKijy1PWJvCvYf7Mc661OYLS/lh01XTOlb0RjKe
   VX0VcRuVFrNcikS8f1fMP8OUbgCNO0dJQD7nz1BdQa49p5y8z2W5cVHom
   FNsplYaerm+9itDGmJTzZqlpakszKMDFWcnRp/DBaCNxTGGpbb2rL4kdQ
   VlbyCklkQdpDmPNpqgqieLHbOYFBd2QmY/9TTU1m3O8pj2LL2DMHQpLt1
   1k6r/uNhJwHsR68j6JE59D6jaEGwz++xfjkkx8cyAV0DOZuaZ72w1WaMC
   zlRh3aGTzecBuQMGLkBYZgl+yBcGxFQydHIZR33tH/XDLHemoGUOnH9Ij
   A==;
X-CSE-ConnectionGUID: gitWnEPmQf+5QA7n+6KKpA==
X-CSE-MsgGUID: aDIIDwXeRkuNFOkdhTHA4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="13554447"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="13554447"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:09:04 -0700
X-CSE-ConnectionGUID: A7RDrk70SrC9wW9Ti6eYng==
X-CSE-MsgGUID: b3d9/hPPTBuJlM+wJhImhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="29595990"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 25 Apr 2024 10:09:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8343787; Thu, 25 Apr 2024 20:09:01 +0300 (EEST)
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
Subject: [PATCH v2 1/2] mmc: atmel-mci: Incapsulate used to be a platform data into host structure
Date: Thu, 25 Apr 2024 20:08:44 +0300
Message-ID: <20240425170900.3767990-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240425170900.3767990-1-andriy.shevchenko@linux.intel.com>
References: <20240425170900.3767990-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After platform data is gone, we always allocate memory for the slot
information. Incapsulate the array of the latter into the host structure,
so we allocate memory only once. This makes code simpler.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/atmel-mci.c | 61 ++++++++++++++----------------------
 1 file changed, 24 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 3aed57c392fa..9ae3ce14db50 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -224,14 +224,6 @@ struct mci_slot_pdata {
 	bool			non_removable;
 };
 
-/**
- * struct mci_platform_data - board-specific MMC/SDcard configuration
- * @slot: Per-slot configuration data.
- */
-struct mci_platform_data {
-	struct mci_slot_pdata	slot[ATMCI_MAX_NR_SLOTS];
-};
-
 struct atmel_mci_caps {
 	bool    has_dma_conf_reg;
 	bool    has_pdc;
@@ -297,6 +289,7 @@ struct atmel_mci_dma {
  * @mapbase: Physical address of the MMIO registers.
  * @mck: The peripheral bus clock hooked up to the MMC controller.
  * @dev: Device associated with the MMC controller.
+ * @pdata: Per-slot configuration data.
  * @slot: Slots sharing this MMC controller.
  * @caps: MCI capabilities depending on MCI version.
  * @prepare_data: function to setup MCI before data transfer which
@@ -375,6 +368,7 @@ struct atmel_mci {
 	struct clk		*mck;
 	struct device		*dev;
 
+	struct mci_slot_pdata	pdata[ATMCI_MAX_NR_SLOTS];
 	struct atmel_mci_slot	*slot[ATMCI_MAX_NR_SLOTS];
 
 	struct atmel_mci_caps   caps;
@@ -630,11 +624,11 @@ static const struct of_device_id atmci_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, atmci_dt_ids);
 
-static struct mci_platform_data *atmci_of_init(struct device *dev)
+static int atmci_of_init(struct atmel_mci *host)
 {
+	struct device *dev = host->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *cnp;
-	struct mci_platform_data *pdata;
 	u32 slot_id;
 	int err;
 
@@ -643,10 +637,6 @@ static struct mci_platform_data *atmci_of_init(struct device *dev)
 		return ERR_PTR(-EINVAL);
 	}
 
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
 	for_each_child_of_node(np, cnp) {
 		if (of_property_read_u32(cnp, "reg", &slot_id)) {
 			dev_warn(dev, "reg property is missing for %pOF\n", cnp);
@@ -661,38 +651,38 @@ static struct mci_platform_data *atmci_of_init(struct device *dev)
 		}
 
 		if (of_property_read_u32(cnp, "bus-width",
-		                         &pdata->slot[slot_id].bus_width))
-			pdata->slot[slot_id].bus_width = 1;
+					 &host->pdata[slot_id].bus_width))
+			host->pdata[slot_id].bus_width = 1;
 
-		pdata->slot[slot_id].detect_pin =
+		host->pdata[slot_id].detect_pin =
 			devm_fwnode_gpiod_get(dev, of_fwnode_handle(cnp),
 					      "cd", GPIOD_IN, "cd-gpios");
-		err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].detect_pin);
+		err = PTR_ERR_OR_ZERO(host->pdata[slot_id].detect_pin);
 		if (err) {
 			if (err != -ENOENT) {
 				of_node_put(cnp);
-				return ERR_PTR(err);
+				return err;
 			}
-			pdata->slot[slot_id].detect_pin = NULL;
+			host->pdata[slot_id].detect_pin = NULL;
 		}
 
-		pdata->slot[slot_id].non_removable =
+		host->pdata[slot_id].non_removable =
 			of_property_read_bool(cnp, "non-removable");
 
-		pdata->slot[slot_id].wp_pin =
+		host->pdata[slot_id].wp_pin =
 			devm_fwnode_gpiod_get(dev, of_fwnode_handle(cnp),
 					      "wp", GPIOD_IN, "wp-gpios");
-		err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].wp_pin);
+		err = PTR_ERR_OR_ZERO(host->pdata[slot_id].wp_pin);
 		if (err) {
 			if (err != -ENOENT) {
 				of_node_put(cnp);
-				return ERR_PTR(err);
+				return err;
 			}
-			pdata->slot[slot_id].wp_pin = NULL;
+			host->pdata[slot_id].wp_pin = NULL;
 		}
 	}
 
-	return pdata;
+	return 0;
 }
 
 static inline unsigned int atmci_get_version(struct atmel_mci *host)
@@ -2456,7 +2446,6 @@ static void atmci_get_cap(struct atmel_mci *host)
 static int atmci_probe(struct platform_device *pdev)
 {
 	struct device			*dev = &pdev->dev;
-	struct mci_platform_data	*pdata;
 	struct atmel_mci		*host;
 	struct resource			*regs;
 	unsigned int			nr_slots;
@@ -2467,12 +2456,6 @@ static int atmci_probe(struct platform_device *pdev)
 	if (!regs)
 		return -ENXIO;
 
-	pdata = atmci_of_init(dev);
-	if (IS_ERR(pdata)) {
-		dev_err(dev, "platform data not available\n");
-		return PTR_ERR(pdata);
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -2485,6 +2468,10 @@ static int atmci_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 	INIT_LIST_HEAD(&host->queue);
 
+	ret = atmci_of_init(host);
+	if (ret)
+		return dev_err_probe(dev, ret, "Slot information not available\n");
+
 	host->mck = devm_clk_get(dev, "mci_clk");
 	if (IS_ERR(host->mck))
 		return PTR_ERR(host->mck);
@@ -2544,16 +2531,16 @@ static int atmci_probe(struct platform_device *pdev)
 	/* We need at least one slot to succeed */
 	nr_slots = 0;
 	ret = -ENODEV;
-	if (pdata->slot[0].bus_width) {
-		ret = atmci_init_slot(host, &pdata->slot[0],
+	if (host->pdata[0].bus_width) {
+		ret = atmci_init_slot(host, &host->pdata[0],
 				0, ATMCI_SDCSEL_SLOT_A, ATMCI_SDIOIRQA);
 		if (!ret) {
 			nr_slots++;
 			host->buf_size = host->slot[0]->mmc->max_req_size;
 		}
 	}
-	if (pdata->slot[1].bus_width) {
-		ret = atmci_init_slot(host, &pdata->slot[1],
+	if (host->pdata[1].bus_width) {
+		ret = atmci_init_slot(host, &host->pdata[1],
 				1, ATMCI_SDCSEL_SLOT_B, ATMCI_SDIOIRQB);
 		if (!ret) {
 			nr_slots++;
-- 
2.43.0.rc1.1336.g36b5255a03ac


