Return-Path: <linux-kernel+bounces-102636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D687B528
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CE23B225A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30B5D734;
	Wed, 13 Mar 2024 23:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TCBS+aCQ"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6A5D724
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372282; cv=none; b=QUlND8/mlclXjXTCJobDh3ao3g7rQcNaftyzWfqCgXASqon/oYsaw0FUOYwQb5h5s/N91c0rIv1dyYwXpyTWJoC8SOJKxIhaGe9X4IvTHRUX+YKb9oPBZrKNarXG/7U0d1SuVHjLCjqPqo2WxhDdGuHBJ0KSVwLnoRJsgctphFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372282; c=relaxed/simple;
	bh=HKyUwew810z+LaXSBYXDklPZLMcXYEepc/mtYjT8i2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9PAzBSwGRdh30wQdoYfm7Qaf1o3ipeUgv77eS5SAlXY8vpRXfHpDCTiWAkkiKEN5Il98TJCU1o5KjpYsWMfLvOwzCLUOXXhhDXmYrIue8AQrNqRCrxptvlIqYToSDsOYb0YdPFW7/rgJGdSZ4nCd+b3rK7vv6P3MauGIpwmdCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TCBS+aCQ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1710372275;
	bh=HKyUwew810z+LaXSBYXDklPZLMcXYEepc/mtYjT8i2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TCBS+aCQYGgS3gC+Ki41nQJO4zxg6uQPSswbzaNoPTgpUCUlRv5c/TeC9zS38FDDQ
	 2n/IphpS4HGVoDbxePU3oyPpwKIGkNzZZAjqxBicnCcjrAI3AuC368t2xB3hNvKLQr
	 emhIB87ZUfGHemL7vbSGH4YGlmF2k/ICd8Pq4JgD7ioMnxiu2UfUUOJTeeerdv3s3U
	 c2+u8L0i4JAeo+6hGe3PiyF5HuQxLYL4ZV9MtEDu/ESGduNRghYRyewy906+zuqaYe
	 TRfjYEF1htGgn9d7TA8eKTpcEw4LqY0tyeUnpB68FI/V2z9IVs22iMpq7p0vXcqBhP
	 DdW3eK+BPAP/g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Tw66W60PkzjcJ;
	Wed, 13 Mar 2024 19:24:35 -0400 (EDT)
Message-ID: <65d88186-7975-46ff-aef9-3b3a34f8e97a@efficios.com>
Date: Wed, 13 Mar 2024 19:24:49 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] smp: Implement serialized smp_call_function APIs
Content-Language: en-US
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Peter Oskolkov <posk@google.com>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 Maged Michael <maged.michael@gmail.com>, gromer@google.com,
 Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20240313205622.2179659-1-mathieu.desnoyers@efficios.com>
 <20240313205622.2179659-2-mathieu.desnoyers@efficios.com>
 <CAHk-=wj5rEZFvaLgs-ZtsCX9++mFNYKox21SBfF8vrSQG4WbPA@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=wj5rEZFvaLgs-ZtsCX9++mFNYKox21SBfF8vrSQG4WbPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-13 17:19, Linus Torvalds wrote:
> On Wed, 13 Mar 2024 at 13:56, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Introduce serialized smp_call_function APIs to limit the number of
>> concurrent smp_call_function IPIs which can be sent to a given CPU to a
>> maximum of two: one broadcast and one specifically targeting the CPU.
> 
> So  honestly, with only one user, I think the serialization code
> should be solidly in that one user, not in kernel/smp.c.

Good point, unless other users of this show up, I could move it
into membarrier.c. But only if anyone cares enough to come up
with benchmarks justifying the added complexity.

> 
> Also, this kind of extra complexity does require numbers to argue for it.

Of course,

Thanks,

Mathieu

> 
>               Linus

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


