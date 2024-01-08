Return-Path: <linux-kernel+bounces-19452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4E9826D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B903D1F2259B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA332224FC;
	Mon,  8 Jan 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grFPucQq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14F621A06
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55753dc5cf0so1965413a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704714382; x=1705319182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=byOMqWdTTkyf4mhLqzz3oazxcLeJG/lnHvrwsMOeAu8=;
        b=grFPucQqyd7klXrNmtVDYYwLm258pHTk21NZAq/Po9Ib8QbSAZZf2Igfwh5gZC42I0
         vP4+s/q0/L3rPXvVq7sLof5PX7/6hkMg/U+NvzjFZGZiVVSUgbgT5c2IIhh0LLb30WbJ
         dXutfMMPMgkwO1RyPOxMGGWm5MklZkb44kdeeyWHkdXVcl/DUaman/FPTdJj5oOAvAyj
         K2NuFou1NJOCd701yOrpZFMdPjooC4OFd/ZAv27y9ueOEXG+IvxubD4Icc7tFa+WqMHo
         sl4Z5LlRfRDNyAteiX29HVpvZBYsDg1EmDWeurkDEszw2sw4IeYZATtOg54Dn3CLFgOb
         VQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704714382; x=1705319182;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=byOMqWdTTkyf4mhLqzz3oazxcLeJG/lnHvrwsMOeAu8=;
        b=fed8+PNjDPV6eKulY/PVpnxJUnozo8mAWbeu4wggV/32seePrMgtdPB4dVdmXAGjpv
         7TTUHbe5a0fKghvZPI71lTPUFORlb0ZMedfVun3pavkn0AxDJX4KgidGuw80GijXDQTi
         htIHppAGI311wL0amTqfgsXLJE/2M6I8Cx9eue/Hbx0v5AKccwzZtRnm07JovAu1w1a/
         Dy4H6O5XzJQJHFogIVJ8zsHclEJc/WOiRfh5To+evq3Mn2djmsv00uT3oc9KlsLfGkFw
         3VJKdUWmNO8mzqpkOQwE2mj4V5xHtin18oBmX0LM49qojwetqWaTqjwo5IftjIsCxbun
         JFJA==
X-Gm-Message-State: AOJu0YwugFsNQsikBro/KAwjnllwOlMyFpxi7lcJDNjczx4RfyjvJjmW
	uje6r3ll+GAoblH+9h9KwIARBG4B6RMQdIjP
X-Google-Smtp-Source: AGHT+IGok+JfJHrJ//oHkZVQ6LFA0JKq5ND5o+jETiYM+abcXZTq0/wjOeFHHM4Z0I85QuwHPMn8Cg==
X-Received: by 2002:a50:c34d:0:b0:553:f0b2:1110 with SMTP id q13-20020a50c34d000000b00553f0b21110mr1742128edb.61.1704714381538;
        Mon, 08 Jan 2024 03:46:21 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id l13-20020aa7cacd000000b00557e0e24abbsm70958edt.59.2024.01.08.03.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 03:46:20 -0800 (PST)
Message-ID: <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
Date: Mon, 8 Jan 2024 12:46:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
 'Andrew Morton' <akpm@linux-foundation.org>,
 "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
 'Christoph Hellwig' <hch@infradead.org>,
 "'Jason A. Donenfeld'" <Jason@zx2c4.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
