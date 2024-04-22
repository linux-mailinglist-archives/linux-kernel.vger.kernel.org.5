Return-Path: <linux-kernel+bounces-153987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AC48AD5BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FBC3282D13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306941553B8;
	Mon, 22 Apr 2024 20:11:13 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADF1553A3;
	Mon, 22 Apr 2024 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816672; cv=none; b=DQdZD0y5Vma47ej85kAClt7tzea2QH11fXRKYko53BU8qSi+ZdYDjy/dzvH5EoXxh/mhHhAl4tUlI6ncWexL+j8s87Kh1cz6NThdL80mqEbcYBNteYCBJq5yok6XuRZPJ8N+rnydzaii34GgmZrBOB5sLdtbsTeoWE73hnFGW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816672; c=relaxed/simple;
	bh=eudLHhevbRgKy1GmiMEyW4Ix3pXn7T8fj586KMAXp6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVtKUMT7UhMgvxW/7bV+AW6wWkU0oPBHtIcK7g2hRUBU0tfiPESh9G1q6X/KQTfo1LSYXtVH7+vbTNqgAZTjFrKBxdFVFS0Czoe83VeTUbWgOnTBjV+lUq3Dstoudogtr6t05HhHOFZbagYZx1BiSck1ar5869O64goz3fNnuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-419fc79e4dcso13699365e9.1;
        Mon, 22 Apr 2024 13:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816669; x=1714421469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiZH2HuWtN2RM55UIzIoV8b21h1ck/6OdH9T0Un1VM8=;
        b=F6diHPYUQ/Qs8FiTF+WU+szwjzQ+GNnrcj2YRgsEzb2SGBv6KTmCy51j892vmOeYxq
         v1z5hhOFDLae2UQyMsIp2yNopEODpCfBzUgrjr8iNEUZS87sOh+oMol3eXej+9vyyZG9
         Xs4OAVVjxlhm98zD+Ib4wTURjzupMUs33D3Nz39a3Z5M5+7ztx8NJdjhd5nTI7DJXqZg
         toztK+1cPBnXzCohmHFE6dEEr2Uk2pzwnz9eQQCcSlf80oznRJrwSz9EKY73rLADs5Fv
         060AA6On8CGZBx4S/pD/JRv5x7JP4UImmMzD+ws1xZVKuBJPUVjwPwPh/BnATcEeCW6c
         rvHA==
X-Forwarded-Encrypted: i=1; AJvYcCVWvqOUj1XDiScfZEQ+GkAfshNvtc6D3QGl1LeyIPK4fFiAfWEFP4nxe0OE8OYKjHNCL0cF0o+Yyii/yW8LGSrD0/JmzLto+phbSwjClh+hu/NkIXt8ySqezrrhIIFwnK7JXu+4AvcwWObo
X-Gm-Message-State: AOJu0YzrP7ywhFUE04ZsYTX6B8L+S6s4c7KdVT1AO060H+shJ8R9biOz
	T5erhjVibP5L5VSlbmiYsvr51U+Uwbu1oJWGFEg3lvtR+B43CLh2wcJEvVRlvK0=
X-Google-Smtp-Source: AGHT+IG3Gx698bdfIKk4hJj71qjoXNK9mGtBo//5YyWkZYlcdLzvIEqNk0BTcSARnvV+z/2G+kGPjw==
X-Received: by 2002:a05:600c:4ec6:b0:419:e25e:ef62 with SMTP id g6-20020a05600c4ec600b00419e25eef62mr4046133wmq.40.1713816669111;
        Mon, 22 Apr 2024 13:11:09 -0700 (PDT)
Received: from [172.16.1.217] ([80.95.105.245])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b004161af729f4sm17712488wmb.31.2024.04.22.13.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 13:11:08 -0700 (PDT)
Message-ID: <afeae80e-d854-4f38-981e-7e9f414400b7@kernel.org>
Date: Mon, 22 Apr 2024 19:28:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] serial: sc16is7xx: add support for EXAR XR20M1172
 UART
To: "Konstantin P." <ria.freelander@gmail.com>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org,
 lkp@intel.com, vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com,
 nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net,
 ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de,
 Maarten.Brock@sttls.nl, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Lech Perczak <lech.perczak@camlingroup.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240420182223.1153195-1-rilian.la.te@ya.ru>
 <20240420182223.1153195-4-rilian.la.te@ya.ru>
 <7cf31245-b2a1-419c-add6-a6a50a3f3cf1@kernel.org>
 <CAF1WSuwCdonhyzAKX6EeyWAHNX11bV+tgCLJ4vXuEXTAceVvzA@mail.gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <CAF1WSuwCdonhyzAKX6EeyWAHNX11bV+tgCLJ4vXuEXTAceVvzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22. 04. 24, 14:00, Konstantin P. wrote:
> On Mon, Apr 22, 2024 at 9:30 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>
>> On 20. 04. 24, 20:22, Konstantin Pugin wrote:
>>> From: Konstantin Pugin <ria.freelander@gmail.com>
>>>
>>> XR20M1172 register set is mostly compatible with SC16IS762, but it has
>>> a support for additional division rates of UART with special DLD register.
>>> So, add handling this register by appropriate devicetree bindings.
>> ...
>>> --- a/drivers/tty/serial/sc16is7xx.c
>>> +++ b/drivers/tty/serial/sc16is7xx.c
>> ...
>>> @@ -555,18 +578,43 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
>>>        return reg == SC16IS7XX_RHR_REG;
>>>    }
>>>
>>> +static bool sc16is7xx_has_dld(struct device *dev)
>>> +{
>>> +             struct sc16is7xx_port *s = dev_get_drvdata(dev);
>>> +
>>> +             if (s->devtype == &xr20m1172_devtype)
>>> +                     return true;
>>> +             return false;
>>
>> :) so this should simply be:
>>
>> return s->devtype == &xr20m1172_devtype;
>>
> I especially want to avoid this construction, because it will lead to
> idea than we does not have other
> DLD-capable UARTS, which is simply not true, there is, for example,
> XR20M1280 UART, which has roughly the same register set
> (https://www.alldatasheet.com/datasheet-pdf/pdf/445109/EXAR/XR20M1280.html).
> I simply do not have other devices, so I do not
> want to risk sending untested patches upstream.

Sorry, what?

-- 
js
suse labs


