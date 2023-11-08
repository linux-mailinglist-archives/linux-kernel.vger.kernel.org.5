Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C57E5F36
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjKHUc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjKHUc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:32:28 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233E92132
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:32:26 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-778925998cbso6253685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 12:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1699475545; x=1700080345; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=arsZQPA2RZXUjCJmEFmYkqL9RPQkiSEQdhIguF//Kn4=;
        b=3GvZraNVoluGhkP+Z3Y35I6XItw6KO6u1mQ7KXOJp8y7Ces1vMbpO/cjQ05OUhFJXC
         cKbVghjCMpKXUKIt1Sdl2HzOlndffZ34c821MjRJRlWoKQpJxmrBYx7Mxkg2zA1aTDEv
         lHRRkn7XJIgz+7ZsTtDNX+XrMWsqgDyhRCjssN4QY6DDjWR8MHw2PIxFhnEVU3+AONOg
         Q39oo7gTkdLYdcVulIWBN0DR8fIjDW+Rq72+avMwOPRLtWmBZ3kppztn1rxrdJ0N0Sob
         vU+au6BWt3T5bDkRi8jY6nJjWhG5ZZBF/3Yr0J5ZCEe9SbPw5Fnn/BXYI9oRf5Ee8FKT
         WuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699475545; x=1700080345;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arsZQPA2RZXUjCJmEFmYkqL9RPQkiSEQdhIguF//Kn4=;
        b=X/ZeWlMf7K/r9lUUKZI91dWPgST9g19Rf4xWI/cXhQ6mPOeG6UlIRV6TI5AUjg4Lfd
         KjiyNpg1+YER5TEZMOJOHOjTi7j3PaDczgNdVSZ6h7UAS4YPg4pwuA8R7ip0C3ZS599j
         eGThz5xC1VDCNLgAqFGCqnJNaKnE4lKgvhbj7Q4UPVKDb8pZD1UVc2GqDeF1RKasZXNy
         jydTvVebF4suq4RablQXhc6p+J5J4asi8sYAgFhUougmaO/0smVOjZEL3he6hvXivilw
         cwKxl/TY2NfgRXEJ/T2Cs6i4jzSBteEXgJ7iWWd6MQGJ38rzbCcAfGuXv2TVqu38QemA
         /IQA==
X-Gm-Message-State: AOJu0YxoOLsCGOjQmKDgj1SrR5wbj7jeThxRG3RzlC8xbBevEftlVrue
        DSjX0Xiq8FswYjQshdMeGIHGkw==
X-Google-Smtp-Source: AGHT+IGBqGUcpAiMYcvzEd3qf5FRqvRSHQytfpVmoG2JSlNJ/d3VqMavVbb6p4+mmsKy/L5SxAXOpQ==
X-Received: by 2002:a05:620a:8394:b0:770:72c3:dbbc with SMTP id pb20-20020a05620a839400b0077072c3dbbcmr2925381qkn.18.1699475545168;
        Wed, 08 Nov 2023 12:32:25 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:6dc0::c73? ([2606:6d00:17:6dc0::c73])
        by smtp.gmail.com with ESMTPSA id c26-20020a05620a135a00b007742c2ad7dfsm1401055qkl.73.2023.11.08.12.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 12:32:24 -0800 (PST)
Message-ID: <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
From:   nicolas@ndufresne.ca
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Esker Wong <esker@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Esker Wong <esker@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Nov 2023 15:32:23 -0500
In-Reply-To: <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
         <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu>
         <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
         <fe672e31315b8f9c44a693c909d464a299e76093.camel@ndufresne.ca>
         <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
         <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 08 novembre 2023 =C3=A0 08:04 +0100, Ricardo Ribalda a =C3=A9cr=
it=C2=A0:
> Hi Esker
>=20
> On Wed, 8 Nov 2023 at 07:54, Esker Wong <esker@google.com> wrote:
> >=20
> > Hi Nicholas and Sakari,
> >=20
> > We need it as precise as possible. Currently the earliest time of a
> > frame we can have in userspace  is the dqbuf.
> >=20
> > And for UVC timestamp, it is somewhat awkward for us to use. Since
> > other functions in our stacks do not necessarily contain such
> > timestamps. So we want some event to be trigger and we can get the
> > system time directly.

The fact that you interpret the time from FRAME_SYNC to DQBUF (well the
READ IO notification) as the actual latency is yours of course. It
assumes that the camera on the other end does not introduce other
source of latency (or that these are negligible). You are also going to
introduce a lot of jitter, since it relies on when the OS decides to
wake up your process.

I think my opinion resides in if you can accurately *enough* implement
what the spec says for FRAME_SYNC then do it, otherwise just don't lie.
I think for ISO, "after the first chunk" i a small lie, but acceptable.
But for BULK, the way it was explained is that it will be always very
close to DQBUF time. and it should not emit FRAME_SYNC for this type of
UVC device. If it fits other events fine of course, I'm just making a
judgment on if its fits V4L2_EVENT_FRAME_SYNC or not.

In term of accuracy, if timestamp was passed with the FRAME_SYNC event,
it would not matter how fast your process the event anymore and greatly
improve accuracy.

>=20
> Not to mention that the UVC timestamping requires a bit of love.
>=20
> @Laurent Pinchart, @Kieran Bingham  any progress reviewing :P :
> https://patchwork.linuxtv.org/project/linux-media/list/?series=3D10083

Thanks for working on this by the way, hope someone will find the time
to review this. The timestamps should in theory provide a jitter free
measurement of the delay Esker is trying to measure, and if it wasn't
of bugs (and crazy complexity) it would in the worst case match the
transfer time.

Nicolas

