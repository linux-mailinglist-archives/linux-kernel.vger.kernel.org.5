Return-Path: <linux-kernel+bounces-148947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DEE8A897B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B0B1C23620
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C2F17106C;
	Wed, 17 Apr 2024 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdBglDZX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315C17106F;
	Wed, 17 Apr 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373040; cv=none; b=u8BXzc3jDir06Z+OXctods93TXm5YXz9Gym1rfozFFUb1dqSNyM1bir2B1uyaTVEChuUzTF1uj+h2ttjES4TijeSTCYPt6U9MUU9H1aGtvsCS2esk+16PBkK7JEk+oFkKOozne/Tn6eQzZM7Xoc/peOb/w7pe/EYyfYBx7cWXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373040; c=relaxed/simple;
	bh=GZsozUShGk4fFvMqDmcx0WgJ+1CjFN4FctwcHdIe7AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK1COH+X+2QsyP53p9pCWGzHPvN6Jto3pchfqY5qSWKojUJNtpEK3qqlb6ozs+6+xuiSVmmBLqokdIIc6KIQblu5dcAq7wyYep8iXMMoU8Vf+sgozsQWXD9tN7tjx1Q3gDvLMSsYugHkrwuxgqxuo2SZoTOHDpj9jIzSz+PNk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdBglDZX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373037; x=1744909037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZsozUShGk4fFvMqDmcx0WgJ+1CjFN4FctwcHdIe7AI=;
  b=YdBglDZX/cVamcdwZDQUPREidMMXr/te6s6MQMuteAwKx1viF87ZneSk
   f/dnEWeySsbu2z9HIiqNYXC+mPJfSbzoMj/Xd6xrAhwkyUi00ul4uWXpy
   0ZR78SGXoLre9jb9o9mye3yd4vOcUeeuctMZNaGjObIxTM1GhuzI822YH
   bwYKzwyzmPC3kNyJtV/Xm0X2uNUcrGX3lNHAufxZpClQfTqhAf40BgNUL
   5kOA/4dgEKhnJjC0CVIFIne+c9rKk0IZfIpp+haeNHlCFV9KJ7G/05V0a
   vtsjucSrGuWTYNgWxwplSM/UVJqCR0aGItoHt/PNviPcAmI+2ewm2aXot
   w==;
