Return-Path: <linux-kernel+bounces-16704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E048242B3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF6BC1F22960
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00589224C3;
	Thu,  4 Jan 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Eb2oxIEN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8245224C2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso659307a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 05:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704375221; x=1704980021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9nciiriJpb7tENlNvSwNphXFtDHdU2SZI62Llv8IA4=;
        b=Eb2oxIENQkiMEoCKcb9owXt0YFJuf2PvUTAUwmw+8frGGapY06bx2LcALzYzvqXjyU
         hYt68pVDKgIUTmbXUgF0u1w1HiAKlcL+ToRqi9r+un/9GSTWPWPC+9JixwCTK9B0KaI5
         EhPaDZ/9RQC9l4IQAOLzvYYSwpiAaVLemWgMPsNKV7IHHzVVDfHiU7NQFjBAVnMP5ar+
         L6kbbTkarIvu2CSY+dEXEMuentQOCZUFu3IVUubd6nZ3xixcMDbK/H+oCuN7LtuZUBSP
         LQXTB86sOd6VegThj/QctnFixJ0ItegVBIpShOqVMacAcKu4gAKEdzoqCYDNRXMHVAo8
         LMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704375221; x=1704980021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9nciiriJpb7tENlNvSwNphXFtDHdU2SZI62Llv8IA4=;
        b=codCr/BhbIva3uYjVQegnOh8PGe4X7msvznr73Je8MPbuFNif5IODsRcgusptkkHRI
         KjP43nD6a+f2mz4whYKpoiWO5ogDrx9Gpi6asR9vqmIyglxMLBot+yC/LJyuFgygg9wT
         ESaJUNu/QRv7Sbqh+pa/C9Sw/z6IY2zmZMW/lmxcKyTE73pn+7YzNlzOBcknqg5yjRtZ
         leBkyJtGITcTYvmVq+dH1CG+cO+VyCMts0LmHNr4HC3BofZVS5ExEC9jqqBAtlTgPrxh
         NmpLqbUXLaNAAWXGt1GVektrv2nWT2R0QiFROcE6jwAOefKLVaPbCT2vHKvba38hSjLH
         yTrw==
X-Gm-Message-State: AOJu0Yz274yi3eV+zQpywlqNNDvwgrHBO/kGbMP7C0BO57YnyRjPF/Sj
	KqXt7c9jamXLCsvCXc5VX33vqmAG/fZj1uLHVdIZ7JnuGF3+UU/GrKNjMrdV
X-Google-Smtp-Source: AGHT+IHPeUkGUKxv3Vw5A8F02Al3wlBIO0DPJKAYP8898EnuKCc8DJQUhHbBnnDi12kdWgEyklle/VhrRcs1cP13cpY=
X-Received: by 2002:a17:906:7683:b0:a23:49f1:52e9 with SMTP id
 o3-20020a170906768300b00a2349f152e9mr348415ejm.146.1704375221096; Thu, 04 Jan
 2024 05:33:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102141851.105144-1-alexghiti@rivosinc.com> <9cd39ef1-9750-4e4d-9df1-3dad0a7ea015@sifive.com>
