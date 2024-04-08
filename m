Return-Path: <linux-kernel+bounces-134911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77ABA89B897
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE73CB226E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19F25632;
	Mon,  8 Apr 2024 07:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fBn2188k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5bBQXTwO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fBn2188k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5bBQXTwO"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3D25619
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561905; cv=none; b=EGJ/IGU7DwVksaoPwXfxcpHelqU73CKs+BTFlfC/dCGUBNGJsBCQ70TbE4yayAj7n6vm/k11g6zHgwq1knSybRjHhcnQRPkzgM+cI/8te3YctMqu7C0owUUR9QvkBem5AW7491ZBWdpMSmaSQJ2i5umTRsR8+z0iJl3C4LH7NL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561905; c=relaxed/simple;
	bh=GTL/uT0QmdkDTJG+8EUVeHgZ1nLQq/V+K6ECxsaKgJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6P+NknW0R3kPQsyk5hr1KF4ZtnA7xBuflyKMsWq3m00+6SIQ8kCww7sevyTyxVX7DNQRnbMILrF5IksRJFd6bd3IhuxI0EXais15ZrUB1FY+aX5QDZFshg6pOTH27l4JrVqGP47CeN4mffQLAK9e2rgEc8gY4o31QkfDu06NWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fBn2188k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5bBQXTwO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fBn2188k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5bBQXTwO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D1881FDD9;
	Mon,  8 Apr 2024 07:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712561901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yDXYZ+HVnjL8LE33ELw6Ev7L7ptFfBFSiqjfmx+pLTk=;
	b=fBn2188kDItamcKZUw6GNFQi7zDvajXvdOuQ/G+qSX7jQGwSep87thmPdX7OtGF3ASS0UD
	ADSf9RNosB49Wou8xYnsqGkOIAU+AGCOBbniGxg72YiFK7Wey942WDa6z1KO5H7XvJ2fFy
	QfpzapNUfSUyz5C5FpwwdUTxfc8mpZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712561901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yDXYZ+HVnjL8LE33ELw6Ev7L7ptFfBFSiqjfmx+pLTk=;
	b=5bBQXTwOVkFCX54Tjtn+j1d+9yqYRoh8cSYD2edzGBtZ9CRMi3UDCad+i1ch+61upSlXyE
	+IO7ImUZ+FJO7hDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712561901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yDXYZ+HVnjL8LE33ELw6Ev7L7ptFfBFSiqjfmx+pLTk=;
	b=fBn2188kDItamcKZUw6GNFQi7zDvajXvdOuQ/G+qSX7jQGwSep87thmPdX7OtGF3ASS0UD
	ADSf9RNosB49Wou8xYnsqGkOIAU+AGCOBbniGxg72YiFK7Wey942WDa6z1KO5H7XvJ2fFy
	QfpzapNUfSUyz5C5FpwwdUTxfc8mpZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712561901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yDXYZ+HVnjL8LE33ELw6Ev7L7ptFfBFSiqjfmx+pLTk=;
	b=5bBQXTwOVkFCX54Tjtn+j1d+9yqYRoh8cSYD2edzGBtZ9CRMi3UDCad+i1ch+61upSlXyE
	+IO7ImUZ+FJO7hDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 422C0137D4;
	Mon,  8 Apr 2024 07:38:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lTN0D+2eE2bqWQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 08 Apr 2024 07:38:21 +0000
Message-ID: <ecb88320-9990-49e1-a58a-e8fc85b1da3f@suse.cz>
Date: Mon, 8 Apr 2024 09:38:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] mm: page_alloc: consolidate free page accounting
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-11-hannes@cmpxchg.org>
 <7b3b7f2e-7109-4e72-b1cf-259cb56f3629@linux.alibaba.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <7b3b7f2e-7109-4e72-b1cf-259cb56f3629@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.03
X-Spam-Level: 
X-Spamd-Result: default: False [-3.03 / 50.00];
	BAYES_HAM(-1.74)[93.40%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 4/7/24 12:19 PM, Baolin Wang wrote:
> On 2024/3/21 02:02, Johannes Weiner wrote:
>>   
>> +	account_freepages(page, zone, 1 << order, migratetype);
>> +
>>   	while (order < MAX_PAGE_ORDER) {
>> -		if (compaction_capture(capc, page, order, migratetype)) {
>> -			__mod_zone_freepage_state(zone, -(1 << order),
>> -								migratetype);
>> +		int buddy_mt = migratetype;
>> +
>> +		if (compaction_capture(capc, page, order, migratetype))
>>   			return;
>> -		}
> 
> IIUC, if the released page is captured by compaction, then the 
> statistics for free pages should be correspondingly decreased, 
> otherwise, there will be a slight regression for my thpcompact benchmark.
> 
> thpcompact Percentage Faults Huge
>                            k6.9-rc2-base        base + patch10 + 2 fixes	
> Percentage huge-1        78.18 (   0.00%)       71.92 (  -8.01%)
> Percentage huge-3        86.70 (   0.00%)       86.07 (  -0.73%)
> Percentage huge-5        90.26 (   0.00%)       78.02 ( -13.57%)
> Percentage huge-7        92.34 (   0.00%)       78.67 ( -14.81%)
> Percentage huge-12       91.18 (   0.00%)       81.04 ( -11.12%)
> Percentage huge-18       89.00 (   0.00%)       79.57 ( -10.60%)
> Percentage huge-24       90.52 (   0.00%)       80.07 ( -11.54%)
> Percentage huge-30       94.44 (   0.00%)       96.28 (   1.95%)
> Percentage huge-32       93.09 (   0.00%)       99.39 (   6.77%)
> 
> I add below fix based on your fix 2, then the thpcompact Percentage 
> looks good. How do you think for the fix?

Yeah another well spotted, thanks. "slight regression" is an understatement,
this affects not just a "statistics" but very important counter
NR_FREE_PAGES which IIUC would eventually become larger than reality, make
the watermark checks false positive and result in depleted reserves etc etc.
Actually wondering why we're not seeing -next failures already (or maybe I
just haven't noticed).

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 8330c5c2de6b..2facf844ef84 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -805,8 +805,10 @@ static inline void __free_one_page(struct page *page,
>          while (order < MAX_PAGE_ORDER) {
>                  int buddy_mt = migratetype;
> 
> -               if (compaction_capture(capc, page, order, migratetype))
> +               if (compaction_capture(capc, page, order, migratetype)) {
> +                       account_freepages(zone, -(1 << order), migratetype);
>                          return;
> +               }
> 
>                  buddy = find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
>                  if (!buddy)
> 
> With my fix, the THP percentage looks better:
>                        k6.9-rc2-base          base + patch10 + 2 fixes	+ 
> my fix
> Percentage huge-1        78.18 (   0.00%)       82.83 (   5.94%)
> Percentage huge-3        86.70 (   0.00%)       93.47 (   7.81%)
> Percentage huge-5        90.26 (   0.00%)       94.73 (   4.95%)
> Percentage huge-7        92.34 (   0.00%)       95.22 (   3.12%)
> Percentage huge-12       91.18 (   0.00%)       92.40 (   1.34%)
> Percentage huge-18       89.00 (   0.00%)       85.39 (  -4.06%)
> Percentage huge-24       90.52 (   0.00%)       94.70 (   4.61%)
> Percentage huge-30       94.44 (   0.00%)       97.00 (   2.71%)
> Percentage huge-32       93.09 (   0.00%)       92.87 (  -0.24%)


