Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DC6768A86
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjGaEBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGaEBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:01:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DE0AD
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 21:01:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so6363411e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 21:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690776092; x=1691380892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s8u97lqotaNl/hOcbem4KK1UDnxjWFMW3VzsF7w5Bhw=;
        b=C/AwymanRSfwefv1q5htgwAx/CvlemfksOfOZvyqZLIb7BkU1JIarJYLxziIpgh6Em
         wGlcGavpwFmKm+cyBhdM12oDgIPSrpeEzdR0E/p/N7GqwItWstP0dWx/3n5CogdUJitS
         dlFNgLrQyhn93oIC1F4j0qT3Qgv42HXZPa2HrUOu0rpPxti/FbO1KgZ0gNl7eZ8Sf94o
         lDq40jZv+pLUImqa8ymyZ5Ft7QkjfY/cv/qKvx43CqNZ9+6UextqG8I7TkzJvaVwOY+/
         ZvW+qnJOOhDQNChs5yI76mUjOMWh3NRg1DYJqx4OZk34cg6n16Ziu1SC5RkJt0kgblk4
         aNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690776092; x=1691380892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8u97lqotaNl/hOcbem4KK1UDnxjWFMW3VzsF7w5Bhw=;
        b=fzaqrZuIr9TohOhviw8lOYRr/LxkRkgtrfyqJReiggzZ8JztY+YfmVKEx1Mir910fq
         j7aIath8TDeVW0kXq16KcwBNnI6orl+ofBOWr9tkiE1HF8tPeu7CkTZlyXqtEzZMK4j+
         nev2rBqQzhmemS6FtM4UiXr8EDWQx66/ol1DtZFaNvarnvMPIluriTBiTHCaV9ckuf4y
         n41kLT+bfZmBMnXZujhADqCd13E6rEiPuq4mJ0+cY5slGIqfxJiSFcSPKcFFSfDMUAkH
         vpIVzJlIhbMR2XEn7HlQPZHkPKaNXSGBQvBANrl/MUz2NyJ0Wb6X3j5usrIt7qe3qI2D
         nEeA==
X-Gm-Message-State: ABy/qLZJGhN5ZTK9VecI+Skb+Q9rZlssmvyobrBEbCZySneJtmz9nW9g
        K8mIX8r+phPXtPdSb0laSgaQRw==
X-Google-Smtp-Source: APBJJlFjZVN+phbH8H7grHIe9dFDGro/sLoDXEz5vT4iqsaEYKwetddc4PlFBqaVuoL+kBrA8xHVnQ==
X-Received: by 2002:a2e:3012:0:b0:2b9:bc5c:1b28 with SMTP id w18-20020a2e3012000000b002b9bc5c1b28mr5166533ljw.49.1690776092236;
        Sun, 30 Jul 2023 21:01:32 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id d16-20020a2e96d0000000b002b724063010sm2384544ljj.47.2023.07.30.21.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 21:01:31 -0700 (PDT)
Message-ID: <de8388d2-5625-2737-3997-4fa23baa3693@linaro.org>
Date:   Mon, 31 Jul 2023 07:01:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v5 02/10] drm: Introduce solid fill DRM plane property
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
References: <20230728-solid-fill-v5-0-053dbefa909c@quicinc.com>
 <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230728-solid-fill-v5-2-053dbefa909c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 20:02, Jessica Zhang wrote:
