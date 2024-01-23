Return-Path: <linux-kernel+bounces-34887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9538388D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F12CB21A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3258AB1;
	Tue, 23 Jan 2024 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5oqOpBR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NaDyXDrk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5oqOpBR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NaDyXDrk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127D58AA7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998275; cv=none; b=VymYKvrGoVrT3iK65RnCh7N8u/xp5ldYcr8DfXxrA/Ips3m+KTpK6+ANjf0bCjuaCDczF91E7w998SFtr14FhS1BkSMSZIVk8ta7+lJzLpsAxhF/T9nIaBjTkuYjuZ25VSGXj1P2XvROBxxs+ErYuTGqPFi36AzRjYJ8mgOlhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998275; c=relaxed/simple;
	bh=zWhLd5BECCRa4/i2MbDWlARVwVglB8s68b7OYWk8b+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPLFj2qNvh4BbdGFpUU0x2leaHBXdFwlllRsaNEbEjlLTuF4sXAyn2PhGvjwXw26bjG9ZWZCF7Jun08hKSYieErxj8nntVZdfNsHvynO4WIH7XALWSbovPL9QoTaCVdI/7LpGkQqdJXodf9gsThrfP0/bNXnFUZVFepSVnMsQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5oqOpBR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NaDyXDrk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5oqOpBR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NaDyXDrk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8DE811F76B;
	Tue, 23 Jan 2024 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705998271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qF9pTM2iZocrtZVj2sV+edGXZT+tYrsByVnKG403QCk=;
	b=Q5oqOpBRfYsOK9W2ZmmZRKdqfxnIJYTZb7b/LgwHU0/R19Qvdfl3c15OBI8Bd1xw6Tl3Gz
	WXp6vVo8X59UKcqUHvcfueP7eIH1zcuK79BgzYjs0Hlo7XfD3zjwifxNXS3GdgjqwiK9Gj
	/6MoaqHkLTJnbylUcipN84bOwqrqfe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705998271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qF9pTM2iZocrtZVj2sV+edGXZT+tYrsByVnKG403QCk=;
	b=NaDyXDrkSWboFPGhW2kgv0r+9725XNgEZdRzOuRrihNQwhuiPmUAyOV71f7yuovZQLQR4j
	ODL5E+7FNcT+r1Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705998271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qF9pTM2iZocrtZVj2sV+edGXZT+tYrsByVnKG403QCk=;
	b=Q5oqOpBRfYsOK9W2ZmmZRKdqfxnIJYTZb7b/LgwHU0/R19Qvdfl3c15OBI8Bd1xw6Tl3Gz
	WXp6vVo8X59UKcqUHvcfueP7eIH1zcuK79BgzYjs0Hlo7XfD3zjwifxNXS3GdgjqwiK9Gj
	/6MoaqHkLTJnbylUcipN84bOwqrqfe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705998271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qF9pTM2iZocrtZVj2sV+edGXZT+tYrsByVnKG403QCk=;
	b=NaDyXDrkSWboFPGhW2kgv0r+9725XNgEZdRzOuRrihNQwhuiPmUAyOV71f7yuovZQLQR4j
	ODL5E+7FNcT+r1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 754D713786;
	Tue, 23 Jan 2024 08:24:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7G5CHL93r2VxcAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 23 Jan 2024 08:24:31 +0000
Message-ID: <0974c3b7-a964-44b6-a588-e08c6f79eec9@suse.cz>
Date: Tue, 23 Jan 2024 09:24:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/slub: directly load freelist from cpu partial slab
 in the likely case
To: Chengming Zhou <zhouchengming@bytedance.com>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
 <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com>
 <76641777-1918-2b29-b6aa-bda9b5467aa3@gentwo.org>
 <412b8618-0941-4d9d-85df-ee480695e7f7@bytedance.com>
 <a2132c63-99a5-7fa2-9f2a-cccf6b40fe9e@linux.com>
 <e81d914b-8718-4dbb-a2d8-d5298fe66d1a@bytedance.com>
 <ac0ce290-58a7-42b2-a7e4-72e241717c63@suse.cz>
 <36964450-f45a-4f35-a187-dc493246ef59@bytedance.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <36964450-f45a-4f35-a187-dc493246ef59@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,lge.com,kernel.org,linux-foundation.org,linux.dev,google.com,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.59

On 1/23/24 03:51, Chengming Zhou wrote:
> On 2024/1/23 01:13, Vlastimil Babka wrote:
>> On 1/19/24 04:53, Chengming Zhou wrote:
>>> On 2024/1/19 06:14, Christoph Lameter (Ampere) wrote:
>>>> On Thu, 18 Jan 2024, Chengming Zhou wrote:
>>>>
>>>>> So get_freelist() has two cases to handle: cpu slab and cpu partial list slab.
>>>>> The latter is NOT frozen, so need to remove "VM_BUG_ON(!new.frozen)" from it.
>>>>
>>>> Right so keep the check if it is the former?
>>>>
>>>
>>> Ok, I get it. Maybe like this:
>> 
>> I think that's just too ugly for a VM_BUG_ON(). I'd just remove the check
>> and be done with that.
> 
> Ok with me.
> 
>> 
>> I have a somewhat different point. You reused get_freelist() but in fact
>> it's more like freeze_slab(), but that one uses slab_update_freelist() and
>> we are under the local_lock so we want the cheaper __slab_update_freelist(),
>> which get_freelist() has and I guess that's why you reused that one.
> 
> Right, we already have the lock_lock, so reuse get_freelist().
> 
>> 
>> However get_freelist() also assumes it can return NULL if the freelist is
>> empty. If that's possible to happen on the percpu partial list, we should
>> not "goto load_freelist;" but rather create a new label above that, above
>> the "if (!freelist) {" block that handles the case.
>> 
>> If that's not possible to happen (needs careful audit) and we have guarantee
> 
> Yes, it's not possible for now.
> 
>> that slabs on percpu partial list must have non-empty freelist, then we
>> probably instead want a new __freeze_slab() variant that is like
>> freeze_slab(), but uses __slab_update_freelist() and probably also has
>> VM_BUG_ON(!freelist) before returning it?
>> 
> 
> Instead of introducing another new function, how about still reusing get_freelist()
> and VM_BUG_ON(!freelist) after calling it? I feel this is simpler.

Could you measure if introducing new function that sets new.frozen = 1; has
any performance benefit? If not, we can reuse get_freelist() as you say.
Thanks!

> Thanks!


