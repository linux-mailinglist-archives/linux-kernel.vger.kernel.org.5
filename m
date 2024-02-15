Return-Path: <linux-kernel+bounces-67354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61332856A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8366DB2576F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E9313665F;
	Thu, 15 Feb 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uj78eShb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d4x9GOGa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uj78eShb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d4x9GOGa"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29E135A75
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016295; cv=none; b=YvXslKwb0UrpU7w7z6ygpouOyRdjDzujFM9E4GGQjPMHgF41KTLr2CnV2cOw7KTsKJFoGHMZ+7uMdKDxeYE7Dl98L0mdaIHYYFPxqlE/B7pIHQKTDqoEBTWd6n8Mh2Ds+pyxR0rK1PL0YYwF0vNY3GO4SzbRQHVoJrxZCG+FT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016295; c=relaxed/simple;
	bh=VkRUamCXaPtSJ6IdITg+zE5jNmLdwfb4psxszPgy344=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gg/JD0oMTYVu0NIqM2C7H+5yk4+C4REpmy/Ji28xRawDtmauyvgTkERSug3hMcV39HN9esovmaOhU3Z1Mn/o3K8cmTihBpjFuGXKZgwgUbO6ch6QCYiVvt9OQH8GADgJ88Lztnlj/LP9DfvSJGc/S23jeMhQceUUih7ZnrAElN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uj78eShb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d4x9GOGa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uj78eShb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d4x9GOGa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2AE982222A;
	Thu, 15 Feb 2024 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708016263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7muDhr8z81X6jCxdMQftsbeBEUefCO81St+FLzSeTk=;
	b=Uj78eShbmCGOVbMuA28C8iKzGylYbSaStAQ4dkI/AZ2eOXwjEledvo1aAoWlaAJI4y2yC3
	7/GGEsczGzRkcT3MLZL4FPoXdvCMynBLLlkjTabgQznADQe+G2pITnpvd5dKe5THIpkhZb
	bYLdt6LpiRl9Sm9wsshAiKiEZcK2b5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708016263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7muDhr8z81X6jCxdMQftsbeBEUefCO81St+FLzSeTk=;
	b=d4x9GOGaorsYebiZnthGeD3C+cEhXXfg4FLEm4KMXI1XDv1rTnwL6z7SHoE8wuucanmu7h
	WiFbeh0TCVvumJCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708016263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7muDhr8z81X6jCxdMQftsbeBEUefCO81St+FLzSeTk=;
	b=Uj78eShbmCGOVbMuA28C8iKzGylYbSaStAQ4dkI/AZ2eOXwjEledvo1aAoWlaAJI4y2yC3
	7/GGEsczGzRkcT3MLZL4FPoXdvCMynBLLlkjTabgQznADQe+G2pITnpvd5dKe5THIpkhZb
	bYLdt6LpiRl9Sm9wsshAiKiEZcK2b5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708016263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7muDhr8z81X6jCxdMQftsbeBEUefCO81St+FLzSeTk=;
	b=d4x9GOGaorsYebiZnthGeD3C+cEhXXfg4FLEm4KMXI1XDv1rTnwL6z7SHoE8wuucanmu7h
	WiFbeh0TCVvumJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01A1E13A53;
	Thu, 15 Feb 2024 16:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uF5gO4ZCzmX7DAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 16:57:42 +0000
Message-ID: <6a011e7f-4e21-4e31-a9a2-52cba3181337@suse.cz>
Date: Thu, 15 Feb 2024 17:57:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] mm/compaction: add support for >0 order folio
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
References: <20240214220420.1229173-1-zi.yan@sent.com>
 <20240214220420.1229173-3-zi.yan@sent.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240214220420.1229173-3-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.41 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLqwhhqik4qyk5i1fk54co8f1o)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.00)[17.29%];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
X-Spam-Score: 1.41
X-Spam-Flag: NO

On 2/14/24 23:04, Zi Yan wrote:
> @@ -1849,10 +1857,22 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>  static void compaction_free(struct folio *dst, unsigned long data)
>  {
>  	struct compact_control *cc = (struct compact_control *)data;
> +	int order = folio_order(dst);
> +	struct page *page = &dst->page;
> +
> +	if (folio_put_testzero(dst)) {
> +		free_pages_prepare_fpi_none(page, order);
> +
> +		INIT_LIST_HEAD(&dst->lru);

(is this even needed? I think the state of first parameter of list_add() is
never expected to be in particular state?)

>  
> -	list_add(&dst->lru, &cc->freepages);
> -	cc->nr_freepages++;
> -	cc->nr_migratepages += 1 << folio_order(dst);
> +		list_add(&dst->lru, &cc->freepages[order]);
> +		cc->nr_freepages += 1 << order;
> +		cc->nr_migratepages += 1 << order;

Hm actually this increment of nr_migratepages should happen even if we lost
the free page.

> +	}
> +	/*
> +	 * someone else has referenced the page, we cannot take it back to our
> +	 * free list.
> +	 */
>  }


