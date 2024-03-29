Return-Path: <linux-kernel+bounces-125357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4468892486
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E681C21A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988D13B7A6;
	Fri, 29 Mar 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YpK+vCPh"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F813B58F;
	Fri, 29 Mar 2024 19:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741752; cv=none; b=cYW1AIS3uQbKs30n423l6Oj+0qgTUMTf/VtRWRJWCJ4jyE+KHHjHmXd++KjKDPJNmclVBQA7PYikpyo4nzxS4G+eDXDAs1zlm6Npyklm9MV6mZSaVcPUreLERMRKJpybc6Lrj19Ac5nlCX7HE0o8Upfe2n6N7h1rJAUq02sxKmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741752; c=relaxed/simple;
	bh=RQfkxEbmUEursFfbk/NnyJASD3prRmM+bDbQdXUO1nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0SLF6FF9NoUKH9FiyObx6239qxwHBkltrN76G10UFSKbSu5TcFY7CWxa3XyGq3W5q1p3M3LCNwBmJtruVCX4jSaFXoTD2ZwT/ITRspPXKAIVoQ1vUiy+BZRBznHSrbAWFbmKWa6cyOrcUoLXqEyN28tf4Q1Auy2RDvDvHDWs7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YpK+vCPh; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TCGnSc028424;
	Fri, 29 Mar 2024 12:49:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=N90THS7jWW4+Nwtm6d/5q6ZFs8Zl+YTdX/fB3Xm0y9Y=; b=YpK
	+vCPhQinuC7Iu4YoFPDjBmuhHSGQSwO1Vlwwp8LHqfMQsOdbN/XDw9CKT2Qdin15
	JL/T3DimMigijwY2qzJPsaB1uBq3ktYd1G51vDeLjH6TGg6r0tfim1KpBwReml+X
	4Iqg7cAw6tbSAIBR1kItL/JLbwW8g0ZA2Ee2MxxvfBazxQeo0FCP9Rjucz1XDbSy
	59tcK8C9xgCQFNYVBC3CWbDgWrJK2WS9jKhyNk5fQMzEtFkkeboAFbB8Gh1cob13
	phlIAtuSOBqCasWBNqmkOeRjRf7Rz4ojay5ru4H4j4DZUahuzH64jlX6ZPHMOSs9
	0Q4xoJf3OnijLk9f7pA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x5wgphd3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 12:49:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 29 Mar 2024 12:49:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 29 Mar 2024 12:49:04 -0700
Received: from localhost.localdomain (unknown [10.110.150.170])
	by maili.marvell.com (Postfix) with ESMTP id 4FAED3F707C;
	Fri, 29 Mar 2024 12:49:04 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH 2/5] spi: cadence: Add Marvell IP modification changes
Date: Fri, 29 Mar 2024 12:48:46 -0700
Message-ID: <20240329194849.25554-3-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240329194849.25554-1-wsadowski@marvell.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: PDCAkOAO3ZFqdtEAdYLWlcMClfIMJse3
X-Proofpoint-ORIG-GUID: PDCAkOAO3ZFqdtEAdYLWlcMClfIMJse3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02

Add support for Marvell IP modification - clock divider,
and PHY config, and IRQ clearing.
Clock divider block is build into Cadence XSPI controller
and is connected directly to 800MHz clock.
As PHY config is not set directly in IP block, driver can
load custom PHY configuration values.
To correctly clear interrupt in Marvell implementation
MSI-X must be cleared too.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 311 ++++++++++++++++++++++++++++++++-
 1 file changed, 306 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 8648b8eb080d..f570b2920b18 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -189,6 +189,43 @@
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
@@ -208,6 +245,7 @@ enum cdns_xspi_stig_cmd_dir {
 struct cdns_xspi_dev {
 	struct platform_device *pdev;
 	struct device *dev;
+	bool mrvl_hw_overlay;
 
 	void __iomem *iobase;
 	void __iomem *auxbase;
@@ -228,6 +266,157 @@ struct cdns_xspi_dev {
 	u8 hw_num_banks;
 };
 
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
@@ -291,6 +480,10 @@ static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
 				     bool enabled)
 {
 	u32 intr_enable;
+	u32 irq_status;
+
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 
 	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
 	if (enabled)
@@ -315,6 +508,9 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 		return -EIO;
 	}
 
+	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
+	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
+
 	ctrl_features = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_FEATURES_REG);
 	cdns_xspi->hw_num_banks = FIELD_GET(CDNS_XSPI_NUM_BANKS, ctrl_features);
 	cdns_xspi_set_interrupts(cdns_xspi, false);
