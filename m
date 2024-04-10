Return-Path: <linux-kernel+bounces-139452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E008A038A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4031F2342C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289C410A1D;
	Wed, 10 Apr 2024 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jukuL98k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMnenegG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE5BA49
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789176; cv=none; b=Lxz0S47JgP3KFgIuGsKh2t3r9hOJsE4O1MoBTxYLDUt4/VnDYOgfVatO93m/QnGHu1hwrxrtqMSxDDz+Gp4HPi7srcyHOOl4hBrgXjMhhcRw91MQ+hTkHdnxD+6DPrKyY/P+AGEij8hSmIrChtL/vevprwndqZVRQmR+YPGlec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789176; c=relaxed/simple;
	bh=qBubWXQbBIq6P4Kw2H8EobgXNMlS2x+iH1nFOnrDOQQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=mM8Rj/ExWWnaFjkdTQ9w86AEMCtrFMOne5IOHGze7j5l65OvfGlAOLpKmku0LqLLOgZNeMhdgABt7PVXGODHJfmgMiqZ3mwAOL5XNOGit4FEvoFST+Gf8td3LpMGUOHCSqDGsCQ0QU/tEx33X0iCZ2AkK4/HD4+2HfPra2GfJrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jukuL98k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KMnenegG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240410164558.316665885@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712789172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=O7Dfk2XBW3xV635fF4z7Tq7JJbMTU+/tQLvji5B+0ek=;
	b=jukuL98kzCufhpC1QVoxBcgVIHMMvgtVFXaa1nFoygzt2TliWnLYtbENaASnaBa83xZ5xI
	3EPmTj+PgKR1F6PBkofY4pJNCWuhZbJJTxQLsHzf8J20IN6f95M3R78VEguo1bQhI8QTfp
	AhYTDm9K1L7vd6E018j0llKVlAzzRnX3BDu/bCZDF37a4OuiP1XjLEpGrr5+2b0QTO1G3+
	AlAkqnpeEaXMbVTGprvxdPe8mkL/wrG9RgeIYCUsWDBIvGXityxFJ5XKKm52dIVQTOpvM5
	CwnTjZK4chyDPXAzwsTQWrSqc0IHsDfbjhqRSkTLE+15weW62pBpkWNUWd7sGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712789172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=O7Dfk2XBW3xV635fF4z7Tq7JJbMTU+/tQLvji5B+0ek=;
	b=KMnenegGN19JwKoo3AKss9kpMXWL2aDIgUuxYYIDyyO37ijEv9chuOFi5MRiY619+TRrWE
	h2g+TW50D69F/6Aw==
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
Subject: [patch V2 00/50] posix-timers: Cure inconsistencies and the SIG_IGN
 mess
Date: Thu, 11 Apr 2024 00:46:12 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is the second attempt of cleaning this up. Version 1 can be found
here:

   https://lore.kernel.org/lkml/20230606132949.068951363@linutronix.de/

Last year I reread a 15 years old comment about the SIG_IGN problem:

 "FIXME: What we really want, is to stop this timer completely and restart
  it in case the SIG_IGN is removed. This is a non trivial change which
  involves sighand locking (sigh !), which we don't want to do late in the
  release cycle.  ...  A more complex fix which solves also another related
  inconsistency is already in the pipeline."

The embarrasing part was that I put that comment in back then. So I went
back and rumaged through old notes as I completely had forgotten why our
attempts to fix this back then failed.

It turned out that the comment is about right: sighand locking and life
time issues. So I sat down with the old notes and started to wrap my head
around this again.

The problem to solve:

Posix interval timers are not rearmed automatically by the kernel for
various reasons:

   1) To prevent DoS by extremly short intervals.
   2) To avoid timer overhead when a signal is pending and has not
      yet been delivered.

This is achieved by queueing the signal at timer expiry and rearming the
timer at signal delivery to user space. This puts the rearming basically
under scheduler control and the work happens in context of the task which
asked for the signal.

There is a problem with that vs. SIG_IGN. If a signal has SIG_IGN installed
as handler the related signals are discarded. So in case of posix interval
timers this means that such a timer is never rearmed even when SIG_IGN is
replaced later with a real handler (including SIG_DFL).

To work around that the kernel self rearms those timers and throttles them
when the interval is smaller than a tick to prevent a DoS.

That just keeps timers ticking, which obviously has effects on power and
just creates work for nothing.

So ideally these timers should be stopped and rearmed when SIG_IGN is
replaced, which aligns with the regular handling of posix timers.

Sounds trivial, but isn't:

  1) Lock ordering.

     The timer lock cannot be taken with sighand lock held which is
     problematic vs. the atomicity of sigaction().

  2) Life time rules

     The timer and the sigqueue are separate entities which requires a
     lookup of the timer ID in the signal rearm code. This can be handled,
     but the separate life time rules are not necessarily robust.

  3) Finding the relevant timers

     Obviosly it is possible to walk the posix timer list under sighand
     lock and handle it from there. That can be expensive especially in the
     case that there are no affected timers as the walk would just end up
     doing nothing.

The following series is a new and this time actually working attempt to
solve this. It addresses it by:

  1) Embedding the preallocated sigqueue into struct k_itimer, which makes
     the life time rules way simpler and just needs a trivial reference
     count.

  2) Having a separate list in task::signal on which ignored timers are
     queued.

     This avoids walking a potentially large timer list for nothing on a
     SIG_IGN to handler transition.

  3) Requeueing the timers signal in the relevant signal queue so the timer
     is rearmed when the signal is actually delivered

     That turned out to be the least complicated way to address the sighand
     lock vs. timer lock ordering issue.

With that timers which have their signal ignored are not longer self
rearmed and the relevant workarounds including throttling for DoS
prevention are removed.

Aside of the SIG_IGN issues it also addresses a few inconsistencies in
posix CPU timers and the general inconsistency of signal handling
vs. disarmed, reprogrammed and deleted timers.

To actually validate the fixes the posix timer self test has been expanded
with tests which cover not only the simple SIG IGN case but also more
complex scenarios which have never been handled correctly by the current
self rearming work around.

The series is based on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent

and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/posix

Changes vs. V1:

    - Dropped the timer distribution check changes as that has been handled
      upstream differently (it's in timers/urgent and soon in Linus tree)

    - Split up patch 9 for the sake of easier review - Frederic

    - Addressed the review comments from Frederic

    - Picked up Reviewed-by tags where appropriate

Thanks,

	tglx
---
 arch/x86/kernel/signal_32.c                   |    2 
 arch/x86/kernel/signal_64.c                   |    2 
 drivers/power/supply/charger-manager.c        |    3 
 fs/proc/base.c                                |   10 
 fs/signalfd.c                                 |    4 
 fs/timerfd.c                                  |    4 
 include/linux/alarmtimer.h                    |   10 
 include/linux/posix-timers.h                  |   69 ++-
 include/linux/sched/signal.h                  |   11 
 include/uapi/asm-generic/siginfo.h            |    2 
 init/init_task.c                              |    5 
 kernel/fork.c                                 |    3 
 kernel/signal.c                               |  486 +++++++++++++---------
 kernel/time/alarmtimer.c                      |   82 ---
 kernel/time/itimer.c                          |   22 -
 kernel/time/posix-cpu-timers.c                |  231 ++++------
 kernel/time/posix-timers.c                    |  276 ++++++-------
 kernel/time/posix-timers.h                    |    9 
 net/netfilter/xt_IDLETIMER.c                  |    4 
 tools/testing/selftests/timers/posix_timers.c |  550 +++++++++++++++++++++-----
 20 files changed, 1092 insertions(+), 693 deletions(-)

