Return-Path: <linux-kernel+bounces-136172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C076189D0C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2C6284D14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01313548E8;
	Tue,  9 Apr 2024 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="QFoHTJ4Z"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8DC54773
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632398; cv=none; b=kpN/T/3z5CTnLaCZ4fERMJfIVAg5SYzTAsZvKW9HnYSZ+kzEMv+dKGHWO+edvHd0KNpVquvYI9PJieFT97mmjJ6b0/nz+l0mw0e+IyRoMYpauEd4Lrq8+QI9dTYUe0akrVSl4X3Kjhfzk3jd8jEacJQksCpdLst5eqr8qepo8FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632398; c=relaxed/simple;
	bh=AGjNixSGJ5QwggZtom6Ug2ISD2eoh19CLxKOzqIHrRM=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=lW0n4nO4DetgpycxRH/fvmcHm7UAzTBs1RV5UEnApM+2ZIiHgnWHxzQU8E4V0iDYCBhdjD2hXYnXajs0xh4rrSikDf0Lte/N0PfOCXY4CKVAiYmqxqx/xusAIcojY/kJ6Sz09gysgr/EXwloeA//+RezWDLpC7D3qGhSmuS1R/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=QFoHTJ4Z; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id tr5lrID6Xuh6su1v3ru8Ge; Tue, 09 Apr 2024 03:13:09 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id u1v2ropZuELAWu1v3rTbHu; Tue, 09 Apr 2024 03:13:09 +0000
X-Authority-Analysis: v=2.4 cv=EfzOQumC c=1 sm=1 tr=0 ts=6614b245
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
	bh=1fi7cYYhOkV2FiaOiItVm/B3uVfPOHQmO8hDnH3nrqI=; b=QFoHTJ4Zp4MrGnF6VLVdHNBNJx
	AOWLfasXQdswhlrNGXazPmL0xr9eVUmLoR9+bfBhBvbU4Znd6p7Gxy6ro+oFrXA6dnrk229Z5Ks96
	MAfBFN1GMUkg+Cnb3rmYh4X+42E1nRzeXP7/W2JnGdGl250C8l8R23uaTYBRk0ot65rR2eMmgCZ6W
	crODtTJRtY6AxjmV1vBMQ6VJirANz378daNJWnWR3tAwQy/u1H08DR5R+RCmx+RPlGsa6mOdQv3Vu
	cHIG6uxmcBDtpnCzT+OoSZOdsd1WYk/Y4MTSx5Hh2dN0vqq8mRrIuH1RsRNobHm8yZ3PsMLTgOHy6
	lycTjuuA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:56502 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1ru1v0-003CRV-3B;
	Mon, 08 Apr 2024 21:13:07 -0600
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240408125306.643546457@linuxfoundation.org>
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <9715c616-e1db-7da4-8f5b-22def173735e@w6rz.net>
Date: Mon, 8 Apr 2024 20:13:04 -0700
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
X-Exim-ID: 1ru1v0-003CRV-3B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:56502
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEmuDe6lpTyTQmJ4MyPFdOfv0Or9gwpatfOu+1V8pTY3N0ZsbM9dZU76IkWAPl9xaEtsvdERkAIj+4J83/9IHagecnFETavJTDkdfoyJyoE04nEihk76
 EMDTIxBsW+wSQKw9YROsIIqyQM08U3QreVGi/fkklxiXAsYFWNBz1Ly+1eWgZQLrx7JjYf90JzlgfcfCFuL2ud30jzRcmW4zqZM=

On 4/8/24 5:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


