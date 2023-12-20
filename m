Return-Path: <linux-kernel+bounces-6832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB27819E37
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C7F282F82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E3B2137D;
	Wed, 20 Dec 2023 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUzU649W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868421374
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703072193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8BchaCDmzeoxVU55kJ2u51V6cvoLkYsea8CRw1NRe74=;
	b=eUzU649WVgdEIcd6/wujldVInyQi2PYcS9RS5rvPZFHzIhtZUYVft5erX8RBYDiRIGUwJy
	1U85CFQY2I011dXE/4bojIKH/ZXepw3fk0UenvnijbeJErOBKORjFlWn6dFUd1cfN3M7NI
	r53w7sU3qh2Z2HCgFMUjL+PVJGSJyy4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-PceKEST0MGCqSXfQrOqfTg-1; Wed, 20 Dec 2023 06:36:32 -0500
X-MC-Unique: PceKEST0MGCqSXfQrOqfTg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-336628333caso2533402f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703072191; x=1703676991;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BchaCDmzeoxVU55kJ2u51V6cvoLkYsea8CRw1NRe74=;
        b=Y4qHGjfqpUkBvyo3WZwCkXaoO54m69mqT0ddJz+0C9ZPqFlnAAwb3htR1Lvj/8qX4e
         TUOtJGv4hQgQu93H+q6cjwDyNmJAbCSoflcIwtMuCBcZCdsiRUqA8+8L8UIRJl0h5mtp
         G2Q9D+50vmxxjNHSqF3rjxibFJkN9vXKnEIfyXX98pNqGMmUsUHQCnmwS7QkdDP13cjV
         3HBB1Y8azOx+F37QAQS6UQVAYjrSuvqu+0DpY6gvh0v0XqgbwBGYYES7ff512eBhR9zI
         W++HAOOrp0C5m6sGLVsCorx9lj3t3a3U51aT8Rm3H9EpNbHSWalpe2DIMGlnQFJFlFQt
         BJTg==
X-Gm-Message-State: AOJu0YwQ2SzZPT8fO1X4flZutNxusfsJute0ONbJANRwc7u5zu3+ybj3
	mztX+SaMl4NSLu4xsQKYMqZI+znZYBvx2VMNzroPV/MZczIZUzIgPU11/epMHmTCqUhIXEcfiUu
	QsO2CgXl+IrTbxmZnppMcR+Ne
X-Received: by 2002:adf:f50c:0:b0:336:4ba9:e2b3 with SMTP id q12-20020adff50c000000b003364ba9e2b3mr4634193wro.58.1703072190584;
        Wed, 20 Dec 2023 03:36:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdFj4P5mxD5K32DTUMRVCnPewCMggzPF2DgitvHwewgtK8rhmT++/56nZIg6X0cY15VVZlRA==
X-Received: by 2002:adf:f50c:0:b0:336:4ba9:e2b3 with SMTP id q12-20020adff50c000000b003364ba9e2b3mr4634186wro.58.1703072190032;
        Wed, 20 Dec 2023 03:36:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:eb00:8e25:6953:927:1802? (p200300cbc73beb008e25695309271802.dip0.t-ipconnect.de. [2003:cb:c73b:eb00:8e25:6953:927:1802])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d4b83000000b00336660534e9sm9035418wrt.12.2023.12.20.03.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 03:36:29 -0800 (PST)
Message-ID: <2a8c5b6c-f5ae-43b2-99aa-6d10e79b76e1@redhat.com>
Date: Wed, 20 Dec 2023 12:36:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] mm: Batch-copy PTE ranges during fork()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, John Hubbard <jhubbard@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231218105100.172635-1-ryan.roberts@arm.com>
 <20231218105100.172635-3-ryan.roberts@arm.com>
 <0bef5423-6eea-446b-8854-980e9c23a948@redhat.com>
 <db1be625-33e4-4d07-8500-3f7d3c8f9937@arm.com>
 <be8b5181-be2c-4800-ba53-c65a6c3ed803@redhat.com>
 <dd227e51-c4b2-420b-a92a-65da85ab4018@arm.com>
 <7c0236ad-01f3-437f-8b04-125d69e90dc0@redhat.com>
 <9a58b1a2-2c13-4fa0-8ffa-2b3d9655f1b6@arm.com>
 <28968568-f920-47ac-b6fd-87528ffd8f77@redhat.com>
 <10b0b562-c1c0-4a66-9aeb-a6bff5c218f6@arm.com>
 <8f8023cb-3c31-4ead-a9e6-03a10e9490c6@redhat.com>
 <da16a7e5-76dd-4150-9ade-54b0d227a1e1@arm.com>
 <699cb1db-51eb-460e-9ceb-1ce08ca03050@redhat.com>
 <da29a4c6-61f6-4203-9c82-9ce6e1c32552@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <da29a4c6-61f6-4203-9c82-9ce6e1c32552@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.12.23 12:28, Ryan Roberts wrote:
