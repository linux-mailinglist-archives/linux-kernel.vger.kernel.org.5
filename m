Return-Path: <linux-kernel+bounces-63444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C698E852FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6261F21526
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881352F8F;
	Tue, 13 Feb 2024 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qlN8MDQH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKWAPuNK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qlN8MDQH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iKWAPuNK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3D7376F3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824100; cv=none; b=tkzWfeeVnuQOqFfIRm5icVHgyhvLwRZjpMjoY1FKuk0IWJ3fRJVlcw9WMJtWh7KUVyKYPEtPHBuk84igNmuDYH1z6Fj4WkF5AQ+F7208/aOkzMgVYMPnc89aSBlskb8YDDWK/H9NBYfcUTrJxrTtXA9V5cxqIsGqyu802/1MdAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824100; c=relaxed/simple;
	bh=TcqesdG2KM9lV4iAhGJ3PTgQd0R6wXbcspGs4ohG7Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRqh0Dj6fJ+G/EgU9CU9jEMad1kx1GLxv09mGQ9RJcc1rK7xqNoe/gNd1nQxwaR3Y5shfRmqs57vgjk4Aofc39r6Hgy0iXU4NNvmupfOhDUs7v8Wy+zcLdL8G5oxlqtM7RrPsUxyLgKDtoT2vv+hHd9ChhzagxLZEJWEYAwztow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qlN8MDQH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKWAPuNK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qlN8MDQH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iKWAPuNK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5529B21E40;
	Tue, 13 Feb 2024 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707824096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghGDITH5a4ZoXoh0yiMTLBa3Ptq5jxOlMFTWcfo631s=;
	b=qlN8MDQHXyl133ejSoFs03hc66Q5AOAJBTfn5cLTwITPEGtSoKzRfEL1G6lMpI1aIsVAzI
	kQFBPSVzxaLg7cZRUrDDASIDVY7lqvGrGsjk5UEROwaesP5Xh4vWYeyF+T5iSCQgR0Ueep
	2zuTVRCD+FYHi28LR2KfB+wKQXwpc7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707824096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghGDITH5a4ZoXoh0yiMTLBa3Ptq5jxOlMFTWcfo631s=;
	b=iKWAPuNKsQIqMownxqV9qhJZ0/ynyCdvG2O9M5BDCYqG6/BP2pGi3Oru1KGCPEUIEV1xV5
	8e8N+Ip71RBe6bAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707824096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghGDITH5a4ZoXoh0yiMTLBa3Ptq5jxOlMFTWcfo631s=;
	b=qlN8MDQHXyl133ejSoFs03hc66Q5AOAJBTfn5cLTwITPEGtSoKzRfEL1G6lMpI1aIsVAzI
	kQFBPSVzxaLg7cZRUrDDASIDVY7lqvGrGsjk5UEROwaesP5Xh4vWYeyF+T5iSCQgR0Ueep
	2zuTVRCD+FYHi28LR2KfB+wKQXwpc7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707824096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghGDITH5a4ZoXoh0yiMTLBa3Ptq5jxOlMFTWcfo631s=;
	b=iKWAPuNKsQIqMownxqV9qhJZ0/ynyCdvG2O9M5BDCYqG6/BP2pGi3Oru1KGCPEUIEV1xV5
	8e8N+Ip71RBe6bAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AE1C1370C;
	Tue, 13 Feb 2024 11:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OaKNDeBTy2ULegAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Feb 2024 11:34:56 +0000
