Return-Path: <linux-kernel+bounces-76934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4827785FED9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7349A1C2403A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56710154C11;
	Thu, 22 Feb 2024 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CKMJYy6Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ruP0wCQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A414C5AB;
	Thu, 22 Feb 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621930; cv=none; b=iKTnZrVJRvQNo/btt/zLz3v38Sc9vEXBYhWG06m/10fzG15vnUghZ6cljjPNPCYwKIb4WJxW078/+niXfsbbMMqsUKU4BoOakJa/vYGQEHHDD5uElMbfa2bcECF8pA5b3QyUGMqXcxjTeQ8jiQbShdogr5LiG5Eg3QVK126/KZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621930; c=relaxed/simple;
	bh=YZm/XgM0xRkKyAGqQ/2cFME7qeJi2s+j33grqYT8TQ8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j9gjjDaOzoaKO831MhcBf3YBx2DZwau/3hu9wc6r0FoXCrF0DSNsm/jhN1FHNTLXE7ohzoVKBbKDkejQrMQimBoYGU8Z6mFNbX2MPF7yNHGVAhhFUppoGWVrJMLru0hreQ9bVGBuKbhLpebS6Q1UOeE1Zjfee2B+tdfHYZOUnfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CKMJYy6Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ruP0wCQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/16MK3Otxhbv+zGW2DDiw4HNmylrodOU+Dw2SRu+8MA=;
	b=CKMJYy6QWuA58UW2224k5s/9DytIOYgMzH6+M8ZG2ArXs5CDpiWOyESm0WHyIm1PcHS8CF
	C80/SK3f8KP/8KRS5hUv938VxKRdCG0fX6bKtnQmwilcaYEn5IFkndTEns1hhAYHhPkUOL
	d+GvP4ZKkWOfhYM4JN8VbJ/BuLKMq9/63HoGeXI+nokJA32CrbdP8HzGOQZfx/8XVSacru
	VCq6ezsvd5DdyZBLfOJz95mgMf6mNfX+O+Q3Qsqx5hPEeamMkXW+7mB+VRo3us4eVOTYPD
	DRSKL0sYPONyr9Mpj/WfErkWqXzuJglU9Ol/YyOc6AaUZ+MxR4JBxZAM5IJ7SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/16MK3Otxhbv+zGW2DDiw4HNmylrodOU+Dw2SRu+8MA=;
	b=2ruP0wCQ9gNTa8owTjXrrs6B38XwxpdhpCRLE/RcMuysnDPmwMoe6bF7eWw6DPK+I/X7ds
	o0pNyhdwNwS5f8Bw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Introduce function to check timer base
 is_idle flag
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-18-anna-maria@linutronix.de>
References: <20240221090548.36600-18-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862192671.398.14655637018769907129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     57e95a5c4117dc6a67dc416d82079c02dab7e983
Gitweb:        https://git.kernel.org/tip/57e95a5c4117dc6a67dc416d82079c02dab7e983
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:32 +01:00

timers: Introduce function to check timer base is_idle flag

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have a function that returns the value
of the is_idle flag of the timer base to keep the hierarchy states during
online in sync with timer base state.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-18-anna-maria@linutronix.de

---
 kernel/time/tick-internal.h |  1 +
 kernel/time/timer.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index ccf39be..7e30901 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -165,6 +165,7 @@ extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
 					      unsigned int cpu);
 extern void timer_lock_remote_bases(unsigned int cpu);
 extern void timer_unlock_remote_bases(unsigned int cpu);
+extern bool timer_base_is_idle(void);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4420cdf..e02ac46 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2159,6 +2159,16 @@ void timer_lock_remote_bases(unsigned int cpu)
 	raw_spin_lock(&base_local->lock);
 	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 }
+
+/**
+ * timer_base_is_idle() - Return whether timer base is set idle
+ *
+ * Returns value of local timer base is_idle value.
+ */
+bool timer_base_is_idle(void)
+{
+	return __this_cpu_read(timer_bases[BASE_LOCAL].is_idle);
+}
 # endif /* CONFIG_SMP */
 
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,

