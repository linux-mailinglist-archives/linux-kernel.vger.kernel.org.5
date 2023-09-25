Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3BC7ADD71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjIYQvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIYQvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:51:39 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22358EE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:51:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35137ab766dso3805ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695660690; x=1696265490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guHH5XwkYZghkYXHEacdf4rVrJmI+x6l8REN2+UZc1Q=;
        b=VDWO5fgpNDRgzkudo0Q4fFfqhuv4ZK7kpviqgoPlXVGirLuv8OJfB208yQkoMTcm4J
         W6gklOhEgFDukTczhNs5nQONJ7HZqxJAtA00FlS0r9Ekh0grmrmoODiyuivDELLXG5jY
         +AyiO1g/sLd/b91JEJbwQnIi7cFI/wgITVHCLXOs/tG7lfDMSI5Lcdk+npAKdeUJl1cC
         YXXnxv1QWcIAZp1a9Z6hGTWrib2mEBzF79AxQMtvZZidV1nTr2imx2P12Fv/AlErW3sd
         FU1tgzgdvx9F29kWXxHjNsyT2Z3GaJ0Mxz5P0b7X8a52enfdXQ+RO8Tmrgry4OtGb/cK
         IWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695660690; x=1696265490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guHH5XwkYZghkYXHEacdf4rVrJmI+x6l8REN2+UZc1Q=;
        b=ljammiq0lvRoT9FFzBRmowNaqhttu8y/IUkU8ayAFfqTN18ynRSyfIyjDR4ayyNRxl
         lLvI4Qy3EM8k+BBeU5B4jX+Zol9pNX/9zJgiqZBXr+MyJuNLVk0pHaSWgHEVouSV1En+
         4u0gjKf2cnwqbGFg3M9YVHKa9aFraE3nDGGIsaHvbiChdHajrPA4tTmbGYtvvWiEny5+
         LzdnizgxoN+SuoMHYVDisd3uShNz45HHfWdY5to3PmfGraK3LduHhMAEYYJTKPnF1zBU
         JdE47uwVITJeqSEz83JGfT+Cm7dO7nqqO3m12gn/p8vVSQqre7DdJy9y9s3BqXcEjK2y
         GV5Q==
X-Gm-Message-State: AOJu0YzvWAfsDXFT5pyUVTUAhLNvH8K6IF/IbcmiTHl1qPGL9DhCOx/i
        8FaS4abv86MkuaWlvDdpE8+so+aMhcGX5CEvTjke
X-Google-Smtp-Source: AGHT+IGGuzThpvoikYBTyyNGTXvsV15y4Fxa6YHncRwzBR705mTRYD3Oop/HwBiBhTmdrvlpEY1m89f4rvx2mMAO+CE=
X-Received: by 2002:a92:c545:0:b0:340:502b:1487 with SMTP id
 a5-20020a92c545000000b00340502b1487mr10796ilj.12.1695660690206; Mon, 25 Sep
 2023 09:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
 <20230911125936.10648-13-yunfei.dong@mediatek.com> <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
 <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl> <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
 <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl> <CA+ddPcN6EaFERC60_Z_-ZmWzqyUEwxiDCZwt_U6Y-gpaAu76tA@mail.gmail.com>
 <ff7aa575-c820-4dfa-853f-77438b8b149a@xs4all.nl> <b7d661637eacbda3e83d192b1126fc3970c4f50d.camel@collabora.com>
 <c3d14f64-bf04-46b9-ac7b-af7ef9014335@xs4all.nl> <00302ac675af858eb11d8398f100921af806bc30.camel@mediatek.com>
 <3e053387-4ba6-49bc-a59a-46854e0a7c26@xs4all.nl> <CA+ddPcOaCKq5Nd_3eWwJ3=oAf=5t-Z+w51NqapXN8VBuvbTw3g@mail.gmail.com>
 <71cadec5-06df-4490-9b06-e3af6bb43498@xs4all.nl>
In-Reply-To: <71cadec5-06df-4490-9b06-e3af6bb43498@xs4all.nl>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Mon, 25 Sep 2023 09:51:15 -0700
Message-ID: <CA+ddPcN0ivYa+vfvs-8PDpkDFkC=1gkM6fkeP7kE8Wqbi1w+dw@mail.gmail.com>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to decoder driver
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
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

