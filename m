Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D467D1C09
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjJUJX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjJUJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:23:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B60B0;
        Sat, 21 Oct 2023 02:23:49 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 000716607314;
        Sat, 21 Oct 2023 10:23:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697880228;
        bh=WlVZ7ZMsuMZogPd2cfuUgr4t+u7d4kIFM09tuxRbbmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovFYUc4skr4Qg0XjjInKUXk17nnLmnaEkhzy/jbXkz2m4gjMjRTB4ynAeEhdhRH0M
         weOq5lC3Xa3CcnjSD7X137iNyleDhN2cJ4UjnY7eZWHwMUhN13xoIxuj0wUsuCnWcs
         nhCqxL+GtEZAXykzkcr13RZMmWXrwIZZqZlP8FSCyTJZSs602jTd0gLqGOzimpAIOZ
         MOVQq99IfypacrSyXe2qp75HAN/LvgN2iB3gG42L0J6+5fBOXo3rpCw+8blfBnuAGs
         XQxv5N6283jQ032buhuEmH00Ds46HhT3xgEqXo15BBBgnb8u7k00BePZkY3GsbxnWQ
         Q2aF5rFymXJIw==
Date:   Sat, 21 Oct 2023 11:23:45 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     =?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 2/7] media: mediatek: vcodec: Setting the supported h264
 level for each platform
Message-ID: <20231021092345.2636a7utfdb3nbv5@basti-XPS-13-9310>
References: <20231016064346.31451-1-yunfei.dong@mediatek.com>
 <20231016064346.31451-2-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20231016064346.31451-2-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yunfei,

On 16.10.2023 14:43, Yunfei Dong wrote:
>The supported resolution and fps of different platforms are not the
>same. Need to set the supported level according to the chip name.

I would suggest the following rewording:

Set the maximum H264 codec level for each platform.
The various mediatek platforms support different levels for decoding,
the level of the codec limits among others the maximum resolution, bit
rate and frame rate for the decoder.

With that you can add:
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Regards,
Sebastian

>
>Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>---
> .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 45 +++++++++++++++++++
> 1 file changed, 45 insertions(+)
>
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
>index e29c9c58f3da..f4af81bddc58 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
>@@ -56,6 +56,15 @@ static const struct mtk_stateless_control mtk_stateless_controls[] = {
> 		},
> 		.codec_type = V4L2_PIX_FMT_H264_SLICE,
> 	},
>+	{
>+		.cfg = {
>+			.id = V4L2_CID_MPEG_VIDEO_H264_LEVEL,
>+			.min = V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
>+			.def = V4L2_MPEG_VIDEO_H264_LEVEL_4_1,
>+			.max = V4L2_MPEG_VIDEO_H264_LEVEL_4_2,
>+		},
>+		.codec_type = V4L2_PIX_FMT_H264_SLICE,
>+	},
> 	{
> 		.cfg = {
> 			.id = V4L2_CID_STATELESS_H264_DECODE_MODE,
>@@ -519,6 +528,40 @@ static const struct v4l2_ctrl_ops mtk_vcodec_dec_ctrl_ops = {
> 	.s_ctrl = mtk_vdec_s_ctrl,
> };
>
>+static void mtk_vcodec_dec_fill_h264_level(struct v4l2_ctrl_config *cfg,
>+					   struct mtk_vcodec_dec_ctx *ctx)
>+{
>+	switch (ctx->dev->chip_name) {
>+	case MTK_VDEC_MT8192:
>+		cfg->max = V4L2_MPEG_VIDEO_H264_LEVEL_5_1;
>+		break;
>+	case MTK_VDEC_MT8188:
>+	case MTK_VDEC_MT8195:
>+		cfg->max = V4L2_MPEG_VIDEO_H264_LEVEL_5_2;
>+		break;
>+	case MTK_VDEC_MT8183:
>+	case MTK_VDEC_MT8186:
>+		cfg->max = V4L2_MPEG_VIDEO_H264_LEVEL_4_2;
>+		break;
>+	default:
>+		cfg->max = V4L2_MPEG_VIDEO_H264_LEVEL_4_1;
>+		break;
>+	};
>+}
>+
>+static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
>+					  struct mtk_vcodec_dec_ctx *ctx)
>+{
>+	switch (cfg->id) {
>+	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
>+		mtk_vcodec_dec_fill_h264_level(cfg, ctx);
>+		mtk_v4l2_vdec_dbg(3, ctx, "h264 supported level: %lld %lld", cfg->max, cfg->def);
>+		break;
>+	default:
>+		break;
>+	};
>+}
>+
> static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
> {
> 	unsigned int i;
>@@ -532,6 +575,8 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
> 	for (i = 0; i < NUM_CTRLS; i++) {
> 		struct v4l2_ctrl_config cfg = mtk_stateless_controls[i].cfg;
> 		cfg.ops = &mtk_vcodec_dec_ctrl_ops;
>+
>+		mtk_vcodec_dec_reset_controls(&cfg, ctx);
> 		v4l2_ctrl_new_custom(&ctx->ctrl_hdl, &cfg, NULL);
> 		if (ctx->ctrl_hdl.error) {
> 			mtk_v4l2_vdec_err(ctx, "Adding control %d failed %d", i,
>-- 
>2.18.0
>
