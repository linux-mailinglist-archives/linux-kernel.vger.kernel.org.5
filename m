Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D697F661E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjKWSWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWSWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:22:08 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EA0DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:22:14 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f5d2e4326fso674540fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1700763733; x=1701368533; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QgSFVLXdiiVlFncJG5xnGMZmf3/Lcv/2SbxbrtDMVHM=;
        b=zEn7F6RBkQg1dH+lgFglNvoTr4hfTWzcvCZOl7p+4Lqkb3KCsHK7DETy6Vbk9IyCzq
         g803IXMLZXdNZGJ8BMyh3F+8ylJc+H0XWJEg+J2WqniB4SRnRyGUdvSjBBvDUTnZRAHl
         s60gZPTbiC5t+oxZ7PKVLOBYUn8bjqY/9FtzoYB7RRmiC8YA1qKuzPzA25AHJOH7AfmP
         TTL5Ta9ikXinurYqsRo/nPF4ikjXGYRQ7LsY3rMPGpfkxlaX6xPyVnHBeo3uLCyTJs+w
         BKtcq/YTGjXdAWGPujZTFgoUF8Yt6k9a6uGhz5n9Il7EnMmse4KRcHSUHB0o36Hq74PM
         od9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700763733; x=1701368533;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgSFVLXdiiVlFncJG5xnGMZmf3/Lcv/2SbxbrtDMVHM=;
        b=PfVSQs1cguSiorypRG+BgkprVEKrS7S+u5ohEgJL63DEFY6G+ZEGwi+8WDRT4QeDPE
         3IZSP9o5cBBRKh2re84Pgi2iKaJbfUAUvv7/a2JYPrsE8qa2+KDl34lVT6WI41NA1U+6
         0674qs9ekptzSo/GjitFrEyAAakRn9Q1tt7kHcGEM7vCoIID6QTfStcYVJgabKEndeT8
         mV3V6Ke9k+bdgHSjCB+C8PuxV1ExSDuEUAS8lK3mVrQ3RTG+eNae0cq0J17lMcUTZasp
         f3iTc4tvBvPhr8zQPCI79bVTtJ6o051i/zrv3iybQTfO4DbI7VU7a8a5Kp+3+oEgZxNP
         eryw==
X-Gm-Message-State: AOJu0YyNRwKeOQ+i9o/+tgympO0C7gPIGME1AfZ4R0j7TGNOKoFX/0nL
        JkgOaMlcu3ePSFU9kpQd2TBfrw==
X-Google-Smtp-Source: AGHT+IF3P8f9G8z9cBesH4gZimJTvSi3PylasM1ZQxb1/VVqU5icDdUiOk0n+6nNy/V0MrxC6p6jEg==
X-Received: by 2002:a05:6870:c6a5:b0:1f0:597d:fe25 with SMTP id cv37-20020a056870c6a500b001f0597dfe25mr111773oab.45.1700763733463;
        Thu, 23 Nov 2023 10:22:13 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:3ac8::7a9])
        by smtp.gmail.com with ESMTPSA id d13-20020a0cf6cd000000b0067a063e606asm697875qvo.52.2023.11.23.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:22:12 -0800 (PST)
Message-ID: <ded0b788f5896621cffd8f64c679ef375231b6d1.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Esker Wong <esker@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Esker Wong <esker@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 Nov 2023 13:22:11 -0500
In-Reply-To: <CANiDSCuD=Z2FVaSnejCfLnRJXUSE99GQkK=4tRAXBbxpUqEVHg@mail.gmail.com>
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
         <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu>
         <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
         <fe672e31315b8f9c44a693c909d464a299e76093.camel@ndufresne.ca>
         <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
         <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
         <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
         <CANiDSCunRRyod3Rg+L9ZsffOZyC7CKbMVTHX3u-n5iuNyZQk0w@mail.gmail.com>
         <20231109000327.GE21616@pendragon.ideasonboard.com>
         <CANiDSCuD=Z2FVaSnejCfLnRJXUSE99GQkK=4tRAXBbxpUqEVHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 09 novembre 2023 =C3=A0 01:27 +0100, Ricardo Ribalda a =C3=A9crit=
