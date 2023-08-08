Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6FA7743EB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjHHSMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjHHSL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:11:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022AA168B43
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:15:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686f38692b3so5853213b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691514946; x=1692119746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6S+a7yYbAbaMGNTQ39CoTTiQM46sZCpEJ7cTfZYNXGA=;
        b=Lx5g90Y9FoTVVViMPXEL4bXWDJVCil+eGqVwHTyT4cg0PzhXdny4MdmsD1q12iqKem
         26vh+T0JUf7vnMMPRHvajoabXdO3wFugYppfCwT8MTL4mdatDDO4tG9lzEuwSGvqfLUt
         TcV9lYKMTmRFDN+or8svOrX2E69p8qsQMFhyFAEZ+LmxnROQfJMRHFNNY/M1xw35WOIg
         Wu989wc4iaeCJH5V1aLGe0CLwufQlUlgnbos5xGmdBH330HeUbzdpEm8UUVLb3DLqWH3
         mcMNUal5VffH335OADi3l82ayxcb8wyTB0SPvI0IJsBMbv1IbpsPNNAvzDQOD0BD/x9Q
         P30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514946; x=1692119746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6S+a7yYbAbaMGNTQ39CoTTiQM46sZCpEJ7cTfZYNXGA=;
        b=Ob28PEfBY44Tf0CeDyyh7fRLOlhh1vhx7oKNvvablq36HcxhZsSC+YIDz4DwM5Q7sT
         EAkB0a6uTaeLFHTgpp5JIQcrVFDXDCpIg0537BUKpoQXndjcO+oVP8y43TElIJcreJ3P
         Z2JsS4JcMj10yUrBMeExnHXFqe3cwY7MlTpeUzIwFzciTq4E/KyuPm1hJvVq+gTNZISJ
         3RWcwhY/NfNq9Ccnjt3zyPmFifFZlIvI8BvldccKkO3vaERbTrk/Uj/g0MN7mBVAu4br
         VbPEh8kcNHjB9ND7GJaIKbgWZNLJP7xNIWPXhxY6LWJzp/NBeNyyriVAWsag4J2GAmYf
         JyzA==
X-Gm-Message-State: AOJu0YwGs3115rGcOPnhOslY7bE11oRUZOidDEK2HSSGFTsWoA3BEWrD
        Adq6kZEagdbw3YMuQxZRJnLJntq45CeQfpzbkUSSWw==
X-Google-Smtp-Source: AGHT+IGNaqV23dBBot7rOX2J7bjM37vOJ8eoGZABaopwO5OZt2zgCY1gyz5T/l8PD7NzJI9RShv6W3tBEWZXRJy+hew=
X-Received: by 2002:a17:90b:2385:b0:262:e821:b3f8 with SMTP id
 mr5-20020a17090b238500b00262e821b3f8mr169486pjb.38.1691514945940; Tue, 08 Aug
 2023 10:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230808082738.122804-1-krzysztof.kozlowski@linaro.org> <20230808082738.122804-10-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808082738.122804-10-krzysztof.kozlowski@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 8 Aug 2023 12:15:34 -0500
Message-ID: <CAPLW+4=h7EvHwzkP84+z1T3o=PvBScsaBFsbG=Y+odYrjmVu1g@mail.gmail.com>
Subject: Re: [PATCH 09/11] clk: samsung: exynos850: do not define number of
 clocks in bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 11:15, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Number of clocks supported by Linux drivers might vary - sometimes we
