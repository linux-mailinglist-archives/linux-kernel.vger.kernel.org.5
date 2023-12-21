Return-Path: <linux-kernel+bounces-8721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B109981BB7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691CD28828F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DA55E52;
	Thu, 21 Dec 2023 16:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eEDmGz8N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z8AA3iNc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eEDmGz8N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z8AA3iNc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B955E41
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0070B21E45;
	Thu, 21 Dec 2023 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703174734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y0o6m2PLxPN/8wWQ2CD6ak5/tzc7u6pVRNRVvBJRC70=;
	b=eEDmGz8NPM6vTqM3HQNPqYopGEM1VFEYqETqCXPpsQpj+X5zSG0Qc8ZSGj1ciEThznKgOR
	eg8h4qznTtO2u/AXlPgwUi8xPo07NAHS4KD8TUnQ1NO93NkeEb06PKReEpL70IrQyC4Wpp
	ChqrRo0V222WYhDTCuQu//b0pN7PUNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703174734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y0o6m2PLxPN/8wWQ2CD6ak5/tzc7u6pVRNRVvBJRC70=;
	b=Z8AA3iNcBOX0PDGQCb6H1u1O4sLIWHwgxgtWukPnC6RTuXPUBHJoNWLeUz0XK+L1KSQKGq
	zbRa5vz0hlvQncBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703174734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y0o6m2PLxPN/8wWQ2CD6ak5/tzc7u6pVRNRVvBJRC70=;
	b=eEDmGz8NPM6vTqM3HQNPqYopGEM1VFEYqETqCXPpsQpj+X5zSG0Qc8ZSGj1ciEThznKgOR
	eg8h4qznTtO2u/AXlPgwUi8xPo07NAHS4KD8TUnQ1NO93NkeEb06PKReEpL70IrQyC4Wpp
	ChqrRo0V222WYhDTCuQu//b0pN7PUNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703174734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Y0o6m2PLxPN/8wWQ2CD6ak5/tzc7u6pVRNRVvBJRC70=;
	b=Z8AA3iNcBOX0PDGQCb6H1u1O4sLIWHwgxgtWukPnC6RTuXPUBHJoNWLeUz0XK+L1KSQKGq
	zbRa5vz0hlvQncBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E051613AB5;
	Thu, 21 Dec 2023 16:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mOG8Nk1ihGWWPAAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Thu, 21 Dec 2023 16:05:33 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id D4C92985FF; Thu, 21 Dec 2023 17:05:17 +0100 (CET)
