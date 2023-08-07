Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1847377184A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 04:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjHGCWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 22:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjHGCWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 22:22:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F7E172D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 19:21:39 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bbb7c3d0f5so8441015ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 19:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691374899; x=1691979699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qb/leLE6aCOZIBr9r1JYx3TvNlqeON7iS6luW38r5Jc=;
        b=MhFGNTSsO4+QWxRK82qumq9rIgYUhYdEtWtmsu+iSWZuXBlQH+Jx6RKgdZZFO06ThW
         G37Ma8brGBJxWF7UkJspgflGUQaJiZaxjvDyaz18XUG2U/LCOEUXLV+VmlcLXZOvnMmj
         nyLtb+JMK+VKyjFzRaHEMnMfg4ALVrMpUaU+83cfjao+bENXCNlVA8puNic5zPPgRXMj
         uJ19xY0Zt3h4aHO3jHr8IVHButtjHyG9SS5gdQy8Dfh5p+amv6EvjCKVeeW5NrJTjjun
         r34wfS65FaM+UZvBU/e2i5dptVB1aCzmSDwymThGl45g7FJSqbN87dmAD07OZaTzgSR+
         b51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691374899; x=1691979699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb/leLE6aCOZIBr9r1JYx3TvNlqeON7iS6luW38r5Jc=;
        b=hFDBHWa2618hFMKecHJTLjs2h4MJrO2krhxc7/LSv7FgQL/HBfi6H7AKvVWPxzJPJi
         JkdYHCxWAel9XAE1NEVXKt81607rh15hydeEnXZk91VhAUeyoljtiCckQ15P2ravsAS7
         yOx/XLbSl6VT8Eq61sGgv+SznB/9dsxSKC7f9ao3q7E4S01I84qinU5Ne3c00aqQKmtU
         yEfgcgTwVPBv3Xe9eL2EOGjsiUgPqHh3F1Tp8SpzUHCgmZSFwldNw7hS2ZIgw9yo0vbJ
         ytFAM5w+HSq+KnjUDHZyIKq7uD8mUlwo3AVA3+eXFmSOErwjyiDx8QXN1HgX77sJFV/0
         YvTA==
X-Gm-Message-State: ABy/qLZzCXPuY0ywOE993FEe0NZ0OyZMNOvZGTb3NYOk82jRvdLDZPWK
        bBigYfjaQQtpB5dWmgAJOjNfKA==
X-Google-Smtp-Source: APBJJlGpQC/bZc7PkKBaCqakVv3f0BQCW9VbmoYUUceaU6MBY9H2NMC4vSDtjENAGMgNRiun6LJ2JA==
X-Received: by 2002:a17:902:ce92:b0:1b8:1591:9f81 with SMTP id f18-20020a170902ce9200b001b815919f81mr31962617plg.4.1691374898719;
        Sun, 06 Aug 2023 19:21:38 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902cf4600b001ac5896e96esm5514361plg.207.2023.08.06.19.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 19:21:37 -0700 (PDT)
Message-ID: <3403e5d3-e840-cea7-1863-b6b9ab7ecae0@bytedance.com>
Date:   Mon, 7 Aug 2023 10:21:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 10/13] mm/khugepaged: collapse_pte_mapped_thp() with
 mmap_read_lock()
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <7cd843a9-aa80-14f-5eb2-33427363c20@google.com>
 <b53be6a4-7715-51f9-aad-f1347dcb7c4@google.com>
 <0df84f9f-e9b0-80b1-4c9e-95abc1a73a96@bytedance.com>
 <884f20fe-d642-3a5f-522a-d756c3443bb4@google.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <884f20fe-d642-3a5f-522a-d756c3443bb4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/6 11:55, Hugh Dickins wrote:
> On Thu, 3 Aug 2023, Qi Zheng wrote:
>> On 2023/7/12 12:42, Hugh Dickins wrote:
>>> Bring collapse_and_free_pmd() back into collapse_pte_mapped_thp().
>>> It does need mmap_read_lock(), but it does not need mmap_write_lock(),
>>> nor vma_start_write() nor i_mmap lock nor anon_vma lock.  All racing
>>> paths are relying on pte_offset_map_lock() and pmd_lock(), so use those.
> ...
>>> @@ -1681,47 +1634,76 @@ int collapse_pte_mapped_thp(struct mm_struct *mm,
>>> unsigned long addr,
>>>    
>>>      if (pte_none(ptent))
>>>    			continue;
>>> -		page = vm_normal_page(vma, addr, ptent);
>>> -		if (WARN_ON_ONCE(page && is_zone_device_page(page)))
>>> +		/*
>>> +		 * We dropped ptl after the first scan, to do the
>>> mmu_notifier:
>>> +		 * page lock stops more PTEs of the hpage being faulted in,
>>> but
>>> +		 * does not stop write faults COWing anon copies from existing
>>> +		 * PTEs; and does not stop those being swapped out or
>>> migrated.
>>> +		 */
>>> +		if (!pte_present(ptent)) {
>>> +			result = SCAN_PTE_NON_PRESENT;
>>>    			goto abort;
>>> +		}
>>> +		page = vm_normal_page(vma, addr, ptent);
>>> +		if (hpage + i != page)
>>> +			goto abort;
>>> +
>>> +		/*
>>> +		 * Must clear entry, or a racing truncate may re-remove it.
>>> +		 * TLB flush can be left until pmdp_collapse_flush() does it.
>>> +		 * PTE dirty? Shmem page is already dirty; file is read-only.
>>> +		 */
>>> +		pte_clear(mm, addr, pte);
>>
>> This is not non-present PTE entry, so we should call ptep_clear() to let
>> page_table_check track the PTE clearing operation, right? Otherwise it
>> may lead to false positives?
> 
> You are right: thanks a lot for catching that: fix patch follows.

With fix patch:

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

Thanks.

> 
> Hugh
