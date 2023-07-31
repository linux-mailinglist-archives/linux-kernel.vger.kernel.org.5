Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE037694EA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjGaLbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGaLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:31:13 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8120BF;
        Mon, 31 Jul 2023 04:31:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-78374596182so211614039f.0;
        Mon, 31 Jul 2023 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690803069; x=1691407869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHKapT8ENC1PBKGVYqZ8+yi9plL2LAZnMYWeD7e3EEU=;
        b=rxNtYrRbXqOYxRS9kDvn2jIorEe0tMwLkhQbdLtCeg2LMahuhY+AD0VizzYt9MqWzK
         NSW9me+dqBNMVjf69EY7lQeHpBctWIcEwfVvLVbPsdfpVqlhtEYcN5Jq1OA+Gh0uBKEo
         t/KmSIFj+kNNanL3NTfZbEfE1gcq/bAZHFrJKqo8XOH1aiemRKxyZeF0o1LBQ8RgrYdH
         NwjyM+ZQVUpse5QlG4RwkfnYE8NSS4M6nSJrpt+gIJgSzeQ6cy/fDrDhHeSB8p92khYV
         /EWv7WnbO23VWY7iPm6qlF5wa6eTA/Qk00oUX7ioRyaSvyUw0C7Pu7HSbKZzxg8QTHEL
         IpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690803069; x=1691407869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHKapT8ENC1PBKGVYqZ8+yi9plL2LAZnMYWeD7e3EEU=;
        b=hDGEblBORrffXnAnscP8YzDYbZGKwlpRMshrwoxqIknqTOke1vzmsLnHZb43tmdpJI
         V8pxO6q5Y3jCWgBGf3U0LK+J+W76sLGI5vi9bRfooXzZTATMHSPpPLKHlHS950ADsdlj
         QqXJcKiy85vdE6lC9pqrgcC/1zv2lBT8n5cDgHTnQ0fWV2XpZjPWeP6EE0yw6nWPFxus
         ZfyclHtm/crRteQqj2TkiBFq/WHYzuiAMPxWuTGKcTEuVuBoIMAsLgrArwtChB7SNXWK
         3L2qeAgpfKAzYjowsskGerEE0H6E9cNo1Fn8AJZeVGO5xhLt7d7mjDmWD+ghe490vVf+
         z/OA==
X-Gm-Message-State: ABy/qLbkyNojfL+OwKhBdi9UfPEriniTd3zQSv8ogVMFT6N6CkIl1XXV
        s/BHypj8MmRIds7XlcqMYl6sMp5XAh0B95cq5Hg=
X-Google-Smtp-Source: APBJJlFq9Ropxw2PjeLIl7PNITQTwYriwtj1i23jeO3NOZmYTFNq9toLfh7UIBnYNUzm2Q68tkUVbF5bdsZGUkRVAz0=
X-Received: by 2002:a5e:c608:0:b0:790:88df:2cf6 with SMTP id
 f8-20020a5ec608000000b0079088df2cf6mr1640891iok.10.1690803069072; Mon, 31 Jul
 2023 04:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230702203429.237615-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230702203429.237615-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <ZMZ6XB6gX2kFd/Nt@xhacker>
In-Reply-To: <ZMZ6XB6gX2kFd/Nt@xhacker>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 31 Jul 2023 12:30:43 +0100
Message-ID: <CA+V-a8u3F_XDjBfVVVvNMfjrni8pgpcRgbVt6_Ax1TmG2fJdEg@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
To:     Jisheng Zhang <jszhang@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

Thank you for the review.

On Sun, Jul 30, 2023 at 4:09=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Sun, Jul 02, 2023 at 09:34:26PM +0100, Prabhakar wrote:
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
> >       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> >       select DMA_DIRECT_REMAP
> >
> > +config RISCV_NONSTANDARD_CACHE_OPS
> > +     bool
> > +     depends on RISCV_DMA_NONCOHERENT
> > +     help
> > +       This enables function pointer support for non-standard noncoher=
ent
> > +       systems to handle cache management.
>
> Per Documentation/riscv/patch-acceptance.rst:
>
> "we'll only consider patches for extensions that either:
>
> - Have been officially frozen or ratified by the RISC-V Foundation, or
> - Have been implemented in hardware that is widely available, per standar=
d
>   Linux practice."
>
> I'm not sure which item this patch series belongs to.
>
Maybe Conor can help me here ;)

> > +
> >  config AS_HAS_INSN
> >       def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(co=
mma) t0$(comma) zero)
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
>
> can we reword this line as
> "struct riscv_nonstd_cache_ops - Structure for non-standard CMO function
> pointers" to explictly note this is only for non-standard CMO.
>
Sure I will update it.

