Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3CA75232B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjGMNP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjGMNP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:15:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00A91BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:15:54 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2233F3F71E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689254152;
        bh=lzWjLkz9jgGntegWn0jvL4sjWw5FNz46EKQK53j0qbY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dlab18ZTlvOPTRt+i6sb53s16eMQi1SezGG9c06eew7yNfbBQb24LOw4dwdZimJgm
         5C7DXGMa1j3Q4TR+0BbthYgSIrUC14Xa3VnSibr6pYu9KVIb05rSfuoHCY+mBSxlP0
         PY2NFWAfF4vLZAbEVRBCFVChOPB0fGtXXdlPHNrXx9ruJhuYj7N1Mk5MbI4u44MpzG
         AfpxYFqxIo06ia4D69YF+K6gntsHWl4Bd7UXlIt7xn9ssGF2i7XIxB/IRX5XIIeDSQ
         6QehLhaq3Je+l18GUPfsVC+0AYSM4YLvgbvO0jlcBIEWYbsWfen4/dqT0K2k0qc22S
         zTkX8pEkMXUug==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-403a5b83c9aso9435031cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689254149; x=1691846149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lzWjLkz9jgGntegWn0jvL4sjWw5FNz46EKQK53j0qbY=;
        b=Yfz3EqtO40RLoOqoRd6dNpswjToVyT10WwYi9Hnentzl6ngPeggytXXbzL2Jgua1x6
         qrbgkdZpjReqO2whl0uih3oiQlBKoz4/crhFaZDUDIya3/g1W4GGxqqTKkfuH1UdJqzT
         pBYNR6xZzx/gFec7jylkJ+tVjWgIlzNNG25abPAXzDRLQ7rxsi3PQdqXh2aCFByXIgKD
         JMQdG80Vnyr4+Mnz8YW0xfmxWzlt7JfiArXl5ZVP7zzEXZ1fqC6jPqej0zLJS7uhBuRT
         q33t0YaG5hpmA9Le8aw5+H9bxZvjxd9JsHjwZzQQCZdLGlRu5qP7C/liwHCG36Hk+AJz
         0mUg==
X-Gm-Message-State: ABy/qLZwNnCFhSDGEPp3orLBQ3/ayn48ZU2asTEBJlKBbmPX/7L/UHRt
        VujPJFsyiLVqFjliAdTq4h2A/bGLEHb688sDXyVnLOwNG4/7aIVgZcYua5wqajd0wDcMaMW21cy
        dZTIkhO8Ytbq7Jkt5buTugE9xugPJAtnVAbm7Gz46ySh5fsJeGzWOf2zpdA==
X-Received: by 2002:ac8:5dcf:0:b0:400:9a75:d868 with SMTP id e15-20020ac85dcf000000b004009a75d868mr1784482qtx.53.1689254149352;
        Thu, 13 Jul 2023 06:15:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFREZAUVHrD2WAPAOepNdisRg4PmYWg2KJmdiHvZLy8utdjhf7asfxlbZZKZpSBDSxQLR979i/SsgKi5ZyG1lw=
X-Received: by 2002:ac8:5dcf:0:b0:400:9a75:d868 with SMTP id
 e15-20020ac85dcf000000b004009a75d868mr1784462qtx.53.1689254149008; Thu, 13
 Jul 2023 06:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com> <20230704064610.292603-6-xingyu.wu@starfivetech.com>
