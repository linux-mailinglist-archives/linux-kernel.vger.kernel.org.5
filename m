Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2685B7536BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjGNJgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbjGNJgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:36:35 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEEE35A8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:36:30 -0700 (PDT)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 51E883F18F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 09:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689327387;
        bh=+yiF1ij/z+iWY/wZthjD0aPjMSoVu9B46XxEpPJ5vvs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=oXQu9EtGrgtxHRToV1t0zuR4XnCGJn6QbytYS5UbrgroI8WdqfcekZEF8/+GBy9KA
         CJtC11FYTCVMJmeVUCFck17lS8S6Vx5ETFOOlt1cy0ECiEZRfESkn1P25jGEZBeJrq
         MGU/teMhYCkKZvokTZO1tLgknlXnZjMb6eQF0xjk0E4/7Gm/fE8rvqQL346p0pnTfK
         oo/1rD+YYtNfK9jJPoq59p0S5LoUZroHCOzdycZogqMJ+eYEZyOfo12Fl0nnzCzryC
         bLiUuKVx+Vmui7QtUKdCkbB42BW1SnsPqLMt6fBLdkga1oFbwrSEETJePnH3UDq4wq
         xtY1l8WmfmCqQ==
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-5eee6742285so17584426d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327386; x=1691919386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yiF1ij/z+iWY/wZthjD0aPjMSoVu9B46XxEpPJ5vvs=;
        b=SC8W+lNBLMQcRkke3JtFDU4++m8rprFPFF6TfptFzwo454u7Q44NBe0qg69E5UHxJn
         2QgaON2zsgD3e/ASsXJcbxHOO3vHdYtxrUWpPHbXSXy8SqXPkbArwtS1tJqTHU1Cv9WA
         cyRwDiHbiYo++HQM5n9R9PecsItKC2jpC3PURtkCwAcoM6s/+dvTljHVox5Z1GOR1/jT
         QXz0whPXoxYgtpj8BB7Nwr4F9PH04uELLoWsPX0oQacH0945H1W/GmNr+C3Pkt1RNJWK
         fdImEPZpOwoosiYkJ3ktqbj7hRNHWVAg40Eb6oG/VSjKfagluQAUeFa/HenqPDRu3Ryh
         2RHg==
X-Gm-Message-State: ABy/qLaNTRZtGQrwevHCOsPZw7v9/qA0EBffljsxrQnt62+4zkWBDnUX
        nkY1ERcKXEwqQtUjbAoYdJ4aLkjjYfJpzDx7y7CWOwGnAwKk378Jm2tKqtTCNCf7WCyCD1ysA9b
        oxu6qm/zav/UJSmPF+syp22nUJP8jj2YvmQp+60bYsoUrwM+god9Urbgt7nkGcYu0EQ==
X-Received: by 2002:a05:622a:181:b0:403:ac95:c6a9 with SMTP id s1-20020a05622a018100b00403ac95c6a9mr5242748qtw.30.1689327386204;
        Fri, 14 Jul 2023 02:36:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGxE6bkszZ+7BBq2hyHda3ibW1kqoUiril9bmmHYh1J06irx78LOa5uu+I/iZMoL2sy2f6nXwFaMqHTE34JLQw=
X-Received: by 2002:a05:622a:181:b0:403:ac95:c6a9 with SMTP id
 s1-20020a05622a018100b00403ac95c6a9mr5242716qtw.30.1689327385565; Fri, 14 Jul
 2023 02:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230704064610.292603-1-xingyu.wu@starfivetech.com>
 <20230704064610.292603-6-xingyu.wu@starfivetech.com> <CAJM55Z-OSmQCV6mO+SD4R2eU5gfx9TArSqDy+d-M2aer6bKL_A@mail.gmail.com>
 <9a2f0aa0-ad7e-c12d-245d-5f80928705d6@starfivetech.com>
