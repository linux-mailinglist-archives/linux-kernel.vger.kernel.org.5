Return-Path: <linux-kernel+bounces-86835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A272D86CB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EBCDB23E59
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B8A12AAC1;
	Thu, 29 Feb 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yvLz7rhS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2dO8eOrS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB513774A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216626; cv=none; b=r/sejhlvD4hlwz8iI0zTPalADv7qDBhW2jm8GfDE+dMsbqpwKQ28oIda2GXU33He3u0iGYnglLYvmliNYLQKZqPeyTxhWym0kXykJ36WoDlxYRJpf1swPdrEb85BdujKqeHgqW+rcw/B9nn6UvzPWxhzyOhKahCm3BDI2oXIE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216626; c=relaxed/simple;
	bh=yV1Vbm8kbRpxhEC85aNrHys8axlAFGfQgZDSVAUbcdE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=A6neTgu2g58A8Tb6QF36pP4iJUQgzi0ylg8IthObA+8Hozthbw5ekViaqVjItao7C2aOVAO7b6PILV8feSf87Nowj0Ob0X5njEN6PBtNI7BunhdrmHtqO20QkSkJwoRjQlor17X5FVVa8cs2xgziQDnwNnIVXv5SvOxqL/f/G1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yvLz7rhS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2dO8eOrS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240229142248.518723854@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709216621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=el2DwwRk9lMlTFOxyOulzJroAc1k+VvNXpXzxagNgoY=;
	b=yvLz7rhSaw7axm8/3n1DA19ePmitL+wj35rPIcC2uDQouACfyuWIG8QNkxPZ84Fxy/V6fY
	+Yj9D/MrXBivgT38Wlo/L1SFAKfvmVlaWNjgd0IsO8CSsoa9oTglFryHEhOClNSG8OEvcC
	y50bYPR81kaN4CHRkr2d66hMUXNdnaEY+MjcBXgNscjAKvf4Ot21ckaJLS17DcQ7ImMecZ
	Q3QiNHgjWSzX7MAxXCEgG7wH6tvBhk0AXqJTtQncMTFLj6kMxAvH8+3qmI9eLlj+4neQMJ
	1jYd+yci1tODDM4s4pcqzvbK/Vf9jWPXMBnxBeKsyZ3JyiDp1J/2TZW41FLyGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709216621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=el2DwwRk9lMlTFOxyOulzJroAc1k+VvNXpXzxagNgoY=;
	b=2dO8eOrSh2R+3dVq5vLwiMqoKO7zRcwIEj8IOfIAsdhwBy9B0nxo3sLA0q1TBXVJIlRIrr
	AN7GyaXVojKHS/CA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 5/6] x86/idle: Let prefer_mwait_c1_over_halt() return bool
References: <20240229141407.283316443@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 15:23:41 +0100 (CET)

The return value is truly boolean. Make it so.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/process.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -853,21 +853,21 @@ void __noreturn stop_this_cpu(void *dumm
  * Do not prefer MWAIT if MONITOR instruction has a bug or idle=nomwait
  * is passed to kernel commandline parameter.
  */
-static int prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
+static bool prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 
 	/* If override is enforced on the command line, fall back to HALT. */
 	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
-		return 0;
+		return false;
 
 	/* MWAIT is not supported on this platform. Fallback to HALT */
 	if (!cpu_has(c, X86_FEATURE_MWAIT))
-		return 0;
+		return false;
 
 	/* Monitor has a bug or APIC stops in C1E. Fallback to HALT */
 	if (boot_cpu_has_bug(X86_BUG_MONITOR) || boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E))
-		return 0;
+		return false;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
@@ -876,13 +876,13 @@ static int prefer_mwait_c1_over_halt(con
 	 * with EAX=0, ECX=0.
 	 */
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED))
-		return 1;
+		return true;
 
 	/*
 	 * If MWAIT extensions are available, there should be at least one
 	 * MWAIT C1 substate present.
 	 */
-	return (edx & MWAIT_C1_SUBSTATE_MASK);
+	return !!(edx & MWAIT_C1_SUBSTATE_MASK);
 }
 
 /*


