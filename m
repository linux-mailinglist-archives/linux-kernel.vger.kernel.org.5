Return-Path: <linux-kernel+bounces-76111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEBD85F313
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423DA1C231F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0892C23754;
	Thu, 22 Feb 2024 08:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPQ61uOK"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCECC101C2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590948; cv=none; b=t2NmUM6GWZjW/2myuVa9qXPtO569tXqkDhYa5uxD7mLSTRMTHycYPooUJAM7vJeunV3cxWi0zCuX2V/5Gqw/3Dy5rKOF04e+t+kG5k1N9bCJcRRfnjjXYb14Itd3JikTvTJgj5d1Vj5FPa1dk8xP0pzpAg5eQXVN65U5NL5CPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590948; c=relaxed/simple;
	bh=Ch4I69LtCagVeK/soA5CABJDlpkUSxODhpldr8aLShQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLJqBKCIpx4WG4VGrm5NiJoIO/2hY9opGEcJWmtBrOdVc5AFg6XXy/tfKrypyT3teAomlEq6RO3FmNAPdgvlIHluKDfkAvlRFi6sOAu6s4uzWyBYTZKrCdQyDZhexAV/Hfm6aRSndqkvRTw+AHCVbvgMdE0plU1mCalcx4FuQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPQ61uOK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d2505352e6so30169461fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708590943; x=1709195743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLcnfNka3p1XZTyVd3sS5LqFAV2FLUbRoJLphNmVCtU=;
        b=SPQ61uOK+JpLD9JthIdSCo1IEoRNaygU2StHJskM8UwWXlCGFTlIeXybDNEcNlT2wb
         Ujk0pmPSwq3wtci/IpCgDADgXiMqiHjCnwJmv4SJSvULX7p0GNZVPvda9QAxUt+IH87W
         6LrfiwLxDPjNs2i/r65YCKEuU94pBuJIQCOAvMqicokg9SMuys2dsSPZLQzTuSxryeRm
         vmdgC4YuzUvIKkssdFX2JmO3DXMD0MQV/AZckB4Fj93BfbQxTTjGY8IzvdHAvVgteS1H
         OQmn6Ai9pZR0d40R0FiwQtA9aM4QvPqt+DDi9O346LpqphqMks5a+R/uxIjS4zUoOFIg
         x3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590943; x=1709195743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLcnfNka3p1XZTyVd3sS5LqFAV2FLUbRoJLphNmVCtU=;
        b=mJaY3KB3LRsqnjqS3PKSkpRSXxoi17UtIHSh2e+LxfsvK0la3JuPEoHux4hHiRa7m2
         sVh0h+hyY0TOdZM1kF/VZcz2yBXwzWv8lq9/ObEbSQLZg6RPhQrT6RvsipLebWwn7r2m
         Mt+ndb/eL7tN0TuzHl9C8PIvBhF4GzKMv+LtzkvjpNQNzT1UEtsgfcp/+9bn046L2tr+
         ooyH7gk9s2ESIMdyU6+D/FLUVaOD4BgQkUg3XXRJgRsD7tw8Xr2BDOpbsxTsaJtQhk3E
         20z+9H8LPSL6nXO6Ib7CiYltmGGl1HZoPGLjNgJH0QwlpWSPUSwm04ccdnFdOV2kb0gh
         XIkw==
X-Forwarded-Encrypted: i=1; AJvYcCV/GrzyNc3vJ5a0FcUUoUCxOGLG6ZpUx8LAHG0ooBu4XGxcsFz9jKRqLarELY6vDJbcYELGosim9h+W5pLoolJ0MgM2++I6nrEYK/oj
X-Gm-Message-State: AOJu0YwzA5rL9up//2NdLDUs+sH+tLJbMzdmb3zM6phiWBMos7oj4v7x
	J9Egwx3N/XD2pfrpp2xtl0heqldQpH6Aczti8CFxYCbv847rru1n
