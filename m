Return-Path: <linux-kernel+bounces-68168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287508576C0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B421C21707
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E32179AF;
	Fri, 16 Feb 2024 07:21:43 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6717997
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068103; cv=none; b=sIZuAIYTyR0EvXO++cqo43g6TM7v4bscfhGk3pv4Zh4K9gJV3KUp7acSrM/f+Q0WIJ3z30DJeO3HSHVxboE1GgTMQCK4K6C6CE6lxzXuGdO9022fgxBk1xduvp/gnWIrAHbQH96UwiFjfvzWvVovLSRTpvLDRhwI4J8LJryRy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068103; c=relaxed/simple;
	bh=t5qe8+Zhs9ljzhxQTm37IafJwX1YNqurFe+Pb82VJzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iWo1j96NObIr83k9sPpymTLrraDpFtwotDVFoZA/PEEWVzsc4zhkW4odnxURvzSrW7CIM4JvNzdA/BCSfAy8oyJRvAXeNkH20lFIyN3j6bcrpv7Lmq6UWvLbIlBlFpwGEb/hEFSApC4yG6x6v8vCf04EQ+OOBeAJ266/t/HxUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563e6131140so497029a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708068100; x=1708672900;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z64nGsp/rAMsyvZoNvBnG9fsc/X11YU9xalIeEY0Tig=;
        b=q4KJUyqdwPGaP5ceinY2a9tNHL+euagMDec4LAWd8am2RNzFCDL9D+FYGbugMsLFlU
         zEmnXcNb0seqRVr0a1gcqxewHOUZGSq1jz5jkc2qvIS922Q+gSVatGsa4z2ABERD6FgT
         YM4iWWNAiW3Tf1zN5OVm+NVUgOAjXQTiMzlG4slhhb1wrkd9IkVuaZohWMuUyeApRvRu
         ommgP6U4wJZIOjcJXOs8rC8tZMQgkeimwfx5eDbZchS9MyndrVGbELtz4/trtPR/bjZ1
         SRVV31eBb4G/XTBkpY2l5cGgvzU1cctEhuEF7vLYoidZGmVUTNsLc4kBZzaDzrdmZIlv
         SjKg==
X-Forwarded-Encrypted: i=1; AJvYcCXVaSIRXKC8QtgdycIGzxapVRO0e3HpviJpQUtnpeaynNiXYbhXvm3DA58ceLlIgJI53diB6OpRp+ByAbA5bAzvf6Z9GKaKyElC9cYm
X-Gm-Message-State: AOJu0YyPglzpIaEmXMUJzkha52yVCrER63/DKqUpyDwdXvavNkFd5uom
	VzJFSRCIn4Hk9+KKca91n1gMMA3Ggq19EhpZaAiVaYvWPXxHQ3CXC/AeehAd
X-Google-Smtp-Source: AGHT+IEnPSJ90KsRysPhrNmeOgcQj1FbHB+J4C2w7M7l1+Zgu9rngwtSz0o9nKY4coUxpXn9HP7ddw==
X-Received: by 2002:a17:906:c309:b0:a3c:aef1:e01c with SMTP id s9-20020a170906c30900b00a3caef1e01cmr2584601ejz.14.1708068099437;
        Thu, 15 Feb 2024 23:21:39 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id vh2-20020a170907d38200b00a3de6cf49ebsm163571ejc.6.2024.02.15.23.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 23:21:39 -0800 (PST)
Message-ID: <d7743747-1ec2-4557-9f2f-4cffd77284b3@kernel.org>
Date: Fri, 16 Feb 2024 08:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] VT: Add ability to get font requirements
Content-Language: en-US
To: Alexey Gladkov <legion@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1708011391.git.legion@kernel.org>
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
In-Reply-To: <cover.1708011391.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 02. 24, 16:37, Alexey Gladkov wrote:
> We now have KD_FONT_OP_SET_TALL, but in fact such large fonts cannot be
> loaded. No console driver supports tall fonts.

I thought fbcon can, no? If not, we should likely remove all the 
KD_FONT_OP_SET_TALL checks here and there.

> Unfortunately, userspace
> cannot distinguish the lack of support in the driver from errors in the
> font itself. In all cases, EINVAL will be returned.

Yeah, AFAIR userspace just tries many possibilities and sees what trial 
worked.

> How about adding another operator to get the supported font size so that
> userspace can handle this situation correctly?

The whole font interface is horrid (and we got rid of v1 interface only 
recently). Like (ab)using height = vpitch in KD_FONT_OP_SET_TALL :(.

So perhaps, as a band-aid, this might be fine (note you give no 
opportunity to find out supported vpitch for example). Eventually, we 
need to invent a v3 interface with some better font_op struct with 
reserved fields for future use and so on.

> I mean something like this proof-of-concept.
> 
> ---
> 
> Alexey Gladkov (5):
>    VT: Add KD_FONT_OP_GET_INFO operation
>    newport_con: Allow to get max font width and height
>    sticon: Allow to get max font width and height
>    vgacon: Allow to get max font width and height
>    fbcon: Allow to get max font width and height
> 
>   drivers/tty/vt/vt.c                 | 27 +++++++++++++++++++++++++++
>   drivers/tty/vt/vt_ioctl.c           |  2 +-
>   drivers/video/console/newport_con.c | 21 +++++++++++++++++----
>   drivers/video/console/sticon.c      | 21 +++++++++++++++++++--
>   drivers/video/console/vgacon.c      | 17 ++++++++++++++++-
>   drivers/video/fbdev/core/fbcon.c    | 18 +++++++++++++++++-
>   include/linux/console.h             |  1 +
>   include/uapi/linux/kd.h             |  1 +
>   8 files changed, 99 insertions(+), 9 deletions(-)
> 

-- 
js
suse labs


