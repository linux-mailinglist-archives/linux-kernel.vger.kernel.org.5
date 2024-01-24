Return-Path: <linux-kernel+bounces-36611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBABF83A3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A5B2915B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA81754B;
	Wed, 24 Jan 2024 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="2bjnlo9X"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29AF171DD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706083736; cv=none; b=lu0hdFoIbHmTM8msxkF096aUdd46w0vuwV6MWLu4kHeH/VU2pB/D5F6Ha/rJW62nkJJKAXN3NgAQNbvLv1a10zTTajAPepIQiq23KNvrZAFDvETMm5KhQLCpqdBpUFcL0BgG2vdacs124VZRaQaHAh0GVjHJzAHS23iUWPaWEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706083736; c=relaxed/simple;
	bh=tjVRPp2Co4O6lcVg8LQ/3gjn1vR4oh5ntnSyXvu+OP8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=Bvbqy9XJejR/Bu3oi59DRhGSQLxRfwN+VRwFMeFv3KQrtLAYIMPN7zmYouftPf1RzEIDajIzVv6pN6hYymofQUW/zuha9KXElu7VWXXW1eRrbDFbYfMGZoHGABWLRxA0o/sDoeGgqBaAk1wJ48j+b5ezwAeNNDCwFcLxgKj8K3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=2bjnlo9X; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id SR6Urptc9MVQiSYJUrzcRr; Wed, 24 Jan 2024 08:08:48 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id SYJTryZp1Yjq0SYJTrBW0A; Wed, 24 Jan 2024 08:08:48 +0000
X-Authority-Analysis: v=2.4 cv=afxyIDkt c=1 sm=1 tr=0 ts=65b0c590
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=wAV19y9ws7N_jJsmqfMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mDJLb2MtZ3S/4kIFAcYBVF0r8/J/DLjrlxCA2XTsWR0=; b=2bjnlo9X4ih2STIWOEj2LUTazs
	BqieNQjeo4sclcvpgIANSZRBLREhqFzVIH/X1C59I4+lW3NDeJiufi8aPllsD5TEGBkniUADKkDHX
	FQFHqNenTC3E3d6e/BQNRIsF3yS7JhJy2gazgvRRyWfB0kyR89w0nc4snScdJAlNzF7XBDVOnMX81
	f6E2GztkyJKuFyRqNGayjK1NkYyVOIZXYI/Xwa4SiwVjGs22yQYn2HIYVwctQjlpT6AvSeJ1zk4xM
	4ZeDtsPzFME7bsqhRn6pPoeeMV3rUuCkA3X/oe6o2jmyTyDlhZqzCQ6EMdZ102z9FXgj1XciFYGFD
	ByiF52JQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:36744 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rSYJR-002UHK-1m;
	Wed, 24 Jan 2024 01:08:45 -0700
Subject: Re: [PATCH 6.1 000/414] 6.1.75-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240123174510.372863442@linuxfoundation.org>
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <103b7674-d2bd-02a7-6035-946b2cc8a755@w6rz.net>
Date: Wed, 24 Jan 2024 00:08:43 -0800
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
X-Exim-ID: 1rSYJR-002UHK-1m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:36744
X-Source-Auth: re@w6rz.net
X-Email-Count: 22
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfA4WbRUk42enCZFIJpmSYFjbDrhGoSHreM4aBsp8XnKvU/SUlIg/Vet3+m+6v6TGsaK5tZcih28qvrKWU3LRPpRaeS1FsF8xDVXDhr3ANvYz5pCZXbfI
 QRsMZ+g/gcuXPZmZIRvzHAUnlTuwUQshkGITJTEr3mzAjcFQRtvHJyvLGSH5uHyojX8CdvNcRZKEZagLjkInhvqKTn+1/eH+464=

On 1/23/24 9:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.75-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


