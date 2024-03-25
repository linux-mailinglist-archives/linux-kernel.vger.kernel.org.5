Return-Path: <linux-kernel+bounces-117459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B788B067
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5086CBC640D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8D57174D;
	Mon, 25 Mar 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OitADZr/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCcozfZF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OitADZr/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCcozfZF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0569474
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383733; cv=none; b=LE6FCxHQs+G8iyjrQ8HNMRSEJKkzOFRdqcd1kwzkjHivxJH11cW7cbqE4g8DN7vzyII01Drth4TRtbjo3gigWJgo2t2AtFBCMhvwBDBj4tU2JU3Y7eODP1rIKmlSpO5rTFIi0Fj9div011pt8znINOEeXXm3woC8AsAa/t/3MDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383733; c=relaxed/simple;
	bh=34Fay1VYIuAdJvEofq/9qAHIIbMDTvr7zOVPImL2NVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvwCayY9z6HrFMayBLyDL4FfWP9sKKqhexUAwJevQgu6LlfuKKEgDAMcj5mftJ7qZKg0YIwMRrvXkculBZHue+KFFYlhvgsvMvFPGrExwIg+LBJT56Ou6N4RITGI5Y5Qq9BIpvlilSWumzzPABUvkLLWd4fMW6iyvPdsjYWoPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OitADZr/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCcozfZF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OitADZr/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCcozfZF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67C1F5C8FC;
	Mon, 25 Mar 2024 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711383729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pMQ/oo81Y3FaZHkSy9sDeQffPP6Xckn73dbgRd3Hhg=;
	b=OitADZr/dd+M3VXCCcIh1qtmFJkg0ojHQK8Vey6CMHdl15slRMfkP3XM7yMfQfw+iGNRE0
	YDVTxkkkkwLvYDEtivoWK0rVH+he8BTTH3yx0ifxr7eRJqeSfiqgG8MvpbeSCvgYFU6tKM
	7sg+7LI4QIP5B5ikL6fe8MHRI/gA/ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711383729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pMQ/oo81Y3FaZHkSy9sDeQffPP6Xckn73dbgRd3Hhg=;
	b=eCcozfZFcSUsbvTGonPLFjaOWfJfg9TNNuUBK9UUtVWDsDURNR64FI9Jzolc6FgbHTTKDa
	fkmjO6bYLtMrcMBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711383729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pMQ/oo81Y3FaZHkSy9sDeQffPP6Xckn73dbgRd3Hhg=;
	b=OitADZr/dd+M3VXCCcIh1qtmFJkg0ojHQK8Vey6CMHdl15slRMfkP3XM7yMfQfw+iGNRE0
	YDVTxkkkkwLvYDEtivoWK0rVH+he8BTTH3yx0ifxr7eRJqeSfiqgG8MvpbeSCvgYFU6tKM
	7sg+7LI4QIP5B5ikL6fe8MHRI/gA/ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711383729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pMQ/oo81Y3FaZHkSy9sDeQffPP6Xckn73dbgRd3Hhg=;
	b=eCcozfZFcSUsbvTGonPLFjaOWfJfg9TNNuUBK9UUtVWDsDURNR64FI9Jzolc6FgbHTTKDa
	fkmjO6bYLtMrcMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51F6E13503;
	Mon, 25 Mar 2024 16:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mm2XE7GkAWaRFgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 25 Mar 2024 16:22:09 +0000
Message-ID: <47ba1e37-6431-44c7-b809-61c7bd832893@suse.cz>
Date: Mon, 25 Mar 2024 17:22:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] mm: page_alloc: fix move_freepages_block() range
 error
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
 "Huang, Ying" <ying.huang@intel.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240320180429.678181-1-hannes@cmpxchg.org>
 <20240320180429.678181-6-hannes@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240320180429.678181-6-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.63
X-Spamd-Result: default: False [-2.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.34)[90.42%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 3/20/24 7:02 PM, Johannes Weiner wrote:
> When a block is partially outside the zone of the cursor page, the
> function cuts the range to the pivot page instead of the zone
> start. This can leave large parts of the block behind, which
> encourages incompatible page mixing down the line (ask for one type,
> get another), and thus long-term fragmentation.
> 
> This triggers reliably on the first block in the DMA zone, whose
> start_pfn is 1. The block is stolen, but everything before the pivot
> page (which was often hundreds of pages) is left on the old list.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a1376a6fe7e4..7373329763e6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1645,9 +1645,15 @@ int move_freepages_block(struct zone *zone, struct page *page,
>  	start_pfn = pageblock_start_pfn(pfn);
>  	end_pfn = pageblock_end_pfn(pfn) - 1;
>  
> -	/* Do not cross zone boundaries */
> +	/*
> +	 * The caller only has the lock for @zone, don't touch ranges
> +	 * that straddle into other zones. While we could move part of
> +	 * the range that's inside the zone, this call is usually
> +	 * accompanied by other operations such as migratetype updates
> +	 * which also should be locked.
> +	 */
>  	if (!zone_spans_pfn(zone, start_pfn))
> -		start_pfn = pfn;
> +		return 0;
>  	if (!zone_spans_pfn(zone, end_pfn))
>  		return 0;
>  


