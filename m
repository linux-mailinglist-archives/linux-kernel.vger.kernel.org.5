Return-Path: <linux-kernel+bounces-82391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3705B86839E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E582D2834B2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC0133996;
	Mon, 26 Feb 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRe72MT4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tnh3pNDH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A111332A3;
	Mon, 26 Feb 2024 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986276; cv=none; b=D/YSGW3g3r8YLxf88RpfKvZF74OE6D6a1oviGswf2TQtoivMRKcn8VMm2ZnGLLGY7/v1P3qzuZCxFfbPCzyRcGRiChxbTirrTym8Pd+UEDIGDhB4GQ3kNh08Kst7lCRP3ucYKNtLU6uHo55dorF0PZT89tj5RTqsIlUo44tzDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986276; c=relaxed/simple;
	bh=MXYuqddvAgScwlDuDC2mLdCth928Zms9L8JCQc6Bm48=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WKZm4ta7Ykpbx+eL5D6lS5qjVRttaog3bE8m1ACKEYx9ltnpPxQLhnLuJ3eSsIwR1e8r2RoXPqYD4EfyjC9RktdVHHrGv6AEY8qu45s1F2Pd9D0W2t+q1ab2UNE8+eviT1zcd5tOq1fCkXykqGpj9dwigkLx7b4axx9gIhiVOXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRe72MT4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tnh3pNDH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/vcZ6pcdKVZi5Z+UKncqylpibfLy4U/GGaLZVaCKeQ=;
	b=dRe72MT4TbthnpZsT4LbqXhC0oFy7foVTfRIcPUR/Ivqg0jF4yRn9rC0PDqJeVeGGm8OTl
	NeuMxbTsO6YbOhg8+zcpAvhK2hYI5l3fKHPIO/F8EWGoqUVle6j4NQYwIO9wUBE5LBpB2/
	q++4SaeI6yN8bR0+zT8fHrsctonBP88puXHSDvl3J/raxPFx6PACb0LAGt2weyyA4qBi/w
	f9ts3g699NvRrblbC1bA6O0hZwBlH3P94ohwwL9guxmA4u2x1cuCkO4Kd5Pe5bM0llkOCg
	hRnfXREPgv5W97uL07CDZLAnkvckJy6l3JpvQ/frLY8Zkw5sz6tPr+gquPDlSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/vcZ6pcdKVZi5Z+UKncqylpibfLy4U/GGaLZVaCKeQ=;
	b=tnh3pNDHCsiVpauYcDQDFZwBE3pwkRof34M0nZWHoZfrxnwM1Xe6nHYXWigqz3ZEEauDVP
	GiNh4cwyyFv114Dw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Move got_idle_tick away from common flags
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-12-frederic@kernel.org>
References: <20240225225508.11587-12-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627211.398.9037031004873986695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3ce74f1a8566dbbc9774f85fb0ce781fe290fd32
Gitweb:        https://git.kernel.org/tip/3ce74f1a8566dbbc9774f85fb0ce781fe290fd32
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:55:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:32 +01:00

tick: Move got_idle_tick away from common flags

tick_nohz_idle_got_tick() is called by cpuidle_reflect() within the idle
loop with interrupts enabled. This function modifies the struct
tick_sched's bitfield "got_idle_tick". However this bitfield is stored
within the same mask as other bitfields that can be modified from
interrupts.

Fortunately so far it looks like the only race that can happen is while
writing ->got_idle_tick to 0, an interrupt fires and writes the
->idle_active field to 0. It's then possible that the interrupted write
to ->got_idle_tick writes back the old value of ->idle_active back to 1.

However if that happens, the worst possible outcome is that the time
spent between that interrupt and the upcoming call to
tick_nohz_idle_exit() is accounted as idle, which is negligible quantity.

Still all the bitfield writes within this struct tick_sched's shadow
mask should be IRQ-safe. Therefore move this bitfield out to its own
storage to avoid further suprises.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-12-frederic@kernel.org

---
 kernel/time/tick-sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 35808bb..3b555e0 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -61,7 +61,6 @@ struct tick_sched {
 	unsigned int			tick_stopped	: 1;
 	unsigned int			idle_active	: 1;
 	unsigned int			do_timer_last	: 1;
-	unsigned int			got_idle_tick	: 1;
 
 	/* Tick handling: jiffies stall check */
 	unsigned int			stalled_jiffies;
@@ -73,6 +72,7 @@ struct tick_sched {
 	ktime_t				next_tick;
 	unsigned long			idle_jiffies;
 	ktime_t				idle_waketime;
+	unsigned int			got_idle_tick;
 
 	/* Idle entry */
 	seqcount_t			idle_sleeptime_seq;

