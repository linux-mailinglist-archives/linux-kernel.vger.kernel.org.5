Return-Path: <linux-kernel+bounces-161930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76D8B5378
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194281F218E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AB417BCA;
	Mon, 29 Apr 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UoXm3SJO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YEYHKUm9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UoXm3SJO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YEYHKUm9"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDCC2C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714380773; cv=none; b=hbPkHmToPYbq9yKlbT4aBCzXvzIARHUNPiGeZJKHcMp2BzxzdHlupYaY3jBx5Y1RItByUCj1FLbMK4fWYPAk6sCDSzf0DL9gI78nJ8mJjWI04m+jZIM8v0ReYQCUNecsnnhS5ubrXglANpcTPZhwI1IMJIocNDHfa5cnP9L9xzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714380773; c=relaxed/simple;
	bh=4TE710Ycv0ek1rz+R8n2+LlA2UNzWtdUp8Db7p7CkKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLOFy9NgGuy1w/i5AM9falL/nHLAHCAiLW2AS3XZ8xccHJUFQ76hRKsE/aMT++TmDA22FPEVFX1L/OJP9+lsr2jI95KmAXWeftRQDLZua3R2jF5MvB6/lntfuSCrOsfYLn3ztu7uSCyXX3it5RnhF1jXRk89HdKG1Z9WvgReQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UoXm3SJO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YEYHKUm9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UoXm3SJO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YEYHKUm9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01045203D9;
	Mon, 29 Apr 2024 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714380769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jx6yaNpr8hmPTIwWZh3UfYxX9haWFezt31WoNCFnLlE=;
	b=UoXm3SJO1i2QQIjjp0O3vI+EXhdZsHtQ5gPTVHO35ZZr/HEJo+bBQHxLaxi20UITokkzoA
	pYumOzrxQNxNllXQQ9lXZPHuiOCJ8CD0HznWH3RyuBOFczthFj5jE/WtpuADAJc6Zgtmzc
	lHFUmArXlBlQToi4tykgeqX84YpvoGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714380769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jx6yaNpr8hmPTIwWZh3UfYxX9haWFezt31WoNCFnLlE=;
	b=YEYHKUm9ZXiEL5jl50Y9vStDzLI4ooVdj1RKVZiQ58v8snhUeazkPk/frNScluZW5MFC4W
	hDYiByUPdExI04CQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UoXm3SJO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YEYHKUm9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714380769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jx6yaNpr8hmPTIwWZh3UfYxX9haWFezt31WoNCFnLlE=;
	b=UoXm3SJO1i2QQIjjp0O3vI+EXhdZsHtQ5gPTVHO35ZZr/HEJo+bBQHxLaxi20UITokkzoA
	pYumOzrxQNxNllXQQ9lXZPHuiOCJ8CD0HznWH3RyuBOFczthFj5jE/WtpuADAJc6Zgtmzc
	lHFUmArXlBlQToi4tykgeqX84YpvoGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714380769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jx6yaNpr8hmPTIwWZh3UfYxX9haWFezt31WoNCFnLlE=;
	b=YEYHKUm9ZXiEL5jl50Y9vStDzLI4ooVdj1RKVZiQ58v8snhUeazkPk/frNScluZW5MFC4W
	hDYiByUPdExI04CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC7DC138A7;
	Mon, 29 Apr 2024 08:52:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6YowNeBfL2arEwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 29 Apr 2024 08:52:48 +0000
Message-ID: <6f977874-2a18-44ef-b207-9eb0baad9d66@suse.cz>
Date: Mon, 29 Apr 2024 10:52:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: Fixes freepointer encoding for single free
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, Xiongwei Song <xiongwei.song@windriver.com>
References: <Zij_fGjRS_rK-65r@archlinux>
 <f9c133a9-8886-4c86-a24f-4778997547f2@linux.dev>
 <bbf2063f-54d4-43f0-84b3-1ea789470914@clip-os.org>
 <5c34b253-b476-494a-96c9-fe3c95b9b74d@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <5c34b253-b476-494a-96c9-fe3c95b9b74d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,windriver.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 01045203D9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.00

On 4/25/24 5:14 PM, Chengming Zhou wrote:
> On 2024/4/25 23:02, Nicolas Bouchinet wrote:

Thanks for finding the bug and the fix!

