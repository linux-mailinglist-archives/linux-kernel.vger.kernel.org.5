Return-Path: <linux-kernel+bounces-103330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D15D87BE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87B8CB21FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C046FE1E;
	Thu, 14 Mar 2024 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="zNCPYhW3"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8966FE0E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424653; cv=none; b=tb86uGY7cl8+bKxuVvjn1bO2DED8trCbmkYzrXZM++y7lBFcqM7/7wvVhYXv08kNWcHymRXV3WHFDgSIs9vW5UlPEF4oqL59tC6R6g+dVDP2hOnA9J95t6+xvU/1Ea5XDkLTZwFnFMgVbvegVI3Poa5zOHPRDtaUhp0eYFKfCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424653; c=relaxed/simple;
	bh=qak9nEqjPrRmrEJGCzU/m6RNSxSsO7lFq0sySveqSRM=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=PpsOJpiJSZ9o19JFzUZfGQBdIn9or8a3lFQrOckSCk4g4bN7hb9X0slNXJqyg6W3XWIAWwyyU63tzROCg9Oid9rUjqJbCFscTAjV+WqKz9bnZIu6JQeGiZhj7QX8DJIzK5Ii++YmKuIcoyehh2xBo7L6MlxKBH9fXR72nTnkwvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=zNCPYhW3; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id kl0PrGfPGPM1hklYoreDby; Thu, 14 Mar 2024 13:55:54 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id klYnro3uhPW7tklYnrWHjv; Thu, 14 Mar 2024 13:55:53 +0000
X-Authority-Analysis: v=2.4 cv=bOAQIu+Z c=1 sm=1 tr=0 ts=65f301e9
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
	bh=GuovT0Zf00DJfnP9eUQKgQ92jnL5mHj5XtG06nlFzjM=; b=zNCPYhW3IJmLhHb16XWy/wnmgM
	KXAMHQ7vD/f7GyV8v2q7B5AFx79JBitNYvEra/xW/QWg5qYi7418xFLwUAZOE/+xFEUJ4rcemomPB
	ICxG2p+/skkhH8+AJhzWWyv5AH2S6fVoikDnEdSm0FzK5C5xx5OJKNO4laZ12gCU210FQMdvEyNLU
	AgbWziz0CuB0oYjOp4lOwdDAzl9rm6psTHxwIz4SGU62U16ZrdSQNSENOb2q/O6rZi3OoeW8WoKJp
	PuqauEyK0coG+tFRnmANKl5V1WNd6pgeH9FIF+Z+9+53QlOVfjLpPugn9TbhJa+rbaJk6Amtv03nw
	xvznP0Xg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:51006 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rklYm-003xV5-1w;
	Thu, 14 Mar 2024 07:55:52 -0600
Subject: Re: [PATCH 6.8 0/5] 6.8.1-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313163019.613705-1-sashal@kernel.org>
In-Reply-To: <20240313163019.613705-1-sashal@kernel.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <1217741e-51da-ba81-7680-30b8f7edd3b3@w6rz.net>
Date: Thu, 14 Mar 2024 06:55:50 -0700
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
X-Exim-ID: 1rklYm-003xV5-1w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:51006
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGMQDaDaQKJleKrhjGU/N9uKxyh0YsoATURdXSYdcFpxWVVyHmi+JOJ4zZwBPqDwQrP8A1u9wjpouucUuldb5GEgnYYrte2HLdb4AMQV/FsBUg3MCfWo
 Agc5lEmeppq+X54ekQ70nb4kk1rpRtmZNEqMpZ8LGT+CJ3oaKvj/ba8KEijePgiJqUI2+6Ru4QqAvSIjeqGUPEikhCnI+4Bs9Nw=

On 3/13/24 9:30 AM, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.8.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Mar 15 04:28:11 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