> add new clocks, not exposed previously.  Therefore this number of clocks
> should not be in the bindings, because otherwise we should not change
> it.
>
> Define number of clocks per each clock controller inside the driver
> directly.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/clk/samsung/clk-exynos850.c | 35 ++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos850.c b/drivers/clk/samsung/clk-exynos850.c
> index c32b2e6451a0..bdc1eef7d6e5 100644
> --- a/drivers/clk/samsung/clk-exynos850.c
> +++ b/drivers/clk/samsung/clk-exynos850.c
> @@ -16,6 +16,19 @@
>  #include "clk.h"
>  #include "clk-exynos-arm64.h"
>
> +/* NOTE: Must be equal to the last clock ID increased by one */
> +#define CLKS_NR_TOP                    (CLK_DOUT_G3D_SWITCH + 1)
> +#define CLKS_NR_APM                    (CLK_GOUT_SYSREG_APM_PCLK + 1)
> +#define CLKS_NR_AUD                    (CLK_GOUT_AUD_CMU_AUD_PCLK + 1)
> +#define CLKS_NR_CMGP                   (CLK_GOUT_SYSREG_CMGP_PCLK + 1)
> +#define CLKS_NR_G3D                    (CLK_GOUT_G3D_SYSREG_PCLK + 1)
> +#define CLKS_NR_HSI                    (CLK_GOUT_HSI_CMU_HSI_PCLK + 1)
> +#define CLKS_NR_IS                     (CLK_GOUT_IS_SYSREG_PCLK + 1)
> +#define CLKS_NR_MFCMSCL                        (CLK_GOUT_MFCMSCL_SYSREG_PCLK + 1)
> +#define CLKS_NR_PERI                   (CLK_GOUT_WDT1_PCLK + 1)
> +#define CLKS_NR_CORE                   (CLK_GOUT_SYSREG_CORE_PCLK + 1)
> +#define CLKS_NR_DPU                    (CLK_GOUT_DPU_SYSREG_PCLK + 1)
> +
>  /* ---- CMU_TOP ------------------------------------------------------------- */
>
>  /* Register Offset definitions for CMU_TOP (0x120e0000) */
> @@ -485,7 +498,7 @@ static const struct samsung_cmu_info top_cmu_info __initconst = {
>         .nr_div_clks            = ARRAY_SIZE(top_div_clks),
>         .gate_clks              = top_gate_clks,
>         .nr_gate_clks           = ARRAY_SIZE(top_gate_clks),
> -       .nr_clk_ids             = TOP_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_TOP,
>         .clk_regs               = top_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(top_clk_regs),
>  };
> @@ -625,7 +638,7 @@ static const struct samsung_cmu_info apm_cmu_info __initconst = {
>         .nr_gate_clks           = ARRAY_SIZE(apm_gate_clks),
>         .fixed_clks             = apm_fixed_clks,
>         .nr_fixed_clks          = ARRAY_SIZE(apm_fixed_clks),
> -       .nr_clk_ids             = APM_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_APM,
>         .clk_regs               = apm_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(apm_clk_regs),
>         .clk_name               = "dout_clkcmu_apm_bus",
> @@ -908,7 +921,7 @@ static const struct samsung_cmu_info aud_cmu_info __initconst = {
>         .nr_gate_clks           = ARRAY_SIZE(aud_gate_clks),
>         .fixed_clks             = aud_fixed_clks,
>         .nr_fixed_clks          = ARRAY_SIZE(aud_fixed_clks),
> -       .nr_clk_ids             = AUD_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_AUD,
>         .clk_regs               = aud_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(aud_clk_regs),
>         .clk_name               = "dout_aud",
> @@ -1011,7 +1024,7 @@ static const struct samsung_cmu_info cmgp_cmu_info __initconst = {
>         .nr_gate_clks           = ARRAY_SIZE(cmgp_gate_clks),
>         .fixed_clks             = cmgp_fixed_clks,
>         .nr_fixed_clks          = ARRAY_SIZE(cmgp_fixed_clks),
> -       .nr_clk_ids             = CMGP_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_CMGP,
>         .clk_regs               = cmgp_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(cmgp_clk_regs),
>         .clk_name               = "gout_clkcmu_cmgp_bus",
> @@ -1107,7 +1120,7 @@ static const struct samsung_cmu_info g3d_cmu_info __initconst = {
>         .nr_div_clks            = ARRAY_SIZE(g3d_div_clks),
>         .gate_clks              = g3d_gate_clks,
>         .nr_gate_clks           = ARRAY_SIZE(g3d_gate_clks),
> -       .nr_clk_ids             = G3D_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_G3D,
>         .clk_regs               = g3d_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(g3d_clk_regs),
>         .clk_name               = "dout_g3d_switch",
> @@ -1209,7 +1222,7 @@ static const struct samsung_cmu_info hsi_cmu_info __initconst = {
>         .nr_mux_clks            = ARRAY_SIZE(hsi_mux_clks),
>         .gate_clks              = hsi_gate_clks,
>         .nr_gate_clks           = ARRAY_SIZE(hsi_gate_clks),
> -       .nr_clk_ids             = HSI_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_HSI,
>         .clk_regs               = hsi_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(hsi_clk_regs),
>         .clk_name               = "dout_hsi_bus",
> @@ -1341,7 +1354,7 @@ static const struct samsung_cmu_info is_cmu_info __initconst = {
>         .nr_div_clks            = ARRAY_SIZE(is_div_clks),
>         .gate_clks              = is_gate_clks,
>         .nr_gate_clks           = ARRAY_SIZE(is_gate_clks),
> -       .nr_clk_ids             = IS_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_IS,
>         .clk_regs               = is_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(is_clk_regs),
>         .clk_name               = "dout_is_bus",
> @@ -1450,7 +1463,7 @@ static const struct samsung_cmu_info mfcmscl_cmu_info __initconst = {
>         .nr_div_clks            = ARRAY_SIZE(mfcmscl_div_clks),
>         .gate_clks              = mfcmscl_gate_clks,
>         .nr_gate_clks           = ARRAY_SIZE(mfcmscl_gate_clks),
> -       .nr_clk_ids             = MFCMSCL_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_MFCMSCL,
>         .clk_regs               = mfcmscl_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(mfcmscl_clk_regs),
>         .clk_name               = "dout_mfcmscl_mfc",
> @@ -1625,7 +1638,7 @@ static const struct samsung_cmu_info peri_cmu_info __initconst = {
>         .nr_div_clks            = ARRAY_SIZE(peri_div_clks),
>         .gate_clks              = peri_gate_clks,
>         .nr_gate_clks           = ARRAY_SIZE(peri_gate_clks),
> -       .nr_clk_ids             = PERI_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_PERI,
>         .clk_regs               = peri_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(peri_clk_regs),
>         .clk_name               = "dout_peri_bus",
> @@ -1732,7 +1745,7 @@ static const struct samsung_cmu_info core_cmu_info __initconst = {
>         .nr_div_clks            = ARRAY_SIZE(core_div_clks),
>         .gate_clks              = core_gate_clks,
>         .nr_gate_clks           = ARRAY_SIZE(core_gate_clks),
> -       .nr_clk_ids             = CORE_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_CORE,
>         .clk_regs               = core_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(core_clk_regs),
>         .clk_name               = "dout_core_bus",
> @@ -1806,7 +1819,7 @@ static const struct samsung_cmu_info dpu_cmu_info __initconst = {
>         .nr_div_clks            = ARRAY_SIZE(dpu_div_clks),
>         .gate_clks              = dpu_gate_clks,
>         .nr_gate_clks           = ARRAY_SIZE(dpu_gate_clks),
> -       .nr_clk_ids             = DPU_NR_CLK,
> +       .nr_clk_ids             = CLKS_NR_DPU,
>         .clk_regs               = dpu_clk_regs,
>         .nr_clk_regs            = ARRAY_SIZE(dpu_clk_regs),
>         .clk_name               = "dout_dpu",
> --
> 2.34.1
>
