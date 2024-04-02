Return-Path: <linux-kernel+bounces-128331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939EC895966
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EA328D413
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C7914B097;
	Tue,  2 Apr 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n52Zmm0E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RGhEWK3R"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577BF14AD1C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074407; cv=none; b=po+FJ7GOWa5NaSLpA1l09wLeXWCBIOI6X1QJxRIpR99kHp6mRMs1LFMtCpcsYcANqyc73KBQIg1TJD/Y5XcGXM9rPxF5/TZ/gQoVmlhRKfrWeO7xVTPVFkSGkCU/QR5lerRTCtSyhOXrg+qql0K3Ufy6VY6ZxXR1rn//YwRGREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074407; c=relaxed/simple;
	bh=5ZXnTIy9ib/ddzqBlUF3fDnLNKcHSNvAKdUZoChTWWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klDJdOyNNCjeKXZsJnzlHmhu2JM1qhvWu2pu4F4tMyMHXTIbOHP3UQ2OWevV3hZCjBojAHAK3ZY45UO2W/NX0dnnuLrqmHAVFpPYr53PQIWsF5PGpT30ZmrkiMAl4pIshm8y4xWQXd2cMT/UMgaibt9CHA7YE/D9YJk9Z4vPN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n52Zmm0E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RGhEWK3R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5939934899;
	Tue,  2 Apr 2024 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712074403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Gc2HfYT61VQfZurFzA2oPT2Lo+9CbieuFO4RlOzRD4=;
	b=n52Zmm0EYlXT2jX0QLQ85bf035iy0rqSIG5hwqHrLSTV5BIntIJR+kv3kOX3s2yJGL3VoP
	UBWduxp81AtLcE9rw4VRlclSXi6ClRedU1YwAl4tv4vL9i7oARfRyms9+1LorG7ZK7/iOw
	wO+vcpYoN/1sFXHxyrdldXFUn4DHTBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712074403;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Gc2HfYT61VQfZurFzA2oPT2Lo+9CbieuFO4RlOzRD4=;
	b=RGhEWK3R5xS1ooylPHE+M0hKjOfcTBWm4i00+gVhs0XgJc6vJY9c7htNir522Z9Vnz451G
	Is9sdTSds4OFEFDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3555D13A90;
	Tue,  2 Apr 2024 16:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rqGuDKMuDGZkDgAAn2gu4w
	(envelope-from <vbabka@suse.cz>); Tue, 02 Apr 2024 16:13:23 +0000
Message-ID: <cd9d9890-0259-4039-917b-0e517a388433@suse.cz>
Date: Tue, 2 Apr 2024 18:13:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: fix slub segmentation
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Ming Yang <yangming73@huawei.com>, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
 roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: zhangliang5@huawei.com, wangzhigang17@huawei.com, liushixin2@huawei.com,
 alex.chen@huawei.com, pengyi.pengyi@huawei.com, xiqi2@huawei.com
References: <20240402031025.1097-1-yangming73@huawei.com>
 <cd42083e-ea53-48bd-aa32-a16fc9f73ffa@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <cd42083e-ea53-48bd-aa32-a16fc9f73ffa@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -0.60
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.60 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FREEMAIL_TO(0.00)[linux.dev,huawei.com,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,gmail.com,kvack.org,vger.kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5939934899

On 4/2/24 5:45 AM, Chengming Zhou wrote:
> On 2024/4/2 11:10, Ming Yang wrote:
>> When one of numa nodes runs out of memory and lots of processes still
>> booting, slabinfo shows much slub segmentation exits. The following

You mean fragmentation not segmentation, right?

>> shows some of them:
>> 
>> tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs>
>> <num_slabs> <sharedavail>
>> kmalloc-512        84309 380800   1024   32    8 :
>> tunables    0    0    0 : slabdata  11900  11900      0
>> kmalloc-256        65869 365408    512   32    4 :
>> tunables    0    0    0 : slabdata  11419  11419      0
>> 
>> 365408 "kmalloc-256" objects are alloced but only 65869 of them are
>> used; While 380800 "kmalloc-512" objects are alloced but only 84309
>> of them are used.
>> 
>> This problem exits in the following senario:
>> 1. Multiple numa nodes, e.g. four nodes.
>> 2. Lack of memory in any one node.
>> 3. Functions which alloc many slub memory in certain numa nodes,
>> like alloc_fair_sched_group.
>> 
>> The slub segmentation generated because of the following reason:
>> In function "___slab_alloc" a new slab is attempted to be gotten via
>> function "get_partial". If the argument 'node' is assigned but there
>> are neither partial memory nor buddy memory in that assigned node, no
>> slab could be gotten. And then the program attempt to alloc new slub
>> from buddy system, as mentationed before: no buddy memory in that
>> assigned node left, a new slub might be alloced from the buddy system
>> of other node directly, no matter whether there is free partil memory
>> left on other node. As a result slub segmentation generated.
>> 
>> The key point of above allocation flow is: the slab should be alloced
>> from the partial of other node first, instead of the buddy system of
>> other node directly.
>> 
>> In this commit a new slub allocation flow is proposed:
>> 1. Attempt to get a slab via function get_partial (first step in
>> new_objects lable).
>> 2. If no slab is gotten and 'node' is assigned, try to alloc a new
>> slab just from the assigned node instead of all node.
>> 3. If no slab could be alloced from the assigned node, try to alloc
>> slub from partial of other node.
>> 4. If the alloctation in step 3 fails, alloc a new slub from buddy
>> system of all node.
> 
> FYI, there is another patch to the very same problem:
> 
> https://lore.kernel.org/all/20240330082335.29710-1-chenjun102@huawei.com/

Yeah and I have just taken that one to slab/for-6.10

>> 
>> Signed-off-by: Ming Yang <yangming73@huawei.com>
>> Signed-off-by: Liang Zhang <zhangliang5@huawei.com>
>> Signed-off-by: Zhigang Wang <wangzhigang17@huawei.com>
>> Reviewed-by: Shixin Liu <liushixin2@huawei.com>
>> ---
>> This patch can be tested and verified by following steps:
>> 1. First, try to run out memory on node0. echo 1000(depending on your memory) > 
>> /sys/devices/system/node/node0/hugepages/hugepages-2048kB/nr_hugepages.
>> 2. Second, boot 10000(depending on your memory) processes which use setsid 
>> systemcall, as the setsid systemcall may likely call function 
>> alloc_fair_sched_group.
>> 3. Last, check slabinfo, cat /proc/slabinfo.
>> 
>> Hardware info:
>> Memory : 8GiB
>> CPU (total #): 120
>> numa node: 4
>> 
>> Test clang code example:
>> int main() {
>>     void *p = malloc(1024);
>>     setsid();
>>     while(1);
>> }
>> 
>>  mm/slub.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 1bb2a93cf7..3eb2e7d386 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3522,7 +3522,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>  	}
>>  
>>  	slub_put_cpu_ptr(s->cpu_slab);
>> +	if (node != NUMA_NO_NODE) {
>> +		slab = new_slab(s, gfpflags | __GFP_THISNODE, node);
>> +		if (slab)
>> +			goto slab_alloced;
>> +
>> +		slab = get_any_partial(s, &pc);
>> +		if (slab)
>> +			goto slab_alloced;
>> +	}
>>  	slab = new_slab(s, gfpflags, node);
>> +
>> +slab_alloced:
>>  	c = slub_get_cpu_ptr(s->cpu_slab);
>>  
>>  	if (unlikely(!slab)) {


