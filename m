Return-Path: <linux-kernel+bounces-136193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7F689D0F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93BB2836E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4A548F9;
	Tue,  9 Apr 2024 03:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="sn71H8Ti"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA1548F8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632815; cv=none; b=HkorHz5LULCphlolxPDSliyDJH8I+hya5xq/KQTSH9Ha0Nsfp3Q1sWFaITWOEI8zmD8lXRsP6s+jIC7m1Ou3GdO7xBfeiOQLaHEx5KRJB5++pGOShPl+AokrRgY8CT3DuNLwaLyyvb1y4r48OUfEYG4BhULjJaLn3mifRDoKSgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632815; c=relaxed/simple;
	bh=zfBNbb8TrnQTdLQDPS1GKKwODIujhLMGadxCrTZDCdA=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=hSpcDmrfJyb8QxZ/qDt+8OY6A9L+o69wpWhDPaoH6qjYUCqrwNJS0frbbphn9r7ZdHKEt89jKm/FQksp/pv+OrVjyp3TtlmBmChHrqA9VeMAAtE5mETOTw9aF71rYsb83KdPoGZKHoXMacX26TJ9UkX4vmEBxFeY0ITKy64x/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=sn71H8Ti; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id tiTprmDkbPM1hu21nrsjlE; Tue, 09 Apr 2024 03:20:07 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id u21mrwJwjiKqRu21nrthut; Tue, 09 Apr 2024 03:20:07 +0000
X-Authority-Analysis: v=2.4 cv=I9quR8gg c=1 sm=1 tr=0 ts=6614b3e7
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CJMi/Tnoal97D64JcUAlD29irEPkjmoW3B52pAAlfXk=; b=sn71H8TixRVoYLUuC7/ACfKZFP
	50tqCU0j4/TboCbbapbvD8H6TUNUk+uOP4yNaUAv1wr8b3ExpU6jhYwMow8NFqOB6wvQOb7X4jTU/
	LZ7AlWU7KDA6wP2aIPzRhphxFRLnJRXp19dFKa/h9zgIlWCQmsCj/gXA2ODOKEv8xFmU9i95H4l7M
	QriMbbrYJ8XMWATwY6losxFVTSBA9LobaIVCr5SISlvqwb7tFDMXQp/cy5Iq3JrXib3Nw9l2g3XqH
	z0G4r5Yi++4GUxxw/0u8j8TAFAskaKPnbGStZrmgdGvvbAO2b67McbwqM5MGVB2Cm7T6+CFuVk6Dc
	O4Gsh5CQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:56506 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1ru21k-003Eap-2r;
	Mon, 08 Apr 2024 21:20:04 -0600
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240408125256.218368873@linuxfoundation.org>
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <23256c30-b49d-04e8-7824-c727ef63ecfc@w6rz.net>
Date: Mon, 8 Apr 2024 20:19:58 -0700
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
X-Exim-ID: 1ru21k-003Eap-2r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:56506
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB7VooPnzQmJv0FloMWP/GAWMHMKiXScrGa5SlJsFuwrTrzhSyjLRJslreLaFxuqbZA8KsEc4q3TyodMsK8XcCBVpyW2tIji5JFDAoUI3nE5fmP/fmAJ
 IWQei1tTm8Q40i8OKqG7zWfq8LriUmaCujFYhcEJtBnOdcTQ8RrYIR6ggKzCMnU1NgKVVb+2K3W/5gq7+/Ll7SE6bJr7W7M4aAo=

On 4/8/24 5:56 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


