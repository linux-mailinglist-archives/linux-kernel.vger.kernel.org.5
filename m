Return-Path: <linux-kernel+bounces-142140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB138A27FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8582285012
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC1A481D5;
	Fri, 12 Apr 2024 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="BDiYz7Sg"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782C46BA0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906947; cv=none; b=SJtI1MVnkjLlJAHOG+vNHA5lKBBhni7dwfQ4ZvWpsYVI5YQ6yrpt6nmlhenuXEHjSGyLA1cSfUaA3IH1agWx3MZxn+5UzSy3OK1sFoC+Bptis26N+II4FDAJi9wPmKer0dYwUiZ5su7rlPz7eiXjEEqz5nrASVKoji6sgSh01QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906947; c=relaxed/simple;
	bh=uzcggq3bPd+3RCETDBjveHXqWyzHjC9KuIoQbL7oXgA=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=Qcg04fnUg2FFvaX/gjr+dcX4MxYHmg+CqCpKXJihaew29+w2wocS/4q4G4cxyUgtEI/zXeb0a/lNkkAduCpTvd9M0D+KSEFHHmoGB1CDnbQleVDRBeuHLwEoaarlz5dlW7Yyt3pWNnHNo6/Oi2KTBcHu5XIY6eZ58PMDGkcVVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=BDiYz7Sg; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id v8QkrTfBQQr4SvBLMrFRvy; Fri, 12 Apr 2024 07:29:04 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vBLLrXrSDYakKvBLMrwBcL; Fri, 12 Apr 2024 07:29:04 +0000
X-Authority-Analysis: v=2.4 cv=a4T79lSF c=1 sm=1 tr=0 ts=6618e2c0
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
	bh=qM1J/xum7Nk8e7ghP66aqhE2udMt7YLdiWs6QHw2XS8=; b=BDiYz7SgJGbXNnPEAq6anlV1vl
	8752FD34m1oMUbIAQnpKjea4a0LHnQdUfC1fdlxK2PoYaAqL3UEk7la7ZFXdE2BwfNKFoFtyNl+Og
	7VBpuLTfKfIY7yMxe3ThcfaKwPuDn5aTR0/8d0SCHdKBG2sGDjDwc7UPYn1wEVx57OBE6GQJTHaqq
	E7vibU4QbEq77iBHMyE2ZYSY6/8yiD+Wk9paBGLILVFYdA1RBckvN6eLqzx5e7HKrsbHJVyx2KfS4
	7zl4ypzAPjO6cFnVWVyP5j0O1Wjjm2au8mggQuNs7EXOYT8EM0XQDb9Jjg5mBrZfjZEnyNZKH2KcQ
	4bnzXIZA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:57268 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rvBLJ-0024Gn-2u;
	Fri, 12 Apr 2024 01:29:01 -0600
Subject: Re: [PATCH 5.15 00/57] 5.15.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095407.982258070@linuxfoundation.org>
In-Reply-To: <20240411095407.982258070@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <333f1778-6568-da30-b4f1-7accba6ce725@w6rz.net>
Date: Fri, 12 Apr 2024 00:28:59 -0700
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
X-Exim-ID: 1rvBLJ-0024Gn-2u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:57268
X-Source-Auth: re@w6rz.net
X-Email-Count: 61
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKWdMdfxYxiW6Bh2U3udjSSs5SX3NFEJZiVKF57kvO83uybNfbWMSdgaiD+s1peV4BzgRIaPdihtDI6pOYeowySW3AXOV94Qa7HtlrCcM7jZOM1Ah7Tm
 FemXsDyNxB51H5wutFHurdS+sxhjz7TfJ2bIf4/aUis/O/G6zrQBKm1WaNrY3+lW06NA/XKGucNDQJv/AoWtK4rny45sOv/eaFk=

On 4/11/24 2:57 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.155 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


