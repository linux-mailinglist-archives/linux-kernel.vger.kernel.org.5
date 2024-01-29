Return-Path: <linux-kernel+bounces-42153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE483FD1E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A38E1C22B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964112E4D;
	Mon, 29 Jan 2024 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rnFuZ7Mr"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16911734
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706501332; cv=none; b=kGMx6sGLrGeSW/Fjgv2upV70RyuWDqHX2vHqlTrstGfQRUnBYvb4p+w5UAF1MQcFO9k5Z+/yiG9rWWiVVCdlx7SJCNBYsG+ogkWQjaPkv1DVMNOofuxXFQzvz+yvLfp+W4r8SzTzLX3x5LVHHOhAkgnrVd8QthVSvKUEcszrPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706501332; c=relaxed/simple;
	bh=MFnqxa2FlwSQnHD4FuVTTxhMbrdlgpPdXx9P5+EY9jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K31/U+f/AS3CepaBrhTOhQeDK/UB6iS3IuJ6Ds+VF3yggh4L2NCUKHqY0yWAqvcjpWpbVElzMhpC1ycr6I2BX2h4OaK3Mso3L03ayUcJXZyXWS1zhJFM0Qt8SMj9RflzHCKyE3QOBkCGJlRHVhQGSyGbGDllo0DTPuGlIUJEQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rnFuZ7Mr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff7ec8772dso23741677b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706501329; x=1707106129; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AKHdQZdCTLHs4pcHr7TzhQwsCq0HwLSonhICMhFAgjk=;
        b=rnFuZ7MrkWp1PzUWSio+u2CbOiXmUmCc2CONW/odWGuXNbfbcyLdvByxY97Q/v2Pfs
         CHujqPfiAAB0ph4BWthOD303v2WbJ76uT87ZXzKY1J6XyGrno2/RBEktkAHHEprF8vD1
         DbszTvEL7/5vC36fJFHvnIZN4ylwF3HeWvRy+Z2hpHh0gB7TUDZgzVbMf/US5zAwbynK
         Q8G3yS7IO1ZQZFsEnYJvagV12QMqWoF71imr1MGA4oXsWYCeaM/YI/2impEwv7b0jnQT
         GEyXhfyqWu1HAMvs8oMbtpFhHeMOsLN1tjsCwOPedyV/ModgG5rDbEywQUVLI2Gaf5al
         KXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706501329; x=1707106129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKHdQZdCTLHs4pcHr7TzhQwsCq0HwLSonhICMhFAgjk=;
        b=HfzrjwA6KLqxnvR9LZ+Iu/yQ2pFoB3vKLJ/+GHgC5dgQMxhq6x7nkMLfaYbyvRQCxF
         WXyYIGApHsXIO+cmZ5X8h9IxmkBYKex+Pi6l4UgF0vvkCviGLA6S7o6C9KVRxjmOSmk0
         CCHRlSicw3cVvG0DkbfarRtc93dNzPX7aB0LpxfZD5Q9STPtFN6Z8FDapaVEcZr2WhhU
         vjXz4wrv4YdjPt7nACdN1OCtVq5eIg3aMUYvU1PsZIFCdIVvwmB8IqohKv8XTtETq5C3
         8s7YiS14bRyVn4F3YRNeNKiF40OGu91ab42fkfjjWTdBdIDFu4pKnhHdmVK88beMiOC1
         ffzQ==
X-Gm-Message-State: AOJu0YzfBPR14zE4KUCMz4s1fwBtGbAUWxTvRul0Kd2T8LXgF4yYYjo6
	92oEqw/X8xC2K5yWkxsEjAu7I/XRz2YCBEjRrHH0KRK5FOd9gQxJvy8lmvobioP+pb3Qje3STMa
	n0OoLP7GoTulOHqrASF8r/OFBjSB9P0DPYz91dA==
X-Google-Smtp-Source: AGHT+IHmGSN3vYOtt0Yg2EhoesVrd7TO0jYAzwGfrgIgN8CjVtzRElVO9Po5LQYN1roAhOENrN/kaSwBj3wivE0PLWA=
X-Received: by 2002:a81:b666:0:b0:603:414b:d357 with SMTP id
 h38-20020a81b666000000b00603414bd357mr2958529ywk.52.1706501329443; Sun, 28
 Jan 2024 20:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org> <20240129-x1e80100-clock-controllers-v3-6-d96dacfed104@linaro.org>
