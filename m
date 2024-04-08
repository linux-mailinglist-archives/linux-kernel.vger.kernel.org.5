Return-Path: <linux-kernel+bounces-135461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0245689C3E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BE51F23285
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB47F80603;
	Mon,  8 Apr 2024 13:39:49 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366279F0;
	Mon,  8 Apr 2024 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583589; cv=none; b=W3zRT5EscCa8Vs6RsgKWyN2OYpqI297rNS8CMEiZUN0ujEA4ER7qG3jk6GYInzbYMCqlkU7ruyiujdlUD1fVI+sKoWNY3/Wi6fyrSZRJDBf1Or1SyWcITZqBftcikBoVsL6plQiyFmYOklcnq9/v4igIaF96RiDasnQNcFZRECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583589; c=relaxed/simple;
	bh=HBiOHkqW/9TipkYoD4a9v0jztvyOEos6tX06fqvWb6s=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MwekOagle4r6vXBdXfas35sCQtdDpqR2shMwOFfS98pifAl7LcEHIMxEospMiiSV0y+IrsC+a2li013yANGeNADdyKEZcLENJCl7HiFZwURJ3gESA7HIhBgGoJdXcKLSLzs7iwDdLxj9wfX0wHOJpw9L/wMyqgS8KAXRPfyt33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VCqs70pSLz1ymQ9;
	Mon,  8 Apr 2024 21:37:31 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id BA03B1401E0;
	Mon,  8 Apr 2024 21:39:44 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 8 Apr
 2024 21:39:44 +0800
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation and
 maintainer for page_frag
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-13-linyunsheng@huawei.com>
 <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com>
Date: Mon, 8 Apr 2024 21:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/4/8 2:13, Alexander H Duyck wrote:
> On Sun, 2024-04-07 at 21:08 +0800, Yunsheng Lin wrote:
>> Update documentation about design, implementation and API usages
>> for page_frag.
>>
>> Also update MAINTAINERS for page_frag. Alexander seems to be the
>> orginal author for page_frag, we can add him to the MAINTAINERS
>> later if we have an ack from him.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> Again, this seems more like 2 different pathches at least. One for the
> Documentation and MAINTAINERS changes, and one for the function
> documentation.

Sure.

> 
>> ---
>>  Documentation/mm/page_frags.rst | 115 ++++++++++++++++++----------
>>  MAINTAINERS                     |  10 +++
>>  include/linux/page_frag_cache.h | 128 ++++++++++++++++++++++++++++++++
>>  mm/page_frag_cache.c            |  51 ++++++++++---
>>  4 files changed, 256 insertions(+), 48 deletions(-)
>>
>> diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
>> index 503ca6cdb804..77256dfb58bf 100644
>> --- a/Documentation/mm/page_frags.rst
>> +++ b/Documentation/mm/page_frags.rst
>> @@ -1,43 +1,80 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>>  ==============
>>  Page fragments
>>  ==============
>>  
>> -A page fragment is an arbitrary-length arbitrary-offset area of memory
>> -which resides within a 0 or higher order compound page.  Multiple
>> -fragments within that page are individually refcounted, in the page's
>> -reference counter.
>> -
>> -The page_frag functions, page_frag_alloc and page_frag_free, provide a
>> -simple allocation framework for page fragments.  This is used by the
>> -network stack and network device drivers to provide a backing region of
>> -memory for use as either an sk_buff->head, or to be used in the "frags"
>> -portion of skb_shared_info.
>> -
>> -In order to make use of the page fragment APIs a backing page fragment
>> -cache is needed.  This provides a central point for the fragment allocation
>> -and tracks allows multiple calls to make use of a cached page.  The
>> -advantage to doing this is that multiple calls to get_page can be avoided
>> -which can be expensive at allocation time.  However due to the nature of
>> -this caching it is required that any calls to the cache be protected by
>> -either a per-cpu limitation, or a per-cpu limitation and forcing interrupts
>> -to be disabled when executing the fragment allocation.
>> -
>> -The network stack uses two separate caches per CPU to handle fragment
>> -allocation.  The netdev_alloc_cache is used by callers making use of the
>> -netdev_alloc_frag and __netdev_alloc_skb calls.  The napi_alloc_cache is
>> -used by callers of the __napi_alloc_frag and napi_alloc_skb calls.  The
>> -main difference between these two calls is the context in which they may be
>> -called.  The "netdev" prefixed functions are usable in any context as these
>> -functions will disable interrupts, while the "napi" prefixed functions are
>> -only usable within the softirq context.
>> -
>> -Many network device drivers use a similar methodology for allocating page
>> -fragments, but the page fragments are cached at the ring or descriptor
>> -level.  In order to enable these cases it is necessary to provide a generic
>> -way of tearing down a page cache.  For this reason __page_frag_cache_drain
>> -was implemented.  It allows for freeing multiple references from a single
>> -page via a single call.  The advantage to doing this is that it allows for
>> -cleaning up the multiple references that were added to a page in order to
>> -avoid calling get_page per allocation.
>> -
>> -Alexander Duyck, Nov 29, 2016.
> 
> What is the point of removing this just to add it to a C file further
> down in the diff? Honestly I am not a fan of all the noise this is
> adding to these diffs. Can we do a little less moving of lines for the
> sake of moving them? All it does is pollute the git blame if you try to
> figure out the origin of the lines.

