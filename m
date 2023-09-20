Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BE7A8B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjITSNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjITSNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:13:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E5BD3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:13:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso11625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695233617; x=1695838417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjJwJX+Tyt35Jvmq3Gpk/1T/kcsOE94ufpBd/ISHFSM=;
        b=VdhgvRdUk+LPXB83YwM0NlYHvgkNZCh91kYUKZ0WoMg1EykuA48cysGpoXzSxrbSEa
         7Q0//K3XrUbcW4bM/EIoTp+P+mqKD/XLbAfsjGEMCJhjFVTKjo2eG+VN5RI29GsqND6v
         qzx3tCIOmT3frv6xEz6f8ouxE3aLcvCeqGmjv1k+m1FjHpL7SQla/f+V/tXThdlzCmAG
         3p/P/k3zH45FpH57dP5VMoAfqB1tsRtFEW9ecYW/6EjDSwV5KlJ6TjmtJPvj5zjmcLh2
         hDRPLHgnbSc5xR6ino8x/TsEbrGMn1cGn6odpHH4kwc+EeLHpHcZ2dlxo8EAM5ga/DHg
         twyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233617; x=1695838417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjJwJX+Tyt35Jvmq3Gpk/1T/kcsOE94ufpBd/ISHFSM=;
        b=wByAOoZ1uTyB5yErI/tGfRqgfLa4jYSyezZTgUMGqR5JvAqA7Pss7Yz1eMUbeURfgL
         kq2QzFgBoNwtPE6rS6+9KPJC1pCVRAPgtpIB+iKd2kY8Rm1hq+seTpGG2W0aSki/sXbG
         Es+CModPhbXjhw+89POWBN4T622r1/4kJW+WPXNXiQXod9mFj5okjnQEe7wvogoxFMIN
         +3+K6kyoyYtSNxZ4O4pTUjXw0drhJFGVmctfm9gPCenCB+XaXMPfjEnvjGOfbIwpANMT
         N1RoYa+fFMOa3qIxqBeuYSnU7iKhgv2kqziXj0vMcULCD6JmaSVRAxviH0NEQVXcw8Q6
         DWfw==
X-Gm-Message-State: AOJu0Yz1VdQMjYxH8VOHUWb59k4M82GDxzHZR+JwDEd7kQYOymq2FJ5K
        BmHIA7cF0z9Zuvf7hhMki6SdIc8RlPpvm4uqKMCk
X-Google-Smtp-Source: AGHT+IELBrduJFdOa/+wyXoyd4Vwp1rzTltbg8q7bu8jRrQXr6jCtwG/RmnW20Dl1O/cBvR5l4SQ5un1Asg4VuGAdc4=
X-Received: by 2002:a05:600c:3b9e:b0:3fe:ef25:8b86 with SMTP id
 n30-20020a05600c3b9e00b003feef258b86mr4367wms.4.1695233616766; Wed, 20 Sep
 2023 11:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
 <20230911125936.10648-13-yunfei.dong@mediatek.com> <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
 <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl> <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
 <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl> <CA+ddPcN6EaFERC60_Z_-ZmWzqyUEwxiDCZwt_U6Y-gpaAu76tA@mail.gmail.com>
 <ff7aa575-c820-4dfa-853f-77438b8b149a@xs4all.nl> <b7d661637eacbda3e83d192b1126fc3970c4f50d.camel@collabora.com>
 <CA+ddPcPq3XrJGPqjZDq0u_ga6Aat1ve5ODBDD-OouO3xPSCFuA@mail.gmail.com> <7ed371e9-ffc1-4802-8de0-3190a9bb661d@xs4all.nl>
In-Reply-To: <7ed371e9-ffc1-4802-8de0-3190a9bb661d@xs4all.nl>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 20 Sep 2023 11:13:23 -0700
Message-ID: <CA+ddPcPzd-HTWQgUJW_W5zRLrXpEiNp9Ymbp9k+BfKftZGrmJw@mail.gmail.com>
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

