Return-Path: <linux-kernel+bounces-84220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F13586A3B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22821F21C83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4352756749;
	Tue, 27 Feb 2024 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1EX/d8e"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367715646D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076577; cv=none; b=FPza6LAoqV76p/9U5Mq1/O2635e7/N55A7rIO2qBPCbM7d7BrJ8/um7BYezzsZarNompi67Zz4ZB6gqZyVdduuSuvUnAf57kpanIUCI2RW6xBVle47UykwU8f7s7tFxo6tD5U7i51U0EYuJ+DM4b82Mso5YUtTBUCtD9653oWv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076577; c=relaxed/simple;
	bh=zKGF7Z5yoV9p4humhsqI1fzpBZ0r4r5ELfCDgEYVEus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3zuYtKAcMLkBkWDVMSbA7KoTtd0ihMqOCbPPG7Esejlw6sNUv1Jtxgt8VKAGks93A8bqx443ZW6vB9K1w/ziBOL80iatNu3QR0T0NLRKrYEW3T74j46EKdQki5ehm48K9oHNSM8BcPeJQkZ0+/jaI8i7ZoCXLRD6FeXCe4gVE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1EX/d8e; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4d335a593e6so196486e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709076574; x=1709681374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/HZWWY/BxyXj68/kdx8luNNS+VFIwwb3gQYHrbtGh4=;
        b=l1EX/d8ei5KVRJm7QiAMZNUDpmyVcq1zC0XQkXWWEHMt80LShC2qtem3Fguay36Bl+
         ZHr/6wJZd/AM4SKU9J/O7Fy1UoF09UNJpbdLLIpx6opKyG7d/hJNp2rAlXtIKV1g/QHS
         pVkxHLjG4PnYcTQx2AL5bAVTEb0k2n/3DkH/pCuIntqR0H9QKKHBnaIRDDD+P5gjCwNq
         MqmnymqCw9BNWZ4JPsmI7GuihRG8k2VAu+S4wzuvX7xXwfNChVB1ROUv5LWOr2TuXu4G
         yHgbzCPBB1VC3bGjvcz4l1rCH2iiIBZp6n9/jv4U4HfaWWfuvRdvsOfGP6ujOgwxeA0L
         wzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709076574; x=1709681374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/HZWWY/BxyXj68/kdx8luNNS+VFIwwb3gQYHrbtGh4=;
        b=IxAIf+H/r4NZMFGfTKrip5gCtQ0XHj95kHtyzvJj8FrYzUIl7Ed4mkaLoNTL+OdKx6
         l/KM4Zcde5sGMbeL+Wl7PR2p0z0h7oR1obMLB/aYrlVkwLTwjYkAA1B0/AvffWMNJnyh
         ej80b+w1CvbFBPDrhTUXsKgmwkvSwJo2QI+Xf8kVW9n/wNFplQh5a98UOrHAkl0WH8Gp
         kKkRvbBFrxpp2/aQRke04i1n9E0H7AoKmbprHj6sHaTY/hgfjR42GmAU5OFRyN4CQkba
         aNGrInjKHYkJqm9FWQ/MPlVhWVT9p4O0kpDVu/BMhW/spfi3HUM+x1zjXKkOjKZ+qedv
         IeIw==
X-Gm-Message-State: AOJu0YyTQ0uHqVxIdhqs89IjJEl1d2cKy+5QXPShHmcFTgkhZiK+Q+3o
	fLoW8g8bFvwK4RUba7YgnvctjtgDxkIkNw0Yg3Q1ns2evSv4Xnxg2DAz+7GJkWIAmmb2ClPIFHm
	yIBl0yK3baPC6gGUNg302dHiyoHM=
X-Google-Smtp-Source: AGHT+IH3RZcyV+rgPNWxhx4xvCOiXGF6Ap3KkGHlOO0i0klIiDnagjT9CcYHs28t/yHvoOYo8YX3mXUEX9PuHswQRSw=
X-Received: by 2002:a1f:e681:0:b0:4c8:f33e:67a9 with SMTP id
 d123-20020a1fe681000000b004c8f33e67a9mr8067233vkh.5.1709076574054; Tue, 27
 Feb 2024 15:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227201548.857831-1-david@redhat.com>
In-Reply-To: <20240227201548.857831-1-david@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 12:29:22 +1300
Message-ID: <CAGsJ_4y9juMbcM4GxpXDQWBQbU0DQJChEhcr0NG0h_3X0iX-AQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: convert folio_estimated_sharers() to folio_likely_mapped_shared()
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <v-songbaohua@oppo.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:16=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
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

LGTM,
Acked-by: Barry Song <v-songbaohua@oppo.com>

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
>

Thanks
Barry

