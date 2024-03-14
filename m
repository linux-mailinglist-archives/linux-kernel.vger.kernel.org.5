Return-Path: <linux-kernel+bounces-103322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB4387BE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA872825FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765406F086;
	Thu, 14 Mar 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ1LCZZL"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27776F06D;
	Thu, 14 Mar 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424237; cv=none; b=aKYcgDWOzY10EIwTpJWxgd2rns2wPwgPG4xiEOLTrlT5Xwa320K3Y6OVvkG6xM/tEte5ovmlkSUhDQFbPwZU+YQ245fNWOocIXaG6Da1FKNEUNTPsYGt4eVEPpFTObB8Y4octeUEhVApTUfhXf/7/bZEUubMgpeoLgsxUrzQQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424237; c=relaxed/simple;
	bh=UNpaCeBcqmNNLkvnpntDc2rky0tZJ6yDsYV4YuKGPjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PMASxGgDpaseg9QspLq/KkI/v4iS6xFZ6Pwf88J4TnYWulTUSORpkcBe5hdqTqL6P+jNktW2sfJyln9RsTuMlB1nZSGWjRgRMs+Wi5/Cge8823psu7gOulaQvzxaw/8+CWzv2jZq9nUJCumJHqZJ3fT9kN8qg3mdkFTHOSSNEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ1LCZZL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6ce174d45so573295b3a.3;
        Thu, 14 Mar 2024 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710424235; x=1711029035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vJp1W1BFyCTx9D6QxoVL4qIYyK7cv5fVEs0PxaztKc8=;
        b=OZ1LCZZLlN+N8hsWBbtt+J5W4UhydFWAtZiZEAzTnYatUc9ngrEc0nyMr9CroFrWxU
         iU4RPrCyQhLbvyot2GRYton0z/Cw0M4XJ4GG7bZE70/nkBjkYY2ISDGFid1ef1iHw/Y3
         dAjzmkobuBSSYM6puZi4QrVRgp0idil6Q3Dbl/Wo5gecHiyZoTpd2Qd9orYNf90ZVLpd
         isgy11Iuv+1rEy4u590t4ee9+Zzi8c6BzokISx7Y6AFrXRBML5IdogZ2Dkedg3ar8aEC
         eou8GpfvbSQQVy0dh+GIm50yopt5eqYXZZvWTXfY7CBrAJg4L6d9JLfh3vPvmIHbKkkp
         m5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424235; x=1711029035;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJp1W1BFyCTx9D6QxoVL4qIYyK7cv5fVEs0PxaztKc8=;
        b=gFql1a8W0YoiqHox+VxrDJwEibQ4n5O1HXEGoY0v9ySWdOqiQh0hjLaCh4st6ZbMo8
         tuhoZqSneDfFmeDubnx7HEVYgXCikYh6TmKWj0H9J/4z7TCOk/Hy2yT/6RC+RQdlFpKz
         wcbeqnJtzFCjQeSzcPmjdNgudoRZfOfyMa5aAGV3COumQKaRoQDqMgpSGjTGKUDT5KWW
         2+t77v8JSQvangbhR3sjNtfyflujCE0UDxaBlpuV4otZCL/oWNyOggcUJwTFfuhY80g8
         l46Igwqlp5SpofiXRawbgBrSYLSsamWLNHTKKeVz3IMvObq4wPE3LX91WBOsQi9W2DIz
         MB2A==
X-Forwarded-Encrypted: i=1; AJvYcCXXVj18yaz4irk1+W4xONlgk1YTaNvlknrid4rD/vWWU0ql231hm5Nz4iZVXIESR+gZTl2WOiIPTtP0BIBildPJcdPbYFy2/HtPXmK0ZEWIyyyBd/IN2+M8QKR2hKpXU10j7mJsQ75EPB+y0A0=
X-Gm-Message-State: AOJu0Yx1hUyht9Wy77+wj9/2zAOhrg8EUCdLsBffRaVylCY7S7yEWsSN
	MQfBaJPGIpKF++AIrQXbehVkFIuYxtBPy7qKP/UqiKwxzKZilutq
X-Google-Smtp-Source: AGHT+IFq8jao80Z/Ja9nZTGJGiEkdtmFrTaFi4uMIFzA/6Pv9cSD9FIUcGJ0KTKKK317fxG8FaUKAQ==
X-Received: by 2002:aa7:8881:0:b0:6e6:9fe2:e902 with SMTP id z1-20020aa78881000000b006e69fe2e902mr1931527pfe.20.1710424234932;
        Thu, 14 Mar 2024 06:50:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ks1-20020a056a004b8100b006e6cc458206sm1439506pfb.175.2024.03.14.06.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:50:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <257fa47f-f1de-49ec-9ebf-c33d4de736e1@roeck-us.net>
Date: Thu, 14 Mar 2024 06:50:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drivers: watchdog: ast2600 support bootstatus
Content-Language: en-US
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240314065744.1182701-1-peteryin.openbmc@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240314065744.1182701-1-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 23:57, Peter Yin wrote:
> Add WDIOF_EXTERN1 bootstatus in ast2600
> 

This does a bit more than that because it replaces
WDIOF_CARDRESET with WDIOF_EXTERN1 for ast2600.

> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
> Change log:
> 
> v1
>    - Patch 0001 - Add WDIOF_EXTERN1 bootstatus
> ---
>   drivers/watchdog/aspeed_wdt.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..8adadd394be6 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -81,6 +81,7 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>   #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
>   #define WDT_RESET_MASK1		0x1c
>   #define WDT_RESET_MASK2		0x20
> +#define   WDT_EVENT_COUNTER_MASK       (0xFFF << 8)
>   
>   /*
>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
> @@ -459,8 +460,17 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	}
>   
>   	status = readl(wdt->base + WDT_TIMEOUT_STATUS);/BOOT_SECON
> -	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
> -		wdt->wdd.bootstatus = WDIOF_CARDRESET;
> +
> +	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
> +		if (status & WDT_EVENT_COUNTER_MASK) {
> +			/*
> +			 * Reset cause by WatchDog
> +			 */
> +			wdt->wdd.bootstatus |= WDIOF_EXTERN1;
> +		}
> +	} else {
> +		if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
> +			wdt->wdd.bootstatus = WDIOF_CARDRESET;
>   
>   		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
>   		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))

This check is now unnecessary since it matches the else case.

Either case, it needs to be explained why WDIOF_CARDRESET ("Card previously
reset the CPU") is replaced by WDIOF_EXTERN1 ("External relay 1") for ast2600,
and why WDT_TIMEOUT_STATUS_BOOT_SECONDARY does not apply for ast2600 but
(status & WDT_EVENT_COUNTER_MASK) does.

Guenter


