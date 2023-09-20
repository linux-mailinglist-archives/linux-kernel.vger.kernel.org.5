Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902F47A8B94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjITSVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjITSVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:21:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40BBCC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:20:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53317e29b00so2288a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695234052; x=1695838852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyd/aJ7XR8NQtgivSMATWqnYaKDBoBfBDXDhcwXm/O0=;
        b=PTSDVUv/wThtnlmceCw+tT1YIsEELhbzPAA7nWiJapuUUtA8wfR7FqInOlAj0YRCN9
         dw6uAzLQkHgHFfgvZPGpolWnmM37EqZk+Trofla90+FZWTbhNoAfM1uwM7bzWurEySu2
         1rEa5/BN8foAZkZnPj8SgccEjG0xIDnSo2JKNXGna7UGRDZ8Cs1DwtNffIkp6SaZVr44
         TI7pFKNjujGHg6q+2DCjbVnAcy+jsyl69n1t495ZVjEthvoTd6EBf1d9jUsFfp+XuY3q
         9J1uPXfSDmYP3SR7Ct8IDU+gx/eONotKRgbhOzXbsL6cuL+gysr+hge1vKlAndBYD9pW
         qy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695234052; x=1695838852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyd/aJ7XR8NQtgivSMATWqnYaKDBoBfBDXDhcwXm/O0=;
        b=CkiDQ3j8FMi3NBJfvtubnnP58k+58CZg0hJuJYlIP8LLy0C4ld0c/fAecvSK94+v/x
         Ccezk6uRHc4ouQ7g62EmJzB4Hy2N5wErMoeQf6H4Hw5pXFdWIrTlc7H+DnrQLUS3iZi7
         9+eeCBXDWAJKXF7RmTABDinQCZf/TQmW+KFFaXGB4cbt4RIAFd+ALJ5diD7leAgLCym9
         LwAWIoWleSB6w7fkQchPlGNLGyqsi1DBoeXpa2rJP0R01TjZiMrduyRIA3fFbF9HOQgz
         SnTOCGP9WkhgYdquI/M8iQkjw83azvhkl22H1BzQ6eLKRsHS2j/Z1OJC/71zVG0OKmKH
         lRoQ==
X-Gm-Message-State: AOJu0YxXYJKl8ov6Tm6A6xuHR0MEtW9fxmiazacDjIiCgHPJ0Xt8hOP1
        NdTyHgbbrzcF1YBjnSQQpD56AHIyIMo2A1RsSyZ4
X-Google-Smtp-Source: AGHT+IFxuAjg+Ic0t/x3t25l6vtnUKRpKBkkadvIhwfzCgaNNtJiwKXEJMhgoL1Q71r2LAV/PoTqc6i+ZBDcSj6s7XQ=
X-Received: by 2002:a50:ccd0:0:b0:522:4741:d992 with SMTP id
 b16-20020a50ccd0000000b005224741d992mr4151edj.4.1695234051775; Wed, 20 Sep
 2023 11:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
 <20230911125936.10648-13-yunfei.dong@mediatek.com> <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
 <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl> <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
 <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl> <CA+ddPcN6EaFERC60_Z_-ZmWzqyUEwxiDCZwt_U6Y-gpaAu76tA@mail.gmail.com>
 <ff7aa575-c820-4dfa-853f-77438b8b149a@xs4all.nl> <b7d661637eacbda3e83d192b1126fc3970c4f50d.camel@collabora.com>
 <c3d14f64-bf04-46b9-ac7b-af7ef9014335@xs4all.nl>
