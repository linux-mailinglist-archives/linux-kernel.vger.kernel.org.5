Return-Path: <linux-kernel+bounces-104448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F38F87CE09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4811F220F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3D136AF0;
	Fri, 15 Mar 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vfA3ABJU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nU0KTRgt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vfA3ABJU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nU0KTRgt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967323611A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710508892; cv=none; b=JS9P0j+BIgHWCykk4CZqgoru6ENEPkUv6Cdjx2dG50S+FCj0RWyxsso7H682cUcCo7aoSimvw+J+/GyK2KX/rRTXy36lxl/nVvG15hDTopfzuqIA6e+xz/0qDK26ErrEVJCxruWFX49dVp3rXBMF1v1mYa6MjntJmg/yi++BZ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710508892; c=relaxed/simple;
	bh=zCQEqNlXlQg6ezeF7a3bY252Pyvca3zgnDLWNyexoTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VY/ym6081PHnjs5S+UgS1bqMyWzAL5PRtvn37uCxktlztDPZO2/Vc9Qnhlxk/NlKMkU+5qNoQRc2XGxT0LSFTFfq/rA/0JlWaGZtu01dgCZMslHvsbneRxA0Ws7kW1DUXWaut4Lt1bABs7fjVxITv97Vn0Wmp+zxJwCZoKr93kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vfA3ABJU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nU0KTRgt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vfA3ABJU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nU0KTRgt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF01F21CE0;
	Fri, 15 Mar 2024 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710508888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM5qUTSpsdqhoopyv5Nl5L/m1g1ZRFRMuEKSX1CHpM0=;
	b=vfA3ABJUOsjU5yG2qkfv70rSzuaixACVZ1QAS6qH7GF8gwRZnkg5+3FLiKa8edisV1gxJC
	erIJ+mPZQnFBPFUgkMGGYl0TWGydjgVSlQmLkkyP6qzEjVoz9CHexeP8uAs7ycSl1uJDba
	ENwNQ7wxOX9UYMjC0oWxNmYzrLYRJZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710508888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM5qUTSpsdqhoopyv5Nl5L/m1g1ZRFRMuEKSX1CHpM0=;
	b=nU0KTRgt9aP+kVvrOLBuql6/rDBFutEkr+5TdgEKZfoO4uF9oCbU1OFUWRSmqTv6ySJoQn
	xusvEhXbon80/hDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710508888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM5qUTSpsdqhoopyv5Nl5L/m1g1ZRFRMuEKSX1CHpM0=;
	b=vfA3ABJUOsjU5yG2qkfv70rSzuaixACVZ1QAS6qH7GF8gwRZnkg5+3FLiKa8edisV1gxJC
	erIJ+mPZQnFBPFUgkMGGYl0TWGydjgVSlQmLkkyP6qzEjVoz9CHexeP8uAs7ycSl1uJDba
	ENwNQ7wxOX9UYMjC0oWxNmYzrLYRJZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710508888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LM5qUTSpsdqhoopyv5Nl5L/m1g1ZRFRMuEKSX1CHpM0=;
	b=nU0KTRgt9aP+kVvrOLBuql6/rDBFutEkr+5TdgEKZfoO4uF9oCbU1OFUWRSmqTv6ySJoQn
	xusvEhXbon80/hDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99F8A1368C;
	Fri, 15 Mar 2024 13:21:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7YZBJVhL9GUTKAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Mar 2024 13:21:28 +0000
Message-ID: <7ea61161-4eee-47b2-9540-00805d906f50@suse.cz>
Date: Fri, 15 Mar 2024 14:21:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm,page_owner: Fix refcount imbalance
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240314144753.16276-1-osalvador@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240314144753.16276-1-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vfA3ABJU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nU0KTRgt
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-8.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -8.00
X-Rspamd-Queue-Id: AF01F21CE0
X-Spam-Flag: NO

