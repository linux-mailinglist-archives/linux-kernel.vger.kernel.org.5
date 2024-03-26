Return-Path: <linux-kernel+bounces-118522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ADD88BC16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CE11F3F504
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D6134422;
	Tue, 26 Mar 2024 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZIcRNIoq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZxfcEH2F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5313341E;
	Tue, 26 Mar 2024 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440863; cv=none; b=pj3BrXj8RU9u3a/KlCih5va2wrTGqM1lqsD6w0xbjltAHjPYyc4m3544PXy8xC+laXh3e3RDPrfdckUyivC92B3DM72QjTKvdxwgmbKH7nGHSIJo9akQfVMoEQs8NO9/qtuslwojUTAXhz/IaxYwJOT6JuZcQjR1z+59E+cdwuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440863; c=relaxed/simple;
	bh=uXNuOnrlxoacDE4htCHyP4Jg8sVjasry7YMjexT7+ZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O7V8wwdOe1aOCgIqzVGZD5VIWkO1/NpnG3Da66Ke93/1A0j3JwV94bHCRUuJPM+k0/y8AOrRy/T8ofBaaLMTReV8hBx5Os1NIVY+tglxoE1EHoIoYtMMmI1sW6jvlv8B3C5bvoI0cVQ3g/savEUGAwKyt+3eg2O0CvRwQzWgraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZIcRNIoq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZxfcEH2F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 08:14:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711440860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvY99s+9IkddCUDp0OxjqZVvEwm8fe3ntlSIWWtmCj4=;
	b=ZIcRNIoqKqfxNcoNr7t5+KALq8NdV9Zoz8yt02it9iip/VC9oQCEDNr5/CtqFvYhHUAa7W
	OMrvVtV7hj8v0wH6t0uMpNIGp9d0Fe2e1tVl7KRhUePwDa5Y1AsySF2JVnTSraF9ZhAujC
	1mf07BO6Cq79U0hIAAiA9LH6qVwv6JT+P827hm8gDtEgqSVAKsDRj1jfzZPZLiHYZA03fW
	L2VSMbvSazEQ6CUvkvwlE7erPMxSN3xq5di2QxLwgaheAsm4ePYXkdKVytDmTZALQj26/e
	M4DknOxrmBMf9uZsgTw5LGIc/pnlvSFjDw/TAGuutBo5dE204pBYCTOpHJecLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711440860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lvY99s+9IkddCUDp0OxjqZVvEwm8fe3ntlSIWWtmCj4=;
	b=ZxfcEH2F9bBX2y/i2BDFVJ41dm++cbK1dq0yB7G7j27Z7OmNt9voLKx+eDugaL1yzyF4nM
	99lBV/ErpeqCUBCQ==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/core: Update and fix stalled-cycles-*
 events for Zen 2 and later
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Ian Rogers <irogers@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
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
Message-ID: <171144085952.10875.16500416606586334675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c7b2edd8377be983442c1344cb940cd2ac21b601
Gitweb:        https://git.kernel.org/tip/c7b2edd8377be983442c1344cb940cd2ac21b601
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Mon, 25 Mar 2024 13:17:53 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Mar 2024 09:03:40 +01:00

perf/x86/amd/core: Update and fix stalled-cycles-* events for Zen 2 and later

AMD processors based on Zen 2 and later microarchitectures do not
support PMCx087 (instruction pipe stalls) which is used as the backing
event for "stalled-cycles-frontend" and "stalled-cycles-backend".

Use PMCx0A9 (cycles where micro-op queue is empty) instead to count
frontend stalls and remove the entry for backend stalls since there
is no direct replacement.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Fixes: 3fe3331bb285 ("perf/x86/amd: Add event map for AMD Family 17h")
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

