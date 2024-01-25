Return-Path: <linux-kernel+bounces-38200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C7F83BC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63901C23887
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9193C1B968;
	Thu, 25 Jan 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jKrMpwSS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="73zPb6ER"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721B1BC26;
	Thu, 25 Jan 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173092; cv=none; b=Gi0Imwp+jaipQfApLLkg83B3B4wFnw6XB+yv5BHktziTGb5e4NvgbTzSkf8E7n10koxS8pwJNUlLnlHOEq4ha8+9LW40xRa/Pm7rzGQ1b1H1F4WuaWn0Dj+469KShVHSJLL/0Wu4jTD+2zzZdAtkBeM+UAQBYSLzgoYV9zT+wQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173092; c=relaxed/simple;
	bh=9W0rHMo1PmIbSLpl2yzt5yWUJKRIEZKegqCU/kJoaDM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DcpTx6qaSV8DJ4zC95KfJCr0to2b9iUASsY8+ZGyYNz1jVgQvPElB98NnrWez4Taqgs6m8p80krKHDNSAmZKU2BOVlvSg/MM6tHYwB4Ty3a6cq9/8nwttU9aaTJ2gtMTx7su9t0CbSEN6b8RhJOkvOH/L5eezsn/F1UQN4xdEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jKrMpwSS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=73zPb6ER; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 08:58:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706173089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WObzDTHXTDPa3dmfW8P5dQHGpAZC4IP5d5HH0veMj0U=;
	b=jKrMpwSS0vJ+enxX/UUdSXvZofeoh25ExNB30G4Gh0m29UyfX6Q5gghqGaSjrkomtLd5qp
	DCyKtaFJmwGKBeyQD5KD4rBbwok5ARPbVaJb3jG1JHUVkT2DOl/yN5+UsKfo6h+aErEReb
	hySSvzXGi8Ul0I3yQ689TEx6vRSpXoY2IGe58FZcRbbKDI06w/jdtfPJEEuvajj9HoG7bP
	hMnT50J1iA9ltXVQmwpM3ecd6z7pX97USGZO4OByOm9kUOs/8veBNK3WT06tFvuCTxWwcO
	KuEdIp1KMmc2hAVymLBwywK2uO0iNfo3h8gqV59Ij5jBosyvtcnM5kld1HlBFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706173089;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WObzDTHXTDPa3dmfW8P5dQHGpAZC4IP5d5HH0veMj0U=;
	b=73zPb6ERvA0LkZs/xmqJ61qIAudzbirFxV2ZgrnG4t39t2TZhOnApLSX4krcFxOkNGcWZr
	FUx7VlfUDuSnpJDg==
From: "tip-bot2 for Tim Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/sched: Preserve number of idle sleeps
 across CPU hotplug events
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240122233534.3094238-1-tim.c.chen@linux.intel.com>
References: <20240122233534.3094238-1-tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170617308836.398.11235504689824871790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     9a574ea9069be30b835a3da772c039993c43369b
Gitweb:        https://git.kernel.org/tip/9a574ea9069be30b835a3da772c039993c43369b
Author:        Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Mon, 22 Jan 2024 15:35:34 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 09:52:40 +01:00

tick/sched: Preserve number of idle sleeps across CPU hotplug events

Commit 71fee48f ("tick-sched: Fix idle and iowait sleeptime accounting vs
CPU hotplug") preserved total idle sleep time and iowait sleeptime across
CPU hotplug events.

Similar reasoning applies to the number of idle calls and idle sleeps to
get the proper average of sleep time per idle invocation.

Preserve those fields too.

Fixes: 71fee48f ("tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug")
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240122233534.3094238-1-tim.c.chen@linux.intel.com
---
 kernel/time/tick-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d250167..01fb50c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1577,6 +1577,7 @@ void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 	ktime_t idle_sleeptime, iowait_sleeptime;
+	unsigned long idle_calls, idle_sleeps;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
@@ -1585,9 +1586,13 @@ void tick_cancel_sched_timer(int cpu)
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;
+	idle_calls = ts->idle_calls;
+	idle_sleeps = ts->idle_sleeps;
 	memset(ts, 0, sizeof(*ts));
 	ts->idle_sleeptime = idle_sleeptime;
 	ts->iowait_sleeptime = iowait_sleeptime;
+	ts->idle_calls = idle_calls;
+	ts->idle_sleeps = idle_sleeps;
 }
 #endif
 

