Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6DB7BF518
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442704AbjJJH6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442669AbjJJH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:58:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51521AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:58:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so5319663f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696924718; x=1697529518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DuF08tiAL2vBsnI7ItZlNLjLI9/OSkp0LDsu4D+EiFA=;
        b=wDJM63bu7VsqpvlbetGuKHpulU5fFyghCWJ9agOW9MQks2TsQLX09MdTgG2JnE+oxs
         3p1O+pUId14mpA1lbr6KXbuWaYpe/VPBFxjwzXsw92VKq8v9QvYbUp/CQofWbl8WVyRZ
         4hng8V+lsy66rRndSKzPk5bbEhuA96OXovS5YaJKWzpzApHc7P65CnJg7AeEwbolKmdQ
         Fsx5DkJ4S7Q6qyxf5mePzSkHQ+5in83queMuLQWZxnrMSvptRup+ZkIjTyT0inCBYto6
         cbVa/8ZkP08aPuYWBIIX02hmm/6hzONLUOZjolIfCbJsvj1ZqzsvDcraIGAe3Uw5NndB
         7Dmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696924718; x=1697529518;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DuF08tiAL2vBsnI7ItZlNLjLI9/OSkp0LDsu4D+EiFA=;
        b=AjpQohffejGHfSaKg6oc9z3zD23HIB5uRgl9q4GnWUCrovNcQRK4reYZcFWU1SzedL
         977/51Ls4szz4wLrTqQOSqcwdqekFXTGJqplntRXYF5YsBkjcOxgoV8ZyKCL+jVg1v7D
         7Y/1+XRGnECgtvcKldoJnzxKYis7urtgIeTj4oxtJwDLuuqoEIB8A3fXkbapu7vKz2Ho
         PssNUbrVX2SRUsSiT63lWXS+RCmTjLlC0U2vaaaGUAu+qXtMzxkF4BtY3ng+mYOGkTbq
         8AVcE9z0+xtI8/SbvVFtY3wsuxxnNcOc3w/8iPpustAYqk2HXmBWdfZ8k4kNhlia+hNJ
         iA2w==
X-Gm-Message-State: AOJu0YwVNYuklX0/qCHzyXvIUMO80aSjFpuX8iCM/xefweEDSbk945CD
        pZDwvlNXSSdvgBkU5X02rEV9Fg==
X-Google-Smtp-Source: AGHT+IHfVtV+fM/y8bb4Y20eH4zD+GGKjiUOYYRNx1gqzX/XHYwbaChonFJ07oxttNsmMG54NZcuEQ==
X-Received: by 2002:a05:6000:1f0a:b0:32c:a930:fe0d with SMTP id bv10-20020a0560001f0a00b0032ca930fe0dmr1261947wrb.4.1696924717664;
        Tue, 10 Oct 2023 00:58:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:2eac:5b51:e0a4:4807? ([2a01:e0a:982:cbb0:2eac:5b51:e0a4:4807])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d534b000000b003232380ffd5sm11816539wrv.106.2023.10.10.00.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 00:58:37 -0700 (PDT)
Message-ID: <6ba6331c-12c6-4cce-bbf9-0255d4f17118@linaro.org>
Date:   Tue, 10 Oct 2023 09:58:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC 4/5] drm/msm: dpu1: call wb & sspp clk_force_ctrl op
 if split clock control
