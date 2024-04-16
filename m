Return-Path: <linux-kernel+bounces-146350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661928A63D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9251F22509
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB896D1A7;
	Tue, 16 Apr 2024 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="4KBpnldg"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14876CDDF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249292; cv=none; b=o6kRvK2Hn3RzaIFsgdJK4IQne7ZTOYxZWRw0DnkHY9hqPRtheeAW4czwor/eLJqV2yPb/5dNXqfnqkMUSkowarDcIakGbBP5CzFslcS7SotU2RtaUIyTmBTkghwOpu5z1L5j8hJke8xwZEYssBF48IfK+pEqHgWroW22w+O7clk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249292; c=relaxed/simple;
	bh=XCgkOzhMsbOJzuLqpLn/8nLxmZnMaMR41pjiI3ASrQs=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=Bc1SEmcbAcTjfFgTMlyaFkmnDUdz8aNuFE2o90xe0jpGd0sRZDt560QmqnrfQiF5NXZrYtAPxXw+QLX7KP2jB5fXMRs87fo8aLOp3tVHTUGoJRoPOaLKcBvkxA675nBnUOPxyk2ZzPu24tVRFyH5P4zPERimGBCtjbUneAmL/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=4KBpnldg; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id wawprrXvBuh6swcOyr5X7o; Tue, 16 Apr 2024 06:34:44 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wcOxrHnD7HHoAwcOxr7RFP; Tue, 16 Apr 2024 06:34:43 +0000
X-Authority-Analysis: v=2.4 cv=dskQCEg4 c=1 sm=1 tr=0 ts=661e1c03
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+07axyW+ZbRmTBe2i4OgzTYThRnKslRKgz/+xUnb+zg=; b=4KBpnldgPubUrhB/pVoJRWn1vB
	yvVmv6mjoxeD5sKVvqwzXY3x/hWQOSJrTy8bF4jb/h0NzRsMxN1T4rMp4D/k86QhOPsqx5qQA2/DV
	KhYeSu9W15cltXDix4uxdylVodHooMIH/Ua09oZ6hQIQRtvOnfp1Gh+TZxnH8lXg+rcti1jHEbgj1
	E8l5EzS2ihW92W2c/s+Xpafh7Jet3U8lEPsIhXJxjCasaPNDLKuk2tf8BPCeLNot8o9h0mEVhDFMV
	Ys7QfNh9ZLvHFS/i1YPs/icnHGdjg/W+xUHrtMuK0BgrNqykxTGOYImU2NolB7uQx7+LZwzKNZlyO
	Md+PspSg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:57908 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rwcOv-002DPv-1Y;
	Tue, 16 Apr 2024 00:34:41 -0600
Subject: Re: [PATCH 6.1 00/69] 6.1.87-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240415141946.165870434@linuxfoundation.org>
In-Reply-To: <20240415141946.165870434@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <4ad06e18-5f5f-7b21-f96a-0502b1fffe6a@w6rz.net>
Date: Mon, 15 Apr 2024 23:34:39 -0700
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
X-Exim-ID: 1rwcOv-002DPv-1Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:57908
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMD54DJ1utxqGaEsSipV3zDpAN8bp/aG2QLloAUhc8X1DX7DUi4xpj/ZO5HrdnWx5a4Wu9H88Wtp3i2ebFttx53DmaJ4hNS7WQ+u7Y3dlBn91AyTJ705
 eGklfeAxKtVkSy0HC52e35yAkmddkn2VRMH7M3mVuhsqYg3qjTw2S48GbAtj6l4oPAU0Vr9lciGNNwlXd03baxOewKVBwg80BVk=

On 4/15/24 7:20 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.87 release.
> There are 69 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.87-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


