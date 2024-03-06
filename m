Return-Path: <linux-kernel+bounces-94154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920B6873AAA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B8D1F24F5C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD681350EC;
	Wed,  6 Mar 2024 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="UrWWlrbW"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BA12FF88
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738975; cv=none; b=av1QG4OJemXcedtWx5IaZ1tofTmWd+l3EZ9eKPsas3nvVeGz2iIhcPSRzI1NYaPGLkykDLsSXVQvVkfTTOzFmIaL7Npk6nyndJfF1GZ2IlSWETmCTuTZ9naD0qzHvdD4RnHHOkJQ917UGKIWhQwbu6TnWdTOVzLRqMsNCQcO67Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738975; c=relaxed/simple;
	bh=C3Sx1OdAp4WBlmh0QlBwjLKQijGxkG87lxhH+y5+Gwg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SLAKpJOEq9BphzxA0hUodmXyiGUHVP/h6hji8H262bASgqRLq3aqKqbMxlQhwRJh25z9oB7YbnJ+QrKEUEXnIWYWEllXUED3ait7hV8Ewn9pSfWkITfK48T9IPaXb9G3OUHaAYdLMFTC/l0CTlLMvPq8211UY9Hn69X68fPgpdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=UrWWlrbW; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id C0B0DD9A062B0;
	Wed,  6 Mar 2024 18:29:18 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id h34VE-gmfcRS; Wed,  6 Mar 2024 18:29:18 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 8D6B2D9A062AE;
	Wed,  6 Mar 2024 18:29:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 8D6B2D9A062AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1709738958;
	bh=s2MDr7WOywlnh3ZAqvGnB0f57zkYihv9+BGZBbec/V0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=UrWWlrbWKlytDmLbBBNNhl+k6fSFAIvdRV2gP7OZCgpLaPjwXRM448CNRUpgvF+MG
	 MEv+wD6NtY9q1zqEyFTKMiKATrPBH5mGxqSOLs3nZFLijUY119OGY0L4QG5sOWuBEg
	 4qZpcoVVZAB7GkRh85KXFSYGY1nTb0hIEGTNjfqyDLujq6meOa8G8oMvSTDGYyuKv1
	 OV32qZ/xX3UN9QICY/mASUt5m1PQXZHS6O9p9Tsyt3PDRG+lPZo017rm58UpOsWqU0
	 9G3g788SDktPgsPLrY7cG+18Jkeq3YQxHJdO1NLbGu7yUQXyyuITTd5NPA1PV2KMMl
	 tYkpJh4imxopQ==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SV61K1I6DtiF; Wed,  6 Mar 2024 18:29:18 +0300 (MSK)
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	by mail.rosalinux.ru (Postfix) with ESMTP id 577D8D9A062B0;
	Wed,  6 Mar 2024 18:29:18 +0300 (MSK)
Date: Wed, 6 Mar 2024 18:29:18 +0300 (MSK)
From: =?utf-8?B?0JzQuNGF0LDQuNC7INCb0L7QsdCw0L3QvtCy?= <m.lobanov@rosalinux.ru>
To: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	greybus-dev@lists.linaro.org
Message-ID: <263695481.5978842.1709738958259.JavaMail.zimbra@rosalinux.ru>
In-Reply-To: <m38r2v67h8.fsf@gmail.com>
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru> <m38r2v67h8.fsf@gmail.com>
Subject: Re: [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - GC120 (Win)/8.8.12_GA_3794)
Thread-Topic: greybus: Fix deref of NULL in __gb_lights_flash_brightness_set
Thread-Index: aWEJxOWeV+AJ+gus/QAqbWALvD0cYw==


Hi Rui, if you can, please prepare a patch with my reported-by tag.
Thanks!

Yours sincerely, Mikhail!

>Hi Mikhail,
>Mikhail Lobanov <m.lobanov@rosalinux.ru> writes:
>
>
>Are you sending a new version with the changes suggested in this thread?
>or do you want me to prepare something with your reported-by tag?
>
>Cheers,
>    Rui

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

