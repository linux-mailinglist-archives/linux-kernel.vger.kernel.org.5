Return-Path: <linux-kernel+bounces-118616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEF488BD50
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1E3301360
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AE64D9FE;
	Tue, 26 Mar 2024 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="QBoQ1YtO"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0824C4CB3D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444189; cv=none; b=Q/LDKYI6R8rtoQe1gssyXVN90TKmE5ZH46gPNlO6vurtrOomN2CQb+z+QPPPGN8fB68Pqd5PEH5QY6prVVcPI8IKO8MTPfXH57NHYDp/41QYS0fMN7xJi3Pga0XQLk2b3WylD0wIuWZYqZoZJ6h+vGB+dMzOTzrwVGlPUVmENy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444189; c=relaxed/simple;
	bh=zviBgsBXNOR3k3tbOgbAK3NsRdOqlOYIwLz/8y8f7oU=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=R8YYSTMu8uIf1Ltaa+oBuXfcTuTA1mN+cQ3ROyApjhVMNrdKhnj1We871chZZpJQx2SJMHBQQsVOQ9VCvrVcpnk8drREGXxXkjN9vwfO2npT6tX0YpWOJUmAq9npha6YtnJxbEyyXdW+pgLqiv20Vop+kufyA8mAqebY7uHV8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=QBoQ1YtO; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id ocRrrtg5xuh6sp2oOrf6PQ; Tue, 26 Mar 2024 09:09:40 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id p2oNrDXYDQufZp2oNrTV32; Tue, 26 Mar 2024 09:09:39 +0000
X-Authority-Analysis: v=2.4 cv=eK4Vjmp1 c=1 sm=1 tr=0 ts=660290d3
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
	bh=n4tS1j0m7NWiNX502zvW0bV89P3lIF8twqlrpzeCQUQ=; b=QBoQ1YtOyjpXsB8VEq/m+cnNUw
	Jgiz1DaWo9MKMQ524rGgyF74xevTVe8dTUeqf4ySQAJofa0FMtsFhvHNjbaVZwt22E98b4y7fslA4
	zXVHxj12oDHTcMFFyyk4sRA4ntYGJIeMI6M0tX/E8spTSXfiJzIk3+CIlNK99Xhe8kZaL4xcKXwXF
	R2yei3AB4cpIPnQqCDl4CiZuppuwICp+S0Sx5FzZqJdvBxpY5jGuhLwRjn0FE6f00ke6TYf4pE3A3
	pEeMNVgNvSRvtMGaK9FKBVTPoGvU45dHKcIa3Jb/s1ydZMmT6hmDfTBk6bzEryACDOlnb2yEjMdLS
	VcPq96XA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:53500 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rp2oM-001TUg-2C;
	Tue, 26 Mar 2024 03:09:38 -0600
Subject: Re: [PATCH 6.1 000/444] 6.1.83-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de
References: <20240325115939.1766258-1-sashal@kernel.org>
In-Reply-To: <20240325115939.1766258-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <5480469c-7e5a-440c-8595-f13a5869da7a@w6rz.net>
Date: Tue, 26 Mar 2024 02:09:36 -0700
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
X-Exim-ID: 1rp2oM-001TUg-2C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:53500
X-Source-Auth: re@w6rz.net
X-Email-Count: 35
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBUwLU6UoJCP0sZ0DegYQUhzdZt1kLWxf7ioqdUrZ2vnTYk/1ls7hIAn9PckVg46SRiDbaOkuj08HcisEIVZtF530eAb05rCJd+jN3Xo//xDB3f1EINl
 bye3sMMc3JOI5jP503h6Hqvd9Y15JgJhT9pryIVWpSQ+2L6m5V4qEl02PkODeZR0QDEImZJgSnVh/QygY0EdxiAK2aDru/qICUA=

On 3/25/24 4:59 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 11:59:37 AM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.82
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


