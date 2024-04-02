Return-Path: <linux-kernel+bounces-127399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01621894AC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188341C2197A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA3718044;
	Tue,  2 Apr 2024 05:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0eiWRh8q"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00A17C95
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034849; cv=none; b=MU0Va683ebj5Zxy1v5/Y4Rb9BUc30wjRqy0OEYoBOo9V4xqRlrR7SH99hor7DqBqVLy3oDn7le4VGgJRWI7qVKghWpr7xHv10OGIJBoUUxwoVpVo2vhE7ozMDgXBgd71xK4drRWW3f2RSIBLNskXgO/etp99JmPk6kRF4jo58ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034849; c=relaxed/simple;
	bh=fxwNwE3ZMbT6hPHqx2KGEVoVHnLMm7qX+1rvhAbsHFQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=GeYI0CFkSUpLUDFrgdoPEO+Hk+mY+dweOL9R7fp66+7Dtxoj4QNJWd34KX9ukgimm/ehnIDR2eCIgm6yyC6bIfyns5pZ9QcJhezppSDLNobiIQe9mAW1fb5T3wAaiJsJbM3tCAmlI7WQw1rO1k7jYLvnwUCCNw9n9Lq2mA5Eglc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0eiWRh8q; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id rJsBrcDB8uh6srWTBrk4z2; Tue, 02 Apr 2024 05:14:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rWTArcztH3g73rWTArHVoj; Tue, 02 Apr 2024 05:14:01 +0000
X-Authority-Analysis: v=2.4 cv=esUUzZpX c=1 sm=1 tr=0 ts=660b9419
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
	bh=rh1jffIz4yI6KmIMiYoXE1SPjv74MhJUKr3aoR16hAs=; b=0eiWRh8qObOvHNmnSJ2lw3vdqa
	SRPEQyPDFeNUeik2SLTSvYVizZUC6CUdlwsfUzkNz/sZT13wji6zoQ8yYKqjDXXFC0Po3xXlWXygW
	vCBOk+Fwv16tYcHcFYV+ajTyYNNiPZTFvsZuSuOcmcgbALRzX5bacPWLL4A9LLUmWD9+/KOLxKs2h
	1NEyEHBLyU2rd4s9MT5iGjLeqIMIkHBYzwKr7e+uqUrYJSGKKT9nH1AfkyvSlLE0Dd0oJAre7OAxZ
	4wBJln2kzHwJtUrlzi1ZVHGyJYKmLBeXQvs3iSlWIv35RqK1MXhSCJw21uHTOxnIkJ2oXINrr323I
	xJbbGtJA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:55194 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rrWT8-0020xn-1t;
	Mon, 01 Apr 2024 23:13:58 -0600
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152547.867452742@linuxfoundation.org>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <55be44a0-cec1-0feb-fba1-300c5c1086cd@w6rz.net>
Date: Mon, 1 Apr 2024 22:13:50 -0700
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
X-Exim-ID: 1rrWT8-0020xn-1t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:55194
X-Source-Auth: re@w6rz.net
X-Email-Count: 42
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCpVTsdBIWhm+0NbTErzs63gGNwp6zjlKLN98DsOsAp7dWDjxxqVkixfRk+2ULiWKp0FgNpnWBLKvGkKtJT09mUVgmrAB8XkRf8f2UUIQv+sRIvAbrsP
 /BMPofSNZ7gK8G7vt3zNo6DSVxxKWr9C9TaucE5W+ys29TJnBMqwF9SW4UrpFO2xl4RBL/6m6k41bbLYbyrPxHSQu7EPwjYEeco=

On 4/1/24 8:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.24-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


