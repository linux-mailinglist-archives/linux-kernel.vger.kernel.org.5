Return-Path: <linux-kernel+bounces-90872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AD0870628
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F990B2C8C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D6D4DA10;
	Mon,  4 Mar 2024 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="GNRF5Ip7"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6226C4BAA6;
	Mon,  4 Mar 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567048; cv=fail; b=l8KbipivIY7dPTgsx4zOHVqpFbb12yXIbHRR9ruf2KZxBXLAqNFw9n4eS+dwTjVcDcRZdiWna/nSlzniQwF566M2P15pcV9c+auo55OVHjFN5VElKkkOfYQxsbd5snweYyxik3HyuGOOocLZZiGdQS6C7Vi+ZnzwIqqbj57Jguo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567048; c=relaxed/simple;
	bh=+VW1LRb09QGUVghBfezgN6ikQ/6CBUhR7N8sWTKsxKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAmsyxUa+M54VjscrPvXM5GEdLJTSYpzxICsR0rJSEVJzo/YXcCUSRtb9Tjk+Nk8p9/c4HmLo4+x7fZpiXJqEnpu34g0JJrHrhG0eqFEHN6JiezsM8BUmP9WDnu5Thl03sSHPRaQItNxmuMSgLNoWk4XSv1XEcHOkZULN/eokFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=GNRF5Ip7; arc=fail smtp.client-ip=18.185.115.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.168.141])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 8DB8810000092;
	Mon,  4 Mar 2024 15:43:59 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1709567039.157000