On Wed, Sep 20, 2023 at 12:10=E2=80=AFAM Hans Verkuil <hverkuil-cisco@xs4al=
l.nl> wrote:
>
> On 19/09/2023 21:49, Jeffrey Kardatzke wrote:
> > On Tue, Sep 19, 2023 at 11:51=E2=80=AFAM Nicolas Dufresne
> > <nicolas.dufresne@collabora.com> wrote:
> >>
> >> Le mardi 19 septembre 2023 =C3=A0 10:53 +0200, Hans Verkuil a =C3=A9cr=
it :
> >>> On 18/09/2023 22:57, Jeffrey Kardatzke wrote:
> >>>> On Fri, Sep 15, 2023 at 1:56=E2=80=AFAM Hans Verkuil <hverkuil-cisco=
@xs4all.nl> wrote:
> >>>>>
> >>>>> On 15/09/2023 10:25, Yunfei Dong (=E8=91=A3=E4=BA=91=E9=A3=9E) wrot=
e:
> >>>>>> Hi Hans & Nicolas,
> >>>>>>
> >>>>>> Thanks for your advice.
> >>>>>>
> >>>>>> On Tue, 2023-09-12 at 11:30 +0200, Hans Verkuil wrote:
> >>>>>>>
> >>>>>>> External email : Please do not click links or open attachments un=
til
> >>>>>>> you have verified the sender or the content.
> >>>>>>>  Hi,
> >>>>>>>
> >>>>>>> On 9/11/23 17:54, Nicolas Dufresne wrote:
> >>>>>>>> Hi,
> >>>>>>>>
> >>>>>>>> Le lundi 11 septembre 2023 =C3=A0 20:59 +0800, Yunfei Dong a =C3=
=A9crit :
> >>>>>>>>> Setting secure mode flag to kernel when trying to play secure
> >>>>>>>
> >>>>>>> video,
> >>>>>>>>> then decoder driver will initialize tee related interface to
> >>>>>>>
> >>>>>>> support
> >>>>>>>>> svp.
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> This is not what the patch is doing, please rework. This patch i=
s
> >>>>>>>
> >>>>>>> an vendor API
> >>>>>>>> addition introducing V4L2_CID_MPEG_MTK_SET_SECURE_MODE. I should
> >>>>>>>
> >>>>>>> not have to
> >>>>>>>> read your patch to understand this.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> >>>>>>>>> ---
> >>>>>>>>>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c     | 15
> >>>>>>>
> >>>>>>> ++++++++++++++-
> >>>>>>>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c         |  5 +++++
> >>>>>>>>>  include/uapi/linux/v4l2-controls.h                |  1 +
> >>>>>>>>>  3 files changed, 20 insertions(+), 1 deletion(-)
> >>>>>>>>>
> >>>>>>>>> diff --git
> >>>>>>>
> >>>>>>> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tate
> >>>>>>> less.c
> >>>>>>> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tate
> >>>>>>> less.c
> >>>>>>>>> index d2b09ce9f1cf..a981178c25d9 100644
> >>>>>>>>> ---
> >>>>>>>
> >>>>>>> a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tate
> >>>>>>> less.c
> >>>>>>>>> +++
> >>>>>>>
> >>>>>>> b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_s=
tate
> >>>>>>> less.c
> >>>>>>>>> @@ -535,6 +535,17 @@ static int mtk_vdec_s_ctrl(struct v4l2_ctr=
l
> >>>>>>>
> >>>>>>> *ctrl)
> >>>>>>>>>  ctrl->val =3D mtk_dma_contig_get_secure_handle(ctx, ctrl->val)=
;
> >>>>>>>>>  mtk_v4l2_vdec_dbg(3, ctx, "get secure handle: %d =3D> 0x%x",
> >>>>>>>
> >>>>>>> sec_fd, ctrl->val);
> >>>>>>>>>  break;
> >>>>>>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> >>>>>>>>
> >>>>>>>> Stepping back a little and focusing on the API, what makes your
> >>>>>>>
> >>>>>>> driver so
> >>>>>>>> special that it should be the only one having a "secure mode" ? =
We
> >>>>>>>
> >>>>>>> are touching
> >>>>>>>> in gap in the media pipeline in Linux, and this should come with
> >>>>>>>
> >>>>>>> consideration
> >>>>>>>> of the global API.
> >>>>>>>>
> >>>>>>>> Why is this API better then let's say Google Android one, were t=
hey
> >>>>>>>
> >>>>>>> expose 2
> >>>>>>>> device nodes in their fork of the MFC driver (a secure and a non
> >>>>>>>
> >>>>>>> secure one) ?
> >>>>>>>
> >>>>>>> Perhaps it is a good idea to first post an RFC with an uAPI propo=
sal
> >>>>>>> on how to
> >>>>>>> handle secure video. I suspect this isn't mediatek specific, othe=
r
> >>>>>>> SoCs with
> >>>>>>> tee support could use this as well.
> >>>>>>>
> >>>>>>> As Nicolas said, it's long known to be a gap in our media support=
, so
> >>>>>>> it is
> >>>>>>> really great that you started work on this, but you need to look =
at
> >>>>>>> this from
> >>>>>>> a more generic point-of-view, and not mediatek-specific.
> >>>>>>>
> >>>>>>
> >>>>>> Whether your have any advice about how to do a more generic driver=
 to
