Return-Path: <linux-kernel+bounces-117489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F78488ABE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DC2307DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAAD148315;
	Mon, 25 Mar 2024 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0+r5uil"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855FC548E2;
	Mon, 25 Mar 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384900; cv=none; b=CTxJj7OUMegyVf1SyIhYKjS8Rmk16FRqiigQ07NcKXnJXe7qWZMBJsnoFT3mwsROzpKDJ4YyLyrbqE63ZlhHUShzXd4WvRGgW+bgnk9a7DdRP9mCrZ7D7sUJMCcGpZh1WHsGVMiFHArrRGRijgc75Ylyu7I/LSNRmf80XvYpxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384900; c=relaxed/simple;
	bh=K7pUKP7ruGv22mCAhvMDemUvTVp+Ys+fqe4+M130Cqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YckzpVT2K9Lq9IBYHvooyR2YdbrzSGeKg7av8YGJcgtLiwPSTqdvSy3KV2zPSdaEnmP9is+risxzz9qSmUFgEfR+3rvhnsIXhxagTjqzmD8Jz1X0+5cHKfgAugmHPWBTCw1BuOTHorranImK0lYpdXvaUcEvFbQ0KiUJUWUWpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0+r5uil; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dddb160a37so30033355ad.2;
        Mon, 25 Mar 2024 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384898; x=1711989698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4xcp2kkAyO6A68aOUlrkBc3YO7TVrI2D0VIQ7EgPnV0=;
        b=j0+r5uilFJN0ZWd4u9ripug1Xa9bwnGyoEL48GVsS0qmcG35vKexWOhZwALKipLUSl
         3/D4EnpjXSj96R9IEWGrzSH4mdO5B6sXpSUuVDMAoCu35OaSRI3U3QZTdOqI2mJvecL3
         fxSQKTQ8Awipk37QYCueEKnVKa6Ac9KL+fBjuTy8W+d14u4m/bH1xHnOAUuR79shl+Ni
         q0sdcKAoB8XqIdHMnjkuRklyn2K1yqqLe4GtnZwX+WpnudvFUHrAg/q9iH/NE017We7i
         EvucKfcBtzh0VORiodL/B9EwM+/18zsJHqAI9BdcCPlzje5O2M3YruXzL6zRObvuX7ww
         sqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384898; x=1711989698;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xcp2kkAyO6A68aOUlrkBc3YO7TVrI2D0VIQ7EgPnV0=;
        b=N5sbTiY+7nyiIyy/8BOgR3epo8RctCNMzSoMlTfug42c4KHQM5n/xSgGvQx4JK4ed2
         nlmqaXDYyP4tcucVja1eFW74qES9tWnt7WLcjuW7mXWJ80wYcPlHkpePJa+L35jCVHYI
         SuJv9ckMBQ83vbsMf/dok34bFKNwrG3wiQrwWIiiGd3wHfZI8U2ELu4N6Ctf8VMhB2QP
         zCvnOtJ9MnFYrAGupc1Nfxx8ffnF7/fCBva+IGBGrB+x4Ji2R/hsPW9dYw1Aw1E3xa5b
         vZr0Nbhm2jjzkQgTIVFWAkA2KOpQGZD3KLe1ivoHVJmFu9iNgf2URt6yG+COA4k5TOIo
         Xqng==
X-Forwarded-Encrypted: i=1; AJvYcCU8sWE5CszmYqBbJOtbcRqjQ3sfk4y8MNEAEA4x7T20KiKU9d9ZPcSylwl3WzWmfZMp07KNQz0CcV9rBg5zJ3STv0dt/TSbhqRzLlsfy0g+72cQxCZBne6KWVyXnvdcvNIUjZKbIFyi278=
X-Gm-Message-State: AOJu0YwvQOrBAlA0REhkq9LVN1KjztaTBhJovY6Wwe5jiCr966XuoyT5
	gR0+DUhelC/xNFThMiZpwDDPrnwumfGOci+dqPA35/O4y+MO7+qO
X-Google-Smtp-Source: AGHT+IEmm49uHJSX9fejvnEGw5OUbGopQ7EdmZ90GZE4TEpjmZd2PMrNihDh/W+Y69i4sIai6NfDBQ==
X-Received: by 2002:a17:902:e543:b0:1dd:a3d7:dca3 with SMTP id n3-20020a170902e54300b001dda3d7dca3mr10826685plf.11.1711384897823;
        Mon, 25 Mar 2024 09:41:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b001dd7a97a266sm4858839plf.282.2024.03.25.09.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:41:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3c101a6b-1475-4499-8272-46b201cd7819@roeck-us.net>
Date: Mon, 25 Mar 2024 09:41:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] media: uvcvideo: Exit early if there is not
 int_urb
Content-Language: en-US
To: Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Max Staudt <mstaudt@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240325-guenter-mini-v3-0-c4bc61d84e03@chromium.org>
 <20240325-guenter-mini-v3-3-c4bc61d84e03@chromium.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240325-guenter-mini-v3-3-c4bc61d84e03@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 09:31, Ricardo Ribalda wrote:
> If there is no in_urb there is no need to do a clean stop.
> 
Nit: int_urb

Guenter

> Also we avoid calling usb_kill_urb(NULL). It is properly handled by the
> usb framework, but it is not polite.
> 
> Now that we are at it, fix the code style in uvc_status_start() for
> consistency.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>   drivers/media/usb/uvc/uvc_status.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> index ff66482346dde..f644ac7e67427 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -308,7 +308,7 @@ static int _uvc_status_start(struct uvc_device *dev, gfp_t flags)
>   {
>   	lockdep_assert_held(&dev->status_lock);
>   
> -	if (dev->int_urb == NULL)
> +	if (!dev->int_urb)
>   		return 0;
>   
>   	return usb_submit_urb(dev->int_urb, flags);
> @@ -320,6 +320,9 @@ static void _uvc_status_stop(struct uvc_device *dev)
>   
>   	lockdep_assert_held(&dev->status_lock);
>   
> +	if (!dev->int_urb)
> +		return;
> +
>   	/*
>   	 * Prevent the asynchronous control handler from requeing the URB. The
>   	 * barrier is needed so the flush_status change is visible to other
> 


