Return-Path: <linux-kernel+bounces-165042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB28B8B86FA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227331C22D75
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 08:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02865027B;
	Wed,  1 May 2024 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="FcA/Tr9Z"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1C1E4A1
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714552657; cv=none; b=Q21U+hgdg9lIy5Dxte1uzGtTxi7YhGZe8ZMoIwMpX4Hdb2xYm0n0Kfato1ltmMzWE1g7EyVRCbVcK7iBowOa6O9vCVkQ1siThVG1dyo9ykkVtpcVySIzSGpYI5fIfVYnpSYQAP08tnPscKzsvlSqQc1vzVkzh9/FzUNAppNUR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714552657; c=relaxed/simple;
	bh=65YM1MCSsz4OPrNoLfqOMbUiTzskRniYZg3X+hwAmxs=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=XE33Xp9eZ9W+qHhrwJu8Lef/X2/wBTA9ORBxxjtttweW62uYPMhyzvZ5O6uD1qeqPvi0tF7Z3C3xxd71lU+7p1C+5pXJdUoi632bsqUKd1rZ/pHiQcaW2tPVLxt/3FyQaV70mnHyLtba4/l/rOjN9dIDFkhADDNlM3m+Kdnhuvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=FcA/Tr9Z; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id 1U11sWyMgFfFD25Systgi9; Wed, 01 May 2024 08:37:28 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 25Sxs864Gq9rZ25SxseBDp; Wed, 01 May 2024 08:37:28 +0000
X-Authority-Analysis: v=2.4 cv=b6q04MGx c=1 sm=1 tr=0 ts=6631ff48
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=w3vtCogE_fj71Z-Hq2MA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BUZiGilm5vYEHJQQBmLNsAzDza+jgNVFnbLcNIHc5P4=; b=FcA/Tr9ZX2TvaRxyzfAnH6N0Kt
	WcGGDxNymoegNElWFvw35s7hSKC0KZi07GRFS+1YrK2TwccYLJcluy5kcFA9YbAAoO5m7rVqI2ZPJ
	1fVbnC+OWL/AM6i6xLW2OV7CiYXjcR35LttR4XkuaSOWC5xXPeJdRtgl5MuqGk8h8a42LIi8rcSu7
	9zWbB6TxYuRiEVra1u0bfzcXheZ9T+kW7Ud5Bc15vwG4AtGIrUBJM6gQxqHgIrSAB93aBQ6pmhZyS
	p5Er5cEfdKmR2pZq5xsS9TBOmDDOyz7jYi2XpdAFtYDBX9Esbv+Uj4nV4g7dwsq9q6h62r1EEVVnp
	UPvnUcIw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:60586 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1s25Su-0013cF-1v;
	Wed, 01 May 2024 02:37:24 -0600
Subject: Re: [PATCH 6.8 000/228] 6.8.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103103.806426847@linuxfoundation.org>
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <6cb40aeb-31d2-6aa8-3994-52ad38c50897@w6rz.net>
Date: Wed, 1 May 2024 01:37:21 -0700
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
X-Exim-ID: 1s25Su-0013cF-1v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:60586
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLMn5eA+gHSoAe5/SQ88Pu/IjkI78ahanWxf/CMrv4DqIQeyKUaRpJvLi9MSihgNH6gcQFu3KnPXsZ4kKctHkrzNzS+3sGKJv9VZnPi3Cm/rTOCC/pEk
 Axthz2l8cROZyQkhVEdE1RgIg4ef9srUm0G+JZigoG3jk8G7bbLlKH9h5YrtJ7pzJkdS6nIU1gRp1wEhxTG6ALPdOUfaIvDvzeE=

On 4/30/24 3:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.9 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


