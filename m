Return-Path: <linux-kernel+bounces-14588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA50E821F46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440091F22AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377CB14F69;
	Tue,  2 Jan 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qjgwENPJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1QTZh1Yz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qjgwENPJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1QTZh1Yz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476A14F63;
	Tue,  2 Jan 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B815210E9;
	Tue,  2 Jan 2024 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704211853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVgL7DZ8mWAYcWGWuopXqY0ECrWRGDftGwQn5Ry+vCc=;
	b=qjgwENPJL3wvMdNf1NQhTmCqxbErIBXz24k4rN4DaX8Q5CwLgaz4bwpltIn0tDfDqPzD0q
	oCNjnuCrbFOEt77QCSj1nLpB3YK9GmA4gkeNYKtJjDOh/ilZqZef4tiMDP3lngyaY1Jjuo
	eIub1M3AYlqebWMB+WJwQwa9FNTfGl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704211853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVgL7DZ8mWAYcWGWuopXqY0ECrWRGDftGwQn5Ry+vCc=;
	b=1QTZh1YzMctn1TSoUf76eKlcAMwAyYKRbp3bUfKTABE4vhTVaUFKh8kGh5RP0RXhdSUjuN
	YcXEArQXJRnMziAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704211853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVgL7DZ8mWAYcWGWuopXqY0ECrWRGDftGwQn5Ry+vCc=;
	b=qjgwENPJL3wvMdNf1NQhTmCqxbErIBXz24k4rN4DaX8Q5CwLgaz4bwpltIn0tDfDqPzD0q
	oCNjnuCrbFOEt77QCSj1nLpB3YK9GmA4gkeNYKtJjDOh/ilZqZef4tiMDP3lngyaY1Jjuo
	eIub1M3AYlqebWMB+WJwQwa9FNTfGl4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704211853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVgL7DZ8mWAYcWGWuopXqY0ECrWRGDftGwQn5Ry+vCc=;
	b=1QTZh1YzMctn1TSoUf76eKlcAMwAyYKRbp3bUfKTABE4vhTVaUFKh8kGh5RP0RXhdSUjuN
	YcXEArQXJRnMziAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 454BD1340C;
	Tue,  2 Jan 2024 16:10:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f9+XEI01lGWlegAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 02 Jan 2024 16:10:53 +0000
Message-ID: <cd4c22c3-2901-4dee-b6b4-e6981848cb70@suse.cz>
Date: Tue, 2 Jan 2024 17:10:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/34] mm: slub: Unpoison the memchr_inv() return value
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sven Schnelle <svens@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
 <20231213233605.661251-16-iii@linux.ibm.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231213233605.661251-16-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.37
X-Spamd-Result: default: False [1.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL5nkphuxq5kxo98ppmuqoc8wo)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.04)[58.94%];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.ibm.com,google.com,gmail.com,googlegroups.com,vger.kernel.org,kvack.org,arm.com,linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

On 12/14/23 00:24, Ilya Leoshkevich wrote:
> Even though the KMSAN warnings generated by memchr_inv() are suppressed
> by metadata_access_enable(), its return value may still be poisoned.
> 
> The reason is that the last iteration of memchr_inv() returns
> `*start != value ? start : NULL`, where *start is poisoned. Because of
> this, somewhat counterintuitively, the shadow value computed by
> visitSelectInst() is equal to `(uintptr_t)start`.
> 
> The intention behind guarding memchr_inv() behind
> metadata_access_enable() is to touch poisoned metadata without
> triggering KMSAN, so unpoison its return value.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/slub.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 2d29d368894c..802702748925 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1076,6 +1076,7 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
>  	metadata_access_enable();
>  	fault = memchr_inv(kasan_reset_tag(start), value, bytes);
>  	metadata_access_disable();
> +	kmsan_unpoison_memory(&fault, sizeof(fault));
>  	if (!fault)
>  		return 1;
>  
> @@ -1182,6 +1183,7 @@ static void slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  	metadata_access_enable();
>  	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
>  	metadata_access_disable();
> +	kmsan_unpoison_memory(&fault, sizeof(fault));
>  	if (!fault)
>  		return;
>  	while (end > fault && end[-1] == POISON_INUSE)


