Return-Path: <linux-kernel+bounces-25975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E382D929
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CABC1C216FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FB168A9;
	Mon, 15 Jan 2024 12:54:38 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE3D1642F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3368b1e056eso7227606f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 04:54:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705323275; x=1705928075;
        h=in-reply-to:autocrypt:references:cc:to:from:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLghDWpkVU0YBuzbAu4AAdJFnxwFpeeuzgUW29PuSMY=;
        b=T8RpIyWEb3P3/JTkXd+ydPlozGY6Jj9q5xcBcfEe+KzXPWFyoUOEZHXa7yWb/8kBzA
         wAOtj2LFt+U0EbJps+L382YFoa0QY09xFfp3kjtnqKRB8v3/ltQL03f6ye9T3hv5O3vA
         lJZzsfAqiNmoON8TymRPq7afOHRXaS6MuDJjL5w9MIWAQWIytcmIVtR6BJF5A+V6VHr7
         k3nYKJSDo0iQ1TfTVzwiWdwfIfSpmLYUnx8xzReQBY8ns4RmwbD+fhD8SEzvmWwCof2U
         rUcxq2wbH/bSC2xzkk0gMVzoNdyHraRXpVsorHhWU6ojhwJdt3VfctRhUGLnn+YpZF0o
         MK/g==
X-Gm-Message-State: AOJu0YxS0hTT38DrAWWuE0XJnWgb4YK88favGIW60pqcQl8PVeUbDQk6
	60ZjRtm8ZcnGVD5mmJzwJC0=
X-Google-Smtp-Source: AGHT+IFRPhXev11ORnPnGCEOT2C2rDG6s0AfVxRCuG72RaCVKZpRUBUFZH8FhqL+PGUDJpREjrGt6w==
X-Received: by 2002:adf:f150:0:b0:333:5665:fa86 with SMTP id y16-20020adff150000000b003335665fa86mr2807773wro.18.1705323274450;
        Mon, 15 Jan 2024 04:54:34 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id d13-20020a056000114d00b003379d5d2f1csm6629574wrx.28.2024.01.15.04.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 04:54:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------MIjzjvXzDzk5uLbgROFJFtxw"
Message-ID: <c737a604-d441-49c6-a5cd-ef01e9f2a454@kernel.org>
Date: Mon, 15 Jan 2024 13:54:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] locking/rtmutex: Acquire the hb lock via trylock
 after wait-proxylock.
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, boqun.feng@gmail.com, bristot@redhat.com,
 bsegall@google.com, dietmar.eggemann@arm.com, jstultz@google.com,
 juri.lelli@redhat.com, longman@redhat.com, mgorman@suse.de,
 mingo@redhat.com, rostedt@goodmis.org, swood@redhat.com,
 vincent.guittot@linaro.org, vschneid@redhat.com, will@kernel.org
References: <20230908162254.999499-1-bigeasy@linutronix.de>
 <20230908162254.999499-8-bigeasy@linutronix.de>
 <20230911141135.GB9098@noisy.programming.kicks-ass.net> <87fs3f1tl0.ffs@tglx>
 <20230915151943.GD6743@noisy.programming.kicks-ass.net>
 <4611bcf2-44d0-4c34-9b84-17406f881003@kernel.org>
 <9f75eb59-9b7a-4b49-9081-e6a3cbb00187@kernel.org>
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
In-Reply-To: <9f75eb59-9b7a-4b49-9081-e6a3cbb00187@kernel.org>

