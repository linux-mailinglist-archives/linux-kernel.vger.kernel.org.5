Return-Path: <linux-kernel+bounces-163012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101128B6372
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B91F22117
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D9E141999;
	Mon, 29 Apr 2024 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XUqsYLc5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CPyUBR9r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XUqsYLc5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CPyUBR9r"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424AA12B14F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422177; cv=none; b=lqeWQGTJeifVDPo+i0slKfB22nPasDvfvlXBzwZfYSnh9Wlcj2OJINgBl508qQ5nm5MzyFHFtTCBZ9uxag4UCmxf/0kzHaxEi7RboO6nOGP6x4HL5DHKai5BreagOsrzzQ3GlYDB6XL/2/ZOgmlo+DyIFARVv73t28jDS58Mih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422177; c=relaxed/simple;
	bh=TVcBTI0zuiXuSOE4Jt9svSMfs/4dmk6pHHcYqL/PMNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldRQiH72kRyCv2aVcBxMGK0qKPSKnR99XQTBKTJIWip/eRdEWcgDxInaGdmtDV4rlb3o99vJeN2kR4+8tTNrzzD04oKdKkLIZmCll8DOIclphRji7qEzED62uQIQDkFb2ky+Rd1/L3nx5tsL7WlsT3YgvW/B7wB31+tiA7ZNq00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XUqsYLc5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CPyUBR9r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XUqsYLc5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CPyUBR9r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 12B151F395;
	Mon, 29 Apr 2024 20:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714422173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wbbou26awthy0OaHOCg1E2oWXEWL2HTH0voxKWq9DDA=;
	b=XUqsYLc5gfh0LAKx12R6+M+W4IJZPigGJ/3s6aDE1q7G/hANgybUZ79zcRC8Hz5JOIk0nS
	D8hdut82Fezbia7vt9WgoI4pnveWsk/WzqpFoCfeFEi5RHp6zXicDUrn4IyDDEPMkA/5FZ
	0rmVl2aVUNQdOsrCVsu0lCfijoETxSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714422173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wbbou26awthy0OaHOCg1E2oWXEWL2HTH0voxKWq9DDA=;
	b=CPyUBR9rDR48D+9U35W2mWlSuIsVW++99Mmknu1ZGKRXGQHZVZAuNFekhbtY2gNDt3Y3FP
	Ye8CzcQ9vNSO4XAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XUqsYLc5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CPyUBR9r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714422173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wbbou26awthy0OaHOCg1E2oWXEWL2HTH0voxKWq9DDA=;
	b=XUqsYLc5gfh0LAKx12R6+M+W4IJZPigGJ/3s6aDE1q7G/hANgybUZ79zcRC8Hz5JOIk0nS
	D8hdut82Fezbia7vt9WgoI4pnveWsk/WzqpFoCfeFEi5RHp6zXicDUrn4IyDDEPMkA/5FZ
	0rmVl2aVUNQdOsrCVsu0lCfijoETxSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714422173;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wbbou26awthy0OaHOCg1E2oWXEWL2HTH0voxKWq9DDA=;
	b=CPyUBR9rDR48D+9U35W2mWlSuIsVW++99Mmknu1ZGKRXGQHZVZAuNFekhbtY2gNDt3Y3FP
	Ye8CzcQ9vNSO4XAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC894139DE;
	Mon, 29 Apr 2024 20:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A0RqOZwBMGYweQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 29 Apr 2024 20:22:52 +0000
Message-ID: <ae15114f-24d3-499b-9c99-ae7e098badd9@suse.cz>
Date: Mon, 29 Apr 2024 22:22:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: Fixes freepointer encoding for single free
Content-Language: en-US
To: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>,
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
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <10c9a07a-1c6d-4ea7-8c1d-03a7dc5b29d8@clip-os.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,windriver.com];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 12B151F395
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.00

On 4/29/24 6:16 PM, Nicolas Bouchinet wrote:
> On 4/29/24 16:52, Chengming Zhou wrote:
>> On 2024/4/29 22:32, Nicolas Bouchinet wrote:
>>> On 4/29/24 15:35, Chengming Zhou wrote:
>>>> On 2024/4/29 20:59, Nicolas Bouchinet wrote:
>>>>>>
>>>>>> I help maintaining the Linux-Hardened patchset in which we have a slab object canary feature that helps detecting overflows. It is located just after the object freepointer.
>>>>> I've tried a patch where the freepointer is avoided but it results in the same bug. It seems that the commit 0f181f9fbea8bc7ea ("mm/slub.c: init_on_free=1 should wipe freelist ptr for bulk allocations") inits the freepointer on allocation if init_on_free is set in order to return a clean initialized object to the caller.
>>>>>
>>>> Good catch! You may need to change maybe_wipe_obj_freeptr() too,
>>>> I haven't tested this, not sure whether it works for you. :)
>>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index 3e33ff900d35..3f250a167cb5 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -3796,7 +3796,8 @@ static void *__slab_alloc_node(struct kmem_cache *s,
>>>>    static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
>>>>                                                      void *obj)
>>>>    {
>>>> -       if (unlikely(slab_want_init_on_free(s)) && obj)
>>>> +       if (unlikely(slab_want_init_on_free(s)) && obj &&
>>>> +           !freeptr_outside_object(s))
>>>>                   memset((void *)((char *)kasan_reset_tag(obj) + s->offset),
>>>>                           0, sizeof(void *));
>>>>    }
>>>>
>>>> Thanks!
>>> Indeed since check_object() avoids objects for which freepointer is in the object and since val is equal to SLUB_RED_ACTIVE in our specific case it should work. Do you want me to add you as Co-authored ?
>>>
>> Ok, it's great. Thanks!
> 
> Now I think of it, doesn't it seems a bit odd to only properly 
> init_on_free object's freepointer only if it's inside the object ? IMHO 
> it is equally necessary to avoid information leaking about the 
> freepointer whether it is inside or outside the object.
> I think it break the semantic of the commit 0f181f9fbea8bc7ea 
> ("mm/slub.c: init_on_free=1 should wipe freelist ptr for bulk 
> allocations") ?

Hm, AFAIU, wiping inside object prevents misuse of some buggy kernel code
that would allocate and accidentally leak prior content (including the
in-object freepointer) somewhere the attacker can read. Now for wiping the
freepointer outside the object to be useful it would have assume said
leak-prone code to additionally be reading past the allocated object size,
i.e. a read buffer overflow. That to me seems to be a much more rare
combination, and also in that case such code could also likely read even
further past the object, i.e. leak the next object's data? IOW I don't think
it buys us much additional security protection in practice?

> Thanks.
> 


