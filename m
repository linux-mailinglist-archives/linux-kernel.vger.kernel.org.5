Return-Path: <linux-kernel+bounces-149387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 845C68A907C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E2D1C21954
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909274F1E2;
	Thu, 18 Apr 2024 01:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HnFn2eP7"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812A53A267;
	Thu, 18 Apr 2024 01:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402874; cv=none; b=SJAQYBl8NMmO2cAsuKbBuL8W+UPi98ZS0h6cOfLexiospr1K5S+61/WTVexTN52tdxuZv+QfOwYxahRi3BQ0CO5frgm7/C4H+xUUU6DOTpR4SzB8oHjKidloX9L3+c0THik42LN9Ib7lYrCiu2oZ2eWjp6LN7zWNK3eNbv9/ABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402874; c=relaxed/simple;
	bh=p0XjNKu73Ok1wiLbNHCKJEPqMOpL6dMMsLHxPy+8Pz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPQ2GfUX2lJN668ZE8eBqcKOkZM5AXMphJEidd76honaH0SSsS6LpRdvze6BGff0SKHbxsVQ64QET5lMeCMOvzhTa6xfA46SRv3jkMLsB3xYmoev0DazLEfvpH2R8euW77/9znSaOgnFMAYr4tTqtLviXUGlM4kVUjdkpplMWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HnFn2eP7; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HIddBD012429;
	Wed, 17 Apr 2024 18:14:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=2B+Yg4XNxt2YeN+zBzuft8gu1nI60RTHXP8UtU1yiWY=; b=HnF
	n2eP7PwvgR0oSi2ImllVlsEPVxH3UvvVLBZQ0Ck7PdleWIEGhsU8/CW7KDUJdG1U
	wUzIuVY3yRRFV4rrSciCYBts9y0axS6fIPGFZ7ES1aJrLR3yVfs4YZiuMe7UHvmf
	4ksZHQskVdnxTbf73Bfig5ogUD9pDVNAP5RQC4rVFhSy8Q+icmP/nxaJnT4oo8qi
	53qo0M1V9oRxOjHnVJmmvk1TqB+r58hidKPyZo3FN790dmDzun09xcKDA+2nM0AK
	ATh7v9Mf4+PoCY1fAtEX5Q0W44JEYrb2bVMYWs4cUuGg25/PYeQnsgD/21hEBuVZ
	QkPS+4viyDXoM0+HujA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xjkw694vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 18:14:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Apr 2024 18:14:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 18:14:19 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 70CAD3F7067;
	Wed, 17 Apr 2024 18:14:19 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v3 3/5] spi: cadence: Add Marvell xSPI IP overlay changes
Date: Wed, 17 Apr 2024 18:13:50 -0700
Message-ID: <20240418011353.1764672-4-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418011353.1764672-1-wsadowski@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240418011353.1764672-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NAsVRp7_lyG7FQiN8481hXR5Zi-sWxn3
X-Proofpoint-ORIG-GUID: NAsVRp7_lyG7FQiN8481hXR5Zi-sWxn3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_20,2024-04-17_01,2023-05-22_02

Add support for basic v2 Marvell overlay block. Support for basic
operation is added here: clock configuration, PHY configuration,
interrupt configuration(enabling)
Clock divider block is build on top of Cadence xSPI IP, and divides
external 800MHz clock. It allows only for a few different clock speeds
starting from 6.25MHz up to 200MHz.
PHY configuration can be read from device-tree, if parameter is not
present - safe defaults will be used..
In addition to handle interrupt propoerly driver must clear MSI-X
interrupt bit, in addition to clearing xSPI interrupt bit. Interrupt
masking must be disabled.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 326 ++++++++++++++++++++++++++++++++-
 1 file changed, 318 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index cdce2e280f66..5d36f9177f3c 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -193,6 +193,44 @@
 		((op)->data.dir == SPI_MEM_DATA_IN) ? \
 		CDNS_XSPI_STIG_CMD_DIR_READ : CDNS_XSPI_STIG_CMD_DIR_WRITE))
 
