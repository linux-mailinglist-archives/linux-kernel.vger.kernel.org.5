Return-Path: <linux-kernel+bounces-8270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9083B81B4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48DBA286EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5956BB44;
	Thu, 21 Dec 2023 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W/twjhG6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA826ABB7;
	Thu, 21 Dec 2023 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703157512;
	bh=VbjptPM4GNcY1DYymE21BbuCBDKKRsn1bAZk8aP0EFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/twjhG6hdcXLT17GsMAlQxf+w/IsTnzbef+pKYtZoHB+hDusovHT9D5J59Vvs6o2
	 YY+iErQzgHIS4MCIDao25dRyF5yavoh5Mo2CWSCJljNg0OjsDW0eXvQ3mAxKkNYKtQ
	 8QmOKWWDsJLwEl5ZDikfTtCUwfUviRpLHwyvFWXosPaIDlIgH65I1w967CyjwE/a2d
	 MOo+RHAiVAnGRrqGgzx96vL2YY8xrVzXsOLTIhN8FipK+ZfighpnLkINSb9ijEtRKX
	 BzivqxO8akS9PR64jvVF47kyDogxlNHlS2vqYo1URzhia9YRTFdU1Xf+FmYHY4WvJJ
	 umq90AEAwUiXA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2FBCC3781FC9;
	Thu, 21 Dec 2023 11:18:32 +0000 (UTC)
Date: Thu, 21 Dec 2023 12:18:30 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Hugues Fruchet <hugues.fruchet@foss.st.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH v5 2/5] media: hantro: add support for STM32MP25 VDEC
Message-ID: <20231221111830.gx23e6t354jadujk@basti-XPS-13-9310>
References: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
 <20231221084723.2152034-3-hugues.fruchet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20231221084723.2152034-3-hugues.fruchet@foss.st.com>

Hey Hugues,

On 21.12.2023 09:47, Hugues Fruchet wrote:
>Add support for STM32MP25 VDEC video hardware decoder.
>Support of H264/VP8 decoding.
>No post-processor support.
>VDEC has its own reset/clock/irq.
>
>Sucessfully tested up to full HD.

s/Sucessfully/Successfully/

if this turns out to be the only problem, then I can fix it up for the
PR.

Greetings,
Sebastian

