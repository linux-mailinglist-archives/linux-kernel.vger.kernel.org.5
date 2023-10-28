Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AAA7DA8CA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 21:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjJ1THD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1THA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 15:07:00 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5890F2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 12:06:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40790b0a224so23222595e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698520016; x=1699124816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9S0aP/DAr8QgXn/c7opvaFYYMlH14zJNjTl2DhjYeZ0=;
        b=GyQ9FjaVeo+foJMN7ZOectkMjqGUmG4qHNHsIyB9V/2sciOUbflMB761xTlygC70v2
         zxqXcuXhyItO9XDdyxAp901gNC2u7LLgoczCywT4+/ifUyEaZ6PX7skVFtTxq24ysGiD
         lgQxNI+lJzoQjZShh6TW232tJRpbHYa8iSCQuR/76epsd6Vg6BLQ02is5BEFFIRfLUeF
         LImCHmK7fbb4RreXgQLj0Ug4Box8TO+Ub4Qk5powsWNtpcJq4JQ1URVZITK2KDLbf894
         TlSbo/s6iXYzUUiL6YYsHsPaOJYY8GJxJhHYGGLyE+37P+rGULeo7vMICu6eskMJ1pOS
         tcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698520016; x=1699124816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9S0aP/DAr8QgXn/c7opvaFYYMlH14zJNjTl2DhjYeZ0=;
        b=jIh6N8P42MnmNDQwrjTrfhlaL+hkY+dqfp2LJDnKGE9V5JJA+1O2B6AaSxbkkimLlY
         SCUblUSECAm9kgu1fqtyDUljKRAUwGVcEYGJtcxLvso4ZwU7lVcaYO0wBblEED0BB1uu
         xYUTMUTWEsGDqpwIAMVszxcKlgYGVwbcf7FZOv7GRPzuNI6EyxkWp8EUS8RB1rkkUP4l
         9t3TgqIk+CQrLHIqBkWXJvWaht0We4xmqBIMbo/xcwTTjzAxtgZOMrgLQ7p28Zg6oXsK
         wKoXh5joOyE/GOK3FKS3Cuq7ltJMgne+DtTk1vd20XOLbxwW7lR+v8POcAapkREKlwrI
         ibVg==
X-Gm-Message-State: AOJu0YygRSUqQGsaZPjqNM1lt84IBFuf0yRNSoLLuVs5LPqwNyaoEAP+
        +FbnclEVW0F/Wp5u0Po3+EC+/Q==
X-Google-Smtp-Source: AGHT+IH1EYQ37mPecAHTkLvHphgwrSOp4qEhgbT/T5bYkEBNbWW7FKFTMb9Mzv5cXrsbSvtwi6lGCQ==
X-Received: by 2002:a05:600c:4592:b0:408:575e:f24f with SMTP id r18-20020a05600c459200b00408575ef24fmr4741350wmo.28.1698520016048;
        Sat, 28 Oct 2023 12:06:56 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c190800b004063ea92492sm4683574wmq.22.2023.10.28.12.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Oct 2023 12:06:55 -0700 (PDT)
Message-ID: <3bc27995-4905-40b8-9b6c-3fc5d77086a2@linaro.org>
Date:   Sat, 28 Oct 2023 20:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-msm8939: Fix mclk0 & mclk1 for 24 MHz
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephan Gerhold <stephan@gerhold.net>
References: <20231028120756.316574-1-vincent.knecht@mailoo.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231028120756.316574-1-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2023 13:07, Vincent Knecht wrote:
> Fix mclk0 & mclk1 parent map to use correct GPLL6 configuration and
> freq_tbl to use GPLL6 instead of GPLL0 so that they tick at 24 MHz.
> 
> Fixes: 1664014e4679 ("clk: qcom: gcc-msm8939: Add MSM8939 Generic Clock Controller")
> Suggested-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>   drivers/clk/qcom/gcc-msm8939.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-msm8939.c b/drivers/clk/qcom/gcc-msm8939.c
> index b45f97c07eeb..e4a44377b75f 100644
> --- a/drivers/clk/qcom/gcc-msm8939.c
> +++ b/drivers/clk/qcom/gcc-msm8939.c
> @@ -432,7 +432,7 @@ static const struct parent_map gcc_xo_gpll0_gpll1a_gpll6_sleep_map[] = {
>   	{ P_XO, 0 },
>   	{ P_GPLL0, 1 },
>   	{ P_GPLL1_AUX, 2 },
> -	{ P_GPLL6, 2 },
> +	{ P_GPLL6, 3 },
>   	{ P_SLEEP_CLK, 6 },
>   };
>   
> @@ -1100,7 +1100,7 @@ static struct clk_rcg2 jpeg0_clk_src = {
>   };
>   
>   static const struct freq_tbl ftbl_gcc_camss_mclk0_1_clk[] = {
> -	F(24000000, P_GPLL0, 1, 1, 45),
> +	F(24000000, P_GPLL6, 1, 1, 45),
>   	F(66670000, P_GPLL0, 12, 0, 0),
>   	{ }
>   };

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
