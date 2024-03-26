Return-Path: <linux-kernel+bounces-118987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587DC88C24E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1CC1C3217C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD496EB5F;
	Tue, 26 Mar 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LJSKatIt"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F450A98
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456655; cv=none; b=uoC3MdARkLaYtKm5DGfyPBAMT0/dwBZ/P6OVm86VyUeTEMxFvmky9Ld0eVFHxQlypI7jnisrE2slmVTUF8gAaM3CPi+CIZwBKxo1Zpuah9xv3zJ+yHFfxsM+2Uj6Atmamu6vzOC+4T+jJ4uj1C/ox0KzeGYIZBkVDBNsHKfDObQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456655; c=relaxed/simple;
	bh=aZna8YAluKUCCQIMbM5gnPGbSv5NGDwb7irWEMgmhI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUpALdOkyq1RseDPLp+eLD5gGGPNugm7qhhuPoJ5Ctn9Bfndmvx1oC/vbCbfcTlBeotw3W5wI1GALPq6OfUBO0nugFuvKYWIS5uarEO1J8FoCw34fF4j0YJPvpbehNRCHUrS6omTm1nrFTtiE0f5cLwUna963dEe1cA5jEsuPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LJSKatIt; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc236729a2bso5276196276.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711456651; x=1712061451; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx8c0fzZpQ3t1HiVdbx5VhvTuw+jHpnajVV7Jh7hCH4=;
        b=LJSKatItsQLN7YHPDFGJhhXI4gqLbCrrqu/mQtzkGHkl8Pjq+mzJqp1D287Dk6dynA
         oV/eKFXS4ZR77jirL1MPV51dYZiNXUwQg7VTvcSHoucYzX1tAY1Z90CiAtuLHTWJ3WQk
         sOKEzWaqCpQs9s26D2IydBh84bWjorqarZ7W6UflUbpe3Rb33xcIPqrDPjA/OLXto3jc
         jZR5y22T2T8YoYikUWX9L58NERBZBI9MSREOEuN12sqHgoTw3VQi1wlU1HldL7w+U5bl
         5WqktPfgOHYglRao42BJ1sVlKi0N/ELBoSES7qE90/wUO4XCl2z/k27Q+DsyrJe3Rgsu
         Rw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711456651; x=1712061451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dx8c0fzZpQ3t1HiVdbx5VhvTuw+jHpnajVV7Jh7hCH4=;
        b=i0azIUIVGfZuFyGtBxNGCNoZikVs2NJMT0KkE+i5YhFak82wWO3XgVLzj5Kwzw6YVA
         6sUyZVoTRziqErK74xemHA+d8XeXhQ1mW9hj8rb7sQeX5Y/wTkdX/XnvBSiUkveppr4B
         C6RjNjP8FBbIb5c0qbI1uGfMFXMyy/rJAyI1oQiH1H/7MSjMecYRGHbjbEJ9myTIdBpL
         dH2xHA9JXhBrnPuOrNaEn1JhfP4E8eaIm67pXLaeH8RchaqIikqBXRRkDTtZ2nE0L1qy
         Ceb4wP4MxUu5SITcFHIdoogBwMHh5KwJQUVzQk3sSEUPOJ06lotsY1UXoGlmMAbESYE4
         LkNA==
X-Forwarded-Encrypted: i=1; AJvYcCWjELCdBYcdwRj4FYja1ZvpSepvuP23UbkrXVF7PNJ4QVi+vz5Ltly1dZKPwORFr6qZ4H3GJlkqB3o2IwrtUiU+7tFxgFqZtSshT39b
X-Gm-Message-State: AOJu0Yw9t8AGDSoywfQwx1OG6csqdjqRFPzoy3sR6FKh+r1G0RCCOJQT
	jaLHk0EMQCcN8OzjWwCLAzmocsAQdI/4rNdUeX964q5Y8Jk1CwS+fZaiNYkYATGJFW7yVu3mCrf
	SHVkN8+FJzbz6dGTn7ke6wqJ0rCMh2/FU96nkAGb3eGrDULKUiBc=
X-Google-Smtp-Source: AGHT+IHpG7/sHyh3c2zBPRtS76P8iuvz7AvVhRoJ/V1dq27C+XzkkwfvynwUMJxq+rlJ+gQeMJqbdkJYeim6vTxWmQk=
X-Received: by 2002:a25:361c:0:b0:dda:a7a9:7b59 with SMTP id
 d28-20020a25361c000000b00ddaa7a97b59mr906996yba.50.1711456651465; Tue, 26 Mar
 2024 05:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326121312.1702701-1-quic_varada@quicinc.com> <20240326121312.1702701-3-quic_varada@quicinc.com>
