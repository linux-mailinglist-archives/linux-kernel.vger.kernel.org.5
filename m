Return-Path: <linux-kernel+bounces-72488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC83085B420
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026241C2278B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661B5A796;
	Tue, 20 Feb 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nM4aQe9A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xxj75LFW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nM4aQe9A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xxj75LFW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97505A782;
	Tue, 20 Feb 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414985; cv=none; b=KHoaxEuXoSq8UuOJC3D6ILeuZoBkmOhW+dHGfJ/H0XMmPR8gzAY3wPnmPuqk3djCC9GZiwpQJ5y2z2n9Egov/FHinwfC50Cm25MV9AZHJVH8OrRJwuNIKoocwGSb17yTCN2lVp5SRaE88mm6UXLLEl8FfOb2RlnL+3er3GzF0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414985; c=relaxed/simple;
	bh=NnwxAWUgAPSEAG2tb9b/O+QUPnXmxs6KGqBYX1R/+Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmnnSGDi7lTRtQ/nkoaKwCjV3EHTlQeoxzPtR7DzYnSA/ko9ursKkSmONTNWsjHwFQNN5sLDhc4AVuDhMt1xBEe/W65k9dkiZBNpRBqXRIQ//d+r4fyUhPBrdAPhtRnet64o0hz7jkzWmyRz+ZVyW5wTrsRTTixP+UBUgn2EHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nM4aQe9A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xxj75LFW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nM4aQe9A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xxj75LFW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C22A21E83;
	Tue, 20 Feb 2024 07:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708414981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP75gQ+KuAUWIsBrrfVvGIwpBE4lZR/yaSnCbNK3JAo=;
	b=nM4aQe9AUG8OB1eQInkY9Ey1DsyWYVDk188d6SvNNIgHsMFwsMVFV/MlTT+VWvxhX2+Sw5
	WRlyzHHj0HD090JpMzTpZ4Hu2rG6F6aAQvrxSKMuSV+lqTkZqxQDTnbC7dINm+3BasLuim
	8Vs5hjK9pKxdg/GIzHgCcwRTl++1lh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708414981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP75gQ+KuAUWIsBrrfVvGIwpBE4lZR/yaSnCbNK3JAo=;
	b=Xxj75LFWc7tNaXnTr/HSZprPWtodjUnliFQX2qfQfv7XVJM4g6gsvO5QLb2fPQFULR4Yvd
	/p4S2vmzdSK1zUBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708414981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP75gQ+KuAUWIsBrrfVvGIwpBE4lZR/yaSnCbNK3JAo=;
	b=nM4aQe9AUG8OB1eQInkY9Ey1DsyWYVDk188d6SvNNIgHsMFwsMVFV/MlTT+VWvxhX2+Sw5
	WRlyzHHj0HD090JpMzTpZ4Hu2rG6F6aAQvrxSKMuSV+lqTkZqxQDTnbC7dINm+3BasLuim
	8Vs5hjK9pKxdg/GIzHgCcwRTl++1lh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708414981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YP75gQ+KuAUWIsBrrfVvGIwpBE4lZR/yaSnCbNK3JAo=;
	b=Xxj75LFWc7tNaXnTr/HSZprPWtodjUnliFQX2qfQfv7XVJM4g6gsvO5QLb2fPQFULR4Yvd
	/p4S2vmzdSK1zUBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D05BC134E4;
	Tue, 20 Feb 2024 07:43:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DTs8MQRY1GVrSgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Feb 2024 07:43:00 +0000
Message-ID: <f8255302-24d8-4847-a17c-01353f0a39e5@suse.cz>
Date: Tue, 20 Feb 2024 08:43:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: compaction: update the cc->nr_migratepages when
 allocating or freeing the freepages
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: mgorman@techsingularity.net, ziy@nvidia.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6440493f18da82298152b6305d6b41c2962a3ce6.1708409245.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6440493f18da82298152b6305d6b41c2962a3ce6.1708409245.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nM4aQe9A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xxj75LFW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 1C22A21E83
X-Spam-Flag: NO

