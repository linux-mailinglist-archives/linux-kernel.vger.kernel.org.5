Return-Path: <linux-kernel+bounces-45897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FEA8437A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E829B26732
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2C14F1F1;
	Wed, 31 Jan 2024 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GAekjjuz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gag5/Fxf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4557895;
	Wed, 31 Jan 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685675; cv=none; b=QJONrxDM/2Xfsu7tpOoA9XHvBUZ4NoD8RIOuOlLrYjbW88zT296v4HD4n5Ng9cNCnfeqTd7Yp/nnDtjZQ5Tyf+eRf64UIrNN/+HXIsVUcTaIqAfTlBAluUM258ZY4QiETONp3RbjsJdA6omcjqVKqcLaILGP73AFTBm+/Aunygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685675; c=relaxed/simple;
	bh=ZtKcR+gaBrCffk5+FcWQymIAZGh5FL7JvJ7v4IjK4hk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kKMuQ2Z4pUr/1YsptatYg6+t1hFPjikO44Z2pKgzKQF+4a3UptBht92OBca8c+cPQG5xAvR6rzvzSsY7spgumwI8Yn3cYD1mszmR6Odwy4/I9bzz3bs5mnxarwysX4pUCWuuGhBy3qgXcbsBHJCv67g26qmDODagu9z3/DKeEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GAekjjuz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gag5/Fxf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XlbVEcqzK70Xd4/IoT+NiavE0+oU/y+jSQKIyn/+Go=;
	b=GAekjjuz0ybuz7LASDJ1KiPru7qkye4TWjr/PT6j8+tgWZl4oSC8u6e5vvNA1j+eXZpX9z
	wfekvSo96eeYuqYq6/I1o03udgMOhZ0xPSMMd9QbqKHFNZGRAyNbsyBOYMy3F/h4SJGfnv
	AE4FUtknIkfPIdsULCIoenEHwgs2mFbaMBc3/xlUqCeJm77mu2H7wLq/nQN5XXGrSh7kqS
	+tsf7DtLt32sSbD2QOgmKDmEa7fyi8IY/4LPCN8uXefLTQtIAP3IrTdrL5l4s7QW8FR8sk
	/px3XUfNe4H9thgyvpCnER/5iCDJDaY1JMjsWqSqx6VwB2Umdl9YV73eXnMGMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XlbVEcqzK70Xd4/IoT+NiavE0+oU/y+jSQKIyn/+Go=;
	b=Gag5/FxfamX284WGm1+59s3SfbEDN52XgRtURVu1wfAf8+k9//ZcmjB+9lxtdLj1zafRns
	iKJE704sp2AHA6AQ==
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
Message-ID: <170668567170.398.9402549096413117470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     531ff17a705a0f0ecafb8823956f69d5fbfda6fd
Gitweb:        https://git.kernel.org/tip/531ff17a705a0f0ecafb8823956f69d5fbfda6fd
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:17 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:36 +01:00

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

