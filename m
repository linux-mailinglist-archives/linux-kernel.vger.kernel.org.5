Return-Path: <linux-kernel+bounces-22658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F66D82A104
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD79284712
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304344E1C6;
	Wed, 10 Jan 2024 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cxbsWLL7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="osziepAM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kiPR61FI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v6MnfcBu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B590405E3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C1F522275;
	Wed, 10 Jan 2024 19:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704914696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ff6hp8RNpBv20JU2zM0F454o+SZtIAQoQeoCnyUZ70g=;
	b=cxbsWLL7Ivfpsrmc7LRdVSRF7Le9/v6zXmwDfApd0fAemYcS9nrgNBr6RSjrf5a5zkW9+K
	qZeFWl1vzvBAubX5nCmGVnDwirkSxeTAH/6rkPrXIcm4THigw5x+gKFyDxK9sIhw6dvHfZ
	Nc+2SMTudurd+lswNzSJNHitY2W62mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704914696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ff6hp8RNpBv20JU2zM0F454o+SZtIAQoQeoCnyUZ70g=;
	b=osziepAMyV8C1lr7aqInK/sUe5gQPkAh2lbpSOWo8ym2j5HGnzecbZfFxz9O8vFli6rKNv
	GZIk3BiTnJKTI+Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704914770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ff6hp8RNpBv20JU2zM0F454o+SZtIAQoQeoCnyUZ70g=;
	b=kiPR61FId50SaVm6mRDS/4ydvmIgqNVDS388QfwDixRTSUYXtvUEindZxwOw8w1QeWH+ML
	QbAY5z0OrO/7/zRZThfTjTMQsvRIZ0gnpCW/xPVbrzIOaA/tvdzt/OKLs0I8+jAT2uvOcY
	Ypm0v2JPnb6vyXClqvRp4J/PDCSzO0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704914770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ff6hp8RNpBv20JU2zM0F454o+SZtIAQoQeoCnyUZ70g=;
	b=v6MnfcBuxbptjOGnW1smEgJQjZBVJejRTyywR5GyNO+OtNWhbrkYKe4Fx1Z8JU8K8wEpeR
	9EJY+zYX0fHfypDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E74413306;
	Wed, 10 Jan 2024 19:24:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oC9iJgbvnmUoOwAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Wed, 10 Jan 2024 19:24:54 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id CA2EA9C46A; Wed, 10 Jan 2024 20:26:23 +0100 (CET)
Date: Wed, 10 Jan 2024 20:26:23 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH v2] clocksource: Skip watchdog check for large watchdog
 intervals
Message-ID: <20240110192623.GA7158@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kiPR61FI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v6MnfcBu
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
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
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0C1F522275
X-Spam-Level: 
X-Spam-Score: -2.81
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
threshold of 400 microseconds.  The discrepancy is that the measured
clocksource skew was evaluated against a threshold suited for watchdog
intervals of roughly WATCHDOG_INTERVAL, i.e. HZ >> 1, which is 0.5 second.
Both the cs_nsec and the wd_nsec value indicate that the actual watchdog
interval was circa 14.5 seconds. Since the watchdog is executed in softirq
context the expiration of the watchdog timer can get severely delayed on
account of a ksoftirqd thread not getting to run in a timely manner.
Surely, a system with such belated softirq execution is not working well
and the scheduling issue should be looked into but the clocksource
watchdog should be able to deal with it accordingly.

The solution in this patch skips the current watchdog check if the
watchdog interval exceeds 1.5 * WATCHDOG_INTERVAL. Considering the maximum
watchdog interval of 1.5 * WATCHDOG_INTERVAL, the current default
uncertainty margin (of the TSC and HPET) corresponds to a limit on
clocksource skew of 333 ppm (microseconds of skew per second). To keep the
limit imposed by NTP (500 microseconds of skew per second) for all
possible watchdog intervals, the margins would have to be scaled so that
the threshold value is proportional to the length of the actual watchdog
interval.

v2: fixed interger overflow in WATCHDOG_INTR_MAX_NS on i386

Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
Suggested-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
 kernel/time/clocksource.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..e7f8d0a1b95c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -98,7 +98,9 @@ static u64 suspend_start;
 /*
  * Interval: 0.5sec.
  */
-#define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_INTERVAL	(HZ >> 1)
+#define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
+				 * (NSEC_PER_SEC / HZ))
 
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
@@ -134,6 +136,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
+static int64_t watchdog_max_intr;
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
@@ -399,8 +402,8 @@ static inline void clocksource_reset_watchdog(void)
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
+	int64_t wd_nsec, cs_nsec, interval;
 	int next_cpu, reset_pending;
-	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
 	enum wd_read_status read_ret;
 	unsigned long extra_wait = 0;
@@ -470,6 +473,27 @@ static void clocksource_watchdog(struct timer_list *unused)
 		if (atomic_read(&watchdog_reset_pending))
 			continue;
 
+		/*
+		 * The processing of timer softirqs can get delayed (usually
+		 * on account of ksoftirqd not getting to run in a timely
+		 * manner), which causes the watchdog interval to stretch.
+		 * Some clocksources, e.g. acpi_pm, cannot tolerate
+		 * watchdog intervals longer than a few seconds.
+		 * Skew detection may fail for longer watchdog intervals
+		 * on account of fixed margins being used.
+		 */
+		interval = max(cs_nsec, wd_nsec);
+		if (unlikely(interval > WATCHDOG_INTR_MAX_NS)) {
+			if (system_state > SYSTEM_SCHEDULING &&
+			    interval > 2 * watchdog_max_intr) {
+				watchdog_max_intr = interval;
+				pr_warn("Skipping watchdog check: cs_nsec: %lld wd_nsec: %lld\n",
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

