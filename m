Return-Path: <linux-kernel+bounces-54271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C282184AD10
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEDF1F240A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC474E1E;
	Tue,  6 Feb 2024 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2b8iyz/z"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5682E745C9;
	Tue,  6 Feb 2024 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707191038; cv=none; b=TFORH2czad5cjEiKKrSX+RRWQQfwuu5+5zAbsuC64lqkBqR/GUU6CiTA3o5byuFy0qphGUJX/Yqod8PYn9nfSKJyroGJ2l8J3hopLgXpBg6Na/9Bk+3i8xjFLkMNYIzjygChlSJko92V0l/i9Yrj6lq3CbZDmZgMVmsqxBem8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707191038; c=relaxed/simple;
	bh=9wMMxsq97VMG9IVWdgT8bDy3/uzggkUUU3wkwGfqBqw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMAqyQ0iU81b306IpY8NaRUE/xlbgFJdLRHIxdoWneDFmEux6byxHRgeRogzeZWeNMweFxGQqRrNCRYBkodjjXbyvfYpx8UKUEbdGEZI66/98o2/r1lDpzD9Gl2HZOwCRtvTqIkbmvPeyxz5mpZ2EPDZ6lkzYsrFYb7EYwW09+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2b8iyz/z; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707191036; x=1738727036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9wMMxsq97VMG9IVWdgT8bDy3/uzggkUUU3wkwGfqBqw=;
  b=2b8iyz/z1TkJc2gUsQGMPbYfcM1u9EuuusgVjr7TR6jJFYGHzoAPwUtF
   /m/rxjdSSKC8XYDTOnaXlIoQ6M7oATwBD8/v50KSyqWWlePUKApdG+bQ0
   Sekcw5S9HQmjPoUwDHipcelzWiRRyd7dLqtkPoD+8MPgLFcCdlLTxOg55
   Ro321/2hhJRwTbpUzP6Vt9uFwy6RbMLNYTzk1B92DXChllsRe2zptEcGZ
   YafYrN36gVqGMchtOhtfeeFY4htBc3KmWXQm+ktDeoRgPpHlAAvWRhBaK
   ui9DFgsG5+tTEYeuHID7PstMKTRMUpj/eOmmatbi0KDA72+z05379s1ci
   Q==;
X-CSE-ConnectionGUID: fiSYXhrfTQy9hSpjm7+bzA==
X-CSE-MsgGUID: lTKfHHPsR7uvPnxLe+XRmw==
X-IronPort-AV: E=Sophos;i="6.05,246,1701154800"; 
   d="scan'208";a="15826649"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Feb 2024 20:43:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 20:43:20 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 20:43:18 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v2 SPI for-next 2/3] spi: mchp-pci1xxxx: DMA Read support for copying data into SPI Buf
Date: Tue, 6 Feb 2024 09:11:17 +0530
Message-ID: <20240206034118.748801-3-thangaraj.s@microchip.com>
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

pci1xxxx_spi_transfer_with_dma is registered as transfer_one callback
when DMA can be supported. This function adds DMA read operation which
copies the data from host cpu buffer to SPI Tx Buffer.
On DMA Read Completion interrupt, SPI transaction is initiated in isr.
Helper functions pci1xxxx_spi_setup, pci1xxxx_spi_setup_dma_read and
pci1xxxx_start_spi_xfer are added for starting spi transfer, setting up
spi and dma read operation. In the existing implementation, codes are
replaced with helper wherever applicable.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 275 +++++++++++++++++++++++++++++++++----
 1 file changed, 248 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 85a6068b244d..2b2f55a0b5a5 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -5,6 +5,7 @@
 //          Kumaravel Thiagarajan <Kumaravel.Thiagarajan@microchip.com>
 
 
+#include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
@@ -12,6 +13,7 @@
 #include <linux/msi.h>
 #include <linux/pci_regs.h>
 #include <linux/pci.h>
+#include <linux/spinlock.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
 
@@ -37,6 +39,7 @@
 #define	SPI_MST_CTL_MODE_SEL		(BIT(2))
 #define	SPI_MST_CTL_GO			(BIT(0))
 