On Mon, Sep 25, 2023 at 2:00=E2=80=AFAM Hans Verkuil <hverkuil-cisco@xs4all=
.nl> wrote:
>
> On 22/09/2023 21:17, Jeffrey Kardatzke wrote:
> > On Fri, Sep 22, 2023 at 1:44=E2=80=AFAM Hans Verkuil <hverkuil-cisco@xs=
4all.nl> wrote:
> >>
> >> On 22/09/2023 05:28, Yunfei Dong (=E8=91=A3=E4=BA=91=E9=A3=9E) wrote:
> >>> Hi Hans,
> >>>
> >>> Thanks for your help to give some good advice.
> >>> On Wed, 2023-09-20 at 09:20 +0200, Hans Verkuil wrote:
> >>>>
> >>>>>>>> In any case, using a control to switch to secure mode and using
> >>>> a control
> >>>>>>>> to convert a dmabuf fd to a secure handle seems a poor choice to
> >>>> me.
> >>>>>>>>
> >>>>>>>> I was wondering if it wouldn't be better to create a new
> >>>> V4L2_MEMORY_ type,
> >>>>>>>> e.g. V4L2_MEMORY_DMABUF_SECURE (or perhaps _DMABUF_OPTEE). That
> >>>> ensures that
> >>>>>>>> once you create buffers for the first time, the driver can
> >>>> switch into secure
> >>>>>>>> mode, and until all buffers are released again you know that the
> >>>> driver will
> >>>>>>>> stay in secure mode.
> >>>>>>>
> >>>>>>> Why do you think the control for setting secure mode is a poor
> >>>> choice?
> >>>>>>> There's various places in the driver code where functionality
> >>>> changes
> >>>>>>> based on being secure/non-secure mode, so this is very much a
> >>>> 'global'
> >>>>>>> setting for the driver. It could be inferred based off a new
> >>>> memory
> >>>>>>> type for the queues...which then sets that flag in the driver;
> >>>> but
> >>>>>>> that seems like it would be more fragile and would require
> >>>> checking
> >>>>>>> for incompatible output/capture memory types. I'm not against
> >>>> another
> >>>>>>> way of doing this; but didn't see why you think the proposed
> >>>> method is
> >>>>>>> a poor choice.
> >>>>>>
> >>>>>> I assume you are either decoding to secure memory all the time, or
> >>>> not
> >>>>>> at all. That's something you would want to select the moment you
> >>>> allocate
> >>>>>> the first buffer. Using the V4L2_MEMORY_ value would be the
> >>>> natural place
> >>>>>> for that. A control can typically be toggled at any time, and it
> >>>> makes
> >>>>>> no sense to do that for secure streaming.
> >>>>>>
> >>>>>> Related to that: if you pass a dmabuf fd you will need to check
> >>>> somewhere
> >>>>>> if the fd points to secure memory or not. You don't want to mix
> >>>> the two
> >>>>>> but you want to check that at VIDIOC_QBUF time.
> >>>>>>
> >>>>>> Note that the V4L2_MEMORY_ value is already checked in the v4l2
> >>>> core,
> >>>>>> drivers do not need to do that.
> >>>>>
> >>>>> Just to clarify a bit, and make sure I understand this too. You are
> >>>> proposing to
> >>>>> introduce something like:
> >>>>>
> >>>>>    V4L2_MEMORY_SECURE_DMABUF
> >>>>>
> >>>>> Which like V4L2_MEMORY_DMABUF is meant to import dmabuf, while
> >>>> telling the
> >>>>> driver that the memory is secure according to the definition of
> >>>> "secure" for the
> >>>>> platform its running on.
> >>>>>
> >>>>> This drivers also allocate secure SHM (a standard tee concept) and
> >>>> have internal
> >>>>> allocation for reconstruction buffer and some hw specific reference
> >>>> metadata. So
> >>>>> the idea would be that it would keep allocation using the dmabuf
> >>>> heap internal
> >>>>> APIs ? And decide which type of memory based on the memory type
> >>>> found in the
> >>>>> queue?
> >>>>
> >>>> Yes. Once you request the first buffer you basically tell the driver
> >>>> whether it
> >>>> will operate in secure or non-secure mode, and that stays that way
> >>>> until all
> >>>> buffers are freed. I think that makes sense.
> >>>>
> >>>
> >>> According to iommu's information, the dma operation for secure and no=
n-
> >>> secure are the same, whether just need to add one memory type in v4l2
> >>> framework the same as V4L2_MEMORY_DMABUF? The dma operation in
> >>> videobuf2-dma-contig.c can use the same functions.
> >>
> >> So if I pass a non-secure dma fd to the capture queue of the codec, wh=
o
> >> will check that it can't write the data to that fd? Since doing so wou=
ld
> >> expose the video. Presumably at some point the tee code will prevent t=
hat?
> >> (I sincerely hope so!)
> >
> > It is entirely the job of the TEE to prevent this. Nothing in the
> > kernel should allow exploitation of what happens in the TEE no matter
> > what goes on in the kernel
> >
> >>
> >> Having a separate V4L2_MEMORY_DMABUF_SECURE type is to indicate to the
> >> driver that 1) it can expect secure dmabuf fds, 2) it can configure it=
self
> >> for that (that avoids using a control to toggle between normal and sec=
ure mode),
> >> and at VIDIOC_QBUF time it is easy for the V4L2 core to verify that th=
e
> >> fd that is passed in is for secure memory. This means that mistakes by
> >> userspace are caught at QBUF time.
> >>
> >> Of course, this will not protect you (people can disable this check by
> >> recompiling the kernel), that still has to be done by the firmware, bu=
t
> >> it catches userspace errors early on.
> >>
> >> Also, while for this hardware the DMA operation is the same, that migh=
t
> >> not be the case for other hardware.
> >
> > That's a really good point. So one of the other models that is used
> > for secure video decoding is to send the encrypted buffer into the
> > video decoder directly (i.e. V4L2_MEMORY_MMAP) and then also send in
> > all the corresponding crypto parameters (i.e. algorithm, IV,
> > encryption pattern, etc.). Then the video driver internally does the
> > decryption and decode in one operation.  That's not what we want to
> > use here for Mediatek; but I've done other integrations that work that
> > way (that was for VAAPI [1], not V4L2...but there are other ARM
> > implementations that do operate that way).  So if we end up requiring
> > V4L2_MEMORY_DMABUF_SECURE to indicate secure mode and enforce it on
> > output+capture, that'll close off other potential solutions in the
> > future.
> >
> > Expanding on your point about DMA operations being different on
> > various hardware, that also makes me think a general check for this in
> > v4l2 code may also be limiting. There are various ways secure video
> > pipelines are done, so leaving these checks up to the individual
> > drivers that implement secure video decode may be more pragmatic. If
> > there's a generic V4L2 _CID_SECURE_MODE control, that makes it more
> > general for how drivers can handle secure video decode.
>
> No, using a control for this is really wrong.
>
> The reason why I want it as a separate memory type is that that is
> what you use when you call VIDIOC_REQBUFS, and that ioctl is also
> when things are locked down in a driver. As long as no buffers have
> been allocated, you can still change formats, parameters, etc. But
> once buffers are allocated, most of that can't be changed, since
> changing e.g. the format would also change the buffer sizes.
>
> It also locks down who owns the buffers by storing the file descriptor.
> This prevents other processes from hijacking the I/O streaming, only
> the owner can stream buffers.
>
> So it is a natural point in the sequence for selecting secure
> buffers.
>
> If you request V4L2_MEMORY_DMABUF_SECURE for the output, then the
> capture side must also use DMABUF_SECURE. Whether or not you can
> use regular DMABUF for the output side and select DMABUF_SECURE
> on the capture side is a driver decision. It can be useful to
> support this for testing the secure capture using regular video
> streams (something Nicolas discussed as well), but it depends on
> the hardware whether you can use that technique.

OK, that does work for the additional cases I mentioned.  And for
testing...we would still want to use DMABUF_SECURE on both ends for
Mediatek at least (that's the only way they support it). But rather
than having to bother with a clearkey implementation...we can just do
something that directly copies compressed video into the secure
dmabufs and then exercises the whole pipeline from there. This same
thing happens with the 'clear lead' that is sometimes there with
encrypted video (where the first X seconds are unencrypted and then it
switches to encrypted...but you're still using the secure video
pipeline on the unencrypted frames in that case).


>
> Regards,
>
>         Hans
>
> >
> > [1] - https://github.com/intel/libva/blob/master/va/va.h#L2177
> >
> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >>>
> >>> Best Regards,
> >>> Yunfei Dong
> >>>
> >>
>
