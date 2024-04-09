Return-Path: <linux-kernel+bounces-136288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14AA89D244
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DBA1C21F5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6028F7172F;
	Tue,  9 Apr 2024 06:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iMEWAwtl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H9WQHInF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iMEWAwtl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H9WQHInF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D66EB72
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643717; cv=none; b=IehWKWD6Ctxw1ZlOIyeoeC/s/z+r5nkb4NfrSahD7heamguA1n7sigwA83L6ef1bSW8oHbyQ8smaHtnhZJ8Z8COa29N3Ns/s/VZfmoVWEtmH3t7kIpF9tPH+iabeEKNUoj7R42fuETtquDcSnpz511YlXT/d76hAS1f1xQFl128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643717; c=relaxed/simple;
	bh=NDqcs5uDhXOn4quFJkZQHkWlSJEPh02+MUBR4aTcILg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UEIcEVI7T4qRFiv28Z+G1h2mW2nfLHi8KRzhj5wdPMEJsN32YEatCAOMgRe/5lPB16zStGkw35YNUnLdMcvnQ+37ho29P6OtXLGUIhF/Oyj2bUFpkqRKq74KaOWLIltzyRnd5DtIZnHEBKW7ryjOkY3E+ZOOcvhM1ljFVbt8zHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iMEWAwtl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H9WQHInF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iMEWAwtl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H9WQHInF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7282720809;
	Tue,  9 Apr 2024 06:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712643713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hCEsc9mIVyOaAe4f1JBlc/QIIG8e0U7alLBuZ0Z5nL0=;
	b=iMEWAwtlp8DYmPI21Zz2M8eUSmQhO1e8MK2C4W1BOQT0IjBp+EqwZl5STxmXyGpTkstln5
	0GuxDwl1B5pW5UjTR6zPQoBp2pExTpf7daiNgWDqPsSoJCwSUGIHcTOA0h4RxjCiCvRCTE
	gWZ8c7ERuJ6cUaOGf4aopTNyGG73dR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712643713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hCEsc9mIVyOaAe4f1JBlc/QIIG8e0U7alLBuZ0Z5nL0=;
	b=H9WQHInFWGGEF2uCGpFaEHlO0yjGTYX4Q0DlX2I9BAS+mviPagGuolb4Kzf4bqDcq65RpT
	E9RF1N4twm48MFDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iMEWAwtl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H9WQHInF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712643713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hCEsc9mIVyOaAe4f1JBlc/QIIG8e0U7alLBuZ0Z5nL0=;
	b=iMEWAwtlp8DYmPI21Zz2M8eUSmQhO1e8MK2C4W1BOQT0IjBp+EqwZl5STxmXyGpTkstln5
	0GuxDwl1B5pW5UjTR6zPQoBp2pExTpf7daiNgWDqPsSoJCwSUGIHcTOA0h4RxjCiCvRCTE
	gWZ8c7ERuJ6cUaOGf4aopTNyGG73dR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712643713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hCEsc9mIVyOaAe4f1JBlc/QIIG8e0U7alLBuZ0Z5nL0=;
	b=H9WQHInFWGGEF2uCGpFaEHlO0yjGTYX4Q0DlX2I9BAS+mviPagGuolb4Kzf4bqDcq65RpT
	E9RF1N4twm48MFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D3CA13313;
	Tue,  9 Apr 2024 06:21:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7LJaFoHeFGZ3LAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 09 Apr 2024 06:21:53 +0000
Message-ID: <8de812c5-de4b-4d7e-b24a-5674e9fba33d@suse.cz>
Date: Tue, 9 Apr 2024 08:21:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] mm: page_alloc: fix freelist movement during block
 conversion
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-7-hannes@cmpxchg.org>
 <a97697e0-45b0-4f71-b087-fdc7a1d43c0e@linux.alibaba.com>
 <20240405165632.GA870124@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240405165632.GA870124@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7282720809
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 4/5/24 6:56 PM, Johannes Weiner wrote:
> Hi Baolin,
> 
> On Fri, Apr 05, 2024 at 08:11:47PM +0800, Baolin Wang wrote:
>> On 2024/3/21 02:02, Johannes Weiner wrote:
>> > @@ -2127,15 +2165,14 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
>> >   				return page;
>> >   		}
>> >   	}
>> > -retry:
>> > +
>> >   	page = __rmqueue_smallest(zone, order, migratetype);
>> >   	if (unlikely(!page)) {
>> >   		if (alloc_flags & ALLOC_CMA)
>> >   			page = __rmqueue_cma_fallback(zone, order);
>> > -
>> > -		if (!page && __rmqueue_fallback(zone, order, migratetype,
>> > -								alloc_flags))
>> > -			goto retry;
>> > +		else
>> > +			page = __rmqueue_fallback(zone, order, migratetype,
>> > +						  alloc_flags);
>> 
>> (Sorry for chim in late.)
>> 
>> I have some doubts about the changes here. The original code logic was 
>> that if the 'migratetype' type allocation is failed, it would first try 
>> CMA page allocation and then attempt to fallback to other migratetype 
>> allocations. Now it has been changed so that if CMA allocation fails, it 
>> will directly return. This change has caused a regression when I running 
>> the thpcompact benchmark, resulting in a significant reduction in the 
>> percentage of THPs like below:
>> 
>> thpcompact Percentage Faults Huge
>>                           K6.9-rc2                K6.9-rc2 + this patch
>> Percentage huge-1        78.18 (   0.00%)       42.49 ( -45.65%)
>> Percentage huge-3        86.70 (   0.00%)       35.13 ( -59.49%)
>> Percentage huge-5        90.26 (   0.00%)       52.35 ( -42.00%)
>> Percentage huge-7        92.34 (   0.00%)       31.84 ( -65.52%)
>> Percentage huge-12       91.18 (   0.00%)       45.85 ( -49.72%)
>> Percentage huge-18       89.00 (   0.00%)       29.18 ( -67.22%)
>> Percentage huge-24       90.52 (   0.00%)       46.68 ( -48.43%)
>> Percentage huge-30       94.44 (   0.00%)       38.35 ( -59.39%)
>> Percentage huge-32       93.09 (   0.00%)       39.37 ( -57.70%)
> 
> Ouch, sorry about that! I changed that specific part around later
> during development and didn't retest with CMA. I'll be sure to
> re-enable it again in my config.
> 
>> After making the following modifications, the regression is gone.
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index ce67dc6777fa..a7cfe65e45c1 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2139,7 +2139,8 @@ __rmqueue(struct zone *zone, unsigned int order, 
>> int migratetype,
>>          if (unlikely(!page)) {
>>                  if (alloc_flags & ALLOC_CMA)
>>                          page = __rmqueue_cma_fallback(zone, order);
>> -               else
>> +
>> +               if (!page)
>>                          page = __rmqueue_fallback(zone, order, migratetype,
>>                                                    alloc_flags);
>>          }
>> 
>> But I am not sure your original change is intentional? IIUC, we still 
>> need try fallbacking even though CMA allocation is failed, please 
>> correct me if I misunderstand your code. Thanks.
> 
> No, this was accidental. I missed that CMA dependency when changing
> things around for the new return type of __rmqueue_fallback(). Your
> fix is good: just because the request qualifies for CMA doesn't mean
> it will succeed from that region. We need the fallback for those.
> 
> Andrew, could you please pick up Baolin's change for this patch?
> 
> [baolin.wang@linux.alibaba.com: fix allocation failures with CONFIG_CMA]

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Thanks for debugging this and the fix, Baolin.


