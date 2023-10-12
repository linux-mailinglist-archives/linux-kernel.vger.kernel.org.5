Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329D77C6DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347235AbjJLMPj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 08:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343869AbjJLMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:15:37 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B0BA;
        Thu, 12 Oct 2023 05:15:35 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7c08b7744so10836377b3.3;
        Thu, 12 Oct 2023 05:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697112934; x=1697717734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wl3I/2bXbjqN636hLulYiW7jhp7Ro5bp+FnjB/CpQr8=;
        b=D2SNDzY+ZHbtLcrDP13ADGWzFLyjOuelw38N4+vtkphygQlvQPwEkdKsXPbPexFS0d
         CnIAdZ9/Q4B+YJfuL9S+wyoWOkG0UbDgBPC6DnYvk+QE936jjDo7Qe5Bq/9fg9yp/ou5
         uIc24FIkl5NfC3hbHyRU+3Dtpi/ERTxwCOHJTlJFxRqmLG3k80KO49so/b5L41loveFH
         Cdzxvs69fdzyrVRWVJPZaPDJ660loQjNdmfEeKdODjCGw4HlRojVp8wgMJbeeYgmjjfa
         d+ao4P6ZKCLHUM5wgIReix5n+dRwJjHDqnWtfo1uc/4Knti+nituE0Fre0a9N375wmoC
         WVMA==
X-Gm-Message-State: AOJu0Yx8yz1pg/3Sj80YoB609SvRzojRV7vhgyopWecJf4mRDxRAZCaX
        wQ/O6XFtpipofEGLVbo8EUG7XePMUUPCNg==
X-Google-Smtp-Source: AGHT+IFVBU3c9WPwENNvq83TUmSuvwtpSnPnE5ioJfpYzfXuzrqrKsxIIgzUHtnBsVOsx9AdrMzxSg==
X-Received: by 2002:a81:8742:0:b0:59f:6675:7771 with SMTP id x63-20020a818742000000b0059f66757771mr22443274ywf.35.1697112934475;
        Thu, 12 Oct 2023 05:15:34 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id g68-20020a0df647000000b0059b2be24f88sm5772597ywf.143.2023.10.12.05.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 05:15:33 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7b91faf40so11003367b3.1;
        Thu, 12 Oct 2023 05:15:33 -0700 (PDT)
X-Received: by 2002:a0d:d40f:0:b0:59b:fe46:82de with SMTP id
 w15-20020a0dd40f000000b0059bfe4682demr24538814ywd.18.1697112932799; Thu, 12
 Oct 2023 05:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231012-pouch-parkway-7d26c04b3300@spud>
In-Reply-To: <20231012-pouch-parkway-7d26c04b3300@spud>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 14:15:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWRzoBgxxkF6kpxr4tpUM4BzHnMUmW3vDR_BrrXiKae5Q@mail.gmail.com>
Message-ID: <CAMuHMdWRzoBgxxkF6kpxr4tpUM4BzHnMUmW3vDR_BrrXiKae5Q@mail.gmail.com>
Subject: Re: [PATCH v2] soc: renesas: make ARCH_R9A07G043 depend on required options
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Thu, Oct 12, 2023 at 1:11 PM Conor Dooley <conor@kernel.org> wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Randy reported a randconfig build issue against linux-next:
> WARNING: unmet direct dependencies detected for ERRATA_ANDES
>   Depends on [n]: RISCV_ALTERNATIVE [=n] && RISCV_SBI [=y]
>   Selected by [y]:
>   - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_SBI [=y]
>
> ../arch/riscv/errata/andes/errata.c:59:54: warning: 'struct alt_entry' declared inside parameter list will not be visible outside of this definition or declaration
>    59 | void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>
> On RISC-V, alternatives are not usable in XIP kernels, which this
> randconfig happened to select. Rather than add a check for whether
> alternatives are available before selecting the ERRATA_ANDES config
> option, rework the R9A07G043 Kconfig entry to depend on the
> configuration options required to support its non-standard cache
> coherency implementation.
>
> Without these options enabled, the SoC is effectively non-functional to
> begin with, so there's an extra benefit in preventing the creation of
> non-functional kernels.
>
> The "if RISCV_DMA_NONCOHERENT" can be dropped, as ERRATA_ANDES_CMO will
> select it.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/09a6b0f0-76a1-45e3-ab52-329c47393d1d@infradead.org/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>
> I dropped Randy's t-b etc since this patch is quite different.
>
> v2: drop the extra condition on the select of ERRATA_ANDES, move instead
> to depending on required options.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-fixes for v6.6.

> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -340,10 +340,12 @@ if RISCV
>  config ARCH_R9A07G043
>         bool "RISC-V Platform support for RZ/Five"
>         depends on NONPORTABLE
> +       depends on RISCV_ALTERNATIVE
> +       depends on RISCV_SBI
>         select ARCH_RZG2L
> -       select AX45MP_L2_CACHE if RISCV_DMA_NONCOHERENT
> +       select AX45MP_L2_CACHE
>         select DMA_GLOBAL_POOL
> -       select ERRATA_ANDES if RISCV_SBI
> +       select ERRATA_ANDES
>         select ERRATA_ANDES_CMO if ERRATA_ANDES

As ERRATA_ANDES is now selected unconditionally, the test
for it can be removed.  I can do that while applying.

>         help
>           This enables support for the Renesas RZ/Five SoC.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
