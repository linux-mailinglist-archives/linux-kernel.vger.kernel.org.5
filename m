Return-Path: <linux-kernel+bounces-44945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54D984294B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE391F292BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C52313BEAD;
	Tue, 30 Jan 2024 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sacx46S6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKv42Ukd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A2137C2B;
	Tue, 30 Jan 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631979; cv=none; b=KwgVpJKXQUNARSm7RnyJeMJHBhhVvMHu0gLhmSIk6c744ThDK6kmSHQ5rNYxuy1sjqr9f4aWBchOW6A1vUmN6GXrRhNNlkiyLO3cQJCl6kSxrWRNDA8fM+iS321phe0LqBQpPtlbqu6kR2NX5bbboTMEftsHvamBOfGkldwtAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631979; c=relaxed/simple;
	bh=2Z+DqwLrOTlEZtmtvqHrOMU4bM5HdTHPDUJrj8SQZpE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KRppRn9zdmx/L1ZpaffFd2b6bqwPjm9d0GSMlsKlZqXLPBBMx9IRPvaNrqogHnw8vH7G3LVC/BFlqRv/8lUy6U9VJvJiDwCY6izpwQgWPIOCOxp3HfmWRjiKHWKxVeAQvjrzTEiaHpkByG+93zXHiSgemQBmAuB8jUIjg1RVddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sacx46S6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKv42Ukd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vlBWR4ni7gRjWjPqo2lfaQlbNasDoG4pk6ry00Cg7g=;
	b=Sacx46S6h8jjg8rzPp6/fMBNU540s9lQwySdBoes5uxEVGSmvvUWOlo99oTJQLSavORkHl
	aOJUrP5tRIeyqYZL0ay1juzO4ik7R8JxP7GUmJEaHvo9qp1rqZ6FBcv17dWnlzqhyAS5wl
	s1lA2tt3t0B79QK6aIPJbqozZo8LsteMIViTw7AkA0kYJrvE93lNdNW5ifi94GRZT1Ou/W
	Va1fdq8KBeqBqiAXkZvlAlIMQ1CovZjuF1bD9cVmYecvVYa/Mmos7C3OBcgYix3iaMRRGy
	apihtQPkHbcjDuy1PA19y4vy/scut5wZzvQQgYg/4Bx1PJUnZ97BrW4cGU3bOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vlBWR4ni7gRjWjPqo2lfaQlbNasDoG4pk6ry00Cg7g=;
	b=dKv42UkdRRbp0DNbrhvXJMSr8CKakpeOz9o5jf+Sq5wQc6c7R66Vqf6jbtpPjI0im6IQ8W
	yBHhtOblKC9UXtDg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/mm: Fix memory encryption features advertisement
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240124140217.533748-1-kirill.shutemov@linux.intel.com>
References: <20240124140217.533748-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663197449.398.3923766970691246483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     4cab62c058f5a150d9960c112362e5c76d204d9d
Gitweb:        https://git.kernel.org/tip/4cab62c058f5a150d9960c112362e5c76d204d9d
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 24 Jan 2024 16:02:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 17:08:27 +01:00

x86/mm: Fix memory encryption features advertisement

When memory encryption is enabled, the kernel prints the encryption
flavor that the system supports.

The check assumes that everything is AMD SME/SEV if it doesn't have
the TDX CPU feature set.

Hyper-V vTOM sets cc_vendor to CC_VENDOR_INTEL when it runs as L2 guest
on top of TDX, but not X86_FEATURE_TDX_GUEST. Hyper-V only needs memory
encryption enabled for I/O without the rest of CoCo enabling.

To avoid confusion, check the cc_vendor directly.

  [ bp: Massage commit message. ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/r/20240124140217.533748-1-kirill.shutemov@linux.intel.com
---
 arch/x86/mm/mem_encrypt.c | 56 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c290c55..d035bce 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -42,38 +42,42 @@ bool force_dma_unencrypted(struct device *dev)
 
 static void print_mem_encrypt_feature_info(void)
 {
-	pr_info("Memory Encryption Features active:");
+	pr_info("Memory Encryption Features active: ");
 
-	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
-		pr_cont(" Intel TDX\n");
-		return;
-	}
-
-	pr_cont(" AMD");
+	switch (cc_vendor) {
+	case CC_VENDOR_INTEL:
+		pr_cont("Intel TDX\n");
+		break;
+	case CC_VENDOR_AMD:
+		pr_cont("AMD");
 
-	/* Secure Memory Encryption */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+		/* Secure Memory Encryption */
+		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		/*
 		 * SME is mutually exclusive with any of the SEV
 		 * features below.
-		 */
-		pr_cont(" SME\n");
-		return;
+		*/
+			pr_cont(" SME\n");
+			return;
+		}
+
+		/* Secure Encrypted Virtualization */
+		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+			pr_cont(" SEV");
+
+		/* Encrypted Register State */
+		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+			pr_cont(" SEV-ES");
+
+		/* Secure Nested Paging */
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+			pr_cont(" SEV-SNP");
+
+		pr_cont("\n");
+		break;
+	default:
+		pr_cont("Unknown\n");
 	}
-
-	/* Secure Encrypted Virtualization */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		pr_cont(" SEV");
-
-	/* Encrypted Register State */
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		pr_cont(" SEV-ES");
-
-	/* Secure Nested Paging */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		pr_cont(" SEV-SNP");
-
-	pr_cont("\n");
 }
 
 /* Architecture __weak replacement functions */