X-TM-MAIL-UUID: 88cb1e92-12ff-4dca-91f6-773498cd14fe
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 26A4E10072460;
	Mon,  4 Mar 2024 15:43:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLgS65iPCRbFoxuTMXVIGyDWh1jaexC3xCEJCGwPXeZ+c6bomiSZbFEvzINXVkoEqwZIjcOEi1EOwogZUMd5TiCYTRWiSNtCiulG/8l3+QsYWwch6CzxWZZg2lQEdjIzF8Ij0RRjS2mhTNb57YXTL5upkFaFg5ePKRHgQViNcot06sStm2wpfJoEX2SfTaGf0zYelK1+yjKrFJ9ka4jFuG3+ktSUmzUdp+o9fDpx7Paw36zsNNL/JusicpYFh7cNqehXzGW8OjIQ7et7QH8I9GcYTimFEpxpfWOSCeq5h+RBHswyoHFFw24qPizNZGoNYWgxh3lo2RpYzYfckujPPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eu2TlG2hVnZmKGmKUroJddoWu2B5Dc33FUjoj7UGw4=;
 b=CznuYketx6WnDdkBNE8FeOgYzB4uDVBvuBSVKZabKn/1ZaJKyp85kPsoI2H6MKFLHIZUB+iJl59UE4UI47JsR/JEM9Oy6KPhEFgW7pOI6jFgD8EsM8TIV8ULK/QG8Fit7ZW93XlQWqeP1pJHEJWH46wJJaywTIg7Sc1IaeLSMUZRC2SdLlAzDkxxO2KRgOG35cAnxPPT4IT9vE0zHTCyoCknNkh1hLeYKP18/HMBdKi595Bf2TBhnsDOwOVC0D3elN34Xutasbc0szyXa+IbJHq3eUbjJnbxZs1Ib8G9uGUHtWrHIzWLFgbaVW8mVj4kHWQvNH/JRTJ2LY039Fu6+A==
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
Subject: [PATCH v2 3/3] virtio-spi: Add virtio SPI driver.
Date: Mon,  4 Mar 2024 16:43:42 +0100
Message-Id: <20240304154342.44021-4-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
References: <20240304154342.44021-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|FR0P281MB3130:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ae8f3071-b686-4bf8-ffc1-08dc3c61e53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qgCVNuvogWvaNgYPQkOQlpw7599yUsbQS8DBEnU/rY+k1XasdZJFcojQwd040dcdc8C2hD3BNxDreEYLXRTBPjv6Esjb5C9+20GvCwnAuWyFwk7752tm005aR7hz1YnzcHUvnNgpNkFG+IxiFuyDz2EXNsy9wLDfKuhxeZnvalaZWazkdOuGTyWhpPU21JGaPQ3UQPXy3N2hQZL8wxzvF/xwS5/iDqAAagVBHgU34uPJKFurTmO8EPiJlZF3mVTLcQ0mMZooX06rDpWQ0wPQs9+2hZ136b65rd2gTfNNMxGG35P9B/TazlG/f7RcsmAfVx/mBeiluVycIYaHgF603F8JgI0uFtXz1PD6OD82mX1Mz5pdRL1/c3ASaOKcmj1qBSU+89c84bw4Ezaqy+m07NoYv/lsS3GwX/yGAgco6NbUBeZcnMIcvkHvfQtqf5n2LHr0C13v6Q7K+grNM1WdkEYji1CXr4OLoCW95TbG1aq3jB8zlwEAVF5DiaWMvI7ayRY5+Y6k1nOG3T18u66VQjcD4R09uNP8+/rIr2K1LDek6clTxOx/lmXICpGisJSfT0Jc/jbaOio8TDWQDs0L76AsZHq9uc5QLQTZH7LUxJAviLmxRocZSyvYsNXZh+xA/9qCspcLa5tAym4az663g1dUnAo8iqan0fEi3amJH1mLIS3D9l0N8D94Ibcng0B2kUON8a30jmyqo4JcqpYoNssbnCCiRVN0IVUMTHCy7Thz7EKIlU1yQY7MshgwV3lk
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:43:53.4370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8f3071-b686-4bf8-ffc1-08dc3c61e53d
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB3130
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28232.000
X-TMASE-Result: 10--17.353100-4.000000
X-TMASE-MatchedRID: 2kGot8vQMiMAsgl6PZgqJOkI20Cl55uDgz5VmKZ8x87hCm8am+SP54vP
	iBq/iW91MpPx8OFzfY0zJJn1odE+3zVxLV/TD3CFsX4aFYAMIYPIQQwRv8gPjskXIF34mJLKOnp
	NWpJkOQuTIJr1EFP8Nn7U1eUtsS59MsZYFnBjXTWF3V/JMHm7u781t3rGD+B++wWpop+OSdw4As
	RtUisW+DmvcaGRO/Oh31jKtZ+jlPPy8yPa5oCwl4WEan0Y08OtfJ3eYkN7pTES6lv5p9KHVZtjb
	vEw2yYya+t98YxCbwSI47i1GQb7nS1CuW+6P3e+BA/ZR5qnp8O4UL3v//+17eY6m/6o4hAKqFty
	1HMHrV6ZNA2b+iaOd6EA84aOEbsGODSqp4i2jlcKonRFsndtvYo3KQs0iA9hiGVApiRLArkow1L
	HBmlcNps6E2fc3GjdUTh5CoFhalLaej9gO1Z/MOBHyXZCGbHqfq7xWexVq1yyBw15H24MRz/m+V
	kiqierl1NYlxxvWUwtgEZJUHc75WBnDtEasdEgiL+RrlWsewrY2awIDlDmurswIO3n6P8FAZjsJ
	4RGp+txn96XTjexE5aFHfoEdhN6n1gAx3HqIFTfb7rnqqBYxQjIhAT2d4YVMHiMmW0ZUNuF6zUv
	sSpW6rEDulXIfwn2AVpeDm8nJoLwnQHFZbUP3moEkqixPwVY91J43y6QhhD2xnAZLOb+d9/upPe
	xrMg4lExlQIQeRG0=