I was thinking about move the doc related code to file where code is related,
so that author will remember to update the doc when changing the code.
Maybe above does not matter that much?

> 
>> +.. kernel-doc:: mm/page_frag_cache.c
>> +   :doc: page_frag allocator
>> +
>> +Architecture overview
>> +=====================
>> +
>> +.. code-block:: none
>> +
>> +    +----------------------+
>> +    | page_frag API caller |
>> +    +----------------------+
>> +            ^
>> +            |
>> +            |
>> +            |
>> +            v
>> +    +----------------------------------------------+
>> +    |          request page fragment               |
>> +    +----------------------------------------------+
>> +        ^                                        ^
>> +        |                                        |
>> +        | Cache empty or not enough              |
>> +        |                                        |
>> +        v                                        |
>> +    +--------------------------------+           |
>> +    | refill cache with order 3 page |           |
>> +    +--------------------------------+           |
>> +     ^                  ^                        |
>> +     |                  |                        |
>> +     |                  | Refill failed          |
>> +     |                  |                        | Cache is enough
>> +     |                  |                        |
>> +     |                  v                        |
>> +     |    +----------------------------------+   |
>> +     |    |  refill cache with order 0 page  |   |
>> +     |    +----------------------------------+   |
>> +     |                       ^                   |
>> +     | Refill succeed        |                   |
>> +     |                       | Refill succeed    |
>> +     |                       |                   |
>> +     v                       v                   v
>> +    +----------------------------------------------+
>> +    |       allocate fragment from cache           |
>> +    +----------------------------------------------+
>> +
> 
> +1 for the simple visualization of how this works.
> 
>> +API interface
>> +=============
>> +As the design and implementation of page_frag API, the allocation side does not
>> +allow concurrent calling, it is assumed that the caller must ensure there is not
>> +concurrent alloc calling to the same page_frag_cache instance by using it's own
>> +lock or rely on some lockless guarantee like NAPI softirq.
>> +
>> +Depending on different use cases, callers expecting to deal with va, page or
>> +both va and page for them may call page_frag_alloc_va(), page_frag_alloc_pg(),
>> +or page_frag_alloc() accordingly.
>> +
> 
> So the new documentation is good up to here.
> 
>> +There is also a use case that need minimum memory in order for forward
>> +progressing, but can do better if there is more memory available. Introduce
>> +page_frag_alloc_prepare() and page_frag_alloc_commit() related API, the caller
>> +requests the minimum memory it need and the prepare API will return the maximum
>> +size of the fragment returned, caller need to report back to the page_frag core
>> +how much memory it actually use by calling commit API, or not calling the commit
>> +API if deciding to not use any memory.
>> +
> 
> This part is as clear as mud to me. It sounds like kind of a convoluted
> setup where you are having the caller have to know a fair bit about the
> internal structure of the cache and it is essentially checking the
> state and then performing a commit. Not a huge fan. I would almost
> prefer to see something more like what we used to do with msix where
> you just had a range you could request and if it can't give you at
> least the minimum it fails.>
> I assume the patch is somewhere here in the set. Will take a look at it
> later.

Yes, the API is introduced in patch 9 and used in patch 10.

> 
>> +.. kernel-doc:: include/linux/page_frag_cache.h
>> +   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
>> +                 page_frag_alloc_va __page_frag_alloc_va_align
>> +                 page_frag_alloc_va_align page_frag_alloc_va_prepare
>> +                 page_frag_alloc_va_prepare_align page_frag_alloc_pg_prepare
>> +                 page_frag_alloc_prepare page_frag_alloc_commit
>> +                 page_frag_alloc_commit_noref page_frag_free_va
>> +
>> +.. kernel-doc:: mm/page_frag_cache.c
>> +   :identifiers: page_frag_cache_drain
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 4745ea94d463..2f84aba59428 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16683,6 +16683,16 @@ F:	mm/page-writeback.c
>>  F:	mm/readahead.c
>>  F:	mm/truncate.c
>>  
>> +PAGE FRAG
>> +M:	Yunsheng Lin <linyunsheng@huawei.com>
>> +L:	linux-mm@kvack.org
>> +L:	netdev@vger.kernel.org
>> +S:	Supported
>> +F:	Documentation/mm/page_frags.rst
>> +F:	include/linux/page_frag_cache.h
>> +F:	mm/page_frag_cache.c
>> +F:	mm/page_frag_test.c
>> +
> 
> I would appreciate it if you could add me as I usually am having to
> deal with issues people have with this anyway. You can probably just go
> with:
> Alexander Duyck <alexander.duyck@gmail.com>

Sure, good to your ack here.

> 
>>  PAGE POOL
>>  M:	Jesper Dangaard Brouer <hawk@kernel.org>
>>  M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
>> index 28185969cd2c..d8edbecdd179 100644