+/*PHY default values*/
+#define REGS_DLL_PHY_CTRL		0x00000707
+#define CTB_RFILE_PHY_CTRL		0x00004000
+#define RFILE_PHY_TSEL			0x00000000
+#define RFILE_PHY_DQ_TIMING		0x00000101
+#define RFILE_PHY_DQS_TIMING		0x00700404
+#define RFILE_PHY_GATE_LPBK_CTRL	0x00200030
+#define RFILE_PHY_DLL_MASTER_CTRL	0x00800000
+#define RFILE_PHY_DLL_SLAVE_CTRL	0x0000ff01
+
+/*PHY config rtegisters*/
+#define CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL			0x1034
+#define CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL			0x0080
+#define CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL			0x0084
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING		0x0000
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING		0x0004
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL	0x0008
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_MASTER_CTRL	0x000c
+#define CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL	0x0010
+#define CDNS_XSPI_DATASLICE_RFILE_PHY_DLL_OBS_REG_0		0x001c
+
+#define CDNS_XSPI_DLL_RST_N BIT(24)
+#define CDNS_XSPI_DLL_LOCK  BIT(0)
+
+/* Marvell clock config register */
+#define CDNS_MRVL_XSPI_CLK_CTRL_AUX_REG	0x2020
+#define CDNS_MRVL_XSPI_CLK_ENABLE	BIT(0)
+#define CDNS_MRVL_XSPI_CLK_DIV		GENMASK(4, 1)
+#define CDNS_MRVL_XSPI_IRQ_ENABLE	BIT(6)
+
+/* Marvell MSI-X clear interrupt register */
+#define CDNS_MRVL_XSPI_SPIX_INTR_AUX	0x2000
+#define CDNS_MRVL_MSIX_CLEAR_IRQ	0x01
+
+/* Marvell clock macros */
+#define CDNS_MRVL_XSPI_CLOCK_IO_HZ 800000000
+#define CDNS_MRVL_XSPI_CLOCK_DIVIDED(div) ((CDNS_MRVL_XSPI_CLOCK_IO_HZ) / (div))
+
 enum cdns_xspi_stig_instr_type {
 	CDNS_XSPI_STIG_INSTR_TYPE_0,
 	CDNS_XSPI_STIG_INSTR_TYPE_1,
@@ -212,6 +250,7 @@ enum cdns_xspi_stig_cmd_dir {
 struct cdns_xspi_dev {
 	struct platform_device *pdev;
 	struct device *dev;
+	bool mrvl_hw_overlay;
 
 	void __iomem *iobase;
 	void __iomem *auxbase;
@@ -232,6 +271,170 @@ struct cdns_xspi_dev {
 	u8 hw_num_banks;
 };
 
+struct cdns_xspi_driver_data {
+	bool mrvl_hw_overlay;
+};
+
+static struct cdns_xspi_driver_data mrvl_driver_data = {
+	.mrvl_hw_overlay = true,
+};
+
+static struct cdns_xspi_driver_data cdns_driver_data = {
+	.mrvl_hw_overlay = false,
+};
+
+#define MRVL_DEFAULT_CLK 25000000
+
+const int cdns_mrvl_xspi_clk_div_list[] = {
+	4,	//0x0 = Divide by 4.   SPI clock is 200 MHz.
+	6,	//0x1 = Divide by 6.   SPI clock is 133.33 MHz.
+	8,	//0x2 = Divide by 8.   SPI clock is 100 MHz.
+	10,	//0x3 = Divide by 10.  SPI clock is 80 MHz.
+	12,	//0x4 = Divide by 12.  SPI clock is 66.666 MHz.
+	16,	//0x5 = Divide by 16.  SPI clock is 50 MHz.
+	18,	//0x6 = Divide by 18.  SPI clock is 44.44 MHz.
+	20,	//0x7 = Divide by 20.  SPI clock is 40 MHz.
+	24,	//0x8 = Divide by 24.  SPI clock is 33.33 MHz.
+	32,	//0x9 = Divide by 32.  SPI clock is 25 MHz.
+	40,	//0xA = Divide by 40.  SPI clock is 20 MHz.
+	50,	//0xB = Divide by 50.  SPI clock is 16 MHz.
+	64,	//0xC = Divide by 64.  SPI clock is 12.5 MHz.
+	128,	//0xD = Divide by 128. SPI clock is 6.25 MHz.
+	-1	//End of list
+};
+
+static bool cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
+{
+	u32 dll_cntrl = readl(cdns_xspi->iobase +
+			      CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+	u32 dll_lock;
+
+	/*Reset DLL*/
+	dll_cntrl |= CDNS_XSPI_DLL_RST_N;
+	writel(dll_cntrl, cdns_xspi->iobase +
+			  CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+
+	/*Wait for DLL lock*/
+	return readl_relaxed_poll_timeout(cdns_xspi->iobase +
+		CDNS_XSPI_INTR_STATUS_REG,
+		dll_lock, ((dll_lock & CDNS_XSPI_DLL_LOCK) == 1), 10, 10000);
+}
+
+static void cdns_configure_phy_register_io(struct cdns_xspi_dev *cdns_xspi,
+					   const char *prop_name,
+					   u64 default_value, u64 offset)
+{
+	struct device_node *node_prop = cdns_xspi->pdev->dev.of_node;
+	u64 phy_cfg;
+
+	if (of_property_read_u64(node_prop, prop_name, &phy_cfg))
+		phy_cfg = default_value;
+	writel(phy_cfg,
+		cdns_xspi->iobase + offset);
+}
+
+static void cdns_configure_phy_register_aux(struct cdns_xspi_dev *cdns_xspi,
+					    const char *prop_name,
+					    u64 default_value, u64 offset)
+{
+	struct device_node *node_prop = cdns_xspi->pdev->dev.of_node;
+	u64 phy_cfg;
+
+	if (of_property_read_u64(node_prop, "cdns,dll-phy-control", &phy_cfg))
+		phy_cfg = default_value;
+	writel(phy_cfg,
+		cdns_xspi->auxbase + offset);
+}
+
+//Static confiuration of PHY
+static bool cdns_xspi_configure_phy(struct cdns_xspi_dev *cdns_xspi)
+{
+	cdns_configure_phy_register_io(cdns_xspi,
+				       "cdns,dll-phy-control",
+				       REGS_DLL_PHY_CTRL,
+				       CDNS_XSPI_RF_MINICTRL_REGS_DLL_PHY_CTRL);
+	cdns_configure_phy_register_aux(cdns_xspi,
+					"cdns,rfile-phy-control",
+					CTB_RFILE_PHY_CTRL,
+					CDNS_XSPI_PHY_CTB_RFILE_PHY_CTRL);
+	cdns_configure_phy_register_aux(cdns_xspi,
+					"cdns,rfile-phy-tsel",
+					RFILE_PHY_TSEL,
+					CDNS_XSPI_PHY_CTB_RFILE_PHY_TSEL);
+	cdns_configure_phy_register_aux(cdns_xspi,
+				"cdns,phy-dq-timing",
+				RFILE_PHY_DQ_TIMING,
+				CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQ_TIMING);
+	cdns_configure_phy_register_aux(cdns_xspi,
+			"cdns,phy-dqs-timing",
+			RFILE_PHY_DQS_TIMING,
+			CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DQS_TIMING);
+	cdns_configure_phy_register_aux(cdns_xspi,
+			"cdns,phy-gate-lpbk-ctrl",
+			RFILE_PHY_GATE_LPBK_CTRL,
+			CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL);
+	cdns_configure_phy_register_aux(cdns_xspi,
+			"cdns,phy-dll-master-ctrl",
+			RFILE_PHY_DLL_MASTER_CTRL,
+			CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_GATE_LPBK_CTRL);
+	cdns_configure_phy_register_aux(cdns_xspi,
+			"cdns,phy-dll-slave-ctrl",
+			RFILE_PHY_DLL_SLAVE_CTRL,
+			CDNS_XSPI_PHY_DATASLICE_RFILE_PHY_DLL_SLAVE_CTRL);
+
+	return cdns_xspi_reset_dll(cdns_xspi);
+}
+
+// Find max avalible clock
+static bool cdns_mrvl_xspi_setup_clock(struct cdns_xspi_dev *cdns_xspi,
+				       int requested_clk)
+{
+	int i = 0;
+	int clk_val;
+	u32 clk_reg;
+	bool update_clk = false;
+
+	while (cdns_mrvl_xspi_clk_div_list[i] > 0) {
+		clk_val = CDNS_MRVL_XSPI_CLOCK_DIVIDED(
+				cdns_mrvl_xspi_clk_div_list[i]);
+		if (clk_val <= requested_clk)
+			break;
+		i++;
+	}
+
+	if (cdns_mrvl_xspi_clk_div_list[i] == -1) {
+		dev_info(cdns_xspi->dev,
+			"Unable to find clk div for CLK: %d - using 6.25MHz\n",
+		       requested_clk);
+		i = 0x0D;
+	} else {
+		dev_dbg(cdns_xspi->dev, "Found clk div: %d, clk val: %d\n",
+			cdns_mrvl_xspi_clk_div_list[i],
+			CDNS_MRVL_XSPI_CLOCK_DIVIDED(
+				cdns_mrvl_xspi_clk_div_list[i]));
+	}
+
+	clk_reg = readl(cdns_xspi->auxbase + CDNS_MRVL_XSPI_CLK_CTRL_AUX_REG);
+
+	if (FIELD_GET(CDNS_MRVL_XSPI_CLK_DIV, clk_reg) != i) {
+		clk_reg &= ~CDNS_MRVL_XSPI_CLK_ENABLE;
+		writel(clk_reg,
+		       cdns_xspi->auxbase + CDNS_MRVL_XSPI_CLK_CTRL_AUX_REG);
+		clk_reg = FIELD_PREP(CDNS_MRVL_XSPI_CLK_DIV, i);
+		clk_reg &= ~CDNS_MRVL_XSPI_CLK_DIV;
+		clk_reg |= FIELD_PREP(CDNS_MRVL_XSPI_CLK_DIV, i);
+		clk_reg |= CDNS_MRVL_XSPI_CLK_ENABLE;
+		clk_reg |= CDNS_MRVL_XSPI_IRQ_ENABLE;
+		update_clk = true;
+	}
+
+	if (update_clk)
+		writel(clk_reg,
+		       cdns_xspi->auxbase + CDNS_MRVL_XSPI_CLK_CTRL_AUX_REG);
+
+	return update_clk;
+}
+
 static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_stat;
@@ -295,6 +498,10 @@ static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
 				     bool enabled)
 {
 	u32 intr_enable;
+	u32 irq_status;
+
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 
 	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
 	if (enabled)
@@ -319,6 +526,9 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 		return -EIO;
 	}
 
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
 	ctrl_features = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_FEATURES_REG);
 	cdns_xspi->hw_num_banks = FIELD_GET(CDNS_XSPI_NUM_BANKS, ctrl_features);
 	cdns_xspi_set_interrupts(cdns_xspi, false);
@@ -326,6 +536,70 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 	return 0;
 }
 
+static void mrvl_ioreadq(void __iomem  *addr, void *buf, int len)
+{
+	int i = 0;
+	int rcount = len / 8;
+	int rcount_nf = len % 8;
+	uint64_t tmp;
+	uint64_t *buf64 = (uint64_t *)buf;
+
+	if (((uint64_t)buf % 8) == 0) {
+		for (i = 0; i < rcount; i++)
+			*buf64++ = readq(addr);
+	} else {
+		for (i = 0; i < rcount; i++) {
+			tmp = readq(addr);
+			memcpy(buf+(i*8), &tmp, 8);
+		}
+	}
+
+	if (rcount_nf != 0) {
+		tmp = readq(addr);
+		memcpy(buf+(i*8), &tmp, rcount_nf);
+	}
+}
+
+static void mrvl_iowriteq(void __iomem *addr, const void *buf, int len)
+{
+	int i = 0;
+	int rcount = len / 8;
+	int rcount_nf = len % 8;
+	uint64_t tmp;
+	uint64_t *buf64 = (uint64_t *)buf;
+
+	if (((uint64_t)buf % 8) == 0) {
+		for (i = 0; i < rcount; i++)
+			writeq(*buf64++, addr);
+	} else {
+		for (i = 0; i < rcount; i++) {
+			memcpy(&tmp, buf+(i*8), 8);
+			writeq(tmp, addr);
+		}
+	}
+
+	if (rcount_nf != 0) {
+		memcpy(&tmp, buf+(i*8), rcount_nf);
+		writeq(tmp, addr);
+	}
+}
+
+static void cdns_xspi_sdma_memread(struct cdns_xspi_dev *cdns_xspi, int len)
+{
+	if (cdns_xspi->mrvl_hw_overlay)
+		mrvl_ioreadq(cdns_xspi->sdmabase, cdns_xspi->in_buffer, len);
+	else
+		ioread8_rep(cdns_xspi->sdmabase, cdns_xspi->in_buffer, len);
+}
+
+static void cdns_xspi_sdma_memwrite(struct cdns_xspi_dev *cdns_xspi, int len)
+{
+	if (cdns_xspi->mrvl_hw_overlay)
+		mrvl_iowriteq(cdns_xspi->sdmabase, cdns_xspi->out_buffer, len);
+	else
+		iowrite8_rep(cdns_xspi->sdmabase, cdns_xspi->out_buffer, len);
+}
+
 static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 sdma_size, sdma_trd_info;
@@ -337,13 +611,11 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 
 	switch (sdma_dir) {
 	case CDNS_XSPI_SDMA_DIR_READ:
-		ioread8_rep(cdns_xspi->sdmabase,
-			    cdns_xspi->in_buffer, sdma_size);
+		cdns_xspi_sdma_memread(cdns_xspi, sdma_size);
 		break;
 
 	case CDNS_XSPI_SDMA_DIR_WRITE:
-		iowrite8_rep(cdns_xspi->sdmabase,
-			     cdns_xspi->out_buffer, sdma_size);
+		cdns_xspi_sdma_memwrite(cdns_xspi, sdma_size);
 		break;
 	}
 }
@@ -421,6 +693,9 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 	if (cdns_xspi->cur_cs != spi_get_chipselect(mem->spi, 0))
 		cdns_xspi->cur_cs = spi_get_chipselect(mem->spi, 0);
 
+	if (cdns_xspi->mrvl_hw_overlay)
+		cdns_mrvl_xspi_setup_clock(cdns_xspi, mem->spi->max_speed_hz);
+
 	return cdns_xspi_send_stig_command(cdns_xspi, op,
 					   (dir != SPI_MEM_NO_DATA));
 }
