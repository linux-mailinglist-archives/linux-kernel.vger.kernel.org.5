Return-Path: <linux-kernel+bounces-40642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 708EF83E38F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC241C24BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB424B20;
	Fri, 26 Jan 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEceu7Xk"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3824A11;
	Fri, 26 Jan 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302882; cv=none; b=XVNzQOjwHtoU9OUoYqDuzya+S9ZQdG4FpKghy1LtEqVD/imEyr5/4HFAWsOfA+dyp50S8hyEK4dP+asEG3tL29gcRxIf0C9kt4tjySq3TddkB8rmLYPxftYuwpXbuoCW7BRV4cGDkodhPKRDGJ5xrzs6bEuiO9Zy3NwxD41I2NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302882; c=relaxed/simple;
	bh=Z3NBcdg+tQjXG37oXp1uFOMFd4Bb1DC/hFzDXy+JC30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqHn1jN3zPfCbnmcNN/ibQbnRM47lISLny5kHzzhSx9QSY67lIUN/TVHSdRjXiLO48muxQTy+pEthl6mMxxVYz9V562K5lcmoF38kVMm9MMAcsSpHlc5s/N3Cpi4GkWOJkWJwYw8ym/eRB/VBJhGZEvEDxsrLBr/yV335t1aUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEceu7Xk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d76671e5a4so7160985ad.0;
        Fri, 26 Jan 2024 13:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706302880; x=1706907680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dBKHSUHNVVx/foeEsK6W4Es3PUE4MbOidth76VLLK3M=;
        b=QEceu7XkNIM5g2II3UPPhofeF75/p4m8O2EBAiRlstbhqZhBcfOgSMKrq4iT6cJXA3
         76hVBWY9M2izZPRzHwvS5uenptU54Ix7IxgDImL0vcnLF7aGjRc95q0WYG2gXYehL7xO
         grJ9DRbGBAfU4Lx58AIBaqSQk2IBRN7TmaJv8yGdpWFEK6Vy2zgPBFxW8reaE6IO4f8j
         0OJSj7p7sc9MK2aaHlic8qoT55eh51hT01I1Kzkw/5HfRL8Lt9rzgB9V02wON8BUo5u9
         y+NSZ7cwofUTDY/5S4qdrfos9NUP5EMSGCB7aDWmc9w2bIWYkwDWCpn6Kco0KSDMRSmX
         oRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706302880; x=1706907680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBKHSUHNVVx/foeEsK6W4Es3PUE4MbOidth76VLLK3M=;
        b=Botx/tbBCNea+lH99EUFGVh4k0+EKgTltgJeroKN00HzaPiYpzbJ9EnYUZJeSLGtIj
         9lqDZCgp7tcakaFZIwaAgjngZLkdUghPlggpJ1VcUXw2C6fczNypT536pf79qwGcQBu1
         /WSiWXERH+/yumr2Si8yaR9c7ZpckgUkWmRiU0arxVD2ToVRavOt2IsupSsL8yLGR/B7
         RdUoOB5pnz9O2HVBTFQf5vFYHVxY+UaSwVlPuDwgUHIvYboQfa+g+EuPzPRWUj0mWC7s
         ngcxueVig+5+9WczlUVe8pYcSXvfDY99FKnjmGFnlbrbJoZMN2UJ9b4EVETO5qm6MinJ
         DXEw==
X-Gm-Message-State: AOJu0YwZ/Hu/9FNBcEsH7DQuLbIjSCds6K1YYzPeqUXx+KOReNa7oNw3
	vWkQdqa1KnduRq9zQax9q3v9NpFaXDw7RTAX/XRYq05jkefBjH0F
X-Google-Smtp-Source: AGHT+IHo2IgJvyUf2GuA2MDzZVwkKMF8PEG4/i5+z4Jm77kke2q3dvwWMN5zeDhEo7Sk0EoonjBR3g==
X-Received: by 2002:a17:902:bc44:b0:1d5:5ac9:da0c with SMTP id t4-20020a170902bc4400b001d55ac9da0cmr371499plz.115.1706302879472;
        Fri, 26 Jan 2024 13:01:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lf12-20020a170902fb4c00b001d710cb27b7sm1348776plb.206.2024.01.26.13.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:01:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net>
