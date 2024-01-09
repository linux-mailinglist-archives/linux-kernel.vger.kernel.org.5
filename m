Return-Path: <linux-kernel+bounces-20437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A83827EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448E52857C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EFE8F4F;
	Tue,  9 Jan 2024 06:54:22 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7879C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2821884a09so197504166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 22:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704783259; x=1705388059;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNu0l7wv0H4Otda2UdlBRHEV1qb2KydpoX/ptjG0Mqw=;
        b=v1DKfTxmzdAq7ZGrg2sIhDJ2mHFZUldXljbfHtcRB2BufvLmNfcQUfp0BjdPAY+yHB
         TzIgQPffQ5glKf2KVx4oCZixYH3c6hNul7xZWxM9cp4GfXIcYwspvs7eSBCjPGXcjMeK
         DtzizpWc/CkYn8r8xHjAH8hfIUt78QjyPz9g/J9bNYU+5OjXS5ZzfNkYA1r7X4aGBXFT
         +nGKGEj97BR99h2aei5cQqGDIZsFFczozuL7gfq/PXymXaYFR0wSYPK+T82P7DTBDi7G
         hv3IQce1Tvk0UQdP4nqDmFaCIuxVj0j1lOFMHviiBx/SiLKG62rccOytOnUC6NVFDB3y
         weFA==
X-Gm-Message-State: AOJu0YzFf37ZgDKy+N1F5c6vZ7nOvG9yrBsFU+rmLgKrbE7J+h4FjHLf
	sD3gTlPyZVyDkuLaNHk4W+o=
X-Google-Smtp-Source: AGHT+IF96/abx5jXJWBb7ZAUoOqJmDj/+zq1RSLVP6Ci0ycJxXj1E+4z/kT3VryWrA625PxfIotqLw==
X-Received: by 2002:a17:906:ad99:b0:a28:a77d:3424 with SMTP id la25-20020a170906ad9900b00a28a77d3424mr308102ejb.65.1704783258969;
        Mon, 08 Jan 2024 22:54:18 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id p17-20020a1709060dd100b00a2689e28445sm687604eji.106.2024.01.08.22.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 22:54:18 -0800 (PST)
Message-ID: <8ef72461-1ed6-46cb-a692-412abec86186@kernel.org>
Date: Tue, 9 Jan 2024 07:54:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
 <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
 <CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
 <CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
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
In-Reply-To: <CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08. 01. 24, 22:11, Linus Torvalds wrote:
> On Mon, 8 Jan 2024 at 12:04, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> So we *could* plan on that, remove the checks from min/max, and use
>> something like the attached patch.
> 
> Whee.
> 
> On my machine, that patch makes an "allmodconfig" build go from
> 
>      10:41 elapsed
> 
> to
> 
>       8:46 elapsed
> 
> so that min/max type checking is almost 20% of the build time.
> 
> Yeah, I think we need to get rid of it.
> 
> Can somebody else confirm similar time differences? Or is it just me?

openSUSE config [1] -j160 build on 160 cores on /dev/shm:
real    6m5,729s
user    551m54,756s
sys     94m36,401s

Patched:
real    6m2,908s
user    535m35,860s
sys     92m0,006s




allmodconfig:
real    7m14,514s
user    818m34,541s
sys     112m59,033s

Patched:
real    6m57,144s
user    797m25,163s
sys     110m5,316s




So yes, there is definitely a change.

[1] 
https://github.com/openSUSE/kernel-source/blob/master/config/x86_64/default

regards,
-- 
js
suse labs


