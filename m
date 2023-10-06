Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DA67BC152
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjJFVkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjJFVkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:40:00 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A00010EC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 14:39:36 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c189dabcc3so30415571fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696628373; x=1697233173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT6SEGOGkAQe0ejKNRIEG3Mg0RqGqWFejjM93l9xq5k=;
        b=L0ZcBYAKfoTKHAZYY+c6x4HxhTZEql2uRqhNvKthq/gj8kLK6F4a33am55Oli92JH/
         Vtg9bsQyKcayhqpofgHc01wzCOEGBxAGIjg8qZoFyWWvR07xCCw+V7pEPnXao6vpOeHl
         Q3XIL9+7uYnILCOrA7p8J96srgLQvcrA0IzCvtLOH65b5j90aEOeF0MN65GAJgZlnUSi
         6ME5oPe/vXMhq5Ik/9P8czNvVSjKZbM4keJucuUeEiuMmqGrAnf1Cp2EVE8l37E3J0XQ
         nEqe0wABl4C9uGD7BE5vmQze6wltlY867hFkMPlPVSR95mfTwS0sy13VBzrOhC6Akf0X
         /CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696628373; x=1697233173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT6SEGOGkAQe0ejKNRIEG3Mg0RqGqWFejjM93l9xq5k=;
        b=sKgajj1T0gps81r+cqMYQVv9q4GRT9XwGnZ6EbDrU0rntvDJXgiN3oKmD4a/uT6YnF
         ggjO6v+ADKvzH3Uo58Cx+O28aM38oiOvU3x0EwsRv5Ko+MIcxP/9yvYYWZM/VoF9e3ja
         9nAU6YQaFwFL3d9hJutfmfKSgZQftcQAJJlPBn4gowYDDcu4lNqlgYGq8lBU+pri8dhG
         RV/4WCdeAvlTmNkbuK3tK9QbzEYooAG2VPsoea0WKhO1SjzTlkdQ1BIgqiacbUV+cWG2
         Os0kxOi/cEF8wFVVKw4q+iuDSI2f40BRDl8xpEkJZzsqPi4c2urm+ncefUGl7UZ6iDLj
         TQUw==
X-Gm-Message-State: AOJu0Yx0MSMDarcQoKO4KoIOk1IxFsE6ngrJ91f1NmNEHM6fXoYUwR4L
        Wy5UvOmHjsIaw5zWdE+BReo4VQ==
X-Google-Smtp-Source: AGHT+IHLOGhl4bJHL/Xz4jCazed5eiZOPI0yll6JNm9DpVnTJLrYtOWQyVMcyFeBMQutFUWKp5H61A==
X-Received: by 2002:a2e:b165:0:b0:2c0:23d3:daee with SMTP id a5-20020a2eb165000000b002c023d3daeemr8683153ljm.39.1696628373660;
        Fri, 06 Oct 2023 14:39:33 -0700 (PDT)
Received: from [192.168.200.173] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id p18-20020a2e9ad2000000b002b6cd89a3fcsm942283ljj.118.2023.10.06.14.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 14:39:33 -0700 (PDT)
Message-ID: <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
Date:   Fri, 6 Oct 2023 23:39:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
 <20230929205731.GA10357@monkey>
 <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231006030836.GC86415@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.10.2023 05:08, Mike Kravetz wrote:
> On 10/02/23 11:57, Konrad Dybcio wrote:
>>
>>
>> On 9/29/23 22:57, Mike Kravetz wrote:
>>> On 09/27/23 13:26, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 26.09.2023 01:48, Mike Kravetz wrote:
>>>>> Allocation of a hugetlb page for the hugetlb pool is done by the routine
>>>>> alloc_pool_huge_page.  This routine will allocate contiguous pages from
>>>>> a low level allocator, prep the pages for usage as a hugetlb page and
>>>>> then add the resulting hugetlb page to the pool.
>>>>>
>>>>> In the 'prep' stage, optional vmemmap optimization is done.  For
>>>>> performance reasons we want to perform vmemmap optimization on multiple
>>>>> hugetlb pages at once.  To do this, restructure the hugetlb pool
>>>>> allocation code such that vmemmap optimization can be isolated and later
>>>>> batched.
>>>>>
>>>>> The code to allocate hugetlb pages from bootmem was also modified to
>>>>> allow batching.
>>>>>
>>>>> No functional changes, only code restructure.
>>>>>
>>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>>>> ---
>>>> Hi, looks like this patch prevents today's next from booting
>>>> on at least one Qualcomm ARM64 platform. Reverting it makes
>>>> the device boot again.
>>>
>>> Can you share the config used and any other specific information such as
>>> kernel command line.
>> Later this week.
> 
> As mentioned, I have been unable to reproduce on arm64 platforms I can
> access.  I have tried various config and boot options.  While doing so,
> I came across one issue impacting kernels compiled without
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP defined.  This is not something
> that would prevent booting.
> 
> I will send out an updated version series in the hope that any other
> issues may be discovered.
I'm pushing the "later this week" by answering near end of calendar
day, Friday, but it seems like this patch in v7 still prevents the
device from booting..

You can find my defconfig at the link below.

https://gist.github.com/konradybcio/d865f8dc9b12a98ba3875ec5a9aac42e

Konrad
