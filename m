Return-Path: <linux-kernel+bounces-120246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275BF88D4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D193C2A6302
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310B3219F6;
	Wed, 27 Mar 2024 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNTUa3eo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26DD2262B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711508067; cv=none; b=b7fMNxjNOBlgtZh8PJmYLiMSjqRBtRB6M7qbDKeyKMpnDfIx/EbCnWuxz6uyZCyWxbwvKLUqoHDckAjdMDqwdgdFdsYR03qAoQ2WsuMvDgjPZ9vyrd8Dsh5lhAColeM067XFSLlZxH3zEkWzrqkAjVevLJw5TAE/JVWyDKliNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711508067; c=relaxed/simple;
	bh=YxNB/+KVg3sJySwSmzUJhuJT2OVZcJaWVmnZNq1sfzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PBbPVxcAkkk8TJnPfhEOmM8vC30/4ibZEO6/P+KDJYmMy6egwseVO6XuNITlT4vNXa0qk2lLJRIKexIPyeB4QbqmE0ZICNLvvhykGCNSovL9EnAkUvKQ2+rdTB/a58oF2vr/jZitqWVOQyRkANSEujz7JhW+oow4xFN/Vz42344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNTUa3eo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711508065; x=1743044065;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=YxNB/+KVg3sJySwSmzUJhuJT2OVZcJaWVmnZNq1sfzU=;
  b=XNTUa3eo5WV6p66zRWbQcbKjqLg1e1Wl+u0/GKvSXu0Q7BR1XTI9OQ9+
   7qRkMZQFdoggvKh33uL1RaFmU1IXHz4ZDM5U+V1+83wAyh9DSzckZu1zl
   bPR/8zu132reBOIybGbPfvc3ZMVTU/Riwidn8RfVGCEp7fcfoEye7bXh3
   q5pZNzdeD6anWOY0nMG1NHi1ppVrfuyADZ78kiegSakSMO6WO+YH1VQJC
   FqhBUjBU42VtZy9AqW6nSnpq8sbnOyNCdw1RD+AJQ6iqa4Qqf/2mnMp5q
   5USoJn0Y7uhc5bHv+T+dJEiVXx0DYD8mTWJo0wBCd6uMojBgzmFhRIR2M
   w==;
X-CSE-ConnectionGUID: QW6r9s8kR2KrB9N+nC6ZwA==
X-CSE-MsgGUID: qeiFLMy2SRGVD74NxaS91Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10389187"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="10389187"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 19:54:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="20805218"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 19:54:21 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Chris Li
 <chrisl@kernel.org>,  Minchan Kim <minchan@kernel.org>,  Barry Song
 <v-songbaohua@oppo.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Yu Zhao
 <yuzhao@google.com>,  SeongJae Park <sj@kernel.org>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Nhat Pham
 <nphamcs@gmail.com>,  Chengming Zhou <zhouchengming@bytedance.com>,
  Andrew Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] mm/swap: always use swap cache for
 synchronization
In-Reply-To: <20240326185032.72159-1-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 27 Mar 2024 02:50:22 +0800")
References: <20240326185032.72159-1-ryncsn@gmail.com>
Date: Wed, 27 Mar 2024 10:52:26 +0800
Message-ID: <878r24o07p.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Kairui,

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> A month ago a bug was fixed for SWP_SYNCHRONOUS_IO swapin (swap cache
> bypass swapin):
> https://lore.kernel.org/linux-mm/20240219082040.7495-1-ryncsn@gmail.com/
>
> Because we have to spin on the swap map on race, and swap map is too small
> to contain more usable info, an ugly schedule_timeout_uninterruptible(1)
> is added. It's not the first time a hackish workaround was added for cache
> bypass swapin and not the last time. I did many experiments locally to
> see if the swap cache bypass path can be dropped while keeping the
> performance still comparable. And it seems doable.
>

In general, I think that it's a good idea to unify cache bypass swapin
and normal swapin.  But I haven't dive into the implementation yet.

