Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1627A19C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjIOI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbjIOI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:56:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE23C24;
        Fri, 15 Sep 2023 01:54:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29E3C433C7;
        Fri, 15 Sep 2023 08:54:50 +0000 (UTC)
Message-ID: <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
Date:   Fri, 15 Sep 2023 10:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder
 driver
Content-Language: en-US, nl
To:     =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
 <20230911125936.10648-13-yunfei.dong@mediatek.com>
 <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
 <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl>
 <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:25, Yunfei Dong (董云飞) wrote:
> Hi Hans & Nicolas,
> 
> Thanks for your advice.
> 
> On Tue, 2023-09-12 at 11:30 +0200, Hans Verkuil wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  Hi,
>>
>> On 9/11/23 17:54, Nicolas Dufresne wrote:
>>> Hi,
>>>
>>> Le lundi 11 septembre 2023 à 20:59 +0800, Yunfei Dong a écrit :
>>>> Setting secure mode flag to kernel when trying to play secure
>>
>> video,
>>>> then decoder driver will initialize tee related interface to
>>
>> support
>>>> svp.
>>>
>>>
>>> This is not what the patch is doing, please rework. This patch is
>>
>> an vendor API
>>> addition introducing V4L2_CID_MPEG_MTK_SET_SECURE_MODE. I should
>>
>> not have to
>>> read your patch to understand this.
>>>
>>>>
>>>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>>>> ---
>>>>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c     | 15
>>
>> ++++++++++++++-
>>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
>>>>  include/uapi/linux/v4l2-controls.h                |  1 +
>>>>  3 files changed, 20 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git
>>
>> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
>> less.c
>> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
>> less.c
>>>> index d2b09ce9f1cf..a981178c25d9 100644
>>>> ---
>>
>> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
>> less.c
>>>> +++
>>
>> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
>> less.c
>>>> @@ -535,6 +535,17 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl
>>
>> *ctrl)
>>>>  ctrl->val = mtk_dma_contig_get_secure_handle(ctx, ctrl->val);
>>>>  mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d => 0x%x",
>>
>> sec_fd, ctrl->val);
>>>>  break;
>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
>>>
>>> Stepping back a little and focusing on the API, what makes your
>>
>> driver so
>>> special that it should be the only one having a "secure mode" ? We
>>
>> are touching
>>> in gap in the media pipeline in Linux, and this should come with
>>
>> consideration
>>> of the global API.
>>>
>>> Why is this API better then let's say Google Android one, were they
>>
>> expose 2
>>> device nodes in their fork of the MFC driver (a secure and a non
>>
>> secure one) ?
>>
>> Perhaps it is a good idea to first post an RFC with an uAPI proposal
>> on how to
>> handle secure video. I suspect this isn't mediatek specific, other
>> SoCs with
>> tee support could use this as well.
>>
>> As Nicolas said, it's long known to be a gap in our media support, so
>> it is
>> really great that you started work on this, but you need to look at
>> this from
>> a more generic point-of-view, and not mediatek-specific.
>>
> 
> Whether your have any advice about how to do a more generic driver to
> handle secure video playback?
> 
> There are several kind of buffer: output queue buffer/capture queue
> buffer/working buffer.
> 
> output and capture queue buffer: user space will call tee related
> interface to allocate secure handle. Will convert to secure handle with
> v4l2 framework, then send secure handle to optee-os.
> 
> working buffer: calling dma_heap and dma_buf to get secure memory
> handle, then covert secure iova in optee-os.
> 
> Using the same kernel driver for svp and non-svp playback, just the
> buffer type are different. Normal is iova and secure is secure handle.
> 
> User driver will tell the kernel driver with CID control whether the
> current playback is svp or non-svp.

My understanding is that when you switch to secure mode, the driver makes
some optee calls to set everything up. And userspace needs a way convert a
dmabuf fd to a 'secure handle', which appears to be the DMA address of the
buffer. Who uses that handle?

In any case, using a control to switch to secure mode and using a control
to convert a dmabuf fd to a secure handle seems a poor choice to me.

I was wondering if it wouldn't be better to create a new V4L2_MEMORY_ type,
e.g. V4L2_MEMORY_DMABUF_SECURE (or perhaps _DMABUF_OPTEE). That ensures that
once you create buffers for the first time, the driver can switch into secure
mode, and until all buffers are released again you know that the driver will
stay in secure mode.

For converting the dmabuf fd into a secure handle: a new ioctl similar to
VIDIOC_EXPBUF might be more suited for that.

