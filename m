Return-Path: <linux-kernel+bounces-34933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7C983896A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9F31C252ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8353A58118;
	Tue, 23 Jan 2024 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NNueRp6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="miJ+7ejN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NNueRp6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="miJ+7ejN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA458100
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999629; cv=none; b=b5ApteOxGFaQ2dnhmGcPZmZzlKx3lP88E0w8FwKphVhlRlev+/UXYrPnyHjIUFRwTMddGpL6yDAfVBH4GrVlrtKDfa7Ym6BxB9Ki1avcDg3l1eHe+ZG/YYOFWF8RIUaWRK5Jw2VxLU1b6vLSDPloK1llF9IhZCUqTtcymT24bS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999629; c=relaxed/simple;
	bh=4CZkeS6/9cQ1MLGFI8MB7eATcIqqJ9ZcD/Y6He7WjZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oikQdNggMNmTYdx3uoV0TOM2PwwQTJ0YqrKrPWsWBS2FlARDyHsHRAeZV8tnrDbzCC2wP4+ioYM0GIBQ1ZXfCTA+MdFBIvhBR5TnFnlTZRbggzXnXzS3dN1ANnZuSMm7HDUeg2++8NhpJ0CyVj6wBpF8VbkFrZ/3NCa9JA6FkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NNueRp6z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=miJ+7ejN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NNueRp6z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=miJ+7ejN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 644DB1FD41;
	Tue, 23 Jan 2024 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705999626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htWxjEPlRTMSVWB8Sh/hvcNr95OXa69lLJnBD35ruig=;
	b=NNueRp6zLKqZccW5qvjgPo5NqtwuMPuxENJc5+I/JsI5Cq2Dr8zGX2YStntrl28bur7kDR
	DtIGq7lUB9VGvROw+x2ku91eiRH6SZh0HiC4TjS8aXwJYaQUZJwtUrLkK8lfvKXFayrig1
	oHVGopC/oEXVfKSrRww0Dy/ZytUB35s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705999626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htWxjEPlRTMSVWB8Sh/hvcNr95OXa69lLJnBD35ruig=;
	b=miJ+7ejNtqlgblX0KWOl0cmzvTLIFZFD2vUNIQeh2YlTYbLsfEi1c84kPj8GxGpzAN2dS/
	bMYqRLqPINEWiwDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705999626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htWxjEPlRTMSVWB8Sh/hvcNr95OXa69lLJnBD35ruig=;
	b=NNueRp6zLKqZccW5qvjgPo5NqtwuMPuxENJc5+I/JsI5Cq2Dr8zGX2YStntrl28bur7kDR
	DtIGq7lUB9VGvROw+x2ku91eiRH6SZh0HiC4TjS8aXwJYaQUZJwtUrLkK8lfvKXFayrig1
	oHVGopC/oEXVfKSrRww0Dy/ZytUB35s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705999626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=htWxjEPlRTMSVWB8Sh/hvcNr95OXa69lLJnBD35ruig=;
	b=miJ+7ejNtqlgblX0KWOl0cmzvTLIFZFD2vUNIQeh2YlTYbLsfEi1c84kPj8GxGpzAN2dS/
	bMYqRLqPINEWiwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D76E13786;
	Tue, 23 Jan 2024 08:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V5WOEgp9r2UcdwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 23 Jan 2024 08:47:06 +0000
Message-ID: <d7d1af6f-3a98-4c9a-bb39-c8f98b41a2e8@suse.cz>
Date: Tue, 23 Jan 2024 09:47:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm/slub: remove unused parameter in
 next_freelist_entry()
Content-Language: en-US
To: Chengming Zhou <zhouchengming@bytedance.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
 <20240117-slab-misc-v1-3-fd1c49ccbe70@bytedance.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240117-slab-misc-v1-3-fd1c49ccbe70@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NNueRp6z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=miJ+7ejN
X-Spamd-Result: default: False [1.20 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[bytedance.com,gmail.com,lge.com,linux.com,kernel.org,linux-foundation.org,linux.dev,google.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[15.51%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: 644DB1FD41
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 1/17/24 12:46, Chengming Zhou wrote:
> The parameter "struct slab *slab" is unused in next_freelist_entry(),
> so just remove it.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f0307e8b4cd2..3a4e2f8d341c 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2243,7 +2243,7 @@ static void __init init_freelist_randomization(void)
>  }
>  
>  /* Get the next entry on the pre-computed freelist randomized */
> -static void *next_freelist_entry(struct kmem_cache *s, struct slab *slab,
> +static void *next_freelist_entry(struct kmem_cache *s,
>  				unsigned long *pos, void *start,
>  				unsigned long page_limit,
>  				unsigned long freelist_count)
> @@ -2282,13 +2282,12 @@ static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
>  	start = fixup_red_left(s, slab_address(slab));
>  
>  	/* First entry is used as the base of the freelist */
> -	cur = next_freelist_entry(s, slab, &pos, start, page_limit,
> -				freelist_count);
> +	cur = next_freelist_entry(s, &pos, start, page_limit, freelist_count);
>  	cur = setup_object(s, cur);
>  	slab->freelist = cur;
>  
>  	for (idx = 1; idx < slab->objects; idx++) {
> -		next = next_freelist_entry(s, slab, &pos, start, page_limit,
> +		next = next_freelist_entry(s, &pos, start, page_limit,
>  			freelist_count);
>  		next = setup_object(s, next);
>  		set_freepointer(s, cur, next);
> 


