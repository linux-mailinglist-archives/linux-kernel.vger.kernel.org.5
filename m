Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21B07CFADA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbjJSNWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjJSNWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:22:09 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026BD130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:22:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a87ac9d245so55135977b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697721726; x=1698326526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LK/A8QLl6mmZsiIVExfW0sdngxXHRyvJR8+2rskOKXw=;
        b=y2EbQdSuBPfoN7iHvMzb7Eehk+7o1FyEgcUZGm3n4YjsSBbqvyuGTQjwulKDSIst3g
         VEufAFVA4Oq+ACDcflmvrFUc7RGdRAwXl1/Qmc7c26S1YDHznIt+9A542K42kRAycz97
         JNoOJ9TkP5bh4kEhvcnO6rqA3E268DPOgmqpoRTnY6NyljsweBQGOmmsrKwEmy3K+pua
         seGiEfihIEHmrZtNqJHNzNPymzbFmWd15AnOUOgY+dpr2lSpgqFIBZiY+6154Rz+MhDv
         0Qre5tLtGJU3DnXWJBTtSYk0n1GTsk9A70udMS8XSiAvx55Sz7bN7f7dt+ZGb9HPxv6l
         ibig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721726; x=1698326526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LK/A8QLl6mmZsiIVExfW0sdngxXHRyvJR8+2rskOKXw=;
        b=YrPx7OqZIbHTh2Xk/AmgMNr6ibbyNgKyn9s6lW89KGOJDp5yNgN9H+L/247JBNSXn0
         JPuOhSAETQLZmMVcPJfdFtOhshNR0W8gt3POwpq6UViJChh7YJ3Ejxwj5W6ZgDQz4PHY
         d7Q2/MwMDaXBktNw6dWFL0PNSY255MThfj3z3vqbK9JAvSOAqZNAqtoGonuTle2Aj2Lh
         TjwC9EEYvlsSGfEgdt5ufPRoWBk0In8H823GSAXh/NvrMJCLtNnAMKKy/TeztN+nUE5F
         hJ13Inxte4sFKm4r/+lSwd8lz2gEBxk6i2D8Ne/hXpxdCsLivGk5mwlMJJvsPiN5XzsS
         1cnw==
X-Gm-Message-State: AOJu0YxU9p64oFpyetzgD7mGaM3OQPq0FivUzKGtet+d6BMQdhzlYokf
        aHuk9MSw+BzGrGXBs1FUfkBpFPQFIfVO0bR5A/z18w==
X-Google-Smtp-Source: AGHT+IGO7zgweMP4Ggy580FnIWlG2Q2goG3FWkhovjhI5E63Yz0JUSyXj4xiRJEQZJSqvTzyffCd0vqYP5Uz4i/JMOA=
X-Received: by 2002:a0d:d8cc:0:b0:5a7:afc9:3579 with SMTP id
 a195-20020a0dd8cc000000b005a7afc93579mr2270939ywe.18.1697721726120; Thu, 19
 Oct 2023 06:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697694811.git.quic_varada@quicinc.com> <9ebae0e9780745091274562a2b9afd856241dbdc.1697694811.git.quic_varada@quicinc.com>
In-Reply-To: <9ebae0e9780745091274562a2b9afd856241dbdc.1697694811.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 Oct 2023 16:21:55 +0300
Message-ID: <CAA8EJpo3-dZmYZ40FCGBBHRAHPmSAYJLPuwdGy8eY9-NwDYMhA@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] clk: qcom: apss-ipq6018: ipq5332: add safe source
 switch for a53pll
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, ilia.lin@kernel.org,
        sivaprak@codeaurora.org, quic_kathirav@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 11:42, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Stromer Plus PLL found on IPQ53xx doesn't support dynamic
> frequency scaling. To achieve the same, we need to park the APPS
> PLL source to GPLL0, re configure the PLL and then switch the
> source to APSS_PLL_EARLY.
>
> To support this, register a clock notifier to get the PRE_RATE
> and POST_RATE notification. Change the APSS PLL source to GPLL0
> when PRE_RATE notification is received, then configure the PLL
> and then change back the source to APSS_PLL_EARLY.
>
> Additionally, not all SKUs of IPQ53xx support scaling. Hence,
> do the above to the SKUs that support scaling.
>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3:     devm_kzalloc for cpu_clk_notifier instead of global static
> v2:     Handle ABORT_RATE_CHANGE
>         Use local variable for apcs_alias0_clk_src.clkr.hw
>         Use single line comment instead of multi line style
> ---
>  drivers/clk/qcom/apss-ipq6018.c | 58 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> index 4e13a08..db65b0d 100644
> --- a/drivers/clk/qcom/apss-ipq6018.c
> +++ b/drivers/clk/qcom/apss-ipq6018.c
> @@ -9,8 +9,11 @@
>  #include <linux/clk-provider.h>
>  #include <linux/regmap.h>
>  #include <linux/module.h>
> +#include <linux/clk.h>
> +#include <linux/soc/qcom/smem.h>
>
>  #include <dt-bindings/clock/qcom,apss-ipq.h>
> +#include <dt-bindings/arm/qcom,ids.h>
>
>  #include "common.h"
>  #include "clk-regmap.h"
> @@ -84,15 +87,68 @@ static const struct qcom_cc_desc apss_ipq6018_desc = {
>         .num_clks = ARRAY_SIZE(apss_ipq6018_clks),
>  };
>
> +static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
> +                               void *data)
> +{
> +       struct clk_hw *hw;
> +       u8 index;
> +       int err;
> +
> +       if (action == PRE_RATE_CHANGE)
> +               index = P_GPLL0;
> +       else if (action == POST_RATE_CHANGE || action == ABORT_RATE_CHANGE)
> +               index = P_APSS_PLL_EARLY;
> +       else
> +               return NOTIFY_OK;
> +
> +       hw = &apcs_alias0_clk_src.clkr.hw;
> +       err = clk_rcg2_mux_closest_ops.set_parent(hw, index);
> +
> +       return notifier_from_errno(err);
> +}
> +
>  static int apss_ipq6018_probe(struct platform_device *pdev)
>  {
> +       struct notifier_block *cpu_clk_notifier;
>         struct regmap *regmap;
> +       u32 soc_id;
> +       int ret;
> +
> +       ret = qcom_smem_get_soc_id(&soc_id);
> +       if (ret)
> +               return ret;
>
>         regmap = dev_get_regmap(pdev->dev.parent, NULL);
>         if (!regmap)
>                 return -ENODEV;
>
> -       return qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> +       ret = qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> +       if (ret)
> +               return ret;
> +
> +       switch (soc_id) {
> +       /* Only below variants of IPQ53xx support scaling */
> +       case QCOM_ID_IPQ5332:
> +       case QCOM_ID_IPQ5322:
> +       case QCOM_ID_IPQ5300:
> +               cpu_clk_notifier = devm_kzalloc(&pdev->dev,
> +                                               sizeof(*cpu_clk_notifier),
> +                                               GFP_KERNEL);
> +               if (!cpu_clk_notifier)
> +                       return -ENOMEM;
> +
> +               cpu_clk_notifier->notifier_call = cpu_clk_notifier_fn;
> +
> +               ret = clk_notifier_register(apcs_alias0_clk_src.clkr.hw.clk,
> +                                           cpu_clk_notifier);

devm_clk_notifier_register sounds more future-proof.

Other than that:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +               if (ret)
> +                       return ret;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
>  }
>
>  static struct platform_driver apss_ipq6018_driver = {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