Note that I am the first to admit that I have no experience with secure
video pipelines or optee-os, so I am looking at this purely from an uAPI
perspective.

Regards,

	Hans

> 
> Best Regards,
> Yunfei Dong
>> Regards,
>>
>> Hans
>>
>>>
>>> regards,
>>> Nicolas
>>>
>>> p.s. you forgot to document your control in the RST doc, please do
>>
>> in following
>>> release.
>>>
>>>> +ctx->is_svp_mode = ctrl->val;
>>>> +
>>>> +if (ctx->is_svp_mode) {
>>>> +ret = mtk_vcodec_dec_optee_open(ctx->dev->optee_private);
>>>> +if (ret)
>>>> +mtk_v4l2_vdec_err(ctx, "open secure mode failed.");
>>>> +else
>>>> +mtk_v4l2_vdec_dbg(3, ctx, "decoder in secure mode: %d", ctrl-
>>>
>>> val);
>>>> +}
>>>> +break;
>>>>  default:
>>>>  mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id:
>>>> 0x%x\n",
>>
>> hdr_ctrl->id);
>>>>  return ret;
>>>> @@ -573,7 +584,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct
>>
>> mtk_vcodec_dec_ctx *ctx)
>>>>  unsigned int i;
>>>>  struct v4l2_ctrl *ctrl;
>>>>  
>>>> -v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
>>>> +v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 2);
>>>>  if (ctx->ctrl_hdl.error) {
>>>>  mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n");
>>>>  return ctx->ctrl_hdl.error;
>>>> @@ -592,6 +603,8 @@ static int mtk_vcodec_dec_ctrls_setup(struct
>>
>> mtk_vcodec_dec_ctx *ctx)
>>>>  
>>>>  ctrl = v4l2_ctrl_new_std(&ctx->ctrl_hdl,
>>
>> &mtk_vcodec_dec_ctrl_ops,
>>>>   V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0, 65535, 1, 0);
>>>> +ctrl = v4l2_ctrl_new_std(&ctx->ctrl_hdl,
>>
>> &mtk_vcodec_dec_ctrl_ops,
>>>> + V4L2_CID_MPEG_MTK_SET_SECURE_MODE, 0, 65535, 1, 0);
>>>>  
>>>>  v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
>>>>  
>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>
>> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> index d8cf01f76aab..a507045a3f30 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> @@ -1042,6 +1042,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>>  case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:return
>>>> "Reference
>>
>> Frames for a P-Frame";
>>>>  case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:return "Prepend
>>
>> SPS and PPS to IDR";
>>>>  case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:return "MediaTek
>>>> Decoder
>>
>> get secure handle";
>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:return "MediaTek Decoder
>>
>> set secure mode";
>>>>  
>>>>  /* AV1 controls */
>>>>  case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:return "AV1 Profile";
>>>> @@ -1442,6 +1443,10 @@ void v4l2_ctrl_fill(u32 id, const char
>>
>> **name, enum v4l2_ctrl_type *type,
>>>>  *type = V4L2_CTRL_TYPE_INTEGER;
>>>>  *flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
>>>>  break;
>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
>>>> +*type = V4L2_CTRL_TYPE_INTEGER;
>>>> +*flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
>>>> +break;
>>>>  case V4L2_CID_USER_CLASS:
>>>>  case V4L2_CID_CAMERA_CLASS:
>>>>  case V4L2_CID_CODEC_CLASS:
>>>> diff --git a/include/uapi/linux/v4l2-controls.h
>>
>> b/include/uapi/linux/v4l2-controls.h
>>>> index 7b3694985366..88e90d943e38 100644
>>>> --- a/include/uapi/linux/v4l2-controls.h
>>>> +++ b/include/uapi/linux/v4l2-controls.h
>>>> @@ -957,6 +957,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_type {
>>>>  /*  MPEG-class control IDs specific to the MediaTek Decoder
>>
>> driver as defined by V4L2 */
>>>>  #define V4L2_CID_MPEG_MTK_BASE(V4L2_CTRL_CLASS_CODEC | 0x2000)
>>>>  #define
>>
>> V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE(V4L2_CID_MPEG_MTK_BASE+8)
>>>> +#define
>>
>> V4L2_CID_MPEG_MTK_SET_SECURE_MODE(V4L2_CID_MPEG_MTK_BASE+9)
>>>>  
>>>>  /*  Camera class control IDs */
>>>>  

