Return-Path: <linux-kernel+bounces-156536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C18B0442
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6191C243EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C131B15887D;
	Wed, 24 Apr 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="S2LZXF8P"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C035157499
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947109; cv=none; b=RpIbR7oY/PFlhD/02vGYbikQxKjK+gm5DhSk8wWKltaymZPH+MVwkbCdaZWoohspeMxdZofg4AfkiXsqlBK/3v6yqcTDv/1f7q7zvGkSWO8Sucl9YBupT0bacVheFlIuRhWHrhwJsEh3SZg4jhNcwr8y/DM6c+ygW20c6PYjoaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947109; c=relaxed/simple;
	bh=/McE5mTXtuwDTyfGYM/K02HZiI8R+y8gSoKAk0VlCN8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=NYjXbDZ2lTR4y3Hip3fxzp4akWRTUiAVbc37HAHi4Gs6uXNyAtrbMY9zTYQfC935Qgw3glvvJsQ2m6QnL+f66ln/BykmgrD8kcrV41MacgQf/z09HUCEQyj2TojgSM5m6K6VLsmfJZfQb2jHnaWYh9U5BxoQYNvqHXQfBbBkfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=S2LZXF8P; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id zIKIrBALJPM1hzXwBrUN6l; Wed, 24 Apr 2024 08:25:07 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id zXw9rX21FiKqRzXwArywhS; Wed, 24 Apr 2024 08:25:06 +0000
X-Authority-Analysis: v=2.4 cv=I9quR8gg c=1 sm=1 tr=0 ts=6628c1e2
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
	bh=0mOX9MgjqqmtOtuSB6MNWCwKvl7Kg5xuKiNv9Ti0oHg=; b=S2LZXF8PPmjurjyXTFXEkoLtH9
	Jsmu7BBgPK4Fa0AQvb2do/qVxKo9kUSVT67Nykqa541TCL210m+5W7PlW2dykO3uOJ7lwVzB+jM5P
	CkJ6HjInVkW/aWer4irkWIBOLizdGbG59EXQlfBrPpPvvMNim3H8qoufmSd5Ko/6jRZ+zYixFoT6H
	jPmE/YRxzgEFpSWn+nk76w9jHeP4ZZvg7JIhbCKoUbe0hvsFMLpsqk4puwIuxS78ur4O+0hUZf/YY
	7rl0pNx0JD9aPOrFsAQWdOj8Sdn3CnXCmUOnhLlihYGelzvQYCwbWlnjp6C8iHPoOkY5KHiy5aSMS
	5JT7kk/w==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:59350 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rzXw7-003bgc-0l;
	Wed, 24 Apr 2024 02:25:03 -0600
Subject: Re: [PATCH 6.6 000/158] 6.6.29-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213855.696477232@linuxfoundation.org>
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <897dd6c9-7dd4-5c30-3b4e-3d055130e0f5@w6rz.net>
Date: Wed, 24 Apr 2024 01:25:00 -0700
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
X-Exim-ID: 1rzXw7-003bgc-0l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:59350
X-Source-Auth: re@w6rz.net
X-Email-Count: 23
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFtJngTaUEEgzA7zUmnR7s1MHg2c5JYZ9/CebNYYBKoHlcXc8kz3nB0j8ZiyvBlcwiwlCN1DWm9IlRlgFzHN/RnWPDxCBr96DHv4nrxnapzbYkHPnf18
 5a1FW05z/udYqB43WSLHZ4r/svrNY+bRr3GoyaLqufOFcw6kX+IM7XwUXqwF83HROeMFeHSrQQbU//EwlQziBLyD+wS2eyC/sdA=

On 4/23/24 2:37 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.29 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.29-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

