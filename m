Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF5275261D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGMPHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjGMPG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:06:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5D30D8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:06:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso7897995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689260777; x=1691852777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxVsKvtmYMpsDCokRqc9QY4JAyyCTbpOwPzJb4QgZv0=;
        b=FZXgiFX6K6e1lSKn83fCQ8mpmVMgQemCsTpzYznDarOLdNMaA1dJOWnzlkWir846qA
         G26v9yp/cHDY0qSunsNuIq8deYpzWPTyjWcCo9rabUZ4JSsAWBYRKFODHQqqCwpL0vfN
         xxfDuC3Gw/MuzzMfj3dAtNGtr6n/jkNZkMgpPnMlZhYrihiFzdnk6sBlW7JB636C2yjj
         WoB3fdWUQdUkOHf9c0FWYK+nUjlJTQKwTQl1lrD/pyUUJuyDPpypCft+GH8zico0jp/E
         vyC7BeQ5CawSTw5jKIWzfc2tuCXoksh9y8bGlumJCJlVqzEz9qyejVAkxIZR2z9n0PMZ
         k/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260777; x=1691852777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxVsKvtmYMpsDCokRqc9QY4JAyyCTbpOwPzJb4QgZv0=;
        b=CANIbjODLkCs8B5QUgKw4wBPqpK6fa053K/+0WY3RO3FSapt8QlTikzhvW/Q85E8tD
         u7MB7q24UDtmT4VwBkuhOc1TIkGR5O3nw6GyXGpSv8iRZBas7bywhpIKKvcz4LOV9mzn
         PZG1fffLeWpUO7kuWDxKIn4rxJHr0dVNzUWVOqv4eohxNZLvnsM+2ngGsvioEIhhyzkv
         syCiCFEtosVFajn/RAiYe5CnH89FaD8cXTzMemxPqNnY6fE3sdEP8nbmJsFengzLcPpz
         C7K9nDkehX1ZneEpPpW2wJv5xQ5fpMOYA0Y24OVK07vcBuBoLjWow7UNIQj3bl1BrS4o
         qAnQ==
X-Gm-Message-State: ABy/qLZksKQ/xQyu+iDcWAgehdFfj6DDyIQAj5IbxHeToZOWjzKCSFQ8
        bHGNmoppsLkSu1hsZjULdpvxZgUCCZP20jIe6Odw4g==
X-Google-Smtp-Source: APBJJlHvRLlMf8mhytAgBtVKkiw4lCwEpCjIlvG+bNco2pE24zIFaTYvABy0Zw0hOGLh7XfKV/oEKWzBfzc+F60E3EU=
X-Received: by 2002:adf:dd45:0:b0:315:9047:a482 with SMTP id
 u5-20020adfdd45000000b003159047a482mr1743327wrm.48.1689260776700; Thu, 13 Jul
 2023 08:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230713133401.116506-1-alexghiti@rivosinc.com>
 <20230713133401.116506-4-alexghiti@rivosinc.com> <CAMj1kXGUxGMtH9Zcc93H+KvXRqdrH-Lx4UsE+HSzxdwnN16fmw@mail.gmail.com>
In-Reply-To: <CAMj1kXGUxGMtH9Zcc93H+KvXRqdrH-Lx4UsE+HSzxdwnN16fmw@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 13 Jul 2023 17:06:05 +0200
Message-ID: <CAHVXubiR=SHtR1LsaNhcr1gukOXeCGMsS=dUK=WZhOTkQQP1tA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] arm64: libstub: Move KASLR handling functions to efi-stub-helper.c
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Thu, Jul 13, 2023 at 4:30=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Hello Alexandre,
>
> On Thu, 13 Jul 2023 at 15:37, Alexandre Ghiti <alexghiti@rivosinc.com> wr=
ote:
> >
> > This prepares for riscv to use the same functions to handle the p=C4=A5=
ysical
> > kernel move when KASLR is enabled.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/arm64/include/asm/efi.h                  |   4 +
> >  arch/riscv/include/asm/efi.h                  |   1 +
> >  drivers/firmware/efi/libstub/Makefile         |   3 +-
> >  drivers/firmware/efi/libstub/arm64-stub.c     | 117 ++-----------
> >  drivers/firmware/efi/libstub/efi-stub-kaslr.c | 159 ++++++++++++++++++
>
> Please just call the file kaslr.c

