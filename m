Return-Path: <linux-kernel+bounces-149859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163178A96E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970071F22194
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD515B569;
	Thu, 18 Apr 2024 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YEE6pjJR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iAhukmSG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YEE6pjJR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iAhukmSG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387615B555
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713434527; cv=none; b=EbsFDN190VNEi5nVFYoG+9xArmlEQMiIWWG8rdItVQHD15m740WwiQizZW8ytn0ssitgHmRicdaQKOStPwAMu406yvs0Zp20zkkpduNJFwfI1NgGdPAr0mbuhxo+BCw6r7wfBCBLiga9gQRs1XOR6hE3oCH/1evvb2POqsx+UDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713434527; c=relaxed/simple;
	bh=8COTx1i1oSrY4Hi+JbsS9g77yXZeH/Kgh/g2wsvl+pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6kxYQRoOKmYIDxDZFTv+t6rAHamj8ZZdAq2mCds2N8/O4Zat20srxTIjJk0nt4dg+pHxyNqVaTDM2KdAIak6EXHFQx9lOx3JCA+rSlofil+x8HXYYSoclYQlv7vJyByElb0RuEFWWPAOiWxarZzwQKWD55QR8qLU9p7P3aL1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YEE6pjJR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iAhukmSG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YEE6pjJR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iAhukmSG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50D6634CF1;
	Thu, 18 Apr 2024 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713434517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9BC5x+epqyJhvENaf5Ud+TioMjKQGGUEKQ2yKbOem4=;
	b=YEE6pjJRHnm0WNgrLCf1bV4cwh+6uXHyuqm41rLGr5jxwlOEEvGW3lUEgRqFTNobuX0LlX
	xOdjgvLdySs8wggbr/WxDvcM5qYMR7SP6sr4QVHfvWpP/X7sIEPG7PLOb/u1RTLqoPM2Az
	2sF8bLki4zAFFg4BvFEdFnFK/n5zBug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713434517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9BC5x+epqyJhvENaf5Ud+TioMjKQGGUEKQ2yKbOem4=;
	b=iAhukmSGHwAHBydoC1CoGwjoCozOc4F+zxg5iCQWTvWQrw/gN+nuev+Er34qqipIrSOhO+
	osCzkFsW8N3eD/AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713434517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9BC5x+epqyJhvENaf5Ud+TioMjKQGGUEKQ2yKbOem4=;
	b=YEE6pjJRHnm0WNgrLCf1bV4cwh+6uXHyuqm41rLGr5jxwlOEEvGW3lUEgRqFTNobuX0LlX
	xOdjgvLdySs8wggbr/WxDvcM5qYMR7SP6sr4QVHfvWpP/X7sIEPG7PLOb/u1RTLqoPM2Az
	2sF8bLki4zAFFg4BvFEdFnFK/n5zBug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713434517;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9BC5x+epqyJhvENaf5Ud+TioMjKQGGUEKQ2yKbOem4=;
	b=iAhukmSGHwAHBydoC1CoGwjoCozOc4F+zxg5iCQWTvWQrw/gN+nuev+Er34qqipIrSOhO+
	osCzkFsW8N3eD/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4462913687;
	Thu, 18 Apr 2024 10:01:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SKhfEJXvIGbMRQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 18 Apr 2024 10:01:57 +0000
Message-ID: <9863d6b8-cb6d-4555-b35e-38d495f3afbd@suse.cz>
Date: Thu, 18 Apr 2024 12:01:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] slub: limit number of slabs to scan in
 count_partial()
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, junxiao.bi@oracle.com
References: <20240417185938.5237-1-jianfeng.w.wang@oracle.com>
 <20240417185938.5237-2-jianfeng.w.wang@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20240417185938.5237-2-jianfeng.w.wang@oracle.com>
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

On 4/17/24 20:59, Jianfeng Wang wrote:
> When reading "/proc/slabinfo", the kernel needs to report the number
> of free objects for each kmem_cache. The current implementation uses
> count_partial() to count the number of free objects by scanning each

Hi,

thanks. I wanted to apply this patch but then I realized we use the same
function besides slabinfo for sysfs and slab_out_of_memory(), and it's
not always counting free objects. When somebody is debugging with sysfs,
they may expect the exact counts and pay the price if needed, but we
probably don't want to make slab_out_of_memory() slow and precise, so
that's more like the slabinfo.