> On 20/12/2023 10:56, David Hildenbrand wrote:
>> On 20.12.23 11:41, Ryan Roberts wrote:
>>> On 20/12/2023 10:16, David Hildenbrand wrote:
>>>> On 20.12.23 11:11, Ryan Roberts wrote:
>>>>> On 20/12/2023 09:54, David Hildenbrand wrote:
>>>>>> On 20.12.23 10:51, Ryan Roberts wrote:
>>>>>>> On 20/12/2023 09:17, David Hildenbrand wrote:
>>>>>>>> On 19.12.23 18:42, Ryan Roberts wrote:
>>>>>>>>> On 19/12/2023 17:22, David Hildenbrand wrote:
>>>>>>>>>> On 19.12.23 09:30, Ryan Roberts wrote:
>>>>>>>>>>> On 18/12/2023 17:47, David Hildenbrand wrote:
>>>>>>>>>>>> On 18.12.23 11:50, Ryan Roberts wrote:
>>>>>>>>>>>>> Convert copy_pte_range() to copy a batch of ptes in one go. A given
>>>>>>>>>>>>> batch is determined by the architecture with the new helper,
>>>>>>>>>>>>> pte_batch_remaining(), and maps a physically contiguous block of
>>>>>>>>>>>>> memory,
>>>>>>>>>>>>> all belonging to the same folio. A pte batch is then write-protected in
>>>>>>>>>>>>> one go in the parent using the new helper, ptep_set_wrprotects() and is
>>>>>>>>>>>>> set in one go in the child using the new helper, set_ptes_full().
>>>>>>>>>>>>>
>>>>>>>>>>>>> The primary motivation for this change is to reduce the number of tlb
>>>>>>>>>>>>> maintenance operations that the arm64 backend has to perform during
>>>>>>>>>>>>> fork, as it is about to add transparent support for the "contiguous
>>>>>>>>>>>>> bit"
>>>>>>>>>>>>> in its ptes. By write-protecting the parent using the new
>>>>>>>>>>>>> ptep_set_wrprotects() (note the 's' at the end) function, the backend
>>>>>>>>>>>>> can avoid having to unfold contig ranges of PTEs, which is expensive,
>>>>>>>>>>>>> when all ptes in the range are being write-protected. Similarly, by
>>>>>>>>>>>>> using set_ptes_full() rather than set_pte_at() to set up ptes in the
>>>>>>>>>>>>> child, the backend does not need to fold a contiguous range once they
>>>>>>>>>>>>> are all populated - they can be initially populated as a contiguous
>>>>>>>>>>>>> range in the first place.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This code is very performance sensitive, and a significant amount of
>>>>>>>>>>>>> effort has been put into not regressing performance for the order-0
>>>>>>>>>>>>> folio case. By default, pte_batch_remaining() is compile constant 1,
>>>>>>>>>>>>> which enables the compiler to simplify the extra loops that are added
>>>>>>>>>>>>> for batching and produce code that is equivalent (and equally
>>>>>>>>>>>>> performant) as the previous implementation.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This change addresses the core-mm refactoring only and a separate
>>>>>>>>>>>>> change
>>>>>>>>>>>>> will implement pte_batch_remaining(), ptep_set_wrprotects() and
>>>>>>>>>>>>> set_ptes_full() in the arm64 backend to realize the performance
>>>>>>>>>>>>> improvement as part of the work to enable contpte mappings.
>>>>>>>>>>>>>
>>>>>>>>>>>>> To ensure the arm64 is performant once implemented, this change is very
>>>>>>>>>>>>> careful to only call ptep_get() once per pte batch.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The following microbenchmark results demonstate that there is no
>>>>>>>>>>>>> significant performance change after this patch. Fork is called in a
>>>>>>>>>>>>> tight loop in a process with 1G of populated memory and the time for
>>>>>>>>>>>>> the
>>>>>>>>>>>>> function to execute is measured. 100 iterations per run, 8 runs
>>>>>>>>>>>>> performed on both Apple M2 (VM) and Ampere Altra (bare metal). Tests
>>>>>>>>>>>>> performed for case where 1G memory is comprised of order-0 folios and
>>>>>>>>>>>>> case where comprised of pte-mapped order-9 folios. Negative is faster,
>>>>>>>>>>>>> positive is slower, compared to baseline upon which the series is
>>>>>>>>>>>>> based:
>>>>>>>>>>>>>
>>>>>>>>>>>>> | Apple M2 VM   | order-0 (pte-map) | order-9 (pte-map) |
>>>>>>>>>>>>> | fork          |-------------------|-------------------|
>>>>>>>>>>>>> | microbench    |    mean |   stdev |    mean |   stdev |
>>>>>>>>>>>>> |---------------|---------|---------|---------|---------|
>>>>>>>>>>>>> | baseline      |    0.0% |    1.1% |    0.0% |    1.2% |
>>>>>>>>>>>>> | after-change  |   -1.0% |    2.0% |   -0.1% |    1.1% |
>>>>>>>>>>>>>
>>>>>>>>>>>>> | Ampere Altra  | order-0 (pte-map) | order-9 (pte-map) |
>>>>>>>>>>>>> | fork          |-------------------|-------------------|
>>>>>>>>>>>>> | microbench    |    mean |   stdev |    mean |   stdev |
>>>>>>>>>>>>> |---------------|---------|---------|---------|---------|
>>>>>>>>>>>>> | baseline      |    0.0% |    1.0% |    0.0% |    0.1% |
>>>>>>>>>>>>> | after-change  |   -0.1% |    1.2% |   -0.1% |    0.1% |
>>>>>>>>>>>>>
>>>>>>>>>>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>>>>>>>>>>>>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>>>>>>>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>         include/linux/pgtable.h | 80 +++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>>         mm/memory.c             | 92
>>>>>>>>>>>>> ++++++++++++++++++++++++++---------------
>>>>>>>>>>>>>         2 files changed, 139 insertions(+), 33 deletions(-)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>>>>>>>>> index af7639c3b0a3..db93fb81465a 100644
>>>>>>>>>>>>> --- a/include/linux/pgtable.h
>>>>>>>>>>>>> +++ b/include/linux/pgtable.h
>>>>>>>>>>>>> @@ -205,6 +205,27 @@ static inline int pmd_young(pmd_t pmd)
>>>>>>>>>>>>>         #define arch_flush_lazy_mmu_mode()    do {} while (0)
>>>>>>>>>>>>>         #endif
>>>>>>>>>>>>>         +#ifndef pte_batch_remaining
>>>>>>>>>>>>> +/**
>>>>>>>>>>>>> + * pte_batch_remaining - Number of pages from addr to next batch
>>>>>>>>>>>>> boundary.
>>>>>>>>>>>>> + * @pte: Page table entry for the first page.
>>>>>>>>>>>>> + * @addr: Address of the first page.
>>>>>>>>>>>>> + * @end: Batch ceiling (e.g. end of vma).
>>>>>>>>>>>>> + *
>>>>>>>>>>>>> + * Some architectures (arm64) can efficiently modify a contiguous
>>>>>>>>>>>>> batch of
>>>>>>>>>>>>> ptes.
>>>>>>>>>>>>> + * In such cases, this function returns the remaining number of
>>>>>>>>>>>>> pages to
>>>>>>>>>>>>> the end
>>>>>>>>>>>>> + * of the current batch, as defined by addr. This can be useful when
>>>>>>>>>>>>> iterating
>>>>>>>>>>>>> + * over ptes.
>>>>>>>>>>>>> + *
>>>>>>>>>>>>> + * May be overridden by the architecture, else batch size is always 1.
>>>>>>>>>>>>> + */
>>>>>>>>>>>>> +static inline unsigned int pte_batch_remaining(pte_t pte, unsigned
>>>>>>>>>>>>> long
>>>>>>>>>>>>> addr,
>>>>>>>>>>>>> +                        unsigned long end)
>>>>>>>>>>>>> +{
>>>>>>>>>>>>> +    return 1;
>>>>>>>>>>>>> +}
>>>>>>>>>>>>> +#endif
>>>>>>>>>>>>
>>>>>>>>>>>> It's a shame we now lose the optimization for all other archtiectures.
>>>>>>>>>>>>
>>>>>>>>>>>> Was there no way to have some basic batching mechanism that doesn't
>>>>>>>>>>>> require
>>>>>>>>>>>> arch
>>>>>>>>>>>> specifics?
>>>>>>>>>>>
>>>>>>>>>>> I tried a bunch of things but ultimately the way I've done it was the
>>>>>>>>>>> only
>>>>>>>>>>> way
>>>>>>>>>>> to reduce the order-0 fork regression to 0.
>>>>>>>>>>>
>>>>>>>>>>> My original v3 posting was costing 5% extra and even my first attempt
>>>>>>>>>>> at an
>>>>>>>>>>> arch-specific version that didn't resolve to a compile-time constant 1
>>>>>>>>>>> still
>>>>>>>>>>> cost an extra 3%.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I'd have thought that something very basic would have worked like:
>>>>>>>>>>>>
>>>>>>>>>>>> * Check if PTE is the same when setting the PFN to 0.
>>>>>>>>>>>> * Check that PFN is consecutive
>>>>>>>>>>>> * Check that all PFNs belong to the same folio
>>>>>>>>>>>
>>>>>>>>>>> I haven't tried this exact approach, but I'd be surprised if I can get
>>>>>>>>>>> the
>>>>>>>>>>> regression under 4% with this. Further along the series I spent a lot of
>>>>>>>>>>> time
>>>>>>>>>>> having to fiddle with the arm64 implementation; every conditional and
>>>>>>>>>>> every
>>>>>>>>>>> memory read (even when in cache) was a problem. There is just so
>>>>>>>>>>> little in
>>>>>>>>>>> the
>>>>>>>>>>> inner loop that every instruction matters. (At least on Ampere Altra and
>>>>>>>>>>> Apple
>>>>>>>>>>> M2).
>>>>>>>>>>>
>>>>>>>>>>> Of course if you're willing to pay that 4-5% for order-0 then the
>>>>>>>>>>> benefit to
>>>>>>>>>>> order-9 is around 10% in my measurements. Personally though, I'd
>>>>>>>>>>> prefer to
>>>>>>>>>>> play
>>>>>>>>>>> safe and ensure the common order-0 case doesn't regress, as you
>>>>>>>>>>> previously
>>>>>>>>>>> suggested.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I just hacked something up, on top of my beloved rmap cleanup/batching
>>>>>>>>>> series. I
>>>>>>>>>> implemented very generic and simple batching for large folios (all PTE
>>>>>>>>>> bits
>>>>>>>>>> except the PFN have to match).
>>>>>>>>>>
>>>>>>>>>> Some very quick testing (don't trust each last % ) on Intel(R) Xeon(R)
>>>>>>>>>> Silver
>>>>>>>>>> 4210R CPU.
>>>>>>>>>>
>>>>>>>>>> order-0: 0.014210 -> 0.013969
>>>>>>>>>>
>>>>>>>>>> -> Around 1.7 % faster
>>>>>>>>>>
>>>>>>>>>> order-9: 0.014373 -> 0.009149
>>>>>>>>>>
>>>>>>>>>> -> Around 36.3 % faster
>>>>>>>>>
>>>>>>>>> Well I guess that shows me :)
>>>>>>>>>
>>>>>>>>> I'll do a review and run the tests on my HW to see if it concurs.
>>>>>>>>
>>>>>>>>
>>>>>>>> I pushed a simple compile fixup (we need pte_next_pfn()).
>>>>>>>
>>>>>>> I've just been trying to compile and noticed this. Will take a look at your
>>>>>>> update.
>>>>>>>
>>>>>>> But upon review, I've noticed the part that I think makes this difficult for
>>>>>>> arm64 with the contpte optimization; You are calling ptep_get() for every
>>>>>>> pte in
>>>>>>> the batch. While this is functionally correct, once arm64 has the contpte
>>>>>>> changes, its ptep_get() has to read every pte in the contpte block in
>>>>>>> order to
>>>>>>> gather the access and dirty bits. So if your batching function ends up
>>>>>>> wealking
>>>>>>> a 16 entry contpte block, that will cause 16 x 16 reads, which kills
>>>>>>> performance. That's why I added the arch-specific pte_batch_remaining()
>>>>>>> function; this allows the core-mm to skip to the end of the contpte block and
>>>>>>> avoid ptep_get() for the 15 tail ptes. So we end up with 16 READ_ONCE()s
>>>>>>> instead
>>>>>>> of 256.
>>>>>>>
>>>>>>> I considered making a ptep_get_noyoungdirty() variant, which would avoid the
>>>>>>> bit
>>>>>>> gathering. But we have a similar problem in zap_pte_range() and that function
>>>>>>> needs the dirty bit to update the folio. So it doesn't work there. (see
>>>>>>> patch 3
>>>>>>> in my series).
>>>>>>>
>>>>>>> I guess you are going to say that we should combine both approaches, so that
>>>>>>> your batching loop can skip forward an arch-provided number of ptes? That
>>>>>>> would
>>>>>>> certainly work, but feels like an orthogonal change to what I'm trying to
>>>>>>> achieve :). Anyway, I'll spend some time playing with it today.
>>>>>>
>>>>>> You can overwrite the function or add special-casing internally, yes.
>>>>>>
>>>>>> Right now, your patch is called "mm: Batch-copy PTE ranges during fork()"
>>>>>> and it
>>>>>> doesn't do any of that besides preparing for some arm64 work.
>>>>>>
>>>>>
>>>>> Well it allows an arch to opt-in to batching. But I see your point.
>>>>>
>>>>> How do you want to handle your patches? Do you want to clean them up and I'll
>>>>> base my stuff on top? Or do you want me to take them and sort it all out?
>>>>
>>>> Whatever you prefer, it was mostly a quick prototype to see if we can achieve
>>>> decent performance.
>>>
>>> I'm about to run it on Altra and M2. But I assume it will show similar results.
> 
> OK results in, not looking great, which aligns with my previous experience. That
> said, I'm seeing some "BUG: Bad page state in process gmain  pfn:12a094" so
> perhaps these results are not valid...