In-Reply-To: <c3d14f64-bf04-46b9-ac7b-af7ef9014335@xs4all.nl>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 20 Sep 2023 11:20:38 -0700
Message-ID: <CA+ddPcPbox=mknpmDkwfYTfDMca49wU10SNF3mJspYu=5T64FQ@mail.gmail.com>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder driver
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:21=E2=80=AFAM Hans Verkuil <hverkuil-cisco@xs4al=
l.nl> wrote:
>
> On 19/09/2023 20:51, Nicolas Dufresne wrote:
> > Le mardi 19 septembre 2023 =C3=A0 10:53 +0200, Hans Verkuil a =C3=A9cri=
t :
> >> On 18/09/2023 22:57, Jeffrey Kardatzke wrote:
> >>> On Fri, Sep 15, 2023 at 1:56=E2=80=AFAM Hans Verkuil <hverkuil-cisco@=
xs4all.nl> wrote:
> >>>>
> >>>> On 15/09/2023 10:25, Yunfei Dong (=E8=91=A3=E4=BA=91=E9=A3=9E) wrote=
:
> >>>>> Hi Hans & Nicolas,
> >>>>>
> >>>>> Thanks for your advice.
> >>>>>
> >>>>> On Tue, 2023-09-12 at 11:30 +0200, Hans Verkuil wrote:
> >>>>>>
> >>>>>> External email : Please do not click links or open attachments unt=
il
> >>>>>> you have verified the sender or the content.
> >>>>>>  Hi,
> >>>>>>
> >>>>>> On 9/11/23 17:54, Nicolas Dufresne wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> Le lundi 11 septembre 2023 =C3=A0 20:59 +0800, Yunfei Dong a =C3=
=A9crit :
> >>>>>>>> Setting secure mode flag to kernel when trying to play secure
> >>>>>>
> >>>>>> video,
> >>>>>>>> then decoder driver will initialize tee related interface to
> >>>>>>
> >>>>>> support
> >>>>>>>> svp.
> >>>>>>>
> >>>>>>>
> >>>>>>> This is not what the patch is doing, please rework. This patch is
> >>>>>>
> >>>>>> an vendor API
> >>>>>>> addition introducing V4L2_CID_MPEG_MTK_SET_SECURE_MODE. I should
> >>>>>>
> >>>>>> not have to
> >>>>>>> read your patch to understand this.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> >>>>>>>> ---
> >>>>>>>>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c     | 15
> >>>>>>
> >>>>>> ++++++++++++++-
> >>>>>>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
> >>>>>>>>  include/uapi/linux/v4l2-controls.h                |  1 +
> >>>>>>>>  3 files changed, 20 insertions(+), 1 deletion(-)
> >>>>>>>>
> >>>>>>>> diff --git
> >>>>>>
> >>>>>> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_st=
ate
> >>>>>> less.c
> >>>>>> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_st=
ate
> >>>>>> less.c
> >>>>>>>> index d2b09ce9f1cf..a981178c25d9 100644
> >>>>>>>> ---
> >>>>>>
> >>>>>> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_st=
ate
> >>>>>> less.c
> >>>>>>>> +++
> >>>>>>
> >>>>>> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_st=
ate
> >>>>>> less.c
> >>>>>>>> @@ -535,6 +535,17 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctrl
> >>>>>>
> >>>>>> *ctrl)
> >>>>>>>>  ctrl->val =3D mtk_dma_contig_get_secure_handle(ctx, ctrl->val);
> >>>>>>>>  mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d =3D> 0x%x",
> >>>>>>
> >>>>>> sec_fd, ctrl->val);
> >>>>>>>>  break;
> >>>>>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> >>>>>>>
> >>>>>>> Stepping back a little and focusing on the API, what makes your
> >>>>>>
> >>>>>> driver so
> >>>>>>> special that it should be the only one having a "secure mode" ? W=
e
> >>>>>>
> >>>>>> are touching
> >>>>>>> in gap in the media pipeline in Linux, and this should come with
> >>>>>>
> >>>>>> consideration
> >>>>>>> of the global API.
> >>>>>>>
> >>>>>>> Why is this API better then let's say Google Android one, were th=
ey
> >>>>>>
> >>>>>> expose 2
> >>>>>>> device nodes in their fork of the MFC driver (a secure and a non
> >>>>>>
> >>>>>> secure one) ?
> >>>>>>
> >>>>>> Perhaps it is a good idea to first post an RFC with an uAPI propos=
al
> >>>>>> on how to
> >>>>>> handle secure video. I suspect this isn't mediatek specific, other
> >>>>>> SoCs with
> >>>>>> tee support could use this as well.
> >>>>>>
> >>>>>> As Nicolas said, it's long known to be a gap in our media support,=
 so