This is a multi-part message in MIME format.
--------------MIjzjvXzDzk5uLbgROFJFtxw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15. 01. 24, 12:52, Jiri Slaby wrote:
> On 15. 01. 24, 12:40, Jiri Slaby wrote:
>> On 15. 09. 23, 17:19, Peter Zijlstra wrote:
>>> On Fri, Sep 15, 2023 at 02:58:35PM +0200, Thomas Gleixner wrote:
>>>
>>>> I spent quite some time to convince myself that this is correct. I was
>>>> not able to poke a hole into it. So that really should be safe to
>>>> do. Famous last words ...
>>>
>>> IKR :-/
>>>
>>> Something like so then...
>>>
>>> ---
>>> Subject: futex/pi: Fix recursive rt_mutex waiter state
>>
>> So this breaks some random test in APR:
>>
>>  From 
>> https://build.opensuse.org/package/live_build_log/openSUSE:Factory:Staging:G/apr/standard/x86_64:
>> testprocmutex       :  Line 122: child did not terminate with success
>>
>> The child in fact terminates on 
>> https://github.com/apache/apr/blob/trunk/test/testprocmutex.c#L93:
>>                  while ((rv = apr_proc_mutex_timedlock(proc_lock, 1))) {
>>                      if (!APR_STATUS_IS_TIMEUP(rv))
>>                          exit(1); <----- here
>>
>> The test creates 6 children and does some 
>> pthread_mutex_timedlock/unlock() repeatedly (200 times) in parallel 
>> while sleeping 1 us inside the lock. The timeout is 1 us above. And 
>> the test expects all them to fail (to time out). But the time out does 
>> not always happen in 6.7 (it's racy, so the failure is semi-random: 
>> like 1 of 1000 attempts is bad).
> 
> This is not precise as I misinterpreted. The test is: either it succeeds 
> or times out.
> 
> But since the commit, futex() yields 22/EINVAL, i.e. fails.

A simplified reproducer attached (in particular, no APR anymore). Build 
with -pthread, obviously. If you see
BADx rv=22

that's bad.

regards,
-- 
js
suse labs

--------------MIjzjvXzDzk5uLbgROFJFtxw
Content-Type: text/x-csrc; charset=UTF-8; name="pokus2.c"
Content-Disposition: attachment; filename="pokus2.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzdGRp
by5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDx1bmlzdGQuaD4KCiNpbmNsdWRl
IDxzeXMvbW1hbi5oPgojaW5jbHVkZSA8c3lzL3RpbWUuaD4KI2luY2x1ZGUgPHN5cy93YWl0
Lmg+CgojZGVmaW5lIE1BWF9XQUlUX1VTRUMgKDEwMDAqMTAwMCkKI2RlZmluZSBDSElMRFJF
TiAxNgojZGVmaW5lIE1BWF9JVEVSIDIwMAoKI2RlZmluZSBOU19QRVJfUyAxMDAwMDAwMDAw
CgpzdGF0aWMgcHRocmVhZF9tdXRleF90ICpwcm9jX2xvY2s7CgpzdGF0aWMgdm9pZCBjaGls
ZCgpCnsKICAgICAgICBpbnQgcnYsIGkgPSAwOwoKICAgICAgICBkbyB7CiAgICAgICAgICAg
ICAgICBpbnQgd2FpdF91c2VjID0gMDsKCQlzdHJ1Y3QgdGltZXNwZWMgYWJzdGltZTsKCgkJ
Y2xvY2tfZ2V0dGltZShDTE9DS19SRUFMVElNRSwgJmFic3RpbWUpOwoKCQlhYnN0aW1lLnR2
X25zZWMgKz0gMTAwMDsKCQlpZiAoYWJzdGltZS50dl9uc2VjID49IE5TX1BFUl9TKSB7CgkJ
CWFic3RpbWUudHZfc2VjKys7CgkJCWFic3RpbWUudHZfbnNlYyAtPSBOU19QRVJfUzsKCQl9
CgogICAgICAgICAgICAgICAgd2hpbGUgKChydiA9IHB0aHJlYWRfbXV0ZXhfdGltZWRsb2Nr
KHByb2NfbG9jaywgJmFic3RpbWUpKSkgewogICAgICAgICAgICAgICAgICAgIGlmIChydiAh
PSBFVElNRURPVVQpIHsKCQkJICAgIGZwcmludGYoc3RkZXJyLCAiQkFEeCBydj0lZFxuIiwg
cnYpOwoJCQkgICAgYWJvcnQoKTsKCQkgICAgfQogICAgICAgICAgICAgICAgICAgIGlmICgr
K3dhaXRfdXNlYyA+PSBNQVhfV0FJVF9VU0VDKQogICAgICAgICAgICAgICAgICAgICAgICBh
Ym9ydCgpOwogICAgICAgICAgICAgICAgfQoJCS8vZnByaW50ZihzdGRlcnIsICJbJWRdIHJ2
PSVkXG4iLCBnZXRwaWQoKSwgcnYpOwoKICAgICAgICAgICAgaSsrOwoJICAgIHVzbGVlcCgx
KTsKICAgICAgICAgICAgaWYgKHB0aHJlYWRfbXV0ZXhfdW5sb2NrKHByb2NfbG9jaykpCiAg
ICAgICAgICAgICAgICBhYm9ydCgpOwogICAgICAgIH0gd2hpbGUgKGkgPCBNQVhfSVRFUik7
CgoJZXhpdCgwKTsKfQoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQp7Cglwcm9j
X2xvY2sgPSBtbWFwKE5VTEwsIHNpemVvZigqcHJvY19sb2NrKSwKCQkJIFBST1RfUkVBRCB8
IFBST1RfV1JJVEUsIE1BUF9BTk9OWU1PVVMgfCBNQVBfU0hBUkVELAoJCQkgLTEsIDApOwoK
CXB0aHJlYWRfbXV0ZXhhdHRyX3QgbWF0dHI7CgoJcHRocmVhZF9tdXRleGF0dHJfaW5pdCgm
bWF0dHIpOwoJcHRocmVhZF9tdXRleGF0dHJfc2V0cHNoYXJlZCgmbWF0dHIsIFBUSFJFQURf
UFJPQ0VTU19TSEFSRUQpOwoJcHRocmVhZF9tdXRleGF0dHJfc2V0cm9idXN0KCZtYXR0ciwg
UFRIUkVBRF9NVVRFWF9ST0JVU1QpOwoJcHRocmVhZF9tdXRleGF0dHJfc2V0cHJvdG9jb2wo
Jm1hdHRyLCBQVEhSRUFEX1BSSU9fSU5IRVJJVCk7CgoJcHRocmVhZF9tdXRleF9pbml0KHBy
b2NfbG9jaywgJm1hdHRyKTsKCglwdGhyZWFkX211dGV4YXR0cl9kZXN0cm95KCZtYXR0cik7
CgoJZm9yICh1bnNpZ25lZCBhID0gMDsgYSA8IENISUxEUkVOOyBhKyspCgkJaWYgKCFmb3Jr
KCkpCgkJCWNoaWxkKCk7CgoJZm9yICh1bnNpZ25lZCBhID0gMDsgYSA8IENISUxEUkVOOyBh
KyspCgkJd2FpdChOVUxMKTsKCglwdGhyZWFkX211dGV4X2Rlc3Ryb3kocHJvY19sb2NrKTsK
CgoJcmV0dXJuIDA7Cn0KCg==

--------------MIjzjvXzDzk5uLbgROFJFtxw--

