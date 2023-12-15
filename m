Return-Path: <linux-kernel+bounces-1262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C0814C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C61C23910
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE11F3BB43;
	Fri, 15 Dec 2023 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wqNYy4Hy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="77FOvPPz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C9C374D4;
	Fri, 15 Dec 2023 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Dec 2023 16:10:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702656605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6acx+RWzAs+leXBAMRYDcKzcqztD8teBvwavRFvgEtA=;
	b=wqNYy4HyJ7smHQHd1X1dEgJgdsTlG2uM2ubBwB/bJXnZgWMoDGvDH00a2PYByV6YT2RMQe
	/3YKE+riwyJxKZBc6qFtosN8ZVJu4a8okNM0Lm4hELDN0NhvuLbBs1WE3mjCBy7p0MmqxH
	JsJ/gyOLo80/sSm4RfPZJrv/l8Y8cNmZMcID8kZoOnNF6bQ0yEziOkYXyIY49V6MeSLfRf
	ARD3U/9yJBrAwCJxJcbZSqZacz50ch+j13BfHUQXYbK1JrWK8zBkCcoX42ozcGnyjpnWSt
	yIhXl1p4GLc2yabypyzxgzOnZCVwMOhPqASVOGdMuuKg4ZPKRR91zxIeTuRP9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702656605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6acx+RWzAs+leXBAMRYDcKzcqztD8teBvwavRFvgEtA=;
	b=77FOvPPz2bjXCGZmkUWCkLgWvX05f1Qwg6nzXm3vsoE5dJc904GgAt30Dq316oi2/UgIzU
	Zoc1HcERw/4Bp6Ag==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Remove old CMCI storm mitigation code
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231115195450.12963-2-tony.luck@intel.com>
References: <20231115195450.12963-2-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170265660471.398.8068343149455379081.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     3ed57b41a4125609e9fd03e32228aec61d95fe1f
Gitweb:        https://git.kernel.org/tip/3ed57b41a4125609e9fd03e32228aec61d95fe1f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 15 Nov 2023 11:54:48 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 15 Dec 2023 13:44:12 +01:00

x86/mce: Remove old CMCI storm mitigation code

When a "storm" of corrected machine check interrupts (CMCI) is detected
this code mitigates by disabling CMCI interrupt signalling from all of
the banks owned by the CPU that saw the storm.

There are problems with this approach:

1) It is very coarse grained. In all likelihood only one of the banks
   was generating the interrupts, but CMCI is disabled for all.  This
   means Linux may delay seeing and processing errors logged from other
   banks.

2) Although CMCI stands for Corrected Machine Check Interrupt, it is
   also used to signal when an uncorrected error is logged. This is
   a problem because these errors should be handled in a timely manner.

Delete all this code in preparation for a finer grained solution.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20231115195450.12963-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c     |  20 +----
 arch/x86/kernel/cpu/mce/intel.c    | 145 +----------------------------
 arch/x86/kernel/cpu/mce/internal.h |   6 +-
 3 files changed, 1 insertion(+), 170 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1642018..b2ef487 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1617,13 +1617,6 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
 static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
 static DEFINE_PER_CPU(struct timer_list, mce_timer);
 
