Return-Path: <linux-kernel+bounces-60136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A79B85009C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E519A28488F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951F6374DE;
	Fri,  9 Feb 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pd0xpMVC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VvSX5hPA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UtV1+l5i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YfD8xwCX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA8219E4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520390; cv=none; b=l3XgZ2QvaKI6d58QvoMAGik9D6WXIfJP0inwnoyBOlH85oE3lP7V4TkTJNZatmuPQnEwrRaFgI3IlI0zfE+fEJ6WSmVgc0oZ4GP9fewfWl6qjMWzUycz0BrxMB2gbGpdpu8JLWr257sTtcFeLEVkNE+xV8rFM4dW6AcANj2y3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520390; c=relaxed/simple;
	bh=cto60T5aKoSgdnFHbOH1BU81mCjxPNLXa/UWaNi1BKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebo7JHQwmUrsHA8JvJ5e4Qm3iSXXL7ogXRUCdM4/GKfW3LckRf14yCxw2tCiUqPLLVwG/a3McgbheYhDug2kzF1sBPwk7EgWj5j9k03ZWTW+miWr6fGnJmbjVegzr/SkBrR+7NfjG/ya6FdzBwWwM331VTgtaLh7j+115QJfOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pd0xpMVC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VvSX5hPA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UtV1+l5i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YfD8xwCX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C59FE1F836;
	Fri,  9 Feb 2024 23:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707520387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9lpcBV9vzvFNtzllF8vaGWpSfSHINn8hx6gz8lR9do=;
	b=Pd0xpMVCWk8lLJEwQIwXH9UVn5/spsULRig1/vCnyKM+gdyWu8qf7TV1TMWVRPYEt2YpNj
	5o2hsBoU3qlcqwiA+ydpRRoFdcvn8fzlbm+XClOGjDHoNPen9ZydU66ZHa8ZmnjxfncEW0
	FDNFgaIjXU4txDcbpQUnHP+ICFObajk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707520387;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9lpcBV9vzvFNtzllF8vaGWpSfSHINn8hx6gz8lR9do=;
	b=VvSX5hPABaCgbXERSDBgxqWrEGkLFEvlaLRpTTGYlQnBYHwa/j/YvFEZPXTLiGxD/Ith4T
	32PXNvM0j+3KbfCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707520386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9lpcBV9vzvFNtzllF8vaGWpSfSHINn8hx6gz8lR9do=;
	b=UtV1+l5iQa1XiClMk8rQKdiMwA+cUmzLzaThRsKzj+Rvw9veDnV4BUEr0seDDT48d1k1QM
	Sj5yD6FyEYlvIJPLgUs/4hqjnKlE7RxcqOgR8HL2VyKtNv+R/rnHOZOddcEixosunJMKwj
	vtSfBGFFD/LlXuvuHO7/F50NJnIZ/xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707520386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S9lpcBV9vzvFNtzllF8vaGWpSfSHINn8hx6gz8lR9do=;
	b=YfD8xwCXfxRTiyKLP33cUiRHKI4NdUAugrEAqxccd/IWuhcAn74QwKOPuS8MuBIFjuPrR0
	jm6W1nFU5QpkCoCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4758613353;
	Fri,  9 Feb 2024 23:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JZl0DoKxxmVKfwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 09 Feb 2024 23:13:06 +0000
Date: Sat, 10 Feb 2024 00:14:13 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Marco Elver <elver@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v7 3/4] mm,page_owner: Display all stacks and their count
Message-ID: <ZcaxxQE1PkepEWwf@localhost.localdomain>
References: <20240208234539.19113-1-osalvador@suse.de>
 <20240208234539.19113-4-osalvador@suse.de>
 <CANpmjNNcPr=pPco_HN9nXBabubtfo02SAH=taZGNCvYDq42YUQ@mail.gmail.com>
 <ZcaesCP4mY-94ciJ@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcaesCP4mY-94ciJ@localhost.localdomain>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UtV1+l5i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YfD8xwCX
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.22 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.04)[-0.181];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,suse.cz,gmail.com,google.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.87)[94.27%]
X-Spam-Score: -3.22
X-Rspamd-Queue-Id: C59FE1F836
X-Spam-Flag: NO

On Fri, Feb 09, 2024 at 10:52:48PM +0100, Oscar Salvador wrote:
> Thinking about it some more, I think I made a mistake:
> 
> I am walking all buckets, and within those buckets there are not only
> page_owner stack_records, which means that I could return a stack_record
> from e.g: KASAN (which I think can evict stack_records) and then
> everything goes off the rails.
> Which means I cannot walk the buckets like that.
> 
> Actually, I think that having something like the following
> 
>  struct list_stack_records {
>       struct stack_record *stack;
>       struct list_stack_records *next;
>  }

Or, I could use the extra_bits field from handle_parts to flag that
when a depot_stack_handle_t is used by page_owner.

Then __stack_depot_get_next_stack_record() would check whether
a stack_record->handle.extra_bits has the page_owner bit, and only
return those stacks that have such bit.
This would solve the problem of returning a potentially evictable stack
, only by returning page_owner's stack_records, and I would not have
to maintain my own list.
 
I yet have to see how that would look like, but sounds promising.
Do you think that is feasible Marco?

Thanks

-- 
Oscar Salvador
SUSE Labs

