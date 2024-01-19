Return-Path: <linux-kernel+bounces-31332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D0832CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A197B2301A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A198654FA6;
	Fri, 19 Jan 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZFPK9QiI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kuDG/Evb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C154BFC;
	Fri, 19 Jan 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680111; cv=none; b=RXQYVBoRNkZ0MAmKYGEbE1/Zq1DLeQScJbw8UxQVRhUD5TqeDCrIlmGHtmfRmgIKbGaKOWI50uX+iCEqADmOkU9qZ/Iulg+7bm9RIeXmaSQvsdIC+L4zJdcndyyBDrSi5fQMaJF6BqZwhu0V1KcTosX6+li+FlC6la/v9R2KpEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680111; c=relaxed/simple;
	bh=8kuc08C2taB58eMQ6rGGFADhFfGm4/dWdPXlBPFcrus=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jEIGjJWkV7oiv17imMjVczr9Sn86o/m1/ej0VoyC5iBEulsH6ToPjykjZFuFO9FvMv/k49rmnYTukI5cmHvp2kgh3Zx9mzzfod3akKBiasZx6hBJIsySrpM/bKMGaa+xbdc40dma7v5NMDaTMoMcJwFX32IA3RC94zn+kr6fhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZFPK9QiI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kuDG/Evb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 19 Jan 2024 15:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705679234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFazF9OBwT3EjQqG8QuBCT1kbtLVarHDzsAbA8dTKw4=;
	b=ZFPK9QiIICfd8WUV0M7dre8KmtFwLNjg/6SE4JlANPlmsZ781B/ossw5+vZB7K74lBxE1s
	/A+WYMOH8FtXds5SG7TuDi+KZ/f73fJLxkqX0vpNceovvg2Gsszed/YTCrgQLD9FsWf8MN
	7Z8p7ZKlNACtXyBw1ga3Qrbe0+01hMd/vq6FtGOn+GPSLry3AtY3c8aXqvm17HgCWoDSFS
	j4HD1ioYtW2XCg9qqqK5eKDNcd8lnXAG14KL1SVSzibxq3FWuWM0flT0jxeWXtOS1yZQ7t
	OnpQNWNyF0HaEXq/k/fohU9Z5hr7mOIXPCMggMS8bglWH7QseOl7yRK4LwN5Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705679234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OFazF9OBwT3EjQqG8QuBCT1kbtLVarHDzsAbA8dTKw4=;
	b=kuDG/EvbM+WAIO/NIPmWXdZoSDPWxyZ/aVvK9yTG2xXRNSdkFU3RWl+Xi1h7BRXQyP7u2f
	QnEaaZvu7OIZFZAA==
From: "tip-bot2 for Heiko Carstens" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick-sched: Fix idle and iowait sleeptime
 accounting vs CPU hotplug
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240115163555.1004144-1-hca@linux.ibm.com>
References: <20240115163555.1004144-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170567923344.398.15988931354472984709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     71fee48fb772ac4f6cfa63dbebc5629de8b4cc09
Gitweb:        https://git.kernel.org/tip/71fee48fb772ac4f6cfa63dbebc5629de8b4cc09
Author:        Heiko Carstens <hca@linux.ibm.com>
AuthorDate:    Mon, 15 Jan 2024 17:35:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 19 Jan 2024 16:40:38 +01:00

tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug

When offlining and onlining CPUs the overall reported idle and iowait
times as reported by /proc/stat jump backward and forward:

cpu  132 0 176 225249 47 6 6 21 0 0
cpu0 80 0 115 112575 33 3 4 18 0 0
cpu1 52 0 60 112673 13 3 1 2 0 0

cpu  133 0 177 226681 47 6 6 21 0 0
cpu0 80 0 116 113387 33 3 4 18 0 0

cpu  133 0 178 114431 33 6 6 21 0 0 <---- jump backward
cpu0 80 0 116 114247 33 3 4 18 0 0
cpu1 52 0 61 183 0 3 1 2 0 0        <---- idle + iowait start with 0

cpu  133 0 178 228956 47 6 6 21 0 0 <---- jump forward
cpu0 81 0 117 114929 33 3 4 18 0 0

Reason for this is that get_idle_time() in fs/proc/stat.c has different
sources for both values depending on if a CPU is online or offline:

- if a CPU is online the values may be taken from its per cpu
  tick_cpu_sched structure

- if a CPU is offline the values are taken from its per cpu cpustat
  structure

The problem is that the per cpu tick_cpu_sched structure is set to zero on
CPU offline. See tick_cancel_sched_timer() in kernel/time/tick-sched.c.

Therefore when a CPU is brought offline and online afterwards both its idle
and iowait sleeptime will be zero, causing a jump backward in total system
idle and iowait sleeptime. In a similar way if a CPU is then brought
offline again the total idle and iowait sleeptimes will jump forward.

It looks like this behavior was introduced with commit 4b0c0f294f60
("tick: Cleanup NOHZ per cpu data on cpu down").

This was only noticed now on s390, since we switched to generic idle time
reporting with commit be76ea614460 ("s390/idle: remove arch_cpu_idle_time()
and corresponding code").

Fix this by preserving the values of idle_sleeptime and iowait_sleeptime
members of the per-cpu tick_sched structure on CPU hotplug.

Fixes: 4b0c0f294f60 ("tick: Cleanup NOHZ per cpu data on cpu down")
Reported-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20240115163555.1004144-1-hca@linux.ibm.com

---
 kernel/time/tick-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a17d260..d250167 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1576,13 +1576,18 @@ void tick_setup_sched_timer(void)
 void tick_cancel_sched_timer(int cpu)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	ktime_t idle_sleeptime, iowait_sleeptime;
 
 # ifdef CONFIG_HIGH_RES_TIMERS
 	if (ts->sched_timer.base)
 		hrtimer_cancel(&ts->sched_timer);
 # endif
 
+	idle_sleeptime = ts->idle_sleeptime;
+	iowait_sleeptime = ts->iowait_sleeptime;
 	memset(ts, 0, sizeof(*ts));
+	ts->idle_sleeptime = idle_sleeptime;
+	ts->iowait_sleeptime = iowait_sleeptime;
 }
 #endif
 

