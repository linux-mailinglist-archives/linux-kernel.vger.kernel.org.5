Return-Path: <linux-kernel+bounces-56671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E65984CD62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D364428FEAC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD00F7E79F;
	Wed,  7 Feb 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbofN7EJ"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498557E77A;
	Wed,  7 Feb 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317745; cv=none; b=rZ6pc5HVtcE8cU/ZG41y+WIRL9jBEL6kSMOX7WOcXPXhKIrkrMXSqVYuwfM6a0nH8aaY1/XOI+1p61LD93eR9iIpHBZlN7jv3krX/eE9tUHuvI8vasZxuQpdhrjAkXSry3zto8LZBJHQoFTG3/CM0bCmGfuTF8EGf61Vc3oCb0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317745; c=relaxed/simple;
	bh=dFzXt6F1DP1HQc6IzaRpp3N2ODJiqnPd7viKv6zYg9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnwStJLel8dJZFXO0ozQLyzr1ScHzGJfYO2Hz1OsLQnzCaEy0ttFha58ZwzMhkDq0SzVNvDi3wTKE9lIIWJ50yxdk8PQh59aMvzu6rAXG+IWrtFDQP+hHuK39sDUw0DoRuRgth/Mx+Fbf0QL+iTgGanvdBDH6IjFn5Wv8oMDxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbofN7EJ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso518982a12.0;
        Wed, 07 Feb 2024 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707317742; x=1707922542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OLfcprqWMh3vfC5AY+Dqj3bm11cgZI+0KaaVLHFjyOM=;
        b=VbofN7EJDVlq/MxwTYlPC5CBC95rT8oZp3cau4XXgUiD6PGOIR45zqc50SdkffE++S
         u83wJ7xeK9qccjoAwbGK/CNZ9L3qqb2v0n/lJ5rwFsZZBwxpPLgzDivyr9sdRrYagG/Y
         z6gBW6zmc2UbNH73bAUi3FWagD4UnOuPHRYYK+UQAPNutT9A9faOQUhyqjazHkY9frQ/
         47YFe+cuMSAuTKBWEosc+WWPce5lpRAlZh4UtwSCU6hZbXafqIOra9vEyTM5wuI8xCf0
         WwymtL3u48I3P4fnrAc/MOJDdmMEGqVVLOJ+BoLOA3LxE6o1iiEGqu37IUZEZ/dlAypY
         HvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317742; x=1707922542;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLfcprqWMh3vfC5AY+Dqj3bm11cgZI+0KaaVLHFjyOM=;
        b=LPkjwi3Smvk9h3uWA/q4bCyqwVfW0i8kV4MxueRnCI8by0febqhIznJd4Ojyr9bXyJ
         715lDpwT2jhgyd26EM+/cvprKcS1ziZx6sY7KVyBLhW5qMaGlZ7bybbbzLX6jxyrm+lP
         4MOUrZFudHjqY/Lme6YIJbfZk9fhHAUmy1riC80VBwhHNXodeRLud+jcmOj/OH7hHTD+
         rjmonQRha7K9AArKtO04zaRlSQZqoSkK/t0HBI3o/QGM194T2zbdX1sAhxRatvFpO8JD
         XB/SQo38EFgp0YzdfBHp5b4hcIHl8rezSA8sGFj/8ZmsBP8hPCuDg9LuEFBwpyWO1gHU
         bGeQ==
X-Gm-Message-State: AOJu0Yyg0OZ/QPzMVBe71/z/b3FUa7HA7bbO+KAgqyDiwpjhxbvd+Bi1
	MtNzacWajXfpAxuhClavXzd8M5/PJD/1rYygvh70ZGcutNu2j9Gi
X-Google-Smtp-Source: AGHT+IHS1LwqpltXj2KnZf2PjS267mAU7l1McZVkpNH3VvQgb/4FXGWsYV1dzdrN8pX1iHn6mNILcg==
X-Received: by 2002:a05:6a20:3944:b0:19e:4aa7:e6ab with SMTP id r4-20020a056a20394400b0019e4aa7e6abmr5399332pzg.47.1707317742344;
        Wed, 07 Feb 2024 06:55:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqN/7RuJlRJY9ebXC4l552VAXhI9t4V8TwwHp9y/fp4XR50d7YstmLiRKbk26conVlCfQYiaY4AFVDXxfOtpCQq+6AW70PI6395BUbBPlGuI7IVQOggMyaIAAm3NfVGwdPf7risgqc8RM7BzSw2mTF7Q5fMTQM1niovGUao2zfAeUdXelRKZbkfIHJNk+uj7Ruo3FGg5Kw
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001d88f0359c1sm1520086plq.278.2024.02.07.06.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 06:55:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <099bc4e3-ec08-4604-90cf-5691a98441b2@roeck-us.net>
Date: Wed, 7 Feb 2024 06:55:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add support for Ayaneo Air Plus 7320u.
Content-Language: en-US
To: Sebastian Kranz <tklightforce@googlemail.com>
Cc: samsagax@gmail.com, derekjohn.clark@gmail.com, jdelvare@suse.com,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240207084206.2204-1-tklightforce@googlemail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240207084206.2204-1-tklightforce@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/7/24 00:42, Sebastian Kranz wrote:
> ---

Patch description missing.

>   drivers/hwmon/oxp-sensors.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index ea9602063eab..8d3b0f86cc57 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -43,6 +43,7 @@ enum oxp_board {
>   	aok_zoe_a1 = 1,
>   	aya_neo_2,
>   	aya_neo_air,
> +	aya_neo_air_plus_mendo,
>   	aya_neo_air_pro,
>   	aya_neo_geek,
>   	oxp_mini_amd,
> @@ -98,6 +99,13 @@ static const struct dmi_system_id dmi_table[] = {
>   		},
>   		.driver_data = (void *)aya_neo_air,
>   	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AB05-Mendocino"),
> +		},
> +		.driver_data = (void *)aya_neo_air_plus_mendo,
> +	},
>   	{
>   		.matches = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> @@ -332,6 +340,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>   			switch (board) {
>   			case aya_neo_2:
>   			case aya_neo_air:
> +			case aya_neo_air_plus_mendo:
>   			case aya_neo_air_pro:
>   			case aya_neo_geek:
>   			case oxp_mini_amd:
> @@ -374,6 +383,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>   			switch (board) {
>   			case aya_neo_2:
>   			case aya_neo_air:
> +			case aya_neo_air_plus_mendo:
>   			case aya_neo_air_pro:
>   			case aya_neo_geek:
>   			case oxp_mini_amd:


