Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCD6806D48
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378012AbjLFLE1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 06:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378018AbjLFLEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:04:10 -0500
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53F2D64;
        Wed,  6 Dec 2023 03:03:38 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5d3efc071e2so61083137b3.0;
        Wed, 06 Dec 2023 03:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860606; x=1702465406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVVREpeNBksiVzen2ZqgrQY7HZ3YW+vcOqMYYYjnJRc=;
        b=HpzMhqvRtcgKQV1bMsK9/EK1usIc1FOxaaNKDW4BSgMWweGdat+oCxQEwlCN1lW36g
         Ie9b7GP0zYgQ/AghSQ06exNW3b1Ty2Ns95sNEARrveXkCI+O1jE+/VRyK7y37RtWHHkI
         4AGDukpD5oqM12gMyD9+f75SlcoLtRopY/YhmpKuc8fYG85kDez8XFU6qfYfXnu26DDS
         TBUtwEudfCu2qyDKT3NtTie3CIB/DuZaywC2Zk13Qd9xLJ13ooucyyE+TkAAOHepClmx
         hL3JGMND5pIoJsw/lXoAGqzYDi6NjIZHBIp2MbkAMzV7bEFlu7qMIuwQFE8jG7Ol5D0J
         rt3w==
X-Gm-Message-State: AOJu0YyIrVYV/XTqJhiD4rdCBUNpDAE8JYSOAuTUhNCtJm9sBYINiwFP
        FeWMfjKJS2uQZn9ma/osR99MPCK807gNUQ==
X-Google-Smtp-Source: AGHT+IGG2chzZi55SmELOQzXjX9bd1TZrzeA0mEjt+D6WXX+5jYSxL9Dvx0HlQ5Rz4ISa7+d4inDwg==
X-Received: by 2002:a81:49d4:0:b0:5d3:e2a2:8bcd with SMTP id w203-20020a8149d4000000b005d3e2a28bcdmr539979ywa.5.1701860606103;
        Wed, 06 Dec 2023 03:03:26 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id l6-20020a0dc906000000b005add997ae53sm3940442ywd.81.2023.12.06.03.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:03:25 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db3a09e96daso5427460276.3;
        Wed, 06 Dec 2023 03:03:25 -0800 (PST)
X-Received: by 2002:a81:ae5a:0:b0:5d7:1941:2c23 with SMTP id
 g26-20020a81ae5a000000b005d719412c23mr477831ywk.80.1701860605566; Wed, 06 Dec
 2023 03:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com> <20231120070024.4079344-13-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20231120070024.4079344-13-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Dec 2023 12:03:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWa9wSDfwrz=WSpa9S16BnMCJHdEiJSNFB2m8gr_p8z9g@mail.gmail.com>
Message-ID: <CAMuHMdWa9wSDfwrz=WSpa9S16BnMCJHdEiJSNFB2m8gr_p8z9g@mail.gmail.com>
Subject: Re: [PATCH 12/14] arm64: dts: renesas: Improve documentation for SW_SD0_DEV_SEL
To:     Claudiu <claudiu.beznea@tuxon.dev>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Mon, Nov 20, 2023 at 8:03 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add switch OFF/OFF description to values of SW_SD0_DEV_SEL for
> better understanding.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -11,8 +11,8 @@
>  /*
>   * Signals of SW_CONFIG switches:
>   * @SW_SD0_DEV_SEL:
> - *     0 - SD0 is connected to eMMC
> - *     1 - SD0 is connected to uSD0 card
> + *     0 - (switch OFF) SD0 is connected to eMMC
> + *     1 - (switch ON)  SD0 is connected to uSD0 card
>   * @SW_SD2_EN:
>   *     0 - (switch OFF) SD2 is connected to SoC
>   *     1 - (switch ON)  SCIF1, SSI0, IRQ0, IRQ1 connected to SoC

I guess this makes sense
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
