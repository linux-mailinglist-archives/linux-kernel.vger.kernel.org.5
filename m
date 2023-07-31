Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C88768ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 06:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGaEPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 00:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGaEPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 00:15:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D788E10D
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 21:15:44 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe383c1a26so529399e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 21:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690776943; x=1691381743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMYX8jg3dCCRuMtGRbFlfbd9q+spdF7dLaJz3ilyQ9s=;
        b=bYvAXKJfEpm7ZHm7V6ZQYvQ/r3zEqbZqR2jUyTa2M3ANHwwnSUYCuFQWHiMJJLxbxh
         /nhxgAJN7Dn8TffN0Tu6uDmG/R6vsB3vntrYTxd7r/QEkucacPez16QZyNN21IgZdmcn
         572UoyXFdxJrAvUt1DtZw4KiX82M7w24ajn6WrlG/mIHMHF81d/SDWtbGnupwj+VELyE
         yVwfCecGWLWoABPkzqRt79FUCBfLBoM6DXeenhtuI03gSPaW0N1ZdefdHnmqXr7dIK/i
         zV16CNJk6iOaCEOKV5f/lYQp2WdNP38Hbk/X5WHbdshk7LchrIng+WS6yNDSOWpfskSv
         nnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690776943; x=1691381743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMYX8jg3dCCRuMtGRbFlfbd9q+spdF7dLaJz3ilyQ9s=;
        b=PcBrCLnDKgQqk/uZaHbqAjqdvbw50O9aT4XiLw/7OjxKzvLbcR3CAKsD4UEtQ/f1Mh
         9dIh1cpyt+5mS6mVi2QHuKBZ7pP9yj5kwQj/G3GeE2lrawcgZwBWqqBMioIrvwVaMIi6
         GU4URShg8Cuy8+SuqbP/7sX40QY4VISgmObD7Y/mQLu2FnwalMU2QAv54B1PTr6uzego
         SD6j5WjowH6pkw24Jwmy4JUkTNy65qxzxRh4/m0MkiAIlfvT6urYXZ7zofAEseR/x/t3
         rr33cC0bF7mRNzXzToLLFNpZt2EuCxFtsqB46ZnZo4LHBgVss96msSkw+ga8dB6r5pa9
         iMfw==
X-Gm-Message-State: ABy/qLYpays5YjUKA7s43hcSmz461w74wjeakcLLJ50OBXKVjauWad8B
        WXvdb9EXHuEXdAIwBEMYAJ3ttg==
X-Google-Smtp-Source: APBJJlGonw/NVp753YF2Y9RKp+a5ekUpZME5M2yzcts8myZGrL29w0aXo/ctx0eEWpMecqVnI/Jw1Q==
X-Received: by 2002:a19:6501:0:b0:4f8:71cc:2b6e with SMTP id z1-20020a196501000000b004f871cc2b6emr5022274lfb.33.1690776943055;
        Sun, 30 Jul 2023 21:15:43 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h11-20020ac25d6b000000b004fa4323ec97sm1899712lft.301.2023.07.30.21.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 21:15:42 -0700 (PDT)
Message-ID: <de406c53-023d-f477-17f2-7d6dabf838bd@linaro.org>
Date:   Mon, 31 Jul 2023 07:15:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC v5 09/10] drm/msm/dpu: Use DRM solid_fill property
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
 <20230728-solid-fill-v5-9-053dbefa909c@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230728-solid-fill-v5-9-053dbefa909c@quicinc.com>
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
> Drop DPU_PLANE_COLOR_FILL_FLAG and check the DRM solid_fill property to
> determine if the plane is solid fill. In addition drop the DPU plane
> color_fill field as we can now use drm_plane_state.solid_fill instead,
> and pass in drm_plane_state.alpha to _dpu_plane_color_fill_pipe() to
> allow userspace to configure the alpha value for the solid fill color.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 114c803ff99b..95fc0394d13e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -42,7 +42,6 @@
>   #define SHARP_SMOOTH_THR_DEFAULT	8
>   #define SHARP_NOISE_THR_DEFAULT	2
>   
> -#define DPU_PLANE_COLOR_FILL_FLAG	BIT(31)
>   #define DPU_ZPOS_MAX 255
>   
>   /*
> @@ -82,7 +81,6 @@ struct dpu_plane {
>   
>   	enum dpu_sspp pipe;
>   
> -	uint32_t color_fill;
>   	bool is_error;
>   	bool is_rt_pipe;
>   	const struct dpu_mdss_cfg *catalog;
> @@ -606,6 +604,20 @@ static void _dpu_plane_color_fill_pipe(struct dpu_plane_state *pstate,
>   	_dpu_plane_setup_scaler(pipe, fmt, true, &pipe_cfg, pstate->rotation);
>   }
>   
> +static uint32_t _dpu_plane_get_bgr_fill_color(struct drm_solid_fill solid_fill)

As I commented for v4 (please excuse me for not responding to your email 
at thattime), we can return abgr here, taking plane->state->alpha into 
account.

> +{
> +	uint32_t ret = 0;
> +	uint8_t b = solid_fill.b >> 24;
> +	uint8_t g = solid_fill.g >> 24;
> +	uint8_t r = solid_fill.r >> 24;
> +
> +	ret |= b << 16;
> +	ret |= g << 8;
> +	ret |= r;
> +
> +	return ret;
> +}
> +
>   /**
>    * _dpu_plane_color_fill - enables color fill on plane
>    * @pdpu:   Pointer to DPU plane object
> @@ -977,9 +989,9 @@ void dpu_plane_flush(struct drm_plane *plane)
>   	if (pdpu->is_error)
>   		/* force white frame with 100% alpha pipe output on error */
>   		_dpu_plane_color_fill(pdpu, 0xFFFFFF, 0xFF);
> -	else if (pdpu->color_fill & DPU_PLANE_COLOR_FILL_FLAG)
> -		/* force 100% alpha */
> -		_dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
> +	else if (drm_plane_solid_fill_enabled(plane->state))
> +		_dpu_plane_color_fill(pdpu, _dpu_plane_get_bgr_fill_color(plane->state->solid_fill),
> +				plane->state->alpha);
>   	else {
>   		dpu_plane_flush_csc(pdpu, &pstate->pipe);
>   		dpu_plane_flush_csc(pdpu, &pstate->r_pipe);
> @@ -1024,7 +1036,7 @@ static void dpu_plane_sspp_update_pipe(struct drm_plane *plane,
>   	}
>   
>   	/* override for color fill */
> -	if (pdpu->color_fill & DPU_PLANE_COLOR_FILL_FLAG) {
> +	if (drm_plane_solid_fill_enabled(plane->state)) {
>   		_dpu_plane_set_qos_ctrl(plane, pipe, false);
>   
>   		/* skip remaining processing on color fill */
> 

-- 
With best wishes
Dmitry

