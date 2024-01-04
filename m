Return-Path: <linux-kernel+bounces-16696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C7C824292
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C631F217C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC14D22314;
	Thu,  4 Jan 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="WUxYwK/i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21502210F4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.19.58])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 4A90710C4086B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:01:56 +0000 (UTC)
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.176.220])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 215B1100017A6;
	Thu,  4 Jan 2024 13:01:49 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1704373308.670000
X-TM-MAIL-UUID: d07ada51-4d3a-476c-a830-014f30aa25a4
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id A3CE010047C38;
	Thu,  4 Jan 2024 13:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ymh/UGRCUzqE4kwA1LNRD3V76rrU0q5JmXDQmICtgagGd0Sx+6VKeX2wQT3Bgmy4M5W5lmPNCv/wjBtmpdkE76CNQWzu11JKah5qaxWsvyIcK6bXXGzZKOGDURMEtwPc7H5vJRvVf2b9mXD6F9urkxlBkUMqy+QagjyE75Uw2CCsIn0ccSKPpW/iWCs/pFGZQIX6wCpqAMZar4rS07+XnVKqbs5xmawIX/F3btB3t4T02sxH4HmpJAhpcue4qVxfIXlyozSrZeQArwI2nRB4O59Xq8onQeBRxkjAEz19GsZ29UcdY64yvRYn9YJgu7kcYNg6dOpEWq+PIgukrt63rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A44VEZYTspkX2zfu6+lQI056JfCNUZlrpQHGpBI4xJ0=;
 b=c2tAnvbo1XUcD3oFt0xNKMnL86OEcaZGEvzarswmJrM6rhjpCkzdc1VVfUUpe5aYCkzGaR+u6mnESUH61TNsm9olAYfxcNTJqcJ0LPIM1wey1VxiuvwRO2nRibNNx2qToTsJFEtFJth71eKPKaKO8+MlCLog3lGNFy0LLejk4aeLZodl0ChVIZbKjYzJQIg7R23+oWeJ8wmuHbPOCebSGBZ6NxxtQOhxPj7bfDQKliHA3vELRoiWCmxtUutRaAbcN/34pIL5UzgrnOPyDmQC793LLAVwX/6o5v98ty0E6+Pq9EUBZCmZgCugUex/Sa0Gf6KydNNnTGvLHGO/kzJzEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=kernel.org smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Harald Mommer <Harald.Mommer@opensynergy.com>
To: virtio-dev@lists.oasis-open.org,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Harald Mommer <harald.mommer@opensynergy.com>,
	Harald Mommer <Harald.Mommer@opensynergy.com>
