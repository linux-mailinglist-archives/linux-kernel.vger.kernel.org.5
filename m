Return-Path: <linux-kernel+bounces-22011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8C58297EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD481F25563
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0647A63;
	Wed, 10 Jan 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5pp79yS2"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2BA47786;
	Wed, 10 Jan 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A9DPKa014680;
	Wed, 10 Jan 2024 11:47:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=bKDY4JqLAfcTateE5N/zYQ2tWG6qV9HCBIu52pV908A=; b=5p
	p79yS2VDtFRjVElOOwdF614vkiyhkEebwsdlkx/XwzTg/Ti0VD14wpMbeEbaCbFj
	xpevF3oMEVA/himLk+gzshH8B89mK+I3+mRaoNNU/TmFa4XarMe/Dq5w5X1Uqrjr
	o7zT9l4Ubjcpgzj+EVXJYXQK1seke+q7Dn5j3xaVVeA8S7mJHqoB+zJ24zMLwLev
	p+4xYxd/4BHl90iqNeah9QaWIePuNcZEAN3zO+7HScYMn5rsbEcFHdp+VND1mgvL
	s/ixkSF+8re1eY64Ac9nfA3LxYXTEP7HbohwLhP21BkayvMDbhZ3pDaEtJnY4wc4
	Y42PdFs0hGXlQROyJDUQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vfjpnwk0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:47:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 80ABB10002A;
	Wed, 10 Jan 2024 11:47:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7363326C046;
	Wed, 10 Jan 2024 11:47:02 +0100 (CET)
Received: from localhost (10.201.20.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 10 Jan
 2024 11:47:02 +0100
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC: Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Marco Felsch
	<m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Subject: [RESEND PATCH v6 2/5] media: hantro: add support for STM32MP25 VDEC
Date: Wed, 10 Jan 2024 11:46:39 +0100
Message-ID: <20240110104642.532011-3-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110104642.532011-1-hugues.fruchet@foss.st.com>
References: <20240110104642.532011-1-hugues.fruchet@foss.st.com>
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
index 24b927d8f182..9a34d14c6e40 100644
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
@@ -15,8 +15,8 @@ config VIDEO_HANTRO
 	select V4L2_VP9
 	help
 	  Support for the Hantro IP based Video Processing Units present on
-	  Rockchip and NXP i.MX8M SoCs, which accelerate video and image
-	  encoding and decoding.
+	  Rockchip, NXP i.MX8M and STM32MP25 SoCs, which accelerate video
+	  and image encoding and decoding.
 	  To compile this driver as a module, choose M here: the module
 	  will be called hantro-vpu.
 
@@ -51,3 +51,11 @@ config VIDEO_HANTRO_SUNXI
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
index db3df6cc4513..fe8e2240324c 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -735,6 +735,9 @@ static const struct of_device_id of_hantro_match[] = {
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
index 9aec8a79acdc..0b4806f67630 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -408,6 +408,7 @@ extern const struct hantro_variant rk3568_vpu_variant;
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