+#define SPI_PERI_ADDR_BASE		(0x160000)
 #define SPI_SYSTEM_ADDR_BASE		(0x2000)
 #define	SPI_MST1_ADDR_BASE		(0x800)
 
@@ -48,22 +51,49 @@
 #define DEV_REV_MASK			(GENMASK(7, 0))
 
 #define SPI_SYSLOCK			BIT(4)
+#define SPI0				(0)
+#define SPI1				(1)
 
 /* DMA Related Registers */
 #define SPI_DMA_ADDR_BASE		(0x1000)
 #define SPI_DMA_GLOBAL_WR_ENGINE_EN	(SPI_DMA_ADDR_BASE + 0x0C)
 #define SPI_DMA_GLOBAL_RD_ENGINE_EN	(SPI_DMA_ADDR_BASE + 0x2C)
+#define SPI_DMA_RD_DOORBELL_REG		(SPI_DMA_ADDR_BASE + 0x30)
 #define SPI_DMA_INTR_IMWR_WDONE_LOW	(SPI_DMA_ADDR_BASE + 0x60)
 #define SPI_DMA_INTR_IMWR_WDONE_HIGH	(SPI_DMA_ADDR_BASE + 0x64)
 #define SPI_DMA_INTR_IMWR_WABORT_LOW	(SPI_DMA_ADDR_BASE + 0x68)
 #define SPI_DMA_INTR_IMWR_WABORT_HIGH	(SPI_DMA_ADDR_BASE + 0x6C)
 #define SPI_DMA_INTR_WR_IMWR_DATA	(SPI_DMA_ADDR_BASE + 0x70)
+#define SPI_DMA_INTR_RD_STS		(SPI_DMA_ADDR_BASE + 0xA0)
+#define SPI_DMA_RD_INT_MASK		(SPI_DMA_ADDR_BASE + 0xA8)
+#define SPI_DMA_INTR_RD_CLR		(SPI_DMA_ADDR_BASE + 0xAC)
+#define SPI_DMA_ERR_RD_STS		(SPI_DMA_ADDR_BASE + 0xB8)
 #define SPI_DMA_INTR_IMWR_RDONE_LOW	(SPI_DMA_ADDR_BASE + 0xCC)
 #define SPI_DMA_INTR_IMWR_RDONE_HIGH	(SPI_DMA_ADDR_BASE + 0xD0)
 #define SPI_DMA_INTR_IMWR_RABORT_LOW	(SPI_DMA_ADDR_BASE + 0xD4)
 #define SPI_DMA_INTR_IMWR_RABORT_HIGH	(SPI_DMA_ADDR_BASE + 0xD8)
 #define SPI_DMA_INTR_RD_IMWR_DATA	(SPI_DMA_ADDR_BASE + 0xDC)
 
+#define SPI_DMA_CH0_RD_BASE		(SPI_DMA_ADDR_BASE + 0x300)
+#define SPI_DMA_CH1_RD_BASE		(SPI_DMA_ADDR_BASE + 0x500)
+
+#define SPI_DMA_CH_CTL1_OFFSET		(0x00)
+#define SPI_DMA_CH_XFER_LEN_OFFSET	(0x08)
+#define SPI_DMA_CH_SAR_LO_OFFSET	(0x0C)
+#define SPI_DMA_CH_SAR_HI_OFFSET	(0x10)
+#define SPI_DMA_CH_DAR_LO_OFFSET	(0x14)
+#define SPI_DMA_CH_DAR_HI_OFFSET	(0x18)
+
+#define SPI_DMA_CH0_DONE_INT		BIT(0)
+#define SPI_DMA_CH1_DONE_INT		BIT(1)
+#define SPI_DMA_CH0_ABORT_INT		BIT(16)
+#define SPI_DMA_CH1_ABORT_INT		BIT(17)
+#define SPI_DMA_DONE_INT_MASK		(SPI_DMA_CH0_DONE_INT | SPI_DMA_CH1_DONE_INT)
+#define SPI_DMA_ABORT_INT_MASK		(SPI_DMA_CH0_ABORT_INT | SPI_DMA_CH1_ABORT_INT)
+#define DMA_CH_CONTROL_LIE		BIT(3)
+#define DMA_CH_CONTROL_RIE		BIT(4)
+#define DMA_INTR_EN			(DMA_CH_CONTROL_RIE | DMA_CH_CONTROL_LIE)
+
 /* x refers to SPI Host Controller HW instance id in the below macros - 0 or 1 */
 
 #define	SPI_MST_CMD_BUF_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x00)
