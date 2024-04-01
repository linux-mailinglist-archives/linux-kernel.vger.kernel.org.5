Return-Path: <linux-kernel+bounces-126650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD6B893AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3EE1F2114C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F8374F7;
	Mon,  1 Apr 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mir5d+F2"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3B208DD
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 12:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711974329; cv=none; b=oqJUSgFyKTqfWGYwlbvFOh0jQxIFZe/a80zuft8Rkqd1m4I2+RqdaZNtx2tm04YssJaoWUXKSz9Oitfon3l4IQWyQIYnyPtbD4dzDjoOKwQP2zY2OsF7mlTYTqlYRPPszC/e8uxCAuLym1yGw93RMcBZC0/x+ZW04SLpUP2tfDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711974329; c=relaxed/simple;
	bh=0+uuaWuZI/u1j6ybe/zc1IQEf7G44Ll0b/8zBfHfnFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8DaXtHv03Gdxsaljx9gvTSm5AsTi7PXOsR2sGG1cDSTGjttGKj2bxrlvHpOx3Y7Iw531znlJoK6qZU1AFTFXPWbAChAZ1QhezMT6AuZEpEQG//MPMvTbHCU8Rx9z6imeJZcZgjKS7quMfivEYgGFXU2rjgtct3rr/mfWoF7pAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mir5d+F2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c2c41cbdaso2183282a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711974325; x=1712579125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5Wz2K6I2DnMCzQHAtDkcCM/sbtzk2JGtRSmt3tcB4Y=;
        b=Mir5d+F2XTyGjR489OEMNw/xuC2JRHfPGaiISyXq11bvUqEd7ZM8qKoon7nCy8hVTa
         YnHviVn0/GQit+q2z/J89RHaKpHI+7J7GQpaJ4IKobRWuMKf7mNw0Lj9WoJSrz8JvMtr
         2SAW4BFcOOoSt/pbqVxuiNjI+RBweTtbRvhLImSCnT+UdCbFGytXFHewWO+lOtQJOcDu
         VdmPoEe/k95ck6RrDmmNDCQgmvyUwK1oYJm6ZekzsLfAjV7O4kl5HoWF6JR9uL2A+FTh
         mPAGlqITmeUn92/OIK/rLS6/4xDz9nQQrvQv7Am6g2MOuBNnnFRWKXHBX0wXQdgbUuxj
         uB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711974325; x=1712579125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5Wz2K6I2DnMCzQHAtDkcCM/sbtzk2JGtRSmt3tcB4Y=;
        b=l/7ZIoajWO+9RCur7CTNEDGJjJ+zh8DF0pFRsR9ELFImh9fsNHJrbteAupmnuvHiP3
         cy7nR7uj6LpbbnJlyV1KFzLqBq7nQ607GYQ/k4vaMEPGxjMSLSQYx78+1UfJK+Yclhxr
         5YVFWewQP6F8V4KSRx8F1rYltlFWUsQjd8HMrQhQwYljHwyh+J7F4K/GyqjYW13sMsyP
         cklfJ1DnyCBgurHy52lvFHQf81tldYN/eDnNjI2i0x1GvuqsEzIJN0HPuQywMNY2cTNr
         rJLtoyZrIBtQBS3NMpHtn4CLi0UYuNBc7eqWlHDQM1Po0fVZGzmqRlzw66Webxyef8EW
         6jTg==
X-Forwarded-Encrypted: i=1; AJvYcCXdvlSIXUBAhv0WameMJ7NLa26IC83UpR6VPF3i45DjQ4keN5eiMxMbIX3WDDepcYK4ATp2JGrJ78AXMRbh6YYFybl23h5fygxrHQoS
X-Gm-Message-State: AOJu0YyhxWrY3ZuE1ECf880cz0kMHS13/8cJZm7AGM3GpI00IOYGD2Bw
	qDyPoj3d6q6kGxGnRrtmQdxxzeYQXdkAQ4GLLBi4WjQ9Vh4DGkm+vrMEhV6QJ10fpxS1K3OIKvo
	tT7/uKahMNoGkDJPBIz61k8qRPoQ=