> >>>>>> it is
> >>>>>> really great that you started work on this, but you need to look a=
t
> >>>>>> this from
> >>>>>> a more generic point-of-view, and not mediatek-specific.
> >>>>>>
> >>>>>
> >>>>> Whether your have any advice about how to do a more generic driver =
to
> >>>>> handle secure video playback?
> >>>>>
> >>>>> There are several kind of buffer: output queue buffer/capture queue
> >>>>> buffer/working buffer.
> >>>>>
> >>>>> output and capture queue buffer: user space will call tee related
> >>>>> interface to allocate secure handle. Will convert to secure handle =
with
> >>>>> v4l2 framework, then send secure handle to optee-os.
> >>>>>
> >>>>> working buffer: calling dma_heap and dma_buf to get secure memory
> >>>>> handle, then covert secure iova in optee-os.
> >>>>>
> >>>>> Using the same kernel driver for svp and non-svp playback, just the
> >>>>> buffer type are different. Normal is iova and secure is secure hand=
le.
> >>>>>
> >>>>> User driver will tell the kernel driver with CID control whether th=
e
> >>>>> current playback is svp or non-svp.
> >>>>
> >>>> My understanding is that when you switch to secure mode, the driver =
makes
> >>>> some optee calls to set everything up. And userspace needs a way con=
vert a
> >>>> dmabuf fd to a 'secure handle', which appears to be the DMA address =
of the
> >>>> buffer. Who uses that handle?
> >>>
> >>> The only user space usage for getting the 'secure handle' from an fd
> >>> is when that memory is written to. This is done when the TEE decrypts
> >>> the video contents. User space sends the encrypted video + 'secure
> >>> handle' to the TEE, and the TEE decrypts the contents to the memory
> >>> associated with the 'secure handle'. Then the 'secure handle' is
> >>> passed into the TEE again with the v4l2 driver to use as the source
> >>> for video decoding (but w/ v4l2, user space is passing in fds).
> >>
> >> I think I need some more background. This series is to support a 'Secu=
re Video
> >> Processor' (at least, that's what svp stands for I believe, something =
that
> >> is not mentioned anywhere in this series, BTW) which is used to decode=
 an
> >> encrypted h264 stream.
> >>
> >> First question: how is that stream encrypted? Is that according to som=
e standard?
> >> Nothing is mentioned about that.
> >>
> >> I gather that the encrypted stream is fed to the codec as usual (i.e. =
just put it
> >> in the output buffer and queue it to the codec), nothing special is ne=
eded for that.
> >> Except, how does the hardware know it is encrypted? I guess that's whe=
re the
> >> control comes in, you have to turn on SVP mode first.
> >
> > Decryption takes place before the decoder. I suspect there is no dedica=
ted
> > driver for that, the TEE driver API is similar to smart card API and fi=
ts well
> > this task. So the decrytor consume normal memory that is encrypted and =
is only
> > allowed to decrypt into secure memory. All this is happening before the=
 decoder,
