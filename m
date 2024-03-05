Return-Path: <linux-kernel+bounces-92031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019158719FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E4D1C21256
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F9537E6;
	Tue,  5 Mar 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="sT+8z2AV"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1867E5339E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632387; cv=none; b=ZmWEs3kMpjB7QjyN6w55dKocXj4ladnDxDasDzL480E3UyBEQIIxW7YGYUhyOgEG/whxoub5J6MdBHd3UM0cp0E+H+/3IVCKtHjAYHqgayPkRnl1Cc5c3EdYTHeF62DTb0eSkH8HSxAVikMfUgtXOQSRAJL7FMC/5rQjjhiZ6s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632387; c=relaxed/simple;
	bh=OMXHsWgy5ek5HhPBxwwuFXHndjFeQa1IvTPgUPKbPOA=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Bwovsd0eOWvVktAWeJJh6sQAdGYWXWquX8Vdmc63NASs+kjCGZHvOuu/eEEfba/i0ElfHW4lHi1TFjgJUj6PpaXOGk8V+B9gHV1b1wCHTf3n63/2T7Tw7Na3LgA7cAewc22jMsShl5aUcKA234hozDuWJRt9On1iP5vLwp93cic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=sT+8z2AV; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id hPQUrX1NZDI6fhRTsrSmHl; Tue, 05 Mar 2024 09:53:04 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hRTrrvZtfHZXphRTrrQsky; Tue, 05 Mar 2024 09:53:04 +0000
X-Authority-Analysis: v=2.4 cv=OppJyT/t c=1 sm=1 tr=0 ts=65e6eb80
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=N659UExz7-8A:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=pFyQfRViAAAA:8
 a=kLO_78tPsFOv1NFa8psA:9 a=3ZKOabzyN94A:10 a=pILNOxqGKmIA:10
 a=Y6Wt1f1SdXxjDN_AVjWB:22 a=oJz5jJLG1JtSoe7EL652:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AfeRHuT1v8xdOSui5LMmHFULlvJUzgG0gSrsmLPLnv0=; b=sT+8z2AVxhseVm40maYtiq7wBn
	9Fwd/WRqXdCoJUxmKC7Gfl9wmZYitqnb/rXRJmg3MkffTuLY9Y5HvhgVC7UYzCHVd+w+arFobq4Vu
	iRmVv4brkOv1yM4PohiROtsG+qR5SqXxCgc1DhKamiW1IoFTC+kySYFHztRItRIxqrR0wr7OBNh5e
	SoHDsL+8e/RxpriSkBy1Z8fC/A04V954mfimevq9drhrBGcLe+LGVfpPMvRtbg/6dU883OT0ftqUD
	iaX2vWj+YZBTyWCq+fBa9iDltLCex26KYyx3ogupPn36a9CpAJmPZJtPk4EzUiw4Ek2kEIU9hJ7TG
	8dGw/zwg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:49228 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rhRTp-004B6H-2i;
	Tue, 05 Mar 2024 02:53:01 -0700
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
From: Ron Economos <re@w6rz.net>
To: Conor Dooley <conor.dooley@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240305074649.580820283@linuxfoundation.org>
 <20240305-arson-panhandle-afa453ccb0aa@wendy>
 <1a9a5456-ea3f-8a30-d8db-f49269966e71@w6rz.net>
 <fc131a72-6421-ad75-44bd-5ab7761d1cc4@w6rz.net>
Message-ID: <013ebb78-46df-0db7-d95e-51229273bd2c@w6rz.net>
Date: Tue, 5 Mar 2024 01:52:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fc131a72-6421-ad75-44bd-5ab7761d1cc4@w6rz.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rhRTp-004B6H-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:49228
X-Source-Auth: re@w6rz.net
X-Email-Count: 43
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAI8poFiylVdI12j2ldIQ0TM6W11ORPg3WomKni9zA19uhvhvri4rhk/IFweMqHULn/gYOk/J6I+j98VDp06En47haZamwCOl36Xm76WEUgjDEtClI6/
 TSG00Os/KRnAo84JybvPe9qKj1J4aHmcKXmNuDZmytcdAyBUr4IJM8m4jE6IQteVt5Qwq3IsJddGlkj5HyH+ly8RjpizqJc8h/8=

On 3/5/24 1:48 AM, Ron Economos wrote:
> On 3/5/24 1:27 AM, Ron Economos wrote:
>> On 3/5/24 12:31 AM, Conor Dooley wrote:
>>> On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 6.7.9 release.
>>>> There are 163 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, 
>>>> please
>>>> let me know.
>>>>
>>>> Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
>>>> Anything received after that time might be too late.
>>>> Samuel Holland <samuel.holland@sifive.com>
>>>>      riscv: Save/restore envcfg CSR during CPU suspend
>>>>
>>>> Samuel Holland <samuel.holland@sifive.com>
>>>>      riscv: Add a custom ISA extension for the [ms]envcfg CSR
>>> I left a comment in response to the off-list email about this patch,
>>> I don't think it's gonna work as the number this custom extension has
>>> been given exceeds the max in 6.7/
>>>
>>> Cheers,
>>> Conor.
>>>
>>>> Samuel Holland <samuel.holland@sifive.com>
>>>>      riscv: Fix enabling cbo.zero when running in M-mode
>>
>> Yeah, it doesn't work. Here's the new error:
>>
>> arch/riscv/kernel/cpufeature.c:180:9: error: implicit declaration of 
>> function '__RISCV_ISA_EXT_SUPERSET'; did you mean 
>> 'RISCV_ISA_EXT_SVPBMT'? [-Werror=implicit-function-declaration]
>>   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom, 
>> RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
>>       |         RISCV_ISA_EXT_SVPBMT
>> arch/riscv/kernel/cpufeature.c:180:34: error: 'zicbom' undeclared 
>> here (not in a function)
>>   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom, 
>> RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
>>       |                                  ^~~~~~
>> arch/riscv/kernel/cpufeature.c:181:34: error: 'zicboz' undeclared 
>> here (not in a function)
>>   181 |         __RISCV_ISA_EXT_SUPERSET(zicboz, 
>> RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
>>       |                                  ^~~~~~
>> cc1: some warnings being treated as errors
>> make[4]: *** [scripts/Makefile.build:243: 
>> arch/riscv/kernel/cpufeature.o] Error 1
>> make[3]: *** [scripts/Makefile.build:480: arch/riscv/kernel] Error 2
>> make[2]: *** [scripts/Makefile.build:480: arch/riscv] Error 2
>>
>>
> This depends on a much earlier patch, "riscv: add ISA extension 
> parsing for vector crypto" (upstream commit 
> aec3353963b8de889c3f1ab7cc8ba11e99626606).
>
> I think the best solution will be to revert all three patches.
>
> riscv: Save/restore envcfg CSR during CPU suspend
>
> riscv: Add a custom ISA extension for the [ms]envcfg CSR
>
> riscv: Fix enabling cbo.zero when running in M-mode
>
>
>
Sorry, "riscv: Fix enabling cbo.zero when running in M-mode" is okay. 
Just the first two.