X-Google-Smtp-Source: AGHT+IGsYJCiWk1VPNmspSvN2B/1A+RmR7GmpS9FfAhe2KXRwYgHCRDx7saQzpYF6MmuqYPaa4df/BoskbhHTifgQ3w=
X-Received: by 2002:a05:6402:34d6:b0:56b:d1c2:9b42 with SMTP id
 w22-20020a05640234d600b0056bd1c29b42mr9366765edc.29.1711974325215; Mon, 01
 Apr 2024 05:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327144537.4165578-1-ryan.roberts@arm.com> <20240327144537.4165578-7-ryan.roberts@arm.com>
In-Reply-To: <20240327144537.4165578-7-ryan.roberts@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 1 Apr 2024 20:25:13 +0800
Message-ID: <CAK1f24kON1tLerfYMPUO5vXN2yL9UXozOgACDtSwgGO_zFzTQQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 10:46=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any large
> folio that is fully and contiguously mapped in the pageout/cold vm
> range. This change means that large folios will be maintained all the
> way to swap storage. This both improves performance during swap-out, by
> eliding the cost of splitting the folio, and sets us up nicely for
> maintaining the large folio when it is swapped back in (to be covered in
> a separate series).
>
> Folios that are not fully mapped in the target range are still split,
> but note that behavior is changed so that if the split fails for any
> reason (folio locked, shared, etc) we now leave it as is and move to the
> next pte in the range and continue work on the proceeding folios.
> Previously any failure of this sort would cause the entire operation to
> give up and no folios mapped at higher addresses were paged out or made
> cold. Given large folios are becoming more common, this old behavior
> would have likely lead to wasted opportunities.
>
> While we are at it, change the code that clears young from the ptes to
> use ptep_test_and_clear_young(), via the new mkold_ptes() batch helper
> function. This is more efficent than get_and_clear/modify/set,
> especially for contpte mappings on arm64, where the old approach would
> require unfolding/refolding and the new approach can be done in place.
>
> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h | 30 ++++++++++++++
>  mm/internal.h           | 12 +++++-
>  mm/madvise.c            | 88 ++++++++++++++++++++++++-----------------
>  mm/memory.c             |  4 +-
>  4 files changed, 93 insertions(+), 41 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8185939df1e8..391f56a1b188 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -361,6 +361,36 @@ static inline int ptep_test_and_clear_young(struct v=
m_area_struct *vma,
>  }
>  #endif
>
> +#ifndef mkold_ptes
> +/**
> + * mkold_ptes - Mark PTEs that map consecutive pages of the same folio a=
s old.
> + * @vma: VMA the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to mark old.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a si=
mple
> + * loop over ptep_test_and_clear_young().
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For e=
xample,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecut=
ive
> + * pages that belong to the same folio.  The PTEs are all in the same PM=
D.
> + */
> +static inline void mkold_ptes(struct vm_area_struct *vma, unsigned long =
addr,
> +               pte_t *ptep, unsigned int nr)
> +{
> +       for (;;) {
> +               ptep_test_and_clear_young(vma, addr, ptep);

IIUC, if the first PTE is a CONT-PTE, then calling ptep_test_and_clear_youn=
g()
will clear the young bit for the entire contig range to avoid having
to unfold. So,
the other PTEs within the range don't need to clear again.

Maybe we should consider overriding mkold_ptes for arm64?

Thanks,
Lance

> +               if (--nr =3D=3D 0)
> +                       break;
> +               ptep++;
> +               addr +=3D PAGE_SIZE;
> +       }
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONL=
EAF_PMD_YOUNG)
>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> diff --git a/mm/internal.h b/mm/internal.h
> index eadb79c3a357..efee8e4cd2af 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -130,6 +130,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t p=
te, fpb_t flags)
>   * @flags: Flags to modify the PTE batch semantics.
>   * @any_writable: Optional pointer to indicate whether any entry except =
the
>   *               first one is writable.
> + * @any_young: Optional pointer to indicate whether any entry except the
> + *               first one is young.
>   *
>   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>   * pages of the same large folio.
> @@ -145,16 +147,18 @@ static inline pte_t __pte_batch_clear_ignored(pte_t=
 pte, fpb_t flags)
