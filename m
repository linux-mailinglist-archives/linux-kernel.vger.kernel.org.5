Return-Path: <linux-kernel+bounces-78788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EFD8618D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98B41F238C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B812A151;
	Fri, 23 Feb 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c3nbt8eP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RIdmzQbR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c3nbt8eP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RIdmzQbR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C442A99
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707986; cv=none; b=CsHrua/GR9tkqFwS4WflWP2KL9O/i0I8Wpj8llHWcsNKnnAlku8l32WqMvwmGhiGpW0kLhGpEOZes3i6E2PIWI/BIBpoYFNVPx/EHy2z08x+5HxWOU80X0moAlAP24as0Cw2vx9s/MxoqsVYbChAc59YNQZMffVS37lmeq0dg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707986; c=relaxed/simple;
	bh=UBbWfigObnroS+8pL5BsALO6nQWfGs57MyLJ+vhS9zY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OzDBlG1pPRUr3td49Xj+kHFoG6xc7kTi1Gb55CKMpQ0ODhsACmLS9Jko7SxsVyslvkbu6O6Il2BHbf15hzrIpb6tXwtc/3/JcLnzXj1PVg/U0sJDGZ9Bn2Iz+HP0obKdl2FWq5mktOY0YnPQLxODNd3/cTv6UXMqLfRAtXOHmVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c3nbt8eP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RIdmzQbR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c3nbt8eP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RIdmzQbR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F90E1FC2A;
	Fri, 23 Feb 2024 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708707981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRXLoTFs1yNmoq5dTsBkasLC6qtPSY+4X/YPItbqSTo=;
	b=c3nbt8ePU6Dr4/cuyloEb6uZ/gRHDChYfzgWRJ7pw+hf9K5ZbbUDoIvz5K7BIBq8dsuW16
	YJ5MmXuSvATunRAH9lRpSVyZWhnuNVzAXwufmCiV5sfxY1tbHtuRQ9DY6pmXAgMgFFEHcc
	31c5fa1FX/pqCSO++KdabBm3tLzMuSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708707981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRXLoTFs1yNmoq5dTsBkasLC6qtPSY+4X/YPItbqSTo=;
	b=RIdmzQbRMTYR1F3yozrDWj6RU4/1LivIXKaZ0qt3SNVtLGiPudmM6nPsXgp8c3i4T3W4Y4
	fcsgkIlXhH2xCyAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708707981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRXLoTFs1yNmoq5dTsBkasLC6qtPSY+4X/YPItbqSTo=;
	b=c3nbt8ePU6Dr4/cuyloEb6uZ/gRHDChYfzgWRJ7pw+hf9K5ZbbUDoIvz5K7BIBq8dsuW16
	YJ5MmXuSvATunRAH9lRpSVyZWhnuNVzAXwufmCiV5sfxY1tbHtuRQ9DY6pmXAgMgFFEHcc
	31c5fa1FX/pqCSO++KdabBm3tLzMuSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708707981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRXLoTFs1yNmoq5dTsBkasLC6qtPSY+4X/YPItbqSTo=;
	b=RIdmzQbRMTYR1F3yozrDWj6RU4/1LivIXKaZ0qt3SNVtLGiPudmM6nPsXgp8c3i4T3W4Y4
	fcsgkIlXhH2xCyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBDC2133DC;
	Fri, 23 Feb 2024 17:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eu36OIzQ2GW0OgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 17:06:20 +0000
Message-ID: <9b6a4b83-0922-494e-9284-9214152c8e9c@suse.cz>
Date: Fri, 23 Feb 2024 18:06:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm, slab: use an enum to define SLAB_ cache creation
 flags
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Xiongwei Song <xiongwei.song@windriver.com>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
References: <20240220-slab-cleanup-flags-v1-0-e657e373944a@suse.cz>
 <20240220-slab-cleanup-flags-v1-2-e657e373944a@suse.cz>
 <8bc31ec7-5d6e-b4c0-9d6e-42849673f35f@linux.com>
 <7ff66c6a-4127-417b-a71f-a10ab47090b4@suse.cz>
In-Reply-To: <7ff66c6a-4127-417b-a71f-a10ab47090b4@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c3nbt8eP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RIdmzQbR
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.05 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLycmwa99sdzp837p77658kns5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.05)[59.48%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com,huawei.com,windriver.com,kvack.org,vger.kernel.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -0.05
X-Rspamd-Queue-Id: 2F90E1FC2A
X-Spam-Flag: NO

On 2/23/24 17:43, Vlastimil Babka wrote:
> On 2/23/24 04:12, Christoph Lameter (Ampere) wrote:
>> On Tue, 20 Feb 2024, Vlastimil Babka wrote:
>> 
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index 2ef88bbf56a3..a93c5a17cbbb 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -306,13 +306,13 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>>>
>>> /* Internal SLUB flags */
>>> /* Poison object */
>>> -#define __OBJECT_POISON		((slab_flags_t __force)0x80000000U)
>>> +#define __OBJECT_POISON		__SF_BIT(_SLAB_OBJECT_POISON)
>>> /* Use cmpxchg_double */
>>>
>>> #ifdef system_has_freelist_aba

Hm but we only have this in the internal mm/slab.h

>>> -#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0x40000000U)
>>> +#define __CMPXCHG_DOUBLE	__SF_BIT(_SLAB_CMPXCHG_DOUBLE)
>>> #else
>>> -#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0U)
>>> +#define __CMPXCHG_DOUBLE	0

And keeping the 0 is desirable to make the checks compile-time false when
it's not available.

So maybe it's best if it stays here after all, or we'd pull too much of
internal details into the "public" slab.h

>>> #endif
>> 
>> Maybe its good to put these internal flags together with the other flags. 
>> After all there is no other slab allocator available anymore and having 
>> them all together avoids confusion.
> 
> Good poiint, will do. Then I can also #undef the helper macro after the last
> flag.
> 
> 
> 


