Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45E07B7159
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbjJCSx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjJCSx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:53:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35E29B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:53:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-307d20548adso1207356f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696359203; x=1696964003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxdS62njemCJYDyxzH0Xec1nDuWI0jd1G26QrbZoJVI=;
        b=HEgaUwM3A4feo7BFlYkcRbKFKYSNNNVwkrQiRSGMNJMpMHsKAZmmjXhEnrNeqM3UNW
         XpmflCAUzsLGeLTbtMIVSDPaqEiY/hp//UeM+mlKarWPEhSkIi5KCJa6ESfQqJgHz4C8
         TDN9XPdef2xHWby0pDL/eOcTUpxjozii8Jlc0eVECXLWyx1k4Z2pirucBgHtoX+bmtbt
         sV7EzmWGG6r5CNWbzPbAUoLR8WBPoHJ5R/27hAWncpNxzEH65p64XQzchxmLkL3PZ6BK
         v3AxvBDYIMYN/tdGH3OKNCQUmMChyPpj3fTjkKhP9b83Xi7NWfEKPTd+hR08sQdlm7+t
         C7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696359203; x=1696964003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxdS62njemCJYDyxzH0Xec1nDuWI0jd1G26QrbZoJVI=;
        b=wqlrXJ1vyBb0FFtwI0Sabliji0ywQLHoRMhWhnqK3+fwcgKQiRlY5bT+8hZKfPRfrR
         ca83U579/J6jENlz7b7omvb4nChKSglyMWkcW02gSxcfgQz1Za+cbLrEsgKDyiGZJoE2
         4I7U6ww/pdlm9d/8Zzf9RECe0/hkP6Z3CCLOT9X7VBRkGXeSVVqWzDEfKZi9wP3kVaxw
         kDNbVtMFAtXFn6phLqkGga6Pg8oal2hsvltwau8hp9oP7xcM9AHEgEpZD2zpvzm9ZWrr
         cmvYkfVMlklKWPdMMpU5tvkQKogqhMIVeeG7NxdXo813bN3KMs3/r0v+EXPgTolMXrh8
         j/Yw==
X-Gm-Message-State: AOJu0YyhVi2nSq2LRr2SCIsfRfh3vY1+3gNhfFGPM5PXbPxeTk4eqIri
        5COraWBLKf7mqPJ3OiqI98l1zH0NoT3q3049rmqrSw==
X-Google-Smtp-Source: AGHT+IHgHTJULG9/ylDvqsl0oic3Vd6rdjwr9xrFptOLH9ELQgyfZDGJG8zjY4qp9RI6QL23gNUARde2AUw9jfvnzRM=
X-Received: by 2002:adf:f74f:0:b0:319:68ba:7c8e with SMTP id
 z15-20020adff74f000000b0031968ba7c8emr101529wrp.38.1696359203241; Tue, 03 Oct
 2023 11:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230927170015.295232-1-sunilvl@ventanamicro.com> <20230927170015.295232-2-sunilvl@ventanamicro.com>
In-Reply-To: <20230927170015.295232-2-sunilvl@ventanamicro.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 3 Oct 2023 20:53:12 +0200
Message-ID: <CAHVXubjp_hTS7so1eO4V6nwYEqr1ruvMt05u-Y3efDgvP2YNHg@mail.gmail.com>
Subject: Re: [PATCH v2 -next 1/4] RISC-V: ACPI: Enhance acpi_os_ioremap with
 MMIO remapping
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunil,

On Wed, Sep 27, 2023 at 7:00=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Enhance the acpi_os_ioremap() to support opregions in MMIO space. Also,
> have strict checks using EFI memory map to allow remapping the RAM simila=
r
> to arm64.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/Kconfig       |  1 +
>  arch/riscv/kernel/acpi.c | 87 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d607ab0f7c6d..ac039cf8af7a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -39,6 +39,7 @@ config RISCV
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_HAS_UBSAN_SANITIZE_ALL
>         select ARCH_HAS_VDSO_DATA
> +       select ARCH_KEEP_MEMBLOCK

Shouldn't we restrict this to ACPI?

