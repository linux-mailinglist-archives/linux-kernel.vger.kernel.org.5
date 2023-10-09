Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44287BE768
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377391AbjJIRKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376329AbjJIRKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:10:11 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47029D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:10:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c1854bebf5so59511391fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696871408; x=1697476208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYoCwAiR4inAijqUaMCL87UoY8rv8b+1tyeGpKKu09k=;
        b=PyPvSmxcfAv9ivXy4cY5YLrAxfbrPU0NCSeBJly5pc9QU74FT21gxOX5cR7Oe2C8NP
         pzTBmOen/RKpQxP8v9N4hluzRHl+MdX1bvd2oM+9wBvu4BI/2aQcTHdimKfo1rM/GrSL
         G+RuRWSWpK3c1mmqZjlfR9V+8pM//KAAaeOCRM72GSTw733jV/1RvC25i22DE41komL7
         BoerYAyubztj8IR4DHFGDC1MUueXulYvNUDxFFyhjeYHXvWGkW1u2LMiXy1RIjzW3ZlQ
         2R1JA65sIgj4rc85WY3Y5nak40X26wraWPfjPnGjBXj4NsHT++8VbFOZqvnqtd1cImfv
         jRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696871408; x=1697476208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYoCwAiR4inAijqUaMCL87UoY8rv8b+1tyeGpKKu09k=;
        b=X7hckSlyAV7NVOzF5WIjSyKguc3MseGtnjXtPc1ZwHkvP5D9L3k6v6w5EFbQypBh6w
         qqkAWCjv6W/YoysqNrGM69OTjRfDmN9/lBeCnwUJp89zwxvfqn4jVYoW/y1j/mAhYJ+E
         AtavhW6+hGYXUNnh4YgSGnYjD0dfBKfnF8LRan/3vpT/AIDQDATuPjxR9+OsEbhT0mUi
         yfUmxKe+I/spuCQGvQPPsM76qhpt8m9clPIOHEuoVxX9Hjp1BSSQV8WtLab9d8mIxYFU
         TG5y63zKk2HwtHbHhEYydOvr78mP2TEBM/No3EE/hIi3LNJOjYcl4BeAW6F0EG4os4KO
         96hw==
X-Gm-Message-State: AOJu0YyQy+fEsKdyliPfdFw0T+S9DlYqCAeJHJ3zM31S1km95vRkjgB7
        DMmqZV21YONYL25BiS+wmlsd1A==
X-Google-Smtp-Source: AGHT+IGjIv5lRo3XdQegUZ6LOT8XiXCUx78FtqE80vN6nQNNSwkxg99L9GQkF4GuQxN8sfVQJ+uvtw==
X-Received: by 2002:a2e:b2d1:0:b0:2bf:f599:be63 with SMTP id 17-20020a2eb2d1000000b002bff599be63mr13449013ljz.41.1696871408005;
        Mon, 09 Oct 2023 10:10:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a19-20020a05651c011300b002bff365c7bfsm2098383ljb.35.2023.10.09.10.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 10:10:07 -0700 (PDT)
Message-ID: <7eecc9af-3d4f-43ba-8262-e58858bbe417@linaro.org>
Date:   Mon, 9 Oct 2023 20:10:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/5] drm/msm: dpu1: sm8550: move split clock controls
 to sspp entries
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
 <20231009-topic-sm8550-graphics-sspp-split-clk-v1-5-806c0dee4e43@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231009-topic-sm8550-graphics-sspp-split-clk-v1-5-806c0dee4e43@linaro.org>
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
> The SM8550 has the SSPP clk_ctrl in the SSPP registers, move them
> out of the MDP top.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 35 ++++++++++------------
>   1 file changed, 15 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> index 7bed819dfc39..527ec020fba4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> @@ -24,16 +24,6 @@ static const struct dpu_mdp_cfg sm8550_mdp = {
>   	.base = 0, .len = 0x494,
>   	.features = BIT(DPU_MDP_PERIPH_0_REMOVED),
>   	.clk_ctrls = {
> -		[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x4330, .bit_off = 0 },
> -		[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x6330, .bit_off = 0 },
> -		[DPU_CLK_CTRL_VIG2] = { .reg_off = 0x8330, .bit_off = 0 },
> -		[DPU_CLK_CTRL_VIG3] = { .reg_off = 0xa330, .bit_off = 0 },
> -		[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x24330, .bit_off = 0 },
> -		[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x26330, .bit_off = 0 },
> -		[DPU_CLK_CTRL_DMA2] = { .reg_off = 0x28330, .bit_off = 0 },
> -		[DPU_CLK_CTRL_DMA3] = { .reg_off = 0x2a330, .bit_off = 0 },
> -		[DPU_CLK_CTRL_DMA4] = { .reg_off = 0x2c330, .bit_off = 0 },
> -		[DPU_CLK_CTRL_DMA5] = { .reg_off = 0x2e330, .bit_off = 0 },
>   		[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20 },

Hmm, interesting. I even double-checked this. SSPP and WB have their own 
clock registers now. But the REG_DMA uses the main area (0x2bc).

>   	},
>   };
> @@ -73,6 +63,11 @@ static const struct dpu_ctl_cfg sm8550_ctl[] = {
>   	},
>   };
>   
> +static const struct dpu_clk_ctrl_reg sm8550_sspp_clk_ctrl = {
> +	.reg_off = 0x330,
> +	.bit_off = 0
> +};

