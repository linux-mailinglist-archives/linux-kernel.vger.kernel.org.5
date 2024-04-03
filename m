Return-Path: <linux-kernel+bounces-129197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C488966D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01BB1F28B22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0E6EB67;
	Wed,  3 Apr 2024 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpDXx3Oo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="quQwbNua"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9195C8FC;
	Wed,  3 Apr 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130032; cv=none; b=t1Q58IGnD2Ks7JzUHG9yegG1VixgXKJCo8m2sZQg+XpaNbIhk3D3ChC3QGII+LY0N9sgj+xHqV3nmwfO2H0Y9jZGk6Q+14UMv790IsrO6ee+2BVb8M5g4ZcFMV4sw9y3nBb7rWI7zU6rvCZW9804LkF/f5DsZmkybhueNYT8X1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130032; c=relaxed/simple;
	bh=xz5niPW26FF12C5dQBcipAFWPYqvK4P0bAEQaNE1kcc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UnWcpLNt/jbxNlJnJq8Fv9zwt0dUDLsyCsBlWGL1lzsJ74y6jJZAniCTWVF+9x0qDA6xxJVjEaxQvc/F0pdtH9ak9suh/E0vM3e/A/83vgyslcfYs1tdT2rnJk/j2/JhmJ0SxD1yyxhBkf50RNfsj/IQrGQmVYOqkL8wPjOG3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpDXx3Oo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=quQwbNua; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 07:40:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712130029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zx8zzTB6OCY48v3Lo1fOhQeel0GTDH4TqEKk7ytogA=;
	b=zpDXx3OoEP3jad5U/1FBNi0NEIj0F63VrQTK8SOlViLMXmV/cffZ+KhGPEqWugsN/fJXC0
	wk8TELsxU6Q75LdRVgq9fUYETg99jNBoa+Jk2nPQib3srRE8zwP64d0sed7+oXJD00i8k3
	3kX1BYXFJStfB1i/69ch22wZOX0A3P3X6aUQfWvGtpicWAd/qyj1GYEdeURMtt2Dk/B67w
	mLOWKPZdbV4spNl/masbbQR2URu3h1N8/frarFMZBqUdwWnoA7L4KyVwskSKVNIBYtSdAU
	1al3/Qe8mTi2L8/oopGWwUsVdX5mCPrgqNwLY8PNnovsTjv1LVfTzuf0POwB+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712130029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4zx8zzTB6OCY48v3Lo1fOhQeel0GTDH4TqEKk7ytogA=;
	b=quQwbNua/998RkjWT52ShQnIREu3AsdrssieLTjgBC7I9B4IdXiV/c5belsy9Y7lliio5b
	L22LCfFAPMMPZeDg==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Ensure amd_pmu_core_disable_all() is
 always inlined
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Sandipan Das <sandipan.das@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240402022118.1046049-2-andrii@kernel.org>
References: <20240402022118.1046049-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171213002832.10875.15810292580039392764.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0dbf66fa7e80024629f816c2ec7a9f3d39637822
Gitweb:        https://git.kernel.org/tip/0dbf66fa7e80024629f816c2ec7a9f3d39637822
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Mon, 01 Apr 2024 19:21:15 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 09:14:26 +02:00

perf/x86/amd: Ensure amd_pmu_core_disable_all() is always inlined

In the following patches we will enable LBR capture on AMD CPUs at
arbitrary point in time, which means that LBR recording won't be frozen
by hardware automatically as part of hardware overflow event. So we need
to take care to minimize amount of branches and function calls/returns
on the path to freezing LBR, minimizing LBR snapshot altering as much as
possible.

amd_pmu_core_disable_all() is one of the functions on this path, and is
already marked as __always_inline. But it calls amd_pmu_set_global_ctl()
which is marked as just inline.  So to guarantee no function call will
be generated thoughout mark amd_pmu_set_global_ctl() as __always_inline
as well.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20240402022118.1046049-2-andrii@kernel.org
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 985ef3b..9b15afd 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -647,7 +647,7 @@ static void amd_pmu_cpu_dead(int cpu)
 	}
 }
 
-static inline void amd_pmu_set_global_ctl(u64 ctl)
+static __always_inline void amd_pmu_set_global_ctl(u64 ctl)
 {
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, ctl);
 }

