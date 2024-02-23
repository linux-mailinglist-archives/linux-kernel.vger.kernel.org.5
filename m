Return-Path: <linux-kernel+bounces-78751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB1B861842
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB393B2673A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18AD12838F;
	Fri, 23 Feb 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2OT+Qh3D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLxSkZPx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2OT+Qh3D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wLxSkZPx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D883FF1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706616; cv=none; b=A9+8TnDGt510wElaC0RPrhR/+5P3T4D/5PCRz2PIbTfmoGR9RXtVhq0YUD6+okWpORKCrduY5zCe9AJwsvJdIXzvg5vVmlz247GSC/PPlKCImmD+PHCDhgy13b1FyQAyNVMGV3SqIHtq3IOPix6rx18BSX0hoI2ITv2mRQJxUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706616; c=relaxed/simple;
	bh=vwn7JiCAzT+ZLee7nKOhjJnOcFjaLcOXInrr9wz6ITo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EX8JhW64HqZVvqlMlc66q5XoNkZdWBK8MjJl/hOnDNHY0uJAwx+5LcCOxUvCQbziDzx+itYYxvaeFlJ50Dgz5BPe0xgCaQ2PnjDj/5mc1JSSWGTzZQD9lcwni5v75A2M3ya/wRQjJUb5lJHgwE+Ub6RBi1RJxTOS+Kzmbw4Ye1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2OT+Qh3D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLxSkZPx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2OT+Qh3D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wLxSkZPx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B54B1FC2A;
	Fri, 23 Feb 2024 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708706612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE2URHICWI/LHH1AjYAsqoMojZ4QR/fYwJKrudMYFC4=;
	b=2OT+Qh3Dw1l1IialP8VVIQUGpW+45Dr2oNVISSa6VKeFNYL3mfP3ALzB+hsc3tNR/lIqwa
	w5v9s0VnVUo+t8Bx54UHPgBrcGDXgDyqqoqFzYf0XGfJbPC4exZrVd4iooXAm1eytC2X34
	tDSVsSqIKDOu3YeZUxocDpN1insDFHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708706612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE2URHICWI/LHH1AjYAsqoMojZ4QR/fYwJKrudMYFC4=;
	b=wLxSkZPxuzyDRsvvZZzVgNfBCO5HRlbysOxG3Sit8bfKp6K3JXsozoF++0od0GBzSLKOpi
	ohpmmz3AbAsqUhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708706612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE2URHICWI/LHH1AjYAsqoMojZ4QR/fYwJKrudMYFC4=;
	b=2OT+Qh3Dw1l1IialP8VVIQUGpW+45Dr2oNVISSa6VKeFNYL3mfP3ALzB+hsc3tNR/lIqwa
	w5v9s0VnVUo+t8Bx54UHPgBrcGDXgDyqqoqFzYf0XGfJbPC4exZrVd4iooXAm1eytC2X34
	tDSVsSqIKDOu3YeZUxocDpN1insDFHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708706612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE2URHICWI/LHH1AjYAsqoMojZ4QR/fYwJKrudMYFC4=;
	b=wLxSkZPxuzyDRsvvZZzVgNfBCO5HRlbysOxG3Sit8bfKp6K3JXsozoF++0od0GBzSLKOpi
	ohpmmz3AbAsqUhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01059133DC;
	Fri, 23 Feb 2024 16:43:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iOK0OjPL2GWUNAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 16:43:31 +0000
Message-ID: <7ff66c6a-4127-417b-a71f-a10ab47090b4@suse.cz>
Date: Fri, 23 Feb 2024 17:43:31 +0100
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
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <8bc31ec7-5d6e-b4c0-9d6e-42849673f35f@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2OT+Qh3D;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wLxSkZPx
X-Spamd-Result: default: False [1.02 / 50.00];
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
	 BAYES_HAM(-0.18)[70.21%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLycmwa99sdzp837p77658kns5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com,huawei.com,windriver.com,kvack.org,vger.kernel.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.02
X-Rspamd-Queue-Id: 3B54B1FC2A
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

On 2/23/24 04:12, Christoph Lameter (Ampere) wrote:
> On Tue, 20 Feb 2024, Vlastimil Babka wrote:
> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 2ef88bbf56a3..a93c5a17cbbb 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -306,13 +306,13 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>>
>> /* Internal SLUB flags */
>> /* Poison object */
>> -#define __OBJECT_POISON		((slab_flags_t __force)0x80000000U)
>> +#define __OBJECT_POISON		__SF_BIT(_SLAB_OBJECT_POISON)
>> /* Use cmpxchg_double */
>>
>> #ifdef system_has_freelist_aba
>> -#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0x40000000U)
>> +#define __CMPXCHG_DOUBLE	__SF_BIT(_SLAB_CMPXCHG_DOUBLE)
>> #else
>> -#define __CMPXCHG_DOUBLE	((slab_flags_t __force)0U)
>> +#define __CMPXCHG_DOUBLE	0
>> #endif
> 
> Maybe its good to put these internal flags together with the other flags. 
> After all there is no other slab allocator available anymore and having 
> them all together avoids confusion.

Good poiint, will do. Then I can also #undef the helper macro after the last
flag.




