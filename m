Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F757B4FA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjJBJ5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjJBJ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:57:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923068E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:57:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50307759b65so24990675e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696240632; x=1696845432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwEtkxsfBhgs6E7OtuujbkpVgU3JMhyc0hqKghcL4RU=;
        b=Z7+MijikGZyX0P8WDGY3DiOnkJUBLS3chut3OxUvJ91V0nY3rIPx8euKjptZrBi1+H
         aF2nTcUgaASzqKxNmdaJZY98Z5YgnU+zssk8LKVOvl5eieOTTcQtRyV0GJiXGzC43MQU
         1ax+6rvYjwFE577Kqmf2ak7F7p64vNSRGx6Qp1FOwrWdalXfIv5LSyS7CTUHOCc6Maj0
         V/q7QMn6b5G+R1qUtubF+dsYdlvJPp4YmV0r7Om7a+DUdZE6KnJxZmSrLasNdFvmsSsm
         FgN9bfTP9ouU/gnGZvgov/7YXH5m08h4xyh/9uJlrjaxc/ISSVPI/548II9h1cRiAwY9
         66rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696240632; x=1696845432;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwEtkxsfBhgs6E7OtuujbkpVgU3JMhyc0hqKghcL4RU=;
        b=QiKYgLPFMJSUlKeO85VNq6EfiRNja5NDzpqLpzT2Qsq+jzGYPrAdIOOeXQUvECnb3T
         T69e3pPwSjlxS8q0pClZlAd5kB+Rz7UXnhpA6WN6dc5Kh4lY/CWFq1Qj5ueRES2C8oTD
         yW6fz+Y5Rrd1r1npDJlNXF9+UTGbMyM3URSSk9QaWSKNp2ICmAKJ6UNt5o64b8OpfcOP
         QuARCWWjzwKmfjhYK11mnJ/P5wBHVStz4SU1WWOyULdn/iw0gi4J2PIbC1gbR6YZl/Vv
         bAbruuYJ55KX6YNYEJIkubnhE0Eg/HzQpDl1V3nkD3ktfEADCqihr1Vxv2XafFxga40s
         dE3A==
X-Gm-Message-State: AOJu0Yz9HJnqXgwBfeHZ/kcCQdSDEUDvf/1FQaBPXGpqxzNrJEzfiYe3
        +JWJ4woK8AKywsD8a5Kv5gV5JA==
X-Google-Smtp-Source: AGHT+IFdE6YQcfmyUbpQxzt3Mj9yhWkQUIGV2HAIWGVAJzNvPsQqCa1EWZ80dNv5OCeTvDOY0+o5wQ==
X-Received: by 2002:a05:6512:4011:b0:500:9d6c:913e with SMTP id br17-20020a056512401100b005009d6c913emr10719139lfb.52.1696240631837;
        Mon, 02 Oct 2023 02:57:11 -0700 (PDT)
Received: from [172.30.204.164] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v2-20020a056512096200b005030c533843sm4617893lft.154.2023.10.02.02.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 02:57:11 -0700 (PDT)
Message-ID: <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
Date:   Mon, 2 Oct 2023 11:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
 <20230929205731.GA10357@monkey>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230929205731.GA10357@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/23 22:57, Mike Kravetz wrote:
> On 09/27/23 13:26, Konrad Dybcio wrote:
>>
>>
>> On 26.09.2023 01:48, Mike Kravetz wrote:
>>> Allocation of a hugetlb page for the hugetlb pool is done by the routine
>>> alloc_pool_huge_page.  This routine will allocate contiguous pages from
>>> a low level allocator, prep the pages for usage as a hugetlb page and
>>> then add the resulting hugetlb page to the pool.
>>>
>>> In the 'prep' stage, optional vmemmap optimization is done.  For
>>> performance reasons we want to perform vmemmap optimization on multiple
>>> hugetlb pages at once.  To do this, restructure the hugetlb pool
>>> allocation code such that vmemmap optimization can be isolated and later
>>> batched.
>>>
>>> The code to allocate hugetlb pages from bootmem was also modified to
>>> allow batching.
>>>
>>> No functional changes, only code restructure.
>>>
>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>> Hi, looks like this patch prevents today's next from booting
>> on at least one Qualcomm ARM64 platform. Reverting it makes
>> the device boot again.
> 
> Can you share the config used and any other specific information such as
> kernel command line.
Later this week.

Konrad
