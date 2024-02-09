Return-Path: <linux-kernel+bounces-59618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97E84F9BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703141C21A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A4D7BAFC;
	Fri,  9 Feb 2024 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tAFh3NcO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qYWXlvNi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fp8C1Gx0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deVoTIPF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915E7AE6D
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496634; cv=none; b=fmKCqIXwffw17Ja330pd9zt42vqZnHH0SLn7jjRPRr5DdpaiL/C3h0fc9WQar50yOv5XliGYunAbuG/t8J/gqH6p5AMP5017/HJWuF7KLfImTRdFIRXRMKUczHYpTxkLufNhhh7cIKZ9dISs8mon+0X8fmM5yorY8Q0DoXMYiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496634; c=relaxed/simple;
	bh=IO07RBrMM6JdsAjR3Bjh4Ac/WCCBPTv6Q80IidcpjQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HR3KIUp5sC+QPXDFLBaty3dkBiSxUeAghy+Q950LpIacuBPNmbD5uLEtE3Nbu4Y1h41i6iYTMVAIwwZG+SocDM38LZfWsBAWhNeH47cGW4fAYauXD9EmmJSfLcFPDeuGiC7LwNyOmgeaWPJp7P+gfmkQRjZeBE8R9H2BBgvWZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tAFh3NcO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qYWXlvNi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fp8C1Gx0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deVoTIPF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BACA1F812;
	Fri,  9 Feb 2024 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707496629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDKKL0U7LaU3VV2//9ga67jQ7AvHjSSoo7VuO9ZKxWU=;
	b=tAFh3NcO/12GUGYM9ESNwau+NtesuyDpInwivGpGHvicb9IyZgDEbA/uNOL7NWRcBVbT/z
	zMbr0CstFPBW04eqlM2yCccInC68CmkcC/AWZmz5/0TiM9RU5JJ2J6zWgzXgCt18S9JbzH
	naPbihBE+Mt2+2JzTeGMr6RQNdlJgOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707496629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDKKL0U7LaU3VV2//9ga67jQ7AvHjSSoo7VuO9ZKxWU=;
	b=qYWXlvNiIBSo0MaK4xZGM3pIXHjB1q6XzpCje2LHIkmkGsrTyWe85U8tUi1msB+77CNacQ
	ZIipfKz7qt6scCBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707496628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDKKL0U7LaU3VV2//9ga67jQ7AvHjSSoo7VuO9ZKxWU=;
	b=Fp8C1Gx0nAqZZsH5aaMD7vxMH7wB4Z69bheRK7ZzgiBwHxzhx0PMaEMDRzEhLcdnf78c5z
	OqiUk93DTM0vTPD+lJBG3H5lM6ESo58UBDIEXN5MXjhzf711uuKAr4kRszRbXrc+DHdl7D
	eruVmTdEadqusQVJY1B+ANjsqLuqQ0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707496628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDKKL0U7LaU3VV2//9ga67jQ7AvHjSSoo7VuO9ZKxWU=;
	b=deVoTIPForqnBTr/xCwzq+fOTMCUbiGsBE1EimMxhDN8aP3AUwTr7V6nVZldvgh+uxWlW3
	ovzfyLw40WBaCJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CB5013353;
	Fri,  9 Feb 2024 16:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H/BXErRUxmX5GwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Feb 2024 16:37:08 +0000
Message-ID: <025b7e7c-b17f-47c7-8677-ee36fc6dbc52@suse.cz>
Date: Fri, 9 Feb 2024 17:37:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mm/compaction: add support for >0 order folio
 memory compaction.
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
 <20240202161554.565023-3-zi.yan@sent.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240202161554.565023-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Fp8C1Gx0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=deVoTIPF
X-Spamd-Result: default: False [-1.80 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLfsxmn1qwoupcjwdqfx65548p)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,nvidia.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7BACA1F812
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO

