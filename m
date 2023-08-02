Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00D976CFC2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjHBOLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjHBOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:11:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C544C2708
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 07:11:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3177163aa97so6967413f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690985490; x=1691590290;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SVUD/O22MK9ex6QgiZ3+WUntWWQ3J8kc4lQNBHLBbPU=;
        b=O0pl3CfNG+2nlyUt5+zfo6hxkUIwCmA0VTxeAoAucHTP2J3GXCg1P/ihndRx2gZ1I4
         0t1+kPq9wQCvjz8ovRbBlbKlQwVL6EZg7iHAAyFUZ3WHclipajFdd87iZ8Vjjz/ygVRQ
         rWHMIgDWEKEZc+nK0spkAOFVW8mN7o3dPyajSNEcGbZcve+qEJNuTbJ2TddbaiHi2J/C
         EpxmIZKdd6hrUpaH5JR5F3pfc6P+vE3OA7K39Ynn52i6RoSMpdc0BHai/1MAkXTt/Lco
         hcj1WzLZnaiL5wxytbt69pPeY3LyclHGlIdXaKnPhDJ4q8JLhVQIqEJGRpWj1iuf64c5
         QmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690985490; x=1691590290;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVUD/O22MK9ex6QgiZ3+WUntWWQ3J8kc4lQNBHLBbPU=;
        b=Dt/1tAD8pEXi7mi8L96sRdW9oEK1aRmeicG/0dKWVDKQ+vgMvKUGw5pW+MLOwEKHpy
         qc/4BEVq0pVKcYC3p0RQDu5ZBpntIqyxY67jI+aQ7rCG+amdMo1u5sCfVbK8lrzs6kOt
         9p6clFFMLby9xBSYoRKxiUnu6zcdyL8eA0bEF0rqqUoNL7rR004vicwV0YS2wCwRJGOp
         Jt9giG9LQN62szkzNUOXLZFqLN6xNSsxwh8sM7BK5A8E6NMaJVXcUWb//vuySTJ308IK
         dUog01nCYdOSPmgWiiNjUhliBfb8UyT2xKvefAXzasezDMslURgP8bxgVVpWy2sCVhEj
         oevw==
X-Gm-Message-State: ABy/qLbrrl7fieLnYJZW8PT9/6TKufKLcB6gSUSkbIgSSJF+lIqxbTb0
        Nc2iJFhwrErG6klbx2CJnogs0A==
X-Google-Smtp-Source: APBJJlG571gwXZIj6TT36oNDTSONPYSRs5LsCoWFMRx/QXy3Xwaf3xs7Q41gEg0SoGxykIUAzWqDbw==
X-Received: by 2002:a5d:6a8e:0:b0:314:468d:ccab with SMTP id s14-20020a5d6a8e000000b00314468dccabmr4601407wru.45.1690985490210;
        Wed, 02 Aug 2023 07:11:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196? ([2a01:e0a:982:cbb0:c5bb:5b4:61e3:d196])
        by smtp.gmail.com with ESMTPSA id c7-20020a7bc847000000b003fe22da3bc5sm1772761wml.42.2023.08.02.07.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 07:11:29 -0700 (PDT)
Message-ID: <079ece4b-3f36-2ff9-36ff-23fcc4c2c8e1@linaro.org>
Date:   Wed, 2 Aug 2023 16:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/msm/dpu: increase memtype count to 16 for sm8550
Content-Language: en-US
To:     Jonathan Marek <jonathan@marek.ca>, freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230802134900.30435-1-jonathan@marek.ca>
Organization: Linaro Developer Services
In-Reply-To: <20230802134900.30435-1-jonathan@marek.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 15:48, Jonathan Marek wrote:
> sm8550 has 16 vbif clients.
> 
> This fixes the extra 2 clients (DMA4/DMA5) not having their memtype
> initialized. This fixes DMA4/DMA5 planes not displaying correctly.
> 
> Fixes: efcd0107 ("drm/msm/dpu: add support for SM8550")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   .../msm/disp/dpu1/catalog/dpu_9_0_sm8550.h    |  4 ++--
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 20 +++++++++++++++++++
>   2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> index f17b9a7fee85..89a2ac1e840d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> @@ -245,8 +245,8 @@ const struct dpu_mdss_cfg dpu_sm8550_cfg = {
>   	.merge_3d = sm8550_merge_3d,
>   	.intf_count = ARRAY_SIZE(sm8550_intf),
>   	.intf = sm8550_intf,
> -	.vbif_count = ARRAY_SIZE(sdm845_vbif),
> -	.vbif = sdm845_vbif,
> +	.vbif_count = ARRAY_SIZE(sm8550_vbif),
> +	.vbif = sm8550_vbif,
>   	.perf = &sm8550_perf_data,
>   	.mdss_irqs = BIT(MDP_SSPP_TOP0_INTR) | \
>   		     BIT(MDP_SSPP_TOP0_INTR2) | \
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 0de507d4d7b7..8b17a4a9b438 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -663,6 +663,26 @@ static const struct dpu_vbif_cfg sdm845_vbif[] = {
>   	},
>   };
>   
> +static const struct dpu_vbif_cfg sm8550_vbif[] = {
> +	{
> +	.name = "vbif_rt", .id = VBIF_RT,
> +	.base = 0, .len = 0x1040,
> +	.features = BIT(DPU_VBIF_QOS_REMAP),
> +	.xin_halt_timeout = 0x4000,
> +	.qos_rp_remap_size = 0x40,
> +	.qos_rt_tbl = {
> +		.npriority_lvl = ARRAY_SIZE(sdm845_rt_pri_lvl),
> +		.priority_lvl = sdm845_rt_pri_lvl,
> +		},
> +	.qos_nrt_tbl = {
> +		.npriority_lvl = ARRAY_SIZE(sdm845_nrt_pri_lvl),
> +		.priority_lvl = sdm845_nrt_pri_lvl,
> +		},
> +	.memtype_count = 16,
> +	.memtype = {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
> +	},
> +};
> +
>   /*************************************************************
>    * PERF data config
>    *************************************************************/

Thanks !

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
