Return-Path: <linux-kernel+bounces-67633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B73856E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD0A1C21A57
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C953139588;
	Thu, 15 Feb 2024 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZI/jCPPv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4AQXmCFX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZI/jCPPv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4AQXmCFX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C782595
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027380; cv=none; b=UqvTpohtsGsfYWWu8qHvERRm71LksU65/JNTmrjFKf+PmbpE67ospaCIOXIhk1oL++otgcFXif5n6T8Rpknx/Dz0oSrgaNYwN05TCURNyvajaNiQHykAEJjvvtTIeIsZ9UjKhRi4FXp9AXHc8DsIfh+pLaCE2KfBsW8G+9yAGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027380; c=relaxed/simple;
	bh=BY1ulfHWbWAbY8n900k5RjNBvv0Mmq5pUCy50iYD1l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoZWKt6y7GhU/MJXI+Pj+WwLpQ55v6RrLktnyU/zHcFbXbjEpYPmRlL4YRvOJf0qN2tj5L84EG9t4AhtcGQMyF0Iv1bhCu+sVrM15cTCWb72NAYpx0i6p+n2lN/bYhnKWG+eOskomYXiWqtDrC3pgnjPWkTLxigB2E+vfsQFtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZI/jCPPv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4AQXmCFX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZI/jCPPv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4AQXmCFX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85FF51F8D9;
	Thu, 15 Feb 2024 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708027376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PERVCXAFrMhan0F9FQFEGlBIXfFbcTjGpAr7PL6j+Xo=;
	b=ZI/jCPPvM7bk89EFGpEWJCJNroklydChgjcBal+t9/zyol+pSh+Puc3wsVBpLgJAarDI80
	RRJ44XPgQNej6nM4bl25j0owukI4D9O0hAzy1DgmgNKfSA3MbFDGiTKbYUf82rhJM7nX5u
	vOeT3dl5GCVHd6dmMmmge7HGas8l7Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708027376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PERVCXAFrMhan0F9FQFEGlBIXfFbcTjGpAr7PL6j+Xo=;
	b=4AQXmCFXDnP3C93B/dAbH8Kz27Ko65oJohDbyLX07yACNs3eaOwaWxcUmrjF+MDL8//hCs
	IW2DGSEIqK/s8OBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708027376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PERVCXAFrMhan0F9FQFEGlBIXfFbcTjGpAr7PL6j+Xo=;
	b=ZI/jCPPvM7bk89EFGpEWJCJNroklydChgjcBal+t9/zyol+pSh+Puc3wsVBpLgJAarDI80
	RRJ44XPgQNej6nM4bl25j0owukI4D9O0hAzy1DgmgNKfSA3MbFDGiTKbYUf82rhJM7nX5u
	vOeT3dl5GCVHd6dmMmmge7HGas8l7Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708027376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PERVCXAFrMhan0F9FQFEGlBIXfFbcTjGpAr7PL6j+Xo=;
	b=4AQXmCFXDnP3C93B/dAbH8Kz27Ko65oJohDbyLX07yACNs3eaOwaWxcUmrjF+MDL8//hCs
	IW2DGSEIqK/s8OBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C6DE13A82;
	Thu, 15 Feb 2024 20:02:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vr7yCfBtzmVYNwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Feb 2024 20:02:56 +0000
Message-ID: <25a80b95-93e6-4d68-a3b1-35cd3ef9c421@suse.cz>
Date: Thu, 15 Feb 2024 21:02:55 +0100
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
References: <20240214220420.1229173-1-zi.yan@sent.com>
 <20240214220420.1229173-3-zi.yan@sent.com>
 <6a011e7f-4e21-4e31-a9a2-52cba3181337@suse.cz>
 <CA1FC23E-A652-4DD9-8E79-4956B2E11921@nvidia.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA1FC23E-A652-4DD9-8E79-4956B2E11921@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ZI/jCPPv";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4AQXmCFX
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLfsxmn1qwoupcjwdqfx65548p)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,intel.com,arm.com,linux-foundation.org,infradead.org,redhat.com,google.com,linux.intel.com,cmpxchg.org,linux.alibaba.com,huaweicloud.com,techsingularity.net,gmail.com,kernel.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: 85FF51F8D9
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/15/24 18:32, Zi Yan wrote:
> On 15 Feb 2024, at 11:57, Vlastimil Babka wrote:
> 
>> On 2/14/24 23:04, Zi Yan wrote:
>>> @@ -1849,10 +1857,22 @@ static struct folio *compaction_alloc(struct folio *src, unsigned long data)
>>>  static void compaction_free(struct folio *dst, unsigned long data)
>>>  {
>>>  	struct compact_control *cc = (struct compact_control *)data;
>>> +	int order = folio_order(dst);
>>> +	struct page *page = &dst->page;
>>> +
>>> +	if (folio_put_testzero(dst)) {
>>> +		free_pages_prepare_fpi_none(page, order);
>>> +
>>> +		INIT_LIST_HEAD(&dst->lru);
>>
>> (is this even needed? I think the state of first parameter of list_add() is
>> never expected to be in particular state?)
> 
> There is a __list_add_valid() performing list corruption checks.

Yes, but dst->lru becomes "new" in list_add() and __list_add_valid() and
those never check the contents of new, i.e. new->next or new->prev. We could
have done list_del(&dst->lru) which puts poison values there and then a
list_add() is fine. So dst->lru does not need the init, it's just confusing.
Init is for the list's list_head, not for the list entry.

>>>
>>> -	list_add(&dst->lru, &cc->freepages);
>>> -	cc->nr_freepages++;
>>> -	cc->nr_migratepages += 1 << folio_order(dst);
>>> +		list_add(&dst->lru, &cc->freepages[order]);
>>> +		cc->nr_freepages += 1 << order;
>>> +		cc->nr_migratepages += 1 << order;
>>
>> Hm actually this increment of nr_migratepages should happen even if we lost
>> the free page.
> 
> Because compaction_free() indicates the page is not migrated and nr_migratepages
> should be increased regardless.

Yes.

> Will fix it. Thanks.
> 
>>> +	}
>>> +	/*
>>> +	 * someone else has referenced the page, we cannot take it back to our
>>> +	 * free list.
>>> +	 */
>>>  }
> 
> 
> --
> Best Regards,
> Yan, Zi


