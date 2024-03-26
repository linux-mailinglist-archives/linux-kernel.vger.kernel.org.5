Return-Path: <linux-kernel+bounces-118521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3555A88BC13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483D81C30526
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CAE134405;
	Tue, 26 Mar 2024 08:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ca5+ABR1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RnTyQSC9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D956130AC8;
	Tue, 26 Mar 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440862; cv=none; b=Ue94bUvfoWFvXvykHKxoYdcc+HQUAuc/t29PnYUixk8H+oOi/AUYvM/JAQ/iyPEbZZwkNbHA2Ia2pMQ1c3UL+JtyaWALiX8vzMFFQGsr8Y7mpMsqx78T4Jh8FoI60rui3iaBslOTx3D0uBYEk2Y9KsW8MQyOwAGFBz6p8+fAeBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440862; c=relaxed/simple;
	bh=jLSn338qOihURpjvsURRbw6RHTZ0FohTfnDvpjv7Lqc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d9gxV0i/ct8P+k/pkBbdQdDMzgm5JB/fVAQMoH64Ze2epaepi5zE7CxTCkezNL8pLPfU2WB3+DVD8ExIpPK5866U5+1tuYW5G4tNdttMzVKp5ZwomcZMOQONZPVnGhItufHsCHLqalAMApVxNnC6mYxqcNuu48vFoCzsg0J/Th4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ca5+ABR1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RnTyQSC9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 08:14:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711440859;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFLgsNJfpu+vPg8vrPYFz2GD3r/pUuQt7HsOv7OoJsI=;
	b=Ca5+ABR1vtJXxqxYW+r1FGJJMe6T4NSQTdfVLsUsiuA9Tz4yF4M1NS5N8kzWZFXtEC0Y1R
	qxnVqIVoZirom4V/bhbuNBqJqZaFvXnyKvYIOEuyJjZ4jovaSMMPrck66+34BSzcnoYzKw
	iex4HHuDh0D6i39JQHQbJf8ZfWMrWutyl4+9AB8SQtrIQixoduwsPvOXLYazDO/LeNu8CA
	FI5y0+Ty4/ILok7aA2JE0cvdD06yq+SAwjb1gOE5hUhZmuSZB0ywUL3N5Qw/aDeeOmfZrk
	vp/LjxnWgfSPJ84eTgDVJZ9KP7rVLPdDNje8syhmD2xrgYa3Q/O4kpnn+EgqrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711440859;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFLgsNJfpu+vPg8vrPYFz2GD3r/pUuQt7HsOv7OoJsI=;
	b=RnTyQSC9MQNQZb7gcnRBvfiWn33MmQPHt4/7RZwKKkL/cAhmHizqzjpznrrLkIdzEK2oVn
	SlFdmfgTwoPRhWBQ==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd/core: Define a proper ref-cycles
 event for Zen 4 and later
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Ian Rogers <irogers@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
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
Message-ID: <171144085875.10875.4543656707439916020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     68cdf1e6e8f2ce78ed7d8f5d80844fd75a9c54ff
Gitweb:        https://git.kernel.org/tip/68cdf1e6e8f2ce78ed7d8f5d80844fd75a9c54ff
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Mon, 25 Mar 2024 13:17:54 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 Mar 2024 09:04:21 +01:00

perf/x86/amd/core: Define a proper ref-cycles event for Zen 4 and later

Add the "ref-cycles" event for AMD processors based on Zen 4 and later
microarchitectures. The backing event is based on PMCx120 which counts
cycles not in halt state in P0 frequency (same as MPERF).

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
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
 

