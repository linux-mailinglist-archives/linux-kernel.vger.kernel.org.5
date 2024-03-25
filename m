Return-Path: <linux-kernel+bounces-116835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74C88ABED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A44BE1B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24DB1B8830;
	Mon, 25 Mar 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FzNRCvtB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d2HjPGZd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080966E616;
	Mon, 25 Mar 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362564; cv=none; b=DxIeMFm5qT+d5rKmrXO47YDJcO+q3Rp3pDJX4actvlcaHXjuglqewechCBKEWzkiPqQZDcA4BuIA2H8HMLQ1/RQCNcprIoNqqCiU3oXVx0VjG/dwYQ0kLU/FXZMOWjKfhbOq1aw477neSrLubaL/9tqMnnpnG32/Tnu29UMw6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362564; c=relaxed/simple;
	bh=mLpBg2nWRyz96DYpNS5I78B+tK+MUUvH4ycRNC28LKY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dS5dyzXoqUVd6ml6Ot1Oa71BqTHiPoKA2d+mVni1HwJlowMJ44uwGv02gDmq0OOIJiYIhC/XnLDW9RYLubUHgZQ3xHAtaTOfE4Hnl72S3DmYWglcE7as5QbxcwHwq2Ahjg95xdE+lmdXK4PoH6K3hTXWFnoiMWAcpGlIT8uHBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FzNRCvtB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d2HjPGZd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 10:29:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711362560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cBI7Cp1vH/oBUW0wsybTtTvF3/j1JbyDwHKAuM7m2k=;
	b=FzNRCvtB5/4UyroB0IZ9FPYSZLMQK6VPDQ5cHmKjltRqckY6HBtNYw2qMMudIB2i+YnBJK
	3tyddrXw0gPRHpGz69H07cWwFhFlam2j9aDapbqp1sAs1T4Kf/+IdlSGuWhnvajCAf+EqB
	IjxdCeiVf3EzWpEYEtMit35MDkfrX2nlrVqJjYhJgqFioTolp/IpYlqg0/0Gr6U6wCq0fl
	lJFovWsHETQjAxSAC6Z+ItUMMlKm0pT8TTlwXnjjPynpBOkygafHVwEjxA9NdO1x46vRl/
	zH2TSA91QZMEYDQsOya0/Bu8mMkxKPq+c7ZRX0mETa6bh77awp+lptSpeXRcmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711362560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1cBI7Cp1vH/oBUW0wsybTtTvF3/j1JbyDwHKAuM7m2k=;
	b=d2HjPGZdi2ONkdmVkIGf8TcGCqJs0zcH6E7pTpdP6O/NNRwx4Vv8+4v1TftcSp5AT7RxLy
	P5OTtEnstvkiDtAw==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/core: Define a proper ref-cycles
 event for Zen 4 and later
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C089155f19f7c7e65aeb1caa727a882e2ca9b8b04=2E17113?=
 =?utf-8?q?52180=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C089155f19f7c7e65aeb1caa727a882e2ca9b8b04=2E171135?=
 =?utf-8?q?2180=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136255986.10875.1380945659061646748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     563bdbac10e5abe49c332b380fedd8ee7dc72b05
Gitweb:        https://git.kernel.org/tip/563bdbac10e5abe49c332b380fedd8ee7dc72b05
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Mon, 25 Mar 2024 13:17:54 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 11:19:04 +01:00

perf/x86/amd/core: Define a proper ref-cycles event for Zen 4 and later

Add the "ref-cycles" event for AMD processors based on Zen 4 and later
microarchitectures. The backing event is based on PMCx120 which counts
cycles not in halt state in P0 frequency (same as MPERF).

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/089155f19f7c7e65aeb1caa727a882e2ca9b8b04.1711352180.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index af8add6..985ef3b 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -273,8 +273,23 @@ static const u64 amd_zen2_perfmon_event_map[PERF_COUNT_HW_MAX] =
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00a9,
 };
 
+static const u64 amd_zen4_perfmon_event_map[PERF_COUNT_HW_MAX] =
+{
+	[PERF_COUNT_HW_CPU_CYCLES]		= 0x0076,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= 0xff60,
+	[PERF_COUNT_HW_CACHE_MISSES]		= 0x0964,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c2,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c3,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x00a9,
+	[PERF_COUNT_HW_REF_CPU_CYCLES]		= 0x100000120,
+};
+
 static u64 amd_pmu_event_map(int hw_event)
 {
+	if (cpu_feature_enabled(X86_FEATURE_ZEN4) || boot_cpu_data.x86 >= 0x1a)
+		return amd_zen4_perfmon_event_map[hw_event];
+
 	if (cpu_feature_enabled(X86_FEATURE_ZEN2) || boot_cpu_data.x86 >= 0x19)
 		return amd_zen2_perfmon_event_map[hw_event];
 

