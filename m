Return-Path: <linux-kernel+bounces-142921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC438A3210
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E909928376B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344A71487DC;
	Fri, 12 Apr 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x7xXPb9U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OKGtZdj3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C210147C8F;
	Fri, 12 Apr 2024 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934873; cv=none; b=D0lWDhGsO4zmQcIfbdJxb1ZPfNs3QqeD0srnEwWSQJwfv6XuICvBpaKHJ8cqhCaTdJp9xpvEU9TInA71mxCf/8lIFk9Z/BW6LITJygmnAcSYm8mYcH3FNAt5V8O0UVISF5DSBcgI7rtA1Gcb/NPr1M71bghyrLXUhcxhQJA8Uuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934873; c=relaxed/simple;
	bh=frKJkUH5HOAUMC8MElNqLZsDub/NkDADFAmaaaCNKKA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MRliRbgVhBBPakWUmSZvyxxmg2+dmWMrsXU8GbqjuN4aUvtT5/zAObIyR5p7NmERQruPGzhmNXmq4DmDIKQKgH0/Fmw06dzS9TzokbN3ytJkZYlUH71uonySI9mu/eXirLt864jDrvtQZ0ZlnquZAvblxmKv40VFVlszuxerARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x7xXPb9U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OKGtZdj3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 15:14:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712934869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aZ/fu7UYntQNPJjhyMDLFe1NRzC+T4RwtTLr3ZFSE4=;
	b=x7xXPb9U2ZNoKurGPTZnUOl92+tasvP42J9YK7WVQ1JW8lsukYCIK1GIL9i9DG41t5Aprg
	pfUXgvDkAXbK5w5nHeT8Yu7aJMQi2Y6uZxw3y1D1hY9piJUrJzjWA6XadQJbNH/eyR4zgB
	DFf3bW7Qpce6g4OOA5cUV4a2u3DmMhXT3PL0DcLJ11KYhp6VXzx0oa2ulAh8MJuBluPBKd
	XPYilG2kxC7ACVOU311VMvalc1MdrJZWS1AJ8ps/OpjbFchV0W6gEk3cSLlihGyZmoaLt5
	dCZlWH8AItoDI8YRs5+k4uZjb6qt/2nAWaUlAMabKRmmMDyb+P+jCaLT6euokg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712934869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aZ/fu7UYntQNPJjhyMDLFe1NRzC+T4RwtTLr3ZFSE4=;
	b=OKGtZdj37StrUD6QUaG3iNP1B1POjHi6E4QgeK1SvnbOhsQgC4FrZ84R/M3SePk/+jG2sC
	XNrmOX05aJ4HHxCw==
From: "tip-bot2 for Bitao Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] watchdog/softlockup: Report the most frequent interrupts
Cc: Bitao Hu <yaoma@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>,
 Liu Song <liusong@linux.alibaba.com>,
 Douglas Anderson <dianders@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240411074134.30922-6-yaoma@linux.alibaba.com>
References: <20240411074134.30922-6-yaoma@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171293486882.10875.2511614863489298418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e9a9292e2368e9be4a48aae6ff8aafa3433133e6
Gitweb:        https://git.kernel.org/tip/e9a9292e2368e9be4a48aae6ff8aafa3433133e6
Author:        Bitao Hu <yaoma@linux.alibaba.com>
AuthorDate:    Thu, 11 Apr 2024 15:41:34 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 12 Apr 2024 17:08:06 +02:00

watchdog/softlockup: Report the most frequent interrupts

When the watchdog determines that the current soft lockup is due to an
interrupt storm based on CPU utilization, reporting the most frequent
interrupts could be good enough for further troubleshooting.

Below is an example of interrupt storm. The call tree does not provide
useful information, but analyzing which interrupt caused the soft lockup by
comparing the counts of interrupts during the lockup period allows to
identify the culprit.

[  638.870231] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [swapper/9:0]
[  638.870825] CPU#9 Utilization every 4s during lockup:
[  638.871194]  #1:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.871652]  #2:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.872107]  #3:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.872563]  #4:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.873018]  #5:   0% system,          0% softirq,   100% hardirq,     0% idle
[  638.873494] CPU#9 Detect HardIRQ Time exceeds 50%. Most frequent HardIRQs:
[  638.873994]  #1: 330945      irq#7
[  638.874236]  #2: 31          irq#82
[  638.874493]  #3: 10          irq#10
[  638.874744]  #4: 2           irq#89
[  638.874992]  #5: 1           irq#102
..
[  638.875313] Call trace:
[  638.875315]  __do_softirq+0xa8/0x364

Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Liu Song <liusong@linux.alibaba.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20240411074134.30922-6-yaoma@linux.alibaba.com

---
 kernel/watchdog.c | 116 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index ef8ebd3..d12ff74 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -12,22 +12,25 @@
 
 #define pr_fmt(fmt) "watchdog: " fmt
 
-#include <linux/mm.h>
 #include <linux/cpu.h>
-#include <linux/nmi.h>
 #include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/kernel_stat.h>
+#include <linux/kvm_para.h>
 #include <linux/math64.h>
+#include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/nmi.h>
+#include <linux/stop_machine.h>
 #include <linux/sysctl.h>
 #include <linux/tick.h>