X-Google-Smtp-Source: AGHT+IH0mO9PggosH8AtipIvuO9sVXAdfyo819+Pk1RZTJ9mnG/3ywQyHRmKCUNv4UYe5wuAj0x3Tg==
X-Received: by 2002:a2e:9955:0:b0:2d2:2bd2:78e8 with SMTP id r21-20020a2e9955000000b002d22bd278e8mr8186518ljj.47.1708590942545;
        Thu, 22 Feb 2024 00:35:42 -0800 (PST)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id k18-20020a2e8892000000b002d11f45f408sm2201657lji.25.2024.02.22.00.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:35:42 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 22 Feb 2024 09:35:40 +0100
To: Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
	kirill.shutemov@linux.intel.com,
	Vishal Moola <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 00/11] Mitigate a vmap lock contention v3
Message-ID: <ZdcHXFMq0cwmVKfM@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102184633.748113-1-urezki@gmail.com>

Hello, Folk!

> This is v3. It is based on the 6.7.0-rc8.
> 
> 1. Motivation
> 
> - Offload global vmap locks making it scaled to number of CPUS;
> - If possible and there is an agreement, we can remove the "Per cpu kva allocator"
>   to make the vmap code to be more simple;
> - There were complains from XFS folk that a vmalloc might be contented
>   on the their workloads.
> 
> 2. Design(high level overview)
> 
> We introduce an effective vmap node logic. A node behaves as independent
> entity to serve an allocation request directly(if possible) from its pool.
> That way it bypasses a global vmap space that is protected by its own lock.
> 
> An access to pools are serialized by CPUs. Number of nodes are equal to
> number of CPUs in a system. Please note the high threshold is bound to
> 128 nodes.
> 
> Pools are size segregated and populated based on system demand. The maximum
> alloc request that can be stored into a segregated storage is 256 pages. The
> lazily drain path decays a pool by 25% as a first step and as second populates
> it by fresh freed VAs for reuse instead of returning them into a global space.
> 
> When a VA is obtained(alloc path), it is stored in separate nodes. A va->va_start
> address is converted into a correct node where it should be placed and resided.
> Doing so we balance VAs across the nodes as a result an access becomes scalable.
> The addr_to_node() function does a proper address conversion to a correct node.
> 
> A vmap space is divided on segments with fixed size, it is 16 pages. That way
> any address can be associated with a segment number. Number of segments are
> equal to num_possible_cpus() but not grater then 128. The numeration starts
> from 0. See below how it is converted:
> 
> static inline unsigned int
> addr_to_node_id(unsigned long addr)
> {
> 	return (addr / zone_size) % nr_nodes;
> }
> 
> On a free path, a VA can be easily found by converting its "va_start" address
> to a certain node it resides. It is moved from "busy" data to "lazy" data structure.
> Later on, as noted earlier, the lazy kworker decays each node pool and populates it
> by fresh incoming VAs. Please note, a VA is returned to a node that did an alloc
> request.
> 
> 3. Test on AMD Ryzen Threadripper 3970X 32-Core Processor
> 
> sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64
> 
> <default perf>
>  94.41%     0.89%  [kernel]        [k] _raw_spin_lock
>  93.35%    93.07%  [kernel]        [k] native_queued_spin_lock_slowpath
>  76.13%     0.28%  [kernel]        [k] __vmalloc_node_range
>  72.96%     0.81%  [kernel]        [k] alloc_vmap_area
>  56.94%     0.00%  [kernel]        [k] __get_vm_area_node
>  41.95%     0.00%  [kernel]        [k] vmalloc
>  37.15%     0.01%  [test_vmalloc]  [k] full_fit_alloc_test
>  35.17%     0.00%  [kernel]        [k] ret_from_fork_asm
>  35.17%     0.00%  [kernel]        [k] ret_from_fork
>  35.17%     0.00%  [kernel]        [k] kthread
>  35.08%     0.00%  [test_vmalloc]  [k] test_func
>  34.45%     0.00%  [test_vmalloc]  [k] fix_size_alloc_test
>  28.09%     0.01%  [test_vmalloc]  [k] long_busy_list_alloc_test
>  23.53%     0.25%  [kernel]        [k] vfree.part.0
>  21.72%     0.00%  [kernel]        [k] remove_vm_area
>  20.08%     0.21%  [kernel]        [k] find_unlink_vmap_area
>   2.34%     0.61%  [kernel]        [k] free_vmap_area_noflush
> <default perf>
>    vs
> <patch-series perf>
>  82.32%     0.22%  [test_vmalloc]  [k] long_busy_list_alloc_test
>  63.36%     0.02%  [kernel]        [k] vmalloc
>  63.34%     2.64%  [kernel]        [k] __vmalloc_node_range
>  30.42%     4.46%  [kernel]        [k] vfree.part.0
>  28.98%     2.51%  [kernel]        [k] __alloc_pages_bulk
>  27.28%     0.19%  [kernel]        [k] __get_vm_area_node
>  26.13%     1.50%  [kernel]        [k] alloc_vmap_area
>  21.72%    21.67%  [kernel]        [k] clear_page_rep
>  19.51%     2.43%  [kernel]        [k] _raw_spin_lock
>  16.61%    16.51%  [kernel]        [k] native_queued_spin_lock_slowpath
>  13.40%     2.07%  [kernel]        [k] free_unref_page
>  10.62%     0.01%  [kernel]        [k] remove_vm_area
>   9.02%     8.73%  [kernel]        [k] insert_vmap_area
>   8.94%     0.00%  [kernel]        [k] ret_from_fork_asm
>   8.94%     0.00%  [kernel]        [k] ret_from_fork
>   8.94%     0.00%  [kernel]        [k] kthread
>   8.29%     0.00%  [test_vmalloc]  [k] test_func
>   7.81%     0.05%  [test_vmalloc]  [k] full_fit_alloc_test
>   5.30%     4.73%  [kernel]        [k] purge_vmap_node
>   4.47%     2.65%  [kernel]        [k] free_vmap_area_noflush
> <patch-series perf>
> 
> confirms that a native_queued_spin_lock_slowpath goes down to
> 16.51% percent from 93.07%.
> 
> The throughput is ~12x higher:
> 
> urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64
> Run the test with following parameters: run_test_mask=7 nr_threads=64
> Done.
> Check the kernel ring buffer to see the summary.
> 
> real    10m51.271s
> user    0m0.013s
> sys     0m0.187s
> urezki@pc638:~$
> 
> urezki@pc638:~$ time sudo ./test_vmalloc.sh run_test_mask=7 nr_threads=64
> Run the test with following parameters: run_test_mask=7 nr_threads=64
> Done.
> Check the kernel ring buffer to see the summary.
> 
> real    0m51.301s
> user    0m0.015s
> sys     0m0.040s
> urezki@pc638:~$
> 
> 4. Changelog
> 
> v1: https://lore.kernel.org/linux-mm/ZIAqojPKjChJTssg@pc636/T/
> v2: https://lore.kernel.org/lkml/20230829081142.3619-1-urezki@gmail.com/
> 
> Delta v2 -> v3:
>   - fix comments from v2 feedback;
>   - switch from pre-fetch chunk logic to a less complex size based pools.
> 
> Baoquan He (1):
>   mm/vmalloc: remove vmap_area_list
> 
> Uladzislau Rezki (Sony) (10):
>   mm: vmalloc: Add va_alloc() helper
>   mm: vmalloc: Rename adjust_va_to_fit_type() function
>   mm: vmalloc: Move vmap_init_free_space() down in vmalloc.c
>   mm: vmalloc: Remove global vmap_area_root rb-tree
>   mm: vmalloc: Remove global purge_vmap_area_root rb-tree
>   mm: vmalloc: Offload free_vmap_area_lock lock
>   mm: vmalloc: Support multiple nodes in vread_iter
>   mm: vmalloc: Support multiple nodes in vmallocinfo
>   mm: vmalloc: Set nr_nodes based on CPUs in a system
>   mm: vmalloc: Add a shrinker to drain vmap pools
> 
>  .../admin-guide/kdump/vmcoreinfo.rst          |    8 +-
>  arch/arm64/kernel/crash_core.c                |    1 -
>  arch/riscv/kernel/crash_core.c                |    1 -
>  include/linux/vmalloc.h                       |    1 -
>  kernel/crash_core.c                           |    4 +-
>  kernel/kallsyms_selftest.c                    |    1 -
>  mm/nommu.c                                    |    2 -
>  mm/vmalloc.c                                  | 1049 ++++++++++++-----
>  8 files changed, 786 insertions(+), 281 deletions(-)
> 
> -- 
> 2.39.2
> 
There is one thing that i have to clarify and which is open for me yet.

