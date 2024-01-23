Return-Path: <linux-kernel+bounces-34579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1F8381B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 03:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686441C23CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3DB4F611;
	Tue, 23 Jan 2024 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DHEyNI9M"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60C4A1A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705972632; cv=none; b=eEI8sAbUrvW7bdBXbc+pRbGM0D+xU4jB6fd4pefJhfXiMHqRFKpgzkXgbWEIBAt5daq0t+6Cyfj6Gmhd96RieEFz+NMcOXnKOOsVCZdLNa8qbWQfLVL5l763C547c6+it0qmM+0vWrFb+9kaKByGhG4Fg1dYL1vWz8Wi+/fMkAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705972632; c=relaxed/simple;
	bh=22dELSQHTcOkyOJDCSy4w/O6DClPqBTUGM3zbVdN6Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSHdc67/dXaSa2T/+8Hh3/gopyK0uNiIdPXNfYdZIaW4ZfV2TjLoq7hGwwAWq4hk5+X+o4ooPDG/bB3Qaunwq9Ih86bCzBJDen7c0ygbowJLc/ebSJDhZ9HWerBfVUtApmMnNmxV7f+H2CexZ6kIPnYo7kPBoFXUZkd10DOkiYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DHEyNI9M; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0185D1574;
	Tue, 23 Jan 2024 02:15:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1705972554;
	bh=22dELSQHTcOkyOJDCSy4w/O6DClPqBTUGM3zbVdN6Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHEyNI9MQcgQqsDstVKdkIn0e4tjkwezLEPzlaGFvGfrx6lFCnCgQ1kCrAmw+nvUJ
	 2tUl5mfEMZWrVXMX5B/EU0uG/LOt98szZnc88Hz6z1u8SOtnSGofbw0muQiTbowv5j
	 8/Zwci8dRWlgTQM/wEE3wYnPW87uv8zYCvKTxMVo=
Date: Tue, 23 Jan 2024 03:17:10 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: David Airlie <airlied@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] drm/bridge: Add drm_bridge_find_by_fwnode() helper
Message-ID: <20240123011710.GA22880@pendragon.ideasonboard.com>
References: <20240122163220.110788-1-sui.jingfeng@linux.dev>
 <20240122163220.110788-2-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240122163220.110788-2-sui.jingfeng@linux.dev>

Hi Sui,

Thank you for the patch.

On Tue, Jan 23, 2024 at 12:32:16AM +0800, Sui Jingfeng wrote:
> Because ACPI based systems only has the fwnode associated, the of_node
> member of struct device is NULL. To order to move things forward, we add
> drm_bridge_find_by_fwnode() to extend the support.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Could we switch completely to fwnode, instead of maintaining the fwnode
and OF options side-by-side ?

> ---
>  drivers/gpu/drm/drm_bridge.c | 33 +++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     |  4 ++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index cee3188adf3d..ffd969adc2fb 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1347,6 +1347,39 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  EXPORT_SYMBOL(of_drm_find_bridge);
>  #endif
>  
> +/**
> + * drm_bridge_find_by_fwnode - Find the bridge corresponding to the associated fwnode
> + *
> + * @fwnode: fwnode for which to find the matching drm_bridge
> + *
> + * This function looks up a drm_bridge based on its associated fwnode.
> + *
> + * RETURNS:
> + * A reference to the drm_bridge control structure if found, NULL on failure.
> + */
> +struct drm_bridge *drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode)
> +{
> +	struct drm_bridge *ret = NULL;
> +	struct drm_bridge *bridge;
> +
> +	if (!fwnode)
> +		return NULL;
> +
> +	mutex_lock(&bridge_lock);
> +
> +	list_for_each_entry(bridge, &bridge_list, list) {
> +		if (bridge->fwnode == fwnode) {
> +			ret = bridge;
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&bridge_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_bridge_find_by_fwnode);
> +
>  MODULE_AUTHOR("Ajay Kumar <ajaykumar.rs@samsung.com>");
>  MODULE_DESCRIPTION("DRM bridge infrastructure");
>  MODULE_LICENSE("GPL and additional rights");
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index e39da5807ba7..fe3d5f4bf37f 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -720,6 +720,8 @@ struct drm_bridge {
>  	struct list_head chain_node;
>  	/** @of_node: device node pointer to the bridge */
>  	struct device_node *of_node;
> +	/** @fwnode: associated fwnode supplied by platform firmware */
> +	struct fwnode_handle *fwnode;
>  	/** @list: to keep track of all added bridges */
>  	struct list_head list;
>  	/**
> @@ -796,6 +798,8 @@ static inline struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  }
>  #endif
>  
> +struct drm_bridge *drm_bridge_find_by_fwnode(struct fwnode_handle *fwnode);
> +
>  /**
>   * drm_bridge_get_next_bridge() - Get the next bridge in the chain
>   * @bridge: bridge object

-- 
Regards,

Laurent Pinchart

