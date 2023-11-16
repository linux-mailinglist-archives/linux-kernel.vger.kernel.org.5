Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB57EE49F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345436AbjKPPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345351AbjKPPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:48:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF21D5A;
        Thu, 16 Nov 2023 07:48:31 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C4316607359;
        Thu, 16 Nov 2023 15:48:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700149710;
        bh=FWoRq71D+3CZWvgfQamGU6bN0kUnW+MQUhCIbwvri58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmvWKIACvVm8j1f0ShhDkQUcTBQpus3oQZsJORrCeE0Zs22+DDxZtF123CnE5cdlo
         LNAbDrYcaX3lN76LF2kTVRecK7MfohVzK29uMcu/sGkh1cjm3beTb+QhQ65gRpyRoU
         vpGjAg1yyqacC6K4acERKOE9Z/K2PlMwNVjWxT7qD1ucqibzuZ/2YkNgus43Bw3VTf
         Y3rNiyomHPbD8jBLEJbe99QkHFerTrbozpkaMu8yzaK/9AKlqLcFllDflm8IzGjayn
         qOuP3b00Zp8E5sZm/im6xXR3kU6sDok8wz1JYCzBZNWT7vsUt8ZebTUtpVBIC5Iq1b
         2q6bAj/bppDVA==
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com
Subject: [RFC 3/6] media: verisilicon: Improve constant's name
Date:   Thu, 16 Nov 2023 16:48:13 +0100
Message-Id: <20231116154816.70959-4-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231116154816.70959-1-andrzej.p@collabora.com>
References: <20231116154816.70959-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For VP8 BIT(18) of this register is for enabling the boolean encoder.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_h1_regs.h    | 2 +-
 drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_h1_regs.h b/drivers/media/platform/verisilicon/hantro_h1_regs.h
index 7752d1291c0e..c1c66c934a24 100644
--- a/drivers/media/platform/verisilicon/hantro_h1_regs.h
+++ b/drivers/media/platform/verisilicon/hantro_h1_regs.h
@@ -70,7 +70,7 @@
 #define    H1_REG_ENC_CTRL2_DISABLE_QUARTER_PIXMV	BIT(22)
 #define    H1_REG_ENC_CTRL2_TRANS8X8_MODE_EN		BIT(21)
 #define    H1_REG_ENC_CTRL2_CABAC_INIT_IDC(x)		((x) << 19)
-#define    H1_REG_ENC_CTRL2_ENTROPY_CODING_MODE		BIT(18)
+#define    H1_REG_ENC_CTRL2_VP8_BOOLENC_ENABLE		BIT(18)
 #define    H1_REG_ENC_CTRL2_H264_INTER4X4_MODE		BIT(17)
 #define    H1_REG_ENC_CTRL2_H264_STREAM_MODE		BIT(16)
 #define    H1_REG_ENC_CTRL2_INTRA16X16_MODE(x)		((x))
diff --git a/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c b/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
index 05aa0dd9c09c..08c5079fbfd0 100644
--- a/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
+++ b/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
@@ -1226,7 +1226,7 @@ static void hantro_h1_vp8_enc_set_params(struct hantro_dev *vpu, struct hantro_c
 	reg = 0;
 	if (mb_width * mb_height > MAX_MB_COUNT_TO_DISABLE_QUARTER_PIXEL_MV)
 		reg = H1_REG_ENC_CTRL2_DISABLE_QUARTER_PIXMV;
-	reg |= H1_REG_ENC_CTRL2_ENTROPY_CODING_MODE;
+	reg |= H1_REG_ENC_CTRL2_VP8_BOOLENC_ENABLE;
 
 	inter_favor = 128 - ctx->vp8_enc.prob_intra;
 	if (inter_favor >= 0)
-- 
2.25.1

