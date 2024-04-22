Return-Path: <linux-kernel+bounces-152902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 373328AC5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B514F1F2127B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431454D11D;
	Mon, 22 Apr 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1mgLhSAt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S6A4OAxC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1mgLhSAt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S6A4OAxC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90018039
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713772148; cv=none; b=Wyeg+HNG8T8r6YeO1hnMSVElpgLN+5mAEdIBHwNy3tKV+XwjB2Li/ZYFVGQtLd3CJnF0T5fMaCCrmETTyEqfuabcpE7znRZHTKMnlZYlZ5hhRQLDqpiHdGK96ZQDaPStmvY4z0a7y4qch5sNi8YyuGKo4Y3XlVjpTjO11evFtNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713772148; c=relaxed/simple;
	bh=e8487b4mCGGSx/djcqQwQvOZR3pCDY8QFaP0bqTcCMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdTJ4kb6XoykROP5m9S+IU+r8DS+WMBNqYggWXgAGGeaYk68Uis77WjFtmOovf8aSmoEn6hRISSoTku0llfxDJMUgdt6MZfvcp0GuUcCYpmqLvKGylkRUDIX56vvqqPM6xwiXgtBfinRyTRHfhEMjC/U4vOP5jiwzgHTKXgwmRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1mgLhSAt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S6A4OAxC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1mgLhSAt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S6A4OAxC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F35E5CC00;
	Mon, 22 Apr 2024 07:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713772144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qqhL+Km9d3Ro4Qxo6J2e77ZARt5KARP3u0rYJ7W2T+M=;
	b=1mgLhSAtI/OkqmH3MLhsquf/iu6O+I2gUxDQWLYpKcnmCbLHKFr5VHCQP9Kha+U/DvjKuj
	37mKVZhJbHhj+M7WUyF48MgMFZTZXrX0vSeWIOjlBWKaqmJEB66Kv0A9nDUi9CXwNVKP8K
	0NfjFUYC0A41O7z/r6H/frCkTGqSUmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713772144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qqhL+Km9d3Ro4Qxo6J2e77ZARt5KARP3u0rYJ7W2T+M=;
	b=S6A4OAxCwKmIQJuo3R0gTtrfdBXDjcaOzIeIne23nCwl+t6b0xPRNhHahEvXbpQetS5sIW
	6QSEO8IZlrBH/gBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1mgLhSAt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S6A4OAxC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713772144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qqhL+Km9d3Ro4Qxo6J2e77ZARt5KARP3u0rYJ7W2T+M=;
	b=1mgLhSAtI/OkqmH3MLhsquf/iu6O+I2gUxDQWLYpKcnmCbLHKFr5VHCQP9Kha+U/DvjKuj
	37mKVZhJbHhj+M7WUyF48MgMFZTZXrX0vSeWIOjlBWKaqmJEB66Kv0A9nDUi9CXwNVKP8K
	0NfjFUYC0A41O7z/r6H/frCkTGqSUmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713772144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qqhL+Km9d3Ro4Qxo6J2e77ZARt5KARP3u0rYJ7W2T+M=;
	b=S6A4OAxCwKmIQJuo3R0gTtrfdBXDjcaOzIeIne23nCwl+t6b0xPRNhHahEvXbpQetS5sIW
	6QSEO8IZlrBH/gBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CB35136ED;
	Mon, 22 Apr 2024 07:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lFFoDnAWJmbRcAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 22 Apr 2024 07:49:04 +0000
Message-ID: <e1a06ea3-57b2-4562-895b-a2fb5d5667cc@suse.cz>
Date: Mon, 22 Apr 2024 09:49:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] slub: introduce count_partial_free_approx()
To: David Rientjes <rientjes@google.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cl@linux.com,
 akpm@linux-foundation.org, penberg@kernel.org
References: <20240419175611.47413-1-jianfeng.w.wang@oracle.com>
 <20240419175611.47413-2-jianfeng.w.wang@oracle.com>
 <3e5d2937-76ab-546b-9ce8-7e7140424278@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <3e5d2937-76ab-546b-9ce8-7e7140424278@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4F35E5CC00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

On 4/20/24 2:18 AM, David Rientjes wrote:
> On Fri, 19 Apr 2024, Jianfeng Wang wrote:
> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 1bb2a93cf7b6..993cbbdd2b6c 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3213,6 +3213,43 @@ static inline bool free_debug_processing(struct kmem_cache *s,
>>  #endif /* CONFIG_SLUB_DEBUG */
>>  
>>  #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
>> +#define MAX_PARTIAL_TO_SCAN 10000
>> +
>> +static unsigned long count_partial_free_approx(struct kmem_cache_node *n)
>> +{
>> +	unsigned long flags;
>> +	unsigned long x = 0;
>> +	struct slab *slab;
>> +
>> +	spin_lock_irqsave(&n->list_lock, flags);
>> +	if (n->nr_partial <= MAX_PARTIAL_TO_SCAN) {
>> +		list_for_each_entry(slab, &n->partial, slab_list)
>> +			x += slab->objects - slab->inuse;
>> +	} else {
>> +		/*
>> +		 * For a long list, approximate the total count of objects in
>> +		 * it to meet the limit on the number of slabs to scan.
>> +		 * Scan from both the list's head and tail for better accuracy.
>> +		 */
>> +		unsigned long scanned = 0;
>> +
>> +		list_for_each_entry(slab, &n->partial, slab_list) {
>> +			x += slab->objects - slab->inuse;
>> +			if (++scanned == MAX_PARTIAL_TO_SCAN / 2)
>> +				break;
>> +		}
>> +		list_for_each_entry_reverse(slab, &n->partial, slab_list) {
>> +			x += slab->objects - slab->inuse;
>> +			if (++scanned == MAX_PARTIAL_TO_SCAN)
>> +				break;
>> +		}
>> +		x = mult_frac(x, n->nr_partial, scanned);
>> +		x = min(x, node_nr_objs(n));
>> +	}
>> +	spin_unlock_irqrestore(&n->list_lock, flags);
>> +	return x;
>> +}
> 
> Creative :)
> 
> The default value of MAX_PARTIAL_TO_SCAN seems to work well in practice 
> while being large enough to bias for actual values?
> 
> I can't think of a better way to avoid the disruption that very long 
> partial lists cause.  If the actual value is needed, it will need to be 
> read from the sysfs file for that slab cache.
> 
> It does beg the question of whether we want to extend slabinfo to indicate 
> that some fields are approximations, however.  Adding a suffix such as 
> " : approx" to a slab cache line may be helpful if the disparity in the 
> estimates would actually make a difference in practice.

I'm afraid that changing the layout of /proc/slabinfo has a much higher
chance of breaking some consumer, than the imprecision due to approximation
has. So I would rather not risk it.

> I have a hard time believing that this approximation will not be "close 
> enough" for all practical purposes, given that the value could very well 
> substantially change the instant after the iteration is done anyway.
> 
> So for that reason, this sounds good to me!
> 
> Acked-by: David Rientjes <rientjes@google.com>
> 
>> +
>>  static unsigned long count_partial(struct kmem_cache_node *n,
>>  					int (*get_count)(struct slab *))
>>  {
>> @@ -7089,7 +7126,7 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
>>  	for_each_kmem_cache_node(s, node, n) {
>>  		nr_slabs += node_nr_slabs(n);
>>  		nr_objs += node_nr_objs(n);
>> -		nr_free += count_partial(n, count_free);
>> +		nr_free += count_partial_free_approx(n);
>>  	}
>>  
>>  	sinfo->active_objs = nr_objs - nr_free;


