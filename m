Return-Path: <linux-kernel+bounces-7233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6D81A381
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6882D1C24ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0694A9A8;
	Wed, 20 Dec 2023 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AdSucZPb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kg/bqHr1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96499495D6;
	Wed, 20 Dec 2023 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087952;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzybjEgY0lRz1tGpPCvCLZ+wsNlqMcfDI3U2j+gJiwY=;
	b=AdSucZPbmAtcbxh0qJc7JU/BWsQff3T1mvrbRjugXE7UR0NSUWlBoueKEnJ7cDLgqaMG4n
	sToEavjZbFvg/tGQDO8tWL20+KLvAYsIz/0LhOCBqgFjnOpzIlkQFGNggNR4t7hRvafC48
	qm4j8FQLAzYA3GTb7xXaCbgJDAJY9g7+OJdZxribj7tzN2gM8EQ0N3h5m8Jqx9TSPVnxLC
	+qrMqlFAd1KP+QCZz379UNpPPNiauh8xd4N6X6sUG9Z8drOFPrIIa6rhe1XO+WrI8TwDap
	02wd/tWupz+hxE1/dVs3L49TVJDtqJ7mrWmfMFXGx0Kof9bJ0I9wZhsDX49t9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087952;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzybjEgY0lRz1tGpPCvCLZ+wsNlqMcfDI3U2j+gJiwY=;
	b=kg/bqHr1m9Z3vQh8d5WASGyOKxW/4CSjWp1VJ29zulnC8dKmbLUV69CnCbKXyxmQnL/jZ5
	3VLb2LBHjT8rj5DA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] tick-sched: Warn when next tick seems to be in the past
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-4-anna-maria@linutronix.de>
References: <20231201092654.34614-4-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308795125.398.1424176018413782016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cbf04a22026100dceeceec67fcbf1973383eb32f
Gitweb:        https://git.kernel.org/tip/cbf04a22026100dceeceec67fcbf1973383eb32f
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:38 +01:00

tick-sched: Warn when next tick seems to be in the past

When the next tick is in the past, the delta between basemono and the next
tick gets negativ. But the next tick should never be in the past. The
negative effect of a wrong next tick might be a stop of the tick and timers
might expire late.

To prevent expensive debugging when changing underlying code, add a
WARN_ON_ONCE into this code path. To prevent complete misbehaviour, also
reset next_tick to basemono in this case.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-4-anna-maria@linutronix.de

---
 kernel/time/tick-sched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index fce3c6f..a17d260 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -839,6 +839,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 		ts->next_timer = next_tick;
 	}
 
+	/* Make sure next_tick is never before basemono! */
+	if (WARN_ON_ONCE(basemono > next_tick))
+		next_tick = basemono;
+
 	/*
 	 * If the tick is due in the next period, keep it ticking or
 	 * force prod the timer.

