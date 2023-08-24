Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03649786F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbjHXMhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjHXMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:36:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDDB171A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:36:36 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 811643FA97
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692880594;
        bh=JoJT4a5LMoBewyzrwMs8F7Ht2z6jukDla6MBC2nVmeI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=tt9U8NCGH/ZEPWLDxP5ffsfAVEqkGIx39gAghSYjKbyfrnYh+r2U0xfZkVqIw5KMr
         HfdBgoLDMj3hKMJG1OuIZpVqA8f+Tcuv5DSGwhrvCiNfzzMJKzkhtZmwG2dZ8AcPRU
         J5vQQH5pcJ5tPIYOJmwcesohGKb8yifUsL8E0lpvQ5/lOapf3iJptZfLKyUhJtm+Jf
         v15mw6iYEeO6gjWNqn8A+uLsB8Oj6XZr8JWygvBJjDhq0vFnWl4gghNrK7h3JFDLpe
         DcOhsx+RfWiRMk1VxuOdN7dBa3WTktSCC9enWGvXkW66CP5W1ZM2Vj7+Q1KxLa4QX9
         sTVfhQHgn02LQ==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40ffb4530ddso70401411cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880593; x=1693485393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoJT4a5LMoBewyzrwMs8F7Ht2z6jukDla6MBC2nVmeI=;
        b=QXcFO+beU7EbftaDV/ZZhPfFAzz+uCZ0egicrvKRZhUE6JgLqUe1MUoCKpWojQbOOL
         J4PlqImfXFag7Ld9MwN/Rnmq6yVQCFTaNV78Lm1UECHUjrXyJfwElfQpFUjJBoxDx03O
         jo/CIXaNw4vcp91IUQfFgmzlEmmt27dSrfRRZjnysRD/d1hyr1am+r8kn9Eu+mb9U3pw
         SuZ79sJbvTlblNNhXBGMl7P/EJ2V9XV+xQ/wEbqI/4nYq/wk1frOjRymcBqFZq1TQF07
         7ZsIrgG17zCbccudB6pfI3kQRHZ+ivuIIbP2iNjkW+BgP9sdUOouM28iwi2YzUneVZdv
         kNWQ==
X-Gm-Message-State: AOJu0YySUJB1yaFhNviGC7oVC2Nd6Av6E5ExOkwLK+HDOBB31wjN16Dx
        x/6LB80H0QdyH9LKQe2r/H0Q9REi/KZ/QVh4j1gk0f84G/foQkcxHmj8HsRchrbWbBRImkFgV+P
        VY3CZ531EOcj2Cjfn+cEujZ0aUyHmeFtPB358DeKQRMtsKvreqa6wJox4Lw==
X-Received: by 2002:a05:622a:2c2:b0:410:ac5a:e7b with SMTP id a2-20020a05622a02c200b00410ac5a0e7bmr5424877qtx.53.1692880593284;
        Thu, 24 Aug 2023 05:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+g+on5r/DtbY/oKVNkl5O7FS0UGCLx3I2RrRhwtFxoQDMeLCvtJe76K9ry9E2/afidK4c+yYzV7snrCuU6kQ=
X-Received: by 2002:a05:622a:2c2:b0:410:ac5a:e7b with SMTP id
 a2-20020a05622a02c200b00410ac5a0e7bmr5424861qtx.53.1692880592997; Thu, 24 Aug
 2023 05:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230818135723.80612-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230818135723.80612-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230818135723.80612-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 24 Aug 2023 14:36:16 +0200
Message-ID: <CAJM55Z-9jUze3hjAeK+J1GQ1fSz0u3Lk=Y=cJfzi+wPHswsTHw@mail.gmail.com>
Subject: Re: [PATCH v12 3/6] riscv: mm: dma-noncoherent: nonstandard cache
 operations support
To:     Prabhakar <prabhakar.csengg@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 at 15:57, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Introduce support for nonstandard noncoherent systems in the RISC-V
> architecture. It enables function pointer support to handle cache
> management in such systems.
>
> This patch adds a new configuration option called
> "RISCV_NONSTANDARD_CACHE_OPS." This option is a boolean flag that
> depends on "RISCV_DMA_NONCOHERENT" and enables the function pointer
> support for cache management in nonstandard noncoherent systems.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com> #
on the StarFive JH7100

