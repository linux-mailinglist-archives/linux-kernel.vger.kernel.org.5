Return-Path: <linux-kernel+bounces-32741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDC0835F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C621F230A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3DF3A1B7;
	Mon, 22 Jan 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iomb0HFD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+zUvxTMu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF83A1AE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918983; cv=none; b=Mt7nXZQ3A4l0JqZx9Jl0Wu5HGeV6MzeYJfj+ewwTYy3NJRr0w3kz21bcPz2u1CtorjhdFxAM2tMWK50AoA2Vu35gQUIZ4vz1pnGJcsbcnAn7lWTkHWb/7OeCNph35Yi1AU9kh18e1hFBTO6QifIdQnAxjvpzBQdB1eYFEiKdB8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918983; c=relaxed/simple;
	bh=/HVc2sROVltDLVMFLCM0/wdEy4aZkHopgYVU2TEqX7A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=tOms0cs8qF63J8A2/3R8G6fqmruPyr4HtJBsrjdbhmbhLNEX743lr3CTWW93Yy2qwe8ph/o/bh+Ail/9RyCvUJzc0qwRFso/Yev0m7oVCAjrXETOMb5AnSOfTEIyyYob5gnoAyPoHOZmn6dGjQUV6Y7hSDNmuU2f3DICtBLYXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iomb0HFD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+zUvxTMu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705918979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=2kiOCLBd1pSzhu9KU8byjsp15x5ZyvO1qTcLxCpdJ7o=;
	b=iomb0HFDAKHElrRkOf3GHsUiGVBSxv8G+Dz/Xbklr2ZUBXi3OZbilSevJLfsTVH4P3L7+S
	r/akpIleou1eYkEgzYziFJJtMkBeS7YC0crBWRRePw61zyZQWQNjMHQmgDWhNyR10nfwLv
	dusiveLQMy8O2A70plJOu+k1NPX5dhLqMdDboGcTzbWYfZ84J9xHcyMkqTcrodwVChGxGq
	kIT4wXLABYT8CJ5JmdZJzaAox01nyhlucBPLP8fbCiS+5jkH8C4LdYgI6U8v8bm3Pvolyg
	CPAhqApu8/37JvDqADyv4AT6Y9iPpIiOl89l233zhc9GZIEpM69A4mOPwGlwjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705918979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=2kiOCLBd1pSzhu9KU8byjsp15x5ZyvO1qTcLxCpdJ7o=;
	b=+zUvxTMuIkjo4w290zzQAfvwg5hAGsUF2QIV1s2A+VVOWiYuNRfHcOZE+amXfF3f06LELj
	P0TtgV9PaIT0P9Aw==
To: Pierre Gondois <pierre.gondois@arm.com>, Vincent Guittot
 <vincent.guittot@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/idle: Prevent stopping the tick when there is no
 cpuidle driver
In-Reply-To: <fcc07133-c43d-4423-bf92-b1d720c7e864@arm.com>
Date: Mon, 22 Jan 2024 11:22:59 +0100
Message-ID: <87y1chy8e4.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Pierre Gondois <pierre.gondois@arm.com> writes:
> On 1/15/24 14:29, Vincent Guittot wrote:
>> On Mon, 15 Jan 2024 at 13:40, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>>
>>> Hello Thomas,
>>>
>>> On 1/12/24 15:52, Thomas Gleixner wrote:
>>>> On Fri, Jan 12 2024 at 14:39, Pierre Gondois wrote:
>>>>> On 1/12/24 11:56, Anna-Maria Behnsen wrote:
>>>>>> Pierre Gondois <pierre.gondois@arm.com> writes:
>>>>>>> I agree that the absence of cpuidle driver prevents from reaching deep
>>>>>>> idle states. FWIU, there is however still benefits in stopping the tick
>>>>>>> on such platform.
>>>>>>
>>>>>> What's the benefit?
>>>>>
>>>>> I did the following test:
>>>>> - on an arm64 Juno-r2 platform (2 big A-72 and 4 little A-53 CPUs)
>>>>> - booting with 'cpuidle.off=1'
>>>>> - using the energy counters of the platforms
>>>>>      (the counters measure energy for the whole cluster of big/little CPUs)
>>>>> - letting the platform idling during 10s
>>>>>
>>>>> So the energy consumption would be up:
>>>>> - ~6% for the big CPUs
>>>>> - ~10% for the litte CPUs
>>>>
>>>> Fair enough, but what's the actual usecase?
>>>>
>>>> NOHZ w/o cpuidle driver seems a rather academic exercise to me.
>> 
>> Don't know if it's really a valid use case but can't we have VMs in
>> such a configuration ?
>> NOHZ enabled and no cpuidle driver as VM doesn't manage HW anyway ?
>
> Yes right,
> I tried with a kvmtool generated VM and it seemed to be the case:
>
> $ grep . /sys/devices/system/cpu/cpuidle/*
> /sys/devices/system/cpu/cpuidle/available_governors:menu
> /sys/devices/system/cpu/cpuidle/current_driver:none
> /sys/devices/system/cpu/cpuidle/current_governor:menu
> /sys/devices/system/cpu/cpuidle/current_governor_ro:menu
>

So it's not on me to decide whether it is valid to skip stopping the
tick in this setting or not. I observed this unconditional call (which
is not for free) on a fully loaded system which decreases performance.

If there is a reasonable condition that could be added for stopping the
tick, this might also be a good solution or even a better solution. But
only checking whether cpuidle driver is available or not and then
unconditionally stopping the tick, doesn't make sense IMHO.

Thanks,

	Anna-Maria


