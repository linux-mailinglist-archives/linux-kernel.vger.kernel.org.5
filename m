Return-Path: <linux-kernel+bounces-39677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D383D4ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007B01F28D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB6921118;
	Fri, 26 Jan 2024 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vd1HKDcm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="po6VpIsP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vd1HKDcm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="po6VpIsP"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD56C2110E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252205; cv=none; b=trecrT3naS7cdK+2UV7cbC3D28znNuOygwjpu2nmcoVKEk8e+DfDXC68pI8I8ztlVuk+KscjJge35tTFZK9RPbOa3C3jALcPlJwAS/+qnbopd9XPuA3sRjqOdHYMz2Cq3izMjQ9+uX256+vyJkHvUu4bIE88B7ftuzYXZx3SFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252205; c=relaxed/simple;
	bh=pqamaRpz7rMvuoPK41hS59wevP3ULb9HWDJuKXOX9ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crCVHQLfXNpcmUFoFn206YZHaRB8s+ajnQuK3+IQFGZy9XtxJWkWcdhcmg1emjE3oLGuSVpbkXBvFFBt79nZTjDk1xNmkQ/pqyI2zG/M93fY0pgeZXpwwK+H63KK2W9iI9aP85jv0fBPLAFE84D9ycfIiaoeJxpTkYYLotmXdyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vd1HKDcm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=po6VpIsP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vd1HKDcm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=po6VpIsP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 730951FB63;
	Fri, 26 Jan 2024 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706252201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcfkS2d9XntyiwzpBU4N4I4iE45H6Fii3c7Ol6b5+mQ=;
	b=Vd1HKDcmRVAu9qMXs4IlNVdNE7OOzW/taI1IDgOlHgzhU/4BzM0Vj8MFlhWBzre/WLDpwB
	Y3KwPGhbEEHLH6rpgWiQJQXvey+Fpk0JdhAWyN6vssTCrZD6HjUFRI2r+KjKTAyI5aO5/x
	hk9aBiv+nyBeUYCIIeFoXKhCIdepU7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706252201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcfkS2d9XntyiwzpBU4N4I4iE45H6Fii3c7Ol6b5+mQ=;
	b=po6VpIsPSo9Yj/BNbnAJGOS0IfIta1QULzFiPEj8Xzpy0E6tbIC9uHXhK3kEr0H1ua5dVT
	C1ACbHsT5fHHELCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706252201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcfkS2d9XntyiwzpBU4N4I4iE45H6Fii3c7Ol6b5+mQ=;
	b=Vd1HKDcmRVAu9qMXs4IlNVdNE7OOzW/taI1IDgOlHgzhU/4BzM0Vj8MFlhWBzre/WLDpwB
	Y3KwPGhbEEHLH6rpgWiQJQXvey+Fpk0JdhAWyN6vssTCrZD6HjUFRI2r+KjKTAyI5aO5/x
	hk9aBiv+nyBeUYCIIeFoXKhCIdepU7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706252201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VcfkS2d9XntyiwzpBU4N4I4iE45H6Fii3c7Ol6b5+mQ=;
	b=po6VpIsPSo9Yj/BNbnAJGOS0IfIta1QULzFiPEj8Xzpy0E6tbIC9uHXhK3kEr0H1ua5dVT
	C1ACbHsT5fHHELCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E96E4134C3;
	Fri, 26 Jan 2024 06:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XywCN6hXs2U0XQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 26 Jan 2024 06:56:40 +0000
Message-ID: <d390d7ee-f142-44d3-822a-87949e14608b@suse.de>
Date: Fri, 26 Jan 2024 07:56:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softirq: fix memory corruption when freeing
 tasklet_struct
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Mikulas Patocka
 <mpatocka@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 Mike Snitzer <msnitzer@redhat.com>, Ignat Korchagin <ignat@cloudflare.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Hou Tao <houtao1@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
References: <82b964f0-c2c8-a2c6-5b1f-f3145dc2c8e5@redhat.com>
 <CAHk-=wjDW53w4-YcSmgKC5RruiRLHmJ1sXeYdp_ZgVoBw=5byA@mail.gmail.com>
 <586ca4dd-f191-9ada-1bc3-e5672f17f7c@redhat.com>
 <5e2b5f23-94f0-4bf0-80a6-48380c7dc730@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5e2b5f23-94f0-4bf0-80a6-48380c7dc730@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Vd1HKDcm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=po6VpIsP
X-Spamd-Result: default: False [-3.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 730951FB63
X-Spam-Level: 
X-Spam-Score: -3.30
X-Spam-Flag: NO

On 1/26/24 00:15, Damien Le Moal wrote:
> On 1/26/24 07:04, Mikulas Patocka wrote:
>>
>>
>> On Thu, 25 Jan 2024, Linus Torvalds wrote:
>>
>>> On Thu, 25 Jan 2024 at 10:30, Mikulas Patocka <mpatocka@redhat.com> wrote:
>>>>
>>>> There's a problem with the tasklet API - there is no reliable way how to
>>>> free a structure that contains tasklet_struct. The problem is that the
>>>> function tasklet_action_common calls task_unlock(t) after it called the
>>>> callback. If the callback does something that frees tasklet_struct,
>>>> task_unlock(t) would write into free memory.
>>>
>>> Ugh.
>>>
>>> I see what you're doing, but I have to say, I dislike this patch
>>> immensely. It feels like a serious misdesign that is then papered over
>>> with a hack.
>>>
>>> I'd much rather see us trying to move away from tasklets entirely in
>>> cases like this. Just say "you cannot do that".
>>
>> OK. I will delete tasklets from both dm-crypt and dm-verity - it will
>> simplify them quite a bit.
>>
>> BTW. Do you think that we should get rid of request-based device mapper as
>> well? (that's another thing that looks like code bloat to me)
> 
> That would force removing dm-multipath, which is I think the only DM driver
> using requests. But given how widespread the use of dm-multipath is, killing it
> would likely make a lot of people unhappy...
> 
Oh, it's this time of the year again?
(This topic regularly comes up ...)

The reason is not that it will disable dm-multipath (Mike Snitzer put in 
bio-based multipathing as an additional code path); the reason is that 
dm-multipath performance will suffer when you remove request-based DM.

DM-multipath schedules based on request (if you use the request-based 
interface) or bios (if you use the bio-based interface).
Any merge decision is typically done by the block layer when combining 
bios into requests; and you can only merge bios if the bvecs are adjacent.
So if you use bio-based multipathing you will spread sequential bios
across all paths, leaving the block layer unable to merge requests.
For request based multipathing the requests are already fully-formed,
and scheduling across paths does not change them.
Things are slightly better with multi-page bvecs nowadays, but the
overall picture still stands.

Another thing is timeouts; bios don't do timeouts, so a bio can run
for an arbitrary time with no chance of interrupting it.
Requests do have a timeout, and will be aborted from the driver when
the timeout is hit.
Seeing that 99% of all I/O issues I've seen _are_ timeouts it becomes
a crucial feature if you want dm-multipath to control failover time.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


