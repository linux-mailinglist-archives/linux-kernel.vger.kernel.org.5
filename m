Return-Path: <linux-kernel+bounces-16347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDD823D16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618BD28626C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB6200AC;
	Thu,  4 Jan 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Z8CLdfdv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC90B200A8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so141159a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704355204; x=1704960004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j91KlY5ms3kzoQq2fHSTKld4bDhCBANr8vl1qdOQNfc=;
        b=Z8CLdfdvW1B658R2HXDkp0jFRhVNMhAb1vnHnuplOQVesM3M3s3K3pxrpr4SsMD0Kl
         UIWubt67/MC997mJjFiVh4kAxi1h2fJ0LUtB2SZYZnkyjb+UVa+Rn4e58gnnCUj1KhZ2
         1NRY04dke8V6Cx7jJTZPo/se8LIVd9m2Su4mki0yNJEawX7PSpagFxwlxpkJLv3JQLl0
         GWs+6FeqeCEtKg+Ci79+WY/V6unfSdtB6+lCZEmW079JqL5p4+cosKJScYxyvCBldSp6
         QqphZUOdglF23i8/DHugQf5EXt9Scbtzi7PWwgjH+W+O3e9M558/MAtKC1cridEmf9Cj
         LOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704355204; x=1704960004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j91KlY5ms3kzoQq2fHSTKld4bDhCBANr8vl1qdOQNfc=;
        b=rhIa3syckwrFFT//p1PRzPmdBKJNYUhfDqPiGtECoDZ/pdMThIpfE8t98/lSoUcDPq
         CKSfgQTZq7Oop8QQLJhRH0pf3yrIRUUw0yDgvm9QomIBYRoOgnVrxAxwdOmuMyqujOVQ
         UFdeijcpRLtIKiDYLxSNIIyONGpNi/iNjPhPqcJyQQPNeprwHN5YEzXs9rexqi9WL/f4
         RGln0vLUb/2uYMKkID6bTRSFXB9MR96QOLGQQgTcO+b51pU/Q1ahQLRBYWtdoyNoBiev
         B70/p+f85lFB8dpMLqA9nCBq33aZ8dbT5ZgqkBEn+YXaH76yWp3FyQjSr+rI5dGB12ge
         Ekbg==
X-Gm-Message-State: AOJu0YzcfWvt/DKxWqpWBncMvFR6vPBvcf/TnP9QZ6O9aJ40XZzcH866
	W8H20BCdfZQw31Bv6CheQYYiNIal7sCh1tk39yI1dXp1QNsM6w==
X-Google-Smtp-Source: AGHT+IHzs6iFWVOmrIghPxuuEESMTTUdRMTGJrLwla23+cWguHy879CJX8d4yi8yO0RjWdZb47f73XdX2eXfZcIqcvE=
X-Received: by 2002:a05:6a20:4e21:b0:198:fae2:5c39 with SMTP id
 gk33-20020a056a204e2100b00198fae25c39mr180827pzb.34.1704355203721; Thu, 04
 Jan 2024 00:00:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
 <20231123065708.91345-2-luxu.kernel@bytedance.com> <70de2d00-703f-4f9d-9800-fd50ac7b4e21@ghiti.fr>
In-Reply-To: <70de2d00-703f-4f9d-9800-fd50ac7b4e21@ghiti.fr>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Thu, 4 Jan 2024 15:59:52 +0800
Message-ID: <CAPYmKFtDuMjgaWHuYvcdgvO3ConjSthLdprpeH19+Ocw98=zSw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH V1 01/11] mm: Fix misused APIs on huge pte
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ardb@kernel.org, anup@brainfault.org, atishp@atishpatra.org, 
	dengliang.1214@bytedance.com, xieyongji@bytedance.com, 
	lihangjing@bytedance.com, songmuchun@bytedance.com, 
	punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

Thanks for your feedback!

On Mon, Jan 1, 2024 at 12:40=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Xu,
>
> On 23/11/2023 07:56, Xu Lu wrote:
> > There exist some paths that try to get value of huge pte via normal
> > pte API ptep_get instead of huge pte API huge_ptep_get. This commit
> > corrects these misused APIs.
> >
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >   arch/riscv/mm/hugetlbpage.c   |  2 +-
> >   fs/proc/task_mmu.c            |  2 +-
> >   include/asm-generic/hugetlb.h |  7 +++++++
> >   mm/hugetlb.c                  |  2 +-
> >   mm/migrate.c                  |  5 ++++-
> >   mm/mprotect.c                 |  2 +-
> >   mm/rmap.c                     | 10 ++++++++--
> >   mm/vmalloc.c                  |  3 ++-
> >   8 files changed, 25 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> > index b52f0210481f..d7cf8e2d3c5b 100644
> > --- a/arch/riscv/mm/hugetlbpage.c
> > +++ b/arch/riscv/mm/hugetlbpage.c
> > @@ -74,7 +74,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
> >
> >   out:
> >       if (pte) {
> > -             pte_t pteval =3D ptep_get_lockless(pte);
> > +             pte_t pteval =3D huge_ptep_get_lockless(pte);
> >
> >               WARN_ON_ONCE(pte_present(pteval) && !pte_huge(pteval));
> >       }
>
>
> Only looking at riscv for this patch, this change does not look
> necessary as the pte value is only used to check if the pte is huge or
> not, it does not use the A/D bits.
>
> Thanks,
>
> Alex
>

Your observation is very accurate. The pte value here does not use the A/D =
bits.

Actually, the modification here is to ensure the match between pte
type and pte operating functions. In this patch version,
'huge_ptep_get_lockless' and 'ptep_get_lockless' won't traverse pte
array in pte_t to check A/D bits. Instead, to ensure atomicity, they
just get the value of the first pte element and use it to generate the
whole pte_t struct. Thus they may lead to potential A/D bits loss. In
our opinion, if one wants to check the A/D bit to indicate following
page flushing or page swapping, he should acquire page table lock and
use huge_ptep_get/ptep_get instead.

