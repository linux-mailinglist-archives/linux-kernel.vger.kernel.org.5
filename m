Return-Path: <linux-kernel+bounces-44927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C917842923
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A5F1C24D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A585112BF1C;
	Tue, 30 Jan 2024 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JUHNT3b3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ketA+gUY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B712BE8B;
	Tue, 30 Jan 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706631966; cv=none; b=n5USActY9yWKriheyPohogxhKqS91TbiWgrmaqy5n0psh3bb5ggXPIEZM+HJqk00fO7DBQ9yRYqx/xcCOOgFGdG5tzMPRrnyCn7P2GxFg9TCwa3CIE9cy/yqYiZ3t09d8zJL5EcWepgauCbWeTii4JWeNC9eIFO0dGspy+q/9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706631966; c=relaxed/simple;
	bh=ihkwCq59sJnEsPmoyk2mpZOIl+biv3Fwjn5hVIl6mac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i8eRL84VUDlWwAB9ZB/0ePdWa+gmSoG/PdJPPmdeGbqzutsXDMhAkmSdoYsJx7Zpp8m4YqjxFYa82cHl/TEmgd/SiKYQg05Vu6H4XkRH8TSyGQhNpV8ILcASKEynzsbChRMxOd+TZn1O6crW5E8refmIhktqTq+gWTadDqVuMMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JUHNT3b3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ketA+gUY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jan 2024 16:26:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706631963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvvUEytduyOghToZNoDDIgaazJZUXwN2DBVuyjrhpqA=;
	b=JUHNT3b31cyeSJ0pr80heZk2BWlL18pNP4OwXITAMLUUPOt3+yyks3xTjH90eg6o+/quZ8
	o9HCEtWjQQK5ZEIGhilhJLSoVYc9abF0f5v/XQGGFxe//mpca30tT5St7ydhN95BNhBbZm
	oazk7BXM+BjqcsmorH0Ej8akDgnFUhekzdLc1PTQM/JqXpxzogcdJ+XkhvVJSzyTy0U8Q6
	pMffpykovLIk7uwIl0lctVy95lfmari5ByiBN/oZXL1se8/G5gGfdlDUNF3+fJL3m6L+Py
	UKH1/yO11YLH82UiTJ4koj79fd/R408tI7Y6ro+sB2Wx3Freb3QieUKin+gUTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706631963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvvUEytduyOghToZNoDDIgaazJZUXwN2DBVuyjrhpqA=;
	b=ketA+gUY2NSqhWWj4VBGAYXtt5bVEBMFkC8axaPZuVlmVhBPL8U21bWmLKEXrsRTek6ypN
	r12EOAat0a0nHYAA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] crypto: ccp: Handle non-volatile INIT_EX data when SNP
 is enabled
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240126041126.1927228-18-michael.roth@amd.com>
References: <20240126041126.1927228-18-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170663196225.398.6563869035377276598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     7364a6fbca45f826952ea932699fb2171d06ee73
Gitweb:        https://git.kernel.org/tip/7364a6fbca45f826952ea932699fb2171d06ee73
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Thu, 25 Jan 2024 22:11:17 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jan 2024 20:34:18 +01:00

crypto: ccp: Handle non-volatile INIT_EX data when SNP is enabled

For SEV/SEV-ES, a buffer can be used to access non-volatile data so it
can be initialized from a file specified by the init_ex_path CCP module
parameter instead of relying on the SPI bus for NV storage, and
afterward the buffer can be read from to sync new data back to the file.

When SNP is enabled, the pages comprising this buffer need to be set to
firmware-owned in the RMP table before they can be accessed by firmware
for subsequent updates to the initial contents.

Implement that handling here.

  [ bp: Carve out allocation into a helper. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Co-developed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240126041126.1927228-18-michael.roth@amd.com
---
 drivers/crypto/ccp/sev-dev.c | 67 +++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 70aabd1..5ec5636 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -775,6 +775,48 @@ static void __sev_platform_init_handle_tmr(struct sev_device *sev)
 	}
 }
 
+/*
+ * If an init_ex_path is provided allocate a buffer for the file and
+ * read in the contents. Additionally, if SNP is initialized, convert
+ * the buffer pages to firmware pages.
+ */
+static int __sev_platform_init_handle_init_ex_path(struct sev_device *sev)
+{
+	struct page *page;
+	int rc;
+
+	if (!init_ex_path)
+		return 0;
+
+	if (sev_init_ex_buffer)
+		return 0;
+
+	page = alloc_pages(GFP_KERNEL, get_order(NV_LENGTH));
+	if (!page) {
+		dev_err(sev->dev, "SEV: INIT_EX NV memory allocation failed\n");
+		return -ENOMEM;
+	}
+
+	sev_init_ex_buffer = page_address(page);
+
+	rc = sev_read_init_ex_file();
+	if (rc)
+		return rc;
+
+	/* If SEV-SNP is initialized, transition to firmware page. */
+	if (sev->snp_initialized) {
+		unsigned long npages;
+
+		npages = 1UL << get_order(NV_LENGTH);
+		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, false)) {
+			dev_err(sev->dev, "SEV: INIT_EX NV memory page state change failed.\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 static int __sev_platform_init_locked(int *error)
 {
 	int rc, psp_ret = SEV_RET_NO_FW_CALL;
@@ -790,11 +832,9 @@ static int __sev_platform_init_locked(int *error)
 
 	__sev_platform_init_handle_tmr(sev);
 
-	if (sev_init_ex_buffer) {
-		rc = sev_read_init_ex_file();
-		if (rc)
-			return rc;
-	}
+	rc = __sev_platform_init_handle_init_ex_path(sev);
+	if (rc)
+		return rc;
 
 	rc = __sev_do_init_locked(&psp_ret);
 	if (rc && psp_ret == SEV_RET_SECURE_DATA_INVALID) {
@@ -1693,8 +1733,9 @@ static void sev_firmware_shutdown(struct sev_device *sev)
 	}
 
 	if (sev_init_ex_buffer) {
-		free_pages((unsigned long)sev_init_ex_buffer,
-			   get_order(NV_LENGTH));
+		__snp_free_firmware_pages(virt_to_page(sev_init_ex_buffer),
+					  get_order(NV_LENGTH),
+					  true);
 		sev_init_ex_buffer = NULL;
 	}
 
@@ -1748,18 +1789,6 @@ void sev_pci_init(void)
 	if (sev_update_firmware(sev->dev) == 0)
 		sev_get_api_version();
 
-	/* If an init_ex_path is provided rely on INIT_EX for PSP initialization
-	 * instead of INIT.
-	 */
-	if (init_ex_path) {
-		sev_init_ex_buffer = sev_fw_alloc(NV_LENGTH);
-		if (!sev_init_ex_buffer) {
-			dev_err(sev->dev,
-				"SEV: INIT_EX NV memory allocation failed\n");
-			goto err;
-		}
-	}
-
 	/* Initialize the platform */
 	args.probe = true;
 	rc = sev_platform_init(&args);