X-CSE-ConnectionGUID: tY1UqCZ2SBCM+cnmcWytZA==
X-CSE-MsgGUID: p46CdqGXRpmfKrDnQoXXug==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20026888"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="20026888"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:57:15 -0700
X-CSE-ConnectionGUID: +cFC2as1Ty6RVPBwOukZvw==
X-CSE-MsgGUID: d/Kr7EtnT/eb48gjLLZ6aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22766942"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 17 Apr 2024 09:57:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A072421A; Wed, 17 Apr 2024 19:57:11 +0300 (EEST)
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
Subject: [PATCH v1 2/5] mmc: atmel-mci: Use temporary variable for struct device
Date: Wed, 17 Apr 2024 19:55:14 +0300
Message-ID: <20240417165708.2965612-3-andriy.shevchenko@linux.intel.com>
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

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/atmel-mci.c | 214 ++++++++++++++++++-----------------
 1 file changed, 108 insertions(+), 106 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 87c2855f64c2..c4dfd4c7785f 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -526,6 +526,7 @@ static void atmci_show_status_reg(struct seq_file *s,
 static int atmci_regs_show(struct seq_file *s, void *v)
 {
 	struct atmel_mci	*host = s->private;
+	struct device		*dev = &host->pdev->dev;
 	u32			*buf;
 	int			ret = 0;
 
@@ -534,7 +535,7 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	if (!buf)
 		return -ENOMEM;
 
-	pm_runtime_get_sync(&host->pdev->dev);
+	pm_runtime_get_sync(dev);
 
 	/*
 	 * Grab a more or less consistent snapshot. Note that we're
@@ -545,8 +546,8 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	memcpy_fromio(buf, host->regs, ATMCI_REGS_SIZE);
 	spin_unlock_bh(&host->lock);
 
-	pm_runtime_mark_last_busy(&host->pdev->dev);
-	pm_runtime_put_autosuspend(&host->pdev->dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	seq_printf(s, "MR:\t0x%08x%s%s ",
 			buf[ATMCI_MR / 4],
@@ -629,33 +630,31 @@ static const struct of_device_id atmci_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, atmci_dt_ids);
 
-static struct mci_platform_data*
-atmci_of_init(struct platform_device *pdev)
+static struct mci_platform_data *atmci_of_init(struct device *dev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct device_node *cnp;
 	struct mci_platform_data *pdata;
 	u32 slot_id;
 	int err;
 
 	if (!np) {
-		dev_err(&pdev->dev, "device node not found\n");
+		dev_err(dev, "device node not found\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
 	for_each_child_of_node(np, cnp) {
 		if (of_property_read_u32(cnp, "reg", &slot_id)) {
-			dev_warn(&pdev->dev, "reg property is missing for %pOF\n",
-				 cnp);
+			dev_warn(dev, "reg property is missing for %pOF\n", cnp);
 			continue;
 		}
 
 		if (slot_id >= ATMCI_MAX_NR_SLOTS) {
-			dev_warn(&pdev->dev, "can't have more than %d slots\n",
+			dev_warn(dev, "can't have more than %d slots\n",
 			         ATMCI_MAX_NR_SLOTS);
 			of_node_put(cnp);
 			break;
@@ -666,7 +665,7 @@ atmci_of_init(struct platform_device *pdev)
 			pdata->slot[slot_id].bus_width = 1;
 
 		pdata->slot[slot_id].detect_pin =
-			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
+			devm_fwnode_gpiod_get(dev, of_fwnode_handle(cnp),
 					      "cd", GPIOD_IN, "cd-gpios");
 		err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].detect_pin);
 		if (err) {
@@ -681,7 +680,7 @@ atmci_of_init(struct platform_device *pdev)
 			of_property_read_bool(cnp, "non-removable");
 
 		pdata->slot[slot_id].wp_pin =
-			devm_fwnode_gpiod_get(&pdev->dev, of_fwnode_handle(cnp),
+			devm_fwnode_gpiod_get(dev, of_fwnode_handle(cnp),
 					      "wp", GPIOD_IN, "wp-gpios");
 		err = PTR_ERR_OR_ZERO(pdata->slot[slot_id].wp_pin);
 		if (err) {
@@ -726,11 +725,10 @@ static inline unsigned int atmci_convert_chksize(struct atmel_mci *host,
 
 static void atmci_timeout_timer(struct timer_list *t)
 {
-	struct atmel_mci *host;
+	struct atmel_mci *host = from_timer(host, t, timer);
+	struct device *dev = &host->pdev->dev;
 
-	host = from_timer(host, t, timer);
-
-	dev_dbg(&host->pdev->dev, "software timeout\n");
+	dev_dbg(dev, "software timeout\n");
 
 	if (host->mrq->cmd->data) {
 		host->mrq->cmd->data->error = -ETIMEDOUT;
@@ -848,15 +846,14 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
 static void atmci_send_command(struct atmel_mci *host,
 		struct mmc_command *cmd, u32 cmd_flags)
 {
+	struct device *dev = &host->pdev->dev;
 	unsigned int timeout_ms = cmd->busy_timeout ? cmd->busy_timeout :
 		ATMCI_CMD_TIMEOUT_MS;
 
 	WARN_ON(host->cmd);
 	host->cmd = cmd;
 
-	dev_vdbg(&host->pdev->dev,
-			"start command: ARGR=0x%08x CMDR=0x%08x\n",
-			cmd->arg, cmd_flags);
+	dev_vdbg(dev, "start command: ARGR=0x%08x CMDR=0x%08x\n", cmd->arg, cmd_flags);
 
 	atmci_writel(host, ATMCI_ARGR, cmd->arg);
 	atmci_writel(host, ATMCI_CMDR, cmd_flags);
@@ -866,7 +863,9 @@ static void atmci_send_command(struct atmel_mci *host,
 
 static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
 {
-	dev_dbg(&host->pdev->dev, "send stop command\n");
+	struct device *dev = &host->pdev->dev;
+
+	dev_dbg(dev, "send stop command\n");
 	atmci_send_command(host, data->stop, host->stop_cmdr);
 	atmci_writel(host, ATMCI_IER, ATMCI_CMDRDY);
 }
@@ -938,12 +937,11 @@ static void atmci_pdc_set_both_buf(struct atmel_mci *host, int dir)
  */
 static void atmci_pdc_cleanup(struct atmel_mci *host)
 {
+	struct device		*dev = &host->pdev->dev;
 	struct mmc_data         *data = host->data;
 
 	if (data)
-		dma_unmap_sg(&host->pdev->dev,
-				data->sg, data->sg_len,
-				mmc_get_dma_dir(data));
+		dma_unmap_sg(dev, data->sg, data->sg_len, mmc_get_dma_dir(data));
 }
 
 /*
@@ -953,6 +951,7 @@ static void atmci_pdc_cleanup(struct atmel_mci *host)
  */
 static void atmci_pdc_complete(struct atmel_mci *host)
 {
+	struct device *dev = &host->pdev->dev;
 	int transfer_size = host->data->blocks * host->data->blksz;
 	int i;
 
@@ -969,7 +968,7 @@ static void atmci_pdc_complete(struct atmel_mci *host)
 
 	atmci_pdc_cleanup(host);
 
-	dev_dbg(&host->pdev->dev, "(%s) set pending xfer complete\n", __func__);
+	dev_dbg(dev, "(%s) set pending xfer complete\n", __func__);
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
 	tasklet_schedule(&host->tasklet);
 }
@@ -990,9 +989,10 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
 static void atmci_dma_complete(void *arg)
 {
 	struct atmel_mci	*host = arg;
+	struct device		*dev = &host->pdev->dev;
 	struct mmc_data		*data = host->data;
 
-	dev_vdbg(&host->pdev->dev, "DMA complete\n");
+	dev_vdbg(dev, "DMA complete\n");
 
 	if (host->caps.has_dma_conf_reg)
 		/* Disable DMA hardware handshaking on MCI */
@@ -1005,8 +1005,7 @@ static void atmci_dma_complete(void *arg)
 	 * to send the stop command or waiting for NBUSY in this case.
 	 */
 	if (data) {
-		dev_dbg(&host->pdev->dev,
-		        "(%s) set pending xfer complete\n", __func__);
+		dev_dbg(dev, "(%s) set pending xfer complete\n", __func__);
 		atmci_set_pending(host, EVENT_XFER_COMPLETE);
 		tasklet_schedule(&host->tasklet);
 
@@ -1080,6 +1079,7 @@ static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
 static u32
 atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
 {
+	struct device *dev = &host->pdev->dev;
 	u32 iflags, tmp;
 	int i;
 
@@ -1105,8 +1105,7 @@ atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
 
 	/* Configure PDC */
 	host->data_size = data->blocks * data->blksz;
-	dma_map_sg(&host->pdev->dev, data->sg, data->sg_len,
-		   mmc_get_dma_dir(data));
+	dma_map_sg(dev, data->sg, data->sg_len, mmc_get_dma_dir(data));
 
 	if ((!host->caps.has_rwproof)
 	    && (host->data->flags & MMC_DATA_WRITE)) {
@@ -1232,8 +1231,9 @@ atmci_submit_data_dma(struct atmel_mci *host, struct mmc_data *data)
 
 static void atmci_stop_transfer(struct atmel_mci *host)
 {
-	dev_dbg(&host->pdev->dev,
-	        "(%s) set pending xfer complete\n", __func__);
+	struct device *dev = &host->pdev->dev;
+
+	dev_dbg(dev, "(%s) set pending xfer complete\n", __func__);
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
 	atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 }
@@ -1249,14 +1249,14 @@ static void atmci_stop_transfer_pdc(struct atmel_mci *host)
 static void atmci_stop_transfer_dma(struct atmel_mci *host)
 {
 	struct dma_chan *chan = host->data_chan;
+	struct device *dev = &host->pdev->dev;
 
 	if (chan) {
 		dmaengine_terminate_all(chan);
 		atmci_dma_cleanup(host);
 	} else {
 		/* Data transfer was stopped by the interrupt handler */
-		dev_dbg(&host->pdev->dev,
-		        "(%s) set pending xfer complete\n", __func__);
+		dev_dbg(dev, "(%s) set pending xfer complete\n", __func__);
 		atmci_set_pending(host, EVENT_XFER_COMPLETE);
 		atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 	}
@@ -1269,6 +1269,7 @@ static void atmci_stop_transfer_dma(struct atmel_mci *host)
 static void atmci_start_request(struct atmel_mci *host,
 		struct atmel_mci_slot *slot)
 {
+	struct device		*dev = &host->pdev->dev;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
@@ -1284,7 +1285,7 @@ static void atmci_start_request(struct atmel_mci *host,
 	host->cmd_status = 0;
 	host->data_status = 0;
 
-	dev_dbg(&host->pdev->dev, "start request: cmd %u\n", mrq->cmd->opcode);
+	dev_dbg(dev, "start request: cmd %u\n", mrq->cmd->opcode);
 
 	if (host->need_reset || host->caps.need_reset_after_xfer) {
 		iflags = atmci_readl(host, ATMCI_IMR);
@@ -1363,6 +1364,8 @@ static void atmci_start_request(struct atmel_mci *host,
 static void atmci_queue_request(struct atmel_mci *host,
 		struct atmel_mci_slot *slot, struct mmc_request *mrq)
 {
+	struct device *dev = &host->pdev->dev;
+
 	dev_vdbg(&slot->mmc->class_dev, "queue request: state=%d\n",
 			host->state);
 
@@ -1372,7 +1375,7 @@ static void atmci_queue_request(struct atmel_mci *host,
 		host->state = STATE_SENDING_CMD;
 		atmci_start_request(host, slot);
 	} else {
-		dev_dbg(&host->pdev->dev, "queue request\n");
+		dev_dbg(dev, "queue request\n");
 		list_add_tail(&slot->queue_node, &host->queue);
 	}
 	spin_unlock_bh(&host->lock);
@@ -1382,10 +1385,11 @@ static void atmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct atmel_mci_slot	*slot = mmc_priv(mmc);
 	struct atmel_mci	*host = slot->host;
+	struct device		*dev = &host->pdev->dev;
 	struct mmc_data		*data;
 
 	WARN_ON(slot->mrq);
-	dev_dbg(&host->pdev->dev, "MRQ: cmd %u\n", mrq->cmd->opcode);
+	dev_dbg(dev, "MRQ: cmd %u\n", mrq->cmd->opcode);
 
 	/*
 	 * We may "know" the card is gone even though there's still an
@@ -1595,6 +1599,7 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
 {
 	struct atmel_mci_slot	*slot = NULL;
 	struct mmc_host		*prev_mmc = host->cur_slot->mmc;
+	struct device		*dev = &host->pdev->dev;
 
 	WARN_ON(host->cmd || host->data);
 
@@ -1617,12 +1622,11 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
 		slot = list_entry(host->queue.next,
 				struct atmel_mci_slot, queue_node);
 		list_del(&slot->queue_node);
-		dev_vdbg(&host->pdev->dev, "list not empty: %s is next\n",
-				mmc_hostname(slot->mmc));
+		dev_vdbg(dev, "list not empty: %s is next\n", mmc_hostname(slot->mmc));
 		host->state = STATE_SENDING_CMD;
 		atmci_start_request(host, slot);
 	} else {
-		dev_vdbg(&host->pdev->dev, "list empty\n");
+		dev_vdbg(dev, "list empty\n");
 		host->state = STATE_IDLE;
 	}
 
@@ -1756,6 +1760,7 @@ static void atmci_detect_change(struct timer_list *t)
 static void atmci_tasklet_func(struct tasklet_struct *t)
 {
 	struct atmel_mci        *host = from_tasklet(host, t, tasklet);
+	struct device		*dev = &host->pdev->dev;
 	struct mmc_request	*mrq = host->mrq;
 	struct mmc_data		*data = host->data;
 	enum atmel_mci_state	state = host->state;
@@ -1766,14 +1771,13 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
 
 	state = host->state;
 
-	dev_vdbg(&host->pdev->dev,
-		"tasklet: state %u pending/completed/mask %lx/%lx/%x\n",
+	dev_vdbg(dev, "tasklet: state %u pending/completed/mask %lx/%lx/%x\n",
 		state, host->pending_events, host->completed_events,
 		atmci_readl(host, ATMCI_IMR));
 
 	do {
 		prev_state = state;
-		dev_dbg(&host->pdev->dev, "FSM: state=%d\n", state);
+		dev_dbg(dev, "FSM: state=%d\n", state);
 
 		switch (state) {
 		case STATE_IDLE:
@@ -1786,18 +1790,17 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
 			 * END_REQUEST by default, WAITING_NOTBUSY if it's a
 			 * command needing it or DATA_XFER if there is data.
 			 */
-			dev_dbg(&host->pdev->dev, "FSM: cmd ready?\n");
+			dev_dbg(dev, "FSM: cmd ready?\n");
 			if (!atmci_test_and_clear_pending(host,
 						EVENT_CMD_RDY))
 				break;
 
-			dev_dbg(&host->pdev->dev, "set completed cmd ready\n");
+			dev_dbg(dev, "set completed cmd ready\n");
 			host->cmd = NULL;
 			atmci_set_completed(host, EVENT_CMD_RDY);
 			atmci_command_complete(host, mrq->cmd);
 			if (mrq->data) {
-				dev_dbg(&host->pdev->dev,
-				        "command with data transfer");
+				dev_dbg(dev, "command with data transfer\n");
 				/*
 				 * If there is a command error don't start
 				 * data transfer.
@@ -1812,8 +1815,7 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
 				} else
 					state = STATE_DATA_XFER;
 			} else if ((!mrq->data) && (mrq->cmd->flags & MMC_RSP_BUSY)) {
-				dev_dbg(&host->pdev->dev,
-				        "command response need waiting notbusy");
+				dev_dbg(dev, "command response need waiting notbusy\n");
 				atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
 				state = STATE_WAITING_NOTBUSY;
 			} else
@@ -1824,7 +1826,7 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
 		case STATE_DATA_XFER:
 			if (atmci_test_and_clear_pending(host,
 						EVENT_DATA_ERROR)) {
-				dev_dbg(&host->pdev->dev, "set completed data error\n");
+				dev_dbg(dev, "set completed data error\n");
 				atmci_set_completed(host, EVENT_DATA_ERROR);
 				state = STATE_END_REQUEST;
 				break;
@@ -1837,14 +1839,12 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
 			 * to the next step which is WAITING_NOTBUSY in write
 			 * case and directly SENDING_STOP in read case.
 			 */
-			dev_dbg(&host->pdev->dev, "FSM: xfer complete?\n");
+			dev_dbg(dev, "FSM: xfer complete?\n");
 			if (!atmci_test_and_clear_pending(host,
 						EVENT_XFER_COMPLETE))
 				break;
 
-			dev_dbg(&host->pdev->dev,
-			        "(%s) set completed xfer complete\n",
-				__func__);
+			dev_dbg(dev, "(%s) set completed xfer complete\n", __func__);
 			atmci_set_completed(host, EVENT_XFER_COMPLETE);
 
 			if (host->caps.need_notbusy_for_read_ops ||
@@ -1869,12 +1869,12 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
 			 * included) or a write operation. In the latest case,
 			 * we need to send a stop command.
 			 */
-			dev_dbg(&host->pdev->dev, "FSM: not busy?\n");
+			dev_dbg(dev, "FSM: not busy?\n");
 			if (!atmci_test_and_clear_pending(host,
 						EVENT_NOTBUSY))
 				break;
 
-			dev_dbg(&host->pdev->dev, "set completed not busy\n");
+			dev_dbg(dev, "set completed not busy\n");
 			atmci_set_completed(host, EVENT_NOTBUSY);
 
 			if (host->data) {
@@ -1904,12 +1904,12 @@ static void atmci_tasklet_func(struct tasklet_struct *t)
 			 * in order to go to the end request state instead of
 			 * sending stop again.
 			 */
-			dev_dbg(&host->pdev->dev, "FSM: cmd ready?\n");
+			dev_dbg(dev, "FSM: cmd ready?\n");
 			if (!atmci_test_and_clear_pending(host,
 						EVENT_CMD_RDY))
 				break;
 
-			dev_dbg(&host->pdev->dev, "FSM: cmd ready\n");
+			dev_dbg(dev, "FSM: cmd ready\n");
 			host->cmd = NULL;
 			data->bytes_xfered = data->blocks * data->blksz;
 			data->error = 0;
@@ -2108,6 +2108,7 @@ static void atmci_sdio_interrupt(struct atmel_mci *host, u32 status)
 static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 {
 	struct atmel_mci	*host = dev_id;
+	struct device		*dev = &host->pdev->dev;
 	u32			status, mask, pending;
 	unsigned int		pass_count = 0;
 
@@ -2119,21 +2120,21 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 			break;
 
 		if (pending & ATMCI_DATA_ERROR_FLAGS) {
-			dev_dbg(&host->pdev->dev, "IRQ: data error\n");
+			dev_dbg(dev, "IRQ: data error\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_DATA_ERROR_FLAGS
 					| ATMCI_RXRDY | ATMCI_TXRDY
 					| ATMCI_ENDRX | ATMCI_ENDTX
 					| ATMCI_RXBUFF | ATMCI_TXBUFE);
 
 			host->data_status = status;
-			dev_dbg(&host->pdev->dev, "set pending data error\n");
+			dev_dbg(dev, "set pending data error\n");
 			smp_wmb();
 			atmci_set_pending(host, EVENT_DATA_ERROR);
 			tasklet_schedule(&host->tasklet);
 		}
 
 		if (pending & ATMCI_TXBUFE) {
-			dev_dbg(&host->pdev->dev, "IRQ: tx buffer empty\n");
+			dev_dbg(dev, "IRQ: tx buffer empty\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_TXBUFE);
 			atmci_writel(host, ATMCI_IDR, ATMCI_ENDTX);
 			/*
@@ -2149,7 +2150,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 				atmci_pdc_complete(host);
 			}
 		} else if (pending & ATMCI_ENDTX) {
-			dev_dbg(&host->pdev->dev, "IRQ: end of tx buffer\n");
+			dev_dbg(dev, "IRQ: end of tx buffer\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_ENDTX);
 
 			if (host->data_size) {
@@ -2160,7 +2161,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 		}
 
 		if (pending & ATMCI_RXBUFF) {
-			dev_dbg(&host->pdev->dev, "IRQ: rx buffer full\n");
+			dev_dbg(dev, "IRQ: rx buffer full\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_RXBUFF);
 			atmci_writel(host, ATMCI_IDR, ATMCI_ENDRX);
 			/*
@@ -2176,7 +2177,7 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 				atmci_pdc_complete(host);
 			}
 		} else if (pending & ATMCI_ENDRX) {
-			dev_dbg(&host->pdev->dev, "IRQ: end of rx buffer\n");
+			dev_dbg(dev, "IRQ: end of rx buffer\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_ENDRX);
 
 			if (host->data_size) {
@@ -2193,19 +2194,19 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 		 * The appropriate workaround is to use the BLKE signal.
 		 */
 		if (pending & ATMCI_BLKE) {
-			dev_dbg(&host->pdev->dev, "IRQ: blke\n");
+			dev_dbg(dev, "IRQ: blke\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_BLKE);
 			smp_wmb();
-			dev_dbg(&host->pdev->dev, "set pending notbusy\n");
+			dev_dbg(dev, "set pending notbusy\n");
 			atmci_set_pending(host, EVENT_NOTBUSY);
 			tasklet_schedule(&host->tasklet);
 		}
 
 		if (pending & ATMCI_NOTBUSY) {
-			dev_dbg(&host->pdev->dev, "IRQ: not_busy\n");
+			dev_dbg(dev, "IRQ: not_busy\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_NOTBUSY);
 			smp_wmb();
-			dev_dbg(&host->pdev->dev, "set pending notbusy\n");
+			dev_dbg(dev, "set pending notbusy\n");
 			atmci_set_pending(host, EVENT_NOTBUSY);
 			tasklet_schedule(&host->tasklet);
 		}
@@ -2216,11 +2217,11 @@ static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 			atmci_write_data_pio(host);
 
 		if (pending & ATMCI_CMDRDY) {
-			dev_dbg(&host->pdev->dev, "IRQ: cmd ready\n");
+			dev_dbg(dev, "IRQ: cmd ready\n");
 			atmci_writel(host, ATMCI_IDR, ATMCI_CMDRDY);
 			host->cmd_status = status;
 			smp_wmb();
-			dev_dbg(&host->pdev->dev, "set pending cmd rdy\n");
+			dev_dbg(dev, "set pending cmd rdy\n");
 			atmci_set_pending(host, EVENT_CMD_RDY);
 			tasklet_schedule(&host->tasklet);
 		}
@@ -2252,11 +2253,12 @@ static int atmci_init_slot(struct atmel_mci *host,
 		struct mci_slot_pdata *slot_data, unsigned int id,
 		u32 sdc_reg, u32 sdio_irq)
 {
+	struct device			*dev = &host->pdev->dev;
 	struct mmc_host			*mmc;
 	struct atmel_mci_slot		*slot;
 	int ret;
 
-	mmc = mmc_alloc_host(sizeof(struct atmel_mci_slot), &host->pdev->dev);
+	mmc = mmc_alloc_host(sizeof(struct atmel_mci_slot), dev);
 	if (!mmc)
 		return -ENOMEM;
 
@@ -2375,12 +2377,13 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 
 static int atmci_configure_dma(struct atmel_mci *host)
 {
-	host->dma.chan = dma_request_chan(&host->pdev->dev, "rxtx");
+	struct device *dev = &host->pdev->dev;
+
+	host->dma.chan = dma_request_chan(dev, "rxtx");
 	if (IS_ERR(host->dma.chan))
 		return PTR_ERR(host->dma.chan);
 
-	dev_info(&host->pdev->dev, "using %s for DMA transfers\n",
-		 dma_chan_name(host->dma.chan));
+	dev_info(dev, "using %s for DMA transfers\n", dma_chan_name(host->dma.chan));
 
 	host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
 	host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -2400,11 +2403,11 @@ static int atmci_configure_dma(struct atmel_mci *host)
  */
 static void atmci_get_cap(struct atmel_mci *host)
 {
+	struct device *dev = &host->pdev->dev;
 	unsigned int version;
 
 	version = atmci_get_version(host);
-	dev_info(&host->pdev->dev,
-			"version: 0x%x\n", version);
+	dev_info(dev, "version: 0x%x\n", version);
 
 	host->caps.has_dma_conf_reg = false;
 	host->caps.has_pdc = true;
@@ -2445,14 +2448,14 @@ static void atmci_get_cap(struct atmel_mci *host)
 		break;
 	default:
 		host->caps.has_pdc = false;
-		dev_warn(&host->pdev->dev,
-				"Unmanaged mci version, set minimum capabilities\n");
+		dev_warn(dev, "Unmanaged mci version, set minimum capabilities\n");
 		break;
 	}
 }
 
 static int atmci_probe(struct platform_device *pdev)
 {
+	struct device			*dev = &pdev->dev;
 	struct mci_platform_data	*pdata;
 	struct atmel_mci		*host;
 	struct resource			*regs;
@@ -2464,9 +2467,9 @@ static int atmci_probe(struct platform_device *pdev)
 	if (!regs)
 		return -ENXIO;
 
-	pdata = atmci_of_init(pdev);
+	pdata = atmci_of_init(dev);
 	if (IS_ERR(pdata)) {
-		dev_err(&pdev->dev, "platform data not available\n");
+		dev_err(dev, "platform data not available\n");
 		return PTR_ERR(pdata);
 	}
 
@@ -2474,7 +2477,7 @@ static int atmci_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
+	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
 	if (!host)
 		return -ENOMEM;
 
@@ -2482,11 +2485,11 @@ static int atmci_probe(struct platform_device *pdev)
 	spin_lock_init(&host->lock);
 	INIT_LIST_HEAD(&host->queue);
 
-	host->mck = devm_clk_get(&pdev->dev, "mci_clk");
+	host->mck = devm_clk_get(dev, "mci_clk");
 	if (IS_ERR(host->mck))
 		return PTR_ERR(host->mck);
 
-	host->regs = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
+	host->regs = devm_ioremap(dev, regs->start, resource_size(regs));
 	if (!host->regs)
 		return -ENOMEM;
 
@@ -2501,7 +2504,7 @@ static int atmci_probe(struct platform_device *pdev)
 
 	tasklet_setup(&host->tasklet, atmci_tasklet_func);
 
-	ret = request_irq(irq, atmci_interrupt, 0, dev_name(&pdev->dev), host);
+	ret = request_irq(irq, atmci_interrupt, 0, dev_name(dev), host);
 	if (ret) {
 		clk_disable_unprepare(host->mck);
 		return ret;
@@ -2517,12 +2520,12 @@ static int atmci_probe(struct platform_device *pdev)
 		host->submit_data = &atmci_submit_data_dma;
 		host->stop_transfer = &atmci_stop_transfer_dma;
 	} else if (host->caps.has_pdc) {
-		dev_info(&pdev->dev, "using PDC\n");
+		dev_info(dev, "using PDC\n");
 		host->prepare_data = &atmci_prepare_data_pdc;
 		host->submit_data = &atmci_submit_data_pdc;
 		host->stop_transfer = &atmci_stop_transfer_pdc;
 	} else {
-		dev_info(&pdev->dev, "using PIO\n");
+		dev_info(dev, "using PIO\n");
 		host->prepare_data = &atmci_prepare_data;
 		host->submit_data = &atmci_submit_data;
 		host->stop_transfer = &atmci_stop_transfer;
@@ -2532,11 +2535,11 @@ static int atmci_probe(struct platform_device *pdev)
 
 	timer_setup(&host->timer, atmci_timeout_timer, 0);
 
-	pm_runtime_get_noresume(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(&pdev->dev);
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_set_autosuspend_delay(dev, AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
 
 	/* We need at least one slot to succeed */
 	nr_slots = 0;
@@ -2561,27 +2564,26 @@ static int atmci_probe(struct platform_device *pdev)
 	}
 
 	if (!nr_slots) {
-		dev_err(&pdev->dev, "init failed: no slot defined\n");
+		dev_err(dev, "init failed: no slot defined\n");
 		goto err_init_slot;
 	}
 
 	if (!host->caps.has_rwproof) {
-		host->buffer = dma_alloc_coherent(&pdev->dev, host->buf_size,
+		host->buffer = dma_alloc_coherent(dev, host->buf_size,
 		                                  &host->buf_phys_addr,
 						  GFP_KERNEL);
 		if (!host->buffer) {
 			ret = -ENOMEM;
-			dev_err(&pdev->dev, "buffer allocation failed\n");
+			dev_err(dev, "buffer allocation failed\n");
 			goto err_dma_alloc;
 		}
 	}
 
-	dev_info(&pdev->dev,
-			"Atmel MCI controller at 0x%08lx irq %d, %u slots\n",
-			host->mapbase, irq, nr_slots);
+	dev_info(dev, "Atmel MCI controller at 0x%08lx irq %d, %u slots\n",
+		 host->mapbase, irq, nr_slots);
 
-	pm_runtime_mark_last_busy(&host->pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
@@ -2593,8 +2595,8 @@ static int atmci_probe(struct platform_device *pdev)
 err_init_slot:
 	clk_disable_unprepare(host->mck);
 
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 
 	del_timer_sync(&host->timer);
 	if (!IS_ERR(host->dma.chan))
@@ -2607,13 +2609,13 @@ static int atmci_probe(struct platform_device *pdev)
 static void atmci_remove(struct platform_device *pdev)
 {
 	struct atmel_mci	*host = platform_get_drvdata(pdev);
+	struct device		*dev = &pdev->dev;
 	unsigned int		i;
 
-	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_get_sync(dev);
 
 	if (host->buffer)
-		dma_free_coherent(&pdev->dev, host->buf_size,
-		                  host->buffer, host->buf_phys_addr);
+		dma_free_coherent(dev, host->buf_size, host->buffer, host->buf_phys_addr);
 
 	for (i = 0; i < ATMCI_MAX_NR_SLOTS; i++) {
 		if (host->slot[i])
@@ -2632,8 +2634,8 @@ static void atmci_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(host->mck);
 
-	pm_runtime_disable(&pdev->dev);
-	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 }
 
 #ifdef CONFIG_PM
-- 
2.43.0.rc1.1336.g36b5255a03ac


