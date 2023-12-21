Return-Path: <linux-kernel+bounces-8271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0149281B4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4A51C23B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A625B6E2C2;
	Thu, 21 Dec 2023 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s7Ia43Bt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690306D1CA;
	Thu, 21 Dec 2023 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703157518;
	bh=2y+AFJ2E2tAlzXWqVd2TVOftiClzXpdJZMYw206QFqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7Ia43BtOPNb4MY5rahsKjZbOfPa3c8NWWpc+GotYFgxQEoLvwpQ8ciCH/wx95l6L
	 a4MXtzWvRoe+q0XNes5Dh8rS25on3HW+5EaL8rUW7LP/8ewIz21013N108kFdzlBSA
	 ZHm0GE3k1vRuti69qaeiwpHhZub8HR6xkGPXD+pf+lexmRcymwzUoFvNFS65c5wOik
	 EHBJ0+79hWVy4FBekWMrTHY/r1eEkJYwXtxo3BPm0EywChSCl3mWzyTJfn24G2DgrU
	 Bhp8fh/V1MvJYRoFLLGtAxqYVtAKCIZzOKc0ERSOye2DpJ0wZ8H74YmjVfSXO+RL4C
	 3a8Heq6g5PIlw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F379B3782001;
	Thu, 21 Dec 2023 11:18:37 +0000 (UTC)
Date: Thu, 21 Dec 2023 12:18:37 +0100
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
Subject: Re: [PATCH v5 3/5] media: hantro: add support for STM32MP25 VENC
Message-ID: <20231221111837.4u22pmba7jd3hinj@basti-XPS-13-9310>
References: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
 <20231221084723.2152034-4-hugues.fruchet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20231221084723.2152034-4-hugues.fruchet@foss.st.com>

Hey Hugues,

one small comment below, if it should turn out to be the only problem I
can fix it myself for the pull request.