@@ -322,6 +518,70 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
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
@@ -333,13 +593,11 @@ static void cdns_xspi_sdma_handle(struct cdns_xspi_dev *cdns_xspi)
 
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
@@ -411,6 +669,9 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 	if (cdns_xspi->cur_cs != spi_get_chipselect(mem->spi, 0))
 		cdns_xspi->cur_cs = spi_get_chipselect(mem->spi, 0);
 
+	if (cdns_xspi->mrvl_hw_overlay)
+		cdns_mrvl_xspi_setup_clock(cdns_xspi, mem->spi->max_speed_hz);
+
 	return cdns_xspi_send_stig_command(cdns_xspi, op,
 					   (dir != SPI_MEM_NO_DATA));
 }
@@ -451,6 +712,10 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
 
+	if (cdns_xspi->mrvl_hw_overlay)
+		writel(CDNS_MRVL_MSIX_CLEAR_IRQ,
+		       cdns_xspi->auxbase + CDNS_MRVL_XSPI_SPIX_INTR_AUX);
+
 	if (irq_status &
 	    (CDNS_XSPI_SDMA_ERROR | CDNS_XSPI_SDMA_TRIGGER |
 	     CDNS_XSPI_STIG_DONE)) {
@@ -524,6 +789,27 @@ static void cdns_xspi_print_phy_config(struct cdns_xspi_dev *cdns_xspi)
 		 readl(cdns_xspi->auxbase + CDNS_XSPI_CCP_PHY_DLL_SLAVE_CTRL));
 }
 
+static int cdns_xspi_setup(struct spi_device *spi_dev)
+{
+	struct cdns_xspi_dev *cdns_xspi = spi_master_get_devdata(spi_dev->master);
+
+	if (cdns_xspi->mrvl_hw_overlay)
+		cdns_mrvl_xspi_setup_clock(cdns_xspi, spi_dev->max_speed_hz);
+
+	return 0;
+}
+
+static bool cdns_xspi_get_hw_overlay(struct platform_device *pdev)
+{
+	int err;
+
+	err = device_property_match_string(&pdev->dev,
+					   "compatible", "mrvl,xspi-nor");
+
+
+	return (err >= 0);
+}
+
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -531,6 +817,7 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	struct cdns_xspi_dev *cdns_xspi = NULL;
 	struct resource *res;
 	int ret;
+	bool hw_overlay;
 
 	host = devm_spi_alloc_host(dev, sizeof(*cdns_xspi));
 	if (!host)
@@ -540,10 +827,15 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL |
 		SPI_MODE_0  | SPI_MODE_3;
 
+	hw_overlay = cdns_xspi_get_hw_overlay(pdev);
+
 	host->mem_ops = &cadence_xspi_mem_ops;
 	host->dev.of_node = pdev->dev.of_node;
 	host->bus_num = -1;
 
+	if (hw_overlay)
+		host->setup = cdns_xspi_setup;
+
 	platform_set_drvdata(pdev, host);
 
 	cdns_xspi = spi_controller_get_devdata(host);
@@ -555,6 +847,8 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	init_completion(&cdns_xspi->auto_cmd_complete);
 	init_completion(&cdns_xspi->sdma_complete);
 
+	cdns_xspi->mrvl_hw_overlay = hw_overlay;
+
 	ret = cdns_xspi_of_get_plat_data(pdev);
 	if (ret)
 		return -ENODEV;
@@ -588,8 +882,12 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	cdns_xspi_print_phy_config(cdns_xspi);
+	if (hw_overlay) {
+		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
+		cdns_xspi_configure_phy(cdns_xspi);
+	}
 
+	cdns_xspi_print_phy_config(cdns_xspi);
 	ret = cdns_xspi_controller_init(cdns_xspi);
 	if (ret) {
 		dev_err(dev, "Failed to initialize controller\n");
@@ -613,6 +911,9 @@ static const struct of_device_id cdns_xspi_of_match[] = {
 	{
 		.compatible = "cdns,xspi-nor",
 	},
+	{
+		.compatible = "mrvl,xspi-nor",
+	},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, cdns_xspi_of_match);
-- 
2.17.1


