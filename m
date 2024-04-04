Return-Path: <linux-kernel+bounces-130787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654A0897D1A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E3F1C21318
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2984C9F;
	Thu,  4 Apr 2024 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="f7wE4mZK"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3357492;
	Thu,  4 Apr 2024 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190672; cv=none; b=nSl7bt2ukT72iYg/3PtkEGQmXOv82Ez2/NXDNuxPAb+4ooyGskNtit7ECc8UR3Z9+rsFssXz8/OBr0czQ6ZG1zeoJcVBlqRsc+cbnYY5ickPCLjaH3fRSTcI/amiatXMioqmvDPR4PFf9YXUjnaNOEVi9ns4U1hEW1Zzg/Cp+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190672; c=relaxed/simple;
	bh=AZBccU90Y33RDjvsClTnnyoP7eIFc3Od90wpBG4Bv+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEzB2Zm+8ydcgOhHeKG6LUgO16+F3VPgmm17ZwmY2bUndOJagN/UuLqb5+y4AGvo6M0assRH5/R1FuO8EPjU6ve3NQVcSQTXfAhM/4U1p/BzTf8HqYpTVHf7+n8I/03scjMpFNQCKKmywoP1ZJhv9tvedtjJRr6Ii5SlbjUwLMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=f7wE4mZK; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 384413A3;
	Thu,  4 Apr 2024 02:30:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712190629;
	bh=AZBccU90Y33RDjvsClTnnyoP7eIFc3Od90wpBG4Bv+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7wE4mZKlqguDlnDg7J2uj/iDMoKo8Bz3L4JezNgiM3Og0SM64hPVjMHhdTG/1mY1
	 vN6ITSvQFL7+mM3kX7Kljj3Lem5C2sdQB1GtXpT1DHfLIgR8AQGFTPQF7LLT0VGIlj
	 tG6IlkBmORmRX5YixCc89w/6GZr/+B8KcBwBVau0=
Date: Thu, 4 Apr 2024 03:30:55 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, stable@vger.kernel.org,
	Oliver Neukum <oneukum@suse.com>,
	Devinder Khroad <dkhroad@logitech.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v5] media: ucvideo: Add quirk for Logitech Rally Bar
Message-ID: <20240404003055.GD23803@pendragon.ideasonboard.com>
References: <20240402-rallybar-v5-1-7bdd0fbc51f7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402-rallybar-v5-1-7bdd0fbc51f7@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Tue, Apr 02, 2024 at 12:09:29PM +0000, Ricardo Ribalda wrote:
> Logitech Rally Bar devices, despite behaving as UVC cameras, have a
> different power management system that the other cameras from Logitech.
> 
> USB_QUIRK_RESET_RESUME is applied to all the UVC cameras from Logitech
> at the usb core. Unfortunately, USB_QUIRK_RESET_RESUME causes undesired
> USB disconnects in the Rally Bar that make them completely unusable.
> 
> There is an open discussion about if we should fix this in the core or
> add a quirk in the UVC driver. In order to enable this hardware, let's
> land this patch first, and we can revert it later if there is a
> different conclusion.
> 
> Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
> Cc:  <stable@vger.kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Oliver Neukum <oneukum@suse.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Devinder Khroad <dkhroad@logitech.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Tested with a Rallybar Mini with an Acer Chromebook Spin 513
> ---
> Changes in v5:
> - Update commit message to describe that this is a temp solution.
> - Link to v4: https://lore.kernel.org/r/20240108-rallybar-v4-1-a7450641e41b@chromium.org
> 
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
> index 08fcd2ffa727b..9663bcac68438 100644
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

The quirk isn't really about forcing resume, but about not resetting on
resume. Can we name it UVC_QUIRK_NO_RESET_RESUME ?

> +		udev->quirks &= ~USB_QUIRK_RESET_RESUME;

Let's move this before the uvc_dbg().

With that, the patch looks good to me. I can apply those changes
locally if you don't want to submit a v6.

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
>  	/* Chicony CNF7129 (Asus EEE 100HE) */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 6fb0a78b1b009..fa59a21d2a289 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -73,6 +73,7 @@
>  #define UVC_QUIRK_FORCE_Y8		0x00000800
>  #define UVC_QUIRK_FORCE_BPP		0x00001000
>  #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
> +#define UVC_QUIRK_FORCE_RESUME		0x00004000
>  
>  /* Format flags */
>  #define UVC_FMT_FLAG_COMPRESSED		0x00000001
> 
> ---
> base-commit: c0f65a7c112b3cfa691cead54bcf24d6cc2182b5
> change-id: 20231222-rallybar-19ce0c64d5e6

-- 
Regards,

Laurent Pinchart

