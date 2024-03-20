Return-Path: <linux-kernel+bounces-109454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1933881970
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 23:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A743728424B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64B85C74;
	Wed, 20 Mar 2024 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R81mH/HH"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A2685935;
	Wed, 20 Mar 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710973201; cv=none; b=rMq/OSV0jPtSJsdmPY8rd/Sh5y/TM3Pg4AqyiUxFOiSjfAMv49nD09rhOEDGYQ5vLYAw+cmm5hjBeASxoIR/ZdVm7vvySkS4/uxC400JjW3qvKj2icHDP0ymT7LaZQg+O5zsLkLkMFXlxfICApZOh1gce7Q+kj4ia1wxGI/IaI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710973201; c=relaxed/simple;
	bh=6NYpIW+dHsze9wkrqNyjaQMh3a3tNreShgHvoIqtj7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3kpblNKoUGBbSmhMnNfUB++r1LWeHFFEH+SsigdPMtLEe0YXQMOUXCIJuAjVUXFgdzubxXgk6GqO4rSgeLxYRld2yQDf0C56pbV1gf+h9oTuq7h5p1I7KoJ63ZoXR9eEjHjyu1YEoY+oR67oX1NTQAdNlA0l04tMxCrvwK0Ucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R81mH/HH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso40114366b.2;
        Wed, 20 Mar 2024 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710973197; x=1711577997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q179WvDu8vP5bQHS0ss2GDd9uf0aLvPHTTRUQdULLWY=;
        b=R81mH/HHz3s/gPw1GLQyEQ/CKvHFJ1toDXWQ2SbclsJBYTSVH2a6RRmm2wDvlIQBox
         JVe/bAH9j1ytxctvfN27xSxddbQM4xXzOLbKB1wjyemyrqlrVX5feu26g5qSB8b00JWi
         WoCCmY8PDaN4F+QMI8laSWZRi5h0FozIfc2ul2/uxE5GWpuTfZSrnwD6DwFrDS18jsuT
         XeD28kAeWzeAOkGa/fgf8Xx6rMv/3dq9c4zqK2BpPER/nmPfXSCMWvDe9SGhfOuJvUtQ
         HQdB5MMguWN99IV7UlGGjV2/+D8Szt8I7r6WpiB5JMUBRZWenxWILbZt0cVQF2CaBZZH
         9O3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710973197; x=1711577997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q179WvDu8vP5bQHS0ss2GDd9uf0aLvPHTTRUQdULLWY=;
        b=KN7hn7Zar08PJd7+PIJaIhxB8grrdxRy6HmM4j4cCGJMgCZ2WlwKDv+AY19HGEQd/h
         71NABhoSdjR+64qls6cKo3Bks9mipyVIYINMj6HUcoyfHjVXPh2VrUqU9NG3IONSX6rf
         jg4ktTXte5phaGZQa+00B5V/lF15WUbYMykNorH9ySwq1fvjWIr7veBeIpcwX2CUvEf9
         BzPiWDEHuGeFduD2sX70xF2gx4rAm/ajQQjxD08juh+AI9tJWgn5I0PZkfU4gcwNWODJ
         mRHZF0zPPfokYXep+UzFRrqiLB/GuugukUYtog9KuNRFSNqUXrVJjXu8fZ23t7sSeIzQ
         JaxA==
X-Forwarded-Encrypted: i=1; AJvYcCWHU0pf1MF+llgcrMEVfXEW7NWcvTNXHSZQOarO/Du8+RKGpzI/UVoJVxPwyJZgXM35hU3IckfwqJWpf6BU9jQkyyFj+SQd/fhStn9y3NrgMpn6eOATRsCpmXY0lanePJoQWxcPsXKilg==
X-Gm-Message-State: AOJu0YzdUncVgVdh8cD0LQ9O3BldJ2jXaP9CXYv9FKQtHU9etMO/KBe/
	Vj4qDy9w1zua38HTTYj0GkVBW5FIquf0gHy/CsOhXkTVONonZH4A
X-Google-Smtp-Source: AGHT+IEJu1NV0z9lDzRQZ643/ZtJs+Bw9f2kQemq86p48B/2QFBYi1CAdlak23QtcZWDePAs0qdz3w==
X-Received: by 2002:a17:906:c08e:b0:a46:3f18:957 with SMTP id f14-20020a170906c08e00b00a463f180957mr131973ejz.36.1710973197303;
        Wed, 20 Mar 2024 15:19:57 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:98be:9474:6233:4b68? (2a02-a466-68ed-1-98be-9474-6233-4b68.fixed6.kpn.net. [2a02:a466:68ed:1:98be:9474:6233:4b68])
        by smtp.gmail.com with ESMTPSA id xj4-20020a170906db0400b00a46aba003eesm5304409ejb.215.2024.03.20.15.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 15:19:56 -0700 (PDT)
Message-ID: <f83d7735-0351-481a-af3a-16137f078058@gmail.com>
Date: Wed, 20 Mar 2024 23:19:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] gpiolib: Fix debug messaging in
 gpiod_find_and_request()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Stephen Boyd <swboyd@chromium.org>,
 Ferry Toth <ftoth@exalondelft.nl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20240320165930.1182653-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <20240320165930.1182653-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

