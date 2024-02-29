Return-Path: <linux-kernel+bounces-85867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46986BC83
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9E61F2598C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B97F17CB;
	Thu, 29 Feb 2024 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="zZ9VfmoK"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8D15B1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165217; cv=none; b=GBknN5ku2XC1H3/ar4C5X4nBHrpMgMHB8ysHfei4j96lZM1MJq19zxvOzHXtpRTqszTOvGSdWRnQ9+d+reTvIlw/1kJLa6WsGvtVhzgXr7dmGuRuXC+mYcPXeRbZMStrrKet1VF9YRx8VKO7jSWHHzC21N/yRYAQQpuGxBG/gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165217; c=relaxed/simple;
	bh=Hnv/otnAsfc6vNy+N/u39sTj2ipyfCftgZFmMPzENQw=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=IMGyizfeyQsr0od5KtqVFk4C1rIgzU5OucSe5DmcWnoW6MhGRgsmO6Bf/uU0BPs7fObsoTxh2sWPK2wtopV6J4MW2ngIWCH4ixtMpmQrjKdlm0IpahKuknRPOZ3FO5zIjAqco/uezFC/HGzcFMmgUd5pOHanMvBFzIHc9RWoXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=zZ9VfmoK; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id fTFkrqr8Sl9dRfTwnrFJBm; Thu, 29 Feb 2024 00:06:49 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id fTwlrrD3TzReUfTwmrBXgl; Thu, 29 Feb 2024 00:06:48 +0000
X-Authority-Analysis: v=2.4 cv=Ic+BW3qa c=1 sm=1 tr=0 ts=65dfca98
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
	bh=g1vl0B9haMY9iM8RKMvJ67dO1Zo7xoSVRan/r6FUn88=; b=zZ9VfmoKaaNjuaZHADX4QbixOb
	BGcOnUy7Q2CIf8G0pJM1m38mUgdB8vDDkJ7KO1BCcyrMRhBH9cB7V1//qpd/KDWXhnPcGlm9rGzh2
	BK3v8aXK15JkGeExTdh5xqh4AWpklqC54GCO6VeKfEQV3CZVwQUJzwBUlsHXDZm3Zk/Hz4wtRIpes
	zPu7vW/ZK0KDPGAonBKdup/UM+vwDF0b07nnvgMJaAxXzQD35TNsEffUl9nT+jx8gJaAFrKC9cb9O
	eJmrFlCaXakN4faIbFBKw+kSnbV3c69uFLwIWVFFtAGkFo6T6bfq9IU1TmbTnJw7hxMakRJFCLM4P
	Ms+/y19Q==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:48316 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rfTwj-0035q7-27;
	Wed, 28 Feb 2024 17:06:45 -0700
Subject: Re: [PATCH 6.6 000/299] 6.6.19-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240227131625.847743063@linuxfoundation.org>
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <d63582e3-5480-e50c-fbad-95bbf639f9e1@w6rz.net>
Date: Wed, 28 Feb 2024 16:06:43 -0800
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
X-Exim-ID: 1rfTwj-0035q7-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:48316
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEJtHnqh/dVIgApXU7z2AJiz6YNZzochFabPUeH+N0B8YjBySzX11loX/IZgxO5YBQmkfkGmfj8JEV1dLWhsArOnUw/bF5wJnjMixlBgB8chwtCTRbQO
 ltFsfxHCJvKS+gNFvJi0g4en0ustTF7iGlWUhlZJoNx77Ntmj/gV9VBQmsSdlc1MGC+4Xf78TJsXdjEA+pJltMMyaoe6XxXwy7w=

On 2/27/24 5:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.19 release.
> There are 299 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