Message-ID: <11cb2ac2-102f-4acd-aded-bbfd29f7269a@suse.cz>
Date: Tue, 13 Feb 2024 12:34:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
Content-Language: en-US
To: Marco Elver <elver@google.com>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-3-osalvador@suse.de>
 <fc4f498b-fc35-4ba8-abf0-7664d6f1decb@suse.cz>
 <CANpmjNO8CHC6gSFVEOSzYsTAP-j5YvfbfzZMUwnGqSAC1Y4A8g@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CANpmjNO8CHC6gSFVEOSzYsTAP-j5YvfbfzZMUwnGqSAC1Y4A8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qlN8MDQH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iKWAPuNK
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
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
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[suse.de,linux-foundation.org,vger.kernel.org,kvack.org,suse.com,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 5529B21E40
X-Spam-Flag: NO

On 2/13/24 10:21, Marco Elver wrote:
> On Tue, 13 Feb 2024 at 10:16, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 2/12/24 23:30, Oscar Salvador wrote:
>> > page_owner needs to increment a stack_record refcount when a new allocation
>> > occurs, and decrement it on a free operation.
>> > In order to do that, we need to have a way to get a stack_record from a
>> > handle.
>> > Implement __stack_depot_get_stack_record() which just does that, and make
>> > it public so page_owner can use it.
>> >
>> > Also implement {inc,dec}_stack_record_count() which increments
>> > or decrements on respective allocation and free operations, via
>> > __reset_page_owner() (free operation) and __set_page_owner() (alloc
>> > operation).
>> >
>> > Traversing all stackdepot buckets comes with its own complexity,
>> > plus we would have to implement a way to mark only those stack_records
>> > that were originated from page_owner, as those are the ones we are
>> > interested in.
>> > For that reason, page_owner maintains its own list of stack_records,
>> > because traversing that list is faster than traversing all buckets
>> > while keeping at the same time a low complexity.
>> > inc_stack_record_count() is responsible of adding new stack_records
>> > into the list stack_list.
>> >
>> > Modifications on the list are protected via a spinlock with irqs
>> > disabled, since this code can also be reached from IRQ context.
>> >
>> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
>> > ---
>> >  include/linux/stackdepot.h |  9 +++++
>> >  lib/stackdepot.c           |  8 +++++
>> >  mm/page_owner.c            | 73 ++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 90 insertions(+)
>>
>> ...
>>
>>
>> > --- a/mm/page_owner.c
>> > +++ b/mm/page_owner.c
>> > @@ -36,6 +36,14 @@ struct page_owner {
>> >       pid_t free_tgid;
>> >  };
>> >
>> > +struct stack {
>> > +     struct stack_record *stack_record;
>> > +     struct stack *next;
>> > +};
>> > +
>> > +static struct stack *stack_list;
>> > +static DEFINE_SPINLOCK(stack_list_lock);
>> > +
>> >  static bool page_owner_enabled __initdata;
>> >  DEFINE_STATIC_KEY_FALSE(page_owner_inited);
>> >
>> > @@ -61,6 +69,57 @@ static __init bool need_page_owner(void)
>> >       return page_owner_enabled;
>> >  }
>> >
>> > +static void add_stack_record_to_list(struct stack_record *stack_record)
>> > +{
>> > +     unsigned long flags;
>> > +     struct stack *stack;
>> > +
>> > +     stack = kmalloc(sizeof(*stack), GFP_KERNEL);
>>
>> I doubt you can use GFP_KERNEL unconditionally? Think you need to pass down
>> the gfp flags from __set_page_owner() here?
>> And what about the alloc failure case, this will just leave the stack record
>> unlinked forever? Can we somehow know which ones we failed to link, and try
>> next time? Probably easier by not recording the stack for the page at all in
>> that case, so the next attempt with the same stack looks like the very first
>> again and attemps the add to list.
>> Still not happy that these extra tracking objects are needed, but I guess
>> the per-users stack depot instances I suggested would be a major change.
>>
>> > +     if (stack) {
>> > +             stack->stack_record = stack_record;
>> > +             stack->next = NULL;
>> > +
>> > +             spin_lock_irqsave(&stack_list_lock, flags);
>> > +             if (!stack_list) {
>> > +                     stack_list = stack;
>> > +             } else {
>> > +                     stack->next = stack_list;
>> > +                     stack_list = stack;
>> > +             }
>> > +             spin_unlock_irqrestore(&stack_list_lock, flags);
>> > +     }
>> > +}
>> > +
>> > +static void inc_stack_record_count(depot_stack_handle_t handle)
>> > +{
>> > +     struct stack_record *stack_record = __stack_depot_get_stack_record(handle);
>> > +
>> > +     if (stack_record) {
>> > +             /*
>> > +              * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
>> > +              * with REFCOUNT_SATURATED to catch spurious increments of their
>> > +              * refcount.
>> > +              * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us
>> > +              * set a refcount of 1 ourselves.
>> > +              */
>> > +             if (refcount_read(&stack_record->count) == REFCOUNT_SATURATED) {
>> > +                     refcount_set(&stack_record->count, 1);
>>
>> Isn't this racy? Shouldn't we use some atomic cmpxchg operation to change
>> from REFCOUNT_SATURATED to 1?
> 
> If 2 threads race here, both will want to add it to the list as well
> and take the lock. So this could just be solved with double-checked
> locking:
> 
> if (count == REFCOUNT_SATURATED) {
>   spin_lock(...);

Yeah probably stack_list_lock could be taken here already. But then the
kmalloc() of struct stack must happen also here, before taking the lock.

>   if (count == REFCOUNT_SATURATED) {
>     refcount_set(.., 1);
>     .. add to list ...
>   }
>   spin_unlock(..);
> }


