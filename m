Return-Path: <linux-kernel+bounces-120495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435F88D85C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D581F2571F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7FF2C1B4;
	Wed, 27 Mar 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SWMgrUe0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tb6KkLnb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SWMgrUe0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tb6KkLnb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E41CAAF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526800; cv=none; b=JPdT8CHOr8oQ3WCy0mAYuM62CGFzC4VCRcRUtptGMR3U8h/OPZr6yY0657RBYok06T41+InW/83fBjVsit/I/GyW1lmujEgn7IPY7nhUo4ErlBrDCZttOamSEocXewCymRNzeo5NF58KCGXC/XlyuUITT9TmSuCwo+bAKwbtGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526800; c=relaxed/simple;
	bh=BRYtL9VGgWS00XBNCQ/ZnOHDdP8AkBM62WVQ5Nj+mmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyMJRSQj67TgYHjskJxiJLgzJFb/qTg3RV1EC/NlN1NFa7++FeiFf0COqLawc8XWUsxXIS6+hAWigfKFHuxd1XooRso8arnJYbDi+IvmJ4XsqJoGFJ6GVwOpk4RxV6ttdrE7RC7zDSA6nHffROI5qHR2Z8/gzmvtrsb0sXiYBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SWMgrUe0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tb6KkLnb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SWMgrUe0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tb6KkLnb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B0BF60071;
	Wed, 27 Mar 2024 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711526794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUYGU3NEIN9vfbTpc5QK6zxczRpH5cZaM9EFD/D7o+I=;
	b=SWMgrUe0rVobFstorj0qemCViLTqQvMZ3NT4aeBCF6X6ptvJxKKAYUk36j2xeppHTDjCKP
	AIkths8wXl14AMnzYkey6vU+UZlIJrZiZTzOFDFXu5Jg3eQ38bSRtsUGCibPopNRCDZZVH
	Ea+NkZVOlvkz6vm31Q0ToZSb409LfTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711526794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUYGU3NEIN9vfbTpc5QK6zxczRpH5cZaM9EFD/D7o+I=;
	b=tb6KkLnbGFwiwIcR7r2R+UBjpcD19aWhPP1tGdn8r7vTTwBqr8tnveYJav4svZijzAPUAK
	C42BX3fDs0DJKCAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711526794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUYGU3NEIN9vfbTpc5QK6zxczRpH5cZaM9EFD/D7o+I=;
	b=SWMgrUe0rVobFstorj0qemCViLTqQvMZ3NT4aeBCF6X6ptvJxKKAYUk36j2xeppHTDjCKP
	AIkths8wXl14AMnzYkey6vU+UZlIJrZiZTzOFDFXu5Jg3eQ38bSRtsUGCibPopNRCDZZVH
	Ea+NkZVOlvkz6vm31Q0ToZSb409LfTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711526794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUYGU3NEIN9vfbTpc5QK6zxczRpH5cZaM9EFD/D7o+I=;
	b=tb6KkLnbGFwiwIcR7r2R+UBjpcD19aWhPP1tGdn8r7vTTwBqr8tnveYJav4svZijzAPUAK
	C42BX3fDs0DJKCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16F561369F;
	Wed, 27 Mar 2024 08:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nGAbBYrTA2aJBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 27 Mar 2024 08:06:34 +0000
Message-ID: <c97ba53f-b11e-42e3-a528-54a83884eec1@suse.cz>
Date: Wed, 27 Mar 2024 09:06:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] mm: page_isolation: prepare for hygienic freelists
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-10-hannes@cmpxchg.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240320180429.678181-10-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SWMgrUe0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tb6KkLnb
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[22.77%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -1.50
X-Rspamd-Queue-Id: 2B0BF60071
X-Spam-Flag: NO

On 3/20/24 7:02 PM, Johannes Weiner wrote:
> Page isolation currently sets MIGRATE_ISOLATE on a block, then drops
> zone->lock and scans the block for straddling buddies to split
> up. Because this happens non-atomically wrt the page allocator, it's
> possible for allocations to get a buddy whose first block is a regular
> pcp migratetype but whose tail is isolated. This means that in certain
> cases memory can still be allocated after isolation. It will also
> trigger the freelist type hygiene warnings in subsequent patches.
> 
> start_isolate_page_range()
>   isolate_single_pageblock()
>     set_migratetype_isolate(tail)
>       lock zone->lock
>       move_freepages_block(tail) // nop
>       set_pageblock_migratetype(tail)
>       unlock zone->lock
>                                                      __rmqueue_smallest()
>                                                        del_page_from_freelist(head)
>                                                        expand(head, head_mt)
>                                                          WARN(head_mt != tail_mt)
>     start_pfn = ALIGN_DOWN(MAX_ORDER_NR_PAGES)
>     for (pfn = start_pfn, pfn < end_pfn)
>       if (PageBuddy())
>         split_free_page(head)
> 
> Introduce a variant of move_freepages_block() provided by the
> allocator specifically for page isolation; it moves free pages,
> converts the block, and handles the splitting of straddling buddies
> while holding zone->lock.
> 
> The allocator knows that pageblocks and buddies are always naturally
> aligned, which means that buddies can only straddle blocks if they're
> actually >pageblock_order. This means the search-and-split part can be
> simplified compared to what page isolation used to do.
> 
> Also tighten up the page isolation code around the expectations of
> which pages can be large, and how they are freed.
> 
> Based on extensive discussions with and invaluable input from Zi Yan.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Nice cleanup of hairy code as well!

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


