Return-Path: <linux-kernel+bounces-8013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC8681B09D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229A31C21D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B8208D6;
	Thu, 21 Dec 2023 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QMbf25ZS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAB31A278;
	Thu, 21 Dec 2023 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BL8CpGY025683;
	Thu, 21 Dec 2023 09:47:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=R1VdLTKhisRhrx/hR2YEgrUzMLGZk0THIvAGsHtYups=; b=QM
	bf25ZSunO07rBjpgVDn4aGbN8iGtvdwUTUh1B7nTGgMyEvIZq8ESZa5qcESaLoUK
	VBRlK6UyolOyOodZnn9CTyYEIX84hU3CulBGraP5SWRA08pFKwpJwAtVJjfLYNHr
	kQlRLj4i8EagqKDr1sFUU9z3asx/Jq9A+3f4r7mqgsU3ctoP6I1fUfbQvuv+X3LS
	N8bIHglPVYz+KBFlFOaIVtKVogIM3BL7C3IzqNB3Nnn41E8seJ5ufud4E17QPUP4
	kXCh7VYLRu5q7JaFYlCHIF3uXdhU12rmzaHedi0HdqDU4d4pYhu56c2Jw/MJvk2L
	Y2ZMGjMSgmim4QZ35lZw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v14426agx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 09:47:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BFD0100063;
	Thu, 21 Dec 2023 09:47:28 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E55F22A6D7;
	Thu, 21 Dec 2023 09:47:28 +0100 (CET)
Received: from localhost (10.201.20.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Dec
 2023 09:47:27 +0100
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
Subject: [PATCH v5 3/5] media: hantro: add support for STM32MP25 VENC
Date: Thu, 21 Dec 2023 09:47:21 +0100
Message-ID: <20231221084723.2152034-4-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
References: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_04,2023-12-20_01,2023-05-22_02

Add support for STM32MP25 VENC video hardware encoder.
Support of JPEG encoding.
VENC has its own reset/clock/irq.

Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 drivers/media/platform/verisilicon/Makefile   |   3 +-
 .../media/platform/verisilicon/hantro_drv.c   |   1 +
 .../media/platform/verisilicon/hantro_hw.h    |   1 +
 .../platform/verisilicon/stm32mp25_venc_hw.c  | 115 ++++++++++++++++++
 4 files changed, 119 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/verisilicon/stm32mp25_venc_hw.c

diff --git a/drivers/media/platform/verisilicon/Makefile b/drivers/media/platform/verisilicon/Makefile
index 5854e0f0dd32..3bf43fdbedc1 100644
--- a/drivers/media/platform/verisilicon/Makefile
+++ b/drivers/media/platform/verisilicon/Makefile
@@ -41,4 +41,5 @@ hantro-vpu-$(CONFIG_VIDEO_HANTRO_SUNXI) += \
 		sunxi_vpu_hw.o
 
 hantro-vpu-$(CONFIG_VIDEO_HANTRO_STM32MP25) += \
-		stm32mp25_vdec_hw.o
+		stm32mp25_vdec_hw.o \
+		stm32mp25_venc_hw.o
diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 2db27c333924..4d97a8ac03de 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -736,6 +736,7 @@ static const struct of_device_id of_hantro_match[] = {
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_STM32MP25
 	{ .compatible = "st,stm32mp25-vdec", .data = &stm32mp25_vdec_variant, },
+	{ .compatible = "st,stm32mp25-venc", .data = &stm32mp25_venc_variant, },
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index b7eccc1a96fc..70c72e9d11d5 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -407,6 +407,7 @@ extern const struct hantro_variant rk3588_vpu981_variant;
 extern const struct hantro_variant sama5d4_vdec_variant;
 extern const struct hantro_variant sunxi_vpu_variant;
 extern const struct hantro_variant stm32mp25_vdec_variant;
+extern const struct hantro_variant stm32mp25_venc_variant;
 
 extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
 extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
diff --git a/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c b/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
new file mode 100644
index 000000000000..0ff0f073b922
--- /dev/null
+++ b/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * STM32MP25 VENC video encoder driver
+ *
+ * Copyright (C) STMicroelectronics SA 2022
+ * Authors: Hugues Fruchet <hugues.fruchet@foss.st.com>
+ *          for STMicroelectronics.
+ *
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/reset.h>
+
+#include "hantro.h"
+#include "hantro_jpeg.h"
+#include "hantro_h1_regs.h"
+
+/*
+ * Supported formats.
+ */
+
+static const struct hantro_fmt stm32mp25_venc_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_YUV420M,
+		.codec_mode = HANTRO_MODE_NONE,
+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420P,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_NV12M,
+		.codec_mode = HANTRO_MODE_NONE,
+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420SP,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YUYV,
+		.codec_mode = HANTRO_MODE_NONE,
+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUYV422,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.codec_mode = HANTRO_MODE_NONE,
+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_UYVY422,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_JPEG,
+		.codec_mode = HANTRO_MODE_JPEG_ENC,
+		.max_depth = 2,
+		.header_size = JPEG_HEADER_SIZE,
+		.frmsize = {
+			.min_width = 96,
+			.max_width = FMT_4K_WIDTH,
+			.step_width = MB_DIM,
+			.min_height = 96,
+			.max_height = FMT_4K_HEIGHT,
+			.step_height = MB_DIM,
+		},
+	},
+};
+
+static irqreturn_t stm32mp25_venc_irq(int irq, void *dev_id)
+{
+	struct hantro_dev *vpu = dev_id;
+	enum vb2_buffer_state state;
+	u32 status;
+
+	status = vepu_read(vpu, H1_REG_INTERRUPT);
+	state = (status & H1_REG_INTERRUPT_FRAME_RDY) ?
+		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
+
+	vepu_write(vpu, H1_REG_INTERRUPT_BIT, H1_REG_INTERRUPT);
+
+	hantro_irq_done(vpu, state);
+
+	return IRQ_HANDLED;
+}
+
+static void stm32mp25_venc_reset(struct hantro_ctx *ctx)
+{
+}
+
+/*
+ * Supported codec ops.
+ */
+
+static const struct hantro_codec_ops stm32mp25_venc_codec_ops[] = {
+	[HANTRO_MODE_JPEG_ENC] = {
+		.run = hantro_h1_jpeg_enc_run,
+		.reset = stm32mp25_venc_reset,
+		.done = hantro_h1_jpeg_enc_done,
+	},
+};
+
+/*
+ * Variants.
+ */
+
+static const struct hantro_irq stm32mp25_venc_irqs[] = {
+	{ "venc", stm32mp25_venc_irq },
+};
+
+static const char * const stm32mp25_venc_clk_names[] = {
+	"venc-clk"
+};
+
+const struct hantro_variant stm32mp25_venc_variant = {
+	.enc_fmts = stm32mp25_venc_fmts,
+	.num_enc_fmts = ARRAY_SIZE(stm32mp25_venc_fmts),
+	.codec = HANTRO_JPEG_ENCODER,
+	.codec_ops = stm32mp25_venc_codec_ops,
+	.irqs = stm32mp25_venc_irqs,
+	.num_irqs = ARRAY_SIZE(stm32mp25_venc_irqs),
+	.clk_names = stm32mp25_venc_clk_names,
+	.num_clocks = ARRAY_SIZE(stm32mp25_venc_clk_names)
+};
+
-- 
2.25.1


