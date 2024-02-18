Return-Path: <linux-kernel+bounces-70252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7F6859546
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372C81C20A51
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270B7D52D;
	Sun, 18 Feb 2024 07:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OzY6l413";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zoqJA3fA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OzY6l413";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zoqJA3fA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F27470
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708242311; cv=none; b=iExjbJh6bImpVWg10Zi+ygbkiM7XIdYjVUqyCssXHKHhASVkcKn2CElBSMiDycLnCc/eK8Jy8ZeuM99fgVOXSfABDvlunLChAs2CoPk81AZ8Yr55LZXRx9MBlAO6GVhl2yFdyS/JVFPaSU7rjlIhRsLXrVAWgjXPTPQLJf5m6TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708242311; c=relaxed/simple;
	bh=Rz4BsMjV7ldBGPlX4IskfMs6om3XDfI7hFwAe52EV0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGVzzV84dhXkP7oC0WOwGvX4XGi9yn8BcegIcNUetySx1nvbB2QfbKq67BBv5QBM1iMnx1yU/cdJ503YUsHdyugQyIBczSB5ZXGMBN5Fx+PNFXf5+0ZwZAXCj9fWMzwB5pSfP0D2B7heqpssPUhgoANSWcKISUEZKN4jXxTFo7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OzY6l413; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zoqJA3fA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OzY6l413; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zoqJA3fA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FC111FBF2;
	Sun, 18 Feb 2024 07:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708242305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evZe4gckZRBHDhEto05F1VL+BEBk5Sw8m/1sqWCtavg=;
	b=OzY6l413AqV4NamRaozr+xOUFtfEXlLQ7MgbOxFYE5nHINtEwheLgKGD3oxK+tWA/LWMfP
	+sB/ewyB2QysnXjnaIgGaEtlMk2BqbpQL6zsXVBKxaw3LX9a/w24zYzbZXXFtnvWDdRTbJ
	hKd3aPSXYtZfTiYhBDBxTdWpfc6xt6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708242305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evZe4gckZRBHDhEto05F1VL+BEBk5Sw8m/1sqWCtavg=;
	b=zoqJA3fAcIDCyvFIG4LK3eK8/G6U9OLxJxCQtkTiOaBRI5QRS6DFGpFV3SJKEZow1TP6cv
	3CXhsc8JAs9Pe9DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708242305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evZe4gckZRBHDhEto05F1VL+BEBk5Sw8m/1sqWCtavg=;
	b=OzY6l413AqV4NamRaozr+xOUFtfEXlLQ7MgbOxFYE5nHINtEwheLgKGD3oxK+tWA/LWMfP
	+sB/ewyB2QysnXjnaIgGaEtlMk2BqbpQL6zsXVBKxaw3LX9a/w24zYzbZXXFtnvWDdRTbJ
	hKd3aPSXYtZfTiYhBDBxTdWpfc6xt6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708242305;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=evZe4gckZRBHDhEto05F1VL+BEBk5Sw8m/1sqWCtavg=;
	b=zoqJA3fAcIDCyvFIG4LK3eK8/G6U9OLxJxCQtkTiOaBRI5QRS6DFGpFV3SJKEZow1TP6cv
	3CXhsc8JAs9Pe9DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A447413343;
	Sun, 18 Feb 2024 07:45:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1QK8JIC10WUaVQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Sun, 18 Feb 2024 07:45:04 +0000
Date: Sun, 18 Feb 2024 08:46:16 +0100
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
Message-ID: <ZdG1yO29WTyRiw8Q@localhost.localdomain>
References: <20240216114045.24828-1-byungchul@sk.com>
 <Zc9oXOwGMGGE4bBh@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc9oXOwGMGGE4bBh@localhost.localdomain>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Fri, Feb 16, 2024 at 02:51:24PM +0100, Oscar Salvador wrote:
> On Fri, Feb 16, 2024 at 08:40:45PM +0900, Byungchul Park wrote:
> > From 150af2f78e19217a1d03e47e3ee5279684590fb4 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Fri, 16 Feb 2024 20:18:10 +0900
> > Subject: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
> 
> "do not try to promote folios to memoryless nodes"

Thinking some more, promote might be misleading, just something like
"do not try to migrate memory to memoryless nodes".

As this is not a bug fix but an optimization, as we will fail anyways
in migrate_misplaced_folio() when migrate_balanced_pgdat() notices that
we do not have any memory on that code.

With the other comments addressed:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> 
> because AFAICS we are just trying.
> Even if should_numa_migrate_memory() returns true, I assume that we will
> fail somewhere down the chain e.g: migrate_pages() when we see that this
> node does not any memory, right?
> 
> > A numa node might not have its local memory but CPUs. Promoting a folio
> > to the node's local memory is nonsense. So avoid nodes not set N_MEMORY
> > from getting promoted.
> 
> If you talk about memoryless nodes everybody gets it better IMHO.
> "Memoryless nodes do not have any memory to migrate to, so stop trying it."
> 
> 
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  kernel/sched/fair.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d7a3c63a2171..7ed9ef3c0134 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1828,6 +1828,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
> >  	int dst_nid = cpu_to_node(dst_cpu);
> >  	int last_cpupid, this_cpupid;
> >  
> > +	/*
> > +	 * A node of dst_nid might not have its local memory. Promoting
> > +	 * a folio to the node is meaningless.
> > +	 */
> > +	if (!node_state(dst_nid, N_MEMORY))
> > +		return false;
> 
> "Cannot migrate to memoryless nodes"
> 
> seems shorter and more clear.
> 
> So, what happens when we return true here? will we fail at
> migrate_pages() I guess? That is quite down the road so I guess
> this check can save us some time.
> 
> 
> -- 
> Oscar Salvador
> SUSE Labs
> 

-- 
Oscar Salvador
SUSE Labs

