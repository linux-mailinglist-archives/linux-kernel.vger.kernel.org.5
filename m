Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8B6797B01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbjIGR7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242624AbjIGR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:59:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738831BDA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:58:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso20925981fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694109503; x=1694714303; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6arKeyrgPphWsjC9458pVzLHkvbc4JWeWn+IPDbctQc=;
        b=ZQu+Btx0EJQgGVUUszz8I1FSmFBWHMYySQedkZzHBD4m53z7ibBLx2YPCgAVolSiNc
         Ia1ID5Ml49q/vhghmcBkMwnr+ReAI3haI2hKYH4lDKWtTVnyFjzMKbsMwjfSOX3wwEVH
         XdjBZ4Xw68Bk2oYev0OAEbYchlVP9TCuQ0Q90x+Q8EauzbbWM+b9PvBkXErJ9eh+I7pj
         1pPd8HEjVqv1DesDQE9FDaLDeU4YoHvWs5XQrTP6nBICScp5x+4jQ1JuLa6oSmijrqlt
         terZnr8wDWnfjgVTY3ruDg2YXFx5l4FstyxpWX6YaHQU8cWjOaqnx/8sX0NySmbbivQy
         rqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694109503; x=1694714303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6arKeyrgPphWsjC9458pVzLHkvbc4JWeWn+IPDbctQc=;
        b=byEXSuSmvUwmHWktssX+29tFCb2cq84WTgBnmagxv6hVk0dyJmtWxJWM1+co4Q7ojN
         Vj2+XoF8dH6LYVe+oVRkDsSoyW3G5y5cDfLMXp4FrBrnikeM0Enic2J+b12oHSaz+CR1
         zcpMAdhKzhOtkFevyv+rlIPlLp4M8R2vIRk2lF1kiobT2qMctLpWbE0ItoNxLBuaBa7A
         n80ocOKSOlPa10GS7+LEdfILaJYkPys3xIQy8MXde/59QKuruTsE9JKfm+kyEn3r+ogv
         CsNjQhQyECs6nH2z5kteuO0SSWc6VVcl2ePR6Iu6Q3gERm1A100fkUb3orMaIECu92N+
         mdFA==
X-Gm-Message-State: AOJu0YxSYOvb64cbgP+3PKAMSjieYNVaEpTD+c59JAb5w4vayhbcixzW
        Gi8CkMAF7QbC+22egbVCxLjlJy5l506rGrV7zz4=
X-Google-Smtp-Source: AGHT+IFRpPPukBi6IZmLBxS+OzDEd3MJR8tvOwTtzfl4T9BzPzahKmMP5ZhCH3GcpMSc+xkpdZfRGg==
X-Received: by 2002:a05:600c:20d1:b0:401:b53e:6c3b with SMTP id y17-20020a05600c20d100b00401b53e6c3bmr4434672wmm.6.1694081680521;
        Thu, 07 Sep 2023 03:14:40 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b5c7:0:6274:c7ab:26e2:b113? ([2a02:6b6a:b5c7:0:6274:c7ab:26e2:b113])
        by smtp.gmail.com with ESMTPSA id n10-20020adffe0a000000b003140f47224csm22815249wrr.15.2023.09.07.03.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 03:14:40 -0700 (PDT)
Message-ID: <92fc88ba-3e3a-2648-4232-1d3f9bed5bb6@bytedance.com>
Date:   Thu, 7 Sep 2023 11:14:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [v4 4/4] mm: hugetlb: Skip initialization of
 gigantic tail struct pages if freed by HVO
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-5-usama.arif@bytedance.com>
 <20230906181016.GA3612@monkey>
 <57c8dd7f-d1a0-37c4-1d3b-d6374e92ffa1@bytedance.com>
 <20230906215927.GE3612@monkey>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <20230906215927.GE3612@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/2023 22:59, Mike Kravetz wrote:
