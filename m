Return-Path: <linux-kernel+bounces-73357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199585C165
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DD7B21710
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0428763E8;
	Tue, 20 Feb 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VIcAevZM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVouwBFZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98B67C4D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446574; cv=none; b=bfkoxQCfEHxqOCsKICQqWW4vd8wiWJQRGw973A0EPFxVpL/nfZUZvw847Cha9o+Bgru+UAYRqZ2BMAXjft8UAW43Jiqxp5hd1pAwS/VQcCm91XIR5N0HuJttnBzE+ax1ls7jjfWSklwltkxX5/E2yDFxHClxnJO289EEWGdguKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446574; c=relaxed/simple;
	bh=G//O48lj/o6qEVj46+ng5J07Z8+VCB5i+gnKDaQ25Ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V1Afohv3byA5vKSuVGLYR4EvWT7HJcLLtfxn6R9tbqdZacKFaCUyJR0CTW3B5S4vytfGCVyFeLxjSNKaNIHHEOISlpe02rihAPZjHN6BtiRsehiVzsISQM2k+XvvM1kqjqOQc0jyfiXMZFc/stMAFghifkLi0Q8YCJIXsgIv4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VIcAevZM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVouwBFZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708446570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFtBnVpmjj9QkVhwE8uoha4NhmQA+CgIGJamwL8qgPE=;
	b=VIcAevZM5aOKUM0T8NdB25zrY4LPvy6M6cEgR/BSAivw6gX5b5H684ZoKocl3bvWCDphiM
	wk4ubvUiBIG0+QZE5K8YUgwTVVCVlpOldoPR6OXDyadJD2+afVOMGPZmosfiwBKBhRBY2h
	HGrzDiliJ2G4RaBo7d4m9HXOWIp81ICSYr9TPAvV76pzFFEOeRmkuI689k9v6nRVvjxdg1
	rqOfYfBKPuzq+EAnng2f0ak1uYT04bZ5NUYVo3S7KcptcYK9oT/NqDgGMvYK0ENjpuZdc1
	/xNWX/G46Jk1VFTopEggDGTamDqPY8TDVEG0/EiXLHlB0QIqkIy2BV/u1kA0XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708446570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QFtBnVpmjj9QkVhwE8uoha4NhmQA+CgIGJamwL8qgPE=;
	b=GVouwBFZSqs+wk1Po3fIqWjzdPRkESw2E3TW8nvUoVbR1H+lO4jqT/9xPbhMq7ilDKDh2K
	RpM+svaX7YiLIyDA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 06/26] printk: nbcon: Ensure ownership release
 on failed emit
In-Reply-To: <ZdTCZqhZww8_WgSU@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-7-john.ogness@linutronix.de>
 <ZdTCZqhZww8_WgSU@alley>
Date: Tue, 20 Feb 2024 17:35:08 +0106
Message-ID: <87o7cbgkvf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-20, Petr Mladek <pmladek@suse.com> wrote:
>> Until now it was assumed that ownership has been lost when the
>> write_atomic() callback fails. And nbcon_emit_next_record()
>> directly returned false. However, if nbcon_emit_next_record()
>> returns false, the context must no longer have ownership.
>> 
>> The semantics for the callbacks could be specified such that
>> if they return false, they must have released ownership. But
>> in practice those semantics seem odd since the ownership was
>> acquired outside of the callback.
>> 
>> Ensure ownership has been released before reporting failure by
>> explicitly attempting a release. If the current context is not
>> the owner, the release has no effect.
>
> Hmm, the new semantic is not ideal either. And I think that it is
> even worse. The function still releases the owership even though
> it has been acquired by the caller. In addition, it causes
> a double unlock in a valid case. I know that the 2nd
> nbcon_context_release() is a NOP but...
>
> I would personally solve this by adding a comment into the code
> and moving the check, see below.
>
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -891,17 +891,18 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>>  	nbcon_state_read(con, &cur);
>>  	wctxt->unsafe_takeover = cur.unsafe_takeover;
>>  
>> -	if (con->write_atomic) {
>> +	if (con->write_atomic)
>>  		done = con->write_atomic(con, wctxt);
>> -	} else {
>
> 	This code path does not create a bad semantic. The semantic is
> 	as it is because the context might lose the ownership in "any"
> 	nested function.
>
> 	Well, it might deserve a comment, something like:
>
> 		/*
> 		 * nbcon_emit_next_record() should never be called for legacy
> 		 * consoles. Handle it as if write_atomic() have lost
> 		 * the ownership and try to continue.
> 		 */
>> -		nbcon_context_release(ctxt);
>> -		WARN_ON_ONCE(1);
>> -		done = false;
>> -	}
>>  
>> -	/* If not done, the emit was aborted. */
>> -	if (!done)
>> +	if (!done) {
>> +		/*
>> +		 * The emit was aborted, probably due to a loss of ownership.
>> +		 * Ensure ownership was lost or released before reporting the
>> +		 * loss.
>> +		 */
>
> Is there a valid reason when con->write_atomic() would return false
> and still own the context?

This is driver code, so you must use your imagination. But I thought
maybe there might be some reason why the driver cannot print the message
(due to other driver-internal reasons). In this case, it would return
false even though it never lost ownership.

> If not, then this would hide bugs and cause double unlock in
> the valid case.

Even if true is returned, that does not mean that there is still
ownership (because it can be lost at any time). And even if we hit the
WARN because there is no callback, ownership may have been lost. My
point is that there is _always_ a chance that nbcon_context_release()
will be called when ownership was already lost.

nbcon_context_release() was purposely implemented with the idea that it
may be called by a context that has lost ownership. So why not leverage
this here? It is _critical_ that if _this_ function returns false, the
context no longer has ownership.

We could add a nbcon_can_proceed() in front of the release, but
nbcon_context_release() already does that internally.

>> +		nbcon_context_release(ctxt);
>>  		return false;
>
> Even better solution might be to do the check at the beginning of
> the function. It might look like:
>
> 	  if (WARN_ON_ONCE(!con->write_atomic)) {
> 		/*
> 		 * This function should never be called for legacy consoles.
> 		 * Handle it as if write_atomic() have lost the ownership
> 		 * and try to continue.
> 		 */
> 		nbcon_context_release(ctxt);
> 		return false;
> 	}

In the future, con->write_thread() is added. So the missing callback
check will end up in a final else branch anyway.

John