+
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
-#include <linux/stop_machine.h>
 
 #include <asm/irq_regs.h>
-#include <linux/kvm_para.h>
 
 static DEFINE_MUTEX(watchdog_mutex);
 
@@ -418,13 +421,105 @@ static void print_cpustat(void)
 	}
 }
 
+#define HARDIRQ_PERCENT_THRESH          50
+#define NUM_HARDIRQ_REPORT              5
+struct irq_counts {
+	int irq;
+	u32 counts;
+};
+
+static DEFINE_PER_CPU(bool, snapshot_taken);
+
+/* Tabulate the most frequent interrupts. */
+static void tabulate_irq_count(struct irq_counts *irq_counts, int irq, u32 counts, int rank)
+{
+	int i;
+	struct irq_counts new_count = {irq, counts};
+
+	for (i = 0; i < rank; i++) {
+		if (counts > irq_counts[i].counts)
+			swap(new_count, irq_counts[i]);
+	}
+}
+
+/*
+ * If the hardirq time exceeds HARDIRQ_PERCENT_THRESH% of the sample_period,
+ * then the cause of softlockup might be interrupt storm. In this case, it
+ * would be useful to start interrupt counting.
+ */
+static bool need_counting_irqs(void)
+{
+	u8 util;
+	int tail = __this_cpu_read(cpustat_tail);
+
+	tail = (tail + NUM_HARDIRQ_REPORT - 1) % NUM_HARDIRQ_REPORT;
+	util = __this_cpu_read(cpustat_util[tail][STATS_HARDIRQ]);
+	return util > HARDIRQ_PERCENT_THRESH;
+}
+
+static void start_counting_irqs(void)
+{
+	if (!__this_cpu_read(snapshot_taken)) {
+		kstat_snapshot_irqs();
+		__this_cpu_write(snapshot_taken, true);
+	}
+}
+
+static void stop_counting_irqs(void)
+{
+	__this_cpu_write(snapshot_taken, false);
+}
+
+static void print_irq_counts(void)
+{
+	unsigned int i, count;
+	struct irq_counts irq_counts_sorted[NUM_HARDIRQ_REPORT] = {
+		{-1, 0}, {-1, 0}, {-1, 0}, {-1, 0}, {-1, 0}
+	};
+
+	if (__this_cpu_read(snapshot_taken)) {
+		for_each_active_irq(i) {
+			count = kstat_get_irq_since_snapshot(i);
+			tabulate_irq_count(irq_counts_sorted, i, count, NUM_HARDIRQ_REPORT);
+		}
+
+		/*
+		 * Outputting the "watchdog" prefix on every line is redundant and not
+		 * concise, and the original alarm information is sufficient for
+		 * positioning in logs, hence here printk() is used instead of pr_crit().
+		 */
+		printk(KERN_CRIT "CPU#%d Detect HardIRQ Time exceeds %d%%. Most frequent HardIRQs:\n",
+		       smp_processor_id(), HARDIRQ_PERCENT_THRESH);
+
+		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
+			if (irq_counts_sorted[i].irq == -1)
+				break;
+
+			printk(KERN_CRIT "\t#%u: %-10u\tirq#%d\n",
+			       i + 1, irq_counts_sorted[i].counts,
+			       irq_counts_sorted[i].irq);
+		}
+
+		/*
+		 * If the hardirq time is less than HARDIRQ_PERCENT_THRESH% in the last
+		 * sample_period, then we suspect the interrupt storm might be subsiding.
+		 */
+		if (!need_counting_irqs())
+			stop_counting_irqs();
+	}
+}
+
 static void report_cpu_status(void)
 {
 	print_cpustat();
+	print_irq_counts();
 }
 #else
 static inline void update_cpustat(void) { }
 static inline void report_cpu_status(void) { }
+static inline bool need_counting_irqs(void) { return false; }
+static inline void start_counting_irqs(void) { }
+static inline void stop_counting_irqs(void) { }
 #endif
 
 /*
@@ -528,6 +623,18 @@ static int is_softlockup(unsigned long touch_ts,
 			 unsigned long now)
 {
 	if ((watchdog_enabled & WATCHDOG_SOFTOCKUP_ENABLED) && watchdog_thresh) {
+		/*
+		 * If period_ts has not been updated during a sample_period, then
+		 * in the subsequent few sample_periods, period_ts might also not
+		 * be updated, which could indicate a potential softlockup. In
+		 * this case, if we suspect the cause of the potential softlockup
+		 * might be interrupt storm, then we need to count the interrupts
+		 * to find which interrupt is storming.
+		 */
+		if (time_after_eq(now, period_ts + get_softlockup_thresh() / NUM_SAMPLE_PERIODS) &&
+		    need_counting_irqs())
+			start_counting_irqs();
+
 		/* Warn about unreasonable delays. */
 		if (time_after(now, period_ts + get_softlockup_thresh()))
 			return now - touch_ts;
@@ -550,6 +657,7 @@ static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
 static int softlockup_fn(void *data)
 {
 	update_touch_ts();
+	stop_counting_irqs();
 	complete(this_cpu_ptr(&softlockup_completion));
 
 	return 0;

