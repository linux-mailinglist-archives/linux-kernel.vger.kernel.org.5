Return-Path: <linux-kernel+bounces-34930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E5838961
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2072D1F2AFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADAD56B78;
	Tue, 23 Jan 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MVzD4C0V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HcTryCcg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MVzD4C0V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HcTryCcg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D59524D3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999519; cv=none; b=ka5wnvNvSahb6zirq0BErAhNl9ldjxfPM7oIM503DI9c+0mscfJTwaf2ZWvWxNNwEl8BH8sT0CRE1S8bP3nWFwLtSYKYIil/Lk0YnDhbQPEGU1+ZDmxgpUZlBlm7FTcOwu0CStWJajd9jWO17Z/H8PF4ihiRBfQbcKvaYbg+JQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999519; c=relaxed/simple;
	bh=wfaMHmM3Awpd4S3wW8POjXWRRbqPMIhhPBh0nsH2Ntk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trJaQ3ybc1YKkdNpz51bcK2yAiyPfBqL8v374SpI4DHJTF7ASu9pux75y5tc4cWYaCGr4ExN/iUJawdz4PPr/CRbEeR97mLpYydlNn2HObek+eAryH+yMa0yMvQ84qKbNmUZpcyZjs1yp22htF4l1lFezyaqM8EoT4Xtro6U7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MVzD4C0V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HcTryCcg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MVzD4C0V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HcTryCcg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3C3CB1FD41;
	Tue, 23 Jan 2024 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705999516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHBcb6f4SclqAqxvFO8Za6hGfvKmv8CRvtm5QGIZCC4=;
	b=MVzD4C0VOQV5Y2z3YlnI6s6F0+kWQMoAnwiyh+OH2iZupQB849KPMoRD+OtLaYeZPkmvZZ
	jzVqHmgYAI/OGuWYojDOCmSqu5gnqDOEFSpMDer95u7KPn0gHIFtzqVBCqhOm+vdAT52t1
	3xCmyPcBXCXV9lzXBkdP7nK/jWwSrA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705999516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHBcb6f4SclqAqxvFO8Za6hGfvKmv8CRvtm5QGIZCC4=;
	b=HcTryCcgA69cC1p6bigLmEvjz9bnmEW0gnHte1rHh6jVC7d4RglyRrQBSTtjdvXiVY2Frm
	6U3WNp16ua03HaBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705999516; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHBcb6f4SclqAqxvFO8Za6hGfvKmv8CRvtm5QGIZCC4=;
	b=MVzD4C0VOQV5Y2z3YlnI6s6F0+kWQMoAnwiyh+OH2iZupQB849KPMoRD+OtLaYeZPkmvZZ
	jzVqHmgYAI/OGuWYojDOCmSqu5gnqDOEFSpMDer95u7KPn0gHIFtzqVBCqhOm+vdAT52t1
	3xCmyPcBXCXV9lzXBkdP7nK/jWwSrA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705999516;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHBcb6f4SclqAqxvFO8Za6hGfvKmv8CRvtm5QGIZCC4=;
	b=HcTryCcgA69cC1p6bigLmEvjz9bnmEW0gnHte1rHh6jVC7d4RglyRrQBSTtjdvXiVY2Frm
	6U3WNp16ua03HaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2481913786;
	Tue, 23 Jan 2024 08:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ewSBCJx8r2WcdgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 23 Jan 2024 08:45:16 +0000
Message-ID: <05e23c85-1bae-48a5-b1d1-cb61e0b1efdf@suse.cz>
Date: Tue, 23 Jan 2024 09:45:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm/slub: remove full list manipulation for non-debug
 slab
Content-Language: en-US
To: Chengming Zhou <zhouchengming@bytedance.com>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
 <20240117-slab-misc-v1-2-fd1c49ccbe70@bytedance.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240117-slab-misc-v1-2-fd1c49ccbe70@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FREEMAIL_TO(0.00)[bytedance.com,gmail.com,lge.com,linux.com,kernel.org,linux-foundation.org,linux.dev,google.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 1/17/24 12:45, Chengming Zhou wrote:
> Since debug slab is processed by free_to_partial_list(), and only debug
> slab which has SLAB_STORE_USER flag would care about the full list, we
> can remove these unrelated full list manipulations from __slab_free().

Well spotted.

> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 20c03555c97b..f0307e8b4cd2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4187,7 +4187,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  	 * then add it.
>  	 */
>  	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
> -		remove_full(s, n, slab);
>  		add_partial(n, slab, DEACTIVATE_TO_TAIL);
>  		stat(s, FREE_ADD_PARTIAL);
>  	}
> @@ -4201,9 +4200,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  		 */
>  		remove_partial(n, slab);
>  		stat(s, FREE_REMOVE_PARTIAL);
> -	} else {
> -		/* Slab must be on the full list */
> -		remove_full(s, n, slab);
>  	}
>  
>  	spin_unlock_irqrestore(&n->list_lock, flags);
> 