Cheers,
Prabhakar

> > + *
> > + * @wback: Function pointer for cache writeback
> > + * @inv: Function pointer for invalidating cache
> > + * @wback_inv: Function pointer for flushing the cache (writeback + in=
validating)
> > + */
> > +struct riscv_cache_ops {
> > +     void (*wback)(phys_addr_t paddr, unsigned long size);
> > +     void (*inv)(phys_addr_t paddr, unsigned long size);
> > +     void (*wback_inv)(phys_addr_t paddr, unsigned long size);
> > +};
> > +
> > +extern struct riscv_cache_ops noncoherent_cache_ops;
> > +
> > +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops=
 *ops);
> > +
> > +#endif       /* __ASM_DMA_NONCOHERENT_H */
> > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoh=
erent.c
> > index b9a9f57e02be..4c2e3f1cdfe6 100644
> > --- a/arch/riscv/mm/dma-noncoherent.c
> > +++ b/arch/riscv/mm/dma-noncoherent.c
> > @@ -9,13 +9,26 @@
> >  #include <linux/dma-map-ops.h>
> >  #include <linux/mm.h>
> >  #include <asm/cacheflush.h>
> > +#include <asm/dma-noncoherent.h>
> >
> >  static bool noncoherent_supported;
> >
> > +struct riscv_cache_ops noncoherent_cache_ops __ro_after_init =3D {
> > +     .wback =3D NULL,
> > +     .inv =3D NULL,
> > +     .wback_inv =3D NULL,
> > +};
> > +
> >  static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size=
)
> >  {
> >       void *vaddr =3D phys_to_virt(paddr);
> >
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +     if (unlikely(noncoherent_cache_ops.wback)) {
>
> I'm worried about the performance impact here.
> For unified kernel Image reason, RISCV_NONSTANDARD_CACHE_OPS will be
> enabled by default, so standard CMO and T-HEAD's CMO platform's
> performance will be impacted, because even an unlikely is put
> here, the check action still needs to be done.
>
> > +             noncoherent_cache_ops.wback(paddr, size);
> > +             return;
> > +     }
> > +#endif
> >       ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> >  }
> >
> > @@ -23,6 +36,13 @@ static inline void arch_dma_cache_inv(phys_addr_t pa=
ddr, size_t size)
> >  {
> >       void *vaddr =3D phys_to_virt(paddr);
> >
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +     if (unlikely(noncoherent_cache_ops.inv)) {
> > +             noncoherent_cache_ops.inv(paddr, size);
> > +             return;
> > +     }
> > +#endif
> > +
> >       ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
> >  }
> >
> > @@ -30,6 +50,13 @@ static inline void arch_dma_cache_wback_inv(phys_add=
r_t paddr, size_t size)
> >  {
> >       void *vaddr =3D phys_to_virt(paddr);
> >
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +     if (unlikely(noncoherent_cache_ops.wback_inv)) {
> > +             noncoherent_cache_ops.wback_inv(paddr, size);
> > +             return;
> > +     }
> > +#endif
> > +
> >       ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> >  }
> >
> > @@ -50,6 +77,13 @@ void arch_dma_prep_coherent(struct page *page, size_=
t size)
> >  {
> >       void *flush_addr =3D page_address(page);
> >
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +     if (unlikely(noncoherent_cache_ops.wback_inv)) {
> > +             noncoherent_cache_ops.wback_inv(page_to_phys(page), size)=
;
> > +             return;
> > +     }
> > +#endif
> > +
> >       ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
> >  }
> >
> > @@ -75,3 +109,12 @@ void riscv_noncoherent_supported(void)
> >            "Non-coherent DMA support enabled without a block size\n");
> >       noncoherent_supported =3D true;
> >  }
> > +
> > +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops=
 *ops)
> > +{
> > +     if (!ops)
> > +             return;
> > +
> > +     noncoherent_cache_ops =3D *ops;
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
> > +     if (unlikely(noncoherent_cache_ops.wback)) {
> > +             noncoherent_cache_ops.wback(virt_to_phys(addr), size);
> > +             return;
> > +     }
> > +#endif
> >       ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
> >  }
> >  EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
> >
> >  void arch_invalidate_pmem(void *addr, size_t size)
> >  {
> > +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> > +     if (unlikely(noncoherent_cache_ops.inv)) {
> > +             noncoherent_cache_ops.inv(virt_to_phys(addr), size);
> > +             return;
> > +     }
> > +#endif
> >       ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
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
