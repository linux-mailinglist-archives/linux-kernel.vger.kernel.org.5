Return-Path: <linux-kernel+bounces-131232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D27298984E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6221C26517
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BBE762CD;
	Thu,  4 Apr 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LKQ9lBh0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+QAEfTO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27274BE2;
	Thu,  4 Apr 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225811; cv=none; b=r+vPJtaXhOPRYRsXuyKd6NVxkO5wuS4U0VaPgyCOiqHAfQXoy7g2OxdlVWMqmJcXIKNBPhUcHditLBPVjX3YRP2SYxNxYu2fVJiiE3cb+vppL1/zZU62roRUy6PCqp1iLsBUQ6Z0WaqPC+sFnUa44X1dHA14Ze6CJOtJJlFxh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225811; c=relaxed/simple;
	bh=eKJ893bTP2ZAMl0eplHbyOQmdpCa292D8CJNu7UnB1Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A3sMKFGevuJSljDURt9UwH8aoxHUsdbpVh9LL1PL0iVewhnzKxgzg2DwXPRUF/BaS+ixcVGY4FvJFtilwWgktc3P2DW2g1vpdug7E2fzmMM/7hgjjYWttIV7KcGbdZtfg9W8IsavIDWyMdLgNrvXw6R4Bj5Sa6cJKYkzxdQOlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LKQ9lBh0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+QAEfTO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 10:16:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712225803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk2jf1Bfefxj5TMf2164pWJSRGhltl0GuHSomyCRU3k=;
	b=LKQ9lBh0R5qXTL0Nw3YdmrRM4dyUW2r/ns08C+30TSrBJBEdJsQpF603/gKRA6z4HcT84M
	Bsscw4+gsdwiSfE1fVwlh/PgWKTslW6mye+XnjtS80d5QGbmLxRvWdXKLmgsRPE818OCY3
	2x4u3Xb9q4g+DjyiRXKy/fOGxR7I8gsaXltwEf62FdC6ViZVTiuvT1aj94IPgUt7zxClWv
	zJ41jCcC7+1CRSxZaJ4PlNun2SqgjbxAgjouiTFUL5CO4oWD9/ImnRJUpsOZlgDn+x47jX
	+BhID8pFNKxa/ODTQi2Wgcqfa/EmhUxUXhhY123kO2y7vjYUw+7FXRSld4X/pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712225803;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mk2jf1Bfefxj5TMf2164pWJSRGhltl0GuHSomyCRU3k=;
	b=t+QAEfTO8WViW0IvXEfRvzRHh+LYNiAtoGR5pDN2iumqvsyOBfg2U0MpcfRRoirzhcSzZ9
	+5a0f8C1vkalbXBg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Catch late X86_FEATURE modifiers
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Srikanth Aithal <sraithal@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240327154317.29909-3-bp@alien8.de>
References: <20240327154317.29909-3-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171222580192.10875.2680389025942672029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     4175b45dec4cd8ae4563bf724d591ab5cc0ad9ce
Gitweb:        https://git.kernel.org/tip/4175b45dec4cd8ae4563bf724d591ab5cc0ad9ce
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 27 Mar 2024 16:43:14 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Apr 2024 12:09:17 +02:00

x86/alternatives: Catch late X86_FEATURE modifiers

After alternatives have been patched, changes to the X86_FEATURE flags
won't take effect and could potentially even be wrong.

Warn about it.

This is something which has been long overdue.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Link: https://lore.kernel.org/r/20240327154317.29909-3-bp@alien8.de
---
 arch/x86/include/asm/cpufeature.h | 8 ++++++--
 arch/x86/kernel/cpu/cpuid-deps.c  | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 17fd7be..f8d7a06 100644
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

