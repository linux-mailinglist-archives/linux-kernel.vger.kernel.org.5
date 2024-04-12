Return-Path: <linux-kernel+bounces-142772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A95E8A2FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4881F21779
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C176E85287;
	Fri, 12 Apr 2024 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CBD/MbzD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7AuqAnHB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CBD/MbzD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7AuqAnHB"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9086247
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930017; cv=none; b=FLyCI/FTl56ojS+mLMEy/y7ofUmm+TRNlfD4UkKslZfim7Z0QuZqJ/4FG3tE1gVWcrk2L2X7WsrkEWCMyXia/XuJQky411YHZK2KIwlYn2v4dE+kaNx+nVet8fml3ArXBGwdX6S0trFEfddSs6uvA78QrsVqbEKIaXsdr9COaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930017; c=relaxed/simple;
	bh=GpRfNZdAiZw1cko3Adj7uXMEBStX4Kvb6FwPmKFY+Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIKnQwhVVIcDdxNFKmemBrhxwoKnENaJddswTcKe3Z0qsELug+Q0Nospev4tvdZnQbsE9OP533n+8Pupun2OZ4fdoE/WYfBIF99y+93s9bjlQ/M8znSBjacrE3+HgGp1dhT9m8V4Xe5Iou0lm0bqbe/i78aqWCSDS+/4/+eFYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CBD/MbzD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7AuqAnHB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CBD/MbzD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7AuqAnHB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F337E3830F;
	Fri, 12 Apr 2024 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712930014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jCLBp0r4GxrmZerl3rC8Ggqs0l1ATGPD2aQmbUqPAUc=;
	b=CBD/MbzDWjQxuey1zwBm6rnFSe32HR4hrhhkHaHodFYalLO6TlPXNHri8G0bE2G4xVeeTb
	jW+ooGE7kZG4iLYvVCHW5upttpBzAQ1/kyHcmVt0vthqpdbEbyXN5iKG4oHwieR0twYkwI
	hll/Dy6z5NTe5Y/PB3XLuypUfR7posI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712930014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jCLBp0r4GxrmZerl3rC8Ggqs0l1ATGPD2aQmbUqPAUc=;
	b=7AuqAnHBi6HzN+IXZm6EqRvPOTn+ifE0iMDwxISYQ9A9DjH0F8CdrTTvga+MgtlnopAZAq
	ssNK/HhvvJjJrJDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712930014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jCLBp0r4GxrmZerl3rC8Ggqs0l1ATGPD2aQmbUqPAUc=;
	b=CBD/MbzDWjQxuey1zwBm6rnFSe32HR4hrhhkHaHodFYalLO6TlPXNHri8G0bE2G4xVeeTb
	jW+ooGE7kZG4iLYvVCHW5upttpBzAQ1/kyHcmVt0vthqpdbEbyXN5iKG4oHwieR0twYkwI
	hll/Dy6z5NTe5Y/PB3XLuypUfR7posI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712930014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jCLBp0r4GxrmZerl3rC8Ggqs0l1ATGPD2aQmbUqPAUc=;
	b=7AuqAnHBi6HzN+IXZm6EqRvPOTn+ifE0iMDwxISYQ9A9DjH0F8CdrTTvga+MgtlnopAZAq
	ssNK/HhvvJjJrJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D978413942;
	Fri, 12 Apr 2024 13:53:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Tr4MNd08GWaFZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 12 Apr 2024 13:53:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5758CA071E; Fri, 12 Apr 2024 15:53:33 +0200 (CEST)
Date: Fri, 12 Apr 2024 15:53:33 +0200
From: Jan Kara <jack@suse.cz>
To: Peng Zhang <zhangpeng362@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, dennisszhou@gmail.com,
	shakeelb@google.com, jack@suse.cz, surenb@google.com,
	kent.overstreet@linux.dev, mhocko@suse.cz, vbabka@suse.cz,
	yuzhao@google.com, yu.ma@intel.com, wangkefeng.wang@huawei.com,
	sunnanyong@huawei.com
Subject: Re: [RFC PATCH 0/3] mm: convert mm's rss stats into
 lazy_percpu_counter
Message-ID: <20240412135333.btd6e7wfprg4cmx2@quack3>
References: <20240412092441.3112481-1-zhangpeng362@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412092441.3112481-1-zhangpeng362@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,linux-foundation.org,gmail.com,google.com,suse.cz,linux.dev,intel.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email]

