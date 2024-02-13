Return-Path: <linux-kernel+bounces-63807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BD58534B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137A61C21067
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4125EE71;
	Tue, 13 Feb 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="es4UNiST";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+mHTXTqZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="es4UNiST";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+mHTXTqZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B535DF3E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838345; cv=none; b=Kh5yq37AvrzLWqNftrygQRL5aFCtG3L9kJ8GxaiWs9NMjU4fP1klH8UbpXAk8MhaBVYpDI0NMorF29gjxwGqIHoPmMC5WsnmkdxVEcokHLMOpbJ4mjG0b9S+cIhiYrlcPa36qhvXaZ088Br5B7T0lF8/ZVspmx1Cp6IJCq7fUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838345; c=relaxed/simple;
	bh=Jy8VoZSnqR67yqm7MPHgwgHoYLAdDwVSuN2jp8+Gmis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkZ3wKcXQb+ERMXZ3Lozg/LPtT0Luxj185kCkbbCMm7cuBZ6MXJYpnkuoNlrcbeU+CHrfvOjmemhXxMiGRn8zwqSiz+pnQ4K7m/IWboNiMfboriwfQabN+rJxXKR8iU57dmhPFwG7IG88WsCSuZuOxdyxWOn9M9VdTmWS8mrN5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=es4UNiST; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+mHTXTqZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=es4UNiST; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+mHTXTqZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E424C1FCE2;
	Tue, 13 Feb 2024 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707838341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwad023+VpCp8Em+c31I+OWYiRbkKktBQYYUbNSO2Bg=;
	b=es4UNiSTfoBYDBzKtt5jQvZx0jSaafqS3+MdTQ9QMIP69JC8IMTGc8cf4E31MEQodQbx9E
	9i2seiwxuXdntZep8C6D4x2KTFYjAQKBe8OzDC4in0JQbXaaP1bh2pMAWZzxU6Oc6/SD3r
	ZJembWCzqMx94E4v7Q5J7LU7ZgZPKlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707838341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwad023+VpCp8Em+c31I+OWYiRbkKktBQYYUbNSO2Bg=;
	b=+mHTXTqZ1+F6RWZObuc1tTqn3dwoELDnmrt3xxLyML731VQ5NkPkZtL/Tn8rXmyVlITN2x
	1J9hS91wKUwmt/CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707838341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwad023+VpCp8Em+c31I+OWYiRbkKktBQYYUbNSO2Bg=;
	b=es4UNiSTfoBYDBzKtt5jQvZx0jSaafqS3+MdTQ9QMIP69JC8IMTGc8cf4E31MEQodQbx9E
	9i2seiwxuXdntZep8C6D4x2KTFYjAQKBe8OzDC4in0JQbXaaP1bh2pMAWZzxU6Oc6/SD3r
	ZJembWCzqMx94E4v7Q5J7LU7ZgZPKlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707838341;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lwad023+VpCp8Em+c31I+OWYiRbkKktBQYYUbNSO2Bg=;
	b=+mHTXTqZ1+F6RWZObuc1tTqn3dwoELDnmrt3xxLyML731VQ5NkPkZtL/Tn8rXmyVlITN2x
	1J9hS91wKUwmt/CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 65EAA13A0E;
	Tue, 13 Feb 2024 15:32:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id NYe6FYWLy2UPfQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 13 Feb 2024 15:32:21 +0000
Date: Tue, 13 Feb 2024 16:33:30 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v8 3/5] mm,page_owner: Display all stacks and their count
Message-ID: <ZcuLyjU52Gd3xJI8@localhost.localdomain>
References: <20240212223029.30769-1-osalvador@suse.de>
 <20240212223029.30769-4-osalvador@suse.de>
 <b706176a-c60a-4960-ba4a-2755c612d9c8@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b706176a-c60a-4960-ba4a-2755c612d9c8@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.90)[99.57%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -7.00

On Tue, Feb 13, 2024 at 03:25:26PM +0100, Vlastimil Babka wrote:
> On 2/12/24 23:30, Oscar Salvador wrote:
> > +static int stack_print(struct seq_file *m, void *v)
> > +{
> > +	char *buf;
> > +	int ret = 0;
> > +	struct stack *stack = v;
> > +	struct stack_record *stack_record = stack->stack_record;
> > +
> > +	if (!stack_record->size || stack_record->size < 0 ||
> > +	    refcount_read(&stack_record->count) < 2)
> > +		return 0;
> > +
> > +	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +
> > +	ret += stack_trace_snprint(buf, PAGE_SIZE, stack_record->entries,
> > +				   stack_record->size, 0);
> > +	if (!ret)
> > +		goto out;
> > +
> > +	scnprintf(buf + ret, PAGE_SIZE - ret, "stack_count: %d\n\n",
> > +		  refcount_read(&stack_record->count));
> > +
> > +	seq_printf(m, buf);
> > +	seq_puts(m, "\n\n");
> > +out:
> > +	kfree(buf);
> 
> Seems rather wasteful to do kzalloc/kfree so you can print into that buffer
> first and then print/copy it again using seq_printf. If you give up on using
> stack_trace_snprintf() it's not much harder to print the stack directly with
> a loop of seq_printf. See e.g. slab_debugfs_show().

Well, I thought about not reinventing the wheel there, but fair enough
than performing a kmalloc/free op on every print might be suboptimal.
I will try to do ir with seq_printf alone.

Thanks
 

-- 
Oscar Salvador
SUSE Labs