Regards,

Xu

>
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index ef2eb12906da..0fe9d23aa062 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -726,7 +726,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned=
 long hmask,
> >       struct mem_size_stats *mss =3D walk->private;
> >       struct vm_area_struct *vma =3D walk->vma;
> >       struct page *page =3D NULL;
> > -     pte_t ptent =3D ptep_get(pte);
> > +     pte_t ptent =3D huge_ptep_get(pte);
> >
> >       if (pte_present(ptent)) {
> >               page =3D vm_normal_page(vma, addr, ptent);
> > diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetl=
b.h
> > index 6dcf4d576970..52c299db971a 100644
> > --- a/include/asm-generic/hugetlb.h
> > +++ b/include/asm-generic/hugetlb.h
> > @@ -150,6 +150,13 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
> >   }
> >   #endif
> >
> > +#ifndef __HAVE_ARCH_HUGE_PTEP_GET_LOCKLESS
> > +static inline pte_t huge_ptep_get_lockless(pte_t *ptep)
> > +{
> > +     return huge_ptep_get(ptep);
> > +}
> > +#endif
> > +
> >   #ifndef __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
> >   static inline bool gigantic_page_runtime_supported(void)
> >   {
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 1169ef2f2176..9f773eb95b3b 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -7406,7 +7406,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struc=
t vm_area_struct *vma,
> >       }
> >
> >       if (pte) {
> > -             pte_t pteval =3D ptep_get_lockless(pte);
> > +             pte_t pteval =3D huge_ptep_get_lockless(pte);
> >
> >               BUG_ON(pte_present(pteval) && !pte_huge(pteval));
> >       }
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 35a88334bb3c..d0daf58e486e 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -210,7 +210,10 @@ static bool remove_migration_pte(struct folio *fol=
io,
> >
> >               folio_get(folio);
> >               pte =3D mk_pte(new, READ_ONCE(vma->vm_page_prot));
> > -             old_pte =3D ptep_get(pvmw.pte);
> > +             if (folio_test_hugetlb(folio))
> > +                     old_pte =3D huge_ptep_get(pvmw.pte);
> > +             else
> > +                     old_pte =3D ptep_get(pvmw.pte);
> >               if (pte_swp_soft_dirty(old_pte))
> >                       pte =3D pte_mksoft_dirty(pte);
> >
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 81991102f785..b9129c03f451 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -555,7 +555,7 @@ static int prot_none_hugetlb_entry(pte_t *pte, unsi=
gned long hmask,
> >                                  unsigned long addr, unsigned long next=
,
> >                                  struct mm_walk *walk)
> >   {
> > -     return pfn_modify_allowed(pte_pfn(ptep_get(pte)),
> > +     return pfn_modify_allowed(pte_pfn(huge_ptep_get(pte)),
> >                                 *(pgprot_t *)(walk->private)) ?
> >               0 : -EACCES;
> >   }
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 7a27a2b41802..d93c6dabbdf4 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1577,7 +1577,10 @@ static bool try_to_unmap_one(struct folio *folio=
, struct vm_area_struct *vma,
> >                       break;
> >               }
> >
> > -             pfn =3D pte_pfn(ptep_get(pvmw.pte));
> > +             if (folio_test_hugetlb(folio))
> > +                     pfn =3D pte_pfn(huge_ptep_get(pvmw.pte));
> > +             else
> > +                     pfn =3D pte_pfn(ptep_get(pvmw.pte));
> >               subpage =3D folio_page(folio, pfn - folio_pfn(folio));
> >               address =3D pvmw.address;
> >               anon_exclusive =3D folio_test_anon(folio) &&
> > @@ -1931,7 +1934,10 @@ static bool try_to_migrate_one(struct folio *fol=
io, struct vm_area_struct *vma,
> >               /* Unexpected PMD-mapped THP? */
> >               VM_BUG_ON_FOLIO(!pvmw.pte, folio);
> >
> > -             pfn =3D pte_pfn(ptep_get(pvmw.pte));
> > +             if (folio_test_hugetlb(folio))
> > +                     pfn =3D pte_pfn(huge_ptep_get(pvmw.pte));
> > +             else
> > +                     pfn =3D pte_pfn(ptep_get(pvmw.pte));
> >
> >               if (folio_is_zone_device(folio)) {
> >                       /*
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d12a17fc0c17..1a451b82a7ac 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -103,7 +103,6 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long=
 addr, unsigned long end,
> >       if (!pte)
> >               return -ENOMEM;
> >       do {
> > -             BUG_ON(!pte_none(ptep_get(pte)));
> >
> >   #ifdef CONFIG_HUGETLB_PAGE
> >               size =3D arch_vmap_pte_range_map_size(addr, end, pfn, max=
_page_shift);
> > @@ -111,11 +110,13 @@ static int vmap_pte_range(pmd_t *pmd, unsigned lo=
ng addr, unsigned long end,
> >                       pte_t entry =3D pfn_pte(pfn, prot);
> >
> >                       entry =3D arch_make_huge_pte(entry, ilog2(size), =
0);
> > +                     BUG_ON(!pte_none(huge_ptep_get(pte)));
> >                       set_huge_pte_at(&init_mm, addr, pte, entry, size)=
;
> >                       pfn +=3D PFN_DOWN(size);
> >                       continue;
> >               }
> >   #endif
> > +             BUG_ON(!pte_none(ptep_get(pte)));
> >               set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
> >               pfn++;
> >       } while (pte +=3D PFN_DOWN(size), addr +=3D size, addr !=3D end);

