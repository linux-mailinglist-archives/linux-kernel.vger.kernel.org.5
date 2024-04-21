Return-Path: <linux-kernel+bounces-152517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19DE8ABFA3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD531C20D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484BD1BC2A;
	Sun, 21 Apr 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VnQuc3mi"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFF18044
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713710200; cv=none; b=FPnoMnR8pSHW/hYZmledOhkn3o1kX85b7Wgg1x4vS/aIjA63j6C6X6kuC38xj6L0TRw1+smsDt1Ec5s8LzSV8ZW3s7njVKBaXlJEBEXqK/jjc1tHk6vVuj2nbCn/UzuCqbLUQv/9IQEFhKRq2E7h8PJ2uO5/fOJKmH/PSqFXBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713710200; c=relaxed/simple;
	bh=QWTbZqy5lTrwfWMVMScZBHUEFIHVdDptRtsd0agUg80=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZDhTJTcVt+jl03mYF7r2p7BLiQFcjBQx+yrisA03/DRumDH5MANcVzRwgw3uZocC+sb7bMebjRijp8Sjr5iRWuQJpbvy1/4eXrZJ9zh36/GWqydm7H/r94Bmp7XUR9Vr4JccXz9dJm5IYxVf48m3Y5hRAjE3WLSGzi58qZHq3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VnQuc3mi; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7166888276;
	Sun, 21 Apr 2024 16:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713710197;
	bh=qN/AyrbP3w0CH/0SM3qG6WDHoGfkio3UiZLbi7y6Udc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VnQuc3miSCXSguOH/iRYdeYU0fsDvh4xLPXcewr4tSaojRZco3vySrGQnGtVameHV
	 b94pYJPd7NaXk4l3npnPH765JZmXBZY1Vsk+3vT3d0XcvsvE6j1954A1bQleR8O3Ac
	 YQK+yIn4rwMVy73fkJ/y13X9WXAXCtSaPUjDkcZekTQnvs6KO0/bGQLH1Pil+Vr5n4
	 y/BSaAs3j2pb6IZvKhdcjbToTKA8tAoryxnD60vTDlt+LnVxk2auCJCcS1vZCrhzvc
	 faUjIjAsYMv/WKRWHfxYfS/+3vqHh69l3MpPLqlY/Qr4JA18tiWfIddM6zmQmqM/FB
	 /Hmi1kPgerL6w==
Message-ID: <4da75f3b-16a7-46f4-97d9-6f51a54fbe7e@denx.de>
Date: Sun, 21 Apr 2024 16:25:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] drm: bridge: dw-mipi-dsi: Call modeset in modeset
 callback
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Douglas Anderson <dianders@chromium.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Liu Ying <victor.liu@nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
References: <20240421002330.172723-1-marex@denx.de>
 <t3dkuckbko5lmkfezhdtcwrynnbcs4yfn5mtmdyirnktellc5a@ktab3j6rvf3u>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <t3dkuckbko5lmkfezhdtcwrynnbcs4yfn5mtmdyirnktellc5a@ktab3j6rvf3u>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/21/24 1:09 PM, Ondřej Jirman wrote:
> Hi,

Hi,

> On Sun, Apr 21, 2024 at 02:22:35AM GMT, Marek Vasut wrote:
>> Doing modeset in .atomic_pre_enable callback instead of dedicated .mode_set
>> callback does not seem right. Undo this change, which was added as part of
> 
> Actually no. If anything, mode_set callback should be dropped entirely:
> 
> See https://elixir.bootlin.com/linux/latest/source/include/drm/drm_bridge.h#L231
> 
> It's deprecated, and enable callback should just use adjusted_mode:
> 
>      This is deprecated, do not use! New drivers shall set their mode in the
>      &drm_bridge_funcs.atomic_enable operation.

This mentions new drivers ?

>> commit 05aa61334592 ("drm: bridge: dw-mipi-dsi: Fix enable/disable of DSI
>> controller") as it breaks STM32MP15xx LTDC scanout (DSI)->TC358762 DSI-to-DPI
>> bridge->PT800480 DPI panel pipeline. The original fix for HX8394 panel likely
>> requires HX8394 panel side fix instead.
> 
> There's nothing wrong with the panel driver. And that commit is not fixing issue
> with the panel driver, just like the subject hints at. Look at the referenced
> commit, at "Before:" sequence specifically.
> 
> dw_mipi_dsi_mode_set may be named *_mode_set or whatever, but it's basically
> an enable function that turns on clocks, initalizes phy, etc. etc.
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c#L998
> 
> And if you check "Before:" sequence, you'll see that .mode_set callback is just
> called once at boot and never again. And it's atomic(_pre)_enable/atomic(_post)_disable
> callbacks that actually are called in ballanced way to enable/disable the
> controller repeatedly ever after.
> 
> Function dw_mipi_dsi_bridge_post_atomic_disable is the inverse of
> dw_mipi_dsi_mode_set, it undoes everything that dw_mipi_dsi_mode_set does.
> 
> You need to find root cause for your issue on STM32MP15xx instead of reverting
> fixes for resource use bugs in this driver.

Actually, reverting commit 05aa61334592 ("drm: bridge: dw-mipi-dsi: Fix 
enable/disable of DSI controller") makes the STM32MP15xx work again like 
it used to since Linux 5.10 or so, so that commit breaks existing 
working use case.

It seems it is sufficient to revert only this part of the commit to make 
the STM32MP15xx work as it used to, do you have any idea why ?

