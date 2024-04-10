Return-Path: <linux-kernel+bounces-138289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218AA89EF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD6F1F217A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0291586CD;
	Wed, 10 Apr 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H+y0ra/c"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12AF8BE8;
	Wed, 10 Apr 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742947; cv=none; b=dnPh5pWoEunsBPRCe8W5TvqpD4T9BL6VVP/yBDdkiYHcJl2Ca9RSYd67N7GN/hngRqZY1qb7wUkTI9legULLpZ5bM5UfjDunWOfq4VXcrZM8t+v5u8Q0rWTN+pgyDK9ieOoq1WCaYtuAZ5EessJFYPfjVqCfNMSOXFwFX7boqJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742947; c=relaxed/simple;
	bh=vtMV+Q63GqmW7FHaxb//RVu//0rLNFnAcEs9bPdrm4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2yhfhR8AV3KMoJ6B4HQBPOa9XS/+IZmSncG+lscza0IHAlyHyLNye6HVtOC9L8EZP7pvxlNhMbaSiG9TivEYbPsGXXF541O1l9zL+kcvBXZ12IpEXPlVfR5fdAHCwufe/wn1lfxd9FMzBX5rWDTa3V5AuDeYOnwxz1vgG0ngWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H+y0ra/c; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712742943;
	bh=vtMV+Q63GqmW7FHaxb//RVu//0rLNFnAcEs9bPdrm4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H+y0ra/c8fi8Dwjg9BpujJCQ3xxygBdVjA500qeuCeFzp+ZJCdVlH8vvyIyeB9HsR
	 DA5s1nO7qp99kI1dgRqnd1PTbpBFjs85i5qV3Hot/2ZAXB89CtB/5J2ArHtfxZIfc4
	 o/FWIUIdxtTElcmjbWlPUDCyyKR6tMyoviCKvabZV/v9HK5a7zrZqMjw0p3nHjnN3w
	 4zb7jFPSByx5cem0sGHo6y2Jk2hE3kOqoj2HdC2Zn2bOr9PjbduZgwf4kp6YPA3R7C
	 5aFuSh9WocJO85woaHW5vSI8fz2DgrmTJwQM0lPD7FsT9kfnHlBFDXjwU2o2Vs0Wny
	 qEFI8NSPXteGQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C1E25378000E;
	Wed, 10 Apr 2024 09:55:42 +0000 (UTC)
Message-ID: <9c5aa4fb-a83c-470e-acf8-dd31303e50c2@collabora.com>
Date: Wed, 10 Apr 2024 11:55:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Remove redundant
 code in lvts_ctrl_configure
To: Pin-yen Lin <treapking@chromium.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Minjie Du <duminjie@vivo.com>, linux-pm@vger.kernel.org,
 Frank Wunderlich <frank-w@public-files.de>,
 Balsam CHIHI <bchihi@baylibre.com>
References: <20240410000730.628043-1-treapking@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240410000730.628043-1-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 10/04/24 02:07, Pin-yen Lin ha scritto:
> The removed variable assignment is never written to the register, so it
> has no effect on the device behavior.  Mediatek has confirmed that it
> is not required to initialize this register for current platforms, so
> remove this segment to avoid confusion.
> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

Added Nicolas Pitre to the loop;

Nicolas, since you're pushing support for those, can you please check if CALSCALE
is used/useful/necessary on MT8186/88 before I give a R-b to this commit?

P.S.: Can anyone from MediaTek please confirm if the 0x300 value is right for this
       register? I'd still like Linux to properly initialize the registers, even if
       this could technically be a default value.


> ---
> 
>   drivers/thermal/mediatek/lvts_thermal.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index fd4bd650c77a..48d2f8ba3f18 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -985,12 +985,6 @@ static int lvts_ctrl_configure(struct device *dev, struct lvts_ctrl *lvts_ctrl)
>   	value = LVTS_TSSEL_CONF;
>   	writel(value, LVTS_TSSEL(lvts_ctrl->base));
>   
> -	/*
> -	 * LVTS_CALSCALE : ADC voltage round
> -	 */
> -	value = 0x300;
> -	value = LVTS_CALSCALE_CONF;

As a side note, I believe that the original author wanted to write, instead...

	value = LVTS_CALSCALE_CONF;
	writel(value, LVTS_CALSCALE(lvts_ctrl->base);

Cheers,
Angelo

> -
>   	/*
>   	 * LVTS_MSRCTL0 : Sensor filtering strategy
>   	 *