=C2=A0:
> Hi Laurent
>=20
> On Thu, 9 Nov 2023 at 01:03, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >=20
> > Hi Ricardo,
> >=20
> > On Wed, Nov 08, 2023 at 11:46:40PM +0100, Ricardo Ribalda wrote:
> > > On Wed, 8 Nov 2023 at 21:32, <nicolas@ndufresne.ca> wrote:
> > > >=20
> > > > The fact that you interpret the time from FRAME_SYNC to DQBUF (well=
 the
> > > > READ IO notification) as the actual latency is yours of course. It
> > > > assumes that the camera on the other end does not introduce other
> > >=20
> > > We want to use this signal to measure how much power is used since we
> > > start receiving the frame until we can use it.
> > > I agree with you that the latency between capture and dqbuf should be
> > > measured using the timestamp. That is not our use case here.
> > >=20
> > > > source of latency (or that these are negligible). You are also goin=
g to
> > > > introduce a lot of jitter, since it relies on when the OS decides t=
o
> > > > wake up your process.
> > >=20
> > > We have measured a jitter of around 2.5 msec, which is acceptable for=
 our needs.
> > >=20
> > > > I think my opinion resides in if you can accurately *enough* implem=
ent
> > > > what the spec says for FRAME_SYNC then do it, otherwise just don't =
lie.
> > >=20
> > > What the specs says is:
> > > ```
> > > Triggered immediately when the reception of a frame has begun
> > > ```
> > > In my opinion, that is true for usb devices, we are triggering it as
> > > soon as the transfer has started to the eyes of the driver. We cannot
> > > trigger earlier than that.
> > >=20
> > >=20
> > > > I think for ISO, "after the first chunk" i a small lie, but accepta=
ble.
> > > > But for BULK, the way it was explained is that it will be always ve=
ry
> > > > close to DQBUF time. and it should not emit FRAME_SYNC for this typ=
e of
> > > > UVC device. If it fits other events fine of course, I'm just making=
 a
