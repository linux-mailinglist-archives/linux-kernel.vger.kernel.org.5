Return-Path: <linux-kernel+bounces-127651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3613B894EED
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53381F22C76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBD758AD6;
	Tue,  2 Apr 2024 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MElHyioq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+kollIJY"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720517C8D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712050961; cv=none; b=eEYHeCJnelOiKd1vLp1sWo2Q/u2DL1vwceVWQAWG2/K9dj6qdQakZU0povPZARHczms4wO4/2bAwprW3Ch15MdgGBayixiFjTWWZZNQxpCXjs+XPCEIsgRcMzi4A5c6BL6sAs4c2ej2ymwz9gzXnU8EfFzX0LPf5OFW9k+pNLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712050961; c=relaxed/simple;
	bh=4//BeaKKZ5LF6SjvVz57mfBkZN0DZ++Kt9CmwEuQ/x0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A11QfrYnG3kKC8n3pwCtkorPqTAHLnbM7ZDegYPXaZCGF4iYReeJcGDfwy2Q7m5ClDFR64FRFJNAqnDEdawDLxFYhXmjo56+xt20773Bk/PtMLj6q020oga3tLNC/ZQxTQCxwAtPHHvd0UCNblxo5HIjv7j/YPzD0MvdB+wsOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MElHyioq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+kollIJY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8847C20EF0;
	Tue,  2 Apr 2024 09:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712050958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFxpD5FHaiIgLrXwnhr3zhIGLdQxW5tDOYkdBcIvPpY=;
	b=MElHyioqS7r5U8jENFC5kYS3tXmkxKWSEUfwxn/ri7p5EWE7U9KBFmP37s6vw5K63vjvSO
	uLcrRMU4AFNPaZXLM+euTMAVUNy5tkTxAIYDc1YFGJ2DvywQDunVpWXwJPUKLGB9Ukby4E
	FfioU3GiA4ONn0R2Fp9Y/svlD7OSd/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712050958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFxpD5FHaiIgLrXwnhr3zhIGLdQxW5tDOYkdBcIvPpY=;
	b=+kollIJYnZCXE41EIkGGoqZJNuYpWJN1l1YvHmJvsrgiqxRGeyTG0De4TLkg9tnT20Vxdg
	awBUGSKb2Gi/RAAQ==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7122E13A90;
	Tue,  2 Apr 2024 09:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id X8ZDGw7TC2ZHAgAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 09:42:38 +0000
Message-ID: <e531f01b-b459-4f98-81a6-86649322346f@suse.cz>
Date: Tue, 2 Apr 2024 11:42:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm/slub: don't read slab->cpu_partial_slabs directly
Content-Language: en-US
To: xiongwei.song@windriver.com, rientjes@google.com, cl@linux.com,
 penberg@kernel.org, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, chengming.zhou@linux.dev
References: <20240331021926.2732572-1-xiongwei.song@windriver.com>
 <20240331021926.2732572-5-xiongwei.song@windriver.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240331021926.2732572-5-xiongwei.song@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [1.21 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	BAYES_HAM(-0.00)[15.60%];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_TO(0.00)[windriver.com,google.com,linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Score: 1.21
X-Spam-Level: *
X-Spam-Flag: NO

On 3/31/24 4:19 AM, xiongwei.song@windriver.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> We can use slub_get_cpu_partial() to read cpu_partial_slabs.

This code is under the #ifdef so it's not necessary to use the wrapper, only
makes it harder to read imho.

> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>
> ---
>  mm/slub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index ec91c7435d4e..47ea06d6feae 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2966,7 +2966,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
>  	oldslab = this_cpu_read(s->cpu_slab->partial);
>  
>  	if (oldslab) {
> -		if (drain && oldslab->slabs >= s->cpu_partial_slabs) {
> +		if (drain && oldslab->slabs >= slub_get_cpu_partial(s)) {
>  			/*
>  			 * Partial array is full. Move the existing set to the
>  			 * per node partial list. Postpone the actual unfreezing