In-Reply-To: <20240326121312.1702701-3-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 14:37:20 +0200
Message-ID: <CAA8EJpq5ng2K_Y481FbsjSXCaGM5_2+xkwWqFzfzXv2ZOBpMgw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clk: qcom: add IPQ9574 interconnect clocks support
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 14:14, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Unlike MSM platforms that manage NoC related clocks and scaling
> from RPM, IPQ SoCs dont involve RPM in managing NoC related
> clocks and there is no NoC scaling.
>
> However, there is a requirement to enable some NoC interface
> clocks for accessing the peripheral controllers present on
> these NoCs. Though exposing these as normal clocks would work,
> having a minimalistic interconnect driver to handle these clocks
> would make it consistent with other Qualcomm platforms resulting
> in common code paths. This is similar to msm8996-cbf's usage of
> icc-clk framework.
>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Use indexed identifiers here to avoid confusion
>     Fix error messages and move to common.c
> v2: Move DTS to separate patch
>     Update commit log
>     Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
> ---
>  drivers/clk/qcom/Kconfig       |  2 ++
>  drivers/clk/qcom/common.c      | 30 ++++++++++++++++
>  drivers/clk/qcom/common.h      |  2 ++
>  drivers/clk/qcom/gcc-ipq9574.c | 64 +++++++++++++++++++++++++++++++++-
>  4 files changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 8ab08e7b5b6c..af73a0b396eb 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -243,6 +243,8 @@ config IPQ_GCC_8074
>
>  config IPQ_GCC_9574
>         tristate "IPQ9574 Global Clock Controller"
> +       select INTERCONNECT
> +       select INTERCONNECT_CLK
>         help
>           Support for global clock controller on ipq9574 devices.
>           Say Y if you want to use peripheral devices such as UART, SPI,
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 75f09e6e057e..b18d38509de5 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -8,6 +8,8 @@
>  #include <linux/regmap.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk-provider.h>
> +#include <linux/interconnect-clk.h>
> +#include <linux/interconnect-provider.h>
>  #include <linux/reset-controller.h>
>  #include <linux/of.h>
>
> @@ -337,4 +339,32 @@ int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
>  }
>  EXPORT_SYMBOL_GPL(qcom_cc_probe_by_index);
>
> +int qcom_cc_icc_register(struct device *dev, struct clk_regmap *clks[],
> +                        int *noc_clks, int count, unsigned int first_id)
> +{
> +       struct icc_provider *provider;
> +       struct icc_clk_data *icd;
> +       int i;
> +
> +       icd = devm_kcalloc(dev, count, sizeof(*icd), GFP_KERNEL);
> +       if (IS_ERR_OR_NULL(icd))

Can devm_kcalloc return ERR?

> +               return dev_err_probe(dev, PTR_ERR(icd),
> +                                    "malloc for clock data failed\n");

So, this becomes dev_err_prove(dev, 0, "..."). returning 0. Not the
expected result for the error case.

> +
> +       for (i = 0; i < count; i++) {
> +               icd[i].clk = clks[noc_clks[i]]->hw.clk;
> +               if (IS_ERR_OR_NULL(icd[i].clk))
> +                       return dev_err_probe(dev, -ENOENT,
> +                                            "%d clock not found\n", noc_clks[i]);

This is even better. Potential NULL pointer exception, then useless
ERR_OR_NULL  and finally API abuse.
Please use clk_hw_get_clk(), it is there for you.

> +               icd[i].name = clk_hw_get_name(&clks[noc_clks[i]]->hw);
> +       }
> +
> +       provider = icc_clk_register(dev, first_id, count, icd);
> +       if (IS_ERR_OR_NULL(provider))
> +               return dev_err_probe(dev, PTR_ERR(provider),
> +                                    "icc_clk_register failed\n");
> +
> +       return 0;
> +}
> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..4fce5e229fc1 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -65,5 +65,7 @@ extern int qcom_cc_probe(struct platform_device *pdev,
>                          const struct qcom_cc_desc *desc);
>  extern int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
>                                   const struct qcom_cc_desc *desc);
> +int qcom_cc_icc_register(struct device *dev, struct clk_regmap *clks[],
> +                        int *noc_clks, int count, unsigned int first_id);

Add this function to the qcom_cc_probe() call stream. Change it to
pass an array of clk_hw instead of passing indices.

