Return-Path: <linux-kernel+bounces-139491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3569A8A03B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7712B25B09
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CE7130E2E;
	Wed, 10 Apr 2024 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mytQT9Mw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H4yS4X44"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39F85928
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789242; cv=none; b=rhIAs3fyM3ys/bHPdnyuiePGxtrQmxsBcYpa4Ojv3iu0PvPeEAABp42IHDe5QpkAFeL0CJFKHoO0Ec+P9LI2VU1RtLipx5OcK4gx2k/TBN4FH+b+CIEVtGlego250nfMDyrHhmlYB3MiyESG7Vjpx4mao59AGuybRCCxgmfGm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789242; c=relaxed/simple;
	bh=eFn5GMxZi9L4ZeXpUtDZMmDhnFXqtlmDu0N+Bo14zl0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=L6iZUCkhRKKz8QL89I8RS95YW4OMrYRmIMz0mCPOHOVZX81nQ1JOTNdZ4c8tz8LAKX51nCYWFAOX8qmLEhK+180ufQYrByZgMtcMR6TOkSczZpKpEc1lAWVVFzYbN/rPiPHpchRxsjNcQ5Lgc3dS3F7c0g/f8Evznd15HYmmilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mytQT9Mw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H4yS4X44; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410165553.325347784@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dkh9zDfRIgoUx8unNZEZZL+uvuDybK3sMar20TESOQE=;
	b=mytQT9MwPFn91zP6paQCMFi/+0uOfGzj/80NEpk5KW92J2mRcA7kMfXvulNYTU/CkFBOg6
	HlR4eCkVKdHFAtPcK6QYuNFlReSM9bQgJ+rS16VL32D445kMTeNyCSC0nv067k+HjKUSq3
	iZrFkVuPonqw/iBlXlu8+hUVu3b+6c/tlg7A25N+fXCZAP4D7HlgqPez9OCLpN++RARqFS
	8h7uE3DfPF0GN9Lm+X4FnuEwJOgNYLDJmdoLP/SqEubrpk8ieeVM8UAtNbFbQBoJJPjfQn
	K9RQbsVtQHIbvOgOw2lcbE9eu2Ro181C0XEOQ2kqAdzYfAnPK3lz87qy/EHM2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=dkh9zDfRIgoUx8unNZEZZL+uvuDybK3sMar20TESOQE=;
	b=H4yS4X44nEM523JTZp3U+DwkDzCYodCU+f0KFOphTWWYn1N9ARtPSOFoQIwbA8YIKCVp7R
	oWa8BdiDsCNAEkCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V2 38/50] signal: Add sys_private_ptr to
 siginfo::_sifields::_timer
References: <20240410164558.316665885@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 00:47:19 +0200 (CEST)

On signal delivery collect_signal() copies the queued siginfo into a caller
provided siginfo struct. The posix timer signal delivery code then uses
siginfo::si_tid to lookup the timer in the hash table.

That's required today as the timer and the sigqueue are separate entities
and have different life time rules.

The sigqueue will be embedded into struct k_itimer to address a few issues
in the posix timer signal handling, which means the life time rules are
not longer separate, which can spare the lookup.

Due to locking rules posixtimer_deliver_signal() cannot be invoked from
collect_signal(). The timer pointer could be handed down from
collect_signal() to dequeue_signal(), but that's just overhead for the
non-posixtimer case.

There is room in the _sifields union for an extra pointer which will be
used later for storing the timer pointer. This field is copied with siginfo
and cleared before the info is delivered to userspace like the existing
si_sys_private field.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/signal_32.c        |    2 +-
 arch/x86/kernel/signal_64.c        |    2 +-
 include/uapi/asm-generic/siginfo.h |    2 ++
 kernel/time/posix-timers.c         |    4 +++-
 4 files changed, 7 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -456,7 +456,7 @@ CHECK_SI_OFFSET(_timer);
 /* compat_siginfo_t doesn't have si_sys_private */
 CHECK_SI_SIZE  (_timer, 3*sizeof(int));
 #else
-CHECK_SI_SIZE  (_timer, 4*sizeof(int));
+CHECK_SI_SIZE  (_timer, 5*sizeof(int));
 #endif
 static_assert(offsetof(siginfo32_t, si_tid)     == 0x0C);
 static_assert(offsetof(siginfo32_t, si_overrun) == 0x10);
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -456,7 +456,7 @@ static_assert(offsetof(siginfo_t, si_pid
 static_assert(offsetof(siginfo_t, si_uid) == 0x14);
 
 CHECK_SI_OFFSET(_timer);
-CHECK_SI_SIZE  (_timer, 6*sizeof(int));
+CHECK_SI_SIZE  (_timer, 8*sizeof(int));
 static_assert(offsetof(siginfo_t, si_tid)     == 0x10);
 static_assert(offsetof(siginfo_t, si_overrun) == 0x14);
 static_assert(offsetof(siginfo_t, si_value)   == 0x18);
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -47,6 +47,7 @@ union __sifields {
 		int _overrun;		/* overrun count */
 		sigval_t _sigval;	/* same as below */
 		int _sys_private;       /* not to be passed to user */
+		void *_sys_privptr;	/* not to be passed to user */
 	} _timer;
 
 	/* POSIX.1b signals */
@@ -146,6 +147,7 @@ typedef struct siginfo {
 #define si_tid		_sifields._timer._tid
 #define si_overrun	_sifields._timer._overrun
 #define si_sys_private  _sifields._timer._sys_private
+#define si_sys_privptr  _sifields._timer._sys_privptr
 #define si_status	_sifields._sigchld._status
 #define si_utime	_sifields._sigchld._utime
 #define si_stime	_sifields._sigchld._stime
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -289,8 +289,9 @@ bool posixtimer_deliver_signal(struct ke
 out:
 	spin_lock(&current->sighand->siglock);
 
-	/* Don't expose the si_sys_private value to userspace */
+	/* Don't expose the si_sys_priv* values to userspace */
 	info->si_sys_private = 0;
+	info->si_sys_privptr = NULL;
 	return ret;
 }
 
@@ -505,6 +506,7 @@ static int do_timer_create(clockid_t whi
 
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
+	new_timer->sigq->info.si_sys_privptr  = new_timer;
 
 	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;


