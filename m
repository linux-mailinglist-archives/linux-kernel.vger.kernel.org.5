Return-Path: <linux-kernel+bounces-89475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0053886F0D8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C25E1F2213C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B21863E;
	Sat,  2 Mar 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFenO2Ss"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA911B277
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709392988; cv=none; b=Pho1u5OXiB49WffrqaakxIzNuXvPt7hYJ9MI9P3znngyr1R2S2bh+HqYLJxDvwxGdTmxfr54g1DdAMiI7R1fJiCvkdbojIHhBQDU/yOpe9klaQA1R+JntT3taEMwxjvJ0i50OvTDf0VPFJPXh3HJuqueLwdga3nTRUEvCzRLe0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709392988; c=relaxed/simple;
	bh=At3koup2VviNDZCVLU1l+Lb3pUdJLRnNtkzTZionXlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nggtL3x2GxCJriwIegKEmju7UNQGhTpR1skBK6RU8L8Y7ZvSqyM5+ARBpsBJVOhDzNlGLUHY0GbRTxyivrhBkDo2BUBkczhMy0NU7plSQKi/CyLRZn2xU3sjA5MOXQFU2yKBStMl40RFf72Iy9yxIPkpAuRlfflB9G1oVP0olwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFenO2Ss; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412d5727c75so2876595e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 07:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709392985; x=1709997785; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7rzo5E+RHg0C/U2GFdAHU5U5qrBuZYlX6RBI4q7dlI=;
        b=aFenO2SsQgXkB8lWDYOYi7nOTnjo4ooZdhjFkqUzBqdMWO7U/MTjFGGnkq5Eabi/yM
         /vkmNw6xqaWY3M3CPXd8hzy3CQ4k+/ARzEudzSO+k0/ted5WKoM0+Bwqdh7hvMq+SWeR
         Bg6gkPBqpjIx3JT7ey/I+T2anXpAFokvtSFq8X2/QaHHC+TdPDN1N9u3bgpmIgCGhkbv
         5BId8UOngcUtNXdWI40YMTZVzcUJX0nahwh45WaYT25iBWzNGnNvFyqFJQHg6nX1mMiR
         8IR4PbvU150BFo24SYKTZsu+u9TdS9BpiOo1KSd8Y/FQe7QCTfeVZfkYneYypFIxjZ5u
         hqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709392985; x=1709997785;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7rzo5E+RHg0C/U2GFdAHU5U5qrBuZYlX6RBI4q7dlI=;
        b=wwkKJyKmzFyT9tRDNcBpehXuqUKDbJ7x6F4JcM3uoX4wTles4TwwkFMQnQV/PssvwW
         JKvkwFacE1IFLz9JUMlUSfvAzMZSF/rIjMbswrMO7k1PI9/cHTgYH4VH4mtq9sN83d+9
         AloazbnhCGBcXfdd4advIVLWy2Dy4+X+CePyUNt7qu8HKMIygs2kWI8ZY1WFEHevQGzX
         PxaxRXbip0nEODyBbd3/PwnimeQSdksZEe7zsjozspD1vbQuvpvDD/eWEYqv7/tylq4M
         LzCFvApKLI+inJEoRbX5/+LgMCRCtFDCfSJk0pCmApmyJRBw/qoxINksq9efsNxEuOeg
         VSNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6e9Ba+IV79WXNXmyWlVoZfAYMtnNIwaAuqA9mkh6uArELm+rPCcS/HMN0S7X/JUcbSKisIVeFlrJE37S2H0Ko4BrBxYL0gi797V6D
X-Gm-Message-State: AOJu0Ywdy7+h2oec2m8NytkVIyJeote1HV3Vp79h7E4ZIuXtNGwp/UgR
	sbU0k3h2RvSrzUvG+lO34w1jdSlYM2xYUUf2qEX+Tz3KhvcBUayu
X-Google-Smtp-Source: AGHT+IF9EsswUNlrC8dO3hIulzO0/nAlfpDfjvuB54ZVatBrhaWcGqVfEjcX2nY29ypVQwZKsWWmYg==
X-Received: by 2002:a05:600c:468a:b0:412:b0d3:62f4 with SMTP id p10-20020a05600c468a00b00412b0d362f4mr3921542wmo.26.1709392984465;
        Sat, 02 Mar 2024 07:23:04 -0800 (PST)
Received: from localhost (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d4583000000b0033b47ee01f1sm7486148wrq.49.2024.03.02.07.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 07:23:04 -0800 (PST)
From: Rui Miguel Silva <rmfrfs@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Mikhail Lobanov
 <m.lobanov@rosalinux.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
In-Reply-To: <7ef732ad-a50f-4cf5-8322-376f42eb051b@moroto.mountain>
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
 <7ef732ad-a50f-4cf5-8322-376f42eb051b@moroto.mountain>
Date: Sat, 02 Mar 2024 15:23:03 +0000
Message-ID: <m3ttlolktk.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Carpenter <dan.carpenter@linaro.org> writes:
Hi Dan,

> On Fri, Mar 01, 2024 at 02:04:24PM -0500, Mikhail Lobanov wrote:
>> Dereference of null pointer in the __gb_lights_flash_brightness_set function.
>> Assigning the channel the result of executing the get_channel_from_mode function
>> without checking for NULL may result in an error.
>
> get_channel_from_mode() can only return NULL when light->channels_count
> is zero.
>
> Although get_channel_from_mode() seems buggy to me.  If it can't
> find the correct mode, it just returns the last channel.  So potentially
> it should be made to return NULL.

Correct, thanks for the fix. Will you or me send a proper patch for
this? Taking also the suggestion from Alex.

Thanks in advance.

Cheers,
   Rui
>
> diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
> index d62f97249aca..acd435f5d25d 100644
> --- a/drivers/staging/greybus/light.c
> +++ b/drivers/staging/greybus/light.c
> @@ -95,15 +95,15 @@ static struct led_classdev *get_channel_cdev(struct gb_channel *channel)
>  static struct gb_channel *get_channel_from_mode(struct gb_light *light,
>  						u32 mode)
>  {
> -	struct gb_channel *channel = NULL;
> +	struct gb_channel *channel;
>  	int i;
>  
>  	for (i = 0; i < light->channels_count; i++) {
>  		channel = &light->channels[i];
>  		if (channel && channel->mode == mode)
> -			break;
> +			return channel;
>  	}
> -	return channel;
> +	return NULL;
>  }
>  
>  static int __gb_lights_flash_intensity_set(struct gb_channel *channel,

