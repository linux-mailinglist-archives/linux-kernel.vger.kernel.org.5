Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97A47BEC5B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378636AbjJIVJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378544AbjJIVJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:09:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045A193
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:09:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5033918c09eso6237581e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696885767; x=1697490567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IiSyutlj5hKsgZu9TjtxdqL8EqTC57J6Z1fzt7VVinc=;
        b=s9noSNrDhJu0B9Ojljk2Ehm/pBHUelSlrewmkw36haDpfiAjvyUUCu9x4KFQlDQ17N
         p+eHQdTrsDyooabr/azKIwMbita0VN0ggttXH5Ec+YGEfmzLxOU3pPHG1SNTzjuhK/e7
         Ux96R+RHnA/oshkR6CLl8fyKqfSkxOsF2j7Wo0x1q0t3vk5v/fqQNv8QP2njoXxypoGm
         w0oYJ6/cDcxcS3JUs6ZaVOHkf9bqiPVEmgL2Y8Mb4HkWU4QyjQNz0GtHn0w4xnQ1/4A8
         znB5QH5dB/DHeT5++fItR4iIdVLzyAMHgue5pgVxUKDKvaKvZeh3WsMwJABcx9EgjRmY
         4JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885767; x=1697490567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiSyutlj5hKsgZu9TjtxdqL8EqTC57J6Z1fzt7VVinc=;
        b=TWKDuZE2RG34HKU2tbTMAb5u3wSt7+h9aC0rvR1bHswv2LgGY8lzTdsrm6gK4okIx/
         TChdDT15lNJKIHC07YeWpDxSPYB27oiNyLtAq7Y0qVtgyV2YHKgV1qciInAeVlrv5+xy
         ROpdEZgqhoKBLJaCecJKiDnxwRUykrY5jWmGWf2JiC1oKvpWnhXm+UUd/wha0tDgM+oo
         +xVqHmrMDmd3BUW6HIUBqZE8wGKNym6r1ozMsQCRPtBPbPuMRmHQijlxpj1IgeK4GfT6
         61uBLN0yuFZPJTi3GN8T92RlRN9LLa9rHVZyzBV9wmx0lIJ9PQzpQag4JagZLiEUwJj5
         OwyA==
X-Gm-Message-State: AOJu0YxFx0Qyfn3RyvFJrhUx2PbxrNFaKAkfw2y+Vz/aZ5YqhyqC0vtT
        kE0OFIMj8QGjsSsCNoCOiHFujw==
X-Google-Smtp-Source: AGHT+IG1jrmsBDXkKT12AXrUX0fq8OnWsuOFfcH0l/cgALQzx5fyAZJXnsk9jgtUPLIfJU7oMism4A==
X-Received: by 2002:a05:6512:3b9d:b0:506:9c0a:17cc with SMTP id g29-20020a0565123b9d00b005069c0a17ccmr3256164lfv.33.1696885767150;
        Mon, 09 Oct 2023 14:09:27 -0700 (PDT)
Received: from [172.30.204.90] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q10-20020ac25a0a000000b004ff8cd27a61sm1532825lfn.213.2023.10.09.14.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:09:26 -0700 (PDT)
Message-ID: <a24c4255-1e69-40af-b553-7862908a0a6a@linaro.org>
Date:   Mon, 9 Oct 2023 23:09:25 +0200
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
 <20231009150401.GA3846@monkey>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231009150401.GA3846@monkey>
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



On 10/9/23 17:04, Mike Kravetz wrote:
> On 10/09/23 12:11, Konrad Dybcio wrote:
>> On 9.10.2023 05:29, Mike Kravetz wrote:
>>> On 10/06/23 15:35, Mike Kravetz wrote:
>>>> On 10/06/23 23:39, Konrad Dybcio wrote:
>>>>> On 6.10.2023 05:08, Mike Kravetz wrote:
>>>>>> On 10/02/23 11:57, Konrad Dybcio wrote:
>>>>>>> On 9/29/23 22:57, Mike Kravetz wrote:
>>>>>>>> On 09/27/23 13:26, Konrad Dybcio wrote:
>>>>>>>>> On 26.09.2023 01:48, Mike Kravetz wrote:
>>
>> I managed to get a boot log:
>>
>> https://pastebin.com/GwurpCw9
>>
>> This is using arch/arm64/boot/dts/qcom/sm8550-mtp.dts for reference
>>
> 
> Early on in boot log before the panic, I see this in the log:
> 
> [    0.000000] efi: UEFI not found.
> [    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!
> 
> Isn't that misalignment pretty serious?  Or, is is possible to run with that?
That has never caused any issues and sadly I can't do anything about it.

> 
> There are no hugetlb pages allocated at boot time:
> 
> [    0.000000] Kernel command line: PMOS_NO_OUTPUT_REDIRECT console=ttyMSM0 earlycon clk_ignore_unused pd_ignore_unused androidboot.bootdevice=1d84000.ufshc androidboot.fstab_suffix=default androidboot.boot_devices=soc/1d84000.ufshc androidboot.serialno=ab855d8d androidboot.baseband=msm
> 
> So, the routine where we are panic'ing (gather_bootmem_prealloc) should be a
> noop.  The first thing it does is:
> list_for_each_entry(m, &huge_boot_pages, list) {
> ...
> }
> 
> However, huge_boot_pages should be empty as initialized here:
> __initdata LIST_HEAD(huge_boot_pages);
> 
> At the end of the routine, we call prep_and_add_bootmem_folios to
> process the local list created withing that above loop:
> 
> LIST_HEAD(folio_list);
> 
> This should also be empty and a noop.
> 
> Is it possible that the misaligned kernel image could make these lists
> appear as non-empty?
I don't think I have an answer for this

Konrad
