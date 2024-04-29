Return-Path: <linux-kernel+bounces-161947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B252F8B53AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E0D1F21849
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC128DDA;
	Mon, 29 Apr 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p/R0Kk8p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqehEpHw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF3199C7;
	Mon, 29 Apr 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381324; cv=none; b=EA3XbJWEnGG/vTaAry/ezwBvk0e0msATxh4KuD/hp4pNzdA7JB4u/VKHort9MIs7tgFytJg8aEyqDTuhNFVxp8HNPyKQR0tfU8bdBuNIZsTtfeiwwn+WIZkBZMKuEWyhjwiQrOfIsUK+gBe0oSEyFAmm9JrpZkkboaUURNYNcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381324; c=relaxed/simple;
	bh=szM/oj8H6MkK5P0WosI/YkwUD+vH3mnJjuOkpqWpAIY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=siZhasS04wMCBmJ7ZZj6tPl9YRi465aaMe9PHRDNyAi+6IhCpFFoC/OB/na8YwnOXmlaQKSvee6c5fI6GQmhJ7VwHO5FVnZGSH8C5l8Nmu9DveqGV9ZvP8LDS3BMm6+6uvXkQPxvo5Tq/cE32Atg4AwavRfIVGmwWPWBoFJ5j0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p/R0Kk8p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqehEpHw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Apr 2024 09:01:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vppM6fRfRxF2LNHbRHR3s8eGVhgCzGCOOJ+5hrrvhFY=;
	b=p/R0Kk8pA5Io6hbJZ4T14TUXiNq3dZ6ovPXF/+1+ihMpgn5GyzXV4fa0sG8e8I3/k5Pgrz
	TCN3dsM0UF8YWdbNwGnlHnqZMC2dq/veEaOblI6Vc92AqQszW42nqAnuJCLPkxTNZV8/82
	rRQp2HZaLcMngRsyyeNSIgBYDy2cLbeNzKfeyLkdQFjRbeQV5OnmXi1hskDhWNt+7lPG2S
	rsWgLzYki9xCwJel9Lqp7wDo42ips1qhs9b4e+KKmhS2j2zl3OXcwVPw+4kYu+6p98cfIv
	652zF4WTh6U0yC02WTNghI/1a3YR73wlzxtPPobxMfpwlmg53G87fWNwgNQyyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714381314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vppM6fRfRxF2LNHbRHR3s8eGVhgCzGCOOJ+5hrrvhFY=;
	b=LqehEpHwv2Zm3ZU9VaX8MXXBNS+DBPCQix/a43CQZvPuiHyjFMwWPqFjG6gN+hzIaFlXUB
	UwMM7/xanOKNMoCw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/tsc: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171438131383.10875.2260333950581084127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f21b075b672411772a5fe359c29aff2b70fcc51d
Gitweb:        https://git.kernel.org/tip/f21b075b672411772a5fe359c29aff2b70fcc51d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:17 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Apr 2024 10:31:32 +02:00

x86/tsc: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181517.41907-1-tony.luck%40intel.com
---
 arch/x86/kernel/tsc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49..c474514 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -26,7 +26,7 @@
 #include <asm/x86_init.h>
 #include <asm/geode.h>
 #include <asm/apic.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/i8259.h>
 #include <asm/uv/uv.h>
 
@@ -682,7 +682,7 @@ unsigned long native_calibrate_tsc(void)
 	 * clock.
 	 */
 	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_D)
+			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
 		crystal_khz = 25000;
 
 	/*
@@ -713,7 +713,7 @@ unsigned long native_calibrate_tsc(void)
 	 * For Atom SoCs TSC is the only reliable clocksource.
 	 * Mark TSC reliable so no watchdog on it.
 	 */
-	if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
+	if (boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT)
 		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 #ifdef CONFIG_X86_LOCAL_APIC

