Return-Path: <linux-kernel+bounces-156534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044D18B0434
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B582840DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61209158871;
	Wed, 24 Apr 2024 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="OK2tUl42"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAF329CA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713946988; cv=none; b=s0ullyTiyD6fLy9lP4ELw6f9Tq20MYumIyw16k7xsMGkWBu7QoRLy/oPoHCjPJsLncXdGLTW+fWdtCHhWnoYY8MGi24RCp52MxRr0OtarjW/8wj7VzmTuNEd/JPFz4uth/CBId+d9tF9eUWoryDInMV2whTEG0/8xvszLmDVY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713946988; c=relaxed/simple;
	bh=6QVLhBAJp84waL6ZUmhf4vEiQDIz+a6xaQzpqeWyOz0=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=cJn04liH4A5HpEWRpBAGbZ3d9ZJWtHzIiufI2Eqiq2gzVIE0ook+5Znqg9H0jCWss/V2l8suVA0uuBfEqp1x7s6g9IQVwUpjZiJSv3tQYWMml+5tLsxErSHD/lsbdWxYsecHMYQAE/iWvNYNryIJ4lxPpHWS/HHyn9IOhbUw7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=OK2tUl42; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id zIJQrBA6CPM1hzXuErUMPP; Wed, 24 Apr 2024 08:23:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id zXuCrYh5MVdenzXuDrOkgK; Wed, 24 Apr 2024 08:23:05 +0000
X-Authority-Analysis: v=2.4 cv=M4FLKTws c=1 sm=1 tr=0 ts=6628c169
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=CMKPsDBNFkSOfaRWdswA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TbpKAwI5ZCWHUvqoKmQdNYHV152Vc+5IbI4Iy0iPG/A=; b=OK2tUl42Nd5DJlk2bDu9dyqbVT
	YLL9QYv9eJIwnvYM8KPWYxYTwi5+BCm73nnaL9/35BeSQnudEXgXIxNPXrByRJYcvc3W7HJedyARd
	p3ESN8AW8HAMcxhb9Est69v0v/rNVoRQ+0egbLwHuPPyVqV32qZgYRY5vfD6QzspJDR+Ac0U4N2fw
	5X/u3Z02tnCv+I4Sq+DBCpS9KJGVaCECAnjCQssIsECQlrnwnmHnM25J+pH41+cX2qXggx3LhAEjl
	A6G7LSmSkFC7tnbK1xC8/tMTd5FyGzmDyoFyQPtZ9/Ss5qDxjDwFLLqAIwV7BytQjWgAj1Iv2eYnj
	6z7A0e8g==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:59342 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rzXu9-003a5q-2m;
	Wed, 24 Apr 2024 02:23:01 -0600
Subject: Re: [PATCH 6.8 000/158] 6.8.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213855.824778126@linuxfoundation.org>
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <462c8967-e599-58f4-c456-6c672d89cd74@w6rz.net>
Date: Wed, 24 Apr 2024 01:22:58 -0700
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
X-Exim-ID: 1rzXu9-003a5q-2m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:59342
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHDRvTphjEWspK/CKxikcbQk1NEMtklMQE9GrGTPwlsaKhj02zYfHZJSaZ8L6yy59eIkBlLt54/D7B6HQeDp0EvvMdcG8xDE+k66ldW4JH54kTooaFxh
 I2l1FPRiHzaZ3w7Qag115FUDvY1rjG4Brw1DZxjW/B3M1vIMiYq4YpAduNbwKFd1WJiWlDgd4wc4UKQgeibyjIi2I4yauskpAPo=

On 4/23/24 2:37 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.8 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


