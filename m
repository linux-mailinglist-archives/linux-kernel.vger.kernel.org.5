Return-Path: <linux-kernel+bounces-52286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B455384964B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552671F22F95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D61125D8;
	Mon,  5 Feb 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="laPnRj03"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED5A134AD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124834; cv=none; b=NujCowgU2X2Rq3j/hUBD9pJqRfHCvjRGX8FVHoBmMUFn4VtkG69oguBODtN2fp26ZzYk07lBzspxnZ/stGJTSkevl8glXZFla7JyNc6hersZxo6PgWV5EgcwKkxSDTMOGu3TQmokeZq2eTdFPdq6ObSWmz68n2sWRkkq+NNUDXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124834; c=relaxed/simple;
	bh=NwogaMO0Mscgp5dPQGXI6QGM5Bvcz7JNBKciEMJL4J0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=fL3IM9XfH3tOOLHF0ZLJ0ngbJ0aimFrjIoO+JOlKDDE5qZaZ3khr5NkNp3cM3dA097GPuD1utir23/JLUJJ53p2in43VuJ/vgK4CMEfOrkCiBKLYpqutnkr5vRZWghdRA22OmKvhCOc6rC2O5DZzSbC7t3pLbw+rnNtRwooxF3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=laPnRj03; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id WEAdr2MTs80oiWv9MrbnW6; Mon, 05 Feb 2024 09:20:25 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Wv9MrzcpKMcKuWv9Mrw7Jv; Mon, 05 Feb 2024 09:20:24 +0000
X-Authority-Analysis: v=2.4 cv=N+WKFH9B c=1 sm=1 tr=0 ts=65c0a858
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LpCdqv870RknWCK0Tx5X1QgGvnqvpACA8xnj6UMA0I8=; b=laPnRj03pr/K8rLFEFooMnxpkO
	GLFhlyxQ7A9dsjjOxNi3Y8wnXzj+QgCgnBWVCnjl0RZwM1CqcMNbbbeve7vx//vsIhJJniI+/k4XL
	xIOvEd2kyghTWMhRKijf1ICkRJwT6+0ebIMgmcnEVeY2lQDsI/6MLaRYmUlCZ3DvVFo9H76BvBG1m
	IIXq+1dBskM0AIEmc25rClAXwxA6kepfBMeZzuGkSmu3U4cQ6HnkEaxI3uEfowJD2mmoutN1JSopk
	i/AZqdq+zjomgPk+7wD9dVHJMX6RMWyO3XT7DD+I1im40KGD6fvDanPcpzT5GNW1s/Q29RY24NeEn
	NvtIrQaw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:41072 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rWv9K-000tow-0Z;
	Mon, 05 Feb 2024 02:20:22 -0700
Subject: Re: [PATCH 6.1 000/221] 6.1.77-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240203174756.358721205@linuxfoundation.org>
In-Reply-To: <20240203174756.358721205@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <fd4114fc-6f4e-3688-10a7-44a6cc567676@w6rz.net>
Date: Mon, 5 Feb 2024 01:20:19 -0800
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
X-Exim-ID: 1rWv9K-000tow-0Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:41072
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFb9AEJP1USokYbDHIa4ScRycgiZVdNv0ETbEY3buHNgwdFZbqWzTOv9SaZbD28gnC5+rIs7NUGM+eLU6XCOKmnPj+JZKs1y8DvD7u6w49azdZ5Wk21r
 1w7ppYZjKr0hQEMUxRX/NUCAaaO333TMGFCKts3EFhnpAFEKB4TgVwTXkEN+YYZ6v3ss6AKSBKPTzc2UfiR0ZyohzxRhzGs4D3k=

On 2/3/24 9:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.77 release.
> There are 221 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.77-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


