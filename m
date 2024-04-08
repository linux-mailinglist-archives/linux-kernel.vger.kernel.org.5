Return-Path: <linux-kernel+bounces-134872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF489B816
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14801282ED2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209F32232A;
	Mon,  8 Apr 2024 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SlHQUBf+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OfoIxj3J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD42BB0D;
	Mon,  8 Apr 2024 07:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559753; cv=none; b=cKOPYQSIXQcnqaq8dUukNwT0uXxfT9IGK5SPCDTOVVp9zNWdAiACwbB1XwetcncIkTaRHJ1zAQVGaDj4uhthGBDNTBw3FA6+GR26zDyoigRMm/B85ESvzPizInMxK9S0djGTLGZFxlPhUhBuQ0JKUGKf40teDKIAwV7+ZqbK7wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559753; c=relaxed/simple;
	bh=QOSh4rAjt7EpTH6eCTMkOk4R42jH2WV4EIL3hGsapBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OMNu84uRU+qr2rq7hQVtX7bxNjmqPWTcI6Kv388vgoyUMzrddnn2tcK1V3T0uzJdIj7AmhWEn9gGUJg7uw/GwTiCHN0hSuZySCu8Ecnpj0R4pgYAR3ijxQo211GV2MULQIjraCGF4lokYQxPB93pNpAQZnvb4K6d24jPGLFxL0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SlHQUBf+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OfoIxj3J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712559744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUwDtrm53vQQRYnp3vpMLTiNe30BZmkb/pL6DAKCU3I=;
	b=SlHQUBf+iLS0zQeNnLeKKal+9XI5fo5ofz1fxfsruZ/klXptQfEKLKPCO3f4pgpBFr3zTx
	5Ke3hhnnCxp38F2OKPLmvqsS1fWN8uh9RpFKTj8zx9e/PxGm2nx7zMpmc3KCmvJCjT5zsV
	NZF6nRxBSPZ35m2T/AvtWO7vgsKk/SbPrKjpRdfXG52PhaGD4JVMKosGRLpv3CbmzjRjHr
	b5S40nbIf/iueTmG0Px+epcMK7WUINuWVUPXQWkWPZwJQh8IXThpLiZqVh0y1ta3xLS1PN
	qkt/QDGyBMRwf7yVx8WSWyfrDO1ghtxgURHJJfmbU+hEqWq9EkwXEQ7gXozSDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712559744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UUwDtrm53vQQRYnp3vpMLTiNe30BZmkb/pL6DAKCU3I=;
	b=OfoIxj3Jc/K3eeNw1pc1uUcUA1y75B5si0ZQfK1tEDQiiRp4ODpmFNH3Mi8yvrZSve35CV
	MQswu7qoP+7eUbAQ==
To: linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-pm@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>, stable@kernel.org
Subject: [PATCH v2] PM: s2idle: Make sure CPUs will wakeup directly on resume
In-Reply-To: <20240405083410.4896-1-anna-maria@linutronix.de>
References: <20240405083410.4896-1-anna-maria@linutronix.de>
Date: Mon, 08 Apr 2024 09:02:23 +0200
Message-ID: <87r0fg5ocg.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

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
resume. As a consequence there is no guarantee that timers which are queued
on those CPUs and should expire directly after resume, are handled. Also
timer list timers which are remotely queued to one of those CPUs after
resume will not result in a reprogramming IPI as the tick is
active. Queueing a hrtimer will also not result in a reprogramming IPI
because the first hrtimer event is already in the past.

The recent introduction of the timer pull model (7ee988770326 ("timers:
Implement the hierarchical pull model")) amplifies this problem, if the
current migrator is one of the non woken up CPUs. When a non pinned timer
list timer is queued and the queuing CPU goes idle, it relies on the still
suspended migrator CPU to expire the timer which will happen by chance.

The problem exists since commit 8d89835b0467 ("PM: suspend: Do not pause
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
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@kernel.org
---
v2: Fix typos in commit message
---
 kernel/power/suspend.c |    6 ++++++
 1 file changed, 6 insertions(+)

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

