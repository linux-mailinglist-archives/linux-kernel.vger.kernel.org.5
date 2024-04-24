Return-Path: <linux-kernel+bounces-156544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5E8B0452
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA52B2420B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762D15887D;
	Wed, 24 Apr 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="s4iEImEd"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2012142E6F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947319; cv=none; b=j9G5v1yaRJjz4TipA8hAEqVD1wXH0w83Au3s1z/IcNhWWBm+eLEAa2dWREkrwfsUgIWgAbEGKZUOKRolVxVOC4haMKkU7m+Uf3qIB3aC0Z9IfSlJabvGHTkEzgaVDF7PEoOw0Z59ImmG2p89d80k/YhowMvbwENO0qsOV8tGQPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947319; c=relaxed/simple;
	bh=KYTWpKpv6oeY+/R5jsWkNe5xS0x8WQ750NNzb1M/t1s=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=GNGaYZcmStQKBo2UU4Ogeqf47NfpTTZ6P2AZz2ZajsZHMtx3qfx38XhCbivMCbnxuq1MA9+Z20JIRhe0IBRTbaZ9bAz/hbbSDQWbZsvrIX3i4y/UDbwzMIY+DxmofAJbJJYKd0Zn742lzcc7IdYvRJ+PtEo+Z2Nf81qfjn8HTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=s4iEImEd; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id zVW5rR08pQr4SzXzXrGraf; Wed, 24 Apr 2024 08:28:35 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id zXzXrUUXqELAWzXzXrd2kd; Wed, 24 Apr 2024 08:28:35 +0000
X-Authority-Analysis: v=2.4 cv=EfzOQumC c=1 sm=1 tr=0 ts=6628c2b3
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=CMKPsDBNFkSOfaRWdswA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XmzQCDWatu9ptYK38PXzDUgh/4x84Gi6I78nuRqijYU=; b=s4iEImEdmvB49yeN6d7uUi+WWd
	/vZK1TIBC4UjmnyWPMXjHpccX3As9kP6cK/gce8abnUBoXEk2cycH1VoyN2mcG8M03tOl7zTmsmfs
	ilQGGkWzU7ldd/k6I2Vs6yNgydkKgTS3onyWHFjPqXdjrVCVyWBLcXSwIw7+00d9BNrN1YDGwagrY
	WDTKY7qAGjSaPkMrS60kJCUhRUrDkcv9VaFGVyfkO8Qs7w9fnbtICd00v8EgnUERems9cgc8IJiMK
	qUlwqZHY+BlyQYQGYNtgm5/inySYJHmq1k/GPK6ObS1Fp0NOgheHx6hfDxLctVv3v+ym5wjgKJr+U
	itBvOukw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:59366 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rzXzU-003d7O-1R;
	Wed, 24 Apr 2024 02:28:32 -0600
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213844.122920086@linuxfoundation.org>
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <da2f9f9f-5a75-2ce2-22be-ec7fdd97f6bc@w6rz.net>
Date: Wed, 24 Apr 2024 01:28:29 -0700
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
X-Exim-ID: 1rzXzU-003d7O-1R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:59366
X-Source-Auth: re@w6rz.net
X-Email-Count: 61
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPHD3eWWij92D88EDD8nx4jlaUA1g5crmT012LbBzFLM/t2CZ0Y9dZoyG2MmTs8OJaBaKppKgd/ym8C/Oz0LvZtRWi+bLQABqooXLkqHFo6cPjAPsG2H
 vbP1cTGkXgQ7PCq8lL5JJKQTnBWn2qFKqGtuJ4wYH0XprYaq1/xkPCnaLuR6mDHjICEGEhaNmXxXcS9AcxiJZ71QZKkvCyyEXyE=

On 4/23/24 2:39 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.157 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

