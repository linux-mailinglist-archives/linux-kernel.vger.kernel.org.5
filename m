Return-Path: <linux-kernel+bounces-64781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B688542C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C331B1F26E80
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8A10A35;
	Wed, 14 Feb 2024 06:25:17 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A810A0F;
	Wed, 14 Feb 2024 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707891917; cv=none; b=R9buTf9pn8uv7utW9Y7bIsgJJCdpqlbC57Uu2vB6Aw9hWPsA7d5PtKnMdJyQtVq+2vWnFQb2crH3ivwi+aX8bk8/WG27iNs3OQN4YZ6bBPO+vFt5wLxeL8xuqCD9OaPswoLeeo1I4Y3RWK6yYfOY+bTDg+rgVIc1Nu3cmZ2nQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707891917; c=relaxed/simple;
	bh=qRwnr33xb+LQtMbjNmu6bSjYJ/2tQsFjrG/Eg42t9J4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EehYhtQOl88hBgKcuuD39uq6aQ9THPQRscK2mXDyaR0CSNuv7EoAohXIS0tAwd6MlRb213P/G0MFi8rhkipRJUupozV21vWEny8wFNT8b38jLobg36uZ5ZyF/OI6mEILngPxYMbcwPnWc6HzvmXPwsrdd1pzvICnFpgd5Hu3eiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55fcceb5f34so5953291a12.3;
        Tue, 13 Feb 2024 22:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707891913; x=1708496713;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0++smij7fLXWfkbGHyYXuskvQ10t4OERK+LGxTM1+U=;
        b=vvRI0bbMyUhknnqIYplm8HLhItEtNoSmrCtJWCuTvXD2wuIXqpeKf7Ie3Gx9HnyZWj
         NS7HczCWUfuiLvLTc+NF30x4jcHCmN+HGH+mmNXVH9j1Ow2GLc8JBkdmm8YXPlbYa5WB
         nyiTFqLvY5bD7zkzJgJ+9+aJJnxKoCkO60Jysxax9LGOZjf393V0IGgMmVzJeMR0d6M/
         24WgEvifYrawUgorPnF2swN86quAE6x14msWt9wJjrzFUBFDlBfG+eBfRIUMn3dm4bMv
         YBBXRaixTCfH93gPn/ootHl5VQjWDuShtHAfD/x45o47MU3kQY8tJzREj2I47ysVDbY3
         77CA==
X-Forwarded-Encrypted: i=1; AJvYcCXU1BjKfBWESXpnPKUM5P/mAY03qc1WrhlsbsA8KKzx7HNg8OutEVaAPYKg8BZ0GnKxA9dSrYPfKlOEwnnwLjRPfJ9a1+ngW19XIJVRAp67d9eaS9oZl26muXuiN5kv9fAnmAaFYNHbYXs6
X-Gm-Message-State: AOJu0YwhA485D8KQDBUrSJGxley4HtAtt1zdJuj7dAMOwIatdzeINhW7
	vGSumT3oZTGjGp8enAbLcExvFrPkrJ0jISslk2fJnEq/5UFFB/f6sJSWMtru
X-Google-Smtp-Source: AGHT+IEcu8iPcIlJEhmy2BuFw0/RZ4f/wLAZ9lBUEihrZV7jl66i5n1IixzmKHDCAdWfQuTMtGYY2Q==
X-Received: by 2002:a17:906:1997:b0:a3c:8a78:af7b with SMTP id g23-20020a170906199700b00a3c8a78af7bmr914349ejd.74.1707891912323;
        Tue, 13 Feb 2024 22:25:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWjYv9+rzwOO0f16zW8meX4an9BbrmJjRSnvod6iD+4DhogFHKrZZuQqCcU9f08PmZvhO1+dJGaLkPmxox88u9kfgbEA3sHIbp0U/hmHGr94I5pW/sBYxAo/SG41AH6janGJAqGzSp0cfOghg1YKHwZdSdSmA+SyjF2ixGViPNnape5NayLp8lBxgzL5Bjw4Dag2Txw1qCWIxuOOpPnSGLqBs/SaH3ePyKcR7GtueNmo1uox9XOe4Z63GwfCSGUknRnqOY9ui1uklzhyq7WdUS6ALaQpN7JA6gWjwvUz1oLjUeMpgAFF7CBuA8xI9z9lTKmu0Qcp5WVfzojXXM/AOarRNEWP12qL/gXIoyec/hIjA=
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906115200b00a3d310a2684sm526639eja.158.2024.02.13.22.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 22:25:11 -0800 (PST)
Message-ID: <7b9afb8f-6642-4921-a92a-90c9074a48b7@kernel.org>
Date: Wed, 14 Feb 2024 07:25:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: hvc-iucv: fix function pointer casts
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, llvm@lists.linux.dev
References: <20240213101756.461701-1-arnd@kernel.org>
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
In-Reply-To: <20240213101756.461701-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13. 02. 24, 11:17, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang warns about explicitly casting between incompatible function
> pointers:
> 
> drivers/tty/hvc/hvc_iucv.c:1100:23: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   1100 |         priv->dev->release = (void (*)(struct device *)) kfree;
>        |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add a separate function to handle this correctly.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
> index fdecc0d63731..b1149bc62ca1 100644
> --- a/drivers/tty/hvc/hvc_iucv.c
> +++ b/drivers/tty/hvc/hvc_iucv.c
> @@ -1035,6 +1035,10 @@ static const struct attribute_group *hvc_iucv_dev_attr_groups[] = {
>   	NULL,
>   };
>   
> +static void hvc_iucv_free(struct device *data)
> +{
> +	kfree(data);
> +}
>   
>   /**
>    * hvc_iucv_alloc() - Allocates a new struct hvc_iucv_private instance
> @@ -1097,7 +1101,7 @@ static int __init hvc_iucv_alloc(int id, unsigned int is_console)
>   	priv->dev->bus = &iucv_bus;
>   	priv->dev->parent = iucv_root;
>   	priv->dev->groups = hvc_iucv_dev_attr_groups;
> -	priv->dev->release = (void (*)(struct device *)) kfree;
> +	priv->dev->release = hvc_iucv_free;
>   	rc = device_register(priv->dev);
>   	if (rc) {
>   		put_device(priv->dev);

-- 
js
suse labs