In-Reply-To: <9cd39ef1-9750-4e4d-9df1-3dad0a7ea015@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 14:33:30 +0100
Message-ID: <CAHVXubig8pugGJpuCohzi-hhDt924-8i9ctoQNuyKb_t1CkbKg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Tue, Jan 2, 2024 at 11:13=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Alex,
>
> On 2024-01-02 8:18 AM, Alexandre Ghiti wrote:
> > Allow to defer the flushing of the TLB when unmapping pges, which allow=
s
> > to reduce the numbers of IPI and the number of sfence.vma.
> >
> > The ubenchmarch used in commit 43b3dfdd0455 ("arm64: support
> > batched/deferred tlb shootdown during page reclamation/migration") show=
s
> > good performance improvement and perf reports an important decrease in
> > time spent flushing the tlb (results come from qemu):
> >
> > Before this patch:
> >
> > real  2m1.135s
> > user  0m0.980s
> > sys   2m0.096s
> >
> > 4.83%  batch_tlb  [kernel.kallsyms]            [k] __flush_tlb_range
> >
> > After this patch:
> >
> > real  1m0.543s
> > user  0m1.059s
> > sys   0m59.489s
> >
> > 0.14%  batch_tlb  [kernel.kallsyms]            [k] __flush_tlb_range
>
> That's a great improvement!
>
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig                |  1 +
> >  arch/riscv/include/asm/tlbbatch.h | 15 +++++++
> >  arch/riscv/include/asm/tlbflush.h | 10 +++++
> >  arch/riscv/mm/tlbflush.c          | 71 ++++++++++++++++++++++---------
> >  4 files changed, 77 insertions(+), 20 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/tlbbatch.h
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 7603bd8ab333..aa07bd43b138 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -53,6 +53,7 @@ config RISCV
> >       select ARCH_USE_MEMTEST
> >       select ARCH_USE_QUEUED_RWLOCKS
> >       select ARCH_USES_CFI_TRAPS if CFI_CLANG
> > +     select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
>
> Is the SMP dependency because the batching is only useful with multiple C=
PUs, or
> just because tlbflush.c is only compiled in SMP configurations (which is
> resolved by [1])?
>

For now, yes, I considered that only the gain of the IPI is worthwhile
hence the restriction for SMP.

> [1]:
> https://lore.kernel.org/linux-riscv/20240102220134.3229156-1-samuel.holla=
nd@sifive.com/
>
> >       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> >       select ARCH_WANT_FRAME_POINTERS
> >       select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
> > diff --git a/arch/riscv/include/asm/tlbbatch.h b/arch/riscv/include/asm=
/tlbbatch.h
> > new file mode 100644
> > index 000000000000..46014f70b9da
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/tlbbatch.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2023 Rivos Inc.
> > + */
> > +
> > +#ifndef _ASM_RISCV_TLBBATCH_H
> > +#define _ASM_RISCV_TLBBATCH_H
> > +
> > +#include <linux/cpumask.h>
> > +
> > +struct arch_tlbflush_unmap_batch {
> > +     struct cpumask cpumask;
> > +};
> > +
> > +#endif /* _ASM_RISCV_TLBBATCH_H */
> > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm=
/tlbflush.h
> > index 8f3418c5f172..f0b731ccc0c2 100644
> > --- a/arch/riscv/include/asm/tlbflush.h
> > +++ b/arch/riscv/include/asm/tlbflush.h
> > @@ -46,6 +46,16 @@ void flush_tlb_kernel_range(unsigned long start, uns=
igned long end);
> >  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long sta=
rt,
> >                       unsigned long end);
> >  #endif
> > +
> > +#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> > +bool arch_tlbbatch_should_defer(struct mm_struct *mm);
> > +void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch=
,
> > +                            struct mm_struct *mm,
> > +                            unsigned long uaddr);
> > +void arch_flush_tlb_batched_pending(struct mm_struct *mm);
> > +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
> > +#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
> > +
> >  #else /* CONFIG_SMP && CONFIG_MMU */
> >
> >  #define flush_tlb_all() local_flush_tlb_all()
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index e6659d7368b3..bb623bca0a7d 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -93,29 +93,23 @@ static void __ipi_flush_tlb_range_asid(void *info)
> >       local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid)=
;
> >  }
> >
> > -static void __flush_tlb_range(struct mm_struct *mm, unsigned long star=
t,
> > -                           unsigned long size, unsigned long stride)
> > +static void __flush_tlb_range(struct cpumask *cmask, unsigned long asi=
d,
> > +                           unsigned long start, unsigned long size,
> > +                           unsigned long stride)
> >  {
> >       struct flush_tlb_range_data ftd;
> > -     const struct cpumask *cmask;
> > -     unsigned long asid =3D FLUSH_TLB_NO_ASID;
> >       bool broadcast;
> >
> > -     if (mm) {
> > -             unsigned int cpuid;
> > +     if (cpumask_empty(cmask))
> > +             return;
> >
> > -             cmask =3D mm_cpumask(mm);
> > -             if (cpumask_empty(cmask))
> > -                     return;
> > +     if (cmask !=3D cpu_online_mask) {
> > +             unsigned int cpuid;
> >
> >               cpuid =3D get_cpu();
> >               /* check if the tlbflush needs to be sent to other CPUs *=
/
> >               broadcast =3D cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> > -
> > -             if (static_branch_unlikely(&use_asid_allocator))
> > -                     asid =3D atomic_long_read(&mm->context.id) & asid=
_mask;
> >       } else {
> > -             cmask =3D cpu_online_mask;
> >               broadcast =3D true;
> >       }
> >
> > @@ -135,25 +129,34 @@ static void __flush_tlb_range(struct mm_struct *m=
m, unsigned long start,
> >               local_flush_tlb_range_asid(start, size, stride, asid);
> >       }
> >
> > -     if (mm)
> > +     if (cmask !=3D cpu_online_mask)
> >               put_cpu();
> >  }
> >
> > +static inline unsigned long get_mm_asid(struct mm_struct *mm)
> > +{
> > +     return static_branch_unlikely(&use_asid_allocator) ?
> > +                     atomic_long_read(&mm->context.id) & asid_mask : F=
LUSH_TLB_NO_ASID;
> > +}
> > +
> >  void flush_tlb_mm(struct mm_struct *mm)
> >  {
> > -     __flush_tlb_range(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> > +     __flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> > +                       0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> >  }
> >
> >  void flush_tlb_mm_range(struct mm_struct *mm,
> >                       unsigned long start, unsigned long end,
> >                       unsigned int page_size)
> >  {
> > -     __flush_tlb_range(mm, start, end - start, page_size);
> > +     __flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> > +                       start, end - start, page_size);
> >  }
> >
> >  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
> >  {
> > -     __flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
> > +     __flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm)=
,
> > +                       addr, PAGE_SIZE, PAGE_SIZE);
> >  }
> >
> >  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> > @@ -185,18 +188,46 @@ void flush_tlb_range(struct vm_area_struct *vma, =
unsigned long start,
> >               }
> >       }
> >
> > -     __flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
> > +     __flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm)=
,
> > +                       start, end - start, stride_size);
> >  }
> >
> >  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
> >  {
> > -     __flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> > +     __flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO=
_ASID,
> > +                       start, end - start, PAGE_SIZE);
> >  }
> >
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long sta=
rt,
> >                       unsigned long end)
> >  {
> > -     __flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
> > +     __flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm)=
,
> > +                       start, end - start, PMD_SIZE);
> >  }
> >  #endif
> > +
> > +#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
>
> This condition is necessarily true if the file is being compiled.

Indeed, I'll remove that, thanks.

>
> > +bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> > +{
> > +     return true;
> > +}
> > +
> > +void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch=
,
> > +                            struct mm_struct *mm,
> > +                            unsigned long uaddr)
> > +{
> > +     cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
> > +}
> > +
> > +void arch_flush_tlb_batched_pending(struct mm_struct *mm)
> > +{
> > +     flush_tlb_mm(mm);
> > +}
> > +
> > +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> > +{
> > +     __flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
>
> The batching appears to be limited to within a single mm, so we could sav=
e the
> ASID inside struct arch_tlbflush_unmap_batch and use it here.

The batching can be used when reclaiming pages (see
shrink_folio_list() -> try_to_unmap() -> try_to_unmap_one()), so that
could be pages from multiple processes. I'm working on a follow-up
patch that keeps the page addresses and mm to avoid the global
sfence.vma here (up to a certain threshold that we already use), but
since this version *seemed* to perform well, I sent it first.

Thanks,

Alex

>
> Regards,
> Samuel
>
> > +                       FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> > +}
> > +#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
>

