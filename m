Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B77FE8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjK3F6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3F56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:57:58 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E2910C2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 21:58:03 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7bae8dd095cso180348241.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 21:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701323883; x=1701928683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ8T2AVd1TEdvlGm/KeDu4CbfSK765E9B8zJ1w8JmFo=;
        b=cSaMwxwT6gHPukY8EfUv+RN/wUYfk1o0+xF4NHm/5avVfGMW76UeNmxKhT2GGtyG5P
         LN4SMF/iDLhKGEhcx1rRIyxCaQ8AxKw9kd8dZddlCUfuq/6LdKz1Ergo0QPEJLPG7RDk
         HeGXnpgM4iGPJ/Jyr8PXFXJScdmrdGxJ1h2sM3V80aDZ0IFje1r7kXn5s9g8KGw5Py2N
         qsJWa4IhqZmC7uLpUMyOL9X4LP3rjCsx/dcvUn3kFOB4j4WvfTO0cFLjgOfhDhKog+bp
         q3+RRpTO2cS+DpV2YNQK16YwVqkunIAgpR4js0UhQc25tBHuwzDlboPH4UbTCfEEmTiV
         Zj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701323883; x=1701928683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ8T2AVd1TEdvlGm/KeDu4CbfSK765E9B8zJ1w8JmFo=;
        b=b+wvpX152p+6yykpMJTj2k2JPY6vySU+bR6VOitKm22Ec7ZrB4eVOZ0SqsePE7tetf
         ALt7VNuMhfgZvHYy2PPE0HFmafhTMzNxn+Fv7BaGolo8KaGl8RqvAqkX7ij/3LI18t4K
         G/XMVhvcsAPNzs6kWdY3GKuTPOBhm2blZ2q3leyX6e6iIDkcpfRfPe7KpjBbxEWdN86a
         wKoHvhkSCG1Q8k6aSZ9V+JAGH78VpiqJIsWyBncMYOsUdeelUdIRhCacgo6TxzRkVit+
         t0RxbkGhtInMJAb/TXAq09nyZBR3pxCcg/Pfa8OuAN2Npild1pivjHxj/TS5yjCNi32J
         SWCQ==
X-Gm-Message-State: AOJu0Yx0fbFTAVHn+GtvtLtn8RGvWXs68g8kH9GRQ2T30Cn3/RILd62w
        YRDH3jud9ukBVWlkLwaVdWST+9zUlMcA6EiZyrk=
X-Google-Smtp-Source: AGHT+IFTJr02VFozbq16Tjw02IUNLB92Nj/s3C4W68qnRY6vM4R8SrTGleqTQByduvQ/X/T2sovpZjjhePi5h9kUN3M=
X-Received: by 2002:a67:fe06:0:b0:464:47e1:a5e8 with SMTP id
 l6-20020a67fe06000000b0046447e1a5e8mr4731331vsr.19.1701323882746; Wed, 29 Nov
 2023 21:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-15-ryan.roberts@arm.com> <87fs0xxd5g.fsf@nvdebian.thelocal>
 <3b4f6bff-6322-4394-9efb-9c3b9ef52010@arm.com> <87y1eovsn5.fsf@nvdebian.thelocal>
 <8fca9ed7-f916-4abe-8284-6e3c9fa33a8c@arm.com> <87wmu3pro8.fsf@nvdebian.thelocal>
 <26c78fee-4b7a-4d73-9f8b-2e25bbae20e8@arm.com> <87o7fepdun.fsf@nvdebian.thelocal>
 <b4906e1e-8009-4097-8d17-642374a049fe@arm.com> <b6d4b33b-6224-444f-9542-d3cb95afd382@arm.com>
 <87leafg768.fsf@nvdebian.thelocal>
