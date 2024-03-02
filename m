Return-Path: <linux-kernel+bounces-89471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2358586F0D1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8EC81F221C1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3017C6B;
	Sat,  2 Mar 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS67Z4Pg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D318464
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709392700; cv=none; b=jjzYhTLEzUmgLV9Yo8Ggx4+xzsWetz3YCLSMROCqRtHem8Sd/PvN+HtQWhv8KjQnV5hqxz1GjldZ+xEGjhf+6qY7eBaO8ZC9/3lZmI+1FzdQ2VyhAwiWgPuqNlnPvLy9h4G9fMgSMKyobE0TZixz5BnVSnsjQjOkXJDSLisKgqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709392700; c=relaxed/simple;
	bh=iXFz7A/Is1Avr+n6fjouD8BGhLiy6XGPUswE1I3G+6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LBa0who/9IMtcZv0eQ+KmkibO6QMMNyLr0O5Hd4gaPRydu7vtGbeCnGUWdzoecB13566dAAmPivoWxXxPrQTt/vbk0M0iSdFFEL7kXfh6nW4DJp9WxeFqXpIoN+bFVrsvm8YLOltYOFVD6225q6XSylgqx72716A7hC08yjYWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS67Z4Pg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412bb23e5c5so16724795e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 07:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709392695; x=1709997495; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3tsMku+8+1/N/PLDjGS+jqwA4yTKYJa9xvpuCgVhy4=;
        b=fS67Z4PgIKz1QY8xYpBMHx2z1sM3dMhKRx/aDqxFHbPX4mhfVZ+vc2W2L6A80kFvWC
         D2BNHJiuMj5Qv1i5uPFQBMMIM1d4jqnfiVTfe4mbLEtzGKc9Ebr9/2TYCDfrzADTlEY7
         V2TtnhNmtEXD+X3Z86RCz6GB3p0nDqt3gK9NS1QAkCFTZ3bOWFl6QdpK+pGPHcxS53H0
         vZOMDl+KnPCzoewlagCDlrFTUmVoztWYLa75uJXiC4ETOQ7VUQUvHMxO7wLT6ThsK6VT
         uMlY9Xv4PQM54WJkbLf3WFb4hPNzIuvJLjfIZBrGk8f//Dr7YTB7qtBG5c4tGHSM/hdF
         u4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709392695; x=1709997495;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3tsMku+8+1/N/PLDjGS+jqwA4yTKYJa9xvpuCgVhy4=;
        b=BzJnu5s3b+Rc90XMlI2ByzZBys6ExoWrqAjeFUzFqlo/qNM9k2gXYGFHMWU94K8k7g
         1HsyCaP1p6g2DuoKgwCTIGA4X2xYtJqxJqwIW6UTmERJoXU+sWXH1nbWcm9nB2YyCvfV
         YZDE4G0Kf5PGwg6gjMvMV7XMxqk6mYJUbvlqYGc+BrN77NsPt94+waOcJ06isUfqgtKn
         MhBA1HptT3jzFFMOtwDdIZq6WM6sX6kgV51QcEVM3UrE5S5eYcDurcrzvEVTE97ejq9q
         MtECruNIesAqb9n/e4h3b7QB/kkRRwkDFw4xIvi6Ng9VycCU8FI2BZLc0tyQ/pMZfQWP
         4/Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVt5BFZk1B+HUPUQ0jgRpWiXcICxOUr4gbTPAXQDyOQTeDhF3uMgCekgZDzJIb7n5jh3NJgD+6KMF8YvQWAGvMhjSM3VvHDm3PqWT+O
X-Gm-Message-State: AOJu0YyPBgrhXuCPMs2WuEEK8NnkqRrYc0DwdUB8ULemGcDBWrA9VwUY
	2jKoPBazEOx468mFlzxvYlODOhsNS26OaFcZO2kltsac878KFP7wpE3Hz5PU
X-Google-Smtp-Source: AGHT+IHMGqcaebuU5XjaJPHEn0KuC12L6kxnnC++HraoFBZmu+7GOQj+YVKjoRWrraAtMf/akjrVOw==
X-Received: by 2002:adf:ca8a:0:b0:33e:1505:9463 with SMTP id r10-20020adfca8a000000b0033e15059463mr5508436wrh.13.1709392695236;
        Sat, 02 Mar 2024 07:18:15 -0800 (PST)
Received: from localhost (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
        by smtp.gmail.com with ESMTPSA id p18-20020adf9d92000000b0033e18f5714esm5454212wre.59.2024.03.02.07.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 07:18:14 -0800 (PST)
From: Rui Miguel Silva <rmfrfs@gmail.com>
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
In-Reply-To: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
Date: Sat, 02 Mar 2024 15:18:13 +0000
Message-ID: <m31q8smzm2.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Mikhail,
Thanks for your patch.

Mikhail Lobanov <m.lobanov@rosalinux.ru> writes:

> Dereference of null pointer in the __gb_lights_flash_brightness_set function.
> Assigning the channel the result of executing the get_channel_from_mode function
> without checking for NULL may result in an error.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>

Yeah, at the time when this was implemented I recall that we could only
set the brightness of the torch mode in a flash led, not in the flash
only mode. So, if we were getting here was that for sure we had a torch
channel and get_channel_from_mode will always find a channel, so never
returning null here.

but yeah, this is safer. but maybe just do something like the bellow
would be simpler:
modified   drivers/staging/greybus/light.c
@@ -147,6 +147,9 @@ static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
 		channel = get_channel_from_mode(channel->light,
 						GB_CHANNEL_MODE_TORCH);
 
+	if (!channel)
+		return -EINVAL;
+
 	/* For not flash we need to convert brightness to intensity */
 	intensity = channel->intensity_uA.min +
 			(channel->intensity_uA.step * channel->led->brightness);

what do you think?

Cheers,
    Rui

> ---
>  drivers/staging/greybus/light.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index 87d36948c610..929514350947 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -148,10 +148,15 @@ static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
>  						GB_CHANNEL_MODE_TORCH);
>  
>  	/* For not flash we need to convert brightness to intensity */
> -	intensity = channel->intensity_uA.min +
> +
> +	if (channel) {
> +		intensity = channel->intensity_uA.min +
>  			(channel->intensity_uA.step * channel->led->brightness);
>  
> -	return __gb_lights_flash_intensity_set(channel, intensity);
> +		return __gb_lights_flash_intensity_set(channel, intensity);
> +	}
> +
> +	return 0;
>  }
>  #else
>  static struct gb_channel *get_channel_from_cdev(struct led_classdev *cdev)
> -- 
> 2.43.0