Date: Thu, 21 Dec 2023 17:05:17 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH] clocksource: Use proportional clocksource skew threshold
Message-ID: <20231221160517.GA22919@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 5.29
X-Spamd-Bar: +++++
X-Spam-Flag: NO
X-Spamd-Result: default: False [5.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 BAYES_SPAM(5.10)[99.99%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eEDmGz8N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Z8AA3iNc
X-Spam-Level: *****
X-Rspamd-Queue-Id: 0070B21E45

There have been reports of the watchdog marking clocksources unstable on
machines 8 NUMA nodes:
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

The kernel used 200 microseconds for the uncertainty_margin of both the
clocksource and watchdog, resulting in a threshold of 400 microseconds.
The discrepancy is that the measured clocksource skew was evaluated against
a threshold suited for watchdog intervals of roughly WATCHDOG_INTERVAL,
i.e. HZ >> 1. Both the cs_nsec and the wd_nsec value indicate that the
actual watchdog interval was circa 14.5 seconds. Since the watchdog is
executed in softirq context the expiration of the watchdog timer can get
severely delayed on account of a ksoftirqd thread not getting to run in a
timely manner. Surely, a system with such belated softirq execution is not
working well and the scheduling issue should be looked into but the
clocksource watchdog should be able to deal with it accordingly.

To keep the limit imposed by NTP (500 microseconds of skew per second),
the margins must be scaled so that the threshold value is proportional to
the length of the actual watchdog interval. The solution in the patch
utilizes left-shifting to approximate the division by
WATCHDOG_INTERVAL * NSEC_PER_SEC / HZ, which leads to slighly narrower
margins and a slightly lower threshold for longer watchdog intervals.

Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
 kernel/time/clocksource.c | 60 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..a84c4c6f49e3 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -98,7 +98,8 @@ static u64 suspend_start;
 /*
  * Interval: 0.5sec.
  */
-#define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_INTERVAL_SHIFT	1
+#define WATCHDOG_INTERVAL	(HZ >> WATCHDOG_INTERVAL_SHIFT)
 
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
@@ -121,7 +122,8 @@ static u64 suspend_start;
 #define MAX_SKEW_USEC	(125 * WATCHDOG_INTERVAL / HZ)
 #endif
 
-#define WATCHDOG_MAX_SKEW (MAX_SKEW_USEC * NSEC_PER_USEC)
+#define WATCHDOG_MAX_SKEW	(MAX_SKEW_USEC * NSEC_PER_USEC)
+#define WATCHDOG_MIN_MARGIN	(2 * WATCHDOG_MAX_SKEW)
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
@@ -395,16 +397,47 @@ static inline void clocksource_reset_watchdog(void)
 		cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
 }
 
+/* Scaled margin calculation */
+#define MARGIN_SCALE		24
+/* Bits needed for multiplication with WATCHDOG_MIN_MARGIN */
+#define MARGIN_MIN_BITS		(const_ilog2(WATCHDOG_MIN_MARGIN) + 1)
+/* 1UL << 30 approximates NSEC_PER_SEC */
+#define MARGIN_SHIFT		(30 - WATCHDOG_INTERVAL_SHIFT - MARGIN_SCALE)
+/* The result needs to fit into 32 bits */
+#define MARGIN_MAX_INTERVAL	(1ULL << (32 + MARGIN_SCALE - MARGIN_MIN_BITS \
+					  + MARGIN_SHIFT))
+
+/*
+ * Calculate the minimal uncertainty margin scaled by
+ * the length of the watchdog interval that elapsed since
+ * cs_last and wd_last. Since the watchdog is executed
+ * in softirq context the expiration of the timer can get
+ * severely delayed on account of a ksoftirqd thread not
+ * getting to run in a timely manner.
+ * Left-shifting is utilized to approximate the division by
+ * WATCHDOG_INTERVAL * NSEC_PER_SEC / HZ
+ */
+static u32 clocksource_calc_margin(int64_t interval)
+{
+	u64 tmp;
+
+	if (interval < 0)
+		return 0;
+	tmp = interval < MARGIN_MAX_INTERVAL ? interval : MARGIN_MAX_INTERVAL;
+	tmp >>= MARGIN_SHIFT;
+	tmp *= WATCHDOG_MIN_MARGIN;
+	return tmp >> MARGIN_SCALE;
+}
 
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
+	u32 scaled_cs_margin, scaled_wd_margin, md;
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
 	unsigned long extra_wait = 0;
-	u32 md;
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -470,8 +503,19 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
+		/*
+		 * Skip the check if CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE
+		 * detected the MSB of the mask in the delta or delta == mask.
+		 */
+		if (!wd_nsec || !cs_nsec)
+			continue;
+
 		/* Check the deviation from the watchdog clocksource. */
-		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
+		scaled_cs_margin = clocksource_calc_margin(cs_nsec);
+		scaled_wd_margin = clocksource_calc_margin(wd_nsec);
+		md = max(cs->uncertainty_margin, scaled_cs_margin);
+		md += max(watchdog->uncertainty_margin, scaled_wd_margin);
+
 		if (abs(cs_nsec - wd_nsec) > md) {
 			s64 cs_wd_msec;
 			s64 wd_msec;
@@ -487,6 +531,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 			wd_msec = div_s64_rem(wd_nsec, 1000 * 1000, &wd_rem);
 			pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
 				cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
+			pr_warn("                      Max deviation: %u scaled_cs_margin: %u scaled_wd_margin: %u\n",
+				md, scaled_cs_margin, scaled_wd_margin);
 			if (curr_clocksource == cs)
 				pr_warn("                      '%s' is current clocksource.\n", cs->name);
 			else if (curr_clocksource)
@@ -1138,12 +1184,12 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
 	 */
 	if (scale && freq && !cs->uncertainty_margin) {
 		cs->uncertainty_margin = NSEC_PER_SEC / (scale * freq);
-		if (cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW)
-			cs->uncertainty_margin = 2 * WATCHDOG_MAX_SKEW;
+		if (cs->uncertainty_margin < WATCHDOG_MIN_MARGIN)
+			cs->uncertainty_margin = WATCHDOG_MIN_MARGIN;
 	} else if (!cs->uncertainty_margin) {
 		cs->uncertainty_margin = WATCHDOG_THRESHOLD;
 	}
-	WARN_ON_ONCE(cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW);
+	WARN_ON_ONCE(cs->uncertainty_margin < WATCHDOG_MIN_MARGIN);
 
 	/*
 	 * Ensure clocksources that have large 'mult' values don't overflow
-- 
2.35.3


-- 
Jiri Wiesner
SUSE Labs

