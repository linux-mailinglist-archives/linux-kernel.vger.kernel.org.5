Return-Path: <linux-kernel+bounces-132707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61712899912
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16738283813
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDB715FD1C;
	Fri,  5 Apr 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FlI1/jS+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVBH6R8G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14415FCEE;
	Fri,  5 Apr 2024 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308297; cv=none; b=Z31hDmnah4oIjaIyVw01SCl4NXvZxag7nTB2IGizP+XL+jPydisuyFo2OEdBaj49YJ0S6bOCIrI4nwFcuXAGcpwkTU77tIFrrFIAErwitYljAaZryXh3NbnJVCB8mKU0TT+urpSh4oI27WeCfXFr+GFFdBHc+wuv0pMit4YnVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308297; c=relaxed/simple;
	bh=YSaBmWoXfYDhvVymWb8ukujVahbY5mHH7VkkTR3FmbI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MeDLQh6hW4nbvvCxHZf1Q75WB6c8As7072DgI9p/AOm8XRgRbDHzbQuA71Qn3SWnvz0YCJPYnzD8CzRAJh/9ae46i61C41XB5UBvF9qIk4LXbtscu06WCJAEvOZbu7OzMok6Ug4g6/qiyOUMAAM6lfgzIYnJloE28R24k0dtAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FlI1/jS+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVBH6R8G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Apr 2024 09:11:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712308293;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iW/TWBRlA3pdU0u90IiI8ZFieLi9oRhVjZmHm/wce/8=;
	b=FlI1/jS+tEjyelRKJiAJsroLcfcANIMA4xKfzjyGaC2YqoDV1gugBviisv8qNslktP11sO
	vCsb6qHc+diLH8LEcHdjaxaorKpWdQVwG6bLbG4NACBDatP5QLxu93f0qkSh2GZMMmIku7
	ZQZh9E0pbyBMQPHgIWMpJl3iYI6EbPoawZ12TLVif5rZ0c1s7ymJrbn6eocyPXeYj37aZr
	icIrTKvDM9aSW1Bml4oYMUnQxeMjqcXPIsFRuKWOOr06pyDL2pdgnvLmkDBpn3Z+aVQSOv
	Vm0asKF3h3P347+BTWto0s1w3JjoAzrr5PO9jeNef8gXxq5XpI9+QvlpeXnwag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712308293;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iW/TWBRlA3pdU0u90IiI8ZFieLi9oRhVjZmHm/wce/8=;
	b=GVBH6R8G9ldAAYdi7qWESjfXTkDDlUY1OgT79q/HOR5R1Fj4zJjzyMFrx1lS7bNeeMWb8S
	3ghI8I3usNBx87DQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Fix ignored event due to
 missing CPU update
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Zg2Ct6M2RJAYHgCB@localhost.localdomain>
References: <Zg2Ct6M2RJAYHgCB@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171230829261.10875.3417247022952056408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     61f7fdf8fd00ce33d30ca3fae8d643c0850ce945
Gitweb:        https://git.kernel.org/tip/61f7fdf8fd00ce33d30ca3fae8d643c0850ce945
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 01 Apr 2024 23:48:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 05 Apr 2024 11:05:16 +02:00

timers/migration: Fix ignored event due to missing CPU update

When a group event is updated with its expiry unchanged but a different
CPU, that target change may go unnoticed and the event may be propagated
up with a stale CPU value. The following depicts a scenario that has
been actually observed:

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = TGRP1:0 (T0)
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T0
      /         \
    0 (T0)       1 (T1)
    idle         idle

0) The hierarchy has 3 levels. The left part (GRP1:0) is all idle,
including CPU 0 and CPU 1 which have a timer each: T0 and T1. They have
the same expiry value.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = KTIME_MAX
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T0
      /         \
    0 (T0)       1 (T1)
    idle         idle

1) The migrator in GRP1:1 handles remotely T0. The event is dequeued
from the top and T0 executed.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = KTIME_MAX
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T1
      /         \
    0            1 (T1)
    idle         idle

2) The migrator in GRP1:1 fetches the next timer for CPU 0 and finds
none. But it updates the events from its groups, starting with GRP0:0
which now has T1 as its next event. So far so good.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = KTIME_MAX
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T1
      /         \
    0            1 (T1)
    idle         idle

3) The migrator in GRP1:1 proceeds upward and updates the events in
GRP1:0. The child event TGRP0:0 is found queued with the same expiry
as before. And therefore it is left unchanged. However the target CPU
is not the same but that fact is ignored so TGRP0:0 still points to
CPU 0 when it should point to CPU 1.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = TGRP1:0 (T0)
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T1
      /         \
    0            1 (T1)
    idle         idle

4) The propagation has reached the top level and TGRP1:0, having TGRP0:0
as its first event, also wrongly points to CPU 0. TGRP1:0 is added to
the top level group.

                       [GRP2:0]
                   migrator = GRP1:1
                   active   = GRP1:1
                   nextevt  = KTIME_MAX
                    /              \
               [GRP1:0]           [GRP1:1]
            migrator = NONE       [...]
            active   = NONE
            nextevt  = TGRP0:0 (T0)
            /           \
        [GRP0:0]       [...]
      migrator = NONE
      active   = NONE
      nextevt  = T1
      /         \
    0            1 (T1)
    idle         idle

5) The migrator in GRP1:1 dequeues the next event in top level pointing
to CPU 0. But since it actually doesn't see any real event in CPU 0, it
early returns.

6) T1 is left unhandled until either CPU 0 or CPU 1 wake up.

Some other bad scenario may involve trees with just two levels.

Fix this with unconditionally updating the CPU of the child event before
considering to early return while updating a queued event with an
unchanged expiry value.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/Zg2Ct6M2RJAYHgCB@localhost.localdomain
---
 kernel/time/timer_migration.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c63a0af..e3075e4 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -762,8 +762,11 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 	 * queue when the expiry time changed only or when it could be ignored.
 	 */
 	if (timerqueue_node_queued(&evt->nextevt)) {
-		if ((evt->nextevt.expires == nextexp) && !evt->ignore)
+		if ((evt->nextevt.expires == nextexp) && !evt->ignore) {
+			/* Make sure not to miss a new CPU event with the same expiry */
+			evt->cpu = first_childevt->cpu;
 			goto check_toplvl;
+		}
 
 		if (!timerqueue_del(&group->events, &evt->nextevt))
 			WRITE_ONCE(group->next_expiry, KTIME_MAX);

