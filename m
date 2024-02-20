Return-Path: <linux-kernel+bounces-72162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8274A85B035
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C1D1C22628
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277792232E;
	Tue, 20 Feb 2024 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vDQDrpfo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OWF5R8K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAABA107B3;
	Tue, 20 Feb 2024 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390931; cv=none; b=t3hLbuvHzy0AbDSQzcKRnMiBuHxIP/lVE2coV9Yb6OO+YqskCCmZN78/VN0l8CoN0TTBjFff3BTg+aCWBBQvH7GJj48aRBXke5qHhVU9g2Ewk6rn+AIlcPStcpCxqCMeJ5JalFosc0MFvlyrvO/HxCyV/HCXsR1/RyWjuFbPeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390931; c=relaxed/simple;
	bh=1TJF4aBsszoWK56Nl1o97ae4i1PRvc9OA8fu2mY2syI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Qvzk1ITGOZMB65um7gbV2ZgEjiHtz0Qy7vaVkY5m5tnJC1uBRWqKojZOlj5ckGrCDB49U9/54aAm4G8uKfLoK1coPsYBtUDSM0RYfeZJuJtE6p4/3JQqLgDXCq8O2yr4Z/Bnsll3CqdbRtjgmsD56YCoauFuLNrL54bElCquV0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vDQDrpfo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OWF5R8K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 01:02:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708390927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=te/2U583Lf4tyee1I4+21+y3PWy7zV8t4y4NHb6fn/U=;
	b=vDQDrpfoFE0TRNsua4gP7FPekl1O8YZb/6fJA2boHhEQam1mw7ozfXgrgzP5Ewqb5A3dBX
	XXqaBn7sB5C6vL/Q6ocj0MezC2N8UlWdSyZDpjMLxUItE3pO/w1tUOLm4iv15q+jE3j/JA
	rYB/Amh/WW0eFTVMXOzO1tuHHRoSv5vjHVF58YWTFTOivF6IXrcGnjhdCetjJslxb+4HuX
	hdWNPMZMsu3U8925rBXq4+rHJK5n++jcq1CoRAStbVHHqnytYBx5shh79+DIJM3gL6KKNy
	wNPj+odDGWccFbdSB0Le4ycIDG1S0LnnFFD5YvXQisi+ki09VbIlMpqkIbUB0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708390927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=te/2U583Lf4tyee1I4+21+y3PWy7zV8t4y4NHb6fn/U=;
	b=4OWF5R8K/lfoBwMXxIgSR5a/HpvYomkmNsFy31kV7n+GXFG33au13hyeQFnESJGrVCe9wa
	4ayZ0O5S2J9GSQBg==
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
Message-ID: <170839092663.398.4327574535537349249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a0e2dab44d22b913b4c228c8b52b2a104434b0b3
Gitweb:        https://git.kernel.org/tip/a0e2dab44d22b913b4c228c8b52b2a104434b0b3
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 13 Feb 2024 18:22:08 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 19 Feb 2024 16:31:46 -08:00

x86/entry_32: Add VERW just before userspace transition

As done for entry_64, add support for executing VERW late in exit to
user path for 32-bit mode.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-3-a6216d83edb7%40linux.intel.com
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

