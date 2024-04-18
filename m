Return-Path: <linux-kernel+bounces-149388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CDD8A907D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43032821BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458864F608;
	Thu, 18 Apr 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WsVuX2rw"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789303FBB8;
	Thu, 18 Apr 2024 01:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402875; cv=none; b=E4Q87YwIbrf3vRis98G5KtjKN0uE5dzevw3PqEEcQqe9i3VOjDlJOkbAPBvYINr+iGbvTSLxoyVHYMp7AHi9cBBx03oYBOav4HSmeQkEYS7gyPIrcCqPp0KINHtIX3Hqz0dcpJ/eXbdhZEdiVnvwGE0ZOB+dUr2vCxxd/xehLMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402875; c=relaxed/simple;
	bh=mZMAldyxozQWoMJ38p/84uvLl5zdfACsMRxmsVRfb6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLeEzOvJm73oDA2ZGOWGnLO7arFLxlAinrojGTmn3valxKdRn78OM0uoDA33V0yiAjrPFs6iZ2IrHNZnsHjzLmneb/317QksvyABXK4a7iTmpVGk1TwDK16GRhrRs32N1nLpclORHmD5pdXHxbLKLdNhZy8GiOay/WPA5qcXo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WsVuX2rw; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HIdfl8012443;
	Wed, 17 Apr 2024 18:14:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=X+dZHnCK1mvwV2EffIolKGZ06JuAdw6jr9PaRx4tkNs=; b=WsV
	uX2rwCRwvap7Kb249QZSqXITHht2nmJSdyI/t7AdfHKEisttTNF7CLHJJn57Xboh
	2Iz2cUWyXB5VVdK+HxLToM39dvlOeeBSUZQBSz4IM8jxgEcuQ9TLb5RVLv91SdvT
	ctAM7EgCB32LGZj+SNwNnJKza980bv61f+vOu9JK5ANG8INdRH77LDg7kNvdONTu
	2D3vZFo5bZr1/Wh9h0n+5Nk1+1pethsd2JmiZSAZSUSvUhiVHphI9bi1LDOg9NcM
	Kqkzlw02/8Qmek/RAp0wfP5RoYbyNc8n9I+7zI6OJV+m9+YJ0WMP2DFNgoJ2dJbz
	hNYjrpaeFbAcRcPc1Dw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xjkw694vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 18:14:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Apr 2024 18:14:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 18:14:22 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 055B73F7070;
	Wed, 17 Apr 2024 18:14:21 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v3 5/5] spi: cadence: Add MRVL overlay xfer operation support
Date: Wed, 17 Apr 2024 18:13:52 -0700
Message-ID: <20240418011353.1764672-6-wsadowski@marvell.com>
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
X-Proofpoint-GUID: AiJT1tjFqjBWHPgs8wDgt0I1CnCOsHF-
X-Proofpoint-ORIG-GUID: AiJT1tjFqjBWHPgs8wDgt0I1CnCOsHF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_20,2024-04-17_01,2023-05-22_02

MRVL Xfer overlay extend xSPI capabilities, to support non-memory SPI
operations. Marvell overlay combined with generic command allows to
create full-duplex SPI transactions. It also allows to create
transaction with undetermined transaction length - with cs_hold
parameter, and ability to extend CS signal assertion, even if xSPI block
requests CS signal de-assertion.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 248 +++++++++++++++++++++++++++++++++
 1 file changed, 248 insertions(+)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index e4ebfad8a1cb..1fc6760cfef7 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -219,20 +219,39 @@
 #define CDNS_XSPI_DLL_RST_N BIT(24)
 #define CDNS_XSPI_DLL_LOCK  BIT(0)
 
+#define CDNS_XSPI_POLL_TIMEOUT_US	1000
+#define CDNS_XSPI_POLL_DELAY_US		10
+
 /* Marvell clock config register */
 #define CDNS_MRVL_XSPI_CLK_CTRL_AUX_REG	0x2020
 #define CDNS_MRVL_XSPI_CLK_ENABLE	BIT(0)
 #define CDNS_MRVL_XSPI_CLK_DIV		GENMASK(4, 1)
 #define CDNS_MRVL_XSPI_IRQ_ENABLE	BIT(6)
 
