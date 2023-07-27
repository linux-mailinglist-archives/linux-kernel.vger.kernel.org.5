Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0AE765DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjG0U46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjG0U45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:56:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F74F5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:56:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc54cab6fso14449055e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690491390; x=1691096190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZuRgeT5VlstWJ8B1+I/x/Bo/hFhxlkd2kqhh5r6tMvo=;
        b=GUuXheYW4WvNv7X7DW3/pE92+8S04jgSbsMYnMgR2VUJTShU2PWaO0ZxK8TRClpzMj
         ogBc/bRm4qV8UAWdqQ0agHWPjuBnm1aix6Ryr5V6JScupiSQzxYUzh9qpFPfkqTR9pvP
         puk28X+Q7mE47jIJ0qtFq9U7wGeDiLX8Vh7/2pM4AtKx6XnAyFFAlkZlVgge8Zfp+Y/5
         Cou+oM4ac38To08oM9OdpR7YPba1PmtbjkNCCIqtDaTPBevew2eWbQV0c8m8K0NhfuJk
         25/swSF/8/gvYAE9bw374d4sgIH7/UHFm/vjTzChhfMpXiStc+1orlo1yAvdsINUybUP
         08Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690491390; x=1691096190;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuRgeT5VlstWJ8B1+I/x/Bo/hFhxlkd2kqhh5r6tMvo=;
        b=OgHSO89vm2iS95a9F4BbzUenYzBTuq+6gvsCRsTmnv5I8Q04C9mUYBXE2h6DyVD9N6
         ENme4LLhsKWdr2YxtYfwb/JLok4T5PCVC6l8QU+mdzwcHykMPC0xPgCWdgByRAjtWV7S
         6XOtpdZTGEuH/ru4RiPXKvLy0iyhgwshgbLDUCuVIzTZ+HFUcZ9iZV8EJKyBTxtm+d3Z
         BzsrMi8aekQEFMTiuQp5CV+moGD9dRr2gZ+L6Qbn40n27qJXh34e1pPnQs3ZNInnjy+g
         x00tpmyrkyvCxr1PfFapRlJh9beOqGcGBQ+X9DozU2y+6GRRlUVqa4X3a51jt/6tykwS
         jbow==
X-Gm-Message-State: ABy/qLbMFFmEBXOrLu5XocQhEC9mkDjVx69DX5cFlxP515lpddTm8xqb
        EpEalt9hW/wxvx6rCrQK9BSRXw==
X-Google-Smtp-Source: APBJJlGs1jeeH1Eow3I3RdeLRBmy0ZNvAuNmUXCMigvkucMCAXAIQ1kbpSNECnd+OkRlHEmPYp3vcQ==
X-Received: by 2002:a5d:6b8c:0:b0:314:e929:bcb9 with SMTP id n12-20020a5d6b8c000000b00314e929bcb9mr224952wrx.57.1690491390092;
        Thu, 27 Jul 2023 13:56:30 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b465:0:7e3e:db9e:70fa:9ccb? ([2a02:6b6a:b465:0:7e3e:db9e:70fa:9ccb])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d5112000000b00313e59cb371sm3065937wrt.12.2023.07.27.13.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 13:56:29 -0700 (PDT)
Message-ID: <383a72f7-b9d3-963f-e5fb-b0036376399e@bytedance.com>
Date:   Thu, 27 Jul 2023 21:56:28 +0100
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
 <440d4a0e-c1ea-864b-54cb-aab74858319a@bytedance.com>
 <20230727043002.GA1901145@kernel.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20230727043002.GA1901145@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2023 05:30, Mike Rapoport wrote:
> On Wed, Jul 26, 2023 at 04:02:21PM +0100, Usama Arif wrote:
>>
>> On 26/07/2023 12:01, Mike Rapoport wrote:
>>> On Mon, Jul 24, 2023 at 02:46:42PM +0100, Usama Arif wrote:
>>>> This propagates the hugepage size from the memblock APIs
>>>> (memblock_alloc_try_nid_raw and memblock_alloc_range_nid)
>>>> so that it can be stored in struct memblock region. This does not
>>>> introduce any functional change and hugepage_size is not used in
>>>> this commit. It is just a setup for the next commit where huge_pagesize
>>>> is used to skip initialization of struct pages that will be freed later
>>>> when HVO is enabled.
>>>>
>>>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>>>> ---
>>>>    arch/arm64/mm/kasan_init.c                   |  2 +-
>>>>    arch/powerpc/platforms/pasemi/iommu.c        |  2 +-
>>>>    arch/powerpc/platforms/pseries/setup.c       |  4 +-
>>>>    arch/powerpc/sysdev/dart_iommu.c             |  2 +-
>>>>    include/linux/memblock.h                     |  8 ++-
>>>>    mm/cma.c                                     |  4 +-
>>>>    mm/hugetlb.c                                 |  6 +-
>>>>    mm/memblock.c                                | 60 ++++++++++++--------
>>>>    mm/mm_init.c                                 |  2 +-
>>>>    mm/sparse-vmemmap.c                          |  2 +-
>>>>    tools/testing/memblock/tests/alloc_nid_api.c |  2 +-
>>>>    11 files changed, 56 insertions(+), 38 deletions(-)
>>>>
>>>
>>> [ snip ]
>>>
>>>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>>>> index f71ff9f0ec81..bb8019540d73 100644
>>>> --- a/include/linux/memblock.h
>>>> +++ b/include/linux/memblock.h
>>>> @@ -63,6 +63,7 @@ struct memblock_region {
>>>>    #ifdef CONFIG_NUMA
>>>>    	int nid;
>>>>    #endif
>>>> +	phys_addr_t hugepage_size;
>>>>    };
>>>>    /**
>>>> @@ -400,7 +401,8 @@ phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
>>>>    				      phys_addr_t start, phys_addr_t end);
>>>>    phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
>>>>    				      phys_addr_t align, phys_addr_t start,
>>>> -				      phys_addr_t end, int nid, bool exact_nid);
>>>> +				      phys_addr_t end, int nid, bool exact_nid,
>>>> +				      phys_addr_t hugepage_size);
>>>
>>> Rather than adding yet another parameter to memblock_phys_alloc_range() we
>>> can have an API that sets a flag on the reserved regions.
>>> With this the hugetlb reservation code can set a flag when HVO is
>>> enabled and memmap_init_reserved_pages() will skip regions with this flag
>>> set.
>>>
>>
>> Hi,
>>
>> Thanks for the review.
>>
>> I think you meant memblock_alloc_range_nid/memblock_alloc_try_nid_raw and
>> not memblock_phys_alloc_range?
> 
> Yes.
>   
>> My initial approach was to use flags, but I think it looks worse than what I
>> have done in this RFC (I have pushed the flags prototype at
>> https://github.com/uarif1/linux/commits/flags_skip_prep_init_gigantic_HVO,
>> top 4 commits for reference (the main difference is patch 2 and 4 from
>> RFC)). The major points are (the bigger issue is in patch 4):
>>
>> - (RFC vs flags patch 2 comparison) In the RFC, hugepage_size is propagated
>> from memblock_alloc_try_nid_raw through function calls. When using flags,
>> the "no_init" boolean is propogated from memblock_alloc_try_nid_raw through
>> function calls until the region flags are available in memblock_add_range
>> and the new MEMBLOCK_NOINIT flag is set. I think its a bit more tricky to
>> introduce a new function to set the flag in the region AFTER the call to
>> memblock_alloc_try_nid_raw has finished as the memblock_region can not be
>> found.
>> So something (hugepage_size/flag information) still has to be propagated
>> through function calls and a new argument needs to be added.
> 
> Sorry if I wasn't clear. I didn't mean to add flags parameter, I meant to
> add a flag and a function that sets this flag for a range. So for
> MEMBLOCK_NOINIT there would be
> 
> int memblock_mark_noinit(phys_addr_t base, phys_addr_t size);
> 
> I'd just name this flag MEMBLOCK_RSRV_NOINIT to make it clear it controls
> the reserved regions.
> 
> This won't require updating all call sites of memblock_alloc_range_nid()
> and memblock_alloc_try_nid_raw() but only a small refactoring of
> memblock_setclr_flag() and its callers.
> 

Thanks for this, its much cleaner doing the way you described. I have 
sent v1 implementing this 
https://lore.kernel.org/all/20230727204624.1942372-1-usama.arif@bytedance.com/.

Regards,
Usama

