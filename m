Return-Path: <linux-kernel+bounces-64380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45D853DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFC61C27C27
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E054E62A11;
	Tue, 13 Feb 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yu8ZxiHi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Rt+DhFD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2A62A0B;
	Tue, 13 Feb 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861144; cv=none; b=Pk7Ssv4hyvUyK80aoB7jqrpLRZw41A3eCdFFBTJsY3TjMW3dZDJcpKPl0g0ETusHtgHMGokcSX2JUrmHv7kNmkln5t30zeAHep1xTPuPaTBxrZvJPkDR8Wv3SOHhwVwSXKsFv4szSrK4nMm4mePFSAhrKKzhiibst888EFzz3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861144; c=relaxed/simple;
	bh=QhnkaXRfwZQbKoRkSM8XuuMnDlLAgVIr4QBQ1D+gJF4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pSLIWLMZ69MAY9+fkJtAncyCED3xY3nd/Ao0/I218P/ozC1YknbqHFQBlKd+8rfgRuU9iK50qaN9V01Rgi5VI5yKtSw7lB1zByU77CcpoFIRSpgfwSlOXEHGGOzKwUBd18uQPDAOxXBS9G9sTHfiSnMBhzUwcGJJnUHe6z2CDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yu8ZxiHi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Rt+DhFD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 21:52:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707861141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19iTsMkau0+gvmH5V9k/ovuDFOlwlqGTMwHgxTP+yrY=;
	b=Yu8ZxiHiCBEpHqqs4kkLkRpb+OordD6dzruPeTHSVi7gtsQQyVVYN0Y326zYKLgbpXtmgU
	ux3i2R4alMgsvAIPhEvocqby9SHGI3x1ELqV9bhRa3M0L1asOz0/THte+ZAw0oUXkUbxD+
	ks5nA8Edir+ZLQb/37AAFGvdK9vLygMDieiX+iF1XLzBlovIhHr79bq+IL32ZHnDAwSZDU
	pjIB88fnqlxSM3HYrMsZ3VjdQnRaaOlX+as3nkUAlZWwGybCtUumjUM42IEuWvasAK2Zrz
	XASXsm/eoY9dcC6f7mx467ID4hh2JdOiyChyyi+OumGSw34ithBYkXrjtsBxRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707861141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19iTsMkau0+gvmH5V9k/ovuDFOlwlqGTMwHgxTP+yrY=;
	b=2Rt+DhFDysl8cKT1N1O0EsmgQ5PRM0CuMVDqolX9HVMHPfEo5pKguECoeQVdxSKdxyG2BT
	DtvrPGKUdUjEPIAQ==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/insn-eval: Fix function param name in
 get_eff_addr_sib()
Cc: Randy Dunlap <rdunlap@infradead.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240211062452.16411-1-rdunlap@infradead.org>
References: <20240211062452.16411-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170786113958.398.11126392423077777213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     7d4002e8ced6d6344db0c8b0b32372b2c534085d
Gitweb:        https://git.kernel.org/tip/7d4002e8ced6d6344db0c8b0b32372b2c534085d
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Sat, 10 Feb 2024 22:24:52 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Feb 2024 22:41:25 +01:00

x86/insn-eval: Fix function param name in get_eff_addr_sib()

Change "regoff" to "base_offset" in 2 places in the kernel-doc comments to
prevent warnings:

  insn-eval.c:1152: warning: Function parameter or member 'base_offset' not described in 'get_eff_addr_sib'
  insn-eval.c:1152: warning: Excess function parameter 'regoff' description in 'get_eff_addr_sib'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240211062452.16411-1-rdunlap@infradead.org
---
 arch/x86/lib/insn-eval.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 558a605..98631c0 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1129,15 +1129,15 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
  * get_eff_addr_sib() - Obtain referenced effective address via SIB
  * @insn:	Instruction. Must be valid.
  * @regs:	Register values as seen when entering kernel mode
- * @regoff:	Obtained operand offset, in pt_regs, associated with segment
+ * @base_offset: Obtained operand offset, in pt_regs, associated with segment
  * @eff_addr:	Obtained effective address
  *
  * Obtain the effective address referenced by the SIB byte of @insn. After
  * identifying the registers involved in the indexed, register-indirect memory
  * reference, its value is obtained from the operands in @regs. The computed
  * address is stored @eff_addr. Also, the register operand that indicates the
- * associated segment is stored in @regoff, this parameter can later be used to
- * determine such segment.
+ * associated segment is stored in @base_offset; this parameter can later be
+ * used to determine such segment.
  *
  * Returns:
  *