On 21.12.2023 09:47, Hugues Fruchet wrote:
>Add support for STM32MP25 VENC video hardware encoder.
>Support of JPEG encoding.
>VENC has its own reset/clock/irq.
>
>Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
>Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>---
> drivers/media/platform/verisilicon/Makefile   |   3 +-
> .../media/platform/verisilicon/hantro_drv.c   |   1 +
> .../media/platform/verisilicon/hantro_hw.h    |   1 +
> .../platform/verisilicon/stm32mp25_venc_hw.c  | 115 ++++++++++++++++++
> 4 files changed, 119 insertions(+), 1 deletion(-)
> create mode 100644 drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
>
>diff --git a/drivers/media/platform/verisilicon/Makefile b/drivers/media/platform/verisilicon/Makefile
>index 5854e0f0dd32..3bf43fdbedc1 100644
>--- a/drivers/media/platform/verisilicon/Makefile
>+++ b/drivers/media/platform/verisilicon/Makefile
>@@ -41,4 +41,5 @@ hantro-vpu-$(CONFIG_VIDEO_HANTRO_SUNXI) += \
> 		sunxi_vpu_hw.o
>
> hantro-vpu-$(CONFIG_VIDEO_HANTRO_STM32MP25) += \
>-		stm32mp25_vdec_hw.o
>+		stm32mp25_vdec_hw.o \
>+		stm32mp25_venc_hw.o
>diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>index 2db27c333924..4d97a8ac03de 100644
>--- a/drivers/media/platform/verisilicon/hantro_drv.c
>+++ b/drivers/media/platform/verisilicon/hantro_drv.c
>@@ -736,6 +736,7 @@ static const struct of_device_id of_hantro_match[] = {
> #endif
> #ifdef CONFIG_VIDEO_HANTRO_STM32MP25
> 	{ .compatible = "st,stm32mp25-vdec", .data = &stm32mp25_vdec_variant, },
>+	{ .compatible = "st,stm32mp25-venc", .data = &stm32mp25_venc_variant, },
> #endif
> 	{ /* sentinel */ }
> };
>diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
>index b7eccc1a96fc..70c72e9d11d5 100644
>--- a/drivers/media/platform/verisilicon/hantro_hw.h
>+++ b/drivers/media/platform/verisilicon/hantro_hw.h
>@@ -407,6 +407,7 @@ extern const struct hantro_variant rk3588_vpu981_variant;
> extern const struct hantro_variant sama5d4_vdec_variant;
> extern const struct hantro_variant sunxi_vpu_variant;
> extern const struct hantro_variant stm32mp25_vdec_variant;
>+extern const struct hantro_variant stm32mp25_venc_variant;
>
> extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
> extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
>diff --git a/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c b/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
>new file mode 100644
>index 000000000000..0ff0f073b922
>--- /dev/null
>+++ b/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
>@@ -0,0 +1,115 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/*
>+ * STM32MP25 VENC video encoder driver
>+ *
>+ * Copyright (C) STMicroelectronics SA 2022
>+ * Authors: Hugues Fruchet <hugues.fruchet@foss.st.com>
>+ *          for STMicroelectronics.
>+ *
>+ */
>+
>+#include <linux/clk.h>
>+#include <linux/delay.h>
>+#include <linux/reset.h>
>+
>+#include "hantro.h"
>+#include "hantro_jpeg.h"
>+#include "hantro_h1_regs.h"
>+
>+/*
>+ * Supported formats.
>+ */
>+
>+static const struct hantro_fmt stm32mp25_venc_fmts[] = {
>+	{
>+		.fourcc = V4L2_PIX_FMT_YUV420M,
>+		.codec_mode = HANTRO_MODE_NONE,
>+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420P,
>+	},
>+	{
>+		.fourcc = V4L2_PIX_FMT_NV12M,
>+		.codec_mode = HANTRO_MODE_NONE,
>+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420SP,
>+	},
>+	{
>+		.fourcc = V4L2_PIX_FMT_YUYV,
>+		.codec_mode = HANTRO_MODE_NONE,
>+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUYV422,
>+	},
>+	{
>+		.fourcc = V4L2_PIX_FMT_UYVY,
>+		.codec_mode = HANTRO_MODE_NONE,
>+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_UYVY422,
>+	},
>+	{
>+		.fourcc = V4L2_PIX_FMT_JPEG,
>+		.codec_mode = HANTRO_MODE_JPEG_ENC,
>+		.max_depth = 2,
>+		.header_size = JPEG_HEADER_SIZE,
>+		.frmsize = {
>+			.min_width = 96,
>+			.max_width = FMT_4K_WIDTH,
>+			.step_width = MB_DIM,
>+			.min_height = 96,
>+			.max_height = FMT_4K_HEIGHT,
>+			.step_height = MB_DIM,
>+		},
>+	},
>+};
>+
>+static irqreturn_t stm32mp25_venc_irq(int irq, void *dev_id)
>+{
>+	struct hantro_dev *vpu = dev_id;
>+	enum vb2_buffer_state state;
>+	u32 status;
>+
>+	status = vepu_read(vpu, H1_REG_INTERRUPT);
>+	state = (status & H1_REG_INTERRUPT_FRAME_RDY) ?
>+		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
>+
>+	vepu_write(vpu, H1_REG_INTERRUPT_BIT, H1_REG_INTERRUPT);
>+
>+	hantro_irq_done(vpu, state);
>+
>+	return IRQ_HANDLED;
>+}
>+
>+static void stm32mp25_venc_reset(struct hantro_ctx *ctx)
>+{
>+}
>+
>+/*
>+ * Supported codec ops.
>+ */
>+
>+static const struct hantro_codec_ops stm32mp25_venc_codec_ops[] = {
>+	[HANTRO_MODE_JPEG_ENC] = {
>+		.run = hantro_h1_jpeg_enc_run,
>+		.reset = stm32mp25_venc_reset,
>+		.done = hantro_h1_jpeg_enc_done,
>+	},
>+};
>+
>+/*
>+ * Variants.
>+ */
>+
>+static const struct hantro_irq stm32mp25_venc_irqs[] = {
>+	{ "venc", stm32mp25_venc_irq },
>+};
>+
>+static const char * const stm32mp25_venc_clk_names[] = {
>+	"venc-clk"
>+};
>+
>+const struct hantro_variant stm32mp25_venc_variant = {
>+	.enc_fmts = stm32mp25_venc_fmts,
>+	.num_enc_fmts = ARRAY_SIZE(stm32mp25_venc_fmts),
>+	.codec = HANTRO_JPEG_ENCODER,
>+	.codec_ops = stm32mp25_venc_codec_ops,
>+	.irqs = stm32mp25_venc_irqs,
>+	.num_irqs = ARRAY_SIZE(stm32mp25_venc_irqs),
>+	.clk_names = stm32mp25_venc_clk_names,
>+	.num_clocks = ARRAY_SIZE(stm32mp25_venc_clk_names)
>+};
>+

There is an superfluous new line here.

Greetings,
Sebastian

>-- 
>2.25.1
>
>

