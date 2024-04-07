Return-Path: <linux-kernel+bounces-134227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E638089AF3F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8D728401B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C8DDBD;
	Sun,  7 Apr 2024 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXdpH7PE"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512A1876
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712475505; cv=none; b=RPHeUnjeGirPLYPLMiVvAeyV4Tye+Oarj/j8+02dfui4nIthPHBI5Koo7vzSa/yLWxCrU3cfJhaqWDxrY6UK/RfWlbDqkgBG2RdbMDduBgT4dBSof+GeJ6RMjRSUb7kCKEScfAoH7+E/MyRnSqzZ8jP+Z8AEIJoT75SbqxBHWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712475505; c=relaxed/simple;
	bh=7HnPf3snoJDJF166oPZWv7BLk9I7c3N/k3t1xdJeS8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9/xcsKPecBprqY+UoYJL/xht1D5ApmuMEjuPxT6d3qufIKv3Ma4xX+5mDlJ5Gi5mM2l0Rmvt8S/S+QoIAfWhk1NcAj66MFetfxH9WWEQExPwvt9uCaR0fbYachHaCqSyWhXZvL0xiuIwS8JDXYJofLNXP7P53XQfah8Tie8jKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXdpH7PE; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7e328cd8e04so1374421241.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712475502; x=1713080302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzMqnUc4LD3ni68Fyd3o6LUQmvGljV3SG+ic25jE2bw=;
        b=hXdpH7PED064pADlJ7LipJTg2WahCvyU5jZZwZo1il30mTVKWeawgrqIRzOlds8RHh
         S4LeNJcgjTnYdfgWRwwkgI7q2yCq+CS0s6R4gLP6JXn3kJV/O2W/3JZ5nhihOtDs4Jj1
         aKZiiceoQX5sFYH2eb9jYXzoG+TD0dF4Y3qXVBSlftmJbvM/xXuKTJQ28lcdKXQYUBcR
         RF5WXO+eqhLqmQ4+B49H92oNHjMg6vjPVpslvHG4NIQLVuuOEpPTvqqT4A78jQ5Dc86S
         fWbvZytpdrP5i9mnx8lNWjtTtsbT0dbPNHBzo2uUnrMLHMmAYKLcKpz3Okkjd5gDiTim
         MdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712475502; x=1713080302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RzMqnUc4LD3ni68Fyd3o6LUQmvGljV3SG+ic25jE2bw=;
        b=svX4BTdQomVXbWtnYjWIHuWfweiV3qJriCMFNc/9445QPAwOybwst+rPeYl9c0bKk8
         r+DO+oCzBxLrUfTIjm4mOIEiyB0S/ucayRUBNR0qrPYTId/KTuH3yiXLQyHr9BxAAkRd
         GVAJXaLmC2Y99TMl8f4JZqtQrEHzzfIYLIDYzxkiD3ZmbZ5zUCg0FyueF23g0rfqmuV0
         szRU1ZXghJLBVkLvyFuRMs9Vpf49HpGrUIumeUy9zmsnuzZa7882mBiygKIiwp1j2UXN
         gCSqby0VuxW3g553pHCZJh+8msSjcmM+pHA02l77GJPK7ARDkXY0PLS5OwAxaRM6WdFT
         qtXA==
X-Forwarded-Encrypted: i=1; AJvYcCX/gU0AVDkcNh5q97iSPnVSGqSfiDHt5Qm+IiNlh9nbkuuy0feWkrJDfMGm2Su/EW2I/3TbrmNb4gkZ3Zwp6upM94LfPG6Ijak1tv2w
X-Gm-Message-State: AOJu0Yxwdwmr2LAQsH5Jeof+qS/neEqXIrDglkyYUiKCA7i1RY8xPzLd
	XCcWObflJxLC583kwPJcZJFGwr99ahqpQYaC2vod+UqAz8Y9pqDcf/Yq0PnUzlWVy55GGXe6NU0
	DCRV9AtKpOGMNKza29/444x12hGE=
