Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDE580D2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbjLKQlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345031AbjLKQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:41:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDA391
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:41:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496FEC433D9;
        Mon, 11 Dec 2023 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702312869;
        bh=bKmMULTYsuSllJVEHqdoJyJKTDlPdL6U+d4em8AhrDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e+O2+cyr0Ow0bTjD7aQgSyUuwcPnz+W58M1X/hMZMH6mTPP0KtWQL2Rd0JsTU8DED
         GbQJJUOAkOzHkaEweslmal86k3XFyRlxvZThN01IvBUF796P1U4UiR+voBWdt0udY2
         /cJsxVWcjz69xBji+/Djrbtxpk6yRQB8HrTqQtYHZI5IXlYvMXL7LuKjTY9rT6LsGy
         mT7ofxhtXDDcohS2bLM1d7Hrhj/Vu169eAFUYl1XlEfd35m7F6ZHkeFpEG4nBCg6Fn
         HuPj1JuZ9PhscMgjdD+j0PLqMuSQhLko2mjES3HtHaI46esb7OeUcSTyETlP13Itk2
         8bFyWWb1AwvGw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso5309544e87.0;
        Mon, 11 Dec 2023 08:41:09 -0800 (PST)
X-Gm-Message-State: AOJu0Yxb0jBWxyrAjPn70I6YvEUmzaSvehSFqxFG1sU7vySQZpUM0+BO
        0D6In5W05A+DXYyz9MJ3F0HwQORg8Gk/9BuzHw==
X-Google-Smtp-Source: AGHT+IGHwgxj0Odwen0XypIV0RWrJWS+u+chOgGSSFM27JLjV+387RdpxEQeeD/BVoSoFRX9TErbSIxjTxRsenSuHzE=
X-Received: by 2002:a05:6512:4804:b0:50b:f80d:a330 with SMTP id
 eo4-20020a056512480400b0050bf80da330mr1621928lfb.135.1702312867373; Mon, 11
 Dec 2023 08:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20231205061002.30759-1-quic_sibis@quicinc.com> <20231205061002.30759-3-quic_sibis@quicinc.com>
In-Reply-To: <20231205061002.30759-3-quic_sibis@quicinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Dec 2023 10:40:55 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+UhWuFdd=o=W_5iaHpLqQxQ13YOGBjnPAm46LO90hGqA@mail.gmail.com>
Message-ID: <CAL_Jsq+UhWuFdd=o=W_5iaHpLqQxQ13YOGBjnPAm46LO90hGqA@mail.gmail.com>
Subject: Re: [PATCH V3 2/4] clk: qcom: Add Global Clock controller (GCC)
 driver for X1E80100
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 12:11=E2=80=AFAM Sibi Sankar <quic_sibis@quicinc.com=
> wrote:
>
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>
> Add support for the global clock controller found on X1E80100
> based devices.
>
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>
> v3:
> * Rename gcc config to CLK_X1E80100_GCC [Krzysztof/Abel/Bryan]
> * Pickup Rbs.
>
>  drivers/clk/qcom/Kconfig        |   10 +
>  drivers/clk/qcom/Makefile       |    1 +
>  drivers/clk/qcom/gcc-x1e80100.c | 6807 +++++++++++++++++++++++++++++++
>  3 files changed, 6818 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-x1e80100.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ad1acd9b7426..a9bb50da4de5 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -20,6 +20,16 @@ menuconfig COMMON_CLK_QCOM
>
>  if COMMON_CLK_QCOM
>
> +config CLK_X1E80100_GCC
> +       tristate "X1E80100 Global Clock Controller"
> +       depends on ARM64 || COMPILE_TEST
> +       select QCOM_GDSC
> +       help
> +         Support for the global clock controller on Qualcomm Technologie=
s, Inc
> +         X1E80100 devices.
> +         Say Y if you want to use peripheral devices such as UART, SPI, =
I2C,
> +         USB, UFS, SD/eMMC, PCIe, etc.
> +
>  config QCOM_A53PLL
>         tristate "MSM8916 A53 PLL"
>         help
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 17edd73f9839..a8498ee3595e 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -21,6 +21,7 @@ clk-qcom-$(CONFIG_QCOM_GDSC) +=3D gdsc.o
>  obj-$(CONFIG_APQ_GCC_8084) +=3D gcc-apq8084.o
>  obj-$(CONFIG_APQ_MMCC_8084) +=3D mmcc-apq8084.o
>  obj-$(CONFIG_CLK_GFM_LPASS_SM8250) +=3D lpass-gfm-sm8250.o
> +obj-$(CONFIG_CLK_X1E80100_GCC) +=3D gcc-x1e80100.o
>  obj-$(CONFIG_IPQ_APSS_PLL) +=3D apss-ipq-pll.o
>  obj-$(CONFIG_IPQ_APSS_6018) +=3D apss-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_4019) +=3D gcc-ipq4019.o
> diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e80=
100.c
> new file mode 100644
> index 000000000000..74db7fef237b
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-x1e80100.c
> @@ -0,0 +1,6807 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reser=
ved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>

Probably not a header you need as reported for linux-next. You need
platform_device.h and either of.h or mod_devicetable.h.

Rob

> --
> 2.17.1
>
