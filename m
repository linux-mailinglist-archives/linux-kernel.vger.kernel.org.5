Return-Path: <linux-kernel+bounces-94906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE0874689
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253081F243ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559A10A05;
	Thu,  7 Mar 2024 03:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UbebClws"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E86CA62;
	Thu,  7 Mar 2024 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780777; cv=none; b=FLBsXUKHf0JXLMyxwvh59VUKihCC5H05KAgGUhnRVbwqHyFjSqEus0N4IQl5YzBqxVtILV1oBhhuoO9XsvQexeWPTi807xYRAwXgherG19qwMq1HPdmWK3GgZnqb8O/rGp5ys75ogYeHGgmBqWoB4nKc10czZgmmpcH2CqCig+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780777; c=relaxed/simple;
	bh=9mP0EJZ5E3oSsjpDu7iTl0ddJg7+xj8Uhkioumdgbps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdllFLndJrtju6l34c1lNGZNKu4GGRY8s4mekCbAUvsXv7yoPS9UhOPPGxY5TtKl4ZPs/s4ywqKPHf3ADS8u27zcyMEOClJKaE9UzAyIB5BKJE+n3sdrQ34RKTcGv9wYaADJo/M6kh5OyQlI56MepGKtg9N7+eBDnaUnIwyBCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UbebClws; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1709780773;
	bh=9mP0EJZ5E3oSsjpDu7iTl0ddJg7+xj8Uhkioumdgbps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UbebClwsLIxdCMMqed0pnzib3A4ttXjas8h8rvHYyJqNJIYheJgbGnTOMOSfCg9tA
	 6zDCypsBDGj761BVI7yGg7yQFPr0NGM+YB6TtUS8zRCa9LOrUESrJ5FF+6sV5W91ag
	 vxwhIqJyHSAEZs87VrleunK51fLqLsVnzToddllU3mHFbczMhF2QdD1ofpcqGePecq
	 N4Gi/offJnzTcRRwxYdMu1g8FhvNkgK6wdvkPGMkTxnD/0yeYK2anZ4TzGkAWdtCq7
	 So/s6vPP6ZoT7xXT9X7YL5uMac/PRmwUw8uy9X7p5elN0oD8ZvaC+ESjlAsztPyKg5
	 m7vLn3uZE/BAg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TqvMS6c9BzgSw;
	Wed,  6 Mar 2024 22:06:12 -0500 (EST)
Message-ID: <851dc594-d2ea-4050-b7c6-e33a1cddf3a1@efficios.com>
Date: Wed, 6 Mar 2024 22:06:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcutorture: Fix
 rcu_torture_pipe_update_one()/rcu_torture_writer() data race and concurrency
 bug
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, linke li <lilinke99@qq.com>,
 joel@joelfernandes.org, boqun.feng@gmail.com, dave@stgolabs.net,
 frederic@kernel.org, jiangshanlai@gmail.com, josh@joshtriplett.org,
 linux-kernel@vger.kernel.org, qiang.zhang1211@gmail.com,
 quic_neeraju@quicinc.com, rcu@vger.kernel.org
References: <f3624f39-bbb1-451d-8161-8518e4108d8e@joelfernandes.org>
 <tencent_9882B228F292088CDD68F10CF1C228742009@qq.com>
 <20240306103719.1d241b93@gandalf.local.home>
 <27665890-8314-4252-8622-1e019fee27e4@paulmck-laptop>
 <20240306130103.6da71ddf@gandalf.local.home>
 <CAHk-=wgG6Dmt1JTXDbrbXh_6s2yLjL=9pHo7uv0==LHFD+aBtg@mail.gmail.com>
 <20240306135504.2b3872ef@gandalf.local.home>
 <CAHk-=wjbDgMKLgxbV+yK4LKZ+2Qj6zVL_sHeb+L9KDia980Q8Q@mail.gmail.com>
 <20240306142738.7b66a716@rorschach.local.home>
 <CAHk-=wgPAZ4KnCQergqAOUypwinYh=gZ0q4EQbwvuUcJ_8UK+Q@mail.gmail.com>
 <83b47424-e5e0-46de-aa63-d413a5aa6cec@paulmck-laptop>
 <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wiX_zF5Mpt8kUm_LFQpYY-mshrXJPOe+wKNwiVhEUcU9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-06 21:43, Linus Torvalds wrote:
[...]
> 
> Honestly, this all makes me think that we'd be *much* better off
> showing the real "handoff" with smp_store_release() and
> smp_load_acquire().

We've done something similar in liburcu (userspace code) to allow
Thread Sanitizer to understand the happens-before relationships
within the RCU implementations and lock-free data structures.

Moving to load-acquire/store-release (C11 model in our case)
allowed us to provide enough happens-before relationship for
Thread Sanitizer to understand what is happening under the
hood in liburcu and perform relevant race detection of user
code.

As far as the WRITE_ONCE(x, READ_ONCE(x) + 1) pattern
is concerned, the only valid use-case I can think of is
split counters or RCU implementations where there is a
single updater doing the increment, and one or more
concurrent reader threads that need to snapshot a
consistent value with READ_ONCE().

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


