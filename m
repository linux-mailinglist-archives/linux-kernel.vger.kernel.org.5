Return-Path: <linux-kernel+bounces-6255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF2D81966B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A815284587
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1090379D8;
	Wed, 20 Dec 2023 01:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="vVwRPhwc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4796133
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id Fj5br7oQcVly7FlVKrrXQf; Wed, 20 Dec 2023 01:36:10 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id FlVJrsOyKM0U2FlVJrDuwM; Wed, 20 Dec 2023 01:36:09 +0000
X-Authority-Analysis: v=2.4 cv=BuKOfKb5 c=1 sm=1 tr=0 ts=65824509
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vYYv6VnWyDYnl1N0uNA5sHrnj1iKPuBOwJABAM3pcV8=; b=vVwRPhwcKrrny2n4IUK8kkqwKi
	I3X7SS9vD/91Xk3fCoxiV/FXgFSE6eYBd57XnPIehSsMTBcNoOB7OCqohlgUJH/Nqbr6DKr/vZSoB
	cPIGd83YlsjyZiX6ftoPjXQcwkgm0HJgEeyk7vQD5JXyN/QnGa44YjXb7z2o5SkkC1NmuXEu7iKMq
	quIeGQdXKMaMihu1vtkKnA4P88gM3i4S/UbPuLW0XC1knd2ypPPQqSklR64+2sPYO5nSZkFx//Aw7
	mo/a1Ql+yoBqvSJ3+IS2yCVT9xkrp8IT7s6TcS/3KYh52clgViCQwMOQVbFJz1gRNhSjP21dZxnGX
	eZnaeYyg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:60674 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rFlVH-000kqQ-0c;
	Tue, 19 Dec 2023 18:36:07 -0700
Subject: Re: [PATCH 5.15 00/83] 5.15.144-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20231218135049.738602288@linuxfoundation.org>
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <ffe3f88d-521e-2bf7-d971-13333162024f@w6rz.net>
Date: Tue, 19 Dec 2023 17:36:04 -0800
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
X-Exim-ID: 1rFlVH-000kqQ-0c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:60674
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAF5/it3c+JZPnXXNza8/ru6Sq5LvvUMnoAaSExCOMrdX+IO32uw/tSLxQwu3NdlYVgOCno9flYibDaYcdCZI73eW7RgxQP4Kg7xHWYnQDzOsoGcUjaF
 fu+90XtI4cRqwLxXZJ+nl/F1Rr6/087uJsFjFwcL6dCEVX1JKAFF5X5174JmD8DLD4WtyWEbR2lwAgYn7VR83ljZAk1KWTA8yJs=

On 12/18/23 5:51 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.144 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.144-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


