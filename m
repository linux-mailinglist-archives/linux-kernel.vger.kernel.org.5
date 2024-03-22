Return-Path: <linux-kernel+bounces-111163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3EA88688E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FFA284B02
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915218EC0;
	Fri, 22 Mar 2024 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WyYp+XLa"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1C182CF;
	Fri, 22 Mar 2024 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097537; cv=none; b=sqR9jc/QDoE8IpeQ4YJAhq309SfC/5+9Pa9Cjd84V8US9B+1v+KhhOzIr/trRxAyhpFW7qVh6qdElEOmduTqR+UTptVkOKTUSO6hNZJL8dZ1C59oiCf+b/MLMCuWFGvbpOSVCZzEKUphLtMHYQZLa2hi6uhbtw0ofMjns6HVV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097537; c=relaxed/simple;
	bh=lC++plH0G70GB4HvKQWiMMpiVIWxqVnS7uMSp5eqZD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lIpqSUfMWDnNOMw2G2oYMuP8Ep2kz2Jt0EwCVLz2zEAnjJBify0BvS6Q18hxNwoZjtHWWgOxC3exPPOuq07NSD5AB/ZRtAJo7ih7AKZr9UsJSlQuyzOjZ+ID6YVIe9EAru0wtMYtz0lxz+JhSValdMq35zMc9mNVUraKzFBRx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WyYp+XLa; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E3250BEB;
	Fri, 22 Mar 2024 09:51:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711097505;
	bh=lC++plH0G70GB4HvKQWiMMpiVIWxqVnS7uMSp5eqZD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WyYp+XLagBpdHxyGXZ9CKPZa3Za1WRM3dOByUUdSlvNrpAE+oJo1BzxYA8ECuAM2j
	 G0ypJ3lMPezb5m0gfCwNsQoKuiEERvl5rG0kg137z+RNIoB/Ajz1fkRUktwYVEN9AH
	 czvFwBBrHWfrn8WcQJrpLQIh3NvROPYFoUT1K23U=
Date: Fri, 22 Mar 2024 10:52:09 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v9 3/6] media: uvcvideo: Quirk for invalid dev_sof in
 Logitech C922
Message-ID: <20240322085209.GL18799@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-3-55a89f46f6be@chromium.org>
 <20240321234434.GC20938@pendragon.ideasonboard.com>
 <CANiDSCs_dvKwRmws=DoN-YPaTzPeyJQLp0MCUxhRcK-R1T=YSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCs_dvKwRmws=DoN-YPaTzPeyJQLp0MCUxhRcK-R1T=YSA@mail.gmail.com>

