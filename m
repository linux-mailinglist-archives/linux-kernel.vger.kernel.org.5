Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F6D7E7F65
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjKJRxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjKJRwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183D09ED9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:16:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5094727fa67so2658301e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699614993; x=1700219793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxkmO6IiYGO72UiX4UQ3V4i7IbbmznqMUd9OJsl5lng=;
        b=JwfP/TyNeSgQdlypAM+fHzwg8aFfvIPw8JDJszmWNtKt0J58mO0pekWEu8SBSZkcMm
         52OoNyEuh4610urXjKf+CYpZKAXfKHJ2uBug+rqix8sw0ZGaVwuSXiGDq/HRtiC4Slmj
         Z+4pNmgQrlGAIhglGkse2eivYkmbp8hNWHE7D0nLza9Rc3dT5TR3PtSBRjRySt1Cw7KN
         qJwGNsoAEH/7MYymG+4k0LvEDUs7QGSyz9+cv5w4aww2Y5WP8SS56+K6hXxVbp8wxloo
         +Ov1NGjHwkx+YD1bPdGiasDkTA+rXeN+/hYaPOZj0mjC5oEYLfy0b9F3yvAfPHgBJu9E
         vI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699614993; x=1700219793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxkmO6IiYGO72UiX4UQ3V4i7IbbmznqMUd9OJsl5lng=;
        b=UCmZy8bMrLNJs5sKNmfF3TpZ+bnUUg3NuwdfWc74j9F37HtoT6VYN0d5HAESXk7IGf
         X+W7iQUqw6rnBM7QGSxbsUDqlRvg0U40MiREgWhajHciNZbwyjhZE0yeFe4tMi95JP7s
         OXOlMvmLab5NOKJMrmdfPoTt0WPedPWLMsLFyrQnAeZWzJ2xF3SCIja15RQtVA+551Yf
         dmzEBLthfaXO1g4KtM/zvPIWiJj0KnNjBYAu8jQIUCVMv1tfg8ugc8f8eNngHWfolWcf
         8KOlV6aM65mcVd55WVpz+WEV1UrsWJOBdi0w+9wXq74LLQt9vt0xt+myyF6NHIFI09NE
         1ljA==
X-Gm-Message-State: AOJu0YwZJMohAXaadBdsd5oOqN7XYv57MRtLzJkA3113MuoR6CVGekS6
        ERIf7sxfHdMB//KcPhKF27uBGg==
X-Google-Smtp-Source: AGHT+IHXTskzoQbtZ1PX/JfXAerX3f0kEvVd3Cs31EwwuZUMwgpO6YJA4nLPMZyYekHnMs37CNs3yQ==
X-Received: by 2002:a2e:8793:0:b0:2c5:5926:de4c with SMTP id n19-20020a2e8793000000b002c55926de4cmr6089246lji.32.1699614993290;
        Fri, 10 Nov 2023 03:16:33 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id gy15-20020a05600c880f00b004064741f855sm4759808wmb.47.2023.11.10.03.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 03:16:32 -0800 (PST)
Message-ID: <8457b113-bef2-47e4-a138-0f92a4f5798a@linaro.org>
Date:   Fri, 10 Nov 2023 11:16:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: qcom: videocc-sm8150: Update the
 video_pll0_config
Content-Language: en-US
To:     Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20231110065029.2117212-1-quic_skakitap@quicinc.com>
 <20231110065029.2117212-4-quic_skakitap@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231110065029.2117212-4-quic_skakitap@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 06:50, Satya Priya Kakitapalli wrote:
> Update the video_pll0_config to configure the test_ctl_hi and
> test_ctl_hi1 values.
> 
> Fixes: 5658e8cf1a8a ("clk: qcom: add video clock controller driver for SM8150")
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>   drivers/clk/qcom/videocc-sm8150.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/qcom/videocc-sm8150.c b/drivers/clk/qcom/videocc-sm8150.c
> index 6a5f89f53da8..ddfe784fb9e1 100644
> --- a/drivers/clk/qcom/videocc-sm8150.c
> +++ b/drivers/clk/qcom/videocc-sm8150.c
> @@ -33,6 +33,8 @@ static struct alpha_pll_config video_pll0_config = {
>   	.config_ctl_val = 0x20485699,
>   	.config_ctl_hi_val = 0x00002267,
>   	.config_ctl_hi1_val = 0x00000024,
> +	.test_ctl_hi_val = 0x00000002,
> +	.test_ctl_hi1_val = 0x00000020,
>   	.user_ctl_val = 0x00000000,
>   	.user_ctl_hi_val = 0x00000805,
>   	.user_ctl_hi1_val = 0x000000D0,

It would be nice to get a better description of this change.

Reading this - I can see it does an update but, the commit log should 
contain what it is updating and why plus what effect the update will have.

Please update the commit log to capture that data and +cc me on the V2.

---
bod
