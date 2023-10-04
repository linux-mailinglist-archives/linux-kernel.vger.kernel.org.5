Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F137B7D3B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjJDKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjJDKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:33:18 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9586FA1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:33:14 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-3515aad4a87so7458565ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696415594; x=1697020394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IPdQhoPm+GbgN7ZVx8L+id2JS3S18F2GF5veflK7uBA=;
        b=Op2PYtDpFrHc1akmTsxCpbVdmtfuLFCwO5GpNBgKPD5FGjg1sgJjbnT/EIKKFfW0Up
         Qv0e0bGhIgMv0evMJvth0fKEWQSJUuFK7+ldB4wIvsCC55PvHV2vZG47BR13DGJyrovp
         viarD5XYFdo87beZyfbd4Vc59Pa79phdkPa/X2/AalplV6Ho1NKikXw7nQRbGaHxlTiL
         JynCZGvLYcq/2YL3JYhtERKkxGtrEi1+FrhbXW0fMPYyPk/S6IULRIAxjOxVI6c/BFoI
         0cNqvraokX2AYG/5MW7U0WXFwilHIstNVlLWIXMuPIiO2U8HSUQGnfIH6/8PTFCV8K8w
         uQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696415594; x=1697020394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IPdQhoPm+GbgN7ZVx8L+id2JS3S18F2GF5veflK7uBA=;
        b=M88lymqUFzMJAtQNUYTC1xZQi8YdJ+wiUU2Q1eQki8funIRcMHXh58f+U+i1Ix6Ffa
         AgJ/2yKYTlVpUvN4lLCF1Ujen/54EtIlUcyxyinIFlNluyEIvP16HMYIHgQISlvQowiL
         X8+CYs/jrMZ0Ws51Hg8crtxj15ha0F+f9zUGuvhWQEzmfHhAzSx+BaoMWrVUFayePmV4
         odjSnySs9dOdgUc/BbGMxwQRYgXIvEKJYCkPGsnHRQQVaZdBoZd1shQnS2sGaByvCy6U
         sWDrJxquMcs/HDUkIRDkamH3pMM2/NcI+bxfSilnIZtGMkJ3CJVYsTHSMaAo/Yra5a5U
         tcoA==
X-Gm-Message-State: AOJu0YyHr43y4PjIpRKvM+UrAeAAPeziho11xeklA36x4UOwZkvaKVIW
        q/rE6c3gPYJhs52NHkzZu0NOpaPHDxXhrk4zZUI=
X-Google-Smtp-Source: AGHT+IEqVN0kHBmtshrFLo8YgWgHUv1tXSbSnje4gJg+PZFNCOW/VIupCwTLHveBwXWiFMcFTC7mew==
X-Received: by 2002:a05:6e02:219b:b0:351:2053:c6cd with SMTP id j27-20020a056e02219b00b003512053c6cdmr2074083ila.3.1696415593914;
        Wed, 04 Oct 2023 03:33:13 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id a7-20020a92d107000000b0034f6f2eca21sm898204ilb.69.2023.10.04.03.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 03:33:13 -0700 (PDT)
Date:   Wed, 4 Oct 2023 16:03:02 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
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
Subject: Re: [PATCH v2 -next 1/4] RISC-V: ACPI: Enhance acpi_os_ioremap with
 MMIO remapping
Message-ID: <ZR0/Xis6Bzh+iAGt@sunil-laptop>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-2-sunilvl@ventanamicro.com>
 <CAHVXubjp_hTS7so1eO4V6nwYEqr1ruvMt05u-Y3efDgvP2YNHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHVXubjp_hTS7so1eO4V6nwYEqr1ruvMt05u-Y3efDgvP2YNHg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, Oct 03, 2023 at 08:53:12PM +0200, Alexandre Ghiti wrote:
> Hi Sunil,
> 
> On Wed, Sep 27, 2023 at 7:00 PM Sunil V L <sunilvl@ventanamicro.com> wrote:
> >
> > Enhance the acpi_os_ioremap() to support opregions in MMIO space. Also,
> > have strict checks using EFI memory map to allow remapping the RAM similar
> > to arm64.
> >
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/Kconfig       |  1 +
> >  arch/riscv/kernel/acpi.c | 87 +++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 86 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d607ab0f7c6d..ac039cf8af7a 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -39,6 +39,7 @@ config RISCV
> >         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> >         select ARCH_HAS_UBSAN_SANITIZE_ALL
> >         select ARCH_HAS_VDSO_DATA
> > +       select ARCH_KEEP_MEMBLOCK
> 
> Shouldn't we restrict this to ACPI?
> 
Sure, Let me update.

