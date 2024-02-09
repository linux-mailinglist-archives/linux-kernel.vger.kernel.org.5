Return-Path: <linux-kernel+bounces-60052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1BF84FF41
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECBE28D1C7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7601B942;
	Fri,  9 Feb 2024 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o3Aqh1my";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGctspPZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o3Aqh1my";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IGctspPZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98363B8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515506; cv=none; b=VASdcRhuJEbSLGOIvyL6hkaKBuBQPxZyj/RVl2B2AB2+t1XlMnafALSky9ol7kABTQ76yI1iPEmOT/66pu6avv7BllqA+42yHb7BBjlxYWnbrricAW7h6HipaJDVnMQ9JmrSLB0t263mfuYblNN2X56xyFN7r2+9pcaa65eao48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515506; c=relaxed/simple;
	bh=Pr9D+fptCBeC23igqt5i7qdv9JbM3rvuP78jW1t7QzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzNYMdlJ/xyKfQPDQJI4T8qcGfp9zJkWATZzZBOY52JFiyFg8UXLMFFG2mVQSF9oetcnNrYkqu6ehW+U5j+VywXLPlZq3zKK+DJqtjk7TtvWj+ZdXGOzpoteXeeeJUI4bfePb3meaNd7mJSgCSsUcKIS4i3wU8uRgvX+XawNr44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o3Aqh1my; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGctspPZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o3Aqh1my; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IGctspPZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C96D1F834;
	Fri,  9 Feb 2024 21:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707515502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DefqWIsK/Bt8MttPzkKY/ykhXHgBYzfo86LWXkmEtbQ=;
	b=o3Aqh1myufMoF8LFhNC8pbhmUZ6BoHteOhIaZvTfnOnDx9Kwc6i59X07xJvJbCpx180mhD
	jPhlNvAnXzGUB80ZDX1kQpxt8NvORzZxihZPxzpbxaExyJCUELY3aH1dedqOXUsGTqMrNC
	BZ/WCd4IhmWoP7olQl5TP6Iz7A4SPFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707515502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DefqWIsK/Bt8MttPzkKY/ykhXHgBYzfo86LWXkmEtbQ=;
	b=IGctspPZ9dIM6Jy3X942CzbhvGx+EjT+YsV2l4EVuvA5BlcYiuOMGvEKfVItBOJ4TtYRTc
	+9+hawEQW3nboXBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707515502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DefqWIsK/Bt8MttPzkKY/ykhXHgBYzfo86LWXkmEtbQ=;
	b=o3Aqh1myufMoF8LFhNC8pbhmUZ6BoHteOhIaZvTfnOnDx9Kwc6i59X07xJvJbCpx180mhD
	jPhlNvAnXzGUB80ZDX1kQpxt8NvORzZxihZPxzpbxaExyJCUELY3aH1dedqOXUsGTqMrNC
	BZ/WCd4IhmWoP7olQl5TP6Iz7A4SPFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707515502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DefqWIsK/Bt8MttPzkKY/ykhXHgBYzfo86LWXkmEtbQ=;
	b=IGctspPZ9dIM6Jy3X942CzbhvGx+EjT+YsV2l4EVuvA5BlcYiuOMGvEKfVItBOJ4TtYRTc
	+9+hawEQW3nboXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6024139E7;
	Fri,  9 Feb 2024 21:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CfAHNG2exmWybAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 09 Feb 2024 21:51:41 +0000
Date: Fri, 9 Feb 2024 22:52:48 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v7 3/4] mm,page_owner: Display all stacks and their count
Message-ID: <ZcaesCP4mY-94ciJ@localhost.localdomain>
References: <20240208234539.19113-1-osalvador@suse.de>
 <20240208234539.19113-4-osalvador@suse.de>
 <CANpmjNNcPr=pPco_HN9nXBabubtfo02SAH=taZGNCvYDq42YUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNcPr=pPco_HN9nXBabubtfo02SAH=taZGNCvYDq42YUQ@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri, Feb 09, 2024 at 09:00:40AM +0100, Marco Elver wrote:
