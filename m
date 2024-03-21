Return-Path: <linux-kernel+bounces-109961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C786885844
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEBD282039
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58B5A4D4;
	Thu, 21 Mar 2024 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QiDTb8t6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3jZnZioC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B158229;
	Thu, 21 Mar 2024 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020298; cv=none; b=kGfQ0pe+ZR6RE6qw4WR5XRgDfzOwzc6N+U37z/4RFgtdIwxsHHdstfYCkqQkISumPDjQPkyEKhQ3r4QJwSVjfUqzkrwDBvuz6I+qYW4Yg/Yi8GwdXHmQaYmGjgnmwmhOEXKdLS4KKmo1DOSCyIgVR3/5fa61mzufGIdpuNSOEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020298; c=relaxed/simple;
	bh=gst+oXGb/4n8bIDsyLM0AG1Y3wMsVD9IZ4qrzg7eWkE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dxRzn2Xw1QD8+kCramEW5M0KC1XdwEJhQ/afSr1dbPsmUVhxQKSkku8lZznlm8Zw7JI3kmrg2r02OFBqyMprPmLOEqGlk+lMIBjnXAzfnVOYH5piYQNf9iBH0Y5l8sq4JJAWPLvz4GFNV2I3rlgLU+/LQtdlzxUXoU7Q9SZDavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QiDTb8t6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3jZnZioC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 11:24:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711020295;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvgV9uRQ5mokoL+CWA1BFsXEAKiRYoaGZVn2rpFo8oc=;
	b=QiDTb8t6rcTwfdDayxmhLU6lL9U8sgtxRaFjC0bJI03zZXhylD0Aoz9lWyxGUM++S1iaRu
	2MLBzF/8f10tsvk2Tv8R525fcGB4LUlQstbkd4g25QyHULBqXY8QunBTWEkLLzfLERd2KT
	3L0hkQJ3Hni44TBkyfspO71DMxSs202JVNltQDSxhgMIHwbGQMyPDgs42QxRlga8T15lgb
	Za5ryDiAJjkQbX9AaO8b389M/Hy8Coo2tVLl26irNVkcEMWGz6Yfxo4cu4CobtAgfLXiF2
	Uiht+/uuMQwe4No6NcdtNLMDTaB0RSLGfogcjU3qFYgDtSbarwR5Ew7QRMY3xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711020295;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvgV9uRQ5mokoL+CWA1BFsXEAKiRYoaGZVn2rpFo8oc=;
	b=3jZnZioCScL1heQGmCqA89Lxn1TCLZ3x9/mJI1CRz+ade8upFhXqv0duESZHmHkYt4zQuB
	IwcQjPsGQfuK5eDg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Fix endless timer requeue
 after idle interrupts
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240318230729.15497-2-frederic@kernel.org>
References: <20240318230729.15497-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171102029421.10875.6095806684976626047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f55acb1e44f3d4bf1ca7926d777895a67d4ec606
Gitweb:        https://git.kernel.org/tip/f55acb1e44f3d4bf1ca7926d777895a67d4ec606
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 19 Mar 2024 00:07:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 Mar 2024 10:14:55 +01:00

timers/migration: Fix endless timer requeue after idle interrupts

When a CPU is an idle migrator, but another CPU wakes up before it,
becomes an active migrator and handles the queue, the initial idle
migrator may end up endlessly reprogramming its clockevent, chasing ghost
timers forever such as in the following scenario:

               [GRP0:0]
             migrator = 0
             active   = 0
             nextevt  = T1
              /         \
             0           1
          active        idle (T1)

0) CPU 1 is idle and has a timer queued (T1), CPU 0 is active and is
the active migrator.

               [GRP0:0]
             migrator = NONE
             active   = NONE
             nextevt  = T1
              /         \
             0           1
          idle        idle (T1)
          wakeup = T1

1) CPU 0 is now idle and is therefore the idle migrator. It has
programmed its next timer interrupt to handle T1.

                [GRP0:0]
             migrator = 1
             active   = 1
             nextevt  = KTIME_MAX
              /         \
             0           1
          idle        active
          wakeup = T1

2) CPU 1 has woken up, it is now active and it has just handled its own
timer T1.

3) CPU 0 gets a timer interrupt to handle T1 but tmigr_handle_remote()
realize it is not the migrator anymore. So it early returns without
observing that T1 has been expired already and therefore without
updating its ->wakeup value.

4) CPU 0 goes into tmigr_cpu_new_timer() which also early returns
because it doesn't queue a timer of its own. So ->wakeup is left
unchanged and the next timer is programmed to fire now.

5) goto 3) forever

This results in timer interrupt storms in idle and also in nohz_full (as
observed in rcutorture's TREE07 scenario).

Fix this with forcing a re-evaluation of tmc->wakeup while trying
remote timer handling when the CPU isn't the migrator anymmore. The
check is inherently racy but in the worst case the CPU just races setting
the KTIME_MAX value that a remote expiry also tries to set.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240318230729.15497-2-frederic@kernel.org

---
 kernel/time/timer_migration.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 611cd90..c63a0af 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1038,8 +1038,15 @@ void tmigr_handle_remote(void)
 	 * in tmigr_handle_remote_up() anyway. Keep this check to speed up the
 	 * return when nothing has to be done.
 	 */
-	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask))
-		return;
+	if (!tmigr_check_migrator(tmc->tmgroup, tmc->childmask)) {
+		/*
+		 * If this CPU was an idle migrator, make sure to clear its wakeup
+		 * value so it won't chase timers that have already expired elsewhere.
+		 * This avoids endless requeue from tmigr_new_timer().
+		 */
+		if (READ_ONCE(tmc->wakeup) == KTIME_MAX)
+			return;
+	}
 
 	data.now = get_jiffies_update(&data.basej);
 

