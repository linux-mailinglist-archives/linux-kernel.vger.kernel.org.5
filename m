Return-Path: <linux-kernel+bounces-35451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC01839171
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADE728BDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77E6482E4;
	Tue, 23 Jan 2024 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0ryTnrSS"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD221104
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020428; cv=none; b=k9mp1wPatroCbYAgb+A4m624Fj1KSWk1TbeBtSnU9sfKDLn9Hy98NXffRG2y7v8hBkZ++Uo5v2+0HpccuriD+n6tfthzLB7lVBVM10B8FivkAuE/OCsjWBJyls286KVx3Wb7kIkRk8pXh3r6131MkDY4HZ+Rvblc4o8k4aSarfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020428; c=relaxed/simple;
	bh=3mXdbmbZ+YHndnkHsHyyt2OtKuuJDhdZwwY3P3f+pYw=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=VSOOnGfLf8fL7C0Xv83N/TQfrcQqDavqQR0rOD5DP0J6RZGz3UOF5AS7yv2n0Wo3BpuuHhlgCCCIJf+pyIr1o28MMAsHJRLKe5LwH4ELEGPJX3QWIFJQ4OAAl7zuC7vyCfWjqaxZCPbl5XuOLbfAzniapwqKwkIN4pK9cpc3noA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0ryTnrSS; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id SBhJr4n1goMN9SHqRr1jTg; Tue, 23 Jan 2024 14:33:43 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id SHqQrEn9VfPBySHqRr2DAG; Tue, 23 Jan 2024 14:33:43 +0000
X-Authority-Analysis: v=2.4 cv=T+af8tGQ c=1 sm=1 tr=0 ts=65afce47
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=WDs_JM5VsrR4o8Qk1JsA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jrJLpiSrOO6NjeIfLfhdPqBjSqk6LOfDMkioxBUpNBk=; b=0ryTnrSSsyZr1DDi/+MASkc+NH
	N9/U2OSr6YL4t4YcjtaiOuLPBinhm15iiWVbIB4NV3SSd5VXLxXTnFNFu7BgNRiN9siP3RriCL+nq
	Yr4ZqTFskv9vKYY95NKvOUl53fh+KP2Bn1BraDfP2Swky3l6OthMe6d2Ur5EQ0R9tc4DLLMuwRlz3
	rcabFM6Hd9pLG+R6Fe7GHtQ4W2QkP4047XqSXoZS/I6fBeKW246Zna66AAlv2yJ/tDx78g45Tvo3Z
	hy8+mguIORnYIfSQW0buVc2R1dnNVLLA6eUfPanhwNwKM9h16XXp93TsE4ud39Nub484/jWLM3Bfi
	4QWTzoAg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:36662 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rSHqO-0049d5-18;
	Tue, 23 Jan 2024 07:33:40 -0700
Subject: Re: [PATCH 6.7 000/641] 6.7.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240122235818.091081209@linuxfoundation.org>
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <3a6e56d2-9c7a-6b80-e19a-1cca89bdb82a@w6rz.net>
Date: Tue, 23 Jan 2024 06:33:37 -0800
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
X-Exim-ID: 1rSHqO-0049d5-18
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:36662
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCkVoWGFGLy9F9xqP3hRk0exlcyK9gSGc+uxaDfzJ1zYu480+ePYFqIw3B+3m0s4GNiuTcO9pAzOyeeRs3WWYLTgX2kARW68LQ2kwI4HQkO5FfzfEzu9
 gEFDnf7xA5j82c0lxQm/YTzveoo5YZ//zESdLL6bkxjV2DGDVrItuzq/233I22UeYuB0/5cvg0LEJ/SOCbMFOR44nR4BybrD7Tw=

On 1/22/24 3:48 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.2 release.
> There are 641 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