Op 20-03-2024 om 17:58 schreef Andy Shevchenko:
> When consolidating GPIO lookups in ACPI code, the debug messaging
> had been reworked that the user may see
> 
>    [   13.401147] (NULL device *): using ACPI '\_SB.LEDS.led-0' for '(null)' GPIO lookup
>    [   13.401378] gpio gpiochip0: Persistence not supported for GPIO 40
>    [   13.401402] gpio-40 (?): no flags found for (null)
> 
> instead of
> 
>    [   14.182962] gpio gpiochip0: Persistence not supported for GPIO 40
>    [   14.182994] gpio-40 (?): no flags found for gpios
> 
> The '(null)' parts are less informative and likely scare the users.
> Replace them by '(default)' which can point out to the default connection
> IDs, such as 'gpios'.
> 
> While at it, amend other places where con_id is used in the messages.
> 
> Reported-by: Ferry Toth <ftoth@exalondelft.nl>
> Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.c > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: completele reworked solution of
> 20231019173457.2445119-1-andriy.shevchenko@linux.intel.com
>   drivers/gpio/gpiolib.c | 32 ++++++++++++++++++--------------
>   1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e2e583b40207..7d26e5de0b44 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2401,6 +2401,11 @@ char *gpiochip_dup_line_label(struct gpio_chip *gc, unsigned int offset)
>   }
>   EXPORT_SYMBOL_GPL(gpiochip_dup_line_label);
>   
> +static inline const char *function_name_or_default(const char *con_id)
> +{
> +	return con_id ?: "(default)";
> +}
> +
>   /**
>    * gpiochip_request_own_desc - Allow GPIO chip to request its own descriptor
>    * @gc: GPIO chip
> @@ -2429,10 +2434,11 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>   					    enum gpiod_flags dflags)
>   {
>   	struct gpio_desc *desc = gpiochip_get_desc(gc, hwnum);
> +	const char *name = function_name_or_default(label);
>   	int ret;
>   
>   	if (IS_ERR(desc)) {
> -		chip_err(gc, "failed to get GPIO descriptor\n");
> +		chip_err(gc, "failed to get GPIO %s descriptor\n", name);
>   		return desc;
>   	}
>   
> @@ -2442,8 +2448,8 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>   
>   	ret = gpiod_configure_flags(desc, label, lflags, dflags);
>   	if (ret) {
> -		chip_err(gc, "setup of own GPIO %s failed\n", label);
>   		gpiod_free_commit(desc);
> +		chip_err(gc, "setup of own GPIO %s failed\n", name);
>   		return ERR_PTR(ret);
>   	}
>   
> @@ -4157,19 +4163,17 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
>   					      enum gpiod_flags *flags,
>   					      unsigned long *lookupflags)
>   {
> +	const char *name = function_name_or_default(con_id);
>   	struct gpio_desc *desc = ERR_PTR(-ENOENT);
>   
>   	if (is_of_node(fwnode)) {
> -		dev_dbg(consumer, "using DT '%pfw' for '%s' GPIO lookup\n",
> -			fwnode, con_id);
> +		dev_dbg(consumer, "using DT '%pfw' for '%s' GPIO lookup\n", fwnode, name);
>   		desc = of_find_gpio(to_of_node(fwnode), con_id, idx, lookupflags);
>   	} else if (is_acpi_node(fwnode)) {
> -		dev_dbg(consumer, "using ACPI '%pfw' for '%s' GPIO lookup\n",
> -			fwnode, con_id);
> +		dev_dbg(consumer, "using ACPI '%pfw' for '%s' GPIO lookup\n", fwnode, name);
>   		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
>   	} else if (is_software_node(fwnode)) {
> -		dev_dbg(consumer, "using swnode '%pfw' for '%s' GPIO lookup\n",
> -			fwnode, con_id);
> +		dev_dbg(consumer, "using swnode '%pfw' for '%s' GPIO lookup\n", fwnode, name);
>   		desc = swnode_find_gpio(fwnode, con_id, idx, lookupflags);
>   	}
>   
> @@ -4185,6 +4189,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>   					 bool platform_lookup_allowed)
>   {
>   	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
> +	const char *name = function_name_or_default(con_id);
>   	/*
>   	 * scoped_guard() is implemented as a for loop, meaning static
>   	 * analyzers will complain about these two not being initialized.
> @@ -4207,8 +4212,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>   		}
>   
>   		if (IS_ERR(desc)) {
> -			dev_dbg(consumer, "No GPIO consumer %s found\n",
> -				con_id);
> +			dev_dbg(consumer, "No GPIO consumer %s found\n", name);
>   			return desc;
>   		}
>   
> @@ -4230,15 +4234,14 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
>   		 *
>   		 * FIXME: Make this more sane and safe.
>   		 */
> -		dev_info(consumer,
> -			 "nonexclusive access to GPIO for %s\n", con_id);
> +		dev_info(consumer, "nonexclusive access to GPIO for %s\n", name);
>   		return desc;
>   	}
>   
>   	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
>   	if (ret < 0) {
> -		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
>   		gpiod_put(desc);
> +		dev_dbg(consumer, "setup of GPIO %s failed\n", name);
>   		return ERR_PTR(ret);
>   	}
>   
> @@ -4354,6 +4357,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_optional);
>   int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
>   		unsigned long lflags, enum gpiod_flags dflags)
>   {
> +	const char *name = function_name_or_default(con_id);
>   	int ret;
>   
>   	if (lflags & GPIO_ACTIVE_LOW)
> @@ -4397,7 +4401,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
>   
>   	/* No particular flag request, return here... */
>   	if (!(dflags & GPIOD_FLAGS_BIT_DIR_SET)) {
> -		gpiod_dbg(desc, "no flags found for %s\n", con_id);
> +		gpiod_dbg(desc, "no flags found for GPIO %s\n", name);
>   		return 0;
>   	}
>   

Tested-by: Ferry Toth <ftoth@exalondelft.nl> on Intel Edison (mrfld)

