Return-Path: <linux-kernel+bounces-105277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6C887DB49
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 20:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCC1B217F8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488921BC4E;
	Sat, 16 Mar 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5e0WuKc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OLenZOQ8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CDB1B969;
	Sat, 16 Mar 2024 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710615982; cv=none; b=BGjsH3JwLQRkxy6+df6n/teJXwtl5GX8Jk5N5SeSb5+iYHgTswPyONHnaPc38dZj+5AkhVHBlCFLyQwVabdmnQo/Bg6s3S0vFzk4y0VT6cvnYoMN2BfJQudjbfVVcP2FMxwv5Q5Cymzt1Pv83Eou3EKGuagOGh4WXBVRpka7m4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710615982; c=relaxed/simple;
	bh=vYoif7D7tW4p44WK7JGFYi/bUu4bBFFr+Bml9bEqrrw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SzgYSyhtOtFn9+hOMcOhi1z3jegDyVi9e8g54F4aumth4pIij+RYXCMCBjI4yBsPa9alEjD/ZPDm4fcmg5ufFNbwyovD1NtAd8o9cZTZfg4xavIWgKrwLVj+zIX2dWYRhJRglA8GPC+8HeI+ca3F1qS3/8JCbZUVDgowQYlzJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5e0WuKc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OLenZOQ8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 16 Mar 2024 19:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710615971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLIcmw+77NtXr4Q8+Dld04V2Bc1sH1f9ppBBK+5aiwM=;
	b=L5e0WuKcYM+pHN6dnszS24yK5aE0RT152OQ3OJRg5av3/M0+vBMznjh1L7Z+j9tzRZj94h
	fIxy+GX6dLrmcD9hBGSguKBJUl2IO2jL1tsOpJboYylPUOqCeN8M7V9n1HMNmZZFD6m2hh
	Zz0eAzMtqZRjQzwKTtynv+Od2KC5w2gLDzU5xa6GdoVYfSAd8C3IIc8M9r8BQnoOjKzjHY
	PPuTpNwNaYgfcoVmyEdi6QuOzPwDEO0LUvSOMBGzG4Tgd3G11PDX2Lm1qn8MkoH+eux7jK
	56t2uwV1WGCA8E1xVz/ijXyIAqTHfkPi778V7XxAMUN9DZejw/MsVWZ6Wke6/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710615971;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLIcmw+77NtXr4Q8+Dld04V2Bc1sH1f9ppBBK+5aiwM=;
	b=OLenZOQ8/twB/IC90wqbTgZHQP8LMbNywOtFdUs32SUxQ6KL2v59RsHxaSsmFr6NYJCN1Q
	K22ffg2mYvHBxiDQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timer/migration: Remove buggy early return on
 deactivation
Cc: Boqun Feng <boqun.feng@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZfOhB9ZByTZcBy4u@lothringen>
References: <ZfOhB9ZByTZcBy4u@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171061597028.12214.14191592989389643571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     4b6f4c5a67c07417bf29d896c76f513a4be07516
Gitweb:        https://git.kernel.org/tip/4b6f4c5a67c07417bf29d896c76f513a4be07516
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 15 Mar 2024 02:14:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 16 Mar 2024 19:55:46 +01:00

timer/migration: Remove buggy early return on deactivation

When a CPU enters into idle and deactivates itself from the timer
migration hierarchy without any global timer of its own to propagate,
the group event of that CPU is set to "ignore" and tmigr_update_events()
accordingly performs an early return without considering timers queued
by other CPUs.

If the hierarchy has a single level, and the CPU is the last one to
enter idle, it will ignore others' global timers, as in the following
layout:

           [GRP0:0]
         migrator = 0
         active   = 0
         nextevt  = T0i
          /         \
         0           1
      active (T0i)  idle (T1)

0) CPU 0 is active thus its event is ignored (the letter 'i') and so are
upper levels' events. CPU 1 is idle and has the timer T1 enqueued.

           [GRP0:0]
         migrator = NONE
         active   = NONE
         nextevt  = T0i
          /         \
         0           1
      idle (T0i)  idle (T1)

1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
pushed as its next expiry and its own event kept as "ignore". As a result
tmigr_update_events() ignores T1 and CPU 0 goes to idle with T1
unhandled.

This isn't proper to single level hierarchy though. A similar issue,
although slightly different, may arise on multi-level:

                            [GRP1:0]
                         migrator = GRP0:0
                         active   = GRP0:0
                         nextevt  = T0:0i, T0:1
                         /              \
              [GRP0:0]                  [GRP0:1]
           migrator = 0              migrator = NONE
           active   = 0              active   = NONE
           nextevt  = T0i            nextevt  = T2
           /         \                /         \
          0 (T0i)     1 (T1)         2 (T2)      3
      active         idle            idle       idle

0) CPU 0 is active thus its event is ignored (the letter 'i') and so are
upper levels' events. CPU 1 is idle and has the timer T1 enqueued.
CPU 2 also has a timer. The expiry order is T0 (ignored) < T1 < T2

                            [GRP1:0]
                         migrator = GRP0:0
                         active   = GRP0:0
                         nextevt  = T0:0i, T0:1
                         /              \
              [GRP0:0]                  [GRP0:1]
           migrator = NONE           migrator = NONE
           active   = NONE           active   = NONE
           nextevt  = T0i            nextevt  = T2
           /         \                /         \
          0 (T0i)     1 (T1)         2 (T2)      3
        idle         idle            idle         idle

1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
pushed as its next expiry and its own event kept as "ignore". As a result
tmigr_update_events() ignores T1. The change only propagated up to 1st
level so far.

                            [GRP1:0]
                         migrator = NONE
                         active   = NONE
                         nextevt  = T0:1
                         /              \
              [GRP0:0]                  [GRP0:1]
           migrator = NONE           migrator = NONE
           active   = NONE           active   = NONE
           nextevt  = T0i            nextevt  = T2
           /         \                /         \
          0 (T0i)     1 (T1)         2 (T2)      3
        idle         idle            idle         idle

2) The change now propagates up to the top. tmigr_update_events() finds
that the child event is ignored and thus removes it. The top level next
event is now T2 which is returned to CPU 0 as its next effective expiry
to take account for as the global idle migrator. However T1 has been
ignored along the way, leaving it unhandled.

Fix those issues with removing the buggy related early return. Ignored
child events must not prevent from evaluating the other events within
the same group.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/r/ZfOhB9ZByTZcBy4u@lothringen

---
 kernel/time/timer_migration.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 8f49b6b..611cd90 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -751,26 +751,6 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 
 		first_childevt = evt = data->evt;
 
-		/*
-		 * Walking the hierarchy is required in any case when a
-		 * remote expiry was done before. This ensures to not lose
-		 * already queued events in non active groups (see section
-		 * "Required event and timerqueue update after a remote
-		 * expiry" in the documentation at the top).
-		 *
-		 * The two call sites which are executed without a remote expiry
-		 * before, are not prevented from propagating changes through
-		 * the hierarchy by the return:
-		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
-		 *    is never set.
-		 *  - tmigr_inactive_up() takes care of the propagation by
-		 *    itself and ignores the return value. But an immediate
-		 *    return is required because nothing has to be done in this
-		 *    level as the event could be ignored.
-		 */
-		if (evt->ignore && !remote)
-			return true;
-
 		raw_spin_lock(&group->lock);
 
 		childstate.state = 0;

