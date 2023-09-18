Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E8E7A549A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 22:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjIRU6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 16:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjIRU57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:57:59 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81F511A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:57:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34fa117f92bso10595ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695070659; x=1695675459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1RdBqIbW8vq9GeM6+PAZNvRaybVzqVrlabhZaFD0ps=;
        b=z/nupJ8QSdUv68cx0DSTOBlXwXfsWII4ox09ikiir0tGzlCcqh9EY29Md8XPfIX+2E
         LSoBJFbwwL8PB59OoS1YgmpT2ooqBzwHq0foG6E2pwH7HHyYbdSfskH8xTZGg0BVzuuF
         /2VyVWc1T25s0aSQwDldWzcUKtI9ye3rZjTJwDN9AUgcyY0j5lCeXba6Y9rzubmkIM/U
         PYfvdHElxTQA+CHgMLFLwvwDGKI4P1Roki+qcoUaPQ6lfMyV4nv5xwrGiBJAWvBjSIET
         feXnD5gbu8ZlMfpAFNUj+GA8oQNSZ8ZRDV002rg9WisXgPWpQsTUTrlDfNsxL6h6GqNM
         Xl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070659; x=1695675459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1RdBqIbW8vq9GeM6+PAZNvRaybVzqVrlabhZaFD0ps=;
        b=LD8uVpwvHolnMYLVgjpoC5i2FbovAqZDO2XJKWak51E/P9GbqzYBY6LT2Jn4scRPq3
         ud+YyeqKCWhFjEkXw1jHXWcgJj1Zu+76nUaOlZVN/Yezlf/l0bcrFR68fUyy3q0To8RN
         d9bH8dFN6ZNu8AiE20pg3H7YvFpXjff0dRA/DALn7S3MdoXPcbZfc4gARoFKpEnQVt9E
         HVlKeXinkxiQM0r1JkSk5hcOLUGULDH8unmwqv784a4N/k+PVJ6w0+Y7+UuXKTgNr6hc
         ZpXAqDyrwHubSGYWsDsX73B8eMM/KmABBdI3KRODoDjt/EQ5w1ZKbyBHRc5PLNwUVHyl
         Jifg==
X-Gm-Message-State: AOJu0Yxp2qCCLxg4WaFGsrJV+UUPbcSyrtmHWFteLUJkf+ZATWWYB3lC
        CCNHzLCQ5p/M/VL4UsHgegSDKV7rzUtQ1XtJogj8
X-Google-Smtp-Source: AGHT+IGCOA3HmyvGW9XUB4kw7oHDtJYcvoG5SswMRmA0rqPxgJMy9wc1ZYs4tkpHPQrp9vNY5BUoJxRSRr8Wc18+CJs=
X-Received: by 2002:a05:6e02:214a:b0:348:d358:467c with SMTP id
 d10-20020a056e02214a00b00348d358467cmr70014ilv.2.1695070658691; Mon, 18 Sep
 2023 13:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
 <20230911125936.10648-13-yunfei.dong@mediatek.com> <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
 <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl> <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
 <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
