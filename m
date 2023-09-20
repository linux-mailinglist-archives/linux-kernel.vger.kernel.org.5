Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7206F7A73C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjITHLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbjITHLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:11:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B4AD;
        Wed, 20 Sep 2023 00:10:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE4AC433C7;
        Wed, 20 Sep 2023 07:10:40 +0000 (UTC)
Message-ID: <7ed371e9-ffc1-4802-8de0-3190a9bb661d@xs4all.nl>
Date:   Wed, 20 Sep 2023 09:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder
 driver
Content-Language: en-US, nl
To:     Jeffrey Kardatzke <jkardatzke@google.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
 <CA+ddPcN6EaFERC60_Z_-ZmWzqyUEwxiDCZwt_U6Y-gpaAu76tA@mail.gmail.com>
 <ff7aa575-c820-4dfa-853f-77438b8b149a@xs4all.nl>
 <b7d661637eacbda3e83d192b1126fc3970c4f50d.camel@collabora.com>
 <CA+ddPcPq3XrJGPqjZDq0u_ga6Aat1ve5ODBDD-OouO3xPSCFuA@mail.gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <CA+ddPcPq3XrJGPqjZDq0u_ga6Aat1ve5ODBDD-OouO3xPSCFuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 21:49, Jeffrey Kardatzke wrote:
