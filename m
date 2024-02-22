Return-Path: <linux-kernel+bounces-76940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2685FEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A368428B412
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F85154C18;
	Thu, 22 Feb 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tKkEBarM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4l4M/u0/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AE156977;
	Thu, 22 Feb 2024 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621935; cv=none; b=cMAlbAyQ4NxxjdANAiEi66ScYdZ/nGg74ZuchbIFcYgCFopAPV41JMBjsYeMO5I3eIx6+d9M7DijdW/ipK50JstPt702lKKtX4BcRnvvk9t5SsBnARt/9NfZh6oz0R3TZ+0veDgNuRvnLcy7qfVvC9Fb+i3kQNgIOQeQlfNcIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621935; c=relaxed/simple;
	bh=Tbck2OMqtLJUFG6B2k0J2BfnbExTjzQ8EJQcoxcR7eA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qZz++zElWsv+4nBHcvmvONii0MevClS6JPct2595wBblhOG292ImEmmrJSm+cb7+c8B3HnAhs7oWjvPS6x8iSYYKm8+8CEn8qGcSfcFAeRwR+QOzvfMbCpN1hzwgtoygabfHiveDZymlTedxOem1OUz7Ox44FOufIHTxFWPrKbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tKkEBarM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4l4M/u0/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621931;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4BrntYQ08Z67ifw3gui6IDhNOebTMArcG18q33unck=;
	b=tKkEBarMI7uLagMQ7OgS/AducXbo/xoKQdtBDaOqZrTLgrpf7q8IWkaLb8p55DVfwXlrzM
	QuZDeKbABAhbKr+jseZpM/Q+wo74ryKwHQ6+qITg3KPcTeRdj+MG8sTFWjqIrzRF8NsS4J
	bjU1EcTIvyDqD+EQ2SJXZ0Qr1+PjDew8Bz/0cAFs4L4wUh1mNI06VoM78VUce0YVCXaV/I
	kW023K6T23wlj2DWFG3OAHJCRnIcMOVijlsja27AxJfUBN7YWstocclZfVWle9n9XHm//3
	T8qiUrdRfvpigS13txSPgzlKXkWQ90oWoxuuNyAaAkgajgi/wCFklfROa/1Q2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621931;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4BrntYQ08Z67ifw3gui6IDhNOebTMArcG18q33unck=;
	b=4l4M/u0/oh2muLQKWo5BFbti9cA08HmKQkCCzkti89DatmvaMFoZ6YHgqOdCBXzvdBd5HS
	UJCGI7CRgBmWxMCg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Retrieve next expiry of pinned/non-pinned
 timers separately
Cc: "Richard Cochran (linutronix GmbH)" <richardcochran@gmail.com>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-12-anna-maria@linutronix.de>
References: <20240221090548.36600-12-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193062.398.4118896358715520378.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     21927fc89e5feebc1f7cbf50bb58b81d776a62b4
Gitweb:        https://git.kernel.org/tip/21927fc89e5feebc1f7cbf50bb58b81d776a62b4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:31 +01:00

timers: Retrieve next expiry of pinned/non-pinned timers separately

For the conversion of the NOHZ timer placement to a pull at expiry time
model it's required to have separate expiry times for the pinned and the
non-pinned (movable) timers. Therefore struct timer_events is introduced.

No functional change

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-12-anna-maria@linutronix.de

---
 kernel/time/timer.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index aabd136..38becd2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -266,6 +266,11 @@ struct timer_base {
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_NO_HZ_COMMON
 
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
@@ -2031,10 +2036,11 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	struct timer_base *base_local, *base_global;
-	u64 expires = KTIME_MAX;
 	bool local_first;
+	u64 expires;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -2043,7 +2049,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	if (cpu_is_offline(smp_processor_id())) {
 		if (idle)
 			*idle = true;
-		return expires;
+		return tevt.local;
 	}
 
 	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
@@ -2059,14 +2065,33 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 
 	nextevt = local_first ? nextevt_local : nextevt_global;
 
-	if (base_local->timers_pending || base_global->timers_pending) {
+	/*
+	 * If the @nextevt is at max. one tick away, use @nextevt and store
+	 * it in the local expiry value. The next global event is irrelevant in
+	 * this case and can be left as KTIME_MAX.
+	 */
+	if (time_before_eq(nextevt, basej + 1)) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
-		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		goto forward;
 	}
 
 	/*
+	 * Update tevt.* values:
+	 *
+	 * If the local queue expires first, then the global event can be
+	 * ignored. If the global queue is empty, nothing to do either.
+	 */
+	if (!local_first && base_global->timers_pending)
+		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+	if (base_local->timers_pending)
+		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+forward:
+	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
 	 */
@@ -2096,6 +2121,8 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
+	expires = min_t(u64, tevt.local, tevt.global);
+
 	return cmp_next_hrtimer_event(basem, expires);
 }
 