> > so is out of scope for this patchset.
> >
> > Just a correction :-D.
> >
> >>
> >> For the capture buffers you need to provide buffers from secure/truste=
d memory.
> >> That's a dmabuf fd, but where does that come from?
> >>
> >> I saw this message:
> >>
> >> https://lore.kernel.org/linux-media/CAPj87rOHctwHJM-7HiQpt8Q0b09x0WWw_=
T4XsL0qT=3DdS+XzyZQ@mail.gmail.com/T/#u
> >>
> >> so I expect that's where it comes from. But I agree that getting this =
from dma-heaps
> >> seems more natural.
> >>
> >> I assume that those capture buffers are inaccessible from the CPU? (He=
nce 'secure')
> >>
> >> For actually displaying these secure buffers you would use drm, and I =
assume that
> >> the hardware would mix in the contents of the secure buffer into the v=
ideo output
> >> pipeline? I.e., the actual contents remain inaccessible. And that the =
video output
> >> (HDMI or DisplayPort) is using HDCP?
> >>
> >>>
> >>>>
> >>>> In any case, using a control to switch to secure mode and using a co=
ntrol
> >>>> to convert a dmabuf fd to a secure handle seems a poor choice to me.
> >>>>
> >>>> I was wondering if it wouldn't be better to create a new V4L2_MEMORY=
_ type,
> >>>> e.g. V4L2_MEMORY_DMABUF_SECURE (or perhaps _DMABUF_OPTEE). That ensu=
res that
> >>>> once you create buffers for the first time, the driver can switch in=
to secure
> >>>> mode, and until all buffers are released again you know that the dri=
ver will
> >>>> stay in secure mode.
> >>>
> >>> Why do you think the control for setting secure mode is a poor choice=
?
> >>> There's various places in the driver code where functionality changes
> >>> based on being secure/non-secure mode, so this is very much a 'global=
'
> >>> setting for the driver. It could be inferred based off a new memory
> >>> type for the queues...which then sets that flag in the driver; but
> >>> that seems like it would be more fragile and would require checking
> >>> for incompatible output/capture memory types. I'm not against another
> >>> way of doing this; but didn't see why you think the proposed method i=
s
> >>> a poor choice.
> >>
> >> I assume you are either decoding to secure memory all the time, or not
> >> at all. That's something you would want to select the moment you alloc=
ate
> >> the first buffer. Using the V4L2_MEMORY_ value would be the natural pl=
ace
> >> for that. A control can typically be toggled at any time, and it makes
> >> no sense to do that for secure streaming.
> >>
> >> Related to that: if you pass a dmabuf fd you will need to check somewh=
ere
> >> if the fd points to secure memory or not. You don't want to mix the tw=
o
> >> but you want to check that at VIDIOC_QBUF time.
> >>
> >> Note that the V4L2_MEMORY_ value is already checked in the v4l2 core,
> >> drivers do not need to do that.
> >
> > Just to clarify a bit, and make sure I understand this too. You are pro=
posing to
> > introduce something like:
> >
> >    V4L2_MEMORY_SECURE_DMABUF
> >
> > Which like V4L2_MEMORY_DMABUF is meant to import dmabuf, while telling =
the
> > driver that the memory is secure according to the definition of "secure=
" for the
> > platform its running on.
> >
> > This drivers also allocate secure SHM (a standard tee concept) and have=
 internal
> > allocation for reconstruction buffer and some hw specific reference met=
adata. So
> > the idea would be that it would keep allocation using the dmabuf heap i=
nternal
> > APIs ? And decide which type of memory based on the memory type found i=
n the
> > queue?
>
> Yes. Once you request the first buffer you basically tell the driver whet=
her it
> will operate in secure or non-secure mode, and that stays that way until =
all
> buffers are freed. I think that makes sense.
>
> If there is a need in the future to have V4L2 allocate the secure buffers=
, then
> a similar V4L2_MEMORY_MMAP_SECURE type can be added. I think using v4l2_m=
emory
> to select secure or non-secure mode is logical and fits well with the V4L=
2 API.
>
OK, sounds good. I'll work with Mediatek to get the patches updated for tha=
t.

