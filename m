Return-Path: <linux-kernel+bounces-158433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B068B2008
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5F0281BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5E85654;
	Thu, 25 Apr 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bLVDuBDy"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253D84E11
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043654; cv=none; b=t0SeoL0nS8JvWtoJ4Zj9y73bT9iGvZyL6dOikPdJyEnn23kWP1yWKVESKeTeVvkdjIeBrtPlU0s6x0IZh3rz3bKD3QmejtMHVlGUDbeDUZjFWxnjo962bDi/0O8/Ymo/0aV5dKDi0ohhn84EwQDItoUEa1uatYtvXFdP8yN5OSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043654; c=relaxed/simple;
	bh=niR16qEKwPqjmNIq6bjqJcMcnb66MBAe9uEjIVqzIP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn/opzeqsZbWVV7Lpba1b/97IjOXupbqBQiglUvBem0G0d6DyuECRbyMRhWAnkTaMe0WZunvY+RtQ8DrpWr+6+eWsu071tLK4BTxrbKaWJydh9W5hHRuKfXPRVcTmfUO8lddT+LocZMJbp8GmwLZ9GlrfnMF/Quym1ibQat7AIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bLVDuBDy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2392AB0B;
	Thu, 25 Apr 2024 13:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714043598;
	bh=niR16qEKwPqjmNIq6bjqJcMcnb66MBAe9uEjIVqzIP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bLVDuBDyaEur9zVnBH3Iy8ObP2vK3yEgss7QXwjuRfCXNnYX9w5A/D0YpuFdCRk3e
	 hZMGgLHdMXgnmHhidf4gl9TEswJTasAGCykg1aeVvsxs2iwhTus89tepR/CJJc2qUA
	 SVLwr1e/nsCzMgpPx+XHLH20ALf1QsuBxzjx87IQ=
Date: Thu, 25 Apr 2024 14:14:03 +0300
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
Subject: Re: [PATCH V2] drm/bridge: imx: Fix unmet depenency for
 PHY_FSL_SAMSUNG_HDMI_PHY
Message-ID: <20240425111403.GB28454@pendragon.ideasonboard.com>
References: <20240422103352.8886-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240422103352.8886-1-aford173@gmail.com>

Hi Adam,

Thank you for the patch.

On Mon, Apr 22, 2024 at 05:33:52AM -0500, Adam Ford wrote:
> When enabling i.MX8MP DWC HDMI driver, it automatically selects
> PHY_FSL_SAMSUNG_HDMI_PHY, since it wont' work without the phy.
> This may cause some Kconfig warnings during various build tests.
> Fix this by implying the phy instead of selecting the phy.
> 
> To prevent this from happening with the DRM_IMX8MP_HDMI_PVI, also
> imply it instead of selecting it.
> 
> Fixes: 1f36d634670d ("drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404190103.lLm8LtuP-lkp@intel.com/
> Signed-off-by: Adam Ford <aford173@gmail.com>

This looks sensible to me.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> V2:  Change DRM_IMX8MP_HDMI_PVI at the same time since it was affected
>      from the same commit.
> 
> diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
> index 7687ed652df5..13142a6b8590 100644
> --- a/drivers/gpu/drm/bridge/imx/Kconfig
> +++ b/drivers/gpu/drm/bridge/imx/Kconfig
> @@ -8,8 +8,8 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
>  	depends on COMMON_CLK
>  	depends on DRM_DW_HDMI
>  	depends on OF
> -	select DRM_IMX8MP_HDMI_PVI
> -	select PHY_FSL_SAMSUNG_HDMI_PHY
> +	imply DRM_IMX8MP_HDMI_PVI
> +	imply PHY_FSL_SAMSUNG_HDMI_PHY
>  	help
>  	  Choose this to enable support for the internal HDMI encoder found
>  	  on the i.MX8MP SoC.

-- 
Regards,

Laurent Pinchart

