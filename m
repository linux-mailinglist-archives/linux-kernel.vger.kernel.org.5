Return-Path: <linux-kernel+bounces-13401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6615782049C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1378F281E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869B679CC;
	Sat, 30 Dec 2023 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ECxP8U6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBHPInxp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0441A7487;
	Sat, 30 Dec 2023 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 30 Dec 2023 11:31:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703935883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YekaI+XSXzVudCa+DmlL/evq5KrMF9TXWnC3KY0bLQ=;
	b=3ECxP8U6giePTZVmturwNcYulTP+uV0UjbT0pGvUNxHoaYaCLZP1/mdIp5SpJoNm6A73rc
	eLNrZbwLRhX0h0bTzH0RPNHQNqL7G+nSiV46RynPrXxhn8Z2F8EjLfPKEO2djjaaNDgoCs
	GAGwZdZtLBf2tLPW/SzU4oPTIp52dmtLML62Qt6LzVzU0VJ56TRFLA2OPvKs4LjPDkEKA2
	9pTHD579KvPQKY/3BBR3OIxonxKoGYmad7mVQeELOkKfbubVrJJPbr/iYp6wAvAkaNCXpG
	obLg+sql0CSY8+D3fuBVBiK+agRDWwDFEsz3xCAKfFZh26HV/N2ShCLi2MHwxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703935883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YekaI+XSXzVudCa+DmlL/evq5KrMF9TXWnC3KY0bLQ=;
	b=aBHPInxpfgK/+hOHdOxeLwNb+dNyKN6/xkja7EtxbnXaqwrRzqxlfRe4ymHzol/jYbXuRm
	tgt3OJyEIJLc1QCQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/alternative: Correct feature bit debug output
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231206110636.GBZXBVvCWj2IDjVk4c@fat_crate.local>
References: <20231206110636.GBZXBVvCWj2IDjVk4c@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170393588213.398.4263924144760280684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     7991ed43587d1106315208cc289c851d6915d4a3
Gitweb:        https://git.kernel.org/tip/7991ed43587d1106315208cc289c851d6915d4a3
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 30 Dec 2023 12:20:04 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 30 Dec 2023 12:25:55 +01:00

x86/alternative: Correct feature bit debug output

In

  https://lore.kernel.org/r/20231206110636.GBZXBVvCWj2IDjVk4c@fat_crate.local

I wanted to adjust the alternative patching debug output to the new
changes introduced by

  da0fe6e68e10 ("x86/alternative: Add indirect call patching")

but removed the '*' which denotes the ->x86_capability word. The correct
output should be, for example:

  [    0.230071] SMP alternatives: feat: 11*32+15, old: (entry_SYSCALL_64_after_hwframe+0x5a/0x77 (ffffffff81c000c2) len: 16), repl: (ffffffff89ae896a, len: 5) flags: 0x0

while the incorrect one says "... 1132+15" currently.

Add back the '*'.

Fixes: da0fe6e68e10 ("x86/alternative: Add indirect call patching")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231206110636.GBZXBVvCWj2IDjVk4c@fat_crate.local
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f26983a..f7ea108 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -498,7 +498,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			continue;
 		}
 
-		DPRINTK(ALT, "feat: %d32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
+		DPRINTK(ALT, "feat: %d*32+%d, old: (%pS (%px) len: %d), repl: (%px, len: %d) flags: 0x%x",
 			a->cpuid >> 5,
 			a->cpuid & 0x1f,
 			instr, instr, a->instrlen,

