Return-Path: <linux-kernel+bounces-15439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C697822C04
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C201C2325C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E9C18E1E;
	Wed,  3 Jan 2024 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xe/QT+2J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HExykre3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tMWEzmJS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TJqKF1cV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923418E15
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C36CE21F5E;
	Wed,  3 Jan 2024 11:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704280875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=NHB4j9wlHDrYyqT2ikxPmdHQfGYnNUKv98b9mA6DHZM=;
	b=Xe/QT+2JCCbI8yPbqXzgunQq2X3E0dtypQMaD5cVm8O8Ai5eQoSfApEWmxdnywqJvuykVo
	IwkutEsjaBwyQHHPDhcMTXf4REgEtY9RdqXHOwaYjQxaoEK+YfUfHfD441xGfnHcDSOFxi
	2lJecVINk8UwOOFBNmdOGX5uTOzosmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704280875;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=NHB4j9wlHDrYyqT2ikxPmdHQfGYnNUKv98b9mA6DHZM=;
	b=HExykre3r2nf6w/oGKa01rzU9P8W5hj2+dWHlXMRnbopvWXgUagO60EWxfaTJxshV40R1X
	DRN91xHx8qlLrsBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704280874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=NHB4j9wlHDrYyqT2ikxPmdHQfGYnNUKv98b9mA6DHZM=;
	b=tMWEzmJSfW52E5llmjoOygMAXyU09LuvgTtVegHo0XlcNZLQ6/3lhF/Mi1i4t50Lab3gg+
	42lYQX55m19IfbfuQdfW9Gqd57wkkCwxWQqfPEt8GwMm2+idxnIpzi6+dYIIceeWSThIhx
	ALj/VI8oDs4YzrDghcZ5/79LPGYDXV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704280874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=NHB4j9wlHDrYyqT2ikxPmdHQfGYnNUKv98b9mA6DHZM=;
	b=TJqKF1cVc4ZSpxLReDXq13dQPiEwPH0nQeZyd843RMNo3L7roG4SHtSiVPm3yR++TwEdRM
	7f6GiA4pJgnLjYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB5DE13AA6;
	Wed,  3 Jan 2024 11:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GXIXKipDlWV8EAAAD6G6ig
	(envelope-from <jwiesner@suse.de>); Wed, 03 Jan 2024 11:21:14 +0000
Received: by incl.suse.cz (Postfix, from userid 1000)
	id 0819A9BCA0; Wed,  3 Jan 2024 12:21:14 +0100 (CET)
Date: Wed, 3 Jan 2024 12:21:13 +0100
From: Jiri Wiesner <jwiesner@suse.de>
To: linux-kernel@vger.kernel.org
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>
Subject: [PATCH] clocksource: Skip watchdog check for large watchdog intervals
Message-ID: <20240103112113.GA6108@incl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: *****
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tMWEzmJS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TJqKF1cV
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: C36CE21F5E
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

Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
Suggested-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Jiri Wiesner <jwiesner@suse.de>
---
 kernel/time/clocksource.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..ac5cb0ff278b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -98,7 +98,9 @@ static u64 suspend_start;
 /*
  * Interval: 0.5sec.
  */
-#define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_INTERVAL	(HZ >> 1)
+#define WATCHDOG_INTR_MAX_NS	((WATCHDOG_INTERVAL + (WATCHDOG_INTERVAL >> 1))\
+				 * NSEC_PER_SEC / HZ)
 
 /*
  * Threshold: 0.0312s, when doubled: 0.0625s.
@@ -134,6 +136,7 @@ static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
+static int64_t watchdog_max_intr;
 
 static inline void clocksource_watchdog_lock(unsigned long *flags)
 {
@@ -400,7 +403,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
 	int next_cpu, reset_pending;
-	int64_t wd_nsec, cs_nsec;
+	int64_t wd_nsec, cs_nsec, interval;
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

