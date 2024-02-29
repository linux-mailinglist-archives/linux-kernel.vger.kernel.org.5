Return-Path: <linux-kernel+bounces-86121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DBA86BFF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018C21C214F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73C38F96;
	Thu, 29 Feb 2024 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Vlse2Mbf"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BC383A9
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709181744; cv=none; b=j+271en4ZxwJCBgkvFj9JPC+P42Ax/DTT71ocjr3CrtpDrSm2N8/DF9CS2ze6RrXXDGFFQajACiivDZuvMfH0Quj1+zbVIPw+ULT7JRJadJtg/j31v2lAUiqdE9MDXj2zUo/MU7Qq0IleFVoGvRwxefTrJ1dqCLOlokwyJoDFhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709181744; c=relaxed/simple;
	bh=7MdowiYFtd1YVdbQPrEzPUsEd/NWiP+n7PYwa3sOkvQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=GRWeUwacwFM2JF2QPoMylZ95gKpL8vqi9WTGFB+mRYOIyh1mUxCfRbnNdgUsWzUKW7CFjFt7v71JU7TPNInyHplcRwgH4y8eem9VnLvZk5lsHrjuDBKYRh/VhHcsXhJc9EBa3AnPUIF7gBpdNl02GiHyc5MychBa9Vzyib6Ldv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Vlse2Mbf; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id fVfurrRhZl9dRfYFQrGs6C; Thu, 29 Feb 2024 04:42:20 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id fYFPrhcPi6b5LfYFPr0sFF; Thu, 29 Feb 2024 04:42:19 +0000
X-Authority-Analysis: v=2.4 cv=LLRgQoW9 c=1 sm=1 tr=0 ts=65e00b2b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=KyoLkmSyMt9Nb96WE4AA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TqFmvHG+z+uzSLFLtBkJ2F44Thyw1ppS6+xzDkfk1W8=; b=Vlse2MbfSBM27PGyIBxpZjHGEm
	oVkHIefNnEiXZLm02rVvzHsa4tT44fyy9Yz61F3jAQXRkS0Os7PECmol2zqTIngQXqy/T47yAIIKh
	pgH/bG+Mzw9qU0IHse/1hddYnq4ymyg7NIwUXRZlyPcTms6s1/Nx17Fx5AE3PVIumlE4w9z8kH7Gc
	8UkOCe2a8ZNwTzmOu76hRxzz7COyZ+Hk+5518UV/L7HaO5XrydVsZ9Swg/c1dWQtN8GVez+F5t0+G
	knhEFjdXasODBFd7AJ/ATe14kNViFtCkkNegExKSCqqfHEKZvwqk/FjuAyG8V2hm4Wl/ibG1966es
	bd/3UIdA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:48354 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rfYFN-000KVl-1E;
	Wed, 28 Feb 2024 21:42:17 -0700
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240227131610.391465389@linuxfoundation.org>
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <1cfaf521-fef8-bfb6-060f-8f69d96396d2@w6rz.net>
Date: Wed, 28 Feb 2024 20:42:14 -0800
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
X-Exim-ID: 1rfYFN-000KVl-1E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:48354
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD0YrEp3S0iivo7seAF9IUqUPSzDNSbzSFv+hMt4tRtJ53HtrxrmwM08mdSpQaQj071CT74uZ82oHflc3D0SO1LBvmbtIR/T5w/RFNCFKYVFN8I4lDjP
 W6RTEdln2K/7qiK9Px9VGJkqNmEHg/8hNVnM6oj35hx1UHNM6O2ff/oYT0Q4UxZW+yEr69dzSxY7HHS35PuJFU39sIp6mJGvkXA=

On 2/27/24 5:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.80-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


