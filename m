Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC3476CA7A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjHBKHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjHBKHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:07:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9ACB2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 03:06:52 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31783d02093so6109077f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690970811; x=1691575611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyEyhJ+SYt1PDZBLekZnzMx3kPhmdqaT8TuATp+FGSs=;
        b=TdvyOLe7Vbbv1X3Er0J44qtu3Mh/8WS97QaGthp5U/TIJhyPYqp7VyD6PsGIZrjtzH
         svwImSxQoykNemhM5a4Qu8tefnfbsRqKLJZGYuEAgbsQsJybz0exbiyXhk0q/CHVED72
         vrdC3Pjghxg06djY4DuoWwi9522RjyleWbQZoPqDeDLSUy9X0IyLQYyLjWWK/efCWUPU
         MAwQ/iNdTKQe2KB3yLBDtKnZjg/cAqwXOkSfesZXbo+JZ5cqmrVAeM1Is3CrHSQP6cV8
         kjZgDMkdVQDC9K4mcFeGHnZbtCngaB4cExlWpAVdae0rdOzNGd8qGD5wC++xIvUqyrOk
         gLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690970811; x=1691575611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyEyhJ+SYt1PDZBLekZnzMx3kPhmdqaT8TuATp+FGSs=;
        b=Q7PeQ27MuVBq6XCwSKaIXH5LjYdj+4F5QjSVD3Sm9DRNAJi63j3/z42I6KyGYpcpC+
         qC++BWqWX5fjfgUDaP6nMaLj0REc145o0RQBFW1DXo3yQQf68GkxiNyMQeyizkfIKHiP
         OmQOytGnnEN9bWxvcvgLJuyYXqonoAtt1A39+hlRulfDaonqociN+Zm4YvEB/NLf1Dgw
         D1A2s1jfxiCSzWiL85nHbk6zLJX6ClbHx1KgsUzeG/qeDfPSQDVSjCQn2uND7VLi/DwM
         S7dw6X4mTtjnF0BcA1STgLRvnqEewqu3smG9bzEoQ1yVKo5Fh6HQSUUpzBlQOe09iwLB
         ZBuA==
X-Gm-Message-State: ABy/qLZS63GMYCwOEeMASa6J2p6lk5N3LppGTlLp3/JrXeCYrjxeXiNk
        oHIKz9Oy3Ug3MvFuJR+Eq8lxsQ==
X-Google-Smtp-Source: APBJJlF8R8nhPRbeTIwgHztSVyP02VWV2JZIoySmi+a69zXf2DYX0HIycM5ObMSYswanBy6SBSy+Vg==
X-Received: by 2002:adf:f9c9:0:b0:317:5c82:10c2 with SMTP id w9-20020adff9c9000000b003175c8210c2mr4523177wrr.59.1690970810984;
        Wed, 02 Aug 2023 03:06:50 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b465:0:bbb6:1437:eebd:d9ef? ([2a02:6b6a:b465:0:bbb6:1437:eebd:d9ef])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d54c1000000b003176f2d9ce5sm18648471wrv.71.2023.08.02.03.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 03:06:50 -0700 (PDT)
Message-ID: <24ed8a1f-2134-6082-7bc9-f8662dc723bd@bytedance.com>
Date:   Wed, 2 Aug 2023 11:06:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [v2 1/6] mm: hugetlb: Skip prep of tail pages when
 HVO is enabled
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, linux-mm@kvack.org,
        mike.kravetz@oracle.com, rppt@kernel.org
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
 <20230730151606.2871391-2-usama.arif@bytedance.com>
 <b6aaa304-e632-9f8f-ae60-63ae209ad152@linux.dev>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <b6aaa304-e632-9f8f-ae60-63ae209ad152@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2023 03:04, Muchun Song wrote:
> 
> 
> On 2023/7/30 23:16, Usama Arif wrote:
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
>>   mm/hugetlb.c         | 32 ++++++++++++++------------------
>>   mm/hugetlb_vmemmap.c |  2 +-
>>   mm/hugetlb_vmemmap.h | 15 +++++++++++----
>>   3 files changed, 26 insertions(+), 23 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 64a3239b6407..541c07b6d60f 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1942,14 +1942,23 @@ static void prep_new_hugetlb_folio(struct 
>> hstate *h, struct folio *folio, int ni
>>       spin_unlock_irq(&hugetlb_lock);
>>   }
>> -static bool __prep_compound_gigantic_folio(struct folio *folio,
>> -                    unsigned int order, bool demote)
>> +static bool prep_compound_gigantic_folio(struct folio *folio, struct 
>> hstate *h, bool demote)
>>   {
>>       int i, j;
>> +    int order = huge_page_order(h);
>>       int nr_pages = 1 << order;
>>       struct page *p;
>>       __folio_clear_reserved(folio);
>> +
>> +    /*
>> +     * No need to prep pages that will be freed later by 
>> hugetlb_vmemmap_optimize.
>> +     * Hence, reduce nr_pages to the pages that will be kept.
>> +     */
>> +    if (IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) &&
>> +            vmemmap_should_optimize(h, &folio->page))
>> +        nr_pages = HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page);
> 
> We need to initialize the refcount to zero of tail pages (see the big
> comment below in this function), given a situation that someone (maybe
> GUP) could get a ref on the tail pages when the vmemmap is optimizing,
> what prevent this from happening?
> 
> Thanks.
> 

Thanks for pointing this out, will limit to boot time for solving this 
in next version.