> > Stepping back a little, why can't we have a way for drivers to detect t=
hat
> > dmabuf are secure ? I'm wondering if its actually useful to impose to a=
ll
> > userspace component to know that a dmabuf is secure ?
>
> I was wondering the same thing: there should be a simple way for drivers =
and
> userspace to check if a dmabuf fd is secure or not. That will certainly h=
elp
> the vb2 framework verify that you don't mix secure and non-secure dmabuf =
fds.
>
Already talked to Mediatek about this and they are working on updating
the dma-buf patches for this.

> >
> > Also, regarding MTK, these are stateless decoders. I think it would be =
nice to
> > show use example code that can properly parse the un-encrypted header, =
pass the
> > data to the decryptor and decode. There is a bit of mechanic in there t=
hat lacks
> > clarification, a reference implementation would clearly help. Finally, =
does this
> > platform offers some clearkey implementation (or other alternative) so =
we can do
> > validation and regression testing? It would be very unfortunate to add =
feature
> > upstream that can only be tested by proprietary CDM software.
>

It would be possible to use this with clearkey w/ some additional work
on our end. If this is then part of the public ChromiumOS build, would
that be satisfactory? (the TEE would have some binary blob components
like firmware does though)

> Good points.
>
>         Hans
>
> >
> > Nicolas
> >
> >>
> >>>
> >>>>
> >>>> For converting the dmabuf fd into a secure handle: a new ioctl simil=
ar to
> >>>> VIDIOC_EXPBUF might be more suited for that.
> >>>
> >>> I actually think the best way for converting the dmabuf fd into a
> >>> secure handle would be another ioctl in the dma-heap driver...since
> >>> that's where the memory is actually allocated from. But this really
> >>> depends on upstream maintainers and what they are comfortable with.
> >>
> >> That feels like a more natural place of doing this.
> >>
> >> Regards,
> >>
> >>      Hans
> >>
> >>>
> >>>>
> >>>> Note that I am the first to admit that I have no experience with sec=
ure
> >>>> video pipelines or optee-os, so I am looking at this purely from an =
uAPI
> >>>> perspective.
> >>>>
> >>>> Regards,
> >>>>
> >>>>         Hans
> >>>>
> >>>>>
> >>>>> Best Regards,
> >>>>> Yunfei Dong
> >>>>>> Regards,
> >>>>>>
> >>>>>> Hans
> >>>>>>
> >>>>>>>
> >>>>>>> regards,
> >>>>>>> Nicolas
> >>>>>>>
> >>>>>>> p.s. you forgot to document your control in the RST doc, please d=
o
> >>>>>>
> >>>>>> in following
> >>>>>>> release.
> >>>>>>>
> >>>>>>>> +ctx->is_svp_mode =3D ctrl->val;
> >>>>>>>> +
> >>>>>>>> +if (ctx->is_svp_mode) {
> >>>>>>>> +ret =3D mtk_vcodec_dec_optee_open(ctx->dev->optee_private);
> >>>>>>>> +if (ret)
> >>>>>>>> +mtk_v4l2_vdec_err(ctx, "open secure mode failed.");
> >>>>>>>> +else
> >>>>>>>> +mtk_v4l2_vdec_dbg(3, ctx, "decoder in secure mode: %d", ctrl-
> >>>>>>>
> >>>>>>> val);
> >>>>>>>> +}
> >>>>>>>> +break;
> >>>>>>>>  default:
> >>>>>>>>  mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id:
> >>>>>>>> 0x%x\n",
> >>>>>>
> >>>>>> hdr_ctrl->id);
> >>>>>>>>  return ret;
> >>>>>>>> @@ -573,7 +584,7 @@ static int mtk_vcodec_dec_ctrls_setup(struct
> >>>>>>
> >>>>>> mtk_vcodec_dec_ctx *ctx)
> >>>>>>>>  unsigned int i;
> >>>>>>>>  struct v4l2_ctrl *ctrl;
> >>>>>>>>
> >>>>>>>> -v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
> >>>>>>>> +v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 2);
> >>>>>>>>  if (ctx->ctrl_hdl.error) {
> >>>>>>>>  mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n");
> >>>>>>>>  return ctx->ctrl_hdl.error;
> >>>>>>>> @@ -592,6 +603,8 @@ static int mtk_vcodec_dec_ctrls_setup(struct
> >>>>>>
> >>>>>> mtk_vcodec_dec_ctx *ctx)
> >>>>>>>>
> >>>>>>>>  ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> >>>>>>
> >>>>>> &mtk_vcodec_dec_ctrl_ops,
> >>>>>>>>   V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0, 65535, 1, 0);
> >>>>>>>> +ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> >>>>>>
> >>>>>> &mtk_vcodec_dec_ctrl_ops,
> >>>>>>>> + V4L2_CID_MPEG_MTK_SET_SECURE_MODE, 0, 65535, 1, 0);
> >>>>>>>>
> >>>>>>>>  v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>>>
> >>>>>> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>>>>> index d8cf01f76aab..a507045a3f30 100644
> >>>>>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>>>>> @@ -1042,6 +1042,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>>>>>>>  case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:return
> >>>>>>>> "Reference
> >>>>>>
> >>>>>> Frames for a P-Frame";
> >>>>>>>>  case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:return "Prepend
> >>>>>>
> >>>>>> SPS and PPS to IDR";
> >>>>>>>>  case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:return "MediaTek
> >>>>>>>> Decoder
> >>>>>>
> >>>>>> get secure handle";
> >>>>>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:return "MediaTek Decoder
> >>>>>>
> >>>>>> set secure mode";
> >>>>>>>>
> >>>>>>>>  /* AV1 controls */
> >>>>>>>>  case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:return "AV1 Profile";
> >>>>>>>> @@ -1442,6 +1443,10 @@ void v4l2_ctrl_fill(u32 id, const char
> >>>>>>
> >>>>>> **name, enum v4l2_ctrl_type *type,
> >>>>>>>>  *type =3D V4L2_CTRL_TYPE_INTEGER;
> >>>>>>>>  *flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> >>>>>>>>  break;
> >>>>>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> >>>>>>>> +*type =3D V4L2_CTRL_TYPE_INTEGER;
> >>>>>>>> +*flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> >>>>>>>> +break;
> >>>>>>>>  case V4L2_CID_USER_CLASS:
> >>>>>>>>  case V4L2_CID_CAMERA_CLASS:
> >>>>>>>>  case V4L2_CID_CODEC_CLASS:
> >>>>>>>> diff --git a/include/uapi/linux/v4l2-controls.h
> >>>>>>
> >>>>>> b/include/uapi/linux/v4l2-controls.h
> >>>>>>>> index 7b3694985366..88e90d943e38 100644
> >>>>>>>> --- a/include/uapi/linux/v4l2-controls.h
> >>>>>>>> +++ b/include/uapi/linux/v4l2-controls.h
> >>>>>>>> @@ -957,6 +957,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_type =
{
> >>>>>>>>  /*  MPEG-class control IDs specific to the MediaTek Decoder
> >>>>>>
> >>>>>> driver as defined by V4L2 */
> >>>>>>>>  #define V4L2_CID_MPEG_MTK_BASE(V4L2_CTRL_CLASS_CODEC | 0x2000)
> >>>>>>>>  #define
> >>>>>>
> >>>>>> V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE(V4L2_CID_MPEG_MTK_BASE+8)
> >>>>>>>> +#define
> >>>>>>
> >>>>>> V4L2_CID_MPEG_MTK_SET_SECURE_MODE(V4L2_CID_MPEG_MTK_BASE+9)
> >>>>>>>>
> >>>>>>>>  /*  Camera class control IDs */
> >>>>>>>>
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> linux-arm-kernel mailing list
> >>>> linux-arm-kernel@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>
> >
>
