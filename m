Return-Path: <linux-kernel+bounces-84232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BBF86A3EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225C31F220F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922515646F;
	Tue, 27 Feb 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNmyuU+C"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0355E4E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077593; cv=none; b=JNen9BO4AOUm81T+29AN/4WiwCeTvk9rALI4SvQeAxN6rRxr+vaqCvujK1ywQmad27fywy2af04lhmb0Ya+0N2BHHwOlEN7qnEt4qA3GRyqPM7P0CmjDzMicBmRQdlWWWuaDpOhJP2xHc5v666B0jQ9xjl1cZ3vWZAFcGhkYx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077593; c=relaxed/simple;
	bh=VGh3acFZGfOdjYydFCXtfSyPDlqtotmXuZQv4rTql34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4yZRycPwW7iDAHdcJDdOFosFb1D3yj/wJbEKviKHsEnVW8l8cnCMAY13zYSXOmkh8eoRFP8nhq1ykEAok32qdH9eCYMiuH2v48S5nZApMk4atA1e0nqed7HiTZ9Y6N9yrx8o+4TNjrQYd8RBHmN6aa41PLzb2ev5rkAMt9uy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNmyuU+C; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so351605276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709077591; x=1709682391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZz3p2A7RI7L01958ow5hSvNRkDHntNWyAAk2EK1SjU=;
        b=lNmyuU+CCXKJC74k1H1FxwZUFLaagxg0urml6J9+YakMsVmTfJtwMomnN8nKxd19p0
         rKIhLFMN/YrSPavJ1Ia12t66k1/1EItXIhWTLewmhVisdaP5ZGVLkGNYkcXgtse1jO6K
         BUc7yTh4szpUmNR6V0j7NGLov/BvKuzytK+/7zu766GNr13cM6Tt9OU9k7zdw2+u/wa8
         pOGMPhS7ijPTa+gbbwNnT5mgjPodso/fwHDrBqKas/UPenLSNeVLISddfshKqZYkvhZq
         CqrEYAcN1SYITo77wkLQc/PTgBq0PS9ZDFRbw+mxX/zuztxKgdruQm67UlXFkdeUV+b5
         jGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709077591; x=1709682391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZz3p2A7RI7L01958ow5hSvNRkDHntNWyAAk2EK1SjU=;
        b=alKhIVITb7YIS8VU2FcgkQj1n8lEhmwC/9tmpkO5fll24o8DAiQDgP1/CFGP4mVXuW
         dIEtp4/Pc5W/Lk5dfSaxmI8464avxlEqFIxrrwKdIa0mUPeOKyFlpywgvqESnIYTqrtT
         kB+T4HEzOT6Pm393GDB5L/yjHk/WmGsUUkCb8LzXcEPgyA1n0Gv7Lu/LH9CIjh1132Sh
         8Pw2sWi3cagvKcpXlmD/4UV2PllZmZK7JZGZjAGUVYPY7ninmizU9hu2hSiwPYawkGIC
         pfJfSwPGNiD+dM7/4dM8xbtmtzaQdezo70g2KgnEPoVrOoFG8NtQjEINVELTcyPyN4id
         yi/g==
X-Gm-Message-State: AOJu0YyMMbCOuKQimZynGPDVmg6MGX7YcfX+pdMGqCW6fFn5EdvvN3Ww
	KdS8uXkXfnA5QBmFeUOeg/iHPc4+ysQvm/NCWuOdGuSKOPmBNqP2Bt91Nn2Pj6a/GF9cwsUOi/b
	tzziL97zQA5/Z9Bv4FbMYyLkY8z8=
X-Google-Smtp-Source: AGHT+IFcAHC9P+2wk/dIxyeIP6q9s517UZikGNg6ASNVpWUi833sNrRl/ToG90a7iwvyipZamuw/48a50Q/NXXqZYZc=
X-Received: by 2002:a25:a20a:0:b0:dcb:df38:1c20 with SMTP id
 b10-20020a25a20a000000b00dcbdf381c20mr621378ybi.24.1709077590654; Tue, 27 Feb
 2024 15:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227201548.857831-1-david@redhat.com>