On 2/20/24 07:16, Baolin Wang wrote:
> Currently we will use 'cc->nr_freepages >= cc->nr_migratepages' comparison
> to ensure that enough freepages are isolated in isolate_freepages(), however
> it just decreases the cc->nr_freepages without updating cc->nr_migratepages
> in compaction_alloc(), which will waste more CPU cycles and cause too many
> freepages to be isolated.
> 
> So we should also update the cc->nr_migratepages when allocating or freeing
> the freepages to avoid isolating excess freepages. And I can see fewer free
> pages are scanned and isolated when running thpcompact on my Arm64 server:
>                                        k6.7         k6.7_patched
> Ops Compaction pages isolated      120692036.00   118160797.00
> Ops Compaction migrate scanned     131210329.00   154093268.00
> Ops Compaction free scanned       1090587971.00  1080632536.00
> Ops Compact scan efficiency               12.03          14.26
> 
> Moreover, I did not see an obvious latency improvements, this is likely because
> isolating freepages is not the bottleneck in the thpcompact test case.
>                               k6.7                  k6.7_patched
> Amean     fault-both-1      1089.76 (   0.00%)     1080.16 *   0.88%*
> Amean     fault-both-3      1616.48 (   0.00%)     1636.65 *  -1.25%*
> Amean     fault-both-5      2266.66 (   0.00%)     2219.20 *   2.09%*
> Amean     fault-both-7      2909.84 (   0.00%)     2801.90 *   3.71%*
> Amean     fault-both-12     4861.26 (   0.00%)     4733.25 *   2.63%*
> Amean     fault-both-18     7351.11 (   0.00%)     6950.51 *   5.45%*
> Amean     fault-both-24     9059.30 (   0.00%)     9159.99 *  -1.11%*
> Amean     fault-both-30    10685.68 (   0.00%)    11399.02 *  -6.68%*
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

> ---
> Hi Andrew, please use this patch to replace below 2 old patches. Thanks.
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-20-04-19&id=cb30899d456d64fb83ee3e3d95cd9fbb18735d87
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything-2024-02-20-04-19&id=65713d1c4fc498d35dc1f7c1234ef815aa128429
> 
> Changes from v2:
>  - Add acked tag from Mel.
>  - Fix the mm_compaction_migratepages trace event.
> Changes from v1:
>  - Rebased on the latest mm-unstable branch.
> ---
>  include/trace/events/compaction.h |  6 +++---
>  mm/compaction.c                   | 12 ++++++++++--
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/include/trace/events/compaction.h b/include/trace/events/compaction.h
> index 2b2a975efd20..d05759d18538 100644
> --- a/include/trace/events/compaction.h
> +++ b/include/trace/events/compaction.h
> @@ -78,10 +78,10 @@ DEFINE_EVENT(mm_compaction_isolate_template, mm_compaction_fast_isolate_freepage
>  #ifdef CONFIG_COMPACTION
>  TRACE_EVENT(mm_compaction_migratepages,
>  
> -	TP_PROTO(struct compact_control *cc,
> +	TP_PROTO(unsigned int nr_migratepages,
>  		unsigned int nr_succeeded),
>  
> -	TP_ARGS(cc, nr_succeeded),
> +	TP_ARGS(nr_migratepages, nr_succeeded),
>  
>  	TP_STRUCT__entry(
>  		__field(unsigned long, nr_migrated)
> @@ -90,7 +90,7 @@ TRACE_EVENT(mm_compaction_migratepages,
>  
>  	TP_fast_assign(
>  		__entry->nr_migrated = nr_succeeded;
> -		__entry->nr_failed = cc->nr_migratepages - nr_succeeded;
> +		__entry->nr_failed = nr_migratepages - nr_succeeded;
>  	),
>  
>  	TP_printk("nr_migrated=%lu nr_failed=%lu",
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 4494b2914386..218089b29f13 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1798,6 +1798,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  	dst = list_entry(cc->freepages.next, struct folio, lru);
>  	list_del(&dst->lru);
>  	cc->nr_freepages--;
> +	cc->nr_migratepages--;
>  
>  	return dst;
>  }
> @@ -1813,6 +1814,7 @@ static void compaction_free(struct folio *dst, unsigned long data)
>  
>  	list_add(&dst->lru, &cc->freepages);
>  	cc->nr_freepages++;
> +	cc->nr_migratepages++;
>  }
>  
>  /* possible outcome of isolate_migratepages */
> @@ -2435,7 +2437,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  	unsigned long last_migrated_pfn;
>  	const bool sync = cc->mode != MIGRATE_ASYNC;
>  	bool update_cached;
> -	unsigned int nr_succeeded = 0;
> +	unsigned int nr_succeeded = 0, nr_migratepages;
>  
>  	/*
>  	 * These counters track activities during zone compaction.  Initialize
> @@ -2553,11 +2555,17 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  				pageblock_start_pfn(cc->migrate_pfn - 1));
>  		}
>  
> +		/*
> +		 * Record the number of pages to migrate since the
> +		 * compaction_alloc/free() will update cc->nr_migratepages
> +		 * properly.
> +		 */
> +		nr_migratepages = cc->nr_migratepages;
>  		err = migrate_pages(&cc->migratepages, compaction_alloc,
>  				compaction_free, (unsigned long)cc, cc->mode,
>  				MR_COMPACTION, &nr_succeeded);
>  
> -		trace_mm_compaction_migratepages(cc, nr_succeeded);
> +		trace_mm_compaction_migratepages(nr_migratepages, nr_succeeded);
>  
>  		/* All pages were either migrated or will be released */
>  		cc->nr_migratepages = 0;