I don't think we even need this outside of dpu_hw_sspp. You can use 
core_major_rev to check whether the driver should use global clocks or 
per-SSPP / per-WB clocks register instead.

> +
>   static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   	{
>   		.name = "sspp_0", .id = SSPP_VIG0,
> @@ -81,7 +76,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sm8550_vig_sblk_0,
>   		.xin_id = 0,
>   		.type = SSPP_TYPE_VIG,
> -		.clk_ctrl = DPU_CLK_CTRL_VIG0,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	}, {
>   		.name = "sspp_1", .id = SSPP_VIG1,
>   		.base = 0x6000, .len = 0x344,
> @@ -89,7 +84,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sm8550_vig_sblk_1,
>   		.xin_id = 4,
>   		.type = SSPP_TYPE_VIG,
> -		.clk_ctrl = DPU_CLK_CTRL_VIG1,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	}, {
>   		.name = "sspp_2", .id = SSPP_VIG2,
>   		.base = 0x8000, .len = 0x344,
> @@ -97,7 +92,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sm8550_vig_sblk_2,
>   		.xin_id = 8,
>   		.type = SSPP_TYPE_VIG,
> -		.clk_ctrl = DPU_CLK_CTRL_VIG2,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	}, {
>   		.name = "sspp_3", .id = SSPP_VIG3,
>   		.base = 0xa000, .len = 0x344,
> @@ -105,7 +100,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sm8550_vig_sblk_3,
>   		.xin_id = 12,
>   		.type = SSPP_TYPE_VIG,
> -		.clk_ctrl = DPU_CLK_CTRL_VIG3,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	}, {
>   		.name = "sspp_8", .id = SSPP_DMA0,
>   		.base = 0x24000, .len = 0x344,
> @@ -113,7 +108,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sdm845_dma_sblk_0,
>   		.xin_id = 1,
>   		.type = SSPP_TYPE_DMA,
> -		.clk_ctrl = DPU_CLK_CTRL_DMA0,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	}, {
>   		.name = "sspp_9", .id = SSPP_DMA1,
>   		.base = 0x26000, .len = 0x344,
> @@ -121,7 +116,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sdm845_dma_sblk_1,
>   		.xin_id = 5,
>   		.type = SSPP_TYPE_DMA,
> -		.clk_ctrl = DPU_CLK_CTRL_DMA1,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	}, {
>   		.name = "sspp_10", .id = SSPP_DMA2,
>   		.base = 0x28000, .len = 0x344,
> @@ -129,7 +124,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sdm845_dma_sblk_2,
>   		.xin_id = 9,
>   		.type = SSPP_TYPE_DMA,
> -		.clk_ctrl = DPU_CLK_CTRL_DMA2,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	}, {
>   		.name = "sspp_11", .id = SSPP_DMA3,
>   		.base = 0x2a000, .len = 0x344,
> @@ -137,7 +132,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sdm845_dma_sblk_3,
>   		.xin_id = 13,
>   		.type = SSPP_TYPE_DMA,
> -		.clk_ctrl = DPU_CLK_CTRL_DMA3,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	}, {
>   		.name = "sspp_12", .id = SSPP_DMA4,
>   		.base = 0x2c000, .len = 0x344,
> @@ -145,7 +140,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sm8550_dma_sblk_4,
>   		.xin_id = 14,
>   		.type = SSPP_TYPE_DMA,
> -		.clk_ctrl = DPU_CLK_CTRL_DMA4,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	}, {
>   		.name = "sspp_13", .id = SSPP_DMA5,
>   		.base = 0x2e000, .len = 0x344,
> @@ -153,7 +148,7 @@ static const struct dpu_sspp_cfg sm8550_sspp[] = {
>   		.sblk = &sm8550_dma_sblk_5,
>   		.xin_id = 15,
>   		.type = SSPP_TYPE_DMA,
> -		.clk_ctrl = DPU_CLK_CTRL_DMA5,
> +		.clk_ctrl_reg = &sm8550_sspp_clk_ctrl,
>   	},
>   };
>   
> 

-- 
With best wishes
Dmitry

