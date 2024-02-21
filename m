Return-Path: <linux-kernel+bounces-75265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B085E571
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E902853E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C041385659;
	Wed, 21 Feb 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZ6+DW4J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FxeCX53r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC8C8527B;
	Wed, 21 Feb 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539683; cv=none; b=lTCnWTOOuwY+CEGAPRmKsF6BwF/5cdpRNK0STNHd21ez25NztH78ijvWf/AXwMGg2q1VBLbySZKBHz2EY9KvPFmdqNQN2LZoKYvVO0hvTmFOsuluNmr1Tdyhq9Jo8sTliICtlIwl7wWcefi7jgKTFWkpkU2SgednP7ZkOWPb640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539683; c=relaxed/simple;
	bh=03pyyXVeUrrkl2pwj2Tzwc+j/8/UljwnXTiftFoaelw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uL4xM1k1HhkN1wXD4EEH3W2dlxYzpOTGWlqf3W99t6g5otqdEOXWReMtVgsuS+A2obJv79iKN8XreXphMEzHGXfNs5Z89ukBT11+/7C07GpdtFQFU4KkfwuVspbESb+3QDde7Jm3qVueGLwCXDS4BUaq6L51xrrq96am/Xfw+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZ6+DW4J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FxeCX53r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Feb 2024 18:21:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708539679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCsALEvBKvvJRJg2n9eHA9uu/NuYU9FnCRPPxTvk7pw=;
	b=UZ6+DW4J/hIYJRIdcu3SAxzE1TuukEXzpaq1gPLItENRo621YTTVPxqFelJqlCdR/rZ58r
	XeZtsPZV88B0ZiqNWkmCg3W/nAAitlsf2P3SwuHtp9YbPc/dxuUzIhMUVhCYGT6bQDksFH
	95Ai1cJ9LxbXXuOxatMFwKzPOf0Yb+g8tVPSD5FOmV6Zbpn6vAjLwca/3XxS3k29FndnaO
	MH538xJg6G+GV0m8eSLbWrpCl20L5il4SjLK2CdtCdnCOJxpWN9yQwS2Wa3RNDloPZTerz
	ASXboowN84RiyHOGqkjwHRuzbdKJiCMCHsPgD+abe0maHnAkio2Ci4nh4G2Mdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708539679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCsALEvBKvvJRJg2n9eHA9uu/NuYU9FnCRPPxTvk7pw=;
	b=FxeCX53rsNjccmW5WaCv6IpwMXK4WdArLvR8PrNYwtg+gzuvGmHQbmO6Mp57BVz5nsUYpk
	yEcs5rgrRb+NrgDA==
From: "tip-bot2 for Feng Tang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] clocksource: Scale the watchdog read retries automatically
Cc: Feng Tang <feng.tang@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jin Wang <jin1.wang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221060859.1027450-1-feng.tang@intel.com>
References: <20240221060859.1027450-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170853967749.398.12473568848886584851.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2ed08e4bc53298db3f87b528cd804cb0cce066a9
Gitweb:        https://git.kernel.org/tip/2ed08e4bc53298db3f87b528cd804cb0cce066a9
Author:        Feng Tang <feng.tang@intel.com>
AuthorDate:    Wed, 21 Feb 2024 14:08:59 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 Feb 2024 12:00:42 +01:00

clocksource: Scale the watchdog read retries automatically

On a 8-socket server the TSC is wrongly marked as 'unstable' and disabled
during boot time on about one out of 120 boot attempts:

    clocksource: timekeeping watchdog on CPU227: wd-tsc-wd excessive read-back delay of 153560ns vs. limit of 125000ns,
    wd-wd read-back delay only 11440ns, attempt 3, marking tsc unstable
    tsc: Marking TSC unstable due to clocksource watchdog
    TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
    sched_clock: Marking unstable (119294969739, 159204297)<-(125446229205, -5992055152)
    clocksource: Checking clocksource tsc synchronization from CPU 319 to CPUs 0,99,136,180,210,542,601,896.
    clocksource: Switched to clocksource hpet

The reason is that for platform with a large number of CPUs, there are
sporadic big or huge read latencies while reading the watchog/clocksource
during boot or when system is under stress work load, and the frequency and
maximum value of the latency goes up with the number of online CPUs.

