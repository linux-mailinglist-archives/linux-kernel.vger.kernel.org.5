Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4E77820A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 00:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjHTWwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjHTWwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 18:52:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43309F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 15:52:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D5805FA2;
        Mon, 21 Aug 2023 00:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692571861;
        bh=a4e8VEKO1ZA5st0zk5K/VQkJiIOaA/nfBXzO6me1iPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEosBF2EgHsLU6QSEJT+Wxq/PI+Hq7bGsRI5Yfee2Olbe3ETxK8OCoK91AQcWg3qb
         38zkUJoGJkBpTde2F3K+VmRQY9wZa7DmbMEpP22fIoP1TuzBkUdULQiCDhuT0oVjnk
         Sr2Gjj8putVXuQSPSMtWDac1o4ar3Pp7hJgYswqQ=
Date:   Mon, 21 Aug 2023 01:52:23 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Suraj Upadhyay <usuraj35@gmail.com>
Subject: Re: [PATCH v11 3/8] drm: Remove usage of deprecated DRM_INFO in DRM
 core
Message-ID: <20230820225223.GA10135@pendragon.ideasonboard.com>
References: <cover.1692531217.git.code@siddh.me>
 <434cb488766d6c8fb596acc0caea245fc9c115d3.1692531217.git.code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <434cb488766d6c8fb596acc0caea245fc9c115d3.1692531217.git.code@siddh.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siddh,

Thank you for the patch.

On Sun, Aug 20, 2023 at 05:10:39PM +0530, Siddh Raman Pant wrote:
> drm_print.h says DRM_INFO is deprecated in favor of drm_info().
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_client_modeset.c | 2 +-
>  drivers/gpu/drm/drm_connector.c      | 7 ++++---
>  drivers/gpu/drm/drm_drv.c            | 2 +-
>  drivers/gpu/drm/drm_pci.c            | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index 1b12a3c201a3..ae19734974b5 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -331,7 +331,7 @@ static bool drm_client_target_cloned(struct drm_device *dev,
>  		DRM_DEBUG_KMS("can clone using 1024x768\n");
>  		return true;
>  	}
> -	DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
> +	drm_info(dev, "kms: can't enable cloning when we probably wanted to.\n");
>  	return false;
>  }
>  
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index bf8371dc2a61..1145d9e64c24 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -168,13 +168,14 @@ static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
>  		return;
>  
>  	if (mode->force) {
> -		DRM_INFO("forcing %s connector %s\n", connector->name,
> -			 drm_get_connector_force_name(mode->force));
> +		drm_info(connector->dev, "forcing %s connector %s\n",
> +			 connector->name, drm_get_connector_force_name(mode->force));
>  		connector->force = mode->force;
>  	}
>  
>  	if (mode->panel_orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN) {
> -		DRM_INFO("cmdline forces connector %s panel_orientation to %d\n",
> +		drm_info(connector->dev,
> +			 "cmdline forces connector %s panel_orientation to %d\n",
>  			 connector->name, mode->panel_orientation);
>  		drm_connector_set_panel_orientation(connector,
>  						    mode->panel_orientation);
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 3eda026ffac6..d457f2053c05 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -943,7 +943,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>  	if (drm_core_check_feature(dev, DRIVER_MODESET))
>  		drm_modeset_register_all(dev);
>  
> -	DRM_INFO("Initialized %s %d.%d.%d %s for %s on minor %d\n",
> +	drm_info(dev, "Initialized %s %d.%d.%d %s for %s on minor %d\n",
>  		 driver->name, driver->major, driver->minor,
>  		 driver->patchlevel, driver->date,
>  		 dev->dev ? dev_name(dev->dev) : "virtual device",
> diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
> index 39d35fc3a43b..7dfb837d1325 100644
> --- a/drivers/gpu/drm/drm_pci.c
> +++ b/drivers/gpu/drm/drm_pci.c
> @@ -262,7 +262,7 @@ void drm_legacy_pci_exit(const struct drm_driver *driver,
>  		}
>  		mutex_unlock(&legacy_dev_list_lock);
>  	}
> -	DRM_INFO("Module unloaded\n");
> +	drm_info(NULL, "Module unloaded\n");
>  }
>  EXPORT_SYMBOL(drm_legacy_pci_exit);
>  

-- 
Regards,

Laurent Pinchart