+
 /* Marvell MSI-X clear interrupt register */
 #define CDNS_MRVL_XSPI_SPIX_INTR_AUX	0x2000
 #define CDNS_MRVL_MSIX_CLEAR_IRQ	0x01
 
+#define SPIX_XFER_FUNC_CTRL 0x210
+#define SPIX_XFER_FUNC_CTRL_READ_DATA(i) (0x000 + 8 * (i))
+
 /* Marvell clock macros */
 #define CDNS_MRVL_XSPI_CLOCK_IO_HZ 800000000
 #define CDNS_MRVL_XSPI_CLOCK_DIVIDED(div) ((CDNS_MRVL_XSPI_CLOCK_IO_HZ) / (div))
 
+/* Marvell XFER registers */
+#define XFER_SOFT_RESET		BIT(11)
+#define XFER_CS_N_HOLD		GENMASK(9, 6)
+#define XFER_RECEIVE_ENABLE	BIT(4)
+#define XFER_FUNC_ENABLE	BIT(3)
+#define XFER_CLK_CAPTURE_POL	BIT(2)
+#define XFER_CLK_DRIVE_POL	BIT(1)
+#define XFER_FUNC_START		BIT(0)
+
+#define XFER_QWORD_COUNT 32
+#define XFER_QWORD_BYTECOUNT 8
+
 enum cdns_xspi_stig_instr_type {
 	CDNS_XSPI_STIG_INSTR_TYPE_0,
 	CDNS_XSPI_STIG_INSTR_TYPE_1,
@@ -257,6 +276,7 @@ struct cdns_xspi_dev {
 	void __iomem *iobase;
 	void __iomem *auxbase;
 	void __iomem *sdmabase;
+	void __iomem *xferbase;
 
 	int irq;
 	int cur_cs;
@@ -271,6 +291,9 @@ struct cdns_xspi_dev {
 	const void *out_buffer;
 
 	u8 hw_num_banks;
+
+	bool xfer_in_progress;
+	int current_xfer_qword;
 };
 
 struct cdns_xspi_driver_data {
@@ -889,6 +912,220 @@ static int cdns_xspi_setup(struct spi_device *spi_dev)
 	return 0;
 }
 
+static int cdns_xspi_prepare_generic(int cs, const void *dout, int len, int glue, u32 *cmd_regs)
+{
+	u8 *data = (u8 *)dout;
+	int i;
+	int data_counter = 0;
+
+	memset(cmd_regs, 0x00, 6*4);
+
+	if (len > 7) {
+		for (i = (len >= 10 ? 2 : len - 8); i >= 0 ; i--)
+			cmd_regs[3] |= data[data_counter++] << (8*i);
+	}
+	if (len > 3) {
+		for (i = (len >= 7 ? 3 : len - 4); i >= 0; i--)
+			cmd_regs[2] |= data[data_counter++] << (8*i);
+	}
+	for (i = (len >= 3 ? 2 : len - 1); i >= 0 ; i--)
+		cmd_regs[1] |= data[data_counter++] << (8 + 8*i);
+
+	cmd_regs[1] |= 96;
+	cmd_regs[3] |= len << 24;
+	cmd_regs[4] |= cs << 12;
+
+	if (glue == 1)
+		cmd_regs[4] |= 1 << 28;
+
+	return 0;
+}
+
+static unsigned char reverse_bits(unsigned char num)
+{
+	unsigned int count = sizeof(num) * 8 - 1;
+	unsigned int reverse_num = num;
+
+	num >>= 1;
+	while (num) {
+		reverse_num <<= 1;
+		reverse_num |= num & 1;
+		num >>= 1;
+		count--;
+	}
+	reverse_num <<= count;
+	return reverse_num;
+}
+
+static void cdns_xspi_read_single_qword(struct cdns_xspi_dev *cdns_xspi, u8 **buffer)
+{
+	u64 d = readq(cdns_xspi->xferbase +
+		      SPIX_XFER_FUNC_CTRL_READ_DATA(cdns_xspi->current_xfer_qword));
+	u8 *ptr = (u8 *)&d;
+	int k;
+
+	for (k = 0; k < 8; k++) {
+		u8 val = reverse_bits((ptr[k]));
+		**buffer = val;
+		*buffer = *buffer + 1;
+	}
+
+	cdns_xspi->current_xfer_qword++;
+	cdns_xspi->current_xfer_qword %= XFER_QWORD_COUNT;
+}
+
+static void cdns_xspi_finish_read(struct cdns_xspi_dev *cdns_xspi, u8 **buffer, u32 data_count)
+{
+	u64 d = readq(cdns_xspi->xferbase +
+		      SPIX_XFER_FUNC_CTRL_READ_DATA(cdns_xspi->current_xfer_qword));
+	u8 *ptr = (u8 *)&d;
+	int k;
+
+	for (k = 0; k < data_count % XFER_QWORD_BYTECOUNT; k++) {
+		u8 val = reverse_bits((ptr[k]));
+		**buffer = val;
+		*buffer = *buffer + 1;
+	}
+
+	cdns_xspi->current_xfer_qword++;
+	cdns_xspi->current_xfer_qword %= XFER_QWORD_COUNT;
+}
+
+static int cdns_xspi_prepare_transfer(int cs, int dir, int len, u32 *cmd_regs)
+{
+	memset(cmd_regs, 0x00, 6*4);
+
+	cmd_regs[1] |= 127;
+	cmd_regs[2] |= len << 16;
+	cmd_regs[4] |= dir << 4; //dir = 0 read, dir =1 write
+	cmd_regs[4] |= cs << 12;
+
+	return 0;
+}
+
+static bool cdns_xspi_stig_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
+{
+	u32 ctrl_stat;
+
+	return readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_CTRL_STATUS_REG,
+		ctrl_stat,
+		((ctrl_stat & BIT(3)) == 0),
+		sleep ? CDNS_XSPI_POLL_DELAY_US : 0,
+		sleep ? CDNS_XSPI_POLL_TIMEOUT_US : 0);
+}
+
+static bool cdns_xspi_sdma_ready(struct cdns_xspi_dev *cdns_xspi, bool sleep)
+{
+	u32 ctrl_stat;
+
+	return readl_relaxed_poll_timeout
+		(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG,
+		ctrl_stat,
+		(ctrl_stat & CDNS_XSPI_SDMA_TRIGGER),
+		sleep ? CDNS_XSPI_POLL_DELAY_US : 0,
+		sleep ? CDNS_XSPI_POLL_TIMEOUT_US : 0);
+}
+
+static int cdns_xspi_transfer_one_message_b0(struct spi_controller *controller,
+					   struct spi_message *m)
+{
+	struct cdns_xspi_dev *cdns_xspi = spi_controller_get_devdata(controller);
+	struct spi_device *spi = m->spi;
+	struct spi_transfer *t = NULL;
+
+	const int max_len = XFER_QWORD_BYTECOUNT * XFER_QWORD_COUNT;
+	int current_cycle_count;
+	int cs = spi_get_chipselect(spi, 0);
+	int cs_change = 0;
+
+	/* Enable xfer state machine */
+	if (!cdns_xspi->xfer_in_progress) {
+		u32 xfer_control = readl(cdns_xspi->xferbase + SPIX_XFER_FUNC_CTRL);
+
+		cdns_xspi->current_xfer_qword = 0;
+		cdns_xspi->xfer_in_progress = true;
+		xfer_control |= (XFER_RECEIVE_ENABLE |
+				 XFER_CLK_CAPTURE_POL |
+				 XFER_FUNC_START |
+				 XFER_SOFT_RESET |
+				 FIELD_PREP(XFER_CS_N_HOLD, (1 << cs)));
+		xfer_control &= ~(XFER_FUNC_ENABLE | XFER_CLK_DRIVE_POL);
+		writel(xfer_control, cdns_xspi->xferbase + SPIX_XFER_FUNC_CTRL);
+	}
+
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		u8 *txd = (u8 *) t->tx_buf;
+		u8 *rxd = (u8 *) t->rx_buf;
+		u8 data[10];
+		u32 cmd_regs[6];
+
+		if (!txd)
+			txd = data;
+
+		cdns_xspi->in_buffer = txd + 1;
+		cdns_xspi->out_buffer = txd + 1;
+
+		while (t->len) {
+
+			current_cycle_count = t->len > max_len ? max_len : t->len;
+
+			if (current_cycle_count < 10) {
+				cdns_xspi_prepare_generic(cs, txd, current_cycle_count,
+							  false, cmd_regs);
+				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				if (cdns_xspi_stig_ready(cdns_xspi, true))
+					return -EIO;
+			} else {
+				cdns_xspi_prepare_generic(cs, txd, 1, true, cmd_regs);
+				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				cdns_xspi_prepare_transfer(cs, 1, current_cycle_count - 1,
+							   cmd_regs);
+				cdns_xspi_trigger_command(cdns_xspi, cmd_regs);
+				if (cdns_xspi_sdma_ready(cdns_xspi, true))
+					return -EIO;
+				cdns_xspi_sdma_handle(cdns_xspi);
+				if (cdns_xspi_stig_ready(cdns_xspi, true))
+					return -EIO;
+
+				cdns_xspi->in_buffer += current_cycle_count;
+				cdns_xspi->out_buffer += current_cycle_count;
+			}
+
+			if (rxd) {
+				int j;
+
+				for (j = 0; j < current_cycle_count / 8; j++)
+					cdns_xspi_read_single_qword(cdns_xspi, &rxd);
+				cdns_xspi_finish_read(cdns_xspi, &rxd, current_cycle_count);
+			} else {
+				cdns_xspi->current_xfer_qword += current_cycle_count /
+								 XFER_QWORD_BYTECOUNT;
+				if (current_cycle_count % XFER_QWORD_BYTECOUNT)
+					cdns_xspi->current_xfer_qword++;
+
+				cdns_xspi->current_xfer_qword %= XFER_QWORD_COUNT;
+			}
+			cs_change = t->cs_change;
+			t->len -= current_cycle_count;
+		}
+	}
+
+	if (!cs_change) {
+		u32 xfer_control = readl(cdns_xspi->xferbase + SPIX_XFER_FUNC_CTRL);
+
+		xfer_control &= ~(XFER_RECEIVE_ENABLE |
+				  XFER_SOFT_RESET);
+		writel(xfer_control, cdns_xspi->xferbase + SPIX_XFER_FUNC_CTRL);
+		cdns_xspi->xfer_in_progress = false;
+	}
+
+	m->status = 0;
+	spi_finalize_current_message(controller);
+
+	return 0;
+}
+
 static int cdns_xspi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -953,6 +1190,16 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_xspi->auxbase);
 	}
 
+	if (drv_data->mrvl_hw_overlay) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
+		cdns_xspi->xferbase = devm_ioremap_resource(dev, res);
+		if (IS_ERR(cdns_xspi->xferbase)) {
+			dev_info(dev, "XFER register base not found, set it\n");
+			// For compatibility with older firmware
+			cdns_xspi->xferbase = cdns_xspi->iobase + 0x8000;
+		}
+	}
+
 	cdns_xspi->irq = platform_get_irq(pdev, 0);
 	if (cdns_xspi->irq < 0)
 		return -ENXIO;
@@ -967,6 +1214,7 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (drv_data->mrvl_hw_overlay) {
 		cdns_mrvl_xspi_setup_clock(cdns_xspi, MRVL_DEFAULT_CLK);
 		cdns_xspi_configure_phy(cdns_xspi);
+		host->transfer_one_message = cdns_xspi_transfer_one_message_b0;
 	}
 
 	cdns_xspi_print_phy_config(cdns_xspi);
-- 
2.43.0