In-Reply-To: <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Mon, 18 Sep 2023 13:57:24 -0700
Message-ID: <CA+ddPcN6EaFERC60_Z_-ZmWzqyUEwxiDCZwt_U6Y-gpaAu76tA@mail.gmail.com>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder driver
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 1:56=E2=80=AFAM Hans Verkuil <hverkuil-cisco@xs4all=
.nl> wrote:
>
> On 15/09/2023 10:25, Yunfei Dong (=E8=91=A3=E4=BA=91=E9=A3=9E) wrote:
> > Hi Hans & Nicolas,
> >
> > Thanks for your advice.
> >
> > On Tue, 2023-09-12 at 11:30 +0200, Hans Verkuil wrote:
> >>
> >> External email : Please do not click links or open attachments until
> >> you have verified the sender or the content.
> >>  Hi,
> >>
> >> On 9/11/23 17:54, Nicolas Dufresne wrote:
> >>> Hi,
> >>>
> >>> Le lundi 11 septembre 2023 =C3=A0 20:59 +0800, Yunfei Dong a =C3=A9cr=
it :
> >>>> Setting secure mode flag to kernel when trying to play secure
> >>
> >> video,
> >>>> then decoder driver will initialize tee related interface to
> >>
> >> support
> >>>> svp.
> >>>
> >>>
> >>> This is not what the patch is doing, please rework. This patch is
> >>
> >> an vendor API
> >>> addition introducing V4L2_CID_MPEG_MTK_SET_SECURE_MODE. I should
> >>
> >> not have to
> >>> read your patch to understand this.
> >>>
> >>>>
> >>>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> >>>> ---
> >>>>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c     | 15
> >>
> >> ++++++++++++++-
> >>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
> >>>>  include/uapi/linux/v4l2-controls.h                |  1 +
> >>>>  3 files changed, 20 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git
> >>
> >> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
> >> less.c
> >> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
> >> less.c
> >>>> index d2b09ce9f1cf..a981178c25d9 100644
> >>>> ---
> >>
> >> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
> >> less.c
> >>>> +++
> >>
> >> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_state
> >> less.c
> >>>> @@ -535,6 +535,17 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl
> >>
> >> *ctrl)
> >>>>  ctrl->val =3D mtk_dma_contig_get_secure_handle(ctx, ctrl->val);
> >>>>  mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d =3D> 0x%x",
> >>
> >> sec_fd, ctrl->val);
> >>>>  break;
> >>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> >>>
> >>> Stepping back a little and focusing on the API, what makes your
> >>
> >> driver so
> >>> special that it should be the only one having a "secure mode" ? We
> >>
> >> are touching
> >>> in gap in the media pipeline in Linux, and this should come with
> >>
> >> consideration
> >>> of the global API.
> >>>
> >>> Why is this API better then let's say Google Android one, were they
> >>
> >> expose 2
> >>> device nodes in their fork of the MFC driver (a secure and a non
> >>
> >> secure one) ?
> >>
> >> Perhaps it is a good idea to first post an RFC with an uAPI proposal
> >> on how to
> >> handle secure video. I suspect this isn't mediatek specific, other
> >> SoCs with
> >> tee support could use this as well.
> >>
> >> As Nicolas said, it's long known to be a gap in our media support, so
> >> it is
> >> really great that you started work on this, but you need to look at
> >> this from
> >> a more generic point-of-view, and not mediatek-specific.
> >>
> >
> > Whether your have any advice about how to do a more generic driver to
> > handle secure video playback?
> >
> > There are several kind of buffer: output queue buffer/capture queue
> > buffer/working buffer.
> >
> > output and capture queue buffer: user space will call tee related
> > interface to allocate secure handle. Will convert to secure handle with
> > v4l2 framework, then send secure handle to optee-os.
> >
> > working buffer: calling dma_heap and dma_buf to get secure memory
> > handle, then covert secure iova in optee-os.
> >
> > Using the same kernel driver for svp and non-svp playback, just the
> > buffer type are different. Normal is iova and secure is secure handle.
> >
> > User driver will tell the kernel driver with CID control whether the
> > current playback is svp or non-svp.
>
> My understanding is that when you switch to secure mode, the driver makes
> some optee calls to set everything up. And userspace needs a way convert =
a
> dmabuf fd to a 'secure handle', which appears to be the DMA address of th=
e
> buffer. Who uses that handle?

The only user space usage for getting the 'secure handle' from an fd
is when that memory is written to. This is done when the TEE decrypts
the video contents. User space sends the encrypted video + 'secure
handle' to the TEE, and the TEE decrypts the contents to the memory
associated with the 'secure handle'. Then the 'secure handle' is
passed into the TEE again with the v4l2 driver to use as the source
for video decoding (but w/ v4l2, user space is passing in fds).

>
> In any case, using a control to switch to secure mode and using a control
> to convert a dmabuf fd to a secure handle seems a poor choice to me.
>
> I was wondering if it wouldn't be better to create a new V4L2_MEMORY_ typ=
e,
> e.g. V4L2_MEMORY_DMABUF_SECURE (or perhaps _DMABUF_OPTEE). That ensures t=
hat
> once you create buffers for the first time, the driver can switch into se=
cure
> mode, and until all buffers are released again you know that the driver w=
ill
> stay in secure mode.

Why do you think the control for setting secure mode is a poor choice?
There's various places in the driver code where functionality changes
based on being secure/non-secure mode, so this is very much a 'global'
setting for the driver. It could be inferred based off a new memory
type for the queues...which then sets that flag in the driver; but
that seems like it would be more fragile and would require checking
for incompatible output/capture memory types. I'm not against another
way of doing this; but didn't see why you think the proposed method is
a poor choice.

>
> For converting the dmabuf fd into a secure handle: a new ioctl similar to
> VIDIOC_EXPBUF might be more suited for that.

I actually think the best way for converting the dmabuf fd into a
secure handle would be another ioctl in the dma-heap driver...since
that's where the memory is actually allocated from. But this really
depends on upstream maintainers and what they are comfortable with.

