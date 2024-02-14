Return-Path: <linux-kernel+bounces-65594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7D854F39
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CF31C22DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00236088E;
	Wed, 14 Feb 2024 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J84/Eufn"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9960DE4;
	Wed, 14 Feb 2024 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929756; cv=none; b=WC9CD/yM/3YHqZN77HXX407U89FCb2iMut8YRAIXY2HwEhwoyTqpRx3us/M6bj3cC1c9OPHs13x7uXY5bYaSu1efdkiNKYi5cb7+GO0Wa79VXPSF8hfeJq7OoK2XkvGhb46pB0EMKm9AG8Vl0bDxGVaYyPWunct3MnFhkmfvO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929756; c=relaxed/simple;
	bh=28RcU4lwkz295jhx6gIvaNWR9iIeT8fEqM27AWQPN4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2SHvKF7QvATNTgPkYjBkMyX9Sb10M8ew1Ne85SNzGcyIHQuepeaRuC1sJeL5VyNgE+jeEOVPaFOr0rgjIRoMXIgBYWeKDs/zvyPjYnGQTEeYHb06tS7YiOgku7YRUP7whGTEixXscv3c2qNc6K269VKY7QPds43aYTKYIRiueo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J84/Eufn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e10746c6f4so946802b3a.2;
        Wed, 14 Feb 2024 08:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707929754; x=1708534554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KLfyq8/5T3mS7ljJcUopjihwTshtzORsDjCfhrNSw/A=;
        b=J84/Eufnkqz5DkQtiJATXk2/nbAlydzABIjpo2cg6QczdKhJv2YPcATalru6VYBwPq
         9ODjARaaPMhByKf1GVsbCju01hcrMpc5i0Ob/lAM3ptrVq+fG4UBjAuZP2eGS83Lc+Vj
         bb0s1amBbE6axGgeeuYInx9CeTg6wiP124jil0/9f42vL3xDh/stBXWhanGAPhvLwr4/
         8jWAjC47AZu7csfEiFOkPj1V4iU64w7B5OU071OR46CxFwguoThtuxtIRPq4V45ESR11
         VMPcTEhceQ8dmZcKrmQL3y3RdQXDxZWG6tZ/1nA2umdJqXVCjU1GaO6Xg3QzLFkwD0R+
         6eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929754; x=1708534554;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLfyq8/5T3mS7ljJcUopjihwTshtzORsDjCfhrNSw/A=;
        b=ENs0zXs/e6XlxkRqCbig9taCduDK1dfnTdo3cym75I0qOy4Uo7/+B3lpF+ljjbScDi
         vfiHlU/PZPras/dFeovjVISbvarxBqWV7GfvaHpDCPzLAu6CpgIkpxbq8ZKlJABjXrmf
         GgYskjfKI5Vav/5+bXffAr+PLAxHBuYvjmLRqrDBQnNeOwSXz3EncFGY0tWao8bS36Mh
         x1cDW1vw3VYdfSqkj/WtwPw/Yw2FdXOgBBiHl/ws+TRp4qbeChN6Cii+pi8Q3B4Gsdb7
         yCIPNQpILNxdYKQiAlVtl/U0nTenweICrXvVGqA+AbSUBThAcRM1PUqW9JEubLzDNQVb
         nnoA==
X-Forwarded-Encrypted: i=1; AJvYcCXrEkgAvTg7wrf13FsyFnG1qeiuCa4C9PvHFII+y21zTrmobXZSzFdif5dSxJS3umRDN4JWi4mVfMQyhCW4AGDZ7sKjeO+zi3qKWY1lN3Nb8tufNCa9ukZ0IDnv6Vkv548ww7EHKFmku7HbGLE=
X-Gm-Message-State: AOJu0Yz6P88EvMUHVE184rcjyizqNgLi1/t5Ea+aQNgaznFCra/VoukM
	kyDHw2uWJxoeX1fzKUS7RSG2g1j6kwWRpO9rtO3XeSzmHL3P1UC9skdbD9Zs
X-Google-Smtp-Source: AGHT+IEkatfF5JLpPHVVtY4h+YwLkm6Mee8XfZNgjJRC8y6gm0QEu5IjqWCzudVP9kt2n8oqjtNLZA==
X-Received: by 2002:a05:6a20:d809:b0:19e:ba40:83e9 with SMTP id iv9-20020a056a20d80900b0019eba4083e9mr4629912pzb.17.1707929754282;
        Wed, 14 Feb 2024 08:55:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5WTPephLx1ySxYzBYBm8cf5YQTRzoFAJPNrUenBKrae9qAC+AM1j7UPdBRoVfeLsKq0bDQFA+a7nfcknPrLtD/1jx5F54HKtpxim6uCc0aZM6BCWTcU8oc8WxKZmKA1TYf25s6XXExib6S6M=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h69-20020a638348000000b005dc491ccdcesm4491093pge.14.2024.02.14.08.55.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 08:55:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a4313c63-73e0-4a38-8d9b-5c5eccf0b5e0@roeck-us.net>
Date: Wed, 14 Feb 2024 08:55:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] watchdog/hpwdt: Support Suspend and Resume
Content-Language: en-US
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240214164941.630775-1-jerry.hoemann@hpe.com>
 <20240214164941.630775-2-jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240214164941.630775-2-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 08:49, Jerry Hoemann wrote:
> Add call backs to support suspend and resume.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 138dc8d8ca3d..ae30e394d176 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -378,11 +378,36 @@ static void hpwdt_exit(struct pci_dev *dev)
>   	pci_disable_device(dev);
>   }
>   
> +static int hpwdt_suspend(struct device *dev)
> +{
> +	if (watchdog_active(&hpwdt_dev))
> +		hpwdt_stop();
> +
> +	return 0;
> +}
> +
> +static int hpwdt_resume(struct device *dev)
> +{
> +	if (watchdog_active(&hpwdt_dev))
> +		hpwdt_start(&hpwdt_dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops hpwdt_pm_ops = {
> +	LATE_SYSTEM_SLEEP_PM_OPS(hpwdt_suspend, hpwdt_resume)
> +};
> +
>   static struct pci_driver hpwdt_driver = {
>   	.name = "hpwdt",
>   	.id_table = hpwdt_devices,
>   	.probe = hpwdt_init_one,
>   	.remove = hpwdt_exit,
> +
> +	.driver = {
> +		.name = "hpwdt",
> +		.pm = &hpwdt_pm_ops,
> +	}
>   };
>   
>   MODULE_AUTHOR("Tom Mingarelli");


