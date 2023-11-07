Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D37E35FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjKGHhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKGHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:37:03 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E4291;
        Mon,  6 Nov 2023 23:36:59 -0800 (PST)
Received: from hillosipuli.retiisi.eu (185-9-10-242.cust.suomicom.net [185.9.10.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SPg5h1PCkz49PxL;
        Tue,  7 Nov 2023 09:36:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1699342616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CXio6HuYjUeexUiBvbvRDGGEBYAaYFY/eSUaGU6FXk=;
        b=tQA7KhcFUgtYt0NJzRMsqtWkO0dydePu5smoe3oeDJFSkSt9XPdG8wKh+jPJg6Oqlc9v89
        lgvXh/2UAFZKsKvvz3dAzaDSGFGAgKGFM24z6yyYwpw5r9FudpOGJgAJx6AqhURe/epdIX
        svoW2hFjlPaImLMczAFMuxDpaM8REpFgkUoSEDZJ1xcdqwq9U3jxsL/n1HN/ILf2J485Dh
        5VXblZBchzS7yeMz9Sn2sUNOWkCQMrbnYRFn6h+qt/S5CQkD0o75KCkPoP8CHK0ICNDGhs
        D+LsibEwNak8kLTT9ud2h7UfnvPaJ7Ce2qwQXNtlrPCWCajgoCKwwJs3NEzY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1699342616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CXio6HuYjUeexUiBvbvRDGGEBYAaYFY/eSUaGU6FXk=;
        b=O6IGIoWjVTwURGQJyhmXYS1HkmY8c9FdRVKtaYPwqbXwyjN3QBJQ6W0ePl9nzL3s75j9gE
        knua+w4UCtmsiKHkkLfzI8/+p9wc68+YjhcBqQ+C7JFw5Rk9Tr/7sB+sESx9rGI8UpnyOC
        9h9egLULqIhDuGcg33bM3fyiDMRmIn5cAgzdZx2xMILKTbmQ7vrtZv9wnJzXKZb5P6TcpE
        1BU/4KRXA5d4j1lXgUFwcXY2cBVQ6WvLxjmKsyQbCzlGM3IeHNOUr7HRLcMX/iqGDavANt
        j00PXwAamk7Ozi2L+DcRrDAFyUtBMPxEyUZOIWn6LR1PerPxtdlPln1Z5kvr9g==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699342616; a=rsa-sha256;
        cv=none;
        b=qN3gfiNBwSRrkR7ElnIx12z9HryilGFvREBlX5svRDmSoTN5lEp4qNJ4Ib1i1yKC8RCIkK
        rV4v2AoJLerqgYgYMKSU9lBeMBgpf5LmNGxjVQyC9HTJTq6wx0yL+pZGAwr/NMDWhm5pkV
        INNCOBzzynoB0OL2j5Og9Ycpb796ybH7eR5gNb1bwqzLN2hsG6lSGOhOmEFFrGRsMrQloi
        nGDRIyN9bu4FbEeCPm5XNOSMC4ThsEHeRdKiPszfqV5tC74PK+np9Oy64u4m7Ww+Kzfv8G
        lGXaRUheSVJB6hFA8R9rlNxsJHs3CN4z+jVKx8f8qemUBwJuy2LVuCGs0H1ZAg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 230BD634C93;
        Tue,  7 Nov 2023 09:36:52 +0200 (EET)
Date:   Tue, 7 Nov 2023 07:36:51 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Esker Wong <esker@chromium.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
Message-ID: <ZUnpE1Wfe2dImqU0@valkosipuli.retiisi.eu>
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
 <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu>
 <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN_q1f_HV7Etb9i2c2_c6Trm2hAJUyd068UskJfMvT=OyiKXpA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esker,

On Tue, Nov 07, 2023 at 01:06:20PM +0800, Esker Wong wrote:
> [send again in text mode]
> Hi Sakari,
> 
> Sequence number is important to us. We need it to measure the latency
> from this event to the time we display the frame.

I think we could also add the sequence number to V4L2_EVENT_VSYNC.

Cc Hans.

> On Mon, Nov 6, 2023 at 7:06 PM Sakari Ailus <sakari.ailus@iki.fi> wrote:
> >
> > Hi Ricardo,
> >
> > On Mon, Nov 06, 2023 at 10:52:27AM +0000, Ricardo Ribalda wrote:
> > > Add support for the frame_sync event, so user-space can become aware
> > > earlier of new frames.
> > >
> > > Suggested-by: Esker Wong <esker@chromium.org>
> > > Tested-by: Esker Wong <esker@chromium.org>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > > We have measured a latency of around 30msecs between frame sync
> > > and dqbuf.
> > > ---
> > > Changes in v2:
> > > - Suggested by Laurent. Split sequence++ and event init.
> > > - Link to v1: https://lore.kernel.org/r/20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org
> > > ---
> > >  drivers/media/usb/uvc/uvc_v4l2.c  | 2 ++
> > >  drivers/media/usb/uvc/uvc_video.c | 7 +++++++
> > >  2 files changed, 9 insertions(+)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > > index f4988f03640a..9f3fb5fd2375 100644
> > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > @@ -1352,6 +1352,8 @@ static int uvc_ioctl_subscribe_event(struct v4l2_fh *fh,
> > >       switch (sub->type) {
> > >       case V4L2_EVENT_CTRL:
> > >               return v4l2_event_subscribe(fh, sub, 0, &uvc_ctrl_sub_ev_ops);
> > > +     case V4L2_EVENT_FRAME_SYNC:
> > > +             return v4l2_event_subscribe(fh, sub, 0, NULL);
> > >       default:
> > >               return -EINVAL;
> > >       }
> > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > index 28dde08ec6c5..4f3a510ca4fe 100644
> > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > @@ -1073,9 +1073,16 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
> > >        * that discontinuous sequence numbers always indicate lost frames.
> > >        */
> > >       if (stream->last_fid != fid) {
> > > +             struct v4l2_event event = {
> > > +                     .type = V4L2_EVENT_FRAME_SYNC,
> > > +             };
> > > +
> > >               stream->sequence++;
> > >               if (stream->sequence)
> > >                       uvc_video_stats_update(stream);
> > > +
> > > +             event.u.frame_sync.frame_sequence = stream->sequence,
> > > +             v4l2_event_queue(&stream->vdev, &event);
> >
> > uvc_video_decode_start() is called when the reception of the entire frame
> > has been completed. However, the documentation for V4L2_EVENT_FRAME_SYNC
> > says that the event is "Triggered immediately when the reception of a frame
> > has begun.". The functionality here doesn't seem to fit to this patch.
> >
> > Wouldn't V4L2_EVENT_VSYNC be a better fit, even if we don't really have a
> > concept of vertical sync in the case of USB? That event doesn't have the
> > sequence though but I guess it's not an issue at least if your case.
> >
> > Another technically correct option could be to create a new event for this
> > but I'm not sure it's worth it.
> >
> > >       }
> > >
> > >       uvc_video_clock_decode(stream, buf, data, len);
> > >
> >
> > --
> > Regards,
> >
> > Sakari Ailus

-- 
Regards,

Sakari Ailus
