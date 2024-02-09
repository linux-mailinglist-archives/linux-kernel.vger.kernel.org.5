Return-Path: <linux-kernel+bounces-59950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33BB84FDC9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C590A1C20A20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F9C6AB7;
	Fri,  9 Feb 2024 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJdjc6ff";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZqzsBhrL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IJdjc6ff";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZqzsBhrL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA4568A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511385; cv=none; b=V1b6ZGoehSorUTMwpO/oNkJjlSqwSUXf+7s3g0xqmgvbaUNRzpDgWWVxMFNIJAD4Pa2TV4OHhB2/xIQM77+OZ26hjXEdgB4qASruYxz7N48CKJTT2GHDcg10UMGZ/EkHQ1HxGCaDpmk4GOZVvKA5/kvwkeDH0F8hqQNf1a2Os/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511385; c=relaxed/simple;
	bh=9kK6lZlGKhnm6G6FnouL8d9pH6VBbfAI8mP/vOOqTC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m9bSEv5FOFGP8nWYKxmVN1v/C7moMuFDlBqngvRBqiuie2cJhDNcQcjXDbwccgpTtNDwk9DdIRjUAT2XFGQDZLFDeaKcKO8wOnJJsj39KG6Dy9AW+kd+0WjIrHVgPEAs7Qlc6f3/tYISWowgzFm3fdu6XfXx07Ph+LV+0NT5cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJdjc6ff; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZqzsBhrL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IJdjc6ff; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZqzsBhrL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F91A21DDD;
	Fri,  9 Feb 2024 20:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707511381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPJrFIpcUFp3ljkSzw+njm70TJFkUJE5UKVeap+Smwo=;
	b=IJdjc6ffE2sXRMPORezrFCcH10QAAgA6YrcZWCY/Gpi8ipg/ndAuyj8vrDB8K3UnfpkJOQ
	nvX7C9QSrT91VTlORvYAzVoRUZMg4Jk8neNNqB4Xa8ovt6GB81bdo1Qsx5RkVcoXCHVoz8
	AMP4coUX4PU/f5FLnm85eCSqD0c3dWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707511381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPJrFIpcUFp3ljkSzw+njm70TJFkUJE5UKVeap+Smwo=;
	b=ZqzsBhrLrsaCWRnCo7gqEKFB/Qv6oOstLfTzhCMK9Ypp3KEMVTtf/xtAfy3C0cyYSQ0vHU
	f7IR/9p5IyrzY1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707511381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPJrFIpcUFp3ljkSzw+njm70TJFkUJE5UKVeap+Smwo=;
	b=IJdjc6ffE2sXRMPORezrFCcH10QAAgA6YrcZWCY/Gpi8ipg/ndAuyj8vrDB8K3UnfpkJOQ
	nvX7C9QSrT91VTlORvYAzVoRUZMg4Jk8neNNqB4Xa8ovt6GB81bdo1Qsx5RkVcoXCHVoz8
	AMP4coUX4PU/f5FLnm85eCSqD0c3dWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707511381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPJrFIpcUFp3ljkSzw+njm70TJFkUJE5UKVeap+Smwo=;
	b=ZqzsBhrLrsaCWRnCo7gqEKFB/Qv6oOstLfTzhCMK9Ypp3KEMVTtf/xtAfy3C0cyYSQ0vHU
	f7IR/9p5IyrzY1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DD7F13353;
	Fri,  9 Feb 2024 20:43:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MLGzElWOxmVyXAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Feb 2024 20:43:01 +0000
Message-ID: <b1db01bc-e0a3-42d3-8193-6e4bfd7c9f86@suse.cz>
Date: Fri, 9 Feb 2024 21:43:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm/compaction: enable compacting >0 order folios.
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
 <20240202161554.565023-2-zi.yan@sent.com>
 <c42a6c9f-7d45-428c-95b9-98367ddba9d3@suse.cz>
 <24D4AA55-42F5-4E9B-822D-2BE61D0FA51F@nvidia.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <24D4AA55-42F5-4E9B-822D-2BE61D0FA51F@nvidia.com>
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.59

