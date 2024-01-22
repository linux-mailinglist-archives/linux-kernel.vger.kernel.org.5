Return-Path: <linux-kernel+bounces-33801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5B1836EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F29F1F2DF0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3753800;
	Mon, 22 Jan 2024 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IkeY0XKf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jLWQNuuS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IkeY0XKf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jLWQNuuS"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A33A1A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944240; cv=none; b=pYzjJoctSYv4CFtdl4cLIkRCuiyIXT4s/q+wMpxeevXsPqsfllb3Kcj1To9YCX82CNw8l/IgTSM8pEr3xJ+JXyWNlXn/gaVodKPuQY9LJowqiYCGQ4HRkV6cMXMDeUvantl28o6GOZjof/lmUiT0A1VKyibIxYBUQxxR1rcswGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944240; c=relaxed/simple;
	bh=DS26voeHquSs1rZvZjGZPXSp1ip97sF6UV65vOwDmpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aXJ7VZ2ddGAzKzg5yIzbYsc1tLXyzwFYhqwnkneMnjvaQSGZEq0F15cnajzivx0G6XznXSGlblBdNa0N9UrZmhY+tTCr9Uvc5R4r/31RjGMV5kxb3gGk/Wj+j83YmnvpIABxy16a4geRHupjJ2jORWsmlT5s+f38QxWMAXFpynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IkeY0XKf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jLWQNuuS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IkeY0XKf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jLWQNuuS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1B701F388;
	Mon, 22 Jan 2024 17:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705944230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=w7phIx9YZ+djyn/G3G10Q3TOuO+gXHmpB4a37pPWqI4=;
	b=IkeY0XKfOuDO6aeipUtj0lMmBIhnlH+Et5YAs6VbrGusUkjHlhghGVH9028j6h71hudS+f
	CLqX2SQ1BKHf5c+9v1S7AQ5ypx+sjTvtrRQaijN8bLDSGfQlJKEwY3EXuvluDOLWlmjmnd
	vt+WaEkBB4wkj44v/wj/KWNOwr2LeGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705944230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=w7phIx9YZ+djyn/G3G10Q3TOuO+gXHmpB4a37pPWqI4=;
	b=jLWQNuuS2Kbl2rmdAW7JytKkV5rbKNh9PD4R61aH074lWdsr1LMC1oyifxKsldtE4+PxAe
	xIbE5fsuOGvil8DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705944230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=w7phIx9YZ+djyn/G3G10Q3TOuO+gXHmpB4a37pPWqI4=;
	b=IkeY0XKfOuDO6aeipUtj0lMmBIhnlH+Et5YAs6VbrGusUkjHlhghGVH9028j6h71hudS+f
	CLqX2SQ1BKHf5c+9v1S7AQ5ypx+sjTvtrRQaijN8bLDSGfQlJKEwY3EXuvluDOLWlmjmnd
	vt+WaEkBB4wkj44v/wj/KWNOwr2LeGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705944230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=w7phIx9YZ+djyn/G3G10Q3TOuO+gXHmpB4a37pPWqI4=;
	b=jLWQNuuS2Kbl2rmdAW7JytKkV5rbKNh9PD4R61aH074lWdsr1LMC1oyifxKsldtE4+PxAe
	xIbE5fsuOGvil8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAA66136A4;
	Mon, 22 Jan 2024 17:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 662gKaakrmXJDwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Mon, 22 Jan 2024 17:23:50 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 1F7A59C7E1; Mon, 22 Jan 2024 18:23:50 +0100 (CET)
Date: Mon, 22 Jan 2024 18:23:50 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <20240122172350.GA740@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

There have been reports of the watchdog marking clocksources unstable on
machines with 8 NUMA nodes:
> clocksource: timekeeping watchdog on CPU373: Marking clocksource 'tsc' as unstable because the skew is too large:
> clocksource:   'hpet' wd_nsec: 14523447520 wd_now: 5a749706 wd_last: 45adf1e0 mask: ffffffff
> clocksource:   'tsc' cs_nsec: 14524115132 cs_now: 515ce2c5a96caa cs_last: 515cd9a9d83918 mask: ffffffffffffffff
> clocksource:   'tsc' is current clocksource.
> tsc: Marking TSC unstable due to clocksource watchdog
> TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> sched_clock: Marking unstable (1950347883333462, 79649632569)<-(1950428279338308, -745776594)
> clocksource: Checking clocksource tsc synchronization from CPU 400 to CPUs 0,46,52,54,138,208,392,397.
> clocksource: Switched to clocksource hpet

The measured clocksource skew - the absolute difference between cs_nsec
and wd_nsec - was 668 microseconds:
> cs_nsec - wd_nsec = 14524115132 - 14523447520 = 667612

The kernel (based on 5.14.21) used 200 microseconds for the
uncertainty_margin of both the clocksource and watchdog, resulting in a
threshold of 400 microseconds (the md variable). Both the cs_nsec and the
wd_nsec value indicate that the readout interval was circa 14.5 seconds.
The observed behaviour is that watchdog checks failed for large readout
intervals on 8 NUMA node machines. This indicates that the size of the
skew was directly proportinal to the length of the readout interval on
those machines. The measured clocksource skew, 668 microseconds, was
evaluated against a threshold (the md variable) that is suited for
readout intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is
0.5 second.

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
the readout interval are
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
Reviewed-by: Feng Tang <feng.tang@intel.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---

v2: fixed interger overflow in WATCHDOG_INTR_MAX_NS on i386
v3: variable renaming, threshold adjusted, message and log changes

 kernel/time/clocksource.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..3052b1f1168e 100644
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
-- 
2.35.3


-- 
Jiri Wiesner
SUSE Labs

