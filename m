Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ED477F4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350096AbjHQLA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350092AbjHQK7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:59:54 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F652D4A;
        Thu, 17 Aug 2023 03:59:52 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-349a7cb1a5cso21780685ab.0;
        Thu, 17 Aug 2023 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692269992; x=1692874792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TQ4tvtMT0eRr/6y3AA5pQgog1fMxlbrTcPcxQMF188=;
        b=Txv3H08eo8bHyYkj9tUjOe62ROpPG7oUtFu/1OSBY0f8nUhe04BnPLeNgykO3PTQNg
         AVKIcNP0SU05DSziel69DOciTf4y5vHunWM0fMVPSlQWWyzcPGksEXGtHLR1832hUIjB
         /G061LBkJWZ7M4p6PfHKFzjBn0cQFaYiFfoMDpEaXadLlSps4lm/2pSmEcsGlFRdJiQC
         PjSC8H3EkeZRj0iD9orLOCuT0UZYqywDu9BixmfUp79oz3w0vm2rUvpVcjkx2bE5GFVg
         PhObXggIcEeYD+sQviPE2hq6g8isi4Vh2eDMHEZSblIrB50geQdKuxK5dGFJKbBCHMhH
         91xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692269992; x=1692874792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TQ4tvtMT0eRr/6y3AA5pQgog1fMxlbrTcPcxQMF188=;
        b=SyCv0QQKQCCo5EFwHhydkE3PQHvDCfCf7o+MqxruxsPcLHnmX3Dvcs39GcZ7jOMv4i
         dKh3M9KrmpWow0DkVb4HVaKwFfGYHcq6zZkghi8h/eHT6ZXO6WdF3UsuVek3jUts0+Me
         0d2Ob9oVW0vdwFVgXJvLv4hvdZSkwSlwtb3H6jSJWy1NN5QTmvNJDncG+ZV4JunFhdhz
         ZiQQwedCVIwSLTqyU7J3HTDv7TtDcr/LxgR3MW5918WI5lsqQZU4jykPquMW19EN5pBB
         FWrkbSH4sxlw4YcDp7wXWxlKET1SQqeQtjn8kfvZwt7YyWr7hARI+1sO49xRSHdS6JZ9
         6XxQ==
X-Gm-Message-State: AOJu0YzNKaWL7mQm93apy/LwvJH4bFhGYiTVVYw3ZAxAPJT0XQt2s+Vg
        Po76F0Vo9kD1eUskRNyybMvhO4xkww72DTtfBWFJorHdYVo=
X-Google-Smtp-Source: AGHT+IE80RO6zrV3OcM8Gw0wTy8tb9ce66LX6zf8cpCpT+HSyDctOwZM38hcLuWcTYke2+J5eCnreQTrSEvpTML62x4=
X-Received: by 2002:a05:6e02:1c28:b0:348:d5dd:247 with SMTP id
 m8-20020a056e021c2800b00348d5dd0247mr6285271ilh.6.1692269992063; Thu, 17 Aug
 2023 03:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230814205719.79647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230814205719.79647-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAJM55Z8mx5RNq5PVcBPqvw22qAqbJXjcYga_fvYdJe_LZynE3w@mail.gmail.com>
In-Reply-To: <CAJM55Z8mx5RNq5PVcBPqvw22qAqbJXjcYga_fvYdJe_LZynE3w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 17 Aug 2023 11:59:23 +0100
Message-ID: <CA+V-a8vcEKGcX+ZindU45QMYjSE-ZOHreUELC__9ZwqAAfxxLg@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] riscv: mm: dma-noncoherent: nonstandard cache
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

Thank you for the review.

On Thu, Aug 17, 2023 at 11:54=E2=80=AFAM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> On Mon, 14 Aug 2023 at 23:00, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
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
> > v10 -> v11
> > * Changed data type of size from unsigned long to size_t
> > * Reworded doc for struct riscv_cache_ops
> >
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
> > index f52dd125ac5e..a629d383affb 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -269,6 +269,13 @@ config RISCV_DMA_NONCOHERENT
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
> > index 000000000000..2fc43f73f766
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
> > + * struct riscv_nonstd_cache_ops - Structure for non-standard CMO func=
tion pointers
>
> It seems you updated the name in this comment..
>
> > + *
> > + * @wback: Function pointer for cache writeback
> > + * @inv: Function pointer for invalidating cache
> > + * @wback_inv: Function pointer for flushing the cache (writeback + in=
validating)
> > + */
> > +struct riscv_cache_ops {
>
> ..but not the actual struct. I don't have any opinion on which is the
> best name, but they should probably match.
>
Argh! Thanks for pointing out that I'll fix it and resend the series.

Cheers,
Prabhakar

> > +       void (*wback)(phys_addr_t paddr, size_t size);
> > +       void (*inv)(phys_addr_t paddr, size_t size);
> > +       void (*wback_inv)(phys_addr_t paddr, size_t size);
> > +};
> > +
> > +extern struct riscv_cache_ops noncoherent_cache_ops;
> > +
> > +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops=
 *ops);
