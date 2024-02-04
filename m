Return-Path: <linux-kernel+bounces-51592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D038848CFB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7119DB22871
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3E22089;
	Sun,  4 Feb 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WROrUUsb"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28E21364;
	Sun,  4 Feb 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707043992; cv=none; b=V+917TnP0ectAKolVd2UwsUC/peCApB5fToLVJHdq6LGfp3uNYK2Zrpz8esa+jL312AvQ0/KKnsCrPxAYukWWJPFW/zgL50CWj3Dyge6BkxfTXz3wWRF1Ok1YwBu4ltSd0g2k624B7nIrvPUvO/Jp4EgpYqtkREH0p3v+ISNE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707043992; c=relaxed/simple;
	bh=upEribLcp6+Tfi0UR9lL0L23B6NQVSwiCpyWQ95lDXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9Yc8ENJJogCfFomeIgMxFJZD0YbyS5lfUNI11j/n3hAS8KPlDpV6dNRPE25cIIHegwQa628bUzDw78p/iKg+Q25q2hBP1VEyXL9VgJhEQI+9/oZFmBCiePSsAhePisy7tPRLfxhlsHYNCXZda34mwfcJvZECbI+U/2LFPJLIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WROrUUsb; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [109.128.141.99])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A51C9720;
	Sun,  4 Feb 2024 11:51:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707043900;
	bh=upEribLcp6+Tfi0UR9lL0L23B6NQVSwiCpyWQ95lDXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WROrUUsb6wvs8/C7BW++Y7YeAhavpUr0tbYayZh2yzkgBdIvlesejiPAtMxEFsFLX
	 GniaF4qkoxJYd4gnmDZoewVfP3kqpafImtpQOqoT6KaSJUauE/3jaLV6RgZK4ZB6D2
	 0wkIjiNQ7uYaDZeHKBw3gQf+ERS/FX6njdGGPZO8=
Date: Sun, 4 Feb 2024 12:52:27 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
Message-ID: <20240204105227.GB25334@pendragon.ideasonboard.com>
References: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Mon, Jan 08, 2024 at 08:17:46AM +0000, Ricardo Ribalda wrote:
> Logitech Rally Bar devices, despite behaving as UVC cameras, have a
> different power management system that the other cameras from Logitech.
> 
> USB_QUIRK_RESET_RESUME is applied to all the UVC cameras from Logitech
> at the usb core. Unfortunately, USB_QUIRK_RESET_RESUME causes undesired
> USB disconnects, that make them completely unusable.
> 
> Instead of creating a list for this family of devices in the core, let's
> create a quirk in the UVC driver.
> 
> Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
> Cc: stable@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Tested with a Rallybar Mini with an Acer Chromebook Spin 513
> ---
> Changes in v4:
> - Include Logi Rally Bar Huddle (Thanks Kyle!)
> - Link to v3: https://lore.kernel.org/r/20240102-rallybar-v3-1-0ab197ce4aa2@chromium.org
> 
> Changes in v3:
> - Move quirk to uvc driver
> - Link to v2: https://lore.kernel.org/r/20231222-rallybar-v2-1-5849d62a9514@chromium.org
> 
> Changes in v2:
> - Add Fixes tag
> - Add UVC maintainer as Cc
> - Link to v1: https://lore.kernel.org/r/20231222-rallybar-v1-1-82b2a4d3106f@chromium.org
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 30 ++++++++++++++++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 08fcd2ffa727..9663bcac6843 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -14,6 +14,7 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/usb.h>
> +#include <linux/usb/quirks.h>
>  #include <linux/usb/uvc.h>
>  #include <linux/videodev2.h>
>  #include <linux/vmalloc.h>
> @@ -2233,6 +2234,8 @@ static int uvc_probe(struct usb_interface *intf,
>  	}
>  
>  	uvc_dbg(dev, PROBE, "UVC device initialized\n");
> +	if (dev->quirks & UVC_QUIRK_FORCE_RESUME)
> +		udev->quirks &= ~USB_QUIRK_RESET_RESUME;

If you don't mind, I'll move this above the debug message.

>  	usb_enable_autosuspend(udev);
>  	return 0;
>  
> @@ -2574,6 +2577,33 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
> +	/* Logitech Rally Bar Huddle */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x046d,
> +	  .idProduct		= 0x087c,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_RESUME) },
> +	/* Logitech Rally Bar */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x046d,
> +	  .idProduct		= 0x089b,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_RESUME) },
> +	/* Logitech Rally Bar Mini */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x046d,
> +	  .idProduct		= 0x08d3,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_RESUME) },

In an ideal world we would get a list of all devices that require the
reset resume quirk from Logitech, and restrict the quirk to those
devices only in the USB core. In the real world, this seems fine for
now, we'll worry about this approach not scaling when we'll need to make
it scale.

>  	/* Chicony CNF7129 (Asus EEE 100HE) */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 6fb0a78b1b00..fa59a21d2a28 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -73,6 +73,7 @@
>  #define UVC_QUIRK_FORCE_Y8		0x00000800
>  #define UVC_QUIRK_FORCE_BPP		0x00001000
>  #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
> +#define UVC_QUIRK_FORCE_RESUME		0x00004000

Let's name this UVC_QUICK_NO_RESET_RESUME, as that's what the quirk
does.

I'll make these small changes when applying, no need to resend.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  /* Format flags */
>  #define UVC_FMT_FLAG_COMPRESSED		0x00000001
> 

-- 
Regards,

Laurent Pinchart

