Return-Path: <linux-kernel+bounces-45910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545668437C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBDCB2485A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9C77BAFE;
	Wed, 31 Jan 2024 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qbuEfAeV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUjtWSfC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C478762D7;
	Wed, 31 Jan 2024 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685686; cv=none; b=lWFubA239QZezKy5GL0t8quOyx9kuxfby6c7jNuxO84wi08FcrdxSS+hb/bEXMCCZh3Kd2W9tLb7YYhw1v6Lqsa4ugktHU0CO29W1VQAAVh7lQTCX1zkhkqWwZ+ju09jksRDOSvXTzL6fRoZKXic8VOp8QPMeYccb6Z8uGvYLEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685686; c=relaxed/simple;
	bh=QL2/OWq+vgqFQvjPhv5WJiWMfqB/aoojfW5s8UhPlo0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zpy0LmI50qxUpHjMBrhrN3ywZ/BfdR2QzvtSWGWjgppDvE0W7dJ1FsUt3PmqUrLz4+/RSvit058wa67QxsRnxFkOdgK9fPPItjHwOD4nB9rZEFip49egZQSQFJDK5M3aJ259yvDTSOVJSA9D1wfYriX89meF64HLBvFhGWtO81Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qbuEfAeV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUjtWSfC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1conEPj2nHWZzNiaFZc+CtRhcR+OVNeXlZj8gBfnMU=;
	b=qbuEfAeVshGraxq4ERDPUwJkUjm8AorFtX0tX7drPr0txr/tkvFTc8VEUkjeQ4KID4abo/
	akXduNx/k0IE4a8fmCKuKHFFwitCrGovFo8w+reS7TWgz2rt3Fu4brKJSDpdAXeYRNPdCk
	48TN6Jsc90qMx5Nd5tq36xh7dQztEuFwlQ4Xpj/2+Sb919d+oTjbPowgPGfBvPgVMjbq7Y
	NY67ApTles7uhgFJtB+eBOhX4n4/Ecsr4/nLaFYWN40KBBrI/wS6a4dEL9Brg8JKTJ7ecv
	TCruxfhG4hkZVJLAqmmmV4nK91rkxPmXKgZwOXIY44vqSZVRGMlbOd8l9XRcBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1conEPj2nHWZzNiaFZc+CtRhcR+OVNeXlZj8gBfnMU=;
	b=zUjtWSfCvS8+bWTDEI4833cIEELRwX6q3AcnHloRg70B3aDnger0L6MrDdiNGcQQRdSs1f
	mxvHNviwvYaOFSDw==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Reserve space for the FRED stack frame
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-17-xin3.li@intel.com>
References: <20231205105030.8698-17-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170668568261.398.10403890006820046961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     fcd06abf6de2b81724a1e39c121d288f66b1d392
Gitweb:        https://git.kernel.org/tip/fcd06abf6de2b81724a1e39c121d288f66b1d392
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:05 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:35 +01:00

x86/fred: Reserve space for the FRED stack frame

When using FRED, reserve space at the top of the stack frame, just
like i386 does.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-17-xin3.li@intel.com

---
 arch/x86/include/asm/thread_info.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index d63b029..12da7df 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -31,7 +31,9 @@
  * In vm86 mode, the hardware frame is much longer still, so add 16
  * bytes to make room for the real-mode segments.
  *
- * x86_64 has a fixed-length stack frame.
+ * x86-64 has a fixed-length stack frame, but it depends on whether
+ * or not FRED is enabled. Future versions of FRED might make this
+ * dynamic, but for now it is always 2 words longer.
  */
 #ifdef CONFIG_X86_32
 # ifdef CONFIG_VM86
@@ -39,8 +41,12 @@
 # else
 #  define TOP_OF_KERNEL_STACK_PADDING 8
 # endif
-#else
-# define TOP_OF_KERNEL_STACK_PADDING 0
+#else /* x86-64 */
+# ifdef CONFIG_X86_FRED
+#  define TOP_OF_KERNEL_STACK_PADDING (2 * 8)
+# else
+#  define TOP_OF_KERNEL_STACK_PADDING 0
+# endif
 #endif
 
 /*

