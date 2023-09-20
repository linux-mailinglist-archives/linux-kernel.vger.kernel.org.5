Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4167A75B0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjITIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjITIUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:20:21 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDDCB6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:20:13 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-58dce1f42d6so9257987b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695198012; x=1695802812; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rd1vfihH1DTA20PRSXni2dKqqMHS0l7SxUyqhGyajpg=;
        b=mJn5r2H5cH5fKZQo5zdD+UzEVnOJnD66VFFIkmJ87Tr4w5qOSiu4ipm1FP32FsgaeF
         X84UdGHKD2iYm2r4Q8uqmBF1z181IDO+/hwi/sGYxSpRS2lCuZpN6vujslzX84nvKhXQ
         k4zliaDSz+i/J8PxQQGrGNAl6S4vSFNFPfT/L8BBhiEaucLbqEkFYONru85ioNEyKWNf
         iOJ7+QWSi6aKYLm6NDDvxCt6W5saRjVr8JKkNVnC5MGS2NBtI2ZpCTGZcs8+0V4lbmrc
         aXQHy990rpOWzZNLO28i6DKmu4AXHnhT1E/usClyqH+oUOETLKoF3+EBKitHazs76CKH
         E+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695198012; x=1695802812;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rd1vfihH1DTA20PRSXni2dKqqMHS0l7SxUyqhGyajpg=;
        b=FmguePI++Z4Y3eJFWvTsdE5dL+P5GJtQH3XaiLGJSSdkHuRw1nzVF/O0frrerlfMFW
         Y73hjPUEozhLrsNUY8ZZjDCQQnctkVSKDJhpuSCfqWYhiiNgEdHEk/Px+EPO/AIvqLC6
         9U8Jko2ei074slhtm3djYCyH4bXT/on0wtZrzCHZJbBKtDTmgmIgIjmxX1TjGJ8fNAlf
         Sz3Hi7w9el6hhGhmaFvv7pzpHiKcVchPGTNhmFSz4uqaKIyQDP3uiWUHx9Fck/+Av59T
         QP5YcKCl8wqa+cPrRh4nsYyr8TIZ/bhNWm6ouudTdU3fb5eMlm1T/pdKT5LINWvm5Av+
         5yHg==
X-Gm-Message-State: AOJu0YzRHdFwZ6LJ0NtlDGpeUjD2FsG1P7H6kHWBUp2a0AZsahxJV9FO
        D9ok4w9XFLBegqBqy3s3rZ5QtereYdJt+sSO8CHAuA==
X-Google-Smtp-Source: AGHT+IGfmrGo4G3DTdyOkABLKwqDl9NgzXhZOdiDL1ZkwucxMuuRNdJbVWlctMVghZQyXXFi9n40Onp901sMEuaQCM4=
X-Received: by 2002:a0d:d60b:0:b0:58c:5598:be97 with SMTP id
 y11-20020a0dd60b000000b0058c5598be97mr2269069ywd.15.1695198012199; Wed, 20
 Sep 2023 01:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-6-quic_devipriy@quicinc.com> <CAA8EJpr+Wwgot-PDRtj-LVi79aD13B9WVREmjTXiR-8XEEx-rQ@mail.gmail.com>
 <652b55cc-87dd-46d1-e480-e25f5f22b8d8@quicinc.com> <a4c9baae-f328-22b5-48d7-fc7df0b62a79@quicinc.com>
