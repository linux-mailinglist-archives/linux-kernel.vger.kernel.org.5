Return-Path: <linux-kernel+bounces-60661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB7850829
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4840F282528
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A97859168;
	Sun, 11 Feb 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FrUZL7mW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6bJffnHP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E0266A7;
	Sun, 11 Feb 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707640893; cv=none; b=pMSZzSI5BJVGoDfoMRgwBwqJqUWeffpLRpJ48ivqEw9g28t7SwYAXUXbpywoNjnOuvgks28Eb+zDccNETIzcKLCbyxedG7WK7tOu91Gwd2h5ZvZBjMocnK1UFTuAaoB9Yqtf4pXiCr/kyvsjEf/8afgGcYZQ5e1NNgBwuwsajlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707640893; c=relaxed/simple;
	bh=7cuTK77OjwMcPgGPe4LXB+0xeYPPy2gnPG0Oq4cUHjU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N1TRQBQK4HaT8vN5g9DP90KJ7ZaXNkHPp8JlOiKtDGBfLQxu+Zr204712GH6w2W3BCEcy+06HX+Rly8mpxEojT1kIwvXQKbqgrM+/WZPZKeMB3FFrHpc2s8nyhkmj+bqlO/JOt6tOUm++S+3X4sqLOcP8MALrOqc2OUxIHzEV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FrUZL7mW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6bJffnHP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 11 Feb 2024 08:41:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707640889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DK9j+uZmUCooyPlMPC3ga8wjE+/B9aU1nf0GHjtruOg=;
	b=FrUZL7mWfxRy+sE4i+HQ1gpW4BadI2pDe9xYjb8Z63WI7EM0bl/8aQ+ShH19MNDbMY9RFz
	UwvvCNJyfRTNSvMdShSE3Khwq18RB3GQm/bvQPO3Y/FZ1wJWnPPciQO9MJnJn7vf0G5uJB
	RNVQs05UPZ858YWrKwXzgLSbSdFGdPjCEHicicSP1waMK7/lKZDJDhxYAEx7gZ2Cjy2+DT
	4dw8AHcLJbGgSljBi8LJJMwj00++9SKedf9tf5tDIVkY3WYWrYOZtNXVWBokkxpu0iIqkv
	hU5r90z6rkeByn1iSJKOXvCKaFbjW+mFBAGzB+hIwOjJR+MI7gAz8ZR6wpLRQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707640889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DK9j+uZmUCooyPlMPC3ga8wjE+/B9aU1nf0GHjtruOg=;
	b=6bJffnHPc3la52bYJe32FlZP8zKwsuye67wU6Rr+cccqOqA2civrnKVw7/N7v7jLfgi1ji
	Dowd3xLrOm6B0aAg==
From: "tip-bot2 for Peter Hilber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] treewide: Remove system_counterval_t.cs, which is
 never read
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240201010453.2212371-8-peter.hilber@opensynergy.com>
References: <20240201010453.2212371-8-peter.hilber@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170764088833.398.11611177380615244140.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     b152688c91313ab4073cff4a5e63ff4cc491c358
Gitweb:        https://git.kernel.org/tip/b152688c91313ab4073cff4a5e63ff4cc491c358
Author:        Peter Hilber <peter.hilber@opensynergy.com>
AuthorDate:    Thu, 01 Feb 2024 02:04:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Feb 2024 17:05:21 +01:00

treewide: Remove system_counterval_t.cs, which is never read

The clocksource pointer in struct system_counterval_t is not evaluated any
more. Remove the code setting the member, and the member itself.

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240201010453.2212371-8-peter.hilber@opensynergy.com

