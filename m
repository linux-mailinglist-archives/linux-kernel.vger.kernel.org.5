Return-Path: <linux-kernel+bounces-92002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A28A871992
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C76D1C21192
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9449852F8A;
	Tue,  5 Mar 2024 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="qARyPTt4"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED6850272
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630885; cv=none; b=rRIvSmpRWEnMjwq4P/hV4CSEa7SoQyFOJiKgoPntyMpuydfST0DWzqieQZxU5oQqJL91DJs8+qc8qoEoBLskofoKahsq6xzuldIQpHwr9Jg/Fz4Dg0mH+oWU7aZRDxYi04cFNfsbIBPqXD5M7ld7pPy/KZFfcO6uLbWsFJThkGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630885; c=relaxed/simple;
	bh=1kOTYFbWeoGCx7+g2m8ix/ZZJHqJzi8Ogi29BXPLWPA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jFOslOx/LDMyVySS9OpmKifk99iG+3DNPCTlTNrY+heX/Z3dMU/1IGMbBs8OoC7iQZuGFbmFuP+C97j6yEKE2t9f3xuJ8WI1628H+a+UtMWbjVZTmQfObueQAqTODDwp1GkwW8fszaXCgmcnd/h9OMc0P/oLBYpWBIbcoj5oIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=qARyPTt4; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id hPQerdiQWHXmAhR5erCqca; Tue, 05 Mar 2024 09:28:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hR5drgtiZ7GTYhR5drGMDz; Tue, 05 Mar 2024 09:28:02 +0000
X-Authority-Analysis: v=2.4 cv=U6qUD/ru c=1 sm=1 tr=0 ts=65e6e5a2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=N659UExz7-8A:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=pFyQfRViAAAA:8
 a=vYhB_8XAvPddomvlNgMA:9 a=3ZKOabzyN94A:10 a=pILNOxqGKmIA:10
 a=Y6Wt1f1SdXxjDN_AVjWB:22 a=oJz5jJLG1JtSoe7EL652:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
	Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oqRXspNib9mBkuYyhpRwm5r2tRAPVxE1pbc/m6GrAA8=; b=qARyPTt4g+VOyOUm6b1NJIFMDD
	tFOXlPhhdI9NTTJjVunGKuQicc0dMtinlb0P3UxN8e0msGhtnmB8Dr4TITBv/MWhJaVYq32DJYXNj
	vKrKodewHMdo0MgtnLd5Izt3bsHsV7GWB9YzbHs4YTrjm61gm+6Oc2yGb2XFssAdIIslelLZTHgvb
	7biT17xlvE46Q9LoA+nOQrwDo+41Wbu4xGKSK3WOprQphDcPO1piQvVNLMG5DF6S/uJfOCGbQNNDS
	j14xXUrDej4IwNfHiBW/kxs2Smh9BM8obk+uibM9Kyb3aKX8Hm/UT5GBTjfo2u58F4stW5dRU6pOf
	OCWs/nYw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:49192 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rhR5b-0040YA-1Z;
	Tue, 05 Mar 2024 02:27:59 -0700
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
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
From: Ron Economos <re@w6rz.net>
Message-ID: <1a9a5456-ea3f-8a30-d8db-f49269966e71@w6rz.net>
Date: Tue, 5 Mar 2024 01:27:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240305-arson-panhandle-afa453ccb0aa@wendy>
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
X-Exim-ID: 1rhR5b-0040YA-1Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:49192
X-Source-Auth: re@w6rz.net
X-Email-Count: 5
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMk4trh9X1fs3alJL4Dwwc3BtfEhpnzHgdW3KOjEIBN5QzOIgkF4og/lUwhQsu1HAoLJNrXa4lQtxEHl9pluCyswZJ2Ix/T5KwFkQXqpfYGxNy5q9PDw
 Eakwt2ceJ5466nTU1/NTxACPHeGUsdQUrFCm5+WGeRHCMt4nxfBQllcrxilCXpsjWU5ilNQZ/D8R1QAvdg6rL3ukQ7Hx4/+17Rg=

On 3/5/24 12:31 AM, Conor Dooley wrote:
> On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.7.9 release.
>> There are 163 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
>> Anything received after that time might be too late.
>> Samuel Holland <samuel.holland@sifive.com>
>>      riscv: Save/restore envcfg CSR during CPU suspend
>>
>> Samuel Holland <samuel.holland@sifive.com>
>>      riscv: Add a custom ISA extension for the [ms]envcfg CSR
> I left a comment in response to the off-list email about this patch,
> I don't think it's gonna work as the number this custom extension has
> been given exceeds the max in 6.7/
>
> Cheers,
> Conor.
>
>> Samuel Holland <samuel.holland@sifive.com>
>>      riscv: Fix enabling cbo.zero when running in M-mode

Yeah, it doesn't work. Here's the new error:

arch/riscv/kernel/cpufeature.c:180:9: error: implicit declaration of 
function '__RISCV_ISA_EXT_SUPERSET'; did you mean 
'RISCV_ISA_EXT_SVPBMT'? [-Werror=implicit-function-declaration]
   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, 
riscv_xlinuxenvcfg_exts),
       |         ^~~~~~~~~~~~~~~~~~~~~~~~
       |         RISCV_ISA_EXT_SVPBMT
arch/riscv/kernel/cpufeature.c:180:34: error: 'zicbom' undeclared here 
(not in a function)
   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, 
riscv_xlinuxenvcfg_exts),
       |                                  ^~~~~~
arch/riscv/kernel/cpufeature.c:181:34: error: 'zicboz' undeclared here 
(not in a function)
   181 |         __RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, 
riscv_xlinuxenvcfg_exts),
       |                                  ^~~~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:243: 
arch/riscv/kernel/cpufeature.o] Error 1
make[3]: *** [scripts/Makefile.build:480: arch/riscv/kernel] Error 2
make[2]: *** [scripts/Makefile.build:480: arch/riscv] Error 2


