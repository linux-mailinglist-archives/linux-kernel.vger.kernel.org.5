Return-Path: <linux-kernel+bounces-84188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A8586A374
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2A72942A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C5D55E6F;
	Tue, 27 Feb 2024 23:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTBWZuZ3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F7C55E48
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075943; cv=none; b=FowdKV2eCl8ZyotQ7RCL1Bqd1CYQkm3mPuOsxnDjZldQhIHTxeGI1GAbTY1nrfXW6DyTWZCRddu4rOOZtPIE/RNp1c/d89z/CjunBO0RWBUfJF8IYDs+6spTvCWDAtS0JQYgNsD37fIqphwgJikwjP4rQFDA+HmIK4OHpiWXeDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075943; c=relaxed/simple;
	bh=J/rjf5tMaNcfUn9YYabsx8GieQtnyoqfDdDiShchyvM=;
	h=From:Message-ID:Subject:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+GP0bnWqYeb+49i0zzsmeqWw6Bmexxt58Acj1oEmmXdKmTcpwtBZ4H9XxbCNftEXYyFGGo8Fl+T7LGz8p9sRwGF5GMWtOjWFsSmC1qLmlZ2n1jIZKfm+SaSCuse+IwsZl8GwYuNDHjnkForFDSKc5NHCCJaxTh95xpM/mOEEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTBWZuZ3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dca8b86ee7so22856315ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709075941; x=1709680741; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:subject:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k+BpDIFupl9L47GEChtRc9Hw8hU3e9sbyTct+1KRPXE=;
        b=iTBWZuZ3HUMStn2YNcucsOT64KCl9zFEEBwRP0shgdNUmXiCR/CYVIrElaNIA5xsZu
         q8ceZ/ev69Y4B2pC+FCQ2v0ss76DUXl3OpKl9SpzYboMWqnLVQCR8g+Eq4phSk2CsJle
         DCmxxrtGJksTpiVvO5/bplsZw944DtHcwJPG/5MLQE3VIT7QvD7obrHuUTcKE8SLcOty
         B0wMTxStHDvhg6eHs6EpM7KXw8XQlEaKtgaHZ9LSUnPPlk2dk8PUILHgZ5IY07Jhq05I
         MdDNWZLyO3LcVAOG2yzRhL1PnfSkRYPiaM8Egpt+DX7v5K8BrNhtsszj7IV2eR4lsbBE
         Phhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075941; x=1709680741;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:subject:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+BpDIFupl9L47GEChtRc9Hw8hU3e9sbyTct+1KRPXE=;
        b=p1E5gZGYPCzWDzoqrZN991FAbjni2V86Yu38JBDqNOVMGWodIfGMupuswBC9dvCdKD
         IgJKTjllLjve/adX19qTTDTRmESS8RwhTYETkv/qPs+JgkuMXtxbI47KK6cxV6eiVfU2
         g+9T4YOCe9QMtBQn5lxJJAMFrbSiNzsPv8/c0Ov6ZQ0sEXAhmAeOnwfmsfwNc1uBUZyF
         ThjkDGvEB/LH3EgVoV88G1SmYv0o5JPBo0oZuIg9dCbFF6uWWJ/Ma9UV0Hbd9dh/oj0J
         +ZdoP8+mvZKHBav1Dc0dHlLZb8znLV9Hy56u68+hd3LqZzzBewJ4bbtYwlKg0bxDJw8g
         5ytg==
X-Forwarded-Encrypted: i=1; AJvYcCUOUbYkLiymSwwcH8saMS0dHn+uVUVm8cHm4WXAI8z4eXZ6fr84QGWKQgjFelgi5y+K0I6TuAdPHITKh+sRWTHht3U56/ecK/b6eQNH
X-Gm-Message-State: AOJu0Yw77WjgbMY0o38PakfdxgbrsEO7NbiQ3k5+HM9LihyYcD1OjPHm
	2ValnMYvGRKALPql+fKk4ROS3DwQefj5T8ySBNxRl2Vqc5EpI9uY
