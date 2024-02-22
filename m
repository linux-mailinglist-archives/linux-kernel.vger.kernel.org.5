Return-Path: <linux-kernel+bounces-76951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A9985FEFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4FF287F78
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32D015AAC1;
	Thu, 22 Feb 2024 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IhR/W+a4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cAAATO3m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D115956A;
	Thu, 22 Feb 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621941; cv=none; b=aiMmHsQ7LsWwMzVC++1KwHpXcCwyR46/UXk3PUOjcAfdShzIKmRjoVwh9ymmjOSIldYh0nHHaIdYyiaW+wdl1KO1uRV78046WYgZECcHfcC2QPKdmb/zi+uYUa2H028OMsf0W6+ZXxK4aajDxUcIpIiE0r6DsWyjkRbO6Ad7KHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621941; c=relaxed/simple;
	bh=BFK93q7x8VcvAeQitpb7x4GJH07K8Y6wwibPvJMxf0M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q3+LCLueoYtYc4KYTewSoA/hi6R8305EuO6nNlWV2NHUQ/EsqgaeYx1cAE24goMErq+NmWjtVgH4GIXAjVv+9kZwE0i39KwomBvwyI/1bphumCdkmkLkRXe5doeJKnwx8P0fRBFXxYHDT6SLTX4fgbEgL13n5ME5Cerecfze3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IhR/W+a4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cAAATO3m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 17:12:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708621938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjN4cSx6w81HhPEeACaKGE2eN4w6oIBmUtX+lza1qPE=;
	b=IhR/W+a430F6AcA9g+m9V0ga75c/0k3qIxp0jD7wBVQR3tOHFJ+XdaqW3UB4i0+jDNddDu
	8QBBW2qGQ/11DztBu2c8om1iCYrysyayCeWFqd/F58f5DGNcwc5EVkZG57au2zDPR9iNsG
	LT622Ujo2AkVG65B+e+WIUvA2JV3FOmXNLZrMKKke7aAj+qPCVH7aXTcEBFb1vb1MMQhas
	H8q+RhpVz3oBeHVoT6NagwVj0gl+3bQvs67nOrN29KkvrDo+rK+CpQaDTBzNQ5a7Ebn/e3
	a2JBcz0pIknjNg8Fc+77Gb9jO/G7cbZ+VGNdLYWRSWJPZ4GHefM1i9td9K8SkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708621938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjN4cSx6w81HhPEeACaKGE2eN4w6oIBmUtX+lza1qPE=;
	b=cAAATO3mGTixw0BcZCH5JJ/Bamred5+rDEhfJqytyJ98/iuheY2fQ4vPuTtsiSEJFQyI2S
	gzFW+TD0+8ESLgBQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Restructure get_next_timer_interrupt()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240221090548.36600-2-anna-maria@linutronix.de>
References: <20240221090548.36600-2-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170862193726.398.15267422855712611141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bebed6649e85fe55275bd20104ec8e0bdff1bf54
Gitweb:        https://git.kernel.org/tip/bebed6649e85fe55275bd20104ec8e0bdff1bf54
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 21 Feb 2024 10:05:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 22 Feb 2024 17:52:30 +01:00

timers: Restructure get_next_timer_interrupt()

get_next_timer_interrupt() contains two parts for the next timer interrupt
calculation. Those two parts are separated by forwarding the base
clock. But the second part does not depend on the forwarded base
clock.

Therefore restructure get_next_timer_interrupt() to keep things together
which belong together.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240221090548.36600-2-anna-maria@linutronix.de

---
 kernel/time/timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d44dba1..316ded6 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1982,12 +1982,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	if (base->next_expiry_recalc)
 		next_expiry_recalc(base);
 
-	/*
-	 * We have a fresh next event. Check whether we can forward the
-	 * base.
-	 */
-	__forward_timer_base(base, basej);
-
 	if (base->timers_pending) {
 		nextevt = base->next_expiry;
 
@@ -2006,6 +2000,12 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	}
 
 	/*
+	 * We have a fresh next event. Check whether we can forward the
+	 * base.
+	 */
+	__forward_timer_base(base, basej);
+
+	/*
 	 * Base is idle if the next event is more than a tick away.
 	 *
 	 * If the base is marked idle then any timer add operation must forward

