Return-Path: <linux-kernel+bounces-59960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72D84FDED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A013D1C21782
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEB88F78;
	Fri,  9 Feb 2024 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0v0OBNxm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9kdUITPw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0v0OBNxm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9kdUITPw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE825610C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511779; cv=none; b=FmBH/3/Ce8WillkTBQMeWW7pgaXobjyZKwkrnExUWppzAqTbJZ/v5DjtecCAaL2Tc3F3aGKzee5oZdEf9teOUdCdd9rm3ehttS/NpgC8xthat15QjHt0iy9Y0X1tPXJUuLMY5ZDggfLitTdLVvN/FJJNsATedtRAjV0M4I562mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511779; c=relaxed/simple;
	bh=APJ5H2F3aDoJNMFMgsg2nxuxbhrbqYNwMQAdxvtCAfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnP7f7EMwSAu/ya1WygKnKym1+ArjDnI5+t6j3Nf4K8CgtGMgoXsQ4EBTZMGCCd6r+hyRccaCMfYjGTPYVheY9RMPVXx/jXx2trfT5fqvqLgq6JBJkpYliKHTOhoPUaLURfAeNA9VF86fAKRN2nis+QedQzHg7B0vjGeEXrDNfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0v0OBNxm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9kdUITPw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0v0OBNxm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9kdUITPw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1AC2122254;
	Fri,  9 Feb 2024 20:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707511775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOxkAzSV8PisbnYE0tdoMCGFPKAmlMR5dvEXJKmOxDk=;
	b=0v0OBNxmOjo2WFY/G0vp55/Eh847Y/Qz0FVZt46KGhU/anEQO9vOitg9kQmdJB8DRbpUy1
	HZsptByOqB/9Mqf0/nPOt9NfBdcoM80p+9WRTlynCQ5akGneyz8kSWk2rxwAGlthAOjAn7
	5IgZTJa44L3CAwCUk3I/ejGGoAyoYVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707511775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOxkAzSV8PisbnYE0tdoMCGFPKAmlMR5dvEXJKmOxDk=;
	b=9kdUITPw47W82o57/9nKabobcTOio21vrxIaGUvVgzYcG+i9txNgnVanuevizoYwXabdVn
	I1SLiurYOaf4S2CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707511775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOxkAzSV8PisbnYE0tdoMCGFPKAmlMR5dvEXJKmOxDk=;
	b=0v0OBNxmOjo2WFY/G0vp55/Eh847Y/Qz0FVZt46KGhU/anEQO9vOitg9kQmdJB8DRbpUy1
	HZsptByOqB/9Mqf0/nPOt9NfBdcoM80p+9WRTlynCQ5akGneyz8kSWk2rxwAGlthAOjAn7
	5IgZTJa44L3CAwCUk3I/ejGGoAyoYVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707511775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOxkAzSV8PisbnYE0tdoMCGFPKAmlMR5dvEXJKmOxDk=;
	b=9kdUITPw47W82o57/9nKabobcTOio21vrxIaGUvVgzYcG+i9txNgnVanuevizoYwXabdVn
	I1SLiurYOaf4S2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2FF113353;
	Fri,  9 Feb 2024 20:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CVNYNt6PxmX/XQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Feb 2024 20:49:34 +0000
Message-ID: <ff1276ea-acb9-41a3-8ec8-78389d63e2ec@suse.cz>
Date: Fri, 9 Feb 2024 21:49:34 +0100
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
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Huang, Ying" <ying.huang@intel.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 <84dfedc4-a0a2-4e02-9be4-2cffc6e9fd06@suse.cz>
 <8E042D2A-B4B1-4538-946C-A63A0DB64FE0@nvidia.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <8E042D2A-B4B1-4538-946C-A63A0DB64FE0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.59 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.59