In-Reply-To: <20230704064610.292603-6-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 13 Jul 2023 15:15:32 +0200
Message-ID: <CAJM55Z-OSmQCV6mO+SD4R2eU5gfx9TArSqDy+d-M2aer6bKL_A@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 5/7] clk: starfive: jh7110-sys: Add PLL clocks
 source from DTS
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023 at 08:49, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> Modify PLL clocks source to be got from DTS or
> the fixed factor clocks.
>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  drivers/clk/starfive/Kconfig                  |  1 +
>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 45 +++++++++++--------
>  2 files changed, 28 insertions(+), 18 deletions(-)
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
> index e6031345ef05..d56f48013388 100644
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
> @@ -386,6 +387,7 @@ EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
>
>  static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>  {
> +       bool use_fixed_pll = true;      /* PLL clocks use fixed factor clocks or PLL driver */

nit: reverse christmas tree ordering, eg. move this below priv

>         struct jh71x0_clk_priv *priv;
>         unsigned int idx;
>         int ret;
> @@ -402,28 +404,29 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->base))
>                 return PTR_ERR(priv->base);
>
> -       /*
> -        * These PLL clocks are not actually fixed factor clocks and can be
> -        * controlled by the syscon registers of JH7110. They will be dropped
> -        * and registered in the PLL clock driver instead.
> -        */
> +       if (!IS_ERR(devm_clk_get(priv->dev, "pll0_out")))
> +               use_fixed_pll = false;  /* can get pll clocks from PLL driver */

The devm_clk_get() variant will allocate memory for a callback to call
clk_put() when the driver is unloaded, but proper references
associated with the consumers of the pll0_out clock are already taken
below. So unless we find a better way to detect if the pll references
are specified in the device tree or not, maybe something like this
instead:

priv->pll[0] = clk_get(priv->dev, "pll0_out);
if (IS_ERR(priv->pll[0])) {
  /* 24MHZ -> 1000.0MHz */
  priv->pll[0] = ...
  ...

} else {
  clk_put(priv->pll[0]);
  priv->pll[0] = NULL;
}

> +       /* Use fixed factor clocks if can not get the PLL clocks from DTS */
> +       if (use_fixed_pll) {
>         /* 24MHz -> 1000.0MHz */

These comments are not indented with the code, which just looks weird.

> -       priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
> -                                                        "osc", 0, 125, 3);
> -       if (IS_ERR(priv->pll[0]))
> -               return PTR_ERR(priv->pll[0]);
> +               priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
> +                                                                "osc", 0, 125, 3);
> +               if (IS_ERR(priv->pll[0]))
> +                       return PTR_ERR(priv->pll[0]);
>
>         /* 24MHz -> 1066.0MHz */
> -       priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
> -                                                        "osc", 0, 533, 12);
> -       if (IS_ERR(priv->pll[1]))
> -               return PTR_ERR(priv->pll[1]);
> +               priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
> +                                                                "osc", 0, 533, 12);
> +               if (IS_ERR(priv->pll[1]))
> +                       return PTR_ERR(priv->pll[1]);
>
>         /* 24MHz -> 1188.0MHz */
> -       priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
> -                                                        "osc", 0, 99, 2);
> -       if (IS_ERR(priv->pll[2]))
> -               return PTR_ERR(priv->pll[2]);
> +               priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
> +                                                                "osc", 0, 99, 2);
> +               if (IS_ERR(priv->pll[2]))
> +                       return PTR_ERR(priv->pll[2]);
> +       }
>
>         for (idx = 0; idx < JH7110_SYSCLK_END; idx++) {
>                 u32 max = jh7110_sysclk_data[idx].max;
> @@ -462,8 +465,14 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
>                                 parents[i].fw_name = "tdm_ext";
>                         else if (pidx == JH7110_SYSCLK_MCLK_EXT)
>                                 parents[i].fw_name = "mclk_ext";
> -                       else
> +                       else if (use_fixed_pll)

else if (priv->pll[0])

>                                 parents[i].hw = priv->pll[pidx - JH7110_SYSCLK_PLL0_OUT];
> +                       else if (pidx == JH7110_SYSCLK_PLL0_OUT)
> +                               parents[i].fw_name = "pll0_out";
> +                       else if (pidx == JH7110_SYSCLK_PLL1_OUT)
> +                               parents[i].fw_name = "pll1_out";
> +                       else if (pidx == JH7110_SYSCLK_PLL2_OUT)
> +                               parents[i].fw_name = "pll2_out";
>                 }
>
>                 clk->hw.init = &init;
> --
> 2.25.1
>
