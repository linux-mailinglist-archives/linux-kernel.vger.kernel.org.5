Return-Path: <linux-kernel+bounces-70953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C93859EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAD4B212EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3FF219E9;
	Mon, 19 Feb 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrFiDScf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EpcCMYNY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6888721362;
	Mon, 19 Feb 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332338; cv=none; b=dZAhp7XsSO7v7NKSMap4w+E+aQt5FEalFYTYY+rNpCBpUC9bj6FuQ7F22KfYPD3xKTnNBkKiH2e3+gdqxSlvbxvXBo+pd3MYQNbxsDNn3eywgxDnWbJTP9KbCkKNggb5MJ01mqsRzMAxvGMKwoqnNSxHl+MKXJ5vB1y2MpR2mKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332338; c=relaxed/simple;
	bh=dRQEo0B/yKjlnjrGLXR1sOoC2GhyL+3WER4H84ry1lo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HiXjE/eypwUJRmGIJG9TPun3YqLgORtgu9dRzEgle2R4ICVa7LmAUlqDVFMRenJ5VQ0UMz0NX2QAMiEOIyoie3eucTr4dtWnvJRoIqPr3KlJSXfO+FzeeKSc4hEsMKAf/BIDce4FCLBoH6CvHnHggEo6hTJqNqAp2C8TxXLEhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YrFiDScf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EpcCMYNY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 08:45:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708332334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6yI2YSGAYOxFHAzOKGinUcGOxbUq72scA4KZncoj0o=;
	b=YrFiDScfngNNT0bHjJxirzfz8w/Vve+Mj9H4U1DiUraZ4BXN00Dh8v9MaxJ7anUQzI0A8l
	VABHflRbVK2vnturNc0LnWzbsYXvRJZe1Cjv9y6mQHnPLel+dfsiaHdG2CxlfSrnkbR1F0
	+ue4cAXNJWGhq70UusbeHg1qf1LwWkoGNUP2acsaKfSibGcjzxyATNXxnr7rgYoMyHGxgW
	G4zLMM6fB8LS3gUAjhX9QD1y1JIrUer/T+l/LVOB+PG0Lo7WXnL/s+fXhtgYdRWLF/doGQ
	e5nxyY1+GtwU3ROjkzeacKMNsGeiA/HKl+PYceEEHeqo9yqDD0mbZ1Nk60Zhfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708332334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6yI2YSGAYOxFHAzOKGinUcGOxbUq72scA4KZncoj0o=;
	b=EpcCMYNYjYQJqghWBMW6nXrnMheU23xF0eeF/dNyPSlpRD/nj46kOYAF30Zr8Bl49Rp0mD
	58vhRa8p6+lIrqDQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Add function description for
 tick_nohz_next_event()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240123164702.55612-4-anna-maria@linutronix.de>
References: <20240123164702.55612-4-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170833233361.398.7577148614843351327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f365d05506150398fe6b035918d6fd8b62f35b9f
Gitweb:        https://git.kernel.org/tip/f365d05506150398fe6b035918d6fd8b62f35b9f
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 23 Jan 2024 17:46:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 09:38:00 +01:00

tick/sched: Add function description for tick_nohz_next_event()

The return value of tick_nohz_next_event() is not obvious at the first
glance. Add a kernel-doc compatible function description which also covers
return values.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240123164702.55612-4-anna-maria@linutronix.de

---
 kernel/time/tick-sched.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 01fb50c..7c9efe3 100644
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

