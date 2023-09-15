Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E9E7A210E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjIOOcW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbjIOOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:32:21 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B397139;
        Fri, 15 Sep 2023 07:32:17 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59bdb3d03b1so23521067b3.3;
        Fri, 15 Sep 2023 07:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788336; x=1695393136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbw1RUjzbN7U5EVUe70Salt9UZtTqMKxSnkWEm+iEPo=;
        b=MBxz2YobIhITfloBgFoRDd/TYQ/m8cywlWlif4/DjYcPqSY1c2pOWGs1zXj1bGaovw
         VdxlASF93NlId9LJzIgtfZY13vb3LyDJFyj2YBhc1L4TfN9Y8DPxMOiqDqkbAdVPwk6b
         wt0hBOaChDjJeXOIoZhizncSMxigvGa6eg8KWeXcUmAR53mN3ar+v6tOalAHaV4fBHSt
         CM5v1/mriBSHpLycuxTkYgt7GaOnNeXpq6I2fNylaspXJVjJP+SbqsRYfu8U/57RHNnt
         IK5ORd5lFkDVs+ncCPkEoCMPdVaX+6HzMYRY7ytK+Ylw6lDahz54Ga0fuJ8ps+3mOyAa
         I3kQ==
X-Gm-Message-State: AOJu0YwmRwikTbKi4PKxuUyX0FPjRky8vO05cB9oB//zXQWMBna2emwo
        N2ZiAuCpptKN7XeWvoOODJFyxYoUzy3SLA==
X-Google-Smtp-Source: AGHT+IH0yVdoxQnAK58e9vhORA1SXDwH6C6D58hoDQWeK7kdqQMI6egFDJI9N5U346pDLcUnGdSoRw==
X-Received: by 2002:a81:5404:0:b0:59b:ec10:9165 with SMTP id i4-20020a815404000000b0059bec109165mr1714878ywb.24.1694788335905;
        Fri, 15 Sep 2023 07:32:15 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id a144-20020a0dd896000000b005869f734036sm892240ywe.19.2023.09.15.07.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 07:32:15 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d81d09d883dso622425276.0;
        Fri, 15 Sep 2023 07:32:14 -0700 (PDT)
X-Received: by 2002:a25:40c:0:b0:d22:c8b9:8c9b with SMTP id
 12-20020a25040c000000b00d22c8b98c9bmr1616720ybe.13.1694788334663; Fri, 15 Sep
 2023 07:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-35-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-35-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 16:32:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUiW3q4YrKfNCf+w7Z-bsa6fYxODDTrLHd3EKirLeCmGQ@mail.gmail.com>
Message-ID: <CAMuHMdUiW3q4YrKfNCf+w7Z-bsa6fYxODDTrLHd3EKirLeCmGQ@mail.gmail.com>
Subject: Re: [PATCH 34/37] arm64: dts: renesas: rzg3s-smarc: add initial
 device tree for RZ SMARC Carrier-II board
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add initial device tree for RZ SMARC Carrier-II. At the moment it
> contains only serial interface (and its pins definition).
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the RZ SMARC Carrier-II Board.
> + *
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
> +
> +/ {
> +       aliases {
> +               serial0 = &scif0;
> +       };
> +};
> +
> +&pinctrl {
> +       scif0_pins: scif0 {
> +               pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* TXD */

RXD

> +                        <RZG2L_PORT_PINMUX(6, 4, 1)>; /* RXD */

TXD

> +       };
> +};

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