@@ -461,6 +736,10 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 
+	if (cdns_xspi->mrvl_hw_overlay)
+		writel(CDNS_MRVL_MSIX_CLEAR_IRQ,
+		       cdns_xspi->auxbase + CDNS_MRVL_XSPI_SPIX_INTR_AUX);
+
 	if (irq_status &
 	    (CDNS_XSPI_SDMA_ERROR | CDNS_XSPI_SDMA_TRIGGER |
 	     CDNS_XSPI_STIG_DONE)) {
@@ -534,11 +813,23 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
 }
 
+static int cdns_xspi_setup(struct spi_device *spi_dev)
+{
+	struct cdns_xspi_dev *cdns_xspi = spi_controller_get_devdata(
+						spi_dev->controller);
+
+	if (cdns_xspi->mrvl_hw_overlay)
+		cdns_mrvl_xspi_setup_clock(cdns_xspi, spi_dev->max_speed_hz);
+
+	return 0;
+}
+
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct spi_controller *host = NULL;
 	struct cdns_xspi_dev *cdns_xspi = NULL;
+	const struct cdns_xspi_driver_data *drv_data;
 	struct resource *res;
 	int ret;
 
@@ -550,10 +841,16 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL |
 		SPI_MODE_0  | SPI_MODE_3;
 
