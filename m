Return-Path: <linux-kernel+bounces-116836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E44D88A463
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386982E2290
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDC21B882F;
	Mon, 25 Mar 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GxgGfHpH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XajBnTq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA413440C;
	Mon, 25 Mar 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362564; cv=none; b=WaY1CPo/7TjAfCxFSPLXQRqKmnTyRHCqQxt2C+F0Y1W/8XxMrA4UFyp2+WyoxtbFtJiU0YAZNMsKp3A2tRo0d3QRyOqDAP/0QdZ1rNe0PUh5ulz4nqB0xv4tiLrkULPG6nUYfF11FQ44E17BPzT9CcWvsQ3noAo8HMYBEhgaqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362564; c=relaxed/simple;
	bh=gTC5jGrpIUy8wNswYDJ4xgk17WjevtxRNJPN9INO5ao=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=usERvIha1rtLu6bSUdw20dQkRM8piuPnwRWpNeNV3j0EmqoOpT8MOb2ujqHw24g92OX7t0Hi0ZY+GC87gkcPTE2PaBd4vTfJR76r+ImZxVLAocYO5DrnU4krAfMC1VQJq/yfyxXCq61scZvRTjI6N7w23khUlIFZen8h4pclh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GxgGfHpH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1XajBnTq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 10:29:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711362561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vZ9Pt18MQOXZEKO7ljPdhQHodQ8rsIEpEa+kYXBOhk=;
	b=GxgGfHpHRsfc1f0bNi6ddL4b+nT0ha2v1BKmXZ0/X2N7nRGShP3N4CRiHDrcyOyiBopgjw
	0Cf5CJ5Ri0P04k2Z2wx2S+E7Fx53DyTQNgTe8HcsTW3aYw14rtCdbFaCicmXYCMHYQUoU5
	ih8xoT0RlcD3o6K6D3w29twSVnKTVBboXgQlBtTfXCXVvZkGduKqFrioO4ZcxnCPUyR+RF
	/SjF1e0QQaVUR1aJRY579XHPcluAUzM1ymfYF8ExfgaF8As2/n0vxx5ULHLL+x3mFHigts
	u+8/3kY/s0EjXnhtDb1+UVtL8DY5g+GCW+AWv3ZB0e7lQIknDanHWYHUiTH1UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711362561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vZ9Pt18MQOXZEKO7ljPdhQHodQ8rsIEpEa+kYXBOhk=;
	b=1XajBnTq47HxF+FfrCBY5Rntk+Zj1o2kxPbUoOTe49x1WU4JP3zapg1Dm6UP/6BggkSN4u
	WQhNcvttUAjgzGAQ==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/core: Update and fix stalled-cycles-*
 events for Zen 2 and later
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C03d7fc8fa2a28f9be732116009025bdec1b3ec97=2E17113?=
 =?utf-8?q?52180=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C03d7fc8fa2a28f9be732116009025bdec1b3ec97=2E171135?=
 =?utf-8?q?2180=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136256064.10875.16163303893503887112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2a3da5fe10731ca6ccb396b29be612faee76fb69
Gitweb:        https://git.kernel.org/tip/2a3da5fe10731ca6ccb396b29be612faee76fb69
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Mon, 25 Mar 2024 13:17:53 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 11:19:03 +01:00

perf/x86/amd/core: Update and fix stalled-cycles-* events for Zen 2 and later

AMD processors based on Zen 2 and later microarchitectures do not
support PMCx087 (instruction pipe stalls) which is used as the backing
event for "stalled-cycles-frontend" and "stalled-cycles-backend".

Use PMCx0A9 (cycles where micro-op queue is empty) instead to count
frontend stalls and remove the entry for backend stalls since there
is no direct replacement.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/03d7fc8fa2a28f9be732116009025bdec1b3ec97.1711352180.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 5692e82..af8add6 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -250,7 +250,7 @@ static const u64 amd_perfmon_event_map[PERF_COUNT_HW_MAX] =
 /*
  * AMD Performance Monitor Family 17h and later:
  */
-static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
+static const u64 amd_zen1_perfmon_event_map[PERF_COUNT_HW_MAX] =
 {
 	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
 	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
@@ -262,10 +262,24 @@ static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x0187,
 };
 
+static const u64 amd_zen2_perfmon_event_map[PERF_COUNT_HW_MAX] =
+{
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0xff60,
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x0964,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00a9,
+};
+
 static u64 amd_pmu_event_map(int hw_event)
 {
-	if (boot_cpu_data.x86 >= 0x17)
-		return amd_f17h_perfmon_event_map[hw_event];
+	if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86 >= 0x19)
+		return amd_zen2_perfmon_event_map[hw_event];
+
+	if (cpu_feature_enabled(X86_FEATURE_ZEN1))
+		return amd_zen1_perfmon_event_map[hw_event];
 
 	return amd_perfmon_event_map[hw_event];
 }

