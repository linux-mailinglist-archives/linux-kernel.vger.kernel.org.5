Return-Path: <linux-kernel+bounces-152516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 057638ABFA1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 16:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEFB1C20B4C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CDD18037;
	Sun, 21 Apr 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="vG8yyUS5"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8D11190
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713710198; cv=none; b=dndfv2NeiGy+HkwRBdP1ObbPShtyNV6I7BxVR9XUahyTM5yTmfovc6ER3fKpfkd3/QfGmDxpesnDwDhfDSdU4lLkBWyv98vUE+IpLvGvbVdKraMiB5xxFPEimY/hVe3CwNWAPupFCuJx4Xc2Y+irYjCycp7c8oSkBqAjBcHuENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713710198; c=relaxed/simple;
	bh=UeiE5owkBX2h1GBlgtsYVPJ3dV1up/iK+SY3HKhopZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdIhVfpdT45YectsaoqD8Yh/QsGJ9RGAabOXSBw03Y6clpHG/jjUrAwTcA2wlY9qBXCZ9vIY5S4bUCZ72d6QoZ8dhID64Tn6r21miSqUt6vUMUxWPqTUIKUAoYsDK2c2qcEtKbSnGE616sRfZKB/FKwSj7jg9wQJ753G1jogBRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=vG8yyUS5; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 45001881E5;
	Sun, 21 Apr 2024 16:36:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713710194;
	bh=RPV0Iz8yy+LInEIx4qwiC7zvbeZKL5hgL5XRaRhSxPA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vG8yyUS5eItl3QcJPKS9Dpaio8o/QryYvAULFuI7W7vrBY54u21latTBVHDd5DkJL
	 3KCxJSmdg4RK0mag1Ey0XNZpsqAcVGS4OWH+s36Z8pfwSfafdzEJMCnDX8/sTIsh+3
	 PdpIcZQCn0z24lTNWr99tBmtRFCh4oRNzAtGJe8/kBWTpNCOCY5qKvUC7dMtTlPQjk
	 nPuN5b4aZp3wVg6eBPPbTHq1n5pb3CfIMoBZBfhA6rfOHW1aiRa2eLE3aWHVD1ZdAO
	 D/M9oVd+XuKQbPbtpf8d2Vyyy6UMelVgh44UkwrEGlx9jEPShzHfrU0YtdlEPGDUUJ
	 3yQ1IANnjSlng==
Message-ID: <6111fe04-4ecb-428e-9a0c-dc02cadfe3e7@denx.de>
Date: Sun, 21 Apr 2024 16:06:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/bridge: samsung-dsim: Fix porch calcalcuation
 rounding
To: Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc: aford@beaconembedded.com, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Michael Tretter <m.tretter@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240211230931.188194-1-aford173@gmail.com>
 <20240211230931.188194-2-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240211230931.188194-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/12/24 12:09 AM, Adam Ford wrote:
> When using video sync pulses, the HFP, HBP, and HSA are divided between
> the available lanes if there is more than one lane.  For certain
> timings and lane configurations, the HFP may not be evenly divisible.
> If the HFP is rounded down, it ends up being too small which can cause
> some monitors to not sync properly. In these instances, adjust htotal
> and hsync to round the HFP up, and recalculate the htotal.
> 
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron BL i.MX8MM with HDMI monitor
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  No changes
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 8476650c477c..52939211fe93 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1606,6 +1606,27 @@ static int samsung_dsim_atomic_check(struct drm_bridge *bridge,
>   		adjusted_mode->flags |= (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
>   	}
>   
> +	/*
> +	 * When using video sync pulses, the HFP, HBP, and HSA are divided between
> +	 * the available lanes if there is more than one lane.  For certain
> +	 * timings and lane configurations, the HFP may not be evenly divisible.
> +	 * If the HFP is rounded down, it ends up being too small which can cause
> +	 * some monitors to not sync properly. In these instances, adjust htotal
> +	 * and hsync to round the HFP up, and recalculate the htotal. Through trial
> +	 * and error, it appears that the HBP and HSA do not appearto need the same
> +	 * correction that HFP does.
> +	 */
> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE && dsi->lanes > 1) {

Does this also apply to mode with sync events (I suspect it does), so 
the condition here should likely be if (!...burst mode) , right ?

