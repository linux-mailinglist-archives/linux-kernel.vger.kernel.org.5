Return-Path: <linux-kernel+bounces-161962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D588B53CD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A70C1F22290
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E488B1C6AD;
	Mon, 29 Apr 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="F/F6IJ0W"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB0B12E7F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381805; cv=none; b=NGK3FZy/sBhkbu6ynuNwryG10tRk4chHkRZEOfxeNQTWa62h491b9mYeqsjiAWDER985iM5VJ3mai8w48qtf+NAjfW/ANAUbZVUam6m7RFxS3bxxVQ1+2yEbP+UaKXAAWY58LQCupJmXM0fLY2Gx8+7mBQ3vvajySsez8adjkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381805; c=relaxed/simple;
	bh=5hA9MvBhbEa3Cm6McvAOO+1rGHwcbE2SwalN/ZH8NU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrGaHLkHimfZOdcmT5Ossl2dFZfHMhKNZ+vYxePpJ2G4LBU02imhsh8YiAJEy26ZM0CM8YJu7J3+zRnjlkQHGdpItnk3k3ijL3/nIViYTb68wtwh2kuMIOw7u4Oph58dRShJFFGDiqr+ztTLQieAigMEi4qjIhKJozkQlLiErNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=F/F6IJ0W; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29B66240009;
	Mon, 29 Apr 2024 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1714381794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fp3sul8ucGnff9Wy5CSO4ilwRWxsPLPdktBwSszu2E=;
	b=F/F6IJ0WYU2227XVUTbyUysSDfsSjyALh6JLpmO0SamjLFjFamrQeKIeAfgvKxbXFd/xLE
	lf90zFTm+QAxUslquEYdgpXgxEWiE4Gb46fjqUfWu9TtPBwpNGIcjnVv4jVX85eZmyRb8t
	A1zdXhqBcW45cY6PE3ySE6iZrOp6DqPKuQVW2YR+TebVXhhzgJTjE48AIx8fRBdba3EVmB
	j7rV75cne6jGxMmApyzzSOPG/pnF1JCi8j6xA302obAQL42UfzTn2nKWEA9CquFy/VSnlc
	wR8pIYktLrqXYrz0vzSwuyA7VH2Y6Xdfw04MidbQnnbfA08us7r6oCeb0inTeQ==
Message-ID: <d17d7b20-b99e-46ce-b7bf-fb7058a66e79@clip-os.org>
Date: Mon, 29 Apr 2024 11:09:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: Fixes freepointer encoding for single free
To: Vlastimil Babka <vbabka@suse.cz>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, Xiongwei Song <xiongwei.song@windriver.com>
References: <Zij_fGjRS_rK-65r@archlinux>
 <f9c133a9-8886-4c86-a24f-4778997547f2@linux.dev>
 <bbf2063f-54d4-43f0-84b3-1ea789470914@clip-os.org>
 <5c34b253-b476-494a-96c9-fe3c95b9b74d@linux.dev>
 <6f977874-2a18-44ef-b207-9eb0baad9d66@suse.cz>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <6f977874-2a18-44ef-b207-9eb0baad9d66@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

Hi Vlastimil,

thanks for your review and your proposal.

