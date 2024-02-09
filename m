Return-Path: <linux-kernel+bounces-59955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A454684FDE3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED921F23F74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C211DDF6E;
	Fri,  9 Feb 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkDYnOwE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j6ZCK+NV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkDYnOwE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j6ZCK+NV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB59DF63
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511573; cv=none; b=UD+rnLhG5EbjDWkoOpzU47gMzh0xLOWcmwdfnvyxxrGgePe9GXmj8tGJLytIG9h62PJ2Zffb7D7dIC9qj7UIc+oq6iF0gv+xf621/WyJ+Yn/LUkeOpTGht0FfnUKWXmxGfhtHgM5+H+G3KJ3lgYd8OTKlFbFUMZbPzIQhgZ/GLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511573; c=relaxed/simple;
	bh=gAQ6M50ZXXK3Fo6hg1On3yx1TfKjpQVpv1Yzsw/j8s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BugOoeUH6hhYbwAOAoNEg1YrsE9sNSOKrHhx/X/pY6oi3zjt2iLgt9Jtkho2HTI9zVAi/d3q550wYOFYU+dXf18mHiMC1RbsLxhxaqzv7tU2zrpIzO7RcjMhuPf9BT3HeoGdMSRKWV4rvm9xe3Fr4e+5osxKCl0c6U+2pyIAMYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LkDYnOwE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j6ZCK+NV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LkDYnOwE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j6ZCK+NV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D98E1FD3B;
	Fri,  9 Feb 2024 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707511569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+iD+N31fBd2PKN2yLJNz4Wk4041RAH/rDCDtbwOEIo=;
	b=LkDYnOwE3s+D19ECppKGDTcaUa+aWRdV1MLsG13SgbVcJIYlarA75aIFsF35tQvKr4Z115
	ymoclUhUXBZZwZXOaLDqfnIHEaln64FILnn3WOYn9uwdUEEpm30EIC2wOqBgW+qXjTHTIH
	wHp5Ucvc+oncApwsEn5EYARjFBp/w5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707511569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+iD+N31fBd2PKN2yLJNz4Wk4041RAH/rDCDtbwOEIo=;
	b=j6ZCK+NVX2k937T2R3FDIjJcJf0VZE6V5CfJT+AeffBdnwoun9LufnVzFc8ELMYop45NfO
	vBVn0bWxQnDlbuBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707511569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+iD+N31fBd2PKN2yLJNz4Wk4041RAH/rDCDtbwOEIo=;
	b=LkDYnOwE3s+D19ECppKGDTcaUa+aWRdV1MLsG13SgbVcJIYlarA75aIFsF35tQvKr4Z115
	ymoclUhUXBZZwZXOaLDqfnIHEaln64FILnn3WOYn9uwdUEEpm30EIC2wOqBgW+qXjTHTIH
	wHp5Ucvc+oncApwsEn5EYARjFBp/w5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707511569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+iD+N31fBd2PKN2yLJNz4Wk4041RAH/rDCDtbwOEIo=;
	b=j6ZCK+NVX2k937T2R3FDIjJcJf0VZE6V5CfJT+AeffBdnwoun9LufnVzFc8ELMYop45NfO
	vBVn0bWxQnDlbuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6197B13353;
	Fri,  9 Feb 2024 20:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Fj3FhGPxmVFXQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Feb 2024 20:46:09 +0000
Message-ID: <28c47a9f-5ee4-425e-bd8d-bd251634534c@suse.cz>
Date: Fri, 9 Feb 2024 21:46:09 +0100
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
 <20240202161554.565023-3-zi.yan@sent.com>
 <025b7e7c-b17f-47c7-8677-ee36fc6dbc52@suse.cz>
 <5F394663-0AFE-4C12-827C-3A0723863395@nvidia.com>
 <193E0D43-0084-48AA-91F5-8316A130ADC3@nvidia.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <193E0D43-0084-48AA-91F5-8316A130ADC3@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.21
X-Spamd-Result: default: False [0.21 / 50.00];
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
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/9/24 20:40, Zi Yan wrote:
> On 9 Feb 2024, at 14:36, Zi Yan wrote:
> 
>> On 9 Feb 2024, at 11:37, Vlastimil Babka wrote:
>>
>>> On 2/2/24 17:15, Zi Yan wrote:
>>>
>>> ...
>>>
>>>>  /*
>>>> @@ -1835,9 +1857,17 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>>>>  static void compaction_free(struct folio *dst, unsigned long data)
>>>>  {
>>>>  	struct compact_control *cc = (struct compact_control *)data;
>>>> +	int order = folio_order(dst);
>>>> +	struct page *page = &dst->page;
>>>> +
>>>> +	folio_set_count(dst, 0);
>>>
>>> We can't change refcount to 0 like this, after it was already set to 1 and
>>> somebody else might have done get_page_unless_zero(). You need to either
>>> put_page_testzero() and if it's false, consider the page lost, or leave it
>>> refcounted and adjust the code to handle both refcounted and non-refcounted
>>> pages on the lists (the first option is simpler and shouldn't be too bad).
>> Got it. Will fix it with the first option. Thanks.
> 
> Do you think we should have a WARN or WARN_ONCE if we lose a page here?

No, no WARN, it all happens legitimately. It's only our compaction losing
the page - whoever would do the get_page_unless_zero() to inspect that page
would then have to put_page() which will free it back to page allocator.

> --
> Best Regards,
> Yan, Zi


