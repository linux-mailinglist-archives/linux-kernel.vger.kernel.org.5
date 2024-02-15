Return-Path: <linux-kernel+bounces-66851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7DA856260
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218731C21CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66612B171;
	Thu, 15 Feb 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IUvyYiIb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hOTd6eh1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IUvyYiIb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hOTd6eh1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44869DFE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998403; cv=none; b=hDR/YM52ooF2jGHr//Rfds8aim7tLCl7X2PI5hYtJ3gKSfgXUDMLeCddg1aetRbYkh18FsuzvjoehxhLl0nvLZwVAcbja+WO9Y9/7+Ic0YU2T9va3hCRmhN+H9zVOY1ym7GUQ7Yhjnuozn2phh359etRlByPE6WGVhg9a/5uFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998403; c=relaxed/simple;
	bh=Inw5I/nGOWvZ0fEa9macC4Z6ON+4wMS3Sgn0E/1NCZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSfaO6s8TWq3AYhfL1KJGnKIZY6U6M3OfC1IjNzl7VAl0mslzY6SBWRtUh2kDYODa+YINsG2fzYdtZmVbZBoBldAGgZ574Bv3ycgHZnp/CTqmEgdEamg8tB4NRNzhzJxL8gJTQb2YAOyQRYvQ892p7RaHwQct8YRj9630Ab/HZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IUvyYiIb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hOTd6eh1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IUvyYiIb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hOTd6eh1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E84722208;
	Thu, 15 Feb 2024 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707998399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVGNjE+gWHjH3j3EbhyCn5oJEM5fskMFhXwVqjykBB8=;
	b=IUvyYiIb6bx9LWePoXzwlZiyhLhBtCuFzkSFbb6ifzpNkBRyao+YGmQJEzewcwxF0WVh3Y
	FgBhDL9hsqZpyY6uTEq/rOaqlfDexGhBYMbvdRfwCUSkpNdZDNhOf31vqom6Ahy1+x1+ov
	ObLkRLW1DwNDygRQLTT5DYjIU4TZQ2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707998399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVGNjE+gWHjH3j3EbhyCn5oJEM5fskMFhXwVqjykBB8=;
	b=hOTd6eh14ayZfPBPxXJP1J75xpixKeZtKQcrBDNjsBjlwEuouG7q72DN6vw/XQTOhQ0Rji
	I3Wu1j8PvySAcbCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707998399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVGNjE+gWHjH3j3EbhyCn5oJEM5fskMFhXwVqjykBB8=;
	b=IUvyYiIb6bx9LWePoXzwlZiyhLhBtCuFzkSFbb6ifzpNkBRyao+YGmQJEzewcwxF0WVh3Y
	FgBhDL9hsqZpyY6uTEq/rOaqlfDexGhBYMbvdRfwCUSkpNdZDNhOf31vqom6Ahy1+x1+ov
	ObLkRLW1DwNDygRQLTT5DYjIU4TZQ2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707998399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVGNjE+gWHjH3j3EbhyCn5oJEM5fskMFhXwVqjykBB8=;
	b=hOTd6eh14ayZfPBPxXJP1J75xpixKeZtKQcrBDNjsBjlwEuouG7q72DN6vw/XQTOhQ0Rji
	I3Wu1j8PvySAcbCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E6551346A;
	Thu, 15 Feb 2024 11:59:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FPQcIL78zWXqBwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 15 Feb 2024 11:59:58 +0000
Date: Thu, 15 Feb 2024 13:01:04 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v9 6/7] mm,page_owner: Filter out stacks by a threshold
Message-ID: <Zc39AJ1H_zE4VSBG@localhost.localdomain>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-7-osalvador@suse.de>
 <bb7112a8-df8a-4df8-a8db-0cb4761720dd@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb7112a8-df8a-4df8-a8db-0cb4761720dd@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IUvyYiIb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hOTd6eh1
X-Spamd-Result: default: False [-3.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kvack.org,suse.com,google.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.95)[99.77%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0E84722208
X-Spam-Level: 
X-Spam-Score: -3.26
X-Spam-Flag: NO

On Thu, Feb 15, 2024 at 12:12:56PM +0100, Vlastimil Babka wrote:
> On 2/14/24 18:01, Oscar Salvador wrote:
> > We want to be able to filter out the stacks based on a threshold we can
> > can tune.
> > By writing to 'count_threshold' file, we can adjust the threshold value.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks

> Again "- 1" here.

Yes, I might just instead add this assigment in the previous patch,
so no further modifications wrt. stack_count will be needed in this
patch.

Might be cleaner?
 

-- 
Oscar Salvador
SUSE Labs

