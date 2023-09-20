Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DA57A83B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbjITNoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjITNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:44:29 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1AAD;
        Wed, 20 Sep 2023 06:44:23 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4962ea9921aso2682665e0c.0;
        Wed, 20 Sep 2023 06:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695217462; x=1695822262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95fTQPVKJHWmCHRYGh/6GuNTqeE/4yo9MhUnxDaE2lo=;
        b=CB0wsID4G4zWqt++NXEzpOaoNFWcw4IxRRt5gXO70xHnC1/fyV71xpb75nTQqol9Iu
         SwhhSL/uA7+zmlv7VnCOAfoW17mI7ei2SHMRY6tBNRW3GBqgQ4E2jssSZZldg/JMXPAP
         T6pp+f/wCjhyAgTZwbTJubSAvA4IZq+vMRvhz1iACvH8YPHHmcKyjkqQQeAyTfjDSvMI
         D/oawpmL5mBIeg05ACF3auxGooFM25KbyMCH+tIoQJfMzGr+vKzRDz5sMwqS2JKSWzZC
         KYxsz64Fy4PWJ4vkeQ5NHPmnsHJ5J04ohbfsR+Ei+hRNTEIgE7Z3Q1S6+eFY1PJIPiyn
         cRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217462; x=1695822262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95fTQPVKJHWmCHRYGh/6GuNTqeE/4yo9MhUnxDaE2lo=;
        b=PqEV+7aVztKDXkKKQFa1wbGJdDc/KLALsKIaIvegz2L8QD+dPAuwcb1hWS5DTJxQfv
         Xdum/Lz9xe50nxi0TO6cjRtF3Tai+cJnt9ubfl+w+Jkk1/yf+Jv+Z4lfCyJ7Req0EnRJ
         z19bKblu5zF95l6BzqbOzBJm6i/wAfGGWtpFV4wEZXdqSFSn7paiL9Au0BAcSOCvDOJC
         eGQYu7YYfX3jXtWUPkq9PFBmnyzGRxumUKo/eFfpebhn13fUqhwRuIQrnRnjGzQQRH53
         cWinsvIAa1DkqgsTGO65gJzbAemuQ7Pku0xufOm5jIaX/xxnvwotWcoNb7DeGp7U9LK2
         FUfg==
X-Gm-Message-State: AOJu0YzWg/RkTc3uGU7aW6bqmwZKuscCeP33gMhuyroNe/G+xa59mP8w
        fYYeMuhnGfIJ67CjSf4S11EC8XQgceNlTw4YgrE=
X-Google-Smtp-Source: AGHT+IHMmwuzvv3m+YOPL1VZk9naST2BH9KaMdyZjYBGtPJKZd+26gmjj5LV5wpQUnYyN5k5pq3Aj7bDw4GZyw78O1M=
X-Received: by 2002:a1f:4c43:0:b0:48f:e2eb:6dd9 with SMTP id
 z64-20020a1f4c43000000b0048fe2eb6dd9mr2628965vka.8.1695217462414; Wed, 20 Sep
 2023 06:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-24-claudiu.beznea.uj@bp.renesas.com> <CAMuHMdUwnsJ0uKeLtFcwB6a2nQtaSUPu0ZR7kYwQeEhKMhfXFQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUwnsJ0uKeLtFcwB6a2nQtaSUPu0ZR7kYwQeEhKMhfXFQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 20 Sep 2023 14:43:55 +0100
Message-ID: <CA+V-a8vQzBs-Qq0mRyjn_=ciqxna9Fw64dvnQCFF-0xLEx7Fmg@mail.gmail.com>
Subject: Re: [PATCH 23/37] pinctrl: renesas: rzg2l: index all registers based
 on port offset
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Claudiu <claudiu.beznea@tuxon.dev>,
        prabhakar.mahadev-lad.rj@bp.renesas.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
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

Hi Geert,

