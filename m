Return-Path: <linux-kernel+bounces-29328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D644C830CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9902CB250DE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2508523754;
	Wed, 17 Jan 2024 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmYlU/mz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ED32374E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516872; cv=none; b=dc15ZccAHBgy08O5CzGKAyUGR0NE52RJVa9sMPV5o9lsFOUKChmush7tX4PKhB+vpl2VBcmhTskUIZvrwvtsbYeY1OlPIr+8lTyNFIvFio6XVUXMaFOvoZ8/51GcpMDflcHTGhC/9yHD40a1RZ2ThVsFu4u+aOeyYxhOovEZ22E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516872; c=relaxed/simple;
	bh=PFiKdzMyo2z5/cpS9DzfQWfJMMfYRvuRQLk2p/PQ1HE=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=HZt6sq/HN5a/8dIHgduoJ1eZQ2fSlKNKngPf2XrSsbE4L8oFh3Q3kqxXo+0bTMwu4kj+kn7ZjNRkFJKoOhIamdyvupBK9bD28D+kST62XL7R1A2FtXyKDj++rwPY7eIRVqokY5OifvttWfRtaF8IUISgNa+azm8JRB3nrSE4nVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XmYlU/mz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705516869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lYRXXfkGT0Pq232OxP6vbZcsrUt10wCefb5GatWHMVw=;
	b=XmYlU/mzH+FWsvnsVYrxcOAHolICZs4V9Gtdfm+7EcjKb15488zTCC/7BlkbFz6HRqSSHw
	r6sjy6C6H+5qsspU4tVC1DNZnWY0WDT+iOCFFdbi7QcIcXJjDUfZZbi+RfRY6DVJLSZyfl
	21e7RSX/9cQHmikg0jcej66YLs7myOo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-afBu-58UNqKPgw9w012ZNg-1; Wed, 17 Jan 2024 13:41:07 -0500
X-MC-Unique: afBu-58UNqKPgw9w012ZNg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e479a51e4so47392015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705516866; x=1706121666;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYRXXfkGT0Pq232OxP6vbZcsrUt10wCefb5GatWHMVw=;
        b=o+Rpx/FhEiM4zXVvq0c4Vgg+j9/Uix/bDsCcxDtI25rxJQxwC1+OTfYBA0ejy83L0v
         7Q9O3Lpkr3INmcTKCoDXVVXF0eWpxxp5yXgum8knHzsLv3Fn+AIijbn1Eh5wOHYycYLq
         npmbl5GEtWwIiAe2p9eGeTnttMtXOntOArir+RpYkcxZMiF6q5CDFwvaDxuVz4YLwVwq
         BOBqnt/EB7F27hnyM6H/0XH2GO1UNAugrJ9nP/fM/ng3QJumnzXJdopbPA484KsK3fze
         hj2Z6r0NHJUFfW37Ow+zbdorL/7AcIUHCA1tGzxwtWiDzszOvVRSrZovrjNJ+PLCOnnd
         S/dQ==
X-Gm-Message-State: AOJu0Yyrc4W8GlEjZQPj3fduzdxt/QgNWfDXbuvaofpZE1TttO5N531W
	LHI/seK+4SqGYQ8HmojMmBCtk3Pt+N116s0rEx+YIEIvVWsMZWTmrvsw92sAPxh50yGVL58IQlI
	YChjE7G159JROffhf/EwGxHypQAcHvaCNbwXGSwRzvf9E9Hb/ur2F9fcD6RVDlGUWNMnCsQ==
X-Received: by 2002:a05:600c:1c1a:b0:40d:858c:53f6 with SMTP id j26-20020a05600c1c1a00b0040d858c53f6mr851173wms.2.1705516866532;
        Wed, 17 Jan 2024 10:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMVRQ4IR/wVE5ZEXIJhAafaUiUjHQmpJ6rx9cPDz2KGdnM3BclHCCnUIAyOi4pnszvY1atAw==
X-Received: by 2002:a05:600c:1c1a:b0:40d:858c:53f6 with SMTP id j26-20020a05600c1c1a00b0040d858c53f6mr851169wms.2.1705516866092;
        Wed, 17 Jan 2024 10:41:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:b700:5a87:3a7a:c28d:2cff? (p200300cbc70bb7005a873a7ac28d2cff.dip0.t-ipconnect.de. [2003:cb:c70b:b700:5a87:3a7a:c28d:2cff])
        by smtp.gmail.com with ESMTPSA id f12-20020adfb60c000000b00336b8461a5esm2240280wre.88.2024.01.17.10.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 10:41:05 -0800 (PST)
Message-ID: <22b24ce9-d143-4b5f-87da-bf68e4fa46d3@redhat.com>
Date: Wed, 17 Jan 2024 19:41:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] mm/madvise: introduce MADV_TRY_COLLAPSE for
 attempted synchronous hugepage collapse
Content-Language: en-US
To: Zach O'Keefe <zokeefe@google.com>, Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, songmuchun@bytedance.com,
 linux-kernel@vger.kernel.org, Yang Shi <shy828301@gmail.com>,
 Peter Xu <peterx@redhat.com>, Michael Knyszek <mknyszek@google.com>,
 Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org
