Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB240766EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbjG1NrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbjG1NrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:47:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B128A1731
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:47:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31771a876b5so1983904f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690552030; x=1691156830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cy1LSkJqgMruXxvCuJW6/EzZhFsDX10qwz2encY7YDA=;
        b=IdYiD4Bnoqk0CZVpJWuYRqoTIETpnHDpDg2cF3FEAwjw83JPSZzUza8o2XHoKqO4a5
         kYfmTK0jHM9YDyhJW7TuXspo0G+9MJ06UXzg7O/SwBMjBYAfzcJcaHYo6W4PVlYwK++O
         T7gehR860bATi+ob7e20c1Ln5lO8YrD/VLrVF4MzOMScu/sOGbWJJHJZ1gT/xHk54NZi
         BfTM1EbVUnD0Eam7suaUZhuyKroqQhPuklAKJE1e//P8bbT1TIcLcU7h3XO+hXLplqkn
         bfYgMjsHOGCDOT9mlqG6ZHdNuP9jsyLX1q6OFX8b/oPK5Gr5lPn8d7bBiPrcy7hIIXoL
         CrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552030; x=1691156830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy1LSkJqgMruXxvCuJW6/EzZhFsDX10qwz2encY7YDA=;
        b=luXYt/S3Nyu2MB8qATcTszK5G2XDoB9C1ZlJy7OiUzgSi0edMtIjwwvFBD1Yr9xdEo
         zYuIFJn14EyxnrkhH6zpieyKKKDBxKzrTj/ZZ4Z2QA/VLUvkAYBUVuebRTVGtl/l03Fh
         09O9F5r4x52s/B3OVAr6dS72c67QWfdQJA/84xabagULvXP0fDT3Eg+tCHBYERZbogMw
         HrLedV9ZvctbIkOqvMnLy8i+TW2Kruf/ANCKWW7M5JKFCgKHSxjllLwAZT4z5ATbe4i8
         5DA+A9WUC2LkfI5ricwF6qjxEVZzPt37l+IDs18+M5R1zhmjLWa3r6cC0PKiQKcYsUdV
         84jw==
X-Gm-Message-State: ABy/qLb+qTlisg6gvOIPLETASqpcCpp6YPQ3xk0eIoW+LwFzsB/yoJ+z
        jcfP465D1xtZy0YqAvj19ji5DA==
X-Google-Smtp-Source: APBJJlGUkThZ0gS3wOkJ7AGHSscNUxDY1iuwR0EQq+6Xk9WqPXeWAyhZ57i2g+LkvnJNQGzRgN52Rg==
X-Received: by 2002:adf:f8ce:0:b0:317:5e8e:c2be with SMTP id f14-20020adff8ce000000b003175e8ec2bemr1732788wrq.63.1690552030086;
        Fri, 28 Jul 2023 06:47:10 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b465:0:43bc:5463:fea5:e049? ([2a02:6b6a:b465:0:43bc:5463:fea5:e049])
        by smtp.gmail.com with ESMTPSA id s10-20020adfecca000000b003177f57e79esm4826534wro.88.2023.07.28.06.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:47:09 -0700 (PDT)
Message-ID: <a684b0e8-4412-79c8-2926-7822b1163c15@bytedance.com>
Date:   Fri, 28 Jul 2023 14:47:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [v1 4/6] memblock: introduce MEMBLOCK_RSRV_NOINIT
 flag
Content-Language: en-US
To:     =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>,
        linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        rppt@kernel.org
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
 <20230727204624.1942372-5-usama.arif@bytedance.com>
 <55750855-0029-b10f-3317-e6ae4d89d492@redhat.com>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <55750855-0029-b10f-3317-e6ae4d89d492@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/2023 05:30, Mika Penttilä wrote:
