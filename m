Return-Path: <linux-kernel+bounces-165959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9531E8B93D3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566EF283113
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9401BF54;
	Thu,  2 May 2024 04:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="03sbbkhy"
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626AD19BBA;
	Thu,  2 May 2024 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714623436; cv=none; b=lLL2ihGcixx2XPznDoptl9ofK2Qv+jkj54Isw11vW1mYZhgB6LAvB9ik250fwzU8ICl202igfk3PbadPbgS/tSfjb0tYHZC4SVh1i7S1wzEDTwhO7kNyodntxR/uMzO/fehbYV6pJ67238JWfZ15MluDun8jk4zv3RM3mqPpdUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714623436; c=relaxed/simple;
	bh=7enw3TgrUm6s1q6EZ76vT8AArzxFfakAenWWCecpFYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnB/LjAP/tOIa+5tJ49BQAhWFuHH4o1Or/Y6h+wNmxG3YJfBnLQyBkA0P0vBAToq/LHj8u96bPvVFQZMqv55jBSZ7ekFzmDIUTytNnR+Lf+gjkio47gKTg6zRt18P5vO0QrSn8jiH7+gcqDPKAh/NCXUAqp5VIlLs5VJjU+ZjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=03sbbkhy; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id EFEC914C2D7;
	Thu,  2 May 2024 06:07:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1714622866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxhnbEMYdyo/gkIHwPCI1uVhemd0gHqCGSpwgksrIhI=;
	b=03sbbkhykEwud2norN4uGRYUoA+b56S9cYeINdD42BsbsnbTcPFV3h5GFCrfoNAwnLx6qz
	1w9cJPEtKp99DY4mbQPTF5HOs5dYgIaktPIh/f2NFm/AUOuJXfFM1T8z8WJBCyq9HASwDb
	hJ1tS3hnoyKU/IcGc7D/88gv8XnwPBMem0tt4i0YbFfFR1sacjIWd4sDlFo23CFFX53pOo
	i+QmKKf58hfjbLSQsT2oMvGUCVf1SWrs1favInf0DISRkqo8FKKQ5dWnVOOWiLA77/bTDf
	cjyOGT1KcpXS78VvtUius/sGYPXf/DmKkW+TCcJVy2oodmg65epkiNc64D4VkQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3e3ea492;
	Thu, 2 May 2024 04:07:36 +0000 (UTC)
Date: Thu, 2 May 2024 13:07:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/137] 5.10.216-rc2 review
Message-ID: <ZjMReaMNjx8WJSsW@codewreck.org>
References: <20240430134024.771744897@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240430134024.771744897@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Apr 30, 2024 at 03:43:17PM +0200:
> This is the start of the stable review cycle for the 5.10.216 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 13:40:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.216-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 4d39cb0f1c9c ("Linux 5.10.216-rc2") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

> Daisuke Mizobuchi <mizo@atmark-techno.com>
>     mailbox: imx: fix suspend failue

Sorry I didn't check after you replied, the commit message seems to
mostly have been updated to v2 but the 'failure' in the summary is still
'failue'.
That doesn't overly matter, so feel free to keep it that way if you want
to keep commits as they are.

-- 
Dominique Martinet | Asmadeus

