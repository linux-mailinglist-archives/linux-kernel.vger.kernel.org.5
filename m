Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C97BE759
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377349AbjJIRHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344542AbjJIRHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:07:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C305B9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:07:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bfed7c4e6dso53393291fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696871223; x=1697476023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tW+ewvN6hJ7uOk+NGT2wDDdLEYtVkyOMF8rZuJ8lphE=;
        b=sDUSVkEZnydCG2/RuAydlLniFHmdcoqwIJYEAZdaikkft1W3HH/nQDqEi7LCDEVorY
         iwqcLIlKj+urGgujWgqkdjPI9+FwvcNGbnxseqKioFw6Q6J9mD3gb6AtFuNxvuJaEPcP
         6xNoghm/ousKyKW7C7NBdWP28CU9/bul8k6Q+NivT2s2KTambKQSAurLFfXW/CTI5KFw
         ZcxTiexEWGXAIjU3qqPbo/WsuFQDXgByGXbpt5jfK3U6gT36/kDt61W8Q2mhTSjUZ2PO
         T5QqkBr8/2qq8+v13aye6woOyWPjfMCubOV2x3mbGA6eVG7NV85X8e8YXBFFE6BqTPGX
         5WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696871223; x=1697476023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tW+ewvN6hJ7uOk+NGT2wDDdLEYtVkyOMF8rZuJ8lphE=;
        b=e+U1yXOeHLvPytZDF/lrf7QEb7y9lG50DL7cOUenPN/kkXi97uiKY6V1LuDJl7nX2x
         gCiiBcw8vEzbZLth9yxz1Blte3D0HiiF1LWSDODpNoEQNx88yonb6qErH0ZkBy7L7y51
         PJhWbMRQ2LIEgns+LTVEu/VKArZOTIDY2fpJbiqRtF1iHz5E21Z58aiQaTWgMWIVwehW
         usr/n2uKHAPGjYWKdPiD4nv5ptJj8ZmW0SqWPg7fFJYAfKCwvpg0QqdW6AWRfZJ4zmV1
         u3UMfZkZ+BdeCEdw2sdleMUJUALtrF4e2eyWdlpvlx+cE9MPunKdOT+YG1197kLKQHql
         Tc0A==
X-Gm-Message-State: AOJu0Yx/jMAQ6fH38roBV5UlrpSh0y+JoiOcbInwPxEU+HWGHaSbhI5I
        8a0SFuj0z/dVnHYjaZ3R40NeKw==
X-Google-Smtp-Source: AGHT+IFrkUoKkOkj2tFzwpCXVCFkSZlmd2GFj41AeaJ4RiJrQ2T+t2wTeaS0ESuErkGBQ0CSn6HSrw==
X-Received: by 2002:a2e:7310:0:b0:2bc:fd50:573a with SMTP id o16-20020a2e7310000000b002bcfd50573amr13968869ljc.6.1696871222765;
        Mon, 09 Oct 2023 10:07:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id t16-20020a2e9c50000000b002c123b976a5sm2095411ljj.123.2023.10.09.10.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 10:07:02 -0700 (PDT)
Message-ID: <e1f70025-f93d-4d1f-bafa-1e834324ce62@linaro.org>
Date:   Mon, 9 Oct 2023 20:07:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/5] drm/msm: dpu1: call wb & sspp clk_force_ctrl op
 if split clock control
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-0-806c0dee4e43@linaro.org>
 <20231009-topic-sm8550-graphics-sspp-split-clk-v1-4-806c0dee4e43@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-4-806c0dee4e43@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 19:36, Neil Armstrong wrote:
