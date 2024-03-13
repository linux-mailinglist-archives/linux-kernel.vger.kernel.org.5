Return-Path: <linux-kernel+bounces-101266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ABE87A4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B06282F38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FCD2374D;
	Wed, 13 Mar 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ed6rwpt2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2yv2z3/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21012261A;
	Wed, 13 Mar 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710321430; cv=none; b=NLqXghBQd3kN0VdX+fCzz7VCF7RKt4Kbverv3UYcUNtkCluUYlRfVlSKdwPUPe0LEAkK91gfn08ER4c/sie6oVXpja1mEjLygezImZFalGO6LoPF9lsbR63zdhlR+wMbAoavm46O+HARUCsI+twvbzX1I6zFxygclDELw5f09bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710321430; c=relaxed/simple;
	bh=R+56XbCW7VCmvc6HpQtkGngJnu7ekY4FJCSyrZVjUWk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FzADFu4kgdN7I/9HeTRt6J662k9trs7EfjlStImF9h7c0MdQHPUvUkOy/4tPilLGoO/VU3N6HxKDy75qfn7KQGG6BIis6SnZFk5AEb+QZ9vVAThGFoJTPwpxJB0yIllQef1a4Y8z1NnsDrn6RPqdZa6jQAXy9bzvLaTrNSaCLko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ed6rwpt2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2yv2z3/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Mar 2024 09:16:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710321420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rRlQGyhZFVjQ4qM9e0Ekd5/R5Rqi8++m4vJCSr26Mj8=;
	b=Ed6rwpt2/oWdT7rO0xZi9lx7EkPuxNHLMa4QacKnOgL3C+5CJ5GygbdMlF57/7EOe6V+TE
	5uVFEaeBnEgr/rQ8KooF7P1xHbyvIBJWYfh5x0jwkDXeuv6cb41y6Gmz7OXlELKH1/06Fl
	Ri+PMgbX3+hQ0w1RhGKEEAXxPY8P/8chkQ5OcJJwopUVHh2z0IpUOdlItOoCyOPraKDigX
	1FddWU8arqYM+21AMH5LUvoK2MmVivZ63O72QWQ2aRMZvZBjNtXazm6aqW2fTNqIAy3cH3
	BCfnYUW9X3fZHbq7D6tthf90GOAthtxyhpzpvqkEp9IV99xEtOWFKQ4KBo9Ivg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710321420;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=rRlQGyhZFVjQ4qM9e0Ekd5/R5Rqi8++m4vJCSr26Mj8=;
	b=H2yv2z3/7DlWhihI2z3Sdc6FH9ShHgabVd4m5sPaYdcmJVB02CXNkBF8idJr8HhaM7dL8s
	rLHJ8JUZuYsPRuBw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] Revert "x86/bugs: Use fixed addressing for VERW operand"
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171032141964.398.11885459177041650089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     bfa5fa246c0724c2cc1bd0dfe57531aaa7f520c1
Gitweb:        https://git.kernel.org/tip/bfa5fa246c0724c2cc1bd0dfe57531aaa7f520c1
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 12 Mar 2024 07:27:57 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Mar 2024 10:08:09 +01:00

Revert "x86/bugs: Use fixed addressing for VERW operand"

This was reverts commit 8009479ee919b9a91674f48050ccbff64eafedaa.

It was originally in x86/urgent, but was deemed wrong so got zapped.
But in the meantime, x86/urgent had been merged into x86/apic to
resolve a conflict.  I didn't notice the merge so didn't zap it
from x86/apic and it managed to make it up with the x86/apic
material.

The reverted commit is known to cause some KASAN problems.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index d0b8bb7..fc3a8a3 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -314,7 +314,7 @@
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
 .macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF
 .endm
 
 #else /* __ASSEMBLY__ */

