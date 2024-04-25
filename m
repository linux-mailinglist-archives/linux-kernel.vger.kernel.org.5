Return-Path: <linux-kernel+bounces-158771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE7F8B24B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E5C31F21891
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FE814AD3A;
	Thu, 25 Apr 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xOUKbG9P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auyRLV2z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A343BBE6;
	Thu, 25 Apr 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057683; cv=none; b=jbcPvtKdirCoL88IeDaUCA6yzrujEj/AA09PNWm09sqZsT3ZbXkzv3ZyAgpx13qBX1cI2OPBrTLKDTy17TB+qHUGv5+MiU8TQzabBIWkXAnmrgyoF9vrJBmYiYzG+c7KqUJgwkzTMSDNUtspC3R16XxJeQF4PMQfg1CoRq/inE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057683; c=relaxed/simple;
	bh=m74eck4gMpgLFFE08BXb5e06v+Za3er5MGng6KoZ4tA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PvPXOCElrhIF+Pui7YkxpEYcxWdH2Y5Khd1PxDSX9rDVO3CE4xhbWnG3pAmLe9s+/GcVL3P0IcF7lp1/gO8IISg1TjWOujkq/nia+h+3T8yuwLSLdnAIvmic7BwENcP2NwP5RblTTbY+6roBOHgeEux1otKZY+EmVA7zeMRhZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xOUKbG9P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auyRLV2z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Apr 2024 15:07:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714057680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hagq2h2jnnv75srLIprAocYGXcrvhuL6tYuMjuGpuwg=;
	b=xOUKbG9PfkuhbGh+cVJ4omuyahJKxX98L27N2ZeQnsar6g1L5ZohNvMKDcb7PEEuQbJQIJ
	kFYSB22ufru9VYpbs4BoNEhzVNuUhzW4katdpbxXB8iQTSJzuaXv7U8GqXKrA5BNtqtvTl
	reNbTbKAibuST/hW08be/yOKmSazmdAGqj6LN88CFaQjCiwi0bef39en8jg7s3p0WnEWDF
	RlEbkhVH0e4okFoT+shm/ex3yomNmXx95up/VxVMibYfElmK+0gkckOn+9ITXtoadWTufX
	czFRuy8Hfsvbpvqy2IV66PBdsfZnrMFZhRaHH+LwZaAc1PWOfZHjHkaozMn7tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714057680;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hagq2h2jnnv75srLIprAocYGXcrvhuL6tYuMjuGpuwg=;
	b=auyRLV2zIO1FsLQh1KjcAeH8Yww109LBnqswt29IkpoX7Ia7XrcokgoQph5vq4xJwP3rXK
	8Of67MqGQ+jH+qBg==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Make the VMPL0 checking more straight forward
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ced01ddf04bfb475596b24b634fd26cffaa85173a=2E17139?=
 =?utf-8?q?74291=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Ced01ddf04bfb475596b24b634fd26cffaa85173a=2E171397?=
 =?utf-8?q?4291=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171405767963.10875.6117170160698989836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e2f4c8c319abd1afbedb7a31877cb569265db1b4
Gitweb:        https://git.kernel.org/tip/e2f4c8c319abd1afbedb7a31877cb569265db1b4
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 24 Apr 2024 10:57:59 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 25 Apr 2024 16:14:25 +02:00

x86/sev: Make the VMPL0 checking more straight forward

Currently, the enforce_vmpl0() function uses a set argument when modifying
the VMPL1 permissions used to test for VMPL0. If the guest is not running
at VMPL0, the guest self-terminates.

The function is just a wrapper for a fixed RMPADJUST function. Eliminate
the function and perform the RMPADJUST directly.

No functional change.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/ed01ddf04bfb475596b24b634fd26cffaa85173a.1713974291.git.thomas.lendacky@amd.com
---
 arch/x86/boot/compressed/sev.c | 35 +++++++++++++--------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5ad0ff4..0457a9d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -335,26 +335,6 @@ finish:
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
-static void enforce_vmpl0(void)
-{
-	u64 attrs;
-	int err;
-
-	/*
-	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
-	 * higher) privilege level. Here, clear the VMPL1 permission mask of the
-	 * GHCB page. If the guest is not running at VMPL0, this will fail.
-	 *
-	 * If the guest is running at VMPL0, it will succeed. Even if that operation
-	 * modifies permission bits, it is still ok to do so currently because Linux
-	 * SNP guests are supported only on VMPL0 so VMPL1 or higher permission masks
-	 * changing is a don't-care.
-	 */
-	attrs = 1;
-	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
-}
-
 /*
  * SNP_FEATURES_IMPL_REQ is the mask of SNP features that will need
  * guest side implementation for proper functioning of the guest. If any
@@ -588,7 +568,20 @@ void sev_enable(struct boot_params *bp)
 		if (!(get_hv_features() & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
-		enforce_vmpl0();
+		/*
+		 * Enforce running at VMPL0.
+		 *
+		 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
+		 * higher) privilege level. Here, clear the VMPL1 permission mask of the
+		 * GHCB page. If the guest is not running at VMPL0, this will fail.
+		 *
+		 * If the guest is running at VMPL0, it will succeed. Even if that operation
+		 * modifies permission bits, it is still ok to do so currently because Linux
+		 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
+		 * permission mask changes are a don't-care.
+		 */
+		if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, 1))
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))

