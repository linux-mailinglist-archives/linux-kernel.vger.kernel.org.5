Return-Path: <linux-kernel+bounces-136475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F1D89D476
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E28E1C22707
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199637E78B;
	Tue,  9 Apr 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDLPpozD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TIX6bOHt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A713048B;
	Tue,  9 Apr 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651268; cv=none; b=AnHXi4u5FynB7UbOGjK2GTcpzRkOk5ZUHwzmWZCz0nG0CYfOhry+Yt0sZWAWy2tMX/oUbGRagMtyYK691v1RP6aROw7w9Z22WAz5NlC6XIyy+KG9I3SF+4m6FGZg0Zb/DZw0PIeNDNz0QeCesaAh3yw58/6QYAN03qSoJ1MSCoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651268; c=relaxed/simple;
	bh=/+Hi6vwrI+/azqu2PLMP1pkwyqM1tyJ2TALzPG1MuyA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YmhCTiKpM73n/24HmnLV5ItNs3Y+s7o1mb+A7Spo7+Zr2kLgRQFfdtLz5O3WfOxLm46D9DvLOUZ65BH3DAP0mnjfrp6u5DtkhGRrft68Qd+4iGyqBZ5AaNg83HGVrBJoTkKN9bxSDnDolbXZRQvIVJ/k39bxI47zg/oK08akMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DDLPpozD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TIX6bOHt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Apr 2024 08:27:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712651264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uv3eqwvRlzTvqyKKBFLuJ5zhdqBDogQRJAanaG8Ixeg=;
	b=DDLPpozDuuyGUMP55FuJwgxpjzCgAIwpdiGfPcZ8i+AkOvxNhaIMCXU8dIS/ErkS+Z7w9S
	zBRQWb2XzUTlshc0WBfv1w4+Bh+mIbeMf3+7zLfzJrd5fGRgtoU4/7WqhVmqhQKO+80Cg3
	m0OGOApjRUlJVR9QFnLMqr78BJvhIrW7cyZqUhlJzOJkkW2KfIrx4RS6/iy8RlXjjjCgkg
	vgR9UQSrUmY+1F6jIrEBgj7s4dgAMxxz8XOanvIKrRyVj8N3++0WCSUw9OntvwJfHZODur
	u1Z/YGNMeyWg3oThettLkSjjEi9RYqM3R9S2pMtgN2FlvKaXMZbrnsf078KNAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712651264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uv3eqwvRlzTvqyKKBFLuJ5zhdqBDogQRJAanaG8Ixeg=;
	b=TIX6bOHtOHpk2vhI67s7+g3m+18TQCl1dsBenLUu3B8M72TaWz358Se3Jv09Mrv5pLt4Ke
	LeAaY5u+O4Q/pxDA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mce: Implement recovery for errors in TDX/SEAM
 non-root mode
Cc: Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240408180944.44638-1-tony.luck@intel.com>
References: <20240408180944.44638-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171265126376.10875.16864387954272613660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7911f145de5fecbee1d67f27f73bec12f0fbc472
Gitweb:        https://git.kernel.org/tip/7911f145de5fecbee1d67f27f73bec12f0fbc472
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 08 Apr 2024 11:09:44 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 09 Apr 2024 09:30:36 +02:00

x86/mce: Implement recovery for errors in TDX/SEAM non-root mode

Machine check SMIs (MSMI) signaled during SEAM operation (typically
inside TDX guests), on a system with Intel eMCA enabled, might eventually
be reported to the kernel #MC handler with the saved RIP on the stack
pointing to the instruction in kernel code after the SEAMCALL instruction
that entered the SEAM operation. Linux currently says that is a fatal
error and shuts down.

There is a new bit in IA32_MCG_STATUS that, when set to 1, indicates
that the machine check didn't originally occur at that saved RIP, but
during SEAM non-root operation.

Add new entries to the severity table to detect this for both data load
and instruction fetch that set the severity to "AR" (action required).

Increase the width of the mcgmask/mcgres fields in "struct severity"
from unsigned char to unsigned short since the new bit is in position 12.

Action required for these errors is just mark the page as poisoned and
return from the machine check handler.

HW ABI notes:
=============

