Return-Path: <linux-kernel+bounces-25531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA082D1FD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 20:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14961C20A99
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 19:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F6212E5E;
	Sun, 14 Jan 2024 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="hhHwxQ8T"
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C151097D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id P2vzrijXlAxAkP6JRrkD7t; Sun, 14 Jan 2024 19:38:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id P6JArIjxyim6EP6JBr9gkW; Sun, 14 Jan 2024 19:38:13 +0000
X-Authority-Analysis: v=2.4 cv=Qft1A+Xv c=1 sm=1 tr=0 ts=65a43825
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=//1wSoDB8IatMhJ5Neix5676JKUeChEZw1HzdKw1pYg=; b=hhHwxQ8Ts6VzkAFcIG5zNmvm2l
	JktJbOu0PQRBMvR0GHgBNK1bnDO6MKiXrKHjblxxF5XCvbkIPnU8DSBVonvUXuLbWD2qShUs9oYN3
	wtNfIKHVJCxeOxBdueX3ZS9yXTSJB7bA/BwwnAAm+Q50X84SdE5JbWNagc1wr6Pqu4GORyFX+11QP
	NS+8x2xvYTLGjio171I1m4YY/yBSSbLSz5Pu9uwgC22yUYFer6kmCdz5Xz7I0xIuf1s/bKFmUObGb
	q73+pVkK2VLCB7p9mlucnjPIgAWK0z3PajUyBStOYUePX1e5bJ1FamEeJgHBdfk6DGfqW1/4nzb9f
	1gpHM4Ig==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35226 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rP6J8-0037bd-1a;
	Sun, 14 Jan 2024 12:38:10 -0700
Subject: Re: [PATCH 6.1 0/4] 6.1.73-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20240113094204.017594027@linuxfoundation.org>
In-Reply-To: <20240113094204.017594027@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <72c4d415-f169-18f3-54fa-a5c07b811f89@w6rz.net>
Date: Sun, 14 Jan 2024 11:38:08 -0800
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
X-Exim-ID: 1rP6J8-0037bd-1a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35226
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI7AW9h66sJ3AYd0D21gETot+zDouSkiskD9dBQX0aYPUrtpJMPMKphE/fJXFSFwVlQVpAIG2L+3xDNHsmJVDMLFcYo3gTMtpnUNTPHniZZHr954qY87
 iS22jCXtHEWAsn8hDhGycR1YXZRDRNo3Kd3Ex/PWCwfHhseYaw8zbLSWR6o7IwYlK375BAkOPpgtpGmobD0LJ0GMKApHx7IV8kI=

On 1/13/24 1:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.73 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.73-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