On 2/9/24 20:57, Zi Yan wrote:
> On 9 Feb 2024, at 13:43, Vlastimil Babka wrote:
> 
>> On 2/2/24 17:15, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> During migration in a memory compaction, free pages are placed in an array
>>> of page lists based on their order. But the desired free page order (i.e.,
>>> the order of a source page) might not be always present, thus leading to
>>> migration failures and premature compaction termination. Split a high
>>> order free pages when source migration page has a lower order to increase
>>> migration successful rate.
>>>
>>> Note: merging free pages when a migration fails and a lower order free
>>> page is returned via compaction_free() is possible, but there is too much
>>> work. Since the free pages are not buddy pages, it is hard to identify
>>> these free pages using existing PFN-based page merging algorithm.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/compaction.c | 37 ++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 36 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 58a4e3fb72ec..fa9993c8a389 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -1832,9 +1832,43 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>>>  	struct compact_control *cc = (struct compact_control *)data;
>>>  	struct folio *dst;
>>>  	int order = folio_order(src);
>>> +	bool has_isolated_pages = false;
>>>
>>> +again:
>>>  	if (!cc->freepages[order].nr_pages) {
>>> -		isolate_freepages(cc);
>>> +		int i;
>>> +
>>> +		for (i = order + 1; i < NR_PAGE_ORDERS; i++) {
>>
>> You could probably just start with a loop that finds the start_order (and do
>> the isolate_freepages() attempt if there's none) and then handle the rest
>> outside of the loop. No need to separately handle the case where you have
>> the exact order available?
> Like this?

Almost/

> if (list_empty(&cc->freepages[order].pages)) {

You don't need to do that under that if ().

>         int start_order;
> 
>         for (start_order = order + 1; start_order < NR_PAGE_ORDERS;

Just do start_order = order; ... (not order + 1).

The rest should just work.

>              start_order++)
>                 if (!list_empty(&cc->freepages[start_order].pages))
>                         break;
> 
>         /* no free pages in the list */
>         if (start_order == NR_PAGE_ORDERS) {
>                 if (!has_isolated_pages) {
>                         isolate_freepages(cc);
>                         has_isolated_pages = true;
>                         goto again;
>                 } else
>                         return NULL;
>         }
> 
>         struct page *freepage =
>                 list_first_entry(&cc->freepages[start_order].pages,
>                                  struct page, lru);
> 
>         unsigned long size = 1 << start_order;
> 
>         list_del(&freepage->lru);
> 
>         while (start_order > order) {
>                 start_order--;
>                 size >>= 1;
> 
>                 list_add(&freepage[size].lru,
>                         &cc->freepages[start_order].pages);
>                 set_page_private(&freepage[size], start_order);
>         }
>         dst = (struct folio *)freepage;
>         goto done;
> }
> 
>>
>>> +			if (cc->freepages[i].nr_pages) {
>>> +				struct page *freepage =
>>> +					list_first_entry(&cc->freepages[i].pages,
>>> +							 struct page, lru);
>>> +
>>> +				int start_order = i;
>>> +				unsigned long size = 1 << start_order;
>>> +
>>> +				list_del(&freepage->lru);
>>> +				cc->freepages[i].nr_pages--;
>>> +
>>> +				while (start_order > order) {
>>
>> With exact order available this while loop will just be skipped and that's
>> all the difference to it?
>>
>>> +					start_order--;
>>> +					size >>= 1;
>>> +
>>> +					list_add(&freepage[size].lru,
>>> +						&cc->freepages[start_order].pages);
>>> +					cc->freepages[start_order].nr_pages++;
>>> +					set_page_private(&freepage[size], start_order);
>>> +				}
>>> +				dst = (struct folio *)freepage;
>>> +				goto done;
>>> +			}
>>> +		}
>>> +		if (!has_isolated_pages) {
>>> +			isolate_freepages(cc);
>>> +			has_isolated_pages = true;
>>> +			goto again;
>>> +		}
>>> +
>>>  		if (!cc->freepages[order].nr_pages)
>>>  			return NULL;
>>>  	}
>>> @@ -1842,6 +1876,7 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>>>  	dst = list_first_entry(&cc->freepages[order].pages, struct folio, lru);
>>>  	cc->freepages[order].nr_pages--;
>>>  	list_del(&dst->lru);
>>> +done:
>>>  	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
>>>  	if (order)
>>>  		prep_compound_page(&dst->page, order);
> 
> 
> --
> Best Regards,
> Yan, Zi