>
>  #endif
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> index 0a3f846695b8..c63c44b6740f 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -12,6 +12,7 @@
>
>  #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/interconnect/qcom,ipq9574.h>
>
>  #include "clk-alpha-pll.h"
>  #include "clk-branch.h"
> @@ -4301,6 +4302,56 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
>         [GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
>  };
>
> +#define IPQ_APPS_ID                    9574    /* some unique value */
> +
> +enum {
> +       ICC_ANOC_PCIE0,
> +       ICC_SNOC_PCIE0,
> +       ICC_ANOC_PCIE1,
> +       ICC_SNOC_PCIE1,
> +       ICC_ANOC_PCIE2,
> +       ICC_SNOC_PCIE2,
> +       ICC_ANOC_PCIE3,
> +       ICC_SNOC_PCIE3,
> +       ICC_SNOC_USB,
> +       ICC_ANOC_USB_AXI,
> +       ICC_NSSNOC_NSSCC,
> +       ICC_NSSNOC_SNOC_0,
> +       ICC_NSSNOC_SNOC_1,
> +       ICC_NSSNOC_PCNOC_1,
> +       ICC_NSSNOC_QOSGEN_REF,
> +       ICC_NSSNOC_TIMEOUT_REF,
> +       ICC_NSSNOC_XO_DCD,
> +       ICC_NSSNOC_ATB,
> +       ICC_MEM_NOC_NSSNOC,
> +       ICC_NSSNOC_MEMNOC,
> +       ICC_NSSNOC_MEM_NOC_1,
> +};
> +
> +static int noc_clks[] = {
> +       [ICC_ANOC_PCIE0] = GCC_ANOC_PCIE0_1LANE_M_CLK,
> +       [ICC_SNOC_PCIE0] = GCC_SNOC_PCIE0_1LANE_S_CLK,
> +       [ICC_ANOC_PCIE1] = GCC_ANOC_PCIE1_1LANE_M_CLK,
> +       [ICC_SNOC_PCIE1] = GCC_SNOC_PCIE1_1LANE_S_CLK,
> +       [ICC_ANOC_PCIE2] = GCC_ANOC_PCIE2_2LANE_M_CLK,
> +       [ICC_SNOC_PCIE2] = GCC_SNOC_PCIE2_2LANE_S_CLK,
> +       [ICC_ANOC_PCIE3] = GCC_ANOC_PCIE3_2LANE_M_CLK,
> +       [ICC_SNOC_PCIE3] = GCC_SNOC_PCIE3_2LANE_S_CLK,
> +       [ICC_SNOC_USB] = GCC_SNOC_USB_CLK,
> +       [ICC_ANOC_USB_AXI] = GCC_ANOC_USB_AXI_CLK,
> +       [ICC_NSSNOC_NSSCC] = GCC_NSSNOC_NSSCC_CLK,
> +       [ICC_NSSNOC_SNOC_0] = GCC_NSSNOC_SNOC_CLK,
> +       [ICC_NSSNOC_SNOC_1] = GCC_NSSNOC_SNOC_1_CLK,
> +       [ICC_NSSNOC_PCNOC_1] = GCC_NSSNOC_PCNOC_1_CLK,
> +       [ICC_NSSNOC_QOSGEN_REF] = GCC_NSSNOC_QOSGEN_REF_CLK,
> +       [ICC_NSSNOC_TIMEOUT_REF] = GCC_NSSNOC_TIMEOUT_REF_CLK,
> +       [ICC_NSSNOC_XO_DCD] = GCC_NSSNOC_XO_DCD_CLK,
> +       [ICC_NSSNOC_ATB] = GCC_NSSNOC_ATB_CLK,
> +       [ICC_MEM_NOC_NSSNOC] = GCC_MEM_NOC_NSSNOC_CLK,
> +       [ICC_NSSNOC_MEMNOC] = GCC_NSSNOC_MEMNOC_CLK,
> +       [ICC_NSSNOC_MEM_NOC_1] = GCC_NSSNOC_MEM_NOC_1_CLK,
> +};
> +
>  static const struct of_device_id gcc_ipq9574_match_table[] = {
>         { .compatible = "qcom,ipq9574-gcc" },
>         { }
> @@ -4327,7 +4378,18 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
>
>  static int gcc_ipq9574_probe(struct platform_device *pdev)
>  {
> -       return qcom_cc_probe(pdev, &gcc_ipq9574_desc);
> +       int ret;
> +
> +       ret = qcom_cc_probe(pdev, &gcc_ipq9574_desc);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "clock probe failed\n");
> +
> +       ret = qcom_cc_icc_register(&pdev->dev, gcc_ipq9574_clks, noc_clks,
> +                                  ARRAY_SIZE(noc_clks), IPQ_APPS_ID);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret, "interconnect register failed\n");

So, even if we had a useful message from the called function, it has
become overridden with the useless "failed" message. Please don't do
that.

> +
> +       return 0;
>  }
>
>  static struct platform_driver gcc_ipq9574_driver = {
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry

