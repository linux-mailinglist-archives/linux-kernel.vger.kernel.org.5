Return-Path: <linux-kernel+bounces-118884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E488C09F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9860C1C37E63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0DF55787;
	Tue, 26 Mar 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bRYKe74h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MK4jiCYk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bRYKe74h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MK4jiCYk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDA3548F7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452522; cv=none; b=rDqJrR/EGwlr1gQufCY4eE6MXctWTpSnKEkWmAnhugPh+lhFqyL5AHpxHsWWHDCCqEiyUFJ7sEXRW95cUGHx3lKPQm5gFt43MSkP0gNv+8fGXTsro0fclzI03nXWDouCw05a8FXYeIRbF91Pgx7SsZ8P4S+AEdoDfYIftLxO95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452522; c=relaxed/simple;
	bh=sm7Ni5tyWxq4jVayuiiGFWZvLyYM7gkm0laKJpW00PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2CcwUwtu0wrrZDYiGcq5AhAQv6lOJKUMvj9XAsYrFyAC8DGS57CgPzc+JWHIOZMYHKqv/6gkZXPtpFPmLb9Lg/AtPCVezNvozr/SUrgc81b2CZte1pY6JMpxlgn0FhPsD6KndpM61lrOMKcRm5N9P6nhSnXy5KtGSkaZjHQWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bRYKe74h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MK4jiCYk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bRYKe74h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MK4jiCYk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6001C37AF8;
	Tue, 26 Mar 2024 11:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711452518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QrNWpOnpOslw16TWElkWPNU/kcnbluG5mElIbDpht4=;
	b=bRYKe74h1k7yBGWP6uuOjzpmQRbD+tUIijyvLVAb7FHH0JUEUiFrx6LkQwB/O3UBIKiZV4
	F3P+KHS5ZStWrw20E4z0NLnxzhMyG4bXwCjmZmwWEnq9JdjsNLcHMD1AQ6UT5OYzHA2a4p
	VgblDNAWJDPdB6WGt5kJ53O4TXDcpFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711452518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QrNWpOnpOslw16TWElkWPNU/kcnbluG5mElIbDpht4=;
	b=MK4jiCYkXMHOOlxelFraK6uTlINx638FiDqifeuQxh7gs4GMFaMs2mx9iRkqvaTNgL1yLi
	1dRkN/a+MrMmbsCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711452518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QrNWpOnpOslw16TWElkWPNU/kcnbluG5mElIbDpht4=;
	b=bRYKe74h1k7yBGWP6uuOjzpmQRbD+tUIijyvLVAb7FHH0JUEUiFrx6LkQwB/O3UBIKiZV4
	F3P+KHS5ZStWrw20E4z0NLnxzhMyG4bXwCjmZmwWEnq9JdjsNLcHMD1AQ6UT5OYzHA2a4p
	VgblDNAWJDPdB6WGt5kJ53O4TXDcpFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711452518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4QrNWpOnpOslw16TWElkWPNU/kcnbluG5mElIbDpht4=;
	b=MK4jiCYkXMHOOlxelFraK6uTlINx638FiDqifeuQxh7gs4GMFaMs2mx9iRkqvaTNgL1yLi
	1dRkN/a+MrMmbsCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44B5613306;
	Tue, 26 Mar 2024 11:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UjRpD2axAmbUEAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Mar 2024 11:28:38 +0000
Message-ID: <a0879316-31de-4fec-ad1f-caabbfff2e48@suse.cz>
Date: Tue, 26 Mar 2024 12:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] mm: page_alloc: fix freelist movement during block
 conversion
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-7-hannes@cmpxchg.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240320180429.678181-7-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.50
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bRYKe74h;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MK4jiCYk
X-Rspamd-Queue-Id: 6001C37AF8

