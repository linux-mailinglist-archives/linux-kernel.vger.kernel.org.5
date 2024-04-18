Return-Path: <linux-kernel+bounces-149596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54868A9345
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF801F216E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F54249E5;
	Thu, 18 Apr 2024 06:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik9GgEqa"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4986F9E9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422467; cv=none; b=HrB/pPenhWr3CCQ2Z0Vij/U1WJzjQGL/5r3Ff2LhhJEsc44kNJwbMBe2APDzAeb5Z9KNi63AFvjkf3B4lOmfN2ito2Mroulf02Rmj6rK3wMaIcHA4IJZYBjtEhxgYII/MlZb5SWEu0exsaTTfGniK283ja2Z4Y1GaJjswJ860mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422467; c=relaxed/simple;
	bh=YCGca0HmuMoGzksuJmN6LIUBTV1yjU/EK/K2wYM1GTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fAEeGTTJ66W7bY4KSEWLPQmXQGzrVIlTMUwN6xZrn1SL5lSV9QJydw7F/Xa74w5lQnuVZyVVzBP5zAevx5XbiHT5h7lYIV3T9Lf649oujy+3vYVDHp53VjU5pHNzgkj5NsTusg1vkaNAYOop2B3UsT45zX+NGg7OtQWU/BvTgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ik9GgEqa; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5708d8a773aso510050a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713422464; x=1714027264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIerMe8DUgO/cLvMnfZab0s5jOGtP6wHZHAzU3l1c0E=;
        b=Ik9GgEqaaR/asy7y9qa5VICZA3PYDr8JbsoI9QtPz2R7NAr+vUM7nGgCeXbO6a8cDO
         1a0IxHM8Y0czo19VelskhkN0os1k0cfjQWp+s3PapNUFBlZebcutivMMS2x3jq1yrPf5
         JIqdDB5PzMbimhMC7fWg/stx671BScBUXN6J+hzDKvcntRcJyMFOyaTo5RqcYsaTgn0x
         VEj4LBMmL2W8Q6a6SKgFmXgAhTiHk8jJflj+THk8IXx+ZNjm8LNcR9ZGeULbzJ4sCvrP
         PddifFvi/rsAs7ed90tkvoTUXMIu447DWV817NJQoXqS6BFXcuM/XK+yKybf1BBjTsdb
         8Qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713422464; x=1714027264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIerMe8DUgO/cLvMnfZab0s5jOGtP6wHZHAzU3l1c0E=;
        b=Lc8uhVm+rBSLi4cnt88MdoD6+ovjWvMIvRVy3E3cGj3G7CEXfWx5ia7uHOc3b5QeiV
         mOSCAyeziZ+02Bo50J1O/fClBXcg4EqqHI2xwGiQwCwlckWOLl1pZT/wEcSJ4iNOzsvS
         ReRg4jNSzmzX35BIWivwE45wUmhAz+Dr2s7+Fy9gqgWj4tLscyQefVqNXT2Ro+WI82bP
         yGQIdKIrXDcmHnNAw9e8a1Y8sgFNnpFvZl7t47/jbp8h1oeh4qFBluKRuv7X6fZY5/2b
         P5ZQb0YwJjmj4hLhuRzAr/vBJGD+w2dnU9Wz9jMrE1Ld4ERlxwkgkTAclYocafaWjjeU
         dOzg==
X-Forwarded-Encrypted: i=1; AJvYcCX3oXuvF10BfAEcuPl7tt+BQRr45uGV9cstLlW9j+Dv2NdAwParb52nHFD4uBTZxoPB7M47gwqnJKLkuXihKttDEl7Tb2q7Pnd7y+lQ
X-Gm-Message-State: AOJu0Yw2+h+Icd4jNb1FxgbAshAihONDztS2IwLeKvmH9m1QsrkFGSq9
	OiOtHnfXH+Ko3szO5O8AAbuSLj8Ei4kq3FdzjyJG/RoWBCOcJf9dAMNfUcGLInRglzsYouHUhZz
	5qR/04do9XgzrmNb2v9OGmtYDpsg=
X-Google-Smtp-Source: AGHT+IEQ3LDhpLFH5ATWJNwiISmPisd/m02AjpsHkEAeYYdCzggM9Oa0oxcnvypWBRgJfGu9OshAjGaGazlGe6r2g3k=
X-Received: by 2002:a50:9f83:0:b0:56e:3175:6065 with SMTP id
 c3-20020a509f83000000b0056e31756065mr1148834edf.9.1713422463742; Wed, 17 Apr
 2024 23:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417141111.77855-1-ioworker0@gmail.com> <2062c2d1-4ebb-4a40-89f9-3083e6912301@redhat.com>
In-Reply-To: <2062c2d1-4ebb-4a40-89f9-3083e6912301@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 18 Apr 2024 14:40:51 +0800
Message-ID: <CAK1f24kDtOVRC67khxazQw1fS9LUyRrTzzf_ewRqYHQQu_r6AQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, maskray@google.com, 
	ziy@nvidia.com, ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey David,

Thanks for taking time to review.

On Wed, Apr 17, 2024 at 11:02=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 17.04.24 16:11, Lance Yang wrote:
> > When the user no longer requires the pages, they would use madvise(madv=
_free)
> > to mark the pages as lazy free. IMO, they would not typically rewrite t=
o the
> > given range.
> >
> > At present, a PMD-mapped THP marked as lazyfree during shrink_folio_lis=
t()
> > is unconditionally split, which may be unnecessary. If the THP is exclu=
sively
> > mapped and clean, and the PMD associated with it is also clean, then we=
 can
