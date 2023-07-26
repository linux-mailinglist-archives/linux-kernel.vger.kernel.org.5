Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B07639D0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjGZPC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjGZPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:02:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE7010F3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:02:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so7682265e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690383742; x=1690988542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPSIiabiK2bB92IGCQhHNo24e4IiD57cduoDesI/uEQ=;
        b=dO/LDAG1Z1DKZOmV71y3tSzTM7L/oULfRN3jBBUriEKRcjCYssuWh3yYzghtAXqlV+
         uArOGHXt2nmRUO1+tIL8Y+UL86CNijqjbccsbXlrZFbz7d0dmh19MhzamK0sG9KIbyt4
         KN0XhkM3OpfYjEaRlStZwFWEE2w99vDnIROJ9+/J2mTPt3Kh/m3ao+A0Hf6vmn7hyhrB
         67RmvMASqvKA4ru00dYHq/HfDJLR5EjKZN6NPW+g7cnSbzdN0tvPJaIvyodEraL7vGZj
         DRWgM8Raotd/f5j8m/p1FUd46k4wJgkT/U1lGeWimmYdw0rwkcmC1pG9uJl/SsH473aQ
         QYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383742; x=1690988542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPSIiabiK2bB92IGCQhHNo24e4IiD57cduoDesI/uEQ=;
        b=VGN1U7TVnqBm8Kr5oaMwRIbgxtBkDCNQXQKa3RkZdqLqsRk51ms7ht4LzC1BKuEZSV
         vvIGhzfwtrhvioPruk72lsL9N8NorCtee2s2E/lZ4VTw+dX8XaeiKfHbE/ougrCkLnYq
         u8h0M0HhtLXWzIEjT7HUUitUwgGbMOcSVAWoZkkdGQj2awwUuK8fI/LyIY+GBThf3O8i
         3Z2xr/uDp8QGV+kBdeNo3b1UFmVk2pPngvialV/8aFymL8FwclOeyjMLP0rBUQ7oiGJf
         Co8YCwj3RB6anFHjSlF67QYW34KFY/ju/XKVNKyZJsj3DDrLlAqnanoCXxAoykA5IBVS
         bcow==
X-Gm-Message-State: ABy/qLbLIaOoATkFUaP3pWsy6AG9IxqBxuqMgNlrQjw02C1jt2W79nf6
        j8n8U6nf8Je20r0RRgRtWC0NFg==
X-Google-Smtp-Source: APBJJlFs6YArZvcQLv3s/VScdvAm2rpaIl5b4MCX20jpRpa1L1Um5u3JLtxoUdsdj3uRMUxE6ISIgQ==
X-Received: by 2002:a05:600c:6347:b0:3fa:7c6b:86e with SMTP id du7-20020a05600c634700b003fa7c6b086emr5150214wmb.12.1690383742604;
        Wed, 26 Jul 2023 08:02:22 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b465:0:fc3:b498:9b55:91a8? ([2a02:6b6a:b465:0:fc3:b498:9b55:91a8])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003fb739d27aesm2257909wmi.35.2023.07.26.08.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 08:02:22 -0700 (PDT)
Message-ID: <440d4a0e-c1ea-864b-54cb-aab74858319a@bytedance.com>
Date:   Wed, 26 Jul 2023 16:02:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [RFC 2/4] mm/memblock: Add hugepage_size member to
 struct memblock_region
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
References: <20230724134644.1299963-1-usama.arif@bytedance.com>
 <20230724134644.1299963-3-usama.arif@bytedance.com>
 <20230726110113.GT1901145@kernel.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20230726110113.GT1901145@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/07/2023 12:01, Mike Rapoport wrote:
