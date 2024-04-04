Return-Path: <linux-kernel+bounces-131009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC708981DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1705289FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910754BCF;
	Thu,  4 Apr 2024 07:06:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295B548FA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214376; cv=none; b=d1zPWNEvzXwpQIM2vWN4t/kuAXXjhB3DMXjyZhjGg0wWpmsrqzc5zMXpaHY4EuZY/yxiDFNmGwWRKeQZ4MNqT5fHrqq7JdoDPOlRGWzK+8Em1HjfK5d+CKG87kZ15wb7+SL3BiTykif3uYp2LZ41P0FFrmLNxPclRf49Y30dIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214376; c=relaxed/simple;
	bh=MiCPqsssj02ZcG4d0WPRYhfusSKBmtDQ97D+KC2H7tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CePpk/nxzktSRu7Cl1ss5wLktU1XzgGnwJzeMGpbBRkJpKZJVi022Z+kOnIg/8l84HlGOjrAuU/aw2vf+HquuYjnmetKViyIhExf8Qg6AF910Aghpc8U+P1bidcVExaBCJshgy0br7HIFuwF1pHQ7plFVLGtje9xb+R+8nELwUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2B901007;
	Thu,  4 Apr 2024 00:06:44 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E86B23F64C;
	Thu,  4 Apr 2024 00:06:11 -0700 (PDT)
Message-ID: <2acd461f-1d75-434c-a2f2-a3a8e1daad8f@arm.com>
Date: Thu, 4 Apr 2024 08:06:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
Content-Language: en-GB
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-2-ryan.roberts@arm.com>
 <CANeU7QnYOx-=xoeoLWotdQWOs2KMvw0E7LuRq27LO4RDA_ManQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CANeU7QnYOx-=xoeoLWotdQWOs2KMvw0E7LuRq27LO4RDA_ManQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/04/2024 23:12, Chris Li wrote:
> Hi Ryan,
> 
> Sorry for the late reply. I want to review this series but don't have
> the chance to do it sooner.

No problem. This series is now in mm-unstable, so if you want to request any
changes in the other patches, I'd prefer it sooner rather than later, if possible.

> 
> On Wed, Apr 3, 2024 at 4:40 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> As preparation for supporting small-sized THP in the swap-out path,
>> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
>> which, when present, always implies PMD-sized THP, which is the same as
>> the cluster size.
>>
>> The only use of the flag was to determine whether a swap entry refers to
>> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
>> Instead of relying on the flag, we now pass in nr_pages, which
>> originates from the folio's number of pages. This allows the logic to
>> work for folios of any order.
>>
>> The one snag is that one of the swap_page_trans_huge_swapped() call
>> sites does not have the folio. But it was only being called there to
>> shortcut a call __try_to_reclaim_swap() in some cases.
>> __try_to_reclaim_swap() gets the folio and (via some other functions)
>> calls swap_page_trans_huge_swapped(). So I've removed the problematic
>> call site and believe the new logic should be functionally equivalent.
>>
>> That said, removing the fast path means that we will take a reference
>> and trylock a large folio much more often, which we would like to avoid.
>> The next patch will solve this.
>>
>> Removing CLUSTER_FLAG_HUGE also means we can remove split_swap_cluster()
>> which used to be called during folio splitting, since
>> split_swap_cluster()'s only job was to remove the flag.
> 
> Seems necessary to remove the assumption of large folio be PMD size.
> 
> Acked-by: Chris Li <chrisl@kernel.org>

Thanks!

