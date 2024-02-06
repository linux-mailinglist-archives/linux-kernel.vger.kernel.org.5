Return-Path: <linux-kernel+bounces-54272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6984F84AD11
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE5E1F2428A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF06A74E32;
	Tue,  6 Feb 2024 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bEogXcmU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6B041C65;
	Tue,  6 Feb 2024 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707191039; cv=none; b=Z4Qxe49zZHAwsbkD40TypQxDbeb92HJwpUoaCVbc18R12ATXopcsoh6y3hU2TXWQ22Ql3bFRkwQQaaLvM3LXSNZTMMvE5mHBOMcF6nUOmpW/h4Cc8mgCU0JtYHngPtthcj4tZgpmOiBy+uHYZtCgkBWnWsdvgihYfu2r9+EUQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707191039; c=relaxed/simple;
	bh=+HGZrtoYReLV92zkWLbJzfjCrXzgufEBE0VAyMAHRNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnmZxoLc418F7TOITvkRJtTKseSNYOcrzX+XN+LynwwlOFHK12JoEGjdTd3VQlsPnpGzd9FlR3saspLGNcBmNQlv6Y1mQhcshBKRtKMpFknwpRxD6jfh39MpAXg9k0SNS8smiECyQKc0UD4zX4xUS4KIVSN9mrSg+y6SF+GFPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bEogXcmU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707191036; x=1738727036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+HGZrtoYReLV92zkWLbJzfjCrXzgufEBE0VAyMAHRNw=;
  b=bEogXcmUl26dShQYch4PP46gYQoHWye3uMnRitEFDQs9DvJDh0Y8WEKO
   EnX2Cew5xVu5yNWyLWNF85E2YpUKsBaUXPv5460vNbjZr1zBkJ7BEUT0g
   Y9J9C7VzrGy1ofb+zwxHDjAXO7ouI5KXi69fqBcX7Sx+KVNirgtcB5DQr
   oTKRObgD20CvP2sgtkeWg9DcoZ1EDSsQ5WW9DzJtlgeTC36j6H2YGOCQ9
   bHQZsUxlXZO1vRa8YCDFDmAaD32Oj99LfcXFTPnsPz0BzQvKrDrcyQcXB
   wo9DXRcudvzs9lyxqbSzOElwIELCmtoRQlna+Rcg3gR3DYm9s/zdOH1oY
   g==;
X-CSE-ConnectionGUID: fiSYXhrfTQy9hSpjm7+bzA==
X-CSE-MsgGUID: tAzQCGiwRgCjpBqkpJ93ow==
X-IronPort-AV: E=Sophos;i="6.05,246,1701154800"; 
   d="scan'208";a="15826651"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 20:43:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:43:23 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 20:43:21 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v2 SPI for-next 3/3] spi: mchp-pci1xxxx: DMA Write Support for copying data from SPI Buf
Date: Tue, 6 Feb 2024 09:11:18 +0530
Message-ID: <20240206034118.748801-4-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206034118.748801-1-thangaraj.s@microchip.com>
References: <20240206034118.748801-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

DMA Write setup is done in pci1xxxx_spi_transfer_with_dma, before
initiating the transaction. Once the SPI transaction complete interrupt
is received, doorbell is written to initiate DMA Write. DMA Write operation
copies the data from SPI RX buffer to CPU buffer.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 140 ++++++++++++++++++++++++++++++-------
 1 file changed, 115 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 2b2f55a0b5a5..c93224d74e65 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -57,8 +57,13 @@
 /* DMA Related Registers */
 #define SPI_DMA_ADDR_BASE		(0x1000)
 #define SPI_DMA_GLOBAL_WR_ENGINE_EN	(SPI_DMA_ADDR_BASE + 0x0C)
+#define SPI_DMA_WR_DOORBELL_REG		(SPI_DMA_ADDR_BASE + 0x10)
 #define SPI_DMA_GLOBAL_RD_ENGINE_EN	(SPI_DMA_ADDR_BASE + 0x2C)
 #define SPI_DMA_RD_DOORBELL_REG		(SPI_DMA_ADDR_BASE + 0x30)