Test machine:
  quemu x86_64 system
  64 CPUs
  64G of memory

test suite:
  test_vmalloc.sh

environment:
  mm-unstable, branch: next-20240220 where this series
  is located. On top of it i added locally Suren's Baghdasaryan
  Memory allocation profiling v3 for better understanding of memory
  usage.

Before running test, the condition is as below:

urezki@pc638:~$ sort -h /proc/allocinfo
 27.2MiB     6970 mm/memory.c:1122 module:memory func:folio_prealloc
 79.1MiB    20245 mm/readahead.c:247 module:readahead func:page_cache_ra_unbounded
  112MiB     8689 mm/slub.c:2202 module:slub func:alloc_slab_page
  122MiB    31168 mm/page_ext.c:270 module:page_ext func:alloc_page_ext
urezki@pc638:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:           64172         936       63618           0         134       63236
Swap:              0           0           0
urezki@pc638:~$

The test-suite stresses vmap/vmalloc layer by creating workers which in
a tight loop do alloc/free, i.e. it is considered as extreme. Below three
identical tests were done with only one difference, which is 64, 128 and 256 kworkers:

1) sudo tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=64

urezki@pc638:~$ sort -h /proc/allocinfo
 80.1MiB    20518 mm/readahead.c:247 module:readahead func:page_cache_ra_unbounded
  122MiB    31168 mm/page_ext.c:270 module:page_ext func:alloc_page_ext
  153MiB    39048 mm/filemap.c:1919 module:filemap func:__filemap_get_folio
  178MiB    13259 mm/slub.c:2202 module:slub func:alloc_slab_page
  350MiB    89656 include/linux/mm.h:2848 module:memory func:pagetable_alloc