The SEAM_NR bit in IA32_MCG_STATUS hasn't yet made it into the Intel
Software Developers' Manual. But it is described in section 16.5.2
of "Intel(R) Trust Domain Extensions (Intel(R) TDX) Module Base
Architecture Specification" downloadable from:

  https://cdrdv2.intel.com/v1/dl/getContent/733575

Backport notes:
===============

Little value in backporting this patch to stable or LTS kernels as
this is only relevant with support for TDX, which I assume won't be
backported. But for anyone taking this to v6.1 or older, you also
need commit:

  a51cbd0d86d3 ("x86/mce: Use severity table to handle uncorrected errors in kernel")

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240408180944.44638-1-tony.luck@intel.com
---
 arch/x86/include/asm/mce.h         |  2 ++
 arch/x86/kernel/cpu/mce/core.c     | 18 ++++++++++++++++++
 arch/x86/kernel/cpu/mce/severity.c | 16 ++++++++++++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index de31183..dfd2e96 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -13,6 +13,7 @@
 #define MCG_CTL_P		BIT_ULL(8)   /* MCG_CTL register available */
 #define MCG_EXT_P		BIT_ULL(9)   /* Extended registers available */
 #define MCG_CMCI_P		BIT_ULL(10)  /* CMCI supported */
+#define MCG_SEAM_NR		BIT_ULL(12)  /* MCG_STATUS_SEAM_NR supported */
 #define MCG_EXT_CNT_MASK	0xff0000     /* Number of Extended registers */
 #define MCG_EXT_CNT_SHIFT	16
 #define MCG_EXT_CNT(c)		(((c) & MCG_EXT_CNT_MASK) >> MCG_EXT_CNT_SHIFT)
@@ -25,6 +26,7 @@
 #define MCG_STATUS_EIPV		BIT_ULL(1)   /* ip points to correct instruction */
 #define MCG_STATUS_MCIP		BIT_ULL(2)   /* machine check in progress */
 #define MCG_STATUS_LMCES	BIT_ULL(3)   /* LMCE signaled */
+#define MCG_STATUS_SEAM_NR	BIT_ULL(12)  /* Machine check inside SEAM non-root mode */
 
 /* MCG_EXT_CTL register defines */
 #define MCG_EXT_CTL_LMCE_EN	BIT_ULL(0) /* Enable LMCE */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 84d41be..771a9f1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1593,6 +1593,24 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		else
 			queue_task_work(&m, msg, kill_me_maybe);
 
+	} else if (m.mcgstatus & MCG_STATUS_SEAM_NR) {
+		/*
+		 * Saved RIP on stack makes it look like the machine check
+		 * was taken in the kernel on the instruction following
+		 * the entry to SEAM mode. But MCG_STATUS_SEAM_NR indicates
+		 * that the machine check was taken inside SEAM non-root
+		 * mode.  CPU core has already marked that guest as dead.
+		 * It is OK for the kernel to resume execution at the
+		 * apparent point of the machine check as the fault did
+		 * not occur there. Mark the page as poisoned so it won't
+		 * be added to free list when the guest is terminated.
+		 */
+		if (mce_usable_address(&m)) {
+			struct page *p = pfn_to_online_page(m.addr >> PAGE_SHIFT);
+
+			if (p)
+				SetPageHWPoison(p);
+		}
 	} else {
 		/*
 		 * Handle an MCE which has happened in kernel space but from
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c447716..fc8988c 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -39,8 +39,8 @@ static struct severity {
 	u64 mask;
 	u64 result;
 	unsigned char sev;
-	unsigned char mcgmask;
-	unsigned char mcgres;
+	unsigned short mcgmask;
+	unsigned short mcgres;
 	unsigned char ser;
 	unsigned char context;
 	unsigned char excp;
@@ -174,6 +174,18 @@ static struct severity {
 		USER
 		),
 	MCESEV(
+		AR, "Data load error in SEAM non-root mode",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
+		MCGMASK(MCG_STATUS_SEAM_NR, MCG_STATUS_SEAM_NR),
+		KERNEL
+		),
+	MCESEV(
+		AR, "Instruction fetch error in SEAM non-root mode",
+		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
+		MCGMASK(MCG_STATUS_SEAM_NR, MCG_STATUS_SEAM_NR),
+		KERNEL
+		),
+	MCESEV(
 		PANIC, "Data load in unrecoverable area of kernel",
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
 		KERNEL

