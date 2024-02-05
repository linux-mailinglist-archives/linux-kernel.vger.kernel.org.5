Return-Path: <linux-kernel+bounces-52785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E5849CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2206B2812EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D5F2C1A7;
	Mon,  5 Feb 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UffIKMlp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ondMAL/L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE6324B21
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142106; cv=none; b=eim7gEv/hm5z+sY4mzqvLmJEhSHorY8c02pS2Xmf7KGh+5YxfybLpM7P95/wBO+L8/oG0srwzmCuV8YLpnqiuXVI1f5LoNtWNlkx/ZRVbVitV8AVl832/R97vD3V1oq6J2npjj9FKwYBhTaecTWvcYqk8mnheCwFq+B85JjHmDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142106; c=relaxed/simple;
	bh=HqM2vJY5GJ801X8lGG+PB0sq+iCvQSZKru2IVL5toUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D1PLE648J7pbKEhdSrm473JrS3Iy26dX6F2OFAJIBLqXLz6/sE5kriRXbvH6BoQYlQtXakyrp9pm357zMU1XOdnsLLGWsrp1IDvwoH/rSxMwoinZiTJ5tJeBbJ4dB+UHQ/JQNbQ/VQODGeVtMaRjlPPMcoTnDyxe9V8anfu5A8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UffIKMlp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ondMAL/L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707142102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7dCQi4yvempepyF9CUt7hpi4oyUO/J7MLUWt7pZTMk=;
	b=UffIKMlpt7mrjscUAPfx9O8TAUyxVTxG0kElR5NBlMTAPdRieebK0pVueYUVl/BAejlFE8
	oUmOy9L8dXVrFFVdjNVzjKjDRxi4IC9qgaG0ix4HrsFMSIxa6ENAdk96aat9ozg3avS0ak
	BAT3LRzxnX7y8OLLKScawgp8YPg1p9XyBiYGB6eE2lvaWmPHi2CnQzS5UoBiNjZZKkF6Kt
	HMgVGPSbqWXpMpC9cZ+yFuQPtSUyUigb82+oOaj+BNPLF77doc5Xii7Vs6ODFs3toI24rA
	XAx4iURyqt+HFCjTPbIcZqt7SjgK7CYT0JdN36DcvkLW/qRDtYaCoQSv9XFORw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707142102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i7dCQi4yvempepyF9CUt7hpi4oyUO/J7MLUWt7pZTMk=;
	b=ondMAL/Lp9qmYk7aLphYDsoPfiz95FHxTNIOs1CqOiF4dKT0tr+7Nr1GpXajTULGimAZQN
	2eaU7lBOz6Gpr3Dg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 11/14] printk: ringbuffer: Consider committed
 as finalized in panic
In-Reply-To: <ZbvcJwsIEsii3oi2@alley>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-12-john.ogness@linutronix.de>
 <ZbvcJwsIEsii3oi2@alley>
Date: Mon, 05 Feb 2024 15:14:14 +0106
Message-ID: <87v873ngvl.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-02-01, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2023-12-14 22:47:58, John Ogness wrote:
>> A descriptor in the committed state means the record does not yet
>> exist for the reader. However, for the panic CPU, committed
>> records should be handled as finalized records since they contain
>> message data in a consistent state and may contain additional
>> hints as to the cause of the panic.
>> 
>> Add an exception for records in the commit state to not be
>> considered non-existing when reading from the panic CPU.
>
> IMHO, it is important to describe effects of this change in more
> details. And I think that it actually does not work as expected,
> see below.

I reviewed my notes from our meeting in Richmond. We had agreed that
this feature should not apply to the latest message. That would change
the commit message to be as follows:

    printk: ringbuffer: Consider committed as finalized in panic
    
    A descriptor in the committed state means the record does not yet
    exist for the reader. However, for the panic CPU, committed
    records should be handled as finalized records since they contain
    message data in a consistent state and may contain additional
    hints as to the cause of the panic.
    
    The only exception is the last record. The panic CPU may be
    usig LOG_CONT and the individual pieces should not be printed
    separately.
    
    Add a special-case check for records in the commit state to not
    be considered non-existing when reading from the panic CPU and
    it is not the last record.

>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1875,16 +1877,25 @@ static int desc_read_finalized_seq(struct prb_desc_ring *desc_ring,
>>  
>>  	/*
>>  	 * An unexpected @id (desc_miss) or @seq mismatch means the record
>> -	 * does not exist. A descriptor in the reserved or committed state
>> -	 * means the record does not yet exist for the reader.
>> +	 * does not exist. A descriptor in the reserved state means the
>> +	 * record does not yet exist for the reader.
>>  	 */
>>  	if (d_state == desc_miss ||
>>  	    d_state == desc_reserved ||
>> -	    d_state == desc_committed ||
>>  	    s != seq) {
>>  		return -EINVAL;
>>  	}
>>  
>> +	/*
>> +	 * A descriptor in the committed state means the record does not yet
>> +	 * exist for the reader. However, for the panic CPU, committed
>> +	 * records are also handled as finalized records since they contain
>> +	 * message data in a consistent state and may contain additional
>> +	 * hints as to the cause of the panic.
>> +	 */
>> +	if (d_state == desc_committed && !this_cpu_in_panic())
>> +		return -EINVAL;

And this code would change to:

+	/*
+	 * A descriptor in the committed state means the record does not yet
+	 * exist for the reader. However, for the panic CPU, committed
+	 * records are also handled as finalized records since they contain
+	 * message data in a consistent state and may contain additional
+	 * hints as to the cause of the panic. The only exception is the
+	 * last record, which may still be appended by the panic CPU and so
+	 * is not available to the panic CPU for reading.
+	 */
+	if (d_state == desc_committed &&
+	    (!this_cpu_in_panic() || id == atomic_long_read(&desc_ring->head_id))) {
+		return -EINVAL;
+	}

> If I get it correctly, this causes that panic CPU would see a
> non-finalized continuous line as finalized. And it would flush
> the existing piece to consoles.
>
> The problem is that pr_cont() would append the message into
> the same record. But the consoles would already wait
> for the next record. They would miss the appended pieces.

Exactly. That is why we said that the last message would not be
available. Maybe this new version is acceptable.

> Honestly, I think that it is not worth the effort. It would add
> another complexity to the memory barriers. The real effect is not easy
> to understand. And the benefit is minimal from my POV.

I am OK with dropping this patch from the series. It is questionable how
valuable a LOG_CONT piece from a non-panic CPU is anyway. And if the
non-panic CPU managed to reopen the record, it would be skipped anyway.

I will drop this patch unless you want to keep the new version.

John