> >>>>>> handle secure video playback?
> >>>>>>
> >>>>>> There are several kind of buffer: output queue buffer/capture queu=
e
> >>>>>> buffer/working buffer.
> >>>>>>
> >>>>>> output and capture queue buffer: user space will call tee related
> >>>>>> interface to allocate secure handle. Will convert to secure handle=
 with
> >>>>>> v4l2 framework, then send secure handle to optee-os.
> >>>>>>
> >>>>>> working buffer: calling dma_heap and dma_buf to get secure memory
> >>>>>> handle, then covert secure iova in optee-os.
> >>>>>>
> >>>>>> Using the same kernel driver for svp and non-svp playback, just th=
e
> >>>>>> buffer type are different. Normal is iova and secure is secure han=
dle.
> >>>>>>
> >>>>>> User driver will tell the kernel driver with CID control whether t=
he
> >>>>>> current playback is svp or non-svp.
> >>>>>
> >>>>> My understanding is that when you switch to secure mode, the driver=
 makes
> >>>>> some optee calls to set everything up. And userspace needs a way co=
nvert a
> >>>>> dmabuf fd to a 'secure handle', which appears to be the DMA address=
 of the
> >>>>> buffer. Who uses that handle?
> >>>>
> >>>> The only user space usage for getting the 'secure handle' from an fd
> >>>> is when that memory is written to. This is done when the TEE decrypt=
s
> >>>> the video contents. User space sends the encrypted video + 'secure
> >>>> handle' to the TEE, and the TEE decrypts the contents to the memory
> >>>> associated with the 'secure handle'. Then the 'secure handle' is
> >>>> passed into the TEE again with the v4l2 driver to use as the source
> >>>> for video decoding (but w/ v4l2, user space is passing in fds).
> >>>
> >>> I think I need some more background. This series is to support a 'Sec=
ure Video
> >>> Processor' (at least, that's what svp stands for I believe, something=
 that
> >>> is not mentioned anywhere in this series, BTW) which is used to decod=
e an
> >>> encrypted h264 stream.
> >>>
> >>> First question: how is that stream encrypted? Is that according to so=
me standard?
> >>> Nothing is mentioned about that.
> >>>
> >>> I gather that the encrypted stream is fed to the codec as usual (i.e.=
 just put it
> >>> in the output buffer and queue it to the codec), nothing special is n=
eeded for that.
> >>> Except, how does the hardware know it is encrypted? I guess that's wh=
ere the
> >>> control comes in, you have to turn on SVP mode first.
> >>
> >> Decryption takes place before the decoder. I suspect there is no dedic=
ated
> >> driver for that, the TEE driver API is similar to smart card API and f=
its well
> >> this task. So the decrytor consume normal memory that is encrypted and=
 is only
> >> allowed to decrypt into secure memory. All this is happening before th=
e decoder,
> >> so is out of scope for this patchset.
> >>
> >> Just a correction :-D.
> >>
> >>>
> >>> For the capture buffers you need to provide buffers from secure/trust=
ed memory.
> >>> That's a dmabuf fd, but where does that come from?
> >>>
> >>> I saw this message:
> >>>
> >>> https://lore.kernel.org/linux-media/CAPj87rOHctwHJM-7HiQpt8Q0b09x0WWw=
_T4XsL0qT=3DdS+XzyZQ@mail.gmail.com/T/#u
> >>>
> >>> so I expect that's where it comes from. But I agree that getting this=
 from dma-heaps
> >>> seems more natural.
> >>>
> >>> I assume that those capture buffers are inaccessible from the CPU? (H=
ence 'secure')
> >>>
> >>> For actually displaying these secure buffers you would use drm, and I=
 assume that
> >>> the hardware would mix in the contents of the secure buffer into the =
video output
> >>> pipeline? I.e., the actual contents remain inaccessible. And that the=
 video output