> Now clk_ctrl IDs can be optional and the clk_ctrl_reg can be specified
> on the SSPP & WB caps directly, pass the SSPP & WB hw struct to the
> qos & limit params then call the clk_force_ctrl() op accordingly.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  4 +--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  9 +++---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           | 37 +++++++++++++++-------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h           | 12 ++++---
>   4 files changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index 78037a697633..e4dfe0be7207 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -45,6 +45,7 @@ static void dpu_encoder_phys_wb_set_ot_limit(
>   	struct dpu_vbif_set_ot_params ot_params;
>   
>   	memset(&ot_params, 0, sizeof(ot_params));
> +	ot_params.wb = hw_wb;
>   	ot_params.xin_id = hw_wb->caps->xin_id;
>   	ot_params.num = hw_wb->idx - WB_0;
>   	ot_params.width = phys_enc->cached_mode.hdisplay;
> @@ -52,7 +53,6 @@ static void dpu_encoder_phys_wb_set_ot_limit(
>   	ot_params.is_wfd = true;
>   	ot_params.frame_rate = drm_mode_vrefresh(&phys_enc->cached_mode);
>   	ot_params.vbif_idx = hw_wb->caps->vbif_idx;
> -	ot_params.clk_ctrl = hw_wb->caps->clk_ctrl;
>   	ot_params.rd = false;
>   
>   	dpu_vbif_set_ot_limit(phys_enc->dpu_kms, &ot_params);
> @@ -81,9 +81,9 @@ static void dpu_encoder_phys_wb_set_qos_remap(
>   	hw_wb = phys_enc->hw_wb;
>   
>   	memset(&qos_params, 0, sizeof(qos_params));
> +	qos_params.wb = hw_wb;
>   	qos_params.vbif_idx = hw_wb->caps->vbif_idx;
>   	qos_params.xin_id = hw_wb->caps->xin_id;
> -	qos_params.clk_ctrl = hw_wb->caps->clk_ctrl;
>   	qos_params.num = hw_wb->idx - WB_0;
>   	qos_params.is_rt = false;
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index c2aaaded07ed..b0b662068377 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -350,6 +350,7 @@ static void _dpu_plane_set_ot_limit(struct drm_plane *plane,
>   	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
>   
>   	memset(&ot_params, 0, sizeof(ot_params));
> +	ot_params.sspp = pipe->sspp;
>   	ot_params.xin_id = pipe->sspp->cap->xin_id;
>   	ot_params.num = pipe->sspp->idx - SSPP_NONE;
>   	ot_params.width = drm_rect_width(&pipe_cfg->src_rect);
> @@ -357,7 +358,6 @@ static void _dpu_plane_set_ot_limit(struct drm_plane *plane,
>   	ot_params.is_wfd = !pdpu->is_rt_pipe;
>   	ot_params.frame_rate = frame_rate;
>   	ot_params.vbif_idx = VBIF_RT;
> -	ot_params.clk_ctrl = pipe->sspp->cap->clk_ctrl;
>   	ot_params.rd = true;
>   
>   	dpu_vbif_set_ot_limit(dpu_kms, &ot_params);
> @@ -377,16 +377,15 @@ static void _dpu_plane_set_qos_remap(struct drm_plane *plane,
>   
>   	memset(&qos_params, 0, sizeof(qos_params));
>   	qos_params.vbif_idx = VBIF_RT;
> -	qos_params.clk_ctrl = pipe->sspp->cap->clk_ctrl;
> +	qos_params.sspp = pipe->sspp;
>   	qos_params.xin_id = pipe->sspp->cap->xin_id;
>   	qos_params.num = pipe->sspp->idx - SSPP_VIG0;
>   	qos_params.is_rt = pdpu->is_rt_pipe;
>   
> -	DPU_DEBUG_PLANE(pdpu, "pipe:%d vbif:%d xin:%d rt:%d, clk_ctrl:%d\n",
> +	DPU_DEBUG_PLANE(pdpu, "pipe:%d vbif:%d xin:%d rt:%d\n",
>   			qos_params.num,
>   			qos_params.vbif_idx,
> -			qos_params.xin_id, qos_params.is_rt,
> -			qos_params.clk_ctrl);
> +			qos_params.xin_id, qos_params.is_rt);
>   
>   	dpu_vbif_set_qos_remap(dpu_kms, &qos_params);
>   }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
> index 2ae5cba1848b..a79559084a91 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
> @@ -158,11 +158,19 @@ static u32 _dpu_vbif_get_ot_limit(struct dpu_hw_vbif *vbif,
>   	return ot_lim;
>   }
>   
> -static bool dpu_vbif_setup_clk_force_ctrl(struct dpu_hw_mdp *mdp,
> -					  unsigned int clk_ctrl,
> +static bool dpu_vbif_setup_clk_force_ctrl(struct dpu_hw_sspp *sspp,
> +					  struct dpu_hw_wb *wb,
> +					  struct dpu_hw_mdp *mdp,
>   					  bool enable)
>   {
> -	return mdp->ops.setup_clk_force_ctrl(mdp, clk_ctrl, enable);
> +	if (sspp && sspp->cap->clk_ctrl_reg)
> +		return sspp->ops.setup_clk_force_ctrl(sspp, enable);
> +	else if (wb && wb->caps->clk_ctrl_reg)
> +		return wb->ops.setup_clk_force_ctrl(wb, enable);
> +	else

This is what I wanted to avoid.

If we move the caller function to the sspp / WB, we will not need this 
kind of wrapper.

> +		return mdp->ops.setup_clk_force_ctrl(mdp,
> +				sspp ? sspp->cap->clk_ctrl : wb->caps->clk_ctrl,
> +				enable);
>   }
>   
>   /**
> @@ -190,9 +198,13 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
>   		return;
>   	}
>   
> -	if (!mdp->ops.setup_clk_force_ctrl ||
> -			!vbif->ops.set_limit_conf ||
> -			!vbif->ops.set_halt_ctrl)
> +	if ((!params->sspp && !params->wb) ||
> +	    (params->sspp && !params->sspp->ops.setup_clk_force_ctrl) ||
> +	    (params->wb && !params->wb->ops.setup_clk_force_ctrl) ||
> +	    !mdp->ops.setup_clk_force_ctrl)
> +		return;
> +
> +	if (!vbif->ops.set_limit_conf || !vbif->ops.set_halt_ctrl)
>   		return;
>   
>   	/* set write_gather_en for all write clients */
> @@ -207,7 +219,7 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
>   	trace_dpu_perf_set_ot(params->num, params->xin_id, ot_lim,
>   		params->vbif_idx);
>   
> -	forced_on = dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
> +	forced_on = dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, true);

I'd suggest removing the setup_clk_force_ctrl from 
dpu_vbif_set_ot_limit() and dpu_vbif_set_qos_remap(). Instead make 
dpu_plane / dpu_encoder_phys_wb call into dpu_hw_sspp / dpu_hw_wb, which 
will enable the clock, call dpu_vbif then disable the clock.

In my opinion this is simpler than the condition in the previous chunk.

>   
>   	vbif->ops.set_limit_conf(vbif, params->xin_id, params->rd, ot_lim);
>   
> @@ -220,7 +232,7 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
>   	vbif->ops.set_halt_ctrl(vbif, params->xin_id, false);
>   
>   	if (forced_on)
> -		dpu_vbif_setup_clk_force_ctrl(mdp,  params->clk_ctrl, false);
> +		dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, false);
>   }
>   
>   void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
> @@ -245,7 +257,10 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
>   		return;
>   	}
>   
> -	if (!vbif->ops.set_qos_remap || !mdp->ops.setup_clk_force_ctrl) {
> +	if ((!params->sspp && !params->wb) ||
> +	    (params->sspp && !params->sspp->ops.setup_clk_force_ctrl) ||
> +	    (params->wb && !params->wb->ops.setup_clk_force_ctrl) ||
> +	    !mdp->ops.setup_clk_force_ctrl || !vbif->ops.set_qos_remap) {
>   		DRM_DEBUG_ATOMIC("qos remap not supported\n");
>   		return;
>   	}
> @@ -258,7 +273,7 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
>   		return;
>   	}
>   
> -	forced_on = dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
> +	forced_on = dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, true);
>   
>   	for (i = 0; i < qos_tbl->npriority_lvl; i++) {
>   		DRM_DEBUG_ATOMIC("%s xin:%d lvl:%d/%d\n",
> @@ -269,7 +284,7 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
>   	}
>   
>   	if (forced_on)
> -		dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, false);
> +		dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, false);
>   }
>   
>   void dpu_vbif_clear_errors(struct dpu_kms *dpu_kms)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
> index ab490177d886..a4fe76e390d9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
> @@ -7,7 +7,12 @@
>   
>   #include "dpu_kms.h"
>   
> +struct dpu_hw_sspp;
> +struct dpu_hw_wb;
> +
>   struct dpu_vbif_set_ot_params {
> +	struct dpu_hw_sspp *sspp;
> +	struct dpu_hw_wb *wb;
>   	u32 xin_id;
>   	u32 num;
>   	u32 width;
> @@ -16,28 +21,27 @@ struct dpu_vbif_set_ot_params {
>   	bool rd;
>   	bool is_wfd;
>   	u32 vbif_idx;
> -	u32 clk_ctrl;
>   };
>   
>   struct dpu_vbif_set_memtype_params {
>   	u32 xin_id;
>   	u32 vbif_idx;
> -	u32 clk_ctrl;
>   	bool is_cacheable;
>   };
>   
>   /**
>    * struct dpu_vbif_set_qos_params - QoS remapper parameter
> + * @sspp: backing SSPP
>    * @vbif_idx: vbif identifier
>    * @xin_id: client interface identifier
> - * @clk_ctrl: clock control identifier of the xin
>    * @num: pipe identifier (debug only)
>    * @is_rt: true if pipe is used in real-time use case
>    */
>   struct dpu_vbif_set_qos_params {
> +	struct dpu_hw_sspp *sspp;
> +	struct dpu_hw_wb *wb;
>   	u32 vbif_idx;
>   	u32 xin_id;
> -	u32 clk_ctrl;
>   	u32 num;
>   	bool is_rt;
>   };
> 

-- 
With best wishes
Dmitry