On Wed, Sep 20, 2023 at 2:22=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Claudiu,
>
> Thanks for your patch!
>
> On Tue, Sep 12, 2023 at 6:53=E2=80=AFAM Claudiu <claudiu.beznea@tuxon.dev=
> wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > To get address that needs to be read/write for specific port
> > functionalities the P(), PM(), PMC(), PFC(), PIN(), IOLH() IEN(), ISEL(=
)
> > macros are used. Some of these macros received as argument the hardware
> > port identifier, some hardware port offset address (e.g. ISEL() receive=
d
> > port identifier, IOLH() received port offset address). This makes hard =
to
> > extend the current driver for SoCs were port identifiers are not contin=
uous
> > in memory map of pin controller. This is the case for RZ/G3S pin contro=
ller
> > were ports are mapped as follows:
> >
> > port offset    port identifier
> > -----------    ---------------
> > 0x20           P0
> > 0x21           P5
> > 0x22           P6
> > 0x23           P11
> > 0x24           P12
> > 0x25           P13
> > 0x26           P14
> > 0x27           P15
> > 0x28           P16
> > 0x29           P17
> > 0x2a           P18
> > 0x30           P1
> > 0x31           P2
> > 0x32           P3
> > 0x33           P4
> > 0x34           P7
> > 0x35           P8
> > 0x36           P8
> > 0x37           P10
> >
> > To make this achievable change all the above macros used to get the add=
ress
> > of a port register for specific port functionality based on port hardwa=
re
> > address. Shortly, all the above macros will get as argument the port
> > offset address listed in the above table.
> >
> > With this RZG2L_SINGLE_PIN_GET_PORT_OFFSET() and
> > RZG2L_PIN_ID_TO_PORT_OFFSET() were replaced by
>
> and RZG2L_GPIO_PORT_GET_INDEX()?
>
> > RZG2L_PIN_CFG_TO_PORT_OFFSET(), RZG2L_SINGLE_PIN_GET_CFGS() and
> > RZG2L_GPIO_PORT_GET_CFGS() were replaced by RZG2L_PIN_CFG_TO_CAPS().
> >
> > Also rzg2l_pinctrl_set_pfc_mode() don't need port argument anymore.
> > Also rzg2l_gpio_direction_input() and rzg2l_gpio_direction_output() don=
't
> > need to translate port and bit locally as this can be done by
> > rzg2l_gpio_set_direction().
> >
> > To use the same naming for port, bit/pin and register offset the
> > port_offset variable names in different places was replaced by variable
> > named off and there is no need to initialize anymore cfg and bit in
> > different code places.
> >
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> This looks like a nice cleanup, thanks a lot!
> Prabhakar: do you like it, too?
>
Yes indeed, I loved it when I reviewed it internally. This makes it
easier for me to add those extra port pins present on rz/five ;)

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> You can find a few suggestions for improvement below...
>
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -202,9 +202,11 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_de=
v *pctldev,
> >                                  unsigned int group_selector)
> >  {
> >         struct rzg2l_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev=
);
> > +       const struct pinctrl_pin_desc *pin_desc;
> > +       unsigned int i, *psel_val, *pin_data;
> >         struct function_desc *func;
> > -       unsigned int i, *psel_val;
> >         struct group_desc *group;
> > +       u32 port, pin, off;
>
> Please move the new variable declarations inside the for(), and
> combine them with their initialization.
>
> >         int *pins;
> >
> >         func =3D pinmux_generic_get_function(pctldev, func_selector);
> > @@ -218,11 +220,17 @@ static int rzg2l_pinctrl_set_mux(struct pinctrl_d=
ev *pctldev,
> >         pins =3D group->pins;
> >
> >         for (i =3D 0; i < group->num_pins; i++) {
> > -               dev_dbg(pctrl->dev, "port:%u pin: %u PSEL:%u\n",
> > -                       RZG2L_PIN_ID_TO_PORT(pins[i]), RZG2L_PIN_ID_TO_=
PIN(pins[i]),
> > -                       psel_val[i]);
> > -               rzg2l_pinctrl_set_pfc_mode(pctrl, RZG2L_PIN_ID_TO_PORT(=
pins[i]),
> > -                                          RZG2L_PIN_ID_TO_PIN(pins[i])=
, psel_val[i]);
> > +               pin_desc =3D &pctrl->desc.pins[pins[i]];
> > +               pin_data =3D pin_desc->drv_data;
> > +
> > +               port =3D RZG2L_PIN_ID_TO_PORT(pins[i]);
>
> As port is unused but in the debug print, please drop the variable,
> and use RZG2L_PIN_ID_TO_PORT() in the debug print below.
>
> > +               pin =3D RZG2L_PIN_ID_TO_PIN(pins[i]);
> > +               off =3D RZG2L_PIN_CFG_TO_PORT_OFFSET(*pin_data);
> > +
> > +               dev_dbg(pctrl->dev, "port:%u pin: %u off:%x PSEL:%u\n",=
 port,
> > +                       pin, off, psel_val[i]);
> > +
> > +               rzg2l_pinctrl_set_pfc_mode(pctrl, pin, off, psel_val[i]=
);
> >         }
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
