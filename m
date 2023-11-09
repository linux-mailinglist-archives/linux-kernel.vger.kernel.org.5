Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB68F7E6163
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjKIA1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKIA1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:27:39 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872EF268F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 16:27:37 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41e58a33ec9so1968041cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 16:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699489656; x=1700094456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjhlsBOUMwiMeFAPoPORt6q2UO4A3cplcij8pItO4+0=;
        b=LWiM9ZNz86eIGL5mILQfUVwwNM2AG0kfXpSL/7XA34nVZEXMnHSswUSMhNvoLuepIa
         4gfkJfsQy+PV46hhnzD3HSV8sOzykA5T6wsLiMPqUb5zNjqIEobiWlCSBlOPthpy5NTm
         3m7gBfqYGU2uYTqc06dySPy6EldcBKPJQ82U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699489656; x=1700094456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjhlsBOUMwiMeFAPoPORt6q2UO4A3cplcij8pItO4+0=;
        b=bsKBfnzu3/V7SJHEV0GjbhQPgDz5PzTjssSSzADewhp+q2TbOuCbLcOR7Tl3eb5O4r
         csPV0vCajFjm0JH68QsI9zuIRzLtCkf0yZ10tRBNf+98/I+ivcbNPxkYmzhhsEFhQ3Sf
         EgA4rmkiK9sbmf2UVUvKJR2zZuktUpJ2qBlTrNr42UAsdGPcYrYh5suCfE3aDCvQ956O
         RhshGchJ/a0jtcIdkdTponGScjKz2FBpn2yG7rrX+drdSQd2KRimRdsCj9wOEPQ5uX+l
         nYQxn/dveraisifftvtQ7kORJPfKGqhUD9Y4vetve2MUA/u4FCpfW7eo34L8DBJeZUGQ
         TuSg==
X-Gm-Message-State: AOJu0YyV/IdDkgrKyY/C2PdMbyP3YKRWV7uZdy5Fjna6OYCp7lAm6pno
        eMoN2kteAB4SkpcqoH+oFIUqcHS/X5jwhMUoETnv+g==
X-Google-Smtp-Source: AGHT+IGa0RG+O6DXQRP43YbZwKRystnJ+OC5OXhUpeOPeMAzKPirqZECmrXDqmNBMXzPuTn5TI5gjQ==
X-Received: by 2002:a05:622a:186:b0:41c:c56b:e2bd with SMTP id s6-20020a05622a018600b0041cc56be2bdmr3616815qtw.11.1699489656236;
        Wed, 08 Nov 2023 16:27:36 -0800 (PST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com. [209.85.222.170])
        by smtp.gmail.com with ESMTPSA id n5-20020ac86745000000b0041977932fc6sm1433692qtp.18.2023.11.08.16.27.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 16:27:35 -0800 (PST)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7788fb06997so17900685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 16:27:35 -0800 (PST)
X-Received: by 2002:a05:6214:19ea:b0:66d:326a:ee4b with SMTP id
 q10-20020a05621419ea00b0066d326aee4bmr3787064qvc.33.1699489654879; Wed, 08
 Nov 2023 16:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
 <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu> <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
 <fe672e31315b8f9c44a693c909d464a299e76093.camel@ndufresne.ca>
 <CAEZL83qR2bDq35yvCV-WvkaL6ZbPvSxQH+j=ViG6Kq8-0Mzq1Q@mail.gmail.com>
 <CANiDSCtDQ9Wg57YzVAJ1o5WQRmy1QPW8td8V2Scc08MmWtOwFg@mail.gmail.com>
 <03ac47742945cc04e4663b87563b47a96ed3ec1f.camel@ndufresne.ca>
 <CANiDSCunRRyod3Rg+L9ZsffOZyC7CKbMVTHX3u-n5iuNyZQk0w@mail.gmail.com> <20231109000327.GE21616@pendragon.ideasonboard.com>
