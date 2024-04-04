Return-Path: <linux-kernel+bounces-131073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105BC8982BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD36728BC4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466915D73B;
	Thu,  4 Apr 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="FX827ka/"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC622611
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217821; cv=none; b=My/C96WXwv/5vw49ryaAHQcZVjI0zIT23wmto37UaFhax1753IeJtwj4O1T8LkNm0Z6SjXHhnR9FaYKrDb4t56g8Anec0mxlJeOwS/Q2zjVpdC/VOfdrq6PVRBNhrZP7kcKWdtceSnsNQLmsdTS7G1hzmMrSP5rA6olgsXRfTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217821; c=relaxed/simple;
	bh=tj3M/Wu8JZzMW7smqWBNhAePSPbMAD3jrWaLvqyo/yc=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=Nh4nkDePxpXb3YPDWUHEQF9kgP3MZkVDAKX8jl0pgO8/rcmL+Ca/NIp08NPCFXchZfK1+n33IPQS8q2Cxo/HdnwWqO+BxupaZlDzEI1cnzlirSa/c3+jgZ0B7eSkYRt96awRSPTPmLKv9Lk5Xg6aDFDCqYeumnBKZQ3e9DidL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=FX827ka/; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id rshvrEtxpPM1hsI4OrAkp1; Thu, 04 Apr 2024 08:03:36 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id sI4NrQJxl9zHMsI4NrtFdR; Thu, 04 Apr 2024 08:03:35 +0000
X-Authority-Analysis: v=2.4 cv=fo4XZ04f c=1 sm=1 tr=0 ts=660e5ed7
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
	bh=R0qGoWJjV+Rk/S//N/+Zz9RU3rwqp5Swoht54vlUyRw=; b=FX827ka/bB0wwIbbrEBY4YiY1y
	0heQ+2aiYbM9ME3uso6g5v5zEkNJb2NFeoL8NAGkGd5C0yKj+dGWWeNroXR558HgJKhf9hzuowK1h
	O+u+SJIt9MiV3aP/VpuZK2NOGsd7RXCDK0L1QG6s3WaPpPwc0CUTCG87RWTFwsS3tBXOzKj7I38EE
	jJY94PRjT3f8oQUr/LcNwGJYFsALTLCHLRNV5qMOXgBlJNTOHlYVAgyk4fsJCsUjCk3Dx91ehcDOK
	5XjC1WrPgacKy9dZ8BGwTGyyu040wwe0hIHvAPFv4TZfNVC01bTzwwzVIHwxrhjg4lQFceAGA303d
	HgCupMvw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:55676 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rsI4L-002lEz-0f;
	Thu, 04 Apr 2024 02:03:33 -0600
Subject: Re: [PATCH 6.8 00/11] 6.8.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240403175125.754099419@linuxfoundation.org>
In-Reply-To: <20240403175125.754099419@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <63e194fc-07e4-bced-f0ee-7617e0232e54@w6rz.net>
Date: Thu, 4 Apr 2024 01:03:30 -0700
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
X-Exim-ID: 1rsI4L-002lEz-0f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:55676
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN/sgnYNf2WitfBKrZvYJabnXi/qJ/zh6sulrottkMIt43cBdIJgEUhg9Kc53fNZTY0Inw3s3/V7fm4fqwLSSj5i6/uVbV0RnPLrMFSs0nm0gjsWIvlL
 ofCIpxyfjpikzmxzOILS3gA/5SN5spWuEs9QprcbewToxSkhTUCSEanbtSlQZI9QD6pEjt0vA71Xm0pQGDtQkTS1QCxs03kUlpo=

On 4/3/24 10:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.4 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Apr 2024 17:51:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


