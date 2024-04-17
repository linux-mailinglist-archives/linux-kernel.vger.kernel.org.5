Return-Path: <linux-kernel+bounces-148223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99F8A7F85
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D6F1F22891
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0670128369;
	Wed, 17 Apr 2024 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/oFTzHF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n7wpRnph"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B061F516
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345720; cv=none; b=BU3HtilwY2PpNNOUb0Xyht9XW7T8q36t+nE9KSICRR/ryzTPnzxQvOc6/48yEu3A1CzJaYBKzRi2UIpMixS4JO1tcy/xDRnxkZi9kmzel4HRaLkF8SfO87GOaiPcAberdK2BFVNyFLXqfuIf45bYv4j99tFjpK9+JEzFLZFIak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345720; c=relaxed/simple;
	bh=YQCssONq63bP0qOSXogsdrqWe5WQi1xzVV+1t1nonpE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=qnlbTeOL+shGpVH+MSFt71fPAk9kkXveCu4eDPKFMzD/4aiBKcyTqoePMgEXnjkHCqLDZEah9WfaHjsNQDhMaEcKz4zk02ObqBW1zLg59zGf6e44twJCS5N+0KLszXGSpHxUZyXoAnYBcOsEGotkXmHvLZavwo3TCs9mAy8lAEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/oFTzHF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n7wpRnph; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713345713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=uelsdtYZLBKL7jGIyaP3EG/BKK0QSDVCAZyC+ZgTgWI=;
	b=N/oFTzHF4bDb8QRgjaC7Z6Po4wDANptnApdUW0jDwapj4DwVsdil6wL/wbDu9qN139oeWJ
	m9QDrepaKxAjp89hm6WbRfHfRAyvMJQRnQE+NztkslFjtXq+o53shI9qpLZPeabz6+EQAM
	cW5ERdPm2fDlJxTjSgpJH1jp63DN9/LkO3PnKHjLStDRjSdk5GZDwxZUv5YiNeeuVx6nU+
	TfdcdtPuRBEF2KHdmOKHEYgIDDYudqYOej+wXAo4ZXy/cGD3OI4i/9QzxOx3AFzNIslPeM
	P7LexVPri3b1i1cGiHE3I7OyIhi2uYsqAWsjUV0h85Bx0s3Dpbjd9AlgoWO5ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713345713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=uelsdtYZLBKL7jGIyaP3EG/BKK0QSDVCAZyC+ZgTgWI=;
	b=n7wpRnphfQAtG0IBBYh3kxYXjf4HSao3BQ+sNkaQO8ahI2LNp0bALMNVuimOVsF1QHgGQm
	/cjhI3zKt1xxxwBA==
To: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, John Stultz <jstultz@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [patch V2 07/50] posix-cpu-timers: Split up posix_cpu_timer_get()
In-Reply-To: <20240416144438.GA17990@redhat.com>
Date: Wed, 17 Apr 2024 11:21:52 +0200
Message-ID: <87o7a8wdhr.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/11, Thomas Gleixner wrote:
>>
>> In preparation for addressing issues in the timer_get() and timer_set()
>> functions of posix CPU timers.
>
> Cough... I must have missed something, but posix_cpu_timer_get()
> doesn't look right with or without this trivial patch.
>
> It doesn't initialize itp->it_value if cpu_timer_getexpires() == 0,
> this means that sys_timer_gettime() will copy the uninitialized
> cur_setting->it_value on the stack to userspace?

The initialization of itp is already done by the callsites.
do_timer_settime() in posix-timers.c as well as do_cpu_nanosleep() in
posix-cpu-timers.c execute a memset before calling
posix_cpu_timer_get(). So this should be fine - or did I miss something
here?

Thanks,

	Anna-Maria


