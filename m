Return-Path: <linux-kernel+bounces-20617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7836782827B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905271C23814
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C59B2E851;
	Tue,  9 Jan 2024 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="HQh5llwU"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54CF2E650;
	Tue,  9 Jan 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4098pakA009306;
	Tue, 9 Jan 2024 09:52:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=ptsJSTb83rcTd/txenXf6OvD12c8xh0m5TgG+BfI19w=; b=HQ
	h5llwUmLH3dV7CTej4Dj6Xtot6dge9fpzGc8seQRGwJqoWxrCYL31+V9WNuKdgRp
	9aQ66BrFgSalSfysNx53bhyxBWToySDslg55ZNF7lRB3bZU9srMyUSeRk1jcU5Md
	mEdu1a8wgbTWcNDEoQDJu4NQjlV5gODAWVpLTGkLICrZ2m/fko+u2OcQ4wrG7iUR
	0P8X4rs97HvtamDo1A2pNQRevOmRNiwc0KlIAPEGy19UnjzAg9MBzW1C7PLNd7bB
	4giYzXECiRMnUslXY05W6fhRcFvSCkyB4xeoKifmVRlIuzRhJoq4jDTW0IEsClkf
	YqoNHVeMB+/+C5ECk4kA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vexpftuaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 09:52:02 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8EDA510004D;
	Tue,  9 Jan 2024 09:52:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8251322FA51;
	Tue,  9 Jan 2024 09:52:01 +0100 (CET)
Received: from localhost (10.201.20.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 9 Jan
 2024 09:52:01 +0100
From: Hugues Fruchet <hugues.fruchet@foss.st.com>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Benjamin Gaignard
	<benjamin.gaignard@collabora.com>,
        Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida
	<daniel.almeida@collabora.com>,
        Benjamin Mugnier
	<benjamin.mugnier@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC: Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Marco Felsch
	<m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH v6 2/5] media: hantro: add support for STM32MP25 VDEC
Date: Tue, 9 Jan 2024 09:51:52 +0100
Message-ID: <20240109085155.252358-3-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240109085155.252358-1-hugues.fruchet@foss.st.com>
References: <20240109085155.252358-1-hugues.fruchet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

Add support for STM32MP25 VDEC video hardware decoder.
Support of H264/VP8 decoding.
No post-processor support.
VDEC has its own reset/clock/irq.

Successfully tested up to full HD.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
---
 drivers/media/platform/verisilicon/Kconfig    | 14 ++-
 drivers/media/platform/verisilicon/Makefile   |  3 +
 .../media/platform/verisilicon/hantro_drv.c   |  3 +
 .../media/platform/verisilicon/hantro_hw.h    |  1 +
 .../platform/verisilicon/stm32mp25_vpu_hw.c   | 96 +++++++++++++++++++
 5 files changed, 114 insertions(+), 3 deletions(-)
 create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c

diff --git a/drivers/media/platform/verisilicon/Kconfig b/drivers/media/platform/verisilicon/Kconfig
index e65b836b9d78..7642ff9cf96c 100644
--- a/drivers/media/platform/verisilicon/Kconfig
+++ b/drivers/media/platform/verisilicon/Kconfig
@@ -4,7 +4,7 @@ comment "Verisilicon media platform drivers"
 
 config VIDEO_HANTRO
 	tristate "Hantro VPU driver"
-	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || COMPILE_TEST
+	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || ARCH_STM32 || COMPILE_TEST
 	depends on V4L_MEM2MEM_DRIVERS
 	depends on VIDEO_DEV
 	select MEDIA_CONTROLLER
@@ -16,8 +16,8 @@ config VIDEO_HANTRO
 	select V4L2_VP9
 	help
 	  Support for the Hantro IP based Video Processing Units present on
-	  Rockchip and NXP i.MX8M SoCs, which accelerate video and image
-	  encoding and decoding.
+	  Rockchip, NXP i.MX8M and STM32MP25 SoCs, which accelerate video
+	  and image encoding and decoding.
 	  To compile this driver as a module, choose M here: the module
 	  will be called hantro-vpu.
 
@@ -52,3 +52,11 @@ config VIDEO_HANTRO_SUNXI
 	default y
 	help
 	  Enable support for H6 SoC.
+
+config VIDEO_HANTRO_STM32MP25
+	bool "Hantro STM32MP25 support"
+	depends on VIDEO_HANTRO
+	depends on ARCH_STM32 || COMPILE_TEST
+	default y
+	help
+	  Enable support for STM32MP25 SoCs.
diff --git a/drivers/media/platform/verisilicon/Makefile b/drivers/media/platform/verisilicon/Makefile
index 6ad2ef885920..eb38a1833b02 100644
--- a/drivers/media/platform/verisilicon/Makefile
+++ b/drivers/media/platform/verisilicon/Makefile
@@ -39,3 +39,6 @@ hantro-vpu-$(CONFIG_VIDEO_HANTRO_ROCKCHIP) += \
 
 hantro-vpu-$(CONFIG_VIDEO_HANTRO_SUNXI) += \
 		sunxi_vpu_hw.o
