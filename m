Return-Path: <linux-kernel+bounces-16401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5760823DED
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6281C228C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C071EA7D;
	Thu,  4 Jan 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1TRI/m90";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CA1G1rqE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1TRI/m90";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CA1G1rqE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA631E51F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8DA501F7F6;
	Thu,  4 Jan 2024 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704358322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2YJJ/wHF3T/z8OvARyhcqLm9IAHtRiaRn7YI2Y5QEw=;
	b=1TRI/m90ROrYdJZsQaXHP/1gHytvXKxr5PQ1CJXiURHxAO8NrbfjR7CklOn0hrg3bqLb8X
	rt3ZmF0KKMqv2cu84k5piyh/4xveQvGvXrXIhSeeLbepzLnH4GaRUE4P/egSyxTlaZIdhi
	aTM0Jdo/kZBKMF071V2MKSmEPFOfLtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704358322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2YJJ/wHF3T/z8OvARyhcqLm9IAHtRiaRn7YI2Y5QEw=;
	b=CA1G1rqEwBXCavUcVP9PAxQth9MeLV2sVC0gf84o8wAPJEQPnviR8yqy8tloJL3q6I91RW
	hGMlFYWSY9FJh8Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704358322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2YJJ/wHF3T/z8OvARyhcqLm9IAHtRiaRn7YI2Y5QEw=;
	b=1TRI/m90ROrYdJZsQaXHP/1gHytvXKxr5PQ1CJXiURHxAO8NrbfjR7CklOn0hrg3bqLb8X
	rt3ZmF0KKMqv2cu84k5piyh/4xveQvGvXrXIhSeeLbepzLnH4GaRUE4P/egSyxTlaZIdhi
	aTM0Jdo/kZBKMF071V2MKSmEPFOfLtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704358322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e2YJJ/wHF3T/z8OvARyhcqLm9IAHtRiaRn7YI2Y5QEw=;
	b=CA1G1rqEwBXCavUcVP9PAxQth9MeLV2sVC0gf84o8wAPJEQPnviR8yqy8tloJL3q6I91RW
	hGMlFYWSY9FJh8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF48913722;
	Thu,  4 Jan 2024 08:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QM5NL7FxlmW7VQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jan 2024 08:52:01 +0000
Date: Thu, 4 Jan 2024 09:52:53 +0100
From: Oscar Salvador <osalvador@suse.de>
To: andrey.konovalov@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v4 17/22] lib/stackdepot: allow users to evict stack
 traces
Message-ID: <ZZZx5TpqioairIMP@localhost.localdomain>
References: <cover.1700502145.git.andreyknvl@google.com>
 <1d1ad5692ee43d4fc2b3fd9d221331d30b36123f.1700502145.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d1ad5692ee43d4fc2b3fd9d221331d30b36123f.1700502145.git.andreyknvl@google.com>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,google.com,suse.cz,googlegroups.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -3.10
X-Spam-Flag: NO

On Mon, Nov 20, 2023 at 06:47:15PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add stack_depot_put, a function that decrements the reference counter
> on a stack record and removes it from the stack depot once the counter
> reaches 0.
> 
> Internally, when removing a stack record, the function unlinks it from
> the hash table bucket and returns to the freelist.
> 
> With this change, the users of stack depot can call stack_depot_put
> when keeping a stack trace in the stack depot is not needed anymore.
> This allows avoiding polluting the stack depot with irrelevant stack
> traces and thus have more space to store the relevant ones before the
> stack depot reaches its capacity.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

I yet have to review the final bits of this series, but I'd like to
comment on something below

  
> +void stack_depot_put(depot_stack_handle_t handle)
> +{
> +	struct stack_record *stack;
> +	unsigned long flags;
> +
> +	if (!handle || stack_depot_disabled)
> +		return;
> +
> +	write_lock_irqsave(&pool_rwlock, flags);
> +
> +	stack = depot_fetch_stack(handle);
> +	if (WARN_ON(!stack))
> +		goto out;
> +
> +	if (refcount_dec_and_test(&stack->count)) {
> +		/* Unlink stack from the hash table. */
> +		list_del(&stack->list);
> +
> +		/* Free stack. */
> +		depot_free_stack(stack);

It would be great if stack_depot_put would also accept a boolean,
which would determine whether we want to erase the stack or not.

For the feature I'm working on page_ower [1], I need to keep track
of how many times we allocated/freed from a certain path, which may
expose a potential leak, and I was using the refcount to do that,
but I don't want the record to be erased, because this new
functionality won't be exclusive with the existing one.

e.g:  you can check /sys/kernel/debug/page_owner AND
/sys/kernel/debug/page_owner_stacks

So, while the new functionaliy won't care if a record has been erased,
the old one will, so information will be lost.

[1] https://patchwork.kernel.org/project/linux-mm/cover/20231120084300.4368-1-osalvador@suse.de/

 

-- 
Oscar Salvador
SUSE Labs

