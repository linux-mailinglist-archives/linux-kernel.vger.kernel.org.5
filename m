Return-Path: <linux-kernel+bounces-131854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B7F898C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C64F1F2962C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A772C12D203;
	Thu,  4 Apr 2024 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K+ud700O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4v3ZzVKh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAA14A8B;
	Thu,  4 Apr 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249431; cv=none; b=Z7ePKZD4K+hbrBrquUKoPdeSq4iYoypxXClXGhO5X9TLt08FC+MU1MRqrMA+cIcHKfKnrMb5CD3BG+GLhwxEtIgWP8Cmt6RdPxKFPncQbfUWxeI2Zmm7bkK6EoEeZ8G5BitSH01shfVSu95FRl2EB84pI4yWim7niZDbdOczFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249431; c=relaxed/simple;
	bh=CHdsYPxN3bpXMJJkVR+dGGAWeCL/FsCZhntl8455uWA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=htaBFZKSI+seqFkI83mmrmyjf44EifK9UriSVAUgIVo3DwfMsKvYHLN6dru5ABozaFVah2YwRyt63Ouv0Xzn1LGkQHQD8HneTWkMv6I7mLwuZgCGUu6B3BEsA1QS5YncHyRLuggsngf3oDkaTJrF1klPMAjsynFEYkUULilFug0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K+ud700O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4v3ZzVKh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712249427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIhVLHf/UkvLJ7KptHJFdF4HOgrXTkVv33D2+7H0p3E=;
	b=K+ud700OCOVDYr7W5fBN476FnXp/Bn/gWMIBInbBxRCZi6Kr2BBqBrPZgA1WCGG55rx6cp
	uO9FU0Jw/PIp1QbjZKjBcUNV2RYOi04sUfqxkxeZozALJ9GM75/cBh5eJ09GuiNHm19PV6
	54ERePg+3IOYn79NHvq3xxn5HnLNTNXWA273xkIfdB9zoBFSCvfb7vY/IKq0GyvC17ktJY
	j5Ek0HlkCvM/B+1DdBQ4HT8AUaFGDJeT+eojmcbxsKSSjJ3ydix8EoPEyP3pJfxwj0S/BZ
	6+ZEUjlSv5CerCmf/1b2BSHKQ0iInmts6zFc1Wc0SCvX25w0e5ConYlceyDMVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712249427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIhVLHf/UkvLJ7KptHJFdF4HOgrXTkVv33D2+7H0p3E=;
	b=4v3ZzVKhoZgy6TyoZ/Q8cnb6+hU6cTba6VuNl51KhOXo6Xw9xgTTW5+pgTJZ1Sx5TMcaq4
	itrsKp4MM7NMZdBQ==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Russell
 King (Oracle)" <linux@armlinux.org.uk>, Joel Fernandes
 <joel@joelfernandes.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
 mingo@kernel.org, rcu@vger.kernel.org, neeraj.upadhyay@amd.com,
 urezki@gmail.com, qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
 chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org,
 Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH] timers/migration: Return early on deactivation
In-Reply-To: <ZgMDcGOagCjfIB3i@localhost.localdomain>
References: <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com> <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx> <ZfN0wY41pU5UjP8T@boqun-archlinux>
 <ZfOhB9ZByTZcBy4u@lothringen> <87zfulrlnn.fsf@somnus>
 <ZgMDcGOagCjfIB3i@localhost.localdomain>
Date: Thu, 04 Apr 2024 18:50:26 +0200
Message-ID: <87bk6pvzql.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Commit 4b6f4c5a67c0 ("timer/migration: Remove buggy early return on
deactivation") removed the logic to return early in tmigr_update_events()
on deactivation. With this the problem with a not properly updated first
global event in a hierarchy containing only a single group was fixed.

But when having a look at this code path with a hierarchy with more than a
single level, now unnecessary work is done (example is partially copied
from the message of the commit mentioned above):

                            [GRP1:0]
                         migrator = GRP0:0
                         active   = GRP0:0
                         nextevt  = T0:0i, T0:1
                         /              \
              [GRP0:0]                  [GRP0:1]
           migrator = 0              migrator = NONE
           active   = 0              active   = NONE
           nextevt  = T0i, T1        nextevt  = T2
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
           nextevt  = T1             nextevt  = T2
           /         \                /         \
          0 (T0i)     1 (T1)         2 (T2)      3
        idle         idle            idle         idle

1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
pushed as its next expiry and its own event kept as "ignore". Without this
early return the following steps happen in tmigr_update_events() when
child = null and group = GRP0:0 :

  lock(GRP0:0->lock);
  timerqueue_del(GRP0:0, T0i);
  unlock(GRP0:0->lock);


                            [GRP1:0]
                         migrator = NONE
                         active   = NONE
                         nextevt  = T0:0, T0:1
                         /              \
              [GRP0:0]                  [GRP0:1]
           migrator = NONE           migrator = NONE
           active   = NONE           active   = NONE
           nextevt  = T1             nextevt  = T2
           /         \                /         \
          0 (T0i)     1 (T1)         2 (T2)      3
        idle         idle            idle         idle

2) The change now propagates up to the top. Then tmigr_update_events()
updates the group event of GRP0:0 and executes the following steps
(child = GRP0:0 and group = GRP0:0):

  lock(GRP0:0->lock);
  lock(GRP1:0->lock);
  evt = tmigr_next_groupevt(GRP0:0); -> this removes the ignored events
					in GRP0:0
  ... update GRP1:0 group event and timerqueue ...
  unlock(GRP1:0->lock);
  unlock(GRP0:0->lock);

So the dance in 1) with locking the GRP0:0->lock and removing the T0i from
the timerqueue is redundand as this is done nevertheless in 2) when
tmigr_next_groupevt(GRP0:0) is executed.

Revert commit 4b6f4c5a67c0 ("timer/migration: Remove buggy early return on
deactivation") and add a condition into return path to skip the return
only, when hierarchy contains a single group.

Fixes: 4b6f4c5a67c0 ("timer/migration: Remove buggy early return on deactivation")
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -751,6 +751,31 @@ bool tmigr_update_events(struct tmigr_gr
 
 		first_childevt = evt = data->evt;
 
+		/*
+		 * Walking the hierarchy is required in any case when a
+		 * remote expiry was done before. This ensures to not lose
+		 * already queued events in non active groups (see section
+		 * "Required event and timerqueue update after a remote
+		 * expiry" in the documentation at the top).
+		 *
+		 * The two call sites which are executed without a remote expiry
+		 * before, are not prevented from propagating changes through
+		 * the hierarchy by the return:
+		 *  - When entering this path by tmigr_new_timer(), @evt->ignore
+		 *    is never set.
+		 *  - tmigr_inactive_up() takes care of the propagation by
+		 *    itself and ignores the return value. But an immediate
+		 *    return is required because nothing has to be done in this
+		 *    level as the event could be ignored.
+		 *
+		 * But, if the hierarchy has only a single level so @group is
+		 * the top level group, make sure first event information of the
+		 * group is updated properly and also handled properly, so skip
+		 * this fast return path.
+		 */
+		if (evt->ignore && !remote && group->parent)
+			return true;
+
 		raw_spin_lock(&group->lock);
 
 		childstate.state = 0;

