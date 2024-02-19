Return-Path: <linux-kernel+bounces-70935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE20859E38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87AC1F21604
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690121114;
	Mon, 19 Feb 2024 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZNalOCFR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9F1A7Q+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZNalOCFR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9F1A7Q+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980C17554
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331416; cv=none; b=b2ddBt7zYeYzKlELWBDb7Dxc6VZGE1WZqfqzAWJFlz2hLdhUfR0Bf9300n/+rYl+MicHfoOCUFsVZf+LY7uAk86jeYAaeq31IQFtVN8DcGWl5rF0ccPDu5lsnv0sKTkYGjnC4l9Y8oUVYy9ooOiZb9V54GDjcroeN8+INqKVLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331416; c=relaxed/simple;
	bh=rX+poYlHWSErsR9sXMRjKISAdr/XBRo2nvd05tO2tF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxr+jM956YlmJXTFfPqZV+qiN1g5xBBwarF9U1TLsPRVkriAOihh2Snn9BIvIP5Qc0ZLHzJ49+kkfK5pwIB3U2Lyi9sjUzaScmuhS2BEysVrmtF/sUHMDcOf4L2oLYKdoImYI6A0Rr4jcjmZ6DqrWTzE7/+1y9TZwQb3Ne5hS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZNalOCFR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9F1A7Q+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZNalOCFR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9F1A7Q+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DAA0222FC;
	Mon, 19 Feb 2024 08:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708331412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nmFrGbKHKgGYmJjLYoolA8lLxxnfPyDdiArr554cgk=;
	b=ZNalOCFRO6AI3F8f9uAAmKb+uNRopyNXwXONZ9Z9dkOh3I6AGGxQKAARrWZlQTQXFT1RAU
	Ykq+n0hBsVU3iEx8Ga/rd3EodCUV5zfCA0gVXteAR/u3zuHg9kuDtO6QP2DxIcrM10xCM1
	ZBMv8GqOmdcvZqta28VyvBE6NrrPy1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708331412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nmFrGbKHKgGYmJjLYoolA8lLxxnfPyDdiArr554cgk=;
	b=u9F1A7Q+BcCO6J2MU930pVReTp1WgEXuPqbRBQESidkfCa5+hfUbmAFNc10BAe3MJdPOeC
	XtCsMmNHKs2WVjBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708331412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nmFrGbKHKgGYmJjLYoolA8lLxxnfPyDdiArr554cgk=;
	b=ZNalOCFRO6AI3F8f9uAAmKb+uNRopyNXwXONZ9Z9dkOh3I6AGGxQKAARrWZlQTQXFT1RAU
	Ykq+n0hBsVU3iEx8Ga/rd3EodCUV5zfCA0gVXteAR/u3zuHg9kuDtO6QP2DxIcrM10xCM1
	ZBMv8GqOmdcvZqta28VyvBE6NrrPy1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708331412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/nmFrGbKHKgGYmJjLYoolA8lLxxnfPyDdiArr554cgk=;
	b=u9F1A7Q+BcCO6J2MU930pVReTp1WgEXuPqbRBQESidkfCa5+hfUbmAFNc10BAe3MJdPOeC
	XtCsMmNHKs2WVjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5260513647;
	Mon, 19 Feb 2024 08:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /LzNE5QR02WNBgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Feb 2024 08:30:12 +0000
Message-ID: <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
Date: Mon, 19 Feb 2024 09:30:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: David Rientjes <rientjes@google.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
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
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/18/24 20:25, David Rientjes wrote:
> On Thu, 15 Feb 2024, Jianfeng Wang wrote:
> 
>> When reading "/proc/slabinfo", the kernel needs to report the number of
>> free objects for each kmem_cache. The current implementation relies on
>> count_partial() that counts the number of free objects by scanning each
>> kmem_cache_node's partial slab list and summing free objects from all
>> partial slabs in the list. This process must hold per kmem_cache_node
>> spinlock and disable IRQ. Consequently, it can block slab allocation
>> requests on other CPU cores and cause timeouts for network devices etc.,
>> if the partial slab list is long. In production, even NMI watchdog can
>> be triggered because some slab caches have a long partial list: e.g.,
>> for "buffer_head", the number of partial slabs was observed to be ~1M
>> in one kmem_cache_node. This problem was also observed by several
>> others [1-2] in the past.
>> 
>> The fix is to maintain a counter of free objects for each kmem_cache.
>> Then, in get_slabinfo(), use the counter rather than count_partial()
>> when reporting the number of free objects for a slab cache. per-cpu
>> counter is used to minimize atomic or lock operation.
>> 
>> Benchmark: run hackbench on a dual-socket 72-CPU bare metal machine
>> with 256 GB memory and Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.3 GHz.
>> The command is "hackbench 18 thread 20000". Each group gets 10 runs.
>> 
> 
> This seems particularly intrusive for the common path to optimize for 
> reading of /proc/slabinfo, and that's shown in the benchmark result.
> 
> Could you discuss the /proc/slabinfo usage model a bit?  It's not clear if 
> this is being continuously read, or whether even a single read in 
> isolation is problematic.
> 
> That said, optimizing for reading /proc/slabinfo at the cost of runtime 
> performance degradation doesn't sound like the right trade-off.

It should be possible to make this overhead smaller by restricting the
counter only to partial list slabs, as [2] did. This would keep it out of
the fast paths, where it's really not acceptable.
Note [2] used atomic_long_t and the percpu counters used here should be
lower overhead. So basically try to get the best of both attemps.

