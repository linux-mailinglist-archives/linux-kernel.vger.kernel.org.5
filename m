Return-Path: <linux-kernel+bounces-17051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9285B8247A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DC23B21E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F6288CF;
	Thu,  4 Jan 2024 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TG0MlLgb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DA28DAB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a28b0207c1dso63673466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 09:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704390138; x=1704994938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOY/i2nOGRFhoLxq1Mmr/Sq7+xJjr987nJkE2qhg7HM=;
        b=TG0MlLgbPgDmojYZgS13apz4K5MWsmvNMRz1M43rtUKn0lvrat0YchLWprS8LvP862
         gg8GKAlnT8C0ZXVS5+2NOFIEcp4Gbrr/WDvdIKn3WvNnoR0ubLL93cfx6Pt6NUAu8VR9
         BPLPux2A9NAIX/Guf91feZq1x7GyVGh4CdyhdG4zVRRVQbzDLC83K2/8s+UceiZmHpA7
         QL8Kg/nYgu8jPwkQ0Z0dc8aHqG4o4iqDALn1xF8TDj3Rnob50u0kSvTy5VidkioC/8CG
         ac1fckE/kv+PxCeTElei+OJQBn2Z277VqergpZl6G8v7g+yhxiwa5sr7qL1twFC27EFr
         1fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704390138; x=1704994938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOY/i2nOGRFhoLxq1Mmr/Sq7+xJjr987nJkE2qhg7HM=;
        b=IputrZ6e+O5DZ5FKRU/kq7Srag4A3/NLKE/WSElVxEjJCnobftMaCdDXxbjIQ5PxJ+
         8sFyFPK7GzPU44FHV7elHk/SJOY1W0itGUms989Ir4QQo8XpXeOOmYqVH42fUoFGWgmX
         yqsacaTAgVNHlO1VFF7hSOdodDLVIFInqt+Z/ELkLu4EutVJI0isITTj7pJ7d1jC/Oym
         eLUjb10W3ZzS48iuc8LR4/9Qop/FDMzwb/QZrY6Pup3CbzmcxN13GNnZA+coA2vm+QhS
         XL+8+sll1o8uDj5TxzTxFAuOm0XHJX0WDSmcFAB1tCqTOppzIXHCV72WKPLOantR6LQF
         9lXg==
X-Gm-Message-State: AOJu0YxqJil8PehmhnSA60/gOmRQS2pVwlI/8Z2NfIHA+mSAN4pXrwWi
	RjDehtaMsNkKlULC0E0EoT1imqHYBvmgAzrK22bs6cgxC8erVw==
X-Google-Smtp-Source: AGHT+IGelZc1gc5/e+y22sYnKENqs2Bq1Q4lYZbTflO0z8ywa0yQBhz6itp8xnxym93z/zEtgVw5QUPDEMVNguqEgfg=
X-Received: by 2002:a17:906:e2c5:b0:a28:d396:6e8b with SMTP id
 gr5-20020a170906e2c500b00a28d3966e8bmr602408ejb.34.1704390138390; Thu, 04 Jan
 2024 09:42:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102141851.105144-1-alexghiti@rivosinc.com> <ZZU9s7iHDTBD39C0@xhacker>
In-Reply-To: <ZZU9s7iHDTBD39C0@xhacker>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 18:42:07 +0100
Message-ID: <CAHVXubgpMFesz8C-tY4qY0OGzB3Jfyp1eK6YafN8GQN=u7Etyg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jisheng,

On Wed, Jan 3, 2024 at 12:10=E2=80=AFPM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Tue, Jan 02, 2024 at 03:18:51PM +0100, Alexandre Ghiti wrote:
> > Allow to defer the flushing of the TLB when unmapping pges, which allow=
s
> > to reduce the numbers of IPI and the number of sfence.vma.
> >
> > The ubenchmarch used in commit 43b3dfdd0455 ("arm64: support
> > batched/deferred tlb shootdown during page reclamation/migration") show=
s
> > good performance improvement and perf reports an important decrease in
> > time spent flushing the tlb (results come from qemu):
>
> Hi Alex,
>
> I tried this micro benchmark with your patch on T-HEAD TH1520 platform, I
> didn't see any performance improvement for the micro benchmark. Per
> myunderstanding, the micro benchmark is special case for arm64 because
> in a normal tlb flush flow, below sequence is necessary:
>
> tlbi
> dsb
>
>
> while with BATCHED_UNMAP_TLB_FLUSH, the arm64 just does 'tlbi', leaving
> the dsb to the arch_tlbbatch_flush(). So the final result is
>
> several 'tlbi + dsb' sequence VS. several 'tlbi' instructions + only one =
dsb
> The performance improvement comes from the unnecessary dsb eliminations.

Some batching should take place, and with this patch, we only send one
"full" sfence.vma instead of a "local" sfence.vma for each page, it
seems weird that you don't see any improvement, I would have thought
that one "full" sfence.vma would be better.

>
> Do you have suitable benchmark(s) for BATCHED_UNMAP_TLB_FLUSH on riscv?

Can you give the following benchmark a try? I simply created threads
and dispatched them on all the cpus to force IPI usage, that should be
way better if the batching of the first ubenchmark is not enough to
exacerbate performance improvements, let me know and thanks for your
tests!

#define _GNU_SOURCE
#include <pthread.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/mman.h>
#include <string.h>
#include <errno.h>
#include <sched.h>
#include <time.h>

int stick_this_thread_to_core(int core_id) {
        int num_cores =3D sysconf(_SC_NPROCESSORS_ONLN);
        if (core_id < 0 || core_id >=3D num_cores)
           return EINVAL;

        cpu_set_t cpuset;
        CPU_ZERO(&cpuset);
        CPU_SET(core_id, &cpuset);

        pthread_t current_thread =3D pthread_self();
        return pthread_setaffinity_np(current_thread,
sizeof(cpu_set_t), &cpuset);
}

static void *fn_thread (void *p_data)
{
        int ret;
        pthread_t thread;

        stick_this_thread_to_core((int)p_data);

        while (1) {
                sleep(1);
        }

        return NULL;
}

int main()
{
#define SIZE (1 * 1024 * 1024)
        volatile unsigned char *p =3D mmap(NULL, SIZE, PROT_READ | PROT_WRI=
TE,
                                         MAP_SHARED | MAP_ANONYMOUS, -1, 0)=
;
        pthread_t threads[4];
        int ret;

        for (int i =3D 0; i < 4; ++i) {
                ret =3D pthread_create(&threads[i], NULL, fn_thread, (void =
*)i);
                if (ret)
                {
                        printf("%s", strerror (ret));
                }
        }

        memset(p, 0x88, SIZE);

        for (int k =3D 0; k < 500 /* 10000 */; k++) {
                /* swap in */
                for (int i =3D 0; i < SIZE; i +=3D 4096) {
                        (void)p[i];
                }

                /* swap out */
                madvise(p, SIZE, MADV_PAGEOUT);
        }

        for (int i =3D 0; i < 4; i++)
        {
                pthread_cancel(threads[i]);
        }

        for (int i =3D 0; i < 4; i++)
        {
                pthread_join(threads[i], NULL);
        }

        return 0;

}

>
> Thanks
>
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
> >
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
> > +                       FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> > +}
> > +#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
> > --
> > 2.39.2
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

