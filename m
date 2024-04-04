Return-Path: <linux-kernel+bounces-131155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232548983CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3334288801
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BB47581D;
	Thu,  4 Apr 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EOQbvgel";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Us1zLD3Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322727441C;
	Thu,  4 Apr 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221881; cv=none; b=oWIKT96NqNl3C1CIgCiIt8WR2E6OQQu2s4W9vvaDDQ1KE5ESOHWq28AGUHST+wToMXU8WiApVqS0kAZPQ6MPR6MB73bWWLxtDsEdpNNRxqPzbmAOX0gmQEwZ1tlkOBt2fA6Rn0T/nSCeYNJ9c6VDX0rqNTGvdPf5spVA4SRPys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221881; c=relaxed/simple;
	bh=1AVxcRcxQ+8gsWxFQV2c52Cxbze4tk12vFx+32U8s70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pAAI0SmMz2sjd5f65NhAWVKCjD++MGdi4WWC5BVoQRGDUKTcfGILIEx0/KGJ1FJjsgYLldMLwyZWbWpGyPcpMfOOzr9pyapoi2J5Ka60I8E6y/sWTRiSfiWJBshKeVRxw1e4u9frF2fmqX9Ici+DjtTopj1NC/QaB0XYzbnSaIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EOQbvgel; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Us1zLD3Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 09:11:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712221878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsAoNUXTpwWBhnhoA004f/Vlu//19mS2FvY1h0r1Auw=;
	b=EOQbvgelgbOsJJfS7iNFOuGzhmX6J7y4/vBO0LMHViJVsGuIHO58EdwMEZru3ZwEYXUZr5
	No4WUAtp+28smEF3vLCp2JIST/gAjEE50iE7G6bJzl8gnnkoVX+4gDhubdj1pWxafOfHOO
	DikFOz8FL3Bqd4RgHSWapIHr628rTA7O78Rh7FscCyzkal7iqFNw4m2o7tK2MVptfPImfe
	uZnZo9a0oq+u9q5qhrm66fFkeIHSmmyXXk/I4UTLuVnuky2rvNkhJlVCK5lZkx8bdmexIC
	j7uUtR+nkjSUGrQoGTqdf+M0XS5nR5Av2qwN1xgmDtGhqWCG1bWrA49Dehkuzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712221878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsAoNUXTpwWBhnhoA004f/Vlu//19mS2FvY1h0r1Auw=;
	b=Us1zLD3Qjp8WoIjIo9xEYfH8Pw/djHkk/9MXZZJCmEpqsp/t9pWrC1Pe4CixRVf1ddvvNk
	26iSQ3C9w/4DpPBw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Catch late X86_FEATURE modifiers
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Srikanth Aithal <sraithal@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240327154317.29909-3-bp@alien8.de>
References: <20240327154317.29909-3-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171222187750.10875.4089921606500177665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     97784e52f18fe6e0d6516ded8ecd3cec722ce9cc
Gitweb:        https://git.kernel.org/tip/97784e52f18fe6e0d6516ded8ecd3cec722ce9cc
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 27 Mar 2024 16:43:14 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Apr 2024 20:03:24 +02:00

x86/alternatives: Catch late X86_FEATURE modifiers

After alternatives have been patched, changes to the X86_FEATURE flags
won't take effect and could potentially even be wrong.

Warn about it.

This is something which has been long overdue.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Link: https://lore.kernel.org/r/20240327154317.29909-3-bp@alien8.de
---
 arch/x86/include/asm/cpufeature.h | 8 ++++++--
 arch/x86/kernel/cpu/cpuid-deps.c  | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 7103ba1..e5d8880 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -148,8 +148,12 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
-#define setup_force_cpu_cap(bit) do { \
-	set_cpu_cap(&boot_cpu_data, bit);	\
+#define setup_force_cpu_cap(bit) do {			\
+							\
+	if (!boot_cpu_has(bit))				\
+		WARN_ON(alternatives_patched);		\
+							\
+	set_cpu_cap(&boot_cpu_data, bit);		\
 	set_bit(bit, (unsigned long *)cpu_caps_set);	\
 } while (0)
 
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b717420..5dd427c 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -114,6 +114,9 @@ static void do_clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
 	if (WARN_ON(feature >= MAX_FEATURE_BITS))
 		return;
 
+	if (boot_cpu_has(feature))
+		WARN_ON(alternatives_patched);
+
 	clear_feature(c, feature);
 
 	/* Collect all features to disable, handling dependencies */