Ok

>
> >  drivers/firmware/efi/libstub/efistub.h        |  18 ++
> >  6 files changed, 197 insertions(+), 105 deletions(-)
> >  create mode 100644 drivers/firmware/efi/libstub/efi-stub-kaslr.c
> >
> > diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.=
h
> > index 4cf2cb053bc8..83a4d69fd968 100644
> > --- a/arch/arm64/include/asm/efi.h
> > +++ b/arch/arm64/include/asm/efi.h
> > @@ -111,6 +111,7 @@ static inline unsigned long efi_get_kimg_min_align(=
void)
> >          */
> >         return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
> >  }
> > +#define efi_get_kimg_min_align efi_get_kimg_min_align
> >
> >  #define EFI_ALLOC_ALIGN                SZ_64K
> >  #define EFI_ALLOC_LIMIT                ((1UL << 48) - 1)
> > @@ -168,4 +169,7 @@ static inline void efi_capsule_flush_cache_range(vo=
id *addr, int size)
> >
> >  efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f);
> >
> > +void efi_icache_sync(unsigned long start, unsigned long end);
> > +#define efi_icache_sync        efi_icache_sync
> > +
>
> Given that arm64 is the only arch that needs to implement this, can we
> just keep the call in arch code? I.e., after
> efi_kaslr_relocate_kernel() if it returned with EFI_SUCCESS?

Actually, I implement this function for riscv in patch 5 as we need to
sync the icache and the dcache too. But my flaky internet did not
survive long enough.

>
>
> >  #endif /* _ASM_EFI_H */
> > diff --git a/arch/riscv/include/asm/efi.h b/arch/riscv/include/asm/efi.=
h
> > index 29e9a0d84b16..c3dafaab36a2 100644
> > --- a/arch/riscv/include/asm/efi.h
> > +++ b/arch/riscv/include/asm/efi.h
> > @@ -43,6 +43,7 @@ static inline unsigned long efi_get_kimg_min_align(vo=
id)
> >          */
> >         return IS_ENABLED(CONFIG_64BIT) ? SZ_2M : SZ_4M;
> >  }
> > +#define efi_get_kimg_min_align efi_get_kimg_min_align

efi_get_kimg_min_align() is implemented here for riscv ^

> >
> >  #define EFI_KIMG_PREFERRED_ADDRESS     efi_get_kimg_min_align()
> >
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/e=
fi/libstub/Makefile
> > index 16d64a34d1e1..5927fab5c834 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -67,7 +67,8 @@ OBJECT_FILES_NON_STANDARD     :=3D y
> >  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
> >  KCOV_INSTRUMENT                        :=3D n
> >
> > -lib-y                          :=3D efi-stub-helper.o gop.o secureboot=
.o tpm.o \
> > +lib-y                          :=3D efi-stub-helper.o efi-stub-kaslr.o=
 \
