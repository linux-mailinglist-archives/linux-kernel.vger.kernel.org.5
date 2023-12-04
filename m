Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E5802CC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjLDIKO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 03:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjLDIKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:10:12 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C2CD3;
        Mon,  4 Dec 2023 00:10:17 -0800 (PST)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77ecedad216so167078985a.3;
        Mon, 04 Dec 2023 00:10:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701677416; x=1702282216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS1L7NOGg06KDGUFGFQufZ/HHPyLo1FuHzjQoQBHem0=;
        b=AJDhA2a12rQ4GM5Ze2j/Tg6roXa8OWdP5wSSt0DwFyHzHryz2sfNgmt4kb1zefq4tq
         vGBRe/AP+ZvEB+xFbp9Lefx68ubxbdJOk4XwFHswhLY5Wl7tBzrIPLc88bgz0s3XwlTk
         ZemqAAcKr3CEzwrjPlMTVboH0HlVw8rC+3+Dxji1++Gp6nMhBpEUDBqI43cb9/+AqvUe
         /ORKEV4jgxScpFNbkAd3IHr5FBU48x4X5aKsMvIsYOwpH1MCkvMc7C5RRUjhSl09Pl2O
         9/VAH6uKp+32FYXZwkeOneZ1weMPOwRqBAc2BJw/pl2XBu/oDuuE5dIeFDqbL/4oGRGL
         QYLQ==
X-Gm-Message-State: AOJu0YzJyQKdbQrui8yThNu2O+3r4RYNrFieOUWUQZ/E2xgFZf2VTbVD
        Q0lP2ujoDZWIjD2vcwCE0nTOSFWC5NxGSQ==
X-Google-Smtp-Source: AGHT+IH+88HvOfduf9w2+EiioRSXS0hHuKcr9eAKG4NAcvE5FKea0kdXX4iOqq4chMrYwfMNzMSrwQ==
X-Received: by 2002:a05:6214:964:b0:67a:a721:d782 with SMTP id do4-20020a056214096400b0067aa721d782mr4233333qvb.104.1701677416575;
        Mon, 04 Dec 2023 00:10:16 -0800 (PST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id rg3-20020a05620a8ec300b0077703f31496sm4042370qkn.92.2023.12.04.00.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:10:16 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-77dd07e7d39so308509385a.0;
        Mon, 04 Dec 2023 00:10:16 -0800 (PST)
X-Received: by 2002:a0d:ebd4:0:b0:5d7:1940:f3ef with SMTP id
 u203-20020a0debd4000000b005d71940f3efmr3110087ywe.87.1701676944345; Mon, 04
 Dec 2023 00:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-11-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdW9Unpw7NQOGWd4SeFV8XgvRYTKTXnt9Tsagb3Q3U9tNA@mail.gmail.com> <96dd3f54-9560-4587-b4e8-bf75422ff5ef@tuxon.dev>
In-Reply-To: <96dd3f54-9560-4587-b4e8-bf75422ff5ef@tuxon.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Dec 2023 09:02:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWGbEhBdzK4Swu4uX05vX7H2Ow4uE1C=JVNOrdcbZYL=A@mail.gmail.com>
Message-ID: <CAMuHMdWGbEhBdzK4Swu4uX05vX7H2Ow4uE1C=JVNOrdcbZYL=A@mail.gmail.com>
Subject: Re: [PATCH 10/14] arm64: renesas: r9a08g045: Add Ethernet nodes
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux@armlinux.org.uk, magnus.damm@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de, arnd@arndb.de,
        m.szyprowski@samsung.com, alexandre.torgue@foss.st.com, afd@ti.com,
        broonie@kernel.org, alexander.stein@ew.tq-group.com,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Mon, Dec 4, 2023 at 8:41 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> On 01.12.2023 19:35, Geert Uytterhoeven wrote:
> > On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Add Ethernet nodes available on RZ/G3S (R9A08G045).
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> >> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> >> @@ -149,6 +149,38 @@ sdhi2: mmc@11c20000 {
> >>                         status = "disabled";
> >>                 };
> >>
> >> +               eth0: ethernet@11c30000 {
> >> +                       compatible = "renesas,r9a08g045-gbeth", "renesas,rzg2l-gbeth";
> >> +                       reg = <0 0x11c30000 0 0x10000>;
> >> +                       interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> >> +                                    <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> >> +                                    <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       interrupt-names = "mux", "fil", "arp_ns";
> >> +                       clocks = <&cpg CPG_MOD R9A08G045_ETH0_CLK_AXI>,
> >> +                                <&cpg CPG_MOD R9A08G045_ETH0_CLK_CHI>,
> >> +                                <&cpg CPG_MOD R9A08G045_ETH0_REFCLK>;
> >> +                       clock-names = "axi", "chi", "refclk";
> >> +                       resets = <&cpg R9A08G045_ETH0_RST_HW_N>;
> >> +                       power-domains = <&cpg>;
> >
> > Perhaps add a default phy mode, like on other SoCs?
> >
> >     phy-mode = "rgmii"';
>
> I skipped this (even it was available on the other SoCs) as I consider the
> phy-mode is board specific.

IC.  Still, it's good to have some consistency across boards.

> > Also missing:
> >
> >     #address-cells = <1>;
> >     #size-cells = <0>;
>
> Same for these.

These are required, and always have the same values, so it makes more
sense to have them in the SoC .dtsi file, once.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