> > +
> > +#endif /* __ASM_DMA_NONCOHERENT_H */
> > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoh=
erent.c
> > index b6a1e9cc9339..853446525a19 100644
> > --- a/arch/riscv/mm/dma-noncoherent.c
> > +++ b/arch/riscv/mm/dma-noncoherent.c
> > @@ -9,13 +9,26 @@
> >  #include <linux/dma-map-ops.h>
> >  #include <linux/mm.h>
> >  #include <asm/cacheflush.h>
> > +#include <asm/dma-noncoherent.h>
> >
> >  static bool noncoherent_supported __ro_after_init;
> >
> > +struct riscv_cache_ops noncoherent_cache_ops __ro_after_init =3D {
> > +       .wback =3D NULL,
> > +       .inv =3D NULL,
> > +       .wback_inv =3D NULL,
> > +};
> > +
> >  static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size=
)
> >  {
> >         void *vaddr =3D phys_to_virt(paddr);
> >
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +       if (unlikely(noncoherent_cache_ops.wback)) {
> > +               noncoherent_cache_ops.wback(paddr, size);
> > +               return;
> > +       }
> > +#endif
> >         ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> >  }
> >
> > @@ -23,6 +36,13 @@ static inline void arch_dma_cache_inv(phys_addr_t pa=
ddr, size_t size)
> >  {
> >         void *vaddr =3D phys_to_virt(paddr);
> >
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +       if (unlikely(noncoherent_cache_ops.inv)) {
> > +               noncoherent_cache_ops.inv(paddr, size);
> > +               return;
> > +       }
> > +#endif
> > +
> >         ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
> >  }
> >
> > @@ -30,6 +50,13 @@ static inline void arch_dma_cache_wback_inv(phys_add=
r_t paddr, size_t size)
> >  {
> >         void *vaddr =3D phys_to_virt(paddr);
> >
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +       if (unlikely(noncoherent_cache_ops.wback_inv)) {
> > +               noncoherent_cache_ops.wback_inv(paddr, size);
> > +               return;
> > +       }
> > +#endif
> > +
> >         ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> >  }
> >
> > @@ -49,6 +76,13 @@ void arch_dma_prep_coherent(struct page *page, size_=
t size)
> >  {
> >         void *flush_addr =3D page_address(page);
> >
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +       if (unlikely(noncoherent_cache_ops.wback_inv)) {
> > +               noncoherent_cache_ops.wback_inv(page_to_phys(page), siz=
e);
> > +               return;
> > +       }
> > +#endif
> > +
> >         ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
> >  }
> >
> > @@ -74,3 +108,12 @@ void riscv_noncoherent_supported(void)
> >              "Non-coherent DMA support enabled without a block size\n")=
;
> >         noncoherent_supported =3D true;
> >  }
> > +
> > +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops=
 *ops)
> > +{
> > +       if (!ops)
> > +               return;
> > +
> > +       noncoherent_cache_ops =3D *ops;
> > +}
> > +EXPORT_SYMBOL_GPL(riscv_noncoherent_register_cache_ops);
> > diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
> > index 089df92ae876..c5fc5ec96f6d 100644
> > --- a/arch/riscv/mm/pmem.c
> > +++ b/arch/riscv/mm/pmem.c
> > @@ -7,15 +7,28 @@
> >  #include <linux/libnvdimm.h>
> >
> >  #include <asm/cacheflush.h>
> > +#include <asm/dma-noncoherent.h>
> >
> >  void arch_wb_cache_pmem(void *addr, size_t size)
> >  {
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +       if (unlikely(noncoherent_cache_ops.wback)) {
> > +               noncoherent_cache_ops.wback(virt_to_phys(addr), size);
> > +               return;
> > +       }
> > +#endif
> >         ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
> >  }
> >  EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
> >
> >  void arch_invalidate_pmem(void *addr, size_t size)
> >  {
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +       if (unlikely(noncoherent_cache_ops.inv)) {
> > +               noncoherent_cache_ops.inv(virt_to_phys(addr), size);
> > +               return;
> > +       }
> > +#endif
> >         ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
> >  }
> >  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
