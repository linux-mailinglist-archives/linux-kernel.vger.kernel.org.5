Return-Path: <linux-kernel+bounces-101264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA67787A4B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A20DB21AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBB920DCF;
	Wed, 13 Mar 2024 09:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Koi1DMhP"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B3B20B27
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321413; cv=none; b=qdDw1KwifZRHmBxmHfAEuMXOap/zocC2Ax6yx1+aY4vb+mLDPO52IH8PTwN6gzbFBiuPfcsNpWcLE8EtLtoUiLE5DFMaJsAGWazDBvIBKAa2Xmu/AkIFmj/R5TAlrbqVjz8mz2RMXkTRHKrbTORMoQ45vK5WgwvTNI32r8PYkmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321413; c=relaxed/simple;
	bh=rTC9dVyeHgt/3zKkA3JuHbSw772s7ADfMo6UU0gOiXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTSWUaf24iSP87HdaV53uvSvAME4T113CZHOKOAsp1V1aF04GNsOSqwmLc31hHe6TPchcEFdjE+kDXD1hR0ylacmHyDGqmIAsztdsRpWq2xx//AHIkGHI8Byyhm4pNHvstl14K6nJsVBMTI8IkDeN4FgUfzHpQC81ZPn2RAow0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Koi1DMhP; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4734ac202e9so368760137.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710321411; x=1710926211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbGysNzy8azciQHDutj0Ihd2Nn5dFJyFhOYOJqFccXQ=;
        b=Koi1DMhP5MfFn8GDZs88xuQFBZFQmmjrsinbthc/0Lw5lLQd7zOw8XnO+YP74A17SA
         WrXksmFUCNC20wohPj3j7xPnVNfd8RmDc8D5/6y//P2M6MSfWolGpvtfEK/Hj+ii9CNS
         0KbuzuCTuIF6Sbckb4Dld7AWngQ2RfiL54i17O9JBSK8GJMOZFLx2fQpwvZoAEkP0ePx
         90O8xRz6jPgtwJ6iFtyTpTRURYB0I/MrW/PxWlt0B2BdTJFcNXCYc7QNgSgV5a4vo6la
         X15Gko9Gr20IuhnYgD1VAInhfY5S8MA+qSu903JAzIEIM6XyFLbU/1hD0MUxlEG+V/Vb
         pZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710321411; x=1710926211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbGysNzy8azciQHDutj0Ihd2Nn5dFJyFhOYOJqFccXQ=;
        b=fDgDnSNuJ0VjYScxXvuGLQ61yFdW5pJ+39yp+UWwm5mu4WyYNO96arb1ADH72JS3xR
         +L/YQWf5DPqc2BOiPwkbRVf5fvJ+QmJH4qxdBMuQigHyY1w4of2nELnuw2MfW/qcFW7l
         BmYy/Nk8ZIbU2yFJIboeJJ/8aHWhet2qtuWVoRcqjElVdHPZ3GAOeBY7zWxOPyba3qml
         B51E3FqS8h97cKg/61MlvGkRm9PZ2SNhjkNet35H3Tio/tkOYqyxt++3jRZn1UmE+I1C
         wfuJvJeFKszesknDTIaJdvB9ZhrVJiXi4+wm5j3W6x9kfyAOI9YELXqK4QT/U4wpuEqv
         FWlg==
X-Forwarded-Encrypted: i=1; AJvYcCXxsSe+1mvzszSgapkW3kR9Fn25EY46vZ2WgAoH46rUSNg1jxHmuAflGi+QyvFiFUYBqEQKHrW4vhDvJ6p8jE+gkVKnPvw5TEoftP3g
X-Gm-Message-State: AOJu0Yyg3rh7xVSUfRGFUesV+81mZVal3LUXDMg3vrEN4FyGJkQb4/m/
	XMb+fvdaVo+1XZnFZS4/UZUMlptUWw+tRf2rROCEip0w9FSZtB9FMLBnQnMeLhpGX256LI5riRa
	rZEwyFMTGz/VkouOEnd3RXWjdzSg=
X-Google-Smtp-Source: AGHT+IHdLr+dSfOx+0apEmwfQsguD+wSPA81VYst3oPaFU7vcWvGMlEme/8iEUKyaXTE+PHL1Z51xqqp6EEQDFTP/p8=
X-Received: by 2002:a05:6102:721:b0:474:c620:129a with SMTP id
 u1-20020a056102072100b00474c620129amr1095310vsg.17.1710321410524; Wed, 13 Mar
 2024 02:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com> <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com>
