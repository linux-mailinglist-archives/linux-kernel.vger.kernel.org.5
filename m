Return-Path: <linux-kernel+bounces-145328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13F8A52D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AAB282988
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4600274C1B;
	Mon, 15 Apr 2024 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z9l1Q5Gq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/MHEA5ux"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032DB745C9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190540; cv=none; b=UvD7z1YmHH2QNbkBhSUPMjR+5+rn2asqCnV82mIppfH947387gmzJ4P00X+ISYjjfWbhhlZExOpX3WG/VmsJiT/tjT+k4unnoxkbp94o5O5WVEyAI9aCARJZfsnRUhFBH36u3Bf4oJ4tpG4ZfQbQDYBEotOOqWdtE00+myAQqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190540; c=relaxed/simple;
	bh=cjV08SRv2E8lVxHe/9QLozU/asPpH9Ux3oisMF5kEj4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=eNKeVg114TjU+5K+EcDiw/SxbaObDovEQ6uk0aSrxXjmAF49Sug3uiU+aK6iupO2JrmIIS8Bhk2JYbZVoHUqyj2mAm9TcFI2kwrwlgt/IQG9pgxur1HX30tTrJMJvxWfa4xC2rZm/QSuT86CHKxfWaZpvAO6v7ahE1MYNiR75cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z9l1Q5Gq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/MHEA5ux; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713190535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=h6yFM9pgd0whttYbjAZoTcp9eapZWoc7Vu1vmPJ3kHs=;
	b=Z9l1Q5GqxNi1rg9cmNKsTNq53wlwhNh9UonWGMtFn4xtvTVtZFLz+kondQcjSZ917HZRlL
	eh4bvISe/ajz6HtoTgVrq8ssr8xD8wmG9CsPZPmN7Od5PdeORjD5JY6O2rXtsf19OddiU3
	gZs6fns5oLmgLRl+/T+uFCSWzhJSTtnQ10QFP9A1fuT2xJuh0el7cH+pykxg1nJ2oAHfx4
	YYPhGok0VotgUhBQeVHFc4oN5NS1VwcyrXSOG5Om7I5pSG+RjOh5yPdxeCQEWEDFVEUQhW
	4bdcG7eMmjb8GyvWcTU/rDoVmcxx//Dm6U1OhrXYlk5Yes9qGyKAKVfUAg//aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713190535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=h6yFM9pgd0whttYbjAZoTcp9eapZWoc7Vu1vmPJ3kHs=;
	b=/MHEA5uxwRHyEHyKqfdRiA0G9UnXHv3hGNZ3wslJ/cK+b8vVEK9qvhFvwiUPLroirYJTaP
	IpSXwgVhISkHY5CA==
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric
 Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] posix-timers: Handle returned errors poperly in
 [i]timer_delete()
In-Reply-To: <20240415130023.GA27124@redhat.com>
Date: Mon, 15 Apr 2024 16:15:34 +0200
Message-ID: <87a5luvhix.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/15, Anna-Maria Behnsen wrote:
>>
>> timer_delete_hook() returns -EINVAL when the clock or the timer_del
>> callback of the clock does not exist. This return value is not handled by
>> the callsites timer_delete() and itimer_delete().
>
> IIUC this shouldn't happen? timer_delete_hook() WARN()s in this case,
> not sure we need to return this error to userspace...

This shouldn't happen, right.

Even if we do not return this error to userspace, is it valid to proceed
with the rest of the callsites? When it is fine to just ignore the
-EINVAL return, then I would propose just to add a comment to the code.

>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -1009,6 +1009,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
>>  {
>>  	struct k_itimer *timer;
>>  	unsigned long flags;
>> +	int ret;
>>  
>>  	timer = lock_timer(timer_id, &flags);
>>  
>> @@ -1019,7 +1020,11 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
>>  	/* Prevent signal delivery and rearming. */
>>  	timer->it_signal_seq++;
>>  
>> -	if (unlikely(timer_delete_hook(timer) == TIMER_RETRY)) {
>> +	ret = timer_delete_hook(timer);
>> +	if (ret < 0)
>> +		return ret;
>
> unlock_timer() ?
>

bah... was done in a hurry...

Thanks,

	Anna-Maria