In-Reply-To: <20240227201548.857831-1-david@redhat.com>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 27 Feb 2024 15:46:19 -0800
Message-ID: <CAOzc2pwZ0G7ujQqSeK5e17YEWMx0BVw+W7FL9GEHfp4bT3-beg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: convert folio_estimated_sharers() to folio_likely_mapped_shared()
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:15=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> Callers of folio_estimated_sharers() only care about "mapped shared vs.
> mapped exclusively", not the exact estimate of sharers. Let's consolidate
> and unify the condition users are checking. While at it clarify the
> semantics and extend the discussion on the fuzziness.
>
> Use the "likely mapped shared" terminology to better express what the
> (adjusted) function actually checks.
>
> Whether a partially-mappable folio is more likely to not be partially
> mapped than partially mapped is debatable. In the future, we might be abl=
e
> to improve our estimate for partially-mappable folios, though.
>
> Note that we will now consistently detect "mapped shared" only if the
> first subpage is actually mapped multiple times. When the first subpage
> is not mapped, we will consistently detect it as "mapped exclusively".
> This change should currently only affect the usage in
> madvise_free_pte_range() and queue_folios_pte_range() for large folios: i=
f
> the first page was already unmapped, we would have skipped the folio.
>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

> ---
>  include/linux/mm.h | 46 ++++++++++++++++++++++++++++++++++++----------
>  mm/huge_memory.c   |  2 +-
>  mm/madvise.c       |  6 +++---
>  mm/memory.c        |  2 +-
>  mm/mempolicy.c     | 14 ++++++--------
>  mm/migrate.c       |  8 ++++----
>  6 files changed, 51 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6f4825d829656..795c89632265f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2147,21 +2147,47 @@ static inline size_t folio_size(struct folio *fol=
io)
>  }
>
>  /**
> - * folio_estimated_sharers - Estimate the number of sharers of a folio.
> + * folio_likely_mapped_shared - Estimate if the folio is mapped into the=
 page
> + *                             tables of more than one MM
>   * @folio: The folio.
>   *
> - * folio_estimated_sharers() aims to serve as a function to efficiently
> - * estimate the number of processes sharing a folio. This is done by
> - * looking at the precise mapcount of the first subpage in the folio, an=
d
> - * assuming the other subpages are the same. This may not be true for la=
rge
> - * folios. If you want exact mapcounts for exact calculations, look at
> - * page_mapcount() or folio_total_mapcount().
> + * This function checks if the folio is currently mapped into more than =
one
> + * MM ("mapped shared"), or if the folio is only mapped into a single MM
> + * ("mapped exclusively").
>   *
> - * Return: The estimated number of processes sharing a folio.
> + * As precise information is not easily available for all folios, this f=
unction
> + * estimates the number of MMs ("sharers") that are currently mapping a =
folio
> + * using the number of times the first page of the folio is currently ma=
pped
> + * into page tables.
> + *
> + * For small anonymous folios (except KSM folios) and anonymous hugetlb =
folios,
> + * the return value will be exactly correct, because they can only be ma=
pped
> + * at most once into an MM, and they cannot be partially mapped.
> + *
> + * For other folios, the result can be fuzzy:
> + * (a) For partially-mappable large folios (THP), the return value can w=
rongly
> + *     indicate "mapped exclusively" (false negative) when the folio is
> + *     only partially mapped into at least one MM.
> + * (b) For pagecache folios (including hugetlb), the return value can wr=
ongly
> + *     indicate "mapped shared" (false positive) when two VMAs in the sa=
me MM
> + *     cover the same file range.
> + * (c) For (small) KSM folios, the return value can wrongly indicate "ma=
pped
> + *     shared" (false negative), when the folio is mapped multiple times=
 into
> + *     the same MM.
> + *
> + * Further, this function only considers current page table mappings tha=
t
> + * are tracked using the folio mapcount(s). It does not consider:
> + * (1) If the folio might get mapped in the (near) future (e.g., swapcac=
he,
> + *     pagecache, temporary unmapping for migration).
> + * (2) If the folio is mapped differently (VM_PFNMAP).
> + * (3) If hugetlb page table sharing applies. Callers might want to chec=
k
> + *     hugetlb_pmd_shared().
> + *
> + * Return: Whether the folio is estimated to be mapped into more than on=
e MM.
>   */
> -static inline int folio_estimated_sharers(struct folio *folio)
> +static inline bool folio_likely_mapped_shared(struct folio *folio)
>  {
> -       return page_mapcount(folio_page(folio, 0));
> +       return page_mapcount(folio_page(folio, 0)) > 1;
>  }
>
>  #ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 50d146eb248ff..4d10904fef70c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1829,7 +1829,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, =
struct vm_area_struct *vma,
>          * If other processes are mapping this folio, we couldn't discard
>          * the folio unless they all do MADV_FREE so let's skip the folio=
.
>          */
> -       if (folio_estimated_sharers(folio) !=3D 1)
> +       if (folio_likely_mapped_shared(folio))
>                 goto out;
>
>         if (!folio_trylock(folio))
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 44a498c94158c..32a534d200219 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -366,7 +366,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>                 folio =3D pfn_folio(pmd_pfn(orig_pmd));
>
>                 /* Do not interfere with other mappings of this folio */
> -               if (folio_estimated_sharers(folio) !=3D 1)
> +               if (folio_likely_mapped_shared(folio))
>                         goto huge_unlock;
>
>                 if (pageout_anon_only_filter && !folio_test_anon(folio))
> @@ -453,7 +453,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>                 if (folio_test_large(folio)) {
>                         int err;
>
> -                       if (folio_estimated_sharers(folio) > 1)
> +                       if (folio_likely_mapped_shared(folio))
>                                 break;
>                         if (pageout_anon_only_filter && !folio_test_anon(=
folio))
>                                 break;
> @@ -677,7 +677,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigne=
d long addr,
>                 if (folio_test_large(folio)) {
>                         int err;
>
> -                       if (folio_estimated_sharers(folio) !=3D 1)
> +                       if (folio_likely_mapped_shared(folio))
>                                 break;
>                         if (!folio_trylock(folio))
>                                 break;
> diff --git a/mm/memory.c b/mm/memory.c
> index 1c45b6a42a1b9..8394a9843ca06 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5173,7 +5173,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
>          * Flag if the folio is shared between multiple address spaces. T=
his
>          * is later used when determining whether to group tasks together
>          */
> -       if (folio_estimated_sharers(folio) > 1 && (vma->vm_flags & VM_SHA=
RED))
> +       if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHAR=
ED))
>                 flags |=3D TNF_SHARED;
>
>         nid =3D folio_nid(folio);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index f60b4c99f1302..0b92fde395182 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -642,12 +642,11 @@ static int queue_folios_hugetlb(pte_t *pte, unsigne=
d long hmask,
>          * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared fo=
lio.
>          * Choosing not to migrate a shared folio is not counted as a fai=
lure.
>          *
> -        * To check if the folio is shared, ideally we want to make sure
> -        * every page is mapped to the same process. Doing that is very
> -        * expensive, so check the estimated sharers of the folio instead=
.
> +        * See folio_likely_mapped_shared() on possible imprecision when =
we
> +        * cannot easily detect if a folio is shared.
>          */
>         if ((flags & MPOL_MF_MOVE_ALL) ||
> -           (folio_estimated_sharers(folio) =3D=3D 1 && !hugetlb_pmd_shar=
ed(pte)))
> +           (!folio_likely_mapped_shared(folio) && !hugetlb_pmd_shared(pt=
e)))
>                 if (!isolate_hugetlb(folio, qp->pagelist))
>                         qp->nr_failed++;
>  unlock:
> @@ -1032,11 +1031,10 @@ static bool migrate_folio_add(struct folio *folio=
, struct list_head *foliolist,
>          * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a shared fo=
lio.
>          * Choosing not to migrate a shared folio is not counted as a fai=
lure.
>          *
> -        * To check if the folio is shared, ideally we want to make sure
> -        * every page is mapped to the same process. Doing that is very
> -        * expensive, so check the estimated sharers of the folio instead=
.
> +        * See folio_likely_mapped_shared() on possible imprecision when =
we
> +        * cannot easily detect if a folio is shared.
>          */
> -       if ((flags & MPOL_MF_MOVE_ALL) || folio_estimated_sharers(folio) =
=3D=3D 1) {
> +       if ((flags & MPOL_MF_MOVE_ALL) || !folio_likely_mapped_shared(fol=
io)) {
>                 if (folio_isolate_lru(folio)) {
>                         list_add_tail(&folio->lru, foliolist);
>                         node_stat_mod_folio(folio,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 73a052a382f13..35d376969f8b9 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2568,11 +2568,11 @@ int migrate_misplaced_folio(struct folio *folio, =
struct vm_area_struct *vma,
>         /*
>          * Don't migrate file folios that are mapped in multiple processe=
s
>          * with execute permissions as they are probably shared libraries=
.
> -        * To check if the folio is shared, ideally we want to make sure
> -        * every page is mapped to the same process. Doing that is very
> -        * expensive, so check the estimated mapcount of the folio instea=
d.
> +        *
> +        * See folio_likely_mapped_shared() on possible imprecision when =
we
> +        * cannot easily detect if a folio is shared.
>          */
> -       if (folio_estimated_sharers(folio) !=3D 1 && folio_is_file_lru(fo=
lio) &&
> +       if (folio_likely_mapped_shared(folio) && folio_is_file_lru(folio)=
 &&
>             (vma->vm_flags & VM_EXEC))
>                 goto out;
>
> --
> 2.43.2
>