> >>> (HDMI or DisplayPort) is using HDCP?
> >>>
> >>>>
> >>>>>
> >>>>> In any case, using a control to switch to secure mode and using a c=
ontrol
> >>>>> to convert a dmabuf fd to a secure handle seems a poor choice to me=
.
> >>>>>
> >>>>> I was wondering if it wouldn't be better to create a new V4L2_MEMOR=
Y_ type,
> >>>>> e.g. V4L2_MEMORY_DMABUF_SECURE (or perhaps _DMABUF_OPTEE). That ens=
ures that
> >>>>> once you create buffers for the first time, the driver can switch i=
nto secure
> >>>>> mode, and until all buffers are released again you know that the dr=
iver will
> >>>>> stay in secure mode.
> >>>>
> >>>> Why do you think the control for setting secure mode is a poor choic=
e?
> >>>> There's various places in the driver code where functionality change=
s
> >>>> based on being secure/non-secure mode, so this is very much a 'globa=
l'
> >>>> setting for the driver. It could be inferred based off a new memory
> >>>> type for the queues...which then sets that flag in the driver; but
> >>>> that seems like it would be more fragile and would require checking
> >>>> for incompatible output/capture memory types. I'm not against anothe=
r
> >>>> way of doing this; but didn't see why you think the proposed method =
is
> >>>> a poor choice.
> >>>
> >>> I assume you are either decoding to secure memory all the time, or no=
t
> >>> at all. That's something you would want to select the moment you allo=
cate
> >>> the first buffer. Using the V4L2_MEMORY_ value would be the natural p=
lace
> >>> for that. A control can typically be toggled at any time, and it make=
s
> >>> no sense to do that for secure streaming.
> >>>
> >>> Related to that: if you pass a dmabuf fd you will need to check somew=
here
> >>> if the fd points to secure memory or not. You don't want to mix the t=
wo
> >>> but you want to check that at VIDIOC_QBUF time.
> >>>
> >>> Note that the V4L2_MEMORY_ value is already checked in the v4l2 core,
> >>> drivers do not need to do that.
> >>
> >> Just to clarify a bit, and make sure I understand this too. You are pr=
oposing to
> >> introduce something like:
> >>
> >>    V4L2_MEMORY_SECURE_DMABUF
> >>
> >> Which like V4L2_MEMORY_DMABUF is meant to import dmabuf, while telling=
 the
> >> driver that the memory is secure according to the definition of "secur=
e" for the
> >> platform its running on.
> >>
> >> This drivers also allocate secure SHM (a standard tee concept) and hav=
e internal
> >> allocation for reconstruction buffer and some hw specific reference me=
tadata. So
> >> the idea would be that it would keep allocation using the dmabuf heap =
internal
> >> APIs ? And decide which type of memory based on the memory type found =
in the
> >> queue?
> >>
> >> Stepping back a little, why can't we have a way for drivers to detect =
that
> >> dmabuf are secure ? I'm wondering if its actually useful to impose to =
all
> >> userspace component to know that a dmabuf is secure ?
> >>
> >> Also, regarding MTK, these are stateless decoders. I think it would be=
 nice to
> >> show use example code that can properly parse the un-encrypted header,=
 pass the
> >> data to the decryptor and decode. There is a bit of mechanic in there =
that lacks
> >> clarification, a reference implementation would clearly help. Finally,=
 does this
> >> platform offers some clearkey implementation (or other alternative) so=
 we can do
> >> validation and regression testing? It would be very unfortunate to add=
 feature
