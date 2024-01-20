Return-Path: <linux-kernel+bounces-31670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32359833254
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABAAFB22EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636A1368;
	Sat, 20 Jan 2024 01:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="T6jk3AnZ"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9067F7;
	Sat, 20 Jan 2024 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705715381; cv=none; b=Zf47WQZN31jZWpNx2OUxTzw7IzPZ0HWhhN56Cn6aSK8t5yXJeZBTiLBiPtaQPwHyMtJbq0PLOZjjq5A0hJ7e4hbzhn1Yyn/lk0V5PVR12zteOlWl/HOke9/uDaL5P+zg6jnwSpt0LWnFkow8G4NAkjf4NpGcDLtbITz1UARe3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705715381; c=relaxed/simple;
	bh=d9mI/KQX1XMqHS0cYDaVtEPXPFZBKln+2oLKApsh1g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFVy/6Q2/ow/86DHsLjV6+27oxR0gnVRNgYOMbKAlLZmhahoAR80+WJHW+r2MEPWOJ6gKIY5oymJd+EPswN5jo/I1dwjEyrcPje7Bp8HnGhvkY4NiIpmfMaYsp7y7TMunntiiJHdRZCD4oXb6zKx746mT3s5+20FNd62XJpdjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=T6jk3AnZ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1705715377;
	bh=d9mI/KQX1XMqHS0cYDaVtEPXPFZBKln+2oLKApsh1g4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T6jk3AnZRU8E8UAjcsHRUAqash+f0nH3ioBVsEdjw4zue0nC8V7lgHh14Stq2SaKv
	 0DFfpYz7Fo/o3KTLVCRYFmzYjpleFpFUMPH3L6qLHeDcJjIPbVCvCMHabA5xake3ol
	 qLrE9YVTpf+xIRRZFzl1ahG/7Im9FC4dgU2shzNhP/LEqsczGhnwttB+gJYuRYfoP9
	 ZXPfBAzzP5PPrhb5QHG75K7H/Oq6c+hZahQRJtCuVvzYbB5tYq14h5uUAOIoFLcz7R
	 Z+TMV2QgdY6uGOyomn+GcfFyxDV2uErVM8E7ldCHBMO25QbJo+rMtdcvxP3NVWsTQG
	 SOqkvkpUceERg==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TGztn1hlWzTVf;
	Fri, 19 Jan 2024 20:49:37 -0500 (EST)
Message-ID: <5d323a65-8a04-4c73-8702-58869982a269@efficios.com>
Date: Fri, 19 Jan 2024 20:49:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Simplify reservation with try_cmpxchg() loop
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Philippe Proulx <pproulx@efficios.com>
References: <20240118181206.4977da2f@gandalf.local.home>
 <504085e9-bf91-4948-a158-abae5dcb276a@efficios.com>
 <20240119103754.154dc009@gandalf.local.home>
 <cd3f37cc-31ba-4eb4-8d67-852d05570e7b@efficios.com>
 <20240119164252.54ccb654@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240119164252.54ccb654@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-19 16:42, Steven Rostedt wrote:
> On Fri, 19 Jan 2024 15:56:21 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> So when an overflow happens, you just insert a timestamp, and then events
>>> after that is based on that?
>>
>> No. Let's use an example to show how it works.
>>
>> For reference, LTTng uses 5-bit for event ID and 27-bit for timestamps
>> in the compact event header representation. But for the sake of making this
>> discussion easier, let's assume a tracer would use 16-bit for timestamps in the
>> compact representation.
>>
>> Let's say we have the following ktime_get() values (monotonic timestamp value) for
>> a sequence of events:
>>
>>                                     Timestamp (Hex)    Encoding in the trace
>>
>> Packet header timestamp begin     0x12345678         64-bit: 0x12345678
>>
>> Event 1                           0x12345678         16-bit: 0x5678
>>      (When decoded, same value as previous timestamp, no overflow)
>> Event 2                           0x12347777         16-bit: 0x7777
>>      (When decoded, going from "0x5678" to "0x7777" does not overflow 16-bit)
>> Event 3                           0x12350000         16-bit: 0x0000
>>      (When decoded, going from "0x7777" to "0x0000" overflow 16-bit exactly once
>>       which allows the trace reader to reconstruct timestamp 0x12350000 from the
>>       previous timestamp and the 16-bit timestamp encoding.)
>> Event 4                           0x12370000         64-bit: 0x12370000
>>      (Encoding over 16-bit not possible because going from 0x12350000 to
>>       0x12370000 would overflow 16-bit twice, which cannot be detected
>>       by a trace reader. Therefore use the full 64-bit timestamp in the
>>       "large" event header representation.)
> 
> I think that's basically what I said, but you are just looking at it
> differently ;-) Or should I say, you are using bits for optimization.

Based on your explanation below, we are really talking about different things
here. Let me try to reply to your explanation to try to show where what I am
doing completely differs from what you have in mind. This will help explain
how I handle 16-bit overflow as well.

> The events are based off of the last injected timestamp.

Incorrect. There is no "injected timestamp". There is only a concept
of the "current timestamp" as we either write to or read from the
event stream. I will take the point of view of the trace reader for
the rest of the discussion.

> The above example,
> starts with an timestamp injection into the packet header: 0x12345678, with
> the lsb 16bits ignore.

Wrong again. The 16 least significant bits are not ignored. The "current timestamp"
is really 0x12345678 when the packet header is read.

> So in actuality, it inserts 0x12340000, plus adds a
> 5678 that represents the creation of the header (like we discussed about in
> the last tracing meeting).

