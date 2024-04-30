Return-Path: <linux-kernel+bounces-163674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612588B6E35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CC91F2426E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D614817799B;
	Tue, 30 Apr 2024 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="k8QJX1bT"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E471292C4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468806; cv=none; b=GC+arfs9pZeHOe65cHJ6Oxp47EYM53g1QhvzoELVzlTX+uhVnR0puS0ZaEmnKjm9T/+95VBfklmTrYTc2c5yh9p8lAcAMexdnyzpYAQ/X+26eJzPfBkqbnz4j361El5owm5wJcoq/TRrIsvjBe+gMLbnZAGxaScjFtv6QBN6KV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468806; c=relaxed/simple;
	bh=QiEe0qGaiIZOlpKFq5EDuENyv+9UNceDDFBF0P4yEKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHKCCrWJy4/FFaZSRS2bwPr9W4QRI91p6z9JYLvqY8Jhc1F6Qzq8CoFFgVmQqqUYOb0gW9/sgr1kfOVaBV6Y8Zg49Piycgjn/BWOOMbVoPKWgfMGmLyeLdKTVdO2sZxuHXAbNY+lSfKNIH4GqNs/RO0Rapi8JWW6QzpQEy4dcrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=k8QJX1bT; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1D1B2000D;
	Tue, 30 Apr 2024 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1714468802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5WI2wQDSf6+iCnD2XmajtzE8LnfA93T1JMzMZ7UZ4Q=;
	b=k8QJX1bTdcXE4cJQ12Yp4hGl72YKOCpxnFiZSPIosSmeiGQBE75l/W8K2xi9hp9PGJ/uMl
	e9Ir/YBilXS39SVhWuIE/2/LUghCqSchXzzz6iWX6eg5ef5UEAP6BsrR95atEsW7zCEJqo
	68+5/rJZQjy73mUHKtTALivJF8C2H6uBa+Bhy7OrxyCg9qA6qICDfyQiL25eCVJL1BanBi
	ntPvQ8hBf2avHUFbp9TWMHaoZuUZGgPsKoOUXR06Hw1xHK5YEXG1mxtaUBOjVSJa3/KlQM
	c3pS8RCW3ZXJ99tAuI2onNFUPGmgI4vz2n6oV8ri1ZhZTvip1K8CvZG+wnhhnA==
Message-ID: <28095247-b28d-47f9-a28c-775432d2d6d3@clip-os.org>
Date: Tue, 30 Apr 2024 11:19:59 +0200
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
 <d17d7b20-b99e-46ce-b7bf-fb7058a66e79@clip-os.org>
 <7074c0b4-62d4-444d-8e59-e23bbbccf9b8@clip-os.org>
 <e03c8cbb-ddbf-4721-8e71-01e96379b0cc@linux.dev>
 <83fda406-0340-4b7b-9f02-e9eb41c77f0e@clip-os.org>
 <73f80886-e390-4320-84dd-68e7cd7e8c62@linux.dev>
 <10c9a07a-1c6d-4ea7-8c1d-03a7dc5b29d8@clip-os.org>
 <ae15114f-24d3-499b-9c99-ae7e098badd9@suse.cz>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <ae15114f-24d3-499b-9c99-ae7e098badd9@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org


On 4/29/24 22:22, Vlastimil Babka wrote:
> On 4/29/24 6:16 PM, Nicolas Bouchinet wrote:
>> On 4/29/24 16:52, Chengming Zhou wrote:
>>> On 2024/4/29 22:32, Nicolas Bouchinet wrote:
>>>> On 4/29/24 15:35, Chengming Zhou wrote:
>>>>> On 2024/4/29 20:59, Nicolas Bouchinet wrote:
>>>>>>> I help maintaining the Linux-Hardened patchset in which we have a slab object canary feature that helps detecting overflows. It is located just after the object freepointer.
>>>>>> I've tried a patch where the freepointer is avoided but it results in the same bug. It seems that the commit 0f181f9fbea8bc7ea ("mm/slub.c: init_on_free=1 should wipe freelist ptr for bulk allocations") inits the freepointer on allocation if init_on_free is set in order to return a clean initialized object to the caller.
>>>>>>
>>>>> Good catch! You may need to change maybe_wipe_obj_freeptr() too,
>>>>> I haven't tested this, not sure whether it works for you. :)
>>>>>
>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>> index 3e33ff900d35..3f250a167cb5 100644
>>>>> --- a/mm/slub.c
>>>>> +++ b/mm/slub.c
>>>>> @@ -3796,7 +3796,8 @@ static void *__slab_alloc_node(struct kmem_cache *s,
>>>>>     static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
>>>>>                                                       void *obj)
>>>>>     {
>>>>> -       if (unlikely(slab_want_init_on_free(s)) && obj)
>>>>> +       if (unlikely(slab_want_init_on_free(s)) && obj &&
>>>>> +           !freeptr_outside_object(s))
>>>>>                    memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
>>>>>                            0, sizeof(void *));
>>>>>     }
>>>>>
>>>>> Thanks!
>>>> Indeed since check_object() avoids objects for which freepointer is in the object and since val is equal to SLUB_RED_ACTIVE in our specific case it should work. Do you want me to add you as Co-authored ?
>>>>
>>> Ok, it's great. Thanks!
>> Now I think of it, doesn't it seems a bit odd to only properly
>> init_on_free object's freepointer only if it's inside the object ? IMHO
>> it is equally necessary to avoid information leaking about the
>> freepointer whether it is inside or outside the object.
>> I think it break the semantic of the commit 0f181f9fbea8bc7ea
>> ("mm/slub.c: init_on_free=1 should wipe freelist ptr for bulk
>> allocations") ?
> Hm, AFAIU, wiping inside object prevents misuse of some buggy kernel code
> that would allocate and accidentally leak prior content (including the
> in-object freepointer) somewhere the attacker can read. Now for wiping the
> freepointer outside the object to be useful it would have assume said
> leak-prone code to additionally be reading past the allocated object size,
> i.e. a read buffer overflow. That to me seems to be a much more rare
> combination, and also in that case such code could also likely read even
> further past the object, i.e. leak the next object's data? IOW I don't think
> it buys us much additional security protection in practice?
>
Moreover, with CONFIG_SLAB_FREELIST_HARDENED activated, freepointers are 
encoded and harder to exploit.


>> Thanks.
>>
>