> >         select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> >         select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> >         select ARCH_STACKWALK
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index 56cb2c986c48..e619edc8b0cc 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -14,9 +14,10 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/efi.h>
> >  #include <linux/io.h>
> > +#include <linux/memblock.h>
> >  #include <linux/pci.h>
> > -#include <linux/efi.h>
> >
> >  int acpi_noirq = 1;            /* skip ACPI IRQ initialization */
> >  int acpi_disabled = 1;
> > @@ -217,7 +218,89 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
> >
> >  void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> >  {
> > -       return (void __iomem *)memremap(phys, size, MEMREMAP_WB);
> > +       efi_memory_desc_t *md, *region = NULL;
> > +       pgprot_t prot;
> > +
> > +       if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
> > +               return NULL;
> > +
> > +       for_each_efi_memory_desc(md) {
> > +               u64 end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
> > +
> > +               if (phys < md->phys_addr || phys >= end)
> > +                       continue;
> > +
> > +               if (phys + size > end) {
> > +                       pr_warn(FW_BUG "requested region covers multiple EFI memory regions\n");
> > +                       return NULL;
> > +               }
> > +               region = md;
> > +               break;
> > +       }
> > +
> > +       /*
> > +        * It is fine for AML to remap regions that are not represented in the
> > +        * EFI memory map at all, as it only describes normal memory, and MMIO
> > +        * regions that require a virtual mapping to make them accessible to
> > +        * the EFI runtime services.
> > +        */
> > +       prot = PAGE_KERNEL_IO;
> > +       if (region) {
> > +               switch (region->type) {
> > +               case EFI_LOADER_CODE:
> > +               case EFI_LOADER_DATA:
> > +               case EFI_BOOT_SERVICES_CODE:
> > +               case EFI_BOOT_SERVICES_DATA:
> > +               case EFI_CONVENTIONAL_MEMORY:
> > +               case EFI_PERSISTENT_MEMORY:
> > +                       if (memblock_is_map_memory(phys) ||
> > +                           !memblock_is_region_memory(phys, size)) {
> > +                               pr_warn(FW_BUG "requested region covers kernel memory\n");
> > +                               return NULL;
> > +                       }
> > +
> > +                       /*
> > +                        * Mapping kernel memory is permitted if the region in
> > +                        * question is covered by a single memblock with the
> > +                        * NOMAP attribute set: this enables the use of ACPI
> > +                        * table overrides passed via initramfs.
> > +                        * This particular use case only requires read access.
> > +                        */
> > +                       fallthrough;
> > +
> > +               case EFI_RUNTIME_SERVICES_CODE:
> > +                       /*
> > +                        * This would be unusual, but not problematic per se,
> > +                        * as long as we take care not to create a writable
> > +                        * mapping for executable code.
> > +                        */
> > +                       prot = PAGE_KERNEL_RO;
> > +                       break;
> > +
> > +               case EFI_ACPI_RECLAIM_MEMORY:
> > +                       /*
> > +                        * ACPI reclaim memory is used to pass firmware tables
> > +                        * and other data that is intended for consumption by
> > +                        * the OS only, which may decide it wants to reclaim
> > +                        * that memory and use it for something else. We never
> > +                        * do that, but we usually add it to the linear map
> > +                        * anyway, in which case we should use the existing
> > +                        * mapping.
> > +                        */
> > +                       if (memblock_is_map_memory(phys))
> > +                               return (void __iomem *)__va(phys);
> > +                       fallthrough;
> > +
> > +               default:
> > +                       if (region->attribute & EFI_MEMORY_WB)
> > +                               prot = PAGE_KERNEL;
> > +                       else if ((region->attribute & EFI_MEMORY_WC) ||
> > +                                (region->attribute & EFI_MEMORY_WT))
> > +                               prot = pgprot_writecombine(PAGE_KERNEL);
> 
> I have to ask: why is write-through mapped to write-combined here?
> 
IIUC, write-through ensures the copy in the cache and memory are always
in sync. So, instead of using WB, non-cacheable WC is used as RISC-V
doesn't really define these attributes. Let me know if this is not
correct.

> > +               }
> > +       }
> > +
> > +       return ioremap_prot(phys, size, pgprot_val(prot));
> >  }
> >
> >  #ifdef CONFIG_PCI
> > --
> > 2.39.2
> >
> 
> Like Andrew said in v1, too bad we can't merge that with arm64 instead
> of duplicating.
> 
I agree. But since acpi_os_ioremap() is supposed to be arch function, I
kept is separate. Also, I need feedback from Ard whether we should make
it common and where to add this common function.

> But otherwise, you can add:
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 

Thanks!
Sunil
