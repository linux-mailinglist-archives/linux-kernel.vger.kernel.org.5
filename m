Return-Path: <linux-kernel+bounces-132706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590DB89990F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA3328371B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4277E15FCEC;
	Fri,  5 Apr 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gj5bL1St";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UAPO0tr7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AE15FCEA;
	Fri,  5 Apr 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308296; cv=none; b=EOjHdofc94w0wRo8tqGQBN5KQCTNFbH1xXSRAmre5xGbaAfyl5nzmUsDG5imc5vUNvTcuxTrEEEfTITry3VfK3EnZrvp1NR7F8Hhoc42n2baHqgMgwaQ2RYQmHMhCzGnWNASKnUEbeGMDm+o2tFqqbI0an2Q2EvuS5rXr2O1Na4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308296; c=relaxed/simple;
	bh=3fM1sBTrWSY49lNY8xf7sHtghdnUv2AGy1br7QxCdwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S3zY/SIpjY5j9cIBnyWcRqb8h0L0liequHgjzMDC0qPnBQK7457AZiCwX2eOSN+ID6NCZ4CxO1DbVngwuQNgvhSVPMHXbWmmFWjIP/Lyona6eAFC/uAnBw/ELKCcl5t230qRzlxXi9XJmeHuiT682KbTo0Cxw2+E9ZfY9v8mExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gj5bL1St; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UAPO0tr7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Apr 2024 09:11:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712308292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zGzV+I7AEheSHfzAb4K16/iiWoyWFVRjcXBcFqSIjM=;
	b=Gj5bL1StbnrNKCWIg4Gch2EqAcDWZR7cRa/LsgwsQSuq3KhdfIBE4JNg4N6juPybomsS1G
	VmklLNIXtbgnRnYd0dtQMBbklWEp0e3DW8tFP7ovzW5oEZquS54eY/3Wcc7ra0rXcfywvU
	t5puKiLqhEuiWtcfSDcLKOzrSQ2JxDnGCCgFmIzoFKVx3mLCbCABGQmn5RNc37rhg4Frvw
	UQflRe+vqvzA4E+G+RG41w+nG3uQ7/YiaQ9Djy5XkzOIzggIIzk5MeKSICzONCrq2ToOCU
	Zf3ArYRQBBUMIEpA4OtLQWutwkvEpfVlgjSFlevJkRUh5YsimXwNGJPerFE+qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712308292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1zGzV+I7AEheSHfzAb4K16/iiWoyWFVRjcXBcFqSIjM=;
	b=UAPO0tr7EShuISW/alaR6rEhPbizbf9LF2IaEzKUqFrnINoSakWLmK9ubZB14PTp6hmjRg
	0n1eJR508482pGAg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Return early on deactivation
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87cyr49on2.fsf@somnus>
References: <87cyr49on2.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171230829183.10875.12362342443387420509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     7a96a84bfbee96871bb16c70ee3e93d564e190f4
Gitweb:        https://git.kernel.org/tip/7a96a84bfbee96871bb16c70ee3e93d564e190f4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 05 Apr 2024 10:53:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 05 Apr 2024 11:05:16 +02:00

timers/migration: Return early on deactivation

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
only, when hierarchy contains a single group. Adapt comments accordingly.

Fixes: 4b6f4c5a67c0 ("timer/migration: Remove buggy early return on deactivation")
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/87cyr49on2.fsf@somnus

---
 kernel/time/timer_migration.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index e3075e4..ccba875 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -751,6 +751,33 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 
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
+		 *    return is possible if there is a parent, sparing group
+		 *    locking at this level, because the upper walking call to
+		 *    the parent will take care about removing this event from
+		 *    within the group and update next_expiry accordingly.
+		 *
+		 * However if there is no parent, ie: the hierarchy has only a
+		 * single level so @group is the top level group, make sure the
+		 * first event information of the group is updated properly and
+		 * also handled properly, so skip this fast return path.
+		 */
+		if (evt->ignore && !remote && group->parent)
+			return true;
+
 		raw_spin_lock(&group->lock);
 
 		childstate.state = 0;