X-Google-Smtp-Source: AGHT+IHhQQZwHOzSmMsfpAmkSOHt5WYPh3kxfwTYs5P+5qXT5n4tcCf/e0D5j/XBcPaQsMPNFJEhAg==
X-Received: by 2002:a17:902:8349:b0:1db:5b41:c5ac with SMTP id z9-20020a170902834900b001db5b41c5acmr9865212pln.68.1709075941149;
        Tue, 27 Feb 2024 15:19:01 -0800 (PST)
Received: from [10.239.156.40] ([148.87.23.13])
        by smtp.googlemail.com with ESMTPSA id az2-20020a170902a58200b001dca920ae40sm2030171plb.203.2024.02.27.15.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:19:00 -0800 (PST)
From: Khalid Aziz <gonehacking@gmail.com>
X-Google-Original-From: Khalid Aziz <khalid.aziz@oracle.com>
Message-ID: <661e519bc7753d784449931876a61f34bc8ad6ca.camel@oracle.com>
Subject: Re: [PATCH v1] mm: convert folio_estimated_sharers() to
 folio_likely_mapped_shared()
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Barry Song <v-songbaohua@oppo.com>, Vishal Moola
	 <vishal.moola@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>
Date: Tue, 27 Feb 2024 16:18:59 -0700
In-Reply-To: <20240227201548.857831-1-david@redhat.com>
References: <20240227201548.857831-1-david@redhat.com>
Autocrypt: addr=khalid.aziz@oracle.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 21:15 +0100, David Hildenbrand wrote:
> Callers of folio_estimated_sharers() only care about "mapped shared
> vs.
> mapped exclusively", not the exact estimate of sharers. Let's
> consolidate
> and unify the condition users are checking. While at it clarify the
> semantics and extend the discussion on the fuzziness.
>=20
> Use the "likely mapped shared" terminology to better express what the
> (adjusted) function actually checks.
>=20
> Whether a partially-mappable folio is more likely to not be partially
> mapped than partially mapped is debatable. In the future, we might be
> able
> to improve our estimate for partially-mappable folios, though.
>=20
> Note that we will now consistently detect "mapped shared" only if the
> first subpage is actually mapped multiple times. When the first
> subpage
> is not mapped, we will consistently detect it as "mapped
> exclusively".
> This change should currently only affect the usage in
> madvise_free_pte_range() and queue_folios_pte_range() for large
> folios: if
> the first page was already unmapped, we would have skipped the folio.
>=20
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>


This patch adds clarity while retaining current behavior, so looks good
to me.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>


