Return-Path: <linux-kernel+bounces-76604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB9885F9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189571C2528F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74FE1350D8;
	Thu, 22 Feb 2024 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v6OiMPTE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dQwuMnN1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18B134CF7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608812; cv=none; b=C7zIPjj6rmeUZtd/Wa2vbyPGxLb6cB+HJ3wzZYjBkgc+dla32y15ecmcC7K5ajcUqtROJvbzvzRhvvmK3Yw/HmgyLou2YeqnlGsIqgIcZohORugEcb+E/4UMFiLdwCLhUG+ZlDHUNXLUF6P9IMUzdknJ2kZfso0jn3lfzLMzLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608812; c=relaxed/simple;
	bh=Qk4e68m7L/wYYFcyfUP3vhvzpWn6XgmiyH7aWBw11Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qOZPob07AhPnLuyPEyNWccwYQVPV+CFJHhsyEjJLBT+IjRetZ0rOH2wZ2YSXXRO7CgOMJWXAuEkhIlarttm8mLiNjkx87OAyPgxxiko6FIHTax6PPG4qWHnMcBB38C4CJ1KXOlJv4cgXCgH0wc4sNPidpTzkYyX/1qD6tCS2wiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v6OiMPTE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dQwuMnN1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708608808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kf5vbm46zvCvirSgaBCAUyipa0OcueyRJ9iBoOT/nVY=;
	b=v6OiMPTEDAXg/94M8UJiTcACAOoAQu61hw8Dc8QyG08GP6thPgPGO9aBDnDTdIk+l1Rx44
	sxmbbq9T/J7bmxqlEDijSgdP8WjzsgFQwyBNGAhQcfVtUCiHZlQDgQHQab5K/mZQ0GJKJ4
	CkcMdicrXu/4CyKOiBiZSpt42LAJbdCAUbxLK4cwnl1dVF3a9NdKs39iyeryWHsOIMpKRl
	50NRwA+NxMa5JCo5OS8KHFnDJrGvk1svbJMSOfk6mOU/a+eJ2VZTQLqkbZCFDlWytxpZCC
	281YXffru71Buo/052IfwXqz8vohaZZdxdDAtQNDBQ/DrF+SU/IKLDJh0/Vj7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708608808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kf5vbm46zvCvirSgaBCAUyipa0OcueyRJ9iBoOT/nVY=;
	b=dQwuMnN1TIWItdH9T5jbQIeuRd2HEbuaTIAxaI1YBftInQN2LhNroG4NpQgm7FtDzfIV4b
	VPXEHr8eEesTMiAQ==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH] timers/timer_migration: Fix memory barrier comment
Date: Thu, 22 Feb 2024 14:33:20 +0100
Message-Id: <20240222133320.43780-1-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Comment about the required memory barrier in tmigr_inactive_up() is not
written properly. Rewrite it and add also new comments to the other memory
barrier related places. Also make clear, why a memory barrier in
tmigr_active_up() is not required.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
This is a fix for the patch 'timers: Implement the hierarchical pull model'
v11b.
---
 kernel/time/timer_migration.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 0825ccdcfae4..23cb6ea3d44e 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -623,6 +623,11 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	u8 childmask;
 
 	childmask = data->childmask;
+	/*
+	 * No memory barrier is required here in contrast to
+	 * tmigr_inactive_up(), as the group state change does not depend on the
+	 * child state.
+	 */
 	curstate.state = atomic_read(&group->migr_state);
 
 	do {
@@ -1215,9 +1220,16 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	u8 childmask;
 
 	childmask = data->childmask;
-	curstate.state = atomic_read_acquire(&group->migr_state);
 	childstate.state = 0;
 
+	/*
+	 * The memory barrier is paired with the cmpxchg() in tmigr_active_up()
+	 * to make sure the updates of child and group states are ordered. The
+	 * ordering is mandatory, as the group state change depends on the child
+	 * state.
+	 */
+	curstate.state = atomic_read_acquire(&group->migr_state);
+
 	for (;;) {
 		if (child)
 			childstate.state = atomic_read(&child->migr_state);
@@ -1257,10 +1269,12 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state,
 				       newstate.state))
 			break;
+
 		/*
-		 * Add memory barrier to make sure child and group states order
-		 * of read is preserved. This barrier is only required when
-		 * atomic_try_cmpxchg() failed.
+		 * The memory barrier is paired with the cmpxchg() in
+		 * tmigr_active_up() to make sure the updates of child and group
+		 * states are ordered. It is required only when the above
+		 * try_cmpxchg() fails.
 		 */
 		smp_mb__after_atomic();
 	}
-- 
2.39.2


