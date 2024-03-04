Return-Path: <linux-kernel+bounces-91405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7960687110B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352072845A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C707CF26;
	Mon,  4 Mar 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="1C1h287R"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185357C6E3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595070; cv=none; b=PZDQVs9Ji7ILrZgqfaFQaH9QdNdde/yls7Ki4qOyu8dRhZoRTcSF8+B1xPeq2iw1a40WVGBFwLRsbdt7KJd3ygQcjAvrjQc6AOWRAhbfW0dQ1BVBDIUyot+bXBh+aCnpvqzj5w744rfmvbb6vnUZPTnJTGy3ltQzlKRBV+bXj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595070; c=relaxed/simple;
	bh=nHa8DwC8bpEcB5DaG4EAgwujyIfuWHXzqJpn/5Qkqrg=;
	h=Subject:To:Cc:References:From:In-Reply-To:Message-ID:Date:
	 MIME-Version:Content-Type; b=uDojhG7uE0c/bP8oqVq/hZIs8yJe3WLvd66TVTga+b7f5WoXoh77AHqIqUw2NOZ9qbiJI3Ut/VAsZSnx/JATGB6MV/6/5quO7Pd3BsgKlpbCYuJGLKWaRbhvWx1ttHmZ4sFzbCQz1g3C8gdRcTlk40KwJLjv8Wwo36AwyYf5NI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=1C1h287R; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id hG2nr7f16uh6shHlxrA8yL; Mon, 04 Mar 2024 23:31:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hHlwr2daTiykKhHlxrn2Sc; Mon, 04 Mar 2024 23:31:05 +0000
X-Authority-Analysis: v=2.4 cv=RKy1HZi+ c=1 sm=1 tr=0 ts=65e659b9
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=1GQxe75yrw9fIeUcjpcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:In-Reply-To:From:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kkKXkaHiVwHFeTtq12t1/Zf9Z0FrNBJx40HZVh0CcXg=; b=1C1h287RIj9G1MTNAvlWvHaDG2
	LTLJJGchb1J6Nln1UdFrU9WEr06HiZsdZaigQ6RZeSYSGu1EDxG6P/yAYb58sNvpmNrYRNwV1N5C0
	l+wXpHwEM6gnXsxYOlKz+8pHMl/gpj9GYMgUx8PGF+eBNEV14QGTj0mvkoBmPk/m392JVX50U77x8
	OkNbE2v27wNZ44R98sa02hcCvH+NJyJJPjSKt2hNMxKH0P5ezPce5X190hJxHOMxtVRKoOPVajxHr
	837E2jHsh20RyvKOQxrRTlcc9stT5wdKgD4kQNokyX/RJd1I2iTSY8DQqeS5pyAvoblvyyN2goOgq
	Dcb280Pw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:49056 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rhHlu-000CFb-2Z;
	Mon, 04 Mar 2024 16:31:02 -0700
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240304211551.833500257@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20240304211551.833500257@linuxfoundation.org>
Message-ID: <dcc13107-8e7e-12c9-e9f0-d0fa96ea9c39@w6rz.net>
Date: Mon, 4 Mar 2024 15:31:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
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
X-Exim-ID: 1rhHlu-000CFb-2Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:49056
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLG6DbbNn+yyWp5jnYgb7OuOrwq/jbp4XlnGBSYjpySKM13BecC+ppTL5XyNRWTh+2MiriCWQRTsyF8HUwOqjZpLZH/WpSs9RLSh3B50482ot3gI0N40
 yTfCiHV6lKncOb+sHTM78CBkXRE2pNn/W18/0dGUYD6Nc86NzYPErkMM57SaK2835+4Qvg0aoJL3isDMH2ot8zFLEQbquWNpomg=

On 3/4/24 1:21 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.9 release.
> There are 162 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The build fails on RISC-V RV64 with:

arch/riscv/kernel/suspend.c: In function ‘suspend_save_csrs’:
arch/riscv/kernel/suspend.c:14:66: error: ‘RISCV_ISA_EXT_XLINUXENVCFG’ 
undeclared (first use in this function); did you mean 
‘RISCV_ISA_EXT_ZIFENCEI’?
    14 |         if 
(riscv_cpu_has_extension_unlikely(smp_processor_id(), 
RISCV_ISA_EXT_XLINUXENVCFG))
| ^~~~~~~~~~~~~~~~~~~~~~~~~~
| RISCV_ISA_EXT_ZIFENCEI
arch/riscv/kernel/suspend.c:14:66: note: each undeclared identifier is 
reported only once for each function it appears in
arch/riscv/kernel/suspend.c: In function ‘suspend_restore_csrs’:
arch/riscv/kernel/suspend.c:37:66: error: ‘RISCV_ISA_EXT_XLINUXENVCFG’ 
undeclared (first use in this function); did you mean 
‘RISCV_ISA_EXT_ZIFENCEI’?
    37 |         if 
(riscv_cpu_has_extension_unlikely(smp_processor_id(), 
RISCV_ISA_EXT_XLINUXENVCFG))
| ^~~~~~~~~~~~~~~~~~~~~~~~~~
| RISCV_ISA_EXT_ZIFENCEI
make[4]: *** [scripts/Makefile.build:243: arch/riscv/kernel/suspend.o] 
Error 1
make[3]: *** [scripts/Makefile.build:480: arch/riscv/kernel] Error 2
make[2]: *** [scripts/Makefile.build:480: arch/riscv] Error 2

The patch "riscv: Save/restore envcfg CSR during CPU suspend" (commit 
64e54f78d9f2dc30ac399a632922bb1fe036778a) requires patch "riscv: Add a 
custom ISA extension for the [ms]envcfg CSR" (upstream commit 
4774848fef6041716a4883217eb75f6b10eb183b).


