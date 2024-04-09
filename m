Return-Path: <linux-kernel+bounces-136282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2829189D233
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D232E281A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FEB6E5EF;
	Tue,  9 Apr 2024 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wm9slywC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eHS3fFMI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wm9slywC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eHS3fFMI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF004C69
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643373; cv=none; b=H0+1bcjNq++u+rJdmf4FxUHSvMXn8cFXuQmcoYR2pD8YeVKoFroP7p35CWnoHxEnwgSGsLCj2Dy+nqKlvyZ6BZMCkwVBrNAQv4vyO6RLFd2zuBKIzXBRpKHilClw1+fgDx73Ya1VNogfoMsYSA73XG2tIKpIOQgX17ADkgBcRW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643373; c=relaxed/simple;
	bh=k/rWLKzcP1AUOm678dGjBjK/P2NPAfffcWjo8qtL4UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXZyBidBaUkWVlTC3GR10RE5WljhBFfntGnXY8GqkeVuNtcAHk3aNSmfqiJg8JULl5yitzsmXw3hG+q31EhnxTpM2+lVW1mz/TFZjsULO6l+U7xKTKW3J6acOvbNdb5xrr/ZMk6kTKK6u/OFAu1A7JIpNjUea9g8TVRDAdYt+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wm9slywC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eHS3fFMI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wm9slywC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eHS3fFMI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2282C20805;
	Tue,  9 Apr 2024 06:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712643369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S8Ir6UrCC0x/osLkzWifxUCGcPc7NlUpEoLYsu5BO/8=;
	b=Wm9slywC868wYIFeGbST3XbNYijFAcH1PvK4feyHwmvBTKY61s52+yoqiFJXueJgREtGPQ
	/eWSxGwAirWcLDvKcPmBuwTrFgYrQ0ytXqHJg2WFjQjXlOzfGUMVfBeU3LllmbxO8Gi3Mh
	pMavVwbLV9wfbFeK3pAOGzIsv8kY16Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712643369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S8Ir6UrCC0x/osLkzWifxUCGcPc7NlUpEoLYsu5BO/8=;
	b=eHS3fFMIt8DL6PmPcJNB5IKHYebKNPz7KcwlTbFSYyf03uS1IArLZjqMbN8j760S1TiUFF
	kq658b+R7JvbgZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712643369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S8Ir6UrCC0x/osLkzWifxUCGcPc7NlUpEoLYsu5BO/8=;
	b=Wm9slywC868wYIFeGbST3XbNYijFAcH1PvK4feyHwmvBTKY61s52+yoqiFJXueJgREtGPQ
	/eWSxGwAirWcLDvKcPmBuwTrFgYrQ0ytXqHJg2WFjQjXlOzfGUMVfBeU3LllmbxO8Gi3Mh
	pMavVwbLV9wfbFeK3pAOGzIsv8kY16Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712643369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S8Ir6UrCC0x/osLkzWifxUCGcPc7NlUpEoLYsu5BO/8=;
	b=eHS3fFMIt8DL6PmPcJNB5IKHYebKNPz7KcwlTbFSYyf03uS1IArLZjqMbN8j760S1TiUFF
	kq658b+R7JvbgZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0476513313;
	Tue,  9 Apr 2024 06:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hybFACndFGY0KwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 09 Apr 2024 06:16:09 +0000
Message-ID: <2181cb70-a9dd-4ae1-864b-84748cea4941@suse.cz>
Date: Tue, 9 Apr 2024 08:16:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/slub: Reduce memory consumption in extreme
 scenarios
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Chen Jun <chenjun102@huawei.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, xuqiang36@huawei.com, wangkefeng.wang@huawei.com
References: <20240330082335.29710-1-chenjun102@huawei.com>
 <0a59e5a1-1961-5eb2-2eb0-a930006e3f80@gentwo.org>
 <a8b554c8-b71a-4f0f-a291-996c31674966@suse.cz>
 <e3cb4e2d-c80c-71d4-8d86-8391c2780511@linux.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <e3cb4e2d-c80c-71d4-8d86-8391c2780511@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,vger.kernel.org,kvack.org,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.79
X-Spam-Flag: NO

On 4/8/24 8:17 PM, Christoph Lameter (Ampere) wrote:
> On Mon, 8 Apr 2024, Vlastimil Babka wrote:
> 
>> On 4/5/24 6:50 PM, Christoph Lameter (Ampere) wrote:
>>> On Sat, 30 Mar 2024, Chen Jun wrote:
>>>
>>>> When kmalloc_node() is called without __GFP_THISNODE and the target node
>>>> lacks sufficient memory, SLUB allocates a folio from a different node
>>>> other than the requested node, instead of taking a partial slab from it.
>>>
>>> Hmmm... This would mean that we do not consult the partial lists of the
>>> other nodes. That is something to be fixed in the allocator.
>>
>> Which allocator? If you mean SLUB, this patch fixes it. If you mean page
>> allocator, I don't see how.
> 
> 
> The SLUB allocator of course. And the patch does not fix it. It tries to 
> convince the page allocator to give us a folio from the right node.