urezki@pc638:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:           64172        1417       63054           0         298       62755
Swap:              0           0           0
urezki@pc638:~$

2) sudo tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=128

urezki@pc638:~$ sort -h /proc/allocinfo
  122MiB    31168 mm/page_ext.c:270 module:page_ext func:alloc_page_ext 
  154MiB    39440 mm/filemap.c:1919 module:filemap func:__filemap_get_folio 
  196MiB    14038 mm/slub.c:2202 module:slub func:alloc_slab_page 
 1.20GiB   315655 include/linux/mm.h:2848 module:memory func:pagetable_alloc
urezki@pc638:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:           64172        2556       61914           0         302       61616
Swap:              0           0           0
urezki@pc638:~$

3) sudo tools/testing/selftests/mm/test_vmalloc.sh run_test_mask=127 nr_threads=256

urezki@pc638:~$ sort -h /proc/allocinfo
  127MiB    32565 mm/readahead.c:247 module:readahead func:page_cache_ra_unbounded
  197MiB    50506 mm/filemap.c:1919 module:filemap func:__filemap_get_folio
  278MiB    18519 mm/slub.c:2202 module:slub func:alloc_slab_page
 5.36GiB  1405072 include/linux/mm.h:2848 module:memory func:pagetable_alloc
urezki@pc638:~$ free -m
               total        used        free      shared  buff/cache   available
Mem:           64172        6741       57652           0         394       57431
Swap:              0           0           0
urezki@pc638:~$

pagetable_alloc - gets increased as soon as a higher pressure is applied by
increasing number of workers. Running same number of jobs on a next run
does not increase it and stays on same level as on previous.

/**
 * pagetable_alloc - Allocate pagetables
 * @gfp:    GFP flags
 * @order:  desired pagetable order
 *
 * pagetable_alloc allocates memory for page tables as well as a page table
 * descriptor to describe that memory.
 *
 * Return: The ptdesc describing the allocated page tables.
 */
static inline struct ptdesc *pagetable_alloc(gfp_t gfp, unsigned int order)
{
	struct page *page = alloc_pages(gfp | __GFP_COMP, order);

	return page_ptdesc(page);
}

Could you please comment on it? Or do you have any thought? Is it expected?
Is a page-table ever shrink?

/proc/slabinfo does not show any high "active" or "number" of objects to
be used by any cache.

/proc/meminfo - "VmallocUsed" stays low after those 3 tests.

I have checked it with KASAN, KMEMLEAK and i do not see any issues.

Thank you for the help!

--
Uladzislau Rezki