+#define SPI_DMA_INTR_WR_STS		(SPI_DMA_ADDR_BASE + 0x4C)
+#define SPI_DMA_WR_INT_MASK		(SPI_DMA_ADDR_BASE + 0x54)
+#define SPI_DMA_INTR_WR_CLR		(SPI_DMA_ADDR_BASE + 0x58)
+#define SPI_DMA_ERR_WR_STS		(SPI_DMA_ADDR_BASE + 0x5C)
 #define SPI_DMA_INTR_IMWR_WDONE_LOW	(SPI_DMA_ADDR_BASE + 0x60)
 #define SPI_DMA_INTR_IMWR_WDONE_HIGH	(SPI_DMA_ADDR_BASE + 0x64)
 #define SPI_DMA_INTR_IMWR_WABORT_LOW	(SPI_DMA_ADDR_BASE + 0x68)
@@ -74,7 +79,9 @@
 #define SPI_DMA_INTR_IMWR_RABORT_HIGH	(SPI_DMA_ADDR_BASE + 0xD8)
 #define SPI_DMA_INTR_RD_IMWR_DATA	(SPI_DMA_ADDR_BASE + 0xDC)
 
+#define SPI_DMA_CH0_WR_BASE		(SPI_DMA_ADDR_BASE + 0x200)
 #define SPI_DMA_CH0_RD_BASE		(SPI_DMA_ADDR_BASE + 0x300)
+#define SPI_DMA_CH1_WR_BASE		(SPI_DMA_ADDR_BASE + 0x400)
 #define SPI_DMA_CH1_RD_BASE		(SPI_DMA_ADDR_BASE + 0x500)
 
 #define SPI_DMA_CH_CTL1_OFFSET		(0x00)