+
+hantro-vpu-$(CONFIG_VIDEO_HANTRO_STM32MP25) += \
+		stm32mp25_vpu_hw.o
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index a9fa05ac56a9..2db27c333924 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -733,6 +733,9 @@ static const struct of_device_id of_hantro_match[] = {
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_SUNXI
 	{ .compatible = "allwinner,sun50i-h6-vpu-g2", .data = &sunxi_vpu_variant, },
+#endif
+#ifdef CONFIG_VIDEO_HANTRO_STM32MP25
+	{ .compatible = "st,stm32mp25-vdec", .data = &stm32mp25_vdec_variant, },
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index 7f33f7b07ce4..b7eccc1a96fc 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -406,6 +406,7 @@ extern const struct hantro_variant rk3568_vpu_variant;
 extern const struct hantro_variant rk3588_vpu981_variant;
 extern const struct hantro_variant sama5d4_vdec_variant;
 extern const struct hantro_variant sunxi_vpu_variant;
+extern const struct hantro_variant stm32mp25_vdec_variant;
 
 extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
 extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
diff --git a/drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c b/drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c
new file mode 100644
index 000000000000..6af6edcb6650
--- /dev/null
+++ b/drivers/media/platform/verisilicon/stm32mp25_vpu_hw.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STM32MP25 video codec driver
+ *
+ * Copyright (C) STMicroelectronics SA 2024
+ * Authors: Hugues Fruchet <hugues.fruchet@foss.st.com>
+ *          for STMicroelectronics.
+ *
+ */
+
+#include "hantro.h"
+
+/*
+ * Supported formats.
+ */
+
+static const struct hantro_fmt stm32mp25_vdec_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_NV12,
+		.codec_mode = HANTRO_MODE_NONE,
+		.frmsize = {
+			.min_width = FMT_MIN_WIDTH,
+			.max_width = FMT_FHD_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = FMT_MIN_HEIGHT,
+			.max_height = FMT_FHD_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_VP8_FRAME,
+		.codec_mode = HANTRO_MODE_VP8_DEC,
+		.max_depth = 2,
+		.frmsize = {
+			.min_width = FMT_MIN_WIDTH,
+			.max_width = FMT_FHD_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = FMT_MIN_HEIGHT,
+			.max_height = FMT_FHD_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_H264_SLICE,
+		.codec_mode = HANTRO_MODE_H264_DEC,
+		.max_depth = 2,
+		.frmsize = {
+			.min_width = FMT_MIN_WIDTH,
+			.max_width = FMT_FHD_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = FMT_MIN_HEIGHT,
+			.max_height = FMT_FHD_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
+};
+
+/*
+ * Supported codec ops.
+ */
+
+static const struct hantro_codec_ops stm32mp25_vdec_codec_ops[] = {
+	[HANTRO_MODE_VP8_DEC] = {
+		.run = hantro_g1_vp8_dec_run,
+		.reset = hantro_g1_reset,
+		.init = hantro_vp8_dec_init,
+		.exit = hantro_vp8_dec_exit,
+	},
+	[HANTRO_MODE_H264_DEC] = {
+		.run = hantro_g1_h264_dec_run,
+		.reset = hantro_g1_reset,
+		.init = hantro_h264_dec_init,
+		.exit = hantro_h264_dec_exit,
+	},
+};
+
+/*
+ * Variants.
+ */
+
+static const struct hantro_irq stm32mp25_vdec_irqs[] = {
+	{ "vdec", hantro_g1_irq },
+};
+
+static const char * const stm32mp25_vdec_clk_names[] = { "vdec-clk" };
+
+const struct hantro_variant stm32mp25_vdec_variant = {
+	.dec_fmts = stm32mp25_vdec_fmts,
+	.num_dec_fmts = ARRAY_SIZE(stm32mp25_vdec_fmts),
+	.codec = HANTRO_VP8_DECODER | HANTRO_H264_DECODER,
+	.codec_ops = stm32mp25_vdec_codec_ops,
+	.irqs = stm32mp25_vdec_irqs,
+	.num_irqs = ARRAY_SIZE(stm32mp25_vdec_irqs),
+	.clk_names = stm32mp25_vdec_clk_names,
+	.num_clocks = ARRAY_SIZE(stm32mp25_vdec_clk_names),
+};
-- 
2.25.1


