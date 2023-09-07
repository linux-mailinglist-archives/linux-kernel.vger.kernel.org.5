Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED1797759
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjIGQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbjIGQIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:08:01 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59821359C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:01:08 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-44ee1123667so1349301137.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694102091; x=1694706891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=40rylBcMTDXR7i4w8TksqV00SNZY2PfZiThjPzEVKjU=;
        b=LNcoer1jgXWr7fF7OEBICtXch+4ptEPOHYJcLbvdY9vNWqt0QEkiSkgGQu84tIGcEf
         HvKk7jOE7tbfHGEzs+dAqIOQPEkhJj/7604z1P6pHffPkVuHVmM/99q6LXnRRQ6Jp+2t
         fKP/fgPdD9DAzwpS2UC8WTKCIJ41fb5GIZNjITovEi+xWijRm+pcy5pQH6D5m5w2y/Th
         oacFa7sm5aZ/5u/v2I3r4CYoyLPR6pYHp8Zm4S8sAwNK44zBnpu2Hnc+mmwSKAxWh9BN
         sLPXGdlIrmpzHjt2SIo3M8EJC6M2AfGrz6jVUhIxJNWH085jAAWs88+7BhrZ1bcAq6FG
         K0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102091; x=1694706891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40rylBcMTDXR7i4w8TksqV00SNZY2PfZiThjPzEVKjU=;
        b=SGYp+0nbEG+Exww3kThdRxf62kvOlMdiRR7zIxJyYEekCBpsNIO6l5D21RhfT6G0yl
         bDiB3TqnGMhgaQzvlNF/J//Tdy4M2dDDkaQAkcCnUD+tYNeIlN+YQJ2MO5TmCxvOfA9Q
         mEYh4Lb7xem+2zh+R7J/qo9n60iHH6LITifJI7wWT29PCFqR0ux1bzSU/6/+aH8vnbgi
         vIRdTwb6Ux8ifF0Wpg3/WsdIsSgBAz0kV/cOVbPWoXN1f6tLJwhJv30B1xJKXz3IaPkr
         JTZZa0jUcf+0yJF9wN1WD64T3apOXE5ntfSZwnBnCtJOY75oHLT+9no5eQjiuvHi1JJ/
         CzhA==
X-Gm-Message-State: AOJu0YzPDozo/aPEdxVCrVOH6bZTT5g5pfcluMWtO+bzoEBv4wt3Kh+r
        N8InJ+3uS/HS/q6EZQYShs8/u4hi0tc/ca/mgnL+FXRK7+WoV1y4
X-Google-Smtp-Source: AGHT+IETdhddPzANTZg932/q6SiIInI1A+ozTRz+mJHbAWbdsy/mtMdePXNFfT+4SqFLkAAkJW11kVd7upfsHv7Zxng=
X-Received: by 2002:a25:1e0a:0:b0:d1c:876d:2c7d with SMTP id
 e10-20020a251e0a000000b00d1c876d2c7dmr3250628ybe.13.1694094907900; Thu, 07
 Sep 2023 06:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <5e3c29df2b42cceb8072b00546a78e1b99b2d374.1693996662.git.quic_varada@quicinc.com>
In-Reply-To: <5e3c29df2b42cceb8072b00546a78e1b99b2d374.1693996662.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Sep 2023 16:54:56 +0300
Message-ID: <CAA8EJppXxiX7+6nhfKyJYDU0i2pkBzXL5J3EQUapLJXxx3b=HA@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] clk: qcom: apss-ipq6018: ipq5332: add safe
 source switch for a53pll
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sept 2023 at 08:22, Varadarajan Narayanan
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

This means that we are changing the parents behind the back of CCF,
which is not great.

>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/apss-ipq6018.c | 54 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> index 4e13a08..ffb6ab5 100644
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
> @@ -84,15 +87,64 @@ static const struct qcom_cc_desc apss_ipq6018_desc = {
>         .num_clks = ARRAY_SIZE(apss_ipq6018_clks),
>  };
>
> +static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
> +                               void *data)
> +{
> +       u8 index;
> +       int err;
> +
> +       if (action == PRE_RATE_CHANGE)
> +               index = P_GPLL0;

I don't see P_GPLL0 being supported in the ipq6018 driver.

> +       else if (action == POST_RATE_CHANGE)
> +               index = P_APSS_PLL_EARLY;

You also have to handle ABORT_RATE_CHANGE here.

> +       else
> +               return 0;
> +
> +       err = clk_rcg2_mux_closest_ops.set_parent(&apcs_alias0_clk_src.clkr.hw,
> +                                                 index);
> +
> +       return notifier_from_errno(err);
> +}
> +
> +static struct notifier_block cpu_clk_notifier = {
> +       .notifier_call = cpu_clk_notifier_fn,
> +};
> +
>  static int apss_ipq6018_probe(struct platform_device *pdev)
>  {
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
> +       /*
> +        * Only below variants of IPQ53xx support scaling
> +        */
> +       case QCOM_ID_IPQ5332:
> +       case QCOM_ID_IPQ5322:
> +       case QCOM_ID_IPQ5300:

Please use compat strings instead of using the soc-id.

> +               ret = clk_notifier_register(apcs_alias0_clk_src.clkr.hw.clk,
> +                                               &cpu_clk_notifier);
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
