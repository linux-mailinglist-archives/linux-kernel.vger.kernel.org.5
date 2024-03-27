Return-Path: <linux-kernel+bounces-121984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15988F039
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5841F1F33DED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907B152E1E;
	Wed, 27 Mar 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2TzdVPC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uBgE9NNi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T2TzdVPC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uBgE9NNi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AE72E405
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571749; cv=none; b=eweLI1E9Yma1uXKPPt1RD855W21uetXBqmpGgXZbd1X1TzHeaAOPgep7b89g74m62si9Z6c2R+dqmFosjDCmqaPWR0/ZExRtelLpxtEkZCAkFiM8bsx5gv3tp6wiMIG3I6xwjYXwrS4iRlEkLKutfyWGMmPLj+uHBLprtgU0cLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571749; c=relaxed/simple;
	bh=9wD/Eb5em+j3w9MgSn/NxkcPx3KLj1dZxzWdBYGL3io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNPomCuSZGzX5BLNxK7EhH0TIwmFY0HLHIXO0B52y28aagLJ0nTZ13RGMG7T5K/3m2zxZjpD5QOFOzaFacXLSqRxydXTMh5weQsx8OjUezt681WspyC4ZSje4Xo5B7gc+futAHUolDVwfjPjiPTPvaUrhnCaXtY1wChQtAtsiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2TzdVPC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uBgE9NNi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T2TzdVPC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uBgE9NNi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FE7F1FB89;
	Wed, 27 Mar 2024 20:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711571742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FH7v+n7QgUuxAhvGWuLq8652FIDvcKtO0Ev7YO8YbA=;
	b=T2TzdVPC+M07IkS8unjY0nFPstPkkXq98hl18oeQElnVlcFwrb8OPtV07kWgtJRRnnrZk7
	qznIcOlcjdtVAxesGqW1DHEKCiZ9aAF2xjW0ACa5fhy57dOfsET4V30oYa+ytSxBXbRPX9
	39Nh2FduqlwDbOhL5Y16xnTmUV0Ui10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711571742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FH7v+n7QgUuxAhvGWuLq8652FIDvcKtO0Ev7YO8YbA=;
	b=uBgE9NNi42e6KNdNBjlprdaBNgyz3E+AXPng4IQ51BQdBgsKx7Cco0703FCIpHnInAcCAX
	m+hIgCASAPaOGjBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711571742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FH7v+n7QgUuxAhvGWuLq8652FIDvcKtO0Ev7YO8YbA=;
	b=T2TzdVPC+M07IkS8unjY0nFPstPkkXq98hl18oeQElnVlcFwrb8OPtV07kWgtJRRnnrZk7
	qznIcOlcjdtVAxesGqW1DHEKCiZ9aAF2xjW0ACa5fhy57dOfsET4V30oYa+ytSxBXbRPX9
	39Nh2FduqlwDbOhL5Y16xnTmUV0Ui10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711571742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FH7v+n7QgUuxAhvGWuLq8652FIDvcKtO0Ev7YO8YbA=;
	b=uBgE9NNi42e6KNdNBjlprdaBNgyz3E+AXPng4IQ51BQdBgsKx7Cco0703FCIpHnInAcCAX
	m+hIgCASAPaOGjBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 19E4013AB3;
	Wed, 27 Mar 2024 20:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id im1cBR6DBGYXEwAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Wed, 27 Mar 2024 20:35:42 +0000
Message-ID: <5d287756-1c9d-40e0-92de-04c8ffa971cb@suse.cz>
Date: Wed, 27 Mar 2024 21:35:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mm: page_alloc: batch vmstat updates in expand()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <b5b09acc-8bca-4e8c-82d4-6542fc7e9aec@suse.cz>
 <20240327190111.GC7597@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240327190111.GC7597@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On 3/27/24 8:01 PM, Johannes Weiner wrote:
> On Wed, Mar 27, 2024 at 09:54:01AM +0100, Vlastimil Babka wrote:
>> > @@ -1314,10 +1349,10 @@ static inline void expand(struct zone *zone, struct page *page,
>> >  		 * Corresponding page table entries will not be touched,
>> >  		 * pages will stay not present in virtual address space
>> >  		 */
>> > -		if (set_page_guard(zone, &page[size], high, migratetype))
>> > +		if (set_page_guard(zone, &page[size], high))
>> >  			continue;
>> >  
>> > -		add_to_free_list(&page[size], zone, high, migratetype);
>> > +		add_to_free_list(&page[size], zone, high, migratetype, false);
>> 
>> This is account_freepages() in the hot loop, what if we instead used
>> __add_to_free_list(), sum up nr_pages and called account_freepages() once
>> outside of the loop?
> 
> How about this on top of the series? Could be folded into
> mm-page_alloc-consolidate-free-page-accounting, but for credit and
> bisectability (just in case) I think stand-alone makes sense.
> 
> ---
> 
> From 361f5df28183d85c7718fe0b579438d3d58777be Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Wed, 27 Mar 2024 12:29:25 -0400
> Subject: [PATCH 3/3] mm: page_alloc: batch vmstat updates in expand()
> 
> expand() currently updates vmstat for every subpage. This is
> unnecessary, since they're all of the same zone and migratetype.
> 
> Count added pages locally, then do a single vmstat update.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8987e8869f6d..13fe5c612fbe 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1341,6 +1341,7 @@ static inline void expand(struct zone *zone, struct page *page,
>  	int low, int high, int migratetype)
>  {
>  	unsigned long size = 1 << high;
> +	unsigned long nr_added = 0;
>  
>  	while (high > low) {
>  		high--;
> @@ -1356,9 +1357,11 @@ static inline void expand(struct zone *zone, struct page *page,
>  		if (set_page_guard(zone, &page[size], high))
>  			continue;
>  
> -		add_to_free_list(&page[size], zone, high, migratetype, false);
> +		__add_to_free_list(&page[size], zone, high, migratetype, false);
>  		set_buddy_order(&page[size], high);
> +		nr_added += size;
>  	}
> +	account_freepages(zone, nr_added, migratetype);
>  }
>  
>  static void check_new_page_bad(struct page *page)


