Return-Path: <linux-kernel+bounces-76538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B685F891
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6161F25A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F5A134CF7;
	Thu, 22 Feb 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="vmWozsG9"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A003134CED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605965; cv=none; b=fG4h5ceJZQ4zahGhjx4LDWlcyg88H3q9Emd7ygmLCjTqDbsgEAaH0XE4IT0LXTYOtB+UwcRjF92crvp8NKt1K6dZHkTTEOm9ysVCGXQqaSmQdSkmaYEU2WEVuho/APGVnLM81IB5/YoI5oZOFvNVLnA92wJXU3Gk6sCyvdgxP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605965; c=relaxed/simple;
	bh=NnaboX8aXXb197A/dlZOhBBisyfGhcUct3ugFaW30qI=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=iICd1S1q/mR5aTrD1t4rcN+F5TpNqVSb/wQtfN4PsQYPnksJlX4kd16d7wZiGT6GXqKu3cd9ynQcKCw+thm3Gr5VOokCmQM8F81g2X1FGuU5BH3QVwDzT49RscwOZ9VQRUR+RqngYm1djxjRR2OiywglWh5KWoh1dlhoElqlvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=vmWozsG9; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id czgkridbZrh9zd8SartPpg; Thu, 22 Feb 2024 12:45:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id d8SZrzHnQYvf9d8SZrYSyH; Thu, 22 Feb 2024 12:45:56 +0000
X-Authority-Analysis: v=2.4 cv=UOTbHjfy c=1 sm=1 tr=0 ts=65d74204
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=QYZglItAVTj7tyxopZAA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I6AoeXe+ErGVFuvLrp2KUr3Wh804qc4vyrXamwgnRh8=; b=vmWozsG9R6omVfzqqagL7WZ50e
	H3BYauv3YL8RpiXDdmUX5c76oZBkc87Y1LPGZEmwsBGEqLjyFpNN1ACknizyth19A3F3ruevlfpAp
	bFmCCf00fR8VJsdU8ECQynmOmqcgDGaYc1D41dhxI9MvQVMaKImmJxEtpbdYGwonya0T/ovDkvc8v
	wBdE9UJxES7rsQYbDkslUGTi+x8cGo4f8zhVvTDheWhXrqtUjMeaUzyr7mO2CYXluL5YjeC0STdqx
	3yRRaZcwrKwBzGohJrDJR0RAzT5BPLsHgn0IsbS+FArceT5/RmA0IzvAUf+zRPcbH8C6XXBJYKSQF
	ZDzq0nOA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:47348 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rd8SX-003IC9-1i;
	Thu, 22 Feb 2024 05:45:53 -0700
Subject: Re: [PATCH 6.1 000/206] 6.1.79-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240221130223.073542172@linuxfoundation.org>
In-Reply-To: <20240221130223.073542172@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <5539c3c8-99a3-8f7e-72e9-0416441ffafe@w6rz.net>
Date: Thu, 22 Feb 2024 04:45:51 -0800
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
X-Exim-ID: 1rd8SX-003IC9-1i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:47348
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC+mxES9MJBrmyrMCBawGSZxAar1NSFWTuQ++wMkDGlHlNKS8tVuLoR33VgH9/GgwgK/I3CTzMg6fncPJLtLEf13gl0u/miboMYWR/Z61QNxHTdrfHDa
 1L+QzLuEOM1JLUxz2pBtp2lZva7EteFoF2geCC0XAPVoHduinelH516q6EcvsjcUZWJ1XuFRK3UXNnRBHCiXNKQyC8Q7E2ZsFVI=

On 2/21/24 5:03 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.79 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 13:01:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


