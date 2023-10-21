Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEDC7D1BBC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 10:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjJUIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUIa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:30:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A355D41;
        Sat, 21 Oct 2023 01:30:21 -0700 (PDT)
Received: from localhost (89-26-75-29.dyn.cablelink.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D4736607314;
        Sat, 21 Oct 2023 09:30:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697877019;
        bh=kIE/B1VBG9CnAwJuFyku+qlURqJ0Uw31i7DxVdQN65k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGkgia41S68jSewltRL/bH/v/umy0Z+so9Bif1odI2i+Gu0Cy0HGV38ibuGXfsIx3
         ZnVv5ktjdCCH6ZK9Jq5INlYrzKZ0rK7IvL7iKhGB5JOYyJ5U/5h4+5O21+RgOvYa2/
         gAB1UmynDzkph8VGg23pJ81YtSmmjK4DzrZgSpnuynhUy1kSlRwlbAhW9UtM+XnqK1
         2a3FrO1v33rtCv6UCoVFxR8MidOv33cBmUGK4qzD0GbDtLEEfYfu3iTXZ/raAKXbls
         bmlDa89kdLtNvO4TYcOnGK8wMtbDca0M6TdMb/MwsxJgfdMbfXLxT+r6NV1+WXuTTA
         wWPlTqdiUGVIA==
Date:   Sat, 21 Oct 2023 10:30:15 +0200
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
Subject: Re: [PATCH 1/7] media: mediatek: vcodec: Getting the chip name of
 each platform
Message-ID: <20231021083015.ivxvmrm7fq5pofdp@basti-XPS-13-9310>
References: <20231016064346.31451-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20231016064346.31451-1-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Yunfei,

Thanks for your patches!

Could you provide a cover-letter for the next version please?
This will help to get a good context of why we need these changes and to
store the changelog in a helpful manner.
Thanks.

On 16.10.2023 14:43, Yunfei Dong wrote:
>Getting the chip name of each platform according to the device
>compatible to set different parameter.

I would reword this commit description slightly, basically what you
change is that you store the chip name in context permanently and that
you utilize a enum to be more descriptive.

So how about:

"""
Store the name of the chip in the context of the driver in order to be
able to choose the correct configuration values for the different codecs.
Use a enum value instead of an integer to store a more descriptive name.
"""

A few more comments below.

>
>Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>---
> .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  | 24 +----------------
> .../vcodec/decoder/mtk_vcodec_dec_drv.c       | 26 +++++++++++++++++++
> .../vcodec/decoder/mtk_vcodec_dec_drv.h       | 17 ++++++++++++
> 3 files changed, 44 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
>index 91ed576d6821..ba742f0e391d 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec.c
>@@ -208,36 +208,14 @@ static int vidioc_vdec_dqbuf(struct file *file, void *priv,
> 	return v4l2_m2m_dqbuf(file, ctx->m2m_ctx, buf);
> }
>
>-static int mtk_vcodec_dec_get_chip_name(void *priv)
>-{
>-	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
>-	struct device *dev = &ctx->dev->plat_dev->dev;
>-
>-	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec"))
>-		return 8173;
>-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8183-vcodec-dec"))
>-		return 8183;
>-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8192-vcodec-dec"))
>-		return 8192;
>-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8195-vcodec-dec"))
>-		return 8195;
>-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8186-vcodec-dec"))
>-		return 8186;
>-	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8188-vcodec-dec"))
>-		return 8188;
>-	else
>-		return 8173;
>-}
>-
> static int vidioc_vdec_querycap(struct file *file, void *priv,
> 				struct v4l2_capability *cap)
> {
> 	struct mtk_vcodec_dec_ctx *ctx = fh_to_dec_ctx(priv);
> 	struct device *dev = &ctx->dev->plat_dev->dev;
>-	int platform_name = mtk_vcodec_dec_get_chip_name(priv);
>
> 	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
>-	snprintf(cap->card, sizeof(cap->card), "MT%d video decoder", platform_name);
>+	snprintf(cap->card, sizeof(cap->card), "MT%d video decoder", ctx->dev->chip_name);
>
> 	return 0;
> }
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
>index 0a89ce452ac3..f47c98faf068 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.c
>@@ -326,6 +326,26 @@ static const struct v4l2_file_operations mtk_vcodec_fops = {
> 	.mmap		= v4l2_m2m_fop_mmap,
> };
>
>+static void mtk_vcodec_dec_get_chip_name(struct mtk_vcodec_dec_dev *vdec_dev)
>+{
>+	struct device *dev = &vdec_dev->plat_dev->dev;
>+
>+	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-vcodec-dec"))
>+		vdec_dev->chip_name = MTK_VDEC_MT8173;
>+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8183-vcodec-dec"))
>+		vdec_dev->chip_name = MTK_VDEC_MT8183;
>+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8192-vcodec-dec"))
>+		vdec_dev->chip_name = MTK_VDEC_MT8192;
>+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8195-vcodec-dec"))
>+		vdec_dev->chip_name = MTK_VDEC_MT8195;
>+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8186-vcodec-dec"))
>+		vdec_dev->chip_name = MTK_VDEC_MT8186;
>+	else if (of_device_is_compatible(dev->of_node, "mediatek,mt8188-vcodec-dec"))
>+		vdec_dev->chip_name = MTK_VDEC_MT8188;
>+	else
>+		vdec_dev->chip_name = MTK_VDEC_INVAL;
>+}
>+
> static int mtk_vcodec_probe(struct platform_device *pdev)
> {
> 	struct mtk_vcodec_dec_dev *dev;
>@@ -341,6 +361,12 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
> 	INIT_LIST_HEAD(&dev->ctx_list);
> 	dev->plat_dev = pdev;
>
>+	mtk_vcodec_dec_get_chip_name(dev);
>+	if (dev->chip_name == MTK_VDEC_INVAL) {
>+		dev_err(&pdev->dev, "Failed to get decoder chip name");
>+		return -EINVAL;
>+	}
>+
> 	dev->vdec_pdata = of_device_get_match_data(&pdev->dev);
> 	if (!of_property_read_u32(pdev->dev.of_node, "mediatek,vpu",
> 				  &rproc_phandle)) {
>diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
>index 7e36b2c69b7d..8f228ba9aa47 100644
>--- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
>+++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h
>@@ -18,6 +18,19 @@
> #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
> #define IS_VDEC_INNER_RACING(capability) ((capability) & MTK_VCODEC_INNER_RACING)
>
>+/*
>+ * enum mtk_vcodec_dec_chip_name - Structure used to separate different platform
>+ */

I don't feel like this comment is terribly helpful because it is pretty
clear what the enum is about, I would just drop it.

>+enum mtk_vcodec_dec_chip_name {
>+	MTK_VDEC_INVAL = 0,
>+	MTK_VDEC_MT8173 = 8173,
>+	MTK_VDEC_MT8183 = 8183,
>+	MTK_VDEC_MT8186 = 8186,
>+	MTK_VDEC_MT8188 = 8188,
>+	MTK_VDEC_MT8192 = 8192,
>+	MTK_VDEC_MT8195 = 8195,
>+};
>+
> /*
>  * enum mtk_vdec_format_types - Structure used to get supported
>  *		  format types according to decoder capability
>@@ -249,6 +262,8 @@ struct mtk_vcodec_dec_ctx {
>  * @vdec_racing_info: record register value
>  * @dec_racing_info_mutex: mutex lock used for inner racing mode
>  * @dbgfs: debug log related information
>+ *
>+ * @chip_name: the chip name used to separate different platform

I wouldn't repeat chip name in the description and specify more
concretely why we need to separate the platforms.

My suggestion:

  * @chip_name: used to distinguish platforms and select the correct codec configuration values.

>  */
> struct mtk_vcodec_dec_dev {
> 	struct v4l2_device v4l2_dev;
>@@ -289,6 +304,8 @@ struct mtk_vcodec_dec_dev {
> 	/* Protects access to vdec_racing_info data */
> 	struct mutex dec_racing_info_mutex;
> 	struct mtk_vcodec_dbgfs dbgfs;
>+
>+	enum mtk_vcodec_dec_chip_name chip_name;
> };
>
> static inline struct mtk_vcodec_dec_ctx *fh_to_dec_ctx(struct v4l2_fh *fh)

Besides those small wording choices, the patch looks good.

So with these issues resolved:

Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Regards,
Sebastian
>-- 
>2.18.0
>
