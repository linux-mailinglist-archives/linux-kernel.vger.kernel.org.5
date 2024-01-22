Return-Path: <linux-kernel+bounces-33757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2E4836E37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E331C27B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB94BAA6;
	Mon, 22 Jan 2024 17:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9n4lLYT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U0E03061";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9n4lLYT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U0E03061"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951614BAA2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943597; cv=none; b=RvGg6eABewR5JcAFJWo54jVUagXBLd4LfgE5Nmy+al/64LGuL11wSQh4Y7RZkJkAdGI7ahwn8ZPuT71Xueab3TZxdTTBdQ3XGvU3rcQl+V4GN7wkNSqgyP/fJ+L4oJQkJu1JaZkPK6+5iWRhMm4gcy5JUE40SeUlXwklPaz4YoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943597; c=relaxed/simple;
	bh=eK7d3MG7N6Aqc45gYJeNpsG+NQTSq7gYjxILB/X0pJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rcSDGB85lJhVyWXlj7f55xa7NDW3ZmUrDXeiHIfEeHOJJRPoMVfpcmKhceKGRg0sp7mfBa+Q3FV/iY0UznmMzkKgZ/5El/Amrsg3m9XxArmx5WTu9HSoepr9W2BH5eRrYNtUPCyt0x5Oajyz1QPdQFvWJmBRrhwXxrqaMIc8jBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C9n4lLYT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U0E03061; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C9n4lLYT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U0E03061; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81E3B22088;
	Mon, 22 Jan 2024 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705943593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BcI2f1DWEvDi/Qr4PdTFHB53Q+BL3Gr3mer1rs/hRw=;
	b=C9n4lLYTyW8m+oJGEbe+cIJG2OXyT8KgB3X9cn82+C0lAykfyVHXwuem5POohTZBREZH/6
	MFCOiBxCjNbyJpKmW7vSmaeUf0rSqAO7UmKJfXMOolVgBSyIt3pwDRdd5G4oI019i+VTQ7
	ytMywBuxK78mvRChO8IywXyOsI5joTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705943593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BcI2f1DWEvDi/Qr4PdTFHB53Q+BL3Gr3mer1rs/hRw=;
	b=U0E03061dl5X3HrGBv/nhNNE914wcs2KdfKnO+tCuxm38bDCVVe5+ImJMy6biDZjFKe2vg
	/F3ntfVeySBOF+Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705943593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BcI2f1DWEvDi/Qr4PdTFHB53Q+BL3Gr3mer1rs/hRw=;
	b=C9n4lLYTyW8m+oJGEbe+cIJG2OXyT8KgB3X9cn82+C0lAykfyVHXwuem5POohTZBREZH/6
	MFCOiBxCjNbyJpKmW7vSmaeUf0rSqAO7UmKJfXMOolVgBSyIt3pwDRdd5G4oI019i+VTQ7
	ytMywBuxK78mvRChO8IywXyOsI5joTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705943593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BcI2f1DWEvDi/Qr4PdTFHB53Q+BL3Gr3mer1rs/hRw=;
	b=U0E03061dl5X3HrGBv/nhNNE914wcs2KdfKnO+tCuxm38bDCVVe5+ImJMy6biDZjFKe2vg
	/F3ntfVeySBOF+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6909A136A4;
	Mon, 22 Jan 2024 17:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6VL5GCmirmWqDAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 22 Jan 2024 17:13:13 +0000
Message-ID: <ac0ce290-58a7-42b2-a7e4-72e241717c63@suse.cz>
Date: Mon, 22 Jan 2024 18:13:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/slub: directly load freelist from cpu partial slab
 in the likely case
Content-Language: en-US
To: Chengming Zhou <zhouchengming@bytedance.com>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
 <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com>
 <76641777-1918-2b29-b6aa-bda9b5467aa3@gentwo.org>
 <412b8618-0941-4d9d-85df-ee480695e7f7@bytedance.com>
 <a2132c63-99a5-7fa2-9f2a-cccf6b40fe9e@linux.com>
 <e81d914b-8718-4dbb-a2d8-d5298fe66d1a@bytedance.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <e81d914b-8718-4dbb-a2d8-d5298fe66d1a@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C9n4lLYT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U0E03061
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,lge.com,kernel.org,linux-foundation.org,linux.dev,google.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 81E3B22088
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO

On 1/19/24 04:53, Chengming Zhou wrote:
> On 2024/1/19 06:14, Christoph Lameter (Ampere) wrote:
>> On Thu, 18 Jan 2024, Chengming Zhou wrote:
>> 
>>> So get_freelist() has two cases to handle: cpu slab and cpu partial list slab.
>>> The latter is NOT frozen, so need to remove "VM_BUG_ON(!new.frozen)" from it.
>> 
>> Right so keep the check if it is the former?
>> 
> 
> Ok, I get it. Maybe like this:

I think that's just too ugly for a VM_BUG_ON(). I'd just remove the check
and be done with that.

I have a somewhat different point. You reused get_freelist() but in fact
it's more like freeze_slab(), but that one uses slab_update_freelist() and
we are under the local_lock so we want the cheaper __slab_update_freelist(),
which get_freelist() has and I guess that's why you reused that one.

However get_freelist() also assumes it can return NULL if the freelist is
empty. If that's possible to happen on the percpu partial list, we should
not "goto load_freelist;" but rather create a new label above that, above
the "if (!freelist) {" block that handles the case.

If that's not possible to happen (needs careful audit) and we have guarantee
that slabs on percpu partial list must have non-empty freelist, then we
probably instead want a new __freeze_slab() variant that is like
freeze_slab(), but uses __slab_update_freelist() and probably also has
VM_BUG_ON(!freelist) before returning it?

> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..7fa9dbc2e938 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3313,7 +3313,7 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
>   *
>   * If this function returns NULL then the slab has been unfrozen.
>   */
> -static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
> +static inline void *get_freelist(struct kmem_cache *s, struct slab *slab, int frozen)
>  {
>         struct slab new;
>         unsigned long counters;
> @@ -3326,7 +3326,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
>                 counters = slab->counters;
> 
>                 new.counters = counters;
> -               VM_BUG_ON(!new.frozen);
> +               VM_BUG_ON(frozen && !new.frozen);
> 
>                 new.inuse = slab->objects;
>                 new.frozen = freelist != NULL;
> @@ -3440,7 +3440,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>         if (freelist)
>                 goto load_freelist;
> 
> -       freelist = get_freelist(s, slab);
> +       freelist = get_freelist(s, slab, 1);
> 
>         if (!freelist) {
>                 c->slab = NULL;
> @@ -3498,18 +3498,19 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> 
>                 slab = slub_percpu_partial(c);
>                 slub_set_percpu_partial(c, slab);
> -               local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -               stat(s, CPU_PARTIAL_ALLOC);
> 
> -               if (unlikely(!node_match(slab, node) ||
> -                            !pfmemalloc_match(slab, gfpflags))) {
> -                       slab->next = NULL;
> -                       __put_partials(s, slab);
> -                       continue;
> +               if (likely(node_match(slab, node) &&
> +                          pfmemalloc_match(slab, gfpflags))) {
> +                       c->slab = slab;
> +                       freelist = get_freelist(s, slab, 0);
> +                       stat(s, CPU_PARTIAL_ALLOC);
> +                       goto load_freelist;
>                 }
> 
> -               freelist = freeze_slab(s, slab);
> -               goto retry_load_slab;
> +               local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> +
> +               slab->next = NULL;
> +               __put_partials(s, slab);
>         }
>  #endif


