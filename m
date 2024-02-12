Return-Path: <linux-kernel+bounces-62187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A7851CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAEF1C217D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B024176D;
	Mon, 12 Feb 2024 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wc5phODj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XHRPdKh0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1A26AC9;
	Mon, 12 Feb 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762751; cv=none; b=iGxUCbfik0Npo4o94TJqUd4kV34JZD0vJOOFTEg+cixqiJStbQWAhNDyNH5SwPHB4oU2ug2bLThDoVqbexvuPNxVP1Q1LA7krjCIANrYd4xLUg0/CG222gW8nDezJDSB7L8GwlTYkhAT2hDt/D0uYPn9AEe022S/qmOOf3ZxtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762751; c=relaxed/simple;
	bh=vyNJHPcNUPuLi3pT81UVt/fQQ1xvHa0H118nZZfIRAk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZwQW7rtgkE1Tg8UTszx45AgjBc4PdnqryvAJ9dIRFWMfg2iKARll2tAswkz7dF6qlPaPfBCIcw03rHOQ3IvKJO3s6wdUpSD/n3lOOg6KsPtVUFxRB3nD3nTNiwQG9lS0qP2kID0xPS0aa872RqjDjdGpR8PsLBglFdwBaQGh3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wc5phODj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XHRPdKh0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Feb 2024 18:32:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707762748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yG5IYIcZ1vNM+Kx9tfbUTRPnGYxEZCwKfcK4CxPzkFc=;
	b=Wc5phODjU73J7K2FbRg8vdyzN6EsFkG0uQyn5MZtAqssT5cE6zTKM53QGOOx4g/4ikzcj5
	owkd0g2fo7KiYaCl0RX4/WTaDWuBZltumjY3lrl5U3JW/fF9/EVjO111XvLzBOv+HpJAP5
	ymsxsprENafzLVVGNPcJPtO78TxsUiw/b9F5nkAEr9dj5teEm9X4XmUfgMV1Gu1I64DbZ9
	QNnFbvVdgLK5xMewB8WNIXkfnGaYrHRTLuRbVlkWd9ug++Oxx02mEcv8jYhdQZ76pMFwju
	4okxxRw8cHpiyWhw2o2+uuvJhFJGbYMuSYLDJruDiHkqyPKSp509+68DhYBW8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707762748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yG5IYIcZ1vNM+Kx9tfbUTRPnGYxEZCwKfcK4CxPzkFc=;
	b=XHRPdKh0j4qaPF09Ss9CAK9ae2+PVdKlFJJEmmRDk4D2EdQUS4bAgEHrLwQOmHOrQfy/sn
	oxxeiyHa+lOT+yAQ==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/entry_32: Add VERW just before userspace transition
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170776274745.398.9046435625961830614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a67d262a840e0cc2daf4b55940f4a318b831d911
Gitweb:        https://git.kernel.org/tip/a67d262a840e0cc2daf4b55940f4a318b831d911
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Sun, 04 Feb 2024 23:19:33 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 12 Feb 2024 10:25:22 -08:00

x86/entry_32: Add VERW just before userspace transition

As done for entry_64, add support for executing VERW late in exit to
user path for 32-bit mode.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240204-delay-verw-v7-3-59be2d704cb2%40linux.intel.com
---
 arch/x86/entry/entry_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index c73047b..fba4276 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -885,6 +885,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -954,6 +955,7 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1146,6 +1148,7 @@ SYM_CODE_START(asm_exc_nmi)
 
 	/* Not on SYSENTER stack. */
 	call	exc_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:

