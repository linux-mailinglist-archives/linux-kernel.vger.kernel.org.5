Return-Path: <linux-kernel+bounces-102577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A687B425
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B48B1F23037
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E98259B40;
	Wed, 13 Mar 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="M1jhLNkK"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E158359170
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367577; cv=none; b=c9rqNufid4wErqrsRImkHXCczco/y4d1VXn4b0pTYpOV9hotte50kWQT9pN3RPAB7V5PBPP8KA+99e5P+y6Qn/C5X1k477sCBHKqPRdQky7Z8WD+78ojGz8pNbrgliyzUeJn19TC3E7bwFIh6MVstt188xoy8+uUV/xcgQoYid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367577; c=relaxed/simple;
	bh=0MaLJL1WijJOeYVXEY05kGfs7njKM7mKQg7SdwLnCf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bW2fZMxhQenyJF0bkyfq2z4KGSm/ZMpbGVHXSkwzfghtD5xMjSB3FSpmC63n3Ilt6lj9W0zGgK7RV+zfaWaicPygnLl13AXO3Zakrug8MlzTeZq8r0CdoDe28nvo0EdQoNtX9RzCaXwnWuAKZZKozQiqtARuOT189oWCZPR43kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=M1jhLNkK; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1710367572;
	bh=0MaLJL1WijJOeYVXEY05kGfs7njKM7mKQg7SdwLnCf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M1jhLNkKmzBJTLHwSwhGlN9u7aXh1JpdjdAoMjeQn9C2kosnQ6bJnpvWWjXOQSCbx
	 LG/T525WVVmmWOmTZDPBj17YYnM50ERrsOqatAdFMKdf73c0IutjfR9f5pNPbQQ98R
	 R9G3Pj7LXqIvE2g3YAg35e9B/5Hiz3tz2Mi2DHV6KVNNSm+gmq4smR99nSLZNHdVrF
	 ERYmtcbQE4WF8WBAZniRhSuHs9OyBWuC3fpKlWMd2fBRrSXSBfgijKhlYJHmLrnsY1
	 N1Eg7jJnjp4UPjJx/cjUCcRX4P1uKvhgr+qJg0oys2wfQ/xwkc8Sr+iIRpbGiGGSld
	 9+6kJEO1wMgmA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tw4N42Y4Hzjnr;
	Wed, 13 Mar 2024 18:06:12 -0400 (EDT)
Message-ID: <6952b581-68d2-476b-9f7e-e9746c8c0473@efficios.com>
Date: Wed, 13 Mar 2024 18:06:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Introduce serialized smp_call_function APIs
Content-Language: en-US
To: Avi Kivity <avi@scylladb.com>, Peter Oskolkov <posk@google.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 Maged Michael <maged.michael@gmail.com>, gromer@google.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240313205622.2179659-1-mathieu.desnoyers@efficios.com>
 <7c1860d783e0f317160069bf77d8fafdf01a9f97.camel@scylladb.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <7c1860d783e0f317160069bf77d8fafdf01a9f97.camel@scylladb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-03-13 17:14, Avi Kivity wrote:
> On Wed, 2024-03-13 at 16:56 -0400, Mathieu Desnoyers wrote:
>> commit 944d5fe50f3f ("sched/membarrier: reduce the ability to hammer 
>> on sys_membarrier")
>> introduces a mutex over all membarrier operations to reduce its ability
>> to slow down the rest of the system.
>>
>> This RFC series has two objectives:
>>
>> 1) Move this mutex to the smp_call_function APIs so other system calls
>>    using smp_call_function IPIs are limited in the same way,
>>
>> 2) Restore scalability of MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ with
>>    MEMBARRIER_CMD_FLAG_CPU, which targets specific CPUs with IPIs.
>>    This may or may not be useful, and I would welcome benchmarks from
>>    users of this feature to figure out if this is worth it.
>>
>> This series applies on top of v6.8.
>>
> 
> 
> I see this doesn't restore scaling of MEMBARRIER_CMD_PRIVATE_EXPEDITED, 
> which I use (and wasn't aware was broken).

It's mainly a mitigation for IPI Storming: CVE-2024-26602 disclosed
as part of [1].

> 
> I don't have comments on the patches, but do have ideas on how to work 
> around the problem in Seastar. So this was a useful heads-up for me.

Note that if you don't use membarrier private expedited too heavily,
you should not notice any difference. But nevertheless I would be
interested to hear about any regression on performance of real
workloads resulting from commit 944d5fe50f3f.

Thanks,

Mathieu

[1] https://www.vusec.net/projects/ghostrace/



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


