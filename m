Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9B7973FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbjIGPcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343610AbjIGPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:30:38 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBC31716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:30:11 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-573429f5874so586761eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100566; x=1694705366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ovU/2FxJPAjDLCUg/8wOJ1lYtXOuaSxCgEubikhoGHQ=;
        b=Kqzrmg8Tf2f+kBygLttcu7N1MERZ9+4m8Uj2lK9r6S5My5yp2N9zgMyKMapiM+fHxR
         PPrkEXg/HQYwx0FSmD/IEQpk72w+DlYP0woGNPZZuhZWQYzFCi75MyJBzg62f6zVwd+m
         FvYqplOfr/dAaZJo+ow0GEga8GGdbQUhfGXDCO9MFx3gzq8qV+9iLeVwD+BOhAnfezrH
         sgQQfNl7NGmBLICX+8xGPfpoEt0iE6+KVgOzks9r2KgJfCCOoFKql8WOw8uiZJnVtSHw
         ZimK9X3lLQmh1nprvC0zZC2uxmlUhMo7deu0I6vlqx30S60bp01YAWd/ShJ+98Ffvs+T
         BBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100566; x=1694705366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovU/2FxJPAjDLCUg/8wOJ1lYtXOuaSxCgEubikhoGHQ=;
        b=NyEr3vZMuK3QVYWehN96ExYv3jTyAyp+80oedsZBM6D1JSPcVvQyaQK9AjCWIERmXP
         fNwpYoNItCOCgZScv8yDgUSEL4dEaXvUKhF2lPwhMUrO2GqL/x5c1XtN2QDAOXOl5Jic
         0QcI4Jvq5/UJ2wA6SHs1+YBjAyKyBGIlo2Jf8XPBRSKKqFXJe8135idU5Nvg08kOeC3O
         3P7HSXbvmJUEVtgTiwA5m4rwHCw/L7Pxi9Nyeqs23Dm3ly6ZDcbwwspyecjKsf2uONXe
         /GdgzdLBcHg0EVxb7Vk5I7hByqRUEJIyUKm1S5H834RyQ44yJ6LRmScbzcpUBux6trYy
         dGvw==
X-Gm-Message-State: AOJu0YyTjib94mMsovk+YT2yWXm3TJc4QONn69QH4aNoVm6avwI4hjnR
        t3Cf9SSI4ooJIW1loFaP5/WaI9jAV4yAQ5fdD7JRU5VWL6hq8l+99xo=
X-Google-Smtp-Source: AGHT+IGgGELYVKv2nxaDzcRi7A6G5VIgfNHh71hrLRfSFiCDzzZExTZrNatFtyjQnKvxF58qCdkuFUnRMrIuFGcEb1g=
X-Received: by 2002:a25:ad03:0:b0:d7b:8c90:ce5b with SMTP id
 y3-20020a25ad03000000b00d7b8c90ce5bmr19553639ybi.63.1694093984119; Thu, 07
 Sep 2023 06:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <18a3bc0c5b371deec5c4bbe6ceacf8afcf0bc640.1693996662.git.quic_varada@quicinc.com>
In-Reply-To: <18a3bc0c5b371deec5c4bbe6ceacf8afcf0bc640.1693996662.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Sep 2023 16:39:33 +0300
Message-ID: <CAA8EJpoZ_8zXn9RcZQ+dV+hOpYBZQtD7oUQxWQYUqfTN+X=+7A@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] clk: qcom: clk-alpha-pll: introduce stromer plus ops
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 08:22, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Stromer plus APSS PLL does not support dynamic frequency scaling.
> To switch between frequencies, we have to shut down the PLL,
> configure the L and ALPHA values and turn on again. So introduce the
> separate set of ops for Stromer Plus PLL.
>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 68 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-alpha-pll.h |  1 +
>  2 files changed, 69 insertions(+)
>
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index e4ef645..2ef81f7 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -2479,3 +2479,71 @@ const struct clk_ops clk_alpha_pll_stromer_ops = {
>         .set_rate = clk_alpha_pll_stromer_set_rate,
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
> +
> +static int clk_alpha_pll_stromer_plus_determine_rate(struct clk_hw *hw,
> +                                                    struct clk_rate_request *req)
> +{
> +       struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +       u32 l, alpha_width = pll_alpha_width(pll);
> +       u64 a;
> +
> +       req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate, &l,
> +                                        &a, alpha_width);
> +       return 0;
> +}

What is the plL_alpha_width on stromer_plus? Does
clk_alpha_pll_stromer_determine_rate() work for you?

> +
> +static int clk_alpha_pll_stromer_plus_set_rate(struct clk_hw *hw,
> +                                              unsigned long rate,
> +                                              unsigned long prate)
> +{
> +       struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> +       u32 l, alpha_width = pll_alpha_width(pll);
> +       int ret;
> +       u64 a;
> +
> +       rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
> +
> +       regmap_write(pll->clkr.regmap, PLL_MODE(pll), 0);
> +
> +       /* Delay of 2 output clock ticks required until output is disabled */
> +       udelay(1);
> +
> +       regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
> +
> +       if (alpha_width > ALPHA_BITWIDTH)
> +               a <<= alpha_width - ALPHA_BITWIDTH;
> +
> +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
> +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
> +                                       a >> ALPHA_BITWIDTH);
> +
> +       regmap_write(pll->clkr.regmap, PLL_MODE(pll), PLL_BYPASSNL);
> +
> +       /* Wait five micro seconds or more */
> +       udelay(5);
> +       regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_RESET_N,
> +                          PLL_RESET_N);
> +
> +       /* The lock time should be less than 50 micro seconds worst case */
> +       udelay(50);
> +
> +       ret = wait_for_pll_enable_lock(pll);
> +       if (ret) {
> +               pr_err("alpha pll running in 800 MHz with source GPLL0\n");
> +               return ret;
> +       }
> +       regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL,
> +                          PLL_OUTCTRL);
> +
> +       return 0;
> +}
> +
> +const struct clk_ops clk_alpha_pll_stromer_plus_ops = {
> +       .enable = clk_alpha_pll_enable,
> +       .disable = clk_alpha_pll_disable,
> +       .is_enabled = clk_alpha_pll_is_enabled,
> +       .recalc_rate = clk_alpha_pll_recalc_rate,
> +       .determine_rate = clk_alpha_pll_stromer_plus_determine_rate,
> +       .set_rate = clk_alpha_pll_stromer_plus_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_plus_ops);
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index e4bd863..903fbab 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -152,6 +152,7 @@ extern const struct clk_ops clk_alpha_pll_postdiv_ops;
>  extern const struct clk_ops clk_alpha_pll_huayra_ops;
>  extern const struct clk_ops clk_alpha_pll_postdiv_ro_ops;
>  extern const struct clk_ops clk_alpha_pll_stromer_ops;
> +extern const struct clk_ops clk_alpha_pll_stromer_plus_ops;
>
>  extern const struct clk_ops clk_alpha_pll_fabia_ops;
>  extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
