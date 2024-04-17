Return-Path: <linux-kernel+bounces-148945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB18A8977
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4802028519F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82584171E47;
	Wed, 17 Apr 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MTxUR4ie"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DFD171090;
	Wed, 17 Apr 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373039; cv=none; b=k/onGsZ8kxK3tPOQ+n22OwGo8m0MBSRbSFIJUpVitCIjdM9oaBVLIB7qxvWFRSS06oAYQdPMrUX5g+e85dWNeFSZYtlzY0WTr5/779Jn3qjKELJ7BVMzPGGoU5x7tmD38TqV+gnjnyz3uKhYOecsUMdGoYijAES1sfGkcabaqAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373039; c=relaxed/simple;
	bh=pK7D94zlVsLtPfGLt8vrs3Ch7+HDx4astTv2fWve5w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs9MTZa9XgXFfg8GkLrxqw/IMsyJ+ZbHo8KNwu60uaop0s95tw060qtW9fXPKSzGdrJB19CxZATQLP1q/mTYn09gejyrB7SMwD695NUEU4vUNoTM34R/m6IGHJRLw21O2h9oJq1y4kwsfHy+Ui7oHv4CYF6PHCgHTtHrt8Pq93w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MTxUR4ie; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373038; x=1744909038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pK7D94zlVsLtPfGLt8vrs3Ch7+HDx4astTv2fWve5w8=;
  b=MTxUR4ieqys0PURky3p0D9VsfEj7tkLpaG8+/x1riIqVw33e53lx4oNB
   dzX2/fUDeSMRwxzNQ2x89ALpVwuMfILVCQ4oTYBylLpNe1tDqSMgOdtBJ
   r0Uge/wZ01jeulbb+sMWg2/1sU6wSWJvSyBhzCoRqkwuQdLYnWBHemZPa
   UjJbk43i54hp6TYqX7HUXqSAjIJ5U+fEin7mEK4g3OgZsTU/fK0vIRZgF
   ts5zRNSFKN4OPDZqUqhsuz5vmttex6t43lp/X1PQZcnz+YrN78jEbtiYW
   NT4n37OWsJ6o+e8j7Y3uXyLquCjG17ZewzALNvSzRJ+4qch24MrO1T7NH
   Q==;
X-CSE-ConnectionGUID: I9PmHNzuR/WJQmgR89yrmw==
X-CSE-MsgGUID: Ck4lVCD3R3uz7QryKHau7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8737018"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="8737018"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:57:15 -0700
X-CSE-ConnectionGUID: OSdbcZcdSumVhBGEq8jZLA==
X-CSE-MsgGUID: qPYy91wCTsWZZdH0C22tGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22571638"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 17 Apr 2024 09:57:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B650C60B; Wed, 17 Apr 2024 19:57:11 +0300 (EEST)
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
Subject: [PATCH v1 4/5] mmc: atmel-mci: Incapsulate used to be a platform data into host structure
Date: Wed, 17 Apr 2024 19:55:16 +0300
Message-ID: <20240417165708.2965612-5-andriy.shevchenko@linux.intel.com>
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

After platform data is gone, we always allocate memory for the slot
information. Incapsulate the array of the latter into the host structure,
so we allocate memory only once. This makes code simpler.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/atmel-mci.c | 66 ++++++++++++++----------------------
 1 file changed, 25 insertions(+), 41 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 3aed57c392fa..3ae17b8584a2 100644
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
@@ -375,6 +367,7 @@ struct atmel_mci {
 	struct clk		*mck;
 	struct device		*dev;
 
+	struct mci_slot_pdata	pdata[ATMCI_MAX_NR_SLOTS];
 	struct atmel_mci_slot	*slot[ATMCI_MAX_NR_SLOTS];
 
 	struct atmel_mci_caps   caps;
@@ -630,22 +623,16 @@ static const struct of_device_id atmci_dt_ids[] = {
 
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
 
-	if (!np) {
-		dev_err(dev, "device node not found\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
+	if (!np)
+		return dev_err_probe(dev, -EINVAL, "device node not found\n");
 
 	for_each_child_of_node(np, cnp) {
 		if (of_property_read_u32(cnp, "reg", &slot_id)) {
@@ -661,38 +648,38 @@ static struct mci_platform_data *atmci_of_init(struct device *dev)
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
@@ -2456,7 +2443,6 @@ static void atmci_get_cap(struct atmel_mci *host)
 static int atmci_probe(struct platform_device *pdev)
 {
 	struct device			*dev = &pdev->dev;
-	struct mci_platform_data	*pdata;
 	struct atmel_mci		*host;
 	struct resource			*regs;
 	unsigned int			nr_slots;
@@ -2467,12 +2453,6 @@ static int atmci_probe(struct platform_device *pdev)
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
@@ -2485,6 +2465,10 @@ static int atmci_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 	INIT_LIST_HEAD(&host->queue);
 
+	ret = atmci_of_init(host);
+	if (ret)
+		return dev_err_probe(dev, ret, "Slot information not available\n");
+
 	host->mck = devm_clk_get(dev, "mci_clk");
 	if (IS_ERR(host->mck))
 		return PTR_ERR(host->mck);
@@ -2544,16 +2528,16 @@ static int atmci_probe(struct platform_device *pdev)
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


