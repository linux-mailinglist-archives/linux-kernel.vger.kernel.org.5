Return-Path: <linux-kernel+bounces-44944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D607D842948
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3BF28E48E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739913B7B8;
	Tue, 30 Jan 2024 16:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wt7sjOz4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+c2h1I56"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB813343E;
	Tue, 30 Jan 2024 16:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631978; cv=none; b=g0uf7pgGkE+jRFMYGJDznqxm6QdPz3ogYDFJ4z6Yy1OQlqnXkqu1pKgeplTW1VON4FetuBs+WSzh5tioRAOepmOKfplcJmO98vHHtxYhhS6eMeKXTzd18+Jq/wk4/D6PE74S7FQ7AqtgvpU2gom7YGPXgxVPN/wp4V/GHI5ZkDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631978; c=relaxed/simple;
	bh=B0h6aWvGJPn004tzOVelOWQ/cqMdt1JhDKgOfQBTOuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JPEM/ZC3cpgBuouby/Zg0gixQESGlgcyfeGB2PMlg4e4E+kxkRq4bLguWF8I5/HJBR3YF3r6BBv44fAkpqQmL3yCnPSvg/89am32SxZxkucQWm0T34A2LfWtNGD49j1+RV6Ret+Lhx7G+PstgA6B0nXcLlclT7B86fdm9G1pjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wt7sjOz4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+c2h1I56; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqvRhN/JExx8+Z5V9A9N5RTe7yanjkFdVmwkLfKJCYY=;
	b=wt7sjOz4RSGQMq4opw2RDmStXFnO4RpZWZIwFK3Q0yfMbYK/T4+J2BWPxsWTJGj8GY/x6z
	rJX1zTSejoox9aUHuOOZr+zX3hJkgC7Pr5U4xc9D6uVc+u+r186iCU8t75JIaWHn6xWQ/J
	qssXOtisfHlV4E+8JUngc05JcpYX//fhxOUGiako1Nbt7+PDPVwyAIIfH/+Vcsav3M/+Hv
	EktDJLe1LU3K78RHaHpn4Xq4CQMR+/aYB13021ZDjYGwdh2NnG8Wr6slDTQysAnsoPxpPz
	6rNXvoprJa5MetbQ9nOUCtANJSNt7hg0WY49b2iVTFwN7M8n3ygNAx1CxvHPqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631974;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqvRhN/JExx8+Z5V9A9N5RTe7yanjkFdVmwkLfKJCYY=;
	b=+c2h1I560F8XbPlbM3fo8jXKHNptWV9wZBG4tRakwxnvnselXBVJJ2zVjyT3+LckFFzyGh
	qF+PdMH6ZYpQelDQ==
From: "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/cpufeatures: Add SEV-SNP CPU feature
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Jarkko Sakkinen <jarkko@profian.com>, Ashish Kalra <Ashish.Kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-2-michael.roth@amd.com>
References: <20240126041126.1927228-2-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663197324.398.18228422573623248861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     b6e0f6666f74f0794530e3557f5b0a4ce37bd556
Gitweb:        https://git.kernel.org/tip/b6e0f6666f74f0794530e3557f5b0a4ce37bd556
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:01 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:13:16 +01:00

x86/cpufeatures: Add SEV-SNP CPU feature

Add CPU feature detection for Secure Encrypted Virtualization with
Secure Nested Paging. This feature adds a strong memory integrity
protection to help prevent malicious hypervisor-based attacks like
data replay, memory re-mapping, and more.

Since enabling the SNP CPU feature imposes a number of additional
requirements on host initialization and handling legacy firmware APIs
for SEV/SEV-ES guests, only introduce the CPU feature bit so that the
relevant handling can be added, but leave it disabled via a
disabled-features mask.

Once all the necessary changes needed to maintain legacy SEV/SEV-ES
support are introduced in subsequent patches, the SNP feature bit will
be unmasked/enabled.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
Signed-off-by: Ashish Kalra <Ashish.Kalra@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-2-michael.roth@amd.com
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/include/asm/disabled-features.h | 4 +++-
 arch/x86/kernel/cpu/amd.c                | 5 +++--
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index fdf723b..0fa7026 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -440,6 +440,7 @@
 #define X86_FEATURE_SEV			(19*32+ 1) /* AMD Secure Encrypted Virtualization */
 #define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* "" VM Page Flush MSR is supported */
 #define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* AMD Secure Encrypted Virtualization - Secure Nested Paging */
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* AMD SEV-ES full debug state swap support */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 702d93f..fc13bf7 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -117,6 +117,8 @@
 #define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
 #endif
 
+#define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -141,7 +143,7 @@
 			 DISABLE_ENQCMD)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	(DISABLE_IBT)
-#define DISABLED_MASK19	0
+#define DISABLED_MASK19	(DISABLE_SEV_SNP)
 #define DISABLED_MASK20	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f3abca3..4baba69 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -605,8 +605,8 @@ static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
 	 *	      SME feature (set in scattered.c).
 	 *	      If the kernel has not enabled SME via any means then
 	 *	      don't advertise the SME feature.
-	 *   For SEV: If BIOS has not enabled SEV then don't advertise the
-	 *            SEV and SEV_ES feature (set in scattered.c).
+	 *   For SEV: If BIOS has not enabled SEV then don't advertise SEV and
+	 *	      any additional functionality based on it.
 	 *
 	 *   In all cases, since support for SME and SEV requires long mode,
 	 *   don't advertise the feature under CONFIG_X86_32.
@@ -641,6 +641,7 @@ clear_all:
 clear_sev:
 		setup_clear_cpu_cap(X86_FEATURE_SEV);
 		setup_clear_cpu_cap(X86_FEATURE_SEV_ES);
+		setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
 	}
 }
 
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index f4542d2..e58bd69 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -437,6 +437,7 @@
 #define X86_FEATURE_SEV			(19*32+ 1) /* AMD Secure Encrypted Virtualization */
 #define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* "" VM Page Flush MSR is supported */
 #define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* AMD Secure Encrypted Virtualization - Secure Nested Paging */
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* AMD SEV-ES full debug state swap support */