> Esker
>=20
>=20
> >=20
> > If the V4L2_EVENT_FRAME_SYNC will be earlier then V4L2_EVENT_VSYNC,
> > then it has value. We would want to know the delay of a frame being
> > captured to the time it is displayed.
> >=20
> > I'm not sure for bulk is the V4L2_EVENT_VSYNC more accurate?
>=20
>  V4L2_EVENT_VSYNC wont be more accurate than V4L2_EVENT_FRAME_SYNC.
>=20
> My understanding is that Sakari thinks that the description of
> V4L2_EVENT_FRAME_SYNC
> https://www.kernel.org/doc/html/v4.9/media/uapi/v4l/vidioc-dqevent.html#d=
escription
>  does not match the current implementation, and suggests using
> V4L2_EVENT_VSYNC instead.
>=20
>=20
> >=20
> > Esker
> >=20
> >=20
> > On Wed, Nov 8, 2023 at 3:27=E2=80=AFAM <nicolas@ndufresne.ca> wrote:
> > >=20
> > > Hi,
> > >=20
> > > Le mardi 07 novembre 2023 =C3=A0 13:06 +0800, Esker Wong a =C3=A9crit=
 :
> > > > [send again in text mode]
> > > > Hi Sakari,
> > > >=20
> > > > Sequence number is important to us. We need it to measure the laten=
cy
> > > > from this event to the time we display the frame.
> > >=20
> > > how much precision do you expect, because as described, this number
> > > will be completely false for bulk.
> > >=20
> > > Aren't UVC timestamp support to allow measuring latency properly ?
> > >=20
> > > Nicolas
> > >=20
> > > >=20
> > > > Regards,
> > > > Esker
> > > >=20
> > > >=20
> > > > On Mon, Nov 6, 2023 at 7:06=E2=80=AFPM Sakari Ailus <sakari.ailus@i=
ki.fi> wrote:
> > > > >=20
> > > > > Hi Ricardo,
> > > > >=20
> > > > > On Mon, Nov 06, 2023 at 10:52:27AM +0000, Ricardo Ribalda wrote:
> > > > > > Add support for the frame_sync event, so user-space can become =
aware
> > > > > > earlier of new frames.
> > > > > >=20
> > > > > > Suggested-by: Esker Wong <esker@chromium.org>
> > > > > > Tested-by: Esker Wong <esker@chromium.org>
> > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > ---
> > > > > > We have measured a latency of around 30msecs between frame sync
> > > > > > and dqbuf.
> > > > > > ---
> > > > > > Changes in v2:
> > > > > > - Suggested by Laurent. Split sequence++ and event init.
> > > > > > - Link to v1: https://lore.kernel.org/r/20231020-uvc-event-v1-1=
-3baa0e9f6952@chromium.org
> > > > > > ---
> > > > > >  drivers/media/usb/uvc/uvc_v4l2.c  | 2 ++
> > > > > >  drivers/media/usb/uvc/uvc_video.c | 7 +++++++
> > > > > >  2 files changed, 9 insertions(+)
> > > > > >=20
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/u=
sb/uvc/uvc_v4l2.c
> > > > > > index f4988f03640a..9f3fb5fd2375 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > > @@ -1352,6 +1352,8 @@ static int uvc_ioctl_subscribe_event(stru=
ct v4l2_fh *fh,
> > > > > >       switch (sub->type) {
> > > > > >       case V4L2_EVENT_CTRL:
> > > > > >               return v4l2_event_subscribe(fh, sub, 0, &uvc_ctrl=
_sub_ev_ops);
> > > > > > +     case V4L2_EVENT_FRAME_SYNC:
> > > > > > +             return v4l2_event_subscribe(fh, sub, 0, NULL);
> > > > > >       default:
> > > > > >               return -EINVAL;
> > > > > >       }
> > > > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/=
usb/uvc/uvc_video.c
> > > > > > index 28dde08ec6c5..4f3a510ca4fe 100644
> > > > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > > > @@ -1073,9 +1073,16 @@ static int uvc_video_decode_start(struct=
 uvc_streaming *stream,
> > > > > >        * that discontinuous sequence numbers always indicate lo=
st frames.
> > > > > >        */
> > > > > >       if (stream->last_fid !=3D fid) {
> > > > > > +             struct v4l2_event event =3D {
> > > > > > +                     .type =3D V4L2_EVENT_FRAME_SYNC,
> > > > > > +             };
> > > > > > +
> > > > > >               stream->sequence++;
> > > > > >               if (stream->sequence)
> > > > > >                       uvc_video_stats_update(stream);
> > > > > > +
> > > > > > +             event.u.frame_sync.frame_sequence =3D stream->seq=
uence,
> > > > > > +             v4l2_event_queue(&stream->vdev, &event);
> > > > >=20
> > > > > uvc_video_decode_start() is called when the reception of the enti=
re frame
> > > > > has been completed. However, the documentation for V4L2_EVENT_FRA=
ME_SYNC
> > > > > says that the event is "Triggered immediately when the reception =
of a frame
> > > > > has begun.". The functionality here doesn't seem to fit to this p=
atch.
> > > > >=20
> > > > > Wouldn't V4L2_EVENT_VSYNC be a better fit, even if we don't reall=
y have a
> > > > > concept of vertical sync in the case of USB? That event doesn't h=
ave the
> > > > > sequence though but I guess it's not an issue at least if your ca=
se.
> > > > >=20
> > > > > Another technically correct option could be to create a new event=
 for this
> > > > > but I'm not sure it's worth it.
> > > > >=20
> > > > > >       }
> > > > > >=20
> > > > > >       uvc_video_clock_decode(stream, buf, data, len);
> > > > > >=20
> > > > >=20
> > > > > --
> > > > > Regards,
> > > > >=20
> > > > > Sakari Ailus
> > >=20
>=20
>=20
>=20

