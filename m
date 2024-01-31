Return-Path: <linux-kernel+bounces-47123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D459784499C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE7D1F22EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957E3A1D0;
	Wed, 31 Jan 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vkBlf001";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f1FRmEVt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A739FC0;
	Wed, 31 Jan 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735687; cv=none; b=u0zyEvSlFZchawL2dYTkfAxTpJpbX14w+Hjn5c4iknP6MZE/HjjiCceoaEV/NFd1lDusCXnxymTkYl3NpuOEeZ5xaHGsIwA+IbHrFdZL4ATgOU9Y1SOor0Oa/IRo93L81mDdOra/Q9kUY6GEzSoH0m/M69y/CeUm4DF4LhYB1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735687; c=relaxed/simple;
	bh=3z4c8NO4/2R13Yelyydbzr9ZVNwLoneQ4Xa1c16NM3U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=McqJlxcFL6xiLcX0AElcpLxXaczDnlTX3nY8HYdVMsPSPfw4/gqaSCoKHht6O4l+H4W9+d9NhHcqkUqcrmSwbiCBNE7PSfFKfkZXsmY0lHPfrpQE4PrxiaBJQAeeL0k5MGMvIKlgfQXvZH6laBikgA3d0aaq4VnGiUClzrURP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vkBlf001; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f1FRmEVt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6qCoPTML8h57sp9oE2AUKoqeoqQdIRMSvCJ/ZD1qmw=;
	b=vkBlf0012Qi0FmwSzpEy1H+VSBXnLrfcppB68n9ADdkK1oOThVhDCIOpi0gUYY5uME7AIG
	J3pPfhRudXFslbD4riSmqOAZ8YfzK9e1FsQCnMR9HtyNAXCB4gbWmd7p09SYRJ7o9sW9BV
	HbOPPTHL68Ja2MoFwPYuTmS+PEO1yoD80PrcTZFfeZEb5Pc6sh/tbM4dTBJyrjUm2S15kM
	K85YFJ3JZ9dNaJ8qARWAav0THOFJZ9nxqhi8aJH0BzwWR4sThIj3kxJb6mlYv0Y79wMa6N
	VdZfJvqby34jN5zgkyJ++JI4T1QJ1Y9Gkm7ZY+urX071J1ImvH903PYLxlKOHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6qCoPTML8h57sp9oE2AUKoqeoqQdIRMSvCJ/ZD1qmw=;
	b=f1FRmEVtgWgdmUZwhyiGYkufPFPVY8K+Jayh6CcWRoNppBJlG3PoXpgbT8TMaLrWSDDs9/
	EDhVYgEHpFVW50CQ==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Let ret_from_fork_asm() jmp to
 asm_fred_exit_user when FRED is enabled
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-29-xin3.li@intel.com>
References: <20231205105030.8698-29-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568329.398.1021316577676211303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     51ef2a4da7ec347e3315af69a426ac36fab98a6c
Gitweb:        https://git.kernel.org/tip/51ef2a4da7ec347e3315af69a426ac36fab98a6c
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:17 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:02:59 +01:00

x86/fred: Let ret_from_fork_asm() jmp to asm_fred_exit_user when FRED is enabled

Let ret_from_fork_asm() jmp to asm_fred_exit_user when FRED is enabled,
otherwise the existing IDT code is chosen.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-29-xin3.li@intel.com
---
 arch/x86/entry/entry_64.S      | 6 ++++++
 arch/x86/entry/entry_64_fred.S | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 29ce68f..7c4b726 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -247,7 +247,13 @@ SYM_CODE_START(ret_from_fork_asm)
 	 * and unwind should work normally.
 	 */
 	UNWIND_HINT_REGS
+
+#ifdef CONFIG_X86_FRED
+	ALTERNATIVE "jmp swapgs_restore_regs_and_return_to_usermode", \
+		    "jmp asm_fred_exit_user", X86_FEATURE_FRED
+#else
 	jmp	swapgs_restore_regs_and_return_to_usermode
+#endif
 SYM_CODE_END(ret_from_fork_asm)
 .popsection
 
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index c1ddaf6..2271a1c 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -32,6 +32,7 @@
 SYM_CODE_START_NOALIGN(asm_fred_entrypoint_user)
 	FRED_ENTER
 	call	fred_entry_from_user
+SYM_INNER_LABEL(asm_fred_exit_user, SYM_L_GLOBAL)
 	FRED_EXIT
 	ERETU
 SYM_CODE_END(asm_fred_entrypoint_user)