Date: Fri, 26 Jan 2024 13:01:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/286] 5.10.209-rc1 review
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, llvm@lists.linux.dev, keescook@chromium.org
References: <20240122235732.009174833@linuxfoundation.org>
 <6b563537-b62f-428e-96d1-2a228da99077@roeck-us.net>
 <2024012636-clubbed-radial-1997@gregkh>
 <2f342268-8517-4c06-8785-96a588d20c63@roeck-us.net>
 <20240126203436.GA913905@dev-arch.thelio-3990X>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240126203436.GA913905@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/26/24 12:34, Nathan Chancellor wrote:
> On Fri, Jan 26, 2024 at 10:17:23AM -0800, Guenter Roeck wrote:
>> On 1/26/24 09:51, Greg Kroah-Hartman wrote:
>>> On Fri, Jan 26, 2024 at 08:46:42AM -0800, Guenter Roeck wrote:
>>>> On 1/22/24 15:55, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 5.10.209 release.
>>>>> There are 286 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
>>>>> Anything received after that time might be too late.
>>>>>
>>>> [ ... ]
>>>>
>>>>> zhenwei pi <pizhenwei@bytedance.com>
>>>>>        virtio-crypto: implement RSA algorithm
>>>>>
>>>>
>>>> Curious: Why was this (and its subsequent fixes) backported to v5.10.y ?
>>>> It is quite beyond a bug fix. Also, unless I am really missing something,
>>>> the series (or at least this patch) was not applied to v5.15.y, so we now
>>>> have functionality in v5.10.y which is not in v5.15.y.
>>>
>>> See the commit text, it was a dependency of a later fix and documented
>>> as such.
>>>
>>> Having it in 5.10 and not 5.15 is a bit odd, I agree, so patches are
>>> gladly accepted :)
>>>
>>
>> We reverted the entire series from the merge because it results in a build
>> failure for us.
>>
>> In file included from /home/groeck/src/linux-chromeos/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c:10:
>> In file included from /home/groeck/src/linux-chromeos/include/linux/mpi.h:21:
>> In file included from /home/groeck/src/linux-chromeos/include/linux/scatterlist.h:5:
>> In file included from /home/groeck/src/linux-chromeos/include/linux/string.h:293:
>> /home/groeck/src/linux-chromeos/include/linux/fortify-string.h:512:4: error: call to __read_overflow2_field declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
>>                          __read_overflow2_field(q_size_field, size);
> 
> For what it's worth, this is likely self inflicted for chromeos-5.10,
> which carries a revert of commit eaafc590053b ("fortify: Explicitly
> disable Clang support") as commit c19861d34c003 ("CHROMIUM: Revert
> "fortify: Explicitly disable Clang support""). I don't see the series
> that added proper support for clang to fortify in 5.18 that ended with
> commit 281d0c962752 ("fortify: Add Clang support") in that ChromeOS
> branch, so this seems somewhat expected.
> 

That explains that ;-). I don't mind if the patches stay in v5.10.y,
we have them reverted anyway.

The revert was a pure process issue, as you may see when looking into
commit c19861d34c003, so, yes, I agree that it is self-inflicted damage.
Still, that doesn't explain why the problem exists in 5.18+.

>> I also see that upstream (starting with 6.1) when trying to build it with clang,
>> so I guess it is one of those bug-for-bug compatibility things. I really have
>> no idea what causes it, or why we don't see the problem when building
>> chromeos-6.1 or chromeos-6.6, but (so far) only with chromeos-5.10 after
>> merging 5.10.209 into it. Making things worse, the problem isn't _always_
>> seen. Sometimes I can compile the file in 6.1.y without error, sometimes not.
>> I have no idea what triggers the problem.
> 
> Have a .config that reproduces it on upstream? I have not personally
> seen this warning in my build matrix nor has our continuous-integration
> matrix (I don't see it in the warning output at the bottom but that
> could have missed something for some reason) in 6.1:
> 

The following command sequence reproduces the problem for me with all stable
branches starting with 5.18.y (plus mainline).

rm -rf /tmp/crypto-build
mkdir /tmp/crypto-build
make -j CC=clang-15 mrproper >/dev/null 2>&1
make -j O=/tmp/crypto-build CC=clang-15 allmodconfig >/dev/null 2>&1
make -j O=/tmp/crypto-build W=1 CC=clang-15 drivers/crypto/virtio/virtio_crypto_akcipher_algs.o

I tried clang versions 14, 15, and 16. This is with my home system running
Ubuntu 22.04, no ChromeOS or Google specifics/internals involved. For clang-15,
the version is

Ubuntu clang version 15.0.7
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

Guenter