On 2/2/24 17:15, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Before last commit, memory compaction only migrates order-0 folios and
> skips >0 order folios. Last commit splits all >0 order folios during
> compaction. This commit migrates >0 order folios during compaction by
> keeping isolated free pages at their original size without splitting them
> into order-0 pages and using them directly during migration process.
> 
> What is different from the prior implementation:
> 1. All isolated free pages are kept in a NR_PAGE_ORDERS array of page
>    lists, where each page list stores free pages in the same order.
> 2. All free pages are not post_alloc_hook() processed nor buddy pages,
>    although their orders are stored in first page's private like buddy
>    pages.
> 3. During migration, in new page allocation time (i.e., in
>    compaction_alloc()), free pages are then processed by post_alloc_hook().
>    When migration fails and a new page is returned (i.e., in
>    compaction_free()), free pages are restored by reversing the
>    post_alloc_hook() operations using newly added
>    free_pages_prepare_fpi_none().
> 
> Step 3 is done for a latter optimization that splitting and/or merging free
> pages during compaction becomes easier.
> 
> Note: without splitting free pages, compaction can end prematurely due to
> migration will return -ENOMEM even if there is free pages. This happens
> when no order-0 free page exist and compaction_alloc() return NULL.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

..

>  /*
> @@ -1835,9 +1857,17 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  static void compaction_free(struct folio *dst, unsigned long data)
>  {
>  	struct compact_control *cc = (struct compact_control *)data;
> +	int order = folio_order(dst);
> +	struct page *page = &dst->page;
> +
> +	folio_set_count(dst, 0);

We can't change refcount to 0 like this, after it was already set to 1 and
somebody else might have done get_page_unless_zero(). You need to either
put_page_testzero() and if it's false, consider the page lost, or leave it
refcounted and adjust the code to handle both refcounted and non-refcounted
pages on the lists (the first option is simpler and shouldn't be too bad).

Perhaps folio_set_count()/set_page_count() should get some comment warning
against this kind of mistake.

> +	free_pages_prepare_fpi_none(page, order);
>  
> -	list_add(&dst->lru, &cc->freepages);
> -	cc->nr_freepages++;
> +	INIT_LIST_HEAD(&dst->lru);
> +
> +	list_add(&dst->lru, &cc->freepages[order].pages);
> +	cc->freepages[order].nr_pages++;
> +	cc->nr_freepages += 1 << order;
>  }
>  

..

>  
>  extern void free_unref_page(struct page *page, unsigned int order);
> @@ -473,6 +475,11 @@ int split_free_page(struct page *free_page,
>  /*
>   * in mm/compaction.c
>   */
> +
> +struct page_list {
> +	struct list_head	pages;
> +	unsigned long		nr_pages;

I've checked and even with patch 3/3 I don't think you actually need the
counter? The only check of the counter I noticed was to check for
zero/non-zero, and you could use list_empty() instead.

> +};
>  /*
>   * compact_control is used to track pages being migrated and the free pages
>   * they are being migrated to during memory compaction. The free_pfn starts
> @@ -481,7 +488,7 @@ int split_free_page(struct page *free_page,
>   * completes when free_pfn <= migrate_pfn
>   */
>  struct compact_control {
> -	struct list_head freepages;	/* List of free pages to migrate to */
> +	struct page_list freepages[NR_PAGE_ORDERS];	/* List of free pages to migrate to */
>  	struct list_head migratepages;	/* List of pages being migrated */
>  	unsigned int nr_freepages;	/* Number of isolated free pages */
>  	unsigned int nr_migratepages;	/* Number of pages to migrate */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5be4cd8f6b5a..c7c135e6d5ee 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1179,6 +1179,12 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	return true;
>  }
>  
> +__always_inline bool free_pages_prepare_fpi_none(struct page *page,
> +			unsigned int order)
> +{
> +	return free_pages_prepare(page, order, FPI_NONE);
> +}
> +
>  /*
>   * Frees a number of pages from the PCP lists
>   * Assumes all pages on list are in same zone.


