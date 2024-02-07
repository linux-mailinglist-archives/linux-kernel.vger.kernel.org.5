Return-Path: <linux-kernel+bounces-56101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B6084C5FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE30C2871DA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9520312;
	Wed,  7 Feb 2024 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iCuBy3IX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F631200CC;
	Wed,  7 Feb 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293309; cv=none; b=Xoos2w1BAz+VJz4787Y+339kkPpiTTj+IAn4hCSZuLzi3phKvhwZ29/D2hIzg52t5nlxvHaR2VwU1KVODnd2y+eN2KLrR3UqYpAdYvyj6F8WQz2ROrnhrvkzRT38LAjWIZcTkKjGmMGJh4dEIHawAdKsxLcot8yZgkNZcgtFW/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293309; c=relaxed/simple;
	bh=oLxMBXLfAr+3rg+3gu5vE9mmZq4mXWM4hotOb8wwzMU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJRVn/sM+6wBVg/ISB0SzC8SiL8n2ed/tAYAH1JdgtSpFGDPPK0rguNpnhMAgYCCaBl7XpwrnuLJ1o9dXkiCCBeSLPRSZ69lFj5SLIwpTvsXg8LRzUGe6SlBGO2JKf6aZKxTBblu1j8ER8Xf/TFJOr4fH+DlVYAUzjr0Olx+0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iCuBy3IX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1707293306; x=1738829306;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oLxMBXLfAr+3rg+3gu5vE9mmZq4mXWM4hotOb8wwzMU=;
  b=iCuBy3IX3bOoVeDZkBrYSNHHGAQ4t6anFoyxqlZ8U8fZVU9kHy2KhmWQ
   uXr41zwdjjCKF2dntnJLIqq+pafNR53v8Rj1DHwM5Glv+blzlz5lmml2Z
   crAg2ccoGy6s8ida/lfTrXP/Q2ajbeF+Eco5UhTcQNCgx774dEFCzTDTX
   3A+OZvWlqVoAUfMkFrT2SH74JPT9M1W85VH67iCnqyP/fmGgZUtZTrzUJ
   WyQHJeYgAobUDxAGYD0dLd3NRW2SL69qIWSP0C5jv6rzsI3pESnl9WR3y
   ZusVm+UsW19n7gcU8DvdAvBkf3HzPRASer+Ug00Ypqmd3DDI43leGgxsl
   A==;
X-CSE-ConnectionGUID: yQkjUUjURv6AK8yVChmQxw==
X-CSE-MsgGUID: Jp8F2E+qR+uAB+hwImPGTg==
X-IronPort-AV: E=Sophos;i="6.05,250,1701154800"; 
   d="scan'208";a="17266370"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Feb 2024 01:08:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 01:08:17 -0700
Received: from che-dk-ungapp03lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 01:08:15 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <kumaravel.thiagarajan@microchip.com>,
	<tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH v3 SPI for-next 1/2] spi: mchp-pci1xxxx: Add support for DMA in SPI
Date: Wed, 7 Feb 2024 13:36:20 +0530
Message-ID: <20240207080621.30742-2-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240207080621.30742-1-thangaraj.s@microchip.com>
References: <20240207080621.30742-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In PCI1xxxx C0, support for DMA in PCIe endpoint is added
to enhance the SPI performance. With this support, the
performance is improved from 6Mbps to 17Mbps with 20Mhz clock.
- DMA Supports two Channels, 0 and 1
- SPI Instance 0 uses chan 0 and SPI Instance 1 uses chan 1
- DMA can be used only if SPI is mapped to PF0 in the multi
function endpoint and the MSI interrupt is supported
- MSI interrupt of one of the SPI instance is assigned to the DMA
and both channels 0 and 1 share the same irq, the MSI address and
MSI Data of the irq is obtained and stored in DMA registers to
generate interrupt

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 145 +++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 5b2d3e4e21b7..85a6068b244d 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -5,7 +5,12 @@
 //          Kumaravel Thiagarajan <Kumaravel.Thiagarajan@microchip.com>
 
 
+#include <linux/dma-mapping.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/pci_regs.h>
 #include <linux/pci.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
@@ -32,8 +37,33 @@
 #define	SPI_MST_CTL_MODE_SEL		(BIT(2))
 #define	SPI_MST_CTL_GO			(BIT(0))
 
+#define SPI_SYSTEM_ADDR_BASE		(0x2000)
 #define	SPI_MST1_ADDR_BASE		(0x800)
 
