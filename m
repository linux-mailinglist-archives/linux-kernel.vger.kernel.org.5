Return-Path: <linux-kernel+bounces-31271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7AF832B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C9AB23F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024A854BCA;
	Fri, 19 Jan 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="r9plyTna"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB5A5479F;
	Fri, 19 Jan 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675723; cv=none; b=joNJEEXBAOJKZa7Bi7I3zeHkMS3pDy7XewFfW0vPUlIqj38+RrJnyzDnOG6AbR8LSAV0enFRga2EaKQaLF4FniUHKFYYegMakCunO8sAkbHttTGGc9OqfC4zXAsEDufNJpv0cQZ0n06v2vpP+9XDg9qhJpB1Z81piWgDLxJ3KKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675723; c=relaxed/simple;
	bh=N5dxDJ8RBtd+2+qEyuvlZWxCpwk9SOuLxT5zchJWh7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dtzIHl/RXVU9uF7rVI3EMgT1ARNg6YFOPGCLHw9mm5jslfR0PG1A9LurZNuGxch+ItjPgeAooVGJOq96m2m5EWxGA+7qLvTzYZWdv/7L/mCg77ca8RC6WQj9bJ1+B1VO4bHwToth1PcUoXK79mo5TCJ82sjYtjLkkdSq7ZnRQM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=r9plyTna; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1705675228;
	bh=N5dxDJ8RBtd+2+qEyuvlZWxCpwk9SOuLxT5zchJWh7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r9plyTnaRfggs+rIScfK287Oih516Dx4TkppuV/JDCfjQgfyAWermTZsR6ZAya2I3
	 wb7GRgjVdaKxlW/znjeJ5wNYkW/xctA0PBxSyoKF7K8ZnDKJ0Z94bgR3sXuN/Wyehe
	 pGKCj8O4Ni1XC3yW8qjbnGfoNlVJ7A3OyZc6KO2mYfVsc13zsnUGCOotrYsty1jDIs
	 JubAZi/oeqJrhw5fV4cn4GKIw/pmieaUx8olcVyqP/AVP7RARW7yYzKsU0A3bzFcka
	 9/zhEecxDz478X7pB/3IzgZ73vyC72Jm/IxdTE5galtiE+s88ydg67OvdqAvfbNz8V
	 MVqpTQRjAgTKw==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TGj2h3Lv2zLdp;
	Fri, 19 Jan 2024 09:40:28 -0500 (EST)
Message-ID: <504085e9-bf91-4948-a158-abae5dcb276a@efficios.com>
Date: Fri, 19 Jan 2024 09:40:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Simplify reservation with try_cmpxchg() loop
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20240118181206.4977da2f@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240118181206.4977da2f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-18 18:12, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Instead of using local_add_return() to reserve the ring buffer data,
> Mathieu Desnoyers suggested using local_cmpxchg(). This would simplify the
> reservation with the time keeping code.

I admire the effort of trying to simplify the Ftrace ring buffer by bringing
over ideas that worked well for LTTng. :-) As reviewer of the tracing subsystem,
I certainly welcome the simplifications.

> Although, it does not get rid of the double time stamps (before_stamp and
> write_stamp), using cmpxchg() does get rid of the more complex case when
> an interrupting event occurs between getting the timestamps and reserving
> the data, as when that happens, it just tries again instead of dealing
> with it.

I understand that the reason why you need the before/after stamps and their
associated complexity is because the Ftrace ring buffer ABI encodes event
timestamps as delta from the previous event within the buffer as a mean of
compressing the timestamp fields. If the delta cannot be represented in a
given number of bits, then it inserts a 64-bit timestamp (not sure if that
one is absolute or a delta from previous event).

This timestamp encoding as delta between events introduce a strong
inter-dependency between consecutive (nested) events, and is the reason
why you are stuck with all this timestamp before/after complexity.

The Common Trace Format specifies (and LTTng implements) a different way
to achieve the same ring buffer space-savings achieved with timestamp deltas
while keeping the timestamps semantically absolute from a given reference,
hence without all the before/after timestamp complexity. You can see the
clock value decoding procedure in the CTF2 SPEC RC9 [1] document. The basic
idea on the producer side is to record the low-order bits of the current
timestamp in the event header (truncating the higher order bits), and
fall back on a full 64-bit value if the number of low-order bits overflows
from the previous timestamp is more than 1, or if it is impossible to figure
out precisely the timestamp of the previous event due to a race. This achieves
the same space savings as delta timestamp encoding without introducing the
strong event inter-dependency.

The fact that Ftrace exposes this ring buffer binary layout as a user-space
ABI makes it tricky to move to the Common Trace Format timestamp encoding.
There are clearly huge simplifications that could be made by moving to this
scheme though. Is there any way to introduce a different timestamp encoding
scheme as an extension to the Ftrace ring buffer ABI ? This would allow us to
introduce this simpler scheme and gradually phase out the more complex delta
encoding when no users are left.

Thoughts ?

Thanks,

Mathieu

[1] https://diamon.org/ctf/files/CTF2-SPECRC-9.0.html#clk-val-update

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


