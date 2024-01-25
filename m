Return-Path: <linux-kernel+bounces-38153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6F483BBA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3904E2883A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51A17BCB;
	Thu, 25 Jan 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3K8roo9V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFxAVwdQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AA17727;
	Thu, 25 Jan 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170636; cv=none; b=bRb2yrrDszxQwR6IBCPi7ZwySgvRTXcz7UHp2b5wYVzkoLCX2PlhFoqAPCV9tf0u7PvIiobJ9rrHsHZQ23/I8jP1v5NLZjt0DiS0+ziOw2Zp4WTO+aFts+rVFy5bXflZsE2QPuT0C4fGQSc4sYL9HA8VHm3y/1PsELe5mu9A2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170636; c=relaxed/simple;
	bh=V40nGmNyn/o+KifX8TIh7H+eBEDTtw080ETaLnTfvlw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kh95Yk3kx5a/K2SgxITSsSVDN/yaUa9NkbCIIaA8/DOjW4G/SdwsHYGYMBElgNiQvMtghdbz5RacZZhiNNC9xu2+S6RB74KkH8o/D7PhOKM2dprFRir8B7VVF3u7y7cnO8+iKCppWk2kDS2ftJg9/Wf3WYmw1e6R908rs2G1Zgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3K8roo9V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFxAVwdQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 08:17:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706170632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lER7lrtQRjwXWHDXcRnYjUURbFjjl0xhPeP2jwJSCh0=;
	b=3K8roo9VnCsxY9bM39p5ipaVPiNN/T+OcU2IohiF4fwXmNoLh4txb2NNyQyF3FedUlN1UW
	aXYrY2aiwJdPD7y/ESE+t2UNUJPGdQS+i6MnUdOIvFo7eAX9qyg97rzO8V61E3JOkm5DTN
	lq3oLEGQRpJ9iz7rpJ06Sv/zSmQgY3kqumV5JoBCecTxS5rdxU7L7CkMbOP9HWrXs0tcli
	GMJXoG3pJIlDcdFMx4BGuMJSwa6iN2+RjGYUkvcuwFI1X04kVV3TcDJuyMBi+gJx1EIwJA
	PH8eeqdd5DPNXlV7gN1+LJifPgAuIt5g6HoPz/FFJ/+tqe8uaH7zxD1mtWHQew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706170632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lER7lrtQRjwXWHDXcRnYjUURbFjjl0xhPeP2jwJSCh0=;
	b=ZFxAVwdQ4y5d3WPqsD+czAFmGV0hSkhhN13id3D5/v+bOU7ZrX8ouS/Qv/uYSuucsjkRqE
	WCGuuAYWf5PwWwDA==
From: "tip-bot2 for Jiri Wiesner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource: Skip watchdog check for large
 watchdog intervals
Cc: Feng Tang <feng.tang@intel.com>, Jiri Wiesner <jwiesner@suse.de>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240122172350.GA740@incl>
References: <20240122172350.GA740@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170617063191.398.1061031038655031575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     644649553508b9bacf0fc7a5bdc4f9e0165576a5
Gitweb:        https://git.kernel.org/tip/644649553508b9bacf0fc7a5bdc4f9e0165576a5
Author:        Jiri Wiesner <jwiesner@suse.de>
AuthorDate:    Mon, 22 Jan 2024 18:23:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 09:13:16 +01:00

clocksource: Skip watchdog check for large watchdog intervals

There have been reports of the watchdog marking clocksources unstable on
machines with 8 NUMA nodes:

  clocksource: timekeeping watchdog on CPU373:
  Marking clocksource 'tsc' as unstable because the skew is too large:
  clocksource:   'hpet' wd_nsec: 14523447520
  clocksource:   'tsc'  cs_nsec: 14524115132

The measured clocksource skew - the absolute difference between cs_nsec
and wd_nsec - was 668 microseconds:

  cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612

