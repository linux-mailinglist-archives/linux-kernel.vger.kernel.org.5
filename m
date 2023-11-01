Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6048A7DE782
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbjKAV3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345342AbjKAV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:29:10 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE61115
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:29:04 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5b31c5143a0so3509567b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 14:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698874144; x=1699478944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oecjfdn9qXi32jEmitsKgnhqeMKJivxOJDI7gWIxsLQ=;
        b=VvVxEBRWw46bR55cGJJNWQBmjfn+z3gVkhxevtkc0BK6qAEOgXR0VjZJ9ek8n1h1Y0
         Xv2eXSxMpnCVOEGBCZ3cGGDKihQYCmZOHDyIllFHf7OlGw9Gx3uYVb7ERwn7SaNxF12f
         I/Bx62mywGvdP15AzrlqK5nyTYMX5yrCMYLwBNB6z5cIAgOKCJJWU39K5kApfcdctgGv
         M9ghsaPN5uLi8hvUTXk80u+S4Fe8V7ntplTBb2pDxcbzU+w7ueSfGMHWi8LwjJ78zxZd
         58qW7HI265MipW/nHjo7Bovl4rGNiSgQAPEifp0TcXFryaKLMlahLVxkNBmf7g59YLqk
         wKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698874144; x=1699478944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oecjfdn9qXi32jEmitsKgnhqeMKJivxOJDI7gWIxsLQ=;
        b=hmKTc6b5VLpPejFMwu5sQ7OWSWP2FYfTthAp1neDtqjFn0+UlOcuOT+9p7WmFLfT/d
         JADoxsFp5wd6M+7kTp+rqk+0RsXhGXZLGq8Ean0qzi6cdwTFmLd5xR8DNR7ggznNBucf
         3b3K6+yfF9z5pSqHWE6jUqp/wIWxP0DyMrG7gGqzVvE0rlnjBgBxwCenma1bGF2aYOLc
         Rt7RcEE55RcUopUUfsnj1N9YwGr8piyOp255xbR8AihxR5ivDGy+nCtm53/z5f8qqtrL
         gygYDJUdrUzNVjwHzyKM26Zwt7Rr/jLFwzxyZgEpPbqT8m6pDrfL5GqCRzaukgH4CIHX
         JEMg==
X-Gm-Message-State: AOJu0YxvXqTWytTf7MKTkQrLIOzYaYDWXZ0zb5i7juytzErxh3yLHccx
        1Jf43L5PDX8HOYqW1D/rXZqjliLAB3R/J1mXuKarsg==
X-Google-Smtp-Source: AGHT+IFN3Chnt8MUYEHHNt6dZWw74HqhEo9JPWQVnUoG1Y770XslD/GaJhwKd7CUE3x1gUlJJ8PX3On1cylrXoUAoj8=
X-Received: by 2002:a81:d308:0:b0:5a8:60ad:39a4 with SMTP id
 y8-20020a81d308000000b005a860ad39a4mr16560750ywi.3.1698874143732; Wed, 01 Nov
 2023 14:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org> <20231101-gdsc-hwctrl-v3-3-0740ae6b2b04@linaro.org>
In-Reply-To: <20231101-gdsc-hwctrl-v3-3-0740ae6b2b04@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 1 Nov 2023 23:28:52 +0200
Message-ID: <CAA8EJpqTafxkXfAZXdTCat1VphvHUTTWe1TUjbpMvqta1Jf+Cw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 3/5] clk: qcom: gdsc: Add set and get hwmode
 callbacks to switch GDSC mode
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2023 at 11:06, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>
> Add support for set and get hwmode callbacks to switch the GDSC between
> SW and HW modes. Currently, the GDSC is moved to HW control mode
> using HW_CTRL flag and if this flag is present, GDSC is moved to HW
> mode as part of GDSC enable itself. The intention is to keep the
> HW_CTRL flag functionality as is, since many older chipsets still use
> this flag.
>
> Introduce a new HW_CTRL_TRIGGER flag to switch the GDSC back and forth
> between HW/SW modes dynamically at runtime. If HW_CTRL_TRIGGER flag is
> present, register set_hwmode_dev callback to switch the GDSC mode which
> can be invoked from consumer drivers using dev_pm_genpd_set_hwmode
> function. Unlike HW_CTRL flag, HW_CTRL_TRIGGER won't move the GDSC to HW
> control mode as part of GDSC enable itself, GDSC will be moved to HW
> control mode only when consumer driver explicity calls
> dev_pm_genpd_set_hwmode to switch to HW mode. Also add the
> dev_pm_genpd_get_hwmode to allow the consumers to read the actual
> HW/SW mode from hardware.

Can we add two new flags:
- HW_CTRL_TRIGGER
- DEFAULT_HW_TRIGGER

And then define HW_CTRL as HW_CTRL_TRIGGER | DEFAULT_HW_TRIGGER ?

This way older platforms will keep existing behaviour, but can
gradually migrate to the new callbacks?

>
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/gdsc.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/gdsc.h |  1 +
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
> index 5358e28122ab..c763524cd5da 100644
> --- a/drivers/clk/qcom/gdsc.c
> +++ b/drivers/clk/qcom/gdsc.c
> @@ -363,6 +363,34 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>         return 0;
>  }
>
> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
> +{
> +       struct gdsc *sc = domain_to_gdsc(domain);
> +
> +       if (sc->rsupply && !regulator_is_enabled(sc->rsupply)) {
> +               pr_err("Cannot set mode while parent is disabled\n");
> +               return -EIO;
> +       }
> +
> +       return gdsc_hwctrl(sc, mode);
> +}
> +
> +static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
> +{
> +       struct gdsc *sc = domain_to_gdsc(domain);
> +       u32 val;
> +       int ret;
> +
> +       ret = regmap_read(sc->regmap, sc->gdscr, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (val & HW_CONTROL_MASK)
> +               return true;
> +
> +       return false;
> +}
> +
>  static int gdsc_init(struct gdsc *sc)
>  {
>         u32 mask, val;
> @@ -451,6 +479,10 @@ static int gdsc_init(struct gdsc *sc)
>                 sc->pd.power_off = gdsc_disable;
>         if (!sc->pd.power_on)
>                 sc->pd.power_on = gdsc_enable;
> +       if (sc->flags & HW_CTRL_TRIGGER) {
> +               sc->pd.set_hwmode_dev = gdsc_set_hwmode;
> +               sc->pd.get_hwmode_dev = gdsc_get_hwmode;
> +       }
>
>         ret = pm_genpd_init(&sc->pd, NULL, !on);
>         if (ret)
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index 803512688336..1e2779b823d1 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -67,6 +67,7 @@ struct gdsc {
>  #define ALWAYS_ON      BIT(6)
>  #define RETAIN_FF_ENABLE       BIT(7)
>  #define NO_RET_PERIPH  BIT(8)
> +#define HW_CTRL_TRIGGER        BIT(9)
>         struct reset_controller_dev     *rcdev;
>         unsigned int                    *resets;
>         unsigned int                    reset_count;
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