The patch primarily makes slub use its partial lists before going to the
page allocator. The "give us a folio from the right node" is not
"convincing" but an opportunistic request.

> That kind of activity can be controlled within the page allocator via the 
> node reclaim setting. No point in doing multiple calls into the page 
> allocator.

That's assuming there's something to reclaim on that overloaded and
requested node in the first place. But yeah, such unbalanced system will
likely have multiple issues and slub wouldn't be the only one where it
manifests. But if we can remove the slub pathological behavior on such
system easily, we should.

>>>> However, since the allocated folio does not belong to the requested
>>>> node, it is deactivated and added to the partial slab list of the node
>>>> it belongs to.
>>>
>>> That should only occur if a request for an object for node X follows a
>>> request for an object from node Y.
>>
>> Are you sure? I think it's a stream of requests for node X happening on a
>> cpu of node Y, AFAICS the first attempt will allocate the slab page from
>> node different than X (possibly node Y because it's local and has pages
>> available unlike node X which is full). It does get installed as the cpu
>> slab, but then the next request is also for node X, so the node matching
>> checks make the slab deactivate and allocate a new one.
> 
> Then there is something broken in the cpuslab logic.
> 
> The first request of CPU C for memory from node X should lead to:
> 
> 1. deactivation of current cpu slab if it is not from node X
> 2. retrieval of a slab from node X and activation of that slab as cpuslab
> 3. Return of an object from that slab and therefore from node X.
> 
> Further allocation should be caught by the hotpatch where we realize that 
> there is a request from node X and the current cpuslab is from node X and 
> therefore fastpath logic can be used to retrieve the next object.

Yes and that logic AFAIK works. But here we are addressing a situation where
we won't get a slab from node X because it's just full.

>>> get_any_partial() should do that. Maybe it is not called in the
>>> kmalloc_node case.
>>
>> Yes, get_any_partial() is currently skipped for requests of numa node
>> different from NUMA_NO_NODE.
> 
> Maybe we can use that function after checking that the page allocator is 
> over the watermark on the node that we were wanting to allocate from. That 
> check should be fast.

A GFP_NOWAIT | __GFP_THISNODE attempt is basically that check. Maybe it
could be made a bit faster but either we duplicate code or not handle some
corner case the full attempt does. This is not a fast path and not a common
case (kmalloc_node() vs kmalloc()) so to me it seems better to call the page
allocator.

>>> I think it's a useful tradeof to first try satisfy the node preference with
>> a GFP_NOWAIT allocation. If it succeeds, the target node is not overloaded,
>> we get the page from the desired node and further allocations will of the
>> same node will not deactivate it. If it doesn't succeed then we indeed
>> fallback to slabs on partial list from other nodes before wastefully
>> allocating new pages from the other nodes, which addresses the scenario that
>> motivated this patch.
> 
> There are also the memory policies etc to consider. F.e. for the 
> interleave policy the pages must come from different nodes in sequence to 
> properly balance the allocations over multiple NUMA nodes. There are cases 
> in which the allocations are forced to specific sets of nodes or where a 
> node is preferred but fallback to local should occur.
> 
> If you now do multiple page allocator calls then the NUMA interleave 
> policy etc etc may no longer work. I have not looked to deep into those.

Yeah there are policies and there are kmalloc_node() calls with a specific
node. If they are incompatible, what should happen? Arguably kmalloc_node()
should win as it's a more specific call than a per-process policy?
I think as long as there's memory available on all nodes, things will
continue working fine and respecting policies. In the corner case we are
addressing, where a node is overloaded, observing policies becomes
infeasible anyway.

Let's look at the steps again:
+	 * 1) try to get a partial slab from target node with GPF_NOWAIT |
+	 *    __GFP_THISNODE opportunistically.

This was always the first step in get_partial() anyway.

+	 * 2) if 1) failed, try to allocate a new slab from target node with
+	 *    GPF_NOWAIT | __GFP_THISNODE opportunistically too.

This will try to satisfy the kmalloc_node() preferred node, which should be
more important than a policy.

+	 * 3) if 2) failed, retry 1) and 2) with original gfpflags.
The step where we attempt to allocate memory from any node will use original
gfpflags

This is where we reuse existing slabs on other node partials list, as we do
for all allocations before resorting to a page allocator. So that's
unchanged. If that fails, we go to the page allocator with the original
flags so if there are any policies, the page allocator will satisfy them.