In-Reply-To: <9a2f0aa0-ad7e-c12d-245d-5f80928705d6@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 14 Jul 2023 11:36:09 +0200
Message-ID: <CAJM55Z8rXOyT4Q-JbzZof5050qGqohDTRCj7RDavuzi1Zb6wMQ@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 at 10:05, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>
> On 2023/7/13 21:15, Emil Renner Berthing wrote:
> > On Tue, 4 Jul 2023 at 08:49, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> >>
> >> Modify PLL clocks source to be got from DTS or
> >> the fixed factor clocks.
> >>
> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> >> ---
> >>  drivers/clk/starfive/Kconfig                  |  1 +
> >>  .../clk/starfive/clk-starfive-jh7110-sys.c    | 45 +++++++++++--------
> >>  2 files changed, 28 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> >> index 5195f7be5213..978b78ec08b1 100644
> >> --- a/drivers/clk/starfive/Kconfig
> >> +++ b/drivers/clk/starfive/Kconfig
> >> @@ -35,6 +35,7 @@ config CLK_STARFIVE_JH7110_SYS
> >>         select AUXILIARY_BUS
> >>         select CLK_STARFIVE_JH71X0
> >>         select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
> >> +       select CLK_STARFIVE_JH7110_PLL
> >>         default ARCH_STARFIVE
> >>         help
> >>           Say yes here to support the system clock controller on the
> >> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> >> index e6031345ef05..d56f48013388 100644
> >> --- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> >> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
> >> @@ -7,6 +7,7 @@
> >>   */
> >>
> >>  #include <linux/auxiliary_bus.h>
> >> +#include <linux/clk.h>
> >>  #include <linux/clk-provider.h>
> >>  #include <linux/init.h>
> >>  #include <linux/io.h>
> >> @@ -386,6 +387,7 @@ EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
> >>
> >>  static int __init jh7110_syscrg_probe(struct platform_device *pdev)
> >>  {
> >> +       bool use_fixed_pll = true;      /* PLL clocks use fixed factor clocks or PLL driver */
> >
> > nit: reverse christmas tree ordering, eg. move this below priv
> >
> >>         struct jh71x0_clk_priv *priv;
> >>         unsigned int idx;
> >>         int ret;
> >> @@ -402,28 +404,29 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
> >>         if (IS_ERR(priv->base))
> >>                 return PTR_ERR(priv->base);
> >>
> >> -       /*
> >> -        * These PLL clocks are not actually fixed factor clocks and can be
> >> -        * controlled by the syscon registers of JH7110. They will be dropped
> >> -        * and registered in the PLL clock driver instead.
> >> -        */
> >> +       if (!IS_ERR(devm_clk_get(priv->dev, "pll0_out")))
> >> +               use_fixed_pll = false;  /* can get pll clocks from PLL driver */
> >
> > The devm_clk_get() variant will allocate memory for a callback to call
> > clk_put() when the driver is unloaded, but proper references
> > associated with the consumers of the pll0_out clock are already taken
> > below. So unless we find a better way to detect if the pll references
> > are specified in the device tree or not, maybe something like this
> > instead:
> >
>
> Thanks. It looks more reasonable. I will follow it in next version.
>
> > priv->pll[0] = clk_get(priv->dev, "pll0_out);
>
> The priv->pll[] are clk_hw* struct no clk* struct and this could be failed
> when building. So maybe use a temporary clk* struct.

Ah yes, you're right. You'll need a local struct clk *clk for that then.

> > if (IS_ERR(priv->pll[0])) {
> >   /* 24MHZ -> 1000.0MHz */
> >   priv->pll[0] = ...
> >   ...
> >
> > } else {
> >   clk_put(priv->pll[0]);
> >   priv->pll[0] = NULL;
>
> >
> >> +       /* Use fixed factor clocks if can not get the PLL clocks from DTS */
> >> +       if (use_fixed_pll) {
> >>         /* 24MHz -> 1000.0MHz */
> >
> > These comments are not indented with the code, which just looks weird.
>
> Will fix.
>
> >
> >> -       priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
> >> -                                                        "osc", 0, 125, 3);
> >> -       if (IS_ERR(priv->pll[0]))
> >> -               return PTR_ERR(priv->pll[0]);
> >> +               priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
> >> +                                                                "osc", 0, 125, 3);
> >> +               if (IS_ERR(priv->pll[0]))
> >> +                       return PTR_ERR(priv->pll[0]);
> >>
> >>         /* 24MHz -> 1066.0MHz */
> >> -       priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
> >> -                                                        "osc", 0, 533, 12);
> >> -       if (IS_ERR(priv->pll[1]))
> >> -               return PTR_ERR(priv->pll[1]);
> >> +               priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
> >> +                                                                "osc", 0, 533, 12);
> >> +               if (IS_ERR(priv->pll[1]))
> >> +                       return PTR_ERR(priv->pll[1]);
> >>
> >>         /* 24MHz -> 1188.0MHz */
> >> -       priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
> >> -                                                        "osc", 0, 99, 2);
> >> -       if (IS_ERR(priv->pll[2]))
> >> -               return PTR_ERR(priv->pll[2]);
> >> +               priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
> >> +                                                                "osc", 0, 99, 2);
> >> +               if (IS_ERR(priv->pll[2]))
> >> +                       return PTR_ERR(priv->pll[2]);
> >> +       }
> >>
> >>         for (idx = 0; idx < JH7110_SYSCLK_END; idx++) {
> >>                 u32 max = jh7110_sysclk_data[idx].max;
> >> @@ -462,8 +465,14 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
> >>                                 parents[i].fw_name = "tdm_ext";
> >>                         else if (pidx == JH7110_SYSCLK_MCLK_EXT)
> >>                                 parents[i].fw_name = "mclk_ext";
> >> -                       else
> >> +                       else if (use_fixed_pll)
> >
> > else if (priv->pll[0])
>
> Will change.
>
> >
> >>                                 parents[i].hw = priv->pll[pidx - JH7110_SYSCLK_PLL0_OUT];
> >> +                       else if (pidx == JH7110_SYSCLK_PLL0_OUT)
> >> +                               parents[i].fw_name = "pll0_out";
> >> +                       else if (pidx == JH7110_SYSCLK_PLL1_OUT)
> >> +                               parents[i].fw_name = "pll1_out";
> >> +                       else if (pidx == JH7110_SYSCLK_PLL2_OUT)
> >> +                               parents[i].fw_name = "pll2_out";
> >>                 }
> >>
> >>                 clk->hw.init = &init;
> >> --
> >> 2.25.1
> >>
>
> Best regards,
> Xingyu Wu