On 2/9/24 20:25, Zi Yan wrote:
> On 9 Feb 2024, at 9:32, Vlastimil Babka wrote:
> 
>> On 2/2/24 17:15, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> migrate_pages() supports >0 order folio migration and during compaction,
>>> even if compaction_alloc() cannot provide >0 order free pages,
>>> migrate_pages() can split the source page and try to migrate the base pages
>>> from the split. It can be a baseline and start point for adding support for
>>> compacting >0 order folios.
>>>
>>> Suggested-by: Huang Ying <ying.huang@intel.com>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/compaction.c | 43 +++++++++++++++++++++++++++++++++++--------
>>>  1 file changed, 35 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 4add68d40e8d..e43e898d2c77 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_control *cc)
>>>  	return too_many;
>>>  }
>>>
>>> +/*
>>> + * 1. if the page order is larger than or equal to target_order (i.e.,
>>> + * cc->order and when it is not -1 for global compaction), skip it since
>>> + * target_order already indicates no free page with larger than target_order
>>> + * exists and later migrating it will most likely fail;
>>> + *
>>> + * 2. compacting > pageblock_order pages does not improve memory fragmentation,
>>> + * skip them;
>>> + */
>>> +static bool skip_isolation_on_order(int order, int target_order)
>>> +{
>>> +	return (target_order != -1 && order >= target_order) ||
>>> +		order >= pageblock_order;
>>> +}
>>> +
>>>  /**
>>>   * isolate_migratepages_block() - isolate all migrate-able pages within
>>>   *				  a single pageblock
>>> @@ -1010,7 +1025,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>>  		/*
>>>  		 * Regardless of being on LRU, compound pages such as THP and
>>>  		 * hugetlbfs are not to be compacted unless we are attempting
>>> -		 * an allocation much larger than the huge page size (eg CMA).
>>> +		 * an allocation larger than the compound page size.
>>>  		 * We can potentially save a lot of iterations if we skip them
>>>  		 * at once. The check is racy, but we can consider only valid
>>>  		 * values and the only danger is skipping too much.
>>> @@ -1018,11 +1033,18 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>>  		if (PageCompound(page) && !cc->alloc_contig) {
>>>  			const unsigned int order = compound_order(page);
>>>
>>> -			if (likely(order <= MAX_PAGE_ORDER)) {
>>> -				low_pfn += (1UL << order) - 1;
>>> -				nr_scanned += (1UL << order) - 1;
>>> +			/*
>>> +			 * Skip based on page order and compaction target order
>>> +			 * and skip hugetlbfs pages.
>>> +			 */
>>> +			if (skip_isolation_on_order(order, cc->order) ||
>>> +			    PageHuge(page)) {
>>
>> Hm I'd try to avoid a new PageHuge() test here.
>>
>> Earlier we have a block that does
>>                 if (PageHuge(page) && cc->alloc_contig) {
>> 			...
>>
>> think I'd rather rewrite it to handle the PageHuge() case completely and
>> just make it skip the 1UL << order pages there for !cc->alloc_config. Even
>> if it means duplicating a bit of the low_pfn and nr_scanned bumping code.
>>
>> Which reminds me the PageHuge() check there is probably still broken ATM:
>>
>> https://lore.kernel.org/all/8fa1c95c-4749-33dd-42ba-243e492ab109@suse.cz/
>>
>> Even better reason not to add another one.
>> If the huge page materialized since the first check, we should bail out when
>> testing PageLRU later anyway.
> 
> 
> OK, so basically something like:
> 
> if (PageHuge(page)) {
>     if (cc->alloc_contig) {

Yeah but I'd handle the !cc->alloc_contig first as that ends with a goto,
and then the rest doesn't need to be "} else { ... }" with extra identation

>         // existing code for PageHuge(page) && cc->allc_contig
>     } else {
>         const unsigned int order = compound_order(page);
> 
>         if (order <= MAX_PAGE_ORDER) {
>             low_pfn += (1UL << order) - 1;
>             nr_scanned += (1UL << order) - 1;
>         }
>         goto isolate_fail;
>     }
> }