In-Reply-To: <20240129-x1e80100-clock-controllers-v3-6-d96dacfed104@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jan 2024 06:08:38 +0200
Message-ID: <CAA8EJppBtc2HKcZ2sAgBm=+sxtisp-hsADp-ui6PRTRRixB8xw@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] clk: qcom: clk-alpha-pll: Add support for zonda
 ole pll configure
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, Rajendra Nayak <quic_rjendra@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 00:52, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>
> Zonda ole pll has as extra PLL_OFF_CONFIG_CTL_U2 register, hence add
> support for it.
>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 26 ++++++++++++++++++++++++++
>  drivers/clk/qcom/clk-alpha-pll.h |  4 ++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index 05898d2a8b22..85f8e2ad0b37 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -52,6 +52,7 @@
>  #define PLL_CONFIG_CTL(p)      ((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL])
>  #define PLL_CONFIG_CTL_U(p)    ((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL_U])
>  #define PLL_CONFIG_CTL_U1(p)   ((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL_U1])
> +#define PLL_CONFIG_CTL_U2(p)   ((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL_U2])
>  #define PLL_TEST_CTL(p)                ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL])
>  #define PLL_TEST_CTL_U(p)      ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U])
>  #define PLL_TEST_CTL_U1(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U1])
> @@ -228,6 +229,21 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>                 [PLL_OFF_ALPHA_VAL] = 0x24,
>                 [PLL_OFF_ALPHA_VAL_U] = 0x28,
>         },
> +       [CLK_ALPHA_PLL_TYPE_ZONDA_OLE] =  {
> +               [PLL_OFF_L_VAL] = 0x04,
> +               [PLL_OFF_ALPHA_VAL] = 0x08,
> +               [PLL_OFF_USER_CTL] = 0x0c,
> +               [PLL_OFF_USER_CTL_U] = 0x10,
> +               [PLL_OFF_CONFIG_CTL] = 0x14,
> +               [PLL_OFF_CONFIG_CTL_U] = 0x18,
> +               [PLL_OFF_CONFIG_CTL_U1] = 0x1c,
> +               [PLL_OFF_CONFIG_CTL_U2] = 0x20,
> +               [PLL_OFF_TEST_CTL] = 0x24,
> +               [PLL_OFF_TEST_CTL_U] = 0x28,
> +               [PLL_OFF_TEST_CTL_U1] = 0x2c,
> +               [PLL_OFF_OPMODE] = 0x30,
> +               [PLL_OFF_STATUS] = 0x3c,
> +       },
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>
> @@ -2093,6 +2109,16 @@ const struct clk_ops clk_alpha_pll_zonda_ops = {
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_zonda_ops);
>
> +const struct clk_ops clk_alpha_pll_zonda_ole_ops = {
> +       .enable = clk_zonda_pll_enable,
> +       .disable = clk_zonda_pll_disable,
> +       .is_enabled = clk_trion_pll_is_enabled,
> +       .recalc_rate = clk_trion_pll_recalc_rate,
> +       .round_rate = clk_alpha_pll_round_rate,
> +       .set_rate = clk_zonda_pll_set_rate,
> +};
> +EXPORT_SYMBOL(clk_alpha_pll_zonda_ole_ops);

Let's maybe follow the existing example and #define
clk_alpha_pll_zonda_ole_ops clk_alpha_pl_zonda_ops ?
See the defines at clk-alpha-pll.h

LGTM otherwise

> +
>  void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>                                  const struct alpha_pll_config *config)
>  {
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index a1a75bb12fe8..99a3db9de4a1 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -21,6 +21,7 @@ enum {
>         CLK_ALPHA_PLL_TYPE_LUCID = CLK_ALPHA_PLL_TYPE_TRION,
>         CLK_ALPHA_PLL_TYPE_AGERA,
>         CLK_ALPHA_PLL_TYPE_ZONDA,
> +       CLK_ALPHA_PLL_TYPE_ZONDA_OLE,
>         CLK_ALPHA_PLL_TYPE_LUCID_EVO,
>         CLK_ALPHA_PLL_TYPE_LUCID_OLE,
>         CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
> @@ -42,6 +43,7 @@ enum {
>         PLL_OFF_CONFIG_CTL,
>         PLL_OFF_CONFIG_CTL_U,
>         PLL_OFF_CONFIG_CTL_U1,
> +       PLL_OFF_CONFIG_CTL_U2,
>         PLL_OFF_TEST_CTL,
>         PLL_OFF_TEST_CTL_U,
>         PLL_OFF_TEST_CTL_U1,
> @@ -119,6 +121,7 @@ struct alpha_pll_config {
>         u32 config_ctl_val;
>         u32 config_ctl_hi_val;
>         u32 config_ctl_hi1_val;
> +       u32 config_ctl_hi2_val;
>         u32 user_ctl_val;
>         u32 user_ctl_hi_val;
>         u32 user_ctl_hi1_val;
> @@ -173,6 +176,7 @@ extern const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops;
>
>  extern const struct clk_ops clk_alpha_pll_zonda_ops;
>  #define clk_alpha_pll_postdiv_zonda_ops clk_alpha_pll_postdiv_fabia_ops
> +extern const struct clk_ops clk_alpha_pll_zonda_ole_ops;
>
>  extern const struct clk_ops clk_alpha_pll_lucid_evo_ops;
>  extern const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops;
>
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

