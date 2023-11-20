Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982187F0E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjKTI6y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 03:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjKTI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:58:52 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A9583;
        Mon, 20 Nov 2023 00:58:46 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5c9adcaf514so11814867b3.2;
        Mon, 20 Nov 2023 00:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470726; x=1701075526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18JbpiPMAEDFj6NXYlnrzta9l+LmgYRwVtYP+eE4AiM=;
        b=kIqfBCEsBy50pkCwU0QuQeeblaweWR539FfwYYLkSoqaUzENRLFoY52epOChRub0QI
         nDnYstgdjX7gybF1uHgfZNCR3IVc30gNFrJOTLNz1tW6mmPJ1Tifo3PxHgDENisNJ9Yk
         97JJJ4PAYB4KwYozM5ll70PEsCyWSPhEyvWgrtkY5LlUt2vgYAfFk4TJkViH9jdSZ3Nn
         dqqco3CmGjvMUH2ZPgZDIhEUrqWVm+cjzfvDE1QtpKcr89xN9vQU4ihE6wVVtvgNJK5p
         TSh6bx787h7MUG0tOfL1WiCdo22P/YloHe7dGYqJewY6SY0Aks2DKJu8OeipF5E18sgq
         CgZA==
X-Gm-Message-State: AOJu0YyzqPMt9lVz3IhFisoDDBrema9/oAeRwtWkGC0Xppoj4Wx3wkFL
        7TxJUpO5GQeOX2rgTQzhNXKix1XbNL0AUw==
X-Google-Smtp-Source: AGHT+IEcAKhmD2Cwhxx2WVp7uxIs04LulpgMIz9grHiBKuB8tFrxBucq43RCBbNt7vZs4H2MyknXxw==
X-Received: by 2002:a05:690c:2884:b0:5ca:a8b6:3319 with SMTP id ee4-20020a05690c288400b005caa8b63319mr937155ywb.52.1700470725764;
        Mon, 20 Nov 2023 00:58:45 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id s2-20020a819b02000000b005ca265f0c68sm717128ywg.42.2023.11.20.00.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:58:43 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-da819902678so3874391276.1;
        Mon, 20 Nov 2023 00:58:43 -0800 (PST)
X-Received: by 2002:a25:6a55:0:b0:da0:cfca:ed9 with SMTP id
 f82-20020a256a55000000b00da0cfca0ed9mr5235404ybc.12.1700470723057; Mon, 20
 Nov 2023 00:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
 <20231120070024.4079344-15-claudiu.beznea.uj@bp.renesas.com> <bd25377b-b191-4d81-b144-2936cb5139d9@app.fastmail.com>
In-Reply-To: <bd25377b-b191-4d81-b144-2936cb5139d9@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Nov 2023 09:58:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkVO7cXpsHd_oGvEpZdJpP6GP+VC8H5GAZ94KJf2joLA@mail.gmail.com>
Message-ID: <CAMuHMdUkVO7cXpsHd_oGvEpZdJpP6GP+VC8H5GAZ94KJf2joLA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 9:44 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Nov 20, 2023, at 08:00, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > ravb driver is used by RZ/G1H. Enable it in multi_v7_defconfig.

Used by:
  - iWave-RZ/G1M/G1N Qseven carrier board,
  - iWave-RZ/G1H Qseven board,
  - iWave-RZG1E SODIMM carrier board,
  - iWave-RZ/G1C single board computer.

So I'd write "used by various iWave RZ/G1 development boards".

> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> We have a mix of =y and =m for ethernet drivers, and usually
> only have drivers built-in when they are frequently tested
> with NFS root booting.
>
> Do you need this as well, or could it be =m instead?

As the default chosen/bootargs for the iWave-RZ/G1M/G1N Qseven carrier
board contains root=/dev/nfs, builtin is appropriate.
The iWave-RZ/G1H Qseven board defaults to root=/dev/mmcblk0p1.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