In-Reply-To: <87leafg768.fsf@nvdebian.thelocal>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 30 Nov 2023 13:57:45 +0800
Message-ID: <CAGsJ_4x=R4YT68gY99Y5BVBTn+rd4=iVvCoU-UJ_+Uh+D4uc7g@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 30, 2023 at 1:08=E2=80=AFPM Alistair Popple <apopple@nvidia.com=
> wrote:
>
>
> Ryan Roberts <ryan.roberts@arm.com> writes:
>
> >>>> So if we do need to deal with racing HW, I'm pretty sure my v1 imple=
mentation is
> >>>> buggy because it iterated through the PTEs, getting and accumulating=
. Then
> >>>> iterated again, writing that final set of bits to all the PTEs. And =
the HW could
> >>>> have modified the bits during those loops. I think it would be possi=
ble to fix
> >>>> the race, but intuition says it would be expensive.
> >>>
> >>> So the issue as I understand it is subsequent iterations would see a
> >>> clean PTE after the first iteration returned a dirty PTE. In
> >>> ptep_get_and_clear_full() why couldn't you just copy the dirty/access=
ed
> >>> bit (if set) from the PTE being cleared to an adjacent PTE rather tha=
n
> >>> all the PTEs?
> >>
> >> The raciness I'm describing is the race between reading access/dirty f=
rom one
> >> pte and applying it to another. But yes I like your suggestion. if we =
do:
> >>
> >> pte =3D __ptep_get_and_clear_full(ptep)
> >>
> >> on the target pte, then we have grabbed access/dirty from it in a race=
-free
> >> manner. we can then loop from current pte up towards the top of the bl=
ock until
> >> we find a valid entry (and I guess wrap at the top to make us robust a=
gainst
> >> future callers clearing an an arbitrary order). Then atomically accumu=
late the
> >> access/dirty bits we have just saved into that new entry. I guess that=
's just a
> >> cmpxchg loop - there are already examples of how to do that correctly =
when
> >> racing the TLB.
> >>
> >> For most entries, we will just be copying up to the next pte. For the =
last pte,
> >> we would end up reading all ptes and determine we are the last one.
> >>
> >> What do you think?
> >
> > OK here is an attempt at something which solves the fragility. I think =
this is
> > now robust and will always return the correct access/dirty state from
> > ptep_get_and_clear_full() and ptep_get().
> >
> > But I'm not sure about performance; each call to ptep_get_and_clear_ful=
l() for
> > each pte in a contpte block will cause a ptep_get() to gather the acces=
s/dirty
> > bits from across the contpte block - which requires reading each pte in=
 the
