Return-Path: <linux-kernel+bounces-148942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E88A8973
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5EC1C2311B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DDC171094;
	Wed, 17 Apr 2024 16:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaiGxc55"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631016FF4E;
	Wed, 17 Apr 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373037; cv=none; b=rcF1xcvJOmLoZq7pNvidiqqsCAiYhRZAWa4qYqrnv1CyyJQ+LbthzuKfOO4PSnB0ZjlBqSCMvcji6qbz7+8vuLkKDg8GVFDjE214beYm6SoeTeS8LTKRnefQtaTkAMyqshRA1N7wQUBmQrSTsNh8eZXLb3IokqcpxHisSSphQ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373037; c=relaxed/simple;
	bh=LgEyY0Dj0n+E/eaUiquIJNb89lvSKKm6xtvAVSaZUK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CISmBBgSRUJujB/VkoYWTV/zbzs+5CsksbqyM5xMp5n/GyAZjKy0kXEk6XNXbH1qJfUZYJgeKOSclT/bj4SynlgkoNurTtmt2DpwFZwLje2v2I4of4xXGdGsh1Mb6Zt99RUw99iyJxItYJ6MIfbfcv4MTJ0JWnb8RPmiC+9Aj08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaiGxc55; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713373035; x=1744909035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LgEyY0Dj0n+E/eaUiquIJNb89lvSKKm6xtvAVSaZUK8=;
  b=LaiGxc55bQD2yP4++8CG0809exrgIxTvclvv5WrJ6HhOxZ7Ft5OwT/gr
   h0DGmyuHhqDvm6r8jvQ2lrU6mMIcQy22qFzSIydsu1QoruJGf/+EXvAQ4
   VJrUcM3dSiQ0ssKWcoDT+WDQb0EjstkRJJlZttuZhbUlk5ZfVktp3pBus
   ANTugvd+4sOzeD9ewmn4tYIJpRO8P8Jt4xAxt0bXQFskVYueDBcsnQm9s
   imlqvrCbbtWKhl3i0/rXd5TgdnT+W4wxGPqSQ0fyxQ7+eE+mczGcbCpwh
   Wk/+Mm49fl96/EfO+XHehpm+cTxSo0YBUrquAx+pzi8/P7oEQWJOyFjNZ
   g==;
X-CSE-ConnectionGUID: i5G4lYLERAOVYa1N5xXakw==
X-CSE-MsgGUID: mVy314HmTsCr7yM5sugQNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="20026881"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="20026881"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:57:15 -0700
X-CSE-ConnectionGUID: 4FR48OaCTi+ghTGOOPRKog==
X-CSE-MsgGUID: tOtKEfcRQfKK5M+maqD5Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="22766943"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 17 Apr 2024 09:57:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id ACB48491; Wed, 17 Apr 2024 19:57:11 +0300 (EEST)
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
Subject: [PATCH v1 3/5] mmc: atmel-mci: Replace platform device pointer by generic one
Date: Wed, 17 Apr 2024 19:55:15 +0300
Message-ID: <20240417165708.2965612-4-andriy.shevchenko@linux.intel.com>
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

There no need to keep a pointer to a platform device as it's not
used outside of ->probe() and ->remove() callbacks.

