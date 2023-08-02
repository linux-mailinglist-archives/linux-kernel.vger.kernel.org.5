Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99E76D751
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjHBS4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjHBS4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:56:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B842CED
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:55:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B311F9CA;
        Wed,  2 Aug 2023 20:54:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691002478;
        bh=94D6ozUfI9FATQhs8jDdOIKGUnPXh85AgH0XdSn+Ugo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U1JGjkj0h265uJOSh/awUPBTfJYjqi8tAgeC2oGwyaqDZuZM+2EyfRzbBXYYXft+9
         sQNzPbqGc3i2X+hRLJR0KVUPF+E2dFDcbUaF1wbyHQoPwawrVLk2m80l76o+rZrwiN
         WdmcrS4nxYFU8PGkf63zbl4Rt625+jXpnBOBGh+E=
Date:   Wed, 2 Aug 2023 21:55:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Simon Ser <contact@emersion.fr>, Janne Grunau <j@jannau.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/uapi: document the USB subconnector type
Message-ID: <20230802185547.GC32500@pendragon.ideasonboard.com>
References: <20230729004913.215872-1-dmitry.baryshkov@linaro.org>
 <20230729004913.215872-4-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230729004913.215872-4-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Thank you for the patch.

On Sat, Jul 29, 2023 at 03:49:12AM +0300, Dmitry Baryshkov wrote:
> To properly define the USB-C DP altmode connectors, add the USB
> subconnector type.
> 
> Suggested-by: Simon Ser <contact@emersion.fr>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/drm_connector.c | 1 +
>  include/uapi/drm/drm_mode.h     | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index a6066e4a5e9a..9e96b038f5d0 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1050,6 +1050,7 @@ static const struct drm_prop_enum_list drm_dp_subconnector_enum_list[] = {
>  	{ DRM_MODE_SUBCONNECTOR_DisplayPort, "DP"        }, /* DP */
>  	{ DRM_MODE_SUBCONNECTOR_Wireless,    "Wireless"  }, /* DP */
>  	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
> +	{ DRM_MODE_SUBCONNECTOR_USB,	     "USB"       }, /* DP */

Should this be DRM_MODE_SUBCONNECTOR_USB_C and "USB-C", in case we get
another USB type later ?

>  };
>  
>  DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 92d96a2b6763..0f74918b011c 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -398,6 +398,7 @@ enum drm_mode_subconnector {
>  	DRM_MODE_SUBCONNECTOR_HDMIA       = 11, /*            DP */
>  	DRM_MODE_SUBCONNECTOR_Native      = 15, /*            DP */
>  	DRM_MODE_SUBCONNECTOR_Wireless    = 18, /*            DP */
> +	DRM_MODE_SUBCONNECTOR_USB         = 20, /*            DP */
>  };
>  
>  #define DRM_MODE_CONNECTOR_Unknown	0

-- 
Regards,

Laurent Pinchart