> This series does the following things:
> 1. Remove swap cache bypass completely.
> 2. Apply multiple optimizations after that, these optimizations are
>    either undoable or very difficult to do without dropping the cache
>    bypass swapin path.
> 3. Use swap cache as a synchronization layer, also unify some code
>    with page cache (filemap).
>
> As a result, we have:
> 1. A comparable performance, some tests are even faster.
> 2. Multi-index support for swap cache.
> 3. Removed many hackish workarounds including above long tailing
>    issue is gone.
>
> Sending this as RFC to collect some discussion, suggestion, or rejection
> early, this seems need to be split into multiple series, but the
> performance is not good until the last patch so I think start by
> seperating them may make this approach not very convincing. And there
> are still some (maybe further) TODO items and optimization space
> if we are OK with this approach.
>
> This is based on my another series, for reusing filemap code for swapcache:
> [PATCH v2 0/4] mm/filemap: optimize folio adding and splitting
> https://lore.kernel.org/linux-mm/20240325171405.99971-1-ryncsn@gmail.com/
>
> Patch 1/10, introduce a helper from filemap side to be used later.
> Patch 2/10, 3/10 are clean up and prepare for removing the swap cache
>   bypass swapin path.
> Patch 4/10, removed the swap cache bypass swapin path, and the
>   performance drop heavily (-28%).
> Patch 5/10, apply the first optimization after the removal, since all
>   folios goes through swap cache now, there is no need to explicit shadow
>   clearing any more.
> Patch 6/10, apply another optimization after clean up shadow clearing
>   routines. Now swapcache is very alike page cache, so just reuse page
>   cache code and we will have multi-index support. Shadow memory usage
>   dropped a lot.
> Patch 7/10, just rename __read_swap_cache_async, it will be refactored
>   and a key part of this series, and the naming is very confusing to me.
> Patch 8/10, make swap cache as a synchronization layer, introduce two
>   helpers for adding folios to swap cache, caller will either succeed or
>   get a folio to wait on.
> Patch 9/10, apply another optimization. With above two helpers, looking
>   up of swapcache can be optimized and avoid false looking up, which
>   helped improve the performance.
> Patch 10/10, apply a major optimization for SWP_SYNCHRONOUS_IO devices,
>   after this commit, performance for simple swapin/swapout is basically
>   same as before.
>
> Test 1, sequential swapin/out of 30G zero page on ZRAM:
>
>                Before (us)        After (us)
> Swapout:       33619409           33886008
> Swapin:        32393771           32465441 (- 0.2%)
> Swapout (THP): 7817909            6899938  (+11.8%)
> Swapin (THP) : 32452387           33193479 (- 2.2%)

If my understanding were correct, we don't have swapin (THP) support,
yet.  Right?

> And after swapping out 30G with THP, the radix node usage dropped by a
> lot:
>
> Before: radix_tree_node 73728K
> After:  radix_tree_node  7056K (-94%)

Good!

> Test 2:
> Mysql (16g buffer pool, 32G ZRAM SWAP, 4G memcg, Zswap disabled, THP never)
>   sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=root \
>   --mysql-password=1234 --mysql-db=sb --tables=36 --table-size=2000000 \
>   --threads=48 --time=300 --report-interval=10 run
>
> Before: transactions: 4849.25 per sec
> After:  transactions: 4849.40 per sec
>
> Test 3:
> Mysql (16g buffer pool, NVME SWAP, 4G memcg, Zswap enabled, THP never)
>   echo never > /sys/kernel/mm/transparent_hugepage/enabled
>   echo 100 > /sys/module/zswap/parameters/max_pool_percent
>   echo 1 > /sys/module/zswap/parameters/enabled
>   echo y > /sys/module/zswap/parameters/shrinker_enabled
>
>   sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=root \
>   --mysql-password=1234 --mysql-db=sb --tables=36 --table-size=2000000 \
>   --threads=48 --time=600 --report-interval=10 run
>
> Before: transactions: 1662.90 per sec
> After:  transactions: 1726.52 per sec

3.8% improvement.  Good!