@@ -82,6 +112,7 @@
 #define PCI1XXXX_SPI_TIMEOUT			(msecs_to_jiffies(100))
 #define SYSLOCK_RETRY_CNT			(1000)
 #define SPI_DMA_ENGINE_EN			(0x1)
+#define SPI_DMA_ENGINE_DIS			(0x0)
 
 #define SPI_INTR		BIT(8)
 #define SPI_FORCE_CE		BIT(4)
@@ -94,11 +125,19 @@
 
 struct pci1xxxx_spi_internal {
 	u8 hw_inst;
-	bool spi_xfer_in_progress;
+	u8 clkdiv;
 	int irq;
+	int mode;
+	bool spi_xfer_in_progress;
+	bool dma_aborted_rd;
+	u32 bytes_recvd;
+	u32 tx_sgl_len;
+	struct scatterlist *tx_sgl, *rx_sgl;
 	struct completion spi_xfer_done;
 	struct spi_controller *spi_host;
 	struct pci1xxxx_spi *parent;
+	struct spi_transfer *xfer;
+	void *rx_buf;
 	struct {
 		unsigned int dev_sel : 3;
 		unsigned int msi_vector_sel : 1;
@@ -111,6 +150,8 @@ struct pci1xxxx_spi {
 	u8 dev_rev;
 	void __iomem *reg_base;
 	void __iomem *dma_offset_bar;
+	/* lock to safely access the DMA registers in isr */
+	spinlock_t dma_reg_lock;
 	bool can_dma;
 	struct pci1xxxx_spi_internal *spi_int[] __counted_by(total_hw_instances);
 };
@@ -230,6 +271,7 @@ static int pci1xxxx_spi_dma_init(struct pci1xxxx_spi *spi_bus, int irq)
 	if (ret)
 		return ret;
 
+	spin_lock_init(&spi_bus->dma_reg_lock);
 	get_cached_msi_msg(irq, &msi);
 	writel(SPI_DMA_ENGINE_EN, spi_bus->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
 	writel(SPI_DMA_ENGINE_EN, spi_bus->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
@@ -243,6 +285,7 @@ static int pci1xxxx_spi_dma_init(struct pci1xxxx_spi *spi_bus, int irq)
 	writel(msi.address_lo, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_RABORT_LOW);
 	writel(msi.data, spi_bus->dma_offset_bar + SPI_DMA_INTR_WR_IMWR_DATA);
 	writel(msi.data, spi_bus->dma_offset_bar + SPI_DMA_INTR_RD_IMWR_DATA);
+	dma_set_max_seg_size(&spi_bus->dev->dev, PCI1XXXX_SPI_BUFFER_SIZE);
 	spi_bus->can_dma = true;
 	return 0;
 }
@@ -287,12 +330,59 @@ static u8 pci1xxxx_get_clock_div(u32 hz)
 	return val;
 }
 
-static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
-				     struct spi_device *spi, struct spi_transfer *xfer)
+static void pci1xxxx_spi_setup_dma_read(struct pci1xxxx_spi_internal *p,
+					dma_addr_t dma_addr, u32 len)
+{
+	void __iomem *base;
+
+	if (!p->hw_inst)
+		base = p->parent->dma_offset_bar + SPI_DMA_CH0_RD_BASE;
+	else
+		base = p->parent->dma_offset_bar + SPI_DMA_CH1_RD_BASE;
+
+	writel(DMA_INTR_EN, base + SPI_DMA_CH_CTL1_OFFSET);
+	writel(len, base + SPI_DMA_CH_XFER_LEN_OFFSET);
+	writel(lower_32_bits(dma_addr), base + SPI_DMA_CH_SAR_LO_OFFSET);
+	writel(upper_32_bits(dma_addr), base + SPI_DMA_CH_SAR_HI_OFFSET);
+	/* Updated SPI Command Registers */
+	writel(lower_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_CMD_BUF_OFFSET(p->hw_inst)),
+	       base + SPI_DMA_CH_DAR_LO_OFFSET);
+	writel(upper_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_CMD_BUF_OFFSET(p->hw_inst)),
+	       base + SPI_DMA_CH_DAR_HI_OFFSET);
+}
+
+static void pci1xxxx_spi_setup(struct pci1xxxx_spi *par, u8 hw_inst, u32 mode,
+			       u8 clkdiv, u32 len)
+{
+	u32 regval;
+
+	regval = readl(par->reg_base + SPI_MST_CTL_REG_OFFSET(hw_inst));
+	regval &= ~(SPI_MST_CTL_MODE_SEL | SPI_MST_CTL_CMD_LEN_MASK |
+		    SPI_MST_CTL_SPEED_MASK);
+
+	if (mode == SPI_MODE_3)
+		regval |= SPI_MST_CTL_MODE_SEL;
+
+	regval |= FIELD_PREP(SPI_MST_CTL_CMD_LEN_MASK, len);
+	regval |= FIELD_PREP(SPI_MST_CTL_SPEED_MASK, clkdiv);
+	writel(regval, par->reg_base + SPI_MST_CTL_REG_OFFSET(hw_inst));
+}
+
+static void pci1xxxx_start_spi_xfer(struct pci1xxxx_spi_internal *p, u8 hw_inst)
+{
+	u32 regval;
+
+	regval = readl(p->parent->reg_base + SPI_MST_CTL_REG_OFFSET(hw_inst));
+	regval |= SPI_MST_CTL_GO;
+	writel(regval, p->parent->reg_base + SPI_MST_CTL_REG_OFFSET(hw_inst));
+}
+
+static int pci1xxxx_spi_transfer_with_io(struct spi_controller *spi_ctlr,
+					 struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi_ctlr);
-	int mode, len, loop_iter, transfer_len;
 	struct pci1xxxx_spi *par = p->parent;