On Fri, Mar 22, 2024 at 09:32:56AM +0100, Ricardo Ribalda wrote:
> On Fri, 22 Mar 2024 at 00:44, Laurent Pinchart wrote:
> > On Wed, Mar 15, 2023 at 02:30:14PM +0100, Ricardo Ribalda wrote:
> > > Logitech C922 internal SOF does not increases at a stable rate of 1kHz.
> >
> > The next thing you know they will redefine to value of pi to be 3.
> >
> > > This causes that the device_sof and the host_sof run at different rates,
> > > breaking the clock domain conversion algorithm. Eg:
> > >
> > > 30 (6) [-] none 30 614400 B 21.245557 21.395214 34.133 fps ts mono/SoE
> > > 31 (7) [-] none 31 614400 B 21.275327 21.427246 33.591 fps ts mono/SoE
> > > 32 (0) [-] none 32 614400 B 21.304739 21.459256 34.000 fps ts mono/SoE
> > > 33 (1) [-] none 33 614400 B 21.334324 21.495274 33.801 fps ts mono/SoE
> > > * 34 (2) [-] none 34 614400 B 21.529237 21.527297 5.130 fps ts mono/SoE
> > > * 35 (3) [-] none 35 614400 B 21.649416 21.559306 8.321 fps ts mono/SoE
> > > 36 (4) [-] none 36 614400 B 21.678789 21.595320 34.045 fps ts mono/SoE
> > > ...
> > > 99 (3) [-] none 99 614400 B 23.542226 23.696352 33.541 fps ts mono/SoE
> > > 100 (4) [-] none 100 614400 B 23.571578 23.728404 34.069 fps ts mono/SoE
> > > 101 (5) [-] none 101 614400 B 23.601425 23.760420 33.504 fps ts mono/SoE
> > > * 102 (6) [-] none 102 614400 B 23.798324 23.796428 5.079 fps ts mono/SoE
> > > * 103 (7) [-] none 103 614400 B 23.916271 23.828450 8.478 fps ts mono/SoE
> > > 104 (0) [-] none 104 614400 B 23.945720 23.860479 33.957 fps ts mono/SoE
> > >
> > > Instead of disabling completely the hardware timestamping for such
> > > hardware we take the assumption that the packet handling jitter is
> > > under 2ms and use the host_sof as dev_sof.
> > >
> > > We can think of the UVC hardware clock as a system with a coarse clock
> > > (the SOF) and a fine clock (the PTS). The coarse clock can be replaced
> > > with a clock on the same frequency, if the jitter of such clock is
> > > smaller than its sampling rate. That way we can save some of the
> > > precision of the fine clock.
> > >
> > > To probe this point we have run three experiments on the Logitech C922.
> > > On that experiment we run the camera at 33fps and we analyse the
> > > difference in msec between a frame and its predecessor. If we display
> > > the histogram of that value, a thinner histogram will mean a better
> > > meassurement. The results for:
> > > - original hw timestamp: https://ibb.co/D1HJJ4x
> > > - pure software timestamp: https://ibb.co/QC9MgVK
> > > - modified hw timestamp: https://ibb.co/8s9dBdk
> > >
> > > This bug in the camera firmware has been confirmed by the vendor.
> > >
> > > lsusb -v
> > >
> > > Bus 001 Device 044: ID 046d:085c Logitech, Inc. C922 Pro Stream Webcam
> > > Device Descriptor:
> > >   bLength                18
> > >   bDescriptorType         1
> > >   bcdUSB               2.00
> > >   bDeviceClass          239 Miscellaneous Device
> > >   bDeviceSubClass         2
> > >   bDeviceProtocol         1 Interface Association
> > >   bMaxPacketSize0        64
> > >   idVendor           0x046d Logitech, Inc.
> > >   idProduct          0x085c C922 Pro Stream Webcam
> > >   bcdDevice            0.16
> > >   iManufacturer           0
> > >   iProduct                2 C922 Pro Stream Webcam
> > >   iSerial                 1 80B912DF
> > >   bNumConfigurations      1
> > >
> > > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_driver.c | 9 +++++++++
> > >  drivers/media/usb/uvc/uvc_video.c  | 8 ++++++++
> > >  drivers/media/usb/uvc/uvcvideo.h   | 1 +
> > >  3 files changed, 18 insertions(+)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > index 7aefa76a42b3..678a5736c9df 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -2549,6 +2549,15 @@ static const struct usb_device_id uvc_ids[] = {
> > >         .bInterfaceSubClass   = 1,
> > >         .bInterfaceProtocol   = 0,
> > >         .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
> > > +     /* Logitech HD Pro Webcam C922 */
> > > +     { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> > > +                             | USB_DEVICE_ID_MATCH_INT_INFO,
> > > +       .idVendor             = 0x046d,
> > > +       .idProduct            = 0x085c,
> > > +       .bInterfaceClass      = USB_CLASS_VIDEO,
> > > +       .bInterfaceSubClass   = 1,
> > > +       .bInterfaceProtocol   = 0,
> > > +       .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_INVALID_DEVICE_SOF) },
> > >       /* Chicony CNF7129 (Asus EEE 100HE) */
> > >       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> > >                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > index 1f416c494acc..4d566edb73e7 100644
> > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > @@ -547,6 +547,14 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> > >       stream->clock.last_sof = dev_sof;
> > >
> > >       host_sof = usb_get_current_frame_number(stream->dev->udev);
> > > +
> > > +     /*
> > > +      * On some devices, like the Logitech C922, the device SOF does not run
> > > +      * at a stable rate of 1kHz. For those devices use the host SOF instead.
> >
> > I'm still not very convinced, as without a formal proof I think there's
> > some luck involved, and it may break later. This being said, given that
> > this is gated by a quirk, it won't impact other devices, and we can deal
> > with regressions when they happen. Could we record it here:
> >
> >          * On some devices, like the Logitech C922, the device SOF does not run
> >          * at a stable rate of 1kHz. For those devices use the host SOF instead.
> >          * This improves the timestamp precision in the tests performed so far,
> >          * even if the exact reason hasn't been fully determined.
> >
> > or something along those lines ?
> 
> How does this sound:
> 
>         /*
>          * On some devices, like the Logitech C922, the device SOF does not run
>          * at a stable rate of 1kHz. For those devices use the host SOF instead.
> +        * In the tests performed so far, this improves the timestamp precision.
> +        * This is probably explained by a small packet handling jitter from the
> +        * host, but the exact reason hasn't been fully determined.
>          */

Sounds nicer than my text :-)

> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > > +      */
> > > +     if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
> > > +             dev_sof = host_sof;
> > > +
> > >       time = uvc_video_get_time();
> > >
> > >       /*
> > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > index 9a596c8d894a..07b2fdb80adf 100644
> > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > @@ -73,6 +73,7 @@
> > >  #define UVC_QUIRK_FORCE_Y8           0x00000800
> > >  #define UVC_QUIRK_FORCE_BPP          0x00001000
> > >  #define UVC_QUIRK_WAKE_AUTOSUSPEND   0x00002000
> > > +#define UVC_QUIRK_INVALID_DEVICE_SOF 0x00004000
> > >
> > >  /* Format flags */
> > >  #define UVC_FMT_FLAG_COMPRESSED              0x00000001
> > >

-- 
Regards,

Laurent Pinchart