> On 09/06/23 22:27, Usama Arif wrote:
>>
>>
>> On 06/09/2023 19:10, Mike Kravetz wrote:
>>> On 09/06/23 12:26, Usama Arif wrote:
>>>> The new boot flow when it comes to initialization of gigantic pages
>>>> is as follows:
>>>> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
>>>> the region after the first struct page is marked as noinit.
>>>> - This results in only the first struct page to be
>>>> initialized in reserve_bootmem_region. As the tail struct pages are
>>>> not initialized at this point, there can be a significant saving
>>>> in boot time if HVO succeeds later on.
>>>> - Later on in the boot, the head page is prepped and the first
>>>> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
>>>> are initialized.
>>>> - HVO is attempted. If it is not successful, then the rest of the
>>>> tail struct pages are initialized. If it is successful, no more
>>>> tail struct pages need to be initialized saving significant boot time.
>>>
>>> Code looks reasonable.  Quick question.
>>>
>>> On systems where HVO is disabled, we will still go through this new boot
>>> flow and init hugetlb tail pages later in boot (gather_bootmem_prealloc).
>>> Correct?
>>> If yes, will there be a noticeable change in performance from the current
>>> flow with HVO disabled?  My concern would be allocating a large number of
>>> gigantic pages at boot (TB or more).
>>>
>>
>> Thanks for the review.
>>
>> The patch moves the initialization of struct pages backing hugepage from
>> reserve_bootmem_region to a bit later on in the boot to
>> gather_bootmem_prealloc. When HVO is disabled, there will be no difference
>> in time taken to boot with or without this patch series, as 262144 struct
>> pages per gigantic page (for x86) are still going to be initialized, just in
>> a different place.
> 
> I seem to recall that 'normal' deferred struct page initialization was
> done in parallel as the result of these series:
> https://lore.kernel.org/linux-mm/20171013173214.27300-1-pasha.tatashin@oracle.com/
> https://lore.kernel.org/linux-mm/20200527173608.2885243-1-daniel.m.jordan@oracle.com/#t
> and perhaps others.
> 
> My thought is that we lose that parallel initialization when it is being
> done as part of hugetlb fall back initialization.
> 
> Does that make sense?  Or am I missing something?  I do not have any proof
> that things will be slower.  That is just something I was thinking about.

The patches for deferring struct page initialization did not cover the 
struct pages for gigantic pages.

With CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled, the function call taken 
during boot without these patches is:

[A1] mm_core_init-> mem_init-> memblock_free_all-> 
free_low_memory_core_early-> memmap_init_reserved_pages-> 
reserve_bootmem_region-> initialize *all* struct pages of a gigantic 
page serially (DEFERRED_STRUCT_PAGE_INIT is enabled).
The pfn of the struct pages > NODE_DATA(nid)->first_deferred_pfn which 
means this cannot be deferred.

then later on in the boot:

[A2] hugetlb_init-> gather_bootmem_prealloc-> 
prep_compound_gigantic_folio-> prepare *all* the struct pages to be part 
of a gigantic page (freezing page ref count, setting compound head, etc 
for all struct pages)

With CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled, the function call taken 
during boot with these patches is:

[B1] mm_core_init->...reserve_bootmem_region-> initialize head struct 
page only.

then later on in the boot:

[B2] hugetlb_init-> gather_bootmem_prealloc-> [B21] initialize only 64 
tail struct pages if HVO passes. [B22] If HVO fails initialize all tail 
struct pages.


Each of A1, A2 and B22 are for loops going over 262144 struct pages per 
hugepage. So without these patches, the work done is 262144*2 (A1+A2) 
per hugepage during boot, even with CONFIG_DEFERRED_STRUCT_PAGE_INIT as 
its not deferred. With these patches, the work done is either 1 + 64 
(B1+B21) if HVO is enabled or 1 + 262144 (B1+B22) if HVO is disabled.

With CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled, the times taken to boot 
till init process when allocating 500 1G hugeppages are:
- with these patches, HVO enabled: 1.32 seconds [B1 + B21]
- with patches, HVO disabled: 2.15 seconds [B1 + B22]
- without patches, HVO enabled: 3.90  seconds [A1 + A2 + HVO]
- without patches, HVO disabled: 3.58 seconds [A1 + A2]