Replace platform device pointer by generic one in host structure.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/atmel-mci.c | 44 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index c4dfd4c7785f..3aed57c392fa 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -296,7 +296,7 @@ struct atmel_mci_dma {
  *	rate and timeout calculations.
  * @mapbase: Physical address of the MMIO registers.
  * @mck: The peripheral bus clock hooked up to the MMC controller.
- * @pdev: Platform device associated with the MMC controller.
+ * @dev: Device associated with the MMC controller.
  * @slot: Slots sharing this MMC controller.
  * @caps: MCI capabilities depending on MCI version.
  * @prepare_data: function to setup MCI before data transfer which
@@ -373,7 +373,7 @@ struct atmel_mci {
 	unsigned long		bus_hz;
 	unsigned long		mapbase;
 	struct clk		*mck;
-	struct platform_device	*pdev;
+	struct device		*dev;
 
 	struct atmel_mci_slot	*slot[ATMCI_MAX_NR_SLOTS];
 
@@ -526,7 +526,7 @@ static void atmci_show_status_reg(struct seq_file *s,
 static int atmci_regs_show(struct seq_file *s, void *v)
 {
 	struct atmel_mci	*host = s->private;
-	struct device		*dev = &host->pdev->dev;
+	struct device		*dev = host->dev;
 	u32			*buf;
 	int			ret = 0;
 
@@ -726,7 +726,7 @@ static inline unsigned int atmci_convert_chksize(struct atmel_mci *host,
 static void atmci_timeout_timer(struct timer_list *t)
 {
 	struct atmel_mci *host = from_timer(host, t, timer);
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 
 	dev_dbg(dev, "software timeout\n");
 
@@ -846,7 +846,7 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
 static void atmci_send_command(struct atmel_mci *host,
 		struct mmc_command *cmd, u32 cmd_flags)
 {
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 	unsigned int timeout_ms = cmd->busy_timeout ? cmd->busy_timeout :
 		ATMCI_CMD_TIMEOUT_MS;
 
@@ -863,7 +863,7 @@ static void atmci_send_command(struct atmel_mci *host,
 
 static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
 {
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 
 	dev_dbg(dev, "send stop command\n");
 	atmci_send_command(host, data->stop, host->stop_cmdr);
@@ -937,8 +937,8 @@ static void atmci_pdc_set_both_buf(struct atmel_mci *host, int dir)
  */
 static void atmci_pdc_cleanup(struct atmel_mci *host)
 {
-	struct device		*dev = &host->pdev->dev;
 	struct mmc_data         *data = host->data;
+	struct device		*dev = host->dev;
 
 	if (data)
 		dma_unmap_sg(dev, data->sg, data->sg_len, mmc_get_dma_dir(data));
@@ -951,7 +951,7 @@ static void atmci_pdc_cleanup(struct atmel_mci *host)
  */
 static void atmci_pdc_complete(struct atmel_mci *host)
 {
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 	int transfer_size = host->data->blocks * host->data->blksz;
 	int i;
 
@@ -989,8 +989,8 @@ static void atmci_dma_cleanup(struct atmel_mci *host)
 static void atmci_dma_complete(void *arg)
 {
 	struct atmel_mci	*host = arg;
-	struct device		*dev = &host->pdev->dev;
 	struct mmc_data		*data = host->data;
+	struct device		*dev = host->dev;
 
 	dev_vdbg(dev, "DMA complete\n");
 
@@ -1079,7 +1079,7 @@ static u32 atmci_prepare_data(struct atmel_mci *host, struct mmc_data *data)
 static u32
 atmci_prepare_data_pdc(struct atmel_mci *host, struct mmc_data *data)
 {
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 	u32 iflags, tmp;
 	int i;
 
@@ -1231,7 +1231,7 @@ atmci_submit_data_dma(struct atmel_mci *host, struct mmc_data *data)
 
 static void atmci_stop_transfer(struct atmel_mci *host)
 {
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 
 	dev_dbg(dev, "(%s) set pending xfer complete\n", __func__);
 	atmci_set_pending(host, EVENT_XFER_COMPLETE);
@@ -1249,7 +1249,7 @@ static void atmci_stop_transfer_pdc(struct atmel_mci *host)
 static void atmci_stop_transfer_dma(struct atmel_mci *host)
 {
 	struct dma_chan *chan = host->data_chan;
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 
 	if (chan) {
 		dmaengine_terminate_all(chan);
@@ -1269,7 +1269,7 @@ static void atmci_stop_transfer_dma(struct atmel_mci *host)
 static void atmci_start_request(struct atmel_mci *host,
 		struct atmel_mci_slot *slot)
 {
-	struct device		*dev = &host->pdev->dev;
+	struct device		*dev = host->dev;
 	struct mmc_request	*mrq;
 	struct mmc_command	*cmd;
 	struct mmc_data		*data;
@@ -1364,7 +1364,7 @@ static void atmci_start_request(struct atmel_mci *host,
 static void atmci_queue_request(struct atmel_mci *host,
 		struct atmel_mci_slot *slot, struct mmc_request *mrq)
 {
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 
 	dev_vdbg(&slot->mmc->class_dev, "queue request: state=%d\n",
 			host->state);
@@ -1385,7 +1385,7 @@ static void atmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct atmel_mci_slot	*slot = mmc_priv(mmc);
 	struct atmel_mci	*host = slot->host;
-	struct device		*dev = &host->pdev->dev;
+	struct device		*dev = host->dev;
 	struct mmc_data		*data;
 
 	WARN_ON(slot->mrq);
@@ -1599,7 +1599,7 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
 {
 	struct atmel_mci_slot	*slot = NULL;
 	struct mmc_host		*prev_mmc = host->cur_slot->mmc;
-	struct device		*dev = &host->pdev->dev;
+	struct device		*dev = host->dev;
 
 	WARN_ON(host->cmd || host->data);
 
@@ -1760,9 +1760,9 @@ static void atmci_detect_change(struct timer_list *t)
 static void atmci_tasklet_func(struct tasklet_struct *t)
 {
 	struct atmel_mci        *host = from_tasklet(host, t, tasklet);
-	struct device		*dev = &host->pdev->dev;
 	struct mmc_request	*mrq = host->mrq;
 	struct mmc_data		*data = host->data;
+	struct device		*dev = host->dev;
 	enum atmel_mci_state	state = host->state;
 	enum atmel_mci_state	prev_state;
 	u32			status;
@@ -2108,7 +2108,7 @@ static void atmci_sdio_interrupt(struct atmel_mci *host, u32 status)
 static irqreturn_t atmci_interrupt(int irq, void *dev_id)
 {
 	struct atmel_mci	*host = dev_id;
-	struct device		*dev = &host->pdev->dev;
+	struct device		*dev = host->dev;
 	u32			status, mask, pending;
 	unsigned int		pass_count = 0;
 
@@ -2253,7 +2253,7 @@ static int atmci_init_slot(struct atmel_mci *host,
 		struct mci_slot_pdata *slot_data, unsigned int id,
 		u32 sdc_reg, u32 sdio_irq)
 {
-	struct device			*dev = &host->pdev->dev;
+	struct device			*dev = host->dev;
 	struct mmc_host			*mmc;
 	struct atmel_mci_slot		*slot;
 	int ret;
@@ -2377,7 +2377,7 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 
 static int atmci_configure_dma(struct atmel_mci *host)
 {
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 
 	host->dma.chan = dma_request_chan(dev, "rxtx");
 	if (IS_ERR(host->dma.chan))
@@ -2403,7 +2403,7 @@ static int atmci_configure_dma(struct atmel_mci *host)
  */
 static void atmci_get_cap(struct atmel_mci *host)
 {
-	struct device *dev = &host->pdev->dev;
+	struct device *dev = host->dev;
 	unsigned int version;
 
 	version = atmci_get_version(host);
@@ -2481,7 +2481,7 @@ static int atmci_probe(struct platform_device *pdev)
 	if (!host)
 		return -ENOMEM;
 
-	host->pdev = pdev;
+	host->dev = dev;
 	spin_lock_init(&host->lock);
 	INIT_LIST_HEAD(&host->queue);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


