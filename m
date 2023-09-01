Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E369D78FC65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349195AbjIALkk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 07:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345319AbjIALki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:40:38 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D7E10DE;
        Fri,  1 Sep 2023 04:40:34 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-58fae4a5285so19795937b3.0;
        Fri, 01 Sep 2023 04:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693568433; x=1694173233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkv0L31Q5D5FJO/hIrhq5apL36PuzcVnftNBKaUnVoc=;
        b=U4FDhPlOivPVv7zWnXuskOee3wepPMe3LSEgGW4TuH0tUSD2wxHKve69XwbL8cCwq8
         NJR1V1nd2l4enNzp5X8y58VW+gv7H2dnsg7GFEg5DsdCTVTbDsDvAaWGtOTxQB/qURX6
         4Ie19uVwY/NtzhgZssxeSJOwEuy9pai9g6+mk9B0mhSbmbUqP2bX6coJurPlmwbS1UKK
         UhKHkse6bbsvoioSxDokwjz1R9hfVnhu4ZMIR4EaT3PXgCjpSAfYML0Xq5ckxL7KAoTb
         vfj9gwomQTXGgWotanGpwXYnmfZ4qFJgfwi4h3feOQAv/j5XSvwNqogPAVW7VGUZIDPw
         2DOg==
X-Gm-Message-State: AOJu0Yy2zpfX2lntjy1bUaaN0IygMTmvnEnwT8QZeogcnzHFEVzsoyEV
        GMqG8AYjgAkcAa1YH8B8org2l+EqIAqMZg==
X-Google-Smtp-Source: AGHT+IHOse64sEjbb4mUMY8VJu02Kksli2yqqHNCfrz0957YlkTL7YW0bgkorvUnABtoju+B/Uzm7A==
X-Received: by 2002:a0d:d341:0:b0:58c:b8b4:2785 with SMTP id v62-20020a0dd341000000b0058cb8b42785mr2165278ywd.45.1693568432949;
        Fri, 01 Sep 2023 04:40:32 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id z7-20020a816507000000b00592a065e2a3sm1010845ywb.87.2023.09.01.04.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 04:40:32 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7e904674aeso221024276.3;
        Fri, 01 Sep 2023 04:40:32 -0700 (PDT)
X-Received: by 2002:a25:dcf:0:b0:d36:58a6:3281 with SMTP id
 198-20020a250dcf000000b00d3658a63281mr2321384ybn.39.1693568432089; Fri, 01
 Sep 2023 04:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230901113703.314667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901113703.314667-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 13:40:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVbR3mAgJ4UoeBSgesLPTuo-RVrRE_cLZZHwqJAhuVLFA@mail.gmail.com>
Message-ID: <CAMuHMdVbR3mAgJ4UoeBSgesLPTuo-RVrRE_cLZZHwqJAhuVLFA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Kconfig: Allow selecting MMC_SDHI_INTERNAL_DMAC
 for RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Fri, Sep 1, 2023 at 1:37 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Make MMC_SDHI_INTERNAL_DMAC visible for RISC-V architecture so that we can
> select this config option for RZ/Five SoC which is based on RISC-V
> architecture.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> I was in two minds here whether I should instead add dependency for
> ARCH_R9A07G043 instead of RISCV. But adding dependency for RISCV allows
> us to get this config option freely for future coming RISC-V Renesas
> SoCs.
>
> Cheers, Prabhakar
> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 554e67103c1a..5190881cb204 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -677,9 +677,9 @@ config MMC_SDHI_SYS_DMAC
>
>  config MMC_SDHI_INTERNAL_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
> -       depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || COMPILE_TEST
> +       depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || RISCV || COMPILE_TEST
>         depends on MMC_SDHI
> -       default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470)
> +       default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || RISCV)

This would expose this option to a growing number of non-Renesas
RISC-V platforms.  What about using ARCH_RENESAS || COMPILE_TEST
instead?

>         help
>           This provides DMA support for SDHI SD/SDIO controllers
>           using on-chip bus mastering. This supports the controllers

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