+	drv_data = of_device_get_match_data(dev);
+
 	host->mem_ops = &cadence_xspi_mem_ops;
 	host->dev.of_node = pdev->dev.of_node;
+	host->dev.fwnode = pdev->dev.fwnode;
 	host->bus_num = -1;
 
+	if (drv_data->mrvl_hw_overlay)
+		host->setup = cdns_xspi_setup;
+
 	platform_set_drvdata(pdev, host);
 
 	cdns_xspi = spi_controller_get_devdata(host);
@@ -565,23 +862,27 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	init_completion(&cdns_xspi->auto_cmd_complete);
 	init_completion(&cdns_xspi->sdma_complete);
 
+	cdns_xspi->mrvl_hw_overlay = drv_data->mrvl_hw_overlay;
+
 	ret = cdns_xspi_of_get_plat_data(pdev);
 	if (ret)
 		return -ENODEV;
 
-	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "io");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cdns_xspi->iobase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->iobase)) {
 		dev_err(dev, "Failed to remap controller base address\n");
 		return PTR_ERR(cdns_xspi->iobase);
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->sdmabase))
 		return PTR_ERR(cdns_xspi->sdmabase);
 	cdns_xspi->sdmasize = resource_size(res);
 
-	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev, "aux");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	cdns_xspi->auxbase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->auxbase)) {
 		dev_err(dev, "Failed to remap AUX address\n");
 		return PTR_ERR(cdns_xspi->auxbase);
@@ -598,8 +899,12 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	cdns_xspi_print_phy_config(cdns_xspi);
+	if (drv_data->mrvl_hw_overlay) {
+		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
+		cdns_xspi_configure_phy(cdns_xspi);
+	}
 
+	cdns_xspi_print_phy_config(cdns_xspi);
 	ret = cdns_xspi_controller_init(cdns_xspi);
 	if (ret) {
 		dev_err(dev, "Failed to initialize controller\n");
@@ -622,6 +927,11 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 static const struct of_device_id cdns_xspi_of_match[] = {
 	{
 		.compatible = "cdns,xspi-nor",
+		.data = &cdns_driver_data,
+	},
+	{
+		.compatible = "mrvl,xspi-nor",
+		.data = &mrvl_driver_data,
 	},
 	{ /* end of table */}
 };
-- 
2.43.0