X-Google-Smtp-Source: AGHT+IHt8ktBrk2qCyCBGf+xqAlfdUmfeXsaI8fjf1MLhRiNJ3cRu+w6UvfT3QQE9l3dJCxRaTRx9CcBVeCcfCAyThg=
X-Received: by 2002:a05:6122:c96:b0:4d4:17c5:8605 with SMTP id
 ba22-20020a0561220c9600b004d417c58605mr4597251vkb.7.1712475501964; Sun, 07
 Apr 2024 00:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403114032.1162100-1-ryan.roberts@arm.com> <20240403114032.1162100-5-ryan.roberts@arm.com>
In-Reply-To: <20240403114032.1162100-5-ryan.roberts@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 7 Apr 2024 19:38:10 +1200
Message-ID: <CAGsJ_4zuTMbVNPE4ZHisi35+T1ftV4+YCbt_eJGNXnrBQ-c4OQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] mm: swap: Allow storage of all mTHP orders
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 12:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Multi-size THP enables performance improvements by allocating large,
> pte-mapped folios for anonymous memory. However I've observed that on an
> arm64 system running a parallel workload (e.g. kernel compilation)
> across many cores, under high memory pressure, the speed regresses. This
> is due to bottlenecking on the increased number of TLBIs added due to
> all the extra folio splitting when the large folios are swapped out.
>
> Therefore, solve this regression by adding support for swapping out mTHP
> without needing to split the folio, just like is already done for
> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
> and when the swap backing store is a non-rotating block device. These
> are the same constraints as for the existing PMD-sized THP swap-out
> support.
>
> Note that no attempt is made to swap-in (m)THP here - this is still done
> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
> prerequisite for swapping-in mTHP.
>
> The main change here is to improve the swap entry allocator so that it
> can allocate any power-of-2 number of contiguous entries between [1, (1
> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
> order and allocating sequentially from it until the cluster is full.
> This ensures that we don't need to search the map and we get no
> fragmentation due to alignment padding for different orders in the
> cluster. If there is no current cluster for a given order, we attempt to
> allocate a free cluster from the list. If there are no free clusters, we
> fail the allocation and the caller can fall back to splitting the folio
> and allocates individual entries (as per existing PMD-sized THP
> fallback).
>
> The per-order current clusters are maintained per-cpu using the existing
> infrastructure. This is done to avoid interleving pages from different
> tasks, which would prevent IO being batched. This is already done for
> the order-0 allocations so we follow the same pattern.
>
> As is done for order-0 per-cpu clusters, the scanner now can steal
> order-0 entries from any per-cpu-per-order reserved cluster. This
> ensures that when the swap file is getting full, space doesn't get tied
> up in the per-cpu reserves.
>
> This change only modifies swap to be able to accept any order mTHP. It
> doesn't change the callers to elide doing the actual split. That will be
> done in separate changes.

An idea suddenly struck me: we might not need to split the folio into
order 0. Instead,
if we attempt to obtain swap entries at a certain order but fail, we
could try at half the
order. If successful, we could utilize Zi Yan's approach to split the
large folios into two
smaller ones(still large folios) but not nr_pages small folios.

Please disregard this comment for now since we don't have any data regardin=
g
THP_SWPOUT_FALLBACK of mTHP.

>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/swap.h |  10 ++-
>  mm/swap_slots.c      |   6 +-
>  mm/swapfile.c        | 175 ++++++++++++++++++++++++-------------------
>  3 files changed, 109 insertions(+), 82 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 5e1e4f5bf0cb..11c53692f65f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -268,13 +268,19 @@ struct swap_cluster_info {
>   */
>  #define SWAP_NEXT_INVALID      0
>
> +#ifdef CONFIG_THP_SWAP
> +#define SWAP_NR_ORDERS         (PMD_ORDER + 1)
> +#else
> +#define SWAP_NR_ORDERS         1
> +#endif
> +
>  /*
>   * We assign a cluster to each CPU, so each CPU can allocate swap entry =
from
>   * its own cluster and swapout sequentially. The purpose is to optimize =
swapout
>   * throughput.
>   */
>  struct percpu_cluster {
> -       unsigned int next; /* Likely next allocation offset */
> +       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
>  };
>
>  struct swap_cluster_list {
> @@ -471,7 +477,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio);
>  bool folio_free_swap(struct folio *folio);
>  void put_swap_folio(struct folio *folio, swp_entry_t entry);
>  extern swp_entry_t get_swap_page_of_type(int);
> -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_si=
ze);
> +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>  extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 53abeaf1371d..13ab3b771409 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_=
cache *cache)
>         cache->cur =3D 0;
>         if (swap_slot_cache_active)
>                 cache->nr =3D get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
> -                                          cache->slots, 1);
> +                                          cache->slots, 0);
>
>         return cache->nr;
>  }
> @@ -311,7 +311,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>
>         if (folio_test_large(folio)) {
>                 if (IS_ENABLED(CONFIG_THP_SWAP))
> -                       get_swap_pages(1, &entry, folio_nr_pages(folio));
> +                       get_swap_pages(1, &entry, folio_order(folio));
>                 goto out;
>         }
>
> @@ -343,7 +343,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>                         goto out;
>         }
>
> -       get_swap_pages(1, &entry, 1);
> +       get_swap_pages(1, &entry, 0);
>  out:
>         if (mem_cgroup_try_charge_swap(folio, entry)) {
>                 put_swap_folio(folio, entry);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c95986b9cb9c..3ee8957a46e6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -278,15 +278,15 @@ static void discard_swap_cluster(struct swap_info_s=
truct *si,
>  #ifdef CONFIG_THP_SWAP
>  #define SWAPFILE_CLUSTER       HPAGE_PMD_NR
>
> -#define swap_entry_size(size)  (size)
> +#define swap_entry_order(order)        (order)
>  #else
>  #define SWAPFILE_CLUSTER       256
>
>  /*
> - * Define swap_entry_size() as constant to let compiler to optimize
> + * Define swap_entry_order() as constant to let compiler to optimize
>   * out some code if !CONFIG_THP_SWAP
>   */
> -#define swap_entry_size(size)  1
> +#define swap_entry_order(order)        0
>  #endif
>  #define LATENCY_LIMIT          256
>
> @@ -551,10 +551,12 @@ static void free_cluster(struct swap_info_struct *s=
i, unsigned long idx)
>
>  /*
>   * The cluster corresponding to page_nr will be used. The cluster will b=
e
> - * removed from free cluster list and its usage counter will be increase=
d.
> + * removed from free cluster list and its usage counter will be increase=
d by
> + * count.
>   */
> -static void inc_cluster_info_page(struct swap_info_struct *p,
> -       struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +static void add_cluster_info_page(struct swap_info_struct *p,
> +       struct swap_cluster_info *cluster_info, unsigned long page_nr,
> +       unsigned long count)
>  {
>         unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
>
> @@ -563,9 +565,19 @@ static void inc_cluster_info_page(struct swap_info_s=
truct *p,
>         if (cluster_is_free(&cluster_info[idx]))
>                 alloc_cluster(p, idx);
>
> -       VM_BUG_ON(cluster_count(&cluster_info[idx]) >=3D SWAPFILE_CLUSTER=
);
> +       VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CL=
USTER);
>         cluster_set_count(&cluster_info[idx],
> -               cluster_count(&cluster_info[idx]) + 1);
> +               cluster_count(&cluster_info[idx]) + count);
> +}
> +
> +/*
> + * The cluster corresponding to page_nr will be used. The cluster will b=
e
> + * removed from free cluster list and its usage counter will be increase=
d by 1.
> + */
> +static void inc_cluster_info_page(struct swap_info_struct *p,
> +       struct swap_cluster_info *cluster_info, unsigned long page_nr)
> +{
> +       add_cluster_info_page(p, cluster_info, page_nr, 1);
>  }
>
>  /*
> @@ -595,7 +607,7 @@ static void dec_cluster_info_page(struct swap_info_st=
ruct *p,
>   */
>  static bool
>  scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
> -       unsigned long offset)
> +       unsigned long offset, int order)
>  {
>         struct percpu_cluster *percpu_cluster;
>         bool conflict;
> @@ -609,24 +621,39 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info=
_struct *si,
>                 return false;
>
>         percpu_cluster =3D this_cpu_ptr(si->percpu_cluster);
> -       percpu_cluster->next =3D SWAP_NEXT_INVALID;
> +       percpu_cluster->next[order] =3D SWAP_NEXT_INVALID;
> +       return true;
> +}
> +
> +static inline bool swap_range_empty(char *swap_map, unsigned int start,
> +                                   unsigned int nr_pages)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if (swap_map[start + i])
> +                       return false;
> +       }
> +
>         return true;
>  }
>
>  /*
> - * Try to get a swap entry from current cpu's swap entry pool (a cluster=
). This
> - * might involve allocating a new cluster for current CPU too.
> + * Try to get swap entries with specified order from current cpu's swap =
entry
> + * pool (a cluster). This might involve allocating a new cluster for cur=
rent CPU
> + * too.
>   */
>  static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
> -       unsigned long *offset, unsigned long *scan_base)
> +       unsigned long *offset, unsigned long *scan_base, int order)
>  {
> +       unsigned int nr_pages =3D 1 << order;
>         struct percpu_cluster *cluster;
>         struct swap_cluster_info *ci;
>         unsigned int tmp, max;
>
>  new_cluster:
>         cluster =3D this_cpu_ptr(si->percpu_cluster);
> -       tmp =3D cluster->next;
> +       tmp =3D cluster->next[order];
>         if (tmp =3D=3D SWAP_NEXT_INVALID) {
>                 if (!cluster_list_empty(&si->free_clusters)) {
>                         tmp =3D cluster_next(&si->free_clusters.head) *
> @@ -647,26 +674,27 @@ static bool scan_swap_map_try_ssd_cluster(struct sw=
ap_info_struct *si,
>
>         /*
>          * Other CPUs can use our cluster if they can't find a free clust=
er,
> -        * check if there is still free entry in the cluster
> +        * check if there is still free entry in the cluster, maintaining
> +        * natural alignment.
>          */
>         max =3D min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLU=
STER));
>         if (tmp < max) {
>                 ci =3D lock_cluster(si, tmp);
>                 while (tmp < max) {
> -                       if (!si->swap_map[tmp])
> +                       if (swap_range_empty(si->swap_map, tmp, nr_pages)=
)
>                                 break;
> -                       tmp++;
> +                       tmp +=3D nr_pages;
>                 }
>                 unlock_cluster(ci);
>         }
>         if (tmp >=3D max) {
> -               cluster->next =3D SWAP_NEXT_INVALID;
> +               cluster->next[order] =3D SWAP_NEXT_INVALID;
>                 goto new_cluster;
>         }
>         *offset =3D tmp;
>         *scan_base =3D tmp;
> -       tmp +=3D 1;
> -       cluster->next =3D tmp < max ? tmp : SWAP_NEXT_INVALID;
> +       tmp +=3D nr_pages;
> +       cluster->next[order] =3D tmp < max ? tmp : SWAP_NEXT_INVALID;
>         return true;
>  }
>
> @@ -796,13 +824,14 @@ static bool swap_offset_available_and_locked(struct=
 swap_info_struct *si,
>
>  static int scan_swap_map_slots(struct swap_info_struct *si,
>                                unsigned char usage, int nr,
> -                              swp_entry_t slots[])
> +                              swp_entry_t slots[], int order)
>  {
>         struct swap_cluster_info *ci;
>         unsigned long offset;
>         unsigned long scan_base;
>         unsigned long last_in_cluster =3D 0;
>         int latency_ration =3D LATENCY_LIMIT;
> +       unsigned int nr_pages =3D 1 << order;
>         int n_ret =3D 0;
>         bool scanned_many =3D false;
>
> @@ -817,6 +846,25 @@ static int scan_swap_map_slots(struct swap_info_stru=
ct *si,
>          * And we let swap pages go all over an SSD partition.  Hugh
>          */
>
> +       if (order > 0) {
> +               /*
> +                * Should not even be attempting large allocations when h=
uge
> +                * page swap is disabled.  Warn and fail the allocation.
> +                */
> +               if (!IS_ENABLED(CONFIG_THP_SWAP) ||
> +                   nr_pages > SWAPFILE_CLUSTER) {
> +                       VM_WARN_ON_ONCE(1);
> +                       return 0;
> +               }
> +
> +               /*
> +                * Swapfile is not block device or not using clusters so =
unable
> +                * to allocate large entries.
> +                */
> +               if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
> +                       return 0;
> +       }
> +
>         si->flags +=3D SWP_SCANNING;
>         /*
>          * Use percpu scan base for SSD to reduce lock contention on
> @@ -831,8 +879,11 @@ static int scan_swap_map_slots(struct swap_info_stru=
ct *si,
>
>         /* SSD algorithm */
>         if (si->cluster_info) {
> -               if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_bas=
e))
> +               if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_bas=
e, order)) {
> +                       if (order > 0)
> +                               goto no_page;
>                         goto scan;
> +               }
>         } else if (unlikely(!si->cluster_nr--)) {
>                 if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER) {
>                         si->cluster_nr =3D SWAPFILE_CLUSTER - 1;
> @@ -874,13 +925,16 @@ static int scan_swap_map_slots(struct swap_info_str=
uct *si,
>
>  checks:
>         if (si->cluster_info) {
> -               while (scan_swap_map_ssd_cluster_conflict(si, offset)) {
> +               while (scan_swap_map_ssd_cluster_conflict(si, offset, ord=
er)) {
>                 /* take a break if we already got some slots */
>                         if (n_ret)
>                                 goto done;
>                         if (!scan_swap_map_try_ssd_cluster(si, &offset,
> -                                                       &scan_base))
> +                                                       &scan_base, order=
)) {
> +                               if (order > 0)
> +                                       goto no_page;
>                                 goto scan;
> +                       }
>                 }
>         }
>         if (!(si->flags & SWP_WRITEOK))
> @@ -911,11 +965,11 @@ static int scan_swap_map_slots(struct swap_info_str=
uct *si,
>                 else
>                         goto done;
>         }
> -       WRITE_ONCE(si->swap_map[offset], usage);
> -       inc_cluster_info_page(si, si->cluster_info, offset);
> +       memset(si->swap_map + offset, usage, nr_pages);
> +       add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>         unlock_cluster(ci);
>
> -       swap_range_alloc(si, offset, 1);
> +       swap_range_alloc(si, offset, nr_pages);
>         slots[n_ret++] =3D swp_entry(si->type, offset);
>
>         /* got enough slots or reach max slots? */
> @@ -936,8 +990,10 @@ static int scan_swap_map_slots(struct swap_info_stru=
ct *si,
>
>         /* try to get more slots in cluster */
>         if (si->cluster_info) {
> -               if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base=
))
> +               if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base=
, order))
>                         goto checks;
> +               if (order > 0)
> +                       goto done;
>         } else if (si->cluster_nr && !si->swap_map[++offset]) {
>                 /* non-ssd case, still more slots in cluster? */
>                 --si->cluster_nr;
> @@ -964,11 +1020,13 @@ static int scan_swap_map_slots(struct swap_info_st=
ruct *si,
>         }
>
>  done:
> -       set_cluster_next(si, offset + 1);
> +       if (order =3D=3D 0)
> +               set_cluster_next(si, offset + 1);
>         si->flags -=3D SWP_SCANNING;
>         return n_ret;
>
>  scan:
> +       VM_WARN_ON(order > 0);
>         spin_unlock(&si->lock);
>         while (++offset <=3D READ_ONCE(si->highest_bit)) {
>                 if (unlikely(--latency_ration < 0)) {
> @@ -997,38 +1055,6 @@ static int scan_swap_map_slots(struct swap_info_str=
uct *si,
>         return n_ret;
>  }
>
> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *=
slot)
> -{
> -       unsigned long idx;
> -       struct swap_cluster_info *ci;
> -       unsigned long offset;
> -
> -       /*
> -        * Should not even be attempting cluster allocations when huge
> -        * page swap is disabled.  Warn and fail the allocation.
> -        */
> -       if (!IS_ENABLED(CONFIG_THP_SWAP)) {
> -               VM_WARN_ON_ONCE(1);
> -               return 0;
> -       }
> -
> -       if (cluster_list_empty(&si->free_clusters))
> -               return 0;
> -
> -       idx =3D cluster_list_first(&si->free_clusters);
> -       offset =3D idx * SWAPFILE_CLUSTER;
> -       ci =3D lock_cluster(si, offset);
> -       alloc_cluster(si, idx);
> -       cluster_set_count(ci, SWAPFILE_CLUSTER);
> -
> -       memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
> -       unlock_cluster(ci);
> -       swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
> -       *slot =3D swp_entry(si->type, offset);
> -
> -       return 1;
> -}
> -
>  static void swap_free_cluster(struct swap_info_struct *si, unsigned long=
 idx)
>  {
>         unsigned long offset =3D idx * SWAPFILE_CLUSTER;
> @@ -1042,17 +1068,15 @@ static void swap_free_cluster(struct swap_info_st=
ruct *si, unsigned long idx)
>         swap_range_free(si, offset, SWAPFILE_CLUSTER);
>  }
>
> -int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size=
)
> +int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_orde=
r)
>  {
> -       unsigned long size =3D swap_entry_size(entry_size);
> +       int order =3D swap_entry_order(entry_order);
> +       unsigned long size =3D 1 << order;
>         struct swap_info_struct *si, *next;
>         long avail_pgs;
>         int n_ret =3D 0;
>         int node;
>
> -       /* Only single cluster request supported */
> -       WARN_ON_ONCE(n_goal > 1 && size =3D=3D SWAPFILE_CLUSTER);
> -
>         spin_lock(&swap_avail_lock);
>
>         avail_pgs =3D atomic_long_read(&nr_swap_pages) / size;
> @@ -1088,14 +1112,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_en=
tries[], int entry_size)
>                         spin_unlock(&si->lock);
>                         goto nextsi;
>                 }
> -               if (size =3D=3D SWAPFILE_CLUSTER) {
> -                       if (si->flags & SWP_BLKDEV)
> -                               n_ret =3D swap_alloc_cluster(si, swp_entr=
ies);
> -               } else
> -                       n_ret =3D scan_swap_map_slots(si, SWAP_HAS_CACHE,
> -                                                   n_goal, swp_entries);
> +               n_ret =3D scan_swap_map_slots(si, SWAP_HAS_CACHE,
> +                                           n_goal, swp_entries, order);
>                 spin_unlock(&si->lock);
> -               if (n_ret || size =3D=3D SWAPFILE_CLUSTER)
> +               if (n_ret || size > 1)
>                         goto check_out;
>                 cond_resched();
>
> @@ -1349,7 +1369,7 @@ void put_swap_folio(struct folio *folio, swp_entry_=
t entry)
>         unsigned char *map;
>         unsigned int i, free_entries =3D 0;
>         unsigned char val;
> -       int size =3D swap_entry_size(folio_nr_pages(folio));
> +       int size =3D 1 << swap_entry_order(folio_order(folio));
>
>         si =3D _swap_info_get(entry);
>         if (!si)
> @@ -1659,7 +1679,7 @@ swp_entry_t get_swap_page_of_type(int type)
>
>         /* This is called for allocating swap entry, not cache */
>         spin_lock(&si->lock);
> -       if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &e=
ntry))
> +       if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &e=
ntry, 0))
>                 atomic_long_dec(&nr_swap_pages);
>         spin_unlock(&si->lock);
>  fail:
> @@ -3113,7 +3133,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>                 p->flags |=3D SWP_SYNCHRONOUS_IO;
>
>         if (p->bdev && bdev_nonrot(p->bdev)) {
> -               int cpu;
> +               int cpu, i;
>                 unsigned long ci, nr_cluster;
>
>                 p->flags |=3D SWP_SOLIDSTATE;
> @@ -3151,7 +3171,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>                         struct percpu_cluster *cluster;
>
>                         cluster =3D per_cpu_ptr(p->percpu_cluster, cpu);
> -                       cluster->next =3D SWAP_NEXT_INVALID;
> +                       for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> +                               cluster->next[i] =3D SWAP_NEXT_INVALID;
>                 }
>         } else {
>                 atomic_inc(&nr_rotate_swap);
> --
> 2.25.1
>

Thanks
Barry

