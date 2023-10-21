Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4801C7D1C43
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjJUJrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjJUJrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:47:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBEE10CC;
        Sat, 21 Oct 2023 02:47:37 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F39F6607337;
        Sat, 21 Oct 2023 10:47:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697881656;
        bh=3EEfWwRJVneHJoBHkAnll2cb7orvXzxeDtOgWDZBml0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1SYoNWGM08YbCHkOFz7n1c/HdRk9GioDlFlnVqrELuqxMX/12NhpPM4Gu66SS7nh
         FKpxN5lxoIa7VvV9PuaHuTrZInnfqBTwboRA4clIq3zv2QwVqlwxAIsq0gEPBUqyuQ
         q2mQTjWl6Z7zdMcSok1MYgJSTtvVc4tml5/glCrWlT5EG8qDQUzJTaUBCyV0Jrrg/0
         lLE0Pwl5BZBdlxAtCpbo3tJ6yXFzFnUog7iJCmN8vfDb8cgTRRYyjwAT7NoR+4+5lS
         CgSRb+/rX8mUnP+SnB5sozjfKh/v8NcZx0JHt305kuLkpHJkSvZJoIJw/AJv7FEuFn
         CgC5s9c/2xx0g==
Date:   Sat, 21 Oct 2023 11:47:34 +0200
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
Subject: Re: [PATCH 4/7] media: mediatek: vcodec: Setting the supported h264
 profile for each platform
Message-ID: <20231021094734.7osgimxoljlseztv@basti-XPS-13-9310>
References: <20231016064346.31451-1-yunfei.dong@mediatek.com>
 <20231016064346.31451-4-yunfei.dong@mediatek.com>
 <20231021092905.3uxfwckgn5ndon6x@basti-XPS-13-9310>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20231021092905.3uxfwckgn5ndon6x@basti-XPS-13-9310>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yunfei,

please replace Setting with Set in the title.

On 21.10.2023 11:29, Sebastian Fricke wrote:
>Hey Yunfei,
>
>On 16.10.2023 14:43, Yunfei Dong wrote:
>>The supported format type of different platforms are not the
>>same. Need to set the supported profile according to the chip name.
>
>I would suggest the following rewording:
>
>Set the maximum H264 codec profile for each platform.
>The various mediatek platforms support different profiles for decoding,
>the profile of the codec limits the capabilities for decoding.
>
>With that you can add:
>Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>
>Regards,
>Sebastian
>
>>
>>Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>>---
>>.../vcodec/decoder/mtk_vcodec_dec_stateless.c | 19 +++++++++++++++++++
>>1 file changed, 19 insertions(+)
>>
>>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
>>index 1fdb21dbacb8..84c0bed577ed 100644
>>--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
>>+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
>>@@ -559,6 +559,20 @@ static void mtk_vcodec_dec_fill_h264_level(struct v4l2_ctrl_config *cfg,
>>	};
>>}
>>
>>+static void mtk_vcodec_dec_fill_h264_profile(struct v4l2_ctrl_config *cfg,
>>+					     struct mtk_vcodec_dec_ctx *ctx)
>>+{
>>+	switch (ctx->dev->chip_name) {
>>+	case MTK_VDEC_MT8188:
>>+	case MTK_VDEC_MT8195:
>>+		cfg->max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10;
>>+		break;
>>+	default:
>>+		cfg->max = V4L2_MPEG_VIDEO_H264_PROFILE_HIGH;
>>+		break;
>>+	};
>>+}
>>+
>>static void mtk_vcodec_dec_fill_h265_level(struct v4l2_ctrl_config *cfg,
>>					   struct mtk_vcodec_dec_ctx *ctx)
>>{
>>@@ -585,6 +599,11 @@ static void mtk_vcodec_dec_reset_controls(struct v4l2_ctrl_config *cfg,
>>		mtk_vcodec_dec_fill_h265_level(cfg, ctx);
>>		mtk_v4l2_vdec_dbg(3, ctx, "h265 supported level: %lld %lld", cfg->max, cfg->def);
>>		break;
>>+	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
>>+		mtk_vcodec_dec_fill_h264_profile(cfg, ctx);
>>+		mtk_v4l2_vdec_dbg(3, ctx, "h264 supported profile: %lld %lld", cfg->max,
>>+				  cfg->menu_skip_mask);
>>+		break;
>>	default:
>>		break;
>>	};
>>-- 
>>2.18.0
>>
