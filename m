Return-Path: <linux-kernel+bounces-39087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB483CAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49261C25D7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA83137C36;
	Thu, 25 Jan 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/gAX/Qq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="puj3jBB8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B01350C5;
	Thu, 25 Jan 2024 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206890; cv=none; b=iraHqo3K8IKYGW0Wc8jLizI157tS+Tdk4NLfigaOvDUHHG1RMPoG3Wd4LUIOe5ttYUmaqVIGl9/bEN+CK9mZD2L/00IimjP/JteBy5Vtyvo+csUXc8RBL8vt4//WV0Kvpf0w2ajHDbs/HWFguAtstVOqd5RLQ+Wgyjda6gRPxcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206890; c=relaxed/simple;
	bh=+woFgBFR7FjVUxENH8S2w2upZzVCogldGYepU0WKYmg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iD6fvhPqLJ/rVihqK5xU5Un4KKphWJGaEso0X3CB3XE45N3vVFuSoRdtG0hpFXNffeG8TZwLpghBt79dvwVv/EMrRodNkGwhjymb2X7yuHfI8YLtc9yedUkLlNHG+ZRv7mxWD5LTn7g2nbq7NwUCKR6HPugN2S3481e+rDAaJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/gAX/Qq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=puj3jBB8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206881;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5o12gXaKcz7ZubiINHsnlNZBKZnMDOcz7iC++kWJEqw=;
	b=Q/gAX/QqUpKexWFiETm5Aq3BKCpcgXa7IfgSzWerasNahQ57zcCcTBZnSNdyBfbuAgXzyN
	IV5ado5j9DCQ/FkH+bkwYX65VJIBkIfHOBHxjs61hnM/jTsOI8ed3dLpXLzutYoW4BXevK
	8oH6uyiTv5Eqr10FANl157DaAycEaIMmJA+V1S/ZmLXEg1c/5z4dBUjNwsiPae4QyZGfMK
	CwhmkyYW9nLotKZunqLsEE3JDAbPwbHv0V3yPmafCXpmwxIp22FKGYXcyCwcmzrE9CyGEH
	iPoGz7jhZOkURfK/fBNxDXIuANeAMYPkO1/pjnPGHYnOxNpJc5V6TZ8ix5ACUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206881;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5o12gXaKcz7ZubiINHsnlNZBKZnMDOcz7iC++kWJEqw=;
	b=puj3jBB8JR8wFzKRpy24Z5b9Z67UsiLyaDaa1zJLH5DWT0bIt/f5JN4pIQ08lJs+qxgxTd
	AHcKuNGe+b0WuVBw==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Let ret_from_fork_asm() jmp to
 asm_fred_exit_user when FRED is enabled
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-29-xin3.li@intel.com>
References: <20231205105030.8698-29-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620687978.398.12424515755549914146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     81e71a71266e2fbe42632f725147ed5b8f75b11e
Gitweb:        https://git.kernel.org/tip/81e71a71266e2fbe42632f725147ed5b8f75b11e
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:17 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:33 +01:00

x86/fred: Let ret_from_fork_asm() jmp to asm_fred_exit_user when FRED is enabled

Let ret_from_fork_asm() jmp to asm_fred_exit_user when FRED is enabled,
otherwise the existing IDT code is chosen.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
index 37a1dd5..5781c34 100644
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

