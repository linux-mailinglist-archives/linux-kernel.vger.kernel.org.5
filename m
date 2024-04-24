Return-Path: <linux-kernel+bounces-156539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98E18B044B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A654B28417E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E379C15887F;
	Wed, 24 Apr 2024 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="3Lky2W4c"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AE158851
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947210; cv=none; b=E2moDB2n7QwPupZydTXiJemYp+p1f5A9uM8NeHUsHvAvuQtu1yp9zOojpn8ffOkVnNMCNYY99J2Cjt6uloX/Hg6iFycQ7Rc3hfeKdmW8ZsXW9v/qbMU9Z1FJnDscvWYFV5xzZ8r4A4/1X6BA21oomG2CgXLoQhz1Hmj3qRHYKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947210; c=relaxed/simple;
	bh=KmTHIIywUObQdICIchFzfqvn8mHrr2b/cCg6d+QkkeA=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=WgteBNug8JlmR9GBdb62d3BOF19IfEZN9FIyleqVQUEbO6u0oojvTWKGGztQqw2YCDh4pHXebdFxziMG/LNxPkvBoXkutm3fpPR+HdCWS3iUp0Yb/4Juj8kY2MXFnsTfI5Y10GHSV/LFxCUp88cOqS8iIBht/6dcVtBjZ2dY+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=3Lky2W4c; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id ywDNrlDg2l9dRzXxnrIGg9; Wed, 24 Apr 2024 08:26:47 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id zXxmrXXULCaXozXxnrZoas; Wed, 24 Apr 2024 08:26:47 +0000
X-Authority-Analysis: v=2.4 cv=deBL3mXe c=1 sm=1 tr=0 ts=6628c247
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
	bh=9kH6E5uNEsMu+RCPjQCAkG0PnO5BVQA1Lz+SzOLuonY=; b=3Lky2W4clwqNTTcDFlEGYBvox2
	ZEXy2HAd8ye2h756AYq/iukn6goqQH57ufvwgd6EboVCOoFrX6GK63wdM9MYvGpytGWccFebw9Pxl
	tg35dYikUQ1BKfPu1bRXzKjBu7ZCGPPxzAYe4NwswovavJRMWvlxZ1C8zYmAylcOIdKNi8w1oGUZL
	vlPpEcnwZamO7lHRXjve1I3ejpm3cn4tKVsRtPvm8PTDUjOHIP5vTS8sZglNpktnmtY43+aRDpMeG
	/YATffNbuY5/2o08kaG94/fek2YgfYCj/md/GUMzEfDbQrlBPs4nohLc2uyWu6/RC5CuylUEcNxTt
	S3roBZtA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:59358 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rzXxj-003cQc-3A;
	Wed, 24 Apr 2024 02:26:44 -0600
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213853.356988651@linuxfoundation.org>
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <abedef3d-738e-6f53-73c6-39e3d5c6735a@w6rz.net>
Date: Wed, 24 Apr 2024 01:26:40 -0700
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
X-Exim-ID: 1rzXxj-003cQc-3A
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:59358
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL8iTXGPjJLbpelF79QPRMWHU2n7yW+m/VjiHWqnOOxccil4249b2xkigRrss/OHzviUyNxSykLhT2dWyFz6oDf//6udxCVsXOGwzTEe683w9KEtETfO
 PgtLoEJB7pRuj17U+B56vgCZvNBi/yR9fz9f9GaUNEzVgjGmEHWHw6g0K+bVG8Rk9SV2UG8H2vCdbXtmYtPUSwz2K8YFPvl/HuQ=

On 4/23/24 2:37 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