> ---
> =C2=A0include/linux/mm.h | 46 ++++++++++++++++++++++++++++++++++++-------=
-
> --
> =C2=A0mm/huge_memory.c=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0mm/madvise.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A0mm/memory.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0mm/mempolicy.c=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++--------
> =C2=A0mm/migrate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++----
> =C2=A06 files changed, 51 insertions(+), 27 deletions(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6f4825d829656..795c89632265f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2147,21 +2147,47 @@ static inline size_t folio_size(struct folio
> *folio)
> =C2=A0}
> =C2=A0
> =C2=A0/**
> - * folio_estimated_sharers - Estimate the number of sharers of a
> folio.
> + * folio_likely_mapped_shared - Estimate if the folio is mapped into
> the page
> + *				tables of more than one MM
> =C2=A0 * @folio: The folio.
> =C2=A0 *
> - * folio_estimated_sharers() aims to serve as a function to
> efficiently
> - * estimate the number of processes sharing a folio. This is done by
> - * looking at the precise mapcount of the first subpage in the
> folio, and
> - * assuming the other subpages are the same. This may not be true
> for large
> - * folios. If you want exact mapcounts for exact calculations, look
> at
> - * page_mapcount() or folio_total_mapcount().
> + * This function checks if the folio is currently mapped into more
> than one
> + * MM ("mapped shared"), or if the folio is only mapped into a
> single MM
> + * ("mapped exclusively").
> =C2=A0 *
> - * Return: The estimated number of processes sharing a folio.
> + * As precise information is not easily available for all folios,
> this function
> + * estimates the number of MMs ("sharers") that are currently
> mapping a folio
> + * using the number of times the first page of the folio is
> currently mapped
> + * into page tables.
> + *
> + * For small anonymous folios (except KSM folios) and anonymous
> hugetlb folios,
> + * the return value will be exactly correct, because they can only
> be mapped
> + * at most once into an MM, and they cannot be partially mapped.
> + *
> + * For other folios, the result can be fuzzy:
> + * (a) For partially-mappable large folios (THP), the return value
> can wrongly
> + *=C2=A0=C2=A0=C2=A0=C2=A0 indicate "mapped exclusively" (false negative=
) when the folio
> is
> + *=C2=A0=C2=A0=C2=A0=C2=A0 only partially mapped into at least one MM.
> + * (b) For pagecache folios (including hugetlb), the return value
> can wrongly
> + *=C2=A0=C2=A0=C2=A0=C2=A0 indicate "mapped shared" (false positive) whe=
n two VMAs in
> the same MM
> + *=C2=A0=C2=A0=C2=A0=C2=A0 cover the same file range.
> + * (c) For (small) KSM folios, the return value can wrongly indicate
> "mapped
> + *=C2=A0=C2=A0=C2=A0=C2=A0 shared" (false negative), when the folio is m=
apped multiple
> times into
> + *=C2=A0=C2=A0=C2=A0=C2=A0 the same MM.
> + *
> + * Further, this function only considers current page table mappings
> that
> + * are tracked using the folio mapcount(s). It does not consider:
> + * (1) If the folio might get mapped in the (near) future (e.g.,
> swapcache,
> + *=C2=A0=C2=A0=C2=A0=C2=A0 pagecache, temporary unmapping for migration)=
.
> + * (2) If the folio is mapped differently (VM_PFNMAP).
> + * (3) If hugetlb page table sharing applies. Callers might want to
> check
> + *=C2=A0=C2=A0=C2=A0=C2=A0 hugetlb_pmd_shared().
> + *
> + * Return: Whether the folio is estimated to be mapped into more
> than one MM.
> =C2=A0 */
> -static inline int folio_estimated_sharers(struct folio *folio)
> +static inline bool folio_likely_mapped_shared(struct folio *folio)
> =C2=A0{
> -	return page_mapcount(folio_page(folio, 0));
> +	return page_mapcount(folio_page(folio, 0)) > 1;
> =C2=A0}
> =C2=A0
> =C2=A0#ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 50d146eb248ff..4d10904fef70c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1829,7 +1829,7 @@ bool madvise_free_huge_pmd(struct mmu_gather
> *tlb, struct vm_area_struct *vma,
> =C2=A0	 * If other processes are mapping this folio, we couldn't
> discard
> =C2=A0	 * the folio unless they all do MADV_FREE so let's skip the
> folio.
> =C2=A0	 */
> -	if (folio_estimated_sharers(folio) !=3D 1)
> +	if (folio_likely_mapped_shared(folio))
> =C2=A0		goto out;
> =C2=A0
> =C2=A0	if (!folio_trylock(folio))
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 44a498c94158c..32a534d200219 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -366,7 +366,7 @@ static int
> madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> =C2=A0		folio =3D pfn_folio(pmd_pfn(orig_pmd));
> =C2=A0
> =C2=A0		/* Do not interfere with other mappings of this
> folio */
> -		if (folio_estimated_sharers(folio) !=3D 1)
> +		if (folio_likely_mapped_shared(folio))
> =C2=A0			goto huge_unlock;
> =C2=A0
> =C2=A0		if (pageout_anon_only_filter &&
> !folio_test_anon(folio))
> @@ -453,7 +453,7 @@ static int
> madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> =C2=A0		if (folio_test_large(folio)) {
> =C2=A0			int err;
> =C2=A0
> -			if (folio_estimated_sharers(folio) > 1)
> +			if (folio_likely_mapped_shared(folio))
> =C2=A0				break;
> =C2=A0			if (pageout_anon_only_filter &&
> !folio_test_anon(folio))
> =C2=A0				break;
> @@ -677,7 +677,7 @@ static int madvise_free_pte_range(pmd_t *pmd,
> unsigned long addr,
> =C2=A0		if (folio_test_large(folio)) {
> =C2=A0			int err;
> =C2=A0
> -			if (folio_estimated_sharers(folio) !=3D 1)
> +			if (folio_likely_mapped_shared(folio))
> =C2=A0				break;
> =C2=A0			if (!folio_trylock(folio))
> =C2=A0				break;
> diff --git a/mm/memory.c b/mm/memory.c
> index 1c45b6a42a1b9..8394a9843ca06 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5173,7 +5173,7 @@ static vm_fault_t do_numa_page(struct vm_fault
> *vmf)
> =C2=A0	 * Flag if the folio is shared between multiple address
> spaces. This
> =C2=A0	 * is later used when determining whether to group tasks
> together
> =C2=A0	 */
> -	if (folio_estimated_sharers(folio) > 1 && (vma->vm_flags &
> VM_SHARED))
> +	if (folio_likely_mapped_shared(folio) && (vma->vm_flags &
> VM_SHARED))
> =C2=A0		flags |=3D TNF_SHARED;
> =C2=A0
> =C2=A0	nid =3D folio_nid(folio);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index f60b4c99f1302..0b92fde395182 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -642,12 +642,11 @@ static int queue_folios_hugetlb(pte_t *pte,
> unsigned long hmask,
> =C2=A0	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a
> shared folio.
> =C2=A0	 * Choosing not to migrate a shared folio is not counted as
> a failure.
> =C2=A0	 *
> -	 * To check if the folio is shared, ideally we want to make
> sure
> -	 * every page is mapped to the same process. Doing that is
> very
> -	 * expensive, so check the estimated sharers of the folio
> instead.
> +	 * See folio_likely_mapped_shared() on possible imprecision
> when we
> +	 * cannot easily detect if a folio is shared.
> =C2=A0	 */
> =C2=A0	if ((flags & MPOL_MF_MOVE_ALL) ||
> -	=C2=A0=C2=A0=C2=A0 (folio_estimated_sharers(folio) =3D=3D 1 &&
> !hugetlb_pmd_shared(pte)))
> +	=C2=A0=C2=A0=C2=A0 (!folio_likely_mapped_shared(folio) &&
> !hugetlb_pmd_shared(pte)))
> =C2=A0		if (!isolate_hugetlb(folio, qp->pagelist))
> =C2=A0			qp->nr_failed++;
> =C2=A0unlock:
> @@ -1032,11 +1031,10 @@ static bool migrate_folio_add(struct folio
> *folio, struct list_head *foliolist,
> =C2=A0	 * Unless MPOL_MF_MOVE_ALL, we try to avoid migrating a
> shared folio.
> =C2=A0	 * Choosing not to migrate a shared folio is not counted as
> a failure.
> =C2=A0	 *
> -	 * To check if the folio is shared, ideally we want to make
> sure
> -	 * every page is mapped to the same process. Doing that is
> very
> -	 * expensive, so check the estimated sharers of the folio
> instead.
> +	 * See folio_likely_mapped_shared() on possible imprecision
> when we
> +	 * cannot easily detect if a folio is shared.
> =C2=A0	 */
> -	if ((flags & MPOL_MF_MOVE_ALL) ||
> folio_estimated_sharers(folio) =3D=3D 1) {
> +	if ((flags & MPOL_MF_MOVE_ALL) ||
> !folio_likely_mapped_shared(folio)) {
> =C2=A0		if (folio_isolate_lru(folio)) {
> =C2=A0			list_add_tail(&folio->lru, foliolist);
> =C2=A0			node_stat_mod_folio(folio,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 73a052a382f13..35d376969f8b9 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2568,11 +2568,11 @@ int migrate_misplaced_folio(struct folio
> *folio, struct vm_area_struct *vma,
> =C2=A0	/*
> =C2=A0	 * Don't migrate file folios that are mapped in multiple
> processes
> =C2=A0	 * with execute permissions as they are probably shared
> libraries.
> -	 * To check if the folio is shared, ideally we want to make
> sure
> -	 * every page is mapped to the same process. Doing that is
> very
> -	 * expensive, so check the estimated mapcount of the folio
> instead.
> +	 *
> +	 * See folio_likely_mapped_shared() on possible imprecision
> when we
> +	 * cannot easily detect if a folio is shared.
> =C2=A0	 */
> -	if (folio_estimated_sharers(folio) !=3D 1 &&
> folio_is_file_lru(folio) &&
> +	if (folio_likely_mapped_shared(folio) &&
> folio_is_file_lru(folio) &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 (vma->vm_flags & VM_EXEC))
> =C2=A0		goto out;
> =C2=A0