>
>Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
>Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>---
> drivers/media/platform/verisilicon/Kconfig    | 14 ++-
> drivers/media/platform/verisilicon/Makefile   |  3 +
> .../media/platform/verisilicon/hantro_drv.c   |  3 +
> .../media/platform/verisilicon/hantro_hw.h    |  1 +
> .../platform/verisilicon/stm32mp25_vdec_hw.c  | 92 +++++++++++++++++++
> 5 files changed, 110 insertions(+), 3 deletions(-)
> create mode 100644 drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
>
>diff --git a/drivers/media/platform/verisilicon/Kconfig b/drivers/media/platform/verisilicon/Kconfig
>index e65b836b9d78..7642ff9cf96c 100644
>--- a/drivers/media/platform/verisilicon/Kconfig
>+++ b/drivers/media/platform/verisilicon/Kconfig
>@@ -4,7 +4,7 @@ comment "Verisilicon media platform drivers"
>
> config VIDEO_HANTRO
> 	tristate "Hantro VPU driver"
>-	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || COMPILE_TEST
>+	depends on ARCH_MXC || ARCH_ROCKCHIP || ARCH_AT91 || ARCH_SUNXI || ARCH_STM32 || COMPILE_TEST
> 	depends on V4L_MEM2MEM_DRIVERS
> 	depends on VIDEO_DEV
> 	select MEDIA_CONTROLLER
>@@ -16,8 +16,8 @@ config VIDEO_HANTRO
> 	select V4L2_VP9
> 	help
> 	  Support for the Hantro IP based Video Processing Units present on
>-	  Rockchip and NXP i.MX8M SoCs, which accelerate video and image
>-	  encoding and decoding.
>+	  Rockchip, NXP i.MX8M and STM32MP25 SoCs, which accelerate video
>+	  and image encoding and decoding.
> 	  To compile this driver as a module, choose M here: the module
> 	  will be called hantro-vpu.
>
>@@ -52,3 +52,11 @@ config VIDEO_HANTRO_SUNXI
> 	default y
> 	help
> 	  Enable support for H6 SoC.
>+
>+config VIDEO_HANTRO_STM32MP25
>+	bool "Hantro STM32MP25 support"
>+	depends on VIDEO_HANTRO
>+	depends on ARCH_STM32 || COMPILE_TEST
>+	default y
>+	help
>+	  Enable support for STM32MP25 SoCs.
>diff --git a/drivers/media/platform/verisilicon/Makefile b/drivers/media/platform/verisilicon/Makefile
>index 6ad2ef885920..5854e0f0dd32 100644
>--- a/drivers/media/platform/verisilicon/Makefile
>+++ b/drivers/media/platform/verisilicon/Makefile
>@@ -39,3 +39,6 @@ hantro-vpu-$(CONFIG_VIDEO_HANTRO_ROCKCHIP) += \
>
> hantro-vpu-$(CONFIG_VIDEO_HANTRO_SUNXI) += \
> 		sunxi_vpu_hw.o
>+
>+hantro-vpu-$(CONFIG_VIDEO_HANTRO_STM32MP25) += \
>+		stm32mp25_vdec_hw.o
>diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>index a9fa05ac56a9..2db27c333924 100644
>--- a/drivers/media/platform/verisilicon/hantro_drv.c
>+++ b/drivers/media/platform/verisilicon/hantro_drv.c
>@@ -733,6 +733,9 @@ static const struct of_device_id of_hantro_match[] = {
> #endif
> #ifdef CONFIG_VIDEO_HANTRO_SUNXI
> 	{ .compatible = "allwinner,sun50i-h6-vpu-g2", .data = &sunxi_vpu_variant, },
>+#endif
>+#ifdef CONFIG_VIDEO_HANTRO_STM32MP25
>+	{ .compatible = "st,stm32mp25-vdec", .data = &stm32mp25_vdec_variant, },
> #endif
> 	{ /* sentinel */ }
> };
>diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
>index 7f33f7b07ce4..b7eccc1a96fc 100644
>--- a/drivers/media/platform/verisilicon/hantro_hw.h
>+++ b/drivers/media/platform/verisilicon/hantro_hw.h
>@@ -406,6 +406,7 @@ extern const struct hantro_variant rk3568_vpu_variant;
> extern const struct hantro_variant rk3588_vpu981_variant;
> extern const struct hantro_variant sama5d4_vdec_variant;
> extern const struct hantro_variant sunxi_vpu_variant;
>+extern const struct hantro_variant stm32mp25_vdec_variant;
>
> extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
> extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
>diff --git a/drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c b/drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
>new file mode 100644
>index 000000000000..aa8b0f751390
>--- /dev/null
>+++ b/drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
>@@ -0,0 +1,92 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * STM32MP25 VDEC video decoder driver
>+ *
>+ * Copyright (C) STMicroelectronics SA 2022
>+ * Authors: Hugues Fruchet <hugues.fruchet@foss.st.com>
>+ *          for STMicroelectronics.
>+ *
>+ */
>+
>+#include "hantro.h"
>+
>+/*
>+ * Supported formats.
>+ */
>+
>+static const struct hantro_fmt stm32mp25_vdec_fmts[] = {
>+	{
>+		.fourcc = V4L2_PIX_FMT_NV12,
>+		.codec_mode = HANTRO_MODE_NONE,
>+		.frmsize = {
>+			.min_width = FMT_MIN_WIDTH,
>+			.max_width = FMT_FHD_WIDTH,
>+			.step_width = MB_DIM,
>+			.min_height = FMT_MIN_HEIGHT,
>+			.max_height = FMT_FHD_HEIGHT,
>+			.step_height = MB_DIM,
>+		},
>+	},
>+	{
>+		.fourcc = V4L2_PIX_FMT_VP8_FRAME,
>+		.codec_mode = HANTRO_MODE_VP8_DEC,
>+		.max_depth = 2,
>+		.frmsize = {
>+			.min_width = FMT_MIN_WIDTH,
>+			.max_width = FMT_FHD_WIDTH,
>+			.step_width = MB_DIM,
>+			.min_height = FMT_MIN_HEIGHT,
>+			.max_height = FMT_FHD_HEIGHT,
>+			.step_height = MB_DIM,
>+		},
>+	},
>+	{
>+		.fourcc = V4L2_PIX_FMT_H264_SLICE,
>+		.codec_mode = HANTRO_MODE_H264_DEC,
>+		.max_depth = 2,
>+		.frmsize = {
>+			.min_width = FMT_MIN_WIDTH,
>+			.max_width = FMT_FHD_WIDTH,
>+			.step_width = MB_DIM,
>+			.min_height = FMT_MIN_HEIGHT,
>+			.max_height = FMT_FHD_HEIGHT,
>+			.step_height = MB_DIM,
>+		},
>+	},
>+};
>+
>+/*
>+ * Supported codec ops.
>+ */
>+
>+static const struct hantro_codec_ops stm32mp25_vdec_codec_ops[] = {
>+	[HANTRO_MODE_VP8_DEC] = {
>+		.run = hantro_g1_vp8_dec_run,
>+		.reset = hantro_g1_reset,
>+		.init = hantro_vp8_dec_init,
>+		.exit = hantro_vp8_dec_exit,
>+	},
>+	[HANTRO_MODE_H264_DEC] = {
>+		.run = hantro_g1_h264_dec_run,
>+		.reset = hantro_g1_reset,
>+		.init = hantro_h264_dec_init,
>+		.exit = hantro_h264_dec_exit,
>+	},
>+};
>+
>+static const struct hantro_irq stm32mp25_irqs[] = {
>+	{ "vdec", hantro_g1_irq },
>+};
>+
>+static const char * const stm32mp25_clk_names[] = { "vdec-clk" };
>+
>+const struct hantro_variant stm32mp25_vdec_variant = {
>+	.dec_fmts = stm32mp25_vdec_fmts,
>+	.num_dec_fmts = ARRAY_SIZE(stm32mp25_vdec_fmts),
>+	.codec = HANTRO_VP8_DECODER | HANTRO_H264_DECODER,
>+	.codec_ops = stm32mp25_vdec_codec_ops,
>+	.irqs = stm32mp25_irqs,
>+	.num_irqs = ARRAY_SIZE(stm32mp25_irqs),
>+	.clk_names = stm32mp25_clk_names,
>+	.num_clocks = ARRAY_SIZE(stm32mp25_clk_names),
>+};
>-- 
>2.25.1
>
>

