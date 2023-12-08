Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BBD80A5D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574012AbjLHOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573993AbjLHOj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:39:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA00B1996
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:39:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c317723a8so11198965e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702046373; x=1702651173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plEFwaE2+Q6Q8bRZcZwrG+K/OzVydU2DtAmeqHfEJNY=;
        b=cA2GVmHcDRoAjXLmrjMwSuD7CGT2cEMK7CqyO6lctU2OOdD4Ccsx4TkHwIG0F4JS+T
         PGNdQrodT/i6Fm4nPrWyhd4KvnWHK2334nKeXem9MZYr1S4CcNsCOuYnF7lZYB5LThUj
         Ez/M9hIDOsmBA1LxUp9M3fHM8nUZvfrU+l1AvBQ98269bmTbZIG89LC6CfCAvdzRXwiA
         O+5zFfAMUY0118/Mnj9TdbKgwLuTlsrLKhPajxxPpaLVpZnq1zWiHAStOWG/BaRpoOF9
         miTi+m6jKGOXSZF4vIb5J+dis6lqzdjk8lJCjWaF5Zf7cmzz/reUEyEpqYvI5eFx9IoC
         d6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702046373; x=1702651173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plEFwaE2+Q6Q8bRZcZwrG+K/OzVydU2DtAmeqHfEJNY=;
        b=qlS8TrNWBO1Y9+CpZPiDtV1iotTeR5mrlAsCvMzEQt4R6/ptk2WX6pxa4gWE6jHF9H
         hH1Y7/4UAFkyvqU9v3JakmRJ8dt8khM/apppBafHZA5D+6+4xpAo3LzRY+e5JBIl4jXF
         vHTkn5xneAXFUOspxZMgBD4pw9e6kdYSX+JlOPHclQs9m1ORV3IV6GBHgSzJmWeFaFo6
         EMXTs020bDwJR+kT4ikjfXtmthnIvF10V0xjtV9xJrDvEjcXKp9M20AUcbDD9L6fS1s+
         L+AUiYwk1rof4f/IgcdKu79/cpIpXXFR22BE7X+jzCD5vpyAmHsRlO3UUvhB4EX8Deku
         D8dQ==
X-Gm-Message-State: AOJu0YxkOxpDR3Z4+5NOFzFX0HlOZQL4NuqMZPw/JovY4M+SwXWtleY9
        BKgl23WDXLMfAxk3ZqFlfbC09+qRVHoLr1Jwre9OXw==
X-Google-Smtp-Source: AGHT+IEZLjmE7HkIBSBz3WRiqIUfV9PHqTmdLRaDQ/JxQGZgxMlCwLfYkoIRf7OcHv/10DAdN5KKuRkNmNs5aSm2deg=
X-Received: by 2002:a05:600c:2107:b0:40b:5e21:d339 with SMTP id
 u7-20020a05600c210700b0040b5e21d339mr40565wml.66.1702046373348; Fri, 08 Dec
 2023 06:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20231207150348.82096-1-alexghiti@rivosinc.com>
 <20231207150348.82096-4-alexghiti@rivosinc.com> <e783436f-631c-4b02-ba9c-b6145e0e8b5a@csgroup.eu>
In-Reply-To: <e783436f-631c-4b02-ba9c-b6145e0e8b5a@csgroup.eu>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 8 Dec 2023 15:39:22 +0100
Message-ID: <CAHVXubit2NjBREKFb=s14q13PvtcjuthLn2oKnBq8PfFnVMieQ@mail.gmail.com>
Subject: Re: [PATCH RFC/RFT 3/4] riscv: Stop emitting preventive sfence.vma
 for new userspace mappings
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ved Shanbhogue <ved@rivosinc.com>,
        Matt Evans <mev@rivosinc.com>,
        Dylan Jhong <dylan@andestech.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 5:37=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> The subject says "riscv:" but it changes core part and several arch.
> Maybe this commit should be split in two commits, one for API changes
> that changes flush_tlb_fix_spurious_fault() to
> flush_tlb_fix_spurious_write_fault() and adds
> flush_tlb_fix_spurious_read_fault() including the change in memory.c,
> then a second patch with the changes to riscv.

You're right, I'll do that, thanks.

