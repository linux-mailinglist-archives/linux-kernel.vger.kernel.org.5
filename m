Return-Path: <linux-kernel+bounces-112577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54D887BA0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 05:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75A81C20AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB089D53C;
	Sun, 24 Mar 2024 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z4nglIP2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJGJORxf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE0D299;
	Sun, 24 Mar 2024 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711253146; cv=none; b=ArF0kODmBsmf2fo+jDRM+ndpETtyAwPHuUxDLOeQdkW7wtpg2PxONd8NexEctUQLrS+dPG4gwKycl+/94TLRTo+5mjtwj3h9sZVbSnSRbjHkfH3EEYgYGZRosTH/GHU94iJqb75Y6UOqbc8BY+xO2Egejbun1jQDu2JWW8Ko/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711253146; c=relaxed/simple;
	bh=HBjvvPX5aBs3fVktIJGhqt95TrKjZ5BSk66+rDRGIcA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qXMrmw+oATVnvjYTlUTWps2KwtD2lNZcjIlqYYEPcJMWighvi4ZolAV3Au4gYQcyIQiYYKSl6u/WBNXCdAXsNFwNF1c5O0RDo4z1OJmHwdcTJhwNqJWUl8uy9Ph5+mMhpl0MfTizTBuDMfbt2ti7j9/50Na+QVhF5kqsSarmKfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z4nglIP2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJGJORxf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Mar 2024 04:05:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711253142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=365ADidzpDTEccXlyrWfGljiM5ZyCWLY02Ew1bkcEWE=;
	b=Z4nglIP2x3/85pgFKqVxgFivmxWTHq9TasM/bUwucuqiCHUSlmwFdsicpRIfUdXwcl6yOt
	Leu7YDfgx41XeqcJb/zclW1LOcotRToWjhfNQAprKrHR5dJAJ5ZmaIIQkX9kyMeq32TPbE
	Q7hxmnDXLq3Uc0nmG13SdChjEl0JL5fm1vnrRc0/nO3hYKPRZaLx/yGJNBp8db66EclPMr
	TixrsDjXtBQlO7NR7nkiZ5YTQ0RBe73a0iS6FdYkwnNpsl5M9y4WPBp5Xgp72i9mTcYSbw
	cwQz9F8ebeL6oqvKPERKDX+oyEmX2+xzRy367rwcRW9ite49K7Orl4ridIoO0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711253142;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=365ADidzpDTEccXlyrWfGljiM5ZyCWLY02Ew1bkcEWE=;
	b=iJGJORxfDrDDzy5woKIjmvweRy1BcAzoLjbte2JI+enisI023a4EHhtYdyKnz63IoIbAB+
	RrST+simt5H4W+AA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot/64: Apply encryption mask to 5-level
 pagetable update
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8f20345cda7dbba2cf748b286e1bc00816fe649a=2E17111?=
 =?utf-8?q?22067=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C8f20345cda7dbba2cf748b286e1bc00816fe649a=2E171112?=
 =?utf-8?q?2067=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171125314173.10875.16635973743967685352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4d0d7e7852752ea56375ac8645f0239e21ca2b50
Gitweb:        https://git.kernel.org/tip/4d0d7e7852752ea56375ac8645f0239e21ca2b50
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Fri, 22 Mar 2024 10:41:06 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 24 Mar 2024 05:00:35 +01:00

x86/boot/64: Apply encryption mask to 5-level pagetable update

When running with 5-level page tables, the kernel mapping PGD entry is
updated to point to the P4D table. The assignment uses _PAGE_TABLE_NOENC,
which, when SME is active (mem_encrypt=on), results in a page table
entry without the encryption mask set, causing the system to crash on
boot.

Change the assignment to use _PAGE_TABLE instead of _PAGE_TABLE_NOENC so
that the encryption mask is set for the PGD entry.

Fixes: 533568e06b15 ("x86/boot/64: Use RIP_REL_REF() to access early_top_pgt[]")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/8f20345cda7dbba2cf748b286e1bc00816fe649a.1711122067.git.thomas.lendacky@amd.com
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 212e8e0..7d2eb03 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -175,7 +175,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 		p4d = (p4dval_t *)&RIP_REL_REF(level4_kernel_pgt);
 		p4d[MAX_PTRS_PER_P4D - 1] += load_delta;
 
-		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE_NOENC;
+		pgd[pgd_index(__START_KERNEL_map)] = (pgdval_t)p4d | _PAGE_TABLE;
 	}
 
 	RIP_REL_REF(level3_kernel_pgt)[PTRS_PER_PUD - 2].pud += load_delta;