I didn't see that so far on x86, maybe related to the PFN fixup?

> 
> 100 iterations per run, 8 runs over 2 reboots. Positive is slower than baseline,
> negative is faster:
> 
> Fork, order-0, Apple M2 VM:
> | kernel                |   mean_rel |   std_rel |
> |:----------------------|-----------:|----------:|
> | mm-unstable           |       0.0% |      0.8% |
> | hugetlb-rmap-cleanups |       1.3% |      2.0% |
> | fork-batching         |       3.5% |      1.2% |
> 
> Fork, order-9, Apple M2 VM:
> | kernel                |   mean_rel |   std_rel |
> |:----------------------|-----------:|----------:|
> | mm-unstable           |       0.0% |      0.8% |
> | hugetlb-rmap-cleanups |       0.9% |      0.9% |
> | fork-batching         |     -35.6% |      2.0% |
> 
> Fork, order-0, Ampere Altra:
> | kernel                |   mean_rel |   std_rel |
> |:----------------------|-----------:|----------:|
> | mm-unstable           |       0.0% |      0.7% |
> | hugetlb-rmap-cleanups |       3.2% |      0.7% |
> | fork-batching         |       5.5% |      1.1% |
> 
> Fork, order-9, Ampere Altra:
> | kernel                |   mean_rel |   std_rel |
> |:----------------------|-----------:|----------:|
> | mm-unstable           |       0.0% |      0.1% |
> | hugetlb-rmap-cleanups |       0.5% |      0.1% |
> | fork-batching         |     -10.3% |      0.1% |

It's weird that an effective folio_test_large() should affect 
performance that much. So far I haven't seen that behavior on x86, I 
wodner why arm64 should behave here differently (also for the rmap 
cleanups). Code layout/size?

I'll dig it up again and test on x86 once more.

[...]

> 
> Yeah that would probably work. But we need to be careful for the case where
> start_ptep is in the middle of a contpte block (which can happen - due to some
> vma splitting operations, we can have a contpte block that spans 2 vmas). So
> nr_cont_ptes() needs to either be spec'ed to only return the contpte size if
> start_ptep is pointing to the front of the block, and all other times, return 1,
> or it needs to return the number of ptes remaining to the end of the block (as
> it does in my v4).
> 
> But I guess we need to get to the bottom of my arm64 perf numbers first... I'll
> debug those bugs and rerun.

Yes, I'll dig into it on x86 once more.

-- 
Cheers,

David / dhildenb


