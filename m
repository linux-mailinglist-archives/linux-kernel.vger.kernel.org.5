Return-Path: <linux-kernel+bounces-131156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E648983D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81BC287C02
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78DF73539;
	Thu,  4 Apr 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ji816HnB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DXGTWl+h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C2B74C0D;
	Thu,  4 Apr 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221883; cv=none; b=rkEeraE8RNaLY6yg82m+Ql7tR0Nlmb09J2tPgZCfT78t8jQ3Bww8dYMJg0z+AksFaaTZVKnkt+XFnNl2j8oef876cq3QzRwsKRN0XnFEHKf53KrOPsrA5XmZ1ROXdAxsgYDZpYkLkfx33R6dZqdF37Vv1BG1NUtbz3+Iihk6gK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221883; c=relaxed/simple;
	bh=VuKlTEPPxrmk/3PqQSBJXJvmQUdg7C16ZaXuQodL/uQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qMjLyU2oF7PteKhAkpdvzcRvFM/0xx5kYcgdW1qyZ9IRUoPtr+dq+eNLfqgotBYxaQ79SlndMP0cQL2FyAAZ+mDef7JmN8aaviKsb8dqwoyJIlHrDcNB2ZzTRT63Vw5bqJjwIivjVIpxbl9MKjl/m33LYqkLUYpLhk925DSnLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ji816HnB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DXGTWl+h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 09:11:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712221879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDEV9RKVgOCUBL3dcQDVvfxsJhB+0+qYJnz2eNITpS8=;
	b=ji816HnBD3BXYz+Y5kCSG0b86x3WDdFtePCBf+ri6bKOonUTpj6UEIAgmO3KJBc7CnEDVj
	1prFkz8poUVFK8788z2RTVs0J+QDcO8oJO9KOWAqgmdT9d9lE5k0oQN6/hNnbvWJf6NLHL
	Czw+jQ23ECw4fZou2If3yeZMe6fJGnzT6nVD3CmjRta2/vpodDfptZB9e0Iq7Lq9zhrGzB
	C4WosXJNkwRD5186TBOsrHD3WplrlyNjeRZdJDhW8lXq0WKKTYLDL+PgcaXKxHWs4HTzQW
	+WwDaca0jHWYTuPDIOlvuQUZGL6oZFwOpn7kdGSx3sqAm3w4zcQUoezut9WT2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712221879;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDEV9RKVgOCUBL3dcQDVvfxsJhB+0+qYJnz2eNITpS8=;
	b=DXGTWl+hC6rL+gUa06fsKTeSArZBaqt9IctNbedex+NjITyCWwFqM+3grlrYkem18G+xea
	dRaZ/ZqTDoG8VrBQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Remove a superfluous
 newline in _static_cpu_has()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Srikanth Aithal <sraithal@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240327154317.29909-2-bp@alien8.de>
References: <20240327154317.29909-2-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171222187812.10875.2774835074056250819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     e51d20f01f9ef5d19f1a37137696792e605b31e8
Gitweb:        https://git.kernel.org/tip/e51d20f01f9ef5d19f1a37137696792e605b31e8
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 27 Mar 2024 16:43:13 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Apr 2024 20:02:20 +02:00

x86/alternatives: Remove a superfluous newline in _static_cpu_has()

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Srikanth Aithal <sraithal@amd.com>
Link: https://lore.kernel.org/r/20240327154317.29909-2-bp@alien8.de
---
 arch/x86/include/asm/cpufeature.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 42157dd..7103ba1 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -170,8 +170,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  */
 static __always_inline bool _static_cpu_has(u16 bit)
 {
-	asm goto(
-		ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
+	asm goto(ALTERNATIVE_TERNARY("jmp 6f", %P[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
 		" testb %[bitnum]," _ASM_RIP(%P[cap_byte]) "\n"

