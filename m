Return-Path: <linux-kernel+bounces-135421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BDE89C17D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6392823F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E07E0F6;
	Mon,  8 Apr 2024 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hvJFCtR1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hBFBYljj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hvJFCtR1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hBFBYljj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1D70CDA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582226; cv=none; b=HO++F3ZCvcv+Lm/K/9SR9krm9o6tVy3rPtMSSSSsVDd5IcauMp93L2+nZpuiWy3jf0oc4nGPWP0lQzQfcYVhGfo1vy+ESYS5a/o861rNzes8AqKQOw7cpLEEsDftBmHetqHlsEUbESE8RgbD4KuZBksEELnxYWpiw3aZCte42WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582226; c=relaxed/simple;
	bh=rnPt0Q4YLcTvExuaw6CKDiK5rFP4pLS9aJQVJC7Tp3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9Ze9fCxe1eciRDjABZ+gLX1eeneBcOJvk8z+BVn01yYQb6NqKqbkBw8EeRtIVXYsosqqKwObJ/ZFxXKgAb5TkXy2w9ORfZir1T9QounhVC367ae5uL0VTnMCJLIcMy1tSEM0Bb1ukEYz8V7afu0JRxxjz0JkTaC13dWUfm91hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hvJFCtR1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hBFBYljj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hvJFCtR1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hBFBYljj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 404D22035B;
	Mon,  8 Apr 2024 13:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712582222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WJd8m3J+iaKajBaS4TIsuW42TKSTbAuX12JBjWaf3yI=;
	b=hvJFCtR1+hDFYkQYkwexEGMugZi4S8M9UUTSmr02+vPnU3ng0muPB61RSAtcDRZ5+vpcqc
	TKgksgyTuKKVgTyNp1l0belKsol2LAFjKmG9LD3amIEdeZe9s2U36KsXFUqsz5Y8CrWvFP
	6vWjYympUm7Xt1oriZX8/6+QzCZ+I3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712582222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WJd8m3J+iaKajBaS4TIsuW42TKSTbAuX12JBjWaf3yI=;
	b=hBFBYljjpShx9uUM/V7XCRMby1hQSRCbEYXVEet6HpKhMGf6ASF+F4wnZNSMqUwx16cJSh
	BrNY5hWdGF2JdRDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hvJFCtR1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hBFBYljj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712582222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WJd8m3J+iaKajBaS4TIsuW42TKSTbAuX12JBjWaf3yI=;
	b=hvJFCtR1+hDFYkQYkwexEGMugZi4S8M9UUTSmr02+vPnU3ng0muPB61RSAtcDRZ5+vpcqc
	TKgksgyTuKKVgTyNp1l0belKsol2LAFjKmG9LD3amIEdeZe9s2U36KsXFUqsz5Y8CrWvFP
	6vWjYympUm7Xt1oriZX8/6+QzCZ+I3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712582222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WJd8m3J+iaKajBaS4TIsuW42TKSTbAuX12JBjWaf3yI=;
	b=hBFBYljjpShx9uUM/V7XCRMby1hQSRCbEYXVEet6HpKhMGf6ASF+F4wnZNSMqUwx16cJSh
	BrNY5hWdGF2JdRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2560A13675;
	Mon,  8 Apr 2024 13:17:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rlXECE7uE2YANQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 08 Apr 2024 13:17:02 +0000
Message-ID: <a8b554c8-b71a-4f0f-a291-996c31674966@suse.cz>
Date: Mon, 8 Apr 2024 15:17:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: Reduce memory consumption in extreme
 scenarios
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 Chen Jun <chenjun102@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, xuqiang36@huawei.com,
 wangkefeng.wang@huawei.com
References: <20240330082335.29710-1-chenjun102@huawei.com>
 <0a59e5a1-1961-5eb2-2eb0-a930006e3f80@gentwo.org>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <0a59e5a1-1961-5eb2-2eb0-a930006e3f80@gentwo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,huawei.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 404D22035B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.00

On 4/5/24 6:50 PM, Christoph Lameter (Ampere) wrote:
> On Sat, 30 Mar 2024, Chen Jun wrote:
> 
>> When kmalloc_node() is called without __GFP_THISNODE and the target node
>> lacks sufficient memory, SLUB allocates a folio from a different node
>> other than the requested node, instead of taking a partial slab from it.
> 
> Hmmm... This would mean that we do not consult the partial lists of the 
> other nodes. That is something to be fixed in the allocator.

Which allocator? If you mean SLUB, this patch fixes it. If you mean page
allocator, I don't see how.

>> However, since the allocated folio does not belong to the requested
>> node, it is deactivated and added to the partial slab list of the node
>> it belongs to.
> 
> That should only occur if a request for an object for node X follows a 
> request for an object from node Y.

Are you sure? I think it's a stream of requests for node X happening on a
cpu of node Y, AFAICS the first attempt will allocate the slab page from
node different than X (possibly node Y because it's local and has pages
available unlike node X which is full). It does get installed as the cpu
slab, but then the next request is also for node X, so the node matching
checks make the slab deactivate and allocate a new one.

>> This behavior can result in excessive memory usage when the requested
>> node has insufficient memory, as SLUB will repeatedly allocate folios
>> from other nodes without reusing the previously allocated ones.
> 
> That is bad. Can we avoid that by verifying proper allocator behavior
> during deactivationand ensuring that it searches remote partial objects 
> first before doing something drastic as going to the page allocator?
> 
>> To prevent memory wastage,
>> when (node != NUMA_NO_NODE) && !(gfpflags & __GFP_THISNODE) is,
>> 1) try to get a partial slab from target node with GFP_NOWAIT |
>>   __GFP_THISNODE opportunistically.
> 
> Did we check the partial lists of that node first for available 
> objects before going to the page allocator?
> 
> get_any_partial() should do that. Maybe it is not called in the 
> kmalloc_node case.

Yes, get_any_partial() is currently skipped for requests of numa node
different from NUMA_NO_NODE.

I think it's a useful tradeof to first try satisfy the node preference with
a GFP_NOWAIT allocation. If it succeeds, the target node is not overloaded,
we get the page from the desired node and further allocations will of the
same node will not deactivate it. If it doesn't succeed then we indeed
fallback to slabs on partial list from other nodes before wastefully
allocating new pages from the other nodes, which addresses the scenario that
motivated this patch.

