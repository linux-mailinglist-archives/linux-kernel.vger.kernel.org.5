Return-Path: <linux-kernel+bounces-35118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA16838C61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0FD1F2915A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8075C8F0;
	Tue, 23 Jan 2024 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iIQj/O7K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wVhHOvKK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iIQj/O7K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wVhHOvKK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDB5C8EA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006721; cv=none; b=Bp5uyZIOIZG1zYNuSEjKCm5JazYGGI3kSjOy7ZSh36rum1V+95zB/YwejvGWMwyPOO7j6Xzb8QBFZif4Fu6YyBkpv/SsILXq9PoW9d0oYtOG0TqCLvYMg9Rp2e/pESrJEC01v6CU858dtgJb8U+bt2UcLhBk8iHIHNOtg7HadAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006721; c=relaxed/simple;
	bh=2eMXaf6dULvi1BWEq+jE8JXbIt+P5SulgaYJpE7SUZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEMrvSVM3e9qpMcQuEnEj8/KHRqDH4yyjoMdfDqwNIvrAffp6dClbM9JPV0DFkrDI9OqnV8IVO4GEDiJkEW8rhtN4po28i+IH3guOsaElvBS5rM01rH4NNWlZYqY38KavW/dWkbVmZRvrs70Pqpp8G7Ro5g+X+r+JioNKQNti8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iIQj/O7K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wVhHOvKK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iIQj/O7K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wVhHOvKK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5570622010;
	Tue, 23 Jan 2024 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706006717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mih7XdVI+Iwz3YuWyyMA7tblNDBveldYhxzqx9RD90Y=;
	b=iIQj/O7K8yGgQSqQeR6sEk000e9de5gXOXyGQbA8pwWDd3iIxOXA5s+0Yod6Eh046KRsfS
	Xi4E1p6hvBh3d7fDd8GHhq20NNqQr6yv/Iu197BOA9LlkcGFOuIumRsk2IWe4vIIMqO4Cy
	65PPj+p8/y5mMBxias2hZ9NdvWD5iIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706006717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mih7XdVI+Iwz3YuWyyMA7tblNDBveldYhxzqx9RD90Y=;
	b=wVhHOvKKsrooVKt+L5rDFHhLtuVtzVZBeivax6H3VIM9LV6V6lvE1lwy911jTF+pLuzj5R
	R8kIY5Qd2lIAWMAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706006717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mih7XdVI+Iwz3YuWyyMA7tblNDBveldYhxzqx9RD90Y=;
	b=iIQj/O7K8yGgQSqQeR6sEk000e9de5gXOXyGQbA8pwWDd3iIxOXA5s+0Yod6Eh046KRsfS
	Xi4E1p6hvBh3d7fDd8GHhq20NNqQr6yv/Iu197BOA9LlkcGFOuIumRsk2IWe4vIIMqO4Cy
	65PPj+p8/y5mMBxias2hZ9NdvWD5iIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706006717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mih7XdVI+Iwz3YuWyyMA7tblNDBveldYhxzqx9RD90Y=;
	b=wVhHOvKKsrooVKt+L5rDFHhLtuVtzVZBeivax6H3VIM9LV6V6lvE1lwy911jTF+pLuzj5R
	R8kIY5Qd2lIAWMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3378A13786;
	Tue, 23 Jan 2024 10:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qjo7DL2Yr2UrHwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 23 Jan 2024 10:45:17 +0000
Message-ID: <05413732-9225-4b3b-8d3e-d5fc7eb4d796@suse.cz>
Date: Tue, 23 Jan 2024 11:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/slub: directly load freelist from cpu partial
 slab in the likely case
Content-Language: en-US
To: Chengming Zhou <zhouchengming@bytedance.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg
 <penberg@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240117-slab-misc-v2-0-81766907896e@bytedance.com>
 <20240117-slab-misc-v2-1-81766907896e@bytedance.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240117-slab-misc-v2-1-81766907896e@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="iIQj/O7K";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wVhHOvKK
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[bytedance.com,lge.com,google.com,linux.dev,kernel.org,linux.com,linux-foundation.org,gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: 5570622010
X-Spam-Flag: NO

On 1/23/24 10:33, Chengming Zhou wrote:
> The likely case is that we get a usable slab from the cpu partial list,
> we can directly load freelist from it and return back, instead of going
> the other way that need more work, like reenable interrupt and recheck.
> 
> But we need to remove the "VM_BUG_ON(!new.frozen)" in get_freelist()
> for reusing it, since cpu partial slab is not frozen. It seems
> acceptable since it's only for debug purpose.
> 
> And get_freelist() also assumes it can return NULL if the freelist is
> empty, which is not possible for the cpu partial slab case, so we
> add "VM_BUG_ON(!freelist)" after get_freelist() to make it explicit.
> 
> There is some small performance improvement too, which shows by:
> perf bench sched messaging -g 5 -t -l 100000
> 
>             mm-stable   slub-optimize
> Total time      7.473    7.209
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

I'm including the series to slab/for-6.9/optimize-get-freelist and
slab/for-next, thanks!

> ---
>  mm/slub.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2ef88bbf56a3..fda402b2d649 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3326,7 +3326,6 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
>  		counters = slab->counters;
>  
>  		new.counters = counters;
> -		VM_BUG_ON(!new.frozen);
>  
>  		new.inuse = slab->objects;
>  		new.frozen = freelist != NULL;
> @@ -3498,18 +3497,20 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  
>  		slab = slub_percpu_partial(c);
>  		slub_set_percpu_partial(c, slab);
> -		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -		stat(s, CPU_PARTIAL_ALLOC);
>  
> -		if (unlikely(!node_match(slab, node) ||
> -			     !pfmemalloc_match(slab, gfpflags))) {
> -			slab->next = NULL;
> -			__put_partials(s, slab);
> -			continue;
> +		if (likely(node_match(slab, node) &&
> +			   pfmemalloc_match(slab, gfpflags))) {
> +			c->slab = slab;
> +			freelist = get_freelist(s, slab);
> +			VM_BUG_ON(!freelist);
> +			stat(s, CPU_PARTIAL_ALLOC);
> +			goto load_freelist;
>  		}
>  
> -		freelist = freeze_slab(s, slab);
> -		goto retry_load_slab;
> +		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> +
> +		slab->next = NULL;
> +		__put_partials(s, slab);
>  	}
>  #endif
>  
> 


