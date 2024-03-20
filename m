Return-Path: <linux-kernel+bounces-108436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21216880A7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1734283580
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007C1426D;
	Wed, 20 Mar 2024 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tmFJC3bt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f4tnpDq7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tmFJC3bt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f4tnpDq7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520E014271
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710910726; cv=none; b=KKwvQddTmlrYxshbscjEF9j0NqcHNeWXV3nVfIFwqHzqKtApvQkmxb5iNayY5JEWRLHriJvEDgqu0SFX50l5OQMWyktMnG8ZEks4YzZSd6F3mUyE2hn3MYPJUSFygKP2VbQdgloPrAEt0m0mKWbNyPMkOfwuudEFv2PiCqi4Kh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710910726; c=relaxed/simple;
	bh=fvZqhFIGcnR9isSvz9WUB6fZLKC2/E018oQM53IrKI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMarwedom2/Uqxl2+CuxhdogfyZTiWAk2uOt0BJC/D5KBS+oouNmTUvQfDfcZPVLvxIj8lVQ5EHCleGidOUZEX8nIPN4yDm855wHN2XN2ArXy/wM1cinWY4m6MWgxWaQNuZkV16DBNnaPmklStfIOW2R9RAnXdYeiC9LJYGDxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tmFJC3bt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f4tnpDq7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tmFJC3bt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f4tnpDq7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 431A333C71;
	Wed, 20 Mar 2024 04:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710910722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqYdbsJiVpvaV5yrL8Yc783Zl0AzPQgiCsn8hCQDOJI=;
	b=tmFJC3btkNKCvknVBScweVzqTZ/ZwgpxjqUoKCApKTNgKBqH1uUXxu0zGnxEXjKr539T6W
	RM2f1cbexQ1Gnzb9m3pU0vh2GHFxJqDFkkn2CIWGQtK9AHrqPwNmmHOSOAB2kYubPb4c6Q
	3/ZQSR/4WGbjoUnsu7RhGCB3ex8OQ7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710910722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqYdbsJiVpvaV5yrL8Yc783Zl0AzPQgiCsn8hCQDOJI=;
	b=f4tnpDq7IW+3FIeuvZxWJwUNAxhFF80ux6aaoJohyIz9QE+gP7uZ3HoyW8F9lT4CT2TDPP
	SAjlnE9EGtkY+yCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710910722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqYdbsJiVpvaV5yrL8Yc783Zl0AzPQgiCsn8hCQDOJI=;
	b=tmFJC3btkNKCvknVBScweVzqTZ/ZwgpxjqUoKCApKTNgKBqH1uUXxu0zGnxEXjKr539T6W
	RM2f1cbexQ1Gnzb9m3pU0vh2GHFxJqDFkkn2CIWGQtK9AHrqPwNmmHOSOAB2kYubPb4c6Q
	3/ZQSR/4WGbjoUnsu7RhGCB3ex8OQ7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710910722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqYdbsJiVpvaV5yrL8Yc783Zl0AzPQgiCsn8hCQDOJI=;
	b=f4tnpDq7IW+3FIeuvZxWJwUNAxhFF80ux6aaoJohyIz9QE+gP7uZ3HoyW8F9lT4CT2TDPP
	SAjlnE9EGtkY+yCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F17A136CD;
	Wed, 20 Mar 2024 04:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HyMHJAFt+mW0fwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 20 Mar 2024 04:58:41 +0000
Date: Wed, 20 Mar 2024 06:00:08 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v2 2/2] mm,page_owner: Fix accounting of pages when
 migrating
Message-ID: <ZfptWDsfdxBltN6T@localhost.localdomain>
References: <20240319183212.17156-1-osalvador@suse.de>
 <20240319183212.17156-3-osalvador@suse.de>
 <Zfnd_w0ZLOVhgACt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfnd_w0ZLOVhgACt@casper.infradead.org>
X-Spam-Score: -4.24
X-Spamd-Result: default: False [-4.24 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.14)[-0.684];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,i-love.sakura.ne.jp];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

On Tue, Mar 19, 2024 at 06:48:31PM +0000, Matthew Wilcox wrote:
> Is this the right way to fix this problem?  I would have thought we'd
> be better off accounting this as migration freeing the old page and
> allocating the new page.  If I understand correctly, this is the code
> which says "This page was last allocated by X and freed by Y", and I
> would think that being last freed (or allocated) by the migration code
> would be a very nice hint about where a problem might stem from.

I hear you, and I had the same thought when I stumbled upon this.
I did not know that the handle was being changed, otherwise it would
have saved me quite a lot of debugging time.

Checking the history of this, I can see this decision was made in
2016 in:

 commit d435edca928805074dae005ab9a42d9fa60fc702
 Author: Vlastimil Babka <vbabka@suse.cz>
 Date:   Tue Mar 15 14:56:15 2016 -0700
 
     mm, page_owner: copy page owner info during migration


And let me quote:

   "The page_owner mechanism stores gfp_flags of an allocation and stack
    trace that lead to it.  During page migration, the original information
    is practically replaced by the allocation of free page as the migration
    target.  Arguably this is less useful and might lead to all the
    page_owner info for migratable pages gradually converge towards
    compaction or numa balancing migrations.  It has also lead to
    inaccuracies such as one fixed by commit e2cfc91120fa ("mm/page_owner:
    set correct gfp_mask on page_owner")."

A following patch stored the migration reason in last_migrate_reason,
and the patch also add a bit of information if last_migrate_reason was
other than 0:

 +       if (page_ext->last_migrate_reason != -1) {
 +               ret += snprintf(kbuf + ret, count - ret,
 +                       "Page has been migrated, last migrate reason: %s\n",
 +                       migrate_reason_names[page_ext->last_migrate_reason]);
 +               if (ret >= count)
 +                       goto err;
 +       }

Now, thinking about this some more, it kind of makes sense, because one
of the things page_owner is used for, in my experience, is for memory
leaks.
We print the output, try to correlate allocation/free operations per
stack so one can easily spot a stack that just keeps allocating memory
and never frees it (it might be legit, and not a leak, but it gives a
hint).

Now imagine there are 10k pages pointing to stack A.
If those pages were to be migrated e.g: kcompactd jumps in, we will lose
the original stack and replace it with something like:

migrate_pages()
..
..
kcompatd

After that, stack A does not have those 10k pages pointing to it
anymore, although it stills "own" them, just that got replaced by
new ones due to migration.

This kind of defeats the purpose of page_owner.
And after all, we do record some migration information in those new
pages, which will give us a hint when looking at the output.

So, all in all, I am leaning towards "this is fine".


-- 
Oscar Salvador
SUSE Labs

