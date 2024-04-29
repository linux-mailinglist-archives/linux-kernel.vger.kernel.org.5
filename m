Return-Path: <linux-kernel+bounces-162667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7028B5EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EB41F21F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0084283CC7;
	Mon, 29 Apr 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="P5lBlIyl"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A5682869
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407408; cv=none; b=CxclNGNxXZQTZGY6Zqks19LYbvvjRsLWLaGsyUvVnAffsKCNQBtQieDHZkrtoxeWqsOvEmNbH85qhzuoHwQ+d2LypUoSR3ohRMYm6ZupFuBY4xdpOrg9X8mYdVPdCvRh2fb8oR/o7spri0sPFSHcf84IMTQchWYEZoxCz4+VlLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407408; c=relaxed/simple;
	bh=3TGyvOryX/YrPvPyKQqM+bPKGn9tDpw3cGu5JLS+EUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXUDZ4SALHzLNyKVNwYLkpvRhnbuPssg69nwzk+2Iyeb6SGeqNTbsvtmtJGzYmiRZUaH1Hdaq5RxZZ34IAwbNqtnrhyTO5hi+VkCZWfcfN6uLIivPz2GBqNBzk7iKyydza2kYTnuHLVzIFl/GIJtICsifY9ecxHqym+oz+vX/B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=P5lBlIyl; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3987C1C0006;
	Mon, 29 Apr 2024 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1714407403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgjaNRLEiT76BlaO5T8jnumXyfuG+m1B71ogzqT5hpI=;
	b=P5lBlIylAmV4JmvD5a4rMr3zvpn0GBMngXjPqq69tsEHO/yoOH/wix6rvivyiI+pYc/HEQ
	pahxz8udA3d/NlvukusIlMKa7cDGNY0IhBefkMpTFSt+7IF/FY7TGN+9iDD3ExjfA5kXqM
	rpN9LhPIuRZ/PolOtG6xsqVucz3b2q8dNgRfGo+tjATi5pU5rW4wX8fhPbzbziMjGVuQrF
	y36EsNcx1CAg8Bpri9Ks/7v9Sjlltl52GL95GPh312+fvc3NBc03/ArL6oUkAtD5fHoD/B
	U7CRrnQTODX5z6IIKauOyyhIRzLWN890BhlgL79c8JdNrorCsJOIUlbdqgeKlg==
Message-ID: <10c9a07a-1c6d-4ea7-8c1d-03a7dc5b29d8@clip-os.org>
Date: Mon, 29 Apr 2024 18:16:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: Fixes freepointer encoding for single free
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, Xiongwei Song <xiongwei.song@windriver.com>
References: <Zij_fGjRS_rK-65r@archlinux>
 <f9c133a9-8886-4c86-a24f-4778997547f2@linux.dev>
 <bbf2063f-54d4-43f0-84b3-1ea789470914@clip-os.org>
 <5c34b253-b476-494a-96c9-fe3c95b9b74d@linux.dev>
 <6f977874-2a18-44ef-b207-9eb0baad9d66@suse.cz>
 <d17d7b20-b99e-46ce-b7bf-fb7058a66e79@clip-os.org>
 <7074c0b4-62d4-444d-8e59-e23bbbccf9b8@clip-os.org>
 <e03c8cbb-ddbf-4721-8e71-01e96379b0cc@linux.dev>
 <83fda406-0340-4b7b-9f02-e9eb41c77f0e@clip-os.org>
 <73f80886-e390-4320-84dd-68e7cd7e8c62@linux.dev>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <73f80886-e390-4320-84dd-68e7cd7e8c62@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

