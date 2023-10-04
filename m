Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1708C7B80C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbjJDNYq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 09:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjJDNYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:24:45 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A486A9;
        Wed,  4 Oct 2023 06:24:41 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a229ac185aso25236467b3.1;
        Wed, 04 Oct 2023 06:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425880; x=1697030680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WTWKqWv9XxY3T3p+WilR/Uka9qozvLswIeXHeaJ5Zjo=;
        b=d/OWf+dVsuyxW0Eb92ixam921/RCDC74Oxgj+arFYMZJ4JjJX5MVC1jJwe7+2CQbDS
         cv2bhsYdr4vzXXoULIKbeGUZtIybnT0nejF26uZzqjP4CGdUyUCAcKCGCXPo569msOyG
         kM9SwdyYYLe1Lum6XC9Hu5f7MOb8SHWWheNJT0V3ntfBPp16JF7ODh/rCW9eBOubCm8o
         3H00QbsRwvqL4vHlrkxCbBLSy1cJ1pFK3P4Hj3O+upj9LWOkvVPgIMqTtCBoRNzzAQAc
         gOsFXZPnLvGvdmRHLsKHBQFRYmfFji5ZLECxbvn6xibxqXQlOJAzwIK4jf1gVr1NMxsu
         tUBg==
X-Gm-Message-State: AOJu0Yy/tND801CunlEPmY26Q3W5kJN/yIIrJhWdASWg0QGUqwrcxij9
        znEbmI/O3v96dbX9H4VEvRfpDj3/t+wJFw==
X-Google-Smtp-Source: AGHT+IHSDxUn3f9g9KoPPpXrqH/9igegBo1XEdeU9DT0oZTSxqtmaooO5tHGrfLntv6UkJgdaUK1dA==
X-Received: by 2002:a81:5c57:0:b0:561:a123:1041 with SMTP id q84-20020a815c57000000b00561a1231041mr2498458ywb.29.1696425880316;
        Wed, 04 Oct 2023 06:24:40 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id i189-20020a8191c6000000b0059f802fad40sm1134275ywg.22.2023.10.04.06.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:24:39 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-579de633419so25108967b3.3;
        Wed, 04 Oct 2023 06:24:39 -0700 (PDT)
X-Received: by 2002:a0d:fb83:0:b0:586:e50:fb50 with SMTP id
 l125-20020a0dfb83000000b005860e50fb50mr2569096ywf.28.1696425879152; Wed, 04
 Oct 2023 06:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com> <20230929053915.1530607-22-claudiu.beznea@bp.renesas.com>
In-Reply-To: <20230929053915.1530607-22-claudiu.beznea@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 15:24:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU3+7sgOWoEOGkPmjP9mNQYx1_LAWVO7-0Wdt=B8OgR5g@mail.gmail.com>
Message-ID: <CAMuHMdU3+7sgOWoEOGkPmjP9mNQYx1_LAWVO7-0Wdt=B8OgR5g@mail.gmail.com>
Subject: Re: [PATCH v2 21/28] pinctrl: renesas: rzg2l: add support for RZ/G3S SoC
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, linux-renesas-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 7:40 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add basic support for RZ/G3S to be able to boot from SD card, have a
> running console port and use GPIOs. RZ/G3S has 82 general-purpose IO
> ports. Support for the remaining pin functions (e.g. Ethernet, XSPI)
> will be added along with controller specific support.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - dropped [RZG2L_IOLH_IDX_2V5 ... RZG2L_IOLH_IDX_3V3 - 1] =
>   RZG2L_INVALID_IOLH_VAL initializations from v1 as these are not needed
>   anymore with the new code adjustements
> - added BUILD_BUG_ON() for r9a08g045_gpio_configs[] in
>   rzg2l_pinctrl_probe()

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v6.7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