X-TMASE-XGENCLOUD: 5609ae62-6a03-4c89-8412-33257a2aa454-0-0-200-0
X-TM-Deliver-Signature: 5F67A4872DB50A2EEE935219AAD1282E
X-TM-Addin-Auth: er20VbsywMsp/N/O6HWgAT7xwgE0AfXNIvrI8lkoo9Aka+oDG+69pMlarEr
	BJhI9nm6gl/2bvd43D21tzbtHQajDYIvnljLiUwJFef6/8ezt5c49ESZ4XFpt9YCypNttixVryy
	xwpSJKD+ZRt2egM7l0TOvMGozQ0wxr1DcwG9srvn/9i7BcLPsixT1kWG3Q3V+L6f5FQ6q3D0Hnp
	5ziWlzWLM7h3KGE/lPAC96DRY+BTkE9a5AefgZhPcZkphPEW9Mxmt5ZoiI72t2L8z41UycOXX66
	HyMDA2gxxv7ewgk=.Qk74FGzn88JopcSM4B+XJQS6/HDssrz1HpFjKz+FSAjIsNtfKs3836429N
	PxD77abRpqubb4Ga0CUSWM3EbFNKf54p6R+s4LxnFaB5O4I/hcaMFAkRcYEorR/3EKrU7KaZgdG
	KRneTqWHINtk1BgaCwCtC8OAiaqBU4F4Vl4isMg6l086HiVZHstydYwsk8ndVPoAP62TNQTlD8u
	+FybAr3zx8GPFW7PxGjx9nb5im290AeMZE5dnHHVNt9Q/K7lssrnLdDifp6kXDxWKaWulo0hWhD
	DxNVLNu5vzdiXBYp+9ddqjA0y35Qckpqnda63GQbCGMJazgarY4k6TJXUww==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1709567039;
	bh=+VW1LRb09QGUVghBfezgN6ikQ/6CBUhR7N8sWTKsxKI=; l=16591;
	h=From:To:Date;
	b=GNRF5Ip7cIuhFF7loGG5J/LiAUlGLM9dXQjfa66XcvYWmyVJPoODShQH0UkYxRPZW
	 +SaQ4duNjw0fyaKQg3cyRu2Z4hsDY/vLk03cN0PiAI/Z7ezm2+wKbMmS431+e8TBRL
	 vt1yg8Hgi3RGdpQC46CWfQU9dWHUVQ/9Kd2P4dKk1VLQbzfpK7+V/YO8ccKbDqoDsT
	 Zd5LMQwbWZ4GM7PmeWZTxkTB44fPrhtjGankhwwKeSZNUe7JRvCsDefdLYeqbmUvom
	 15d7M3rLf+q2sxAh7xJtgPKY10w9wIisC/IjmsxAthqw5HUMrH9Dh+NXXWC5oaoJz+
	 8GqCQRd3/WWZg==

From: Harald Mommer <harald.mommer@opensynergy.com>

This is the virtio SPI Linux kernel driver.

Signed-off-by: Harald Mommer <Harald.Mommer@opensynergy.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS              |   6 +
 drivers/spi/Kconfig      |  11 +
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-virtio.c | 474 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 492 insertions(+)
 create mode 100644 drivers/spi/spi-virtio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f298c4187fb..42bc6ae594ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23384,6 +23384,12 @@ S:	Maintained
 F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*
 
+VIRTIO SPI DRIVER
+M:	Harald Mommer <harald.mommer@opensynergy.com>
+S:	Maintained
+F:	include/uapi/linux/virtio_spi.h
+F:	drivers/spi/spi-virtio.c
+
 VIRTUAL BOX GUEST DEVICE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
 M:	Arnd Bergmann <arnd@arndb.de>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ddae0fde798e..ff06e595679a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1125,6 +1125,17 @@ config SPI_UNIPHIER
 
 	  If your SoC supports SCSSI, say Y here.
 
