Return-Path: <linux-kernel+bounces-35702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC37839557
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7761F2FDBD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE627F7DF;
	Tue, 23 Jan 2024 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQbY4po9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hCS4YdrH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30581ADA;
	Tue, 23 Jan 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028440; cv=none; b=au+XFqf+TYO2rxzSUpnaNiJLpsxUOakg8T3yyg6n21xs1UAupLOGTGw0isset81C/5Uil0A9nMiOX50ZuFDuFz2WUS/X7HzVWZW+gVDPkZ5QXu/gN9bRHoHGzuGw9oorAqLDZgFlquWJ+IFPt3xqp1u97ibL5LR+qZJeo8zFqYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028440; c=relaxed/simple;
	bh=HFSMKE1bgjlAsGi1MrNiRokzcDfgJUWmntUgaecyamk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uoiQcr43motOuMY3+UmKSkcC4haIhNAzwlKaeFUJFLJT8wdD5QzRTGMzFflBzsBJsnPFounGbCrlOiFB1OyiRfsuq121jNn3mZcRgpw082XTJugutuVuwKWUdrVudtjfqpYrUKCDNr+WM7v3s1pZsbUd15iQw/97LTPDgOx9SPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQbY4po9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hCS4YdrH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706028436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhoBCIZZLnCECGPqIowTZ08lfwc9D2r/FOyJZ9QOgHo=;
	b=BQbY4po9HrsTcQSx6IkQD07yysEbfa4dnqHfgGWm2R08w1+kBTf3TcXMz1E0ZWoUu76L7R
	y+A/uJuVblFUHY0X9+q9KY/cr7ZvpMECXXNvn2OZKj12dvirphwqwWJYCr3QYydDrzduzr
	y/kBQGhCVHoHmuidPBEPv5TB0gdGuKRXypCoaNdQLrA80U2GGNstNYpxpZVREkGTkrIsoB
	RmZc9aXaj9PRk0HjiBwZCPAW0QiRGACAuIQAlvNDZWe7HmC78IKiN4GQL/nEmTOQAnbfOu
	+3mfaxW9XGUu+Pm/QmjfehV6rlL2VT2U4PNgE+P4/IfT/jCSNWQ750wKlAcXqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706028436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PhoBCIZZLnCECGPqIowTZ08lfwc9D2r/FOyJZ9QOgHo=;
	b=hCS4YdrHkHiUDoT7f1qYKpzoe5053vW64j3zVCAWgRFdpio0XsNCTJa6rBZ33hdfoAjs2J
	Q0wxamm1ERTY60BQ==
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Clemens Ladisch <clemens@ladisch.de>,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 3/8] tick/sched: Add function description for tick_nohz_next_event()
Date: Tue, 23 Jan 2024 17:46:57 +0100
Message-Id: <20240123164702.55612-4-anna-maria@linutronix.de>
In-Reply-To: <20240123164702.55612-1-anna-maria@linutronix.de>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of tick_nohz_next_event() is not obvious at the first
glance. Add a kernel-doc compatible function description which also covers
return values.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-sched.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d2501673028d..e1d80f462551 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -799,6 +799,16 @@ static inline bool local_timer_softirq_pending(void)
 	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
 
+/**
+ * tick_nohz_next_event() - return the clock monotonic based next event
+ * @ts:		pointer to tick_sched struct
+ * @cpu:	CPU number
+ *
+ * Return:
+ * *%0		- When the next event is a maximum of TICK_NSEC in the future
+ *		  and the tick is not stopped yet
+ * *%next_event	- Next event based on clock monotonic
+ */
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
 	u64 basemono, next_tick, delta, expires;
-- 
2.39.2