>> Results:
>> - Mainline:
>> 21.0381 +- 0.0325 seconds time elapsed  ( +-  0.15% )
>> - Mainline w/ this patch:
>> 21.1878 +- 0.0239 seconds time elapsed  ( +-  0.11% )
>> 
>> [1] https://lore.kernel.org/linux-mm/
>> alpine.DEB.2.21.2003031602460.1537@www.lameter.com/T/
>> [2] https://lore.kernel.org/lkml/
>> alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com/T/
>> 
>> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
>> ---
>>  mm/slab.h |  4 ++++
>>  mm/slub.c | 31 +++++++++++++++++++++++++++++--
>>  2 files changed, 33 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 54deeb0428c6..a0e7672ba648 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/memcontrol.h>
>>  #include <linux/kfence.h>
>>  #include <linux/kasan.h>
>> +#include <linux/percpu_counter.h>
>>  
>>  /*
>>   * Internal slab definitions
>> @@ -277,6 +278,9 @@ struct kmem_cache {
>>  	unsigned int red_left_pad;	/* Left redzone padding size */
>>  	const char *name;		/* Name (only for display!) */
>>  	struct list_head list;		/* List of slab caches */
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	struct percpu_counter free_objects;
>> +#endif
>>  #ifdef CONFIG_SYSFS
>>  	struct kobject kobj;		/* For sysfs */
>>  #endif
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 2ef88bbf56a3..44f8ded96574 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -736,6 +736,12 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
>>  static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
>>  static DEFINE_SPINLOCK(object_map_lock);
>>  
>> +static inline void
>> +__update_kmem_cache_free_objs(struct kmem_cache *s, s64 delta)
>> +{
>> +	percpu_counter_add_batch(&s->free_objects, delta, INT_MAX);
>> +}
>> +
>>  static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
>>  		       struct slab *slab)
>>  {
>> @@ -1829,6 +1835,9 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>>  	return flags | slub_debug_local;
>>  }
>>  #else /* !CONFIG_SLUB_DEBUG */
>> +static inline void
>> +__update_kmem_cache_free_objs(struct kmem_cache *s, s64 delta) {}
>> +
>>  static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
>>  static inline
>>  void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
>> @@ -2369,6 +2378,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>>  	slab->inuse = 0;
>>  	slab->frozen = 0;
>>  
>> +	__update_kmem_cache_free_objs(s, slab->objects);
>>  	account_slab(slab, oo_order(oo), s, flags);
>>  
>>  	slab->slab_cache = s;
>> @@ -2445,6 +2455,7 @@ static void free_slab(struct kmem_cache *s, struct slab *slab)
>>  		call_rcu(&slab->rcu_head, rcu_free_slab);
>>  	else
>>  		__free_slab(s, slab);
>> +	__update_kmem_cache_free_objs(s, -slab->objects);
>>  }
>>  
>>  static void discard_slab(struct kmem_cache *s, struct slab *slab)
>> @@ -3859,6 +3870,8 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>>  	 */
>>  	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>>  
>> +	if (object)
>> +		__update_kmem_cache_free_objs(s, -1);
>>  	return object;
>>  }
>>  
>> @@ -4235,6 +4248,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>>  	unsigned long tid;
>>  	void **freelist;
>>  
>> +	__update_kmem_cache_free_objs(s, cnt);
>>  redo:
>>  	/*
>>  	 * Determine the currently cpus per cpu slab.
>> @@ -4286,6 +4300,7 @@ static void do_slab_free(struct kmem_cache *s,
>>  				struct slab *slab, void *head, void *tail,
>>  				int cnt, unsigned long addr)
>>  {
>> +	__update_kmem_cache_free_objs(s, cnt);
>>  	__slab_free(s, slab, head, tail, cnt, addr);
>>  }
>>  #endif /* CONFIG_SLUB_TINY */
>> @@ -4658,6 +4673,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>>  		memcg_slab_alloc_error_hook(s, size, objcg);
>>  	}
>>  
>> +	__update_kmem_cache_free_objs(s, -i);
>>  	return i;
>>  }
>>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>> @@ -4899,6 +4915,9 @@ void __kmem_cache_release(struct kmem_cache *s)
>>  	cache_random_seq_destroy(s);
>>  #ifndef CONFIG_SLUB_TINY
>>  	free_percpu(s->cpu_slab);
>> +#endif
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	percpu_counter_destroy(&s->free_objects);
>>  #endif
>>  	free_kmem_cache_nodes(s);
>>  }
>> @@ -5109,6 +5128,14 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>>  	s->random = get_random_long();
>>  #endif
>>  
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	int ret;
>> +
>> +	ret = percpu_counter_init(&s->free_objects, 0, GFP_KERNEL);
>> +	if (ret)
>> +		return ret;
>> +#endif
>> +
>>  	if (!calculate_sizes(s))
>>  		goto error;
>>  	if (disable_higher_order_debug) {
>> @@ -7100,15 +7127,15 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
>>  {
>>  	unsigned long nr_slabs = 0;
>>  	unsigned long nr_objs = 0;
>> -	unsigned long nr_free = 0;
>> +	unsigned long nr_free;
>>  	int node;
>>  	struct kmem_cache_node *n;
>>  
>>  	for_each_kmem_cache_node(s, node, n) {
>>  		nr_slabs += node_nr_slabs(n);
>>  		nr_objs += node_nr_objs(n);
>> -		nr_free += count_partial(n, count_free);
>>  	}
>> +	nr_free = percpu_counter_sum_positive(&s->free_objects);
>>  
>>  	sinfo->active_objs = nr_objs - nr_free;
>>  	sinfo->num_objs = nr_objs;
>> -- 
>> 2.42.1
>> 
>> 


