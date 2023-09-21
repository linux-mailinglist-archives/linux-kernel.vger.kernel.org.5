Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B217A9F74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjIUUWL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 16:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIUUVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:21:40 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18164CB08;
        Thu, 21 Sep 2023 10:14:44 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a7f4f7a8easo496670b6e.2;
        Thu, 21 Sep 2023 10:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316422; x=1695921222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKEwqKwPZjLq0SDyfiZ/hvfF1GQ8y1eLifWNF455kwY=;
        b=B7cFVPIIBVX0cI46+Ze9XhzUcdWBDEILcO/7e9YjFEv1c7gp6iaItqxy2ioWNA/9mq
         V4lA2q7dJmX0DrgTP+Jr8DF7SbqU6tUIbKr2KD1f88rocjCyA/BBRWomV1ryLEhdlgLP
         TicgNBJEprIiUn81xHOBu3dQb3NKAU4EfkzibuMpqLLI0lS1iXJb5xQ4Fq8xzWvB9JW/
         onG9qZzMF3d0wsJmrXHhwXYBcHj3gXshaRtryTkiec0p0z/qKQ6yQjeTmY0FPhmZSPlz
         s+QFaoN4RAsmnEbXKiORtbsuUli0zFE54NDoX4sf7dyIR6bOkg8oy5bjz672PkRPjaB4
         9G8g==
X-Gm-Message-State: AOJu0YwUwwVnyM4CTC7teMLYWA6ZPqS32gnfJ1NCzDebt2zsi2WusnZO
        HYySenbnPebAiOPMcvD8hAmr2hU9j0Y8jzkq
X-Google-Smtp-Source: AGHT+IFW7qcWLpJD5ViEhuGjOSk4sVgu+ZDQVd/Km8akrpb9Yy4QbUppYWtYRTvOmYP1B2d2vSsBOw==
X-Received: by 2002:a25:4603:0:b0:d85:3b6a:c3b8 with SMTP id t3-20020a254603000000b00d853b6ac3b8mr4687097yba.45.1695300686808;
        Thu, 21 Sep 2023 05:51:26 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id x8-20020a259a08000000b00d7b8a1074d4sm301206ybn.57.2023.09.21.05.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 05:51:25 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59c0b5f984aso11259777b3.2;
        Thu, 21 Sep 2023 05:51:25 -0700 (PDT)
X-Received: by 2002:a0d:ff05:0:b0:58f:9cd8:9e4d with SMTP id
 p5-20020a0dff05000000b0058f9cd89e4dmr4594703ywf.46.1695300685164; Thu, 21 Sep
 2023 05:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-26-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-26-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Sep 2023 14:51:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVkttQpA-s0MrKbTVxJ6K+xXmhV3sNNLTAPSbDa0f8XYA@mail.gmail.com>
Message-ID: <CAMuHMdVkttQpA-s0MrKbTVxJ6K+xXmhV3sNNLTAPSbDa0f8XYA@mail.gmail.com>
Subject: Re: [PATCH 25/37] pinctrl: renesas: rzg2l: adapt function number for RZ/G3S
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Thanks for your patch!

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On RZ/G3S PFC register allow setting 8 functions for individual ports
> (function1 to function8). For function1 register need to be configured
> with 0, for function8 register need to be configured with 7.
> We cannot use zero based addressing when requesting functions from
> different code places as documentation (RZG3S_pinfunction_List_r1.0.xlsx)
> states explicitly that function0 has different meaning.

According to that table, function0 is GPIO.

> For this add a new member to struct rzg2l_hwcfg that will keep the
> offset that need to be substracted before applying a value to PFC register.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

But one question below...

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -136,9 +136,11 @@ struct rzg2l_register_offsets {
>  /**
>   * struct rzg2l_hwcfg - hardware configuration data structure
>   * @regs: hardware specific register offsets
> + * @func_base: base number for port function (see register PFC)
>   */
>  struct rzg2l_hwcfg {
>         const struct rzg2l_register_offsets regs;
> +       u8 func_base;
>  };
>
>  struct rzg2l_dedicated_configs {
> @@ -221,6 +223,7 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>                                  unsigned int group_selector)
>  {
>         struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> +       const struct rzg2l_hwcfg *hwcfg = pctrl->data->hwcfg;
>         const struct pinctrl_pin_desc *pin_desc;
>         unsigned int i, *psel_val, *pin_data;
>         struct function_desc *func;
> @@ -247,9 +250,9 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_dev *pctldev,
>                 off = RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
>
>                 dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n", port,
> -                       pin, off, psel_val[i]);
> +                       pin, off, psel_val[i] - hwcfg->func_base);
>
> -               rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]);
> +               rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i] - hwcfg->func_base);
>         }
>
>         return 0;

Perhaps the adjustment should be done in rzg2l_dt_subnode_to_map()
instead, when obtaining MUX_FUNC() from DT? That would allow you to do
some basic validation on it too, which is currently completely missing
(reject out-of-range values overflowing into adjacent PFC fields,
reject zero on RZ/G3S).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
