Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D6B79109C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 06:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbjIDEjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 00:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjIDEjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 00:39:17 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26D7B3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 21:39:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so1418312a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 21:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693802351; x=1694407151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zai6pQtazglqz8kDEJ8B8RnVR840k0ZXmvJDFgMRz6I=;
        b=L9mWKK2rSpIdQhPGjmgeatTCr0yQlBTRxqECcaSyBGJUZmiTsKtrNC27X1Lq9hAw7D
         8pzjysd8rtMjqhs0Eecm9/VDEBeBRWHnl0rMj+bNJmJOnuBu3HTGlmo0C9WL9GA8tVHr
         Mcj5A/9VjpJY5717kTbPpWIUj+hnw+QkOsNDoDVbeiWjie614J/OKTeqEOUpFVgiglcK
         g+UqfvM0ra9L/PVh0ML5X8IuQ5pYORY04GSOW08kYy2XJOplrAHFxfJgz7NYZMHNJXlO
         1ejdXRAwudX+WfwcomjiLmrxGf5ONXKa+dH0S0kKVffI8g4EAUBweYPKUaOJIx8slxUq
         84Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693802351; x=1694407151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zai6pQtazglqz8kDEJ8B8RnVR840k0ZXmvJDFgMRz6I=;
        b=UCkjLrFByU5cD40ZptfG8dMlqarOav/lkw6bqVUW1Z4tIDk3Ydj4FlLu68DwSrzN1P
         E0YrWZWEm3k/YPjuUJoHRD0HAFIR0cYkBzF7IYxpOiZGSShYkuzgazJs+kjMMtkHy5el
         OZ5z5mcEAGGr7Hrza4+MIg3XDFVqkHT9Yu3QkjdmkL15/TwfeR1sQXakZEyx5eTxV4M2
         82t9GSrFvrjCWMlua9TmnMbbL/KIqgdYUJQaBck28DZ5XTdXaYj90Uj2D6YVYDWYz0hN
         bc53xDued+f0EvUqHVPNFVibGYBD1II+7FODZb1B5cVDvFq6qznIk1NbtNqvq72hPgi2
         T+GQ==
X-Gm-Message-State: AOJu0Yy15ZHV70sc/WGhJpn9v/hHN9dDZAipsSlsq5xFoKroEquUim9Q
        AM3F0JzfQyxbQDz2glLi/HilRl/pnR0vSKcMQDA=
X-Google-Smtp-Source: AGHT+IFq9ARrNEcYLIVZ5msETKzqjI5MvFo6Q9yv0et+z12YNwGoM/pI9g8OSeAZROzWsBCI/ZeXdtvXgoGhLPzkjV4=
X-Received: by 2002:aa7:d58f:0:b0:52b:d169:b374 with SMTP id
 r15-20020aa7d58f000000b0052bd169b374mr7398932edq.3.1693802350757; Sun, 03 Sep
 2023 21:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de> <20230818-samsung-dsim-v1-2-b39716db6b7a@pengutronix.de>
In-Reply-To: <20230818-samsung-dsim-v1-2-b39716db6b7a@pengutronix.de>
From:   Inki Dae <daeinki@gmail.com>
Date:   Mon, 4 Sep 2023 13:38:33 +0900
Message-ID: <CAAQKjZOuRVsF7vE6ghBG7KH_QkE-5_UXjXMY080ynzZLpDjs7w@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/bridge: samsung-dsim: reread ref clock before
 configuring PLL
To:     Michael Tretter <m.tretter@pengutronix.de>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023=EB=85=84 8=EC=9B=94 29=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:59, =
Michael Tretter <m.tretter@pengutronix.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:

>
> The PLL reference clock may change at runtime. Thus, reading the clock
> rate during probe is not sufficient to correctly configure the PLL for
> the expected hs clock.
>
> Read the actual rate of the reference clock before calculating the PLL
> configuration parameters.
>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 16 +++++++++-------
>  include/drm/bridge/samsung-dsim.h     |  1 +
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 6778f1751faa..da90c2038042 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -611,7 +611,12 @@ static unsigned long samsung_dsim_set_pll(struct sam=
sung_dsim *dsi,
>         u16 m;
>         u32 reg;
>
> -       fin =3D dsi->pll_clk_rate;
> +       if (dsi->pll_clk)
> +               fin =3D clk_get_rate(dsi->pll_clk);
> +       else
> +               fin =3D dsi->pll_clk_rate;
> +       dev_dbg(dsi->dev, "PLL ref clock freq %lu\n", fin);
> +

Could you share us the actual use case that in runtime the pll
reference clock can be changed?

This patch is trying to change clock binding behavior which is
described in dt binding[1]
[1] Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml

It says,
"DISM oscillator clock frequency. If absent, the clock frequency of
sclk_mipi will be used instead."

However, this patch makes the sclk_mipi to be used first.

Thanks,
Inki Dae

>         fout =3D samsung_dsim_pll_find_pms(dsi, fin, freq, &p, &m, &s);
>         if (!fout) {
>                 dev_err(dsi->dev,
> @@ -1821,18 +1826,15 @@ static int samsung_dsim_parse_dt(struct samsung_d=
sim *dsi)
>         u32 lane_polarities[5] =3D { 0 };
>         struct device_node *endpoint;
>         int i, nr_lanes, ret;
> -       struct clk *pll_clk;
>
>         ret =3D samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequen=
cy",
>                                        &dsi->pll_clk_rate, 1);
>         /* If it doesn't exist, read it from the clock instead of failing=
 */
>         if (ret < 0) {
>                 dev_dbg(dev, "Using sclk_mipi for pll clock frequency\n")=
;
> -               pll_clk =3D devm_clk_get(dev, "sclk_mipi");
> -               if (!IS_ERR(pll_clk))
> -                       dsi->pll_clk_rate =3D clk_get_rate(pll_clk);
> -               else
> -                       return PTR_ERR(pll_clk);
> +               dsi->pll_clk =3D devm_clk_get(dev, "sclk_mipi");
> +               if (IS_ERR(dsi->pll_clk))
> +                       return PTR_ERR(dsi->pll_clk);
>         }
>
>         /* If it doesn't exist, use pixel clock instead of failing */
> diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsu=
ng-dsim.h
> index 05100e91ecb9..31ff88f152fb 100644
> --- a/include/drm/bridge/samsung-dsim.h
> +++ b/include/drm/bridge/samsung-dsim.h
> @@ -87,6 +87,7 @@ struct samsung_dsim {
>         void __iomem *reg_base;
>         struct phy *phy;
>         struct clk **clks;
> +       struct clk *pll_clk;
>         struct regulator_bulk_data supplies[2];
>         int irq;
>         struct gpio_desc *te_gpio;
>
> --
> 2.39.2
>
