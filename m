Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977F076794D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjG2AER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjG2AEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:04:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ABC4231
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:04:11 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52227142a27so3308326a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690589050; x=1691193850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfRG5rD0scPqsV1FykBsfcvR1VHSdVrA0sLu02AnWOM=;
        b=eUzCyV0J1fb+2uOtbl0SEoizsUk8+EHyYPjj46asco+D7r6nKAR5UdkQWLdBTxiBNR
         /kMUlDjX2Nx8COxm2TubVPSp8PwBvk74b0z67yuIFPL/D/Jl7Krlyzkw392cWq6g/5uX
         +k+lFYjONRxxC52gDChAF1VqCdQmWluIid4PmDezq2IuUUfHSlM1wsb3tMBGgRRTI5PR
         k3Fl5NkS71cYjavLyMhl5K65uVMyG/cIc1n03mDNl3KLZfYVSrgglB/AH6BW9XBHubIy
         YuqFnwAAvYtBvBKvofZ3GF5BvXTtr+OfKs0nxO39FO5OsaqA96RQ1YvjWwTmrSwxRswK
         RZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690589050; x=1691193850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfRG5rD0scPqsV1FykBsfcvR1VHSdVrA0sLu02AnWOM=;
        b=QzzdBwv+vbg4I2vTznsebvV51JRoU+aa1nEY97TCtExekSVFY7bS4UFrFAFnawUwdf
         FD9RCXUVa6uW3Vvx9GNzNzrnJ68uZiR+cgfINHfzzRXrC6NxleWCbKtUwk3q8lBPGggY
         AFaJVQYtZxaadSVswEMdqCIAmhORh4qmMLOdAugIGBJ09zAgo6WK644urSDRyA6tNzNj
         ZUgSBcfFkkUwg6+mDkK5W7Cr7DEgGOMeGe/N7rAz4gdtcEdg65OCUn+5ZreFuzS+vsin
         SN6h0O0VSYfEniAo502euk0bKd0APe8aeuqwCHhFy2OiqDuCLmPIDYsmw/mioi0HwaFw
         PEQg==
X-Gm-Message-State: ABy/qLa0tifwvwNMuqRzWT7TvDICVXG1GthySCv5FA7D6XD+ax0pnOi/
        4YmVBVFkoIePU6i6ifExPQUyhg==
X-Google-Smtp-Source: APBJJlGMAZ6zWddJfPSlsMqE6/T2h9lEEfiEuE7orHv0MziUXyZjseGTaz1a/33UmEYRkyhFTyDMzg==
X-Received: by 2002:a17:907:7850:b0:99b:44aa:fae0 with SMTP id lb16-20020a170907785000b0099b44aafae0mr610136ejc.21.1690589050045;
        Fri, 28 Jul 2023 17:04:10 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906115200b00992665694f7sm2587634eja.107.2023.07.28.17.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 17:04:09 -0700 (PDT)
Message-ID: <de6abbcf-9c0d-f51e-b140-938f2c537f74@linaro.org>
Date:   Sat, 29 Jul 2023 03:04:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v5 04/10] drm/atomic: Add pixel source to plane state
 dump
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
 <20230728-solid-fill-v5-4-053dbefa909c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230728-solid-fill-v5-4-053dbefa909c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 20:02, Jessica Zhang wrote:
> Add pixel source to the atomic plane state dump
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/drm_atomic.c        |  1 +
>   drivers/gpu/drm/drm_crtc_internal.h |  2 ++
>   drivers/gpu/drm/drm_plane.c         | 12 ++++++++++++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index b4c6ffc438da..c38014abc590 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -713,6 +713,7 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
>   
>   	drm_printf(p, "plane[%u]: %s\n", plane->base.id, plane->name);
>   	drm_printf(p, "\tcrtc=%s\n", state->crtc ? state->crtc->name : "(null)");
> +	drm_printf(p, "\tpixel-source=%s\n", drm_plane_get_pixel_source_name(state->pixel_source));
>   	drm_printf(p, "\tfb=%u\n", state->fb ? state->fb->base.id : 0);
>   	if (state->fb)
>   		drm_framebuffer_print_info(p, 2, state->fb);
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
> index 501a10edd0e1..75b59ec9f1be 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -38,6 +38,7 @@ enum drm_color_encoding;
>   enum drm_color_range;
>   enum drm_connector_force;
>   enum drm_mode_status;
> +enum drm_plane_pixel_source;
>   
>   struct drm_atomic_state;
>   struct drm_bridge;
> @@ -267,6 +268,7 @@ int drm_plane_check_pixel_format(struct drm_plane *plane,
>   				 u32 format, u64 modifier);
>   struct drm_mode_rect *
>   __drm_plane_get_damage_clips(const struct drm_plane_state *state);
> +const char *drm_plane_get_pixel_source_name(enum drm_plane_pixel_source pixel_source);
>   
>   /* drm_bridge.c */
>   void drm_bridge_detach(struct drm_bridge *bridge);
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index f342cf15412b..4188b3491625 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -1487,6 +1487,18 @@ __drm_plane_get_damage_clips(const struct drm_plane_state *state)
>   					state->fb_damage_clips->data : NULL);
>   }
>   
> +const char *drm_plane_get_pixel_source_name(enum drm_plane_pixel_source pixel_source)
> +{
> +	switch(pixel_source) {
> +	case DRM_PLANE_PIXEL_SOURCE_NONE:
> +		return "NONE";
> +	case DRM_PLANE_PIXEL_SOURCE_FB:
> +		return "fb";
> +	default:
> +		return "";
> +	}
> +}

Please use DRM_ENUM_NAME_FN instead.

> +
>   /**
>    * drm_plane_get_damage_clips - Returns damage clips.
>    * @state: Plane state.
> 

-- 
With best wishes
Dmitry