On 3/14/24 15:47, Oscar Salvador wrote:
> Current code does not contemplate scenarios were an allocation and
> free operation on the same pages do not handle it in the same amount
> at once.
> To give an example, page_alloc_exact(), where we will allocate a page
> of enough order to stafisfy the size request, but we will free the
> remainings right away.
> 
> In the above example, we will increment the stack_record refcount
> only once, but we will decrease it the same number of times as number
> of unused pages we have to free.
> This will lead to a warning because of refcount imbalance.
> 
> Fix this by recording the number of base pages every stack_record holds,
> and only let the last decrementing of refcount succeed if the number of
> base pages equals 0, which means we freed all the pages.
> 
> As a bonus, show the aggregate of stack_count + base_pages as this gives
> a much better picture of the memory usage.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Fixes: 217b2119b9e2 ("mm,page_owner: implement the tracking of the stacks count")
> ---
>  include/linux/stackdepot.h |  3 ++
>  mm/page_owner.c            | 57 +++++++++++++++++++++++++++++++-------
>  2 files changed, 50 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 3c6caa5abc7c..261472807c32 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -57,6 +57,9 @@ struct stack_record {
>  	u32 size;			/* Number of stored frames */
>  	union handle_parts handle;	/* Constant after initialization */
>  	refcount_t count;
> +#ifdef CONFIG_PAGE_OWNER
> +	unsigned long nr_base_pages;
> +#endif

The stackdepot guys probably won't be thrilled about this addition to
stack_record. Can't we instead make the refcount itself reflect the number
of base pages?

..

> -static void dec_stack_record_count(depot_stack_handle_t handle)
> +static void dec_stack_record_count(depot_stack_handle_t handle,
> +				   unsigned long nr_base_pages)
>  {
>  	struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
> +	unsigned long curr_nr_pages;
> +
> +	if (!stack_record)
> +		return;
> +
> +	curr_nr_pages = smp_load_acquire(&stack_record->nr_base_pages);
> +	smp_store_release(&stack_record->nr_base_pages,
> +			  curr_nr_pages - nr_base_pages);

If the intent of this is to have stack_record->nr_base_pages updated
atomically with respect to parallel updates, these smp_ operations won't
help I'm afraid.

> +	curr_nr_pages = smp_load_acquire(&stack_record->nr_base_pages);
> +
> +	/*
> +	 * If this stack_record is going to reach a refcount == 1, which means
> +	 * free, only do it if all the base pages it allocated were freed.
> +	 * E.g: scenarios like THP splitting, or alloc_pages_exact() can have
> +	 * an alloc/free operation with different amount of pages
> +	 */
> +	if (refcount_read(&stack_record->count) == 2 &&
> +	    curr_nr_pages)
> +		return;

This is very suspicious. We shouldn't manipulate refcount based on the other
counter. This suggest the refcount will eventually stop reflecting reality
as we could withold some legitimate decreases and not retry them afterwards?
Another reason to try making refcount itself represent nr_base_pages.


>  
> -	if (stack_record)
> -		refcount_dec(&stack_record->count);
> +	refcount_dec(&stack_record->count);

This refcount_read() followed by refcount_dec() is also potentially racy.

>  }
>  
>  void __reset_page_owner(struct page *page, unsigned short order)
> @@ -260,7 +294,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
>  		 * the machinery is not ready yet, we cannot decrement
>  		 * their refcount either.
>  		 */
> -		dec_stack_record_count(alloc_handle);
> +		dec_stack_record_count(alloc_handle, 1UL << order);
>  }
>  
>  static inline void __set_page_owner_handle(struct page_ext *page_ext,
> @@ -303,7 +337,7 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
>  	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
>  	page_ext_put(page_ext);
>  	set_current_in_page_owner();
> -	inc_stack_record_count(handle, gfp_mask);
> +	inc_stack_record_count(handle, gfp_mask, 1UL << order);
>  	unset_current_in_page_owner();
>  }
>  
> @@ -868,6 +902,7 @@ static int stack_print(struct seq_file *m, void *v)
>  	struct stack *stack = v;
>  	unsigned long *entries;
>  	unsigned long nr_entries;
> +	unsigned long nr_base_pages;
>  	struct stack_record *stack_record = stack->stack_record;
>  
>  	if (!stack->stack_record)
> @@ -875,6 +910,7 @@ static int stack_print(struct seq_file *m, void *v)
>  
>  	nr_entries = stack_record->size;
>  	entries = stack_record->entries;
> +	nr_base_pages = stack_record->nr_base_pages;
>  	stack_count = refcount_read(&stack_record->count) - 1;
>  
>  	if (stack_count < 1 || stack_count < page_owner_stack_threshold)
> @@ -882,7 +918,8 @@ static int stack_print(struct seq_file *m, void *v)
>  
>  	for (i = 0; i < nr_entries; i++)
>  		seq_printf(m, " %pS\n", (void *)entries[i]);
> -	seq_printf(m, "stack_count: %d\n\n", stack_count);
> +	seq_printf(m, "stack_count: %d curr_nr_base_pages: %lu\n\n",
> +		   stack_count, nr_base_pages);
>  
>  	return 0;
>  }