So what I propose is to create a new variant of count_partial, called
e.g. count_partial_free_approx() which has no get_count parameter but
hardcodes what count_free() does.
Then use this new function only for slabinfo and slab_out_of_memory(),
leaving the other count_partial() users unchanged.
Another benefit of that is that we remove the overhead of calling
get_count(), which may be nontrivial with the current cpu vulnerability
mitigations so it's good to avoid for slabinfo and oom reports.

Thanks!

> kmem_cache_node's list of partial slabs and summing free objects
> from every partial slab in the list. This process must hold per
> kmem_cache_node spinlock and disable IRQ, and may take a long time.
> Consequently, it can block slab allocations on other CPU cores and
> cause timeouts for network devices and so on, when the partial list
> is long. In production, even NMI watchdog can be triggered due to this
> matter: e.g., for "buffer_head", the number of partial slabs was
> observed to be ~1M in one kmem_cache_node. This problem was also
> confirmed by several others [1-3].
> 
> Iterating a partial list to get the exact count of objects can cause
> soft lockups for a long list with or without the lock (e.g., if
> preemption is disabled), and is not very useful too: the object
> count can change right after the lock is released. The approach of
> maintaining free-object counters requires atomic operations on the
> fast path [3].
> 
> So, the fix is to limit the number of slabs to scan in count_partial().
> Suppose the limit is N. If the list's length is not greater than N,
> output the exact count by traversing the whole list; if its length is
> greater than N, then output an approximated count by traversing a
> subset of the list. The proposed method is to scan N/2 slabs from the
> list's head and the other N/2 slabs from the tail. For a partial list
> with ~280K slabs, benchmarks show that this approach performs better
> than just counting from the list's head, after slabs get sorted by
> kmem_cache_shrink(). Default the limit to 10000, as it produces an
> approximation within 1% of the exact count for both scenarios.
> 
> Benchmarks: Diff = (exact - approximated) / exact
> * Normal case (w/o kmem_cache_shrink()):
> | MAX_TO_SCAN | Diff (count from head)| Diff (count head+tail)|
> | 1000        |  0.43  %              |  1.09  %              |
> | 5000        |  0.06  %              |  0.37  %              |
> | 10000       |  0.02  %              |  0.16  %              |
> | 20000       |  0.009 %              | -0.003 %              |
> 
> * Skewed case (w/ kmem_cache_shrink()):
> | MAX_TO_SCAN | Diff (count from head)| Diff (count head+tail)|
> | 1000        |  12.46 %              |  6.75  %              |
> | 5000        |  5.38  %              |  1.27  %              |
> | 10000       |  4.99  %              |  0.22  %              |
> | 20000       |  4.86  %              | -0.06  %              |
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
>  mm/slub.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 1bb2a93cf7b6..7e34f2f0ba85 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3213,6 +3213,8 @@ static inline bool free_debug_processing(struct kmem_cache *s,
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
> +#define MAX_PARTIAL_TO_SCAN 10000
> +
>  static unsigned long count_partial(struct kmem_cache_node *n,
>  					int (*get_count)(struct slab *))
>  {
> @@ -3221,8 +3223,30 @@ static unsigned long count_partial(struct kmem_cache_node *n,
>  	struct slab *slab;
>  
>  	spin_lock_irqsave(&n->list_lock, flags);
> -	list_for_each_entry(slab, &n->partial, slab_list)
> -		x += get_count(slab);
> +	if (n->nr_partial <= MAX_PARTIAL_TO_SCAN) {
> +		list_for_each_entry(slab, &n->partial, slab_list)
> +			x += get_count(slab);
> +	} else {
> +		/*
> +		 * For a long list, approximate the total count of objects in
> +		 * it to meet the limit on the number of slabs to scan.
> +		 * Scan from both the list's head and tail for better accuracy.
> +		 */
> +		unsigned long scanned = 0;
> +
> +		list_for_each_entry(slab, &n->partial, slab_list) {
> +			x += get_count(slab);
> +			if (++scanned == MAX_PARTIAL_TO_SCAN / 2)
> +				break;
> +		}
> +		list_for_each_entry_reverse(slab, &n->partial, slab_list) {
> +			x += get_count(slab);
> +			if (++scanned == MAX_PARTIAL_TO_SCAN)
> +				break;
> +		}
> +		x = mult_frac(x, n->nr_partial, scanned);
> +		x = min(x, node_nr_objs(n));
> +	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return x;
>  }

