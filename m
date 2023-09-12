Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C62179CBD1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjILJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjILJbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:31:03 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA2A118
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:30:59 -0700 (PDT)
X-KPN-MessageId: 0d095a7b-514f-11ee-b85c-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 0d095a7b-514f-11ee-b85c-005056992ed3;
        Tue, 12 Sep 2023 11:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=tbcgu7MNJKnt0lu/X9TWh5HxE0+gC7FcDZZymdF80oI=;
        b=H7c42TRlL3s3WG+vc9ngeulpENmlXoaphkWusMMplUDJyfD71UzUXDikENsTPTBvaJnOlXVAa6c4s
         4xyBkXjamlisIrvFWjW05OK6+SXEDhiDKlwPuP3nkO4CkHzJVOy//v+RVALQGG/PB3oMvAUa9X2/rD
         yD/mLPTdoYF7FD74OYt8I8H/U8yAVhfFMltTdBDp/yRKCCp8eCXtIV3wzVG2uSaw08PRteso2mwvUu
         iCdIzkyQ0SvtogNc25BDMbpmTucUMNp6V79PDQKtJNB8ekKJTmqnmoR7jx618LT3SDUqJeZRWkeO21
         NIyljCXj5Yg2XJKOHEevWpvcfsP9Zww==
X-KPN-MID: 33|nrxi0pWqsUgkX9IDvvIcpLP6/oTA2sYu8xIDYeMqD0+oUKUH+mJRjmGv5GVnWZb
 JfKDI28NjYXjugeiwQzDBl7/JzGq6Y3egTWXYVneCbCc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vGIDk8wX97GLaFMM2308imONnDauwJOLZSCt15+i5uErzb6+aNZS2o1TFzrqySU
 Y/eFoqhWnOCtnYbNucx+SZQ==
X-Originating-IP: 173.38.220.60
Received: from [10.47.77.214] (unknown [173.38.220.60])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 12decda6-514f-11ee-ac77-00505699b758;
        Tue, 12 Sep 2023 11:30:56 +0200 (CEST)
Message-ID: <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl>
Date:   Tue, 12 Sep 2023 11:30:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder
 driver
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>,
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
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
 <20230911125936.10648-13-yunfei.dong@mediatek.com>
 <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/11/23 17:54, Nicolas Dufresne wrote:
> Hi,
> 
> Le lundi 11 septembre 2023 à 20:59 +0800, Yunfei Dong a écrit :
>> Setting secure mode flag to kernel when trying to play secure video,
>> then decoder driver will initialize tee related interface to support
>> svp.
> 
> 
> This is not what the patch is doing, please rework. This patch is an vendor API
> addition introducing V4L2_CID_MPEG_MTK_SET_SECURE_MODE. I should not have to
> read your patch to understand this.
> 
>>
>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>> ---
>>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c     | 15 ++++++++++++++-
>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
>>  include/uapi/linux/v4l2-controls.h                |  1 +
>>  3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
>> index d2b09ce9f1cf..a981178c25d9 100644
>> --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
>> +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_stateless.c
>> @@ -535,6 +535,17 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl *ctrl)
>>  		ctrl->val = mtk_dma_contig_get_secure_handle(ctx, ctrl->val);
>>  		mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d => 0x%x", sec_fd, ctrl->val);
>>  		break;
>> +	case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> 
> Stepping back a little and focusing on the API, what makes your driver so
> special that it should be the only one having a "secure mode" ? We are touching
> in gap in the media pipeline in Linux, and this should come with consideration
> of the global API.
> 
> Why is this API better then let's say Google Android one, were they expose 2
> device nodes in their fork of the MFC driver (a secure and a non secure one) ?

Perhaps it is a good idea to first post an RFC with an uAPI proposal on how to
handle secure video. I suspect this isn't mediatek specific, other SoCs with
tee support could use this as well.

As Nicolas said, it's long known to be a gap in our media support, so it is
really great that you started work on this, but you need to look at this from
a more generic point-of-view, and not mediatek-specific.

Regards,

	Hans

> 
> regards,
> Nicolas
> 
> p.s. you forgot to document your control in the RST doc, please do in following
> release.
> 
>> +		ctx->is_svp_mode = ctrl->val;
>> +
>> +		if (ctx->is_svp_mode) {
>> +			ret = mtk_vcodec_dec_optee_open(ctx->dev->optee_private);
>> +			if (ret)
>> +				mtk_v4l2_vdec_err(ctx, "open secure mode failed.");
>> +			else
>> +				mtk_v4l2_vdec_dbg(3, ctx, "decoder in secure mode: %d", ctrl->val);
>> +		}
>> +		break;
>>  	default:
>>  		mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id: 0x%x\n", hdr_ctrl->id);
>>  		return ret;
>> @@ -573,7 +584,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
>>  	unsigned int i;
>>  	struct v4l2_ctrl *ctrl;
>>  
>> -	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
>> +	v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 2);
>>  	if (ctx->ctrl_hdl.error) {
>>  		mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n");
>>  		return ctx->ctrl_hdl.error;
>> @@ -592,6 +603,8 @@ static int mtk_vcodec_dec_ctrls_setup(struct mtk_vcodec_dec_ctx *ctx)
>>  
>>  	ctrl = v4l2_ctrl_new_std(&ctx->ctrl_hdl, &mtk_vcodec_dec_ctrl_ops,
>>  				 V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0, 65535, 1, 0);
>> +	ctrl = v4l2_ctrl_new_std(&ctx->ctrl_hdl, &mtk_vcodec_dec_ctrl_ops,
>> +				 V4L2_CID_MPEG_MTK_SET_SECURE_MODE, 0, 65535, 1, 0);
>>  
>>  	v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
>>  
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> index d8cf01f76aab..a507045a3f30 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> @@ -1042,6 +1042,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>  	case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:	return "Reference Frames for a P-Frame";
>>  	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:		return "Prepend SPS and PPS to IDR";
>>  	case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:		return "MediaTek Decoder get secure handle";
>> +	case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:			return "MediaTek Decoder set secure mode";
>>  
>>  	/* AV1 controls */
>>  	case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:			return "AV1 Profile";
>> @@ -1442,6 +1443,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>  		*type = V4L2_CTRL_TYPE_INTEGER;
>>  		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
>>  		break;
>> +	case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
>> +		*type = V4L2_CTRL_TYPE_INTEGER;
>> +		*flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
>> +		break;
>>  	case V4L2_CID_USER_CLASS:
>>  	case V4L2_CID_CAMERA_CLASS:
>>  	case V4L2_CID_CODEC_CLASS:
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>> index 7b3694985366..88e90d943e38 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -957,6 +957,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_type {
>>  /*  MPEG-class control IDs specific to the MediaTek Decoder driver as defined by V4L2 */
>>  #define V4L2_CID_MPEG_MTK_BASE			(V4L2_CTRL_CLASS_CODEC | 0x2000)
>>  #define V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE	(V4L2_CID_MPEG_MTK_BASE+8)
>> +#define V4L2_CID_MPEG_MTK_SET_SECURE_MODE	(V4L2_CID_MPEG_MTK_BASE+9)
>>  
>>  /*  Camera class control IDs */
>>  
> 

