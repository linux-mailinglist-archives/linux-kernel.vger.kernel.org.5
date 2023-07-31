Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA61768AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjGaEOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGaEOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:14:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9FA1B3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 21:14:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo3222073e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 21:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690776856; x=1691381656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W80uXg1yjvGP96y2coKCqJ7TWhhPhvEmmxE7a2my1ZU=;
        b=kAMal7ZFeAhoShhCoxaGSBKr6BkNISHGSVcFfUY6mRjn7CEuvu8wq1O4W7H+oxr5iF
         MP8yezhgo8B6VwOTSGEVxFSi2B0Oz+kQDN+zXWDYj5sdCM4iHe0BFlAqi9/459vhgvJy
         zEHvY127uQeZ3tP2lVj6NgNEtij3EO5E8scxt9ho9TBKVv2PNSJZXCrK5o3SosJ56tbV
         e0923HPsRpsDYxU98ps7SJOAaOGaE6L2ehH6oq63PU6WySJBHQpzmyepBVX1p55e+Vr1
         IJFSgAaCt3rgKbCIlZ9Qqbn8gKx6pka+CcCXIhB2M48wyu6M91W5Cw90EI87Y0CSdbKT
         XN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690776856; x=1691381656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W80uXg1yjvGP96y2coKCqJ7TWhhPhvEmmxE7a2my1ZU=;
        b=d0J8/u97W+WlQFL78rmjjv9siczc3h9oyZaYvxjd4LPVMLHHwUtDMpPS5ic3+91vHI
         W//6OsfPePf6ZXgyZtijtbmu+sHdcB95+hniBw8y0dq2kmc+jWmjvGNELCQ/Wn5B1cp2
         1yMdO6Tv3cSJqTBt8dZZJ4biw+mvF0Dai9HvY2xZf3ueBTwd+g5YldfcGk3THZzW6Wb6
         yhbch/qC4zgxcMa6M+TFxJd6Nw5jDoP+gTphciqs3xKA47STwrq7UZQRGB69o782IZI1
         lkarDgCcMeL3P9+bgwHzmMzj8TcSbDnftMz4WOriQ9Qn1kxkSIa+siPGnRuWQWLOdAhe
         4Q7A==
X-Gm-Message-State: ABy/qLab/HqbVR1Mq9EkCFOtUqnz0gpw5fvqZT/k6A9N2ajQvTgCmAxB
        JElaciylxkhJRGE/eUm6VAPG/w==
X-Google-Smtp-Source: APBJJlE+m1mVaNUXwjSzxdXR8xvZ5IsgiT7B4y33KivgEWSlBJrTYednuJ4gPivfEpLvO0B+Vvr1lQ==
X-Received: by 2002:a05:6512:1105:b0:4f9:570c:7b28 with SMTP id l5-20020a056512110500b004f9570c7b28mr5729592lfg.32.1690776856601;
        Sun, 30 Jul 2023 21:14:16 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q19-20020ac25293000000b004fe0ab60530sm1924432lfm.49.2023.07.30.21.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 21:14:15 -0700 (PDT)
Message-ID: <16bf0d7d-e549-d297-4fc8-f694eab3fd2e@linaro.org>
Date:   Mon, 31 Jul 2023 07:14:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v5 08/10] drm/msm/dpu: Allow NULL FBs in atomic commit
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
 <20230728-solid-fill-v5-8-053dbefa909c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230728-solid-fill-v5-8-053dbefa909c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 20:02, Jessica Zhang wrote:
