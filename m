Return-Path: <linux-kernel+bounces-71226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9996B85A230
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111771F21EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88C12C68C;
	Mon, 19 Feb 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qyxDsVl2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nTDEHiH1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qyxDsVl2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nTDEHiH1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4972D052;
	Mon, 19 Feb 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342805; cv=none; b=BiU2N8GmYbU4O9bIsxVjJpDz56GbTkgxoY5ipuYo6qYl7ixPcfUeHZi4iKKWMUhxVrU04eJwUrc4yG+fC2IXCWR/PDdbDpOQggn/fjJarNfFPLtRReJyReDkvkj9WdXT5PgcHQp+mM3S9rMmh4gQN+se2VCpCvVp0cvKE3/oj4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342805; c=relaxed/simple;
	bh=8w5CP+AO5f8hWR39DOrpl6lIQYcmtAL6hnFbGEfxNH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv85GfyCA1hyXgYwKi3jUMTFsz3zNk3vzePSas6QbUdoV7tDTLmWq+XaKfANtXKh2KGZh/VJhlWjmEKiZXZ9cstPlHM1Rd/QVWipr2FPk+mQZVUQC8CeDkrLVBsKTDDhTtFU4EHy+fxWIE0mCEEh+Tj6vdUZlAb5/+IFSB5Fn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qyxDsVl2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nTDEHiH1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qyxDsVl2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nTDEHiH1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3741E1FD12;
	Mon, 19 Feb 2024 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708342802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpNd7pScMzcCua32coUiV3InuIJm0wwq2wM8HmpeqA4=;
	b=qyxDsVl2nUf/elcWaG06ru0iwhkV3yDVeyszL4wtreYDPp2GliqZBCGCJhtrrsqr8j4cEU
	9FUpM5nyW3uDaGDQjC/F6gz9D5YSQxsqvFmC+YQYo1LfuB+MLTRJY38d3wm5txQIO3+R+H
	QjokKUPFJ/HyFhVFStL/1SucI/1Wt4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708342802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpNd7pScMzcCua32coUiV3InuIJm0wwq2wM8HmpeqA4=;
	b=nTDEHiH188LXGOCghi9RFOmdhpIEfrthQIl/Ne7U4pmnEm8boyJrpa2vN4ckwPYguaGbcV
	6V1jV3BEUoIdpbCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708342802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpNd7pScMzcCua32coUiV3InuIJm0wwq2wM8HmpeqA4=;
	b=qyxDsVl2nUf/elcWaG06ru0iwhkV3yDVeyszL4wtreYDPp2GliqZBCGCJhtrrsqr8j4cEU
	9FUpM5nyW3uDaGDQjC/F6gz9D5YSQxsqvFmC+YQYo1LfuB+MLTRJY38d3wm5txQIO3+R+H
	QjokKUPFJ/HyFhVFStL/1SucI/1Wt4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708342802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpNd7pScMzcCua32coUiV3InuIJm0wwq2wM8HmpeqA4=;
	b=nTDEHiH188LXGOCghi9RFOmdhpIEfrthQIl/Ne7U4pmnEm8boyJrpa2vN4ckwPYguaGbcV
	6V1jV3BEUoIdpbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EF9D139D0;
	Mon, 19 Feb 2024 11:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bBw4BxI+02W+NgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Feb 2024 11:40:02 +0000
Message-ID: <235ab5aa-90a4-4dd7-b2c6-70469605bcfb@suse.cz>
Date: Mon, 19 Feb 2024 12:40:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stall at page allocations with __GFP_RETRY_MAYFAIL (Re: [PATCH
 v1] ALSA: memalloc: Fix indefinite hang in non-iommu case)
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>,
 Karthikeyan Ramasubramanian <kramasub@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sven van Ashbrook <svenva@chromium.org>, Brian Geffon <bgeffon@google.com>,
 stable@vger.kernel.org, Curtis Malainey <cujomalainey@chromium.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-sound@vger.kernel.org, linux-mm@kvack.org
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
 <87jzn0ofdb.wl-tiwai@suse.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <87jzn0ofdb.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/19/24 12:36, Takashi Iwai wrote:
