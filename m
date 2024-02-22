Return-Path: <linux-kernel+bounces-77491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A06860648
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0E7287632
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EB018629;
	Thu, 22 Feb 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="A13lClL4"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4F17BC7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643605; cv=none; b=QcwwkgBdKqgsCkJh/P7CZzhRpWifJp84TX5ewugRYm9RSU7yAaFfPxJH5ONa3jbeW1TAgy1FgRvT+bjdHZKqvyZ1RdvZpu/b12AgCZsftBsOm2UMFEti5fuBi6Cl2vR9NZBxr34ExeAZ2asFTzb/9eqTYjmBvCP1xmTvMhLKs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643605; c=relaxed/simple;
	bh=y/jZuHl6NUzjAai7o2bI+i7qcLC9Q25IhiVkgk6OeBI=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=PR5PRtsf73WkuuMSD33sAJhA2d/T2/9/+VGdjJKp3XgwVmqEvKC9ime72UpqxR9SQDdHBQWHrUXPP6/DoyQPe+BEaCHhTX1bELfcFJfqL1lslnRJ4vOcV++HQlVFnqxLG2GPy8KNMvPt+dtXzSVFy7VdHgDaeOPToHMnST3Ends=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=A13lClL4; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id d4WyrWiScTHHudIFlrTGim; Thu, 22 Feb 2024 23:13:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id dIFlrQCTWRkHQdIFlrMA6f; Thu, 22 Feb 2024 23:13:21 +0000
X-Authority-Analysis: v=2.4 cv=N8QvFX9B c=1 sm=1 tr=0 ts=65d7d511
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=xVAsXjOY_3W_6nlrMEoA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f2oyKlKeSKZqmQ4ISDZxnOvntf0l5tdrQzymgi4iK2I=; b=A13lClL4mgogF3Bd2pjqqOJuMG
	T4ug6gIcahZCqtXjlaMTuI5HSEKho5PLJjIdCLZPwem6IOtGpVZvPUFCc7//TxgKS7rBONtHh1ku/
	ksrXp/Lr34+iGZq88bHNF8lxYnYRt6t0YF6SVh7EtPvRiJx++CIw/69beSaE7VJpaDi4hIyvtBoSW
	RN9CY5crcMs4pzNeIG9jnuwh3G+ju08cdTWz6cL5rPrvwvI6zWSAUv7uRLliZAWgxSFmgfvoNy7gK
	NGobUPmjkeEzD52359jTxDyJvJJwEwEhbsHbg/Rh4B16UOKPYjDJ+zzzjlXppwsEg8XR5jsMAwqxY
	iYCRZnpg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:47430 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rdIFi-002kzD-33;
	Thu, 22 Feb 2024 16:13:18 -0700
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240221130007.738356493@linuxfoundation.org>
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <7bae8767-51bb-3549-e859-b820b7b261e6@w6rz.net>
Date: Thu, 22 Feb 2024 15:13:16 -0800
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
X-Exim-ID: 1rdIFi-002kzD-33
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:47430
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIL6Go8v7257qwI4wQukNhyi/GAi9hd9kvQXLI0irhHz6Vs3o7wG3A6fwjxM4HwZrPEX8DMiYqC+6jCZP8AQztjy8Z7kpgKNcfzZk4YojZlwA0l6NLpT
 8rBkZ227lqRV3GfHpLbNZYAtrckPDwcP57vIFC2Bx+B26SlnqPMDrlf+c2v6KUHnAhO9hte9afqv361sAGl8z5d2WA/zjmAfTwU=

On 2/21/24 5:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