+#define DEV_REV_REG			(SPI_SYSTEM_ADDR_BASE + 0x00)
+#define SPI_SYSLOCK_REG			(SPI_SYSTEM_ADDR_BASE + 0xA0)
+#define SPI_CONFIG_PERI_ENABLE_REG	(SPI_SYSTEM_ADDR_BASE + 0x108)
+
+#define SPI_PERI_ENBLE_PF_MASK		(GENMASK(17, 16))
+#define DEV_REV_MASK			(GENMASK(7, 0))
+
+#define SPI_SYSLOCK			BIT(4)
+
+/* DMA Related Registers */
+#define SPI_DMA_ADDR_BASE		(0x1000)
+#define SPI_DMA_GLOBAL_WR_ENGINE_EN	(SPI_DMA_ADDR_BASE + 0x0C)
+#define SPI_DMA_GLOBAL_RD_ENGINE_EN	(SPI_DMA_ADDR_BASE + 0x2C)
+#define SPI_DMA_INTR_IMWR_WDONE_LOW	(SPI_DMA_ADDR_BASE + 0x60)
+#define SPI_DMA_INTR_IMWR_WDONE_HIGH	(SPI_DMA_ADDR_BASE + 0x64)
+#define SPI_DMA_INTR_IMWR_WABORT_LOW	(SPI_DMA_ADDR_BASE + 0x68)
+#define SPI_DMA_INTR_IMWR_WABORT_HIGH	(SPI_DMA_ADDR_BASE + 0x6C)
+#define SPI_DMA_INTR_WR_IMWR_DATA	(SPI_DMA_ADDR_BASE + 0x70)
+#define SPI_DMA_INTR_IMWR_RDONE_LOW	(SPI_DMA_ADDR_BASE + 0xCC)
+#define SPI_DMA_INTR_IMWR_RDONE_HIGH	(SPI_DMA_ADDR_BASE + 0xD0)
+#define SPI_DMA_INTR_IMWR_RABORT_LOW	(SPI_DMA_ADDR_BASE + 0xD4)
+#define SPI_DMA_INTR_IMWR_RABORT_HIGH	(SPI_DMA_ADDR_BASE + 0xD8)
+#define SPI_DMA_INTR_RD_IMWR_DATA	(SPI_DMA_ADDR_BASE + 0xDC)
+
 /* x refers to SPI Host Controller HW instance id in the below macros - 0 or 1 */
 
 #define	SPI_MST_CMD_BUF_OFFSET(x)		(((x) * SPI_MST1_ADDR_BASE) + 0x00)
@@ -50,6 +80,8 @@
 #define SPI_MAX_DATA_LEN			320
 
 #define PCI1XXXX_SPI_TIMEOUT			(msecs_to_jiffies(100))
+#define SYSLOCK_RETRY_CNT			(1000)
+#define SPI_DMA_ENGINE_EN			(0x1)
 
 #define SPI_INTR		BIT(8)
 #define SPI_FORCE_CE		BIT(4)
@@ -76,7 +108,10 @@ struct pci1xxxx_spi_internal {
 struct pci1xxxx_spi {
 	struct pci_dev *dev;
 	u8 total_hw_instances;
+	u8 dev_rev;
 	void __iomem *reg_base;
+	void __iomem *dma_offset_bar;
+	bool can_dma;
 	struct pci1xxxx_spi_internal *spi_int[] __counted_by(total_hw_instances);
 };
 
@@ -106,6 +141,112 @@ static const struct pci_device_id pci1xxxx_spi_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, pci1xxxx_spi_pci_id_table);
 
