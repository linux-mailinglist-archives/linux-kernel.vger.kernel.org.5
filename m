Return-Path: <linux-kernel+bounces-74353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E4885D30C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8D01C2279F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14153EA83;
	Wed, 21 Feb 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HvRZ57j6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pE7xSGt4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689733D548
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506380; cv=none; b=fZ2uX6U+nPk8Z1pB+ZeGzYjJNtlm4oq/RbIwvegTJQn2bitKvQTAa/g3qid5pudxYbYaLTBkXBDkXOitR5paqSYOgy281D0Wxipm26GM4zg75ChYzeIpK53WbCzflSdzxg/MnNq2gUEsAU4trxpBIJKlPev6CCAgB87gtt1FOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506380; c=relaxed/simple;
	bh=fMnUip/MpnSW36woG3gUZ5/i2vpiyMU5OgA7NkdHqf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IBiTXXBdCNTcXd0uZNK8AMTVUXcBCX1Hb1Bb8OQxXBgU03Wy6TzB5sKo/MFXQIj9HU/bifO0oEkvt4QkQcQY6DCi8B8rOmvLS6vp9LplcSYhIDIAGfqNS0FUAsLXcK6WPaGQdWrO2Nocy0nf13PF1us7ASJYVHbRnqbkUrU3rNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HvRZ57j6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pE7xSGt4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNIN8XCUDE1sXjDFOsAqNC/m2dPziZPst5V05kZh90Q=;
	b=HvRZ57j6yC35ZAi87VIvPdSqQPxGKA37Fw5X7GMyMMKu1PfClEnNQrcXGlFTP/Ncd5Ggko
	WkOe7WnAQEIKhr6iCuAE4crKzZew/srk5b/5yAxWmKWIezrXGPmNElWemBRCRijklkzP0C
	MxrzAFxL+iyYoivIEGQfXV3ztsm5CghxWCE0mjMNz5AnuJZkUsNFb+Ih4DrIAtcnT7Wcj4
	SDZL+9mwyIHjckotLCYp3EcOZ8vWvZZcs5fvkfjWfVjL93vqXWZFK91V6kplXSUy5AP2dZ
	u3BLvRGgA3X6W+1iBKKSNzjnakCsR/+ggBJNTivzCJYbLinCv54nJ2a/laagGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNIN8XCUDE1sXjDFOsAqNC/m2dPziZPst5V05kZh90Q=;
	b=pE7xSGt45DLeitGoDdAVEkrpLrx8syoI2M2zBt+QD+vQJM+h6MjCvTUuyVdQJ8Z904MgQQ
	2Renbh2v4LfXzFBw==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v11 08/20] timers: Ease code in run_local_timers()
Date: Wed, 21 Feb 2024 10:05:36 +0100
Message-Id: <20240221090548.36600-9-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic for raising a softirq the way it is implemented right now, is
readable for two timer bases. When increasing numbers of timer bases, code
gets harder to read. With the introduction of the timer migration
hierarchy, there will be three timer bases.

Therefore ease the code. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v5: New patch to decrease patch size of follow up patches
---
 kernel/time/timer.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index fc4c406c9ec7..793848167852 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2135,16 +2135,14 @@ static void run_local_timers(void)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	hrtimer_run_queues();
-	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->next_expiry)) {
-		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
-			return;
-		/* CPU is awake, so check the deferrable base. */
-		base++;
-		if (time_before(jiffies, base->next_expiry))
+
+	for (int i = 0; i < NR_BASES; i++, base++) {
+		/* Raise the softirq only if required. */
+		if (time_after_eq(jiffies, base->next_expiry)) {
+			raise_softirq(TIMER_SOFTIRQ);
 			return;
+		}
 	}
-	raise_softirq(TIMER_SOFTIRQ);
 }
 
 /*
-- 
2.39.2


