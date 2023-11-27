Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E267F9D18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjK0KIM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 05:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjK0KIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:08:09 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE6C0;
        Mon, 27 Nov 2023 02:08:16 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1fa4b632198so464242fac.1;
        Mon, 27 Nov 2023 02:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701079695; x=1701684495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VnyBshkvXGTRRsL4y6lDrPgLjR5JtfcTMrPcPvPYA4=;
        b=QUtqLED33HtNG437p14zBWcM4SfHTEF9znRZwISMeRQvYo7yCMS7p7EU2/l0OCne7p
         +9EcGlUUuBNCcXMqvHwDx7Bx6jjDnniA57CkWogSYadvHFBhflw93VezeEDRoE7FWuNl
         Si+fNaqMWyTjM6xBqbiEsMPKZw2MR3pVwSbF7fhRqf5Kb5+KaTOBS1V25n1/Ic4U+88R
         PtDiiutjumpFHvDuCIyrva2Oge9zheG7Y+g6/VYhkurpPZCnZsTguFMw0t7bqCuVgDWu
         gYi3GLO4dV9rrfavnNdQK8ZGcbJx9T6DAqFX4GJf+g++tTOXl+zWclhUfeL04dTehjdH
         zC7A==
X-Gm-Message-State: AOJu0YzZ8pWa/DIuXFshRDQGxdxFhztJsBiiMqGnQ4cmxMARMKPCNLcv
        tKrZgYQarAERahy7SPNyHYWp2/kT4nKNAQ==
X-Google-Smtp-Source: AGHT+IHBatFEKsPQJkcu6tgxnyooX+qUGzUREsYOnQk4kiyIbtLawY1X7SUpYwr5DJByTKNNmyvkhQ==
X-Received: by 2002:a05:6870:4d08:b0:1e9:9179:4c6f with SMTP id pn8-20020a0568704d0800b001e991794c6fmr14319770oab.49.1701079695133;
        Mon, 27 Nov 2023 02:08:15 -0800 (PST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id gb10-20020a056870670a00b001dd8c46ed49sm1525052oab.8.2023.11.27.02.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 02:08:14 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1eb39505ba4so2654872fac.0;
        Mon, 27 Nov 2023 02:08:14 -0800 (PST)
X-Received: by 2002:a0d:eb0b:0:b0:5cc:d0bc:fc31 with SMTP id
 u11-20020a0deb0b000000b005ccd0bcfc31mr10889619ywe.24.1701079330823; Mon, 27
 Nov 2023 02:02:10 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-15-claudiu.beznea.uj@bp.renesas.com>
 <bd25377b-b191-4d81-b144-2936cb5139d9@app.fastmail.com> <CAMuHMdUkVO7cXpsHd_oGvEpZdJpP6GP+VC8H5GAZ94KJf2joLA@mail.gmail.com>
In-Reply-To: <CAMuHMdUkVO7cXpsHd_oGvEpZdJpP6GP+VC8H5GAZ94KJf2joLA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Nov 2023 11:01:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUWHMgA8EAhYk1DUx0P85D5=K26aUoBrLsCMr4=Uw4Qrg@mail.gmail.com>
Message-ID: <CAMuHMdUWHMgA8EAhYk1DUx0P85D5=K26aUoBrLsCMr4=Uw4Qrg@mail.gmail.com>
Subject: Re: [PATCH 14/14] arm: multi_v7_defconfig: Enable CONFIG_RAVB
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Davis <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        eugen.hristev@collabora.com, sergei.shtylyov@gmail.com,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Mon, Nov 20, 2023 at 9:58 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, Nov 20, 2023 at 9:44 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Nov 20, 2023, at 08:00, Claudiu wrote:
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > > ravb driver is used by RZ/G1H. Enable it in multi_v7_defconfig.
>
> Used by:
>   - iWave-RZ/G1M/G1N Qseven carrier board,
>   - iWave-RZ/G1H Qseven board,
>   - iWave-RZG1E SODIMM carrier board,
>   - iWave-RZ/G1C single board computer.
>
> So I'd write "used by various iWave RZ/G1 development boards".

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.8, with the above updated.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
