Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FDE7F43F1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjKVKck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKVKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:32:37 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7AD93
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:32:33 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-679dd3055faso16032246d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700649152; x=1701253952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nBpspFpw0wYhl7ifL6tUUdN7tL1Ofok89vNbvxhOgUA=;
        b=k/fsABOxSPGtZ9lKeNf2kxUnOb0eURVdimUOoz6KcneXmcSyOf99Ms2XEenRp93T6g
         QUBeNIIlagZSAhaoA4n+rIjE6qlZzW02bFoa8jYCw+2wnsi4c54KjYyMR2IybZw7EARh
         8pP1/0w/OjN5znOT7xwapcXOf8qto6cXm47cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700649152; x=1701253952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBpspFpw0wYhl7ifL6tUUdN7tL1Ofok89vNbvxhOgUA=;
        b=ZoN8D2iFvg+uD+j6WLXJm0W+clraNFMw/ffNeWLPpc7RdrTS7jusv2ZV7kiWea9W51
         HTiC+uU04/9fwcIQ1cPKRvlO4jpbuL9H/DMkg5oGmq4lQ6XAZLvHtRyZTa8c2kxCq/Gc
         Jv1eFBGHgs91lg5iUMcjSk+gCG9dk2mkvE2ZSHgclyBhfoDoQKLOoGg6i97X+AFDcZB6
         +iCNJ5ow1xYfH2efNpKjKc6HMyZec90D769M5opO7DxviXBU/CGY/oJW36HOw3QgEcAM
         HXrQiv13VJlwX4mVwP2gKX806XWIlKJjOvh5oAQRmUoXnuvAtX77G4sMe+YjEGMiNLc4
         XDnw==
X-Gm-Message-State: AOJu0YzeOfwGa375cyMwdLEnft1CK7VFwGmsA9LyFJT7962IGPhDEzdH
        gnNfCgYYJGm/qKugbaYhCmGsMDyz4QKuulIJCo7+tw==
X-Google-Smtp-Source: AGHT+IE3NjYRfgmnaaLWXQINEsI69f3VB2/BMXk5+IwHaqphPx7ayU+amsialmin311dT6p7TUpmUQ==
X-Received: by 2002:a05:620a:6792:b0:77d:6900:c196 with SMTP id rr18-20020a05620a679200b0077d6900c196mr596612qkn.42.1700649151853;
        Wed, 22 Nov 2023 02:32:31 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id a23-20020a05620a103700b0077580becd52sm4325813qkk.103.2023.11.22.02.32.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 02:32:31 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-679dd3055faso16031656d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 02:32:31 -0800 (PST)
X-Received: by 2002:a05:6214:f27:b0:679:f3b2:ef4c with SMTP id
 iw7-20020a0562140f2700b00679f3b2ef4cmr2086266qvb.38.1700649150941; Wed, 22
 Nov 2023 02:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-2-d8a5eae2312b@chromium.org> <ZV3XDtUKJPuGLhw9@valkosipuli.retiisi.eu>
In-Reply-To: <ZV3XDtUKJPuGLhw9@valkosipuli.retiisi.eu>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 22 Nov 2023 11:32:16 +0100
X-Gmail-Original-Message-ID: <CANiDSCuXXD_GWadSJo43zxscGAOPzxhODK=TKixn0OPn7z_tCw@mail.gmail.com>
Message-ID: <CANiDSCuXXD_GWadSJo43zxscGAOPzxhODK=TKixn0OPn7z_tCw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Do not halt the device after disconnect
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari

