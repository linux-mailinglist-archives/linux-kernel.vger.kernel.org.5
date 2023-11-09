Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AAF7E69D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 12:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjKILmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 06:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjKILmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 06:42:22 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B522D64
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 03:42:20 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c431b91b2aso722390b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 03:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699530140; x=1700134940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ks66/aaBrCae+24/ZGNYzUfStCxhmpQEyTbEy/n7tI=;
        b=3MXLvX4rJu8pgBM6fBXLcyBOjZSXwc9cxAn4k1ld+gLcRMlTGXSzoV91ZIuES/GiEJ
         TlX2zY+3x3Cc6qZxEY/GVmZmgy6MuV509WqQ/Bn7cDNkyVsMsQ0WRe3+/zh/GYvmlrnL
         1Hoxvu8GZWu2UZWrNUrSB42o04R4ltW7seJ8lzgcLEgvvvuyiVNuOplXeIKRgm+mmoAX
         objIeKbb5MEdG6zvodMWqGb3o7oAz336bSJ7v1fJ7hy4e1AWRAqq+pGGnyupOzRFNEUh
         S3RCg70bsC0hCqJuW4JM+t7hXuCfKAFQB2G6FaeT0sSqqT4nAyPeV1PRzs/eVk6Y3jfY
         huag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699530140; x=1700134940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ks66/aaBrCae+24/ZGNYzUfStCxhmpQEyTbEy/n7tI=;
        b=mE24LAN6EVPt2dFmEp8ypvRim3hCdTe1/o3H8OrBFXX5KOBUyMyI1ucfBq6j6fNTqS
         zWMNughUELzikFOF+EgopzCwTUp7D+zcXoKKN6zsG3pfIJoMxAqbWnTW8p5W2WIKBN2G
         k3MBamTg9xnhyjAQUf4PojuPghmKqED8wUA1nN4SeguUqtVGdVxSS/cmGvH7X0Q2FS74
         MnPoU8QkzM9g+UwWIY2idN/c3EdrVAvhezztRlorygFN9ZRAl9zKvPfSArNf84zdVRtb
         a6djdmtm89IIn9Qxtzj4wSOVwI2C6sd0RXbSNWa93bj5nKp6l0mQozi6kDfI6WVcdZ86
         cjTw==
X-Gm-Message-State: AOJu0YwBiuDvOfr08usVM4mYeR6acpZ+OQAgSgdjIo8m0eGDjbbXTDBf
        q3JMkasm1BxNZmV6c3Mxl2/jZlFtyMf1FpJJvs8abw==
X-Google-Smtp-Source: AGHT+IGToiDV0lxKYJVwEkt5iRWbZzW7iOX44IGXWCByCxcvUVYLyQjPJ6mcdX1uJwHF5YGSjtOoxS3h/p0zHGwvJn4=
X-Received: by 2002:a05:6a20:4311:b0:14d:6309:fc96 with SMTP id
 h17-20020a056a20431100b0014d6309fc96mr5475018pzk.4.1699530139918; Thu, 09 Nov
 2023 03:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
 <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu> <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
 <fe672e31315b8f9c44a693c909d464a299e76093.camel@ndufresne.ca>
 <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
 <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
 <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
 <CANiDSCunRRyod3Rg+L9ZsffOZyC7CKbMVTHX3u-n5iuNyZQk0w@mail.gmail.com>
 <20231109000327.GE21616@pendragon.ideasonboard.com> <CAEZL83rcMocCohTi1ddAOyQ7BDK_AqR3-h33ZnHkWRMFO7cuwg@mail.gmail.com>
 <20231109113428.GI21616@pendragon.ideasonboard.com>
In-Reply-To: <20231109113428.GI21616@pendragon.ideasonboard.com>
From:   Esker Wong <esker@google.com>
Date:   Thu, 9 Nov 2023 19:41:43 +0800
Message-ID: <CAEZL83reDb0dY4gTd8LwUXUsYNoYtYePZbDO4d_wDBv4FdCsdw@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>, nicolas@ndufresne.ca,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Esker Wong <esker@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

We not only need t(dqbuf) - t(exposure), we are also interested in
t(dqbuf) - t(frame_recieved) to know more detail inside the camera for
analysis.

Thanks,
Esker








On Thu, Nov 9, 2023 at 7:34=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Esker,
>
> On Thu, Nov 09, 2023 at 08:59:13AM +0800, Esker Wong wrote:
> > Hi Laurent,
> >
> > The use case here we want is actually the latency. We want to know
> > what is the most accurate delay the user will feel when the camera
> > capture the frame to the frame get displayed. So anytime earlier then
> > the dqbuf should be an improvement here. It would help us know better
> > of a camera quality.
>
> If it's the latency you're after, wouldn't it be best to use the
> timestamp produced by the camera ? That's the most accurate information.
> It is expressed relative to the camera internal clock, but UVC transmits
> information that enables conversion of the value to a system timestamp.
>
> > On Thu, Nov 9, 2023 at 8:03=E2=80=AFAM Laurent Pinchart wrote:
> > > On Wed, Nov 08, 2023 at 11:46:40PM +0100, Ricardo Ribalda wrote:
> > > > On Wed, 8 Nov 2023 at 21:32, <nicolas@ndufresne.ca> wrote:
> > > > >
> > > > > The fact that you interpret the time from FRAME_SYNC to DQBUF (we=
ll the
> > > > > READ IO notification) as the actual latency is yours of course. I=
t
> > > > > assumes that the camera on the other end does not introduce other
> > > >
> > > > We want to use this signal to measure how much power is used since =
we
> > > > start receiving the frame until we can use it.
> > > > I agree with you that the latency between capture and dqbuf should =
be
> > > > measured using the timestamp. That is not our use case here.
> > > >
> > > > > source of latency (or that these are negligible). You are also go=
ing to
> > > > > introduce a lot of jitter, since it relies on when the OS decides=
 to
> > > > > wake up your process.
> > > >
> > > > We have measured a jitter of around 2.5 msec, which is acceptable f=
or our needs.
> > > >
> > > > > I think my opinion resides in if you can accurately *enough* impl=
ement
> > > > > what the spec says for FRAME_SYNC then do it, otherwise just don'=
t lie.
> > > >
> > > > What the specs says is:
> > > > ```
> > > > Triggered immediately when the reception of a frame has begun
> > > > ```
> > > > In my opinion, that is true for usb devices, we are triggering it a=
s
> > > > soon as the transfer has started to the eyes of the driver. We cann=
ot
> > > > trigger earlier than that.
> > > >
> > > >
> > > > > I think for ISO, "after the first chunk" i a small lie, but accep=
table.
> > > > > But for BULK, the way it was explained is that it will be always =
very
> > > > > close to DQBUF time. and it should not emit FRAME_SYNC for this t=
ype of
> > > > > UVC device. If it fits other events fine of course, I'm just maki=
ng a
> > > > > judgment on if its fits V4L2_EVENT_FRAME_SYNC or not.
> > > >
> > > > nit: I believe that you have swapped iso and bulk on this descripti=
on
> > >
> > > I've confused the USB packet size and the UVC payload size. The latte=
r
> > > is typically much bigger for bulk devices than isoc devices, but the
> > > former will be in similar order of magnitudes in a large number of
> > > cases, but not all cases.
> > >
> > > The URB size is the result of the USB packet size and number of packe=
ts
> > > per URB. The uvcvideo driver currently sets the number of packets per
> > > URB to 32 at most (and lowers it if the frame size is small, or if no=
t
> > > enough memory can be allocated). This could be increased or made dyna=
mic
> > > in the future, as higher speeds typically benefit from larger URB siz=
es.
> > > The packet size differs between bulk and isoc endpoints.
> > >
> > > For bulk, the packet size can be up to 512 bytes for USB 2.0 and 1024
> > > bytes for USB 3.0, and the device can select a smaller size. The larg=
est
> > > URB size (again based on the current implementation of the uvcvideo
> > > driver) is thus 32 KiB.
> > >
> > > For isochronous the situation is more complicated. The term "packet" =
as
> > > used in the uvcvideo driver actually means all the data transferred i=
n
> > > one service interval, thus made of multiple isoc packets. It is heavi=
ly
> > > dependent on the USB speed, and the device can advertise different
> > > supported sizes (which translate directly to the reserved bandwidth f=
or
> > > the transfer), with the driver picking the smallest bandwidth large
> > > enough for the data rate required by the resolution and frame rate. T=
he
> > > theoretical worst case is 1024 bytes per isoc packet * 16 isoc packet=
s
> > > per burst * 6 burst per interval * 32 "packets" per URB, equal to 3 M=
iB.
> > >
> > > Even with the largest URB size you have witnessed of ~1 MiB, we will =
end
> > > up lying quite a bit if we consider the URB completion callback for t=
he
> > > first URB of the frame as indicating the start of reception.
> > >
> > > > > In term of accuracy, if timestamp was passed with the FRAME_SYNC =
event,
> > > > > it would not matter how fast your process the event anymore and g=
reatly
> > > > > improve accuracy.
> > > >
> > > > +1 to that. If we could easily change the uAPI for FRAME_SYNC that
> > > > should definitely be implemented.
> > > >
> > > > > > Not to mention that the UVC timestamping requires a bit of love=
.
> > > > > >
> > > > > > @Laurent Pinchart, @Kieran Bingham  any progress reviewing :P :
> > > > > > https://patchwork.linuxtv.org/project/linux-media/list/?series=
=3D10083
> > > > >
> > > > > Thanks for working on this by the way, hope someone will find the=
 time
> > > > > to review this. The timestamps should in theory provide a jitter =
free
> > > >
> > > > It already has a couple of Reviewed-by stamped in.... ;)
> > > >
> > > > > measurement of the delay Esker is trying to measure, and if it wa=
sn't
> > > > > of bugs (and crazy complexity) it would in the worst case match t=
he
> > > > > transfer time.
> > > >
> > > > Sorry to repeat myself, but just to avoid the confusion: Esker need=
s
> > > > to know how much power is used since we start receiving a frame unt=
il
> > > > it is available for dqbuf, not de frame latency.
> > >
> > > As I think everybody is aware, the earliest notification you get on t=
he
> > > CPU side is the *end* of reception of the first URB, which can possib=
ly
> > > be significantly later than the start of reception of the frame.
> > >
> > > Based on what I understand, the goal is to measure the CPU power
> > > consumption related to CPU processing of the frame. If that's the cas=
e,
> > > there's good and bad news. The good news is that the CPU doesn't proc=
ess
> > > the frame at all until the URB has been received (if you were to meas=
ure
> > > the power consumption of the USB host controller too, it would be a
> > > different story), so the delay shouldn't be a problem. The bad news i=
s
> > > that I don't see how the information you're trying to get will help y=
ou,
> > > as there's plenty of other things unrelated to the uvcvideo driver th=
at
> > > can take CPU time while a frame is being received. That may not be an=
y
> > > of my business, but from the point of view of the uvcvideo driver, I'=
m
> > > less inclined to accept a possibly significant V4L2_EVENT_FRAME_SYNC =
lie
> > > if the use case ends up making little sense :-)
>
> --
> Regards,
>
> Laurent Pinchart
