Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D47AAEF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjIVJ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIVJ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:58:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84E19C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:58:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-273d9b1908eso425637a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695376705; x=1695981505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=glhbcKHlOJ++dI91Fd232eTIXjHqf2bx1O8BgYp5lCc=;
        b=CW9CowE6eFGkLbIno5FWgUMiI7oGMBE16mxr5llVZvF34xDmi62V9zvg2Mu8isfB6Z
         YKocuRLIZICNayJNLGPz6o7Mba3iMnDofdPv07+MGEhuIq3UKiFgqV9Y7Ji1F8ej2auN
         tyHGzFwcMjaotBlo8OAvz4wwp+zdn/SS19BTKJXaAJhcU0f1DYqMaS25UrppHAtjFcdX
         5dhG8G5pca9BhgnMiwjVYwtyfqCJcNwvffXB5IM8XGbGk2aTvncsBJ1PBt9oTFXRYD6B
         GEkVjpqk0OU1dJ2oKBvjKUB244NGuvdtPBkPvAqrE1wXJYmZjSeRMlGSNu/smKUBtRFJ
         zdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695376705; x=1695981505;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glhbcKHlOJ++dI91Fd232eTIXjHqf2bx1O8BgYp5lCc=;
        b=Aw+d0ZC9SSy8d9sTN9AZR4eY1aFl6G+T9ob0pdCWQtxP6yh70PTmNSyz6s3BGo2UoQ
         Iq9yFoNCGa5FvTVDArZJmH+PSAZ/CdT4Cgkyb1xg+jb3/qcOxsnB0fC2//1Z9BCJqCHh
         sy3a4/codykfqiSeFk73ckNou25xMwvWU0kQLbbmmdGkKZ1/8hVE9NxfAlXvIhXKXN13
         HhnQdzdkVZejzLCIpYPoxazYzrSE7gJJNcHiijmGuUnWxgFh4pxPH+iO82XeqJDUSrZI
         nxF5lRujiaw//pxsezhI61EO6YFVVaQOER1Sd4VQFeAf999hFGOMEMQGz5FiVJlJkT5L
         8EgQ==
X-Gm-Message-State: AOJu0YzfocRhbu1VWM1xgvHK4Accp0AkLXEAv2du6Fb3wuDqLB9ExztB
        LNZ/Jq37sT/xFo0Z2HnWVzKgRA==
X-Google-Smtp-Source: AGHT+IEAmOaW7qH1FQ4rMNYW5X5iaduW//iDAeulAsmjkwRxSd+P25fgKl/VoNi7DW4NKppwZJBueA==
X-Received: by 2002:a17:90a:674b:b0:25c:1ad3:a4a1 with SMTP id c11-20020a17090a674b00b0025c1ad3a4a1mr7316585pjm.1.1695376705244;
        Fri, 22 Sep 2023 02:58:25 -0700 (PDT)
Received: from [10.84.155.178] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id lt22-20020a17090b355600b00276d039aecasm2933526pjb.13.2023.09.22.02.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 02:58:24 -0700 (PDT)
Message-ID: <41b6524a-effe-c600-962c-2b6e32526dc8@bytedance.com>
Date:   Fri, 22 Sep 2023 17:58:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 8/8] arm64: hugetlb: Fix set_huge_pte_at() to work with
 all swap entries
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
References: <20230921162007.1630149-1-ryan.roberts@arm.com>
 <20230921162007.1630149-9-ryan.roberts@arm.com>
 <217bb956-b9f6-1057-914b-436d4c775a8b@bytedance.com>
 <3358e732-8df9-4408-8249-384b102f5d75@arm.com>
 <6db7e7e0-4db6-f742-436b-1f4d8ae4e490@bytedance.com>
 <9e8d66fb-1d8d-4ce0-86a7-4c8b04557cca@arm.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <9e8d66fb-1d8d-4ce0-86a7-4c8b04557cca@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On 2023/9/22 17:35, Ryan Roberts wrote:
