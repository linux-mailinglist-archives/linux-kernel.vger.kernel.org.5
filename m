Return-Path: <linux-kernel+bounces-142165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2992E8A2864
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DE01F231FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4234F20A;
	Fri, 12 Apr 2024 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VyEif3/6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqdYEwNv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VyEif3/6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqdYEwNv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075D4EB31
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907688; cv=none; b=S0tIZAP5llWJigZxUZ46pBc+AVefSfB2j5GJcrx3DgRefh3S/hG7ddtU3tr/SJ66MKvgb9h/+GKuRua/WKbTB1HcNyyG1hvSp8ug/W2fJa6iIAy3NXlCtaTm6X6a5v4EmRyCyIk2ReGbJcvSZxs6McNjK5bZNeJQPOp3S4JbnM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907688; c=relaxed/simple;
	bh=pZvaQWg4/lDUNd78wbErdNu616vvkTC67YYTBG+dZKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/GDqP2ZMgPAMWrAJE+CVZDZZMgHlfFZea0euHezsFPcUG9Ymd+Pv8x26zdSimXtknzVUztK82EtQZBkRWrP5zAkNQ6H7E+Z40jkzvx0c1jYl9Ke7WtX7MhgfJ0v4ZvcnyNOOpYrCaSUAAJn8Tw9hfY49guLfKlGOeUQH4E2h8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VyEif3/6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqdYEwNv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VyEif3/6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqdYEwNv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D46E37FDE;
	Fri, 12 Apr 2024 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712907684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bpSFbvpuwKnjTjJW94zNuOLDHd0xHPzUBCV4nRLI79c=;
	b=VyEif3/6Z89z11ZwgChc/btbqf4QnyeeunUA4I0JWys+Jl1l0VclIC7eulkAZ5OodwjpbK
	9KCLTNB7UymteSbVvLAZjv/I8M0xqeNaLJNJm7o8opCLzKDhY0wCLnIIL6VZqMSpcjpGEq
	zmF/9n6eY8foszg4T77O0orY5pg8lVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712907684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bpSFbvpuwKnjTjJW94zNuOLDHd0xHPzUBCV4nRLI79c=;
	b=lqdYEwNvYSXrknr3BSOjxkEem4es0xUNCDaYCd2B7ECUOJiHS41jIHVHJmmWXAd9gto3h9
	qbZjJ1zcb3aatXAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712907684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bpSFbvpuwKnjTjJW94zNuOLDHd0xHPzUBCV4nRLI79c=;
	b=VyEif3/6Z89z11ZwgChc/btbqf4QnyeeunUA4I0JWys+Jl1l0VclIC7eulkAZ5OodwjpbK
	9KCLTNB7UymteSbVvLAZjv/I8M0xqeNaLJNJm7o8opCLzKDhY0wCLnIIL6VZqMSpcjpGEq
	zmF/9n6eY8foszg4T77O0orY5pg8lVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712907684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bpSFbvpuwKnjTjJW94zNuOLDHd0xHPzUBCV4nRLI79c=;
	b=lqdYEwNvYSXrknr3BSOjxkEem4es0xUNCDaYCd2B7ECUOJiHS41jIHVHJmmWXAd9gto3h9
	qbZjJ1zcb3aatXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A83013942;
	Fri, 12 Apr 2024 07:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u67ZEaTlGGYKbgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 12 Apr 2024 07:41:24 +0000
Message-ID: <d9794e5f-a57c-4d3b-bca3-6b1e34f6f163@suse.cz>
Date: Fri, 12 Apr 2024 09:41:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, junxiao.bi@oracle.com
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.29
X-Spam-Flag: NO

On 4/11/24 6:40 PM, Jianfeng Wang wrote:
> When reading "/proc/slabinfo", the kernel needs to report the number
> of free objects for each kmem_cache. The current implementation relies
> on count_partial() that counts the number of free objects by scanning
> each kmem_cache_node's list of partial slabs and summing free objects
> from every partial slab in the list. This process must hold per
> kmem_cache_node spinlock and disable IRQ and may take a long time.
> Consequently, it can block slab allocation requests on other CPU cores
> and cause timeouts for network devices etc., when the partial slab list
> is long. In production, even NMI watchdog can be triggered due to this
> matter: e.g., for "buffer_head", the number of partial slabs was
> observed to be ~1M in one kmem_cache_node. This problem was also

Wonder what led to such a situation, whether it could have been the NUMA
related problem this patch is fixing:
https://lore.kernel.org/all/20240330082335.29710-1-chenjun102@huawei.com/

But guess we don't do that with buffer heads, and it's just possible that a
surge of allocations led to many slabs being allocated, and then the a
slower trickle freeing didn't happen in a matching order, leading to many
slabs becoming partially free...

> confirmed by several others [1-3] in the past.
> 
> Iterating a partial list to get the exact count of objects can cause
> soft lockups for a long list with or without the lock (e.g., if
> preemption is disabled), and is not very useful too: the object
> count can change right after the lock is released. The approach of
> maintaining free-object counters requires atomic operations on the
> fast path [3].
> 
> So, the fix is to limit the number of slabs to scan in
> count_partial(), and output an approximated result if the list is too
> long. Default to 10000 which should be enough for most sane cases.
> 
> [1] https://lore.kernel.org/linux-mm/
> alpine.DEB.2.21.2003031602460.1537@www.lameter.com/T/
> [2] https://lore.kernel.org/lkml/
> alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com/T/
> [3] https://lore.kernel.org/lkml/
> 1e01092b-140d-2bab-aeba-321a74a194ee@linux.com/T/
> 
> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
> ---
>  mm/slub.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1bb2a93cf7b6..5ed998ec7d6d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3213,16 +3213,25 @@ static inline bool free_debug_processing(struct kmem_cache *s,
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
> +#define MAX_PARTIAL_TO_SCAN 10000
> +
>  static unsigned long count_partial(struct kmem_cache_node *n,
>  					int (*get_count)(struct slab *))
>  {
>  	unsigned long flags;
>  	unsigned long x = 0;
> +	unsigned long scanned = 0;
>  	struct slab *slab;
>  
>  	spin_lock_irqsave(&n->list_lock, flags);
> -	list_for_each_entry(slab, &n->partial, slab_list)
> +	list_for_each_entry(slab, &n->partial, slab_list) {
>  		x += get_count(slab);
> +		if (++scanned > MAX_PARTIAL_TO_SCAN) {
> +			/* Approximate total count of objects */
> +			x = mult_frac(x, n->nr_partial, scanned);
> +			break;
> +		}
> +	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return x;
>  }