In-Reply-To: <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 13 Mar 2024 22:16:39 +1300
Message-ID: <CAGsJ_4wodFkL4YZ1iQveUjK6QL7sNajyayBq4hJ3-GPoWJ6foQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:03=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 13/03/2024 07:19, Barry Song wrote:
> > On Tue, Mar 12, 2024 at 4:01=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any larg=
e
> >> folio that is fully and contiguously mapped in the pageout/cold vm
> >> range. This change means that large folios will be maintained all the
> >> way to swap storage. This both improves performance during swap-out, b=
y
> >> eliding the cost of splitting the folio, and sets us up nicely for
> >> maintaining the large folio when it is swapped back in (to be covered =
in
> >> a separate series).
> >>
> >> Folios that are not fully mapped in the target range are still split,
> >> but note that behavior is changed so that if the split fails for any
> >> reason (folio locked, shared, etc) we now leave it as is and move to t=
he
> >> next pte in the range and continue work on the proceeding folios.
> >> Previously any failure of this sort would cause the entire operation t=
o
> >> give up and no folios mapped at higher addresses were paged out or mad=
e
> >> cold. Given large folios are becoming more common, this old behavior
> >> would have likely lead to wasted opportunities.
> >>
> >> While we are at it, change the code that clears young from the ptes to
> >> use ptep_test_and_clear_young(), which is more efficent than
> >> get_and_clear/modify/set, especially for contpte mappings on arm64,
> >> where the old approach would require unfolding/refolding and the new
> >> approach can be done in place.
> >>
> >> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> >
> > This looks so much better than our initial RFC.
> > Thank you for your excellent work!
>
> Thanks - its a team effort - I had your PoC and David's previous batching=
 work