+config SPI_VIRTIO
+	tristate "Virtio SPI Controller"
+	depends on SPI_MASTER && VIRTIO
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
index 000000000000..4f22b03fb678
--- /dev/null
+++ b/drivers/spi/spi-virtio.c
@@ -0,0 +1,474 @@
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
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+#include <linux/virtio_spi.h>
+
+struct virtio_spi_req {
+	struct completion completion;
+	struct spi_transfer_head transfer_head	____cacheline_aligned;
+	const uint8_t *tx_buf			____cacheline_aligned;
+	uint8_t *rx_buf				____cacheline_aligned;
+	struct spi_transfer_result result	____cacheline_aligned;
+};
+
+struct virtio_spi_priv {
+	/* Virtio SPI message */
+	struct virtio_spi_req spi_req;
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
+/*
+ *       .   .      .    .    .   .   .   .   .   .
+ * Delay + A +      + B  +    + C + D + E + F + A +
+ *       .   .      .    .    .   .   .   .   .   .
+ *    ___.   .      .    .    .   .   .___.___.   .
+ * CS#   |___.______.____.____.___.___|   .   |___._____________
+ *       .   .      .    .    .   .   .   .   .   .
+ *       .   .      .    .    .   .   .   .   .   .
+ * SCLK__.___.___NNN_____NNN__.___.___.___.___.___.___NNN_______
+ *
+ * NOTE: 1st transfer has two words, the delay between these two words are
+ * 'B' in the diagram.
+ *
+ * A => struct spi_device -> cs_setup
+ * B => max{struct spi_transfer -> word_delay, struct spi_device -> word_delay}
+ *   Note: spi_device and spi_transfer both have word_delay, Linux
+ *         choose the bigger one, refer to _spi_xfer_word_delay_update function
+ * C => struct spi_transfer -> delay
+ * D => struct spi_device -> cs_hold
+ * E => struct spi_device -> cs_inactive
+ * F => struct spi_transfer -> cs_change_delay
+ *
+ * So the corresponding relationship:
+ * A <===> cs_setup_ns (after CS asserted)
+ * B <===> word_delay_ns (no matter with CS)
+ * C+D <===> cs_delay_hold_ns (before CS deasserted)
+ * E+F <===> cs_change_delay_inactive_ns (after CS deasserted, these two
+ * values are also recommended in the Linux driver to be added up)
+ */
+static int virtio_spi_set_delays(struct spi_transfer_head *th,
+				 struct spi_device *spi,
+				 struct spi_transfer *xfer)
+{
+	int cs_setup;
+	int cs_word_delay_xfer;
+	int cs_word_delay_spi;
+	int delay;
+	int cs_hold;
+	int cs_inactive;
+	int cs_change_delay;
+
+	cs_setup = spi_delay_to_ns(&spi->cs_setup, xfer);
+	if (cs_setup < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_setup\n");
+		return cs_setup;
+	}
+	th->cs_setup_ns = cpu_to_le32((u32)cs_setup);
+
+	cs_word_delay_xfer = spi_delay_to_ns(&xfer->word_delay, xfer);
+	if (cs_word_delay_xfer < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_word_delay_xfer\n");
+		return cs_word_delay_xfer;
+	}
+	cs_word_delay_spi = spi_delay_to_ns(&spi->word_delay, xfer);
+	if (cs_word_delay_spi < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_word_delay_spi\n");
+		return cs_word_delay_spi;
+	}
+	if (cs_word_delay_spi > cs_word_delay_xfer)
+		th->word_delay_ns = cpu_to_le32((u32)cs_word_delay_spi);
+	else
+		th->word_delay_ns = cpu_to_le32((u32)cs_word_delay_xfer);
+
+	delay = spi_delay_to_ns(&xfer->delay, xfer);
+	if (delay < 0) {
+		dev_warn(&spi->dev, "Cannot convert delay\n");
+		return delay;
+	}
+	cs_hold = spi_delay_to_ns(&spi->cs_hold, xfer);
+	if (cs_hold < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_hold\n");
+		return cs_hold;
+	}
+	th->cs_delay_hold_ns = cpu_to_le32((u32)delay + (u32)cs_hold);
+
+	cs_inactive = spi_delay_to_ns(&spi->cs_inactive, xfer);
+	if (cs_inactive < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_inactive\n");
+		return cs_inactive;
+	}
+	cs_change_delay = spi_delay_to_ns(&xfer->cs_change_delay, xfer);
+	if (cs_change_delay < 0) {
+		dev_warn(&spi->dev, "Cannot convert cs_change_delay\n");
+		return cs_change_delay;
+	}
+	th->cs_change_delay_inactive_ns =
+		cpu_to_le32((u32)cs_inactive + (u32)cs_change_delay);
+
+	return 0;
+}
+
+static int virtio_spi_transfer_one(struct spi_controller *ctrl,
+				   struct spi_device *spi,
+				   struct spi_transfer *xfer)
+{
+	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
+	struct virtio_spi_req *spi_req = &priv->spi_req;
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
+	ret = virtio_spi_set_delays(th, spi, xfer);
+	if (ret)
+		goto msg_done;
+
+	/* Set buffers */
+	spi_req->tx_buf = xfer->tx_buf;
+	spi_req->rx_buf = xfer->rx_buf;
+
+	/* Prepare sending of virtio message */
+	reinit_completion(&spi_req->completion);
+
+	sg_init_one(&sg_out_head, th, sizeof(*th));
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
+		sgs[outcnt] = &sg_in_payload;
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
+	if (ret)
+		goto msg_done;
+
+	/* Simple implementation: There can be only one transfer in flight */
+	virtqueue_kick(priv->vq);
+
+	wait_for_completion(&priv->spi_req.completion);
+
+	/* Read result from message and translate return code */
+	switch (priv->spi_req.result.result) {
+	case VIRTIO_SPI_TRANS_OK:
+		/* ret is 0 */
+		break;
+	case VIRTIO_SPI_PARAM_ERR:
+		ret = -EINVAL;
+		break;
+	case VIRTIO_SPI_TRANS_ERR:
+		ret = -EIO;
+		break;
+	default: /* Protocol violation */
+		ret = -EIO;
+		break;
+	}
+
+msg_done:
+	if (ret)
+		ctrl->cur_msg->status = ret;
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
+	if (!ctrl)
+		return -ENOMEM;
+
+	priv = spi_controller_get_devdata(ctrl);
+	priv->vdev = vdev;
+	vdev->priv = priv;
+	dev_set_drvdata(&vdev->dev, ctrl);
+
+	init_completion(&priv->spi_req.completion);
+
+	err = of_property_read_u32(np, "spi,bus-num", &bus_num);
+	if (!err && bus_num <= S16_MAX)
+		ctrl->bus_num = (s16)bus_num;
+
+	virtio_spi_read_config(vdev);
+
+	ctrl->transfer_one = virtio_spi_transfer_one;
+
+	err = virtio_spi_find_vqs(priv);
+	if (err) {
+		dev_err(&vdev->dev, "Cannot setup virtqueues\n");
+		return err;
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
+
+		if (!(priv->mode_func_supported & VIRTIO_SPI_CS_HIGH))
+			board_info.mode = SPI_MODE_0;
+		else
+			board_info.mode = SPI_MODE_0 | SPI_CS_HIGH;
+
+		if (!spi_new_device(ctrl, &board_info)) {
+			dev_err(&vdev->dev, "Cannot setup device %u\n", csi);
+			spi_unregister_controller(ctrl);
+			err = -ENODEV;
+			goto err_return;
+		}
+	}
+
+	return 0;
+
+err_return:
+	vdev->config->del_vqs(vdev);
+	return err;
+}
+
+static void virtio_spi_remove(struct virtio_device *vdev)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(&vdev->dev);
+
+	/* Order: 1.) unregister controller, 2.) remove virtqueue */
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
2.43.2