> Hi,
> 
> On 7/27/23 23:46, Usama Arif wrote:
> 
>> For reserved memory regions marked with this flag,
>> reserve_bootmem_region is not called during memmap_init_reserved_pages.
>> This can be used to avoid struct page initialization for
>> regions which won't need them, for e.g. hugepages with
>> HVO enabled.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> ---
>>   include/linux/memblock.h |  7 +++++++
>>   mm/memblock.c            | 32 ++++++++++++++++++++++++++------
>>   2 files changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index f71ff9f0ec81..7f9d06c08592 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -47,6 +47,7 @@ enum memblock_flags {
>>       MEMBLOCK_MIRROR        = 0x2,    /* mirrored region */
>>       MEMBLOCK_NOMAP        = 0x4,    /* don't add to kernel direct 
>> mapping */
>>       MEMBLOCK_DRIVER_MANAGED = 0x8,    /* always detected via a 
>> driver */
>> +    MEMBLOCK_RSRV_NOINIT    = 0x10,    /* don't call 
>> reserve_bootmem_region for this region */
>>   };
>>   /**
>> @@ -125,6 +126,7 @@ int memblock_clear_hotplug(phys_addr_t base, 
>> phys_addr_t size);
>>   int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>>   int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
>>   int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
>> +int memblock_rsrv_mark_noinit(phys_addr_t base, phys_addr_t size);
>>   void memblock_free_all(void);
>>   void memblock_free(void *ptr, size_t size);
>> @@ -259,6 +261,11 @@ static inline bool memblock_is_nomap(struct 
>> memblock_region *m)
>>       return m->flags & MEMBLOCK_NOMAP;
>>   }
>> +static inline bool memblock_is_noinit(struct memblock_region *m)
>> +{
>> +    return m->flags & MEMBLOCK_RSRV_NOINIT;
>> +}
>> +
>>   static inline bool memblock_is_driver_managed(struct memblock_region 
>> *m)
>>   {
>>       return m->flags & MEMBLOCK_DRIVER_MANAGED;
>> diff --git a/mm/memblock.c b/mm/memblock.c
>> index 4fd431d16ef2..3a15708af3b6 100644
>> --- a/mm/memblock.c
>> +++ b/mm/memblock.c
>> @@ -997,6 +997,22 @@ int __init_memblock 
>> memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>>       return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP, 0);
>>   }
>> +/**
>> + * memblock_rsrv_mark_noinit - Mark a reserved memory region with 
>> flag MEMBLOCK_RSRV_NOINIT.
>> + * @base: the base phys addr of the region
>> + * @size: the size of the region
>> + *
>> + * For memory regions marked with %MEMBLOCK_RSRV_NOINIT, 
>> reserve_bootmem_region
>> + * is not called during memmap_init_reserved_pages, hence struct 
>> pages are not
>> + * initialized for this region.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>> +int __init_memblock memblock_rsrv_mark_noinit(phys_addr_t base, 
>> phys_addr_t size)
>> +{
>> +    return memblock_setclr_flag(base, size, 1, MEMBLOCK_RSRV_NOINIT, 1);
>> +}
>> +
>>   static bool should_skip_region(struct memblock_type *type,
>>                      struct memblock_region *m,
>>                      int nid, int flags)
>> @@ -2113,13 +2129,17 @@ static void __init 
>> memmap_init_reserved_pages(void)
>>           memblock_set_node(start, end, &memblock.reserved, nid);
>>       }
>> -    /* initialize struct pages for the reserved regions */
>> +    /*
>> +     * initialize struct pages for reserved regions that don't have
>> +     * the MEMBLOCK_RSRV_NOINIT flag set
>> +     */
>>       for_each_reserved_mem_region(region) {
>> -        nid = memblock_get_region_node(region);
>> -        start = region->base;
>> -        end = start + region->size;
>> -
>> -        reserve_bootmem_region(start, end, nid);
>> +        if (!memblock_is_noinit(region)) {
>> +            nid = memblock_get_region_node(region);
>> +            start = region->base;
>> +            end = start + region->size;
>> +            reserve_bootmem_region(start, end, nid);
>> +        }
>>       }
>>   }
> 
> There's code like:
> 
> static inline void free_vmemmap_page(struct page *page)
> {
>          if (PageReserved(page))
>                  free_bootmem_page(page);
>          else
>                  __free_page(page);
> }
> 
> which depends on the PageReserved being in vmempages pages, so I think 
> you can't skip that part?
> 

free_vmemmap_page_list (free_vmemmap_page) is called on struct pages 
(refer to as [1]) that point to memory *which contains* the struct pages 
(refer to as [2]) for the hugepage. The above if 
(!memblock_is_noinit(region)) to not reserve_bootmem_region is called 
for the struct pages [2] for the hugepage. struct pages [1] are not 
changed with my patch.

As an experiment if I run the diff at the bottom with and without these 
patches I get the same log "HugeTLB: reserved pages 4096, normal pages 
0", which means those struct pages are treated the same without and 
without these patches. (Its 4096 as 262144 struct pages [2] per hugepage 
* 64 bytes per struct page / PAGE_SIZE = 4096 struct pages [1] )

Also should have mentioned in cover letter, I used cat /proc/meminfo to 
make sure it was working as expected. Reserving 500 1G hugepages with 
and without these patches when hugetlb_free_vmemmap=on
MemTotal:       536207112 kB (511.4G)

when hugetlb_free_vmemmap=off
MemTotal:       528015112 kB (503G)


The expectation is that for 500 1G hugepages, when using HVO we have a 
saving of 16380K*500=~8GB which is what we see with and without those 
patches (511.4G - 503G). These patches didnt affect these numbers.



diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b5b7834e0f42..bc0ec90552b7 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -208,6 +208,8 @@ static int vmemmap_remap_range(unsigned long start, 
unsigned long end,
         return 0;
  }

+static int i = 0, j = 0;
+
  /*
   * Free a vmemmap page. A vmemmap page can be allocated from the memblock
   * allocator or buddy allocator. If the PG_reserved flag is set, it means
@@ -216,10 +218,14 @@ static int vmemmap_remap_range(unsigned long 
start, unsigned long end,
   */
  static inline void free_vmemmap_page(struct page *page)
  {
-       if (PageReserved(page))
+       if (PageReserved(page)) {
+               i++;
                 free_bootmem_page(page);
-       else
+       }
+       else {
+               j++;
                 __free_page(page);
+       }
  }

  /* Free a list of the vmemmap pages */
@@ -380,6 +386,7 @@ static int vmemmap_remap_free(unsigned long start, 
unsigned long end,

         free_vmemmap_page_list(&vmemmap_pages);

+       pr_err("reserved pages %u, normal pages %u", i, j);
         return ret;
  }





> --Mika
> 
> 