The kernel used 200 microseconds for the uncertainty_margin of both the
clocksource and watchdog, resulting in a threshold of 400 microseconds (the
md variable). Both the cs_nsec and the wd_nsec value indicate that the
readout interval was circa 14.5 seconds.  The observed behaviour is that
watchdog checks failed for large readout intervals on 8 NUMA node
machines. This indicates that the size of the skew was directly proportinal
to the length of the readout interval on those machines. The measured
clocksource skew, 668 microseconds, was evaluated against a threshold (the
md variable) that is suited for readout intervals of roughly
WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5 second.

The intention of 2e27e793e280 ("clocksource: Reduce clocksource-skew
threshold") was to tighten the threshold for evaluating skew and set the
lower bound for the uncertainty_margin of clocksources to twice
WATCHDOG_MAX_SKEW. Later in c37e85c135ce ("clocksource: Loosen clocksource
watchdog constraints"), the WATCHDOG_MAX_SKEW constant was increased to
125 microseconds to fit the limit of NTP, which is able to use a
clocksource that suffers from up to 500 microseconds of skew per second.
Both the TSC and the HPET use default uncertainty_margin. When the
readout interval gets stretched the default uncertainty_margin is no
longer a suitable lower bound for evaluating skew - it imposes a limit
that is far stricter than the skew with which NTP can deal.

The root causes of the skew being directly proportinal to the length of
the readout interval are:

  * the inaccuracy of the shift/mult pairs of clocksources and the watchdog
  * the conversion to nanoseconds is imprecise for large readout intervals

Prevent this by skipping the current watchdog check if the readout
interval exceeds 2 * WATCHDOG_INTERVAL. Considering the maximum readout
interval of 2 * WATCHDOG_INTERVAL, the current default uncertainty margin
(of the TSC and HPET) corresponds to a limit on clocksource skew of 250
ppm (microseconds of skew per second).  To keep the limit imposed by NTP
(500 microseconds of skew per second) for all possible readout intervals,
the margins would have to be scaled so that the threshold value is
proportional to the length of the actual readout interval.

As for why the readout interval may get stretched: Since the watchdog is
executed in softirq context the expiration of the watchdog timer can get
severely delayed on account of a ksoftirqd thread not getting to run in a
timely manner. Surely, a system with such belated softirq execution is not
working well and the scheduling issue should be looked into but the
clocksource watchdog should be able to deal with it accordingly.

Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
Suggested-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240122172350.GA740@incl
---
 kernel/time/clocksource.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8..3052b1f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -99,6 +99,7 @@ static u64 suspend_start;
  * Interval: 0.5sec.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_INTERVAL_MAX_NS ((2 * WATCHDOG_INTERVAL) * (NSEC_PER_SEC / HZ))
 
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
@@ -134,6 +135,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
+static int64_t watchdog_max_interval;
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
@@ -399,8 +401,8 @@ static inline void clocksource_reset_watchdog(void)
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
+	int64_t wd_nsec, cs_nsec, interval;
 	int next_cpu, reset_pending;
-	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
 	unsigned long extra_wait = 0;
@@ -470,6 +472,27 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
+		/*
+		 * The processing of timer softirqs can get delayed (usually
+		 * on account of ksoftirqd not getting to run in a timely
+		 * manner), which causes the watchdog interval to stretch.
+		 * Skew detection may fail for longer watchdog intervals
+		 * on account of fixed margins being used.
+		 * Some clocksources, e.g. acpi_pm, cannot tolerate
+		 * watchdog intervals longer than a few seconds.
+		 */
+		interval = max(cs_nsec, wd_nsec);
+		if (unlikely(interval > WATCHDOG_INTERVAL_MAX_NS)) {
+			if (system_state > SYSTEM_SCHEDULING &&
+			    interval > 2 * watchdog_max_interval) {
+				watchdog_max_interval = interval;
+				pr_warn("Long readout interval, skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
+					cs_nsec, wd_nsec);
+			}
+			watchdog_timer.expires = jiffies;
+			continue;
+		}
+
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {

