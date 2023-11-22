Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1D7F43BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbjKVKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjKVKZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:25:28 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF7D4F;
        Wed, 22 Nov 2023 02:25:24 -0800 (PST)
Received: from hillosipuli.retiisi.eu (185-9-10-242.cust.suomicom.net [185.9.10.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SZy762YBCz49Q5M;
        Wed, 22 Nov 2023 12:25:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1700648722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jloNRvYuaaF2FKShhuxL+B4kWjy4TZNLsSyG0DAi95o=;
        b=KmYYMrVeVcPWgXg9W+/diTJe8ILYaWohSX/YrCLzUFm5NAsmh7V0qOWxfRN36zC9h3hNaz
        agq9Ez8eTL/7QmmP3pO2DCTymPHB6WCHmoi/w8uDyJLBy2LRhDoHZ9bQdE6ARo+fPR1FGc
        omfj2RRi8MC46kRDpEuPDZQ+FcyNwZ/HEU21xIUVqJBNeifD29KSZ5hhigLWwuaueiGyCU
        5Myk+8NuhpXK7QJkv9MdahI/RV2HbVzwOddIiVDipNvGtePXpwjGduH4nwcsQb7O3ebbC8
        ZYx2SOksrWP4iiaAds0nEx1bWMH4fWrAkIxzhd1cnWgObltPjN9hBWGbsyBCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1700648722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jloNRvYuaaF2FKShhuxL+B4kWjy4TZNLsSyG0DAi95o=;
        b=qYSm/k/mYGB687/E/ZMumXgcDXnas7DohVSOYhsDnzZFdREMCqoqWWCBhq8INVWgbaQ3Ci
        JmHKfShctamhJ8xruW5fAh9XzGd6nBvxGOEwa6o7KPUDceVMJZW0ec7x1p+fKNZc55mb0p
        ApUJoH5Fi8dY8iXWBZWybwDSXlu2RR1lsP7b9pJ4PiwH12L5cvv6hWMd9VJHKaKmjny6+/
        EYIhgVIvX4jDF2ugXZqFfhToyhuwaLnQoFndKQeCco4u9nMDofUE/+BeLrEizEfcn1eFjc
        fdKZvNl/n1rMuz/MFwgTa+5dnOddvHfxWZ8qLhW3R/ear4e2zIdKJhoDD6g5aQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1700648722; a=rsa-sha256;
        cv=none;
        b=iGdaTXLqCo9CVVvaw9/N+0RDCVC/qjOTahXeRSRjZEqYO6EerCRylv6RMMv6Wi9lXJuW7i
        J7cz3/rM5tBJyXtL40Rrm/wrCXvj9TjbFe0IPjI8TX1992B0oAjar4f2JiJ2ExaY4TJAdd
        ugC5qZE/7Y19zpbVa2nyIqZ55EyxLQ/+nWXziUoqwEb34BIWNG4hq86Y9E7af5klU/OucN
        cXamDPTtUzOsTdBV28DjOl4W5LtXVQcfELxqNa7Su+hSFH486JCJzPNdWjaa6Qi1ztDzd3
        sVmPXsSDFCXA7j4xn4aQ2+FCW9NVNfcuRMuGnObgXprb3kzqqOXmc0/VBsQ8qA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 6F143634C93;
        Wed, 22 Nov 2023 12:25:18 +0200 (EET)
Date:   Wed, 22 Nov 2023 10:25:18 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Do not halt the device after
 disconnect
Message-ID: <ZV3XDtUKJPuGLhw9@valkosipuli.retiisi.eu>
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-2-d8a5eae2312b@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-guenter-mini-v3-2-d8a5eae2312b@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Tue, Nov 21, 2023 at 07:53:49PM +0000, Ricardo Ribalda wrote:
> usb drivers should not call to any usb_() function after the
> .disconnect() callback has been triggered.
> 
> If the camera is streaming, the uvc driver will call usb_set_interface or
> usb_clear_halt once the device is being released. Let's fix this issue.
> 
> This is probably not the only driver affected with this kind of bug, but
> until there is a better way to do it in the core this is the way to
> solve this issue.
> 
> When/if a different mechanism is implemented in the core to solve the
> lifetime of devices we will adopt it in uvc.
> 
> Trace:
> [ 1065.389723] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> [ 1065.390160] drivers/media/usb/uvc/uvc_driver.c:2264 uvc_disconnect exit
> [ 1065.433956] drivers/media/usb/uvc/uvc_v4l2.c:659 uvc_v4l2_release enter
> [ 1065.433973] drivers/media/usb/uvc/uvc_video.c:2274 uvc_video_stop_streaming enter
> [ 1065.434560] drivers/media/usb/uvc/uvc_video.c:2285 uvc_video_stop_streaming exit
> [ 1065.435154] drivers/media/usb/uvc/uvc_v4l2.c:680 uvc_v4l2_release exit
> [ 1065.435188] drivers/media/usb/uvc/uvc_driver.c:2248 uvc_disconnect enter
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c |  2 ++
>  drivers/media/usb/uvc/uvc_video.c  | 45 ++++++++++++++++++++++++--------------
>  drivers/media/usb/uvc/uvcvideo.h   |  2 ++
>  3 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 08fcd2ffa727..413c32867617 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2257,6 +2257,8 @@ static void uvc_disconnect(struct usb_interface *intf)
>  		return;
>  
>  	uvc_unregister_video(dev);
> +	/* Barrier needed to synchronize with uvc_video_stop_streaming(). */
> +	smp_store_release(&dev->disconnected, true);
>  	kref_put(&dev->ref, uvc_delete);
>  }
>  
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 28dde08ec6c5..032b44e45b22 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -2243,28 +2243,39 @@ int uvc_video_start_streaming(struct uvc_streaming *stream)
>  	return ret;
>  }
>  
> -void uvc_video_stop_streaming(struct uvc_streaming *stream)
> +static void uvc_video_halt(struct uvc_streaming *stream)
>  {
> -	uvc_video_stop_transfer(stream, 1);
> +	unsigned int epnum;
> +	unsigned int pipe;
> +	unsigned int dir;
>  
>  	if (stream->intf->num_altsetting > 1) {

Doesn't this imply the device is using isochronous mode?

>  		usb_set_interface(stream->dev->udev, stream->intfnum, 0);
> -	} else {
> -		/*
> -		 * UVC doesn't specify how to inform a bulk-based device
> -		 * when the video stream is stopped. Windows sends a
> -		 * CLEAR_FEATURE(HALT) request to the video streaming
> -		 * bulk endpoint, mimic the same behaviour.
> -		 */
> -		unsigned int epnum = stream->header.bEndpointAddress
> -				   & USB_ENDPOINT_NUMBER_MASK;
> -		unsigned int dir = stream->header.bEndpointAddress
> -				 & USB_ENDPOINT_DIR_MASK;
> -		unsigned int pipe;
> -
> -		pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> -		usb_clear_halt(stream->dev->udev, pipe);
> +		return;
>  	}
>  
> +	/*
> +	 * UVC doesn't specify how to inform a bulk-based device

Then this comment doesn't look right. What about the code? This isn't
mentioned in the commit message either.

> +	 * when the video stream is stopped. Windows sends a
> +	 * CLEAR_FEATURE(HALT) request to the video streaming
> +	 * bulk endpoint, mimic the same behaviour.
> +	 */
> +	epnum = stream->header.bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
> +	dir = stream->header.bEndpointAddress & USB_ENDPOINT_DIR_MASK;
> +	pipe = usb_sndbulkpipe(stream->dev->udev, epnum) | dir;
> +	usb_clear_halt(stream->dev->udev, pipe);
> +}
> +
> +void uvc_video_stop_streaming(struct uvc_streaming *stream)
> +{
> +	uvc_video_stop_transfer(stream, 1);
> +
> +	/*
> +	 * Barrier needed to synchronize with uvc_disconnect().
> +	 * We cannot call usb_* functions on a disconnected USB device.
> +	 */
> +	if (!smp_load_acquire(&stream->dev->disconnected))
> +		uvc_video_halt(stream);
> +
>  	uvc_video_clock_cleanup(stream);
>  }
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 6fb0a78b1b00..4318ce8e31db 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -559,6 +559,8 @@ struct uvc_device {
>  	unsigned int users;
>  	atomic_t nmappings;
>  
> +	bool disconnected;
> +
>  	/* Video control interface */
>  #ifdef CONFIG_MEDIA_CONTROLLER
>  	struct media_device mdev;
> 

-- 
Kind regards,

Sakari Ailus