In-Reply-To: <a4c9baae-f328-22b5-48d7-fc7df0b62a79@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 20 Sep 2023 11:20:01 +0300
Message-ID: <CAA8EJpq0uawrOBHA8XHygEpGYF--HyxJWxKG44iiFdAZZz7O2w@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] clk: qcom: Add NSS clock Controller driver for IPQ9574
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        richardcochran@gmail.com, arnd@arndb.de, geert+renesas@glider.be,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        quic_saahtoma@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 09:39, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
>
>
> On 9/12/2023 7:38 PM, Devi Priya wrote:
> >
> >
> > On 8/25/2023 5:14 PM, Dmitry Baryshkov wrote:
> >> On Fri, 25 Aug 2023 at 12:15, Devi Priya <quic_devipriy@quicinc.com>
> >> wrote:
> >>>
> >>> Add Networking Sub System Clock Controller(NSSCC) driver for ipq9574
> >>> based
> >>> devices.
> >>>
> >>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >>> ---
> >>>   Changes in V2:
> >>>          - Added depends on ARM64 || COMPILE_TEST in Kconfig
> >>>          - Added module_platform_driver
> >>>          - Dropped patch [2/6] - clk: qcom: gcc-ipq9574: Mark nssnoc
> >>> clocks as critical
> >>>             & added pm_clk for nssnoc clocks
> >>>          - Updated the uniphy clock names
> >>>
> >>>   drivers/clk/qcom/Kconfig         |    7 +
> >>>   drivers/clk/qcom/Makefile        |    1 +
> >>>   drivers/clk/qcom/nsscc-ipq9574.c | 3109 ++++++++++++++++++++++++++++++
> >>>   3 files changed, 3117 insertions(+)
> >>>   create mode 100644 drivers/clk/qcom/nsscc-ipq9574.c
> >>>
> >>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> >>> index bd9bfb11b328..3ecc11e2c8e3 100644
> >>> --- a/drivers/clk/qcom/Kconfig
> >>> +++ b/drivers/clk/qcom/Kconfig
> >>> @@ -203,6 +203,13 @@ config IPQ_GCC_9574
> >>>            i2c, USB, SD/eMMC, etc. Select this for the root clock
> >>>            of ipq9574.
> >>>
> >>> +config IPQ_NSSCC_9574
> >>> +       tristate "IPQ9574 NSS Clock Controller"
> >>> +       depends on ARM64 || COMPILE_TEST
> >>> +       depends on IPQ_GCC_9574
> >>> +       help
> >>> +         Support for NSS clock controller on ipq9574 devices.
> >>> +
> >>>   config MSM_GCC_8660
> >>>          tristate "MSM8660 Global Clock Controller"
> >>>          depends on ARM || COMPILE_TEST
> >>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> >>> index 4790c8cca426..3f084928962e 100644
> >>> --- a/drivers/clk/qcom/Makefile
> >>> +++ b/drivers/clk/qcom/Makefile
> >>> @@ -30,6 +30,7 @@ obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
> >>>   obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
> >>>   obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
> >>>   obj-$(CONFIG_IPQ_GCC_9574) += gcc-ipq9574.o
> >>> +obj-$(CONFIG_IPQ_NSSCC_9574)   += nsscc-ipq9574.o
> >>>   obj-$(CONFIG_IPQ_LCC_806X) += lcc-ipq806x.o
> >>>   obj-$(CONFIG_MDM_GCC_9607) += gcc-mdm9607.o
> >>>   obj-$(CONFIG_MDM_GCC_9615) += gcc-mdm9615.o
> >>> diff --git a/drivers/clk/qcom/nsscc-ipq9574.c
> >>> b/drivers/clk/qcom/nsscc-ipq9574.c
> >>> new file mode 100644
> >>> index 000000000000..65bdb449ae5f
> >>> --- /dev/null
> >>> +++ b/drivers/clk/qcom/nsscc-ipq9574.c
> >>> @@ -0,0 +1,3109 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +/*
> >>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> >>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights
> >>> reserved.
> >>> + */
> >>> +
> >>> +#include <linux/clk-provider.h>
> >>> +#include <linux/err.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/of_device.h>
> >>> +#include <linux/regmap.h>
> >>> +#include <linux/pm_clock.h>
> >>> +#include <linux/pm_runtime.h>
> >>> +
> >>> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
> >>> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
> >>> +
> >>> +#include "clk-alpha-pll.h"
> >>> +#include "clk-branch.h"
> >>> +#include "clk-pll.h"
> >>> +#include "clk-rcg.h"
> >>> +#include "clk-regmap.h"
> >>> +#include "clk-regmap-divider.h"
> >>> +#include "clk-regmap-mux.h"
> >>> +#include "common.h"
> >>> +#include "reset.h"
> >>> +
> >>> +/* Need to match the order of clocks in DT binding */
> >>> +enum {
> >>> +       DT_NSSNOC_NSSCC_CLK,
> >>> +       DT_NSSNOC_SNOC_CLK,
> >>> +       DT_NSSNOC_SNOC_1_CLK,
> >>
> >> Not using the index makes it seem that these clocks are not used,
> >> until one scrolls down to pm_clks.
> > Okay, got it
> >>
> >> BTW: The NSSNOC_SNOC clocks make it look like there is an interconnect
> >> here (not a simple NIU).
> >
> > Hi Dmitry, We are exploring on the ICC driver. In the meantime to
> > unblock PCIe/NSS changes getting merged, shall we use regmap_update_bits
> > and turn on the critical NSSNOC clocks, ANOC & SNOC pcie clocks in the
> > probe function of the gcc driver itself as like sm8550 driver to get the
> > changes merged?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/qcom/gcc-sm8550.c#n3347
>
> Hi Dmitry,
> Just curious to know if we could send out the next series with the
> proposed approach if that holds good.

The answer really depends on the structure of your hardware. The issue
is that once you commit the device bindings,you have to support them
forever. So, if you commit the NSS clock support without interconnects
in place, you have to keep this ANOC/SNOC/etc code forever, even after
you land the interconnect. So I'd suggest landing the icc driver first
(or at least implementing and sending to the mailing list), so that we
can see how all these pieces fit together.

> Thanks,
> Devi Priya
>
> >>
> >>> +       DT_BIAS_PLL_CC_CLK,
> >>> +       DT_BIAS_PLL_NSS_NOC_CLK,
> >>> +       DT_BIAS_PLL_UBI_NC_CLK,
> >>> +       DT_GCC_GPLL0_OUT_AUX,
> >>> +       DT_UNIPHY0_NSS_RX_CLK,
> >>> +       DT_UNIPHY0_NSS_TX_CLK,
> >>> +       DT_UNIPHY1_NSS_RX_CLK,
> >>> +       DT_UNIPHY1_NSS_TX_CLK,
> >>> +       DT_UNIPHY2_NSS_RX_CLK,
> >>> +       DT_UNIPHY2_NSS_TX_CLK,
> >>> +       DT_XO,
> >>
> >> As I wrote, please move DT_XO closer to the beginning of the list.
> >>
> >>> +};
> >>> +
> >>> +enum {
> >>> +       P_BIAS_PLL_CC_CLK,
> >>> +       P_BIAS_PLL_NSS_NOC_CLK,
> >>> +       P_BIAS_PLL_UBI_NC_CLK,
> >>> +       P_GCC_GPLL0_OUT_AUX,
> >>> +       P_UBI32_PLL_OUT_MAIN,
> >>> +       P_UNIPHY0_NSS_RX_CLK,
> >>> +       P_UNIPHY0_NSS_TX_CLK,
> >>> +       P_UNIPHY1_NSS_RX_CLK,
> >>> +       P_UNIPHY1_NSS_TX_CLK,
> >>> +       P_UNIPHY2_NSS_RX_CLK,
> >>> +       P_UNIPHY2_NSS_TX_CLK,
> >>> +       P_XO,
> >>> +};
> >>> +
> >>> +static const struct alpha_pll_config ubi32_pll_config = {
> >>> +       .l = 0x3e,
> >>> +       .alpha = 0x6666,
> >>> +       .config_ctl_val = 0x200d4aa8,
> >>> +       .config_ctl_hi_val = 0x3c,
> >>> +       .main_output_mask = BIT(0),
> >>> +       .aux_output_mask = BIT(1),
> >>> +       .pre_div_val = 0x0,
> >>> +       .pre_div_mask = BIT(12),
> >>> +       .post_div_val = 0x0,
> >>> +       .post_div_mask = GENMASK(9, 8),
> >>> +       .alpha_en_mask = BIT(24),
> >>> +       .test_ctl_val = 0x1c0000c0,
> >>> +       .test_ctl_hi_val = 0x4000,
> >>> +};
> >>> +
> >>> +static struct clk_alpha_pll ubi32_pll_main = {
> >>> +       .offset = 0x28000,
> >>> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA],
> >>> +       .flags = SUPPORTS_DYNAMIC_UPDATE,
> >>> +       .clkr = {
> >>> +               .hw.init = &(const struct clk_init_data) {
> >>> +                       .name = "ubi32_pll_main",
> >>> +                       .parent_data = &(const struct clk_parent_data) {
> >>> +                               .index = DT_XO,
> >>> +                       },
> >>> +                       .num_parents = 1,
> >>> +                       .ops = &clk_alpha_pll_huayra_ops,
> >>> +               },
> >>> +       },
> >>> +};
> >>> +
> >>> +static struct clk_alpha_pll_postdiv ubi32_pll = {
> >>> +       .offset = 0x28000,
> >>> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA],
> >>> +       .width = 2,
> >>> +       .clkr.hw.init = &(const struct clk_init_data) {
> >>> +               .name = "ubi32_pll",
> >>> +               .parent_hws = (const struct clk_hw *[]) {
> >>> +                       &ubi32_pll_main.clkr.hw
> >>> +               },
> >>> +               .num_parents = 1,
> >>> +               .ops = &clk_alpha_pll_postdiv_ro_ops,
> >>> +               .flags = CLK_SET_RATE_PARENT,
> >>> +       },
> >>> +};
> >>> +
> >>
> >> [skipped clock tables, LGTM]
> >>
> >>> +static const struct of_device_id nss_cc_ipq9574_match_table[] = {
> >>> +       { .compatible = "qcom,ipq9574-nsscc" },
> >>> +       { }
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, nss_cc_ipq9574_match_table);
> >>> +
> >>> +static int nss_cc_ipq9574_probe(struct platform_device *pdev)
> >>> +{
> >>> +       struct regmap *regmap;
> >>> +       struct qcom_cc_desc nsscc_ipq9574_desc = nss_cc_ipq9574_desc;
> >>> +
> >>> +       int ret;
> >>> +
> >>> +       ret = devm_pm_runtime_enable(&pdev->dev);
> >>> +       if (ret < 0)
> >>> +               return ret;
> >>> +
> >>> +       ret = devm_pm_clk_create(&pdev->dev);
> >>> +       if (ret < 0)
> >>> +               return ret;
> >>> +
> >>> +       ret = of_pm_clk_add_clk(&pdev->dev, "nssnoc_nsscc");
> >>
> >> As we are switching to DT indices, better add new API that takes index
> >> rather than mixing indices and names.
> > sure okay
> >
> > Thanks,
> > Devi Priya
> >>
> >>> +       if (ret < 0) {
> >>> +               dev_err(&pdev->dev, "Failed to acquire nssnoc_nsscc
> >>> clock\n");
> >>> +               return ret;
> >>> +       }
> >>> +
> >>> +       ret = of_pm_clk_add_clk(&pdev->dev, "nssnoc_snoc");
> >>> +       if (ret < 0) {
> >>> +               dev_err(&pdev->dev, "Failed to acquire nssnoc_snoc
> >>> clock\n");
> >>> +               return ret;
> >>> +       }
> >>> +
> >>> +       ret = of_pm_clk_add_clk(&pdev->dev, "nssnoc_snoc_1");
> >>> +       if (ret < 0) {
> >>> +               dev_err(&pdev->dev, "Failed to acquire nssnoc_snoc_1
> >>> clock\n");
> >>> +               return ret;
> >>> +       }
> >>> +
> >>> +       ret = pm_runtime_get(&pdev->dev);
> >>> +       if (ret)
> >>> +               return ret;
> >>> +
> >>> +       regmap = qcom_cc_map(pdev, &nsscc_ipq9574_desc);
> >>> +       if (IS_ERR(regmap))
> >>> +               return PTR_ERR(regmap);
> >>> +
> >>> +       clk_alpha_pll_configure(&ubi32_pll_main, regmap,
> >>> &ubi32_pll_config);
> >>> +
> >>> +       return qcom_cc_really_probe(pdev, &nsscc_ipq9574_desc, regmap);
> >>> +}
> >>> +
> >>> +static const struct dev_pm_ops nss_cc_pm_ops = {
> >>> +       SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
> >>> +};
> >>> +
> >>> +static struct platform_driver nss_cc_ipq9574_driver = {
> >>> +       .probe = nss_cc_ipq9574_probe,
> >>> +       .driver = {
> >>> +               .name = "qcom,nsscc-ipq9574",
> >>> +               .of_match_table = nss_cc_ipq9574_match_table,
> >>> +               .pm = &nss_cc_pm_ops,
> >>> +       },
> >>> +};
> >>> +
> >>> +module_platform_driver(nss_cc_ipq9574_driver);
> >>> +
> >>> +MODULE_DESCRIPTION("QTI NSS_CC IPQ9574 Driver");
> >>> +MODULE_LICENSE("GPL");
> >>> --
> >>> 2.34.1
> >>>
> >>
> >>



-- 
With best wishes
Dmitry
