Return-Path: <linux-kernel+bounces-71863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7197E85ABF7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B5328482E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A95027F;
	Mon, 19 Feb 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WBOZqsAY"
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4F5C99
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370788; cv=pass; b=ThxREUHTDfTQJ9To7ZViVr3nRxhSXzrkIpeckL8aNZQYARwCD/lUnSop/H9YVZbZMOIxLR14xn7qs/W0K/xk7feIeHc5/fwhHfbwnQtnf3pvLKlqWO9iVwJIJcGUML4u+U45cRqP4DrcMbCxaoPYvHGo1kgl+YwZSGWlA5SeaMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370788; c=relaxed/simple;
	bh=uf1A//8zCOrZfoBhZKPqmCeZ7Kh/8dmn97nNY6s5mYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS5DEALWdoFaSzECWtAYYWplEVgFqfTnOCvxzPQ8XVvzdoPl6YoP+DvtmmXI15HUUHBb3i3jkwkSLbsHgE1KqH256JKDKxgPtqt5eXMJqBW4utKw+xyb8uC+d/JpBEoXKk4Gu9rm3XBXcLYKYVCS1uyWHRjwMj4CFJDmsN4u2fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WBOZqsAY; arc=pass smtp.client-ip=23.83.218.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C367A764159;
	Mon, 19 Feb 2024 19:26:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D41DD760B46;
	Mon, 19 Feb 2024 19:26:19 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708370780; a=rsa-sha256;
	cv=none;
	b=tdpzv6Vivgyp5rlzlWZHXQjW0KBlF+EPAmmdNhqZLi3kIBwDk+Y/yYZfARc5IYajG3Bw06
	srhWfmQ4ixmfpyj3UtiUe9KPoeX6sf9e7ZMflV90OL2/cczUUcwCJldZ7/kJ2SNWjqdX8M
	SCV2Ey89yVTGOm+JihSQMiQiRGCQoa3QHKwj0ukuKMcH37++Srj1LV0mnLiuuvqynrj9F4
	vHSByvqGimoGWhLY+T1mYVtSwyNQxg1BzARBZMwcVjBfqVqg/j4N78B2kLegdScR5xq9wq
	PkDGxmUIQYp0Jg2oLho61wKGaqdPgEGl4zzAqklF5RXqAKjvaah9UPoNPiIc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1708370780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Hn2l3d45OvLwYGiCr0LlqsBI++buxfvs3HMYLYE8Fk4=;
	b=pHOxg1gNAzrmlHob8c9Xi/82rm6dywk9T2mqdTEIs5qqS+HydjRDsSEiNbGG9q8ac488lL
	LGIAyDe9v2B5K1G172SEGQyRTdh+9RXe5zoicVQMSLpYQipQN81gxx5LFr5euZT0ZYySlD
	58yNgZVUiK0Cc6JCnfxlBUfO1LCKTV5KXv8JUFQdRsqazqbs/rm9BLxTgRjI6TIPKN0era
	tgIgWb0P8wCKVoFQ+QQZE8WM3V2Ajp6/xKONb9TX3RqW4ccWqMYnynwZPm0Nwhz9g7izMk
	agz4tzbedOTsAog9DXXXHDG/DaBB86Z6KQ2TrrkHQRuPT87ZmHILvh6L0tO6IQ==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-5mzw9;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Cellar: 2b2031422a3cfeaf_1708370780645_702971671
X-MC-Loop-Signature: 1708370780645:464803234
X-MC-Ingress-Time: 1708370780645
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.181.103 (trex/6.9.2);
	Mon, 19 Feb 2024 19:26:20 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4TdswB4kXjzGH;
	Mon, 19 Feb 2024 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1708370779;
	bh=Hn2l3d45OvLwYGiCr0LlqsBI++buxfvs3HMYLYE8Fk4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=WBOZqsAYKS9HgVsjtYxiIK9i0CM1ATn7RXh9NGZcdf2nD6iyhaa4bVyH3H8dHdBxR
	 wuGXtz+1CKgaK+WP118KJPyiempcvgvCkNcsybhkErAu/4cgASzeuHe7lDiISwdBqu
	 JKPqhyCRoEfFjOFRuuxO9L4benP/dih3t0ERyPBjq4uQ/2WvFcFNuwYa2bIq9p1oTk
	 kcR9paTrIQN5kfnOy/D5FC/9/vEmcUhIy8sdjG3FjUz7XL+H/VoD7yqrCeMs1TnqqU
	 vrjpym5dV5T1zt0lwXn2te1jDwHA5zZbTagcezJr5eZci/fXz5xUFDWlgJg03b8lc4
	 qejgiwv7aw8fA==
