Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6B57B7D49
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjJDKh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjJDKh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:37:57 -0400
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5DAC;
        Wed,  4 Oct 2023 03:37:53 -0700 (PDT)
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 394A3871022388;
        Wed, 4 Oct 2023 12:37:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=bgESotg1ucUNSxBe+XGbEGaW9PYWluU0WM6A0IsNEdg=; b=Dh
        TkSwk68XxCzi7PobhB0rUzKN57p+5wFuuVF0eGrzAl9O2MONGD6dZYCoYDs5wHg0
        g02IODDZYqmmzIMwzdD/LUdYcd1Rx5S00w/1i2kUXnSbYpCNAXOc2GlBmbdZ3HLm
        ctRH8+ZVrSTB9jIY7eqtNFAbxmK524hwCTSXg5mjjrUWlVTMjqVg/wFqOZqLnN4C
        W29G6ar14K9YQ36dHyE+pxSWg6/WUXDg5R7NXWmKqDv24dC84CKjjLo/b5C7W0zZ
        Q3WHXdFqo9vnDxAVSYVOLryRCZJp69/bno1rSMpu9UHRGq95BeUmGOLBuHm6NaXR
        Y29qCeTOVd8y6uLy5+wg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3texmj69fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 12:37:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AC88B10005C;
        Wed,  4 Oct 2023 12:37:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A12E2231510;
        Wed,  4 Oct 2023 12:37:31 +0200 (CEST)
Received: from localhost (10.201.20.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 12:37:31 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
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
        Hans Verkuil <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Subject: [RFC 4/6] media: hantro: add VP8 encode support for STM32MP25 VENC
Date:   Wed, 4 Oct 2023 12:37:18 +0200
Message-ID: <20231004103720.3540436-5-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004103720.3540436-1-hugues.fruchet@foss.st.com>
References: <20231004103720.3540436-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_02,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VP8 stateless support for STM32MP25 VENC video hardware encoder.

Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
---
 .../platform/verisilicon/stm32mp25_venc_hw.c  | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c b/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
index 0aac33afcadc..2176eccd1f79 100644
--- a/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
+++ b/drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
@@ -87,6 +87,19 @@ static const struct hantro_fmt stm32mp25_venc_fmts[] = {
 			.step_height = MB_DIM,
 		},
 	},
+	{
+		.fourcc = V4L2_PIX_FMT_VP8_FRAME,
+		.codec_mode = HANTRO_MODE_VP8_ENC,
+		.max_depth = 2,
+		.frmsize = {
+			.min_width = 96,
+			.max_width = 4080,
+			.step_width = MB_DIM,
+			.min_height = 96,
+			.max_height = 4080,
+			.step_height = MB_DIM,
+		},
+	},
 };
 
 static irqreturn_t stm32mp25_venc_irq(int irq, void *dev_id)
@@ -120,6 +133,13 @@ static const struct hantro_codec_ops stm32mp25_venc_codec_ops[] = {
 		.reset = stm32mp25_venc_reset,
 		.done = hantro_h1_jpeg_enc_done,
 	},
+	[HANTRO_MODE_VP8_ENC] = {
+		.run = hantro_h1_vp8_enc_run,
+		.reset = stm32mp25_venc_reset,
+		.init = hantro_vp8_enc_init,
+		.done = hantro_h1_vp8_enc_done,
+		.exit = hantro_vp8_enc_exit,
+	},
 };
 
 /*
@@ -137,7 +157,7 @@ static const char * const stm32mp25_venc_clk_names[] = {
 const struct hantro_variant stm32mp25_venc_variant = {
 	.enc_fmts = stm32mp25_venc_fmts,
 	.num_enc_fmts = ARRAY_SIZE(stm32mp25_venc_fmts),
-	.codec = HANTRO_JPEG_ENCODER,
+	.codec = HANTRO_JPEG_ENCODER | HANTRO_VP8_ENCODER,
 	.codec_ops = stm32mp25_venc_codec_ops,
 	.irqs = stm32mp25_venc_irqs,
 	.num_irqs = ARRAY_SIZE(stm32mp25_venc_irqs),
-- 
2.25.1

