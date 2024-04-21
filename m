Return-Path: <linux-kernel+bounces-152484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8288ABF1D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7001C208C5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1FA125CC;
	Sun, 21 Apr 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y+vskJxH"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E80933D5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713701279; cv=none; b=l1n0ZDsLEfTtx3n5Z6xxMHVtAcTb8zOTfTMXPSUQSREpKTFxvzFm9exvZT4ZbkcllXTr7SD9Y+w6GI/hHYDN57HN1ix0yJJxqwa1fglACQRzpzthD4s4Vz2DpMpQITZR1MDomvGM6Vx0grEtRknBXHnJSr8jX/iVDN1XNYONuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713701279; c=relaxed/simple;
	bh=5t9i1tFwJM8WzaV17nFarWHAevNZdDbrrDX4kWOx5zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4GRPKJK5KBCTRuOmEY0zAsbAecKt6nU0bZOMfDYEnywDUbc+XROKI+WiKBfTusYLK3UwaF+X2kLCuUxYBw/g4tRzQVOnrC9WWFn9hHs51pcfvRfK0NBLJiV4V1mitRznsjbLXPCwtu46BqPhvMvdcDcmaM7dNTR3mJfbrhd+FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Y+vskJxH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7919CE1;
	Sun, 21 Apr 2024 14:07:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713701225;
	bh=5t9i1tFwJM8WzaV17nFarWHAevNZdDbrrDX4kWOx5zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+vskJxHsklch1JdwkAvvGfdOqOEugie7gpKX24QrLZBcz/YmxNuGTriSjbrnb4LQ
	 5Mea1omWXKrqDKtwZhGodr1ge+vclhZgq53hayDJG07GFlqXcw91Xogq8zTh2m9OpH
	 pex9KjGprVVEbnebWk0EnlMk820cf8b4lPmDbK4M=
Date: Sun, 21 Apr 2024 15:07:47 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
	kernel test robot <lkp@intel.com>, Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: imx: Fix unmet depenency for
 PHY_FSL_SAMSUNG_HDMI_PHY
Message-ID: <20240421120747.GA19147@pendragon.ideasonboard.com>
References: <20240420112831.5942-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240420112831.5942-1-aford173@gmail.com>

Hi Adam,

Thank you for the patch.

On Sat, Apr 20, 2024 at 06:28:31AM -0500, Adam Ford wrote:
> When enabling i.MX8MP DWC HDMI driver, it automatically selects
> PHY_FSL_SAMSUNG_HDMI_PHY, since it wont' work without the phy.
> This may cause some Kconfig warnings during various build tests.
> Fix this by implying the phy instead of selecting the phy.
> 
> Fixes: 1f36d634670d ("drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404190103.lLm8LtuP-lkp@intel.com/
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
> index 7687ed652df5..8f125c75050d 100644
> --- a/drivers/gpu/drm/bridge/imx/Kconfig
> +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> @@ -9,7 +9,7 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
>  	depends on DRM_DW_HDMI
>  	depends on OF
>  	select DRM_IMX8MP_HDMI_PVI

This also looks wrong, even if in practice it will likely work because
DRM_IMX8MP_HDMI_PVI has no extra dependency compared to
DRM_IMX8MP_DW_HDMI_BRIDGE. Still, it would be good to fix it.

> -	select PHY_FSL_SAMSUNG_HDMI_PHY
> +	imply PHY_FSL_SAMSUNG_HDMI_PHY
>  	help
>  	  Choose this to enable support for the internal HDMI encoder found
>  	  on the i.MX8MP SoC.

-- 
Regards,

Laurent Pinchart