References: <20240117050217.43610-1-ioworker0@gmail.com>
 <CAAa6QmR0rcdk_rJOzc88ZA4jm9K5LwxT4dSHiBX+nPyd6E3Ddw@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAAa6QmR0rcdk_rJOzc88ZA4jm9K5LwxT4dSHiBX+nPyd6E3Ddw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17.01.24 18:10, Zach O'Keefe wrote:
> [+linux-mm & others]
> 
> On Tue, Jan 16, 2024 at 9:02 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].
>>
>> Introduce a new madvise mode, MADV_TRY_COLLAPSE, that allows users to
>> make a least-effort attempt at a synchronous collapse of memory at
>> their own expense.
>>
>> The only difference from MADV_COLLAPSE is that the new hugepage allocation
>> avoids direct reclaim and/or compaction, quickly failing on allocation errors.
>>
>> The benefits of this approach are:
>>
>> * CPU is charged to the process that wants to spend the cycles for the THP
>> * Avoid unpredictable timing of khugepaged collapse
>> * Prevent unpredictable stalls caused by direct reclaim and/or compaction
>>
>> Semantics
>>
>> This call is independent of the system-wide THP sysfs settings, but will
>> fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
>> multiple VMAs, the semantics of the collapse over each VMA is independent
>> from the others.  This implies a hugepage cannot cross a VMA boundary.  If
>> collapse of a given hugepage-aligned/sized region fails, the operation may
>> continue to attempt collapsing the remainder of memory specified.
>>
>> The memory ranges provided must be page-aligned, but are not required to
>> be hugepage-aligned.  If the memory ranges are not hugepage-aligned, the
>> start/end of the range will be clamped to the first/last hugepage-aligned
>> address covered by said range.  The memory ranges must span at least one
>> hugepage-sized region.
>>
>> All non-resident pages covered by the range will first be
>> swapped/faulted-in, before being internally copied onto a freshly
>> allocated hugepage.  Unmapped pages will have their data directly
>> initialized to 0 in the new hugepage.  However, for every eligible
>> hugepage aligned/sized region to-be collapsed, at least one page must
>> currently be backed by memory (a PMD covering the address range must
>> already exist).
>>
>> Allocation for the new hugepage will not enter direct reclaim and/or
>> compaction, quickly failing if allocation fails. When the system has
>> multiple NUMA nodes, the hugepage will be allocated from the node providing
>> the most native pages. This operation operates on the current state of the
>> specified process and makes no persistent changes or guarantees on how pages
>> will be mapped, constructed, or faulted in the future.
>>
>> Return Value
>>
>> If all hugepage-sized/aligned regions covered by the provided range were
>> either successfully collapsed, or were already PMD-mapped THPs, this
>> operation will be deemed successful.  On success, madvise(2) returns 0.
>> Else, -1 is returned and errno is set to indicate the error for the
>> most-recently attempted hugepage collapse.  Note that many failures might
>> have occurred, since the operation may continue to collapse in the event a
>> single hugepage-sized/aligned region fails.
>>
>>          ENOMEM  Memory allocation failed or VMA not found
>>          EBUSY   Memcg charging failed
>>          EAGAIN  Required resource temporarily unavailable.  Try again
>>                  might succeed.
>>          EINVAL  Other error: No PMD found, subpage doesn't have Present
>>                  bit set, "Special" page no backed by struct page, VMA
>>                  incorrectly sized, address not page-aligned, ...
>>
>> Use Cases
>>
>> An immediate user of this new functionality is the Go runtime heap allocator
>> that manages memory in hugepage-sized chunks. In the past, whether it was a
>> newly allocated chunk through mmap() or a reused chunk released by
>> madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory with
>> huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[3]
>> respectively. However, both approaches resulted in performance issues; for
>> both scenarios, there could be entries into direct reclaim and/or compaction,
>> leading to unpredictable stalls[4]. Now, the allocator can confidently use
>> madvise(MADV_TRY_COLLAPSE) to attempt the allocation of huge pages.
>>
>> [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404faca29a82689c77
>> [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa7333740996181268b60a3a
>> [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be4b3a9bd2af
>> [4] https://github.com/golang/go/issues/63334
> 
> Thanks for the patch, Lance, and thanks for providing the links above,
> referring to issues Go has seen.
> 
> I've reached out to the Go team to try and understand their use case,
> and how we could help. It's not immediately clear whether a
> lighter-weight MADV_COLLAPSE is the answer, but it could turn out to
> be.
> 
> That said, with respect to the implementation, should a need for a
> lighter-weight MADV_COLLAPSE be warranted, I'd personally like to see
> process_madvise(2) be the "v2" of madvise(2), where we can start
> leveraging the forward-facing flags argument for these different
> advice flavors. We'd need to safely revert v5.10 commit a68a0262abdaa
> ("mm/madvise: remove racy mm ownership check") so that
> process_madvise(2) can always operate on self. IIRC, this was ~ the
> plan we landed on during MADV_COLLAPSE dev discussions (i.e. pick a
> sane default, and implement options in flags down the line).

+1, using process_madvise() would likely be the right approach.

-- 
Cheers,

David / dhildenb


