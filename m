Return-Path: <linux-kernel+bounces-74181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F01A885D0D5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7C41C2425F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500D83A1D4;
	Wed, 21 Feb 2024 07:04:11 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7F53399B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499050; cv=none; b=NT1pIHZio4EGnDzKrrNKoyXwUG9Si9dUjsaAhne3y82ghN3/w5HvfjPYR5pryprcv5TgLuAiBDoG8jhyG1RB7uUXmtkNoAkrWXRcTCIKUfo37SV6G/owxreLdZzNqx1/c2GW+gYTWM8c9GinXI5UahZH9RuffTv7WDuLDalUAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499050; c=relaxed/simple;
	bh=t+ysqIz9xYqLLAi9uQIKPYoQfgZu7X32yJfdG6RAKIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvRMUSJ9tR74neb7FUleGJqFCYNVwqcr/e7pXObl8mc2zB68Mh7DJljj4ZJjaG1xhO+UI//r+A2ZPReB4yeplguQaIslIMVDqg5P8HvG8y+qWIz9NUsEpaJcpIULqcD+kws2GvyLR+w97tv0n51mvuA4I55Oih+4QuB8oY5zqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41264c364fbso22974655e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499047; x=1709103847;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/biHpOfQpAXFe/JfX5L5GNgltchzuTbWi/1QjyS6ULk=;
        b=KW0VGTTari4qggPYEQP+943laGLsC/wKz4As2J5d1IfBxt7I4u2DnFOASSjk/kuo/p
         fmurtbUx7+x3lt/JWfhWWxsLfG3ExeJ6mDQeUeG/gIOQ4jKSaKXEXqPmGW1XyzLTB9B8
         KNi8xHlLgMeS5buCuVvYoKqqlraw2tLhNEIIewS+VLnJcqnJ7YuLQZPR6VmcxgS89HUP
         +SI7oiRYM+oLS68Le/RF4ZqQl6116nNpof57tRPkiHsusEZ/D+ug0wCnHY6VYf9mzfXS
         s1GatqTl5KHGUkXRsjFOAubcpDkpGpcnzN4EdoWPGpfChijVaqgRSwIfHvQdhi2EAemU
         /Nhw==
X-Gm-Message-State: AOJu0YxSGktscixFqewSeemPX0Ax111iflsIQHsCLJcF8Qz+BdzvAf5K
	ttjV2/Xm23INjsMH5N4u5vM949J9ve/c0i9sGNb/0DnxvZO1ExHU
X-Google-Smtp-Source: AGHT+IFfkcmauPMuGsVoWK6MuF+KX1UGBqjVVnvWiVZ9Mz9k6UMeW1NMTrBaYeQyB0N82Mrtz5DcIQ==
X-Received: by 2002:a1c:770a:0:b0:411:ea5e:6165 with SMTP id t10-20020a1c770a000000b00411ea5e6165mr13401456wmi.33.1708499047211;
        Tue, 20 Feb 2024 23:04:07 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id dw5-20020a0560000dc500b0033b278cf5fesm15719935wrb.102.2024.02.20.23.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:04:06 -0800 (PST)
Message-ID: <a2c7f1a8-f6e5-4d0b-a98a-93b1d166fab2@kernel.org>
Date: Wed, 21 Feb 2024 08:04:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] VT: Add ability to get font requirements
Content-Language: en-US
To: Alexey Gladkov <legion@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
References: <cover.1708011391.git.legion@kernel.org>
 <d7743747-1ec2-4557-9f2f-4cffd77284b3@kernel.org>
 <Zc9ijvUofv4PCLw_@example.org>
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
In-Reply-To: <Zc9ijvUofv4PCLw_@example.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Cc Thomas (fbdev/fbcon fadeaway -- search SUSE below)

On 16. 02. 24, 14:26, Alexey Gladkov wrote:
> On Fri, Feb 16, 2024 at 08:21:38AM +0100, Jiri Slaby wrote:
>> On 15. 02. 24, 16:37, Alexey Gladkov wrote:
>>> We now have KD_FONT_OP_SET_TALL, but in fact such large fonts cannot be
>>> loaded. No console driver supports tall fonts.
>>
>> I thought fbcon can, no? If not, we should likely remove all the
>> KD_FONT_OP_SET_TALL checks here and there.
> 
> I thought so too until kbd users started trying to use such fonts. A month
> after adding KD_FONT_OP_SET_TALL, support for large fonts was turned off
> in fbcon:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=2b09d5d364986f724f17001ccfe4126b9b43a0be

Hmmm -- it has been a year!

> But I don't think we need to remove KD_FONT_OP_SET_TALL completely. Maybe
> support for large fonts can be fixed.

Either someone needs it so (not necessarily the same) someone fixes it, 
or we remove it.

Note that this whole fbdev is deprecated in favor of (simple)drm. I 
wonder if we want to invest any time to fix this mess at all? Or we 
simply drop the defunct parts now.

I believe SUSE and Fedora (and others very likely too) are currently in 
the process of moving away from fbdev completely at last. I don't know 
the current state, though. Thomas?

>> Eventually, we need to invent a v3 interface with some better font_op
>> struct with reserved fields for future use and so on.
> 
> Yes, yes, yes! Can we discuss this, pleeeeese? :)

You need not discuss at first, propose something ;).

thanks,
-- 
js
suse labs


