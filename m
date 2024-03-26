Return-Path: <linux-kernel+bounces-118597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C8B88BD15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F7DB21C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077771C2A1;
	Tue, 26 Mar 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Aak6/QcC"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA6182AE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443669; cv=none; b=WyI07T21zxI641glhl5dkDKX2nwRwB2DAbaRK7iLtASpsbB64W+qOHPZxZlII/3qZFYpif4cBEPAMRJToA62sZQ/fxtH5lat4zvKOzMNKbb/jhLYF81tz3JmVqi5cE0vM08klXNECd/YVDU4hFOJHtQn44IsZvzL1zlxv+l3X5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443669; c=relaxed/simple;
	bh=KKF/etnlAV4Vo3CaEiBAQT7vC0jCBkZ2PL192e0ugq8=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=dm4iMp46nwR+MBl1gr8zqt6YO1eLfQ4HFTVPuZM7O70SJ57HrMm6PC4mWG/AyqJcHglugTUt2SRIZwxXKGQgTAFgjLjjRxRqvUZMve1XLGItf1zWXytryPWFhVV460J8hZvfh6Ae5IldWtR2UJxNgnQcFRARCOLV0tmSZCYVpP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Aak6/QcC; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id ocSVrR6voDI6fp2g0ruOGt; Tue, 26 Mar 2024 09:01:00 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id p2fzrYOmwkyhrp2fzrWz6z; Tue, 26 Mar 2024 09:01:00 +0000
X-Authority-Analysis: v=2.4 cv=Z9TqHmRA c=1 sm=1 tr=0 ts=66028ecc
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8TK6sc/s+cs5hpXijczBVPYRK+UzTbR5M4d+vTT+vRI=; b=Aak6/QcCwmzWh09DWXAuMCYp3X
	4PQKxhPkHrm2EyprFKM/bgKb4o5th2V1I7JoVM3RNJFkJUhtMUcGFlTT3oUlyzI2/bhKvevYRzwRB
	J4bFjFGeBMmgGyzSNVSt3GQhk2uiQGPllxpkrHEON0ILPkEzFiSHFi4jd7iHDAk/zTTPNKw+qiCaB
	qc99L75lW3UWMft0Gv2iorZgJYyAt0Krb9MxxnaeF6fjztkvnjz0bEgmAOXmGWRMW/C/ILTSiDXhq
	E1GcxYl37GNegNx9PUNRbAFO3+UUgm7CqEZ8L2p94vJteTSTbkTbzWcbVnoAf+woL58dgrATJRI2V
	ZnctS+4w==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:53476 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rp2fy-001LV7-2z;
	Tue, 26 Mar 2024 03:00:58 -0600
Subject: Re: [PATCH 6.8 000/710] 6.8.2-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de
References: <20240325120018.1768449-1-sashal@kernel.org>
In-Reply-To: <20240325120018.1768449-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <ca0c2ac9-2328-5db3-feab-77dc3c4da733@w6rz.net>
Date: Tue, 26 Mar 2024 02:00:57 -0700
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
X-Exim-ID: 1rp2fy-001LV7-2z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:53476
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE15OViGVlugLxFQOiZW0F5MW0eUQq+rINGgMbjPE8+CT74NZdohGs2sTOAjxo0vkDw3nC1YkSfod0CDI9bxZ8YZnC6rRP7NVQz/Z3xxQ1msu5iw3sMC
 n9AfCmd9lbJFvN4NkTOnuTYByAju2d4/rGnU02bm6vhVFl2hFlH89YtqHO6nmBP5zRSOxPvOf0tJ90e4bqG0XWdz5VS06KdjDgE=

On 3/25/24 5:00 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 710 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 12:00:13 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


