Return-Path: <linux-kernel+bounces-92023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84368719E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67CB21F21545
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF1535D1;
	Tue,  5 Mar 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="YbhpMHbI"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFA548E0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632095; cv=none; b=ePBe1am4iQ3l+e+F1LeTdtncXyzoYVJCBSp9C0ZK9bbTML+X198ABZ8Jh67aGSCwFX5GHseWYdBQzu4cfWnr3ec7savlmPSm8IL8yVsEmT9JqdLjDIlex82nYur72uzhwxbd4KH9SzPLXIGJZNbKWrP1p8GaKxFIRcZudWZTjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632095; c=relaxed/simple;
	bh=Kl66zlIUBJMjKiJbs54JM18KCScr6ggO7zuxCM20ZNc=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZMGSr2x5cyDncWy4TgsvK53fzA8Xghntj3tw8VnpepAaFGZNoRZ51qm/R8hgJ2c4rDRYgAsLvcZa5AGV/h0qUPtaQeV0Vi4huevVmpY/92DC5CMkijhTo3nmeqQc/AhXqHIdXYILKsEuqW00DtyxoXBAxuca0C294gaMuAi6dxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=YbhpMHbI; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id hPQTr2HwKQr4ShRP9ryRLX; Tue, 05 Mar 2024 09:48:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hRP8r9lHYVZJ8hRP8rOJbN; Tue, 05 Mar 2024 09:48:11 +0000
X-Authority-Analysis: v=2.4 cv=EsjUrzcA c=1 sm=1 tr=0 ts=65e6ea5b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=N659UExz7-8A:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=pFyQfRViAAAA:8
 a=klGuld2lNjIqw9me8RMA:9 a=3ZKOabzyN94A:10 a=pILNOxqGKmIA:10
 a=Y6Wt1f1SdXxjDN_AVjWB:22 a=oJz5jJLG1JtSoe7EL652:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2vfrtl2hnOi75m01rqnx+qBu6B+J3ABfkcSxaZRuSXo=; b=YbhpMHbIbbmLiZ47gCVYHGAkbl
	ozrU1kfEMtwtUsCrt6fSJn2rRWvir4U+KVXxjidbcs1p3nY9mNg0pgqWEZBppgajsNtFJpDwzpDKr
	QkMisswmmoFa6lB7I9/Lxa5jle6ev4nFcZ2DrQgHlYYtuH3RK1QbR5U6iM48SXqvV7fs2VDAuQnEO
	Af1wBFKAR8/3ThNclVAE+HcR77fyKbmXA0AcgTi6YcBneHoGsudzfD09igL/jGNn//2zSM6tsROnT
	B4BQ/u1MrUGT1EWF1mdQ6cM3LgsokJKnjAi3arnqrFtk26R9C9GU5lOWxu7hSHlUgjv/oSYfyiBsu
	rrATrubg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:49220 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rhRP6-0048RU-2k;
	Tue, 05 Mar 2024 02:48:08 -0700
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
Message-ID: <fc131a72-6421-ad75-44bd-5ab7761d1cc4@w6rz.net>
Date: Tue, 5 Mar 2024 01:48:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1a9a5456-ea3f-8a30-d8db-f49269966e71@w6rz.net>
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
X-Exim-ID: 1rhRP6-0048RU-2k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:49220
X-Source-Auth: re@w6rz.net
X-Email-Count: 24
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNNJEJMaHenM0ZNGaNjYiv+5u7bgq25fnne5+vjJkPn+QdwKdGyx21vdbqPqSPCKLzO+ZcPo+FcxQMwgJWUbK1cN2IW7YU0ZPydTGpCukI96ruSUtdqr
 W1d0cfdn2pFCyi3T00Vwp1pUC64UeMNmqsTw17n2hfnMmud1dqdY0CWSRvmAi46tyUw/OKmx2jiqBJfjeRy34RT+s3gSe9J/G8Q=

On 3/5/24 1:27 AM, Ron Economos wrote:
> On 3/5/24 12:31 AM, Conor Dooley wrote:
>> On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.7.9 release.
>>> There are 163 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
>>> Anything received after that time might be too late.
>>> Samuel Holland <samuel.holland@sifive.com>
>>>      riscv: Save/restore envcfg CSR during CPU suspend
>>>
>>> Samuel Holland <samuel.holland@sifive.com>
>>>      riscv: Add a custom ISA extension for the [ms]envcfg CSR
>> I left a comment in response to the off-list email about this patch,
>> I don't think it's gonna work as the number this custom extension has
>> been given exceeds the max in 6.7/
>>
>> Cheers,
>> Conor.
>>
>>> Samuel Holland <samuel.holland@sifive.com>
>>>      riscv: Fix enabling cbo.zero when running in M-mode
>
> Yeah, it doesn't work. Here's the new error:
>
> arch/riscv/kernel/cpufeature.c:180:9: error: implicit declaration of 
> function '__RISCV_ISA_EXT_SUPERSET'; did you mean 
> 'RISCV_ISA_EXT_SVPBMT'? [-Werror=implicit-function-declaration]
>   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, 
> riscv_xlinuxenvcfg_exts),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
>       |         RISCV_ISA_EXT_SVPBMT
> arch/riscv/kernel/cpufeature.c:180:34: error: 'zicbom' undeclared here 
> (not in a function)
>   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, 
> riscv_xlinuxenvcfg_exts),
>       |                                  ^~~~~~
> arch/riscv/kernel/cpufeature.c:181:34: error: 'zicboz' undeclared here 
> (not in a function)
>   181 |         __RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, 
> riscv_xlinuxenvcfg_exts),
>       |                                  ^~~~~~
> cc1: some warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:243: 
> arch/riscv/kernel/cpufeature.o] Error 1
> make[3]: *** [scripts/Makefile.build:480: arch/riscv/kernel] Error 2
> make[2]: *** [scripts/Makefile.build:480: arch/riscv] Error 2
>
>
This depends on a much earlier patch, "riscv: add ISA extension parsing 
for vector crypto" (upstream commit 
aec3353963b8de889c3f1ab7cc8ba11e99626606).

I think the best solution will be to revert all three patches.

riscv: Save/restore envcfg CSR during CPU suspend

riscv: Add a custom ISA extension for the [ms]envcfg CSR

riscv: Fix enabling cbo.zero when running in M-mode