On Wed, 22 Nov 2023 at 11:25, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Tue, Nov 21, 2023 at 07:53:49PM +0000, Ricardo Ribalda wrote:
> > usb drivers should not call to any usb_() function after the
> > .disconnect() callback has been triggered.
> >
> > If the camera is streaming, the uvc driver will call usb_set_interface or
> > usb_clear_halt once the device is being released. Let's fix this issue.
> >
> > This is probably not the only driver affected with this kind of bug, but
> > until there is a better way to do it in the core this is the way to
> > solve this issue.
> >
> > When/if a different mechanism is implemented in the core to solve the
> > lifetime of devices we will adopt it in uvc.
> >
> > Trace:
> > [ 1065.389723] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> > [ 1065.390160] drivers/media/usb/uvc/uvc_driver.c:2264 uvc_disconnect exit
> > [ 1065.433956] drivers/media/usb/uvc/uvc_v4l2.c:659 uvc_v4l2_release enter
> > [ 1065.433973] drivers/media/usb/uvc/uvc_video.c:2274 uvc_video_stop_streaming enter
> > [ 1065.434560] drivers/media/usb/uvc/uvc_video.c:2285 uvc_video_stop_streaming exit
> > [ 1065.435154] drivers/media/usb/uvc/uvc_v4l2.c:680 uvc_v4l2_release exit
> > [ 1065.435188] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c |  2 ++
> >  drivers/media/usb/uvc/uvc_video.c  | 45 ++++++++++++++++++++++++--------------
> >  drivers/media/usb/uvc/uvcvideo.h   |  2 ++
> >  3 files changed, 32 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 08fcd2ffa727..413c32867617 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2257,6 +2257,8 @@ static void uvc_disconnect(struct usb_interface *intf)
> >               return;
> >
> >       uvc_unregister_video(dev);
> > +     /* Barrier needed to synchronize with uvc_video_stop_streaming(). */
> > +     smp_store_release(&dev->disconnected, true);
> >       kref_put(&dev->ref, uvc_delete);
> >  }
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 28dde08ec6c5..032b44e45b22 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -2243,28 +2243,39 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
> >       return ret;
> >  }
> >
> > -void uvc_video_stop_streaming(struct uvc_streaming *stream)
> > +static void uvc_video_halt(struct uvc_streaming *stream)
> >  {
> > -     uvc_video_stop_transfer(stream, 1);
> > +     unsigned int epnum;
> > +     unsigned int pipe;
> > +     unsigned int dir;
> >
> >       if (stream->intf->num_altsetting > 1) {
>
> Doesn't this imply the device is using isochronous mode?

I haven't changed the behaviour for halt, it is just that git diff is
being a bit too creative here:

Basically it is doing:

void video_halt() {
   if (is_isoc()) {
     usb_set_interface(stream->dev->udev, stream->intfnum, 0);
     return;
   }
   usb_clear_halt();
}

instead of the old:

void video_halt() {
   if (is_isoc()) {
     usb_set_interface(stream->dev->udev, stream->intfnum, 0);
   }  else {
      usb_clear_halt();
   }
}

Thanks!
>
> >               usb_set_interface(stream->dev->udev, stream->intfnum, 0);
> > -     } else {
> > -             /*
> > -              * UVC doesn't specify how to inform a bulk-based device
> > -              * when the video stream is stopped. Windows sends a
> > -              * CLEAR_FEATURE(HALT) request to the video streaming
> > -              * bulk endpoint, mimic the same behaviour.
> > -              */
> > -             unsigned int epnum = stream->header.bEndpointAddress
> > -                                & USB_ENDPOINT_NUMBER_MASK;
> > -             unsigned int dir = stream->header.bEndpointAddress
> > -                              & USB_ENDPOINT_DIR_MASK;
> > -             unsigned int pipe;
> > -
> > -             pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> > -             usb_clear_halt(stream->dev->udev, pipe);
> > +             return;
> >       }
> >
> > +     /*
> > +      * UVC doesn't specify how to inform a bulk-based device
>
> Then this comment doesn't look right. What about the code? This isn't
> mentioned in the commit message either.
>
> > +      * when the video stream is stopped. Windows sends a
> > +      * CLEAR_FEATURE(HALT) request to the video streaming
> > +      * bulk endpoint, mimic the same behaviour.
> > +      */
> > +     epnum = stream->header.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
> > +     dir = stream->header.bEndpointAddress & USB_ENDPOINT_DIR_MASK;
> > +     pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> > +     usb_clear_halt(stream->dev->udev, pipe);
> > +}
> > +
> > +void uvc_video_stop_streaming(struct uvc_streaming *stream)
> > +{
> > +     uvc_video_stop_transfer(stream, 1);
> > +
> > +     /*
> > +      * Barrier needed to synchronize with uvc_disconnect().
> > +      * We cannot call usb_* functions on a disconnected USB device.
> > +      */
> > +     if (!smp_load_acquire(&stream->dev->disconnected))
> > +             uvc_video_halt(stream);
> > +
> >       uvc_video_clock_cleanup(stream);
> >  }
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 6fb0a78b1b00..4318ce8e31db 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -559,6 +559,8 @@ struct uvc_device {
> >       unsigned int users;
> >       atomic_t nmappings;
> >
> > +     bool disconnected;
> > +
> >       /* Video control interface */
> >  #ifdef CONFIG_MEDIA_CONTROLLER
> >       struct media_device mdev;
> >
>
> --
> Kind regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda
