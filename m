Return-Path: <linux-kernel+bounces-167719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C18BADF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9070282068
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F68153BD1;
	Fri,  3 May 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="llhNICT+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXaCRHt8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="llhNICT+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXaCRHt8"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB51E4B1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743943; cv=none; b=tvZQZRVsYVvlYO89OWh36XHGHTBnl8M+MS0knEOa1vIAF/BoFeopgc/jIQ67XJeCnBawTg2TEHzau+EaNb2/sUT6Q3SiR0Jlkd0yD3JkJsCpoI/1tZQU88jHlRy21i99yqbbeDItUU7F4G1Fe68e3PO/MwAl/OjAZSwpzoMOumg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743943; c=relaxed/simple;
	bh=jl6p8UMhfaFUUEWbOK+4DeRjdEQfNDIYyjHHEbZNOHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvABuba3ZyySnAyma33N09aSaMgqzSWbVRLhZQbQaImtFOhRdlNcikdOsCr8yTPDNXoo6lfa54XRRCr9mzVPPhoi5+74o799tvp1eabRd6q9duWw7rkRv85yR+pgXDz/738mPjFNiJM1FhYpMEdKASKm6FSMrts1TVG0GztuRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=llhNICT+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DXaCRHt8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=llhNICT+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DXaCRHt8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EF6921F92;
	Fri,  3 May 2024 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714743940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7QCZQzqpxuWUxcQX3tjIcKBIYpEWQQAw/khjASQyEyM=;
	b=llhNICT+mD41NH8zQpCITtktDPIzcn7OszFJ/FePIe0oJ+/EOGbZVgOYj0/gqbYdrtkth4
	YD0L9YU96mVSWhDnRkKaZk+/FFOBGV+5lTDruvtPSfdcBFdJo70BLdDPX6UR1QG84o5vci
	ZqfBFHNVpE2gpK09NVW4XPk9OeNp0/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714743940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7QCZQzqpxuWUxcQX3tjIcKBIYpEWQQAw/khjASQyEyM=;
	b=DXaCRHt8xaPU7KvU4AXSBPrLlUOKO43IjFps7v3IBWOlj5UOZqU6X1EjaZT1ScD1jO4tOR
	hCDUm627H5cVbQAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714743940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7QCZQzqpxuWUxcQX3tjIcKBIYpEWQQAw/khjASQyEyM=;
	b=llhNICT+mD41NH8zQpCITtktDPIzcn7OszFJ/FePIe0oJ+/EOGbZVgOYj0/gqbYdrtkth4
	YD0L9YU96mVSWhDnRkKaZk+/FFOBGV+5lTDruvtPSfdcBFdJo70BLdDPX6UR1QG84o5vci
	ZqfBFHNVpE2gpK09NVW4XPk9OeNp0/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714743940;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7QCZQzqpxuWUxcQX3tjIcKBIYpEWQQAw/khjASQyEyM=;
	b=DXaCRHt8xaPU7KvU4AXSBPrLlUOKO43IjFps7v3IBWOlj5UOZqU6X1EjaZT1ScD1jO4tOR
	hCDUm627H5cVbQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECA1A139CB;
	Fri,  3 May 2024 13:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QvpvOYPqNGaMCQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 03 May 2024 13:45:39 +0000
Message-ID: <d855af59-be1f-40e0-b5db-840ca1b23cdd@suse.cz>
Date: Fri, 3 May 2024 15:45:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vmstat: sum up all possible CPUs instead of using
 vm_events_fold_cpu
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: hannes@cmpxchg.org, linux-kernel@vger.kernel.org, david@redhat.com,
 v-songbaohua@oppo.com, willy@infradead.org
References: <20240503020924.208431-1-21cnbao@gmail.com>
 <c055203a-4365-4f5e-8276-5c57634abe73@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <c055203a-4365-4f5e-8276-5c57634abe73@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_TO(0.00)[arm.com,gmail.com,linux-foundation.org,kvack.org];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 5/3/24 11:16 AM, Ryan Roberts wrote:
> On 03/05/2024 03:09, Barry Song wrote:
>> @@ -83,8 +83,6 @@ static inline void count_vm_events(enum vm_event_item item, long delta)
>>  
>>  extern void all_vm_events(unsigned long *);
>>  
>> -extern void vm_events_fold_cpu(int cpu);
>> -
>>  #else
>>  
>>  /* Disable counters */
>> @@ -103,9 +101,6 @@ static inline void __count_vm_events(enum vm_event_item item, long delta)
>>  static inline void all_vm_events(unsigned long *ret)
>>  {
>>  }
>> -static inline void vm_events_fold_cpu(int cpu)
>> -{
>> -}
>>  
>>  #endif /* CONFIG_VM_EVENT_COUNTERS */
>>  
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index cd584aace6bf..8b56d785d587 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5826,14 +5826,6 @@ static int page_alloc_cpu_dead(unsigned int cpu)
>>  	mlock_drain_remote(cpu);
>>  	drain_pages(cpu);
>>  
>> -	/*
>> -	 * Spill the event counters of the dead processor
>> -	 * into the current processors event counters.
>> -	 * This artificially elevates the count of the current
>> -	 * processor.
>> -	 */
>> -	vm_events_fold_cpu(cpu);
>> -
>>  	/*
>>  	 * Zero the differential counters of the dead processor
>>  	 * so that the vm statistics are consistent.
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index db79935e4a54..aaa32418652e 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -114,7 +114,7 @@ static void sum_vm_events(unsigned long *ret)
>>  
>>  	memset(ret, 0, NR_VM_EVENT_ITEMS * sizeof(unsigned long));
>>  
>> -	for_each_online_cpu(cpu) {
>> +	for_each_possible_cpu(cpu) {
> 
> One thought comes to mind (due to my lack of understanding exactly what
> "possible" means): Linux is compiled with a max number of cpus - NR_CPUS - 512
> for arm64's defconfig. Does all possible cpus include all 512? On an 8 CPU
> system that would be increasing the number of loops by 64 times.
> 
> Or perhaps possible just means CPUs that have ever been online?

IIRC on x86 it comes from some BIOS tables, and some bioses might be not
providing very realistic numbers, so it can be unnecessary large.

> Either way, I guess it's not considered a performance bottleneck because, from
> memory, the scheduler and many other places are iterating over all possible cpus.

I doubt anything does it in a fastpath. But this affects only reading
/proc/vmstat, right? Which is not a fastpath. Also update_balloon_stats()
which is probably ok as well?

Either way I don't see a clear advantage nor disadvantage of this.

>>  		struct vm_event_state *this = &per_cpu(vm_event_states, cpu);
>>  
>>  		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
>> @@ -129,29 +129,10 @@ static void sum_vm_events(unsigned long *ret)
>>  */
>>  void all_vm_events(unsigned long *ret)
>>  {
>> -	cpus_read_lock();
>>  	sum_vm_events(ret);
>> -	cpus_read_unlock();
>>  }
>>  EXPORT_SYMBOL_GPL(all_vm_events);
>>  
>> -/*
>> - * Fold the foreign cpu events into our own.
>> - *
>> - * This is adding to the events on one processor
>> - * but keeps the global counts constant.
>> - */
>> -void vm_events_fold_cpu(int cpu)
>> -{
>> -	struct vm_event_state *fold_state = &per_cpu(vm_event_states, cpu);
>> -	int i;
>> -
>> -	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
>> -		count_vm_events(i, fold_state->event[i]);
>> -		fold_state->event[i] = 0;
>> -	}
>> -}
>> -
>>  #endif /* CONFIG_VM_EVENT_COUNTERS */
>>  
>>  /*
> 