> > attempt to remove the PMD mapping from it. This change will improve the
> > efficiency of memory reclamation in this case.
> >
> > On an Intel i5 CPU, reclaiming 1GiB of PMD-mapped THPs using
> > mem_cgroup_force_empty() results in the following runtimes in seconds
> > (shorter is better):
> >
> > --------------------------------------------
> > |     Old       |      New       |  Change  |
> > --------------------------------------------
> > |   0.683426    |    0.049197    |  -92.80% |
> > --------------------------------------------
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   include/linux/huge_mm.h |  1 +
> >   include/linux/rmap.h    |  1 +
> >   mm/huge_memory.c        |  2 +-
> >   mm/rmap.c               | 81 ++++++++++++++++++++++++++++++++++++++++=
+
> >   mm/vmscan.c             |  7 ++++
> >   5 files changed, 91 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 7cd07b83a3d0..02a71c05f68a 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -36,6 +36,7 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsign=
ed long old_addr,
> >   int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vm=
a,
> >                   pmd_t *pmd, unsigned long addr, pgprot_t newprot,
> >                   unsigned long cp_flags);
> > +inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd);
> >
> >   vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, pfn_t pfn, bool w=
rite);
> >   vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool w=
rite);
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index 0f906dc6d280..8c2f45713351 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -100,6 +100,7 @@ enum ttu_flags {
> >                                        * do a final flush if necessary =
*/
> >       TTU_RMAP_LOCKED         =3D 0x80, /* do not grab rmap lock:
> >                                        * caller holds it */
> > +     TTU_LAZYFREE_THP        =3D 0x100, /* avoid split PMD-mapped THP =
*/
> >   };
> >
> >   #ifdef CONFIG_MMU
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 58f2c4745d80..309fba9624c2 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -1801,7 +1801,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb=
, struct vm_area_struct *vma,
> >       return ret;
> >   }
> >
> > -static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pm=
d)
> > +inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
> >   {
> >       pgtable_t pgtable;
> >
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 2608c40dffad..4994f9e402d4 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -77,6 +77,7 @@
> >   #include <linux/mm_inline.h>
> >
> >   #include <asm/tlbflush.h>
> > +#include <asm/tlb.h>
> >
> >   #define CREATE_TRACE_POINTS
> >   #include <trace/events/tlb.h>
> > @@ -1606,6 +1607,80 @@ void folio_remove_rmap_pmd(struct folio *folio, =
struct page *page,
> >   #endif
> >   }
> >
> > +static bool __try_to_unmap_lazyfree_thp(struct vm_area_struct *vma,
> > +                                          unsigned long address,
> > +                                          struct folio *folio)
> > +{
> > +     spinlock_t *ptl;
> > +     pmd_t *pmdp, orig_pmd;
> > +     struct mmu_notifier_range range;
> > +     struct mmu_gather tlb;
> > +     struct mm_struct *mm =3D vma->vm_mm;
> > +     struct page *page;
> > +     bool ret =3D false;
> > +
> > +     VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> > +     VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
> > +     VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> > +     VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> > +
> > +     /*
> > +      * If we encounter a PMD-mapped THP that marked as lazyfree, we
> > +      * will try to unmap it without splitting.
> > +      *
> > +      * The folio exclusively mapped should only have two refs:
> > +      * one from the isolation and one from the rmap.
> > +      */
> > +     if (folio_entire_mapcount(folio) !=3D 1 || folio_test_dirty(folio=
) ||
> > +         folio_ref_count(folio) !=3D 2)
>
> folio_mapcount() =3D=3D 1 is a bit nicer. Bit I assume you can drop that
> completely and only check the refcount?

Thanks for your suggestion!

 + if (folio_test_dirty(folio) || folio_ref_count(folio) !=3D 2)

I'm not sure if it's safe without checking the folio_mapcount.

>
> > +             return false;
> > +
> > +     pmdp =3D mm_find_pmd(mm, address);
> > +     if (unlikely(!pmdp))
> > +             return false;
> > +     if (pmd_dirty(*pmdp))
> > +             return false;
> > +
> > +     tlb_gather_mmu(&tlb, mm);
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
> > +                             address & HPAGE_PMD_MASK,
> > +                             (address & HPAGE_PMD_MASK) + HPAGE_PMD_SI=
ZE);
> > +     mmu_notifier_invalidate_range_start(&range);
> > +
> > +     ptl =3D pmd_lock(mm, pmdp);
> > +     orig_pmd =3D *pmdp;
> > +     if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd))=
)
> > +             goto out;
> > +
> > +     page =3D pmd_page(orig_pmd);
> > +     if (unlikely(page_folio(page) !=3D folio))
> > +             goto out;
> > +
> > +     orig_pmd =3D pmdp_huge_get_and_clear(mm, address, pmdp);
> > +     tlb_remove_pmd_tlb_entry(&tlb, pmdp, address);
>
> Until this point, the page could have been pinned (including GUP-fast)
> and we might be in trouble if we drop it.

Thanks for pointing that out!

+ if (pmd_dirty(orig_pmd) || folio_maybe_dma_pinned(folio) ||
folio_ref_count(folio) !=3D 2) {
+     set_pmd_at(mm, address, pmdp, orig_pmd);
+ } else {

Could I check the folio->_pincount using folio_maybe_dma_pinned() and
then re-check the refcount here? Or should I just re-check the refcount?

IIUC, this folio has been already unlinked from the PMD and the process
cannot get an additional pin on this folio.

Thanks again for the review!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

