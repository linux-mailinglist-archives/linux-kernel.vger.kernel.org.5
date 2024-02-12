Return-Path: <linux-kernel+bounces-61234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D9850F74
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C6D1C2145C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3BF101E8;
	Mon, 12 Feb 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NgfR+j9x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FH/Sng6q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NgfR+j9x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FH/Sng6q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835BAF51F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707729240; cv=none; b=I7FgTJDlwz9h3d69gpQo9R47Ij65KI4CIQb5dhUng7U9lYlwmCsJK96KYJjWH5V7xym5apOdIa3MWLAm5T5uu+H6DZibwP2T+koByK5iQiD/eTdJh8ybNyKDJ5B/kB0macQZUy3QbXlopdrTsxEHJEwWQ78ayNhKfQ8GEjIKf84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707729240; c=relaxed/simple;
	bh=rTWYqHYDvRBI+DRk+/jbNPaRiHUGi114yRDzDzEcEGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l99hE6E8PdPCw0VO3S9WMtlSOBzaWqySb4gmzTXyaduT61jcGbDULMv0dYyszcXuwCiG7y2jJIuR9PdqNVj3hQmLxAqD/b/9Hr3ZIYPhHDG/unz/NaEf5uxJYFupKHdnNDAYjDG5xVKKTx2y77kPo3YxVac+vSAtsYPiP2fEOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NgfR+j9x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FH/Sng6q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NgfR+j9x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FH/Sng6q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AB3BE1F457;
	Mon, 12 Feb 2024 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707729236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k7i6PGa+VnvHSMu8tCjQ92uFfMIfah6CK1ZLbbSmS4=;
	b=NgfR+j9xubFTcy1K7ELHQreF1nqp4lamsgMhZi1WzxrtIp4/I+alUp9zjnU1dY5xGqS3s2
	8iw6Bh0D59zu762v4lLbaAEyTsSBaLw1kAgPwSQ2rRHG9SdZy8LmTZk2QpevzCw05e9mRs
	qmX8WwgZfoJADBsK8ViP2awJyM7oguQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707729236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k7i6PGa+VnvHSMu8tCjQ92uFfMIfah6CK1ZLbbSmS4=;
	b=FH/Sng6qg2TlRjvFOYv4avzy+EfNrg9Kqg7Bd3zVhiK45GyHfeAOBKkZtnnG2gFvMUWCtj
	xR1IF2wGlR8QxSBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707729236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k7i6PGa+VnvHSMu8tCjQ92uFfMIfah6CK1ZLbbSmS4=;
	b=NgfR+j9xubFTcy1K7ELHQreF1nqp4lamsgMhZi1WzxrtIp4/I+alUp9zjnU1dY5xGqS3s2
	8iw6Bh0D59zu762v4lLbaAEyTsSBaLw1kAgPwSQ2rRHG9SdZy8LmTZk2QpevzCw05e9mRs
	qmX8WwgZfoJADBsK8ViP2awJyM7oguQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707729236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k7i6PGa+VnvHSMu8tCjQ92uFfMIfah6CK1ZLbbSmS4=;
	b=FH/Sng6qg2TlRjvFOYv4avzy+EfNrg9Kqg7Bd3zVhiK45GyHfeAOBKkZtnnG2gFvMUWCtj
	xR1IF2wGlR8QxSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A84A13985;
	Mon, 12 Feb 2024 09:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id arJhJVThyWWQfgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Feb 2024 09:13:56 +0000
Message-ID: <20c8fa7c-62ae-4e48-aaec-8b512519cee9@suse.cz>
Date: Mon, 12 Feb 2024 10:13:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: compaction: limit the suitable target page order
 to be less than cc->order
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 Zi Yan <ziy@nvidia.com>
Cc: mgorman@techsingularity.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.09

On 1/22/24 14:01, Baolin Wang wrote:
> It can not improve the fragmentation if we isolate the target free pages
> exceeding cc->order, especially when the cc->order is less than pageblock_order.
> For example, suppose the pageblock_order is MAX_ORDER (size is 4M) and cc->order
> is 2M THP size, we should not isolate other 2M free pages to be the migration
> target, which can not improve the fragmentation.
> 
> Moreover this is also applicable for large folio compaction.

So why not Cc: Zi Yan? (done)

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

I doubt this will make much difference, because if such a larger order free
page exists, we shouldn't have a reason to be compacting for a lower order
in the first place?

> ---
>  mm/compaction.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 27ada42924d5..066b72b3471a 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1346,12 +1346,14 @@ static bool suitable_migration_target(struct compact_control *cc,
>  {
>  	/* If the page is a large free page, then disallow migration */
>  	if (PageBuddy(page)) {
> +		int order = cc->order > 0 ? cc->order : pageblock_order;
> +
>  		/*
>  		 * We are checking page_order without zone->lock taken. But
>  		 * the only small danger is that we skip a potentially suitable
>  		 * pageblock, so it's not worth to check order for valid range.
>  		 */
> -		if (buddy_order_unsafe(page) >= pageblock_order)
> +		if (buddy_order_unsafe(page) >= order)
>  			return false;
>  	}
>  


