Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7927889F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbjHYOB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245545AbjHYOBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:01:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A2E2704
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:01:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31c83cd642cso168534f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692972063; x=1693576863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cz3wvihV4Khraq2quFRW1dbYxEl7BtIN5eOiHQDnTTs=;
        b=xqn7boffTsoZ8n5yt2Eo1KHP14UWJYM9I/i9voNa5bLezX07HVpDau5+ZiB5aSmXYL
         chspf245MiswOtYlVXA1o4e4OepqE/xiPUEU1H4wh9gzOYIycGbB5/CRz1UtZt177UnS
         JSSObj+MANe14J/OT4eKGMavoBpcpxPPct93IW8kSnikV6JU9YCSRSF7No5e6WrZ51H4
         Ur4ub9QrtS9Nt4YK61UN+o71lsoaDAqucKys1VFRDjsvsr8RViDYdwjlxWr8oSXhz3kT
         Sr1X2gpYYhyp0JbdNdLhgJ0j/kYfEspMjM7ZNt5by36av1Uevdl3ZzhUcHPBL3OQIXQe
         rwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692972063; x=1693576863;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cz3wvihV4Khraq2quFRW1dbYxEl7BtIN5eOiHQDnTTs=;
        b=hdQXhG36ipsih1fYo4YGfBksE4p47SQtxk1GmwnQeBrFBiJtKBLquWcmmcsOMbfOYo
         KeovhAJXg25purTzQX9yJSg1bLQIClDfLVy+XsJdX/vanuB1V0P7hiozSXdQ4ZPidu5p
         5jCZyMhHqMKXMu960rVDOdfGAqguasEwAcmOxmVKFn1A87z5ckXAn/r/j/NfPMeNg3Y5
         GJoX5lm7CnFhq9p5XjvNFC9AA9xoKwIalkylcAhQbWsCsHH8nGXZoVGMKOE7cSxel9m5
         VhMKwJ9lZByo+VHeAILlG4UKMcx+CeOsDIl57oXwl95UN6BJdhtwcT9JehnS88SrxaJD
         4x5g==
X-Gm-Message-State: AOJu0YzSiSnTwE84vLx10YrX8CMA7pTjCHx9EtvgsO82u1RODfhJosrT
        pK/D5YwUUwrDdUDq2bkk76uPEQ==
X-Google-Smtp-Source: AGHT+IHo2T3zBE151rMfkaJbiyRPBn5jZOjs9VP+lw99pnBUBa+mBAh2rrRjlocfb2/8uaB+zkWHjg==
X-Received: by 2002:a5d:61d0:0:b0:317:f537:748d with SMTP id q16-20020a5d61d0000000b00317f537748dmr13225547wrv.64.1692972062756;
        Fri, 25 Aug 2023 07:01:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4e1:71e1:b02b:811e? ([2a01:e0a:982:cbb0:4e1:71e1:b02b:811e])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d6510000000b003143c9beeaesm2322239wru.44.2023.08.25.07.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 07:01:02 -0700 (PDT)
Message-ID: <71d1d748-133a-470b-986c-ece79f743aa4@linaro.org>
Date:   Fri, 25 Aug 2023 16:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/4] clk: qcom: rpmh: Add RPMH clocks support for SM4450
Content-Language: en-US, fr
To:     Ajit Pandey <quic_ajipan@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824173410.550126-1-quic_ajipan@quicinc.com>
 <20230824173410.550126-3-quic_ajipan@quicinc.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20230824173410.550126-3-quic_ajipan@quicinc.com>
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

Hi,

On 24/08/2023 19:34, Ajit Pandey wrote:
> Add support for RPMH clocks for SM4450 platform.
> 
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>   drivers/clk/qcom/clk-rpmh.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 4c5b552b47b6..5d853fd43294 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -350,6 +350,7 @@ DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a2, "lnbclka3", 2);
>   
>   DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a4, "lnbclka1", 4);
>   DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _a4, "lnbclka2", 4);
> +DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a4, "lnbclka3", 4);
>   
>   DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _g4, "lnbclkg2", 4);
>   DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _g4, "lnbclkg3", 4);
> @@ -717,6 +718,25 @@ static const struct clk_rpmh_desc clk_rpmh_sdx75 = {
>   	.num_clks = ARRAY_SIZE(sdx75_rpmh_clocks),
>   };
>   
> +static struct clk_hw *sm4450_rpmh_clocks[] = {
> +	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div4.hw,
> +	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div4_ao.hw,

Are you sure about div4 here ?

Kailua uses div2 because the CXO input gets used divided by 2
by PHYs and divided by 4 for GCC/DISPCC/...

This is why we introduced a div2 clock in DT used to feed GCC/DISPCC/...

Neil

> +	[RPMH_LN_BB_CLK2]	= &clk_rpmh_ln_bb_clk2_a4.hw,
> +	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_ln_bb_clk2_a4_ao.hw,
> +	[RPMH_LN_BB_CLK3]       = &clk_rpmh_ln_bb_clk3_a4.hw,
> +	[RPMH_LN_BB_CLK3_A]     = &clk_rpmh_ln_bb_clk3_a4_ao.hw,
> +	[RPMH_RF_CLK1]		= &clk_rpmh_rf_clk1_a.hw,
> +	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
> +	[RPMH_RF_CLK5]		= &clk_rpmh_rf_clk5_a.hw,
> +	[RPMH_RF_CLK5_A]	= &clk_rpmh_rf_clk5_a_ao.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sm4450 = {
> +	.clks = sm4450_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(sm4450_rpmh_clocks),
> +};
> +
>   static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>   					 void *data)
>   {
> @@ -810,6 +830,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>   	{ .compatible = "qcom,sdx55-rpmh-clk",  .data = &clk_rpmh_sdx55},
>   	{ .compatible = "qcom,sdx65-rpmh-clk",  .data = &clk_rpmh_sdx65},
>   	{ .compatible = "qcom,sdx75-rpmh-clk",  .data = &clk_rpmh_sdx75},
> +	{ .compatible = "qcom,sm4450-rpmh-clk", .data = &clk_rpmh_sm4450},
>   	{ .compatible = "qcom,sm6350-rpmh-clk", .data = &clk_rpmh_sm6350},
>   	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
>   	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},