> Since solid fill planes allow for a NULL framebuffer in a valid commit,
> add NULL framebuffer checks to atomic commit calls within DPU.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  9 ++++++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 41 ++++++++++++++++++++-----------
>   2 files changed, 34 insertions(+), 16 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 1edf2b6b0a26..cff0f0d26b22 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -451,6 +451,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>   	struct drm_plane_state *state;
>   	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
>   	struct dpu_plane_state *pstate = NULL;
> +	const struct msm_format *fmt;
>   	struct dpu_format *format;
>   	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
>   
> @@ -470,7 +471,13 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>   		pstate = to_dpu_plane_state(state);
>   		fb = state->fb;
>   
> -		format = to_dpu_format(msm_framebuffer_format(pstate->base.fb));
> +		if (drm_plane_solid_fill_enabled(state))
> +			fmt = dpu_get_msm_format(&_dpu_crtc_get_kms(crtc)->base,
> +					DRM_FORMAT_ABGR8888, 0);
> +		else
> +			fmt = msm_framebuffer_format(pstate->base.fb);
> +
> +		format = to_dpu_format(fmt);
>   
>   		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
>   			bg_alpha_enable = true;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index c2aaaded07ed..114c803ff99b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -837,8 +837,13 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
>   
>   	pipe_cfg->dst_rect = new_plane_state->dst;
>   
> -	fb_rect.x2 = new_plane_state->fb->width;
> -	fb_rect.y2 = new_plane_state->fb->height;
> +	if (drm_plane_solid_fill_enabled(new_plane_state))
> +		return 0;
> +
> +	if (new_plane_state->pixel_source == DRM_PLANE_PIXEL_SOURCE_FB && new_plane_state->fb) {
> +		fb_rect.x2 = new_plane_state->fb->width;
> +		fb_rect.y2 = new_plane_state->fb->height;
> +	}
>   
>   	/* Ensure fb size is supported */
>   	if (drm_rect_width(&fb_rect) > MAX_IMG_WIDTH ||
> @@ -1082,21 +1087,32 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane)
>   	struct drm_crtc *crtc = state->crtc;
>   	struct drm_framebuffer *fb = state->fb;
>   	bool is_rt_pipe;
> -	const struct dpu_format *fmt =
> -		to_dpu_format(msm_framebuffer_format(fb));
> +	const struct dpu_format *fmt;
>   	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
>   	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
>   	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
>   	struct msm_gem_address_space *aspace = kms->base.aspace;
>   	struct dpu_hw_fmt_layout layout;
>   	bool layout_valid = false;
> -	int ret;
>   
> -	ret = dpu_format_populate_layout(aspace, fb, &layout);
> -	if (ret)
> -		DPU_ERROR_PLANE(pdpu, "failed to get format layout, %d\n", ret);
> -	else
> -		layout_valid = true;
> +	if (state->pixel_source == DRM_PLANE_PIXEL_SOURCE_FB && fb) {
> +		int ret;
> +
> +		fmt = to_dpu_format(msm_framebuffer_format(fb));
> +
> +		ret = dpu_format_populate_layout(aspace, fb, &layout);
> +		if (ret)
> +			DPU_ERROR_PLANE(pdpu, "failed to get format layout, %d\n", ret);
> +		else
> +			layout_valid = true;
> +
> +		DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FP_FMT "->crtc%u " DRM_RECT_FMT
> +				", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_FP_ARG(&state->src),
> +				crtc->base.id, DRM_RECT_ARG(&state->dst),
> +				(char *)&fmt->base.pixel_format, DPU_FORMAT_IS_UBWC(fmt));
> +	} else {
> +		fmt = dpu_get_dpu_format(DRM_FORMAT_ABGR8888);
> +	}
>   
>   	pstate->pending = true;
>   
> @@ -1104,11 +1120,6 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane)
>   	pstate->needs_qos_remap |= (is_rt_pipe != pdpu->is_rt_pipe);
>   	pdpu->is_rt_pipe = is_rt_pipe;
>   
> -	DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FP_FMT "->crtc%u " DRM_RECT_FMT
> -			", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_FP_ARG(&state->src),
> -			crtc->base.id, DRM_RECT_ARG(&state->dst),
> -			(char *)&fmt->base.pixel_format, DPU_FORMAT_IS_UBWC(fmt));
> -
>   	dpu_plane_sspp_update_pipe(plane, pipe, pipe_cfg, fmt,
>   				   drm_mode_vrefresh(&crtc->mode),
>   				   layout_valid ? &layout : NULL);
> 

-- 
With best wishes
Dmitry

