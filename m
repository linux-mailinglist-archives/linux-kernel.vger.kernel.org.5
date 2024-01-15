Return-Path: <linux-kernel+bounces-25656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5182D430
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166951C2112E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877F256A;
	Mon, 15 Jan 2024 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="QMzHWDuZ"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C245689
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id PF4urxXQx8uLRPGPZrHhrk; Mon, 15 Jan 2024 06:25:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id PGPYrJ9P1yxR5PGPYr34MO; Mon, 15 Jan 2024 06:25:28 +0000
X-Authority-Analysis: v=2.4 cv=JYOvEGGV c=1 sm=1 tr=0 ts=65a4cfd8
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SGh2rGXhg/I9xC1yaKKd+q88bf2U5mstfEvj9cqUAYo=; b=QMzHWDuZuF6Izah3jDzEOPw7pp
	FY9tcAQmJXNcZJqMEw79cw9nz8SxLObx1Ayw+iVqJHFmTO7/25Gjw/VH2LcqB108wMg8t1EapWDFq
	bld5WX51n5UvvOo5NyRg3EOkcH9KtgaMmV7sOaZARMjeAaed/48ImUhWePJiEn05g9R93fE7RGLo0
	ZOQyY15z1HvB7cFwj9wf94Cxp9fMOPiwEErUEa58zpzt6+UwtSQ5zXDvwwidQlJQzXCn9IYVVrOPH
	nn53t/Rf/navjd/8zD96+a1Pa0cKPcxoU0vJ9UPxTTfgxR/gngukQ76ZHovyJCX7LNnFXLhdERzLF
	9AAzHsPw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35260 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rPGPV-002MRA-1Q;
	Sun, 14 Jan 2024 23:25:25 -0700
Subject: Re: [PATCH 6.6 0/1] 6.6.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240113094204.275569789@linuxfoundation.org>
In-Reply-To: <20240113094204.275569789@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <3d1a68b7-8e09-ed00-f48b-7967533f7001@w6rz.net>
Date: Sun, 14 Jan 2024 22:25:22 -0800
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
X-Exim-ID: 1rPGPV-002MRA-1Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35260
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKBkq30scbfLD5KyiCEwkVpSavsSw8vUWb0GGTsLQvmEv9rg5jZ97KY7K0ou90GwzivCEINtHsPy+5Yaz/+NYWoihP0Fn1mEfbSz/KKt7d43PzY+0m7J
 x7LxCOIT45RFvRankZ/hucYoTfTkju4xUrcmQGIvcTHfzBuqrDvgBkrpy7F4Z94YLofKDltJwfNGHzMfqMvXJ+qg2jV5x3uYz/o=

On 1/13/24 1:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.12 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


