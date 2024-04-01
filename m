Return-Path: <linux-kernel+bounces-126533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CA289392B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB7FB21403
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D61111A9;
	Mon,  1 Apr 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+5tc7Lc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EIpGP2Ti"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A858BF0;
	Mon,  1 Apr 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711961259; cv=none; b=fPIUOgxcMRcMydEtO1aaro0Qc9C3DI3lx2PRAFAjt9nHxKX/S6zFw9rCgcS4Rm4MM3Pe4m9f1PcnZJiwDfHr98cfrqa0JLuIpgXq7G+NddPR3bHL88qryrwuUhJnUrHFf1pWJ/HOh/fT59UohUn8qe9+bXPW6TqH+p4qUusxgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711961259; c=relaxed/simple;
	bh=6vhjG1prBgD1BUtFbazTz3a0+5bx/I33FVhvfcrjka8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tSZ8baJdCfRm71ft3dFjncMeQll2ovBRsLPvw//xuDnMhC5CkaHEMIIPY/ZQzWVXjA44aI+D4A391OcSWYAFVFWkBC+HA8hQhrEyCO48LMNBPD5aalHFnSWpnNYet3p2Z57HpS606JuOQG0v3XOnenBCMb1QKTCO1KwKcUvrkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+5tc7Lc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EIpGP2Ti; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Apr 2024 08:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711961249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nVAKrG2DTFtsm0sFhNd+3eKvN95UV47L0lhR7edu6s=;
	b=R+5tc7LcpyvzhnK5qgQDrFY+pnsUlLj28pn1kIvW0Tr3g5JhFhmyadPOoahGg1WvZjydae
	PRMwgWaUFOsksLqaadufM9tE8KBDCNRhddbqDQ9R5voRM2LYMj15wlP5UqXZgJK+NqlWlB
	rvQf0KEJzu8n53r+mymPH0wXVkYcWUk3Xcx4fy3L+Q4NPZTob+bIIa3iQnF++dJ4ISpCJm
	1R22djLpSP7cnJfHr6M5rXNRVuqGoHaCuGkqJOfSUMRDa/MsEgByZ3hcRxL/5jRc/tKa5Y
	3wsUX3HbL8CyKECJBSAk9MpOVvg3kuW3LR5c99GoRMr3zywHRtMYzklZ11HgMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711961249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nVAKrG2DTFtsm0sFhNd+3eKvN95UV47L0lhR7edu6s=;
	b=EIpGP2TiMyIuJ0jdRnumnNpIyla9le3M9kUrbyNXLH0VNZ5nTKHasPCD/Q9bQjGlbP0JlH
	pKOewHlKy7u5WzDA==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/sched: Fix various kernel-doc warnings
Cc: Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240331172652.14086-5-rdunlap@infradead.org>
References: <20240331172652.14086-5-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171196124826.10875.6261994448383066262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     f29536bf1721802d2ebdc7893ed2991d4da0a4b6
Gitweb:        https://git.kernel.org/tip/f29536bf1721802d2ebdc7893ed2991d4da0a4b6
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sun, 31 Mar 2024 10:26:50 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Apr 2024 10:36:35 +02:00

tick/sched: Fix various kernel-doc warnings

Fix a slew of kernel-doc warnings in tick-sched.c:

  tick-sched.c:650: warning: Function parameter or struct member 'now' not described in 'tick_nohz_update_jiffies'
  tick-sched.c:741: warning: No description found for return value of 'get_cpu_idle_time_us'
  tick-sched.c:767: warning: No description found for return value of 'get_cpu_iowait_time_us'
  tick-sched.c:1210: warning: No description found for return value of 'tick_nohz_idle_got_tick'
  tick-sched.c:1228: warning: No description found for return value of 'tick_nohz_get_next_hrtimer'
  tick-sched.c:1243: warning: No description found for return value of 'tick_nohz_get_sleep_length'
  tick-sched.c:1282: warning: Function parameter or struct member 'cpu' not described in 'tick_nohz_get_idle_calls_cpu'
  tick-sched.c:1282: warning: No description found for return value of 'tick_nohz_get_idle_calls_cpu'
  tick-sched.c:1294: warning: No description found for return value of 'tick_nohz_get_idle_calls'
  tick-sched.c:1577: warning: Function parameter or struct member 'hrtimer' not described in 'tick_setup_sched_timer'
  tick-sched.c:1577: warning: Excess function parameter 'mode' description in 'tick_setup_sched_timer'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240331172652.14086-5-rdunlap@infradead.org
---
 kernel/time/tick-sched.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 269e215..1331216 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -697,6 +697,7 @@ bool tick_nohz_tick_stopped_cpu(int cpu)
 
 /**
  * tick_nohz_update_jiffies - update jiffies when idle was interrupted
+ * @now: current ktime_t
  *
  * Called from interrupt entry when the CPU was idle
  *
@@ -794,7 +795,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * This function returns -1 if NOHZ is not enabled.
+ * Return: -1 if NOHZ is not enabled, else total idle time of the @cpu
  */
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
@@ -820,7 +821,7 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
  * This time is measured via accounting rather than sampling,
  * and is as accurate as ktime_get() is.
  *
- * This function returns -1 if NOHZ is not enabled.
+ * Return: -1 if NOHZ is not enabled, else total iowait time of @cpu
  */
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
@@ -1287,6 +1288,8 @@ void tick_nohz_irq_exit(void)
 
 /**
  * tick_nohz_idle_got_tick - Check whether or not the tick handler has run
+ *
+ * Return: %true if the tick handler has run, otherwise %false
  */
 bool tick_nohz_idle_got_tick(void)
 {
@@ -1305,6 +1308,8 @@ bool tick_nohz_idle_got_tick(void)
  * stopped, it returns the next hrtimer.
  *
  * Called from power state control code with interrupts disabled
+ *
+ * Return: the next expiration time
  */
 ktime_t tick_nohz_get_next_hrtimer(void)
 {
@@ -1320,6 +1325,8 @@ ktime_t tick_nohz_get_next_hrtimer(void)
  * The return value of this function and/or the value returned by it through the
  * @delta_next pointer can be negative which must be taken into account by its
  * callers.
+ *
+ * Return: the expected length of the current sleep
  */
 ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 {
@@ -1357,8 +1364,11 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
+ * @cpu: target CPU number
  *
  * Called from the schedutil frequency scaling governor in scheduler context.
+ *
+ * Return: the current idle calls counter value for @cpu
  */
 unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
 {
@@ -1371,6 +1381,8 @@ unsigned long tick_nohz_get_idle_calls_cpu(int cpu)
  * tick_nohz_get_idle_calls - return the current idle calls counter value
  *
  * Called from the schedutil frequency scaling governor in scheduler context.
+ *
+ * Return: the current idle calls counter value for the current CPU
  */
 unsigned long tick_nohz_get_idle_calls(void)
 {
@@ -1559,7 +1571,7 @@ early_param("skew_tick", skew_tick);
 
 /**
  * tick_setup_sched_timer - setup the tick emulation timer
- * @mode: tick_nohz_mode to setup for
+ * @hrtimer: whether to use the hrtimer or not
  */
 void tick_setup_sched_timer(bool hrtimer)
 {

