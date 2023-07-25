Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9370760F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjGYJjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjGYJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:38:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD64223;
        Tue, 25 Jul 2023 02:37:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51C16615D3;
        Tue, 25 Jul 2023 09:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C2CC433B9;
        Tue, 25 Jul 2023 09:37:23 +0000 (UTC)
Message-ID: <b2f44154-79a2-b5e4-4f59-bc578e19e31f@xs4all.nl>
Date:   Tue, 25 Jul 2023 11:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7,06/11] media: mediatek: vcodec: replace pr_* with dev_*
 for v4l2 debug message
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230722074230.30558-1-yunfei.dong@mediatek.com>
 <20230722074230.30558-7-yunfei.dong@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230722074230.30558-7-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2023 09:42, Yunfei Dong wrote:
> Adding different macro mtk_v4l2_vdec_dbg and mtk_v4l2_venc_dbg for
> encoder and decoder. Then calling the common macro mtk_v4l2_debug to
> print debug message.
> 
> Replace pr_err with dev_err for 'mtk_v4l2_err' debug message.
> Replace pr_debug with dev_dbg for 'mtk_v4l2_debug' debug message.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 116 +++++-----
>  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  54 +++--
>  .../mediatek/vcodec/mtk_vcodec_dec_hw.c       |   7 +-
>  .../mediatek/vcodec/mtk_vcodec_dec_pm.c       |  19 +-
>  .../mediatek/vcodec/mtk_vcodec_dec_stateful.c | 143 ++++++------
>  .../vcodec/mtk_vcodec_dec_stateless.c         |  62 ++---
>  .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 211 ++++++++----------
>  .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  45 ++--
>  .../mediatek/vcodec/mtk_vcodec_enc_pm.c       |   8 +-
>  .../platform/mediatek/vcodec/mtk_vcodec_fw.c  |   2 +-
>  .../mediatek/vcodec/mtk_vcodec_fw_scp.c       |   2 +-
>  .../mediatek/vcodec/mtk_vcodec_fw_vpu.c       |   7 +-
>  .../mediatek/vcodec/mtk_vcodec_intr.c         |  12 +-
>  .../mediatek/vcodec/mtk_vcodec_util.c         |  30 ++-
>  .../mediatek/vcodec/mtk_vcodec_util.h         |  27 ++-
>  .../vcodec/vdec/vdec_av1_req_lat_if.c         |  10 +-
>  .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |  14 +-
>  .../vcodec/vdec/vdec_h264_req_multi_if.c      |  16 +-
>  .../vcodec/vdec/vdec_hevc_req_multi_if.c      |  14 +-
>  .../platform/mediatek/vcodec/vdec_drv_if.c    |   4 +-
>  .../platform/mediatek/vcodec/vdec_msg_queue.c |  52 +++--
>  .../platform/mediatek/vcodec/vdec_msg_queue.h |   2 +
>  .../platform/mediatek/vcodec/vdec_vpu_if.c    |   2 +-
>  23 files changed, 417 insertions(+), 442 deletions(-)
> 

<snip>

> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> index fd951ff47fc3..6bc822c7d825 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> @@ -11,6 +11,9 @@
>  #include <linux/types.h>
>  #include <linux/dma-direction.h>
>  
> +#define MTK_DBG_VCODEC_STR "[MTK_VCODEC]"
> +#define MTK_DBG_V4L2_STR "[MTK_V4L2]"
> +
>  struct mtk_vcodec_mem {
>  	size_t size;
>  	void *va;
> @@ -28,8 +31,8 @@ struct mtk_vcodec_dev;
>  #undef pr_fmt
>  #define pr_fmt(fmt) "%s(),%d: " fmt, __func__, __LINE__
>  
> -#define mtk_v4l2_err(fmt, args...)                \
> -	pr_err("[MTK_V4L2][ERROR] " fmt "\n", ##args)
> +#define mtk_v4l2_err(plat_dev, fmt, args...)                            \
> +	dev_err(&(plat_dev)->dev, "[MTK_V4L2][ERROR] " fmt "\n", ##args)
>  
>  #define mtk_vcodec_err(inst_id, plat_dev, fmt, args...)                                 \
>  	dev_err(&(plat_dev)->dev, "[MTK_VCODEC][ERROR][%d]: " fmt "\n", inst_id, ##args)
> @@ -38,11 +41,11 @@ struct mtk_vcodec_dev;
>  extern int mtk_v4l2_dbg_level;
>  extern int mtk_vcodec_dbg;
>  
> -#define mtk_v4l2_debug(level, fmt, args...)				\
> -	do {								\
> -		if (mtk_v4l2_dbg_level >= (level))			\
> -			pr_debug("[MTK_V4L2] %s, %d: " fmt "\n",        \
> -				 __func__, __LINE__, ##args);	        \
> +#define mtk_v4l2_debug(plat_dev, level, fmt, args...)                             \
> +	do {                                                                      \
> +		if (mtk_v4l2_dbg_level >= (level))                                \
> +			dev_dbg(&(plat_dev)->dev, "[MTK_V4L2] %s, %d: " fmt "\n", \
> +				 __func__, __LINE__, ##args);                     \
>  	} while (0)

You forgot to add 'plat_dev' to the argument list of the mtk_v4l2_debug
macro when CONFIG_DEBUG_FS is not set. That causes zillions of compiler
warnings.

>  
>  #define mtk_vcodec_debug(inst_id, plat_dev, fmt, args...)                               \
> @@ -70,6 +73,16 @@ extern int mtk_vcodec_dbg;
>  #define mtk_venc_debug(ctx, fmt, args...)                              \
>  	mtk_vcodec_debug((ctx)->id, (ctx)->dev->plat_dev, fmt, ##args)
>  
> +#define mtk_v4l2_vdec_err(ctx, fmt, args...) mtk_v4l2_err((ctx)->dev->plat_dev, fmt, ##args)
> +
> +#define mtk_v4l2_vdec_dbg(level, ctx, fmt, args...)             \
> +	mtk_v4l2_debug((ctx)->dev->plat_dev, level, fmt, ##args)
> +
> +#define mtk_v4l2_venc_err(ctx, fmt, args...) mtk_v4l2_err((ctx)->dev->plat_dev, fmt, ##args)
> +
> +#define mtk_v4l2_venc_dbg(level, ctx, fmt, args...)             \
> +	mtk_v4l2_debug((ctx)->dev->plat_dev, level, fmt, ##args)
> +
>  void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned int reg_idx);
>  int mtk_vcodec_write_vdecsys(struct mtk_vcodec_ctx *ctx, unsigned int reg, unsigned int val);
>  int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);

Regards,

	Hans