> Document and add support for solid_fill property to drm_plane. In
> addition, add support for setting and getting the values for solid_fill.
> 
> To enable solid fill planes, userspace must assign a property blob to
> the "solid_fill" plane property containing the following information:
> 
> struct drm_mode_solid_fill {
> 	u32 version;
> 	u32 r, g, b;
> };
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/drm_atomic_state_helper.c |  9 +++++
>   drivers/gpu/drm/drm_atomic_uapi.c         | 55 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_blend.c               | 30 +++++++++++++++++
>   include/drm/drm_blend.h                   |  1 +
>   include/drm/drm_plane.h                   | 35 ++++++++++++++++++++
>   include/uapi/drm/drm_mode.h               | 24 ++++++++++++++
>   6 files changed, 154 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 01638c51ce0a..86fb876efbe6 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -254,6 +254,11 @@ void __drm_atomic_helper_plane_state_reset(struct drm_plane_state *plane_state,
>   	plane_state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
>   	plane_state->pixel_source = DRM_PLANE_PIXEL_SOURCE_FB;
>   
> +	if (plane_state->solid_fill_blob) {
> +		drm_property_blob_put(plane_state->solid_fill_blob);
> +		plane_state->solid_fill_blob = NULL;
> +	}
> +
>   	if (plane->color_encoding_property) {
>   		if (!drm_object_property_get_default_value(&plane->base,
>   							   plane->color_encoding_property,
> @@ -336,6 +341,9 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>   	if (state->fb)
>   		drm_framebuffer_get(state->fb);
>   
> +	if (state->solid_fill_blob)
> +		drm_property_blob_get(state->solid_fill_blob);
> +
>   	state->fence = NULL;
>   	state->commit = NULL;
>   	state->fb_damage_clips = NULL;
> @@ -385,6 +393,7 @@ void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state)
>   		drm_crtc_commit_put(state->commit);
>   
>   	drm_property_blob_put(state->fb_damage_clips);
> +	drm_property_blob_put(state->solid_fill_blob);
>   }
>   EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
>   
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 454f980e16c9..039686c78c2a 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -316,6 +316,51 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
>   }
>   EXPORT_SYMBOL(drm_atomic_set_crtc_for_connector);
>   
> +static int drm_atomic_set_solid_fill_prop(struct drm_plane_state *state,
> +		struct drm_property_blob *blob)
> +{
> +	int blob_version;
> +
> +	if (blob == state->solid_fill_blob)
> +		return 0;
> +
> +	if (blob) {
> +		struct drm_mode_solid_fill *user_info = (struct drm_mode_solid_fill *)blob->data;
> +
> +		if (blob->length != sizeof(struct drm_mode_solid_fill)) {
> +			drm_dbg_atomic(state->plane->dev,
> +				       "[PLANE:%d:%s] bad solid fill blob length: %zu\n",
> +				       state->plane->base.id, state->plane->name,
> +				       blob->length);
> +			return -EINVAL;
> +		}
> +
> +		blob_version = user_info->version;

I remember that we had versioning for quite some time. However it stroke 
me while reviewing that we do not a way to negotiate supported 
SOLID_FILL versions. However as we now have support for different 
pixel_source properties, maybe we can drop version completely. If at 
some point a driver needs to support different kind of SOLID_FILL 
property (consider v2), we can add new pixel source to the enum.

> +
> +		/* Add more versions if necessary */
> +		if (blob_version == 1) {
> +			state->solid_fill.r = user_info->r;
> +			state->solid_fill.g = user_info->g;
> +			state->solid_fill.b = user_info->b;
> +		} else {
> +			drm_dbg_atomic(state->plane->dev,
> +				       "[PLANE:%d:%s] unsupported solid fill version (version=%d)\n",
> +				       state->plane->base.id, state->plane->name,
> +				       blob_version);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	drm_property_blob_put(state->solid_fill_blob);
> +
> +	if (blob)
> +		state->solid_fill_blob = drm_property_blob_get(blob);
> +	else
> +		state->solid_fill_blob = NULL;
> +
> +	return 0;
> +}
> +
>   static void set_out_fence_for_crtc(struct drm_atomic_state *state,
>   				   struct drm_crtc *crtc, s32 __user *fence_ptr)
>   {
> @@ -546,6 +591,13 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>   		state->src_h = val;
>   	} else if (property == plane->pixel_source_property) {
>   		state->pixel_source = val;
> +	} else if (property == plane->solid_fill_property) {
> +		struct drm_property_blob *solid_fill = drm_property_lookup_blob(dev, val);
> +
> +		ret = drm_atomic_set_solid_fill_prop(state, solid_fill);
> +		drm_property_blob_put(solid_fill);
> +
> +		return ret;

Bonus point: dropping version from SOLID_FILL would allow us to use 
drm_atomic_replace_property_blob_from_id() here.

>   	} else if (property == plane->alpha_property) {
>   		state->alpha = val;
>   	} else if (property == plane->blend_mode_property) {
> @@ -620,6 +672,9 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>   		*val = state->src_h;
>   	} else if (property == plane->pixel_source_property) {
>   		*val = state->pixel_source;
> +	} else if (property == plane->solid_fill_property) {
> +		*val = state->solid_fill_blob ?
> +			state->solid_fill_blob->base.id : 0;
>   	} else if (property == plane->alpha_property) {
>   		*val = state->alpha;
>   	} else if (property == plane->blend_mode_property) {
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index c500310a3d09..c632dfcd8a9b 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -200,6 +200,10 @@
>    *	"FB":
>    *		Framebuffer source set by the "FB_ID" property.
>    *
> + * solid_fill:
> + *	solid_fill is set up with drm_plane_create_solid_fill_property(). It
> + *	contains pixel data that drivers can use to fill a plane.
> + *
>    * Note that all the property extensions described here apply either to the
>    * plane or the CRTC (e.g. for the background color, which currently is not
>    * exposed and assumed to be black).
> @@ -700,3 +704,29 @@ int drm_plane_create_pixel_source_property(struct drm_plane *plane,
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_plane_create_pixel_source_property);
> +
> +/**
> + * drm_plane_create_solid_fill_property - create a new solid_fill property
> + * @plane: drm plane
> + *
> + * This creates a new property blob that holds pixel data for solid fill planes.
> + * The property is exposed to userspace as a property blob called "solid_fill".
> + *
> + * For information on what the blob contains, see `drm_mode_solid_fill`.
> + */
> +int drm_plane_create_solid_fill_property(struct drm_plane *plane)
> +{
> +	struct drm_property *prop;
> +
> +	prop = drm_property_create(plane->dev,
> +			DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_BLOB,
> +			"solid_fill", 0);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	drm_object_attach_property(&plane->base, prop, 0);
> +	plane->solid_fill_property = prop;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_plane_create_solid_fill_property);
> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> index 122bbfbaae33..e7158fbee389 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
> @@ -60,4 +60,5 @@ int drm_plane_create_blend_mode_property(struct drm_plane *plane,
>   					 unsigned int supported_modes);
>   int drm_plane_create_pixel_source_property(struct drm_plane *plane,
>   					   unsigned long extra_sources);
> +int drm_plane_create_solid_fill_property(struct drm_plane *plane);
>   #endif
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 89508b4dea4a..abf1458fa099 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -46,6 +46,17 @@ enum drm_plane_pixel_source {
>   	DRM_PLANE_PIXEL_SOURCE_MAX
>   };
>   
> +/**
> + * struct solid_fill_property - RGB values for solid fill plane
> + *
> + * Note: This is the V1 for this feature
> + */
> +struct drm_solid_fill {
> +	uint32_t r;
> +	uint32_t g;
> +	uint32_t b;
> +};
> +
>   /**
>    * struct drm_plane_state - mutable plane state
>    *
> @@ -130,6 +141,23 @@ struct drm_plane_state {
>   	 */
>   	enum drm_plane_pixel_source pixel_source;
>   
> +	/**
> +	 * @solid_fill_blob:
> +	 *
> +	 * Blob containing relevant information for a solid fill plane
> +	 * including pixel format and data. See
> +	 * drm_plane_create_solid_fill_property() for more details.
> +	 */
> +	struct drm_property_blob *solid_fill_blob;
> +
> +	/**
> +	 * @solid_fill:
> +	 *
> +	 * Pixel data for solid fill planes. See
> +	 * drm_plane_create_solid_fill_property() for more details.
> +	 */
> +	struct drm_solid_fill solid_fill;
> +
>   	/**
>   	 * @alpha:
>   	 * Opacity of the plane with 0 as completely transparent and 0xffff as
> @@ -720,6 +748,13 @@ struct drm_plane {
>   	 */
>   	struct drm_property *pixel_source_property;
>   
> +	/**
> +	 * @solid_fill_property:
> +	 * Optional solid_fill property for this plane. See
> +	 * drm_plane_create_solid_fill_property().
> +	 */
> +	struct drm_property *solid_fill_property;
> +
>   	/**
>   	 * @alpha_property:
>   	 * Optional alpha property for this plane. See
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 43691058d28f..53c8efa5ad7f 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -259,6 +259,30 @@ struct drm_mode_modeinfo {
>   	char name[DRM_DISPLAY_MODE_LEN];
>   };
>   
> +/**
> + * struct drm_mode_solid_fill - User info for solid fill planes
> + *
> + * This is the userspace API solid fill information structure.
> + *
> + * Userspace can enable solid fill planes by assigning the plane "solid_fill"
> + * property to a blob containing a single drm_mode_solid_fill struct populated with an RGB323232
> + * color and setting the pixel source to "SOLID_FILL".
> + *
> + * For information on the plane property, see drm_plane_create_solid_fill_property()
> + *
> + * @version: Version of the blob. Currently, there is only support for version == 1
> + * @r: Red color value of single pixel
> + * @g: Green color value of single pixel
> + * @b: Blue color value of single pixel
> + */
> +struct drm_mode_solid_fill {
> +	__u32 version;
> +	__u32 r;
> +	__u32 g;
> +	__u32 b;
> +};
> +
> +
>   struct drm_mode_card_res {
>   	__u64 fb_id_ptr;
>   	__u64 crtc_id_ptr;
> 

-- 
With best wishes
Dmitry