> On Tue, Sep 19, 2023 at 11:51 AM Nicolas Dufresne
> <nicolas.dufresne@collabora.com> wrote:
>>
>> Le mardi 19 septembre 2023 à 10:53 +0200, Hans Verkuil a écrit :
>>> On 18/09/2023 22:57, Jeffrey Kardatzke wrote:
>>>> On Fri, Sep 15, 2023 at 1:56 AM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>>>>>
>>>>> On 15/09/2023 10:25, Yunfei Dong (董云飞) wrote:
>>>>>> Hi Hans & Nicolas,
>>>>>>
>>>>>> Thanks for your advice.
>>>>>>
>>>>>> On Tue, 2023-09-12 at 11:30 +0200, Hans Verkuil wrote:
>>>>>>>
>>>>>>> External email : Please do not click links or open attachments until
>>>>>>> you have verified the sender or the content.
>>>>>>>  Hi,
>>>>>>>
>>>>>>> On 9/11/23 17:54, Nicolas Dufresne wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> Le lundi 11 septembre 2023 à 20:59 +0800, Yunfei Dong a écrit :
>>>>>>>>> Setting secure mode flag to kernel when trying to play secure
>>>>>>>
>>>>>>> video,
>>>>>>>>> then decoder driver will initialize tee related interface to
>>>>>>>
>>>>>>> support
>>>>>>>>> svp.
>>>>>>>>
>>>>>>>>
>>>>>>>> This is not what the patch is doing, please rework. This patch is
>>>>>>>
>>>>>>> an vendor API
>>>>>>>> addition introducing V4L2_CID_MPEG_MTK_SET_SECURE_MODE. I should
>>>>>>>
>>>>>>> not have to
>>>>>>>> read your patch to understand this.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>>>>>>>>> ---
>>>>>>>>>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c     | 15
>>>>>>>
>>>>>>> ++++++++++++++-
>>>>>>>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
>>>>>>>>>  include/uapi/linux/v4l2-controls.h                |  1 +
>>>>>>>>>  3 files changed, 20 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git
>>>>>>>
>>>>>>> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
>>>>>>> less.c
>>>>>>> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
>>>>>>> less.c
>>>>>>>>> index d2b09ce9f1cf..a981178c25d9 100644
>>>>>>>>> ---
>>>>>>>
>>>>>>> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
>>>>>>> less.c
>>>>>>>>> +++
>>>>>>>
>>>>>>> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
>>>>>>> less.c
>>>>>>>>> @@ -535,6 +535,17 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl
>>>>>>>
>>>>>>> *ctrl)
>>>>>>>>>  ctrl->val = mtk_dma_contig_get_secure_handle(ctx, ctrl->val);
>>>>>>>>>  mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d => 0x%x",
>>>>>>>
>>>>>>> sec_fd, ctrl->val);
>>>>>>>>>  break;
>>>>>>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
>>>>>>>>
>>>>>>>> Stepping back a little and focusing on the API, what makes your
>>>>>>>
>>>>>>> driver so
>>>>>>>> special that it should be the only one having a "secure mode" ? We
>>>>>>>
>>>>>>> are touching
>>>>>>>> in gap in the media pipeline in Linux, and this should come with
>>>>>>>
>>>>>>> consideration
>>>>>>>> of the global API.
>>>>>>>>
>>>>>>>> Why is this API better then let's say Google Android one, were they
>>>>>>>
>>>>>>> expose 2
>>>>>>>> device nodes in their fork of the MFC driver (a secure and a non
>>>>>>>
>>>>>>> secure one) ?
>>>>>>>
>>>>>>> Perhaps it is a good idea to first post an RFC with an uAPI proposal
>>>>>>> on how to
>>>>>>> handle secure video. I suspect this isn't mediatek specific, other
>>>>>>> SoCs with
>>>>>>> tee support could use this as well.
>>>>>>>
>>>>>>> As Nicolas said, it's long known to be a gap in our media support, so
>>>>>>> it is
>>>>>>> really great that you started work on this, but you need to look at
>>>>>>> this from
>>>>>>> a more generic point-of-view, and not mediatek-specific.
>>>>>>>
>>>>>>
>>>>>> Whether your have any advice about how to do a more generic driver to
>>>>>> handle secure video playback?
>>>>>>
>>>>>> There are several kind of buffer: output queue buffer/capture queue
>>>>>> buffer/working buffer.
>>>>>>
>>>>>> output and capture queue buffer: user space will call tee related
>>>>>> interface to allocate secure handle. Will convert to secure handle with
>>>>>> v4l2 framework, then send secure handle to optee-os.
>>>>>>
>>>>>> working buffer: calling dma_heap and dma_buf to get secure memory
>>>>>> handle, then covert secure iova in optee-os.
>>>>>>
>>>>>> Using the same kernel driver for svp and non-svp playback, just the
>>>>>> buffer type are different. Normal is iova and secure is secure handle.
>>>>>>
>>>>>> User driver will tell the kernel driver with CID control whether the
>>>>>> current playback is svp or non-svp.
>>>>>
>>>>> My understanding is that when you switch to secure mode, the driver makes
>>>>> some optee calls to set everything up. And userspace needs a way convert a
>>>>> dmabuf fd to a 'secure handle', which appears to be the DMA address of the
>>>>> buffer. Who uses that handle?
>>>>
>>>> The only user space usage for getting the 'secure handle' from an fd
>>>> is when that memory is written to. This is done when the TEE decrypts
>>>> the video contents. User space sends the encrypted video + 'secure
>>>> handle' to the TEE, and the TEE decrypts the contents to the memory
>>>> associated with the 'secure handle'. Then the 'secure handle' is
>>>> passed into the TEE again with the v4l2 driver to use as the source
>>>> for video decoding (but w/ v4l2, user space is passing in fds).
>>>
>>> I think I need some more background. This series is to support a 'Secure Video
>>> Processor' (at least, that's what svp stands for I believe, something that
>>> is not mentioned anywhere in this series, BTW) which is used to decode an
>>> encrypted h264 stream.
>>>
>>> First question: how is that stream encrypted? Is that according to some standard?
>>> Nothing is mentioned about that.
>>>
>>> I gather that the encrypted stream is fed to the codec as usual (i.e. just put it
>>> in the output buffer and queue it to the codec), nothing special is needed for that.
>>> Except, how does the hardware know it is encrypted? I guess that's where the
>>> control comes in, you have to turn on SVP mode first.
>>
>> Decryption takes place before the decoder. I suspect there is no dedicated
>> driver for that, the TEE driver API is similar to smart card API and fits well
>> this task. So the decrytor consume normal memory that is encrypted and is only
>> allowed to decrypt into secure memory. All this is happening before the decoder,
>> so is out of scope for this patchset.
>>
>> Just a correction :-D.
>>
>>>
>>> For the capture buffers you need to provide buffers from secure/trusted memory.
>>> That's a dmabuf fd, but where does that come from?
>>>
>>> I saw this message:
>>>
>>> https://lore.kernel.org/linux-media/CAPj87rOHctwHJM-7HiQpt8Q0b09x0WWw_T4XsL0qT=dS+XzyZQ@mail.gmail.com/T/#u
>>>
>>> so I expect that's where it comes from. But I agree that getting this from dma-heaps
>>> seems more natural.
>>>
>>> I assume that those capture buffers are inaccessible from the CPU? (Hence 'secure')
>>>
>>> For actually displaying these secure buffers you would use drm, and I assume that
>>> the hardware would mix in the contents of the secure buffer into the video output
>>> pipeline? I.e., the actual contents remain inaccessible. And that the video output
>>> (HDMI or DisplayPort) is using HDCP?
>>>
>>>>
>>>>>
>>>>> In any case, using a control to switch to secure mode and using a control
>>>>> to convert a dmabuf fd to a secure handle seems a poor choice to me.
>>>>>
>>>>> I was wondering if it wouldn't be better to create a new V4L2_MEMORY_ type,
>>>>> e.g. V4L2_MEMORY_DMABUF_SECURE (or perhaps _DMABUF_OPTEE). That ensures that
>>>>> once you create buffers for the first time, the driver can switch into secure
>>>>> mode, and until all buffers are released again you know that the driver will
>>>>> stay in secure mode.
>>>>
>>>> Why do you think the control for setting secure mode is a poor choice?
>>>> There's various places in the driver code where functionality changes
>>>> based on being secure/non-secure mode, so this is very much a 'global'
>>>> setting for the driver. It could be inferred based off a new memory
>>>> type for the queues...which then sets that flag in the driver; but
>>>> that seems like it would be more fragile and would require checking
>>>> for incompatible output/capture memory types. I'm not against another
>>>> way of doing this; but didn't see why you think the proposed method is
>>>> a poor choice.
>>>
>>> I assume you are either decoding to secure memory all the time, or not
>>> at all. That's something you would want to select the moment you allocate
>>> the first buffer. Using the V4L2_MEMORY_ value would be the natural place
>>> for that. A control can typically be toggled at any time, and it makes
>>> no sense to do that for secure streaming.
>>>
>>> Related to that: if you pass a dmabuf fd you will need to check somewhere
>>> if the fd points to secure memory or not. You don't want to mix the two
>>> but you want to check that at VIDIOC_QBUF time.
>>>
>>> Note that the V4L2_MEMORY_ value is already checked in the v4l2 core,
>>> drivers do not need to do that.
>>
>> Just to clarify a bit, and make sure I understand this too. You are proposing to
>> introduce something like:
>>
>>    V4L2_MEMORY_SECURE_DMABUF
>>
>> Which like V4L2_MEMORY_DMABUF is meant to import dmabuf, while telling the
>> driver that the memory is secure according to the definition of "secure" for the
>> platform its running on.
>>
>> This drivers also allocate secure SHM (a standard tee concept) and have internal
>> allocation for reconstruction buffer and some hw specific reference metadata. So
>> the idea would be that it would keep allocation using the dmabuf heap internal
>> APIs ? And decide which type of memory based on the memory type found in the
>> queue?
>>
>> Stepping back a little, why can't we have a way for drivers to detect that
>> dmabuf are secure ? I'm wondering if its actually useful to impose to all
>> userspace component to know that a dmabuf is secure ?
>>
>> Also, regarding MTK, these are stateless decoders. I think it would be nice to
>> show use example code that can properly parse the un-encrypted header, pass the
>> data to the decryptor and decode. There is a bit of mechanic in there that lacks
>> clarification, a reference implementation would clearly help. Finally, does this
>> platform offers some clearkey implementation (or other alternative) so we can do
>> validation and regression testing? It would be very unfortunate to add feature
>> upstream that can only be tested by proprietary CDM software.
>>
>> Nicolas
> 
> 
> Here's some links to the current userspace implementation built on top
> of the MTK patches (and yeah, this'll end up changing based on what
> happens upstream).
> 
> 1. This is where we are decrypting the video to a secure buffer, it's
> invoking IPC into a closed source component to do that:
> https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/chromeos/decoder_buffer_transcryptor.cc;l=87

