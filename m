Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CAE791116
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352281AbjIDFpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbjIDFps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:45:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994AF195
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 22:45:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so1344624a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 22:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693806319; x=1694411119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MglyBahDCvrWMJ2RZEEmrN2FTqQO/eyX7/1BX76JNMA=;
        b=PdOeLLTqP4AoYImNe2rsWCOJSpyA5HPwHH9rqw+l0xjEceewdtN4GRKK9TAFaqWFO9
         LZTSlOthKDS76t1AeXZ6Jggl3m3PrL5ck/7xZv+9nwUayZ5j56KEoMBaCLqUwlOUmdnU
         ELLW7wOXMMM3hmO94IjKGbExewpbINcMW9vSs6u/4LQKf4h6bVHkdm+6SVAv4yHucjRI
         tImOKK0jdprg0v5FB01DmxmFKsRDJym9qEqM1Q1KxShTziK9gn3GFnxZHI1srg3Q7ueb
         gMlzk/S/JKZqW2bOH83ZBsQ1U2Z9MVWPhybtpN4icj5pr2RbE25svcifsMpXxlRhNahU
         aNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693806319; x=1694411119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MglyBahDCvrWMJ2RZEEmrN2FTqQO/eyX7/1BX76JNMA=;
        b=eZIDqwCl7tFfDGePvfxNWrbO1rU6FOOC+BgTp2glSqz5lqgalKdcmxNdFPq0nWtecj
         KPCSDhQFVdaGcsv15fFs7u+gsnzhyYWFVfQ+B7vDRsd0V1DJu/J35/gj+Bc3r8+tYG2Z
         5syTP/T9F9CsANDK8dFTgAAdwutD/D/fpUNbAP540jooeTHdMTrPJNod1gZTvum0gbXh
         hHFJYA0cHqOLFdzs7LXFuyKvCaGzMphpgDDRIuXHxEoGHM9eK4KyPu4I3tWMi+ynFiKf
         3e+1JK76CecwIWRmI9Ierxu5XBwbeZsdR7t4OYDG4W0mVJYyrMqUyaQBuPhkK1i7rVGE
         B2xA==
X-Gm-Message-State: AOJu0YyzZg0BW5zKXbI05ZauyPW5+LsBtMjUU89xvGUscLtvLa5aSdmp
        YGsiR/qi+teOhOLZBGPVKN7IbCPRjsvV+2bor2qYLPQ8K0AqUQ==
X-Google-Smtp-Source: AGHT+IG8tkv3pgHLNQ+rbiqbFKIwSquIDVoNlAEQrDK2dlMnSMPK/remu92+rFnzLCkgMUq5HYBCs2xuIIn8MuDrXac=
X-Received: by 2002:a05:6402:1206:b0:523:2df6:395e with SMTP id
 c6-20020a056402120600b005232df6395emr6418956edw.31.1693806318816; Sun, 03 Sep
 2023 22:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230818-samsung-dsim-v1-0-b39716db6b7a@pengutronix.de> <20230818-samsung-dsim-v1-3-b39716db6b7a@pengutronix.de>
In-Reply-To: <20230818-samsung-dsim-v1-3-b39716db6b7a@pengutronix.de>
From:   Inki Dae <daeinki@gmail.com>
Date:   Mon, 4 Sep 2023 14:44:41 +0900
Message-ID: <CAAQKjZODcKE_O-Nb_qym0BqAZymUu9j24d+8-UXFsFQekJ=unw@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/bridge: samsung-dsim: update PLL reference clock
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
> The PLL requires a clock between 2 MHz and 30 MHz after the pre-divider.
> The reference clock for the PLL may change due to changes to it's parent
> clock. Thus, the frequency may be out of range or unsuited for
> generating the high speed clock for MIPI DSI.
>
> Try to keep the pre-devider small, and set the reference clock close to
> 30 MHz before recalculating the PLL configuration. Use a divider with a
> power of two for the reference clock as this seems to work best in
> my tests.

Clock frequency is specific to SoC architecture so we have to handle
it carefully because samsung-dsim.c is a common module for I.MX and
Exynos series.
You mentioned "The PLL requires a clock between 2 MHz and 3MHz after
pre-divider", and the clock means that fin_pll - PFD input frequency -
which can be calculated with oscillator clock frequency / P value?
According to Exynos datasheet, the fin_pll should be 6 ~ 12Mhz.

For example,
In case of Exyhos, we use 24MHz as oscillator clock frequency, so
fin_pll frequency, 8MHz =3D 24MHz / P(3).

Can you tell me the source of the constraint that clocks must be
between 2MHz and 30MHz?

To other I.MX and Exynos engineers, please do not merge this patch
until two SoC platforms are tested correctly.

Thanks,
Inki Dae

>
> Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index da90c2038042..4de6e4f116db 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -611,10 +611,21 @@ static unsigned long samsung_dsim_set_pll(struct sa=
msung_dsim *dsi,
>         u16 m;
>         u32 reg;
>
> -       if (dsi->pll_clk)
> +       if (dsi->pll_clk) {
> +               /*
> +                * Ensure that the reference clock is generated with a po=
wer of
> +                * two divider from its parent, but close to the PLLs upp=
er
> +                * limit of the valid range of 2 MHz to 30 MHz.
> +                */
> +               fin =3D clk_get_rate(clk_get_parent(dsi->pll_clk));
> +               while (fin > 30 * MHZ)
> +                       fin =3D fin / 2;
> +               clk_set_rate(dsi->pll_clk, fin);
> +
>                 fin =3D clk_get_rate(dsi->pll_clk);
> -       else
> +       } else {
>                 fin =3D dsi->pll_clk_rate;
> +       }
>         dev_dbg(dsi->dev, "PLL ref clock freq %lu\n", fin);
>
>         fout =3D samsung_dsim_pll_find_pms(dsi, fin, freq, &p, &m, &s);
>
> --
> 2.39.2
>
