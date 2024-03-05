Return-Path: <linux-kernel+bounces-91661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCFE8714C8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56736282800
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ACD3D396;
	Tue,  5 Mar 2024 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="r7vEzZN+"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFF29A2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613244; cv=none; b=TEye48knTOYjNFVBDXfJGb/njvtex1uK2mCnckVh4dQOlH+jxgnrofZqzcxIa5dPy0AkTjh6HcOwXbCIEzDtsU6uFt8QJh8IBxOw6riVgR6t8jCaEpPnH3Y5eAWwN7ad0aNTTwu6cZm+hZ0TnQ1vvFtETCdYmSIzUPxCFnrakIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613244; c=relaxed/simple;
	bh=LSYP9zV2PV7yY/kRPK54E20dDGu/PRw3bWvf0AdCa4o=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=knLpadJZ3tlO6cvYNJbRK1SfDO0EfbbtmOA9Vb9Co1WSm+Nxd9kWy3agIUCG13pgKkgQ8NddrrdSfxNcBLPeKuqtDYmvKAFlD4qSP8GZu18OmdSqUNHR7YxkCxjTa+VfQJw4ucv19Bkf0wuiT0QYMQN0E0lND2UkMKXZZw5I4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=r7vEzZN+; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id hGDnrEUtYl9dRhMV2ry39y; Tue, 05 Mar 2024 04:33:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hMV1rLzgnREFhhMV1rcVBJ; Tue, 05 Mar 2024 04:33:55 +0000
X-Authority-Analysis: v=2.4 cv=cuKdkU4i c=1 sm=1 tr=0 ts=65e6a0b3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+E1+06gSmjjSc5vHL45spY5rfsJuiT3VvxAb7wh1LTA=; b=r7vEzZN++5MkHhKE58D6sSDwts
	YRjMpufiQrxadV6SL31SaWnUEOaOde5eVwlusoYVGfJ8Hd4tZS1Ap+AzAuh8S8757GPTjLnng7Zp3
	1J4FmTZ/EL9KBipPrx1HC7RI+iDL0lYHxJGYT6T096U1QQU4YZ54yNi2p/ZoaBprx1JNZF2VArHOd
	ZX6cYjOTbquhyllgcfhU40rrDtXB1PAjbiQ82o36Lgdji6ASn72yR/NGucdAEejjps5WvNsk5IaWK
	kXCyIQyRcFz7quW5M7wDacr7eP5O/mm7vIRSWJRrH5S/H3SiLzNWsUUKv40Am+WbCreK91I6oYkyU
	qcKveQMg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:49112 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rhMUz-0022Pg-1K;
	Mon, 04 Mar 2024 21:33:53 -0700
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240304211556.993132804@linuxfoundation.org>
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <fbfc8cfe-aeff-62fe-3ad7-c2894e1fcf2e@w6rz.net>
Date: Mon, 4 Mar 2024 20:33:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rhMUz-0022Pg-1K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:49112
X-Source-Auth: re@w6rz.net
X-Email-Count: 22
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNUKDPqgIkO/S3JDWnWB6Z5SL6F8TG0e3WGAR7tASyTIauK2lTxVbk6NA045s/9Gp9OcTDDdqwqryYquWXyayVmvnmXPPJHEqH/sXXp8dyq0lSUorlxL
 6lexJQuZ0tP8ef7l2facakyMs7n2NE4f7acMZpjFJPu7gFnMhmQSXTg55jgYc20z/lE0S17jBpFy3GJGNlze8fP0fsYEPZpCZWA=

On 3/4/24 1:21 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