Date: Mon, 19 Feb 2024 11:26:15 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Oscar Salvador <osalvador@suse.de>
Cc: Byungchul Park <byungchul@sk.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	fan.ni@samsung.com
Subject: Re: [PATCH v3] sched/numa, mm: do not promote folios to nodes not
 set N_MEMORY
Message-ID: <20240219192615.adgr4cfknnb356de@offworld>
Mail-Followup-To: Oscar Salvador <osalvador@suse.de>,
	Byungchul Park <byungchul@sk.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org,
	fan.ni@samsung.com
References: <20240216114045.24828-1-byungchul@sk.com>
 <Zc9oXOwGMGGE4bBh@localhost.localdomain>
 <ZdG1yO29WTyRiw8Q@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZdG1yO29WTyRiw8Q@localhost.localdomain>
User-Agent: NeoMutt/20220429

On Sun, 18 Feb 2024, Oscar Salvador wrote:

>On Fri, Feb 16, 2024 at 02:51:24PM +0100, Oscar Salvador wrote:
>> On Fri, Feb 16, 2024 at 08:40:45PM +0900, Byungchul Park wrote:
>> > From 150af2f78e19217a1d03e47e3ee5279684590fb4 Mon Sep 17 00:00:00 2001
>> > From: Byungchul Park <byungchul@sk.com>
>> > Date: Fri, 16 Feb 2024 20:18:10 +0900
>> > Subject: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
>>
>> "do not try to promote folios to memoryless nodes"
>
>Thinking some more, promote might be misleading, just something like
>"do not try to migrate memory to memoryless nodes".

Yes. Does this also want an unlikely()? Not that it would be measurable.

>As this is not a bug fix but an optimization, as we will fail anyways
>in migrate_misplaced_folio() when migrate_balanced_pgdat() notices that
>we do not have any memory on that code.

This should be in the changelog and the subject is misleading as well.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>
>With the other comments addressed:
>
>Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
>>
>> because AFAICS we are just trying.
>> Even if should_numa_migrate_memory() returns true, I assume that we will
>> fail somewhere down the chain e.g: migrate_pages() when we see that this
>> node does not any memory, right?
>>
>> > A numa node might not have its local memory but CPUs. Promoting a folio
>> > to the node's local memory is nonsense. So avoid nodes not set N_MEMORY
>> > from getting promoted.
>>
>> If you talk about memoryless nodes everybody gets it better IMHO.
>> "Memoryless nodes do not have any memory to migrate to, so stop trying it."
>>
>>
>> > Signed-off-by: Byungchul Park <byungchul@sk.com>
>> > ---
>> >  kernel/sched/fair.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index d7a3c63a2171..7ed9ef3c0134 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -1828,6 +1828,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
>> >  	int dst_nid = cpu_to_node(dst_cpu);
>> >  	int last_cpupid, this_cpupid;
>> >
>> > +	/*
>> > +	 * A node of dst_nid might not have its local memory. Promoting
>> > +	 * a folio to the node is meaningless.
>> > +	 */
>> > +	if (!node_state(dst_nid, N_MEMORY))
>> > +		return false;
>>
>> "Cannot migrate to memoryless nodes"
>>
>> seems shorter and more clear.
>>
>> So, what happens when we return true here? will we fail at
>> migrate_pages() I guess? That is quite down the road so I guess
>> this check can save us some time.
>>
>>
>> --
>> Oscar Salvador
>> SUSE Labs
>>
>
>-- 
>Oscar Salvador
>SUSE Labs
>

