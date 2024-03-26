Return-Path: <linux-kernel+bounces-119302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A880588C6D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09E83B26333
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001913C833;
	Tue, 26 Mar 2024 15:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHFbGQhF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B6J2Jm8e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHFbGQhF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B6J2Jm8e"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D813C80C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711466735; cv=none; b=Jptp5jYIarVBn+V9JgyAuaOIzk2FKEW3YkU2SRz01asaJeXYCnK3BMG+dpM6sf9yyG6AcGTxVAphcgfuM+GkRrGqVy5A7dfv7mKyiT3KQsQGuB+d5o5+nVsOHU88uB73AEqwGctwIBH94emHHHDFHoebhcpM1AwTLXtz2quumEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711466735; c=relaxed/simple;
	bh=Lu5Bs7IrPqjAWtq1NQVli/B/ubR2OmxKpyJX7noirjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmJbttFTnL4Vlqgb9pr+snEge4wenx3KpWjaLLZRRIdUseLGX0NJzeFbblZUU7yzpQqKhjelgw5VNCk/mXvMmBOPK/IBuq2aNfYaI9WcgDNl0wh5VA/dEwKQH1/BDAjMqpD63IznYVO2nRmTbulV/fv1KLi4lOxQrsbNIwVLF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHFbGQhF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B6J2Jm8e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHFbGQhF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B6J2Jm8e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27C185D789;
	Tue, 26 Mar 2024 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711466730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPat731j6NfJAR1b0jUfvamnGYfQh4EZPTmICYWRNyg=;
	b=pHFbGQhFHA+FqBK9md8kt5lvks88yvdhyJXyEatmANMrwggwRBqImHAMT18+7iarRBs6/W
	l/FcQ0wPpyPp5wtiIOHFYqyHFMH20a2G417/RBaDJo+oyzfWEezsQlzzeaVrMZJdFidJTc
	tcUtuPauMwjtlpNK+XCPmHb+71V2E9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711466730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPat731j6NfJAR1b0jUfvamnGYfQh4EZPTmICYWRNyg=;
	b=B6J2Jm8enlEkEoqIQ5KMJ7S81iRWN8cyqPXkQf3KIah9hwuig1FqsavHbcQdKAruDIgdmi
	MaedXTQdY1qlfgAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711466730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPat731j6NfJAR1b0jUfvamnGYfQh4EZPTmICYWRNyg=;
	b=pHFbGQhFHA+FqBK9md8kt5lvks88yvdhyJXyEatmANMrwggwRBqImHAMT18+7iarRBs6/W
	l/FcQ0wPpyPp5wtiIOHFYqyHFMH20a2G417/RBaDJo+oyzfWEezsQlzzeaVrMZJdFidJTc
	tcUtuPauMwjtlpNK+XCPmHb+71V2E9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711466730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPat731j6NfJAR1b0jUfvamnGYfQh4EZPTmICYWRNyg=;
	b=B6J2Jm8enlEkEoqIQ5KMJ7S81iRWN8cyqPXkQf3KIah9hwuig1FqsavHbcQdKAruDIgdmi
	MaedXTQdY1qlfgAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12CD613306;
	Tue, 26 Mar 2024 15:25:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0LsrBOroAmabTQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Mar 2024 15:25:30 +0000
Message-ID: <8444ca4b-f59e-43fd-b458-186ead4cffa9@suse.cz>
Date: Tue, 26 Mar 2024 16:25:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] mm: page_alloc: close migratetype race between
 freeing and stealing
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-8-hannes@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240320180429.678181-8-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.50
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.00)[18.22%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pHFbGQhF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B6J2Jm8e
X-Rspamd-Queue-Id: 27C185D789

On 3/20/24 7:02 PM, Johannes Weiner wrote:
> There are three freeing paths that read the page's migratetype
> optimistically before grabbing the zone lock. When this races with
> block stealing, those pages go on the wrong freelist.
> 
> The paths in question are:
> - when freeing >costly orders that aren't THP
> - when freeing pages to the buddy upon pcp lock contention
> - when freeing pages that are isolated
> - when freeing pages initially during boot
> - when freeing the remainder in alloc_pages_exact()
> - when "accepting" unaccepted VM host memory before first use
> - when freeing pages during unpoisoning
> 
> None of these are so hot that they would need this optimization at the
> cost of hampering defrag efforts. Especially when contrasted with the
> fact that the most common buddy freeing path - free_pcppages_bulk - is
> checking the migratetype under the zone->lock just fine.
> 
> In addition, isolated pages need to look up the migratetype under the
> lock anyway, which adds branches to the locked section, and results in
> a double lookup when the pages are in fact isolated.
> 
> Move the lookups into the lock.
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