Content-Language: en-US, fr
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <e1f70025-f93d-4d1f-bafa-1e834324ce62@linaro.org>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <e1f70025-f93d-4d1f-bafa-1e834324ce62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 19:07, Dmitry Baryshkov wrote:
> On 09/10/2023 19:36, Neil Armstrong wrote:
>> Now clk_ctrl IDs can be optional and the clk_ctrl_reg can be specified
>> on the SSPP & WB caps directly, pass the SSPP & WB hw struct to the
>> qos & limit params then call the clk_force_ctrl() op accordingly.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |  4 +--
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |  9 +++---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c           | 37 +++++++++++++++-------
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h           | 12 ++++---
>>   4 files changed, 40 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
>> index 78037a697633..e4dfe0be7207 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
>> @@ -45,6 +45,7 @@ static void dpu_encoder_phys_wb_set_ot_limit(
>>       struct dpu_vbif_set_ot_params ot_params;
>>       memset(&ot_params, 0, sizeof(ot_params));
>> +    ot_params.wb = hw_wb;
>>       ot_params.xin_id = hw_wb->caps->xin_id;
>>       ot_params.num = hw_wb->idx - WB_0;
>>       ot_params.width = phys_enc->cached_mode.hdisplay;
>> @@ -52,7 +53,6 @@ static void dpu_encoder_phys_wb_set_ot_limit(
>>       ot_params.is_wfd = true;
>>       ot_params.frame_rate = drm_mode_vrefresh(&phys_enc->cached_mode);
>>       ot_params.vbif_idx = hw_wb->caps->vbif_idx;
>> -    ot_params.clk_ctrl = hw_wb->caps->clk_ctrl;
>>       ot_params.rd = false;
>>       dpu_vbif_set_ot_limit(phys_enc->dpu_kms, &ot_params);
>> @@ -81,9 +81,9 @@ static void dpu_encoder_phys_wb_set_qos_remap(
>>       hw_wb = phys_enc->hw_wb;
>>       memset(&qos_params, 0, sizeof(qos_params));
>> +    qos_params.wb = hw_wb;
>>       qos_params.vbif_idx = hw_wb->caps->vbif_idx;
>>       qos_params.xin_id = hw_wb->caps->xin_id;
>> -    qos_params.clk_ctrl = hw_wb->caps->clk_ctrl;
>>       qos_params.num = hw_wb->idx - WB_0;
>>       qos_params.is_rt = false;
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> index c2aaaded07ed..b0b662068377 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
>> @@ -350,6 +350,7 @@ static void _dpu_plane_set_ot_limit(struct drm_plane *plane,
>>       struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
>>       memset(&ot_params, 0, sizeof(ot_params));
>> +    ot_params.sspp = pipe->sspp;
>>       ot_params.xin_id = pipe->sspp->cap->xin_id;
>>       ot_params.num = pipe->sspp->idx - SSPP_NONE;
>>       ot_params.width = drm_rect_width(&pipe_cfg->src_rect);
>> @@ -357,7 +358,6 @@ static void _dpu_plane_set_ot_limit(struct drm_plane *plane,
>>       ot_params.is_wfd = !pdpu->is_rt_pipe;
>>       ot_params.frame_rate = frame_rate;
>>       ot_params.vbif_idx = VBIF_RT;
>> -    ot_params.clk_ctrl = pipe->sspp->cap->clk_ctrl;
>>       ot_params.rd = true;
>>       dpu_vbif_set_ot_limit(dpu_kms, &ot_params);
>> @@ -377,16 +377,15 @@ static void _dpu_plane_set_qos_remap(struct drm_plane *plane,
>>       memset(&qos_params, 0, sizeof(qos_params));
>>       qos_params.vbif_idx = VBIF_RT;
>> -    qos_params.clk_ctrl = pipe->sspp->cap->clk_ctrl;
>> +    qos_params.sspp = pipe->sspp;
>>       qos_params.xin_id = pipe->sspp->cap->xin_id;
>>       qos_params.num = pipe->sspp->idx - SSPP_VIG0;
>>       qos_params.is_rt = pdpu->is_rt_pipe;
>> -    DPU_DEBUG_PLANE(pdpu, "pipe:%d vbif:%d xin:%d rt:%d, clk_ctrl:%d\n",
>> +    DPU_DEBUG_PLANE(pdpu, "pipe:%d vbif:%d xin:%d rt:%d\n",
>>               qos_params.num,
>>               qos_params.vbif_idx,
>> -            qos_params.xin_id, qos_params.is_rt,
>> -            qos_params.clk_ctrl);
>> +            qos_params.xin_id, qos_params.is_rt);
>>       dpu_vbif_set_qos_remap(dpu_kms, &qos_params);
>>   }
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
>> index 2ae5cba1848b..a79559084a91 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.c
>> @@ -158,11 +158,19 @@ static u32 _dpu_vbif_get_ot_limit(struct dpu_hw_vbif *vbif,
>>       return ot_lim;
>>   }
>> -static bool dpu_vbif_setup_clk_force_ctrl(struct dpu_hw_mdp *mdp,
>> -                      unsigned int clk_ctrl,
>> +static bool dpu_vbif_setup_clk_force_ctrl(struct dpu_hw_sspp *sspp,
>> +                      struct dpu_hw_wb *wb,
>> +                      struct dpu_hw_mdp *mdp,
>>                         bool enable)
>>   {
>> -    return mdp->ops.setup_clk_force_ctrl(mdp, clk_ctrl, enable);
>> +    if (sspp && sspp->cap->clk_ctrl_reg)
>> +        return sspp->ops.setup_clk_force_ctrl(sspp, enable);
>> +    else if (wb && wb->caps->clk_ctrl_reg)
>> +        return wb->ops.setup_clk_force_ctrl(wb, enable);
>> +    else
> 
> This is what I wanted to avoid.
> 
> If we move the caller function to the sspp / WB, we will not need this kind of wrapper.

I tried it, but it requires passing the mdp pointer to the setup_clk_force_ctrl op,
which is IMHO not super clean... or if you have a way to get dpu_hw_mdp from
within hw_sspp/hw_wb it would help.

> 
>> +        return mdp->ops.setup_clk_force_ctrl(mdp,
>> +                sspp ? sspp->cap->clk_ctrl : wb->caps->clk_ctrl,
>> +                enable);
>>   }
>>   /**
>> @@ -190,9 +198,13 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
>>           return;
>>       }
>> -    if (!mdp->ops.setup_clk_force_ctrl ||
>> -            !vbif->ops.set_limit_conf ||
>> -            !vbif->ops.set_halt_ctrl)
>> +    if ((!params->sspp && !params->wb) ||
>> +        (params->sspp && !params->sspp->ops.setup_clk_force_ctrl) ||
>> +        (params->wb && !params->wb->ops.setup_clk_force_ctrl) ||
>> +        !mdp->ops.setup_clk_force_ctrl)
>> +        return;
>> +
>> +    if (!vbif->ops.set_limit_conf || !vbif->ops.set_halt_ctrl)
>>           return;
>>       /* set write_gather_en for all write clients */
>> @@ -207,7 +219,7 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
>>       trace_dpu_perf_set_ot(params->num, params->xin_id, ot_lim,
>>           params->vbif_idx);
>> -    forced_on = dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
>> +    forced_on = dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, true);
> 
> I'd suggest removing the setup_clk_force_ctrl from dpu_vbif_set_ot_limit() and dpu_vbif_set_qos_remap(). Instead make dpu_plane / dpu_encoder_phys_wb call into dpu_hw_sspp / dpu_hw_wb, which will enable the clock, call dpu_vbif then disable the clock.
> 
> In my opinion this is simpler than the condition in the previous chunk.

Indeed this is a nice option, but the hw_mdp pointer requirement into hw_sspp/hw_wb
still puzzles me.

> 
>>       vbif->ops.set_limit_conf(vbif, params->xin_id, params->rd, ot_lim);
>> @@ -220,7 +232,7 @@ void dpu_vbif_set_ot_limit(struct dpu_kms *dpu_kms,
>>       vbif->ops.set_halt_ctrl(vbif, params->xin_id, false);
>>       if (forced_on)
>> -        dpu_vbif_setup_clk_force_ctrl(mdp,  params->clk_ctrl, false);
>> +        dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, false);
>>   }
>>   void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
>> @@ -245,7 +257,10 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
>>           return;
>>       }
>> -    if (!vbif->ops.set_qos_remap || !mdp->ops.setup_clk_force_ctrl) {
>> +    if ((!params->sspp && !params->wb) ||
>> +        (params->sspp && !params->sspp->ops.setup_clk_force_ctrl) ||
>> +        (params->wb && !params->wb->ops.setup_clk_force_ctrl) ||
>> +        !mdp->ops.setup_clk_force_ctrl || !vbif->ops.set_qos_remap) {
>>           DRM_DEBUG_ATOMIC("qos remap not supported\n");
>>           return;
>>       }
>> @@ -258,7 +273,7 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
>>           return;
>>       }
>> -    forced_on = dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, true);
>> +    forced_on = dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, true);
>>       for (i = 0; i < qos_tbl->npriority_lvl; i++) {
>>           DRM_DEBUG_ATOMIC("%s xin:%d lvl:%d/%d\n",
>> @@ -269,7 +284,7 @@ void dpu_vbif_set_qos_remap(struct dpu_kms *dpu_kms,
>>       }
>>       if (forced_on)
>> -        dpu_vbif_setup_clk_force_ctrl(mdp, params->clk_ctrl, false);
>> +        dpu_vbif_setup_clk_force_ctrl(params->sspp, params->wb, mdp, false);
>>   }
>>   void dpu_vbif_clear_errors(struct dpu_kms *dpu_kms)
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
>> index ab490177d886..a4fe76e390d9 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_vbif.h
>> @@ -7,7 +7,12 @@
>>   #include "dpu_kms.h"
>> +struct dpu_hw_sspp;
>> +struct dpu_hw_wb;
>> +
>>   struct dpu_vbif_set_ot_params {
>> +    struct dpu_hw_sspp *sspp;
>> +    struct dpu_hw_wb *wb;
>>       u32 xin_id;
>>       u32 num;
>>       u32 width;
>> @@ -16,28 +21,27 @@ struct dpu_vbif_set_ot_params {
>>       bool rd;
>>       bool is_wfd;
>>       u32 vbif_idx;
>> -    u32 clk_ctrl;
>>   };
>>   struct dpu_vbif_set_memtype_params {
>>       u32 xin_id;
>>       u32 vbif_idx;
>> -    u32 clk_ctrl;
>>       bool is_cacheable;
>>   };
>>   /**
>>    * struct dpu_vbif_set_qos_params - QoS remapper parameter
>> + * @sspp: backing SSPP
>>    * @vbif_idx: vbif identifier
>>    * @xin_id: client interface identifier
>> - * @clk_ctrl: clock control identifier of the xin
>>    * @num: pipe identifier (debug only)
>>    * @is_rt: true if pipe is used in real-time use case
>>    */
>>   struct dpu_vbif_set_qos_params {
>> +    struct dpu_hw_sspp *sspp;
>> +    struct dpu_hw_wb *wb;
>>       u32 vbif_idx;
>>       u32 xin_id;
>> -    u32 clk_ctrl;
>>       u32 num;
>>       bool is_rt;
>>   };
>>
> 

Thanks,
Neil