> ---
> v11 -> v12
> * Renamed struct riscv_cache_ops -> struct riscv_nonstd_cache_ops
>
> v10 -> v11
> * Changed data type of size from unsigned long to size_t
> * Reworded doc for struct riscv_cache_ops
>
> v9 -> v10
> * Added __ro_after_init compiler attribute for noncoherent_cache_ops
> * Renamed clean -> wback
> * Renamed inval -> inv
> * Renamed flush -> wback_inv
>
> v8 -> v9
> * New patch
> ---
>  arch/riscv/Kconfig                       |  7 ++++
>  arch/riscv/include/asm/dma-noncoherent.h | 28 +++++++++++++++
>  arch/riscv/mm/dma-noncoherent.c          | 43 ++++++++++++++++++++++++
>  arch/riscv/mm/pmem.c                     | 13 +++++++
>  4 files changed, 91 insertions(+)
>  create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f52dd125ac5e..a629d383affb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -269,6 +269,13 @@ config RISCV_DMA_NONCOHERENT
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>         select DMA_DIRECT_REMAP
>
> +config RISCV_NONSTANDARD_CACHE_OPS
> +       bool
> +       depends on RISCV_DMA_NONCOHERENT
> +       help
> +         This enables function pointer support for non-standard noncoherent
> +         systems to handle cache management.
> +
>  config AS_HAS_INSN
>         def_bool $(as-instr,.insn r 51$(comma) 0$(comma) 0$(comma) t0$(comma) t0$(comma) zero)
>
> diff --git a/arch/riscv/include/asm/dma-noncoherent.h b/arch/riscv/include/asm/dma-noncoherent.h
> new file mode 100644
> index 000000000000..312cfa0858fb
> --- /dev/null
> +++ b/arch/riscv/include/asm/dma-noncoherent.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Renesas Electronics Corp.
> + */
> +
> +#ifndef __ASM_DMA_NONCOHERENT_H
> +#define __ASM_DMA_NONCOHERENT_H
> +
> +#include <linux/dma-direct.h>
> +
> +/*
> + * struct riscv_nonstd_cache_ops - Structure for non-standard CMO function pointers
> + *
> + * @wback: Function pointer for cache writeback
> + * @inv: Function pointer for invalidating cache
> + * @wback_inv: Function pointer for flushing the cache (writeback + invalidating)
> + */
> +struct riscv_nonstd_cache_ops {
> +       void (*wback)(phys_addr_t paddr, size_t size);
> +       void (*inv)(phys_addr_t paddr, size_t size);
> +       void (*wback_inv)(phys_addr_t paddr, size_t size);
> +};
> +
> +extern struct riscv_nonstd_cache_ops noncoherent_cache_ops;
> +
> +void riscv_noncoherent_register_cache_ops(const struct riscv_nonstd_cache_ops *ops);
> +
> +#endif /* __ASM_DMA_NONCOHERENT_H */
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index 06b8fea58e20..a4f3f37859ae 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -9,13 +9,26 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/mm.h>
>  #include <asm/cacheflush.h>
> +#include <asm/dma-noncoherent.h>
>
>  static bool noncoherent_supported __ro_after_init;
>
> +struct riscv_nonstd_cache_ops noncoherent_cache_ops __ro_after_init = {
> +       .wback = NULL,
> +       .inv = NULL,
> +       .wback_inv = NULL,
> +};
> +
>  static inline void arch_dma_cache_wback(phys_addr_t paddr, size_t size)
>  {
>         void *vaddr = phys_to_virt(paddr);
>
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +       if (unlikely(noncoherent_cache_ops.wback)) {
> +               noncoherent_cache_ops.wback(paddr, size);
> +               return;
> +       }
> +#endif
>         ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>  }
>
> @@ -23,6 +36,13 @@ static inline void arch_dma_cache_inv(phys_addr_t paddr, size_t size)
>  {
>         void *vaddr = phys_to_virt(paddr);
>
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +       if (unlikely(noncoherent_cache_ops.inv)) {
> +               noncoherent_cache_ops.inv(paddr, size);
> +               return;
> +       }
> +#endif
> +
>         ALT_CMO_OP(inval, vaddr, size, riscv_cbom_block_size);
>  }
>
> @@ -30,6 +50,13 @@ static inline void arch_dma_cache_wback_inv(phys_addr_t paddr, size_t size)
>  {
>         void *vaddr = phys_to_virt(paddr);
>
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +       if (unlikely(noncoherent_cache_ops.wback_inv)) {
> +               noncoherent_cache_ops.wback_inv(paddr, size);
> +               return;
> +       }
> +#endif
> +
>         ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
>  }
>
> @@ -95,6 +122,13 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
>         void *flush_addr = page_address(page);
>
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +       if (unlikely(noncoherent_cache_ops.wback_inv)) {
> +               noncoherent_cache_ops.wback_inv(page_to_phys(page), size);
> +               return;
> +       }
> +#endif
> +
>         ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
>  }
>
> @@ -120,3 +154,12 @@ void riscv_noncoherent_supported(void)
>              "Non-coherent DMA support enabled without a block size\n");
>         noncoherent_supported = true;
>  }
> +
> +void riscv_noncoherent_register_cache_ops(const struct riscv_nonstd_cache_ops *ops)
> +{
> +       if (!ops)
> +               return;
> +
> +       noncoherent_cache_ops = *ops;
> +}
> +EXPORT_SYMBOL_GPL(riscv_noncoherent_register_cache_ops);
> diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
> index 089df92ae876..c5fc5ec96f6d 100644
> --- a/arch/riscv/mm/pmem.c
> +++ b/arch/riscv/mm/pmem.c
> @@ -7,15 +7,28 @@
>  #include <linux/libnvdimm.h>
>
>  #include <asm/cacheflush.h>
> +#include <asm/dma-noncoherent.h>
>
>  void arch_wb_cache_pmem(void *addr, size_t size)
>  {
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +       if (unlikely(noncoherent_cache_ops.wback)) {
> +               noncoherent_cache_ops.wback(virt_to_phys(addr), size);
> +               return;
> +       }
> +#endif
>         ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
>  }
>  EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
>
>  void arch_invalidate_pmem(void *addr, size_t size)
>  {
> +#ifdef CONFIG_RISCV_NONSTANDARD_CACHE_OPS
> +       if (unlikely(noncoherent_cache_ops.inv)) {
> +               noncoherent_cache_ops.inv(virt_to_phys(addr), size);
> +               return;
> +       }
> +#endif
>         ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
>  }
>  EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> --
> 2.34.1
>