Subject: [RFC PATCH v2 3/3] SPI: Add virtio SPI driver (V10 draft specification).
Date: Thu,  4 Jan 2024 14:01:29 +0100
Message-Id: <20240104130129.17823-4-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
References: <20240104130129.17823-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT045:EE_|BEVP281MB3715:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cc19ef64-7e23-465f-f96a-08dc0d254da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/30CiHNXvXztxycjhydjkpx5UZ8qOlch8nK8rOV6YNGDH4fZo2VFuA27X+c6NuH0C6Vt19OkrKUvtFXGO9oY12mx4iddHFIgDEe6o5GH1SGLWLsJKC11X2m0NuLgw6vElZQLS2Zjdmp7dFP+IrzxeUZUlw1Qwb3wZPwls0aCQZNAWRqvwmfbFgPhknqnrzGOyklA54mTh9mnjkEQsrhQaTqpQHvLnM4WeIolB4Xs8mUJ98jqSO9CB0g1vm9u8c88qo157k7fAoFV3pkrHn94YpHhDfd+jRhetbixvFIcA1v7Ijbf3sv/U8QvcV6icbt+tdZTr+XfIqCbtLbzFjfDWj01Zhh273PMmwEPDKA3rJj3l44zZByzqiYQNYlspuhNwCnhcgqtbPUd3fdlytmmwo2vebLvyIJpJ4IxrZtnI1evdLNhWzP0H0BzCs5ZFTPjNY/bE4TtfkvVu7OyGMm3Yv5XH1vuzrEgUAdQZ/O85S6iQMiBeZFLW1dkOMmiCz5Ga/g1OlR4N52BN3TXQDmnHRMqZedNX7nLFZWiFB1+Qj6woWY+umAIx9u7QXSuq1gpc+i+G4j5SYmUvnRUistgpxIhG4HhVCdnpeZafs+8DL9yvIIILfnMn23aCKDai7i9DbydQYXVfwy7Ixwum4OmQivr+x9amC9TTxZ6btYo3X6hxC8IIItJoHAxwVmJ+DQGXzE6o37bntl7A62XLALY5QHhUHGolXjSCUL4KmdNc2QNjsIoDiqVLMoUlz4soBVU1mTKuVsFf8OYS20M+FbEVAIjbxSpXDaIeVo4G8yXFfs=
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39840400004)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(36840700001)(46966006)(81166007)(41300700001)(86362001)(8936002)(336012)(316002)(110136005)(8676002)(54906003)(4326008)(40480700001)(42186006)(36756003)(83380400001)(1076003)(26005)(70206006)(70586007)(2616005)(107886003)(30864003)(5660300002)(478600001)(47076005)(2906002)(36860700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:01:44.6332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc19ef64-7e23-465f-f96a-08dc0d254da0
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT045.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEVP281MB3715
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28098.007
X-TMASE-Result: 10--16.504500-4.000000
X-TMASE-MatchedRID: Ta8H+ip/h8EAsgl6PZgqJFmcWIT2GKzJgz5VmKZ8x87hCm8am+SP54vP
	iBq/iW91MpPx8OFzfY26s9an5hGqZUnvjwEYgMmSaHBj3sgbnZB35i8rRu5NquqKwADS/wqWjhj
	VY8VBNu5bcyDokSMBC+UhQfnTDSSQgEjtxrCIZOl4lyF1lyvUrR4s1tXUFaIffkpOuA8PICy6dX
	aAYUzGlk2LrJWi3XXEYRSBtQ0oAuFVW+1kgSdrJYWEan0Y08Ot1S6yX8lVpE2JTckzLq0IkhOXf
	+aEEQhS1kAespA2irnFzbrhCIZiOV8W+1KJQAZLWyx0lCurExrDluc4BYfva4ndKaJ31Y39qFty
	1HMHrV4t/kwYYmhI5mlB232a7BNLhH6kN1B9m4YnDrpxCH9Hl4ld6gdpSPEDH7tJno0Yum2/G7t
	ir40c1bPrLGr+YLzgGkDebuxZrqWxkyWC0qYf8OBHyXZCGbHqfq7xWexVq1yyBw15H24MRz/m+V
	kiqierl1NYlxxvWUwtgEZJUHc75WBnDtEasdEgiL+RrlWsewopSViUCNYhMOK9fjqiORFcAZjsJ
	4RGp+vg4EHeQQT63IIqHp23KYvDBYIaQ0ASMyrHfnPG7+BDZvpS9zfbt9q/ayl06EhYQmZPQFFk
	0j5jBsA2iDfbpfy+AVpeDm8nJoLwnQHFZbUP3moEkqixPwVYFrTss38C/MZaOxpgjiWHdQKmARN
	5PTKc
X-TMASE-XGENCLOUD: b94543a8-9db5-44a4-903f-59606b8ffb10-0-0-200-0
X-TM-Deliver-Signature: 30F28E0FD44B0B4F98844915428E4B1C
X-TM-Addin-Auth: CO9yovLtc88pPad4n+QqDxlIjK5FObMliXc+ifrZ+qhWp83xqFRdtQnFqGO
	1zI3kAS673zuO/lISHY7goF8cyrpYLYUx6NqiNSQ/+T01wiJ+QeJQQNpqnUkb7OSkU0rjGnT2D1
	IlELA2+ObKAZo5MKtCshfSI82N6/YlfE/Yn7LdfQkjy6AmZbXUmWvZic/7Lj2ACMFBghivoff3h
	06aArSjdd1gKAdMD3VHDIwf8E7O1ZbkcwP+mgcw8LRvd+4fZBTVIzxWWTOtkDT0ku/T2QG9SkjC
	Lg+327NYNYD7jQg=.JG2A3hNSm60a/+wDRhUJo5Ba0e86wfkYvR0T1cRT8DGVg3oxsNSDLTZLau
	33OJOvo6It9rcxWjaAbNqFpqGbqr5lSBLBB1yInwpdLM3GrvbuxfGkqqOSyL6BXWxNXV2H/xNha
	JrdBnf+iC8yWYViZT0UgcEb/gYoWgB5F8bUor2CzOh31uvomy3aCl0m0/38J7KU9T3af+wuLFH7
	DRus4Ael13pHj9/6wQo7AG6r9lorAtV4WX99wkhK9R3acvbAD4E6rcf/Z/2eCmlGw3hTaB5MeRF
	zGfB473K5thAlDvDfWGMvgETMOdfqkhbhJfUxQDEhCX7ugCu708HRX6kgbA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1704373308;
	bh=vWrXFOLO2Qy0YjZHKJ1cFRl1tGLQHZRjXF4n+dkhQSA=; l=14341;
	h=From:To:Date;
	b=WUxYwK/iIh2NVW9W+6vd0e5juR88oLcJYD+QP/nr9utbDQHe+yAUSMfNYBtTJ+Pcx
	 +0Ca2IaV7qM/fxBvl33CFuP/1wQJBOyhH0GZsds6+kEnc2RLxRZ8TXtTAqAa4bal5D
	 QtJbNOvBujGKA3vb8Q9jZmH2YHwllApqp8Ozqo6CjmdevvK5waID5w/cyhM8MPuVkD
	 CqkuwaU/y8xKouGQMYXezifCGvAXof7pcc7mWXElhcCeyaeJAZssikEdqr5ccOlAjW
	 dHioRjHuuQi5vONnj2OmRSd63rrM9MPMopLkouVZW1LMF7uukmtQE8N8946lzztmLw
	 NG4WBYs5RcKrQ==

From: Harald Mommer <harald.mommer@opensynergy.com>

This is the virtio SPI Linux kernel driver compliant to the "PATCH v10"
draft virtio SPI specification.

Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
---
 drivers/spi/Kconfig      |  11 +
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-virtio.c | 430 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 442 insertions(+)
 create mode 100644 drivers/spi/spi-virtio.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ddae0fde798e..f4f617c79ad7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1125,6 +1125,17 @@ config SPI_UNIPHIER
 
 	  If your SoC supports SCSSI, say Y here.
 
+config SPI_VIRTIO
+	tristate "Virtio SPI SPI Controller"
+	depends on VIRTIO
+	help
+	  This enables the Virtio SPI driver.
+
+	  Virtio SPI is an SPI driver for virtual machines using Virtio.
+
+	  If your Linux is a virtual machine using Virtio, say Y here.
+	  If unsure, say N.
+
 config SPI_XCOMM
 	tristate "Analog Devices AD-FMCOMMS1-EBZ SPI-I2C-bridge driver"
 	depends on I2C
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4ff8d725ba5e..ff2243e44e00 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -146,6 +146,7 @@ spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
 obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
 obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
 obj-$(CONFIG_SPI_UNIPHIER)		+= spi-uniphier.o
+obj-$(CONFIG_SPI_VIRTIO)		+= spi-virtio.o
 obj-$(CONFIG_SPI_XCOMM)		+= spi-xcomm.o
 obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
 obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
diff --git a/drivers/spi/spi-virtio.c b/drivers/spi/spi-virtio.c
new file mode 100644
index 000000000000..39eb38184793
--- /dev/null
+++ b/drivers/spi/spi-virtio.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SPI bus driver for the Virtio SPI controller
+ * Copyright (C) 2023 OpenSynergy GmbH
+ */
+
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/stddef.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+#include <linux/version.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+#include <linux/virtio_spi.h>
+
+/* virtio_spi private data structure */
+struct virtio_spi_priv {
+	/* The virtio device we're associated with */
+	struct virtio_device *vdev;
+	/* Pointer to the virtqueue */
+	struct virtqueue *vq;
+	/* Copy of config space mode_func_supported */
+	u32 mode_func_supported;
+	/* Copy of config space max_freq_hz */
+	u32 max_freq_hz;
+};
+
+struct virtio_spi_req {
+	struct completion completion;
+	struct spi_transfer_head transfer_head	____cacheline_aligned;
+	const uint8_t *tx_buf			____cacheline_aligned;
+	uint8_t *rx_buf				____cacheline_aligned;
+	struct spi_transfer_result result	____cacheline_aligned;
+};
+
+static struct spi_board_info board_info = {
+	.modalias = "spi-virtio",
+};
+
+static void virtio_spi_msg_done(struct virtqueue *vq)
+{
+	struct virtio_spi_req *req;
+	unsigned int len;
+
+	while ((req = virtqueue_get_buf(vq, &len)))
+		complete(&req->completion);
+}
+
+static int virtio_spi_one_transfer(struct virtio_spi_req *spi_req,
+				   struct spi_controller *ctrl,
+				   struct spi_message *msg,
+				   struct spi_transfer *xfer)
+{
+	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
+	struct device *dev = &priv->vdev->dev;
+	struct spi_device *spi = msg->spi;
+	struct spi_transfer_head *th;
+	struct scatterlist sg_out_head, sg_out_payload;
+	struct scatterlist sg_in_result, sg_in_payload;
+	struct scatterlist *sgs[4];
+	unsigned int outcnt = 0u;
+	unsigned int incnt = 0u;
+	int ret;
+
+	th = &spi_req->transfer_head;
+
+	/* Fill struct spi_transfer_head */
+	th->chip_select_id = spi_get_chipselect(spi, 0);
+	th->bits_per_word = spi->bits_per_word;
+	/*
+	 * Got comment: "The virtio spec for cs_change is *not* what the Linux
+	 * cs_change field does, this will not do the right thing."
+	 * TODO: Understand/discuss this, still unclear what may be wrong here
+	 */
+	th->cs_change = xfer->cs_change;
+	th->tx_nbits = xfer->tx_nbits;
+	th->rx_nbits = xfer->rx_nbits;
+	th->reserved[0] = 0;
+	th->reserved[1] = 0;
+	th->reserved[2] = 0;
+
+	BUILD_BUG_ON(VIRTIO_SPI_CPHA != SPI_CPHA);
+	BUILD_BUG_ON(VIRTIO_SPI_CPOL != SPI_CPOL);
+	BUILD_BUG_ON(VIRTIO_SPI_CS_HIGH != SPI_CS_HIGH);
+	BUILD_BUG_ON(VIRTIO_SPI_MODE_LSB_FIRST != SPI_LSB_FIRST);
+
+	th->mode = cpu_to_le32(spi->mode & (SPI_LSB_FIRST | SPI_CS_HIGH |
+					    SPI_CPOL | SPI_CPHA));
+	if ((spi->mode & SPI_LOOP) != 0)
+		th->mode |= cpu_to_le32(VIRTIO_SPI_MODE_LOOP);
+
+	th->freq = cpu_to_le32(xfer->speed_hz);
+
+	ret = spi_delay_to_ns(&xfer->word_delay, xfer);
+	if (ret < 0) {
+		dev_warn(dev, "Cannot convert word_delay\n");
+		goto msg_done;
+	}
+	th->word_delay_ns = cpu_to_le32((u32)ret);
+
+	ret = spi_delay_to_ns(&xfer->delay, xfer);
+	if (ret < 0) {
+		dev_warn(dev, "Cannot convert delay\n");
+		goto msg_done;
+	}
+	th->cs_setup_ns = cpu_to_le32((u32)ret);
+	th->cs_delay_hold_ns = cpu_to_le32((u32)ret);
+
+	/* This is the "off" time when CS has to be deasserted for a moment */
+	ret = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
+	if (ret < 0) {
+		dev_warn(dev, "Cannot convert cs_change_delay\n");
+		goto msg_done;
+	}
+	th->cs_change_delay_inactive_ns = cpu_to_le32((u32)ret);
+
+	/* Set buffers */
+	spi_req->tx_buf = xfer->tx_buf;
+	spi_req->rx_buf = xfer->rx_buf;
+
+	/* Prepare sending of virtio message */
+	init_completion(&spi_req->completion);
+
+	sg_init_one(&sg_out_head, &spi_req->transfer_head,
+		    sizeof(struct spi_transfer_head));
+	sgs[outcnt] = &sg_out_head;
+	outcnt++;
+
+	if (spi_req->tx_buf) {
+		sg_init_one(&sg_out_payload, spi_req->tx_buf, xfer->len);
+		sgs[outcnt] = &sg_out_payload;
+		outcnt++;
+	}
+
+	if (spi_req->rx_buf) {
+		sg_init_one(&sg_in_payload, spi_req->rx_buf, xfer->len);
+		sgs[outcnt + incnt] = &sg_in_payload;
+		incnt++;
+	}
+
+	sg_init_one(&sg_in_result, &spi_req->result,
+		    sizeof(struct spi_transfer_result));
+	sgs[outcnt + incnt] = &sg_in_result;
+	incnt++;
+
+	ret = virtqueue_add_sgs(priv->vq, sgs, outcnt, incnt, spi_req,
+				GFP_KERNEL);
+
+msg_done:
+	if (ret)
+		msg->status = ret;
+
+	return ret;
+}
+
+static int virtio_spi_transfer_one_message(struct spi_controller *ctrl,
+					   struct spi_message *msg)
+{
+	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
+	struct virtio_spi_req *spi_req;
+	struct spi_transfer *xfer;
+	int ret = 0;
+
+	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
+	if (!spi_req) {
+		ret = -ENOMEM;
+		goto no_mem;
+	}
+
+	/*
+	 * Simple implementation: Process message by message and wait for each
+	 * message to be completed by the device side.
+	 */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		ret = virtio_spi_one_transfer(spi_req, ctrl, msg, xfer);
+		if (ret)
+			goto msg_done;
+
+		virtqueue_kick(priv->vq);
+
+		wait_for_completion(&spi_req->completion);
+
+		/* Read result from message */
+		ret = (int)spi_req->result.result;
+		if (ret)
+			goto msg_done;
+	}
+
+msg_done:
+	kfree(spi_req);
+no_mem:
+	msg->status = ret;
+	spi_finalize_current_message(ctrl);
+
+	return ret;
+}
+
+static void virtio_spi_read_config(struct virtio_device *vdev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
+	struct virtio_spi_priv *priv = vdev->priv;
+	u8 cs_max_number;
+	u8 tx_nbits_supported;
+	u8 rx_nbits_supported;
+
+	cs_max_number = virtio_cread8(vdev, offsetof(struct virtio_spi_config,
+						     cs_max_number));
+	ctrl->num_chipselect = cs_max_number;
+
+	/* Set the mode bits which are understood by this driver */
+	priv->mode_func_supported =
+		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
+					      mode_func_supported));
+	ctrl->mode_bits = priv->mode_func_supported &
+			  (VIRTIO_SPI_CS_HIGH | VIRTIO_SPI_MODE_LSB_FIRST);
+	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPHA_1) != 0)
+		ctrl->mode_bits |= VIRTIO_SPI_CPHA;
+	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_CPOL_1) != 0)
+		ctrl->mode_bits |= VIRTIO_SPI_CPOL;
+	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LSB_FIRST) != 0)
+		ctrl->mode_bits |= SPI_LSB_FIRST;
+	if ((priv->mode_func_supported & VIRTIO_SPI_MF_SUPPORT_LOOPBACK) != 0)
+		ctrl->mode_bits |= SPI_LOOP;
+	tx_nbits_supported =
+		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
+					     tx_nbits_supported));
+	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
+		ctrl->mode_bits |= SPI_TX_DUAL;
+	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
+		ctrl->mode_bits |= SPI_TX_QUAD;
+	if ((tx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
+		ctrl->mode_bits |= SPI_TX_OCTAL;
+	rx_nbits_supported =
+		virtio_cread8(vdev, offsetof(struct virtio_spi_config,
+					     rx_nbits_supported));
+	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_DUAL) != 0)
+		ctrl->mode_bits |= SPI_RX_DUAL;
+	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_QUAD) != 0)
+		ctrl->mode_bits |= SPI_RX_QUAD;
+	if ((rx_nbits_supported & VIRTIO_SPI_RX_TX_SUPPORT_OCTAL) != 0)
+		ctrl->mode_bits |= SPI_RX_OCTAL;
+
+	ctrl->bits_per_word_mask =
+		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
+					      bits_per_word_mask));
+
+	priv->max_freq_hz =
+		virtio_cread32(vdev, offsetof(struct virtio_spi_config,
+					      max_freq_hz));
+}
+
+static int virtio_spi_find_vqs(struct virtio_spi_priv *priv)
+{
+	struct virtqueue *vq;
+
+	vq = virtio_find_single_vq(priv->vdev, virtio_spi_msg_done, "spi-rq");
+	if (IS_ERR(vq))
+		return (int)PTR_ERR(vq);
+	priv->vq = vq;
+	return 0;
+}
+
+/* Function must not be called before virtio_spi_find_vqs() has been run */
+static void virtio_spi_del_vq(struct virtio_device *vdev)
+{
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+}
+
+static int virtio_spi_validate(struct virtio_device *vdev)
+{
+	/*
+	 * SPI needs always access to the config space.
+	 * Check that the driver can access the config space
+	 */
+	if (!vdev->config->get) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+		dev_err(&vdev->dev,
+			"device does not comply with spec version 1.x\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int virtio_spi_probe(struct virtio_device *vdev)
+{
+	struct device_node *np = vdev->dev.parent->of_node;
+	struct virtio_spi_priv *priv;
+	struct spi_controller *ctrl;
+	int err;
+	u32 bus_num;
+	u16 csi;
+
+	ctrl = devm_spi_alloc_host(&vdev->dev, sizeof(*priv));
+	if (!ctrl) {
+		dev_err(&vdev->dev, "Kernel memory exhausted in %s()\n",
+			__func__);
+		err = -ENOMEM;
+		goto err_return;
+	}
+
+	priv = spi_controller_get_devdata(ctrl);
+	priv->vdev = vdev;
+	vdev->priv = priv;
+	dev_set_drvdata(&vdev->dev, ctrl);
+
+	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
+	if (!err && bus_num <= S16_MAX)
+		ctrl->bus_num = (s16)bus_num;
+
+	virtio_spi_read_config(vdev);
+
+	/* Method to transfer a single SPI message */
+	ctrl->transfer_one_message = virtio_spi_transfer_one_message;
+
+	/* Initialize virtqueues */
+	err = virtio_spi_find_vqs(priv);
+	if (err) {
+		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
+		goto err_return;
+	}
+
+	err = spi_register_controller(ctrl);
+	if (err) {
+		dev_err(&vdev->dev, "Cannot register controller\n");
+		goto err_return;
+	}
+
+	board_info.max_speed_hz = priv->max_freq_hz;
+	/* spi_new_device() currently does not use bus_num but better set it */
+	board_info.bus_num = (u16)ctrl->bus_num;
+
+	/* Add chip selects to controller */
+	for (csi = 0; csi < ctrl->num_chipselect; csi++) {
+		dev_dbg(&vdev->dev, "Setting up CS=%u\n", csi);
+		board_info.chip_select = csi;
+		/* TODO: Discuss setting of board_info.mode */
+		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
+			board_info.mode = SPI_MODE_0;
+		else
+			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
+		if (!spi_new_device(ctrl, &board_info)) {
+			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
+			err = -ENODEV;
+			goto err_return;
+		}
+	}
+
+	return 0;
+
+err_return:
+	return err;
+}
+
+static void virtio_spi_remove(struct virtio_device *vdev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
+
+	spi_unregister_controller(ctrl);
+	virtio_spi_del_vq(vdev);
+}
+
+static int virtio_spi_freeze(struct virtio_device *vdev)
+{
+	struct device *dev = &vdev->dev;
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	/* Stop the queue running */
+	ret = spi_controller_suspend(ctrl);
+	if (ret) {
+		dev_warn(dev, "cannot suspend controller (%d)\n", ret);
+		return ret;
+	}
+
+	virtio_spi_del_vq(vdev);
+	return 0;
+}
+
+static int virtio_spi_restore(struct virtio_device *vdev)
+{
+	struct device *dev = &vdev->dev;
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	int ret;
+
+	ret = virtio_spi_find_vqs(vdev->priv);
+	if (ret) {
+		dev_err(dev, "problem starting vqueue (%d)\n", ret);
+		return ret;
+	}
+
+	ret = spi_controller_resume(ctrl);
+	if (ret)
+		dev_err(dev, "problem resuming controller (%d)\n", ret);
+
+	return ret;
+}
+
+static struct virtio_device_id virtio_spi_id_table[] = {
+	{ VIRTIO_ID_SPI, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_spi_driver = {
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = virtio_spi_id_table,
+	.validate = virtio_spi_validate,
+	.probe = virtio_spi_probe,
+	.remove = virtio_spi_remove,
+	.freeze = pm_sleep_ptr(virtio_spi_freeze),
+	.restore = pm_sleep_ptr(virtio_spi_restore),
+};
+
+module_virtio_driver(virtio_spi_driver);
+MODULE_DEVICE_TABLE(virtio, virtio_spi_id_table);
+
+MODULE_AUTHOR("OpenSynergy GmbH");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Virtio SPI bus driver");
-- 
2.25.1


