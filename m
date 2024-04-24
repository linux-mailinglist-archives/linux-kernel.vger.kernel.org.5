Return-Path: <linux-kernel+bounces-156639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC28B0613
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E4D2844A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B16D158D9D;
	Wed, 24 Apr 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YPnyalHg"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734C5158D88
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951090; cv=none; b=R+a3LjaOZwDLGJdvz1xiTV9olL89cvCzCX1+rNbPwfBYaNBtA4YQuMYh+mpBLVtIPHc05rrB609GmunCDC49KbME+2k3w9+5U0GK1YcjrC8hU7ZuHsc/GWRSTyAez7ntXUc+Su7UCaCdJnQ29a910BIS7RpbaUGwwRku2caSh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951090; c=relaxed/simple;
	bh=8PWDdtiB3Xzzlhux/xDf8i4DGsXpZQEMjMXh021hTAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncRgSBNuA8NTbu4OZzUEf6K9bWEUYK1l8bZJyv2NbdcuaU5gRtrfHcBiTEY8iQ9Im0+YtV/BD0FHkSgESY6uLnJTItwZO3ke8j/7CxXGMb2Cqh3TmnTx9hsXaP96zY3VQVV0+8dS6FUGMj+eASD2MXi5+Qt3z02TPCOG3JoSGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YPnyalHg; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713951084; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zipW5OKTuriO6u7AdV/9p85sXllwC1SbrX531oPkRyE=;
	b=YPnyalHg5ucnWQMHM2GBdmUjlrWA3v5X4jxKwYvNEguosIIkXV6HWRairtvxuyjc0w4Y0cHnIg9TiTx1xfFWuCg/Dw093qQ9GN5qYa+xqIVSt9a13zFb2oGPenlRyCiaDKyZJFsOvr3DD+jspw0/s+rrIav8FjBde1zGB9cko6s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W5ByeSc_1713951080;
Received: from 30.97.56.58(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W5ByeSc_1713951080)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 17:31:22 +0800
Message-ID: <e0162ba4-11bb-46c1-81b3-4cda3d0d7a6f@linux.alibaba.com>
Date: Wed, 24 Apr 2024 17:31:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
To: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand
 <david@redhat.com>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 wangkefeng.wang@huawei.com, ying.huang@intel.com, shy828301@gmail.com,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com>
 <05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com>
 <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
 <ce6be451-7c5a-402f-8340-be40699829c2@redhat.com>
 <fb2052ab-74d1-48f7-975b-15abc2a078e2@linux.alibaba.com>
 <140d4efa-28a0-449a-9570-9d44c23b55d1@redhat.com>
 <5edfe6b3-8f00-46c4-8ddb-d1add845541d@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5edfe6b3-8f00-46c4-8ddb-d1add845541d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/24 16:15, Ryan Roberts wrote:
> On 24/04/2024 08:11, David Hildenbrand wrote:
>> On 24.04.24 08:10, Baolin Wang wrote:
>>>
>>>
>>> On 2024/4/23 19:37, David Hildenbrand wrote:
>>>> On 23.04.24 03:17, Barry Song wrote:
>>>>> On Mon, Apr 22, 2024 at 3:03 PM Baolin Wang
>>>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>>>
>>>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>> ---
>>>>>>     include/linux/huge_mm.h | 2 ++
>>>>>>     mm/huge_memory.c        | 4 ++++
>>>>>>     mm/shmem.c              | 5 ++++-
>>>>>>     3 files changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>> index 26b6fa98d8ac..67b9c1acad31 100644
>>>>>> --- a/include/linux/huge_mm.h
>>>>>> +++ b/include/linux/huge_mm.h
>>>>>> @@ -270,6 +270,8 @@ enum mthp_stat_item {
>>>>>>            MTHP_STAT_ANON_SWPOUT,
>>>>>>            MTHP_STAT_ANON_SWPOUT_FALLBACK,
>>>>>>            MTHP_STAT_ANON_SWPIN_REFAULT,
>>>>>> +       MTHP_STAT_SHMEM_ANON_ALLOC,
>>>>>> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,
>>>>>
>>>>> not quite sure about this. for 2MB pmd-mapped THP shmem, we count them
>>>>> as FILE_THP.
>>>>> here we are counting as SHMEM_ANON. To me, SHMEM_ANON is more correct but
>>>>> it doesn't align with pmd-mapped THP. David, Ryan, what do you think?
>>>>
>>>> The term "anonymous share" in the patch subject is weird to begin with
>>>> ;) Easy to confuse with anonymous cow-shared memory. Let's just call it
>>>> "anonymous shmem", which it is under the hood.
>>>
>>> Sure.
>>>
>>>> ... regarding the question: if we add FILE_ALLOC and friends, at least
>>>> initially, we wouldn't account other large pagecache folios.
>>>>
>>>> ... likely we should add that then as well so the counter matches the
>>>> actual name?
>>>>
>>>> If we later realize that we need separate FILE vs. SHMEM vs. WHATEVER
>>>> counters, we can always add more fine-grained counters later. Doing it
>>>> consistently w.r.t. traditional THPs first sounds reasonable.
>>>
>>> Um, once we expose it to userspace through the sysfs interface, the
>>> sysfs interface should be explicit as much as possible and avoid
>>> confusing users, otherwise it will be difficult to change this kind of
>>> interface in the future. Personally, I prefer to Ryan's suggestion.
>>
>> Inconsistency is confusing. As long as you avoid that, I don't particularly care.
> 
> This is a good point. We have been careful to make sure the 2M ANON mTHP stats
> match the existing PMD-size stats. So we should definitely make sure that any
> future 2M FILE mTHP stats match too, which I guess means counting both SHMEM and
> FILE events.
> 
> So perhaps it makes more sense to add FILE counters to start with. If we need
> the SHMEM-specific counters, we could add them later?
> 
> I'm happy to go with the crowd on this...

(Seems I'm the only one who prefers the term 'SHMEM_' now.) Fine, I have 
no strong preference, and let's keep consistency first. Thanks guys.