@@ -129,15 +136,17 @@ struct pci1xxxx_spi_internal {
 	int irq;
 	int mode;
 	bool spi_xfer_in_progress;
+	void *rx_buf;
 	bool dma_aborted_rd;
 	u32 bytes_recvd;
 	u32 tx_sgl_len;
+	u32 rx_sgl_len;
 	struct scatterlist *tx_sgl, *rx_sgl;
+	bool dma_aborted_wr;
 	struct completion spi_xfer_done;
 	struct spi_controller *spi_host;
 	struct pci1xxxx_spi *parent;
 	struct spi_transfer *xfer;
-	void *rx_buf;
 	struct {
 		unsigned int dev_sel : 3;
 		unsigned int msi_vector_sel : 1;
@@ -351,6 +360,26 @@ static void pci1xxxx_spi_setup_dma_read(struct pci1xxxx_spi_internal *p,
 	       base + SPI_DMA_CH_DAR_HI_OFFSET);
 }
 
+static void pci1xxxx_spi_setup_dma_write(struct pci1xxxx_spi_internal *p,
+					 dma_addr_t dma_addr, u32 len)
+{
+	void *base;
+
+	if (!p->hw_inst)
+		base = p->parent->dma_offset_bar + SPI_DMA_CH0_WR_BASE;
+	else
+		base = p->parent->dma_offset_bar + SPI_DMA_CH1_WR_BASE;
+
+	writel(DMA_INTR_EN, base + SPI_DMA_CH_CTL1_OFFSET);
+	writel(len, base + SPI_DMA_CH_XFER_LEN_OFFSET);
+	writel(lower_32_bits(dma_addr), base + SPI_DMA_CH_DAR_LO_OFFSET);
+	writel(upper_32_bits(dma_addr), base + SPI_DMA_CH_DAR_HI_OFFSET);
+	writel(lower_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_RSP_BUF_OFFSET(p->hw_inst)),
+	       base + SPI_DMA_CH_SAR_LO_OFFSET);
+	writel(upper_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_RSP_BUF_OFFSET(p->hw_inst)),
+	       base + SPI_DMA_CH_SAR_HI_OFFSET);
+}
+
 static void pci1xxxx_spi_setup(struct pci1xxxx_spi *par, u8 hw_inst, u32 mode,
 			       u8 clkdiv, u32 len)
 {
@@ -444,12 +473,17 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 {
 	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi_ctlr);
 	struct pci1xxxx_spi *par = p->parent;
+	dma_addr_t rx_dma_addr = 0;
 	dma_addr_t tx_dma_addr = 0;
 	int ret = 0;
 	u32 regval;
 
 	p->spi_xfer_in_progress = true;
 	p->tx_sgl = xfer->tx_sg.sgl;
+	p->rx_sgl = xfer->rx_sg.sgl;
+	p->rx_buf = xfer->rx_buf;
+	regval = readl(par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
+	writel(regval, par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 
 	if (!xfer->tx_buf || !p->tx_sgl) {
 		ret = -EINVAL;
@@ -464,10 +498,13 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 	writel(regval, par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 
 	tx_dma_addr = sg_dma_address(p->tx_sgl);
+	rx_dma_addr = sg_dma_address(p->rx_sgl);
 	p->tx_sgl_len = sg_dma_len(p->tx_sgl);
+	p->rx_sgl_len = sg_dma_len(p->rx_sgl);
 	pci1xxxx_spi_setup(par, p->hw_inst, p->mode, p->clkdiv, p->tx_sgl_len);
-
 	pci1xxxx_spi_setup_dma_read(p, (tx_dma_addr), p->tx_sgl_len);
+	if (rx_dma_addr)
+		pci1xxxx_spi_setup_dma_write(p, rx_dma_addr, p->rx_sgl_len);
 	writel(p->hw_inst, par->dma_offset_bar + SPI_DMA_RD_DOORBELL_REG);
 
 	reinit_completion(&p->spi_xfer_done);
@@ -494,8 +531,30 @@ static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
 			       par->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
 			p->dma_aborted_rd = false;
 			ret = -ECANCELED;
-			goto error;
 		}
+		if (p->dma_aborted_wr) {
+			writel(SPI_DMA_ENGINE_DIS,
+			       par->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
+
+			/*
+			 * DMA ENGINE reset takes time if any TLP
+			 * completeion in progress, should wait
+			 * till DMA Engine reset is completed.
+			 */
+			ret = readl_poll_timeout(par->dma_offset_bar +
+						 SPI_DMA_GLOBAL_WR_ENGINE_EN, regval,
+						 (regval == 0x0), 0, USEC_PER_MSEC);
+			if (ret) {
+				ret = -ECANCELED;
+				goto error;
+			}
+
+			writel(SPI_DMA_ENGINE_EN,
+			       par->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
+			p->dma_aborted_wr = false;
+			ret = -ECANCELED;
+		}
+		goto error;
 	}
 	ret = 0;
 
@@ -524,19 +583,50 @@ static irqreturn_t pci1xxxx_spi_isr_io(int irq, void *dev)
 	regval = readl(p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	if (regval & SPI_INTR) {
 		/* Clear xfer_done */
-		complete(&p->spi_xfer_done);
+		if (p->parent->can_dma && p->rx_buf)
+			writel(p->hw_inst, p->parent->dma_offset_bar +
+			       SPI_DMA_WR_DOORBELL_REG);
+		else
+			complete(&p->parent->spi_int[p->hw_inst]->spi_xfer_done);
 		spi_int_fired = IRQ_HANDLED;
 	}
 	writel(regval, p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	return spi_int_fired;
 }
 
+static void pci1xxxx_spi_setup_next_dma_transfer(struct pci1xxxx_spi_internal *p)
+{
+	dma_addr_t tx_dma_addr = 0;
+	dma_addr_t rx_dma_addr = 0;
+	u32 prev_len;
+
+	p->tx_sgl = sg_next(p->tx_sgl);
+	if (p->rx_sgl)
+		p->rx_sgl = sg_next(p->rx_sgl);
+	if (!p->tx_sgl) {
+		/* Clear xfer_done */
+		complete(&p->spi_xfer_done);
+	} else {
+		tx_dma_addr = sg_dma_address(p->tx_sgl);
+		prev_len = p->tx_sgl_len;
+		p->tx_sgl_len = sg_dma_len(p->tx_sgl);
+		if (prev_len != p->tx_sgl_len)
+			pci1xxxx_spi_setup(p->parent,
+					   p->hw_inst, p->mode, p->clkdiv, p->tx_sgl_len);
+		pci1xxxx_spi_setup_dma_read(p, tx_dma_addr, p->tx_sgl_len);
+		if (p->rx_sgl) {
+			rx_dma_addr = sg_dma_address(p->rx_sgl);
+			p->rx_sgl_len = sg_dma_len(p->rx_sgl);
+			pci1xxxx_spi_setup_dma_write(p, rx_dma_addr, p->rx_sgl_len);
+		}
+		writel(p->hw_inst, p->parent->dma_offset_bar + SPI_DMA_RD_DOORBELL_REG);
+	}
+}
+
 static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
 {
 	struct pci1xxxx_spi_internal *p = dev;
 	irqreturn_t spi_int_fired = IRQ_NONE;
-	dma_addr_t tx_dma_addr = 0;
-	void *rx_buf = NULL;
 	unsigned long flags;
 	u32 regval;
 
@@ -555,30 +645,30 @@ static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
 		spi_int_fired = IRQ_HANDLED;
 	}
 	writel(regval, p->parent->dma_offset_bar + SPI_DMA_INTR_RD_CLR);
+
+	/* Clear the DMA WR INT */
+	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_WR_STS);
+	if (regval & SPI_DMA_DONE_INT_MASK) {
+		if (regval & SPI_DMA_CH0_DONE_INT)
+			pci1xxxx_spi_setup_next_dma_transfer(p->parent->spi_int[SPI0]);
+
+		if (regval & SPI_DMA_CH1_DONE_INT)
+			pci1xxxx_spi_setup_next_dma_transfer(p->parent->spi_int[SPI1]);
+
+		spi_int_fired = IRQ_HANDLED;
+	}
+	if (regval & SPI_DMA_ABORT_INT_MASK) {
+		p->dma_aborted_wr = true;
+		spi_int_fired = IRQ_HANDLED;
+	}
+	writel(regval, p->parent->dma_offset_bar + SPI_DMA_INTR_WR_CLR);
 	spin_unlock_irqrestore(&p->parent->dma_reg_lock, flags);
 
 	/* Clear the SPI GO_BIT Interrupt */
 	regval = readl(p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	if (regval & SPI_INTR) {
-		rx_buf = p->rx_buf;
-		memcpy_fromio(rx_buf + p->bytes_recvd, p->parent->reg_base +
-				      SPI_MST_RSP_BUF_OFFSET(p->hw_inst), p->tx_sgl_len);
-		p->bytes_recvd += p->tx_sgl_len;
-
-		p->tx_sgl = sg_next(p->tx_sgl);
-		if (!p->tx_sgl) {
-			/* Clear xfer_done */
-			complete(&p->spi_xfer_done);
-			spi_int_fired = IRQ_HANDLED;
-		} else {
-			tx_dma_addr = sg_dma_address(p->tx_sgl);
-			p->tx_sgl_len = sg_dma_len(p->tx_sgl);
-			pci1xxxx_spi_setup(p->parent, p->hw_inst, p->mode, p->clkdiv,
-					   p->tx_sgl_len);
-			pci1xxxx_spi_setup_dma_read(p, tx_dma_addr, p->tx_sgl_len);
-			writel(p->hw_inst, p->parent->dma_offset_bar +
-			       SPI_DMA_RD_DOORBELL_REG);
-		}
+		writel(p->hw_inst, p->parent->dma_offset_bar + SPI_DMA_WR_DOORBELL_REG);
+		spi_int_fired = IRQ_HANDLED;
 	}
 	writel(regval, p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	return spi_int_fired;
-- 
2.25.1