In-Reply-To: <20231109000327.GE21616@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 9 Nov 2023 01:27:23 +0100
X-Gmail-Original-Message-ID: <CANiDSCuD=Z2FVaSnejCfLnRJXUSE99GQkK=4tRAXBbxpUqEVHg@mail.gmail.com>
Message-ID: <CANiDSCuD=Z2FVaSnejCfLnRJXUSE99GQkK=4tRAXBbxpUqEVHg@mail.gmail.com>
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     nicolas@ndufresne.ca, Esker Wong <esker@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Esker Wong <esker@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Thu, 9 Nov 2023 at 01:03, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Wed, Nov 08, 2023 at 11:46:40PM +0100, Ricardo Ribalda wrote:
> > On Wed, 8 Nov 2023 at 21:32, <nicolas@ndufresne.ca> wrote:
> > >
> > > The fact that you interpret the time from FRAME_SYNC to DQBUF (well the
> > > READ IO notification) as the actual latency is yours of course. It
> > > assumes that the camera on the other end does not introduce other
> >
> > We want to use this signal to measure how much power is used since we
> > start receiving the frame until we can use it.
> > I agree with you that the latency between capture and dqbuf should be
> > measured using the timestamp. That is not our use case here.
> >
> > > source of latency (or that these are negligible). You are also going to
> > > introduce a lot of jitter, since it relies on when the OS decides to
> > > wake up your process.
> >
> > We have measured a jitter of around 2.5 msec, which is acceptable for our needs.
> >
> > > I think my opinion resides in if you can accurately *enough* implement
> > > what the spec says for FRAME_SYNC then do it, otherwise just don't lie.
> >
> > What the specs says is:
> > ```
> > Triggered immediately when the reception of a frame has begun
> > ```
> > In my opinion, that is true for usb devices, we are triggering it as
> > soon as the transfer has started to the eyes of the driver. We cannot
> > trigger earlier than that.
> >
> >
> > > I think for ISO, "after the first chunk" i a small lie, but acceptable.
> > > But for BULK, the way it was explained is that it will be always very
> > > close to DQBUF time. and it should not emit FRAME_SYNC for this type of
> > > UVC device. If it fits other events fine of course, I'm just making a
> > > judgment on if its fits V4L2_EVENT_FRAME_SYNC or not.
> >
> > nit: I believe that you have swapped iso and bulk on this description
>
> I've confused the USB packet size and the UVC payload size. The latter
> is typically much bigger for bulk devices than isoc devices, but the
> former will be in similar order of magnitudes in a large number of
> cases, but not all cases.
>
> The URB size is the result of the USB packet size and number of packets
> per URB. The uvcvideo driver currently sets the number of packets per
> URB to 32 at most (and lowers it if the frame size is small, or if not
> enough memory can be allocated). This could be increased or made dynamic
> in the future, as higher speeds typically benefit from larger URB sizes.
> The packet size differs between bulk and isoc endpoints.
>
> For bulk, the packet size can be up to 512 bytes for USB 2.0 and 1024
> bytes for USB 3.0, and the device can select a smaller size. The largest
> URB size (again based on the current implementation of the uvcvideo
> driver) is thus 32 KiB.
>
> For isochronous the situation is more complicated. The term "packet" as
> used in the uvcvideo driver actually means all the data transferred in
> one service interval, thus made of multiple isoc packets. It is heavily
> dependent on the USB speed, and the device can advertise different
> supported sizes (which translate directly to the reserved bandwidth for
> the transfer), with the driver picking the smallest bandwidth large
> enough for the data rate required by the resolution and frame rate. The
> theoretical worst case is 1024 bytes per isoc packet * 16 isoc packets
> per burst * 6 burst per interval * 32 "packets" per URB, equal to 3 MiB.
>
> Even with the largest URB size you have witnessed of ~1 MiB, we will end
> up lying quite a bit if we consider the URB completion callback for the
> first URB of the frame as indicating the start of reception.
>
> > > In term of accuracy, if timestamp was passed with the FRAME_SYNC event,
> > > it would not matter how fast your process the event anymore and greatly
> > > improve accuracy.
> >
> > +1 to that. If we could easily change the uAPI for FRAME_SYNC that
> > should definitely be implemented.
> >
> > > > Not to mention that the UVC timestamping requires a bit of love.
> > > >
> > > > @Laurent Pinchart, @Kieran Bingham  any progress reviewing :P :
> > > > https://patchwork.linuxtv.org/project/linux-media/list/?series=10083
> > >
> > > Thanks for working on this by the way, hope someone will find the time
> > > to review this. The timestamps should in theory provide a jitter free
> >
> > It already has a couple of Reviewed-by stamped in.... ;)
> >
> > > measurement of the delay Esker is trying to measure, and if it wasn't
> > > of bugs (and crazy complexity) it would in the worst case match the
> > > transfer time.
> >
> > Sorry to repeat myself, but just to avoid the confusion: Esker needs
> > to know how much power is used since we start receiving a frame until
> > it is available for dqbuf, not de frame latency.
>
> As I think everybody is aware, the earliest notification you get on the
> CPU side is the *end* of reception of the first URB, which can possibly
> be significantly later than the start of reception of the frame.
>
> Based on what I understand, the goal is to measure the CPU power
> consumption related to CPU processing of the frame. If that's the case,
> there's good and bad news. The good news is that the CPU doesn't process
> the frame at all until the URB has been received (if you were to measure
> the power consumption of the USB host controller too, it would be a
> different story), so the delay shouldn't be a problem. The bad news is
> that I don't see how the information you're trying to get will help you,
> as there's plenty of other things unrelated to the uvcvideo driver that
> can take CPU time while a frame is being received. That may not be any
> of my business, but from the point of view of the uvcvideo driver, I'm
> less inclined to accept a possibly significant V4L2_EVENT_FRAME_SYNC lie
> if the use case ends up making little sense :-)

Just to add some numbers to add some context:

 V4L2_EVENT_FRAME_SYNC for BULK and ISO will be delayed from:
```
Triggered immediately when the reception of a frame has begun
```
one urb.

For bulk devices this is a maximum of 0.05 msec (32KiB/600MBps)
For 1MiB transfer isoc devices (which is the biggest we have seen),
that is 1.8 msec.
In both cases, this is smaller than the jitter to process the event
itself by userspace.

The time from V4L2_EVENT_FRAME_SYNC to DQBUF is around 30 msec.

I do not know how much delay is considered acceptable... but if we
take the delay argument to the extreme, we could say that
V4L2_EVENT_FRAME_SYNC can never be implemented, because the event will
always be delayed by something.

Regards

>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