>
> Le 07/12/2023 =C3=A0 16:03, Alexandre Ghiti a =C3=A9crit :
> > The preventive sfence.vma were emitted because new mappings must be mad=
e
> > visible to the page table walker, either the uarch caches invalid
> > entries or not.
> >
> > Actually, there is no need to preventively sfence.vma on new mappings f=
or
> > userspace, this should be handled only in the page fault path.
> >
> > This allows to drastically reduce the number of sfence.vma emitted:
> >
> > * Ubuntu boot to login:
> > Before: ~630k sfence.vma
> > After:  ~200k sfence.vma
> >
> > * ltp - mmapstress01
> > Before: ~45k
> > After:  ~6.3k
> >
> > * lmbench - lat_pagefault
> > Before: ~665k
> > After:   832 (!)
> >
> > * lmbench - lat_mmap
> > Before: ~546k
> > After:   718 (!)
> >
> > The only issue with the removal of sfence.vma in update_mmu_cache() is
> > that on uarchs that cache invalid entries, those won't be invalidated
> > until the process takes a fault: so that's an additional fault in those
> > cases.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >   arch/arm64/include/asm/pgtable.h              |  2 +-
> >   arch/mips/include/asm/pgtable.h               |  6 +--
> >   arch/powerpc/include/asm/book3s/64/tlbflush.h |  8 ++--
> >   arch/riscv/include/asm/pgtable.h              | 43 +++++++++++-------=
-
> >   include/linux/pgtable.h                       |  8 +++-
> >   mm/memory.c                                   | 12 +++++-
> >   6 files changed, 48 insertions(+), 31 deletions(-)
>
> Did you forget mm/pgtable-generic.c ?

Indeed, I "missed" the occurrence of flush_tlb_fix_spurious_fault()
there, thanks.

>
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 7f7d9b1df4e5..728f25f529a5 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -57,7 +57,7 @@ static inline bool arch_thp_swp_supported(void)
> >    * fault on one CPU which has been handled concurrently by another CP=
U
> >    * does not need to perform additional invalidation.
> >    */
> > -#define flush_tlb_fix_spurious_fault(vma, address, ptep) do { } while =
(0)
> > +#define flush_tlb_fix_spurious_write_fault(vma, address, ptep) do { } =
while (0)
>
> Why do you need to do that change ? Nothing is explained about that in
> the commit message.