On Fri 12-04-24 17:24:38, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> Since commit f1a7941243c1 ("mm: convert mm's rss stats into
> percpu_counter"), the rss_stats have converted into percpu_counter,
> which convert the error margin from (nr_threads * 64) to approximately
> (nr_cpus ^ 2). However, the new percpu allocation in mm_init() causes a
> performance regression on fork/exec/shell. Even after commit
> 14ef95be6f55 ("kernel/fork: group allocation/free of per-cpu counters
> for mm struct"), the performance of fork/exec/shell is still poor
> compared to previous kernel versions.
> 
> To mitigate performance regression, we use lazy_percpu_counter[1] to
> delay the allocation of percpu memory for rss_stats. After lmbench test,
> we will get 3% ~ 6% performance improvement for lmbench
> fork_proc/exec_proc/shell_proc after conversion.
> 
> The test results are as follows:
> 
>              base           base+revert        base+lazy_percpu_counter
> 
> fork_proc    427.4ms        394.1ms  (7.8%)    413.9ms  (3.2%)
> exec_proc    2205.1ms       2042.2ms (7.4%)    2072.0ms (6.0%)
> shell_proc   3180.9ms       2963.7ms (6.8%)    3010.7ms (5.4%)
> 
> This solution has not been fully evaluated and tested. The main idea of
> this RFC patch series is to get the community's opinion on this approach.

Thanks! I like the idea and in fact I wanted to do something similar (just
never got to it). Thread [2] has couple of good observations regarding this
problem. Couple of thoughts regarding your approach:

1) I think switching to pcpu counter when update rate exceeds 256 updates/s
is not a great fit for RSS because the updates are going to be frequent in
some cases but usually they will all happen from one thread. So I think it
would make more sense to move the decision of switching to pcpu mode from
the counter itself into the callers and just switch on clone() when the
second thread gets created.

2) I thought that for RSS lazy percpu counters, we could directly use
struct percpu_counter and just make it that if 'counters' is NULL, the
counter is in atomic mode (count is used as atomic_long_t), if counters !=
NULL, we are in pcpu mode.

3) In [2] Mateusz had a good observation that the old RSS counters actually
used atomic operations only in rare cases so even lazy pcpu counters are
going to have worse performance for singlethreaded processes than the old
code. We could *almost* get away with non-atomic updates to counter->count
if it was not for occasional RSS updates from unrelated tasks. So it might
be worth it to further optimize the counters as:

struct rss_counter_single {
	void *state;			/* To detect switching to pcpu mode */
	atomic_long_t counter_atomic;	/* Used for foreign updates */
	long counter;			/* Used by local updates */
}

struct rss_counter {
	union {
		struct rss_counter_single single;
		/* struct percpu_counter needs to be modified to have
		 * 'counters' first to avoid issues for different
		 * architectures or with CONFIG_HOTPLUG_CPU enabled */
		struct percpu_counter pcpu;
	}
}

But I'm not sure this complexity is worth it so I'd do it as a separate
patch with separate benchmarking if at all.

								Honza

[2] https://lore.kernel.org/all/ZOPSEJTzrow8YFix@snowbird/

> 
> [1] https://lore.kernel.org/linux-iommu/20230501165450.15352-8-surenb@google.com/
> 
> Kent Overstreet (1):
>   Lazy percpu counters
> 
> ZhangPeng (2):
>   lazy_percpu_counter: include struct percpu_counter in struct
>     lazy_percpu_counter
>   mm: convert mm's rss stats into lazy_percpu_counter
> 
>  include/linux/lazy-percpu-counter.h |  88 +++++++++++++++++++
>  include/linux/mm.h                  |   8 +-
>  include/linux/mm_types.h            |   4 +-
>  include/trace/events/kmem.h         |   4 +-
>  kernel/fork.c                       |  12 +--
>  lib/Makefile                        |   2 +-
>  lib/lazy-percpu-counter.c           | 131 ++++++++++++++++++++++++++++
>  7 files changed, 232 insertions(+), 17 deletions(-)
>  create mode 100644 include/linux/lazy-percpu-counter.h
>  create mode 100644 lib/lazy-percpu-counter.c
> 
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

