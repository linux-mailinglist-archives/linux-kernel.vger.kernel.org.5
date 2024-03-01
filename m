Return-Path: <linux-kernel+bounces-87954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542F886DB74
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084CD287F6C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8933A8DD;
	Fri,  1 Mar 2024 06:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sjuvuVk3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F45FBBF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274621; cv=none; b=OxYiO+qTZ37xxSo3J4RwDbvlIsReNdq4fa7c40lD1n9r8aBW1iL13UtRacBhfou2PtKa/XcP59vTaAJRhozIRPjyugmW6lH1Ek/Ay/sJup+uEB4IZGLjv3si3msjFvz4IWfAkfZenGwssV/EebtkqIrcR40VUm8u4ARu91qiVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274621; c=relaxed/simple;
	bh=yQbUQsOdFYQQXWH7Fu3bQwR+ZertHCl0TbbU2bMrM9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufdQETrDAEHT/vrAcAojYIiEk7feRnKX7LKVHGPNyj9H2j7a7KDv+kimVzjXZShzQCT8ybqVt1vLCfSuFCvI95YZzUgnjhDtWBwiNzmQR80o6A66bCsPqntSyvKe/6NXkTRgo4jECM2F26cGKNpS89pLlIMjs7eBlgf7CHBlfBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sjuvuVk3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B21AD15EE;
	Fri,  1 Mar 2024 07:30:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709274603;
	bh=yQbUQsOdFYQQXWH7Fu3bQwR+ZertHCl0TbbU2bMrM9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjuvuVk3mvhPD4qOQdsUfQL9rsF7Ebg/5dWQ0amqTckNifDDjFNTOQRMzgM3usEBu
	 /py7bYR1hX+q7b0FmLKseEmEHuUoiAxuU6Eypnw6UXw0yQk6hiBSEOqggJocR7sJgB
	 +8aPDIfsBp3wgLtdNcPC7z1VReju+5hs4I/6PfLg=
Date: Fri, 1 Mar 2024 08:30:20 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	owen <qwt9588@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
	Marek Vasut <marex@denx.de>,
	Adrien Grassein <adrien.grassein@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vinay Simha BN <simhavcs@gmail.com>,
	Christopher Vollo <chris@renewoutreach.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	kernel@collabora.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 9/9] drm/panel: truly-nt35597: Don't log an error when
 DSI host can't be found
Message-ID: <20240301063020.GL30889@pendragon.ideasonboard.com>
References: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
 <20240229-anx7625-defer-log-no-dsi-host-v2-9-00506941049a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229-anx7625-defer-log-no-dsi-host-v2-9-00506941049a@collabora.com>

Hi Nícolas,

Thank you for the patch.

On Thu, Feb 29, 2024 at 07:12:15PM -0500, Nícolas F. R. A. Prado wrote:
> Given that failing to find a DSI host causes the driver to defer probe,
> make use of dev_err_probe() to log the reason. This makes the defer
> probe reason available and avoids alerting userspace about something
> that is not necessarily an error.
> 
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/gpu/drm/panel/panel-truly-nt35597.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
> index b73448cf349d..d447db912a61 100644
> --- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
> +++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
> @@ -550,10 +550,8 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
>  
>  	dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
>  	of_node_put(dsi1);
> -	if (!dsi1_host) {
> -		dev_err(dev, "failed to find dsi host\n");
> -		return -EPROBE_DEFER;
> -	}
> +	if (!dsi1_host)
> +		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");

		return dev_err_probe(dev, -EPROBE_DEFER,
				     "failed to find dsi host\n");

With this addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  	/* register the second DSI device */
>  	dsi1_device = mipi_dsi_device_register_full(dsi1_host, &info);
> 

-- 
Regards,

Laurent Pinchart

