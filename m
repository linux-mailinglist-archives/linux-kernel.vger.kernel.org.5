Return-Path: <linux-kernel+bounces-133051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2448C899E14
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA731F22705
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661B16D4CC;
	Fri,  5 Apr 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="oYdAFV+/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vb9IlwIC"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331E16D33A;
	Fri,  5 Apr 2024 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322712; cv=none; b=MaQwH8eqV/fFlPafKPRxmpdSHtjSXic9Ypp16IoHznmsdq0CaOH/xdxINqI6wwG8SztY82LRAf4SLl0tlPQ7QLJoSd0Z/E18pFjWRZL7iSaDxhedzenkOH2CzDhuhqBVojlTQ4t6pCf56YtR/7BHrEPixc9P2Y8IbgE9NpQa11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322712; c=relaxed/simple;
	bh=Pnb0JVfDd2AT2wehrIl4AxYkTliXvgkqqIMPGXnCdc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeATi9FlrQxDEOpjh/2I0XHdYlHPSqR9KXryXBmOe392t6IUJz3nya+Wb3jlGVr2MSTJEE9WDQcBfaaldLtlOafkfPXFiUVheV34NMSI3OrVVuXrjKla+mRPzIIF9zi9L9gdCzDJBh4snOgSJYg3QEy27yko8enuUXtgJsXBR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=oYdAFV+/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vb9IlwIC; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id A4E7C32000D9;
	Fri,  5 Apr 2024 09:11:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 05 Apr 2024 09:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1712322708;
	 x=1712409108; bh=qI3pcWziRd9w6ZdQsFy3xHZSry+rZYZcRpH3Dy+mFlU=; b=
	oYdAFV+/Pt5/XWbGQj+1X3aH+nbnfSAuH64MGl/FkZJrSCx5EKLtNHKSbmWa8jCt
	RKECv0XEr48oSmz8BFquPUA/I4b8kDuiJfj8n3oG8cwQ/BBVgCPDhHigQMotPOlX
	jJAEw2TR617nTk5dK5YjnsBEOkbsKsuxQ9+yJTpECdokqteC0zXvKWhZhtwCyRTY
	dpp8STD52NdZw7W9tJdbZ2zGSOlIPxf4/2zbHk+RIPNRYnWTgMTdesAMkmNfr1xy
	w7yjYERRwQusqtYd9hpHTNuMzz7X97WjRnGIjlj3lH/PNOk373Y9A9bYVEo1QifZ
	0igm6eDHP3KCEcEvw0FswQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712322708; x=
	1712409108; bh=qI3pcWziRd9w6ZdQsFy3xHZSry+rZYZcRpH3Dy+mFlU=; b=V
	b9IlwICEXNv+Gfwxuws6pZFB8vSVmoR5BiPKNYYQkWoQe3OI7YZA60KZKDKQiUCQ
	DP+jmzj5UMzpiG7SJMmnBiwASryDJ8z6H9JJ9mk8N6q22JzOjCZiGQhwRtYkfGv/
	cbV6kNZlJUv6iTTJ3oY1KRrgizi/eN8+RITYN/gNzyvGaG+TAx2+FqIF7CoGwIES
	PlrCBcWSh3vBpV0ICg+yD4t15lEIVjkUTaPcUMxKgoq2aBV+4llrLimEDeAe9EJf
	ZiQn4zGzD9i7w7Uv9HPaqDyBo6Ya5LhJpJoDaYMAliM1lXtvhj+9HyvidoodJwxf
	cggyS2nDovpn2YxBikM1A==
X-ME-Sender: <xms:k_gPZvbZIF4YCi6u_ocVkOJjmYX-BXmS18-2dnMtG0Y-L2Zz1O0vug>
    <xme:k_gPZubtjSJVGrGDSv90qtOVQo-nFfFeTW0B9IZu5FzbolDoOAK80eHUNh9aPhfXw
    rx8XfmII3sDyb73wtU>
X-ME-Received: <xmr:k_gPZh9Hk_XHH42X3pTkKYydKwrz9aclRc0ajXgnaui2ynW_4eoX1DDgBj75kEGR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeftrghf
    rggvlhcuuegvihhmshcuoehrrghfrggvlhessggvihhmshdrmhgvqeenucggtffrrghtth
    gvrhhnpeejieejvdelgeduveejgeeltdevieefteejleeiieejgeeihfelleehtdegudei
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrg
    hfrggvlhessggvihhmshdrmhgv
X-ME-Proxy: <xmx:k_gPZlqOEpmwx1db4otyyrXdy7BxIN1yoO3HnuwNlth4f-1tRuihaA>
    <xmx:k_gPZqo8B1zxGrkqLEagHCJIE2ATj7KUHeqA7taON4bcm-4vkdoYZw>
    <xmx:k_gPZrQsNInDmFFMnxfythvCZwhCnztNsaAkT_XC-dPlNQk_GDVzug>
    <xmx:k_gPZipS7gv70ZRgSwErG3dISj8BqoB3790p8OrDiM1DlMKS4KsHQA>
    <xmx:lPgPZreo8NaQ6USuODbNdUu_pzNGWj7Wrdfb1mK635YeVjnWlNyH40qQJcar>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 09:11:46 -0400 (EDT)
Message-ID: <96b7715e-8cbe-4f85-bdf3-3aca64536d4e@beims.me>
Date: Fri, 5 Apr 2024 10:11:45 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: rti_wdt: Set min_hw_heartbeat_ms to
 accommodate 5% safety margin
Content-Language: pt-BR
To: Judith Mendez <jm@ti.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Francesco Dolcini <francesco@dolcini.it>
References: <20240404153319.1088644-1-jm@ti.com>
From: Rafael Beims <rafael@beims.me>
In-Reply-To: <20240404153319.1088644-1-jm@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2024 12:33, Judith Mendez wrote:
> On AM62x, the watchdog is pet before the valid window
> is open. Fix min_hw_heartbeat and accommodate a 5% safety
> margin with the exception of open window size < 10%,
> which shall use <5% due to the smaller open window size.
>
> cc: stable@vger.kernel.org
> Fixes: 5527483f8f7c (" watchdog: rti-wdt: attach to running watchdog during probe")
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
>
> base-commit: 860bbe8e618fd62446309e286ab4a83d38201c0a


Tested-by: Rafael Beims <rafael.beims@toradex.com>


Rafael


