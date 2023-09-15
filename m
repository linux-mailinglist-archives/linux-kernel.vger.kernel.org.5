Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6957A1DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjIOMAG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 15 Sep 2023 08:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIOMAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:00:05 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E2D1FF1;
        Fri, 15 Sep 2023 04:59:57 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59bebd5bdadso20485277b3.0;
        Fri, 15 Sep 2023 04:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694779196; x=1695383996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3w3Hc9oT+9ZccWQwVTHbvcVnVRL/HUfvJ1knY0q2Ic=;
        b=QvdyYF7XWIEv80sdYY6EUpSVHSU/LFAaMJZ3D2+xk7UhXKvAQb7+m8qQh4c0+OFzmU
         DnBTI0sFTVVdCCdyiIoN6I5pI6RznmlX6oYN6YOC74kgOxtM4RNb9vMUxmuPkA2kHITa
         azl/pVvjpaN+T0Px8EkrWaZtuACKHj98Ue/idsYHXpVZKLgvq5wKEZ5ybLHhKw9K6zYX
         Et1XaO4KO2SDuXR5llh72kNxHOkHsJaVTDj9uhT4QgFWVE9ScQ20SsjwlKSd0o1cXF2x
         KPFzKKBS7ywyU24b+1D52gHbt8tZm8cQg257nSK5bbzEe3H6xAEfdWZL/dkuOKCp33tm
         N0vQ==
X-Gm-Message-State: AOJu0YxLd3xMyYCDly0SDA0xevtcc5RYbm1vV4FsiauDTQFpu30Xx+V+
        HvBRCB69PT3ecBqDo8O71ZGoKQn4cwC+/w==
X-Google-Smtp-Source: AGHT+IGu2Nx4aW4E+cePSYiOtC0ayVxYccNOTgkQKYTSdC/0cQKD2QCiezIjz7s0G+LmdHqX3R8bgw==
X-Received: by 2002:a81:5fc2:0:b0:59b:4bb2:fc2c with SMTP id t185-20020a815fc2000000b0059b4bb2fc2cmr1598737ywb.48.1694779196081;
        Fri, 15 Sep 2023 04:59:56 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id r82-20020a815d55000000b0059b2be24f88sm812554ywb.143.2023.09.15.04.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:59:55 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d7f0a60a159so1872051276.0;
        Fri, 15 Sep 2023 04:59:55 -0700 (PDT)
X-Received: by 2002:a25:2555:0:b0:d77:dcff:e7b2 with SMTP id
 l82-20020a252555000000b00d77dcffe7b2mr1234044ybl.39.1694779195344; Fri, 15
 Sep 2023 04:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com> <20230912045157.177966-22-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20230912045157.177966-22-claudiu.beznea.uj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Sep 2023 13:59:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWc6yy=oJDo4zMdvB-t8pjCuE1oJ_Y6Ck0aX_hPkfhPug@mail.gmail.com>
Message-ID: <CAMuHMdWc6yy=oJDo4zMdvB-t8pjCuE1oJ_Y6Ck0aX_hPkfhPug@mail.gmail.com>
Subject: Re: [PATCH 21/37] dt-bindings: clock: add r9a08g045 CPG clocks and
 resets definitions
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

On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Add RZ/G3S (R9A08G045) Clock Pulse Generator (CPG) core clocks, module
> clocks and resets.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/include/dt-bindings/clock/r9a08g045-cpg.h

> +/* R9A08G045 Module Clocks */

> +#define R9A08G045_USB_U2H0_HCLK                65
> +#define R9A08G045_USB_U2H1_HCLK                66
> +#define R9A08G045_USB_U2P_EXR_CPUCLK   67
> +#define R9A08G045_USB_PCLK             68
> +#define R9A08G045_USB_SCLK             69

There is no USB_SCLK bit in CPG_CLKON_USB, so please drop
R9A08G045_USB_SCLK.

> +/* R9A08G045 Resets */

> +#define R9A08G045_SRAM_ACPU_ARESETN0   11
> +#define R9A08G045_SRAM_ACPU_ARESETN1   12
> +#define R9A08G045_SRAM_ACPU_ARESETN2   13

There is no SRAM_ACPU_ARESETN2 bit in CPG_RST_SRAM_MCPU,
so please drop R9A08G045_SRAM_ACPU_ARESETN2.

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
