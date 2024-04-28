Return-Path: <linux-kernel+bounces-161325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884618B4AB4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B3CB2131C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3C524DB;
	Sun, 28 Apr 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tmUfiNAY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQdZSX8S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89EF9EF;
	Sun, 28 Apr 2024 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714292681; cv=none; b=oYHJmCnG3CuzBGxggCqW7WVNXpfdx80+aPvew8vYURYgyCMjb9fEK2Z6cwrvRyR9xyBNqlb/anwV37zEjcpHYH94B+TgAZmlS7M75EVk044CLwaK0Pk3iEVFjLM8YG4nz6r24NtZ9cPQ4QJfgJ3ZahLT89NunLUPNJMdZEvBGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714292681; c=relaxed/simple;
	bh=Vil+BDqRYDS6LChmPe6Q6on+lguWBTWidGmONc/mXiE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X/6l+zWmrRq+997epiQYx0yJ55im4mSHK9F+nIBkbZE6M8AWrIdGvjdI4IxqVhp2N8jyDKzKXcEvwjlIQKo8sdg3S4yZiXh8lRsER1m3WIfTffCzkTnnXmYVVJepgiwPnK03VPmcaInTL+MoZwG+ZFSN43xyD1CPOmm39Ej9zTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tmUfiNAY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQdZSX8S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 28 Apr 2024 08:24:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714292672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQJyJVk6gQIgoeWCNjweQHoV2R23rcnn9pDzsHMahbQ=;
	b=tmUfiNAY2Hv7ktiFWwCON7M5jMWMVHTm4QTsIYSjDM281Yc9iMjd7CyglKpyCZ1gcxZ9EP
	+xqLhG6HqHd4xwYYHMdQOStykuRvxxzfQIeb1FYc+lPE3FiXGruW+V8WxhFYVp/64D+RZV
	rFnPOXAILRwKUBrDKdn7kBfHslr0pqkkBUCA2K3qhzOeAUHmpRpE2mETYUm4xCT686RQ5c
	QAw81KT7Qtq2Thlu3XYNDfCUXcrJ22Hh7TL1muGtqYDd5iqrtxWSwXPnGmnO+QWNkXeTb0
	HxyjMjytOD2oO+QiHLJG++zehcd8GuhohbK0mC5kmFhVZf52nmpnb9QPNPgV9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714292672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQJyJVk6gQIgoeWCNjweQHoV2R23rcnn9pDzsHMahbQ=;
	b=vQdZSX8SVgiChBBDX3YfN6ICojemZl+ZwVVIuF9fVbmoY6mLopPUhBKstSF6V3NOjbZ3KN
	3zrWks/uk3zZIrBQ==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/isolation: Prevent boot crash when the boot
 CPU is nohz_full
Cc: Chris von Recklinghausen <crecklin@redhat.com>,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Phil Auld <pauld@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240411143905.GA19288@redhat.com>
References: <20240411143905.GA19288@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171429267181.10875.2633061764782446732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     5097cbcb38e6e0d2627c9dde1985e91d2c9f880e
Gitweb:        https://git.kernel.org/tip/5097cbcb38e6e0d2627c9dde1985e91d2c9f880e
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 11 Apr 2024 16:39:05 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 28 Apr 2024 10:07:12 +02:00

sched/isolation: Prevent boot crash when the boot CPU is nohz_full

Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
include the boot CPU, which is no longer true after:

  08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full").

However after:

  aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")

the kernel will crash at boot time in this case; housekeeping_any_cpu()
returns an invalid CPU number until smp_init() brings the first
housekeeping CPU up.

Change housekeeping_any_cpu() to check the result of cpumask_any_and() and
return smp_processor_id() in this case.

This is just the simple and backportable workaround which fixes the
symptom, but smp_processor_id() at boot time should be safe at least for
type == HK_TYPE_TIMER, this more or less matches the tick_do_timer_boot_cpu
logic.

There is no worry about cpu_down(); tick_nohz_cpu_down() will not allow to
offline tick_do_timer_cpu (the 1st online housekeeping CPU).

Fixes: aae17ebb53cd ("workqueue: Avoid using isolated cpus' timers on queue_delayed_work")
Reported-by: Chris von Recklinghausen <crecklin@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240411143905.GA19288@redhat.com
Closes: https://lore.kernel.org/all/20240402105847.GA24832@redhat.com/
---
 Documentation/timers/no_hz.rst |  7 ++-----
 kernel/sched/isolation.c       | 11 ++++++++++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index f8786be..7fe8ef9 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -129,11 +129,8 @@ adaptive-tick CPUs:  At least one non-adaptive-tick CPU must remain
 online to handle timekeeping tasks in order to ensure that system
 calls like gettimeofday() returns accurate values on adaptive-tick CPUs.
 (This is not an issue for CONFIG_NO_HZ_IDLE=y because there are no running
-user processes to observe slight drifts in clock rate.)  Therefore, the
-boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
-"nohz_full=" mask that includes the boot CPU will result in a boot-time
-error message, and the boot CPU will be removed from the mask.  Note that
-this means that your system must have at least two CPUs in order for
+user processes to observe slight drifts in clock rate.) Note that this
+means that your system must have at least two CPUs in order for
 CONFIG_NO_HZ_FULL=y to do anything for you.
 
 Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c..2a262d3 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -46,7 +46,16 @@ int housekeeping_any_cpu(enum hk_type type)
 			if (cpu < nr_cpu_ids)
 				return cpu;
 
-			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
+			if (likely(cpu < nr_cpu_ids))
+				return cpu;
+			/*
+			 * Unless we have another problem this can only happen
+			 * at boot time before start_secondary() brings the 1st
+			 * housekeeping CPU up.
+			 */
+			WARN_ON_ONCE(system_state == SYSTEM_RUNNING ||
+				     type != HK_TYPE_TIMER);
 		}
 	}
 	return smp_processor_id();

