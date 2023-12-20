Return-Path: <linux-kernel+bounces-7236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFFB81A385
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EE4282A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E504B13B;
	Wed, 20 Dec 2023 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Upqbn9Ur";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ieLmf02t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0268347771;
	Wed, 20 Dec 2023 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087953;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeuNT6qh/ePxhWCCgBLnPvvjr82CYuQlBf6grPl2IIQ=;
	b=Upqbn9UrJETggeWWgJ38dUbFgaJWIu6Wrtfdnrf3wvigjx5wz6npvgApwCqZH7yv2Vs6rz
	gmlMIJcxL5lN2Zca0g4+NlLbkzuXjOodOOgtykTUdCBh22yvCwM8j+FnSKHs3ER2K7RONt
	v+FPrM0QyNVz/GJAzYbvLOAULzTQz5N/g3i3GFrcFseYzVYr5YdAQ40oXkWxO37TgHl0BN
	EaiO1MNP+D0gED7a01iHexvhPIIEF+7yLG1sQwS3srfP4S6YvPJv5rKWjc0uQgn2+/i1tj
	lj8kK+V3KcQ7pxEnuxN7ubxvDqsfDJrTdA3GRnmuTdkmS/WuWxicutIoRt/CHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087953;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeuNT6qh/ePxhWCCgBLnPvvjr82CYuQlBf6grPl2IIQ=;
	b=ieLmf02tcrc9r2aBFbNSVz60b1Tu3uW61j0RUbB7VIv74wMyMfHVxzczmKSH+fF1HBq8Br
	oeNkEMDcLxZ9jWDA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick-sched: Fix function names in comments
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-2-anna-maria@linutronix.de>
References: <20231201092654.34614-2-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308795245.398.17239396413364535545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cb665db94fc61512c9c94ed1d42af67e7bf6ce01
Gitweb:        https://git.kernel.org/tip/cb665db94fc61512c9c94ed1d42af67e7bf6ce01
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:37 +01:00

tick-sched: Fix function names in comments

When referencing functions in comments, it might be helpful to use full
function names (including the prefix) to be able to find it when grepping.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-2-anna-maria@linutronix.de

---
 kernel/time/tick-sched.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index be77b02..ff25fdf 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -920,11 +920,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	}
 
 	/*
-	 * nohz_stop_sched_tick() can be called several times before
-	 * nohz_restart_sched_tick() is called. This happens when
-	 * interrupts arrive which do not cause a reschedule. In the
-	 * first call we save the current tick time, so we can restart
-	 * the scheduler tick in nohz_restart_sched_tick().
+	 * tick_nohz_stop_tick() can be called several times before
+	 * tick_nohz_restart_sched_tick() is called. This happens when
+	 * interrupts arrive which do not cause a reschedule. In the first
+	 * call we save the current tick time, so we can restart the
+	 * scheduler tick in tick_nohz_restart_sched_tick().
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();

