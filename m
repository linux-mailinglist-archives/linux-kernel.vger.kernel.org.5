Return-Path: <linux-kernel+bounces-87952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D562186DB70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FE01C2262B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19455F843;
	Fri,  1 Mar 2024 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="voaQ/OQU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787F3A1DC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274569; cv=none; b=kscgdC4ioWKBkqz7xl5EFPpJJ4Hhs7dOnbX52htL6o5sq859PHxUyHHA2UHYTHLyRkWk8D2tt1cdudyFOVcwzh8ngbkfL/QAmFvTtXEjPm0JBE9Mek3MfjgSi+Pc6vCRR64EC+ZwI7G1yjIjnHHnENjcUzCK5BBFuQn5YOdEoM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274569; c=relaxed/simple;
	bh=aeGiOvUNWFB44kw5uf/9p/wmucL3JVEsUpe4CuPUWEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXONudr0JCOP/nse29GhYbYTcGBL2Wub3MxrPg5rOchIBM8VsdT2knezf9uRHiz2zHWkpy3u1fWX8ieAGTLOS0OQsaW5LIHOY4rjXyq6Mt9f4kral6U2IKWmx8EJxp3bKHAuH4zsaoMTrsyYr0ZTMGFtqHX59V0LxmWXOgg3KfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=voaQ/OQU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 41EAE9CE;
	Fri,  1 Mar 2024 07:29:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709274543;
	bh=aeGiOvUNWFB44kw5uf/9p/wmucL3JVEsUpe4CuPUWEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=voaQ/OQU5xC3qLX5hG8/6UBRTL7Hcwa1D39IHDyTqxiNPAIylYE2vEdH1x+BAZl6F
	 SS6IHESFOkEucozhKW9m+gbfUt3fCbubJz0QFflZas+SZLyn5kKDhb2Z/IB9dyx9Oi
	 G/TSTeinLVtk8N/LzgNyM3F9w2nY1poo7yUwZH/s=
Date: Fri, 1 Mar 2024 08:29:20 +0200
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
Subject: Re: [PATCH v2 8/9] drm/panel: novatek-nt35950: Don't log an error
 when DSI host can't be found
Message-ID: <20240301062920.GK30889@pendragon.ideasonboard.com>
References: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
 <20240229-anx7625-defer-log-no-dsi-host-v2-8-00506941049a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240229-anx7625-defer-log-no-dsi-host-v2-8-00506941049a@collabora.com>

Hi Nicolas,

Thank you for the patch.

On Thu, Feb 29, 2024 at 07:12:14PM -0500, Nícolas F. R. A. Prado wrote:
> Given that failing to find a DSI host causes the driver to defer probe,
> make use of dev_err_probe() to log the reason. This makes the defer
> probe reason available and avoids alerting userspace about something
> that is not necessarily an error.
> 
> Fixes: 623a3531e9cf ("drm/panel: Add driver for Novatek NT35950 DSI DriverIC panels")
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt35950.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> index 648ce9201426..028fdac293f7 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
> @@ -556,10 +556,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
>  		}
>  		dsi_r_host = of_find_mipi_dsi_host_by_node(dsi_r);
>  		of_node_put(dsi_r);
> -		if (!dsi_r_host) {
> -			dev_err(dev, "Cannot get secondary DSI host\n");
> -			return -EPROBE_DEFER;
> -		}
> +		if (!dsi_r_host)
> +			return dev_err_probe(dev, -EPROBE_DEFER, "Cannot get secondary DSI host\n");

			return dev_err_probe(dev, -EPROBE_DEFER,
					     "Cannot get secondary DSI host\n");

With this,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
>  		if (!nt->dsi[1]) {
> 

-- 
Regards,

Laurent Pinchart

