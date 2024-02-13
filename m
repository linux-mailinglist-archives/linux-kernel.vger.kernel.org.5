Return-Path: <linux-kernel+bounces-63188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DDF852C10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFDEB22753
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BE321104;
	Tue, 13 Feb 2024 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WB8gtpV+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W12NEeOO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DLq09Ear";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ucbYrPw9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7DC208CB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815737; cv=none; b=X86xdnxpoic3H4mvU1DdhTPoIUF6z5DCZf4aLCK+wcmNKgdfihMQa4pdh6h/1PnRHTiJzthaJyBjSv7dfmpf8uKGhLxy4/Xr0eVtwIQNcB3ZgHHEYk+NZQDvRDqr/dmBZnBXwRqBm902XvrdM5MqCFEbfMGYSSbnojQpN5KALzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815737; c=relaxed/simple;
	bh=z50wzLn1m/BT+/li4gb2XneeVyLvsuhk3x3MNiGJ/C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5g2lokGKgU205ODBA6Mx4R0K4Ee/noxlPKcfJojioFfuJRqcvCYUFNitb6uICZkREK4MsD606EbS/a0VxkaiDfUL/w1wr/7idbpPkIC1PwiF8/rg6dfIDOeM4wzZ1b9IYB8dJP00nPjFZJzG6leZG4BfX2KQXIikXBneQn6p8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WB8gtpV+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W12NEeOO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DLq09Ear; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ucbYrPw9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 847B32116D;
	Tue, 13 Feb 2024 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707815733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2rOmls9bl9Zcz0eoq23xATUmZNLd2aQXwncrMMfP6Q=;
	b=WB8gtpV+5r8bQwRrN625be2/rKvHQt9uT8EgvcusbnwKj8yXo518mXn/uuJKnJkGgY/9e9
	/hdaW9I1qNUU7kx+8ifCVMdhq/83TcqdtG86n40DbS3vKRhPkwNzI8fIFrxPicZGU4atju
	zlNYRfCM3DenSLkiBDB3E7/fM1GrtsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707815733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2rOmls9bl9Zcz0eoq23xATUmZNLd2aQXwncrMMfP6Q=;
	b=W12NEeOOVD3ON0NpTmtSX8KXDy77lEDzMUms8HpbJZp34LgWhkaE79qjaVBLg2SPy7b1jX
	BRV42h+3cKZZnDCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707815732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2rOmls9bl9Zcz0eoq23xATUmZNLd2aQXwncrMMfP6Q=;
	b=DLq09EarOij1+YF93pF4GDTxvYCoh2E8KQdgvsuDW8qX9XR/IWtjR7tu0FdKmSlxVEboox
	dj8sDEiiW6HCvpsuTU9SZXedtG7OQMvuAFH09oP9u0RZKmvT1Gljml7WNKtATw6ROlm1wz
	fhn7aUytJpMYKT6H5OsEsPZ66Nd4zjE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707815732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G2rOmls9bl9Zcz0eoq23xATUmZNLd2aQXwncrMMfP6Q=;
	b=ucbYrPw9opZ9pO0fWUfJB5ZoEEkVkx59BZoT6xgukf3gpXfabKs9Hh1KnlqcfOepeGk6ld
	vlPTv/scdxuj1vDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 081A613A0E;
	Tue, 13 Feb 2024 09:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xfAIOjMzy2WbHwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 13 Feb 2024 09:15:31 +0000
Date: Tue, 13 Feb 2024 10:16:41 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v8 2/5] mm,page_owner: Implement the tracking of the
 stacks count
Message-ID: <ZcszeZ23QpYwFf-v@localhost.localdomain>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-3-osalvador@suse.de>
 <CANpmjNOaUdBOX1z1TST5djOLuL2DWj1Vus=ot_F_e_-8am3qZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOaUdBOX1z1TST5djOLuL2DWj1Vus=ot_F_e_-8am3qZQ@mail.gmail.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DLq09Ear;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ucbYrPw9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.86)[99.39%]
X-Spam-Score: -5.37
X-Rspamd-Queue-Id: 847B32116D
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 09:30:25AM +0100, Marco Elver wrote:
> On Mon, 12 Feb 2024 at 23:29, Oscar Salvador <osalvador@suse.de> wrote:
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> For the code:
> 
> Reviewed-by: Marco Elver <elver@google.com>

Thanks!

> But see minor comments below.

> > +/**
> > + * __stack_depot_get_stack_record - Get a pointer to a stack_record struct
> > + * This function is only for internal purposes.
> 
> I think the body of the kernel doc needs to go after argument declarations.

I see. I will amend that.

> > +static void add_stack_record_to_list(struct stack_record *stack_record)
> > +{
> > +       unsigned long flags;
> > +       struct stack *stack;
> > +
> > +       stack = kmalloc(sizeof(*stack), GFP_KERNEL);
> > +       if (stack) {
> 
> It's usually more elegant to write
> 
> if (!stack)
>   return;
> 
> If the rest of the function is conditional.

Yeah, probably better to save some identation.

> > +       if (stack_record) {
> > +               /*
> > +                * New stack_record's that do not use STACK_DEPOT_FLAG_GET start
> > +                * with REFCOUNT_SATURATED to catch spurious increments of their
> > +                * refcount.
> > +                * Since we do not use STACK_DEPOT_FLAG_{GET,PUT} API, let us
> 
> I think I mentioned this in the other email, there is no
> STACK_DEPOT_FLAG_PUT, only stack_depot_put().

Yes, you did. This was an oversight.
I will fix that.


Thanks for the feedback Marco!

-- 
Oscar Salvador
SUSE Labs

