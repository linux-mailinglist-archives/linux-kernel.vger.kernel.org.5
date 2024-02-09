Return-Path: <linux-kernel+bounces-59479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040684F7AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE472819B2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ACE128372;
	Fri,  9 Feb 2024 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPwpkAYp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IoBEP9Rv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dPwpkAYp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IoBEP9Rv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555CC12837A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707489157; cv=none; b=X5cF0QftdAIdPlJA8M4A1EGtbfw3FLDnGyOH5b32vpgqLghVrDPK210wL15Wo3YVXDCQoamxBplHtg+YEty+mx0OdSGFZHKl42Cy3DjD3jF+lYhsVhTQOlGnCgx9Z3xP7qTY3vQR0D2c2SdDr8E/VeKLOVGk7kWlSt3+dNScAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707489157; c=relaxed/simple;
	bh=IWAG3iZ8Dh5jMmT/GjEjH4OublYbEsUlHsgaDAc6kqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq98yCBNeNgOtmygyzoWxdB9S1f2IK174lLoDQqgZE6kmtRsYV0lVzldYoFwfzdqdHuU5vcRdUDhMx4cdmVJ4Udh8TE8Xv5AU2y3J7R8wOFgdrxfCgzlSIDvwUZtxY6WhtX28+d0ViOqM71XA6Qw3d7seU/6wl3J9DPIPwhLb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPwpkAYp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IoBEP9Rv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dPwpkAYp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IoBEP9Rv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56884220BC;
	Fri,  9 Feb 2024 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707489153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvaR8GHga17EqoSaRiIPdrwK05K74U/GowrqG7dNIBI=;
	b=dPwpkAYphKOr4kYrjwLDzqi7lhq8dEV2JhcAFDwlgXdwnwvQ48j7cfoplMxNFCWKw2EaGF
	scDk1jiMNx3qnN9yC7Euf06dZRvd7x5/qEN/dK2icgDH84Hd2LY22O4QsO91peplhYwq7x
	5yVazHrHUR7L6muAAVT+UTiCVE8voJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707489153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvaR8GHga17EqoSaRiIPdrwK05K74U/GowrqG7dNIBI=;
	b=IoBEP9RvwoX4kInT8LpmC5UBEx68qAqNXtmZjNcVuszPUOel6y+/FwtViVNkTN7C20Fm47
	fMCweZhsaiPw36AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707489153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvaR8GHga17EqoSaRiIPdrwK05K74U/GowrqG7dNIBI=;
	b=dPwpkAYphKOr4kYrjwLDzqi7lhq8dEV2JhcAFDwlgXdwnwvQ48j7cfoplMxNFCWKw2EaGF
	scDk1jiMNx3qnN9yC7Euf06dZRvd7x5/qEN/dK2icgDH84Hd2LY22O4QsO91peplhYwq7x
	5yVazHrHUR7L6muAAVT+UTiCVE8voJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707489153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvaR8GHga17EqoSaRiIPdrwK05K74U/GowrqG7dNIBI=;
	b=IoBEP9RvwoX4kInT8LpmC5UBEx68qAqNXtmZjNcVuszPUOel6y+/FwtViVNkTN7C20Fm47
	fMCweZhsaiPw36AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C97D1326D;
	Fri,  9 Feb 2024 14:32:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PRmNCoE3xmVncwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Feb 2024 14:32:33 +0000
Message-ID: <c42a6c9f-7d45-428c-95b9-98367ddba9d3@suse.cz>
Date: Fri, 9 Feb 2024 15:32:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm/compaction: enable compacting >0 order folios.
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
 <20240202161554.565023-2-zi.yan@sent.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240202161554.565023-2-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLqwhhqik4qyk5i1fk54co8f1o)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/2/24 17:15, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> migrate_pages() supports >0 order folio migration and during compaction,
> even if compaction_alloc() cannot provide >0 order free pages,
> migrate_pages() can split the source page and try to migrate the base pages
> from the split. It can be a baseline and start point for adding support for
> compacting >0 order folios.
> 
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/compaction.c | 43 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 4add68d40e8d..e43e898d2c77 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_control *cc)
>  	return too_many;
>  }
>  
> +/*
> + * 1. if the page order is larger than or equal to target_order (i.e.,
> + * cc->order and when it is not -1 for global compaction), skip it since
> + * target_order already indicates no free page with larger than target_order
> + * exists and later migrating it will most likely fail;
> + *
> + * 2. compacting > pageblock_order pages does not improve memory fragmentation,
> + * skip them;
> + */
> +static bool skip_isolation_on_order(int order, int target_order)
> +{
> +	return (target_order != -1 && order >= target_order) ||
> +		order >= pageblock_order;
> +}
> +
>  /**
>   * isolate_migratepages_block() - isolate all migrate-able pages within
>   *				  a single pageblock
> @@ -1010,7 +1025,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		/*
>  		 * Regardless of being on LRU, compound pages such as THP and
>  		 * hugetlbfs are not to be compacted unless we are attempting
> -		 * an allocation much larger than the huge page size (eg CMA).
> +		 * an allocation larger than the compound page size.
>  		 * We can potentially save a lot of iterations if we skip them
>  		 * at once. The check is racy, but we can consider only valid
>  		 * values and the only danger is skipping too much.
> @@ -1018,11 +1033,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  		if (PageCompound(page) && !cc->alloc_contig) {
>  			const unsigned int order = compound_order(page);
>  
> -			if (likely(order <= MAX_PAGE_ORDER)) {
> -				low_pfn += (1UL << order) - 1;
> -				nr_scanned += (1UL << order) - 1;
> +			/*
> +			 * Skip based on page order and compaction target order
> +			 * and skip hugetlbfs pages.
> +			 */
> +			if (skip_isolation_on_order(order, cc->order) ||
> +			    PageHuge(page)) {

Hm I'd try to avoid a new PageHuge() test here.

Earlier we have a block that does
                if (PageHuge(page) && cc->alloc_contig) {
			...

think I'd rather rewrite it to handle the PageHuge() case completely and
just make it skip the 1UL << order pages there for !cc->alloc_config. Even
if it means duplicating a bit of the low_pfn and nr_scanned bumping code.

Which reminds me the PageHuge() check there is probably still broken ATM:

https://lore.kernel.org/all/8fa1c95c-4749-33dd-42ba-243e492ab109@suse.cz/

Even better reason not to add another one.
If the huge page materialized since the first check, we should bail out when
testing PageLRU later anyway.

> +				if (order <= MAX_PAGE_ORDER) {
> +					low_pfn += (1UL << order) - 1;
> +					nr_scanned += (1UL << order) - 1;
> +				}
> +				goto isolate_fail;
>  			}
> -			goto isolate_fail;
>  		}
>  
>  		/*
> @@ -1165,10 +1187,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			}
>  
>  			/*
> -			 * folio become large since the non-locked check,
> -			 * and it's on LRU.
> +			 * Check LRU folio order under the lock
>  			 */
> -			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
> +			if (unlikely(skip_isolation_on_order(folio_order(folio),
> +							     cc->order) &&
> +				     !cc->alloc_contig)) {
>  				low_pfn += folio_nr_pages(folio) - 1;
>  				nr_scanned += folio_nr_pages(folio) - 1;
>  				folio_set_lru(folio);
> @@ -1786,6 +1809,10 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  	struct compact_control *cc = (struct compact_control *)data;
>  	struct folio *dst;
>  
> +	/* this makes migrate_pages() split the source page and retry */
> +	if (folio_test_large(src) > 0)
> +		return NULL;
> +
>  	if (list_empty(&cc->freepages)) {
>  		isolate_freepages(cc);
>  