The cCurrent code already has logic to detect and filter such high latency
case by reading the watchdog twice and checking the two deltas. Due to the
randomness of the latency, there is a low probabilty that the first delta
(latency) is big, but the second delta is small and looks valid. The
watchdog code retries the readouts by default twice, which is not
necessarily sufficient for systems with a large number of CPUs.

There is a command line parameter 'max_cswd_read_retries' which allows to
increase the number of retries, but that's not user friendly as it needs to
be tweaked per system. As the number of required retries is proportional to
the number of online CPUs, this parameter can be calculated at runtime.

Scale and enlarge the number of retries according to the number of online
CPUs and remove the command line parameter completely.

[ tglx: Massaged change log and comments ]

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jin Wang <jin1.wang@intel.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20240221060859.1027450-1-feng.tang@intel.com
---
 Documentation/admin-guide/kernel-parameters.txt   |  6 +------
 include/linux/clocksource.h                       | 14 +++++++++++++-
 kernel/time/clocksource-wdtest.c                  | 13 +++++++------
 kernel/time/clocksource.c                         | 10 ++++------
 tools/testing/selftests/rcutorture/bin/torture.sh |  2 +-
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25..763e96d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -679,12 +679,6 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clocksource.max_cswd_read_retries= [KNL]
-			Number of clocksource_watchdog() retries due to
-			external delays before the clock will be marked
-			unstable.  Defaults to two retries, that is,
-			three attempts to read the clock under test.
-
 	clocksource.verify_n_cpus= [KNL]
 			Limit the number of CPUs checked for clocksources
 			marked with CLOCK_SOURCE_VERIFY_PERCPU that
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b..0ad8b55 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -291,7 +291,19 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
-extern ulong max_cswd_read_retries;
+static inline unsigned int clocksource_get_max_watchdog_retry(void)
+{
+	/*
+	 * When system is in the boot phase or under heavy workload, there
+	 * can be random big latencies during the clocksource/watchdog
+	 * read, so allow retries to filter the noise latency. As the
+	 * latency's frequency and maximum value goes up with the number of
+	 * CPUs, scale the number of retries with the number of online
+	 * CPUs.
+	 */
+	return (ilog2(num_online_cpus()) / 2) + 1;
+}
+
 void clocksource_verify_percpu(struct clocksource *cs);
 
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index df922f4..d06185e 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -104,8 +104,8 @@ static void wdtest_ktime_clocksource_reset(void)
 static int wdtest_func(void *arg)
 {
 	unsigned long j1, j2;
+	int i, max_retries;
 	char *s;
-	int i;
 
 	schedule_timeout_uninterruptible(holdoff * HZ);
 
@@ -139,18 +139,19 @@ static int wdtest_func(void *arg)
 	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
 
 	/* Verify tsc-like stability with various numbers of errors injected. */
-	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
-		if (i <= 1 && i < max_cswd_read_retries)
+	max_retries = clocksource_get_max_watchdog_retry();
+	for (i = 0; i <= max_retries + 1; i++) {
+		if (i <= 1 && i < max_retries)
 			s = "";
-		else if (i <= max_cswd_read_retries)
+		else if (i <= max_retries)
 			s = ", expect message";
 		else
 			s = ", expect clock skew";
-		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
+		pr_info("--- Watchdog with %dx error injection, %d retries%s.\n", i, max_retries, s);
 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
 		schedule_timeout_uninterruptible(2 * HZ);
 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
-		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
+		WARN_ON_ONCE((i <= max_retries) !=
 			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
 		wdtest_ktime_clocksource_reset();
 	}
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 4ef0665..e5b260a 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -210,9 +210,6 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-ulong max_cswd_read_retries = 2;
-module_param(max_cswd_read_retries, ulong, 0644);
-EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
@@ -224,11 +221,12 @@ enum wd_read_status {
 
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
-	unsigned int nretries;
+	unsigned int nretries, max_retries;
 	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
 
-	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
+	max_retries = clocksource_get_max_watchdog_retry();
+	for (nretries = 0; nretries <= max_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
@@ -240,7 +238,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, 
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_cswd_read_retries) {
+			if (nretries > 1 || nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index d5a0d8a..bbac5f4 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -567,7 +567,7 @@ then
 	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-1" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1 tsc=watchdog"
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-2" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
 	# In case our work is already done...

