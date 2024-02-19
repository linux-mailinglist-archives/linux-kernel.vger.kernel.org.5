Return-Path: <linux-kernel+bounces-71216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B642F85A210
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5052811C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1DA2C1BF;
	Mon, 19 Feb 2024 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gOkmpw19";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="igtd19NE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tRUmE+Cn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZckRGqD5"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61292D03B;
	Mon, 19 Feb 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708342580; cv=none; b=P988kjj7SRgcUgLBFMQb2Q9BM6YjA1OiA9+injGinTRnS+EbXFIGouWQq+/o0LTfzgZr7ogqtO5dn79lwOkelrN68EXguHjqZtHZ+vTW4lmCJGei+VNnm27kxg2EDi+AYpWavIw4KU2sIHBDFXkUdZeBEvltzACYnq8qJgJ63Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708342580; c=relaxed/simple;
	bh=07jpoRUIrwObwt2ZD2dN9rvvSrEplZmEqHo9sDSQ1Q0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7EuyqweSOJdj3yX+mFUBT39XScSwWfQeiAGvP7TKT9M2pahktn+Yxfb1kXJ0Q6skFwYrseMIR77+yt8GbkDk+6rtR7OiK4L3cu4GruPHfG1JeDvJchVhXK7KOeaqKfbCb3IsFjhr+SOF1LUeDvS9ni6jmZSHdmTI0gDGwq+dkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gOkmpw19; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=igtd19NE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tRUmE+Cn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZckRGqD5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D70111FD12;
	Mon, 19 Feb 2024 11:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708342577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++pUqJHlS6MN+oKKOs0BIVMJQQNPqDxn7dbMyMsqdUw=;
	b=gOkmpw19z0RcolN5EFVc39HdeoxMe3gMlPBy8snsKuN4tmu7l5HB3uhAbykbuCj4ChLDpA
	gVmAlQ/HlOIsl3qgP2WS5pSabK5iBX+voUryLyfTC10GZGR+wosW32N/WIiCMHCpY0h7/L
	ss1Xwf6RKDivqoWA+juSRbHCNM6teTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708342577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++pUqJHlS6MN+oKKOs0BIVMJQQNPqDxn7dbMyMsqdUw=;
	b=igtd19NEIa2EmtPk2qdNKnFWNQPkvo9dpf7KNVE1LpSYToWiIx8ubxKCSVwBBo4xjfbtA7
	N5ameFaJN2hgAgCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708342576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++pUqJHlS6MN+oKKOs0BIVMJQQNPqDxn7dbMyMsqdUw=;
	b=tRUmE+CnP981opXZAwsYl64iaXTTQovDQFgGeoEUIwszZv+cZbSU2V/I04YLCxmdc5PoLn
	S6TwJVxCOsc7iwRFbWGzi+SKYb9lS36rAdPXwqGxFyToFAVAblSa2JPSuN+r/jM27B+0hW
	lPMFzV9ISwoHju0d/QWmgO+lS7pAluE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708342576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=++pUqJHlS6MN+oKKOs0BIVMJQQNPqDxn7dbMyMsqdUw=;
	b=ZckRGqD5jDJNOFgF3rU02FnT4mfbdm+38yq0HgGvvweKT/k+MlzZsKysJoZC7f3emHI9z0
	aJtzJ1lb49sQfZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D3BC139D0;
	Mon, 19 Feb 2024 11:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6HgmHTA902XeNQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Feb 2024 11:36:16 +0000
Date: Mon, 19 Feb 2024 12:36:16 +0100
Message-ID: <87jzn0ofdb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sven van Ashbrook <svenva@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	stable@vger.kernel.org,
	Curtis Malainey <cujomalainey@chromium.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org
Subject: Stall at page allocations with __GFP_RETRY_MAYFAIL (Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case)
In-Reply-To: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tRUmE+Cn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZckRGqD5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: D70111FD12
X-Spam-Flag: NO

On Thu, 15 Feb 2024 01:07:25 +0100,
Karthikeyan Ramasubramanian wrote:
> 
> Before 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
> the alsa non-contiguous allocator always called the alsa fallback
> allocator in the non-iommu case. This allocated non-contig memory
> consisting of progressively smaller contiguous chunks. Allocation was
> fast due to the OR-ing in of __GFP_NORETRY.
> 
> After 9d8e536 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
> the code tries the dma non-contig allocator first, then falls back to
> the alsa fallback allocator. In the non-iommu case, the former supports
> only a single contiguous chunk.
> 
> We have observed experimentally that under heavy memory fragmentation,
> allocating a large-ish contiguous chunk with __GFP_RETRY_MAYFAIL
> triggers an indefinite hang in the dma non-contig allocator. This has
> high-impact, as an occurrence will trigger a device reboot, resulting in
> loss of user state.
> 
> Fix the non-iommu path by letting dma_alloc_noncontiguous() fail quickly
> so it does not get stuck looking for that elusive large contiguous chunk,
> in which case we will fall back to the alsa fallback allocator.
> 
> Note that the iommu dma non-contiguous allocator is not affected. While
> assembling an array of pages, it tries consecutively smaller contiguous
> allocations, and lets higher-order chunk allocations fail quickly.
> 
> Suggested-by: Sven van Ashbrook <svenva@chromium.org>
> Suggested-by: Brian Geffon <bgeffon@google.com>
> Fixes: 9d8e536d36e7 ("ALSA: memalloc: Try dma_alloc_noncontiguous() at first")
> Cc: stable@vger.kernel.org
> Cc: Sven van Ashbrook <svenva@chromium.org>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Curtis Malainey <cujomalainey@chromium.org>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>

After chatting with Vlastimil, he recommended to get linux-mm people
involved, as basically such a problem shouldn't happen in the page
allocator side.  So let's widen the audience.

To recap the thread: the problem is that dma_alloc_contiguous() call
with high order pages and __GFP_FAIL_MAYRETRY leads to indefinite
stall.  (It was __GFP_NORETRY beforehand.)  This looks like the code
path with the direct page allocation where no IOMMU is involved.

Karthikeyan, Sven, and co: could you guys show the stack trace at the
stall?  This may give us more clear light.

Also, Vlastimil suggested that tracepoints would be helpful if that's
really in the page allocator, too.


Thanks!

Takashi

> ---
> 
>  sound/core/memalloc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
> index f901504b5afc1..5f6526a0d731c 100644
> --- a/sound/core/memalloc.c
> +++ b/sound/core/memalloc.c
> @@ -540,13 +540,18 @@ static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
>  {
>  	struct sg_table *sgt;
>  	void *p;
> +	gfp_t gfp_flags = DEFAULT_GFP;
>  
>  #ifdef CONFIG_SND_DMA_SGBUF
>  	if (cpu_feature_enabled(X86_FEATURE_XENPV))
>  		return snd_dma_sg_fallback_alloc(dmab, size);
> +
> +	/* Non-IOMMU case: prevent allocator from searching forever */
> +	if (!get_dma_ops(dmab->dev.dev))
> +		gfp_flags |= __GFP_NORETRY;
>  #endif
>  	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
> -				      DEFAULT_GFP, 0);
> +				      gfp_flags, 0);
>  #ifdef CONFIG_SND_DMA_SGBUF
>  	if (!sgt && !get_dma_ops(dmab->dev.dev))
>  		return snd_dma_sg_fallback_alloc(dmab, size);
> -- 
> 2.43.0.687.g38aa6559b0-goog
> 