+static int pci1xxxx_set_sys_lock(struct pci1xxxx_spi *par)
+{
+	writel(SPI_SYSLOCK, par->reg_base + SPI_SYSLOCK_REG);
+	return readl(par->reg_base + SPI_SYSLOCK_REG);
+}
+
+static int pci1xxxx_acquire_sys_lock(struct pci1xxxx_spi *par)
+{
+	u32 regval;
+
+	return readx_poll_timeout(pci1xxxx_set_sys_lock, par, regval,
+			   (regval & SPI_SYSLOCK), 100,
+			   SYSLOCK_RETRY_CNT * 100);
+}
+
+static void pci1xxxx_release_sys_lock(struct pci1xxxx_spi *par)
+{
+	writel(0x0, par->reg_base + SPI_SYSLOCK_REG);
+}
+
+static int pci1xxxx_check_spi_can_dma(struct pci1xxxx_spi *spi_bus, int irq)
+{
+	struct pci_dev *pdev = spi_bus->dev;
+	u32 pf_num;
+	u32 regval;
+	int ret;
+
+	/*
+	 * DEV REV Registers is a system register, HW Syslock bit
+	 * should be acquired before accessing the register
+	 */
+	ret = pci1xxxx_acquire_sys_lock(spi_bus);
+	if (ret) {
+		dev_err(&pdev->dev, "Error failed to acquire syslock\n");
+		return ret;
+	}
+
+	regval = readl(spi_bus->reg_base + DEV_REV_REG);
+	spi_bus->dev_rev = regval & DEV_REV_MASK;
+	if (spi_bus->dev_rev >= 0xC0) {
+		regval = readl(spi_bus->reg_base +
+			       SPI_CONFIG_PERI_ENABLE_REG);
+		pf_num = regval & SPI_PERI_ENBLE_PF_MASK;
+	}
+
+	pci1xxxx_release_sys_lock(spi_bus);
+
+	/*
+	 * DMA is supported only from C0 and SPI can use DMA only if
+	 * it is mapped to PF0
+	 */
+	if (spi_bus->dev_rev < 0xC0 || pf_num)
+		return -EOPNOTSUPP;
+
+	/*
+	 * DMA Supported only with MSI Interrupts
+	 * One of the SPI instance's MSI vector address and data
+	 * is used for DMA Interrupt
+	 */
+	if (!irq_get_msi_desc(irq)) {
+		dev_warn(&pdev->dev, "Error MSI Interrupt not supported, will operate in PIO mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	spi_bus->dma_offset_bar = pcim_iomap(pdev, 2, pci_resource_len(pdev, 2));
+	if (!spi_bus->dma_offset_bar) {
+		dev_warn(&pdev->dev, "Error failed to map dma bar, will operate in PIO mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		dev_warn(&pdev->dev, "Error failed to set DMA mask, will operate in PIO mode\n");
+		pcim_iounmap(pdev, spi_bus->dma_offset_bar);
+		spi_bus->dma_offset_bar = NULL;
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int pci1xxxx_spi_dma_init(struct pci1xxxx_spi *spi_bus, int irq)
+{
+	struct msi_msg msi;
+	int ret;
+
+	ret = pci1xxxx_check_spi_can_dma(spi_bus, irq);
+	if (ret)
+		return ret;
+
+	get_cached_msi_msg(irq, &msi);
+	writel(SPI_DMA_ENGINE_EN, spi_bus->dma_offset_bar + SPI_DMA_GLOBAL_WR_ENGINE_EN);
+	writel(SPI_DMA_ENGINE_EN, spi_bus->dma_offset_bar + SPI_DMA_GLOBAL_RD_ENGINE_EN);
+	writel(msi.address_hi, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_WDONE_HIGH);
+	writel(msi.address_hi, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_WABORT_HIGH);
+	writel(msi.address_hi, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_RDONE_HIGH);
+	writel(msi.address_hi, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_RABORT_HIGH);
+	writel(msi.address_lo, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_WDONE_LOW);
+	writel(msi.address_lo, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_WABORT_LOW);
+	writel(msi.address_lo, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_RDONE_LOW);
+	writel(msi.address_lo, spi_bus->dma_offset_bar + SPI_DMA_INTR_IMWR_RABORT_LOW);
+	writel(msi.data, spi_bus->dma_offset_bar + SPI_DMA_INTR_WR_IMWR_DATA);
+	writel(msi.data, spi_bus->dma_offset_bar + SPI_DMA_INTR_RD_IMWR_DATA);
+	spi_bus->can_dma = true;
+	return 0;
+}
+
 static void pci1xxxx_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct pci1xxxx_spi_internal *p = spi_controller_get_devdata(spi->controller);
@@ -324,6 +465,10 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 				goto error;
 			}
 
+			ret = pci1xxxx_spi_dma_init(spi_bus, spi_sub_ptr->irq);
+			if (ret && ret != -EOPNOTSUPP)
+				return ret;
+
 			/* This register is only applicable for 1st instance */
 			regval = readl(spi_bus->reg_base + SPI_PCI_CTRL_REG_OFFSET(0));
 			if (!only_sec_inst)
-- 
2.25.1