> >> upstream that can only be tested by proprietary CDM software.
> >>
> >> Nicolas
> >
> >
> > Here's some links to the current userspace implementation built on top
> > of the MTK patches (and yeah, this'll end up changing based on what
> > happens upstream).
> >
> > 1. This is where we are decrypting the video to a secure buffer, it's
> > invoking IPC into a closed source component to do that:
> > https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/chro=
meos/decoder_buffer_transcryptor.cc;l=3D87
>
> So the encrypted compressed stream (contained in a regular non-secure buf=
fer)
> is decrypted here into secure buffers. Correct?
Correct
>
> The hardware codec will just operate on those secure buffers, both for th=
e
> output and capture queues, right? And no decryption/encryption takes plac=
e,
> it is all operating on unencrypted secure buffers, right?
Correct
>
> Or is the plan to include the decryption step in the driver?
No, the driver will never be doing the decryption.
>
> But who encrypted the compressed stream? Is it encrypted according to
> some standard? Or it is mediatek specific?
It's encrypted using CENC (Common Encryption). The method for
acquiring the keys to perform the decryption is Widevine specific
(Widevine is the Digital Rights Management system we are using...but
nothing in the kernel patches dictates which Digital Rights Management
system is used, but the encryption technique is a standard).
>
> Regards,
>
>         Hans
>
> > 2. This is where we aren enabling secure mode:
> > https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/v4l2=
/v4l2_video_decoder.cc;l=3D412
> > 3. This is where we are resolving secure buffers to secure handles:
> > https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/v4l2=
/v4l2_video_decoder.cc;l=3D535
> > (the allocation of the secure buffers is done in closed source CDM
> > code, but it's just opening the dma-buf heap and issuing the ioctl to
> > allocate it)
> > 4. This is where we submit the secure buffers to the output queue:
> > https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/v4l2=
/v4l2_queue.cc;l=3D816
> > (this is nothing special, since it's just passing in the fd)
> > 5. For the capture queue, there's zero changes in Chrome V4L2 code for
> > that...it's all transparent to user space that it's a secure surface
> > that's being rendered to. We do allocate them w/ different flags via
> > minigbm which happens here:
> > https://source.chromium.org/chromium/chromium/src/+/main:media/gpu/chro=
meos/platform_video_frame_pool.cc;l=3D37
> >
> >>
> >>>
> >>>>
> >>>>>
> >>>>> For converting the dmabuf fd into a secure handle: a new ioctl simi=
lar to
> >>>>> VIDIOC_EXPBUF might be more suited for that.
> >>>>
> >>>> I actually think the best way for converting the dmabuf fd into a
> >>>> secure handle would be another ioctl in the dma-heap driver...since
> >>>> that's where the memory is actually allocated from. But this really
> >>>> depends on upstream maintainers and what they are comfortable with.
> >>>
> >>> That feels like a more natural place of doing this.
> >>>
> >>> Regards,
> >>>
> >>>       Hans
> >>>
> >>>>
> >>>>>
> >>>>> Note that I am the first to admit that I have no experience with se=
cure
> >>>>> video pipelines or optee-os, so I am looking at this purely from an=
 uAPI
> >>>>> perspective.
> >>>>>
> >>>>> Regards,
> >>>>>
> >>>>>         Hans
> >>>>>
> >>>>>>
> >>>>>> Best Regards,
> >>>>>> Yunfei Dong
> >>>>>>> Regards,
> >>>>>>>
> >>>>>>> Hans
> >>>>>>>
> >>>>>>>>
> >>>>>>>> regards,
> >>>>>>>> Nicolas
> >>>>>>>>
> >>>>>>>> p.s. you forgot to document your control in the RST doc, please =
do
> >>>>>>>
> >>>>>>> in following
> >>>>>>>> release.
> >>>>>>>>
> >>>>>>>>> +ctx->is_svp_mode =3D ctrl->val;
> >>>>>>>>> +
> >>>>>>>>> +if (ctx->is_svp_mode) {
> >>>>>>>>> +ret =3D mtk_vcodec_dec_optee_open(ctx->dev->optee_private);
> >>>>>>>>> +if (ret)
> >>>>>>>>> +mtk_v4l2_vdec_err(ctx, "open secure mode failed.");
> >>>>>>>>> +else
> >>>>>>>>> +mtk_v4l2_vdec_dbg(3, ctx, "decoder in secure mode: %d", ctrl-
> >>>>>>>>
> >>>>>>>> val);
> >>>>>>>>> +}
> >>>>>>>>> +break;
> >>>>>>>>>  default:
> >>>>>>>>>  mtk_v4l2_vdec_dbg(3, ctx, "Not supported to set ctrl id:
> >>>>>>>>> 0x%x\n",
> >>>>>>>
> >>>>>>> hdr_ctrl->id);
> >>>>>>>>>  return ret;
> >>>>>>>>> @@ -573,7 +584,7 @@ static int mtk_vcodec_dec_ctrls_setup(struc=
t
> >>>>>>>
> >>>>>>> mtk_vcodec_dec_ctx *ctx)
> >>>>>>>>>  unsigned int i;
> >>>>>>>>>  struct v4l2_ctrl *ctrl;
> >>>>>>>>>
> >>>>>>>>> -v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 1);
> >>>>>>>>> +v4l2_ctrl_handler_init(&ctx->ctrl_hdl, NUM_CTRLS + 2);
> >>>>>>>>>  if (ctx->ctrl_hdl.error) {
> >>>>>>>>>  mtk_v4l2_vdec_err(ctx, "v4l2_ctrl_handler_init failed\n");
> >>>>>>>>>  return ctx->ctrl_hdl.error;
> >>>>>>>>> @@ -592,6 +603,8 @@ static int mtk_vcodec_dec_ctrls_setup(struc=
t
> >>>>>>>
> >>>>>>> mtk_vcodec_dec_ctx *ctx)
> >>>>>>>>>
> >>>>>>>>>  ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> >>>>>>>
> >>>>>>> &mtk_vcodec_dec_ctrl_ops,
> >>>>>>>>>   V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE, 0, 65535, 1, 0);
> >>>>>>>>> +ctrl =3D v4l2_ctrl_new_std(&ctx->ctrl_hdl,
> >>>>>>>
> >>>>>>> &mtk_vcodec_dec_ctrl_ops,
> >>>>>>>>> + V4L2_CID_MPEG_MTK_SET_SECURE_MODE, 0, 65535, 1, 0);
> >>>>>>>>>
> >>>>>>>>>  v4l2_ctrl_handler_setup(&ctx->ctrl_hdl);
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>>>>
> >>>>>>> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>>>>>> index d8cf01f76aab..a507045a3f30 100644
> >>>>>>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
> >>>>>>>>> @@ -1042,6 +1042,7 @@ const char *v4l2_ctrl_get_name(u32 id)
> >>>>>>>>>  case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:return
> >>>>>>>>> "Reference
> >>>>>>>
> >>>>>>> Frames for a P-Frame";
> >>>>>>>>>  case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:return "Prepend
> >>>>>>>
> >>>>>>> SPS and PPS to IDR";
> >>>>>>>>>  case V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE:return "MediaTek
> >>>>>>>>> Decoder
> >>>>>>>
> >>>>>>> get secure handle";
> >>>>>>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:return "MediaTek Decode=
r
> >>>>>>>
> >>>>>>> set secure mode";
> >>>>>>>>>
> >>>>>>>>>  /* AV1 controls */
> >>>>>>>>>  case V4L2_CID_MPEG_VIDEO_AV1_PROFILE:return "AV1 Profile";
> >>>>>>>>> @@ -1442,6 +1443,10 @@ void v4l2_ctrl_fill(u32 id, const char
> >>>>>>>
> >>>>>>> **name, enum v4l2_ctrl_type *type,
> >>>>>>>>>  *type =3D V4L2_CTRL_TYPE_INTEGER;
> >>>>>>>>>  *flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> >>>>>>>>>  break;
> >>>>>>>>> +case V4L2_CID_MPEG_MTK_SET_SECURE_MODE:
> >>>>>>>>> +*type =3D V4L2_CTRL_TYPE_INTEGER;
> >>>>>>>>> +*flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> >>>>>>>>> +break;
> >>>>>>>>>  case V4L2_CID_USER_CLASS:
> >>>>>>>>>  case V4L2_CID_CAMERA_CLASS:
> >>>>>>>>>  case V4L2_CID_CODEC_CLASS:
> >>>>>>>>> diff --git a/include/uapi/linux/v4l2-controls.h
> >>>>>>>
> >>>>>>> b/include/uapi/linux/v4l2-controls.h
> >>>>>>>>> index 7b3694985366..88e90d943e38 100644
> >>>>>>>>> --- a/include/uapi/linux/v4l2-controls.h
> >>>>>>>>> +++ b/include/uapi/linux/v4l2-controls.h
> >>>>>>>>> @@ -957,6 +957,7 @@ enum v4l2_mpeg_mfc51_video_force_frame_type=
 {
> >>>>>>>>>  /*  MPEG-class control IDs specific to the MediaTek Decoder
> >>>>>>>
> >>>>>>> driver as defined by V4L2 */
> >>>>>>>>>  #define V4L2_CID_MPEG_MTK_BASE(V4L2_CTRL_CLASS_CODEC | 0x2000)
> >>>>>>>>>  #define
> >>>>>>>
> >>>>>>> V4L2_CID_MPEG_MTK_GET_SECURE_HANDLE(V4L2_CID_MPEG_MTK_BASE+8)
> >>>>>>>>> +#define
> >>>>>>>
> >>>>>>> V4L2_CID_MPEG_MTK_SET_SECURE_MODE(V4L2_CID_MPEG_MTK_BASE+9)
> >>>>>>>>>
> >>>>>>>>>  /*  Camera class control IDs */
> >>>>>>>>>
> >>>>>
> >>>>>
> >>>>> _______________________________________________
> >>>>> linux-arm-kernel mailing list
> >>>>> linux-arm-kernel@lists.infradead.org
> >>>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>>
> >>
>
