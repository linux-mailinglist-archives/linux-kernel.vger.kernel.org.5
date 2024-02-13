Return-Path: <linux-kernel+bounces-63260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA74F852CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB331F23AB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAE1224CF;
	Tue, 13 Feb 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aymr0q+w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gNHelfu4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aymr0q+w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gNHelfu4"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1952232A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817509; cv=none; b=lfpo3mu/zADnPWQHfB19s88yLAndjojgV3809PIHuYWruQW39njyk3yQYGKOtyuP6zQt1GG58Ur9ilCSgDZBgb1vc5jzvNStDUs//vglVJlHDXwsAzHlYH8oMGULOeOO1m4H6+2vZTwVUlxN4AfZ6CnLPE8SLnVemkmRElicyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817509; c=relaxed/simple;
	bh=mkZH9Obfhr18Yfn2abbUkhpoJuN4gXdK2EdgMimGXhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aom5PApHNHG+kE1dsiM13MhIC9Bpv/s9dINbheZOhjKnR6Y2iXMvyMr2m1tR+OoS/yQwduxSsUXlGbD0upGNTPbU2HLhSkDAIgA+tG3QmAi8PLwjc7fl9Eq2SE4UCVWi4gx1NEejHubjc9T78SJ2yrIZUe+AHxRJa8UL69Y6d0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aymr0q+w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gNHelfu4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aymr0q+w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gNHelfu4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43C4221EC3;
	Tue, 13 Feb 2024 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707817506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf5JCSm5xHFTDgu6ucr+10h4FlhjOy8LX9i26DB5P3w=;
	b=aymr0q+w9WYHVZK8FJiYcZiep3wQnxQGE6OmCObNLAletOynF2p1rXKDjpuYfaWvrH6yLr
	W5xCFNuLGdaDwrpF0OZK5riqnCOB+t7wzjXXUPYhZSqOHda/0HP0EKlma9w4z2opM7fq9V
	hQU/cnzPviXytY6QL6HCNM8EqTDvCzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707817506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf5JCSm5xHFTDgu6ucr+10h4FlhjOy8LX9i26DB5P3w=;
	b=gNHelfu47xGvBYqfPF+Gu6YIjbTapmJ+6T/Q6L/Bn+jJr4O53fIG6fq3UqvXBwprqLJmlT
	9Wv+e9QtnwRHCdDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707817506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf5JCSm5xHFTDgu6ucr+10h4FlhjOy8LX9i26DB5P3w=;
	b=aymr0q+w9WYHVZK8FJiYcZiep3wQnxQGE6OmCObNLAletOynF2p1rXKDjpuYfaWvrH6yLr
	W5xCFNuLGdaDwrpF0OZK5riqnCOB+t7wzjXXUPYhZSqOHda/0HP0EKlma9w4z2opM7fq9V
	hQU/cnzPviXytY6QL6HCNM8EqTDvCzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707817506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gf5JCSm5xHFTDgu6ucr+10h4FlhjOy8LX9i26DB5P3w=;
	b=gNHelfu47xGvBYqfPF+Gu6YIjbTapmJ+6T/Q6L/Bn+jJr4O53fIG6fq3UqvXBwprqLJmlT
	9Wv+e9QtnwRHCdDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C301013A2C;
	Tue, 13 Feb 2024 09:45:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XMzsLCE6y2XxJgAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 13 Feb 2024 09:45:05 +0000
Date: Tue, 13 Feb 2024 10:46:11 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
Message-ID: <Zcs6Y9rYwgy_-XSk@localhost.localdomain>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-3-osalvador@suse.de>
 <fc4f498b-fc35-4ba8-abf0-7664d6f1decb@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc4f498b-fc35-4ba8-abf0-7664d6f1decb@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aymr0q+w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gNHelfu4
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 43C4221EC3
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 10:16:04AM +0100, Vlastimil Babka wrote:
> On 2/12/24 23:30, Oscar Salvador wrote:
> > +static void add_stack_record_to_list(struct stack_record *stack_record)
> > +{
> > +	unsigned long flags;
> > +	struct stack *stack;
> > +
> > +	stack = kmalloc(sizeof(*stack), GFP_KERNEL);
> 
> I doubt you can use GFP_KERNEL unconditionally? Think you need to pass down
> the gfp flags from __set_page_owner() here?

Yes, we should re-use the same gfp flags.

> And what about the alloc failure case, this will just leave the stack record
> unlinked forever? Can we somehow know which ones we failed to link, and try
> next time? Probably easier by not recording the stack for the page at all in
> that case, so the next attempt with the same stack looks like the very first
> again and attemps the add to list.

Well, it is not that easy.
We could, before even calling into stackdepot to save the trace, try to
allocate a "struct stack", and skip everything if that fails, so
subsequent calls will try again as if this was the first time.

The thing I do not like about that is that it gets in the way of
traditional page_owner functionality (to put it a name), meaning that
if we cannot allocate a "struct stack", we also do not log the page
and the stack as we usually do, which means we lose that information.

One could argue that if we are so screwed that we cannot allocate that
struct, we may also fail deep in stackdepot code when allocating
the stack_record struct, but who knows.
I tried to keep both features as independent as possible.

> Still not happy that these extra tracking objects are needed, but I guess
> the per-users stack depot instances I suggested would be a major change.

Well, it is definitely something I could have a look in a short-term
future, to see if it makes sense, but for now I would go this the
current state as it has a well balanced complexity vs optimization.

> > +	if (stack_record) {
> > +		/*
> > +		 * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
> > +		 * with REFCOUNT_SATURATED to catch spurious increments of their
> > +		 * refcount.
> > +		 * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us
> > +		 * set a refcount of 1 ourselves.
> > +		 */
> > +		if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
> > +			refcount_set(&stack_record->count, 1);
> 
> Isn't this racy? Shouldn't we use some atomic cmpxchg operation to change
> from REFCOUNT_SATURATED to 1?

Yeah, missed that. Probably check it under the lock as Maroc suggested.

Thanks Vlastimil for the feedback!


-- 
Oscar Salvador
SUSE Labs

