Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6974A78FD3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349441AbjIAM3W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Sep 2023 08:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIAM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:29:21 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F9D10CC;
        Fri,  1 Sep 2023 05:29:16 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59205f26e47so20134977b3.2;
        Fri, 01 Sep 2023 05:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571356; x=1694176156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+JqmmCRWd+UBK7TE3eZN/mZRKkS1SdaByqKLv8MuCg=;
        b=BRMohofskAuksh2mr7rjhwlxKFF9JzaCiCQQdw5VpW+x7DbkQj7sXMTCuKZCuxYx4H
         m+3RDYLIHI38NNs3vL3Wmfp2DXUQAi8gEchz5bPcpU4y8pA6x6K2yEw/Pe58URwQFjBW
         ZUo9RBrXCvvy6We4d9q9jlHa2DekwR8BeaUfoSmOhVbF1MtbVczZ4cEuw56QGqk5Ex/V
         CXMeGxH6RhMPGeoaVqmf/3IDCBznzPXX2mp9H+Yy4jZ0i4L1afIp4/BTKEQf5zpsChL+
         5J0Gdz3QCqK1dWSKmpS+vxirJSWuhYK1gvUIZPWnyNkX0+e+RSl2WjwAIp6HefuUafMo
         TvCA==
X-Gm-Message-State: AOJu0YzEJGo70cI67mqSEyaQO+v3IvP7DQnJRbKRc22bq3mxdrg2G6Jc
        ELAqV8jQ8zFzm8nCzJaOl9/c11q3kd7lWg==
X-Google-Smtp-Source: AGHT+IHSFRrr4oLZoLi924swoZjV+seAsmM1Of3+rJnmcfcqWUjTs3m8OPfCJKNJCvUutXEeVAOBnw==
X-Received: by 2002:a81:7287:0:b0:573:bb84:737c with SMTP id n129-20020a817287000000b00573bb84737cmr2306979ywc.26.1693571355847;
        Fri, 01 Sep 2023 05:29:15 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id q3-20020a0de703000000b005925c896bc3sm1033581ywe.53.2023.09.01.05.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:29:15 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d7260fae148so1526555276.1;
        Fri, 01 Sep 2023 05:29:15 -0700 (PDT)
X-Received: by 2002:a25:ae92:0:b0:d7a:ba02:eaa1 with SMTP id
 b18-20020a25ae92000000b00d7aba02eaa1mr2484522ybj.64.1693571355449; Fri, 01
 Sep 2023 05:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230901122701.318082-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230901122701.318082-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 14:29:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV7c4XA2AwU9o5gwO7RiFd-xeJS=n-Ojf3+-f-pVN5Ewg@mail.gmail.com>
Message-ID: <CAMuHMdV7c4XA2AwU9o5gwO7RiFd-xeJS=n-Ojf3+-f-pVN5Ewg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: Kconfig: Make MMC_SDHI_INTERNAL_DMAC config
 option dependant on ARCH_RENESAS
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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

CC Wolfram

On Fri, Sep 1, 2023 at 2:27 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> MMC_SDHI_INTERNAL_DMAC config option has dependency on ARM64 and
> R7S9210/R8A77470 this dependency will keep growing for future SoCs for
> varying architectures. So to simplify this configuration make
> MMC_SDHI_INTERNAL_DMAC solely depend on ARCH_RENESAS, as all Renesas
> SoCs inherently depend on the ARCH_RENESAS config option.
>
> This allows selecting MMC_SDHI_INTERNAL_DMAC config option for RZ/Five SoC
> which is based on RISC-V architecture.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1-v2
> * Add dependency on ARCH_RENESAS instead of RISCV

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> v1:
> https://lore.kernel.org/linux-renesas-soc/20230901113703.314667-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -677,9 +677,9 @@ config MMC_SDHI_SYS_DMAC
>
>  config MMC_SDHI_INTERNAL_DMAC
>         tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
> -       depends on ARM64 || ARCH_R7S9210 || ARCH_R8A77470 || COMPILE_TEST
> +       depends on ARCH_RENESAS || COMPILE_TEST
>         depends on MMC_SDHI
> -       default MMC_SDHI if (ARM64 || ARCH_R7S9210 || ARCH_R8A77470)
> +       default MMC_SDHI if ARCH_RENESAS
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
