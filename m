Return-Path: <linux-kernel+bounces-120499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1688D86B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138B91F2A5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295A82D608;
	Wed, 27 Mar 2024 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIgbilYU"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144B36123
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526939; cv=none; b=U6tXsCRTbcML7eKEPVo7fFdhwmGDq8p++WmMCYqQifxEP/M9Mggu1cdigYsBnN1aryPX/hKlmlPWDrcV0nnlBZ/Sgn2tzliuT3D9qY0xwydInBt9WCWoqRxZ5+JlvYDVNg5kQI7Y+7OwLIzcugn5bfwACJe+n6gKUbMStji7uH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526939; c=relaxed/simple;
	bh=9WtPAaCqrMlfUguCz8sfyv3g4cnBfJtpq8eaLDwofDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cd1qY5nUrRIQq92MrvFOVp3fZKsK5HEpPnYAhvquSpJ7hBRkD7h0rSlZErgRRIrbs/f03MrYa6WpuQeiZw2jNKR0rRwbzxGh2Y/DKMHdxHX/l1OCQy7Ia/v2zjRGysfDMtIAIsF9rqKTrecfR6TnPzfyfPdlq5NyJivTWR11UWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIgbilYU; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4782f98ad5bso376555137.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711526936; x=1712131736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enqHhg5eW0k8vb7HDrT1c69Ar280o1OddJk3zvWY+XI=;
        b=WIgbilYUDAW+lDwjUQSFlpS1ftfkbBrV0g95Avkqn8tYIlIwzzyu+0+gyu+lM15Br5
         3AX5pRLIwi3qyliUOlcx8RMuocGsb5arX/62+8iXTCtmJC16KuJHHSJUEiWBuC2hCr2r
         JvtWwIm/6M2PgtzRoHHwC9v/3wfreyN+cnIvBwZviIIri2KrJuXyAHilhf6Fvx/1oOut
         HW3gwQdoWeK7l7DWrJg2c8S8EtNi+8ookYB7IXs0DXSYsxYBNNXumalgD/kII2iTjW/6
         tyXlPr9mYhgbCB8w/LuMJXG4yAmz9QsZsj03Acun4pA6EoFzsptu/f9xXJTZkQaI0Ag4
         hBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711526936; x=1712131736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enqHhg5eW0k8vb7HDrT1c69Ar280o1OddJk3zvWY+XI=;
        b=hUOSzhDfOjJT6PL3rf2osBRDLo5qwHdat7pgWQkq8OcQZ9E4FU6efV1QcEvg936oK1
         nI7joyOnI5therqd+Pa5F2QpW2ZRji7MgWvtcFtB6Vt4ONLdZFXCE+CxokX6cd4aLBvg
         U2L4HrjzltLKrs9q0+P8EJRZKB7+rJ1Z3nb2HHHU3Ynpoei6RvgqqYf14mC11SBvyYSb
         FTVwt251Rq0VsCah8UalDHInf+D45F5PNC5EgboQuvQNTPVS/wZDq5AYsMspxyGP+geF
         707gBq413Ef3UY4cCNdHLioutrXDSr9mc3sKF5KzPYbcwdDfdH/NHrjKQBO+1CYFZ63i
         14nw==
X-Forwarded-Encrypted: i=1; AJvYcCXGkUHsN3iScXJlSaWufYmNggC6dCcy0BsAuxuTvHcEswe1mie2cDfDFrln9WehW5j0DlyEltVn4thpUQT81MSHuP5qOY6tFkJXMKkI
X-Gm-Message-State: AOJu0YyLeJq6uAfDOddrlbkbiA3NDl8Uu4e+NV7gTYfL0yblritFLBFE
	F9ljgi8EroKTWVGrrxP0RvE7Uj25UOurYfdeTsxSBOhcltZOuyAWRORmR4TRxCcCK5wyVaqMQOa
	Bw3p30Nr0AhjVpP81ZuSlXKjoalQ=
