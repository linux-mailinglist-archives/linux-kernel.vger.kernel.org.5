Return-Path: <linux-kernel+bounces-37705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F983B425
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEF61C2425E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5512213541C;
	Wed, 24 Jan 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cptojg5V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iaTBekRT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C9131E26;
	Wed, 24 Jan 2024 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132278; cv=none; b=USt9KO5FzNF8vwLb+0bATSPQ+CQiZVpSxE78SwLvhEA/LUfZVXLpdhSK44UKD+7O7XLsVD0e8NEKz8j6eChqi4IbeVZQzebHwZ9sTMEWkljrsHVrDeShKdfTzmH/i2MqMawqmVIsi+ENua2ZwfGWvztizE3PNbIRgW6gKkLAhZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132278; c=relaxed/simple;
	bh=v5JsH8tHWjq5Q0A+2MP2G+hmruLvrSRUbQVVzJNqX3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nYA91oZ/WuMugDOducDoD+3U9O9e6b02DGP/xaIly1ynHxvUG9BEqdj8L4b80KPqB+2Gae7i2chkBfslmha0rqCQr56nk2i/J8s5pAa/9OGDyTaiQ+xC4GeLQ7J9fH3Nuo3OUc54QhSMNliEzwMR2XA8KUz5CfmSV0Z47ifapIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cptojg5V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iaTBekRT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 21:37:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706132274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8xWwnsrfWs37M4gapdLyCA1xFMKKptPVYI5zbGOyaM=;
	b=cptojg5VytT6aBmBMog0FoqeJsr9+gIpQwmiF8CyL7ogX50MEbblOmntYj30wt9KLkW0h8
	SGUnrk0P4pUJPRbbPqolV2caS9LxQlnc704eV/+L0UB38l7z19HLbgd8n4F76Xnei2a+iW
	6HzZRRe9l9uyo7ir6o93OHtaNIQwaysGaSCdS+32vgOYhli3tcEX27oVf0NquJvOISNcAa
	V3t/HFkEN1nfTc5yMTJl9hnBLiIGe6CjWVoJshYHqpFjJMqpbSzHtyZUztshuwi09aF4eC
	ku0sQSsjq2LCgvfekc6zJQkoFoJikTe+Jg54byAIG3u1e2NIJcMsxb4eFkq0Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706132274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8xWwnsrfWs37M4gapdLyCA1xFMKKptPVYI5zbGOyaM=;
	b=iaTBekRTv8MEJQb6V8NZNd/gDbMA1IaUL8n24HO82817Ww2E7gmOKbOWgGtgroFuW0i2nz
	zWzPm1wgfpEil1CA==
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
Message-ID: <170613227352.398.393464651879909773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0410516aaef4bf08030845547fb94f4ff989fac0
Gitweb:        https://git.kernel.org/tip/0410516aaef4bf08030845547fb94f4ff989fac0
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 24 Jan 2024 16:02:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 24 Jan 2024 22:27:59 +01:00

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