On 4/29/24 10:52, Vlastimil Babka wrote:
> On 4/25/24 5:14 PM, Chengming Zhou wrote:
>> On 2024/4/25 23:02, Nicolas Bouchinet wrote:
> Thanks for finding the bug and the fix!
>
>>> Hy,
>>>
>>> First of all, thanks a lot for your time.
>>>
>>> On 4/25/24 10:36, Chengming Zhou wrote:
>>>> On 2024/4/24 20:47, Nicolas Bouchinet wrote:
>>>>> From: Nicolas Bouchinet<nicolas.bouchinet@ssi.gouv.fr>
>>>>>
>>>>> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
>>>>> separately") splits single and bulk object freeing in two functions
>>>>> slab_free() and slab_free_bulk() which leads slab_free() to call
>>>>> slab_free_hook() directly instead of slab_free_freelist_hook().
>>>> Right.
>>>> y not suitable for a stable-candidate fix we need
>>>>> If `init_on_free` is set, slab_free_hook() zeroes the object.
>>>>> Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED` are
>>>>> set, the do_slab_free() slowpath executes freelist consistency
>>>>> checks and try to decode a zeroed freepointer which leads to a
>>>>> "Freepointer corrupt" detection in check_object().
>>>> IIUC, the "freepointer" can be checked on the free path only when
>>>> it's outside the object memory. Here slab_free_hook() zeroed the
>>>> freepointer and caused the problem.
>>>>
>>>> But why we should zero the memory outside the object_size? It seems
>>>> more reasonable to only zero the object_size when init_on_free is set?
>>> The original purpose was to avoid leaking information through the object and its metadata / tracking information as described in init_on_free initial Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options").
>>>
>>> I have to admit I didn't read the entire lore about the original patchset yet, though it could be interesting to know a bit more the threat models, specifically regarding the object metadata init.
>> Thank you for the reference! I also don't get why it needs to zero
>> the metadata and tracking information.
> Hmm taking a step back, it seems really suboptimal to initialize the
> outside-object freepointer as part of init_on_free:
>
> - the freeing itself will always set it one way or another, in this case
> free_to_partial_list() will do set_freepointer() after free_debug_processing()
>
> - we lose the ability to detect if the allocated slab object's user wrote to
> it, which is a buffer overflow
>
> So the best option to me would be to adjust the init in slab_free_hook() to
> avoid the outside-object freepointer similarly to how it avoids the red zone.
>
> We'll still not have the buffer overflow detection ability for bulk free
> where slab_free_freelist_hook() will set the free pointer before we reach
> the checks, but changing that is most likely not worth the trouble, and
> especially not suitable for a stable-candidate fix we need here.

It seems like a good alternative to me, I'll push a V2 patch with those 
changes.

I help maintaining the Linux-Hardened patchset in which we have a slab 
object canary feature that helps detecting overflows. It is located just 
after the object freepointer.

>
>>> The patch could also be optimized a bit by restricting set_freepointer() call to the `CONFIG_SLAB_FREELIST_HARDENED` option value.
>>>
>> Yeah. Maybe memcg_alloc_abort_single() needs this too.
>>
>> Thanks.
>>
>>> Thanks again, Nicolas
>>>
>>>> Thanks.
>>>>
>>>>> Object's freepointer thus needs to be properly set using
>>>>> set_freepointer() after init_on_free.
>>>>>
>>>>> To reproduce, set `slub_debug=FU init_on_free=1 log_level=7` on the
>>>>> command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=y`.
>>>>>
>>>>> dmesg sample log:
>>>>> [   10.708715] =============================================================================
>>>>> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): Freepointer corrupt
>>>>> [   10.712695] -----------------------------------------------------------------------------
>>>>> [   10.712695]
>>>>> [   10.712695] Slab 0xffffd8bdc400d580 objects=32 used=4 fp=0xffff9d9a80356f80 flags=0x200000000000a00(workingset|slab|node=0|zone=2)
>>>>> [   10.716698] Object 0xffff9d9a80356600 @offset=1536 fp=0x7ee4f480ce0ecd7c
>>>>> [   10.716698]
>>>>> [   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>> [   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>> [   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>> [   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>> [   10.724696] Padding  ffff9d9a8035667c: 00 00 00 00                                      ....
>>>>> [   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600 not freed
>>>>>
>>>>> Signed-off-by: Nicolas Bouchinet<nicolas.bouchinet@ssi.gouv.fr>
>>>>> ---
>>>>>    mm/slub.c | 8 +++++++-
>>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>> index 3aa12b9b323d9..71dbff9ad8f17 100644
>>>>> --- a/mm/slub.c
>>>>> +++ b/mm/slub.c
>>>>> @@ -4342,10 +4342,16 @@ static __fastpath_inline
>>>>>    void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>>>>               unsigned long addr)
>>>>>    {
>>>>> +    bool init = false;
>>>>> +
>>>>>        memcg_slab_free_hook(s, slab, &object, 1);
>>>>> +    init = slab_want_init_on_free(s);
>>>>>    -    if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>>>>> +    if (likely(slab_free_hook(s, object, init))) {
>>>>> +        if (init)
>>>>> +            set_freepointer(s, object, NULL);
>>>>>            do_slab_free(s, slab, object, object, 1, addr);
>>>>> +    }
>>>>>    }
>>>>>      static __fastpath_inline
Thanks again for your review,

Nicolas

