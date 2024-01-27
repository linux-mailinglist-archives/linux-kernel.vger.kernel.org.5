Return-Path: <linux-kernel+bounces-41174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F583ECE6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1BF1C21886
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE6200C7;
	Sat, 27 Jan 2024 11:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lUedujCn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Fif1aUK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60821E869;
	Sat, 27 Jan 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706354776; cv=none; b=R/8+/oNglstSIYbWD1W47R61aNIFdUjQ1bPJG5EyJgHFlVPBE4HNnAvrLtUHMXOfL5UhgcyXIaas3oqH5JTTHbEC/544NcO4GC+Re373cNuJE0Gd+2BFxzhpDiKa82oyJOVcxGU3nIS5i82WA9ga+szlwJ1Qp8X0xZtF2v6So68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706354776; c=relaxed/simple;
	bh=y77fw+oXQsa4/OSok+BNXAWMyCSdiussIoanHFVbKno=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f2hBTugKduUlsHjwsaJvspaYh6vggTgkrOVJB2ZyeXtY/+YdJpjK1sx5TUTYfwzMAzrYdGwnl1QK0eQIzMchphI6TndojND2PRc9KTWRSQ/4IDLQYsT4HayHmgkTW3YlWdp/A31SSUuoFWWfDmMx4XNmu9Jy/KMRnD3yQBZCFUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lUedujCn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Fif1aUK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 27 Jan 2024 11:26:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706354767;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRSKkfMgDtfSt+TVqiW5vKMlAWylA5g1gZq4YeCkcJA=;
	b=lUedujCnDV3Ah9EvLhvpDKi9bWPZ6MVKsYQZ7ypSOuPVaKlz5SZkgtU9wh8NVc32vX2zSB
	jtlRa1qVt3KOCFn5f4PF9F8jDfCNr6Ol4MA64nTmA3kM0Syb/GTZuNqxAvc0ofD8xt3AMW
	XVxHBjh82lv6x0fyIeM/kCKKeVVsSLBE/0R3zva4xUwx3RMNt8EOpyZX4ZBRwZye0OmshW
	+mF3nRVvsYzWwRujTR3uDfUbnTZbWrgy7iwTFo1y5BFyWc8RQClbKE4wSjh20v+m2y1qdx
	zWR4885n8ZCzpkxjG/4hKdNOHvPYivnJs+V0jfxTcdPycMed3pQEXg2V0oMsOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706354767;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRSKkfMgDtfSt+TVqiW5vKMlAWylA5g1gZq4YeCkcJA=;
	b=/Fif1aUK0iiU39F31vBwyAfh36pEuJanCOh+wbXXBe1xDFR7HzBR3ANyUniWsJWaYjX6JQ
	ej6H6XuuLOuo8wCA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sme: Fix memory encryption setting if enabled by
 default and not overridden
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240126163918.2908990-2-ardb+git@google.com>
References: <20240126163918.2908990-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170635476620.398.13087052898452065480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     aa8eff72842021f52600392b245fb82d113afa8a
Gitweb:        https://git.kernel.org/tip/aa8eff72842021f52600392b245fb82d113afa8a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 26 Jan 2024 17:39:19 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 27 Jan 2024 12:17:26 +01:00

x86/sme: Fix memory encryption setting if enabled by default and not overridden

Commit

  cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in sme_enable()")

'fixed' an issue in sme_enable() detected by static analysis, and broke
the common case in the process.

cmdline_find_option() will return < 0 on an error, or when the command
line argument does not appear at all. In this particular case, the
latter is not an error condition, and so the early exit is wrong.

Instead, without mem_encrypt= on the command line, the compile time
default should be honoured, which could be to enable memory encryption,
and this is currently broken.

Fix it by setting sme_me_mask to a preliminary value based on the
compile time default, and only omitting the command line argument test
when cmdline_find_option() returns an error.

  [ bp: Drop active_by_default while at it. ]

Fixes: cbebd68f59f0 ("x86/mm: Fix use of uninitialized buffer in sme_enable()")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240126163918.2908990-2-ardb+git@google.com
---
 arch/x86/mm/mem_encrypt_identity.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index d73aeb1..7f72472 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -507,7 +507,6 @@ void __init sme_enable(struct boot_params *bp)
 	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
-	bool active_by_default;
 	unsigned long me_mask;
 	char buffer[16];
 	bool snp;
@@ -593,22 +592,19 @@ void __init sme_enable(struct boot_params *bp)
 	     : "p" (sme_cmdline_off));
 
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT))
-		active_by_default = true;
-	else
-		active_by_default = false;
+		sme_me_mask = me_mask;
 
 	cmdline_ptr = (const char *)((u64)bp->hdr.cmd_line_ptr |
 				     ((u64)bp->ext_cmd_line_ptr << 32));
 
 	if (cmdline_find_option(cmdline_ptr, cmdline_arg, buffer, sizeof(buffer)) < 0)
-		return;
+		goto out;
 
 	if (!strncmp(buffer, cmdline_on, sizeof(buffer)))
 		sme_me_mask = me_mask;
 	else if (!strncmp(buffer, cmdline_off, sizeof(buffer)))
 		sme_me_mask = 0;
-	else
-		sme_me_mask = active_by_default ? me_mask : 0;
+
 out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;