> 
>>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/swap.h | 10 ----------
>>  mm/huge_memory.c     |  3 ---
>>  mm/swapfile.c        | 47 ++++++++------------------------------------
>>  3 files changed, 8 insertions(+), 52 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index a211a0383425..f6f78198f000 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -259,7 +259,6 @@ struct swap_cluster_info {
>>  };
>>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
>>  #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
>> -#define CLUSTER_FLAG_HUGE 4 /* This cluster is backing a transparent huge page */
>>
>>  /*
>>   * We assign a cluster to each CPU, so each CPU can allocate swap entry from
>> @@ -590,15 +589,6 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
>>  }
>>  #endif /* CONFIG_SWAP */
>>
>> -#ifdef CONFIG_THP_SWAP
>> -extern int split_swap_cluster(swp_entry_t entry);
>> -#else
>> -static inline int split_swap_cluster(swp_entry_t entry)
>> -{
>> -       return 0;
>> -}
>> -#endif
>> -
>>  #ifdef CONFIG_MEMCG
>>  static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>>  {
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index ea6d1f09a0b9..3ca9282a0dc9 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2844,9 +2844,6 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>                 shmem_uncharge(folio->mapping->host, nr_dropped);
>>         remap_page(folio, nr);
>>
>> -       if (folio_test_swapcache(folio))
>> -               split_swap_cluster(folio->swap);
>> -
>>         /*
>>          * set page to its compound_head when split to non order-0 pages, so
>>          * we can skip unlocking it below, since PG_locked is transferred to
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index 5e6d2304a2a4..0d44ee2b4f9c 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -343,18 +343,6 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
>>         info->data = 0;
>>  }
>>
>> -static inline bool cluster_is_huge(struct swap_cluster_info *info)
>> -{
>> -       if (IS_ENABLED(CONFIG_THP_SWAP))
>> -               return info->flags & CLUSTER_FLAG_HUGE;
>> -       return false;
>> -}
>> -
>> -static inline void cluster_clear_huge(struct swap_cluster_info *info)
>> -{
>> -       info->flags &= ~CLUSTER_FLAG_HUGE;
>> -}
>> -
>>  static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
>>                                                      unsigned long offset)
>>  {
>> @@ -1027,7 +1015,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>>         offset = idx * SWAPFILE_CLUSTER;
>>         ci = lock_cluster(si, offset);
>>         alloc_cluster(si, idx);
>> -       cluster_set_count_flag(ci, SWAPFILE_CLUSTER, CLUSTER_FLAG_HUGE);
>> +       cluster_set_count(ci, SWAPFILE_CLUSTER);
>>
>>         memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
>>         unlock_cluster(ci);
>> @@ -1365,7 +1353,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
>>
>>         ci = lock_cluster_or_swap_info(si, offset);
>>         if (size == SWAPFILE_CLUSTER) {
>> -               VM_BUG_ON(!cluster_is_huge(ci));
>>                 map = si->swap_map + offset;
>>                 for (i = 0; i < SWAPFILE_CLUSTER; i++) {
>>                         val = map[i];
>> @@ -1373,7 +1360,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
>>                         if (val == SWAP_HAS_CACHE)
>>                                 free_entries++;
>>                 }
>> -               cluster_clear_huge(ci);
>>                 if (free_entries == SWAPFILE_CLUSTER) {
>>                         unlock_cluster_or_swap_info(si, ci);
>>                         spin_lock(&si->lock);
>> @@ -1395,23 +1381,6 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
>>         unlock_cluster_or_swap_info(si, ci);
>>  }
>>
>> -#ifdef CONFIG_THP_SWAP
>> -int split_swap_cluster(swp_entry_t entry)
>> -{
>> -       struct swap_info_struct *si;
>> -       struct swap_cluster_info *ci;
>> -       unsigned long offset = swp_offset(entry);
>> -
>> -       si = _swap_info_get(entry);
>> -       if (!si)
>> -               return -EBUSY;
>> -       ci = lock_cluster(si, offset);
>> -       cluster_clear_huge(ci);
>> -       unlock_cluster(ci);
>> -       return 0;
>> -}
>> -#endif
>> -
>>  static int swp_entry_cmp(const void *ent1, const void *ent2)
>>  {
>>         const swp_entry_t *e1 = ent1, *e2 = ent2;
>> @@ -1519,22 +1488,23 @@ int swp_swapcount(swp_entry_t entry)
>>  }
>>
>>  static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
>> -                                        swp_entry_t entry)
>> +                                        swp_entry_t entry,
>> +                                        unsigned int nr_pages)
>>  {
>>         struct swap_cluster_info *ci;
>>         unsigned char *map = si->swap_map;
>>         unsigned long roffset = swp_offset(entry);
>> -       unsigned long offset = round_down(roffset, SWAPFILE_CLUSTER);
>> +       unsigned long offset = round_down(roffset, nr_pages);
> 
> It is obvious this code only works for powers two nr_pages. The
> SWAPFILE_CLSTER is a power of two. If we switch to an API for
> nr_pages, we might want to warn/ban passing in the non-power of two
> nr_pages.

Indeed. I could change the prototype to pass order instead of nr_pages, then
generate nr_pages (= 1 << order) inside the function. But given the function is
static and only called from a single callsite, I don't see it as hugely
important. I'd prefer to leave as is at this stage, unless you have strong
objection.

> 
>>         int i;
>>         bool ret = false;
>>
>>         ci = lock_cluster_or_swap_info(si, offset);
>> -       if (!ci || !cluster_is_huge(ci)) {
>> +       if (!ci || nr_pages == 1) {
>>                 if (swap_count(map[roffset]))
>>                         ret = true;
>>                 goto unlock_out;
>>         }
>> -       for (i = 0; i < SWAPFILE_CLUSTER; i++) {
>> +       for (i = 0; i < nr_pages; i++) {
> 
> Here we assume the swap entry offset is contiguous. That is beyond
> your patch's scope. If in the future we want to have non-contiguous
> swap entries to swap out large pages, we will need to find out and
> change all the places that have the assumption of contiguous swap
> entries.

Yes there are tonnes of places that make this assumption :)

> 
> Chris
> 
>>                 if (swap_count(map[offset + i])) {
>>                         ret = true;
>>                         break;
>> @@ -1556,7 +1526,7 @@ static bool folio_swapped(struct folio *folio)
>>         if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!folio_test_large(folio)))
>>                 return swap_swapcount(si, entry) != 0;
>>
>> -       return swap_page_trans_huge_swapped(si, entry);
>> +       return swap_page_trans_huge_swapped(si, entry, folio_nr_pages(folio));
>>  }
>>
>>  /**
>> @@ -1622,8 +1592,7 @@ int free_swap_and_cache(swp_entry_t entry)
>>                 }
>>
>>                 count = __swap_entry_free(p, entry);
>> -               if (count == SWAP_HAS_CACHE &&
>> -                   !swap_page_trans_huge_swapped(p, entry))
>> +               if (count == SWAP_HAS_CACHE)
>>                         __try_to_reclaim_swap(p, swp_offset(entry),
>>                                               TTRS_UNMAPPED | TTRS_FULL);
>>                 put_swap_device(p);
>> --
>> 2.25.1
>>


