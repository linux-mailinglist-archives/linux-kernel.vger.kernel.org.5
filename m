Return-Path: <linux-kernel+bounces-91683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8328714FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF0B1C20AE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2DA43AB0;
	Tue,  5 Mar 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="hz/36iRT"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA2405F2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614340; cv=none; b=VsGmsWXdEBzA9uARUZJawMgOTR5AdFvfJb2TeQ2X0GYyM0SUpaD/WotGqtJRW7OXRC55uJGxzl6pfsWd+pxQA2mVkyUOd7L+kQznMXlFi1O/Z/sIpXgpUjFV+evaMXalCvm0MFpnjdqvzWSZmYdqkimS4dKoyHanTGhcmjlytxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614340; c=relaxed/simple;
	bh=w3O8uUX73BTEJvOPL+efjeBGcno32i6iKCcSt1GCKQg=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=BI0JpmQSALZo9uXIZmAB0Ol8NtANL0GejQmq+ll+dMrDRvCrny153sHpRGThJV05LHYuCWgiYZ0tkxkRtRai4KRQB25ybosX6Om1oMaA7yQqn5mvPyrLUt3Q23cwkwUouYaDT5rDPWmHL/dADw+rgskCFdmr0hY/lSol7W35g/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=hz/36iRT; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id h5fNrBTXbl9dRhMmmry8Si; Tue, 05 Mar 2024 04:52:17 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hMmlr1hkTlNyJhMmmr26Rx; Tue, 05 Mar 2024 04:52:16 +0000
X-Authority-Analysis: v=2.4 cv=PIAJ++qC c=1 sm=1 tr=0 ts=65e6a500
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V1Xln7kK5ZI/Vh2KFk42k0Fn0oSg/W2AndNWe6uhYOs=; b=hz/36iRT9l3kg9AkHwwl2kwG5c
	VzIQQqCTOSa5K8+BY/xdlBPH7M2XRxUFBASB01wfqyNUU0bbseRGMy7mFLZ8o8WtvI0WKq1nMo7Zl
	n577i4GQh0jZ4pWNMQEVHT47cGXY0pdQjayu/nSCq0IGnHgjRJskd3um7Q23iTmDbQWrC8R3BQLXV
	wInDaxbJFxm2PG1r5lkKcBbflArZgbSsgKBWeCj8jKQGHmiyQmcyBPxZs9kpmn/3xy7E0/RbdPbAh
	uCrZ2e1zZUmmOxk9JqTOnBg1jTopxxlTmRbdfb1db7+IWX00BC0GhZ2VYHSqkmoz5gdsBuuTbclwQ
	CBcA+KtQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:49132 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rhMmk-0029v2-0g;
	Mon, 04 Mar 2024 21:52:14 -0700
Subject: Re: [PATCH 5.15 00/84] 5.15.151-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240304211542.332206551@linuxfoundation.org>
In-Reply-To: <20240304211542.332206551@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <6a518ca3-aa91-2ffe-3ea1-c6dc5b594320@w6rz.net>
Date: Mon, 4 Mar 2024 20:52:11 -0800
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
X-Exim-ID: 1rhMmk-0029v2-0g
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:49132
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEjxp6Wm6haSsSQNbbuZ12FcHy9WHKkxQu7vrLBTXtdUycHkUbx+qOektFrAgfUXdmR6IWIeNEtQAAFKGYEz65s3j4CfKnqCYfdU63UvaPwpKfuCT+yv
 XBd4lRWIHhGTAEn1gp+yNpRIpx5G/jb8Pp2WZvTWZOfBisxG+wZFLELt53rcNI4SGgoo5p6OavSay1bfAXDz2QGzlA+H8zHM3UQ=

On 3/4/24 1:23 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.151 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