I renamed this macro because in the page fault path,
flush_tlb_fix_spurious_fault() is called only when the fault is a
write fault (see
https://elixir.bootlin.com/linux/latest/source/mm/memory.c#L5016).
I'll check if that fits the occurrence in mm/pgtable-generic.c too.

Thanks again for the review,

Alex

>
> >
> >   /*
> >    * ZERO_PAGE is a global shared page that is always zero: used
> > diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pg=
table.h
> > index 430b208c0130..84439fe6ed29 100644
> > --- a/arch/mips/include/asm/pgtable.h
> > +++ b/arch/mips/include/asm/pgtable.h
> > @@ -478,9 +478,9 @@ static inline pgprot_t pgprot_writecombine(pgprot_t=
 _prot)
> >       return __pgprot(prot);
> >   }
> >
> > -static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct =
*vma,
> > -                                             unsigned long address,
> > -                                             pte_t *ptep)
> > +static inline void flush_tlb_fix_spurious_write_fault(struct vm_area_s=
truct *vma,
> > +                                                   unsigned long addre=
ss,
> > +                                                   pte_t *ptep)
> >   {
> >   }
> >
> > diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/power=
pc/include/asm/book3s/64/tlbflush.h
> > index 1950c1b825b4..7166d56f90db 100644
> > --- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
> > +++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
> > @@ -128,10 +128,10 @@ static inline void flush_tlb_page(struct vm_area_=
struct *vma,
> >   #define flush_tlb_page(vma, addr)   local_flush_tlb_page(vma, addr)
> >   #endif /* CONFIG_SMP */
> >
> > -#define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
> > -static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct =
*vma,
> > -                                             unsigned long address,
> > -                                             pte_t *ptep)
> > +#define flush_tlb_fix_spurious_write_fault flush_tlb_fix_spurious_writ=
e_fault
> > +static inline void flush_tlb_fix_spurious_write_fault(struct vm_area_s=
truct *vma,
> > +                                                   unsigned long addre=
ss,
> > +                                                   pte_t *ptep)
> >   {
> >       /*
> >        * Book3S 64 does not require spurious fault flushes because the =
PTE
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index b2ba3f79cfe9..89aa5650f104 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -472,28 +472,20 @@ static inline void update_mmu_cache_range(struct =
vm_fault *vmf,
> >               struct vm_area_struct *vma, unsigned long address,
> >               pte_t *ptep, unsigned int nr)
> >   {
> > -     /*
> > -      * The kernel assumes that TLBs don't cache invalid entries, but
> > -      * in RISC-V, SFENCE.VMA specifies an ordering constraint, not a
> > -      * cache flush; it is necessary even after writing invalid entrie=
s.
> > -      * Relying on flush_tlb_fix_spurious_fault would suffice, but
> > -      * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
> > -      */
> > -     while (nr--)
> > -             local_flush_tlb_page(address + nr * PAGE_SIZE);
> >   }
> >   #define update_mmu_cache(vma, addr, ptep) \
> >       update_mmu_cache_range(NULL, vma, addr, ptep, 1)
> >
> >   #define __HAVE_ARCH_UPDATE_MMU_TLB
> > -#define update_mmu_tlb update_mmu_cache
> > +static inline void update_mmu_tlb(struct vm_area_struct *vma,
> > +                               unsigned long address, pte_t *ptep)
> > +{
> > +     flush_tlb_range(vma, address, address + PAGE_SIZE);
> > +}
> >
> >   static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
> >               unsigned long address, pmd_t *pmdp)
> >   {
> > -     pte_t *ptep =3D (pte_t *)pmdp;
> > -
> > -     update_mmu_cache(vma, address, ptep);
> >   }
> >
> >   #define __HAVE_ARCH_PTE_SAME
> > @@ -548,13 +540,26 @@ static inline int ptep_set_access_flags(struct vm=
_area_struct *vma,
> >                                       unsigned long address, pte_t *pte=
p,
> >                                       pte_t entry, int dirty)
> >   {
> > -     if (!pte_same(*ptep, entry))
> > +     if (!pte_same(*ptep, entry)) {
> >               __set_pte_at(ptep, entry);
> > -     /*
> > -      * update_mmu_cache will unconditionally execute, handling both
> > -      * the case that the PTE changed and the spurious fault case.
> > -      */
> > -     return true;
> > +             /* Here only not svadu is impacted */
> > +             flush_tlb_page(vma, address);
> > +             return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +extern u64 nr_sfence_vma_handle_exception;
> > +extern bool tlb_caching_invalid_entries;
> > +
> > +#define flush_tlb_fix_spurious_read_fault flush_tlb_fix_spurious_read_=
fault
> > +static inline void flush_tlb_fix_spurious_read_fault(struct vm_area_st=
ruct *vma,
> > +                                                  unsigned long addres=
s,
> > +                                                  pte_t *ptep)
> > +{
> > +     if (tlb_caching_invalid_entries)
> > +             flush_tlb_page(vma, address);
> >   }
> >
> >   #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index af7639c3b0a3..7abaf42ef612 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -931,8 +931,12 @@ static inline void arch_swap_restore(swp_entry_t e=
ntry, struct folio *folio)
> >   # define pte_accessible(mm, pte)    ((void)(pte), 1)
> >   #endif
> >
> > -#ifndef flush_tlb_fix_spurious_fault
> > -#define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_pag=
e(vma, address)
> > +#ifndef flush_tlb_fix_spurious_write_fault
> > +#define flush_tlb_fix_spurious_write_fault(vma, address, ptep) flush_t=
lb_page(vma, address)
> > +#endif
> > +
> > +#ifndef flush_tlb_fix_spurious_read_fault
> > +#define flush_tlb_fix_spurious_read_fault(vma, address, ptep)
> >   #endif
> >
> >   /*
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 517221f01303..5cb0ccf0c03f 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5014,8 +5014,16 @@ static vm_fault_t handle_pte_fault(struct vm_fau=
lt *vmf)
> >                * with threads.
> >                */
> >               if (vmf->flags & FAULT_FLAG_WRITE)
> > -                     flush_tlb_fix_spurious_fault(vmf->vma, vmf->addre=
ss,
> > -                                                  vmf->pte);
> > +                     flush_tlb_fix_spurious_write_fault(vmf->vma, vmf-=
>address,
> > +                                                        vmf->pte);
> > +             else
> > +                     /*
> > +                      * With the pte_same(ptep_get(vmf->pte), entry) c=
heck
> > +                      * that calls update_mmu_tlb() above, multiple th=
reads
> > +                      * faulting at the same time won't get there.
> > +                      */
> > +                     flush_tlb_fix_spurious_read_fault(vmf->vma, vmf->=
address,
> > +                                                       vmf->pte);
> >       }
> >   unlock:
> >       pte_unmap_unlock(vmf->pte, vmf->ptl);
