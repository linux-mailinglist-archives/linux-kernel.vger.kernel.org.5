Return-Path: <linux-kernel+bounces-135399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8689C0D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BBE282315
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1817FBC0;
	Mon,  8 Apr 2024 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bdwmv9jm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JObSzMdu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261276402;
	Mon,  8 Apr 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581844; cv=none; b=t0SvO5rZ4VuHojsANwhXJmv/2JYPBjOb50COKLV4AT6GTVtBZRj8iZtJ1UF1tHm4dFyeibbQ7S0b1s4AWwJ2bysOmmOPV/yeMwcysT8YiQwJfqnC9BYuMcpqpOB6k60OqPtAADcxsa657CphLIQFOBykxskDX0pgW238kJ0uB84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581844; c=relaxed/simple;
	bh=KpncE/pvHbR/BX4vuCzdw8Nxv85kAUJOjthIsllPZTU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CixtfRZE3PBz5fOWOVs3ILkPg59qlCk95C9tZmVEUfZgSo+FObQzYBSERCU7n+XvVnR5+I5cg4dEPPT4Yi77uB6D+u/CZWT+oEp/jFE4h3a2fIJp4vES2KzBcQxyjbE3MgGR+QDnFp4P+Cd8SSEikUlXWkQk/AsFTUyy8kHWIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bdwmv9jm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JObSzMdu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 13:10:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712581840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SstGXUHg9aEiuUFZrfVlBr7emtfofKZa1/pqQX2B2G8=;
	b=bdwmv9jmIuiBKLcXCDg/tHazS5llMJqBP7WT+kGlH6VxybALgfbBqRh6vTKhFT/nP12BLl
	iqKGzx1weYM8BnQa4KAz0d/SHNSmKChDyzJjLsEW19Y7T2EufZpCJW2M8780A0lUFlE+0t
	dNRqTdEJIepJNh6vl8w+TJDeJA9BaNAAInAZwY6Gj3njaH1oh0OXeOkU2X9xWpwWp21aWZ
	x88OMwitrwUqdjz9MoIOp9frGqf6cBC0uN52KLpqjXoHKHMhpqElcbHOX8Osv1LVbw+kH5
	QMW+TWBbfOUlo7g8yURYV2LZAZNWYu9ROaF3oJh0roCue3HCXS4iq8aEWYETGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712581840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SstGXUHg9aEiuUFZrfVlBr7emtfofKZa1/pqQX2B2G8=;
	b=JObSzMduDYUuxyuuTS3ZyLYXktK3lxLITMcrWnEzaJJnPvSRaTK1/JlWiyNIwjXdAdGwRh
	u9IxF/4Pu4F9IoBw==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vdso: Make delta calculation overflow safe
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Adrian Hunter <adrian.hunter@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240325064023.2997-9-adrian.hunter@intel.com>
References: <20240325064023.2997-9-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258183964.10875.16766485938132892744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7e90ffb716d289b3b82fb41892bb52a11bdadfd9
Gitweb:        https://git.kernel.org/tip/7e90ffb716d289b3b82fb41892bb52a11bdadfd9
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Mar 2024 08:40:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 08 Apr 2024 15:03:07 +02:00

x86/vdso: Make delta calculation overflow safe

Kernel timekeeping is designed to keep the change in cycles (since the last
timer interrupt) below max_cycles, which prevents multiplication overflow
when converting cycles to nanoseconds. However, if timer interrupts stop,
the calculation will eventually overflow.

Add protection against that. Select GENERIC_VDSO_OVERFLOW_PROTECT so that
max_cycles is made available in the VDSO data page. Check against
max_cycles, falling back to a slower higher precision calculation. Take
advantage of the opportunity to move masking and negative motion check
into the slow path.

The result is a calculation that has similar performance as before. Newer
machines showed performance benefit, whereas older Skylake-based hardware
such as Intel Kaby Lake was seen <1% worse.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240325064023.2997-9-adrian.hunter@intel.com

---
 arch/x86/Kconfig                         |  1 +-
 arch/x86/include/asm/vdso/gettimeofday.h | 31 ++++++++++++++++-------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4fff6ed..4e251ba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -168,6 +168,7 @@ config X86
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_VDSO_TIME_NS
+	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
 	select HARDIRQS_SW_RESEND
 	select HARDLOCKUP_CHECK_TIMESTAMP	if X86_64
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 5727ded..0ef3619 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -319,18 +319,31 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  */
 static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, u64 base)
 {
-	/*
-	 * Due to the MSB/Sign-bit being used as invalid marker (see
-	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX.
-	 */
-	u64 delta = (cycles - vd->cycle_last) & S64_MAX;
+	u64 delta = cycles - vd->cycle_last;
 
 	/*
-	 * Due to the above mentioned TSC wobbles, filter out negative motion.
-	 * Per the above masking, the effective sign bit is now bit 62.
+	 * Negative motion and deltas which can cause multiplication
+	 * overflow require special treatment. This check covers both as
+	 * negative motion is guaranteed to be greater than @vd::max_cycles
+	 * due to unsigned comparison.
+	 *
+	 * Due to the MSB/Sign-bit being used as invalid marker (see
+	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX,
+	 * but that case is also unlikely and will also take the unlikely path
+	 * here.
 	 */
-	if (unlikely(delta & (1ULL << 62)))
-		return base >> vd->shift;
+	if (unlikely(delta > vd->max_cycles)) {
+		/*
+		 * Due to the above mentioned TSC wobbles, filter out
+		 * negative motion.  Per the above masking, the effective
+		 * sign bit is now bit 62.
+		 */
+		if (delta & (1ULL << 62))
+			return base >> vd->shift;
+
+		/* Handle multiplication overflow gracefully */
+		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vd->mult, base, vd->shift);
+	}
 
 	return ((delta * vd->mult) + base) >> vd->shift;
 }

