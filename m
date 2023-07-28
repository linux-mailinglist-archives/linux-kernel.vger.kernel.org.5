Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0447676CB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjG1UNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjG1UNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:13:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCBB423B;
        Fri, 28 Jul 2023 13:13:44 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-786bb09e595so87069939f.1;
        Fri, 28 Jul 2023 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690575223; x=1691180023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yi4y6ZcKjQCRx6lPzKR1GjQXQiW3JC1NO2YhCreRSs=;
        b=HU7pf3oVc852y4gzP5y7q0EvjMiN9Rq5u7b6XbVcNPL2KSmaoEVEGW58JMaylcZ89Q
         4o1OONt9UVbD1fgLkOxmxzv9L+P1DHf1nBDb2iY+jiuqAD6qJxjgjJBqsLYYukgWTV31
         Lhm/1rmqI93vnyvZZH8WQFTCenXKJhjj0PWDJwaOTB4q1ogZZHTuSgY7J0gvjQYuiodv
         64C4hvrWIRcvJi3QRLV/PDFVJAmyKTDK2hKkTycY1h4RW1zUIOpdDmx4EG6Kf1FRX1S8
         iUEFJQOjlw0JPT6CmbCJNB8EiBWycZP+zeN+8ffVPskmpvmEUrKK/aHioXv3Cq4QbcSI
         oPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690575223; x=1691180023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yi4y6ZcKjQCRx6lPzKR1GjQXQiW3JC1NO2YhCreRSs=;
        b=Wsa5dZnoOKcCaTPkmfckFmF3QfRqeNqMbbGBMEywQM5OMSYQaA5h7DKKfaaRsesobC
         euQOPp/CjK0MGxjx1Yi5r4UsFYrqJL5ajvRl2tWcjoFHCD+W1H9kgy0SPJHgkvTRhlwl
         4A289KHgh5KST1E4gmWuHvkTlMSyWJrG8EAVtnkGOMAlzeqZtMNp6O5miRgi5lGQ+Pc8
         7Cjh9KIZ3VFYB6X8bj5W8j7ciTjE8IJUKApzzpPyb88OtAyRNZ6FTmWknnYbboyhY+w4
         ZwMHlo5iE7UL59c7/J4H3kBL2LQvDVJ7NySfu4wsLhsJk5nMpNE0c3tDk+1LJ+nqO2cl
         5Ktg==
X-Gm-Message-State: ABy/qLYFxTPAHnsTL1YVoaQhjX4QhEL+R6Bzs46+2zPVpmZP2tx4AQgx
        Y9nadyy/b04fQB9SedEPlGyt3ZHZ0Wyg+MHRUns=
X-Google-Smtp-Source: APBJJlFWTZEQ6ng+2uju8cCmZwsRwrxZX3okqbaSKeW6MRb/Zg2+oTPl9jAlRLfiuzAvOTYAWMvkDLuIU2LV6NMaCI0=
X-Received: by 2002:a05:6602:381:b0:783:4135:5b96 with SMTP id
 f1-20020a056602038100b0078341355b96mr421356iov.5.1690575223536; Fri, 28 Jul
 2023 13:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAJM55Z_udpELaTdszqwGbOUyOQ3D4ROqmmQ1=_i6Qb8E8pJd1w@mail.gmail.com>
In-Reply-To: <CAJM55Z_udpELaTdszqwGbOUyOQ3D4ROqmmQ1=_i6Qb8E8pJd1w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 28 Jul 2023 21:13:17 +0100
Message-ID: <CA+V-a8tpYHwSNDKh5OKBc-+uP6p55_AOZiwN3cceXjv69Oijmg@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

Thank you for the review.

On Mon, Jul 24, 2023 at 11:18=E2=80=AFAM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> On Sun, 2 Jul 2023 at 22:36, Prabhakar <prabhakar.csengg@gmail.com> wrote=
:
> >
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Introduce support for nonstandard noncoherent systems in the RISC-V
> > architecture. It enables function pointer support to handle cache
> > management in such systems.
> >
> > This patch adds a new configuration option called
> > "RISCV_NONSTANDARD_CACHE_OPS." This option is a boolean flag that
> > depends on "RISCV_DMA_NONCOHERENT" and enables the function pointer
> > support for cache management in nonstandard noncoherent systems.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on =
a d1
> > ---
> > v9 -> v10
> > * Added __ro_after_init compiler attribute for noncoherent_cache_ops
> > * Renamed clean -> wback
> > * Renamed inval -> inv
> > * Renamed flush -> wback_inv
> >
> > v8 -> v9
> > * New patch
> > ---
> >  arch/riscv/Kconfig                       |  7 ++++
> >  arch/riscv/include/asm/dma-noncoherent.h | 28 +++++++++++++++
> >  arch/riscv/mm/dma-noncoherent.c          | 43 ++++++++++++++++++++++++
> >  arch/riscv/mm/pmem.c                     | 13 +++++++
> >  4 files changed, 91 insertions(+)
> >  create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d9e451ac862a..42c86b13c5e1 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -265,6 +265,13 @@ config RISCV_DMA_NONCOHERENT
> >         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> >         select DMA_DIRECT_REMAP
> >
> > +config RISCV_NONSTANDARD_CACHE_OPS
> > +       bool
> > +       depends on RISCV_DMA_NONCOHERENT
> > +       help
> > +         This enables function pointer support for non-standard noncoh=
erent
> > +         systems to handle cache management.
> > +
> >  config AS_HAS_INSN
> >         def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(=
comma) t0$(comma) zero)
> >
> > diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/incl=
ude/asm/dma-noncoherent.h
> > new file mode 100644
> > index 000000000000..969cf1f1363a
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/dma-noncoherent.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2023 Renesas Electronics Corp.
> > + */
> > +
> > +#ifndef __ASM_DMA_NONCOHERENT_H
> > +#define __ASM_DMA_NONCOHERENT_H
> > +
> > +#include <linux/dma-direct.h>
> > +
> > +/*
> > + * struct riscv_cache_ops - Structure for CMO function pointers
> > + *
> > + * @wback: Function pointer for cache writeback
> > + * @inv: Function pointer for invalidating cache
> > + * @wback_inv: Function pointer for flushing the cache (writeback + in=
validating)
> > + */
> > +struct riscv_cache_ops {
> > +       void (*wback)(phys_addr_t paddr, unsigned long size);
> > +       void (*inv)(phys_addr_t paddr, unsigned long size);
> > +       void (*wback_inv)(phys_addr_t paddr, unsigned long size);
>
> Hi Prabhakar
>
> Just a quick question. After Arnd's patchset the
> arch_dma_cache{inv,wback,wback_inv} functions take a phys_addr_t and
> size_t, but here you want these callbacks to take a phys_addr_t and
> unsigned long instead. Why not keep them using size_t?
>
Agreed, I will update it to use size_t instead.

Cheers,
Prabhakar