> On 22/09/2023 08:54, Qi Zheng wrote:
>> Hi Ryan,
>>
>> On 2023/9/22 15:40, Ryan Roberts wrote:
>>> On 22/09/2023 03:54, Qi Zheng wrote:
>>>> Hi Ryan,
>>>>
>>>> On 2023/9/22 00:20, Ryan Roberts wrote:
>>>>> When called with a swap entry that does not embed a PFN (e.g.
>>>>> PTE_MARKER_POISONED or PTE_MARKER_UFFD_WP), the previous implementation
>>>>> of set_huge_pte_at() would either cause a BUG() to fire (if
>>>>> CONFIG_DEBUG_VM is enabled) or cause a dereference of an invalid address
>>>>> and subsequent panic.
>>>>>
>>>>> arm64's huge pte implementation supports multiple huge page sizes, some
>>>>> of which are implemented in the page table with contiguous mappings. So
>>>>> set_huge_pte_at() needs to work out how big the logical pte is, so that
>>>>> it can also work out how many physical ptes (or pmds) need to be
>>>>> written. It does this by grabbing the folio out of the pte and querying
>>>>> its size.
>>>>>
>>>>> However, there are cases when the pte being set is actually a swap
>>>>> entry. But this also used to work fine, because for huge ptes, we only
>>>>> ever saw migration entries and hwpoison entries. And both of these types
>>>>> of swap entries have a PFN embedded, so the code would grab that and
>>>>> everything still worked out.
>>>>>
>>>>> But over time, more calls to set_huge_pte_at() have been added that set
>>>>> swap entry types that do not embed a PFN. And this causes the code to go
>>>>> bang. The triggering case is for the uffd poison test, commit
>>>>> 99aa77215ad0 ("selftests/mm: add uffd unit test for UFFDIO_POISON"),
>>>>> which sets a PTE_MARKER_POISONED swap entry. But review shows there are
>>>>> other places too (PTE_MARKER_UFFD_WP).
>>>>>
>>>>> So the root cause is due to commit 18f3962953e4 ("mm: hugetlb: kill
>>>>> set_huge_swap_pte_at()"), which aimed to simplify the interface to the
>>>>> core code by removing set_huge_swap_pte_at() (which took a page size
>>>>> parameter) and replacing it with calls to set_huge_swap_pte_at() where
>>>>> the size was inferred from the folio, as descibed above. While that
>>>>> commit didn't break anything at the time,
>>>>
>>>> If it didn't break anything at that time, then shouldn't the Fixes tag
>>>> be added to this commit?
>>>>
>>>>> it did break the interface
>>>>> because it couldn't handle swap entries without PFNs. And since then new
>>>>> callers have come along which rely on this working.
>>>>
>>>> So the Fixes tag should be added only to the commit that introduces the
>>>> first new callers?
>>>
>>> Well I guess it's a matter of point of view; My view is that 18f3962953e4 is the
>>> buggy change because it broke the interface to not be able to handle swap
>>> entries which do not contain PFNs. The fact that there were no callers that used
>>> the interface in this way at the time of the commit is irrelevant in my view.
>>
>> I understand your point of view.
>>
>> But IIUC, the Fixes tag is used to indicate the version that needs to
>> backport, but the version where the commit 18f3962953e4 is located
>> does not need to backport this bugfix patch.
>>
>>> But I already added 2 fixes tags; one for the buggy commit, and the other for
>>> the commit containing the new user of the interface.
>>
>> I think 2 fixes tags will cause inconvenience to the maintainers.
>>
> 
> I did some Archaeology:

Nice! Thanks for doing this.

> 
> $ git rev-list --no-walk=sorted --pretty=oneline \
> 	05e90bd05eea33fc77d6b11e121e2da01fee379f \
> 	60dfaad65aa97fb6755b9798a6b3c9e79bcd5930 \
> 	8a13897fb0daa8f56821f263f0c63661e1c6acae \
> 	18f3962953e40401b7ed98e8524167282c3e626e \
> 	v6.5 v5.18 v5.17 v5.19 v6.5-rc6 v6.5-rc7
> 
> 2dde18cd1d8fac735875f2e4987f11817cc0bc2c Linux 6.5
> 706a741595047797872e669b3101429ab8d378ef Linux 6.5-rc7
> 8a13897fb0daa8f56821f263f0c63661e1c6acae mm: userfaultfd: support UFFDIO_POISON for hugetlbfs
> 2ccdd1b13c591d306f0401d98dedc4bdcd02b421 Linux 6.5-rc6
> 3d7cb6b04c3f3115719235cc6866b10326de34cd Linux 5.19
> 18f3962953e40401b7ed98e8524167282c3e626e mm: hugetlb: kill set_huge_swap_pte_at()
> 4b0986a3613c92f4ec1bdc7f60ec66fea135991f Linux 5.18
> 05e90bd05eea33fc77d6b11e121e2da01fee379f mm/hugetlb: only drop uffd-wp special pte if required
> 60dfaad65aa97fb6755b9798a6b3c9e79bcd5930 mm/hugetlb: allow uffd wr-protect none ptes
> f443e374ae131c168a065ea1748feac6b2e76613 Linux 5.17
> 
> 
> So it turns out that the PTE_MARKER_UFFD_WP markers were added first, using
> set_huge_pte_at(). At the time, this should have used set_huge_swap_pte_at(), so
> was arguably buggy for that reason. However, arm64 does not support UFFD_WP so
> none of the call sites that set the PTE_MARKER_UFFD_WP marker to the pte ever
> trigger on arm64.
> 
> Then "mm: hugetlb: kill set_huge_swap_pte_at()" came along and "broke" the
> interface, but there were no callers relying on the behavoir that was broken.
> 
> Then "mm: userfaultfd: support UFFDIO_POISON for hugetlbfs" came along in
> v6.5-rc7 and started relying on the broken behaviour of set_huge_pte_at().

Got it.

> 
> So on that basis, I agree that the first commit where broken behaviour is
> observable is "mm: userfaultfd: support UFFDIO_POISON for hugetlbfs". So I will
> tag that one as "Fixes". (Although if set_huge_pte_at() was an exported symbol,
> then we would want to mark "mm: hugetlb: kill set_huge_swap_pte_at()").

Agree. I just checked the time point when 18f3962953e4 was added,
neither set_huge_pte_at() nor set_huge_swap_pte_at() are exported
symbols.

Thanks,
Qi

> 
> Thanks,
> Ryan
> 
> 
> 
> 
>> Thanks,
>> Qi
>>
>>>
>>>>
>>>> Other than that, LGTM.
>>>
>>> Thanks!
>>>
>>>>
>>>> Thanks,
>>>> Qi
>>>>