On 3/20/24 7:02 PM, Johannes Weiner wrote:
> Currently, page block type conversion during fallbacks, atomic
> reservations and isolation can strand various amounts of free pages on
> incorrect freelists.
> 
> For example, fallback stealing moves free pages in the block to the
> new type's freelists, but then may not actually claim the block for
> that type if there aren't enough compatible pages already allocated.
> 
> In all cases, free page moving might fail if the block straddles more
> than one zone, in which case no free pages are moved at all, but the
> block type is changed anyway.
> 
> This is detrimental to type hygiene on the freelists. It encourages
> incompatible page mixing down the line (ask for one type, get another)
> and thus contributes to long-term fragmentation.
> 
> Split the process into a proper transaction: check first if conversion
> will happen, then try to move the free pages, and only if that was
> successful convert the block to the new type.
> 
> Tested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> @@ -1743,33 +1770,37 @@ static inline bool boost_watermark(struct zone *zone)
>  }
>  
>  /*
> - * This function implements actual steal behaviour. If order is large enough,
> - * we can steal whole pageblock. If not, we first move freepages in this
> - * pageblock to our migratetype and determine how many already-allocated pages
> - * are there in the pageblock with a compatible migratetype. If at least half
> - * of pages are free or compatible, we can change migratetype of the pageblock
> - * itself, so pages freed in the future will be put on the correct free list.
> + * This function implements actual steal behaviour. If order is large enough, we
> + * can claim the whole pageblock for the requested migratetype. If not, we check
> + * the pageblock for constituent pages; if at least half of the pages are free
> + * or compatible, we can still claim the whole block, so pages freed in the
> + * future will be put on the correct free list. Otherwise, we isolate exactly
> + * the order we need from the fallback block and leave its migratetype alone.
>   */
> -static void steal_suitable_fallback(struct zone *zone, struct page *page,
> -		unsigned int alloc_flags, int start_type, bool whole_block)
> +static struct page *
> +steal_suitable_fallback(struct zone *zone, struct page *page,
> +			int current_order, int order, int start_type,
> +			unsigned int alloc_flags, bool whole_block)
>  {
> -	unsigned int current_order = buddy_order(page);
>  	int free_pages, movable_pages, alike_pages;
> -	int old_block_type;
> +	unsigned long start_pfn, end_pfn;
> +	int block_type;
>  
> -	old_block_type = get_pageblock_migratetype(page);
> +	block_type = get_pageblock_migratetype(page);
>  
>  	/*
>  	 * This can happen due to races and we want to prevent broken
>  	 * highatomic accounting.
>  	 */
> -	if (is_migrate_highatomic(old_block_type))
> +	if (is_migrate_highatomic(block_type))
>  		goto single_page;
>  
>  	/* Take ownership for orders >= pageblock_order */
>  	if (current_order >= pageblock_order) {
> +		del_page_from_free_list(page, zone, current_order);
>  		change_pageblock_range(page, current_order, start_type);
> -		goto single_page;
> +		expand(zone, page, order, current_order, start_type);
> +		return page;

Is the exact order here important (AFAIK shouldn't be?) or we could just
change_pageblock_range(); block_type = start_type; goto single_page?

>  	}
>  
>  	/*
> @@ -1784,10 +1815,9 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
>  	if (!whole_block)
>  		goto single_page;
>  
> -	free_pages = move_freepages_block(zone, page, start_type,
> -						&movable_pages);
>  	/* moving whole block can fail due to zone boundary conditions */
> -	if (!free_pages)
> +	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
> +				       &free_pages, &movable_pages))
>  		goto single_page;
>  
>  	/*
> @@ -1805,7 +1835,7 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
>  		 * vice versa, be conservative since we can't distinguish the
>  		 * exact migratetype of non-movable pages.
>  		 */
> -		if (old_block_type == MIGRATE_MOVABLE)
> +		if (block_type == MIGRATE_MOVABLE)
>  			alike_pages = pageblock_nr_pages
>  						- (free_pages + movable_pages);
>  		else
> @@ -1816,13 +1846,16 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
>  	 * compatible migratability as our allocation, claim the whole block.
>  	 */
>  	if (free_pages + alike_pages >= (1 << (pageblock_order-1)) ||
> -			page_group_by_mobility_disabled)
> +			page_group_by_mobility_disabled) {
> +		move_freepages(zone, start_pfn, end_pfn, start_type);
>  		set_pageblock_migratetype(page, start_type);
> -
> -	return;
> +		return __rmqueue_smallest(zone, order, start_type);
> +	}
>  
>  single_page:
> -	move_to_free_list(page, zone, current_order, start_type);
> +	del_page_from_free_list(page, zone, current_order);
> +	expand(zone, page, order, current_order, block_type);
> +	return page;
>  }


