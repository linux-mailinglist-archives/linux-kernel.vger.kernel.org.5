Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A528802E09
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjLDJAN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 04:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjLDJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:00:10 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E685;
        Mon,  4 Dec 2023 01:00:16 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5cd81e76164so46172117b3.1;
        Mon, 04 Dec 2023 01:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701680415; x=1702285215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zv4xm2Lr7Wl/3u3PM4BZ5e6ASOFA8kBT22UWNSzI29A=;
        b=W4IcEPU/06rXnT8zKoV97sb61dfK4jvSzjiUKRd2h1ZIyGrOSEWewb93tkXsKxgV0A
         fyS58euO9pu8E/Prk+l6TktdqcACF3vGncdOCtMy+fDvDZoWUOpNizD1SapCF0RWwX6O
         YsuR8gHtx8OnYuPVHwooZhdRrP1knUbl8uAuUskgOPKHy+oYiguzK/1Ipb8zhRusOrIC
         8kXq5aHCzc9YPk8ByTt7hGCsXbZUgql4kjw0i8VXu9DUdkYRUM/+v4we+hnqt/wVybT4
         +KObvOxtQ5ZoAx6J+fPx7AYaFDBBQbUHT6RjAu8f48MK51cg5Usm8EFMslZZ5F9Ycp6b
         /ozQ==
X-Gm-Message-State: AOJu0YxZ2wOAHYwftq2KHj7FQYSatZvhZXiVTiKlxHcT9T8CnFhyDdZl
        iwaID55UoVvq3WjwHFYsTJLOj0auQvS88A==
X-Google-Smtp-Source: AGHT+IFLHN5lVcrEbK+UZgMtBA8xq+NoiT1Pt2RM2CuumlHSXQwJJCsSPcRznYrTmXwNk4ReaxfVGQ==
X-Received: by 2002:a81:7847:0:b0:5d7:1940:dd77 with SMTP id t68-20020a817847000000b005d71940dd77mr2172352ywc.77.1701680415246;
        Mon, 04 Dec 2023 01:00:15 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id v136-20020a81488e000000b005d8bb479c51sm458655ywa.11.2023.12.04.01.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 01:00:15 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5d4f71f7e9fso27337927b3.0;
        Mon, 04 Dec 2023 01:00:15 -0800 (PST)
X-Received: by 2002:a81:d206:0:b0:5d7:6089:9617 with SMTP id
 x6-20020a81d206000000b005d760899617mr2012816ywi.24.1701680414955; Mon, 04 Dec
 2023 01:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-11-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdW9Unpw7NQOGWd4SeFV8XgvRYTKTXnt9Tsagb3Q3U9tNA@mail.gmail.com>
 <96dd3f54-9560-4587-b4e8-bf75422ff5ef@tuxon.dev> <CAMuHMdWGbEhBdzK4Swu4uX05vX7H2Ow4uE1C=JVNOrdcbZYL=A@mail.gmail.com>
 <b3701927-e41a-44d8-8f91-da245b76f532@tuxon.dev>
In-Reply-To: <b3701927-e41a-44d8-8f91-da245b76f532@tuxon.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Dec 2023 10:00:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVmD7-AUn91SaOq1iOMkcGhi0WNvx8bCX3oD+xa-Bt98g@mail.gmail.com>
Message-ID: <CAMuHMdVmD7-AUn91SaOq1iOMkcGhi0WNvx8bCX3oD+xa-Bt98g@mail.gmail.com>
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

On Mon, Dec 4, 2023 at 9:38 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> On 04.12.2023 10:02, Geert Uytterhoeven wrote:
> > On Mon, Dec 4, 2023 at 8:41 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> >> On 01.12.2023 19:35, Geert Uytterhoeven wrote:
> >>> On Mon, Nov 20, 2023 at 8:01 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>
> >>>> Add Ethernet nodes available on RZ/G3S (R9A08G045).
> >>>>
> >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>> Thanks for your patch!
> >>>
> >>>> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> >>>> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> >>>> @@ -149,6 +149,38 @@ sdhi2: mmc@11c20000 {
> >>>>                         status = "disabled";
> >>>>                 };
> >>>>
> >>>> +               eth0: ethernet@11c30000 {
> >>>> +                       compatible = "renesas,r9a08g045-gbeth", "renesas,rzg2l-gbeth";
> >>>> +                       reg = <0 0x11c30000 0 0x10000>;
> >>>> +                       interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                                    <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
> >>>> +                                    <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
> >>>> +                       interrupt-names = "mux", "fil", "arp_ns";
> >>>> +                       clocks = <&cpg CPG_MOD R9A08G045_ETH0_CLK_AXI>,
> >>>> +                                <&cpg CPG_MOD R9A08G045_ETH0_CLK_CHI>,
> >>>> +                                <&cpg CPG_MOD R9A08G045_ETH0_REFCLK>;
> >>>> +                       clock-names = "axi", "chi", "refclk";
> >>>> +                       resets = <&cpg R9A08G045_ETH0_RST_HW_N>;
> >>>> +                       power-domains = <&cpg>;
> >>>
> >>> Perhaps add a default phy mode, like on other SoCs?
> >>>
> >>>     phy-mode = "rgmii"';
> >>
> >> I skipped this (even it was available on the other SoCs) as I consider the
> >> phy-mode is board specific.
> >
> > IC.  Still, it's good to have some consistency across boards.
> >
> >>> Also missing:
> >>>
> >>>     #address-cells = <1>;
> >>>     #size-cells = <0>;
> >>
> >> Same for these.
> >
> > These are required, and always have the same values, so it makes more
> > sense to have them in the SoC .dtsi file, once.
>
> I remember I had a compilation warning with an Ethernet controller
> configured with fixed-link having #address-cells, #size-cells. With
> fixed-link these were not needed.

I think EtherAVB always use MDIO for management, so fixed-link is
not applicable.

> Anyway... I'll keep all in dtsi if you prefer it this way.

Yes please, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