> Test 4:
> Mysql (16g buffer pool, NVME SWAP, 4G memcg, Zswap enabled, THP always)
>   echo always > /sys/kernel/mm/transparent_hugepage/enabled
>   echo 100 > /sys/module/zswap/parameters/max_pool_percent
>   echo 1 > /sys/module/zswap/parameters/enabled
>   echo y > /sys/module/zswap/parameters/shrinker_enabled
>
>   sysbench /usr/share/sysbench/oltp_read_only.lua --mysql-user=root \
>   --mysql-password=1234 --mysql-db=sb --tables=36 --table-size=2000000 \
>   --threads=48 --time=600 --report-interval=10 run
>
> Before: transactions: 2860.90 per sec.
> After:  transactions: 2802.55 per sec.
>
> Test 5:
> Memtier / memcached (16G brd SWAP, 8G memcg, THP never):
>
>   memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 16 -B binary &
>
>   memtier_benchmark -S /tmp/memcached.socket \
>     -P memcache_binary -n allkeys --key-minimum=1 \
>     --key-maximum=24000000 --key-pattern=P:P -c 1 -t 16 \
>     --ratio 1:0 --pipeline 8 -d 1000
>
> Before: 106730.31 Ops/sec
> After:  106360.11 Ops/sec
>
> Test 5:
> Memtier / memcached (16G brd SWAP, 8G memcg, THP always):
>
>   memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 16 -B binary &
>
>   memtier_benchmark -S /tmp/memcached.socket \
>     -P memcache_binary -n allkeys --key-minimum=1 \
>     --key-maximum=24000000 --key-pattern=P:P -c 1 -t 16 \
>     --ratio 1:0 --pipeline 8 -d 1000
>
> Before: 83193.11 Ops/sec
> After:  82504.89 Ops/sec
>
> These tests are tested under heavy memory stress, and the performance
> seems basically same as before,very slightly better/worse for certain
> cases, the benefits of multi-index are basically erased by
> fragmentation and workingset nodes usage is slightly lower.
>
> Some (maybe further) TODO items if we are OK with this approach:
>
> - I see a slight performance regression for THP tests,
>   could identify a clear hotspot with perf, my guess is the
>   content on the xa_lock is an issue (we have a xa_lock for
>   every 64M swap cache space), THP handling needs to take the lock
>   longer than usual. splitting the xa_lock to be more
>   fine-grained seems a good solution. We have
>   SWAP_ADDRESS_SPACE_SHIFT = 14 which is not an optimal value.
>   Considering XA_CHUNK_SHIFT is 6, we will have three layer of Xarray
>   just for 2 extra bits. 12 should be better to always make use of
>   the whole XA chunk and having two layers at most. But duplicated
>   address_space struct also wastes more memory and cacheline.
>   I see an observable performance drop (~3%) after change
>   SWAP_ADDRESS_SPACE_SHIFT to 12. Might be a good idea to
>   decouple swap cache xarray from address_space (there are
>   too many user for swapcache, shouldn't come too dirty).
>
> - Actually after patch Patch 4/10, the performance is much better for
>   tests limited with memory cgroup, until 10/10 applied the direct swap
>   cache freeing logic for SWP_SYNCHRONOUS_IO swapin. Because if the swap
>   device is not near full, swapin doesn't clear up the swapcache, so
>   repeated swapout doesn't need to re-alloc a swap entry, make things
>   faster. This may indicate that lazy freeing of swap cache could benifit
>   certain workloads and may worth looking into later.
>
> - Now SWP_SYNCHRONOUS_IO swapin will bypass readahead and force drop
>   swap cache after swapin is done, which can be cleaned up and optimized
>   further after this patch. Device type will only determine the
>   readahead logic, and swap cache drop check can be based purely on swap
>   count.
>
> - Recent mTHP swapin/swapout series should have no fundamental
>   conflict with this.
>
> Kairui Song (10):
>   mm/filemap: split filemap storing logic into a standalone helper
>   mm/swap: move no readahead swapin code to a stand-alone helper
>   mm/swap: convert swapin_readahead to return a folio
>   mm/swap: remove cache bypass swapin
>   mm/swap: clean shadow only in unmap path
>   mm/swap: switch to use multi index entries
>   mm/swap: rename __read_swap_cache_async to swap_cache_alloc_or_get
>   mm/swap: use swap cache as a synchronization layer
>   mm/swap: delay the swap cache look up for swapin
>   mm/swap: optimize synchronous swapin
>
>  include/linux/swapops.h |   5 +-
>  mm/filemap.c            | 161 +++++++++-----
>  mm/huge_memory.c        |  78 +++----
>  mm/internal.h           |   2 +
>  mm/memory.c             | 133 ++++-------
>  mm/shmem.c              |  44 ++--
>  mm/swap.h               |  71 ++++--
>  mm/swap_state.c         | 478 +++++++++++++++++++++-------------------
>  mm/swapfile.c           |  64 +++---
>  mm/vmscan.c             |   8 +-
>  mm/workingset.c         |   2 +-
>  mm/zswap.c              |   4 +-
>  12 files changed, 540 insertions(+), 510 deletions(-)

--
Best Regards,
Huang, Ying

