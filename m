Return-Path: <linux-kernel+bounces-77991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10359860DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B6528297A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA158AAB;
	Fri, 23 Feb 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cKM/C5X3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O6qgLgW0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cKM/C5X3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O6qgLgW0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276D718E1F
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679859; cv=none; b=QQXb4zbV+Qzr/PnuB6kgPvNzu48s6U3fokVUTWRHJheXDXI/MhlbDjbp3eni0zU5ljShSfJb2uHHekq7rVDQ6y48q+X1/csx1DV7l1/x9DVv1h9EWjy+85UsD8hgNlJrF5z315jgkcGGV2ZH7ZTg1PKpgxW0ZIquuOY8zIL15MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679859; c=relaxed/simple;
	bh=bBpUvRz4jzIfBpeAc2MGFG6qJxg+nRE4aTUlQzNQG+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbDygH2LSCP4jrOp2qN8u5gDWoUllAYH3s642pxRH9GzF2qScsX0WxJzaJ3w8cGWpeSe3fDKq3TNdaZm2YCuJU9MzcFqSLvqbIfNOCg424z1yfjOD6gV8y8GF7kHej/TWr3fFs/xFLvpGlusqtiV7u1fL2mnrtZsy7kt93ZvhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cKM/C5X3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O6qgLgW0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cKM/C5X3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O6qgLgW0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D0E41F7BB;
	Fri, 23 Feb 2024 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708679855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1E08ED/SIRC2CIXdssJDPc0dm5jCrOKVgwTjcOeBhWY=;
	b=cKM/C5X31C9+86zsnTX3vbJOj+4yJEi/v6P255m07h4C2IwQYbza9Tkza/P2EJBYhH7WoV
	1ufrMO0g4bXYKXkn3n8b3gLV53HwcUeMErPXEb7ZksUkq08MAwBF9h6PlKSWiBqHCkg2cy
	qMqdY9c8RxTWIYQAYl+GvL2Wdgxbcu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708679855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1E08ED/SIRC2CIXdssJDPc0dm5jCrOKVgwTjcOeBhWY=;
	b=O6qgLgW0KJWm8nfaqMsQMCjqkc4wikv4wcVzTZSyv+uAuAGx0fWTFWMMHeCIYAsD+ECXJh
	w2sijSYM/JAmENAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708679855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1E08ED/SIRC2CIXdssJDPc0dm5jCrOKVgwTjcOeBhWY=;
	b=cKM/C5X31C9+86zsnTX3vbJOj+4yJEi/v6P255m07h4C2IwQYbza9Tkza/P2EJBYhH7WoV
	1ufrMO0g4bXYKXkn3n8b3gLV53HwcUeMErPXEb7ZksUkq08MAwBF9h6PlKSWiBqHCkg2cy
	qMqdY9c8RxTWIYQAYl+GvL2Wdgxbcu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708679855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1E08ED/SIRC2CIXdssJDPc0dm5jCrOKVgwTjcOeBhWY=;
	b=O6qgLgW0KJWm8nfaqMsQMCjqkc4wikv4wcVzTZSyv+uAuAGx0fWTFWMMHeCIYAsD+ECXJh
	w2sijSYM/JAmENAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3F59132C7;
	Fri, 23 Feb 2024 09:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JVgDO65i2GUiRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 09:17:34 +0000
Message-ID: <4a8aa758-175e-471c-9c22-bb61dbb956e8@suse.cz>
Date: Fri, 23 Feb 2024 10:17:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>,
 "Christoph Lameter (Ampere)" <cl@linux.com>,
 Chengming Zhou <chengming.zhou@linux.dev>
Cc: David Rientjes <rientjes@google.com>, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
 <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
 <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <93497e03-1acf-483e-8695-e103fd1bc044@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <93497e03-1acf-483e-8695-e103fd1bc044@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="cKM/C5X3";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O6qgLgW0
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[google.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1D0E41F7BB
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO

On 2/23/24 08:36, Jianfeng Wang wrote:
> 
> On 2/22/24 7:02 PM, Christoph Lameter (Ampere) wrote:
>> On Thu, 22 Feb 2024, Chengming Zhou wrote:
>> 
>>> Anyway, I put the code below for discussion...
>> 
>> Can we guestimate the free objects based on the number of partial slabs. That number is available.
>> 
> 
> Yes.
> I've thought about calculating the average number of free objects in a
> partial slab (through sampling) and then estimating the total number of
> free objects as (avg * n->nr_partial).
> 
> See the following.
> 
> ---
>  mm/slub.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 63d281dfacdb..13385761049c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2963,6 +2963,8 @@ static inline bool free_debug_processing(struct kmem_cache *s,
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
> +#define MAX_PARTIAL_TO_SCAN 10000
> +
>  static unsigned long count_partial(struct kmem_cache_node *n,
>  					int (*get_count)(struct slab *))
>  {
> @@ -2971,8 +2973,22 @@ static unsigned long count_partial(struct kmem_cache_node *n,
>  	struct slab *slab;
>  
>  	spin_lock_irqsave(&n->list_lock, flags);
> -	list_for_each_entry(slab, &n->partial, slab_list)
> -		x += get_count(slab);
> +	if (n->nr_partial > MAX_PARTIAL_TO_SCAN) {
> +		/* Estimate total count of objects via sampling */
> +		unsigned long sample_rate = n->nr_partial / MAX_PARTIAL_TO_SCAN;
> +		unsigned long scanned = 0;
> +		unsigned long counted = 0;
> +		list_for_each_entry(slab, &n->partial, slab_list) {

Unfortunately this is still going through the whole list.

> +			if (++scanned % sample_rate == 0) {
> +				x += get_count(slab);

The get_count() itself is trivial, so this won't help much.
(except saving a function call which can be noticeable with all the
retpolines and other unfortunate stuff these days; we could refactor the
code to be inline, but processing the whole long list would still be an issue).

So this would have to instead count first up to MAX_PARTIAL_TO_SCAN slabs
and then terminate the loop. This can make the sampling biased, unfortunately.

> +				counted++;
> +			}
> +		}
> +		x = mult_frac(x, n->nr_partial, counted);
> +	} else {
> +		list_for_each_entry(slab, &n->partial, slab_list)
> +			x += get_count(slab);
> +	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return x;
>  }


