Return-Path: <linux-kernel+bounces-67285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EE885692A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60895282ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C152A136998;
	Thu, 15 Feb 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sAaTsuOo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iqKsAvd/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sAaTsuOo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iqKsAvd/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C39132493
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013260; cv=none; b=hcdwYpa+foPp0f1OYm46+rQfDdnLXWOe6VNh5iTjl/yUQNohpHCAEt6Z3Cztt2esjZpJ4s25J+q/1t9vH5i/sEe1CxreMzLhmv3YfLd0gGGwD6+6voMPkjIT8ixHKFoy3o6GrbNYdL7YIh0A+VKOiRZsaI4VMP5mqTIeWHFgME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013260; c=relaxed/simple;
	bh=cFkg1NFdHZsMSWSF0TXSI9aqTMhPctGcVI+y8TWc5G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MR2YndrdxOsV4ivRlFQMDakjGfutkLEc2lozcLXY3VgWOwo+lWvKhhgN4eJN1OwJIKBrUbSBmVtf/BdwN0Q7rZn4pYptD0DFcR9OYoHsdxpDX3e/BUSxGk17w6JqnIhC+InG/EDh5NLdwmWNgSTv2vp9Pg3pYqWHgFU035MzYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sAaTsuOo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iqKsAvd/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sAaTsuOo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iqKsAvd/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC6CD1F8BD;
	Thu, 15 Feb 2024 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708013256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3aB1O/XufYYPRfT2DCizHtazLUMIEGEshtMYMYqQ3Y=;
	b=sAaTsuOolJA7WH22a80PJT82B1Q2K1Bv9f6lSI8om+Ges4rttWumugW2DwUBcg/X6QaFMt
	GBNCkwhNQGCsH6K3ZBAGX3YywGGwtp5CT5lJWBMwqzHFe6uxd7XWgq0ANKZL8JbtOBdILD
	ARc8fdYscDtSvR3YZLx9RKzuPcTWBjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708013256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3aB1O/XufYYPRfT2DCizHtazLUMIEGEshtMYMYqQ3Y=;
	b=iqKsAvd/rVBbS4oTm+QGapY4qfLETqvB1Bb+E/cp2PXXY3momkbYlVRYfteePXfUmVlMeO
	Yqp6+YleRvmhMhCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708013256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3aB1O/XufYYPRfT2DCizHtazLUMIEGEshtMYMYqQ3Y=;
	b=sAaTsuOolJA7WH22a80PJT82B1Q2K1Bv9f6lSI8om+Ges4rttWumugW2DwUBcg/X6QaFMt
	GBNCkwhNQGCsH6K3ZBAGX3YywGGwtp5CT5lJWBMwqzHFe6uxd7XWgq0ANKZL8JbtOBdILD
	ARc8fdYscDtSvR3YZLx9RKzuPcTWBjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708013256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3aB1O/XufYYPRfT2DCizHtazLUMIEGEshtMYMYqQ3Y=;
	b=iqKsAvd/rVBbS4oTm+QGapY4qfLETqvB1Bb+E/cp2PXXY3momkbYlVRYfteePXfUmVlMeO
	Yqp6+YleRvmhMhCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 969BC13A82;
	Thu, 15 Feb 2024 16:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QONoJMg2zmVIfwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 16:07:36 +0000
Message-ID: <7d2b44bb-e3b0-435d-98ff-670b5029bd93@suse.cz>
Date: Thu, 15 Feb 2024 17:07:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] mm/compaction: add support for >0 order folio
 memory compaction.
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
References: <20240214220420.1229173-1-zi.yan@sent.com>
 <20240214220420.1229173-3-zi.yan@sent.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214220420.1229173-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sAaTsuOo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="iqKsAvd/"
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BC6CD1F8BD
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO

On 2/14/24 23:04, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Before last commit, memory compaction only migrates order-0 folios and
> skips >0 order folios.  Last commit splits all >0 order folios during
> compaction.  This commit migrates >0 order folios during compaction by
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
> Step 3 is done for a latter optimization that splitting and/or merging
> free pages during compaction becomes easier.
> 
> Note: without splitting free pages, compaction can end prematurely due to
> migration will return -ENOMEM even if there is free pages.  This happens
> when no order-0 free page exist and compaction_alloc() return NULL.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Yu Zhao <yuzhao@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Noticed a possible simplification:

> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -447,6 +447,8 @@ extern void prep_compound_page(struct page *page, unsigned int order);
>  
>  extern void post_alloc_hook(struct page *page, unsigned int order,
>  					gfp_t gfp_flags);
> +extern bool free_pages_prepare_fpi_none(struct page *page, unsigned int order);
> +
>  extern int user_min_free_kbytes;
>  
>  extern void free_unref_page(struct page *page, unsigned int order);
> @@ -481,7 +483,7 @@ int split_free_page(struct page *free_page,
>   * completes when free_pfn <= migrate_pfn
>   */
>  struct compact_control {
> -	struct list_head freepages;	/* List of free pages to migrate to */
> +	struct list_head freepages[NR_PAGE_ORDERS];	/* List of free pages to migrate to */
>  	struct list_head migratepages;	/* List of pages being migrated */
>  	unsigned int nr_freepages;	/* Number of isolated free pages */
>  	unsigned int nr_migratepages;	/* Number of pages to migrate */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7ae4b74c9e5c..e6e2ac722a82 100644
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

Seems like free_pages_prepare() currently only passes  fpi_flags to
should_skip_kasan_poison() and that ignores them. You could remove the
parameter from both and declare and use free_pages_prepare(page, order)
directly.

> +}
> +
>  /*
>   * Frees a number of pages from the PCP lists
>   * Assumes all pages on list are in same zone.


