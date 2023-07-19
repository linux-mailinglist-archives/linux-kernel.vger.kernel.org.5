Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3418D759A30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjGSPub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjGSPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:50:28 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982871FFA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:50:13 -0700 (PDT)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7644B3FA70
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689781812;
        bh=lBkd8y3XOzT/fx92qUyW7CMl9N9JYFVT6xHfK84rRBs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Q9xjtbQ15Ybw7rewOfYq54BVdFXC0YvVzNRg0I4S3e12lTY/pVDdR9KFVlHCe4/Z7
         nKIP9psEQoY6TugsP4MJZbj4ZcnJpktsMO5373Eit/K4f6oLM+wx8NqaK/95SSdjDg
         u5e7QuQfKW6QIaGC9Q8Bxhbj/bGf4+ia6ZCCDBmhbsJjOCuLme/XkXet/ce38ZbnkM
         XyEKqrENuPVFPihRYCFQ30RmTIiIsElMiYMF35Ss7DvsiT4Nq9N4Yo+WL8csDt5TYg
         1DQi3O/Bk7vRkYhfYwH8i502gCfI9UHvQK/YbC2jEkwxv8S3q7lWKJPMFioef0Bpgl
         KKL1yHOmgrDZg==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-403b134421cso8660141cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781811; x=1690386611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBkd8y3XOzT/fx92qUyW7CMl9N9JYFVT6xHfK84rRBs=;
        b=Sue2DMZcHqV46WKQms1KsFkfFpCdIZze6JMTw8IoMrS0if2MTamWdk/jIPhVvCaRZV
         HOhGSUPPc5xIHvKMHqcuk1L12A0mb57RrFlQFGR1is5G2/qPHKQ/GNjYopgVlUSO9tGZ
         7u1AZ9DHsU4vpqMIJyeD+KN79exR6K1SI+hq7zjSy1CLbrEOsgtefqAMADrqKvAh1log
         128JO9+2Pj0ENQMGqGdWlIXEeXFnhT+kbp5HToqO1pAjBolm1PBqxzDeu/wAXejJ7yz9
         8jJlxylE9asY4kqIUGDE5v9iH2BqoGty1TZlngXXtdl5ueR5ObQRPceL6JWfMN6Ga+sx
         9V8g==
X-Gm-Message-State: ABy/qLZXJEaemGW7yibSLjaNUA8cQUlYrJuxk8bzCW3NFF/WmEATpxOv
        HrhJYgk/rqtdmFMHtfWzR73jGpVKPGzA2VzReWYUPL4Z4sNU4s/+Jjszt9udtekFL79bnfb/5Zn
        VbopCPdSfOYccaQgMR3vtk8xHPmKZ/WUP7CnTUdNqZF08OAM0e8m6mrK2sA==
X-Received: by 2002:a05:622a:1009:b0:402:d15e:2984 with SMTP id d9-20020a05622a100900b00402d15e2984mr2944879qte.32.1689781810927;
        Wed, 19 Jul 2023 08:50:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFLsdryo3l3HfOhrzOljHukZzudv9rHzS/TP/ey37QvguSJT9mRI3G5taBWNolBsF75e8Yi/YTmAsaRVIRiakk=
X-Received: by 2002:a05:622a:1009:b0:402:d15e:2984 with SMTP id
 d9-20020a05622a100900b00402d15e2984mr2944851qte.32.1689781810663; Wed, 19 Jul
 2023 08:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230717023040.78860-1-xingyu.wu@starfivetech.com> <20230717023040.78860-6-xingyu.wu@starfivetech.com>
