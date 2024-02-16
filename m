Return-Path: <linux-kernel+bounces-68667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9BA857E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3686F1C24DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAAB12BEA5;
	Fri, 16 Feb 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S88AS8To";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jjQKU8QU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="slifVxb0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x2u6/Hks"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3159B5F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091431; cv=none; b=Z6YNxAiL312s8mAJImIlyZakthKtvi/EOLhmIRu2WLuBfcZ8Cq3EqJ8QH7IIvIWJ00xPT03O2qJrp9qchu5w/DbD7IXugNTEbDdr0VV2Cj4VOmBGgsLKUG6PGRW5Wa7DHwgFqU6SOkWkFHbQeAKAZ16bsupXDWUf6WPJNZW0wHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091431; c=relaxed/simple;
	bh=UFLyol9XebIXP8E+TiARQB654sIagqzRAjL0tNlzEP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGqjRptmN+Tl2XbKuPmMD4eeQ9wDPi2bMSbCYr6F6szZUh11smw9mPzcpIHWFtCWQ4cZjLxYfM79+vPRJx6UtwNcqhPDPXhBQJWa8NSyvpqHctMpvqgCKZxS8ccA+hzRnuzWzPePwmgH29MTk74nOyr5NzsGV9uW0OImXkR1wF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S88AS8To; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jjQKU8QU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=slifVxb0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x2u6/Hks; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C1D71FB6D;
	Fri, 16 Feb 2024 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708091425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVE5Nc1YdqNYE0FuXxixZvVN4v97TGfURnkyaIu6vK4=;
	b=S88AS8ToOwW/JD63VpMifx+DoVD5NJ+fJ/N0q8YM9aTt4CBQNpk5fcPeqk8C7NsOQ92Q5F
	cRlgR5qSLfYoP9BgYUxXxXMRqL+JgFoTnJ05oFiXqOxLaGHNpBUkjq8OAnvl+MQ+BoxHbV
	VU14LdBd0vJ4Ja6F6NL7O/vsmLX/zRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708091425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVE5Nc1YdqNYE0FuXxixZvVN4v97TGfURnkyaIu6vK4=;
	b=jjQKU8QU422ZwWsFPRUX3Aew9UBTnQmnY+dpX7NK6cj9VMM1VmtQla8oqxnDALUWyvbT4E
	9Ieoj3KaQxSjuhBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708091423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVE5Nc1YdqNYE0FuXxixZvVN4v97TGfURnkyaIu6vK4=;
	b=slifVxb0mezcFjG1w7d1nnjS+XsyZjUonCKMS5M6rUXAstSt7GSpQ3l+/g+HKs7Frmz3Xl
	/sHi9GWut05qabo0nTYAZzNM49tdaKNONZYre7Fo4C5OAVX/j/JigKo7Nj45QnHfPazjEC
	qaPIm0CVzfHH5uZ8q+euSe8BvgceFFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708091423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVE5Nc1YdqNYE0FuXxixZvVN4v97TGfURnkyaIu6vK4=;
	b=x2u6/HksgKeceJM5Wwh9KgO8YJkdfurk6kqdxjCrOaLeN3xzBG/tavvkg3MhX5r19rbtvp
	rU9QWAKvdlGiyTBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 99B3013421;
	Fri, 16 Feb 2024 13:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id COudIh5oz2WJMAAAn2gu4w
	(envelope-from <osalvador@suse.de>); Fri, 16 Feb 2024 13:50:22 +0000
Date: Fri, 16 Feb 2024 14:51:24 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Byungchul Park <byungchul@sk.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3] sched/numa, mm: do not promote folios to nodes not
 set N_MEMORY
Message-ID: <Zc9oXOwGMGGE4bBh@localhost.localdomain>
References: <20240216114045.24828-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216114045.24828-1-byungchul@sk.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=slifVxb0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="x2u6/Hks"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.31)[75.44%]
X-Spam-Score: -1.82
X-Rspamd-Queue-Id: 6C1D71FB6D
X-Spam-Flag: NO

On Fri, Feb 16, 2024 at 08:40:45PM +0900, Byungchul Park wrote:
> From 150af2f78e19217a1d03e47e3ee5279684590fb4 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Fri, 16 Feb 2024 20:18:10 +0900
> Subject: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set N_MEMORY

"do not try to promote folios to memoryless nodes"

because AFAICS we are just trying.
Even if should_numa_migrate_memory() returns true, I assume that we will
fail somewhere down the chain e.g: migrate_pages() when we see that this
node does not any memory, right?

> A numa node might not have its local memory but CPUs. Promoting a folio
> to the node's local memory is nonsense. So avoid nodes not set N_MEMORY
> from getting promoted.

If you talk about memoryless nodes everybody gets it better IMHO.
"Memoryless nodes do not have any memory to migrate to, so stop trying it."


> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  kernel/sched/fair.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..7ed9ef3c0134 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1828,6 +1828,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>  	int dst_nid = cpu_to_node(dst_cpu);
>  	int last_cpupid, this_cpupid;
>  
> +	/*
> +	 * A node of dst_nid might not have its local memory. Promoting
> +	 * a folio to the node is meaningless.
> +	 */
> +	if (!node_state(dst_nid, N_MEMORY))
> +		return false;

"Cannot migrate to memoryless nodes"

seems shorter and more clear.

So, what happens when we return true here? will we fail at
migrate_pages() I guess? That is quite down the road so I guess
this check can save us some time.


-- 
Oscar Salvador
SUSE Labs

