Return-Path: <linux-kernel+bounces-146365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4F58A6449
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C755B220CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C86F514;
	Tue, 16 Apr 2024 06:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="qEBjY4kS"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6906D1D7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713250028; cv=none; b=F6yrq6Tyygw5N7iNxj3lUo7vKb6QR9mm9VyPgkDnZ5ZZ+pU6zlio2fIiJEqNgrybJmtHbngEz7/8i/3OyThp9kl/iZBVAA17o+ki4NoXU5iEtXY3S2u+XKJbTSYxDr/p6fPqH7g5yX+NCHEwn/tqgWUa3P6HRyShkye+bfB8GZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713250028; c=relaxed/simple;
	bh=wyuTHcxvbfB/eF+OxSPnCHP4j9uWKud0zd4en5i12/Q=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=mBnA9aqsQDou2yDs+DVhYEL45OqH4olQIMqofmks2FIUDhDZ43N2TkoPjKOJzf0E5nds9KUlvbSjs+n/EXwCJQ8dgllBSb6c1xIGd+CKgdJjBj5/HQITByCR9GTbDfDpEo1WYj7d7hpBjDobARosWPz3ADKStcj/MOmZH9kzoOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=qEBjY4kS; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id wWgMrZFIzHXmAwcZPr543j; Tue, 16 Apr 2024 06:45:31 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wcZOrNAUeF4XpwcZProH7G; Tue, 16 Apr 2024 06:45:31 +0000
X-Authority-Analysis: v=2.4 cv=UpZlNfwB c=1 sm=1 tr=0 ts=661e1e8b
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
	bh=zTwTvwDJIkgUNqRoL0J4vERfpqlDMONOvnnBo8aW7Uw=; b=qEBjY4kSgXexvVHW5OL7x8nwTS
	UnRsXoIU3XzcqBqZ+9khIN+DS5fKldsOW0zwgUU0Q6+sXB+c9/xo4KkSyhnBWH2xX4qdAcZbkMeXa
	j26E9giMbt57++P+czg64xPO9xWVp9t1lgaTbjBv4uROLBH9jcbV0L/PeOA9OPWVojga6uE2SD1iR
	cWNX5PMsV/DSQM3smRfqz5IZeX9DeIxPpedEHictUuuqQ4SslDw5mlkZr34Xyo/hv4bPS7YGQxeke
	FdfW+RLj9HXL2LIH4cONSOWHG8NEKwPnNOu36iHVjHrD1R+jB/IEBP9Ezb9MlYMCXGaoNXeiLGgnj
	i0C3Ve9Q==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:57920 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rwcZM-002INl-2a;
	Tue, 16 Apr 2024 00:45:28 -0600
Subject: Re: [PATCH 5.15 00/45] 5.15.156-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240415141942.235939111@linuxfoundation.org>
In-Reply-To: <20240415141942.235939111@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <16ea6882-897a-5ac3-3748-25822da92bf1@w6rz.net>
Date: Mon, 15 Apr 2024 23:45:26 -0700
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
X-Exim-ID: 1rwcZM-002INl-2a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:57920
X-Source-Auth: re@w6rz.net
X-Email-Count: 61
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAoNDXVodFYrBAlsus6ClbRwqE4QoW4QAhMH7j8qN5ZOQKuTvSpi7nuJge4vGAIw1S4faELq0SFes4f+MwpKAbvHUpfi39M0MUy8wvVHm103+jZL2BbU
 MRqwwgidYZxMNinSTSlPBS2NMqp2Xdjf7JESJGsaKh6HNSvCkyF0jAMeHIDYK2FI9G/xt2/sRRWHIoYqrGs31PnzM4C4VZjPOls=

On 4/15/24 7:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.156 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.156-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


