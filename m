Return-Path: <linux-kernel+bounces-91896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 111DD87180E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430411C2140A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C09C7FBB4;
	Tue,  5 Mar 2024 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Urje1p8L"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291037FBBF;
	Tue,  5 Mar 2024 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626699; cv=none; b=KreqF+HZY8HWBKHE4bZSJSNlTZq625+QJAuHssYko4a4uiXqlcEQPhk3amG8joaGQbA7E1Z6QjG0bEIJU7sf2QG0p81sgYp/Youc3nz7AfaVXOy7ohpvf9YwjKJYXNn5BoPiyp1VWEA7DKNkAi+ejyMAoIeZnfNhkTWEUOSsdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626699; c=relaxed/simple;
	bh=aQlT/8nL6oz1JmEwS10Qg0k/nHJTXACjpqXGIT3caBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ8cp5C1n0t8zFreinY9bQQyLeuQeHF30zRPsFekCsDSPPURj9lVE4T/KlxxAGxAhNuh31Ux72zCFnyDow6Za2ZXppn9DQwzw3KGfgXAhPK9d6GlPSAV+9usJLpCZPZgdQ5clzbp/luC32nCR9b5Sq7GC/Vc++SOsugrUZeyHaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Urje1p8L; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5A953CC8;
	Tue,  5 Mar 2024 09:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709626678;
	bh=aQlT/8nL6oz1JmEwS10Qg0k/nHJTXACjpqXGIT3caBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Urje1p8LiZLNSbDKARBxr0QGiU3RlKppsKJF+hofYjbP14x2FaJ7Y8MvSLps3tpmR
	 Nbznjt+clMtw1BdjRtNfYoaTCCLxilbA6GMu51xWpXbn9eQDd8VgLdTfPGfha4AYho
	 r8O2g3CTQKa2BjNe+rKfuV9sS3EKLAb6DGGWuRdk=
Date: Tue, 5 Mar 2024 10:18:16 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] drm/bridge: adv7511: Allow IRQ to share GPIO pins
Message-ID: <20240305081816.GF12503@pendragon.ideasonboard.com>
References: <20240305004859.201085-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305004859.201085-1-aford173@gmail.com>

Hello Adam,

Thank you for the patch.

On Mon, Mar 04, 2024 at 06:48:57PM -0600, Adam Ford wrote:
> The IRQ registration currently assumes that the GPIO is dedicated
> to it, but that may not necessarily be the case. If the board has
> another device sharing the GPIO, it won't be registered and the
> hot-plug detect fails to function.
> 
> Currently, the handler reads two registers and blindly
> assumes one of them caused the interrupt and returns IRQ_HANDLED
> unless there is an error. In order to properly do this, the IRQ
> handler needs to check if it needs to handle the IRQ and return
> IRQ_NONE if there is nothing to handle.  With the check added
> and the return code properly indicating whether or not it there
> was an IRQ, the IRQF_SHARED can be set to share a GPIO IRQ.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> V2:  Add check to see if there is IRQ data to handle
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> index b5518ff97165..f3b4616a8fb6 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -477,6 +477,11 @@ static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* If there is no IRQ to handle, exit indicating no IRQ data */
> +	if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> +	    !(irq1 & ADV7511_INT1_DDC_ERROR))
> +		return -ENODATA;
> +
>  	regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
>  	regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
>  
> @@ -1318,7 +1323,8 @@ static int adv7511_probe(struct i2c_client *i2c)
>  
>  		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
>  						adv7511_irq_handler,
> -						IRQF_ONESHOT, dev_name(dev),
> +						IRQF_ONESHOT | IRQF_SHARED,
> +						dev_name(dev),
>  						adv7511);
>  		if (ret)
>  			goto err_unregister_audio;

-- 
Regards,

Laurent Pinchart

