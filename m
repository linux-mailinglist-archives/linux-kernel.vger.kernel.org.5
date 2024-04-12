Return-Path: <linux-kernel+bounces-142123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD4A8A27D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DFA1C2288E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17744AED7;
	Fri, 12 Apr 2024 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="PxMZz1sG"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07B44655D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906379; cv=none; b=mkd5oimaoSWxoEn1SvQLOEjB9pb8Mnl2NFeewUKPLKpV2sfQvj+NLGsRlM9Dq5KJaRes+L+oZSXBrTwn4++MBx+b7++2u2lJ2sNQQi6uILMJ3NSJvOyV7meNiJTjyKjx2ETjYIutrFSS5e64xbgyuI3Eaye/rPf35AAjhJRiG7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906379; c=relaxed/simple;
	bh=P+oIJWXoygu+79psh4GhWlOdWTMBzVhMLEdsiqusZIg=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=m8kMbNm9i75oBy6qSRiHkXH+hYhINlbBEck35vZjNYAHG1B1emDc2TppfLcNQByBqcqBUQOw6dG9aV11NGXRIjLW9YYYPOVwqPLvuOosNlT7YMavSQ8cWv0gXJK2agcLLasNtLLIZPCU/qjr2UHF7N3jT8M2d8DG0pkau0+8N/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=PxMZz1sG; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id v8awr32H3s4yTvBC6rjeKe; Fri, 12 Apr 2024 07:19:30 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vBC5rwaSZsT9BvBC5r7EY2; Fri, 12 Apr 2024 07:19:30 +0000
X-Authority-Analysis: v=2.4 cv=LIutQ4W9 c=1 sm=1 tr=0 ts=6618e082
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=iIpkR4LGDAw3iw8gTDEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D5hOZbDu+R7aqvivr6F7HuDgafxA/2SSs6uG5uwLTjg=; b=PxMZz1sGDAXvwuhOoqEOQFDk3X
	VVWpDvUUhpuUbsWU228n9bNrnkZ0gJI02IUDlApaRo9F37kE2Hh8YZpSGvCieHUKDu9/B3EvGuO1C
	0P9K4z4/HGkl2ekqa+Q0WnaYB8B1Ieq9GiIdGHtxOnzcGsDUINp8FHtcL/5qbF6yIyUM4iPWQoZG2
	1swhqGxBCBnYGyOsjAvYvp6T1+8XWRTIj4bdZkxoomo+og3exsA5shuSmxCYxM/Nwf5xLP23jbw5z
	APW7E5NFX83xPYMg40fwKvURe7lrD9mnWP+kk7MOCMyUsmpeB1Ql+w5sl/oQq6JoNiQ2xbGghVRm/
	gdS/dnYA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:57244 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rvBC3-00203a-1J;
	Fri, 12 Apr 2024 01:19:27 -0600
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095420.903937140@linuxfoundation.org>
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <3c603358-e4f4-d37d-1d0b-97269706697c@w6rz.net>
Date: Fri, 12 Apr 2024 00:19:24 -0700
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
X-Exim-ID: 1rvBC3-00203a-1J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:57244
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfM2JgujSLyDQvTqDvamLq7jTsWpTfD/3rKwf3al6MyTjAiv1e48Zi+7dAb6DqHbujAgb8SWOrrsk3oyssIO8VDgGA9eHEfNawIsKdl4ZQw9IG0d5QCfK
 avVxO0bwRcZdM8vFHr98fe9kAy7k4JmrbJvvrDkJAfx4n/qYDJZiKdwe5GtypY5QrmuznIg74wVhtcaR8dirwUdpnCHa7J1gF0w=

On 4/11/24 2:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


