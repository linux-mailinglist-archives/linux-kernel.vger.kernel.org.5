Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28CF7BEC5F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378196AbjJIVKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJIVKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:10:00 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A2AA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:09:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50307acd445so6230781e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696885797; x=1697490597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TU4GqFpyKx+szQTs3GpdZdYoNMAHrbMfWPpl7iHi/E=;
        b=EEbjKbKfOI+JEupvi39YiEi2dEcMKiqkw0fkO45G9ymhtTtsr3CQ6Wa3I/QCOqEu49
         CMswqgfSxA0Sa24KTFMKOPG6NfL0u7kSqW/ksWW//iEQB2Ma5IHb+C4947bOzJ0gKAeR
         B81QGsY+tmhxfCRFHvOWKnsKsWvJlsi/iAU0UaQRAl293wawWS/fu6Q5NG9cTQDkOsZc
         jBgXt5G1+hlGS1nMw5y0S2r5r+P4LR7XGJqsp7vfkip0ttlvzMTmkZKoL9GnRtYbTwzk
         RVbX5SA6BZb8q3zag4KJ+R+ps3pFMxYQUSJ87+QwfLXtHMXCXHflIOK71Uk0ogvMWGAw
         CCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885797; x=1697490597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TU4GqFpyKx+szQTs3GpdZdYoNMAHrbMfWPpl7iHi/E=;
        b=ezpPxJ6aQFCKGe1CFsQAS189WgU1t90hw+xmkxexIaih8NlyerLqrg3dB3GLTquMc6
         tAql+8pAkNnKoeLBXFlwo1cnB5JQ4iSXbzqEqX9KKCxoY43wnWRbmE2EdX2W0VwdK4O3
         FLTh/bgQk6P5sAinOu5ugWETRYVXHojONuvsJnP5iIwdDO9DT9OQfvd3KIUDnsEyuYZh
         kaPr89M5SglLw02BR8l5SVGJbG2MnsX2R/J1mIWnZcztwqb7RmmEtZno9BLQeT9otUc9
         FwcY3gA5zkT2a6vi0JSfqpyPr5qGSXc2x14mJRHRBfxiWIrMCukJawXWHg9mVQZeJJ99
         w9Yg==
X-Gm-Message-State: AOJu0YwYquw0iiL1KxNwz9mxIMVcZdrmH3YSFR4+62DqSECa4dQ9GGwc
        puYnzXQch6WkB5fltd+u3hT9Wg==
X-Google-Smtp-Source: AGHT+IGwECwTllJuzDm281Ve4ATbJY/7Wftg82qOVyDB+KpdpskIxF5YLycq0aHOuDixXp0dy01Xmw==
X-Received: by 2002:a19:2d14:0:b0:505:84c8:c640 with SMTP id k20-20020a192d14000000b0050584c8c640mr14717972lfj.48.1696885796954;
        Mon, 09 Oct 2023 14:09:56 -0700 (PDT)
Received: from [172.30.204.90] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q10-20020ac25a0a000000b004ff8cd27a61sm1532825lfn.213.2023.10.09.14.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:09:56 -0700 (PDT)
Message-ID: <0343c1d5-8706-4cf8-a17e-25ab27f654d8@linaro.org>
Date:   Mon, 9 Oct 2023 23:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
 <20231009150401.GA3846@monkey> <20231009151513.GB3846@monkey>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231009151513.GB3846@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 17:15, Mike Kravetz wrote:
> On 10/09/23 08:04, Mike Kravetz wrote:
>> On 10/09/23 12:11, Konrad Dybcio wrote:
>>> On 9.10.2023 05:29, Mike Kravetz wrote:
>>>> On 10/06/23 15:35, Mike Kravetz wrote:
>>>>> On 10/06/23 23:39, Konrad Dybcio wrote:
>>>>>> On 6.10.2023 05:08, Mike Kravetz wrote:
>>>>>>> On 10/02/23 11:57, Konrad Dybcio wrote:
>>>>>>>> On 9/29/23 22:57, Mike Kravetz wrote:
>>>>>>>>> On 09/27/23 13:26, Konrad Dybcio wrote:
>>>>>>>>>> On 26.09.2023 01:48, Mike Kravetz wrote:
>>>
>>> I managed to get a boot log:
>>>
>>> https://pastebin.com/GwurpCw9
>>>
>>> This is using arch/arm64/boot/dts/qcom/sm8550-mtp.dts for reference
>>>
>>
>> Early on in boot log before the panic, I see this in the log:
>>
>> [    0.000000] efi: UEFI not found.
>> [    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!
>>
>> Isn't that misalignment pretty serious?  Or, is is possible to run with that?
>>
>> There are no hugetlb pages allocated at boot time:
>>
>> [    0.000000] Kernel command line: PMOS_NO_OUTPUT_REDIRECT console=ttyMSM0 earlycon clk_ignore_unused pd_ignore_unused androidboot.bootdevice=1d84000.ufshc androidboot.fstab_suffix=default androidboot.boot_devices=soc/1d84000.ufshc androidboot.serialno=ab855d8d androidboot.baseband=msm
>>
>> So, the routine where we are panic'ing (gather_bootmem_prealloc) should be a
>> noop.  The first thing it does is:
>> list_for_each_entry(m, &huge_boot_pages, list) {
>> ...
>> }
>>
>> However, huge_boot_pages should be empty as initialized here:
>> __initdata LIST_HEAD(huge_boot_pages);
>>
>> At the end of the routine, we call prep_and_add_bootmem_folios to
>> process the local list created withing that above loop:
>>
>> LIST_HEAD(folio_list);
>>
>> This should also be empty and a noop.
>>
>> Is it possible that the misaligned kernel image could make these lists
>> appear as non-empty?
> 
> Actually, just saw this:
> 
> https://lore.kernel.org/linux-mm/20231009145605.2150897-1-usama.arif@bytedance.com/
> 
> Will take a look, although as mentioned above prep_and_add_bootmem_folios on
> an empty list should be a noop.
I'll try it out atop the series tomorrow or so.

Konrad
