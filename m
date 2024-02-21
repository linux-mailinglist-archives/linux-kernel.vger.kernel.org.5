Return-Path: <linux-kernel+bounces-74345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754AB85D305
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF85E1F22EE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B243D0BC;
	Wed, 21 Feb 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEmESPwo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHH97aoc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8E3C493
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506376; cv=none; b=cVAmObVeCc8nxceKq/0kN2+PmKItfeQ7kKJGxHKiFv3tIx9K3V1P6PjOSZoDLKmor+AFf4WeXIXjO7o9d1IL5fll2uYN7ka6+atnxu7D7JB2jx3PCe5X3Zo5GJwk9tTlGkv4BuBi4wGUir5igV5bOD6k3v5LyDpjecWS4SxvEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506376; c=relaxed/simple;
	bh=0AtunAhm4yop3m4xvmzGd+hzZGncHjxpu0P4GmAnNxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UZ4S318LGdcsmuDth14Bi82WxLcnjWUld8k2cP/OGtmMnne4GKtlgoOlHEEgsbqOhyebPX+o5RJQvKUGs6ux8KvYj5rn/lidVD6AqvGFdcTpUPfARHlrV6ZktX2lxSnAzpfy2eqlR4dE7YIde8jqVHQSDu0SuJ/Wetu+v/RpbP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEmESPwo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHH97aoc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708506367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vneXKeJPs1ClvnSuuOqDrAMvkymNvjYj3Z1H5l2g9Sg=;
	b=KEmESPwodaFkrKmhUVstJaC78bDPtNz/TfDJM1wMDkyhH3OQr4WPHShzCaRQ2REOUVWJna
	4uCF9pSWasqFawBs8UhAfbcDP22hl8t2rgR/kVY9g/Tvc7XsYAI/jA4atC/fI9fIhCQFTB
	CUk0bZme5i6NAPiQIHlTLZhQ0PZNyDQWMAOpdKK4qNIrPV6ZaQUL5oXf/Ji8GN6yR1IJ/V
	PxMWfVUlguiWWSTeXxyXzbTfsZHTgGa7mqh6uPKuxrG0OuxUtCARP1OKHXUIqg/XFdd73d
	36AIENSxuwnRmkRzct9rXaHnTRn8WXF9S/oXGrnn79jAsaIsd5Ci0l7XSIjErQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708506367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vneXKeJPs1ClvnSuuOqDrAMvkymNvjYj3Z1H5l2g9Sg=;
	b=GHH97aocnaVxt5bPD7KsD/FW0E4YZPLwb1A62txKWJjEd5Riz/Ot57Y5J+vogyUreQL9cr
	HKbTbxelpfjQmZBg==
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
Subject: [PATCH v11 01/20] timers: Restructure get_next_timer_interrupt()
Date: Wed, 21 Feb 2024 10:05:29 +0100
Message-Id: <20240221090548.36600-2-anna-maria@linutronix.de>
In-Reply-To: <20240221090548.36600-1-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_next_timer_interrupt() contains two parts for the next timer interrupt
calculation. Those two parts are separated by forwarding the base
clock. But the second part does not depend on the forwarded base
clock.

Therefore restructure get_next_timer_interrupt() to keep things together
which belong together.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 352b161113cd..5f21db4fa3ca 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1937,12 +1937,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
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
 
@@ -1960,6 +1954,12 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		base->next_expiry = nextevt;
 	}
 
+	/*
+	 * We have a fresh next event. Check whether we can forward the
+	 * base.
+	 */
+	__forward_timer_base(base, basej);
+
 	/*
 	 * Base is idle if the next event is more than a tick away.
 	 *
-- 
2.39.2