X-Google-Smtp-Source: AGHT+IELyW+lGRJ+KNB6y+obMF8YncimwVaRT6NPq1WGF6FrqE+TqfZJKx3xuaYck42WT3C+RRz9B+VIlVCftIU8xsk=
X-Received: by 2002:a67:ecda:0:b0:474:ca8c:227d with SMTP id
 i26-20020a67ecda000000b00474ca8c227dmr4833149vsp.6.1711526936385; Wed, 27 Mar
 2024 01:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326185032.72159-1-ryncsn@gmail.com> <20240326185032.72159-11-ryncsn@gmail.com>
In-Reply-To: <20240326185032.72159-11-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Mar 2024 21:08:45 +1300
Message-ID: <CAGsJ_4yLAYUGYzWJwe9_LmqOcCzrz8-UKhdRDjTzgVQF7Z-xZA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] mm/swap: optimize synchronous swapin
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>, SeongJae Park <sj@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 8:06=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Interestingly the major performance overhead of synchronous is actually
> from the workingset nodes update, that's because synchronous swap in
> keeps adding single folios into a xa_node, making the node no longer
> a shadow node and have to be removed from shadow_nodes, then remove
> the folio very shortly and making the node a shadow node again,
> so it has to add back to the shadow_nodes.

Hi Kairui,

Thank you for clarifying this. I'm unsure how it relates to SWP_SYNCHRONOUS=
_IO.
Does this observation apply universally to all instances where
__swap_count(entry)
=3D=3D 1, even on devices not using SYNCHRONOUS_IO?


