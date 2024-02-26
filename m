Return-Path: <linux-kernel+bounces-82397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D78683A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02300285D96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F2132C25;
	Mon, 26 Feb 2024 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a+PR6vcY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+Hfg/FM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2A134CF0;
	Mon, 26 Feb 2024 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708986281; cv=none; b=JXQERrBPkiH3tM7WI8WZDl4GfxvBPJue0phFY0SG91qOlKkHnWniJStxgOICibRAgHamwC6SBiLCfJtR8zhCnY0dV13bhKQsjWWZtXedqHk034n2O1OYqUsbvpuJmu+MUyLZM4rMGgNxucUPQzW/+i6T2xaUB1sOY1Ayx2WfeT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708986281; c=relaxed/simple;
	bh=nj4FArUzS17fCDnTv2nbz4bnJVfZ6ptHp2GRa8B+Qkk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UMj6lh15c9XPf5xgq/lwHT7PzhVjQfoZXZL6ciwiAtLfQ9o0qtCPAjwPZ47+I5x1X5KHPk9Q57dG/xXg0DZxPahSbLQivc+V7Ku7bHjbQWw8HQtF17Mys/xwuJHinSOg/zj0L2JnjsE43aNwoJSyqIqYzdwPO1oYtaFniwMcPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a+PR6vcY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+Hfg/FM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 22:24:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708986278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiUwnVXiGuVOncjYHgN0ITXe2rAzjGZg8JGvNBNeTNo=;
	b=a+PR6vcYodKyYrqL9fU5Xw2GMJYkUROWaYB5CC4djm+wqMHGZBSP9cNt4Zfyf24c1kq5iy
	ApCdTRB++rfTOl02e4N/jqkcvndOSC05FgKR7Jy2uD7VLNCBBQpCwPfCrK0UE6lSKyHzC+
	fbC8rMPb99KszgonR/iwiddAD4HschykZS0zjI9bcA8NXnRhTwHJGfTQPlzMyjeXKX0Sv2
	MkpMsxWuf4cr3I2tlnwVqYbY+pRmgcx2v+NJ9qMOuL64sUjgT4SJSnRDKiHrWNDtuO8wUR
	bgFNeB6mfsSVIttrzTDfqIZnH3yFGWU6KAcPJ+0FA4e3YSiv/wpJjGM/oXjs9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708986278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LiUwnVXiGuVOncjYHgN0ITXe2rAzjGZg8JGvNBNeTNo=;
	b=f+Hfg/FM/ieK3tR4EEBS8mxDEqYqPDSBFyiY29RtJhAiYBGnhY2AGJF19SXLDA/3BRLI53
	xlusKNXFJx3NnZCA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Rename tick_nohz_stop_sched_tick() to
 tick_nohz_full_stop_tick()
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240225225508.11587-6-frederic@kernel.org>
References: <20240225225508.11587-6-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170898627757.398.5059768758723966854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3650f49bfb954119a33613672abe4ca3bbbf6243
Gitweb:        https://git.kernel.org/tip/3650f49bfb954119a33613672abe4ca3bbbf6243
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 25 Feb 2024 23:54:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 11:37:31 +01:00

tick/sched: Rename tick_nohz_stop_sched_tick() to tick_nohz_full_stop_tick()

tick_nohz_stop_sched_tick() is only about NOHZ_full and not about
dynticks-idle. Reflect that in the function name to avoid confusion.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240225225508.11587-6-frederic@kernel.org

---
 kernel/time/tick-sched.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 4e34967..9f75f56 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1040,7 +1040,7 @@ static void tick_nohz_retain_tick(struct tick_sched *ts)
 }
 
 #ifdef CONFIG_NO_HZ_FULL
-static void tick_nohz_stop_sched_tick(struct tick_sched *ts, int cpu)
+static void tick_nohz_full_stop_tick(struct tick_sched *ts, int cpu)
 {
 	if (tick_nohz_next_event(ts, cpu))
 		tick_nohz_stop_tick(ts, cpu);
@@ -1075,7 +1075,7 @@ static void __tick_nohz_full_update_tick(struct tick_sched *ts,
 	int cpu = smp_processor_id();
 
 	if (can_stop_full_tick(cpu, ts))
-		tick_nohz_stop_sched_tick(ts, cpu);
+		tick_nohz_full_stop_tick(ts, cpu);
 	else if (ts->tick_stopped)
 		tick_nohz_restart_sched_tick(ts, now);
 #endif