So the encrypted compressed stream (contained in a regular non-secure buffer)
is decrypted here into secure buffers. Correct?

The hardware codec will just operate on those secure buffers, both for the
output and capture queues, right? And no decryption/encryption takes place,
it is all operating on unencrypted secure buffers, right?

Or is the plan to include the decryption step in the driver?

But who encrypted the compressed stream? Is it encrypted according to
some standard? Or it is mediatek specific?

Regards,

	Hans

> 2. This is where we aren enabling secure mode:
> https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/v4l2/v4l2_video_decoder.cc;l=412
> 3. This is where we are resolving secure buffers to secure handles:
> https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/v4l2/v4l2_video_decoder.cc;l=535
> (the allocation of the secure buffers is done in closed source CDM
> code, but it's just opening the dma-buf heap and issuing the ioctl to
> allocate it)
> 4. This is where we submit the secure buffers to the output queue:
> https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/v4l2/v4l2_queue.cc;l=816
> (this is nothing special, since it's just passing in the fd)
> 5. For the capture queue, there's zero changes in Chrome V4L2 code for
> that...it's all transparent to user space that it's a secure surface
> that's being rendered to. We do allocate them w/ different flags via
> minigbm which happens here:
> https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/chromeos/platform_video_frame_pool.cc;l=37
> 
>>
>>>
>>>>
>>>>>
>>>>> For converting the dmabuf fd into a secure handle: a new ioctl similar to
>>>>> VIDIOC_EXPBUF might be more suited for that.
>>>>
>>>> I actually think the best way for converting the dmabuf fd into a
>>>> secure handle would be another ioctl in the dma-heap driver...since
>>>> that's where the memory is actually allocated from. But this really
>>>> depends on upstream maintainers and what they are comfortable with.
>>>
>>> That feels like a more natural place of doing this.
>>>
>>> Regards,
>>>
>>>       Hans
>>>
>>>>
>>>>>
>>>>> Note that I am the first to admit that I have no experience with secure
>>>>> video pipelines or optee-os, so I am looking at this purely from an uAPI
>>>>> perspective.
>>>>>
>>>>> Regards,
>>>>>
>>>>>         Hans
>>>>>
>>>>>>
>>>>>> Best Regards,
>>>>>> Yunfei Dong
>>>>>>> Regards,
>>>>>>>
>>>>>>> Hans
>>>>>>>
>>>>>>>>
>>>>>>>> regards,
>>>>>>>> Nicolas
>>>>>>>>
>>>>>>>> p.s. you forgot to document your control in the RST doc, please do
>>>>>>>
>>>>>>> in following
>>>>>>>> release.
>>>>>>>>
>>>>>>>>> +ctx->is_svp_mode = ctrl->val;
>>>>>>>>> +
>>>>>>>>> +if (ctx->is_svp_mode) {
>>>>>>>>> +ret = mtk_vcodec_dec_optee_open(ctx->dev->optee_private);
>>>>>>>>> +if (ret)
>>>>>>>>> +mtk_v4l2_vdec_err(ctx, "open secure mode failed.");
>>>>>>>>> +else
>>>>>>>>> +mtk_v4l2_vdec_dbg(3, ctx, "decoder in secure mode: %d", ctrl-
>>>>>>>>
>>>>>>>> val);
>>>>>>>>> +}
>>>>>>>>> +break;
>>>>>>>>>  default:
>>>>>>>>>  mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id:
>>>>>>>>> 0x%x\n",
>>>>>>>
>>>>>>> hdr_ctrl->id);
>>>>>>>>>  return ret;
>>>>>>>>> @@ -573,7 +584,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct
>>>>>>>
>>>>>>> mtk_vcodec_dec_ctx *ctx)
>>>>>>>>>  unsigned int i;
>>>>>>>>>  struct v4l2_ctrl *ctrl;
>>>>>>>>>
>>>>>>>>> -v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
>>>>>>>>> +v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 2);
>>>>>>>>>  if (ctx->ctrl_hdl.error) {
>>>>>>>>>  mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n");
>>>>>>>>>  return ctx->ctrl_hdl.error;
>>>>>>>>> @@ -592,6 +603,8 @@ static int mtk_vcodec_dec_ctrls_setup(struct
>>>>>>>
>>>>>>> mtk_vcodec_dec_ctx *ctx)
>>>>>>>>>
>>>>>>>>>  ctrl = v4l2_ctrl_new_std(&ctx->ctrl_hdl,
>>>>>>>
>>>>>>> &mtk_vcodec_dec_ctrl_ops,
>>>>>>>>>   V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0, 65535, 1, 0);
>>>>>>>>> +ctrl = v4l2_ctrl_new_std(&ctx->ctrl_hdl,
>>>>>>>
>>>>>>> &mtk_vcodec_dec_ctrl_ops,
>>>>>>>>> + V4L2_CID_MPEG_MTK_SET_SECURE_MODE, 0, 65535, 1, 0);
>>>>>>>>>
>>>>>>>>>  v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>>>
>>>>>>> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>>>>> index d8cf01f76aab..a507045a3f30 100644
>>>>>>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>>>>> @@ -1042,6 +1042,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>>>>>>>  case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:return
>>>>>>>>> "Reference
>>>>>>>
>>>>>>> Frames for a P-Frame";
>>>>>>>>>  case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:return "Prepend
>>>>>>>
>>>>>>> SPS and PPS to IDR";
>>>>>>>>>  case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:return "MediaTek
>>>>>>>>> Decoder
>>>>>>>
>>>>>>> get secure handle";
>>>>>>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:return "MediaTek Decoder
>>>>>>>
>>>>>>> set secure mode";
>>>>>>>>>
>>>>>>>>>  /* AV1 controls */
>>>>>>>>>  case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:return "AV1 Profile";
>>>>>>>>> @@ -1442,6 +1443,10 @@ void v4l2_ctrl_fill(u32 id, const char
>>>>>>>
>>>>>>> **name, enum v4l2_ctrl_type *type,
>>>>>>>>>  *type = V4L2_CTRL_TYPE_INTEGER;
>>>>>>>>>  *flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
>>>>>>>>>  break;
>>>>>>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
>>>>>>>>> +*type = V4L2_CTRL_TYPE_INTEGER;
>>>>>>>>> +*flags |= V4L2_CTRL_FLAG_WRITE_ONLY;
>>>>>>>>> +break;
>>>>>>>>>  case V4L2_CID_USER_CLASS:
>>>>>>>>>  case V4L2_CID_CAMERA_CLASS:
>>>>>>>>>  case V4L2_CID_CODEC_CLASS:
>>>>>>>>> diff --git a/include/uapi/linux/v4l2-controls.h
>>>>>>>
>>>>>>> b/include/uapi/linux/v4l2-controls.h
>>>>>>>>> index 7b3694985366..88e90d943e38 100644
>>>>>>>>> --- a/include/uapi/linux/v4l2-controls.h
>>>>>>>>> +++ b/include/uapi/linux/v4l2-controls.h
>>>>>>>>> @@ -957,6 +957,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_type {
>>>>>>>>>  /*  MPEG-class control IDs specific to the MediaTek Decoder
>>>>>>>
>>>>>>> driver as defined by V4L2 */
>>>>>>>>>  #define V4L2_CID_MPEG_MTK_BASE(V4L2_CTRL_CLASS_CODEC | 0x2000)
>>>>>>>>>  #define
>>>>>>>
>>>>>>> V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE(V4L2_CID_MPEG_MTK_BASE+8)
>>>>>>>>> +#define
>>>>>>>
>>>>>>> V4L2_CID_MPEG_MTK_SET_SECURE_MODE(V4L2_CID_MPEG_MTK_BASE+9)
>>>>>>>>>
>>>>>>>>>  /*  Camera class control IDs */
>>>>>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-arm-kernel mailing list
>>>>> linux-arm-kernel@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>

