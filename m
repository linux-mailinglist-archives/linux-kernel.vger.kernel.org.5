Return-Path: <linux-kernel+bounces-76946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F19C885FEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB1128B5DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C90159584;
	Thu, 22 Feb 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0HsD4pdJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="unL5meut"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE271552EA;
	Thu, 22 Feb 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621939; cv=none; b=gyLoJp9twgTFPZW5N5Bef+5D2y7NDLRrzPpRJrhBzYAR4/ZIxZF33AEkBjnOiV5y0A8/F+uYeK1feuj12CmgG8AzIEewVkPIlwImPLeiH1PAeqbcjstmaLi1koTRphBrZkSUFN84k3CyIDDDfCVZh71G764hSJVTsQlfLjKr/rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621939; c=relaxed/simple;
	bh=ozbVoaHulBQRTdA+15TUcjSwuGNzlg9H4sDlSjucpn0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K23rUDngQ4fWg2cKg7eXr1b6OuxpCv3ugbGGR2yxOWvvvVlMyPnp1qyxTlh7+AbGJnQvDF0mw2uW0f1dQYlMAJlpaKpI2wDbJWYEYNt5ehbu0bTbbhwAAbo9rcBQ4pciddVXTdtv5pRwsZcl5f0qSCqwEUu4kiLmfRSeIAhIewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0HsD4pdJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=unL5meut; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNe/OVUJimxSbdIHgG++gbjoBKTIvez+Gm5b6z2azg8=;
	b=0HsD4pdJ7HaOkEDlRNMtKoQyOIPOxoByLfbzK9y5w4yTE1qCgfWKWLYWgn2WOxxAMARew1
	3D5/IXjwKiZ9M+6WiAjbx6Hh8f4XAoOz9bCyxCxcGVeSczBqPD6Kq3dsPSbUpZOx0XK09C
	Vi/1i/Q3OYvwjQoh+zoJU9RlKSl1a4EWKLgW+/VxJ0eCOyK1MTRXHCOlRVUYh868VBReYY
	yykNC4rh1QG7ZwaZWieXnjaDXRKjxGSeiPZuIHEksjQFT/Gz+iL4EQHrj/ClR5f6dywnAL
	0aDLqFK1d5sIXzlHxEg3ZzaX7sRM2bfBbo8K2ZwG18lBLpeiSqS5DZBUW9zfqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621934;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wNe/OVUJimxSbdIHgG++gbjoBKTIvez+Gm5b6z2azg8=;
	b=unL5meutKBN6clF6GBv0qDUzFeZiZvVOztUMpC+DhpHfqTZsmDsEz/Qxb3QOw4tmFDTXc6
	Vfm5S0Mw+7yMi+Bw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Make sure TIMER_PINNED flag is set in
 add_timer_on()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-8-anna-maria@linutronix.de>
References: <20240221090548.36600-8-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193326.398.7723120743908395960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     aae55e9fb8fc73893f86165f0d84a33b7080902a
Gitweb:        https://git.kernel.org/tip/aae55e9fb8fc73893f86165f0d84a33b7080902a
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:31 +01:00

timers: Make sure TIMER_PINNED flag is set in add_timer_on()

When adding a timer to the timer wheel using add_timer_on(), it is an
implicitly pinned timer. With the timer pull at expiry time model in place,
the TIMER_PINNED flag is required to make sure timers end up in proper
base.

Set the TIMER_PINNED flag unconditionally when add_timer_on() is executed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-8-anna-maria@linutronix.de

---
 kernel/time/timer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index bef8cb8..121f5b9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1329,7 +1329,10 @@ EXPORT_SYMBOL(add_timer_global);
  * @timer:	The timer to be started
  * @cpu:	The CPU to start it on
  *
- * Same as add_timer() except that it starts the timer on the given CPU.
+ * Same as add_timer() except that it starts the timer on the given CPU and
+ * the TIMER_PINNED flag is set. When timer shouldn't be a pinned timer in
+ * the next round, add_timer_global() should be used instead as it unsets
+ * the TIMER_PINNED flag.
  *
  * See add_timer() for further details.
  */
@@ -1343,6 +1346,9 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	if (WARN_ON_ONCE(timer_pending(timer)))
 		return;
 
+	/* Make sure timer flags have TIMER_PINNED flag set */
+	timer->flags |= TIMER_PINNED;
+
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
 	/*

