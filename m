Return-Path: <linux-kernel+bounces-84283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D931786A48E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FBA1F23AC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B02111E;
	Wed, 28 Feb 2024 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="n2Yibytp"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE257A23
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081393; cv=none; b=FMRwBzhopxlO9UYW36qcjxxjLXquw8O9+s5w1zVbV8VtFWSPQ/zGzh1rOWdL/e+DRrZ9HrYN26M7UhU8FRU3lNr/ijfJr0esfut4aL3WQoKZUAXiVFnR6uftpEbJi61PGSJjL0flfZQJRGwOCANvqbmwUD9JVIN/3HHSBpQOe54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081393; c=relaxed/simple;
	bh=AJPIpmjeaInQHB01RZF5ZU1nHM3PWmVoh0vs7h35A1U=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=ezUOFO0wcUfbdJZXAzNDFrjXlcVyrRVLC58RZbrrIIioztcoePFzBJNoiM57JdPsJ/oqGcm+zOC8CoRTM7i+45yvVX0R1UKnALDkPed4RoffjWhjKVDZumUY01Pi0GK3lzW9TDdAYvlbpPhLsiuo7wr5iF/UvrE9Voz1BACrpsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=n2Yibytp; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id f3UZrdN03uh6sf87KrHUhp; Wed, 28 Feb 2024 00:48:14 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id f87JrrTHYMx6Ef87Jr76tl; Wed, 28 Feb 2024 00:48:13 +0000
X-Authority-Analysis: v=2.4 cv=EOMA0UZC c=1 sm=1 tr=0 ts=65de82cd
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
	bh=035y5fzBy+OFW5grlBii3SIEJYQxRB6XZGhrXsV9Bok=; b=n2YibytpIZ+NHpkGnLl1Gadu8Y
	K5vxWibXBF6P+fLKbLGeBRctmHu1QJTBeHA1uzw/YGAHlXlS4n3s85LZdlb5WaMA/xF2B4vw0qiac
	bQkhV+wTMHeCJW2p7V9rXzAXmok/q0DoUamlzMVRcYAUqNLKiiyGWqUTAlB0p75o5zZ2waMPGltLJ
	Z98a+LW+IZ37RbFZnLZ4Ur63XNCv7AVtSfbIWWwTSHiDrXUzN/CNe0/o8pQofUXMJMwhpT/FzZc5k
	OebJZ0q3zBcb89b3ezYxTKoU08WSUKFzeuqPoiEod3GQExNI0ueNFfObfNsxE7+V5DLdLW1eQtFZr
	Muf3wcrw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:48182 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rf87H-003C44-13;
	Tue, 27 Feb 2024 17:48:11 -0700
Subject: Re: [PATCH 6.7 000/334] 6.7.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240227131630.636392135@linuxfoundation.org>
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <f3bced01-facb-fb34-655e-0230292e686d@w6rz.net>
Date: Tue, 27 Feb 2024 16:48:08 -0800
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
X-Exim-ID: 1rf87H-003C44-13
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:48182
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHgmVK8rmxbze0UcMlQ926S1khoMg+ecizGWKKyHmPm7+6VnUlw72RH4NI08E1e5X0vWsjnrrL64ipfN1H7P6c6Em8u7N4cRhKBgKhftL483gyUGcht0
 c5MyRBXrJmoAD+S+ZegSXkBPUK3F5hk0Dye7Vqd2ruKh71rRGCK3n8W7Yd1Zex6cM+4brvP/B8tsHzkg9oh1RivTURkcllaLZEQ=

On 2/27/24 5:17 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.7 release.
> There are 334 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


