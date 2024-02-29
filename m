Return-Path: <linux-kernel+bounces-87410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94E86D40F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F101F25F70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE1713F45B;
	Thu, 29 Feb 2024 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPA6OH6d"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0113F44F;
	Thu, 29 Feb 2024 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237987; cv=none; b=LpTBTnM8hwtD4EadeTpjqya9AYzUcA/MxHRPoPncGS2X7cP+F27BK4IWmla1oyCy3qw1RYGvI0i1auxseX/IWS1bQrzV0qEO9jxJnE+Tmn2htnTknNuXXQymMQb2ELFPFtbVkEALH1h9i5yJwVDfiVTPhuCqA7jkkZa4ieHr7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237987; c=relaxed/simple;
	bh=LN/IOb5JU0DH2uYb2n+cydKcHYsF2OCAvDHl0807OAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ksem9hJH3xbTvLNOEKD3Wn6HXENivSbIHNj6lRuMPxg88g/J27MAnSxXLoz8N/HQt1ECpEYh2IOmtunxns86LG+kmpjS7XyPkJ4lVbRwy3XV76TKA+AV0qi7Gc1Hqv2a5U2pktNwWIubchfgCNno/5urFsCEUXBTEOxIp+OWbwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPA6OH6d; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c48e13e0d7so66860039f.1;
        Thu, 29 Feb 2024 12:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709237984; x=1709842784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DWx+JJzrhA8O/5RetxNWqwuYRfxHSKh4F82WaKom4aE=;
        b=WPA6OH6dngLV7KxMMrIiJYJMemHIehfs5eNgfAT/OsTpEWV2T/eIoqqUNQ3Xm42F6I
         wbPZ3E7n06Lp8VWh68eRQHb8gWL9OZX/FTn36I8NrmyGDZQPqRH+TNEdKckHK+ijSNrJ
         vmh21h9ywFp6l+HMCvcSpfnYys7r54RnLNOoblIye2+TapknCw5MfTdQyyLTKE2Z70IB
         Xam3JtXKv7GYoKVeNNh8X87ll9x4fUQ5kJeUBgWCqGpdaRRJM8KalWh8azq3uVBa3H4c
         HBvCVIcVQO0kBwzsGLwDhciASMwUlCZ8+7Lbqj34QaJ9+6ebpZo5r5Z7+djkxyD2r7aT
         Dh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709237984; x=1709842784;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWx+JJzrhA8O/5RetxNWqwuYRfxHSKh4F82WaKom4aE=;
        b=F6VvcuCyEjnlVD3j1cTS7To+a7bTIYu+RxEpW40cw6XM4opXZHOl/WX21jniWKb3Pb
         wViupzcNTh2Vh1M10ZjJ4y8cflc3ung232EEiPa4c3wsWb4JHubw18KKc1ZMldQUXSkC
         6KuzEBX3od2RefLXABU/j+ltUNuNm3aSATYspU2zE3qIMQFRtCLRKalTakxXQzKpxt7k
         esFSyLSktaUazDcK0xM7Z7kikHfsDOnQBD5mZxYGU9h2JXZfkDMoY4RkIIUkBKbMhAnW
         i/jtqNywqHx4q/+RiXjgsUPL/5rqBupQqDpUVv+lof0VzszEmaUKydXK1v8NAjT4WIUS
         /B9g==
X-Forwarded-Encrypted: i=1; AJvYcCWSnLgKPeFflDE6JPHN/dKNQL2MTe3CDHN+WCnYfPjaD5M/+omRJfX+jxvpYCzLVioFbgzXlQR1spkcVaP3+1ZjCpsQ+CNRJ8kYV1fK
X-Gm-Message-State: AOJu0YyCVHK8KJzl0d93anSVtlKm+P3abUettCmkVNVQrn0IKVzmr96r
	EfZaSJXzx/qgV64kaPxWFW/zMID4DSUwPjCkgaNkwUvmuSD6PDFc
X-Google-Smtp-Source: AGHT+IHIds1jDIwJe86p1OdWPAbmQy+dsnlCtndULGVYG0lmpl5RrYamh/8HeZJ9rlizB5DApykSmQ==
X-Received: by 2002:a5e:8d11:0:b0:7c7:908b:f375 with SMTP id m17-20020a5e8d11000000b007c7908bf375mr52854ioj.10.1709237984397;
        Thu, 29 Feb 2024 12:19:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g10-20020a02b70a000000b00474558a20a3sm473305jam.140.2024.02.29.12.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:19:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1223812f-1dc3-40c2-a58a-2485d68e92b6@roeck-us.net>
Date: Thu, 29 Feb 2024 12:19:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/245] 5.15.150-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, paul@crapouillou.net
References: <20240227131615.098467438@linuxfoundation.org>
 <ac2c579e-4ff0-42e2-ab70-efb8ded2d257@linaro.org>
 <2024022905-skinny-making-7852@gregkh>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2024022905-skinny-making-7852@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/29/24 11:54, Greg Kroah-Hartman wrote:
> On Tue, Feb 27, 2024 at 12:56:32PM -0600, Daniel Díaz wrote:
>> Hello!
>>
>> On 27/02/24 7:23 a. m., Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.150 release.
>>> There are 245 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.150-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> We're seeing build regressions here with RISC-V, with GCC 8, GCC 12, and Clang 17:
>>
>> -----8<-----
>>    In file included from /builds/linux/include/linux/list.h:9,
>>                     from /builds/linux/include/linux/module.h:12,
>>                     from /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:12:
>>    /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:5512:35: error: 'rtl8169_pm_ops' undeclared here (not in a function); did you mean 'rtl8169_poll'?
>>     5512 |         .driver.pm      = pm_ptr(&rtl8169_pm_ops),
>>          |                                   ^~~~~~~~~~~~~~
>>    /builds/linux/include/linux/kernel.h:46:44: note: in definition of macro 'PTR_IF'
>>       46 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
>>          |                                            ^~~
>>    /builds/linux/drivers/net/ethernet/realtek/r8169_main.c:5512:27: note: in expansion of macro 'pm_ptr'
>>     5512 |         .driver.pm      = pm_ptr(&rtl8169_pm_ops),
>>          |                           ^~~~~~
>>    make[5]: *** [/builds/linux/scripts/Makefile.build:289: drivers/net/ethernet/realtek/r8169_main.o] Error 1
>> ----->8-----
>>
>> Bisection points to:
>>
>>    commit ac2871f646a8f556203f5b6be875ce406d855ddb
>>    Author: Paul Cercueil <paul@crapouillou.net>
>>    Date:   Tue Dec 7 00:20:59 2021 +0000
>>        PM: core: Redefine pm_ptr() macro
>>        [ Upstream commit c06ef740d401d0f4ab188882bf6f8d9cf0f75eaf ]
>>
>> A revert could not be done cleanly.
>>
>> Tuxmake reproducer:
>>
>>    tuxmake --runtime podman --target-arch riscv --toolchain gcc-12 --kconfig defconfig
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> I've been beating on this for a while and I really don't know what is
> happening, sorry.  The driver looks fine, something is "odd" with riscv

No, the driver is not fine. Upstream has commit 8fe6e670640e ("r8169: use new
PM macros") which makes rtl8169_pm_ops unconditional. That commit is missing
in v5.15.y. Applying it makes the problem disappear.

In other words, the problem is not riscv specific, but will be seen if the
realtek driver is built with CONFIG_PM=n (which happens to be the case with
riscv:defconfig).

Guenter


