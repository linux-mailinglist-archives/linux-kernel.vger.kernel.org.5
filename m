Return-Path: <linux-kernel+bounces-160549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABCF8B3F02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB251C2245A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF4172BA6;
	Fri, 26 Apr 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JUokkPj/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="58/p9xwV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B316FF47;
	Fri, 26 Apr 2024 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155137; cv=none; b=LcULpHPyyMQperVR3iUYdeGuI+lQ/tesCCrWXnvL/WEY2fnIwXb57L5RXJVePLD/Mca+JcyvQVqtiG8sZUBLqCrgyy5d6NrQrOEFRxr35mrNSrtUoq3v0c0xv7W3FeTkeWvPPaaIkf1gwcYOfGl4fIPE6dMUXk7MWdfBBmouuEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155137; c=relaxed/simple;
	bh=/Xs0Pp39mkKfV4NzZfYbAaZ2eB2sfnvsCLdIn63mb7c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uXXquqE5BBPRbL0U1wqFTUqk34hdS380h43nPnPqJhqPXrDp44iVpa0hnulSNm4o/BzwU/ROYzhHvQ6uupkGGBPVoQEm7jOTsW8g/dtE7s1Cx7uTtOv92dS6I70FFyNE5bjuKeuuBBLfU4oULnGRXCO9mNa4M4iuUJkWXOblTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JUokkPj/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=58/p9xwV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jd9/UNfAiD03pyMEnx6koXtMdXLus7ErmCDIzOTZ2zQ=;
	b=JUokkPj/DoBonSNhElDPzyNbuCVzVXLE2nz3EuorcPcSiGzXi86KqQi7i4pt+wtDaeC9tc
	kriTMgE0H4kStCnJOyN/SQfrttxoRIKAB5+UyFjm2uAVtXg9GC3XIt9DtQgIsDISQ9c/IQ
	T2B4wo0RiZjw7B1SwBPAspOL0xqha8sxcrBypwkcVaVmLilAi888yBZm42JZklrD4T5eLK
	R10Exyv/+R+8z2hMmFhLOKxcGl0UgEVDp3MgZ+uMzlZuPnwnhZkRbQvPHygg8QJNv1bgTs
	4/a4ioJwuGHk9ZcRDGUkmuC1cBDhUzhvHymRSLVObcBEWGNhWM9j8fX+bNPySA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jd9/UNfAiD03pyMEnx6koXtMdXLus7ErmCDIzOTZ2zQ=;
	b=58/p9xwVtJz6s0G9tmNPKhv8mcQ3iI3vPrBJx1SVWSkiXcJs+bILYjxGIRZPwo4O7uYqhW
	IQ1ocBXKmOm5FUBQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/aperfmperf: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513172.10875.1040239656569264211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a7c345216f881c810623035659aa672f3b926fcb
Gitweb:        https://git.kernel.org/tip/a7c345216f881c810623035659aa672f3b926fcb
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:05 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 08:49:23 -07:00

x86/aperfmperf: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181505.41654-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/aperfmperf.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index fdbb5f0..f9a8c7b 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -124,25 +124,24 @@ static bool __init slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	return true;
 }
 
-#define X86_MATCH(model)					\
-	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
-		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
+#define X86_MATCH(vfm)						\
+	X86_MATCH_VFM_FEATURE(vfm, X86_FEATURE_APERFMPERF, NULL)
 
 static const struct x86_cpu_id has_knl_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(XEON_PHI_KNL),
-	X86_MATCH(XEON_PHI_KNM),
+	X86_MATCH(INTEL_XEON_PHI_KNL),
+	X86_MATCH(INTEL_XEON_PHI_KNM),
 	{}
 };
 
 static const struct x86_cpu_id has_skx_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(SKYLAKE_X),
+	X86_MATCH(INTEL_SKYLAKE_X),
 	{}
 };
 
 static const struct x86_cpu_id has_glm_turbo_ratio_limits[] __initconst = {
-	X86_MATCH(ATOM_GOLDMONT),
-	X86_MATCH(ATOM_GOLDMONT_D),
-	X86_MATCH(ATOM_GOLDMONT_PLUS),
+	X86_MATCH(INTEL_ATOM_GOLDMONT),
+	X86_MATCH(INTEL_ATOM_GOLDMONT_D),
+	X86_MATCH(INTEL_ATOM_GOLDMONT_PLUS),
 	{}
 };
 

