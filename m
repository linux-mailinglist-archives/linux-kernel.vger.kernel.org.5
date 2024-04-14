Return-Path: <linux-kernel+bounces-144071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0488A4182
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D761C20D07
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065A22EF0;
	Sun, 14 Apr 2024 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+zPO3NB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/R9VLDvu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406C1AACB;
	Sun, 14 Apr 2024 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713086377; cv=none; b=sbMrlRe4zvfRxGev/q/MegIUidwD8+l4Zv/bfjkXWpQYsM8FsZ5I6r9EuGoeiE15g+GncUvRtzzq5YoDBuR31WVlte/zxKL/LcP8VyfT9oD68FWd5TRlQZZp/I7W6Ll8EWF7HVV+8/cgnQ5GLzmFMpFqvhUuRS0oOQIUlAn5hDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713086377; c=relaxed/simple;
	bh=lnii2kZ8IUvaZdbR0jQA4QKCoeVDNlBUw1Zj8Jm+CSI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZWN/JsneHkCj1Sb5OJPIe3skNktr8T0x0f097Aqm++ucqeC+069bdbEuSdAOLv2/r9mrvQkmxa14RCqwuejPAXvsumB/FfRdpuzNWbOTTE27G/qb3RNZXaFiT9tV/tfRrCSjc8kHw/FKjQ3KDLPqVjijvgRFlTnmgIb1zlGPrFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+zPO3NB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/R9VLDvu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Apr 2024 09:19:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713086373;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZFwphc8SHYVbPnkWi5EsmyxN8HbgaWmtnfTFBlfG2c=;
	b=v+zPO3NBl+tOpY3Gaa72M2N78iAfXLIyevqEEBWTNi9nQ4GyWdAa3inddo0OiaWI0uEynB
	I2hpVDIKTJk4xJ7sbM0MdcfFEgPw5MuSd5pqmfp0Pe3STGPH5IV4oNcN7iyCLoMR7jRHkO
	aVyZrUbXJtmtu26sXxssgfyAzQc3SpQK5nFfUwfqm9TuM9RfFVLHTOxRU3FTo0nWQ4VwFn
	usbll9gf3oIuRQLIIZKRTD02EDSVesO/OkPj1pycqjC8MVlKknRfIxiSWBnzW7reuis9Rv
	y/95iDuuGC+JNX0Qez3hk4ScGNQAw7Mo2EQzVmg69Lqxa3GvjF+sH+qTBRitVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713086373;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZFwphc8SHYVbPnkWi5EsmyxN8HbgaWmtnfTFBlfG2c=;
	b=/R9VLDvuW1MdHw2em5hXToeU3yOsOLRAWusGogzGe914o418BIQ236z4Hx6Dvh9OEYplKZ
	T8EklU8FDWr2fJCQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Fix BHI retpoline check
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <ad3807424a3953f0323c011a643405619f2a4927.1712944776.git.jpoimboe@kernel.org>
References:
 <ad3807424a3953f0323c011a643405619f2a4927.1712944776.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171308637277.10875.5583955178829069240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     69129794d94c544810e68b2b4eaa7e44063f9bf2
Gitweb:        https://git.kernel.org/tip/69129794d94c544810e68b2b4eaa7e44063f9bf2
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 12 Apr 2024 11:10:33 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Apr 2024 11:10:05 +02:00

x86/bugs: Fix BHI retpoline check

Confusingly, X86_FEATURE_RETPOLINE doesn't mean retpolines are enabled,
as it also includes the original "AMD retpoline" which isn't a retpoline
at all.

Also replace cpu_feature_enabled() with boot_cpu_has() because this is
before alternatives are patched and cpu_feature_enabled()'s fallback
path is slower than plain old boot_cpu_has().

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/ad3807424a3953f0323c011a643405619f2a4927.1712944776.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ca295b0..ab18185 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1652,7 +1652,8 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+	    !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
 		spec_ctrl_disable_kernel_rrsba();
 		if (rrsba_disabled)
 			return;
@@ -2804,11 +2805,13 @@ static const char *spectre_bhi_state(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_BHI))
 		return "; BHI: Not affected";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_HW))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_HW))
 		return "; BHI: BHI_DIS_S";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
+	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+		 !boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE) &&
+		 rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Vulnerable, KVM: SW loop";