> to use as a template.
>
> >
> >> ---
> >>  mm/madvise.c | 89 ++++++++++++++++++++++++++++++---------------------=
-
> >>  1 file changed, 51 insertions(+), 38 deletions(-)
> >>
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index 547dcd1f7a39..56c7ba7bd558 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >>         LIST_HEAD(folio_list);
> >>         bool pageout_anon_only_filter;
> >>         unsigned int batch_count =3D 0;
> >> +       int nr;
> >>
> >>         if (fatal_signal_pending(current))
> >>                 return -EINTR;
> >> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >>                 return 0;
> >>         flush_tlb_batched_pending(mm);
> >>         arch_enter_lazy_mmu_mode();
> >> -       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
> >> +       for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
> >> +               nr =3D 1;
> >>                 ptent =3D ptep_get(pte);
> >>
> >>                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> >> @@ -447,55 +449,66 @@ static int madvise_cold_or_pageout_pte_range(pmd=
_t *pmd,
> >>                         continue;
> >>
> >>                 /*
> >> -                * Creating a THP page is expensive so split it only i=
f we
> >> -                * are sure it's worth. Split it if we are only owner.
> >> +                * If we encounter a large folio, only split it if it =
is not
> >> +                * fully mapped within the range we are operating on. =
Otherwise
> >> +                * leave it as is so that it can be swapped out whole.=
 If we
> >> +                * fail to split a folio, leave it in place and advanc=
e to the
> >> +                * next pte in the range.
> >>                  */
> >>                 if (folio_test_large(folio)) {
> >> -                       int err;
> >> -
> >> -                       if (folio_estimated_sharers(folio) > 1)
> >> -                               break;
> >> -                       if (pageout_anon_only_filter && !folio_test_an=
on(folio))
> >> -                               break;
> >> -                       if (!folio_trylock(folio))
> >> -                               break;
> >> -                       folio_get(folio);
> >> -                       arch_leave_lazy_mmu_mode();
> >> -                       pte_unmap_unlock(start_pte, ptl);
> >> -                       start_pte =3D NULL;
> >> -                       err =3D split_folio(folio);
> >> -                       folio_unlock(folio);
> >> -                       folio_put(folio);
> >> -                       if (err)
> >> -                               break;
> >> -                       start_pte =3D pte =3D
> >> -                               pte_offset_map_lock(mm, pmd, addr, &pt=
l);
> >> -                       if (!start_pte)
> >> -                               break;
> >> -                       arch_enter_lazy_mmu_mode();
> >> -                       pte--;
> >> -                       addr -=3D PAGE_SIZE;
> >> -                       continue;
> >> +                       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY |
> >> +                                               FPB_IGNORE_SOFT_DIRTY;
> >> +                       int max_nr =3D (end - addr) / PAGE_SIZE;
> >> +
> >> +                       nr =3D folio_pte_batch(folio, addr, pte, ptent=
, max_nr,
> >> +                                            fpb_flags, NULL);
> >
> > I wonder if we have a quick way to avoid folio_pte_batch() if users
> > are doing madvise() on a portion of a large folio.
>
> Good idea. Something like this?:
>
>         if (pte_pfn(pte) =3D=3D folio_pfn(folio)

what about

"If (pte_pfn(pte) =3D=3D folio_pfn(folio) && max_nr >=3D nr_pages)"

 just to account for cases where the user's end address falls within
the middle of a large folio?


BTW, another minor issue is here:

                if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
                        batch_count =3D 0;
                        if (need_resched()) {
                                arch_leave_lazy_mmu_mode();
                                pte_unmap_unlock(start_pte, ptl);
                                cond_resched();
                                goto restart;
                        }
                }

We are increasing 1 for nr ptes, thus, we are holding PTL longer
than small folios case? we used to increase 1 for each PTE.
Does it matter?

>                 nr =3D folio_pte_batch(folio, addr, pte, ptent, max_nr,
>                                      fpb_flags, NULL);
>
> If we are not mapping the first page of the folio, then it can't be a ful=
l
> mapping, so no need to call folio_pte_batch(). Just split it.
>
> >
> >> +
> >> +                       if (nr < folio_nr_pages(folio)) {
> >> +                               int err;
> >> +
> >> +                               if (folio_estimated_sharers(folio) > 1=
)
> >> +                                       continue;
> >> +                               if (pageout_anon_only_filter && !folio=
_test_anon(folio))
> >> +                                       continue;
> >> +                               if (!folio_trylock(folio))
> >> +                                       continue;
> >> +                               folio_get(folio);
> >> +                               arch_leave_lazy_mmu_mode();
> >> +                               pte_unmap_unlock(start_pte, ptl);
> >> +                               start_pte =3D NULL;
> >> +                               err =3D split_folio(folio);
> >> +                               folio_unlock(folio);
> >> +                               folio_put(folio);
> >> +                               if (err)
> >> +                                       continue;
> >> +                               start_pte =3D pte =3D
> >> +                                       pte_offset_map_lock(mm, pmd, a=
ddr, &ptl);
> >> +                               if (!start_pte)
> >> +                                       break;
> >> +                               arch_enter_lazy_mmu_mode();
> >> +                               nr =3D 0;
> >> +                               continue;
> >> +                       }
> >>                 }
> >>
> >>                 /*
> >>                  * Do not interfere with other mappings of this folio =
and
> >> -                * non-LRU folio.
> >> +                * non-LRU folio. If we have a large folio at this poi=
nt, we
> >> +                * know it is fully mapped so if its mapcount is the s=
ame as its
> >> +                * number of pages, it must be exclusive.
> >>                  */
> >> -               if (!folio_test_lru(folio) || folio_mapcount(folio) !=
=3D 1)
> >> +               if (!folio_test_lru(folio) ||
> >> +                   folio_mapcount(folio) !=3D folio_nr_pages(folio))
> >>                         continue;
> >
> > This looks so perfect and is exactly what I wanted to achieve.
> >
> >>
> >>                 if (pageout_anon_only_filter && !folio_test_anon(folio=
))
> >>                         continue;
> >>
> >> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >> -
> >> -               if (!pageout && pte_young(ptent)) {
> >> -                       ptent =3D ptep_get_and_clear_full(mm, addr, pt=
e,
> >> -                                                       tlb->fullmm);
> >> -                       ptent =3D pte_mkold(ptent);
> >> -                       set_pte_at(mm, addr, pte, ptent);
> >> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> >> +               if (!pageout) {
> >> +                       for (; nr !=3D 0; nr--, pte++, addr +=3D PAGE_=
SIZE) {
> >> +                               if (ptep_test_and_clear_young(vma, add=
r, pte))
> >> +                                       tlb_remove_tlb_entry(tlb, pte,=
 addr);
> >> +                       }
> >
> > This looks so smart. if it is not pageout, we have increased pte
> > and addr here; so nr is 0 and we don't need to increase again in
> > for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE)
> >
> > otherwise, nr won't be 0. so we will increase addr and
> > pte by nr.
>
> Indeed. I'm hoping that Lance is able to follow a similar pattern for
> madvise_free_pte_range().
>
>
> >
> >
> >>                 }
> >>
> >>                 /*
> >> --
> >> 2.25.1
> >>
> >
> > Overall, LGTM,
> >
> > Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>
> Thanks!
>
>