> On Mon, Jul 24, 2023 at 02:46:42PM +0100, Usama Arif wrote:
>> This propagates the hugepage size from the memblock APIs
>> (memblock_alloc_try_nid_raw and memblock_alloc_range_nid)
>> so that it can be stored in struct memblock region. This does not
>> introduce any functional change and hugepage_size is not used in
>> this commit. It is just a setup for the next commit where huge_pagesize
>> is used to skip initialization of struct pages that will be freed later
>> when HVO is enabled.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> ---
>>   arch/arm64/mm/kasan_init.c                   |  2 +-
>>   arch/powerpc/platforms/pasemi/iommu.c        |  2 +-
>>   arch/powerpc/platforms/pseries/setup.c       |  4 +-
>>   arch/powerpc/sysdev/dart_iommu.c             |  2 +-
>>   include/linux/memblock.h                     |  8 ++-
>>   mm/cma.c                                     |  4 +-
>>   mm/hugetlb.c                                 |  6 +-
>>   mm/memblock.c                                | 60 ++++++++++++--------
>>   mm/mm_init.c                                 |  2 +-
>>   mm/sparse-vmemmap.c                          |  2 +-
>>   tools/testing/memblock/tests/alloc_nid_api.c |  2 +-
>>   11 files changed, 56 insertions(+), 38 deletions(-)
>>
> 
> [ snip ]
> 
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index f71ff9f0ec81..bb8019540d73 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -63,6 +63,7 @@ struct memblock_region {
>>   #ifdef CONFIG_NUMA
>>   	int nid;
>>   #endif
>> +	phys_addr_t hugepage_size;
>>   };
>>   
>>   /**
>> @@ -400,7 +401,8 @@ phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
>>   				      phys_addr_t start, phys_addr_t end);
>>   phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
>>   				      phys_addr_t align, phys_addr_t start,
>> -				      phys_addr_t end, int nid, bool exact_nid);
>> +				      phys_addr_t end, int nid, bool exact_nid,
>> +				      phys_addr_t hugepage_size);
> 
> Rather than adding yet another parameter to memblock_phys_alloc_range() we
> can have an API that sets a flag on the reserved regions.
> With this the hugetlb reservation code can set a flag when HVO is
> enabled and memmap_init_reserved_pages() will skip regions with this flag
> set.
> 

Hi,

Thanks for the review.

I think you meant memblock_alloc_range_nid/memblock_alloc_try_nid_raw 
and not memblock_phys_alloc_range?

My initial approach was to use flags, but I think it looks worse than 
what I have done in this RFC (I have pushed the flags prototype at 
https://github.com/uarif1/linux/commits/flags_skip_prep_init_gigantic_HVO, 
top 4 commits for reference (the main difference is patch 2 and 4 from 
RFC)). The major points are (the bigger issue is in patch 4):

- (RFC vs flags patch 2 comparison) In the RFC, hugepage_size is 
propagated from memblock_alloc_try_nid_raw through function calls. When 
using flags, the "no_init" boolean is propogated from 
memblock_alloc_try_nid_raw through function calls until the region flags 
are available in memblock_add_range and the new MEMBLOCK_NOINIT flag is 
set. I think its a bit more tricky to introduce a new function to set 
the flag in the region AFTER the call to memblock_alloc_try_nid_raw has 
finished as the memblock_region can not be found.
So something (hugepage_size/flag information) still has to be propagated 
through function calls and a new argument needs to be added.

- (RFC vs flags patch 4 comparison) We can't skip initialization of the 
whole region, only the tail pages. We still need to initialize the 
HUGETLB_VMEMMAP_RESERVE_SIZE (PAGE_SIZE) struct pages for each gigantic 
page.
In the RFC, hugepage_size from patch 2 was used in the for loop in 
memmap_init_reserved_pages in patch 4 to reserve 
HUGETLB_VMEMMAP_RESERVE_SIZE struct pages for every hugepage_size. This 
looks very simple and not hacky.
If we use a flag, there are 2 ways to initialize the 
HUGETLB_VMEMMAP_RESERVE_SIZE struct pages per hugepage:

1. (implemented in github link patch 4) memmap_init_reserved_pages skips 
the region for initialization as you suggested, and then we initialize 
HUGETLB_VMEMMAP_RESERVE_SIZE struct pages per hugepage somewhere later 
(I did it in gather_bootmem_prealloc). When calling 
reserve_bootmem_region in gather_bootmem_prealloc, we need to skip 
early_page_uninitialised and this makes it look a bit hacky.

2. We initialize the HUGETLB_VMEMMAP_RESERVE_SIZE struct pages per 
hugepage in memmap_init_reserved_pages itself. As we have used a flag 
and havent passed hugepage_size, we need to get the gigantic page size 
somehow. There doesnt seem to be a nice way to determine the gigantic 
page size in that function which is architecture dependent. I think 
gigantic page size can be given by PAGE_SIZE << (PUD_SHIFT - 
PAGE_SHIFT), but not sure if this is ok for all architectures? If we can 
use PAGE_SIZE << (PUD_SHIFT - PAGE_SHIFT) it will look much better than 
point 1.

Both the RFC patches and the github flags implementation work, but I 
think RFC patches look much cleaner. If there is a strong preference for 
the the github patches I can send it to mailing list?

Thanks,
Usama


>>   phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
>>   
>>   static __always_inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
>> @@ -415,7 +417,7 @@ void *memblock_alloc_exact_nid_raw(phys_addr_t size, phys_addr_t align,
>>   				 int nid);
>>   void *memblock_alloc_try_nid_raw(phys_addr_t size, phys_addr_t align,
>>   				 phys_addr_t min_addr, phys_addr_t max_addr,
>> -				 int nid);
>> +				 int nid, phys_addr_t hugepage_size);
>>   void *memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align,
>>   			     phys_addr_t min_addr, phys_addr_t max_addr,
>>   			     int nid);
>> @@ -431,7 +433,7 @@ static inline void *memblock_alloc_raw(phys_addr_t size,
>>   {
>>   	return memblock_alloc_try_nid_raw(size, align, MEMBLOCK_LOW_LIMIT,
>>   					  MEMBLOCK_ALLOC_ACCESSIBLE,
>> -					  NUMA_NO_NODE);
>> +					  NUMA_NO_NODE, 0);
>>   }
>>   
>>   static inline void *memblock_alloc_from(phys_addr_t size,
> 