>
> Note that I am the first to admit that I have no experience with secure
> video pipelines or optee-os, so I am looking at this purely from an uAPI
> perspective.
>
> Regards,
>
>         Hans
>
> >
> > Best Regards,
> > Yunfei Dong
> >> Regards,
> >>
> >> Hans
> >>
> >>>
> >>> regards,
> >>> Nicolas
> >>>
> >>> p.s. you forgot to document your control in the RST doc, please do
> >>
> >> in following
> >>> release.
> >>>
> >>>> +ctx->is_svp_mode =3D ctrl->val;
> >>>> +
> >>>> +if (ctx->is_svp_mode) {
> >>>> +ret =3D mtk_vcodec_dec_optee_open(ctx->dev->optee_private);
> >>>> +if (ret)
> >>>> +mtk_v4l2_vdec_err(ctx, "open secure mode failed.");
> >>>> +else
> >>>> +mtk_v4l2_vdec_dbg(3, ctx, "decoder in secure mode: %d", ctrl-
> >>>
> >>> val);
> >>>> +}
> >>>> +break;
> >>>>  default:
> >>>>  mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id:
> >>>> 0x%x\n",
> >>
> >> hdr_ctrl->id);
> >>>>  return ret;
> >>>> @@ -573,7 +584,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct
> >>
> >> mtk_vcodec_dec_ctx *ctx)
> >>>>  unsigned int i;
> >>>>  struct v4l2_ctrl *ctrl;
> >>>>
> >>>> -v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
> >>>> +v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 2);
> >>>>  if (ctx->ctrl_hdl.error) {
> >>>>  mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n");
> >>>>  return ctx->ctrl_hdl.error;
> >>>> @@ -592,6 +603,8 @@ static int mtk_vcodec_dec_ctrls_setup(struct
> >>
> >> mtk_vcodec_dec_ctx *ctx)
> >>>>
> >>>>  ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> >>
> >> &mtk_vcodec_dec_ctrl_ops,
> >>>>   V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0, 65535, 1, 0);
> >>>> +ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> >>
> >> &mtk_vcodec_dec_ctrl_ops,
> >>>> + V4L2_CID_MPEG_MTK_SET_SECURE_MODE, 0, 65535, 1, 0);
> >>>>
> >>>>  v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
> >>>>
> >>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>
> >> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>> index d8cf01f76aab..a507045a3f30 100644
> >>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>> @@ -1042,6 +1042,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>>>  case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:return
> >>>> "Reference
> >>
> >> Frames for a P-Frame";
> >>>>  case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:return "Prepend
> >>
> >> SPS and PPS to IDR";
> >>>>  case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:return "MediaTek
> >>>> Decoder
> >>
> >> get secure handle";
> >>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:return "MediaTek Decoder
> >>
> >> set secure mode";
> >>>>
> >>>>  /* AV1 controls */
> >>>>  case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:return "AV1 Profile";
> >>>> @@ -1442,6 +1443,10 @@ void v4l2_ctrl_fill(u32 id, const char
> >>
> >> **name, enum v4l2_ctrl_type *type,
> >>>>  *type =3D V4L2_CTRL_TYPE_INTEGER;
> >>>>  *flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> >>>>  break;
> >>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> >>>> +*type =3D V4L2_CTRL_TYPE_INTEGER;
> >>>> +*flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> >>>> +break;
> >>>>  case V4L2_CID_USER_CLASS:
> >>>>  case V4L2_CID_CAMERA_CLASS:
> >>>>  case V4L2_CID_CODEC_CLASS:
> >>>> diff --git a/include/uapi/linux/v4l2-controls.h
> >>
> >> b/include/uapi/linux/v4l2-controls.h
> >>>> index 7b3694985366..88e90d943e38 100644
> >>>> --- a/include/uapi/linux/v4l2-controls.h
> >>>> +++ b/include/uapi/linux/v4l2-controls.h
> >>>> @@ -957,6 +957,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_type {
> >>>>  /*  MPEG-class control IDs specific to the MediaTek Decoder
> >>
> >> driver as defined by V4L2 */
> >>>>  #define V4L2_CID_MPEG_MTK_BASE(V4L2_CTRL_CLASS_CODEC | 0x2000)
> >>>>  #define
> >>
> >> V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE(V4L2_CID_MPEG_MTK_BASE+8)
> >>>> +#define
> >>
> >> V4L2_CID_MPEG_MTK_SET_SECURE_MODE(V4L2_CID_MPEG_MTK_BASE+9)
> >>>>
> >>>>  /*  Camera class control IDs */
> >>>>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
