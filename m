Return-Path: <linux-kernel+bounces-127401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EFC894AD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA5B2838D7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F26182BD;
	Tue,  2 Apr 2024 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="iD3GJsl7"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F7175A1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 05:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712035390; cv=none; b=bYptUDOEbfPSIoiUTGo+xJGuPyIUBANTz5/WBvkmqbYEwOMh+Wdn334kITpqwtPBIe7FaShK1dtA2XlMaXKlaqNZ9uoNRGM9VYwFUvJ5UxHFoSCDc0p7YbGn+ghLurAeCwVA/5dx44AToLqZq5uGNg0ce1dLFiwJN8i+uZ4Z0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712035390; c=relaxed/simple;
	bh=o9JqQU4pt1QfRlOQu21GoPMKrOOCIXPEfH5LBAIp6L4=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=VFFAZyN66rVHD3rALSY/PwAiZdO08aTj9rXY79lUnLMV6p+QoF2t0h+2Xprls/kipcTy2M9XSDRzQujMLLTHrOCDAbT91wCrB+wE8AoPYAjWKZnNui9b0nQ4KlA5vuB1L/DHD/lUXljgq1ueN7RwgnXP+mFBR7t/2foln8EgO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=iD3GJsl7; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id qy6Srfk9kl9dRrWbsrWZFV; Tue, 02 Apr 2024 05:23:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rWbrroiLIuv6XrWbsrN9uj; Tue, 02 Apr 2024 05:23:00 +0000
X-Authority-Analysis: v=2.4 cv=YbZ25BRf c=1 sm=1 tr=0 ts=660b9634
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
	bh=u83x1h+5LHq9SftQChawmhCm98M6VZCKcE9nJ2kSJFQ=; b=iD3GJsl7Jl8+N029Q7hgVXgcK6
	9e2mFMrDEMKQI67WOAsR/HGri4Ge+1tZVYCHX/DBoBQDMLYBA14z3G+/5sS7it/T5b4IrlEwxjjkd
	TBmjnZsiogPLEQRsRhWY3qWRjQMFsOiiXr/MT3KEpigw6q35OvS4whwNp8VA62hfgwIqaVwtqL3sq
	oOOtlhmPnIqDw+du8sle8banKou33yD2aIQ5Rwa1zAhRxMEDMkC7Kda/uppqH8kKgdt4Yyr2CLr6A
	/MThA+A0Brc3jZsRpUjUrs+vx7A7gm82al71MAIMuTD0F4xsoSLCnufQOstuBvzCIobbyI3m5q3Qq
	3Vm2tTtg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:55212 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rrWbp-0024p2-1v;
	Mon, 01 Apr 2024 23:22:57 -0600
Subject: Re: [PATCH 6.1 000/272] 6.1.84-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152530.237785232@linuxfoundation.org>
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <2919e282-6c72-7bd2-d4e3-5427d3d27bcd@w6rz.net>
Date: Mon, 1 Apr 2024 22:22:54 -0700
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
X-Exim-ID: 1rrWbp-0024p2-1v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:55212
X-Source-Auth: re@w6rz.net
X-Email-Count: 61
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGGOAafRYiD/wudEU8QkSJYWE7dPQUHSsJ5kutuYfUnyqNxOO9R6kbZoQCoRipC/CMxwcxbrpwqIEXSeXn1ND8IEe1TkAC68ggLZT85aYunIRH0ut/Z0
 VIAwV+upnsiI9D+QSsv534WuIV/IgTroY4eu5HVri0ysp0QOXlMtx1Q6y8v0XeQpjDY8QCWxw6Lb8uggrQtagHGSnZ6z3U5kUNA=

On 4/1/24 8:43 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.84 release.
> There are 272 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.84-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


