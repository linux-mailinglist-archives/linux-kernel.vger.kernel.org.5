Return-Path: <linux-kernel+bounces-71113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FB385A0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3351C216C8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECB825639;
	Mon, 19 Feb 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FKb0S63A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UL2Lrxdp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FKb0S63A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UL2Lrxdp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D825626
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337879; cv=none; b=DPYlW/r3KOtXjCIb5c26BxDqaBdD0zH2BpT9vTwCT30dvtEx1OGFwyWCoewhl5t4uABQ7mdy9WkSK/elTy508Jqew9HLLVdxu0x9xrJpdqiFNUud5BrkcEeTMSPKjzTWqKdiuSmYLqkr4KyJW99WBzf0YAgFzWD1ErnXSgjys4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337879; c=relaxed/simple;
	bh=Z6Yddt0w51IfLO6iIrNChTJFP1BWAj6vwCMCLiKI1mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVPj/E/C1FcDv8k+EC4cMvpCMHtCr+wFgaecrRocV4LgeOg2HbTqS//6ZRyBRH5elQzsQjBCcgMpnnDCKtJNP/5vLTN9xQsr10NowyFtKqMnFV1fMxxEd8Wg3W+f9QhNxOHYDV9Pt4t/7Npes+X2KynZd+yFxRA47jnbUkYWwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FKb0S63A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UL2Lrxdp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FKb0S63A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UL2Lrxdp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B92821D3E;
	Mon, 19 Feb 2024 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708337873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+SbBgm/0L6gEZP8CYhvP7d6FLlCKV8t5Y080SGYrlc=;
	b=FKb0S63AmqX5yui5UAqYgOsiDqC2ItX5STAHD9WnYgROYiYHePZqZzoy4yNyl4CtI7tOTo
	mGC/U619FbiSvUDT8++WcOYo7du9OKnJLsGXOMPAc6fKaP7BuGXHSM4Jmac3QiZEV7Ktqz
	yMW8vso8qKTsZ7W7hs8+wG1xbS0XIPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708337873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+SbBgm/0L6gEZP8CYhvP7d6FLlCKV8t5Y080SGYrlc=;
	b=UL2Lrxdplk1bTpyEl6lG9bcUFJPipmjE+HAUYqAv4o/ccri89q0YPnpGDu8Zu0Q6GpIaOK
	pY8yo80zUbD19RBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708337873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+SbBgm/0L6gEZP8CYhvP7d6FLlCKV8t5Y080SGYrlc=;
	b=FKb0S63AmqX5yui5UAqYgOsiDqC2ItX5STAHD9WnYgROYiYHePZqZzoy4yNyl4CtI7tOTo
	mGC/U619FbiSvUDT8++WcOYo7du9OKnJLsGXOMPAc6fKaP7BuGXHSM4Jmac3QiZEV7Ktqz
	yMW8vso8qKTsZ7W7hs8+wG1xbS0XIPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708337873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+SbBgm/0L6gEZP8CYhvP7d6FLlCKV8t5Y080SGYrlc=;
	b=UL2Lrxdplk1bTpyEl6lG9bcUFJPipmjE+HAUYqAv4o/ccri89q0YPnpGDu8Zu0Q6GpIaOK
	pY8yo80zUbD19RBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22221139D0;
	Mon, 19 Feb 2024 10:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rYP0B9Eq02UWIgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Feb 2024 10:17:53 +0000
Message-ID: <ab2b2391-09c1-4801-b9bd-04aa8f7f23e7@suse.cz>
Date: Mon, 19 Feb 2024 11:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: Chengming Zhou <zhouchengming@bytedance.com>,
 David Rientjes <rientjes@google.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
 <5cf40e33-d1ae-4ac9-9d01-559b86f853a8@bytedance.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <5cf40e33-d1ae-4ac9-9d01-559b86f853a8@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FKb0S63A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UL2Lrxdp
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[10.62%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: 3B92821D3E
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/19/24 10:29, Chengming Zhou wrote:
> On 2024/2/19 16:30, Vlastimil Babka wrote:
>> On 2/18/24 20:25, David Rientjes wrote:
>>> On Thu, 15 Feb 2024, Jianfeng Wang wrote:
>>>
>>>> When reading "/proc/slabinfo", the kernel needs to report the number of
>>>> free objects for each kmem_cache. The current implementation relies on
>>>> count_partial() that counts the number of free objects by scanning each
>>>> kmem_cache_node's partial slab list and summing free objects from all
>>>> partial slabs in the list. This process must hold per kmem_cache_node
>>>> spinlock and disable IRQ. Consequently, it can block slab allocation
>>>> requests on other CPU cores and cause timeouts for network devices etc.,
>>>> if the partial slab list is long. In production, even NMI watchdog can
>>>> be triggered because some slab caches have a long partial list: e.g.,
>>>> for "buffer_head", the number of partial slabs was observed to be ~1M
>>>> in one kmem_cache_node. This problem was also observed by several
> 
> Not sure if this situation is normal? It maybe very fragmented, right?
> 
> SLUB completely depend on the timing order to place partial slabs in node,
> which maybe suboptimal in some cases. Maybe we could introduce anti-fragment
> mechanism like fullness grouping in zsmalloc to have multiple lists based
> on fullness grouping? Just some random thoughts... :)

Most likely that's wouldn't be feasible. When freeing to a slab on partial
list that's just a cmpxchg128 (unless the slab become empty) and additional
list manipulation to maintain the grouping would kill the performance.