---
 arch/x86/kernel/tsc.c                | 14 ++------------
 drivers/clocksource/arm_arch_timer.c |  3 ---
 drivers/ptp/ptp_kvm_arm.c            |  2 +-
 drivers/ptp/ptp_kvm_common.c         |  4 +---
 drivers/ptp/ptp_kvm_x86.c            |  2 --
 include/linux/ptp_kvm.h              |  4 +---
 include/linux/timekeeping.h          |  3 ---
 7 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index fd567a0..5a69a49 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -53,7 +53,6 @@ static int __read_mostly tsc_force_recalibrate;
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
-static struct clocksource *art_related_clocksource;
 static bool have_art;
 
 struct cyc2ns {
@@ -1313,7 +1312,6 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 	res += tmp + art_to_tsc_offset;
 
 	return (struct system_counterval_t) {
-		.cs	= art_related_clocksource,
 		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
 		.cycles	= res,
 	};
@@ -1337,9 +1335,6 @@ EXPORT_SYMBOL(convert_art_to_tsc);
  *	corresponding clocksource:
  *	cycles:		System counter value
  *	cs_id:		The clocksource ID for validating comparability
- *	cs:		Clocksource corresponding to system counter value. Used
- *			by timekeeping code to verify comparability of two cycle
- *			values.
  */
 
 struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
@@ -1355,7 +1350,6 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
 	res += tmp;
 
 	return (struct system_counterval_t) {
-		.cs	= art_related_clocksource,
 		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
 		.cycles	= res,
 	};
@@ -1464,10 +1458,8 @@ out:
 	if (tsc_unstable)
 		goto unreg;
 
-	if (boot_cpu_has(X86_FEATURE_ART)) {
-		art_related_clocksource = &clocksource_tsc;
+	if (boot_cpu_has(X86_FEATURE_ART))
 		have_art = true;
-	}
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
@@ -1492,10 +1484,8 @@ static int __init init_tsc_clocksource(void)
 	 * the refined calibration and directly register it as a clocksource.
 	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
-		if (boot_cpu_has(X86_FEATURE_ART)) {
-			art_related_clocksource = &clocksource_tsc;
+		if (boot_cpu_has(X86_FEATURE_ART))
 			have_art = true;
-		}
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 45a0287..8d4a520 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1807,7 +1807,6 @@ TIMER_ACPI_DECLARE(arch_timer, ACPI_SIG_GTDT, arch_timer_acpi_init);
 #endif
 
 int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts,
-				 struct clocksource **cs,
 				 enum clocksource_ids *cs_id)
 {
 	struct arm_smccc_res hvc_res;
@@ -1832,8 +1831,6 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *ts,
 	*ts = ktime_to_timespec64(ktime);
 	if (cycle)
 		*cycle = (u64)hvc_res.a2 << 32 | hvc_res.a3;
-	if (cs)
-		*cs = &clocksource_counter;
 	if (cs_id)
 		*cs_id = CSID_ARM_ARCH_COUNTER;
 
diff --git a/drivers/ptp/ptp_kvm_arm.c b/drivers/ptp/ptp_kvm_arm.c
index 017bb5f..e68e694 100644
--- a/drivers/ptp/ptp_kvm_arm.c
+++ b/drivers/ptp/ptp_kvm_arm.c
@@ -28,5 +28,5 @@ void kvm_arch_ptp_exit(void)
 
 int kvm_arch_ptp_get_clock(struct timespec64 *ts)
 {
-	return kvm_arch_ptp_get_crosststamp(NULL, ts, NULL, NULL);
+	return kvm_arch_ptp_get_crosststamp(NULL, ts, NULL);
 }
diff --git a/drivers/ptp/ptp_kvm_common.c b/drivers/ptp/ptp_kvm_common.c
index f6683ba..15ccb7d 100644
--- a/drivers/ptp/ptp_kvm_common.c
+++ b/drivers/ptp/ptp_kvm_common.c
@@ -30,14 +30,13 @@ static int ptp_kvm_get_time_fn(ktime_t *device_time,
 {
 	enum clocksource_ids cs_id;
 	struct timespec64 tspec;
-	struct clocksource *cs;
 	u64 cycle;
 	int ret;
 
 	spin_lock(&kvm_ptp_lock);
 
 	preempt_disable_notrace();
-	ret = kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs, &cs_id);
+	ret = kvm_arch_ptp_get_crosststamp(&cycle, &tspec, &cs_id);
 	if (ret) {
 		spin_unlock(&kvm_ptp_lock);
 		preempt_enable_notrace();
@@ -47,7 +46,6 @@ static int ptp_kvm_get_time_fn(ktime_t *device_time,
 	preempt_enable_notrace();
 
 	system_counter->cycles = cycle;
-	system_counter->cs = cs;
 	system_counter->cs_id = cs_id;
 
 	*device_time = timespec64_to_ktime(tspec);
diff --git a/drivers/ptp/ptp_kvm_x86.c b/drivers/ptp/ptp_kvm_x86.c
index 2782442..617c8d6 100644
--- a/drivers/ptp/ptp_kvm_x86.c
+++ b/drivers/ptp/ptp_kvm_x86.c
@@ -93,7 +93,6 @@ int kvm_arch_ptp_get_clock(struct timespec64 *ts)
 }
 
 int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
-			      struct clocksource **cs,
 			      enum clocksource_ids *cs_id)
 {
 	struct pvclock_vcpu_time_info *src;
@@ -124,7 +123,6 @@ int kvm_arch_ptp_get_crosststamp(u64 *cycle, struct timespec64 *tspec,
 		*cycle = __pvclock_read_cycles(src, clock_pair->tsc);
 	} while (pvclock_read_retry(src, version));
 
-	*cs = &kvm_clock;
 	*cs_id = CSID_X86_KVM_CLK;
 
 	return 0;
diff --git a/include/linux/ptp_kvm.h b/include/linux/ptp_kvm.h
index 95b3d4d..e8c74fa 100644
--- a/include/linux/ptp_kvm.h
+++ b/include/linux/ptp_kvm.h
@@ -12,13 +12,11 @@
 #include <linux/types.h>
 
 struct timespec64;
-struct clocksource;
 
 int kvm_arch_ptp_init(void);
 void kvm_arch_ptp_exit(void);
 int kvm_arch_ptp_get_clock(struct timespec64 *ts);
 int kvm_arch_ptp_get_crosststamp(u64 *cycle,
-		struct timespec64 *tspec, struct clocksource **cs,
-		enum clocksource_ids *cs_id);
+		struct timespec64 *tspec, enum clocksource_ids *cs_id);
 
 #endif /* _PTP_KVM_H_ */
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 3538c5b..7e50cbd 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -271,8 +271,6 @@ struct system_device_crosststamp {
  * struct system_counterval_t - system counter value with the ID of the
  *				corresponding clocksource
  * @cycles:	System counter value
- * @cs:		Clocksource corresponding to system counter value. Timekeeping
- *		code now evaluates cs_id instead.
  * @cs_id:	Clocksource ID corresponding to system counter value. Used by
  *		timekeeping code to verify comparability of two cycle values.
  *		The default ID, CSID_GENERIC, does not identify a specific
@@ -280,7 +278,6 @@ struct system_device_crosststamp {
  */
 struct system_counterval_t {
 	u64			cycles;
-	struct clocksource	*cs;
 	enum clocksource_ids	cs_id;
 };
 

