Return-Path: <linux-kernel+bounces-59823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13E084FC29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B91282800
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640069959;
	Fri,  9 Feb 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oDksP+4a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ql57Be3l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oDksP+4a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ql57Be3l"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C12E57339
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504208; cv=none; b=uiBeCKVjhFF4P3301IFHVwPQZ4ipf/S87vWkL1bsifo1ikS11EIUTKAjJgK/6Eiyw/gPWDvMC8E2x3xu88JoozDi2N82cElumZT30F9gfASr9xgEQdFBuvsUm0NWkXv3MbIT4UZv+ushsZmquPPN8z0ub7ul/AZhRtBWHTvDfj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504208; c=relaxed/simple;
	bh=8BNu6pIGu7uFfufiBUNIOSzn6hHb44tdCsXSjKBi27Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfOcUB4Qcq8+7svIhoyifsH4KMnFymjt4T8/iM7XQ/0YtiIxWiepCO4Lyh9awTbESLBwCIs5l56wWBqjjyZZuINRPYEeLhB5LGd+Hq6TIUvVHQyhn3Qs5l4kqjlOy7UKYRJ2tqsbbQsQAbuANo8xtAH/VZy1D0UkcpIIkB9DZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oDksP+4a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ql57Be3l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oDksP+4a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ql57Be3l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C2F71F823;
	Fri,  9 Feb 2024 18:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707504204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEYLn4TkDj+5w5M8frhbdwGFmGUrN6QrUzMzWCOgpfU=;
	b=oDksP+4a6mK9R7SbcISBVXnlhEr2HRVuI2SVyCZk/mRa/n1u9RW17Na6EZvLNBrO7H8lWu
	AJHZQSu9Mhpp873ZBYCALox9V2a1AELbDJZV/OqaEcSpKxpgEq0OmOMm2VqdrnfQLKKIom
	njvOZNL0xhjBnLamyalffZlYF4R2rXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707504204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEYLn4TkDj+5w5M8frhbdwGFmGUrN6QrUzMzWCOgpfU=;
	b=ql57Be3lwdHXayCYGQVnolMO/pvNZRDF3YscjV9kIumUUvtynQXIiX0la1ikcpJJyplzY/
	zsb6o0nIN3j+7gAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707504204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEYLn4TkDj+5w5M8frhbdwGFmGUrN6QrUzMzWCOgpfU=;
	b=oDksP+4a6mK9R7SbcISBVXnlhEr2HRVuI2SVyCZk/mRa/n1u9RW17Na6EZvLNBrO7H8lWu
	AJHZQSu9Mhpp873ZBYCALox9V2a1AELbDJZV/OqaEcSpKxpgEq0OmOMm2VqdrnfQLKKIom
	njvOZNL0xhjBnLamyalffZlYF4R2rXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707504204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEYLn4TkDj+5w5M8frhbdwGFmGUrN6QrUzMzWCOgpfU=;
	b=ql57Be3lwdHXayCYGQVnolMO/pvNZRDF3YscjV9kIumUUvtynQXIiX0la1ikcpJJyplzY/
	zsb6o0nIN3j+7gAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C85013353;
	Fri,  9 Feb 2024 18:43:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A5voDUxyxmVfPwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Feb 2024 18:43:24 +0000
Message-ID: <84dfedc4-a0a2-4e02-9be4-2cffc6e9fd06@suse.cz>
Date: Fri, 9 Feb 2024 19:43:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm/compaction: optimize >0 order folio compaction
 with free page split.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, "Yin, Fengwei"
 <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>, Rohan Puri
 <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20240202161554.565023-1-zi.yan@sent.com>
 <20240202161554.565023-4-zi.yan@sent.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240202161554.565023-4-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oDksP+4a;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ql57Be3l
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLfsxmn1qwoupcjwdqfx65548p)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[99.99%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: 6C2F71F823
X-Spam-Flag: NO

On 2/2/24 17:15, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> During migration in a memory compaction, free pages are placed in an array
> of page lists based on their order. But the desired free page order (i.e.,
> the order of a source page) might not be always present, thus leading to
> migration failures and premature compaction termination. Split a high
> order free pages when source migration page has a lower order to increase
> migration successful rate.
> 
> Note: merging free pages when a migration fails and a lower order free
> page is returned via compaction_free() is possible, but there is too much
> work. Since the free pages are not buddy pages, it is hard to identify
> these free pages using existing PFN-based page merging algorithm.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/compaction.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 58a4e3fb72ec..fa9993c8a389 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1832,9 +1832,43 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  	struct compact_control *cc = (struct compact_control *)data;
>  	struct folio *dst;
>  	int order = folio_order(src);
> +	bool has_isolated_pages = false;
>  
> +again:
>  	if (!cc->freepages[order].nr_pages) {
> -		isolate_freepages(cc);
> +		int i;
> +
> +		for (i = order + 1; i < NR_PAGE_ORDERS; i++) {

You could probably just start with a loop that finds the start_order (and do
the isolate_freepages() attempt if there's none) and then handle the rest
outside of the loop. No need to separately handle the case where you have
the exact order available?


> +			if (cc->freepages[i].nr_pages) {
> +				struct page *freepage =
> +					list_first_entry(&cc->freepages[i].pages,
> +							 struct page, lru);
> +
> +				int start_order = i;
> +				unsigned long size = 1 << start_order;
> +
> +				list_del(&freepage->lru);
> +				cc->freepages[i].nr_pages--;
> +
> +				while (start_order > order) {

With exact order available this while loop will just be skipped and that's
all the difference to it?

> +					start_order--;
> +					size >>= 1;
> +
> +					list_add(&freepage[size].lru,
> +						&cc->freepages[start_order].pages);
> +					cc->freepages[start_order].nr_pages++;
> +					set_page_private(&freepage[size], start_order);
> +				}
> +				dst = (struct folio *)freepage;
> +				goto done;
> +			}
> +		}
> +		if (!has_isolated_pages) {
> +			isolate_freepages(cc);
> +			has_isolated_pages = true;
> +			goto again;
> +		}
> +
>  		if (!cc->freepages[order].nr_pages)
>  			return NULL;
>  	}
> @@ -1842,6 +1876,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  	dst = list_first_entry(&cc->freepages[order].pages, struct folio, lru);
>  	cc->freepages[order].nr_pages--;
>  	list_del(&dst->lru);
> +done:
>  	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
>  	if (order)
>  		prep_compound_page(&dst->page, order);


