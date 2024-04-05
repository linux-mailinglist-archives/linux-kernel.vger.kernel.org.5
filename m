Return-Path: <linux-kernel+bounces-133002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E112E899D28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587191F231D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0024614F129;
	Fri,  5 Apr 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="yo6V/mDP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XR7uKliT"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A081DFE4;
	Fri,  5 Apr 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320687; cv=none; b=ZZjxsmG8uqkuRudwL07SYZJEOGePN378ybsLkMmza2R0L8L55wb/4nhxJSL21Oqxm9xiyq8hCT9HhjpsV2WIcL6VkGtjVofc9nudmSqP1MzfDUNMvkTfnPnDcFnB5NbCr7cJXgEQoj49OwncBhHPIo3pTA/baSvRgUlxPEPSkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320687; c=relaxed/simple;
	bh=mXnXA9x4NmE809L3U4eMhTHrd1MAnRHvb+EIUqVwVp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LB+ThZMTcBXLR3P3FX0BIulH7VOb9sA7zV5ju4sYODz9LxNkDGj4EZWv0SE5ppaswIL7KdRx53GirH6W867+xfgs2hCkueBsIlNNLzUvCiNIjLCUqnBWimKBfvrK4/X9aMyl/vfx5Em7y48TrGUAaSRjkZ0socBmJudh1AeE9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=yo6V/mDP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XR7uKliT; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id D092932003D3;
	Fri,  5 Apr 2024 08:38:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 05 Apr 2024 08:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1712320682;
	 x=1712407082; bh=9yZNkFVecyVcwhuRWOOXDSmgJ0AyNeDXvYjOa+3vzUY=; b=
	yo6V/mDPxcaesGpYwKN7NilaBjW8TDQzbJHV6dR6PXUyQE+KVO4EqskWHPse/HJJ
	3jdDJPdOCWdV/zObaaHuq9EsTV1cP/xgfUBny7QSHrpVC+09/oomxs4113zQP34s
	YRsRuoLxcvtIlYifbLcVPKo8toznDYchSqvC4c2MAkunx7BAXJMuJFyvFHPQwyrR
	JvJfD32vWQCJp2zSjDK6s4EwNL+KQE8Bgk5oNJ013OmSKksi4lGtXypBKOSmvM3w
	Q3g9Z6peViCVbkr1mvBxBDltadzjya8+qb+r2DXVp67VzZ7qDGd/XEsskdJdDmYH
	FWFpOBqrenepwcVjyQw6Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712320682; x=
	1712407082; bh=9yZNkFVecyVcwhuRWOOXDSmgJ0AyNeDXvYjOa+3vzUY=; b=X
	R7uKliTKPNFdeXBUaphD0b13JnZc8hwIMv5yv9YTKIoGyOgrMrOryWOqR+DurFlp
	+vs+/pM6GPryMg3YGKhIKGJy9RbiAiYmAJ9QRZ57/M2dhtsUxY8UAZqA2f/+2VPa
	IM3qTEEnx7/BuTvhhdGqBpT17FULVVHdyCwrQXblRcHH4jMcPOj5eqtTnQ0XWB8j
	ZMCuhYsROOFK0mSbKqt/tiKo6QHB1TnCE1jJWIkg9XTzEEIMcrtqjvbWlsIpyjka
	nAL2CCZbc5GBptJoqOk83hmLJJEZUhIK7/8+u1syC//GuEq9UcCfahDoznvwc1/F
	WukmQ5Ot7Lr4/187woAhQ==
X-ME-Sender: <xms:qfAPZrE0eQ9MdXg-7i5QtOYS3YCLNdCh_7Z5d085taKBQQCuZWnegg>
    <xme:qfAPZoWRFNVtclqRumXaLWU8LtCFZlwUgPX4Jci8AS8fB1bC27E19OXotBhJbKPyh
    MkGuy2HF_-BnjRBeZU>