> > contpte block. So its O(n^2) in that sense. I'll benchmark it and repor=
t back.
> >
> > Was this the type of thing you were thinking of, Alistair?
>
> Yes, that is along the lines of what I was thinking. However I have
> added a couple of comments inline.
>
> > --8<--
> >  arch/arm64/include/asm/pgtable.h | 23 ++++++++-
> >  arch/arm64/mm/contpte.c          | 81 ++++++++++++++++++++++++++++++++
> >  arch/arm64/mm/fault.c            | 38 +++++++++------
> >  3 files changed, 125 insertions(+), 17 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/=
pgtable.h
> > index 9bd2f57a9e11..6c295d277784 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -851,6 +851,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t =
newprot)
> >       return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
> >  }
> >
> > +extern int __ptep_set_access_flags_notlbi(pte_t *ptep, pte_t entry);
> >  extern int __ptep_set_access_flags(struct vm_area_struct *vma,
> >                                unsigned long address, pte_t *ptep,
> >                                pte_t entry, int dirty);
> > @@ -1145,6 +1146,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t =
orig_pte);
> >  extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
> >  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
> >                               pte_t *ptep, pte_t pte, unsigned int nr);
> > +extern pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
> > +                             unsigned long addr, pte_t *ptep);
> >  extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vm=
a,
> >                               unsigned long addr, pte_t *ptep);
> >  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
> > @@ -1270,12 +1273,28 @@ static inline void pte_clear(struct mm_struct *=
mm,
> >       __pte_clear(mm, addr, ptep);
> >  }
> >
> > +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
> > +static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
> > +                             unsigned long addr, pte_t *ptep, int full=
)
> > +{
> > +     pte_t orig_pte =3D __ptep_get(ptep);
> > +
> > +     if (!pte_valid_cont(orig_pte))
> > +             return __ptep_get_and_clear(mm, addr, ptep);
> > +
> > +     if (!full) {
> > +             contpte_try_unfold(mm, addr, ptep, orig_pte);
> > +             return __ptep_get_and_clear(mm, addr, ptep);
> > +     }
> > +
> > +     return contpte_ptep_get_and_clear_full(mm, addr, ptep);
> > +}
> > +
> >  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
> >  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
> >                               unsigned long addr, pte_t *ptep)
> >  {
> > -     contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> > -     return __ptep_get_and_clear(mm, addr, ptep);
> > +     return ptep_get_and_clear_full(mm, addr, ptep, 0);
> >  }
> >
> >  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> > diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> > index 2a57df16bf58..99b211118d93 100644
> > --- a/arch/arm64/mm/contpte.c
> > +++ b/arch/arm64/mm/contpte.c
> > @@ -145,6 +145,14 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte=
)
> >       for (i =3D 0; i < CONT_PTES; i++, ptep++) {
> >               pte =3D __ptep_get(ptep);
> >
> > +             /*
> > +              * Deal with the partial contpte_ptep_get_and_clear_full(=
) case,
> > +              * where some of the ptes in the range may be cleared but=
 others
> > +              * are still to do. See contpte_ptep_get_and_clear_full()=
.
> > +              */
> > +             if (!pte_valid(pte))
> > +                     continue;
> > +
> >               if (pte_dirty(pte))
> >                       orig_pte =3D pte_mkdirty(orig_pte);
> >
> > @@ -257,6 +265,79 @@ void contpte_set_ptes(struct mm_struct *mm, unsign=
ed long addr,
> >  }
> >  EXPORT_SYMBOL(contpte_set_ptes);
> >
> > +pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
> > +                                     unsigned long addr, pte_t *ptep)
> > +{
> > +     /*
> > +      * When doing a full address space teardown, we can avoid unfoldi=
ng the
> > +      * contiguous range, and therefore avoid the associated tlbi. Ins=
tead,
> > +      * just get and clear the pte. The caller is promising to call us=
 for
> > +      * every pte, so every pte in the range will be cleared by the ti=
me the
> > +      * final tlbi is issued.
> > +      *
> > +      * This approach requires some complex hoop jumping though, as fo=
r the
> > +      * duration between returning from the first call to
> > +      * ptep_get_and_clear_full() and making the final call, the contp=
te
> > +      * block is in an intermediate state, where some ptes are cleared=
 and
> > +      * others are still set with the PTE_CONT bit. If any other APIs =
are
> > +      * called for the ptes in the contpte block during that time, we =
have to
> > +      * be very careful. The core code currently interleaves calls to
> > +      * ptep_get_and_clear_full() with ptep_get() and so ptep_get() mu=
st be
> > +      * careful to ignore the cleared entries when accumulating the ac=
cess
> > +      * and dirty bits - the same goes for ptep_get_lockless(). The on=
ly
> > +      * other calls we might resonably expect are to set markers in th=
e
> > +      * previously cleared ptes. (We shouldn't see valid entries being=
 set
> > +      * until after the tlbi, at which point we are no longer in the
> > +      * intermediate state). Since markers are not valid, this is safe=
;
> > +      * set_ptes() will see the old, invalid entry and will not attemp=
t to
> > +      * unfold. And the new pte is also invalid so it won't attempt to=
 fold.
> > +      * We shouldn't see pte markers being set for the 'full' case any=
way
> > +      * since the address space is being torn down.
> > +      *
> > +      * The last remaining issue is returning the access/dirty bits. T=
hat
> > +      * info could be present in any of the ptes in the contpte block.
> > +      * ptep_get() will gather those bits from across the contpte bloc=
k (for
> > +      * the remaining valid entries). So below, if the pte we are clea=
ring
> > +      * has dirty or young set, we need to stash it into a pte that we=
 are
> > +      * yet to clear. This allows future calls to return the correct s=
tate
> > +      * even when the info was stored in a different pte. Since the co=
re-mm
> > +      * calls from low to high address, we prefer to stash in the last=
 pte of
> > +      * the contpte block - this means we are not "dragging" the bits =
up
> > +      * through all ptes and increases the chances that we can exit ea=
rly
> > +      * because a given pte will have neither dirty or young set.
> > +      */
> > +
> > +     pte_t orig_pte =3D __ptep_get_and_clear(mm, addr, ptep);
> > +     bool dirty =3D pte_dirty(orig_pte);
> > +     bool young =3D pte_young(orig_pte);
> > +     pte_t *start;
> > +
> > +     if (!dirty && !young)
> > +             return contpte_ptep_get(ptep, orig_pte);
>
> I don't think we need to do this. If the PTE is !dirty && !young we can
> just return it. As you say we have to assume HW can set those flags at
> any time anyway so it doesn't get us much. This means in the common case
> we should only run through the loop setting the dirty/young flags once
> which should alay the performance concerns.
>
> However I am now wondering if we're doing the wrong thing trying to hide
> this down in the arch layer anyway. Perhaps it would be better to deal
> with this in the core-mm code after all.
>
> So how about having ptep_get_and_clear_full() clearing the PTEs for the
> entire cont block? We know by definition all PTEs should be pointing to

I truly believe we should clear all PTEs for the entire folio block. Howeve=
r,
if the existing api ptep_get_and_clear_full() is always handling a single o=
ne
PTE, we might keep its behaviour as is.  On the other hand, clearing the
whole block isn't only required in fullmm case, it is also a requirement fo=
r
normal zap_pte_range() cases coming from madvise(DONTNEED) etc.

I do think we need a folio-level variant. as we are now supporting
pte-level large
folios, we need some new api to handle folio-level PTEs entirely as we alwa=
ys
have the needs to drop the whole folio rather than one by one when they are
compound.

> the same folio anyway, and it seems at least zap_pte_range() would cope
> with this just fine because subsequent iterations would just see
> pte_none() and continue the loop. I haven't checked the other call sites
> though, but in principal I don't see why we couldn't define
> ptep_get_and_clear_full() as being something that clears all PTEs
> mapping a given folio (although it might need renaming).
>
> This does assume you don't need to partially unmap a page in
> zap_pte_range (ie. end >=3D folio), but we're already making that
> assumption.
>
> > +
> > +     start =3D contpte_align_down(ptep);
> > +     ptep =3D start + CONT_PTES - 1;
> > +
> > +     for (; ptep >=3D start; ptep--) {
> > +             pte_t pte =3D __ptep_get(ptep);
> > +
> > +             if (!pte_valid(pte))
> > +                     continue;
> > +
> > +             if (dirty)
> > +                     pte =3D pte_mkdirty(pte);
> > +
> > +             if (young)
> > +                     pte =3D pte_mkyoung(pte);
> > +
> > +             __ptep_set_access_flags_notlbi(ptep, pte);
> > +             return contpte_ptep_get(ptep, orig_pte);
> > +     }
> > +
> > +     return orig_pte;
> > +}
> > +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
> > +
> >  int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
> >                                       unsigned long addr, pte_t *ptep)
> >  {
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index d63f3a0a7251..b22216a8153c 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -199,19 +199,7 @@ static void show_pte(unsigned long addr)
> >       pr_cont("\n");
> >  }
> >
> > -/*
> > - * This function sets the access flags (dirty, accessed), as well as w=
rite
> > - * permission, and only to a more permissive setting.
> > - *
> > - * It needs to cope with hardware update of the accessed/dirty state b=
y other
> > - * agents in the system and can safely skip the __sync_icache_dcache()=
 call as,
> > - * like __set_ptes(), the PTE is never changed from no-exec to exec he=
re.
> > - *
> > - * Returns whether or not the PTE actually changed.
> > - */
> > -int __ptep_set_access_flags(struct vm_area_struct *vma,
> > -                         unsigned long address, pte_t *ptep,
> > -                         pte_t entry, int dirty)
> > +int __ptep_set_access_flags_notlbi(pte_t *ptep, pte_t entry)
> >  {
> >       pteval_t old_pteval, pteval;
> >       pte_t pte =3D __ptep_get(ptep);
> > @@ -238,10 +226,30 @@ int __ptep_set_access_flags(struct vm_area_struct=
 *vma,
> >               pteval =3D cmpxchg_relaxed(&pte_val(*ptep), old_pteval, p=
teval);
> >       } while (pteval !=3D old_pteval);
> >
> > +     return 1;
> > +}
> > +
> > +/*
> > + * This function sets the access flags (dirty, accessed), as well as w=
rite
> > + * permission, and only to a more permissive setting.
> > + *
> > + * It needs to cope with hardware update of the accessed/dirty state b=
y other
> > + * agents in the system and can safely skip the __sync_icache_dcache()=
 call as,
> > + * like __set_ptes(), the PTE is never changed from no-exec to exec he=
re.
> > + *
> > + * Returns whether or not the PTE actually changed.
> > + */
> > +int __ptep_set_access_flags(struct vm_area_struct *vma,
> > +                         unsigned long address, pte_t *ptep,
> > +                         pte_t entry, int dirty)
> > +{
> > +     int changed =3D __ptep_set_access_flags_notlbi(ptep, entry);
> > +
> >       /* Invalidate a stale read-only entry */
> > -     if (dirty)
> > +     if (changed && dirty)
> >               flush_tlb_page(vma, address);
> > -     return 1;
> > +
> > +     return changed;
> >  }
> >
> >  static bool is_el1_instruction_abort(unsigned long esr)
> > --8<--
>

Thanks
Barry
