Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977987BD849
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbjJIKNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346126AbjJIKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:13:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCE810E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:13:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c296e6543fso51961221fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696846388; x=1697451188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JqQ5zQ6ECYAmmpDo72jgHZOz40QeybctD1U2kLPy1O8=;
        b=aoda3BbzlawgWWHRi1ugKfNaJV3H6pyKu/0/qed7wLsoek58kODKMR2YR0hBUS4M8i
         WX8n8AkyKGv2QPVsgrILpIWJuemyy4GM6+5KyzeUKOFcy8ygXhxN2+aq9PHkV0He9bo0
         wrEHpPgG5ctY9jHHWhABcSLYbx9bnnA+xDYYBxpaTjEEuJhTWg6f7igZ5MkLNdcZEme2
         yP8F+xJ8uTwChZtMc9BUMnTzPFFai2fSGZdRJwBR1c3QAQBgMYqsXgoCZ7adpX4GBp5S
         ziY3b3ap1B9YMUcF1Lt8pmKJWmNOExZZuXlHzuz+Do0jr/MjsQG9+mW0SR1dF8uf/H1u
         E81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846388; x=1697451188;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqQ5zQ6ECYAmmpDo72jgHZOz40QeybctD1U2kLPy1O8=;
        b=tG87f0jN0q2UXm6EzSGI1xs+ALN3aKmF5aHrGp5d8DwnGypS4bpw7krG7zFeWZOmb+
         pyxDYm/d9YsfhpjBGg8F4DLmDyVTKo0QMHo4ACRUYEWOHZXIPcX5DS+PavJfMOTusM3y
         Thhey0bvc6GXi+TM5ZOvmIpQ6E2PfluSUfANTimiGUTtv3x7qktsqsoFIPWTPHzPMjBJ
         kLB4MBTH78CEQRPgLdLOT0PtNtEx4nAn5AI35TOBDuA32+FbDPB7Rp9/sfDpP97Hd0Pr
         3hsjO2x5t6RdTcsT+LcgqycrU0rCtGVq7fIk+ONcf7uKmFKsoiPXnb00fYWQ/dJMToLW
         iyAg==
X-Gm-Message-State: AOJu0YzLqso62/toTOsTerWIOBTh2gee+95RK54KZlNDcKKg+9ybvFCv
        6MER/3Ixn9T6GhvofMWox9LtZQ==
X-Google-Smtp-Source: AGHT+IGJNv+goN2/JYgcGmX8ZRHbcgKjankBybuB7dZZjNcFZLuLOaw4dpkZ3dE9kBuUbXS8DgB+gA==
X-Received: by 2002:a2e:b0d6:0:b0:2bd:180d:67b7 with SMTP id g22-20020a2eb0d6000000b002bd180d67b7mr12785433ljl.40.1696846387591;
        Mon, 09 Oct 2023 03:13:07 -0700 (PDT)
Received: from [192.168.200.173] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id d17-20020a2e3311000000b002bcb9956a69sm2001771ljc.41.2023.10.09.03.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 03:13:07 -0700 (PDT)
Message-ID: <8e4409a3-ac33-4740-8447-57dc5ac25a88@linaro.org>
Date:   Mon, 9 Oct 2023 12:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Content-Language: en-US
To:     Jane Chu <jane.chu@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
 <ffc9ace3-377e-27ef-2f48-ddeef2a27529@oracle.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ffc9ace3-377e-27ef-2f48-ddeef2a27529@oracle.com>
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

On 7.10.2023 03:51, Jane Chu wrote:
> Hi, Konrad,
> 
> Just wondering, is your arm64 system a VM instance, or a bare metal?
That's a tricky question :)

Qualcomm platforms expose much of the hardware in a manner that's
similar to a VM, there's an extensive irreplaceable hypervisor in
place and the user can only boot Linux at EL1..

So, I guess the answer here is "somewhat bare metal" :/

Konrad
> 
> thanks!
> -jane
> 
> 
> On 10/6/2023 2:39 PM, Konrad Dybcio wrote:
>> On 6.10.2023 05:08, Mike Kravetz wrote:
>>> On 10/02/23 11:57, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 9/29/23 22:57, Mike Kravetz wrote:
>>>>> On 09/27/23 13:26, Konrad Dybcio wrote:
>>>>>
> [..]
>>> I will send out an updated version series in the hope that any other
>>> issues may be discovered.
>> I'm pushing the "later this week" by answering near end of calendar
>> day, Friday, but it seems like this patch in v7 still prevents the
>> device from booting..
>>
>> You can find my defconfig at the link below.
>>
>> https://gist.github.com/konradybcio/d865f8dc9b12a98ba3875ec5a9aac42e
>>
>> Konrad
>>