> > +                                  gop.o secureboot.o tpm.o \
> >                                    file.o mem.o random.o randomalloc.o =
pci.o \
> >                                    skip_spaces.o lib-cmdline.o lib-ctyp=
e.o \
> >                                    alignedmem.o relocate.o printk.o vsp=
rintf.o
> > diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmwa=
re/efi/libstub/arm64-stub.c
> > index 770b8ecb7398..452b7ccd330e 100644
> > --- a/drivers/firmware/efi/libstub/arm64-stub.c
> > +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> > @@ -14,42 +14,6 @@
> >
> >  #include "efistub.h"
> >
> > -/*
> > - * Distro versions of GRUB may ignore the BSS allocation entirely (i.e=
., fail
> > - * to provide space, and fail to zero it). Check for this condition by=
 double
> > - * checking that the first and the last byte of the image are covered =
by the
> > - * same EFI memory map entry.
> > - */
> > -static bool check_image_region(u64 base, u64 size)
> > -{
> > -       struct efi_boot_memmap *map;
> > -       efi_status_t status;
> > -       bool ret =3D false;
> > -       int map_offset;
> > -
> > -       status =3D efi_get_memory_map(&map, false);
> > -       if (status !=3D EFI_SUCCESS)
> > -               return false;
> > -
> > -       for (map_offset =3D 0; map_offset < map->map_size; map_offset +=
=3D map->desc_size) {
> > -               efi_memory_desc_t *md =3D (void *)map->map + map_offset=
;
> > -               u64 end =3D md->phys_addr + md->num_pages * EFI_PAGE_SI=
ZE;
> > -
> > -               /*
> > -                * Find the region that covers base, and return whether
> > -                * it covers base+size bytes.
> > -                */
> > -               if (base >=3D md->phys_addr && base < end) {
> > -                       ret =3D (base + size) <=3D end;
> > -                       break;
> > -               }
> > -       }
> > -
> > -       efi_bs_call(free_pool, map);
> > -
> > -       return ret;
> > -}
> > -
> >  efi_status_t handle_kernel_image(unsigned long *image_addr,
> >                                  unsigned long *image_size,
> >                                  unsigned long *reserve_addr,
> > @@ -59,31 +23,6 @@ efi_status_t handle_kernel_image(unsigned long *imag=
e_addr,
> >  {
> >         efi_status_t status;
> >         unsigned long kernel_size, kernel_codesize, kernel_memsize;
> > -       u32 phys_seed =3D 0;
> > -       u64 min_kimg_align =3D efi_get_kimg_min_align();
> > -
> > -       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
> > -               efi_guid_t li_fixed_proto =3D LINUX_EFI_LOADED_IMAGE_FI=
XED_GUID;
> > -               void *p;
> > -
> > -               if (efi_nokaslr) {
> > -                       efi_info("KASLR disabled on kernel command line=
\n");
> > -               } else if (efi_bs_call(handle_protocol, image_handle,
> > -                                      &li_fixed_proto, &p) =3D=3D EFI_=
SUCCESS) {
> > -                       efi_info("Image placement fixed by loader\n");
> > -               } else {
> > -                       status =3D efi_get_random_bytes(sizeof(phys_see=
d),
> > -                                                     (u8 *)&phys_seed)=
;
> > -                       if (status =3D=3D EFI_NOT_FOUND) {
> > -                               efi_info("EFI_RNG_PROTOCOL unavailable\=
n");
> > -                               efi_nokaslr =3D true;
> > -                       } else if (status !=3D EFI_SUCCESS) {
> > -                               efi_err("efi_get_random_bytes() failed =
(0x%lx)\n",
> > -                                       status);
> > -                               efi_nokaslr =3D true;
> > -                       }
> > -               }
> > -       }
> >
> >         if (image->image_base !=3D _text) {
> >                 efi_err("FIRMWARE BUG: efi_loaded_image_t::image_base h=
as bogus value\n");
> > @@ -98,50 +37,15 @@ efi_status_t handle_kernel_image(unsigned long *ima=
ge_addr,
> >         kernel_codesize =3D __inittext_end - _text;
> >         kernel_memsize =3D kernel_size + (_end - _edata);
> >         *reserve_size =3D kernel_memsize;
> > +       *image_addr =3D (unsigned long)_text;
> >
> > -       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed !=3D 0) {
> > -               /*
> > -                * If KASLR is enabled, and we have some randomness ava=
ilable,
> > -                * locate the kernel at a randomized offset in physical=
 memory.
> > -                */
> > -               status =3D efi_random_alloc(*reserve_size, min_kimg_ali=
gn,
> > -                                         reserve_addr, phys_seed,
> > -                                         EFI_LOADER_CODE);
> > -               if (status !=3D EFI_SUCCESS)
> > -                       efi_warn("efi_random_alloc() failed: 0x%lx\n", =
status);
> > -       } else {
> > -               status =3D EFI_OUT_OF_RESOURCES;
> > -       }
> > -
> > -       if (status !=3D EFI_SUCCESS) {
> > -               if (!check_image_region((u64)_text, kernel_memsize)) {
> > -                       efi_err("FIRMWARE BUG: Image BSS overlaps adjac=
ent EFI memory region\n");
> > -               } else if (IS_ALIGNED((u64)_text, min_kimg_align) &&
> > -                          (u64)_end < EFI_ALLOC_LIMIT) {
> > -                       /*
> > -                        * Just execute from wherever we were loaded by=
 the
> > -                        * UEFI PE/COFF loader if the placement is suit=
able.
> > -                        */
> > -                       *image_addr =3D (u64)_text;
> > -                       *reserve_size =3D 0;
> > -                       return EFI_SUCCESS;
> > -               }
> > -
> > -               status =3D efi_allocate_pages_aligned(*reserve_size, re=
serve_addr,
> > -                                                   ULONG_MAX, min_kimg=
_align,
> > -                                                   EFI_LOADER_CODE);
> > -
> > -               if (status !=3D EFI_SUCCESS) {
> > -                       efi_err("Failed to relocate kernel\n");
> > -                       *reserve_size =3D 0;
> > -                       return status;
> > -               }
> > -       }
> > -
> > -       *image_addr =3D *reserve_addr;
> > -       memcpy((void *)*image_addr, _text, kernel_size);
> > -       caches_clean_inval_pou(*image_addr, *image_addr + kernel_codesi=
ze);
> > -       efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
> > +       status =3D efi_kaslr_relocate_kernel(image_addr,
> > +                                          reserve_addr, reserve_size,
> > +                                          kernel_size, kernel_codesize=
,
> > +                                          kernel_memsize,
> > +                                          efi_kaslr_get_phys_seed(imag=
e_handle));
> > +       if (status !=3D EFI_SUCCESS)
> > +               return status;
> >
> >         return EFI_SUCCESS;
> >  }
> > @@ -159,3 +63,8 @@ unsigned long primary_entry_offset(void)
> >          */
> >         return (char *)primary_entry - _text;
> >  }
> > +
> > +void efi_icache_sync(unsigned long start, unsigned long end)
> > +{
> > +       caches_clean_inval_pou(start, end);
> > +}
> > diff --git a/drivers/firmware/efi/libstub/efi-stub-kaslr.c b/drivers/fi=
rmware/efi/libstub/efi-stub-kaslr.c
> > new file mode 100644
> > index 000000000000..be0c8ab0982a
> > --- /dev/null
> > +++ b/drivers/firmware/efi/libstub/efi-stub-kaslr.c
> > @@ -0,0 +1,159 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Helper functions used by the EFI stub on multiple
> > + * architectures to deal with physical address space randomization.
> > + */
> > +#include <linux/efi.h>
> > +
> > +#include "efistub.h"
> > +
> > +/**
> > + * efi_kaslr_get_phys_seed() - Get random seed for physical kernel KAS=
LR
> > + * @image_handle:      Handle to the image
> > + *
> > + * If KASLR is not disabled, obtain a random seed using EFI_RNG_PROTOC=
OL
> > + * that will be used to move the kernel physical mapping.
> > + *
> > + * Return:     the random seed
> > + */
> > +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle)
> > +{
> > +       efi_status_t status;
> > +       u32 phys_seed;
> > +       efi_guid_t li_fixed_proto =3D LINUX_EFI_LOADED_IMAGE_FIXED_GUID=
;
> > +       void *p;
> > +
> > +       if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
> > +               return 0;
> > +
> > +       if (efi_nokaslr) {
> > +               efi_info("KASLR disabled on kernel command line\n");
> > +       } else if (efi_bs_call(handle_protocol, image_handle,
> > +                              &li_fixed_proto, &p) =3D=3D EFI_SUCCESS)=
 {
> > +               efi_info("Image placement fixed by loader\n");
> > +       } else {
> > +               status =3D efi_get_random_bytes(sizeof(phys_seed),
> > +                                             (u8 *)&phys_seed);
> > +               if (status =3D=3D EFI_SUCCESS) {
> > +                       return phys_seed;
> > +               } else if (status =3D=3D EFI_NOT_FOUND) {
> > +                       efi_info("EFI_RNG_PROTOCOL unavailable\n");
> > +                       efi_nokaslr =3D true;
> > +               } else if (status !=3D EFI_SUCCESS) {
> > +                       efi_err("efi_get_random_bytes() failed (0x%lx)\=
n",
> > +                               status);
> > +                       efi_nokaslr =3D true;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +/*
> > + * Distro versions of GRUB may ignore the BSS allocation entirely (i.e=
., fail
> > + * to provide space, and fail to zero it). Check for this condition by=
 double
> > + * checking that the first and the last byte of the image are covered =
by the
> > + * same EFI memory map entry.
> > + */
> > +static bool check_image_region(u64 base, u64 size)
> > +{
> > +       struct efi_boot_memmap *map;
> > +       efi_status_t status;
> > +       bool ret =3D false;
> > +       int map_offset;
> > +
> > +       status =3D efi_get_memory_map(&map, false);
> > +       if (status !=3D EFI_SUCCESS)
> > +               return false;
> > +
> > +       for (map_offset =3D 0; map_offset < map->map_size; map_offset +=
=3D map->desc_size) {
> > +               efi_memory_desc_t *md =3D (void *)map->map + map_offset=
;
> > +               u64 end =3D md->phys_addr + md->num_pages * EFI_PAGE_SI=
ZE;
> > +
> > +               /*
> > +                * Find the region that covers base, and return whether
> > +                * it covers base+size bytes.
> > +                */
> > +               if (base >=3D md->phys_addr && base < end) {
> > +                       ret =3D (base + size) <=3D end;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       efi_bs_call(free_pool, map);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * efi_kaslr_relocate_kernel() - Relocate the kernel (random if KASLR =
enabled)
> > + * @image_addr: Pointer to the current kernel location
> > + * @reserve_addr:      Pointer to the relocated kernel location
> > + * @reserve_size:      Size of the relocated kernel
> > + * @kernel_size:       Size of the text + data
> > + * @kernel_codesize:   Size of the text
> > + * @kernel_memsize:    Size of the text + data + bss
> > + * @phys_seed:         Random seed used for the relocation
> > + *
> > + * If KASLR is not enabled, this function relocates the kernel to a fi=
xed
> > + * address (or leave it as its current location). If KASLR is enabled,=
 the
> > + * kernel physical location is randomized using the seed in parameter.
> > + *
> > + * Return:     status code, EFI_SUCCESS if relocation is successful
> > + */
> > +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> > +                                      unsigned long *reserve_addr,
> > +                                      unsigned long *reserve_size,
> > +                                      unsigned long kernel_size,
> > +                                      unsigned long kernel_codesize,
> > +                                      unsigned long kernel_memsize,
> > +                                      u32 phys_seed)
> > +{
> > +       efi_status_t status;
> > +       u64 min_kimg_align =3D efi_get_kimg_min_align();
> > +
> > +       if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed !=3D 0) {
> > +               /*
> > +                * If KASLR is enabled, and we have some randomness ava=
ilable,
> > +                * locate the kernel at a randomized offset in physical=
 memory.
> > +                */
> > +               status =3D efi_random_alloc(*reserve_size, min_kimg_ali=
gn,
> > +                                         reserve_addr, phys_seed,
> > +                                         EFI_LOADER_CODE);
> > +               if (status !=3D EFI_SUCCESS)
> > +                       efi_warn("efi_random_alloc() failed: 0x%lx\n", =
status);
> > +       } else {
> > +               status =3D EFI_OUT_OF_RESOURCES;
> > +       }
> > +
> > +       if (status !=3D EFI_SUCCESS) {
> > +               if (!check_image_region(*image_addr, kernel_memsize)) {
> > +                       efi_err("FIRMWARE BUG: Image BSS overlaps adjac=
ent EFI memory region\n");
> > +               } else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
> > +                          (u64)_end < EFI_ALLOC_LIMIT) {
> > +                       /*
> > +                        * Just execute from wherever we were loaded by=
 the
> > +                        * UEFI PE/COFF loader if the placement is suit=
able.
> > +                        */
> > +                       *reserve_size =3D 0;
> > +                       return EFI_SUCCESS;
> > +               }
> > +
> > +               status =3D efi_allocate_pages_aligned(*reserve_size, re=
serve_addr,
> > +                                                   ULONG_MAX, min_kimg=
_align,
> > +                                                   EFI_LOADER_CODE);
> > +
> > +               if (status !=3D EFI_SUCCESS) {
> > +                       efi_err("Failed to relocate kernel\n");
> > +                       *reserve_size =3D 0;
> > +                       return status;
> > +               }
> > +       }
> > +
> > +       memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size)=
;
> > +       *image_addr =3D *reserve_addr;
> > +       efi_icache_sync(*image_addr, *image_addr + kernel_codesize);
> > +       efi_remap_image(*image_addr, *reserve_size, kernel_codesize);
> > +
> > +       return status;
> > +}
> > diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/=
efi/libstub/efistub.h
> > index 6aa38a1bf126..35337ea5056e 100644
> > --- a/drivers/firmware/efi/libstub/efistub.h
> > +++ b/drivers/firmware/efi/libstub/efistub.h
> > @@ -1132,6 +1132,24 @@ const u8 *__efi_get_smbios_string(const struct e=
fi_smbios_record *record,
> >
> >  void efi_remap_image(unsigned long image_base, unsigned alloc_size,
> >                      unsigned long code_size);
> > +efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
> > +                                      unsigned long *reserve_addr,
> > +                                      unsigned long *reserve_size,
> > +                                      unsigned long kernel_size,
> > +                                      unsigned long kernel_codesize,
> > +                                      unsigned long kernel_memsize,
> > +                                      u32 phys_seed);
> > +u32 efi_kaslr_get_phys_seed(efi_handle_t image_handle);
> > +
> > +#ifndef efi_get_kimg_min_align
> > +static inline unsigned long efi_get_kimg_min_align(void) { return 0; }
>
> Shouldn't this be EFI_PAGE_SIZE at least? Surely, the RISC-V kernel
> image has some minimal alignment?

efi_get_kimg_min_align() is implemented above for riscv, this stub is
here to prevent build failures for other architectures that do not
define it (ie x86). But actually, since I have moved the new functions
to their own file, I'm not sure I still need those stubs, I'll check
and remove them in v5 if possible.

>
>
> > +#define efi_get_kimg_min_align efi_get_kimg_min_align
> > +#endif
> > +
> > +#ifndef efi_icache_sync
> > +static inline void efi_icache_sync(unsigned long start, unsigned long =
end) {}
> > +#define efi_icache_sync        efi_icache_sync
> > +#endif
> >
> >  asmlinkage efi_status_t __efiapi
> >  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
> > --
> > 2.39.2
> >

Thanks, and sorry for the truncated series, I'll resend this version
for everyone to have a look at the next 2 patches but keep in mind
your feedback for v5.

Alex