>   */
>  static inline int folio_pte_batch(struct folio *folio, unsigned long add=
r,
>                 pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> -               bool *any_writable)
> +               bool *any_writable, bool *any_young)
>  {
>         unsigned long folio_end_pfn =3D folio_pfn(folio) + folio_nr_pages=
(folio);
>         const pte_t *end_ptep =3D start_ptep + max_nr;
>         pte_t expected_pte, *ptep;
> -       bool writable;
> +       bool writable, young;
>         int nr;
>
>         if (any_writable)
>                 *any_writable =3D false;
> +       if (any_young)
> +               *any_young =3D false;
>
>         VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>         VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
> @@ -168,6 +172,8 @@ static inline int folio_pte_batch(struct folio *folio=
, unsigned long addr,
>                 pte =3D ptep_get(ptep);
>                 if (any_writable)
>                         writable =3D !!pte_write(pte);
> +               if (any_young)
> +                       young =3D !!pte_young(pte);
>                 pte =3D __pte_batch_clear_ignored(pte, flags);
>
>                 if (!pte_same(pte, expected_pte))
> @@ -183,6 +189,8 @@ static inline int folio_pte_batch(struct folio *folio=
, unsigned long addr,
>
>                 if (any_writable)
>                         *any_writable |=3D writable;
> +               if (any_young)
> +                       *any_young |=3D young;
>
>                 nr =3D pte_batch_hint(ptep, pte);
>                 expected_pte =3D pte_advance_pfn(expected_pte, nr);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 070bedb4996e..bd00b83e7c50 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>         LIST_HEAD(folio_list);
>         bool pageout_anon_only_filter;
>         unsigned int batch_count =3D 0;
> +       int nr;
>
>         if (fatal_signal_pending(current))
>                 return -EINTR;
> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>                 return 0;
>         flush_tlb_batched_pending(mm);
>         arch_enter_lazy_mmu_mode();
> -       for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
> +       for (; addr < end; pte +=3D nr, addr +=3D nr * PAGE_SIZE) {
> +               nr =3D 1;
>                 ptent =3D ptep_get(pte);
>
>                 if (++batch_count =3D=3D SWAP_CLUSTER_MAX) {
> @@ -447,55 +449,67 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
>                         continue;
>
>                 /*
> -                * Creating a THP page is expensive so split it only if w=
e
> -                * are sure it's worth. Split it if we are only owner.
> +                * If we encounter a large folio, only split it if it is =
not
> +                * fully mapped within the range we are operating on. Oth=
erwise
> +                * leave it as is so that it can be swapped out whole. If=
 we
> +                * fail to split a folio, leave it in place and advance t=
o the
> +                * next pte in the range.
>                  */
>                 if (folio_test_large(folio)) {
> -                       int err;
> -
> -                       if (folio_likely_mapped_shared(folio))
> -                               break;
> -                       if (pageout_anon_only_filter && !folio_test_anon(=
folio))
> -                               break;
> -                       if (!folio_trylock(folio))
> -                               break;
> -                       folio_get(folio);
> -                       arch_leave_lazy_mmu_mode();
> -                       pte_unmap_unlock(start_pte, ptl);
> -                       start_pte =3D NULL;
> -                       err =3D split_folio(folio);
> -                       folio_unlock(folio);
> -                       folio_put(folio);
> -                       if (err)
> -                               break;
> -                       start_pte =3D pte =3D
> -                               pte_offset_map_lock(mm, pmd, addr, &ptl);
> -                       if (!start_pte)
> -                               break;
> -                       arch_enter_lazy_mmu_mode();
> -                       pte--;
> -                       addr -=3D PAGE_SIZE;
> -                       continue;
> +                       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY |
> +                                               FPB_IGNORE_SOFT_DIRTY;
> +                       int max_nr =3D (end - addr) / PAGE_SIZE;
> +                       bool any_young;
> +
> +                       nr =3D folio_pte_batch(folio, addr, pte, ptent, m=
ax_nr,
> +                                            fpb_flags, NULL, &any_young)=
;
> +                       if (any_young)
> +                               ptent =3D pte_mkyoung(ptent);
> +
> +                       if (nr < folio_nr_pages(folio)) {
> +                               int err;
> +
> +                               if (folio_likely_mapped_shared(folio))
> +                                       continue;
> +                               if (pageout_anon_only_filter && !folio_te=
st_anon(folio))
> +                                       continue;
> +                               if (!folio_trylock(folio))
> +                                       continue;
> +                               folio_get(folio);
> +                               arch_leave_lazy_mmu_mode();
> +                               pte_unmap_unlock(start_pte, ptl);
> +                               start_pte =3D NULL;
> +                               err =3D split_folio(folio);
> +                               folio_unlock(folio);
> +                               folio_put(folio);
> +                               if (err)
> +                                       continue;
> +                               start_pte =3D pte =3D
> +                                       pte_offset_map_lock(mm, pmd, addr=
, &ptl);
> +                               if (!start_pte)
> +                                       break;
> +                               arch_enter_lazy_mmu_mode();
> +                               nr =3D 0;
> +                               continue;
> +                       }
>                 }
>
>                 /*
>                  * Do not interfere with other mappings of this folio and
> -                * non-LRU folio.
> +                * non-LRU folio. If we have a large folio at this point,=
 we
> +                * know it is fully mapped so if its mapcount is the same=
 as its
> +                * number of pages, it must be exclusive.
>                  */
> -               if (!folio_test_lru(folio) || folio_mapcount(folio) !=3D =
1)
> +               if (!folio_test_lru(folio) ||
> +                   folio_mapcount(folio) !=3D folio_nr_pages(folio))
>                         continue;
>
>                 if (pageout_anon_only_filter && !folio_test_anon(folio))
>                         continue;
>
> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -
>                 if (!pageout && pte_young(ptent)) {
> -                       ptent =3D ptep_get_and_clear_full(mm, addr, pte,
> -                                                       tlb->fullmm);
> -                       ptent =3D pte_mkold(ptent);
> -                       set_pte_at(mm, addr, pte, ptent);
> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> +                       mkold_ptes(vma, addr, pte, nr);
> +                       tlb_remove_tlb_entries(tlb, pte, nr, addr);
>                 }
>
>                 /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 9d844582ba38..b5b48f4cf2af 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, str=
uct vm_area_struct *src_vma
>                         flags |=3D FPB_IGNORE_SOFT_DIRTY;
>
>                 nr =3D folio_pte_batch(folio, addr, src_pte, pte, max_nr,=
 flags,
> -                                    &any_writable);
> +                                    &any_writable, NULL);
>                 folio_ref_add(folio, nr);
>                 if (folio_test_anon(folio)) {
>                         if (unlikely(folio_try_dup_anon_rmap_ptes(folio, =
page,
> @@ -1553,7 +1553,7 @@ static inline int zap_present_ptes(struct mmu_gathe=
r *tlb,
>          */
>         if (unlikely(folio_test_large(folio) && max_nr !=3D 1)) {
>                 nr =3D folio_pte_batch(folio, addr, pte, ptent, max_nr, f=
pb_flags,
> -                                    NULL);
> +                                    NULL, NULL);
>
>                 zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent,=
 nr,
>                                        addr, details, rss, force_flush,
> --
> 2.25.1
>