On 4/29/24 16:52, Chengming Zhou wrote:
> On 2024/4/29 22:32, Nicolas Bouchinet wrote:
>> On 4/29/24 15:35, Chengming Zhou wrote:
>>> On 2024/4/29 20:59, Nicolas Bouchinet wrote:
>>>> On 4/29/24 11:09, Nicolas Bouchinet wrote:
>>>>> Hi Vlastimil,
>>>>>
>>>>> thanks for your review and your proposal.
>>>>>
>>>>> On 4/29/24 10:52, Vlastimil Babka wrote:
>>>>>> On 4/25/24 5:14 PM, Chengming Zhou wrote:
>>>>>>> On 2024/4/25 23:02, Nicolas Bouchinet wrote:
>>>>>> Thanks for finding the bug and the fix!
>>>>>>
>>>>>>>> Hy,
>>>>>>>>
>>>>>>>> First of all, thanks a lot for your time.
>>>>>>>>
>>>>>>>> On 4/25/24 10:36, Chengming Zhou wrote:
>>>>>>>>> On 2024/4/24 20:47, Nicolas Bouchinet wrote:
>>>>>>>>>> From: Nicolas Bouchinet<nicolas.bouchinet@ssi.gouv.fr>
>>>>>>>>>>
>>>>>>>>>> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
>>>>>>>>>> separately") splits single and bulk object freeing in two functions
>>>>>>>>>> slab_free() and slab_free_bulk() which leads slab_free() to call
>>>>>>>>>> slab_free_hook() directly instead of slab_free_freelist_hook().
>>>>>>>>> Right.
>>>>>>>>> y not suitable for a stable-candidate fix we need
>>>>>>>>>> If `init_on_free` is set, slab_free_hook() zeroes the object.
>>>>>>>>>> Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED` are
>>>>>>>>>> set, the do_slab_free() slowpath executes freelist consistency
>>>>>>>>>> checks and try to decode a zeroed freepointer which leads to a
>>>>>>>>>> "Freepointer corrupt" detection in check_object().
>>>>>>>>> IIUC, the "freepointer" can be checked on the free path only when
>>>>>>>>> it's outside the object memory. Here slab_free_hook() zeroed the
>>>>>>>>> freepointer and caused the problem.
>>>>>>>>>
>>>>>>>>> But why we should zero the memory outside the object_size? It seems
>>>>>>>>> more reasonable to only zero the object_size when init_on_free is set?
>>>>>>>> The original purpose was to avoid leaking information through the object and its metadata / tracking information as described in init_on_free initial Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options").
>>>>>>>>
>>>>>>>> I have to admit I didn't read the entire lore about the original patchset yet, though it could be interesting to know a bit more the threat models, specifically regarding the object metadata init.
>>>>>>> Thank you for the reference! I also don't get why it needs to zero
>>>>>>> the metadata and tracking information.
>>>>>> Hmm taking a step back, it seems really suboptimal to initialize the
>>>>>> outside-object freepointer as part of init_on_free:
>>>>>>
>>>>>> - the freeing itself will always set it one way or another, in this case
>>>>>> free_to_partial_list() will do set_freepointer() after free_debug_processing()
>>>>>>
>>>>>> - we lose the ability to detect if the allocated slab object's user wrote to
>>>>>> it, which is a buffer overflow
>>> Ah, right, this ability seems important for debugging overflow problem.
>>>
>>>>>> So the best option to me would be to adjust the init in slab_free_hook() to
>>>>>> avoid the outside-object freepointer similarly to how it avoids the red zone.
>>> Agree.
>>>
>>>>>> We'll still not have the buffer overflow detection ability for bulk free
>>>>>> where slab_free_freelist_hook() will set the free pointer before we reach
>>>>>> the checks, but changing that is most likely not worth the trouble, and
>>>>>> especially not suitable for a stable-candidate fix we need here.
>>>>> It seems like a good alternative to me, I'll push a V2 patch with those changes.
>>>>>
>>>>> I help maintaining the Linux-Hardened patchset in which we have a slab object canary feature that helps detecting overflows. It is located just after the object freepointer.
>>>> I've tried a patch where the freepointer is avoided but it results in the same bug. It seems that the commit 0f181f9fbea8bc7ea ("mm/slub.c: init_on_free=1 should wipe freelist ptr for bulk allocations") inits the freepointer on allocation if init_on_free is set in order to return a clean initialized object to the caller.
>>>>
>>> Good catch! You may need to change maybe_wipe_obj_freeptr() too,
>>> I haven't tested this, not sure whether it works for you. :)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 3e33ff900d35..3f250a167cb5 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -3796,7 +3796,8 @@ static void *__slab_alloc_node(struct kmem_cache *s,
>>>    static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
>>>                                                      void *obj)
>>>    {
>>> -       if (unlikely(slab_want_init_on_free(s)) && obj)
>>> +       if (unlikely(slab_want_init_on_free(s)) && obj &&
>>> +           !freeptr_outside_object(s))
>>>                   memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
>>>                           0, sizeof(void *));
>>>    }
>>>
>>> Thanks!
>> Indeed since check_object() avoids objects for which freepointer is in the object and since val is equal to SLUB_RED_ACTIVE in our specific case it should work. Do you want me to add you as Co-authored ?
>>
> Ok, it's great. Thanks!

Now I think of it, doesn't it seems a bit odd to only properly 
init_on_free object's freepointer only if it's inside the object ? IMHO 
it is equally necessary to avoid information leaking about the 
freepointer whether it is inside or outside the object.
I think it break the semantic of the commit 0f181f9fbea8bc7ea 
("mm/slub.c: init_on_free=1 should wipe freelist ptr for bulk 
allocations") ?

Thanks.