> > > > judgment on if its fits V4L2_EVENT_FRAME_SYNC or not.
> > >=20
> > > nit: I believe that you have swapped iso and bulk on this description
> >=20
> > I've confused the USB packet size and the UVC payload size. The latter
> > is typically much bigger for bulk devices than isoc devices, but the
> > former will be in similar order of magnitudes in a large number of
> > cases, but not all cases.
> >=20
> > The URB size is the result of the USB packet size and number of packets
> > per URB. The uvcvideo driver currently sets the number of packets per
> > URB to 32 at most (and lowers it if the frame size is small, or if not
> > enough memory can be allocated). This could be increased or made dynami=
c
> > in the future, as higher speeds typically benefit from larger URB sizes=
.
> > The packet size differs between bulk and isoc endpoints.
> >=20
> > For bulk, the packet size can be up to 512 bytes for USB 2.0 and 1024
> > bytes for USB 3.0, and the device can select a smaller size. The larges=
t
> > URB size (again based on the current implementation of the uvcvideo
> > driver) is thus 32 KiB.
> >=20
> > For isochronous the situation is more complicated. The term "packet" as
> > used in the uvcvideo driver actually means all the data transferred in
> > one service interval, thus made of multiple isoc packets. It is heavily
> > dependent on the USB speed, and the device can advertise different
> > supported sizes (which translate directly to the reserved bandwidth for
> > the transfer), with the driver picking the smallest bandwidth large
> > enough for the data rate required by the resolution and frame rate. The
> > theoretical worst case is 1024 bytes per isoc packet * 16 isoc packets
> > per burst * 6 burst per interval * 32 "packets" per URB, equal to 3 MiB=
.
> >=20
> > Even with the largest URB size you have witnessed of ~1 MiB, we will en=
d
> > up lying quite a bit if we consider the URB completion callback for the
> > first URB of the frame as indicating the start of reception.
> >=20
> > > > In term of accuracy, if timestamp was passed with the FRAME_SYNC ev=
ent,
> > > > it would not matter how fast your process the event anymore and gre=
atly
> > > > improve accuracy.
> > >=20
> > > +1 to that. If we could easily change the uAPI for FRAME_SYNC that
> > > should definitely be implemented.
> > >=20
> > > > > Not to mention that the UVC timestamping requires a bit of love.
> > > > >=20
> > > > > @Laurent Pinchart, @Kieran Bingham  any progress reviewing :P :
> > > > > https://patchwork.linuxtv.org/project/linux-media/list/?series=3D=
10083
> > > >=20
> > > > Thanks for working on this by the way, hope someone will find the t=
ime
> > > > to review this. The timestamps should in theory provide a jitter fr=
ee
> > >=20
> > > It already has a couple of Reviewed-by stamped in.... ;)
> > >=20
> > > > measurement of the delay Esker is trying to measure, and if it wasn=
't
> > > > of bugs (and crazy complexity) it would in the worst case match the
> > > > transfer time.
> > >=20
> > > Sorry to repeat myself, but just to avoid the confusion: Esker needs
> > > to know how much power is used since we start receiving a frame until
> > > it is available for dqbuf, not de frame latency.
> >=20
> > As I think everybody is aware, the earliest notification you get on the
> > CPU side is the *end* of reception of the first URB, which can possibly
> > be significantly later than the start of reception of the frame.
> >=20
> > Based on what I understand, the goal is to measure the CPU power
> > consumption related to CPU processing of the frame. If that's the case,
> > there's good and bad news. The good news is that the CPU doesn't proces=
s
> > the frame at all until the URB has been received (if you were to measur=
e
> > the power consumption of the USB host controller too, it would be a
> > different story), so the delay shouldn't be a problem. The bad news is
> > that I don't see how the information you're trying to get will help you=
,
> > as there's plenty of other things unrelated to the uvcvideo driver that
> > can take CPU time while a frame is being received. That may not be any
> > of my business, but from the point of view of the uvcvideo driver, I'm
> > less inclined to accept a possibly significant V4L2_EVENT_FRAME_SYNC li=
e
> > if the use case ends up making little sense :-)
>=20
> Just to add some numbers to add some context:
>=20
>  V4L2_EVENT_FRAME_SYNC for BULK and ISO will be delayed from:
> ```
> Triggered immediately when the reception of a frame has begun
> ```
> one urb.
>=20
> For bulk devices this is a maximum of 0.05 msec (32KiB/600MBps)

I lack a bit of knowledge on how to scale this to different devices, with
different speed/framesize. My only bulk device is:

https://inogeni.com/product/4k2usb3/

Which is USB 3.0, and have raw (NV12) resolution from 640x480 (max 60pfs) t=
o 4K
(max 30fps). What would the error look like with that ?

> For 1MiB transfer isoc devices (which is the biggest we have seen),
> that is 1.8 msec.
> In both cases, this is smaller than the jitter to process the event
> itself by userspace.
>=20
> The time from V4L2_EVENT_FRAME_SYNC to DQBUF is around 30 msec.
>=20
> I do not know how much delay is considered acceptable... but if we
> take the delay argument to the extreme, we could say that
> V4L2_EVENT_FRAME_SYNC can never be implemented, because the event will
> always be delayed by something.

We have v4l2_event.timestamp for all events, so the jitter to process the e=
vent
by userpace can be removed reliably already.

Nicolas

p.s. missed it earlier

>=20
> >=20
> > --
> > Regards,
> >=20
> > Laurent Pinchart
>=20
>=20
>=20

