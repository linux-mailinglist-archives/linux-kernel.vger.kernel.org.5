Return-Path: <linux-kernel+bounces-132659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9678997E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1452858FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9215F32E;
	Fri,  5 Apr 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGPpchnC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iZLMIhAp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B1145B09;
	Fri,  5 Apr 2024 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306066; cv=none; b=kfeWoybO/nqJ5Lo3cYBHPypD3zKDzfKP+eZ4fo3F2MSoJJGAmlYjnUeXZ8JVkqzeLawnaXTZhCSg/4tbFrP28exqEuQ6WIlUerNF2+9Z5vQ++jtqrBhHoDq+cdKYy2Zc8z7e4U5ACXnIhykKOeosa7AC6gTjo3pIePsBzaR5Eg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306066; c=relaxed/simple;
	bh=PR+7ds2HGo2jve0t4aq/uu/b6Ds20Iyx2n8veKfoFqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HK1rdOznsgn8upsoFiRQkeY96ToXCvGZ2Bfxr2+DNcme8bjYf8rYTsNINvbxM5SgQZ1z6/Vr8x9v8mhhcJJpD5yNmIJiM4OCXri2EPd48NfnvEryki0V6H+8W+SD+yveBus3EodM82IlnMUHIDdiRL7sq48LfaaL8//7e7JcChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGPpchnC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iZLMIhAp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712306062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vz9gdAWslzxa17vDr2RXb+lx+EfINHoYwLIVtOfMNtI=;
	b=ZGPpchnCt2RNbT1lS8u3Ih0SiM+WOpteLMPsAwQ2vFB493JDuLNdAtMbGkH7fpOTvPb9fk
	m1120JXJwnveC1nXpyaK1rPS2V491lHQfJc6id+zFOSNc0t4TBXShc5uRu1sro6eHWqt1m
	rQiL4q23e++KHIaySuYVwMORQKaWpxRJ7bWSx7Bvb6ftAv2lp/y1/iSDe7pcAkzp5gcOLW
	DBbDs6gUMDF3LWHTeZUsbIt5Pb49M6Ks1sCeutSkNb5v/SJQsrXjCYFhodwMel2EVRfxIx
	1b3TbK/fx+iRazqNaDuSIb37FqBz4MsOcXvQ3Qt7Yn7y7gCAoJUNZe3l7hfrQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712306062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vz9gdAWslzxa17vDr2RXb+lx+EfINHoYwLIVtOfMNtI=;
	b=iZLMIhApPYlZDWKi3sN9uPbNXcXtdkpN8bUfaaTBYWnX5UPJJWpYteetnuJCCVS+Wir8MR
	Tj/It3XOCiV9SBCw==
To: linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	stable@kernel.org
Subject: [PATCH] PM: s2idle: Make sure CPUs will wakeup directly on resume
Date: Fri,  5 Apr 2024 10:34:10 +0200
Message-Id: <20240405083410.4896-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s2idle works like a regular suspend with freezing processes and freezing
devices. All CPUs except the control CPU go into idle. Once this is
completed the control CPU kicks all other CPUs out of idle, so that they
reenter the idle loop and then enter s2idle state. The control CPU then
issues an swait() on the suspend state and therefore enters the idle loop
as well.

Due to being kicked out of idle, the other CPUs leave their NOHZ states,
which means the tick is active and the corresponding hrtimer is programmed
to the next jiffie.

On entering s2idle the CPUs shut down their local clockevent device to
prevent wakeups. The last CPU which enters s2idle shuts down its local
clockevent and freezes timekeeping.

On resume, one of the CPUs receives the wakeup interrupt, unfreezes
timekeeping and its local clockevent and starts the resume process. At that
point all other CPUs are still in s2idle with their clockevents switched
off. They only resume when they are kicked by another CPU or after resuming
devices and then receiving a device interrupt.

That means there is no guarantee that all CPUs will wakeup directly on
resume. As the consequence there is no guarantee that timers which are
queued on those CPUs and should expire directly after resume, are
handled. Also timer list timers which are remotely queued to one of those
CPUs after resume will not result in a reporgramming IPI as the tick is
active. A queue hrtimer will also not result in a reprogramming IPI because
the first hrtimer event is already in the past.

The recent introduction of the timer pull model (7ee988770326 ("timers:
Implement the hierarchical pull model")) amplifies this problem, if the
current migrator is one of the non woken up CPUs. When a non pinned timer
list timer is queued and the queueing CPU goes idle, it relies on the still
suspended migrator CPU to expire the timer which will happen by chance.

The problem existis since commit 8d89835b0467 ("PM: suspend: Do not pause
cpuidle in the suspend-to-idle path"). There the cpuidle_pause() call which
in turn invoked a wakeup for all idle CPUs was moved to a later point in
the resume process. This might not be reached or reached very late because
it waits on a timer of a still suspended CPU.

Address this by kicking all CPUs out of idle after the control CPU returns
from swait() so that they resume their timers and restore consistent system
state.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218641
Fixes: 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-to-idle path")
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@kernel.org
---
 kernel/power/suspend.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index e3ae93bbcb9b..09f8397bae15 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -106,6 +106,12 @@ static void s2idle_enter(void)
 	swait_event_exclusive(s2idle_wait_head,
 		    s2idle_state == S2IDLE_STATE_WAKE);
 
+	/*
+	 * Kick all CPUs to ensure that they resume their timers and restore
+	 * consistent system state.
+	 */
+	wake_up_all_idle_cpus();
+
 	cpus_read_unlock();
 
 	raw_spin_lock_irq(&s2idle_lock);
-- 
2.39.2


