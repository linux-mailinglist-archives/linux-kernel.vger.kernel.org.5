Return-Path: <linux-kernel+bounces-45757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C88435E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BECF282BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575D13E499;
	Wed, 31 Jan 2024 05:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="r1P7AIJI"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307073E496
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677728; cv=none; b=aayqy6As6GA4GCwwbOx16tOBap8YTojMMZmX2f3PNic93AyzN22RYvvkXSmQAwMJtunc96H55JZFfWkpU5VgDI17rEo8hnAMzbHMSAhv5KOKlrlcg6bVHblTkIRdU9Uu7Z5VRB2KhItbxDE+MWPzUv7zQkClb3gqkwJlw15OCzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677728; c=relaxed/simple;
	bh=xlVDI89mtI52l3zzcIoMCJsnh1RwAgEG5xXnohHifd8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=OGLhezeal4Zt5XdOCuxGTV08uCTkhG7JgAPYx1x4zELeFYek6UmhPtcsJ6FKTQRHQ3VS4yDKEA6WbY3q4dzP7eAwA1iBEGS+Y0O7jAgudfbKOjra4QpILeR3UBCe5U6AP3MSXJtgPWwc5FU3CyBzshhc9QWaZBL0d4XGbc9nr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=r1P7AIJI; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id UtLCrKwQR8uLRV2pzrkyV7; Wed, 31 Jan 2024 05:08:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id V2pyrhyk7fPByV2pyrKfET; Wed, 31 Jan 2024 05:08:38 +0000
X-Authority-Analysis: v=2.4 cv=T+af8tGQ c=1 sm=1 tr=0 ts=65b9d5d6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=fgkVngnsqUz9it14FVEA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RuA7V1Oi0UgNsRmBDWdWdoNNiAoNLAqu1nIXFx2hl+4=; b=r1P7AIJIA97RqC7as2xjyf+CRr
	1O+2exuiBaYT3dn5WZHIkQeWzJ4lZ56c2AXIv2Z6xUvopL1ATjCbZaAqJDgsqR/33v55/1a/btiNA
	Hy+VwiAbPzd4ipt0WWhLDU+ixSeehuyRfMo+MMzroOi5U931mysHZef5/1eUeqTJiRYYIpBpgS29U
	PmknaE/EnV+F05NBfKoH5KVdwj8jDT+mYiM9PXYKaQ0aV2NSdVus+YC2v54T1AfSVeLNrTuWPU1bB
	ZNJwenkyDhEZLBmVIwOJnjm6CV5eBGzErjdlXb+jyeiCVZSvOKrwaP1GdSnlBsKOc/kXujgrO9RWn
	Z0efiDbA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:37676 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rV2pv-003Tdm-0U;
	Tue, 30 Jan 2024 22:08:35 -0700
Subject: Re: [PATCH 6.1 000/186] 6.1.76-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240130183318.454044155@linuxfoundation.org>
In-Reply-To: <20240130183318.454044155@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <57f991b5-df2f-8aa3-99df-de84eafd3153@w6rz.net>
Date: Tue, 30 Jan 2024 21:08:32 -0800
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
X-Exim-ID: 1rV2pv-003Tdm-0U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:37676
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ+DH/aVQwaEyL1jUArZCUTE08Ql0S5aqYwowbKJ7OUFlo71KhsxxCaKb24DpkSpk68gGubpnvc1R84Oy8mCOZwH1OPLH065pcUuNh8fdSGRHC1XfGo8
 Ackqsq1fmAvK0z6TY0mcDHawaZqcDqOIhxzdXQAVGeAZLRWnvQo0CGNjqUB5UTC+ym1mWp4f9KYyBvB1DnuP4DnyRsZiRYlzuVQ=

On 1/30/24 10:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.76 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 Feb 2024 18:32:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