In-Reply-To: <20230717023040.78860-6-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Wed, 19 Jul 2023 17:49:54 +0200
Message-ID: <CAJM55Z_cX09WQdxB+aNBXo+WVjoJYT5vQz5sbrNBmLikDiNJrQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] clk: starfive: jh7110-sys: Add PLL clocks source
 from DTS
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 at 04:30, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> Modify PLL clocks source to be got from DTS or
> the fixed factor clocks.
>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  drivers/clk/starfive/Kconfig                  |  1 +
>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 66 ++++++++++++-------
>  2 files changed, 45 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 5195f7be5213..978b78ec08b1 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -35,6 +35,7 @@ config CLK_STARFIVE_JH7110_SYS
>         select AUXILIARY_BUS
>         select CLK_STARFIVE_JH71X0
>         select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
> +       select CLK_STARFIVE_JH7110_PLL
>         default ARCH_STARFIVE
>         help
>           Say yes here to support the system clock controller on the
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> index e6031345ef05..3884eff9fe93 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/auxiliary_bus.h>
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -389,6 +390,7 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>         struct jh71x0_clk_priv *priv;
>         unsigned int idx;
>         int ret;
> +       struct clk *pllclk;
>
>         priv = devm_kzalloc(&pdev->dev,
>                             struct_size(priv, reg, JH7110_SYSCLK_END),
> @@ -402,28 +404,42 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->base))
>                 return PTR_ERR(priv->base);
>
> -       /*
> -        * These PLL clocks are not actually fixed factor clocks and can be
> -        * controlled by the syscon registers of JH7110. They will be dropped
> -        * and registered in the PLL clock driver instead.
> -        */
> -       /* 24MHz -> 1000.0MHz */
> -       priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
> -                                                        "osc", 0, 125, 3);
> -       if (IS_ERR(priv->pll[0]))
> -               return PTR_ERR(priv->pll[0]);
> -
> -       /* 24MHz -> 1066.0MHz */
> -       priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
> -                                                        "osc", 0, 533, 12);
> -       if (IS_ERR(priv->pll[1]))
> -               return PTR_ERR(priv->pll[1]);
> -
> -       /* 24MHz -> 1188.0MHz */
> -       priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
> -                                                        "osc", 0, 99, 2);
> -       if (IS_ERR(priv->pll[2]))
> -               return PTR_ERR(priv->pll[2]);
> +       /* Use fixed factor clocks if can not get the PLL clocks from DTS */
> +       pllclk = clk_get(priv->dev, "pll0_out");
> +       if (IS_ERR(pllclk)) {
> +               /* 24MHz -> 1000.0MHz */
> +               priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
> +                                                                "osc", 0, 125, 3);
> +               if (IS_ERR(priv->pll[0]))
> +                       return PTR_ERR(priv->pll[0]);
> +       } else {
> +               clk_put(pllclk);
> +               priv->pll[0] = NULL;

Not really important enough for a respin, but setting these to NULL is
not needed as devm_kzalloc() already zeroes the memory allocated.

In any case:
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> +       }
> +
> +       pllclk = clk_get(priv->dev, "pll1_out");
> +       if (IS_ERR(pllclk)) {
> +               /* 24MHz -> 1066.0MHz */
> +               priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
> +                                                                "osc", 0, 533, 12);
> +               if (IS_ERR(priv->pll[1]))
> +                       return PTR_ERR(priv->pll[1]);
> +       } else {
> +               clk_put(pllclk);
> +               priv->pll[1] = NULL;
> +       }
> +
> +       pllclk = clk_get(priv->dev, "pll2_out");
> +       if (IS_ERR(pllclk)) {
> +               /* 24MHz -> 1188.0MHz */
> +               priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
> +                                                                "osc", 0, 99, 2);
> +               if (IS_ERR(priv->pll[2]))
> +                       return PTR_ERR(priv->pll[2]);
> +       } else {
> +               clk_put(pllclk);
> +               priv->pll[2] = NULL;
> +       }
>
>         for (idx = 0; idx < JH7110_SYSCLK_END; idx++) {
>                 u32 max = jh7110_sysclk_data[idx].max;
> @@ -462,6 +478,12 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>                                 parents[i].fw_name = "tdm_ext";
>                         else if (pidx == JH7110_SYSCLK_MCLK_EXT)
>                                 parents[i].fw_name = "mclk_ext";
> +                       else if (pidx == JH7110_SYSCLK_PLL0_OUT && !priv->pll[0])
> +                               parents[i].fw_name = "pll0_out";
> +                       else if (pidx == JH7110_SYSCLK_PLL1_OUT && !priv->pll[1])
> +                               parents[i].fw_name = "pll1_out";
> +                       else if (pidx == JH7110_SYSCLK_PLL2_OUT && !priv->pll[2])
> +                               parents[i].fw_name = "pll2_out";
>                         else
>                                 parents[i].hw = priv->pll[pidx - JH7110_SYSCLK_PLL0_OUT];
>                 }
> --
> 2.25.1
>
