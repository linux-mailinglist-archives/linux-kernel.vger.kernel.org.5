Return-Path: <linux-kernel+bounces-118611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF79888BD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5B3B24357
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9464F890;
	Tue, 26 Mar 2024 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="NudIRX7F"
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760C4C635
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443858; cv=none; b=nQxCWL5ZnOqMoujzRr1mv8aTyUKp6YGMlVTTkaS2o4cAhKy2HPbC7RVVTkAFbaa6weGN1ayTpoK2W423+ATm8YxdiA1nSGKesq8Z3R8zbC5Txiwjc7+8t425EaDp6TV4vYx0Cfax3YtQp2ZKWxKNPyRUKKl9HX/kedMSetBkd8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443858; c=relaxed/simple;
	bh=THka6a7Z8uT4NCljl98iaZfM74/Z9EaRIjmUGDqT7SQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=UgUC9vm0fQvVgy21upq/V6cGqbB/Q96W9eSHgHZ8mTGDAFnvmaxBljBdL/bq5vvuEBHMO01q0QwwTFCINdMp87U4sctdoADqgD/xIuomjCkOIDl7d/kBblVqQy1zB1EDRVy5gE1pkQzcPtGvqemEAXHMzIOZX7WUQnT332FjnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=NudIRX7F; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id omqCr80f8tf2Qp2j4rlR0s; Tue, 26 Mar 2024 09:04:10 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id p2j3rGCwssT9Bp2j4rLw1N; Tue, 26 Mar 2024 09:04:10 +0000
X-Authority-Analysis: v=2.4 cv=LIutQ4W9 c=1 sm=1 tr=0 ts=66028f8a
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
	bh=9L5GFdXtpNhlmg0N5DQpvqypfwsR2dSZY32SLz2/dr0=; b=NudIRX7FMUOhvkqhKz2JpIa1V2
	QoWazCsLbILvVvaDAQj58QfsGgN7N3D7jzfTVaUnkxjrklMNLqQ0LmRgGJAWSSy0D5vMxwxItfePs
	kva7qirjyWV7uQqO5Z0Lg/EjrHSI6YXkravZUL68rrILHjTniAoCbAxRr1K42tChKGvID9d9ml3Ho
	nnlmIXn8SWinhrG8cj5ntg0C4LDwLViHES9hmxdf2yT+YfENz06IrqhVGuMS/szSQOm+QHDgouGCm
	LXRYdb3YBTkCk4UUtBiuZjG4c1wJ+qeMn/s15o8Phedo+nVdBfg+Xglhk7qt2yS4rmKs/DsFN/Adp
	uqVlpTLQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:53484 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rp2j2-001Og4-38;
	Tue, 26 Mar 2024 03:04:09 -0600
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de
References: <20240325120003.1767691-1-sashal@kernel.org>
In-Reply-To: <20240325120003.1767691-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <0acfc4a5-1681-b8d5-e1ef-7564b07c0dd0@w6rz.net>
Date: Tue, 26 Mar 2024 02:04:07 -0700
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
X-Exim-ID: 1rp2j2-001Og4-38
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:53484
X-Source-Auth: re@w6rz.net
X-Email-Count: 13
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBfb5xEv7Tg0sK1QlPNNtgdzTqmvHESTQrG8zf1skwTWB28Rzwz50P/slgtQP9L3GPgWCoC4awLTcdtWC8wQZyuymEZfVD6oz3zT7u1r/r+uKogZHQ2V
 hw3MiHuAbFptsq6iCRR9z9rkqMr6sAAm1SivEdc4m71iHEFpPiyWY/sxau21Zetj/vDqXvMinB6DPuNpCM4WJP1wBED87bqu98Y=

On 3/25/24 5:00 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 707 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