X-ME-Received: <xmr:qfAPZtLLe6iKFqnAT3mpklcuw-GUYwAGRBNQWb2J2mIr0FRY5VvBPFwD3kLADk2l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttddvjeenucfhrhhomheptfgrfhgr
    vghluceuvghimhhsuceorhgrfhgrvghlsegsvghimhhsrdhmvgeqnecuggftrfgrthhtvg
    hrnhepleehtdfhiefgieethfetgeegudehgeejuedujedvfeduveetheevtdfgudfhueel
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrfh
    grvghlsegsvghimhhsrdhmvg
X-ME-Proxy: <xmx:qfAPZpHgTzxeVmH5ad6yuVcTLG7bkIkWBaIHU-V5_mZ2w_cQXsvE9g>
    <xmx:qfAPZhWotHFvuxPVG9Jyq3aiqipB9T92-xLzwGTDMgivTHNMWgGUzA>
    <xmx:qfAPZkMLMWNwve4pd8ISmEN6dlyiObD_0kKz-UBLZ6CYJAIadQvrlA>
    <xmx:qfAPZg2PYTou7T5ZFRoHMdqEuL0HSzk7Wlb5q7dyF2XcUoQUNWGcxA>
    <xmx:qvAPZvc8D0P9Ma8wllYu6pYbcBq_aijTfXsn5-P8QTN3nxDV3o1v8bHvpfW6>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 08:38:00 -0400 (EDT)
Message-ID: <9fe44ea8-3e60-4bac-9362-63a3138f1493@beims.me>
Date: Fri, 5 Apr 2024 09:37:57 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate
 5% safety margin
Content-Language: en-US
To: Judith Mendez <jm@ti.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240403212426.582727-1-jm@ti.com>
From: Rafael Beims <rafael@beims.me>
In-Reply-To: <20240403212426.582727-1-jm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/2024 18:24, Judith Mendez wrote:
> On AM62x, the watchdog is pet before the valid window
> is open. Fix min_hw_heartbeat and accommodate a 5% safety
> margin with the exception of open window size < 10%,
> which shall use <5% due to the smaller open window size.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   drivers/watchdog/rti_wdt.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 8e1be7ba0103..0b16ada659cc 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -92,7 +92,7 @@ static int rti_wdt_start(struct watchdog_device *wdd)
>   	 * to be 50% or less than that; we obviouly want to configure the open
>   	 * window as large as possible so we select the 50% option.
>   	 */
> -	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
> +	wdd->min_hw_heartbeat_ms = 550 * wdd->timeout;
>   
>   	/* Generate NMI when wdt expires */
>   	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
> @@ -126,31 +126,33 @@ static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
>   	 * be petted during the open window; not too early or not too late.
>   	 * The HW configuration options only allow for the open window size
>   	 * to be 50% or less than that.
> +	 * To avoid any glitches, we accommodate 5% safety margin, with the
> +	 * exception of open window size < 10%.
>   	 */
>   	switch (wsize) {
>   	case RTIWWDSIZE_50P:
> -		/* 50% open window => 50% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
> +		/* 50% open window => 55% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 550 * heartbeat;
>   		break;
>   
>   	case RTIWWDSIZE_25P:
> -		/* 25% open window => 75% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
> +		/* 25% open window => 80% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 800 * heartbeat;
>   		break;
>   
>   	case RTIWWDSIZE_12P5:
> -		/* 12.5% open window => 87.5% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
> +		/* 12.5% open window => 92.5% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 925 * heartbeat;
>   		break;
>   
>   	case RTIWWDSIZE_6P25:
> -		/* 6.5% open window => 93.5% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
> +		/* 6.5% open window => 96.5% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 965 * heartbeat;
>   		break;
>   
>   	case RTIWWDSIZE_3P125:
> -		/* 3.125% open window => 96.9% min heartbeat */
> -		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
> +		/* 3.125% open window => 97.9% min heartbeat */
> +		wdd->min_hw_heartbeat_ms = 979 * heartbeat;
>   		break;
>   
>   	default:


I tested this patch by enabling the systemd watchdog adding 
RuntimeWatchdogSec=30 to system.conf on a Verdin AM62.

This setup causes watchdog resets without the patch, and with the patch 
applied I didn't see any watchdog related reboots.


Tested-by: Rafael Beims <rafael.beims@toradex.com>


Rafael



