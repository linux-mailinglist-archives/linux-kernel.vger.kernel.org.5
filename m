Return-Path: <linux-kernel+bounces-88659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 170C886E4EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6824283E42
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6791A70AF5;
	Fri,  1 Mar 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UIgSXCo/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jMkoRH2D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UIgSXCo/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jMkoRH2D"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EF38DC3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309042; cv=none; b=cYGC2KevkE3i1qZeCkc912wmBrKdDRaxTZPMwRYLFElLg8N3umDuQMuVIsDx0Nno1LaUbKCksK6oRmZg4wHI5C63ovyICqcdSTx4e/9lc6UaSzURNY25+tT4TTWPtcu7Nyy7Iitaj7pcSzXIuQWXvu2NmV+EsdTiS+UuZSEK7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309042; c=relaxed/simple;
	bh=HZCnirsXZ9rn1IThWaKHVxVS5cA3jDCKr5aryDmWi2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAQxSKPBW/uv4w3eQXKPW/I2ElBCr929Kk3f1gcyElfLIRHEHPJJHV3V7dPvQrZQtxjTODLeu3uwyiX/LGeHPp9x9GiJS2ObJWA4wnHz8J3CQ1ewHBf+FP0SEBckWLM0QeOwHgV4SOTupruWOvs2QbNeJ79+F9TaQjTf48K8gA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UIgSXCo/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jMkoRH2D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UIgSXCo/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jMkoRH2D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA267206D7;
	Fri,  1 Mar 2024 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709309038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjR6OvQiPcuCw93mAUfU7kJQwKpvjY1JrTdttou/ro4=;
	b=UIgSXCo/2RInJegpmI12RiPD+Dls2VU4xtaUVNW2fZsRGE3A/qfxp7qD5m5thox+LDrosy
	8FKwMuk3qW3EPQXHALZ+EjVJSaYXk3ylMnvGc2ROhlWJmgTCMckdq49tYQYEGnF/JOdoLH
	FvhK3XkSStfgltINgYQ2K/+P0UjHp2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709309038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjR6OvQiPcuCw93mAUfU7kJQwKpvjY1JrTdttou/ro4=;
	b=jMkoRH2DN4FqIMQK3IJs1gDBY4dp8UkaCBaCtSGh7ojUuw3M/rRruKv3lnKVVXXbF5VgyF
	kwrWH+8HuqeLwBAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709309038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjR6OvQiPcuCw93mAUfU7kJQwKpvjY1JrTdttou/ro4=;
	b=UIgSXCo/2RInJegpmI12RiPD+Dls2VU4xtaUVNW2fZsRGE3A/qfxp7qD5m5thox+LDrosy
	8FKwMuk3qW3EPQXHALZ+EjVJSaYXk3ylMnvGc2ROhlWJmgTCMckdq49tYQYEGnF/JOdoLH
	FvhK3XkSStfgltINgYQ2K/+P0UjHp2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709309038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WjR6OvQiPcuCw93mAUfU7kJQwKpvjY1JrTdttou/ro4=;
	b=jMkoRH2DN4FqIMQK3IJs1gDBY4dp8UkaCBaCtSGh7ojUuw3M/rRruKv3lnKVVXXbF5VgyF
	kwrWH+8HuqeLwBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D94E13A80;
	Fri,  1 Mar 2024 16:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jgCPIW784WXQCAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 01 Mar 2024 16:03:58 +0000
Message-ID: <6594a42c-0f53-4124-9177-d1c631d9764f@suse.cz>
Date: Fri, 1 Mar 2024 17:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, slab: remove the corner case of inc_slabs_node()
Content-Language: en-US
To: chengming.zhou@linux.dev, cl@linux.com
Cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240222130233.2880176-1-chengming.zhou@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240222130233.2880176-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="UIgSXCo/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jMkoRH2D
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
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
	 FREEMAIL_CC(0.00)[kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 BAYES_HAM(-0.00)[39.38%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: AA267206D7
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/22/24 14:02, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <chengming.zhou@linux.dev>
> 
> We already have the inc_slabs_node() after kmem_cache_node->node[node]
> initialized in early_kmem_cache_node_alloc(), this special case of
> inc_slabs_node() can be removed. Then we don't need to consider the
> existence of kmem_cache_node in inc_slabs_node() anymore.
> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>

Well spotted, thank. Added to slab/for-next.

> ---
>  mm/slub.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 284b751b3b64..3f413e5e1415 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1500,16 +1500,8 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
>  {
>  	struct kmem_cache_node *n = get_node(s, node);
>  
> -	/*
> -	 * May be called early in order to allocate a slab for the
> -	 * kmem_cache_node structure. Solve the chicken-egg
> -	 * dilemma by deferring the increment of the count during
> -	 * bootstrap (see early_kmem_cache_node_alloc).
> -	 */
> -	if (likely(n)) {
> -		atomic_long_inc(&n->nr_slabs);
> -		atomic_long_add(objects, &n->total_objects);
> -	}
> +	atomic_long_inc(&n->nr_slabs);
> +	atomic_long_add(objects, &n->total_objects);
>  }
>  static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
>  {
> @@ -4877,7 +4869,6 @@ static void early_kmem_cache_node_alloc(int node)
>  	slab = new_slab(kmem_cache_node, GFP_NOWAIT, node);
>  
>  	BUG_ON(!slab);
> -	inc_slabs_node(kmem_cache_node, slab_nid(slab), slab->objects);
>  	if (slab_nid(slab) != node) {
>  		pr_err("SLUB: Unable to allocate memory from node %d\n", node);
>  		pr_err("SLUB: Allocating a useless per node structure in order to be able to continue\n");