From: Jiri Slaby <jirislaby@gmail.com>
Autocrypt: addr=jirislaby@gmail.com; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSBKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAZ21haWwuY29tPsLBewQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
 HgECF4AFAk6S6P4CGQEACgkQvSWxBAa0cEl1Sg//UMXp//d4lP57onXMC2y8gafT1ap/xuss
 IvXR+3jSdJCHRaUFTPY2hN0ahCAyBQq8puUa6zaXco5jIzsVjLGVfO/s9qmvBTKw9aP6eTU7
 77RLssLlQYhRzh7vapRRp4xDBLvBGBv9uvWORx6dtRjh+e0J0nKKce8VEY+jiXv1NipWf+RV
 vg1gVbAjBnT+5RbJYtIDhogyuBFg14ECKgvy1Do6tg9Hr/kU4ta6ZBEUTh18Io7f0vr1Mlh4
 yl2ytuUNymUlkA/ExBNtOhOJq/B087SmGwSLmCRoo5VcRIYK29dLeX6BzDnmBG+mRE63IrKD
 kf/ZCIwZ7cSbZaGo+gqoEpIqu5spIe3n3JLZQGnF45MR+TfdAUxNQ4F1TrjWyg5Fo30blYYU
 z6+5tQbaDoBbcSEV9bDt6UOhCx033TrdToMLpee6bUAKehsUctBlfYXZP2huZ5gJxjINRnlI
 gKTATBAXF+7vMhgyZ9h7eARG6LOdVRwhIFUMGbRCCMXrLLnQf6oAHyVnsZU1+JWANGFBjsyy
 fRP2+d8TrlhzN9FoIGYiKjATR9CpJZoELFuKLfKOBsc7DfEBpsdusLT0vlzR6JaGae78Od5+
 ljzt88OGNyjCRIb6Vso0IqEavtGOcYG8R5gPhMV9n9/bCIVqM5KWJf/4mRaySZp7kcHyJSb0
 O6nOwU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02
 XFTIt4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P
 +nJWYIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYV
 nZAKDiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNe
 LuS8f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+B
 avGQ8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUF
 Bqgk3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpo
 tgK4/57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPD
 GHo739Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBK
 HQxz1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkF
 Ak6S54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH
 /1ldwRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+
 Kzdr90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj
 9YLxjhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbc
 ezWIwZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+d
 yTKLwLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330m
 kR4gW6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/
 tJ98f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCu
 jlYQDFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmf
 faK/S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 18. 09. 23, 10:14, David Laight wrote:
> The min() (etc) functions in minmax.h require that the arguments have
> exactly the same types.
> 
> However when the type check fails, rather than look at the types and
> fix the type of a variable/constant, everyone seems to jump on min_t().
> In reality min_t() ought to be rare - when something unusual is being
> done, not normality.
...
> David Laight (5):
>    minmax: Add umin(a, b) and umax(a, b)
>    minmax: Allow min()/max()/clamp() if the arguments have the same
>      signedness.
>    minmax: Fix indentation of __cmp_once() and __clamp_once()
>    minmax: Allow comparisons of 'int' against 'unsigned char/short'.
>    minmax: Relax check to allow comparison between unsigned arguments and
>      signed constants.

This slows down the build and increases the build memory consumption so 
that it causes OOMs.

In particular 6.7:
$ time make drivers/media/pci/solo6x10/solo6x10-p2m.i
...
   CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
real    0m45,002s
user    0m40,840s
sys     0m5,922s


$ git revert 867046cc7027703f60a46339ffde91a1970f2901
$ time make drivers/media/pci/solo6x10/solo6x10-p2m.i
...
   CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
real    0m11,132s
user    0m9,737s
sys     0m1,415s


$ git revert 4ead534fba42fc4fd41163297528d2aa731cd121
$ time make drivers/media/pci/solo6x10/solo6x10-p2m.i
...
   CPP [M] drivers/media/pci/solo6x10/solo6x10-p2m.i
real    0m3,711s
user    0m3,041s
sys     0m0,710s



Note it's only a preprocessor run. If you run a compiler on top of that, 
it even dies.

There is nothing special in that file, just:
if (SOLO_SDRAM_END(solo_dev) > solo_dev->sdram_size) {

which at some point expands to
         max(__SOLO_JPEG_MIN_SIZE(__solo),                               \
             min((__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo)), 
0x00ff0000))

and that expands to a lot of stuff.

Note that _line_ is 519 kbytes on 6.6 already. And 6 MB on 6.7.

The file is 4.3M vs. 122M.

Could you investigate/fix/revert (at least) the above two commits?

thanks,
-- 
js


