Return-Path: <linux-kernel+bounces-94017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB80873863
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65BF9282C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A6131757;
	Wed,  6 Mar 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YRgm1kv2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yII/aw7G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4535612FB0F;
	Wed,  6 Mar 2024 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709734050; cv=none; b=dAXfqjUxObJlkQmVkEXT5vkFeA0SgQwjLVD7anaub5lpN2OkeBHN4c/o+Wp6IUt0Vo6Gl7BIvx4eWF15sbeHIFQUtcSWcj6QgW+/SBAfnUGdsWXML0oylCmwFSYTOgm0CJLqHIVEBm2wQLrJiXfSDj/+IG68mqI2noQmyNTx/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709734050; c=relaxed/simple;
	bh=9Lhxtpg5G50oKTpp0MbbL/2Egq5R9jqv5aa+7pmY/cc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q+mwxXAP40RgPogOmN/naZSog+QXC3fTKR5BRQzZQ3s3RUE0ROy6Hss0fJAwU7z7AR9Q5MzKpL4Ticc7/enorSF2orD/DGdqwVyNZ2y/isU6fL+kB9Lvw3N4IDfu4V5gdKH/PULkXPgDfWVTT2E5eKHPi7ezLl2jHMG/zwAg39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YRgm1kv2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yII/aw7G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Mar 2024 14:07:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709734046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iklUqAt2hVpZsWeOoiF0VFmtNuHMivKSsp9yM7nk2Y=;
	b=YRgm1kv2jTgqakDJHL9+z944metfOA5KfPRQU4hPJGzCrV+bIk1xPi4HglfiPTEieOVTrG
	17w7qUDDyep7qGt7GCUc2FulfsHnlUii96wyxaiQsBP7OM+KIM7dQgeoz46wYfu92t1wzG
	SjXS7snA81hqYd/VjwDce3AVMG6zVhP8oI8IhP6B73RVxulQ0gmxX/7X23tbElHCRGqYqW
	UElpNHaRQWFr2zr5ROk1QGR0igChopjD2BN166WBVMlTmGzAYyITSALkbNIFqWWcVi4j25
	6r4dnvIEdStfVCY4y9i2+3gQfROUfEOR80OKs0kOL0flWI1pXSznWeCGdNDtHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709734046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iklUqAt2hVpZsWeOoiF0VFmtNuHMivKSsp9yM7nk2Y=;
	b=yII/aw7Gd2qYX3IIffJdTDZytduSrJVIxQxm8+526x/m7kAnTGB1UmdMgSK+c4enI7vMoO
	y7yCE66sM6C39PAg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timer/migration: Fix quick check reporting late expiry
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240305002822.18130-1-frederic@kernel.org>
References: <20240305002822.18130-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170973404551.398.9744367892734721294.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8ca1836769d758e4fbf5851bb81e181c52193f5d
Gitweb:        https://git.kernel.org/tip/8ca1836769d758e4fbf5851bb81e181c52193f5d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 05 Mar 2024 01:28:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 06 Mar 2024 15:02:09 +01:00

timer/migration: Fix quick check reporting late expiry

When a CPU is the last active in the hierarchy and it tries to enter
into idle, the quick check looking up the next event towards cpuidle
heuristics may report a too late expiry, such as in the following
scenario:

                        [GRP1:0]
                     migrator = NONE
                     active   = NONE
                     nextevt  = T0:0, T0:1
                     /              \
          [GRP0:0]                  [GRP0:1]
       migrator = NONE           migrator = NONE
       active   = NONE           active   = NONE
       nextevt  = T0, T1         nextevt  = T2
       /         \                /         \
      0           1              2           3
    idle       idle           idle         idle

0) The whole system is idle, and CPU 0 was the last migrator. CPU 0 has
a timer (T0), CPU 1 has a timer (T1) and CPU 2 has a timer (T2). The
expire order is T0 < T1 < T2.

                        [GRP1:0]
                     migrator = GRP0:0
                     active   = GRP0:0
                     nextevt  = T0:0(i), T0:1
                   /              \
          [GRP0:0]                  [GRP0:1]
       migrator = CPU0           migrator = NONE
       active   = CPU0           active   = NONE
       nextevt  = T0(i), T1      nextevt  = T2
       /         \                /         \
      0           1              2           3
    active       idle           idle         idle

1) CPU 0 becomes active. The (i) means a now ignored timer.

                        [GRP1:0]
                     migrator = GRP0:0
                     active   = GRP0:0
                     nextevt  = T0:1
                     /              \
          [GRP0:0]                  [GRP0:1]
       migrator = CPU0           migrator = NONE
       active   = CPU0           active   = NONE
       nextevt  = T1             nextevt  = T2
       /         \                /         \
      0           1              2           3
    active       idle           idle         idle

2) CPU 0 handles remote. No timer actually expired but ignored timers
   have been cleaned out and their sibling's timers haven't been
   propagated. As a result the top level's next event is T2 and not T1.

3) CPU 0 tries to enter idle without any global timer enqueued and calls
   tmigr_quick_check(). The expiry of T2 is returned instead of the
   expiry of T1.

When the quick check returns an expiry that is too late, the cpuidle
governor may pick up a C-state that is too deep. This may be result into
undesired CPU wake up latency if the next timer is actually close enough.

Fix this with assuming that expiries aren't sorted top-down while
performing the quick check. Pick up instead the earliest encountered one
while walking up the hierarchy.

7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240305002822.18130-1-frederic@kernel.org

---
 kernel/time/timer_migration.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index d85aa2a..8f49b6b 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1385,11 +1385,11 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
  *			  single group active on the way to top level)
  * * nextevt		- when CPU is offline and has to handle timer on his own
  *			  or when on the way to top in every group only a single
- *			  child is active and but @nextevt is before next_expiry
- *			  of top level group
- * * next_expiry (top)	- value of top level group, when on the way to top in
- *			  every group only a single child is active and @nextevt
- *			  is after this value active child.
+ *			  child is active but @nextevt is before the lowest
+ *			  next_expiry encountered while walking up to top level.
+ * * next_expiry	- value of lowest expiry encountered while walking groups
+ *			  if only a single child is active on each and @nextevt
+ *			  is after this lowest expiry.
  */
 u64 tmigr_quick_check(u64 nextevt)
 {
@@ -1408,10 +1408,16 @@ u64 tmigr_quick_check(u64 nextevt)
 	do {
 		if (!tmigr_check_lonely(group)) {
 			return KTIME_MAX;
-		} else if (!group->parent) {
-			u64 first_global = READ_ONCE(group->next_expiry);
-
-			return min_t(u64, nextevt, first_global);
+		} else {
+			/*
+			 * Since current CPU is active, events may not be sorted
+			 * from bottom to the top because the CPU's event is ignored
+			 * up to the top and its sibling's events not propagated upwards.
+			 * Thus keep track of the lowest observed expiry.
+			 */
+			nextevt = min_t(u64, nextevt, READ_ONCE(group->next_expiry));
+			if (!group->parent)
+				return nextevt;
 		}
 		group = group->parent;
 	} while (group);