>
> Mark synchronous swapin folio with a special bit in swap entry embedded
> in folio->swap, as we still have some usable bits there. Skip workingset
> node update on insertion of such folio because it will be removed very
> quickly, and will trigger the update ensuring the workingset info is
> eventual consensus.
>
> Test result of sequential swapin/out of 30G zero page on ZRAM:
>
>                Before (us)        After (us)
> Swapout:       33853883           33886008
> Swapin:        38336519           32465441 (+15.4%)
> Swapout (THP): 6814619            6899938
> Swapin (THP) : 38383367           33193479 (+13.6%)
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swapops.h |  5 +++-
>  mm/filemap.c            | 16 +++++++++---
>  mm/memory.c             | 34 ++++++++++++++----------
>  mm/swap.h               | 15 +++++++++++
>  mm/swap_state.c         | 57 ++++++++++++++++++++++++-----------------
>  mm/vmscan.c             |  6 +++++
>  mm/workingset.c         |  2 +-
>  7 files changed, 92 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 48b700ba1d18..ebc0c3e4668d 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -25,7 +25,10 @@
>   * swp_entry_t's are *never* stored anywhere in their arch-dependent for=
mat.
>   */
>  #define SWP_TYPE_SHIFT (BITS_PER_XA_VALUE - MAX_SWAPFILES_SHIFT)
> -#define SWP_OFFSET_MASK        ((1UL << SWP_TYPE_SHIFT) - 1)
> +#define SWP_CACHE_FLAG_BITS    1
> +#define SWP_CACHE_SYNCHRONOUS  BIT(SWP_TYPE_SHIFT - 1)
> +#define SWP_OFFSET_BITS        (SWP_TYPE_SHIFT - SWP_CACHE_FLAG_BITS)
> +#define SWP_OFFSET_MASK        (BIT(SWP_OFFSET_BITS) - 1)
>
>  /*
>   * Definitions only for PFN swap entries (see is_pfn_swap_entry()).  To
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5e8e3fd26b8d..ac24cc65d1da 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -923,12 +923,20 @@ int __filemap_add_swapcache(struct address_space *m=
apping, struct folio *folio,
>                             pgoff_t index, gfp_t gfp, void **shadowp)
>  {
>         XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio))=
;
> +       bool synchronous =3D swap_cache_test_synchronous(folio);
>         long nr;
>         int ret;
>
>         VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>         VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
> -       mapping_set_update(&xas, mapping);
> +
> +       /*
> +        * Skip node update for synchronous folio insertion, it will be
> +        * updated on folio deletion very soon, avoid repeated LRU lockin=
g.
> +        */
> +       if (!synchronous)
> +               xas_set_update(&xas, workingset_update_node);
> +       xas_set_lru(&xas, &shadow_nodes);
>
>         nr =3D folio_nr_pages(folio);
>         folio_ref_add(folio, nr);
> @@ -936,8 +944,10 @@ int __filemap_add_swapcache(struct address_space *ma=
pping, struct folio *folio,
>         ret =3D __filemap_lock_store(&xas, folio, index, gfp, shadowp);
>         if (likely(!ret)) {
>                 mapping->nrpages +=3D nr;
> -               __node_stat_mod_folio(folio, NR_FILE_PAGES, nr);
> -               __lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr);
> +               if (!synchronous) {
> +                       __node_stat_mod_folio(folio, NR_FILE_PAGES, nr);
> +                       __lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr);
> +               }
>                 xas_unlock_irq(&xas);
>         } else {
>                 folio_put_refs(folio, nr);
> diff --git a/mm/memory.c b/mm/memory.c
> index 774a912eb46d..bb40202b4f29 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3933,6 +3933,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         struct swap_info_struct *si =3D NULL;
>         rmap_t rmap_flags =3D RMAP_NONE;
>         bool folio_allocated =3D false;
> +       bool synchronous_io =3D false;
>         bool exclusive =3D false;
>         swp_entry_t entry;
>         pte_t pte;
> @@ -4032,18 +4033,19 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (ret & VM_FAULT_RETRY)
>                 goto out_release;
>
> -       if (swapcache) {
> -               /*
> -                * Make sure folio_free_swap() or swapoff did not release=
 the
> -                * swapcache from under us.  The page pin, and pte_same t=
est
> -                * below, are not enough to exclude that.  Even if it is =
still
> -                * swapcache, we need to check that the page's swap has n=
ot
> -                * changed.
> -                */
> -               if (unlikely(!folio_test_swapcache(folio) ||
> -                            page_swap_entry(page).val !=3D entry.val))
> -                       goto out_page;
> +       /*
> +        * Make sure folio_free_swap() or swapoff did not release the
> +        * swapcache from under us.  The page pin, and pte_same test
> +        * below, are not enough to exclude that.  Even if it is still
> +        * swapcache, we need to check that the page's swap has not
> +        * changed.
> +        */
> +       if (unlikely(!folio_test_swapcache(folio) ||
> +                    (page_swap_entry(page).val & ~SWP_CACHE_SYNCHRONOUS)=
 !=3D entry.val))
> +               goto out_page;
>
> +       synchronous_io =3D swap_cache_test_synchronous(folio);
> +       if (!synchronous_io) {
>                 /*
>                  * KSM sometimes has to copy on read faults, for example,=
 if
>                  * page->index of !PageKSM() pages would be nonlinear ins=
ide the
> @@ -4105,9 +4107,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>          */
>         if (!folio_test_ksm(folio)) {
>                 exclusive =3D pte_swp_exclusive(vmf->orig_pte);
> -               if (folio !=3D swapcache) {
> +               if (synchronous_io || folio !=3D swapcache) {
>                         /*
> -                        * We have a fresh page that is not exposed to th=
e
> +                        * We have a fresh page that is not sharable thro=
ugh the
>                          * swapcache -> certainly exclusive.
>                          */
>                         exclusive =3D true;
> @@ -4148,7 +4150,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>          * yet.
>          */
>         swap_free(entry);
> -       if (should_try_to_free_swap(folio, vma, vmf->flags))
> +       if (synchronous_io)
> +               delete_from_swap_cache(folio);
> +       else if (should_try_to_free_swap(folio, vma, vmf->flags))
>                 folio_free_swap(folio);
>
>         inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> @@ -4223,6 +4227,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  out_nomap:
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> +       if (synchronous_io)
> +               delete_from_swap_cache(folio);
>  out_page:
>         folio_unlock(folio);
>  out_release:
> diff --git a/mm/swap.h b/mm/swap.h
> index bd872b157950..9d106eebddbd 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -31,6 +31,21 @@ extern struct address_space *swapper_spaces[];
>         (&swapper_spaces[swp_type(entry)][swp_offset(entry) \
>                 >> SWAP_ADDRESS_SPACE_SHIFT])
>
> +static inline void swap_cache_mark_synchronous(struct folio *folio)
> +{
> +       folio->swap.val |=3D SWP_CACHE_SYNCHRONOUS;
> +}
> +
> +static inline bool swap_cache_test_synchronous(struct folio *folio)
> +{
> +       return folio->swap.val & SWP_CACHE_SYNCHRONOUS;
> +}
> +
> +static inline void swap_cache_clear_synchronous(struct folio *folio)
> +{
> +       folio->swap.val &=3D ~SWP_CACHE_SYNCHRONOUS;
> +}
> +
>  void show_swap_cache_info(void);
>  bool add_to_swap(struct folio *folio);
>  void *get_shadow_from_swap_cache(swp_entry_t entry);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index cf178dd1131a..b0b1b5391ac1 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -86,7 +86,7 @@ void *get_shadow_from_swap_cache(swp_entry_t entry)
>   * but sets SwapCache flag and private instead of mapping and index.
>   */
>  static int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> -                            gfp_t gfp, void **shadowp)
> +                            gfp_t gfp, bool synchronous, void **shadowp)
>  {
>         struct address_space *address_space =3D swap_address_space(entry)=
;
>         pgoff_t idx =3D swp_offset(entry);
> @@ -98,11 +98,12 @@ static int add_to_swap_cache(struct folio *folio, swp=
_entry_t entry,
>
>         folio_set_swapcache(folio);
>         folio->swap =3D entry;
> -
> +       if (synchronous)
> +               swap_cache_mark_synchronous(folio);
>         ret =3D __filemap_add_swapcache(address_space, folio, idx, gfp, s=
hadowp);
>         if (ret) {
> -               folio_clear_swapcache(folio);
>                 folio->swap.val =3D 0;
> +               folio_clear_swapcache(folio);
>         }
>
>         return ret;
> @@ -129,11 +130,13 @@ void __delete_from_swap_cache(struct folio *folio,
>         xas_set_order(&xas, idx, folio_order(folio));
>         xas_store(&xas, shadow);
>
> -       folio->swap.val =3D 0;
>         folio_clear_swapcache(folio);
>         address_space->nrpages -=3D nr;
> -       __node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
> -       __lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
> +       if (!swap_cache_test_synchronous(folio)) {
> +               __node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
> +               __lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
> +       }
> +       folio->swap.val =3D 0;
>  }
>
>  /**
> @@ -393,7 +396,7 @@ struct folio *filemap_get_incore_folio(struct address=
_space *mapping,
>   * else or hitting OOM.
>   */
>  static struct folio *swap_cache_add_or_get(struct folio *folio,
> -               swp_entry_t entry, gfp_t gfp_mask)
> +               swp_entry_t entry, gfp_t gfp_mask, bool synchronous)
>  {
>         int ret =3D 0;
>         void *shadow =3D NULL;
> @@ -403,7 +406,7 @@ static struct folio *swap_cache_add_or_get(struct fol=
io *folio,
>         if (folio) {
>                 __folio_set_locked(folio);
>                 __folio_set_swapbacked(folio);
> -               ret =3D add_to_swap_cache(folio, entry, gfp_mask, &shadow=
);
> +               ret =3D add_to_swap_cache(folio, entry, gfp_mask, synchro=
nous, &shadow);
>                 if (ret)
>                         __folio_clear_locked(folio);
>         }
> @@ -460,7 +463,7 @@ int swap_cache_add_wait(struct folio *folio, swp_entr=
y_t entry, gfp_t gfp)
>         struct folio *wait_folio;
>
>         for (;;) {
> -               ret =3D add_to_swap_cache(folio, entry, gfp, NULL);
> +               ret =3D add_to_swap_cache(folio, entry, gfp, false, NULL)=
;
>                 if (ret !=3D -EEXIST)
>                         break;
>                 wait_folio =3D filemap_get_folio(swap_address_space(entry=
),
> @@ -493,7 +496,7 @@ struct folio *swap_cache_alloc_or_get(swp_entry_t ent=
ry, gfp_t gfp_mask,
>         /* We are very likely the first user, alloc and try add to the sw=
apcache. */
>         folio =3D (struct folio *)alloc_pages_mpol(gfp_mask, 0, mpol, ilx=
,
>                                                  numa_node_id());
> -       swapcache =3D swap_cache_add_or_get(folio, entry, gfp_mask);
> +       swapcache =3D swap_cache_add_or_get(folio, entry, gfp_mask, false=
);
>         if (swapcache !=3D folio) {
>                 folio_put(folio);
>                 goto out_no_alloc;
> @@ -875,21 +878,27 @@ static struct folio *swap_vma_readahead(swp_entry_t=
 targ_entry, gfp_t gfp_mask,
>  struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
>                             struct vm_fault *vmf, bool *folio_allocated)
>  {
> -       struct mempolicy *mpol;
> -       struct folio *folio;
> -       pgoff_t ilx;
> -
> -       mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> -       folio =3D swap_cache_alloc_or_get(entry, gfp_mask, mpol, ilx,
> -                                       folio_allocated);
> -       mpol_cond_put(mpol);
> -
> -       if (*folio_allocated)
> +       struct folio *folio =3D NULL, *swapcache;
> +       /* First do a racy check if cache is already loaded. */
> +       swapcache =3D swap_cache_try_get(entry);
> +       if (unlikely(swapcache))
> +               goto out;
> +       folio =3D vma_alloc_folio(gfp_mask, 0, vmf->vma, vmf->address, fa=
lse);
> +       swapcache =3D swap_cache_add_or_get(folio, entry, gfp_mask, true)=
;
> +       if (!swapcache)
> +               goto out_nocache;
> +       if (swapcache =3D=3D folio) {
>                 swap_read_folio(folio, true, NULL);
> -       else if (folio)
> -               swap_cache_update_ra(folio, vmf->vma, vmf->address);
> -
> -       return folio;
> +               *folio_allocated =3D true;
> +               return folio;
> +       }
> +out:
> +       swap_cache_update_ra(swapcache, vmf->vma, vmf->address);
> +out_nocache:
> +       if (folio)
> +               folio_put(folio);
> +       *folio_allocated =3D false;
> +       return swapcache;
>  }
>
>  /**
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c3db39393428..e71b049fee01 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1228,6 +1228,12 @@ static unsigned int shrink_folio_list(struct list_=
head *folio_list,
>                                         if (!add_to_swap(folio))
>                                                 goto activate_locked_spli=
t;
>                                 }
> +                       } else if (swap_cache_test_synchronous(folio)) {
> +                               /*
> +                                * We see a folio being swapped in but no=
t activated either
> +                                * due to missing shadow or lived too sho=
rt, active it.
> +                                */
> +                               goto activate_locked;
>                         }
>                 } else if (folio_test_swapbacked(folio) &&
>                            folio_test_large(folio)) {
> diff --git a/mm/workingset.c b/mm/workingset.c
> index f2a0ecaf708d..83a0b409be0f 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -753,7 +753,7 @@ static enum lru_status shadow_lru_isolate(struct list=
_head *item,
>          */
>         if (WARN_ON_ONCE(!node->nr_values))
>                 goto out_invalid;
> -       if (WARN_ON_ONCE(node->count !=3D node->nr_values))
> +       if (WARN_ON_ONCE(node->count !=3D node->nr_values && mapping->hos=
t !=3D NULL))
>                 goto out_invalid;
>         xa_delete_node(node, workingset_update_node);
>         __inc_lruvec_kmem_state(node, WORKINGSET_NODERECLAIM);
> --
> 2.43.0
>
>

Thanks
Barry