>         select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>         select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>         select ARCH_STACKWALK
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 56cb2c986c48..e619edc8b0cc 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -14,9 +14,10 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/efi.h>
>  #include <linux/io.h>
> +#include <linux/memblock.h>
>  #include <linux/pci.h>
> -#include <linux/efi.h>
>
>  int acpi_noirq =3D 1;            /* skip ACPI IRQ initialization */
>  int acpi_disabled =3D 1;
> @@ -217,7 +218,89 @@ void __init __acpi_unmap_table(void __iomem *map, un=
signed long size)
>
>  void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size=
)
>  {
> -       return (void __iomem *)memremap(phys, size, MEMREMAP_WB);
> +       efi_memory_desc_t *md, *region =3D NULL;
> +       pgprot_t prot;
> +
> +       if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
> +               return NULL;
> +
> +       for_each_efi_memory_desc(md) {
> +               u64 end =3D md->phys_addr + (md->num_pages << EFI_PAGE_SH=
IFT);
> +
> +               if (phys < md->phys_addr || phys >=3D end)
> +                       continue;
> +
> +               if (phys + size > end) {
> +                       pr_warn(FW_BUG "requested region covers multiple =
EFI memory regions\n");
> +                       return NULL;
> +               }
> +               region =3D md;
> +               break;
> +       }
> +
> +       /*
> +        * It is fine for AML to remap regions that are not represented i=
n the
> +        * EFI memory map at all, as it only describes normal memory, and=
 MMIO
> +        * regions that require a virtual mapping to make them accessible=
 to
> +        * the EFI runtime services.
> +        */
> +       prot =3D PAGE_KERNEL_IO;
> +       if (region) {
> +               switch (region->type) {
> +               case EFI_LOADER_CODE:
> +               case EFI_LOADER_DATA:
> +               case EFI_BOOT_SERVICES_CODE:
> +               case EFI_BOOT_SERVICES_DATA:
> +               case EFI_CONVENTIONAL_MEMORY:
> +               case EFI_PERSISTENT_MEMORY:
> +                       if (memblock_is_map_memory(phys) ||
> +                           !memblock_is_region_memory(phys, size)) {
> +                               pr_warn(FW_BUG "requested region covers k=
ernel memory\n");
> +                               return NULL;
> +                       }
> +
> +                       /*
> +                        * Mapping kernel memory is permitted if the regi=
on in
> +                        * question is covered by a single memblock with =
the
> +                        * NOMAP attribute set: this enables the use of A=
CPI
> +                        * table overrides passed via initramfs.
> +                        * This particular use case only requires read ac=
cess.
> +                        */
> +                       fallthrough;
> +
> +               case EFI_RUNTIME_SERVICES_CODE:
> +                       /*
> +                        * This would be unusual, but not problematic per=
 se,
> +                        * as long as we take care not to create a writab=
le
> +                        * mapping for executable code.
> +                        */
> +                       prot =3D PAGE_KERNEL_RO;
> +                       break;
> +
> +               case EFI_ACPI_RECLAIM_MEMORY:
> +                       /*
> +                        * ACPI reclaim memory is used to pass firmware t=
ables
> +                        * and other data that is intended for consumptio=
n by
> +                        * the OS only, which may decide it wants to recl=
aim
> +                        * that memory and use it for something else. We =
never
> +                        * do that, but we usually add it to the linear m=
ap
> +                        * anyway, in which case we should use the existi=
ng
> +                        * mapping.
> +                        */
> +                       if (memblock_is_map_memory(phys))
> +                               return (void __iomem *)__va(phys);
> +                       fallthrough;
> +
> +               default:
> +                       if (region->attribute & EFI_MEMORY_WB)
> +                               prot =3D PAGE_KERNEL;
> +                       else if ((region->attribute & EFI_MEMORY_WC) ||
> +                                (region->attribute & EFI_MEMORY_WT))
> +                               prot =3D pgprot_writecombine(PAGE_KERNEL)=
;

I have to ask: why is write-through mapped to write-combined here?

> +               }
> +       }
> +
> +       return ioremap_prot(phys, size, pgprot_val(prot));
>  }
>
>  #ifdef CONFIG_PCI
> --
> 2.39.2
>

Like Andrew said in v1, too bad we can't merge that with arm64 instead
of duplicating.

But otherwise, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex
