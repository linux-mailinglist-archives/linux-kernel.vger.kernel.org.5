Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1176CA71
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjHBKGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjHBKGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:06:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562E011F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:05:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so30371385e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690970737; x=1691575537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cF2FUhStQzchBg8EsNZ3PTlwlia/z+UG1itwYa+1w48=;
        b=JzfYxtvZfxxFD6qkz6THP204zLrAiElgl0934FX0RHk3ykyx8MwCzq2wjKaeQkrJJ4
         ISUnpj2tVfFBAn9YipG8V4o7XH4bW8V8F/Gz+aCm+fqCFsCMS1ovL1qGpePz9I5ZE/u6
         SC7xTqA8aiQkzfjgf24AqVRpNsU909t3DEn8e9A/sKZvBes5ZNkbokaAFUw6+KtfWxdl
         bZuDw0sSosmGQyfRa8xCm2GGzkzC4sKHJt/G16tv+/0heA+KAbSO5QEKb9CKisssPX5K
         E3S/Ba/HIn4QOZq6L/NKViYZuPwZxBGB0ySGve2kqP3rgmV+9NCggNBA0Et3wwzHlZ+P
         ivYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690970737; x=1691575537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cF2FUhStQzchBg8EsNZ3PTlwlia/z+UG1itwYa+1w48=;
        b=hR3cGzhM0DQOdXTzmKAugk1BcVBYxfChxUGeQyKVqPFfvlQmclBKplmCntyd4W0Aar
         rQGm4WCElBvHLf3RAdhixMJEc+UCTgR8jHZde/J4okaS12PYZrPEGGit4Zvlf27N+CjH
         dGxTnWqpcbztu4YK1tE/DDhZEbify40TfHJ66AjEt6tOxhamxDySwcrfoKQiufHemyk0
         zK6P7kAE3UXPSpJMXK6tsxUGLpv7TzBWpjOBIN8/MDE+cGKpruU2Ssd1vprQnPFrc5mc
         b4Evi6AqCiTuDdOSBY4zk7tGRmB90f9YmTQ6qdXk7S8C9wdrj/8tgHg/QM6Jj4ONJiRM
         UqMg==
X-Gm-Message-State: ABy/qLZ1h9iliohhgvIP9mw/m/+QUFT3bECBsg1iK2fjAkmXhGn8eG11
        U4zzlpbm4oh4dYITcPW0bezZv6g4Bx81Lw4YX58=
X-Google-Smtp-Source: APBJJlH3pfPlzSGgbSJIfcxXkXUxVokwvam+tnvDb/DSTS7pWmqUOuB79Em+1psry3vpjf4x7C4JmQ==
X-Received: by 2002:a7b:cc88:0:b0:3fe:1d13:4663 with SMTP id p8-20020a7bcc88000000b003fe1d134663mr4426709wma.1.1690970736804;
        Wed, 02 Aug 2023 03:05:36 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b465:0:bbb6:1437:eebd:d9ef? ([2a02:6b6a:b465:0:bbb6:1437:eebd:d9ef])
        by smtp.gmail.com with ESMTPSA id q7-20020a1cf307000000b003fa98908014sm1286703wmq.8.2023.08.02.03.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 03:05:36 -0700 (PDT)
Message-ID: <540a0f2e-31e0-6396-be14-d9baec608b87@bytedance.com>
Date:   Wed, 2 Aug 2023 11:05:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [v2 1/6] mm: hugetlb: Skip prep of tail pages when
 HVO is enabled
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, Muchun Song <songmuchun@bytedance.com>
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
 <20230730151606.2871391-2-usama.arif@bytedance.com>
 <20230731231841.GA39768@monkey>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20230731231841.GA39768@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2023 00:18, Mike Kravetz wrote:
> On 07/30/23 16:16, Usama Arif wrote:
>> When vmemmap is optimizable, it will free all the duplicated tail
>> pages in hugetlb_vmemmap_optimize while preparing the new hugepage.
>> Hence, there is no need to prepare them.
>>
>> For 1G x86 hugepages, it avoids preparing
>> 262144 - 64 = 262080 struct pages per hugepage.
>>
>> The indirection of using __prep_compound_gigantic_folio is also removed,
>> as it just creates extra functions to indicate demote which can be done
>> with the argument.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> ---
>>   mm/hugetlb.c         | 32 ++++++++++++++------------------
>>   mm/hugetlb_vmemmap.c |  2 +-
>>   mm/hugetlb_vmemmap.h | 15 +++++++++++----
>>   3 files changed, 26 insertions(+), 23 deletions(-)
> 
> Thanks,
> 
> I just started looking at this series.  Adding Muchun on Cc:
> 
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 64a3239b6407..541c07b6d60f 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1942,14 +1942,23 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
>>   	spin_unlock_irq(&hugetlb_lock);
>>   }
>>   
>> -static bool __prep_compound_gigantic_folio(struct folio *folio,
>> -					unsigned int order, bool demote)
>> +static bool prep_compound_gigantic_folio(struct folio *folio, struct hstate *h, bool demote)
>>   {
>>   	int i, j;
>> +	int order = huge_page_order(h);
>>   	int nr_pages = 1 << order;
>>   	struct page *p;
>>   
>>   	__folio_clear_reserved(folio);
>> +
>> +	/*
>> +	 * No need to prep pages that will be freed later by hugetlb_vmemmap_optimize.
>> +	 * Hence, reduce nr_pages to the pages that will be kept.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) &&
>> +			vmemmap_should_optimize(h, &folio->page))
> 
> IIUC, vmemmap_optimize_enabled (checked in vmemmap_should_optimize) can be
> modified at runtime via sysctl.  If so, what prevents it from being changed
> after this check and the later call to hugetlb_vmemmap_optimize()?

Hi,

Thanks for the review.

Yes thats a good catch. The solution for this issue would be to to turn 
hugetlb_free_vmemmap into a callback core_param and have a lock around 
the write and when its used in gather_bootmem_prealloc, etc.

But the bigger issue during runtime is what Muchun pointed out that the 
struct page refcount is not frozen to 0.

My main usecase (and maybe for others as well?) is reserving these 
gigantic pages at boot time. I thought the runtime improvement might 
come from free with it but doesnt look like it. Both issues could be 
solved by just limiting it to boot time, as vmemmap_optimize_enabled 
cannot be changed during boot time, and reference to those pages cannot 
gotten by anything else as well (they aren't even initialized by 
memblock after patch 6), so will include the below diff to solve both 
the issues in next revision.


diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8434100f60ae..790842a6f978 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1956,7 +1956,8 @@ static bool prep_compound_gigantic_folio(struct 
folio *folio, struct hstate *h,
          * Hence, reduce nr_pages to the pages that will be kept.
          */
         if (IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) &&
-                       vmemmap_should_optimize(h, &folio->page))
+                       vmemmap_should_optimize(h, &folio->page) &&
+                       system_state == SYSTEM_BOOTING)
                 nr_pages = HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct 
page);
         for (i = 0; i < nr_pages; i++) {

Thanks,
Usama