There is no "0x12340000" reference time. There is only the actual 0x12345678
current time at packet begin, including those 16 low order bits.

> 
> The first event has: 0x5678 which is based on the previous injected
> timestamp of 0x12340000.

It is not "based" on the previous injected timestamp. It just represents
the low-order 16-bits of the timestamp at event 1. The trace readers takes
two informations to compute the complete current timestamp for event 1:

1) The current timestamp just before event 1 is read (0x12345678),
2) The low-order 16 bits of event 1 (0x5678).

Given that there is no 16-bit overflow when comparing:

0x12345678 & 0xFFFF and 0x5678

We know that the resulting current timestamp for event 1 is:

(0x12345678 & ~0xFFFF) + 0x5678 = 0x12345678

Or basically that time did not move between the packet header and event 1.

> 
> the events go on just using a delta from that until you see it overflow (or
> too big of a delta to fit in the 16 bits), and you insert a new full
> timestamps that everything will be based on:
> 
>    0x12370000

No. The following events use the same algorithm I just described: They use
this notion of "current timestamp" and the information provided by the new
timestamp field in the event header to figure out the updated current timestamp.

It is _never_ based on some kind of arbitrary reference, it is always absolute,
and is always computed based on the current timestamp and the timestamp field
encountered.

> 
> Now events following that are just a delta from that timestamp. But you
> calculate the delta simply by masking out the lower bits.

No, again, there is no delta from arbitrary injected time. It's always
computed from this virtual "current time", which applies to an event stream.

> 
> But how do you detect the overflow? That last timestamps to know if the tsc
> overflowed or not needs to be saved and compared. I would assume you have a
> similar race that I have.

Yes, I save a "last timestamp" per buffer, but the race does not matter because
of the order in which it is saved wrt local cmpxchg updating the reserved position.

The algorithm looks like:

do {
   - read current reserved position (old pos)
   - read time
   - compute new reserved position (new pos)
} while (cmpxchg(reserved pos, old pos, new pos) != old pos);

[A]

save_last_tsc()

If interrupted at [A] by another trace producer, it will compare with an
older "last tsc" than the tsc of the event physically located just before
the nested event. This stale "last tsc" has a value which is necessarily
lower than the one we would be saving with the save_last_tsc immediately
afterwards, which means in the worse case we end up using a full 64-bit
timestamp when in fact we could use a more compact representation. But
this race is rare and therefore it does not matter for size.

The fact that I only need this last_tsc value for the sake of optimization,
and not for computation of a time delta from a previous injected timestamp,
makes it possible to handle the race gracefully without requiring anything
more than a single last_tsc value per buffer and a single comparison for
16-bit overflow.

> 
>>
>>>    
>>>>
>>>> The fact that Ftrace exposes this ring buffer binary layout as a user-space
>>>> ABI makes it tricky to move to the Common Trace Format timestamp encoding.
>>>> There are clearly huge simplifications that could be made by moving to this
>>>> scheme though. Is there any way to introduce a different timestamp encoding
>>>> scheme as an extension to the Ftrace ring buffer ABI ? This would allow us to
>>>> introduce this simpler scheme and gradually phase out the more complex delta
>>>> encoding when no users are left.
>>>
>>> I'm not sure if there's a path forward. The infrastructure can easily swap
>>> in and out a new implementation. That is, there's not much dependency on
>>> the way the ring buffer works outside the ring buffer itself.
>>>
>>> If we were to change the layout, it would likely require a new interface
>>> file to read. The trace_pipe_raw is the only file that exposes the current
>>> ring buffer. We could create a trace_out_raw or some other named file that
>>> has a completely different API and it wouldn't break any existing API.
>>
>> Or introduce "trace_pipe_raw2" or some kind of versioned file names as new
>> ABIs.
> 
> I hate "version numbers" ;-)  I would rather have a meaning name instead.
> 
> "trace_pipe_raw_ts_delta" or something that gives a hint to why it's
> different.

It's just that as it evolves and more changes are integrated, you may end
up with "trace_pipe_raw_featureA_featureB_featureC", which is also inconvenient.

> 
>>
>>> Although, if we want to change the "default" way, it may need some other
>>> knobs or something, which wouldn't be hard.
>>
>> The delta-timestamp-encoding would have to stay there for a while as long
>> as users have not switched over to trace_pipe_raw2. Then when it's really
>> gone, the trace_pipe_raw could either go away or return an error when
>> opened.
>>
>>> Now I have to ask, what's the motivation for this. The code isn't that
>>> complex anymore. Yes it still has the before/after timestamps, but the
>>> most complexity in that code was due to what happens in the race of
>>> updating the reserved data. But that's no longer the case with the
>>> cmpxchg(). If you look at this patch, that entire else statement was
>>> deleted. And that deleted code was what made me sick to my stomach ;-)
>>> Good riddance!
>>
>> The motivation for this would be to further simplify the implementation
>> of __rb_reserve_next(), rb_add_timestamp(), and rb_try_to_discard(), and
>> remove a few useless loads, stores, and conditional branches on the fast-path
>> of __rb_reserve_next(). This would turn the before/after timestamp
>> stores/loads/comparisons into a simple "last timestamp" field and a comparison
>> of the current timestamp against the "last timestamp" value to figure out
>> whether the compact representation can be used.
>>
>> I don't know whether it's worth the trouble or not, it's really up to you. :)
> 
> Yeah, making such a change would require an analysis to know if it would
> speed things up enough to make a significant difference to do that effort.

I would also consider reducing code complexity as a worthwhile metric in
addition to speed. It makes it easier to extend in the future, easier to
understand for reviewers, and subtle bugs are less likely to creep in.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


