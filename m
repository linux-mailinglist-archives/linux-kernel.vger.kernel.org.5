Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FE97BD83F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbjJIKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346076AbjJIKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:11:48 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA8FC5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:11:47 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c1854bebf5so54311051fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696846305; x=1697451105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGY0FBb36qCXjvr1NWROo1BhBbwPapXrgUBbbWrCwgg=;
        b=QeZdXfsNPx8u/sPSAGlKhnGSvbf1vVPlAd+KTo4MKXJRzKoA2ZI1zhIXO0gj2xBmIe
         to/nuJ3aJidZwz88KGvcFRYB4gtseZ8/58m+agzQz+Eex3PYzeSUwZZNKNcnMLWgSjou
         5ZHDTjYq6ETq+ghxS35aM0p5fu9NOf7eBpCd53uHN/m/5fcv11fY9BdtSIDneJbzq9OR
         6jzfR0QdOxP6kIdVMkLSPcqQboSWV7PJyncHMGqUzaV0xq17gWCynZm95MGrz72eR1gN
         ZfIL5jBx8pD4HphNzQgkKE97H1kMgX16qxOql43/ZkaMOch512HFw1F9mkojh9aHwalQ
         IamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846305; x=1697451105;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGY0FBb36qCXjvr1NWROo1BhBbwPapXrgUBbbWrCwgg=;
        b=cS45/p97rMaAIL89VRQndc8gBApEBQe8ELqtXxfceJMRgnsEvjTRMh1PUPJk/6ruN1
         1au49wwBM57MkicyE7f1Q/IlxxLNP8ANJUTo0VybfVY0xtZNYFKv96HEueTNUgBlS/r+
         K/jl8or0BH4W4qJ/nMEfZUBvhjRwFieUU8hSQ5FUP676tYTEC4VVWjz0rpqYcNiA3lzv
         7C97m24clx0cyHahQsRFDUcvT+j8vCtZLV57FHTn/HjtG+A0lsO0ur3JYkkl32amEiCD
         7kcZ64GRxK5HFXe+EV8bkawDwJlenA8++b1wybQdrbuxPOqnosdsNZztehFzbGryBku5
         3dkA==
X-Gm-Message-State: AOJu0YxvX1T2v66zh2iZgNv/EARkInEhZTwWhP9NfoSEfr7TObHBZP+1
        781P/EbL7iQcpAn/PArwVJ99XQ==
X-Google-Smtp-Source: AGHT+IF06qVhDrgVrjGhmjIW9BJWBQjOdsy3kHUarYO2CVraC19PXLzrv97AeJbJjiTBliTEWl/mgw==
X-Received: by 2002:a2e:3803:0:b0:2bc:fa8f:83c4 with SMTP id f3-20020a2e3803000000b002bcfa8f83c4mr12461404lja.39.1696846305151;
        Mon, 09 Oct 2023 03:11:45 -0700 (PDT)
Received: from [192.168.200.173] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id d17-20020a2e3311000000b002bcb9956a69sm2001771ljc.41.2023.10.09.03.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 03:11:44 -0700 (PDT)
Message-ID: <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
Date:   Mon, 9 Oct 2023 12:11:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
 <20231006223512.GC3861@monkey> <20231009032926.GA3376@monkey>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231009032926.GA3376@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.10.2023 05:29, Mike Kravetz wrote:
> On 10/06/23 15:35, Mike Kravetz wrote:
>> On 10/06/23 23:39, Konrad Dybcio wrote:
>>> On 6.10.2023 05:08, Mike Kravetz wrote:
>>>> On 10/02/23 11:57, Konrad Dybcio wrote:
>>>>>
>>>>>
>>>>> On 9/29/23 22:57, Mike Kravetz wrote:
>>>>>> On 09/27/23 13:26, Konrad Dybcio wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 26.09.2023 01:48, Mike Kravetz wrote:
>>>>>>>> Allocation of a hugetlb page for the hugetlb pool is done by the routine
>>>>>>>> alloc_pool_huge_page.  This routine will allocate contiguous pages from
>>>>>>>> a low level allocator, prep the pages for usage as a hugetlb page and
>>>>>>>> then add the resulting hugetlb page to the pool.
>>>>>>>>
>>>>>>>> In the 'prep' stage, optional vmemmap optimization is done.  For
>>>>>>>> performance reasons we want to perform vmemmap optimization on multiple
>>>>>>>> hugetlb pages at once.  To do this, restructure the hugetlb pool
>>>>>>>> allocation code such that vmemmap optimization can be isolated and later
>>>>>>>> batched.
>>>>>>>>
>>>>>>>> The code to allocate hugetlb pages from bootmem was also modified to
>>>>>>>> allow batching.
>>>>>>>>
>>>>>>>> No functional changes, only code restructure.
>>>>>>>>
>>>>>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>>>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>>>>>>> ---
>>>>>>> Hi, looks like this patch prevents today's next from booting
>>>>>>> on at least one Qualcomm ARM64 platform. Reverting it makes
>>>>>>> the device boot again.
>>>>>>
>>>>>> Can you share the config used and any other specific information such as
>>>>>> kernel command line.
>>>>> Later this week.
>>>>
>>>> As mentioned, I have been unable to reproduce on arm64 platforms I can
>>>> access.  I have tried various config and boot options.  While doing so,
>>>> I came across one issue impacting kernels compiled without
>>>> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP defined.  This is not something
>>>> that would prevent booting.
>>>>
>>>> I will send out an updated version series in the hope that any other
>>>> issues may be discovered.
>>> I'm pushing the "later this week" by answering near end of calendar
>>> day, Friday, but it seems like this patch in v7 still prevents the
>>> device from booting..
>>>
>>> You can find my defconfig at the link below.
>>>
>>> https://gist.github.com/konradybcio/d865f8dc9b12a98ba3875ec5a9aac42e
>>>
>>
>> Thanks!
>>
>> I assume there is no further information such as any console output?
>> Did any of you other arm64 platforms have this issue?
>>
>> Just trying to get as much information as possible to get to root cause.
> 
> I have not had success isolating the issue with your config file.
> 
> Since the only code changes in this patch deal with allocating hugetlb
> pages, I assume this is what you are doing?  Can you let me know how you
> are performing the allocations?  I assume it is on the kernel command
> line as these would be processed earliest in boot.
> 
> If you are not allocating hugetlb pages, then I need to think of what
> else may be happening.
> 
> Anshuman, any chance you (or someone else with access to arm64 platforms)
> could throw this on any platforms you have access to for a quick test?
I managed to get a boot log:

https://pastebin.com/GwurpCw9

This is using arch/arm64/boot/dts/qcom/sm8550-mtp.dts for reference

Konrad