>> Hy,
>> 
>> First of all, thanks a lot for your time.
>> 
>> On 4/25/24 10:36, Chengming Zhou wrote:
>>> On 2024/4/24 20:47, Nicolas Bouchinet wrote:
>>>> From: Nicolas Bouchinet<nicolas.bouchinet@ssi.gouv.fr>
>>>>
>>>> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
>>>> separately") splits single and bulk object freeing in two functions
>>>> slab_free() and slab_free_bulk() which leads slab_free() to call
>>>> slab_free_hook() directly instead of slab_free_freelist_hook().
>>> Right.
>>>
>>>> If `init_on_free` is set, slab_free_hook() zeroes the object.
>>>> Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED` are
>>>> set, the do_slab_free() slowpath executes freelist consistency
>>>> checks and try to decode a zeroed freepointer which leads to a
>>>> "Freepointer corrupt" detection in check_object().
>>> IIUC, the "freepointer" can be checked on the free path only when
>>> it's outside the object memory. Here slab_free_hook() zeroed the
>>> freepointer and caused the problem.
>>>
>>> But why we should zero the memory outside the object_size? It seems
>>> more reasonable to only zero the object_size when init_on_free is set?
>> 
>> The original purpose was to avoid leaking information through the object and its metadata / tracking information as described in init_on_free initial Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options").
>> 
>> I have to admit I didn't read the entire lore about the original patchset yet, though it could be interesting to know a bit more the threat models, specifically regarding the object metadata init.
> 
> Thank you for the reference! I also don't get why it needs to zero
> the metadata and tracking information.

Hmm taking a step back, it seems really suboptimal to initialize the
outside-object freepointer as part of init_on_free:

- the freeing itself will always set it one way or another, in this case
free_to_partial_list() will do set_freepointer() after free_debug_processing()

- we lose the ability to detect if the allocated slab object's user wrote to
it, which is a buffer overflow

So the best option to me would be to adjust the init in slab_free_hook() to
avoid the outside-object freepointer similarly to how it avoids the red zone.

We'll still not have the buffer overflow detection ability for bulk free
where slab_free_freelist_hook() will set the free pointer before we reach
the checks, but changing that is most likely not worth the trouble, and
especially not suitable for a stable-candidate fix we need here.

>> 
>> The patch could also be optimized a bit by restricting set_freepointer() call to the `CONFIG_SLAB_FREELIST_HARDENED` option value.
>> 
> 
> Yeah. Maybe memcg_alloc_abort_single() needs this too.
> 
> Thanks.
> 
>> Thanks again, Nicolas
>> 
>>>
>>> Thanks.
>>>
>>>> Object's freepointer thus needs to be properly set using
>>>> set_freepointer() after init_on_free.
>>>>
>>>> To reproduce, set `slub_debug=FU init_on_free=1 log_level=7` on the
>>>> command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=y`.
>>>>
>>>> dmesg sample log:
>>>> [   10.708715] =============================================================================
>>>> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): Freepointer corrupt
>>>> [   10.712695] -----------------------------------------------------------------------------
>>>> [   10.712695]
>>>> [   10.712695] Slab 0xffffd8bdc400d580 objects=32 used=4 fp=0xffff9d9a80356f80 flags=0x200000000000a00(workingset|slab|node=0|zone=2)
>>>> [   10.716698] Object 0xffff9d9a80356600 @offset=1536 fp=0x7ee4f480ce0ecd7c
>>>> [   10.716698]
>>>> [   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>> [   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>> [   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>> [   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>> [   10.724696] Padding  ffff9d9a8035667c: 00 00 00 00                                      ....
>>>> [   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600 not freed
>>>>
>>>> Signed-off-by: Nicolas Bouchinet<nicolas.bouchinet@ssi.gouv.fr>
>>>> ---
>>>>   mm/slub.c | 8 +++++++-
>>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index 3aa12b9b323d9..71dbff9ad8f17 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -4342,10 +4342,16 @@ static __fastpath_inline
>>>>   void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>>>              unsigned long addr)
>>>>   {
>>>> +    bool init = false;
>>>> +
>>>>       memcg_slab_free_hook(s, slab, &object, 1);
>>>> +    init = slab_want_init_on_free(s);
>>>>   -    if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>>>> +    if (likely(slab_free_hook(s, object, init))) {
>>>> +        if (init)
>>>> +            set_freepointer(s, object, NULL);
>>>>           do_slab_free(s, slab, object, object, 1, addr);
>>>> +    }
>>>>   }
>>>>     static __fastpath_inline


