Return-Path: <linux-kernel+bounces-78003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75FF860DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D601287DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF25C8E9;
	Fri, 23 Feb 2024 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PhS/hbMB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQ6TEx6P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PhS/hbMB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HQ6TEx6P"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575DD59B50
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680256; cv=none; b=rQox238AhhjgYT5lBGBBSB0nr1eY0tcNPl6pZOvUxJ7Acfjy94IrdB+8K7ejiAAziCAXEqkXd2cyw3CJlsY3ZygXMqE5SQKm9HgKa3OXXxeivT5b+vy1E2xflqTbEI/MGjrmrNu/5mmLwJ/0zramMbOEaPROLHbs5jyIhsIYeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680256; c=relaxed/simple;
	bh=/b/uAasNatYQkDRlPz3mGNYIuDQ6VGlg03I3StB6bnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCq0Lo2+qjWPnpqnUx1U//AVoVMx+higdyptsgRQzVwMWMWz1Jp3GlV+PuHrOcI4aTJIVbp7RycrfNVgWpQVZEf+1WUCMoqmDagBx26vmfTTMjnxgQXbfANzNTKw+1+WlpwpUZx+Rewv34jQ98aqt90ECkdUV2jKh1OWYv+/bNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PhS/hbMB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQ6TEx6P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PhS/hbMB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HQ6TEx6P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 858CF22055;
	Fri, 23 Feb 2024 09:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708680252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI3PUL04AyDJ8eLPoZj8TZ5v3v4zDascbS3qGTDm8D4=;
	b=PhS/hbMBvnREKdhHIvVRK1rDlStl2LC2w7g5gFbs3R1CwU0qVyq0B9V6lT4zNYzOlmNpIP
	ITRqzZ6UfvYaghpqpjHqBTPRFB1z4GBbIr2ggKpXa8OHwGBAAzuOktz5o2jAUbT8XG29Vp
	/tbjJ+LNZqjjFPLxkra3qvef5i0AJ3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708680252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI3PUL04AyDJ8eLPoZj8TZ5v3v4zDascbS3qGTDm8D4=;
	b=HQ6TEx6PM75XacgxB4dFIxFRF1g7/nuTmAk4ERZVWj/k+MOdY4NvPKJLQEUlTs5+BQ77CS
	ioeKSi5/ZgymjaCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708680252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI3PUL04AyDJ8eLPoZj8TZ5v3v4zDascbS3qGTDm8D4=;
	b=PhS/hbMBvnREKdhHIvVRK1rDlStl2LC2w7g5gFbs3R1CwU0qVyq0B9V6lT4zNYzOlmNpIP
	ITRqzZ6UfvYaghpqpjHqBTPRFB1z4GBbIr2ggKpXa8OHwGBAAzuOktz5o2jAUbT8XG29Vp
	/tbjJ+LNZqjjFPLxkra3qvef5i0AJ3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708680252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI3PUL04AyDJ8eLPoZj8TZ5v3v4zDascbS3qGTDm8D4=;
	b=HQ6TEx6PM75XacgxB4dFIxFRF1g7/nuTmAk4ERZVWj/k+MOdY4NvPKJLQEUlTs5+BQ77CS
	ioeKSi5/ZgymjaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 634E8132C7;
	Fri, 23 Feb 2024 09:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r++SFzxk2GW9RQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 23 Feb 2024 09:24:12 +0000
Message-ID: <1a952209-fa22-4439-af27-bf102c7d742b@suse.cz>
Date: Fri, 23 Feb 2024 10:24:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: Chengming Zhou <chengming.zhou@linux.dev>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
 <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
 <6daf88a2-84c2-5ba4-853c-c38cca4a03cb@linux.com>
 <e924c39b-7636-4c34-bfe9-603cf07c21d3@linux.dev>
 <b8f393fb-2b1d-213c-9301-35d4ffca1f50@linux.com>
 <347b870e-a7d5-45df-84ba-4eee37b74ff6@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <347b870e-a7d5-45df-84ba-4eee37b74ff6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.79
X-Spamd-Result: default: False [-2.79 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
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
	 RCPT_COUNT_TWELVE(0.00)[12];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[google.com,oracle.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On 2/23/24 06:00, Chengming Zhou wrote:
> On 2024/2/23 11:50, Christoph Lameter (Ampere) wrote:
>> On Fri, 23 Feb 2024, Chengming Zhou wrote:
>> 
>>>> Can we guestimate the free objects based on the number of partial slabs. That number is available.
>>>
>>> Yeah, the number of partial slabs is easy to know, but I can't think of a way to
>>> estimate the free objects, since __slab_free() is just double cmpxchg in most cases.
>> 
>> Well a starting point may be half the objects possible in a slab page?
> 
> Yeah, also a choice.
> 
>> 
>> 
>>>> How accurate need the accounting be? We also have fuzzy accounting in the VM counters.
>>>
>>> Maybe not need to be very accurate, some delay/fuzzy should be acceptable.
>>>
>>> Another direction I think is that we don't distinguish slabs on cpu partial list or
>>> slabs on node partial list anymore (different with current behavior).
>>>
>>> Now we have three scopes:
>>> 1. SL_ALL: include all slabs
>>> 2. SL_PARTIAL: only include partial slabs on node
>>> 3. SL_CPU: only include partail slabs on cpu and the using cpu slab
>>>
>>> If we change SL_PARTIAL to mean all partial slabs, it maybe simpler.
>> 
>> Thats not going to work since you would have to scan multiple lists instead of a single list.
> 
> We have to use percpu counters if we go this way.
> 
>> 
>> Another approach may be to come up with some way to scan the partial lists without taking locks. That actually would improve the performance of the allocator. It may work with a single linked lists and RCU.

We often remove a slab from the middle of a partial list due to object
freeing, and this means it has to be double linked, no?

>> 
> 
> I think this is a better direction! We can use RCU list if slab can be freed by RCU.

Often we remove slab from the partial list for other purposes than freeing -
i.e. to become a cpu (partial) slab, and that can't be handled by a rcu
callback nor can we wait a grace period in such situations.