+	int len, loop_iter, transfer_len;
 	unsigned long bytes_transfered;
 	unsigned long bytes_recvd;
 	unsigned long loop_count;
@@ -302,7 +392,7 @@ static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
 	u8 clkdiv;
 
 	p->spi_xfer_in_progress = true;
-	mode = spi->mode;
+	p->bytes_recvd = 0;
 	clkdiv = pci1xxxx_get_clock_div(xfer->speed_hz);
 	tx_buf = xfer->tx_buf;
 	rx_buf = xfer->rx_buf;
@@ -327,26 +417,8 @@ static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
 			memcpy_toio(par->reg_base + SPI_MST_CMD_BUF_OFFSET(p->hw_inst),
 				    &tx_buf[bytes_transfered], len);
 			bytes_transfered += len;
-			regval = readl(par->reg_base +
-				       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
-			regval &= ~(SPI_MST_CTL_MODE_SEL | SPI_MST_CTL_CMD_LEN_MASK |
-				    SPI_MST_CTL_SPEED_MASK);
-
-			if (mode == SPI_MODE_3)
-				regval |= SPI_MST_CTL_MODE_SEL;
-			else
-				regval &= ~SPI_MST_CTL_MODE_SEL;
-
-			regval |= (clkdiv << 5);
-			regval &= ~SPI_MST_CTL_CMD_LEN_MASK;
-			regval |= (len << 8);
-			writel(regval, par->reg_base +
-			       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
-			regval = readl(par->reg_base +
-				       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
-			regval |= SPI_MST_CTL_GO;
-			writel(regval, par->reg_base +
-			       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
+			pci1xxxx_spi_setup(par, p->hw_inst, spi->mode, clkdiv, len);
+			pci1xxxx_start_spi_xfer(p, p->hw_inst);
 
 			/* Wait for DMA_TERM interrupt */
 			result = wait_for_completion_timeout(&p->spi_xfer_done,
@@ -366,7 +438,83 @@ static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
 	return 0;
 }
 
-static irqreturn_t pci1xxxx_spi_isr(int irq, void *dev)
+static int pci1xxxx_spi_transfer_with_dma(struct spi_controller *spi_ctlr,
+					  struct spi_device *spi,
+					  struct spi_transfer *xfer)
+{
+	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi_ctlr);
+	struct pci1xxxx_spi *par = p->parent;
+	dma_addr_t tx_dma_addr = 0;
+	int ret = 0;
+	u32 regval;
+
+	p->spi_xfer_in_progress = true;
+	p->tx_sgl = xfer->tx_sg.sgl;
+
+	if (!xfer->tx_buf || !p->tx_sgl) {
+		ret = -EINVAL;
+		goto error;
+	}
+	p->xfer = xfer;
+	p->mode = spi->mode;
+	p->clkdiv = pci1xxxx_get_clock_div(xfer->speed_hz);
+	p->bytes_recvd = 0;
+	p->rx_buf = xfer->rx_buf;
+	regval = readl(par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
+	writel(regval, par->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
+
+	tx_dma_addr = sg_dma_address(p->tx_sgl);
+	p->tx_sgl_len = sg_dma_len(p->tx_sgl);
+	pci1xxxx_spi_setup(par, p->hw_inst, p->mode, p->clkdiv, p->tx_sgl_len);
+
+	pci1xxxx_spi_setup_dma_read(p, (tx_dma_addr), p->tx_sgl_len);
+	writel(p->hw_inst, par->dma_offset_bar + SPI_DMA_RD_DOORBELL_REG);
+
+	reinit_completion(&p->spi_xfer_done);
+	/* Wait for DMA_TERM interrupt */
+	ret = wait_for_completion_timeout(&p->spi_xfer_done, PCI1XXXX_SPI_TIMEOUT);
+	if (!ret) {
+		ret = -ETIMEDOUT;
+		if (p->dma_aborted_rd) {
+			writel(SPI_DMA_ENGINE_DIS,
+			       par->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
+			/*
+			 * DMA ENGINE reset takes time if any TLP
+			 * completeion in progress, should wait
+			 * till DMA Engine reset is completed.
+			 */
+			ret = readl_poll_timeout(par->dma_offset_bar +
+						 SPI_DMA_GLOBAL_RD_ENGINE_EN, regval,
+						 (regval == 0x0), 0, USEC_PER_MSEC);
+			if (ret) {
+				ret = -ECANCELED;
+				goto error;
+			}
+			writel(SPI_DMA_ENGINE_EN,
+			       par->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
+			p->dma_aborted_rd = false;
+			ret = -ECANCELED;
+			goto error;
+		}
+	}
+	ret = 0;
+
+error:
+	p->spi_xfer_in_progress = false;
+
+	return ret;
+}
+
+static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
+				     struct spi_device *spi, struct spi_transfer *xfer)
+{
+	if (spi_ctlr->can_dma(spi_ctlr, spi, xfer) && spi_ctlr->cur_msg_mapped)
+		return pci1xxxx_spi_transfer_with_dma(spi_ctlr, spi, xfer);
+	else
+		return pci1xxxx_spi_transfer_with_io(spi_ctlr, spi, xfer);
+}
+
+static irqreturn_t pci1xxxx_spi_isr_io(int irq, void *dev)
 {
 	struct pci1xxxx_spi_internal *p = dev;
 	irqreturn_t spi_int_fired = IRQ_NONE;
@@ -379,12 +527,83 @@ static irqreturn_t pci1xxxx_spi_isr(int irq, void *dev)
 		complete(&p->spi_xfer_done);
 		spi_int_fired = IRQ_HANDLED;
 	}
-
 	writel(regval, p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
+	return spi_int_fired;
+}
 
+static irqreturn_t pci1xxxx_spi_isr_dma(int irq, void *dev)
+{
+	struct pci1xxxx_spi_internal *p = dev;
+	irqreturn_t spi_int_fired = IRQ_NONE;
+	dma_addr_t tx_dma_addr = 0;
+	void *rx_buf = NULL;
+	unsigned long flags;
+	u32 regval;
+
+	spin_lock_irqsave(&p->parent->dma_reg_lock, flags);
+	/* Clear the DMA RD INT and start spi xfer*/
+	regval = readl(p->parent->dma_offset_bar + SPI_DMA_INTR_RD_STS);
+	if (regval & SPI_DMA_DONE_INT_MASK) {
+		if (regval & SPI_DMA_CH0_DONE_INT)
+			pci1xxxx_start_spi_xfer(p, SPI0);
+		if (regval & SPI_DMA_CH1_DONE_INT)
+			pci1xxxx_start_spi_xfer(p, SPI1);
+		spi_int_fired = IRQ_HANDLED;
+	}
+	if (regval & SPI_DMA_ABORT_INT_MASK) {
+		p->dma_aborted_rd = true;
+		spi_int_fired = IRQ_HANDLED;
+	}
+	writel(regval, p->parent->dma_offset_bar + SPI_DMA_INTR_RD_CLR);
+	spin_unlock_irqrestore(&p->parent->dma_reg_lock, flags);
+
+	/* Clear the SPI GO_BIT Interrupt */
+	regval = readl(p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
+	if (regval & SPI_INTR) {
+		rx_buf = p->rx_buf;
+		memcpy_fromio(rx_buf + p->bytes_recvd, p->parent->reg_base +
+				      SPI_MST_RSP_BUF_OFFSET(p->hw_inst), p->tx_sgl_len);
+		p->bytes_recvd += p->tx_sgl_len;
+
+		p->tx_sgl = sg_next(p->tx_sgl);
+		if (!p->tx_sgl) {
+			/* Clear xfer_done */
+			complete(&p->spi_xfer_done);
+			spi_int_fired = IRQ_HANDLED;
+		} else {
+			tx_dma_addr = sg_dma_address(p->tx_sgl);
+			p->tx_sgl_len = sg_dma_len(p->tx_sgl);
+			pci1xxxx_spi_setup(p->parent, p->hw_inst, p->mode, p->clkdiv,
+					   p->tx_sgl_len);
+			pci1xxxx_spi_setup_dma_read(p, tx_dma_addr, p->tx_sgl_len);
+			writel(p->hw_inst, p->parent->dma_offset_bar +
+			       SPI_DMA_RD_DOORBELL_REG);
+		}
+	}
+	writel(regval, p->parent->reg_base + SPI_MST_EVENT_REG_OFFSET(p->hw_inst));
 	return spi_int_fired;
 }
 
+static irqreturn_t pci1xxxx_spi_isr(int irq, void *dev)
+{
+	struct pci1xxxx_spi_internal *p = dev;
+
+	if (p->spi_host->can_dma(p->spi_host, NULL, p->xfer))
+		return pci1xxxx_spi_isr_dma(irq, dev);
+	else
+		return pci1xxxx_spi_isr_io(irq, dev);
+}
+
+static bool pci1xxxx_spi_can_dma(struct spi_controller *host,
+				 struct spi_device *spi,
+				 struct spi_transfer *xfer)
+{
+	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(host);
+	struct pci1xxxx_spi *par = p->parent;
+
+	return par->can_dma;
+}
+
 static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	u8 hw_inst_cnt, iter, start, only_sec_inst;
@@ -505,7 +724,9 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 		spi_host->num_chipselect = SPI_CHIP_SEL_COUNT;
 		spi_host->mode_bits = SPI_MODE_0 | SPI_MODE_3 | SPI_RX_DUAL |
 				      SPI_TX_DUAL | SPI_LOOP;
+		spi_host->can_dma = pci1xxxx_spi_can_dma;
 		spi_host->transfer_one = pci1xxxx_spi_transfer_one;
+
 		spi_host->set_cs = pci1xxxx_spi_set_cs;
 		spi_host->bits_per_word_mask = SPI_BPW_MASK(8);
 		spi_host->max_speed_hz = PCI1XXXX_SPI_MAX_CLOCK_HZ;
-- 
2.25.1


