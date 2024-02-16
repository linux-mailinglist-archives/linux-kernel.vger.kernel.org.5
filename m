Return-Path: <linux-kernel+bounces-68189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EF48576FF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7051C21EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B86C17591;
	Fri, 16 Feb 2024 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t9/LzMl2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eExjU4mE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t9/LzMl2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eExjU4mE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E68833
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708069884; cv=none; b=ieyRzWQPpv5sZtr+bIvgBZNvtCHyUim+KC3H80pIbThKSrolYUooJqhDJTAfrZRbjFPkJrVo4x8SZjPHtl9UiT3YErMVjAytp62xlWA/GCkqmK8hGmIr4B3Z7vKvYP621RNGOeOTVNprPRrwYRM5kRWjieXlTyHwfiaSYb/G524=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708069884; c=relaxed/simple;
	bh=8bF7goS6MKQSsc1bLSN9LL2IR7vzhurIY/xLn8K4R6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEZfWumK1bgF4urtiIaD7qEkWFnWJn9C4sz1x47i6SlWde8Ju0ewWLa0E1WbVpufvm44ruozeSrsvAmBP+uokpQXhIxEMxKJiFp50P5hnmQ7H+Ep1ssAK4s2dCHzo8kUg08sP9R1ORs3RfGdJOO8h9OCtCuSKiOyp04TNybp1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t9/LzMl2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eExjU4mE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t9/LzMl2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eExjU4mE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CE9A21EF8;
	Fri, 16 Feb 2024 07:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708069881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3kSRMNvYqoD1Oew8jvkJgmFhy+2180XepdgpQuG9JA=;
	b=t9/LzMl2CRtI/GwuTpbOZMw4MT6i2J2aZ5B+3sChAPt+vTv+R3FtsRTLN2EYo09OVMTzze
	uIBGQ0HX65xwCYkD1JIjYGi8O1Miu2w68ujiuyVjMwIAZo3Kub9PiwuXSgkFguaKEZlAic
	JV6KyavyjYKa6bBzR5dAuhEHbGY7R64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708069881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3kSRMNvYqoD1Oew8jvkJgmFhy+2180XepdgpQuG9JA=;
	b=eExjU4mE/PaJBmGZBUFFnwsmW/luxQEN4/qZ+UkFMcowV1HFpIpx+pUlRTwK6fioN6Z9mU
	sXTSABZrHG9yewDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708069881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3kSRMNvYqoD1Oew8jvkJgmFhy+2180XepdgpQuG9JA=;
	b=t9/LzMl2CRtI/GwuTpbOZMw4MT6i2J2aZ5B+3sChAPt+vTv+R3FtsRTLN2EYo09OVMTzze
	uIBGQ0HX65xwCYkD1JIjYGi8O1Miu2w68ujiuyVjMwIAZo3Kub9PiwuXSgkFguaKEZlAic
	JV6KyavyjYKa6bBzR5dAuhEHbGY7R64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708069881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3kSRMNvYqoD1Oew8jvkJgmFhy+2180XepdgpQuG9JA=;
	b=eExjU4mE/PaJBmGZBUFFnwsmW/luxQEN4/qZ+UkFMcowV1HFpIpx+pUlRTwK6fioN6Z9mU
	sXTSABZrHG9yewDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 46E7B13421;
	Fri, 16 Feb 2024 07:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pN+RDvgTz2WmaQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Fri, 16 Feb 2024 07:51:20 +0000
Date: Fri, 16 Feb 2024 08:52:30 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Byungchul Park <byungchul@sk.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH] sched/numa, mm: do not promote folios to nodes not set
 N_MEMORY
Message-ID: <Zc8UPuzii_5gTsrJ@localhost.localdomain>
References: <20240214035355.18335-1-byungchul@sk.com>
 <Zc0tFdGAzD9sCzZN@localhost.localdomain>
 <20240216070754.GB32626@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216070754.GB32626@system.software.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="t9/LzMl2";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eExjU4mE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.96 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
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
	 BAYES_HAM(-1.95)[94.76%]
X-Spam-Score: -6.96
X-Rspamd-Queue-Id: 1CE9A21EF8
X-Spam-Flag: NO

On Fri, Feb 16, 2024 at 04:07:54PM +0900, Byungchul Park wrote:
> For normal numa nodes, node_data[] is initialized at alloc_node_data(),
> but it's not for memoryless node. However, the node *gets onlined* at
> init_cpu_to_node().
> 
> Let's look at back free_area_init(). free_area_init_node() will be called
> with node_data[] not set yet, because it's already *onlined*. So
> ->zone_pgdat cannot be initialized properly in the path you mentioned.

I am might be missing something., so bear with me.

free_area_init() gets called before init_cpu_to_node() does.
free_area_init_node() gets called on every possible node.

free_area_init_node then() does

 pg_data_t *pgdat = NODE_DATA(nid);,

and then we call free_area_init_core().

free_area_init_core() does

 free_area_init_core() does
  zone_init_internals()

which ends up doing zone->zone_pgdat = NODE_DATA(nid);

If node_data[] was not set at all, we would already blow up when doing
the first

  for_each_node()
    pgdat = NODE_DATA(nid);
    free_area_init_node(nid);

back in free_area_init().


-- 
Oscar Salvador
SUSE Labs

