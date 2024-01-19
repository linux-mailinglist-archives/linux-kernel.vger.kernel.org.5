Return-Path: <linux-kernel+bounces-30761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6B4832411
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA0C1F22864
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832946A2;
	Fri, 19 Jan 2024 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="idP2yh0J"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E5C15D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705638665; cv=none; b=Y5TGUwrAD6VImiQcTS4nchFLyHcwRd2hsxqYSaHiVuMImUFDBpuiuFBGKstEe6b1Ok10ANzPNSbcOkL1Pnk/qgepG5ysGifYsYP1PyG0VRu5BKLibV/f0nZ3x5dH9FEya+WJohG8jHndFaOzt0w2nE/BJzLQebK8/b5g1f1bvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705638665; c=relaxed/simple;
	bh=yYYIxoLS/fTY0SERJ9JIVKX7ri9WHPUupunuOb2ocG4=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=ceY3SCW9hDHcjiNcBQaeOftIhEJLMFSOugzJM/S5bx0+JUgTrbxme0YII0seNEBdNsNN72VPipfKE2VLeZiUgWxDhmokIapzTl50MTccN/Bb4h5BlXxbEWTUuzDSGdjvyP/QqONZkMtkDVoBWvU1LbeQRskDXatnNt9bMTwtsic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=idP2yh0J; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id QgWKr9XzKAxAkQgXArTuox; Fri, 19 Jan 2024 04:31:13 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id QgWtrBQmnjqQkQgWtr8ikr; Fri, 19 Jan 2024 04:30:55 +0000
X-Authority-Analysis: v=2.4 cv=A7F/goaG c=1 sm=1 tr=0 ts=65a9faff
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
	bh=GOK2ftpeLzD+oWdoQAJCQkkPzUkEAfnVyOYW/U+5zoc=; b=idP2yh0JyCEkggwxJvTCl5d3Z/
	PqaumAc4o/AxRH7PXFAVR5nbr6TeqS/YcF1f3AGI9/fcg5bH7hPGoc/8B0typya3nw7jIzrtj4JJJ
	eJAkeBwLjf03MDZkmAhbqBF1TdyIpq1r/wnRynudHiJ8Gdit0nGXa4XvhSeQfj0D9oNChA2StyP4z
	6GB4hsRP82Wzb89VV83vTC6ibeXvn8ho+kUz6J2FgH3DC5zshjxg3N9Ljscwp6ndyu08yl/E67Nfd
	MLo1j8E+1xx9OCqPORTejm/DuQWU6DJtMuktHyMPK2/qrhhtzcbbBh7wUh2fFOkaw0PkpsjXUvqxc
	PS9U70Mg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35842 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rQgWq-000ehB-2P;
	Thu, 18 Jan 2024 21:30:52 -0700
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240118104301.249503558@linuxfoundation.org>
In-Reply-To: <20240118104301.249503558@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <69ce639b-0fee-6eb7-8f12-35aef792e243@w6rz.net>
Date: Thu, 18 Jan 2024 20:30:50 -0800
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
X-Exim-ID: 1rQgWq-000ehB-2P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35842
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHE5ClEISnfl6xrlTqbDqwX3ftpcGX9r8ZkWuFcRy/xtlu/tues+W0BKgK2n8LnC5sVCYHw4U846dT0VM8bz2QNI+cNNHUMVzoGHNiL/SXm2OxgpD6kp
 1Ci1H3EDRjqx1ypyHEGBgwApOXvxzq4K/VmhJ/NIgrYClabPwmbftEYvAzE2GWR4dBX3MJKA256A8IO/Bu3vt5ZqKffor66kdlA=

On 1/18/24 2:48 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.1 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