> On Thu, 15 Feb 2024 01:07:25 +0100,
> Karthikeyan Ramasubramanian wrote:
>> 
>> Before 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
>> the alsa non-contiguous allocator always called the alsa fallback
>> allocator in the non-iommu case. This allocated non-contig memory
>> consisting of progressively smaller contiguous chunks. Allocation was
>> fast due to the OR-ing in of __GFP_NORETRY.
>> 
>> After 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
>> the code tries the dma non-contig allocator first, then falls back to
>> the alsa fallback allocator. In the non-iommu case, the former supports
>> only a single contiguous chunk.
>> 
>> We have observed experimentally that under heavy memory fragmentation,
>> allocating a large-ish contiguous chunk with __GFP_RETRY_MAYFAIL
>> triggers an indefinite hang in the dma non-contig allocator. This has
>> high-impact, as an occurrence will trigger a device reboot, resulting in
>> loss of user state.
>> 
>> Fix the non-iommu path by letting dma_alloc_noncontiguous() fail quickly
>> so it does not get stuck looking for that elusive large contiguous chunk,
>> in which case we will fall back to the alsa fallback allocator.
>> 
>> Note that the iommu dma non-contiguous allocator is not affected. While
>> assembling an array of pages, it tries consecutively smaller contiguous
>> allocations, and lets higher-order chunk allocations fail quickly.
>> 
>> Suggested-by: Sven van Ashbrook <svenva@chromium.org>
>> Suggested-by: Brian Geffon <bgeffon@google.com>
>> Fixes: 9d8e536d36e7 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
>> Cc: stable@vger.kernel.org
>> Cc: Sven van Ashbrook <svenva@chromium.org>
>> Cc: Brian Geffon <bgeffon@google.com>
>> Cc: Curtis Malainey <cujomalainey@chromium.org>
>> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
> 
> After chatting with Vlastimil, he recommended to get linux-mm people
> involved, as basically such a problem shouldn't happen in the page
> allocator side.  So let's widen the audience.
> 
> To recap the thread: the problem is that dma_alloc_contiguous() call
> with high order pages and __GFP_FAIL_MAYRETRY leads to indefinite
> stall.  (It was __GFP_NORETRY beforehand.)  This looks like the code
> path with the direct page allocation where no IOMMU is involved.
> 
> Karthikeyan, Sven, and co: could you guys show the stack trace at the
> stall?  This may give us more clear light.

Yeah, if the inifinite loop with __GFP_RETRY_MAYFAIL happens in a call to
__alloc_pages and not in some retry loop around it in an upper layer (I
tried to check the dma functions but got lost quickly so the exact call
stack would be useful), we definitely want to know the details. It shouldn't
happen for costly orders (>3) because the retries are hard limited for those
despite apparent progress or reclaim or compaction.

> Also, Vlastimil suggested that tracepoints would be helpful if that's
> really in the page allocator, too.
> 
> 
> Thanks!
> 
> Takashi
> 
>> ---
>> 
>>  sound/core/memalloc.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
>> index f901504b5afc1..5f6526a0d731c 100644
>> --- a/sound/core/memalloc.c
>> +++ b/sound/core/memalloc.c
>> @@ -540,13 +540,18 @@ static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
>>  {
>>  	struct sg_table *sgt;
>>  	void *p;
>> +	gfp_t gfp_flags = DEFAULT_GFP;
>>  
>>  #ifdef CONFIG_SND_DMA_SGBUF
>>  	if (cpu_feature_enabled(X86_FEATURE_XENPV))
>>  		return snd_dma_sg_fallback_alloc(dmab, size);
>> +
>> +	/* Non-IOMMU case: prevent allocator from searching forever */
>> +	if (!get_dma_ops(dmab->dev.dev))
>> +		gfp_flags |= __GFP_NORETRY;
>>  #endif
>>  	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
>> -				      DEFAULT_GFP, 0);
>> +				      gfp_flags, 0);
>>  #ifdef CONFIG_SND_DMA_SGBUF
>>  	if (!sgt && !get_dma_ops(dmab->dev.dev))
>>  		return snd_dma_sg_fallback_alloc(dmab, size);
>> -- 
>> 2.43.0.687.g38aa6559b0-goog
>> 