-static unsigned long mce_adjust_timer_default(unsigned long interval)
-{
-	return interval;
-}
-
-static unsigned long (*mce_adjust_timer)(unsigned long interval) = mce_adjust_timer_default;
-
 static void __start_timer(struct timer_list *t, unsigned long interval)
 {
 	unsigned long when = jiffies + interval;
@@ -1653,15 +1646,9 @@ static void mce_timer_fn(struct timer_list *t)
 
 	iv = __this_cpu_read(mce_next_interval);
 
-	if (mce_available(this_cpu_ptr(&cpu_info))) {
+	if (mce_available(this_cpu_ptr(&cpu_info)))
 		mc_poll_banks();
 
-		if (mce_intel_cmci_poll()) {
-			iv = mce_adjust_timer(iv);
-			goto done;
-		}
-	}
-
 	/*
 	 * Alert userspace if needed. If we logged an MCE, reduce the polling
 	 * interval, otherwise increase the polling interval.
@@ -1671,7 +1658,6 @@ static void mce_timer_fn(struct timer_list *t)
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
 
-done:
 	__this_cpu_write(mce_next_interval, iv);
 	__start_timer(t, iv);
 }
@@ -2011,7 +1997,6 @@ static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
 
 	intel_init_cmci();
 	intel_init_lmce();
-	mce_adjust_timer = cmci_intel_adjust_timer;
 }
 
 static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
@@ -2024,7 +2009,6 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		mce_intel_feature_init(c);
-		mce_adjust_timer = cmci_intel_adjust_timer;
 		break;
 
 	case X86_VENDOR_AMD: {
@@ -2678,8 +2662,6 @@ static void mce_reenable_cpu(void)
 
 static int mce_cpu_dead(unsigned int cpu)
 {
-	mce_intel_hcpu_update(cpu);
-
 	/* intentionally ignoring frozen here */
 	if (!cpuhp_tasks_frozen)
 		cmci_rediscover();
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 52bce53..fc4ffc4 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -42,15 +42,6 @@
 static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
 
 /*
- * CMCI storm detection backoff counter
- *
- * During storm, we reset this counter to INITIAL_CHECK_INTERVAL in case we've
- * encountered an error. If not, we decrement it by one. We signal the end of
- * the CMCI storm when it reaches 0.
- */
-static DEFINE_PER_CPU(int, cmci_backoff_cnt);
-
-/*
  * cmci_discover_lock protects against parallel discovery attempts
  * which could race against each other.
  */
@@ -64,21 +55,6 @@ static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
 static DEFINE_SPINLOCK(cmci_poll_lock);
 
 #define CMCI_THRESHOLD		1
-#define CMCI_POLL_INTERVAL	(30 * HZ)
-#define CMCI_STORM_INTERVAL	(HZ)
-#define CMCI_STORM_THRESHOLD	15
-
-static DEFINE_PER_CPU(unsigned long, cmci_time_stamp);
-static DEFINE_PER_CPU(unsigned int, cmci_storm_cnt);
-static DEFINE_PER_CPU(unsigned int, cmci_storm_state);
-
-enum {
-	CMCI_STORM_NONE,
-	CMCI_STORM_ACTIVE,
-	CMCI_STORM_SUBSIDED,
-};
-
-static atomic_t cmci_storm_on_cpus;
 
 static int cmci_supported(int *banks)
 {
@@ -134,124 +110,6 @@ static bool lmce_supported(void)
 	return tmp & FEAT_CTL_LMCE_ENABLED;
 }
 
-bool mce_intel_cmci_poll(void)
-{
-	if (__this_cpu_read(cmci_storm_state) == CMCI_STORM_NONE)
-		return false;
-
-	/*
-	 * Reset the counter if we've logged an error in the last poll
-	 * during the storm.
-	 */
-	if (machine_check_poll(0, this_cpu_ptr(&mce_banks_owned)))
-		this_cpu_write(cmci_backoff_cnt, INITIAL_CHECK_INTERVAL);
-	else
-		this_cpu_dec(cmci_backoff_cnt);
-
-	return true;
-}
-
-void mce_intel_hcpu_update(unsigned long cpu)
-{
-	if (per_cpu(cmci_storm_state, cpu) == CMCI_STORM_ACTIVE)
-		atomic_dec(&cmci_storm_on_cpus);
-
-	per_cpu(cmci_storm_state, cpu) = CMCI_STORM_NONE;
-}
-
-static void cmci_toggle_interrupt_mode(bool on)
-{
-	unsigned long flags, *owned;
-	int bank;
-	u64 val;
-
-	raw_spin_lock_irqsave(&cmci_discover_lock, flags);
-	owned = this_cpu_ptr(mce_banks_owned);
-	for_each_set_bit(bank, owned, MAX_NR_BANKS) {
-		rdmsrl(MSR_IA32_MCx_CTL2(bank), val);
-
-		if (on)
-			val |= MCI_CTL2_CMCI_EN;
-		else
-			val &= ~MCI_CTL2_CMCI_EN;
-
-		wrmsrl(MSR_IA32_MCx_CTL2(bank), val);
-	}
-	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
-}
-
-unsigned long cmci_intel_adjust_timer(unsigned long interval)
-{
-	if ((this_cpu_read(cmci_backoff_cnt) > 0) &&
-	    (__this_cpu_read(cmci_storm_state) == CMCI_STORM_ACTIVE)) {
-		mce_notify_irq();
-		return CMCI_STORM_INTERVAL;
-	}
-
-	switch (__this_cpu_read(cmci_storm_state)) {
-	case CMCI_STORM_ACTIVE:
-
-		/*
-		 * We switch back to interrupt mode once the poll timer has
-		 * silenced itself. That means no events recorded and the timer
-		 * interval is back to our poll interval.
-		 */
-		__this_cpu_write(cmci_storm_state, CMCI_STORM_SUBSIDED);
-		if (!atomic_sub_return(1, &cmci_storm_on_cpus))
-			pr_notice("CMCI storm subsided: switching to interrupt mode\n");
-
-		fallthrough;
-
-	case CMCI_STORM_SUBSIDED:
-		/*
-		 * We wait for all CPUs to go back to SUBSIDED state. When that
-		 * happens we switch back to interrupt mode.
-		 */
-		if (!atomic_read(&cmci_storm_on_cpus)) {
-			__this_cpu_write(cmci_storm_state, CMCI_STORM_NONE);
-			cmci_toggle_interrupt_mode(true);
-			cmci_recheck();
-		}
-		return CMCI_POLL_INTERVAL;
-	default:
-
-		/* We have shiny weather. Let the poll do whatever it thinks. */
-		return interval;
-	}
-}
-
-static bool cmci_storm_detect(void)
-{
-	unsigned int cnt = __this_cpu_read(cmci_storm_cnt);
-	unsigned long ts = __this_cpu_read(cmci_time_stamp);
-	unsigned long now = jiffies;
-	int r;
-
-	if (__this_cpu_read(cmci_storm_state) != CMCI_STORM_NONE)
-		return true;
-
-	if (time_before_eq(now, ts + CMCI_STORM_INTERVAL)) {
-		cnt++;
-	} else {
-		cnt = 1;
-		__this_cpu_write(cmci_time_stamp, now);
-	}
-	__this_cpu_write(cmci_storm_cnt, cnt);
-
-	if (cnt <= CMCI_STORM_THRESHOLD)
-		return false;
-
-	cmci_toggle_interrupt_mode(false);
-	__this_cpu_write(cmci_storm_state, CMCI_STORM_ACTIVE);
-	r = atomic_add_return(1, &cmci_storm_on_cpus);
-	mce_timer_kick(CMCI_STORM_INTERVAL);
-	this_cpu_write(cmci_backoff_cnt, INITIAL_CHECK_INTERVAL);
-
-	if (r == 1)
-		pr_notice("CMCI storm detected: switching to poll mode\n");
-	return true;
-}
-
 /*
  * The interrupt handler. This is called on every event.
  * Just call the poller directly to log any events.
@@ -260,9 +118,6 @@ static bool cmci_storm_detect(void)
  */
 static void intel_threshold_interrupt(void)
 {
-	if (cmci_storm_detect())
-		return;
-
 	machine_check_poll(MCP_TIMESTAMP, this_cpu_ptr(&mce_banks_owned));
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index e13a26c..b18e990 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -41,9 +41,6 @@ struct dentry *mce_get_debugfs_dir(void);
 extern mce_banks_t mce_banks_ce_disabled;
 
 #ifdef CONFIG_X86_MCE_INTEL
-unsigned long cmci_intel_adjust_timer(unsigned long interval);
-bool mce_intel_cmci_poll(void);
-void mce_intel_hcpu_update(unsigned long cpu);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
 void intel_init_lmce(void);
@@ -51,9 +48,6 @@ void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
 bool intel_mce_usable_address(struct mce *m);
 #else
-# define cmci_intel_adjust_timer mce_adjust_timer_default
-static inline bool mce_intel_cmci_poll(void) { return false; }
-static inline void mce_intel_hcpu_update(unsigned long cpu) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }

