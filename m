Return-Path: <linux-kernel+bounces-82986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9874868C95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAE51F21F6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840DE1369A2;
	Tue, 27 Feb 2024 09:43:58 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B268136989
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027038; cv=none; b=p+Ga3EX12o5B0ZszZ7Ij/xUiAhZixw97rbgB/tUiIDqDdzcBEzLsiSgdaGBItkvbfa18rgaZClh/4yYkUTqJITYDUi23RIzKw1beIhW7SCmSMQhM9hHes89KfALfgY3ymEK7UUZUlfk4b9mje6hvYxobLLh2pwsbjJX20IwXaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027038; c=relaxed/simple;
	bh=eY9mLWvWENbzvvnDFf61NURLD+YUY43q8xe+W2oscqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JytAbcgjdUXwXH2rYFUpl4/Mz3U9ogmS9Bq6Rh2ugRg+SOnASIxjwhO6KVRxl9Qkdhc08Q9RtXHn+fdwisA/MHK9J2pyqJYFp85bTJDxL/XuQuWVRvx0GXCMYAjLdpLhgBf62vGBu4gbcArqopPa4oEYFy8KA724gYPbF3xRoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so2824241f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709027035; x=1709631835;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZtneY2221lsZSEsmdoaC1eV3+M74BwSZ3O0IWrGErE=;
        b=KX0MoAJ4tdqnjmi7t6mZpHihaqNXoFB92wF3gOwLBVFn9FPIXH8Kis7gysemKUxQox
         lgMGe2PcFMeSHyFYjhsDDopI4vGQva4+knEaNh0UmRWUPQc4VCglrk+/6xIFn1VzCwAt
         oplTPSzDwfMLIQJO2etZKDufVmzOTpgCpoM/hJRTO1OnsjxpL/XXVQF6hT1Nueya7miS
         bYXXfaLFkQpaPmw6ji9OJua2+79jXV0f62f0Ww2i+LA8qytQy4HMV2t1UzZV7/74HQBB
         V1ASswrpfSWlXxQbbajul2Hz6/YtIjopBgzHjgPIbCV2gPnLT49PBvSNw+cXprnhaQYx
         WaLw==
X-Forwarded-Encrypted: i=1; AJvYcCUNKmC8czV8h0nMzf3M/x9W4YPiU+HTDUlP+V24kgr0l9SDI+c6uXNEmiO6BugJ6ky67ubeZrUsObM1a4UgTb9DnbSrnif5VfAXlYxc
X-Gm-Message-State: AOJu0Yyd8jXfqcHGqzYzSHQ9fPmt/9H3Rm5SMWwkTVDA4HVxHIXSaydP
	xuEH0wnSta8wDnK4eGJnhL+Zw1Zc1nX+mMldFKKt5/q5JcOGmNPcoYLFKUSN
X-Google-Smtp-Source: AGHT+IEDGtE8I8A1QnL0Ktxr53lZ37S+YmKxSgo1/2HMyXIysJdbv/A72aHQ2284EM1mBFbv2C4yfg==
X-Received: by 2002:adf:e6c8:0:b0:33d:6334:e14 with SMTP id y8-20020adfe6c8000000b0033d63340e14mr5938816wrm.11.1709027034445;
        Tue, 27 Feb 2024 01:43:54 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id by6-20020a056000098600b0033d568f8310sm10976586wrb.89.2024.02.27.01.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:43:54 -0800 (PST)
Message-ID: <373674e4-cbd0-44d7-98c7-304b0ab4f34b@kernel.org>
Date: Tue, 27 Feb 2024 10:43:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/bugs: Use fixed addressing for VERW operand
Content-Language: en-US
To: Nikolay Borisov <nik.borisov@suse.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <20240226-verw-arg-fix-v1-1-7b37ee6fd57d@linux.intel.com>
 <92440f47-21b7-4f4f-ad99-a99358cfbedf@suse.com>
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
In-Reply-To: <92440f47-21b7-4f4f-ad99-a99358cfbedf@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27. 02. 24, 9:47, Nikolay Borisov wrote:
> 
> 
> On 27.02.24 г. 1:52 ч., Pawan Gupta wrote:
>> Macro used for MDS mitigation executes VERW with relative addressing for
>> the operand. This is unnecessary and creates a problem for backports on
>> older kernels that don't support relocations in alternatives. Relocation
>> support was added by commit 270a69c4485d ("x86/alternative: Support
>> relocations in alternatives"). Also asm for fixed addressing is much
>> more cleaner than relative RIP addressing.
>>
>> Simplify the asm by using fixed addressing for VERW operand.
>>
>> Fixes: baf8361e5455 ("x86/bugs: Add asm helpers for executing VERW")
>> Reported-by: Nikolay Borisov <nik.borisov@suse.com>
>> Closes: 
>> https://lore.kernel.org/lkml/20558f89-299b-472e-9a96-171403a83bd6@suse.com/
>> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>> ---
>>   arch/x86/include/asm/nospec-branch.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/nospec-branch.h 
>> b/arch/x86/include/asm/nospec-branch.h
>> index 2aa52cab1e46..ab19c7f1167b 100644
>> --- a/arch/x86/include/asm/nospec-branch.h
>> +++ b/arch/x86/include/asm/nospec-branch.h
>> @@ -323,7 +323,7 @@
>>    * Note: Only the memory operand variant of VERW clears the CPU 
>> buffers.
>>    */
>>   .macro CLEAR_CPU_BUFFERS
>> -    ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), 
>> X86_FEATURE_CLEAR_CPU_BUF
>> +    ALTERNATIVE "", __stringify(verw mds_verw_sel), 
>> X86_FEATURE_CLEAR_CPU_BUF
> 
> Actually thinking about it more and discussing with Jiri (cc'ed), will 
> this work with KASLR enabled?

I might of course be wrong. We appear to rely on the asm+linker here. 
Please see also:
https://lore.kernel.org/r/fd8f2df0-563e-4f5c-aca4-bc92a14e9426@kernel.org

thanks,
-- 
js
suse labs