> > +/**
> > + * stack_depot_get_next_stack - Returns all stacks, one at a time
> 
> "Returns all stack_records" to be clear that this is returning the struct.

Fixed.


> 
> > + *
> > + * @table:     Current table we are checking
> > + * @bucket:    Current bucket we are checking
> > + * @last_found:        Last stack that was found
> > + *
> > + * This function finds first a non-empty bucket and returns the first stack
> > + * stored in it. On consequent calls, it walks the bucket to see whether
> > + * it contains more stacks.
> > + * Once we have walked all the stacks in a bucket, we check
> > + * the next one, and we repeat the same steps until we have checked all of them
> 
> I think for this function it's important to say that no entry returned
> from this function can be evicted.
> 
> I.e. the easiest way to ensure this is that the caller makes sure the
> entries returned are never passed to stack_depot_put() - which is
> certainly the case for your usecase because you do not use
> stack_depot_put().
> 
> > + * Return: A pointer a to stack_record struct, or NULL when we have walked all
> > + * buckets.
> > + */
> > +struct stack_record *stack_depot_get_next_stack(unsigned long *table,
> 
> To keep consistent, I'd also call this
> __stack_depot_get_next_stack_record(), so that we're clear this is
> more of an internal function not for general usage.
> 
> > +                                               struct list_head **bucket,
> > +                                               struct stack_record **last_found);
> > +
> >  /**
> >   * stack_depot_fetch - Fetch a stack trace from stack depot
> >   *
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index 197c355601f9..107bd0174cd6 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -782,6 +782,52 @@ unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
> >  }
> >  EXPORT_SYMBOL(stack_depot_get_extra_bits);
> >
> > +struct stack_record *stack_depot_get_next_stack(unsigned long *table,
> > +                                               struct list_head **curr_bucket,
> > +                                               struct stack_record **last_found)
> > +{
> > +       struct list_head *bucket = *curr_bucket;
> > +       unsigned long nr_table = *table;
> > +       struct stack_record *found = NULL;
> > +       unsigned long stack_table_entries = stack_hash_mask + 1;
> > +
> > +       rcu_read_lock_sched_notrace();
> 
> We are returning pointers to stack_records out of the RCU-read
> critical section, which are then later used to continue the iteration.
> list_for_each_entry_continue_rcu() says this is fine if "... you held
> some sort of non-RCU reference (such as a reference count) ...".
> Updating the function's documentation to say none of these entries can
> be evicted via a stack_depot_put() is required.

Thinking about it some more, I think I made a mistake:

I am walking all buckets, and within those buckets there are not only
page_owner stack_records, which means that I could return a stack_record
from e.g: KASAN (which I think can evict stack_records) and then
everything goes off the rails.
Which means I cannot walk the buckets like that.

Actually, I think that having something like the following

 struct list_stack_records {
      struct stack_record *stack;
      struct list_stack_records *next;
 }

in page_owner would make sense.
Then the only thing I would have to do is to add a new record on every
new stack_record, and then I could just walk the list like a linked
list.

Which means that the function stack_depot_get_next_stack() could be
killed because everything would happen in page_owner code.

e.g:

 static void inc_stack_record_count(depot_stack_handle_t handle)
 {
         struct stack_record *stack = __stack_depot_get_stack_record(handle);
 
         if (stack) {
                 /*
                  * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
                  * with REFCOUNT_SATURATED to catch spurious increments of their
                  * refcount.
                  * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us
                  * set a refcount of 1 ourselves.
                  */
                 if (refcount_read(&stack->count) == REFCOUNT_SATURATED) {
                         refcount_set(&stack->count, 1);
			 add_new_stack_record_into_the_list(stack)
		 }
                 refcount_inc(&stack->count);
         }
 }

and then just walk the list_stack_records list whenever we want to
show the stacktraces and their counting.

I think that overall this approach is cleaner and safer.

-- 
Oscar Salvador
SUSE Labs

