Return-Path: <linux-kernel+bounces-73647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570785C571
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88491C20FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F2114F9D6;
	Tue, 20 Feb 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="isjk5MMK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhx13rg5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01B14D438;
	Tue, 20 Feb 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459475; cv=none; b=kEAb3HVU/q018ZOYe0G2s2gIzHqKNs2GZQErXMNGcY2sEztfg+9DK0CwCKO70aLBzzOdohf8xoolXlqxJAuWbL0OWB3bJk5kN7dETSLOwLQ/UF7bxklFkIf2PMflT1Wf3sGzLM83/PAhBTCFkpkiM1/h7zWeTP6HdRz2awsJ5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459475; c=relaxed/simple;
	bh=KEDsLXYcoyRDbxR0FZqnM+1PrPd3XchfuAYflXjBMzA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g5brHx05x6Ijuf2f3XTy3urbcOuu7V0RbABOd/xjnGTEuXue4R5jChuO1qbhPt5Vy/Cn/ngCkmIm4I6xVT+fxkiSTeH82iYdVLq9/mMPWdeGejhBObePCVMahivRvCcR+XycImvUMI4jvsSspz6kKGHlLC9XSKRCpiVmmzLwBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=isjk5MMK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhx13rg5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 20:04:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708459471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpLzDQM4p8MzYemt/5BaaxZB7bvUITLVj+nxe5abCSc=;
	b=isjk5MMKuRwO2dOxEDqg0/aVi4tt3HrKOJQR8Zs1ra6+HkEfzLsrT2JncyX0m087F6QdTg
	KKtTRqRG6RHI4rXMqEsCxa9ROJ69XNS0EiQqgWCp1aV8FsVv46eaY3nAIsR+mEf3jJvh47
	2Cv1xepOVHYB9qmtBDlGL666PcuoKqnwlnJw2q6DQtiJRpQ1aGmYgJI2DdD0NQB0oGOE/y
	q4kx+5Tl8DB5pPr7BZfvTXN8kt+cck2HC+yCAchqqStyCHVP79+U5c11bkzk3rZQTtOTm/
	B22yl6sSH9w+ne9KtbLUvTcq6OvrCFJsrdqeWzBGO2JTmnsJkkw9dm+uEwqh3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708459471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NpLzDQM4p8MzYemt/5BaaxZB7bvUITLVj+nxe5abCSc=;
	b=qhx13rg5RI2RUQFDNARM0O083Y+AQJ7TUhUSWHapC3UN+qvyu+NOo/UeNfrNEE1nH49fMc
	oNWfAvlUpLi3i+DQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso/ARM: Make union vdso_data_store available for
 all architectures
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Kees Cook <keescook@chromium.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240219153939.75719-5-anna-maria@linutronix.de>
References: <20240219153939.75719-5-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170845947061.398.18124310641714961312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a0d2fcd62ac2d3749ff48e30635fe8ea184f0a97
Gitweb:        https://git.kernel.org/tip/a0d2fcd62ac2d3749ff48e30635fe8ea184f0a97
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 19 Feb 2024 16:39:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Feb 2024 20:56:00 +01:00

vdso/ARM: Make union vdso_data_store available for all architectures

The vDSO data page "union vdso_data_store" is defined in an ARM specific
header file and also defined in several other places.

Move the definition from the ARM header file into the generic vdso datapage
header to make it also usable for others and to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240219153939.75719-5-anna-maria@linutronix.de

---
 arch/arm/include/asm/elf.h           |  1 -
 arch/arm/include/asm/vdso_datapage.h | 26 --------------------------
 arch/arm/kernel/asm-offsets.c        |  4 +++-
 arch/arm/kernel/vdso.c               |  4 ----
 include/vdso/datapage.h              | 10 ++++++++++
 5 files changed, 13 insertions(+), 32 deletions(-)
 delete mode 100644 arch/arm/include/asm/vdso_datapage.h

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index d681016..9f21e17 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -4,7 +4,6 @@
 
 #include <asm/auxvec.h>
 #include <asm/hwcap.h>
-#include <asm/vdso_datapage.h>
 
 /*
  * ELF register definitions..
diff --git a/arch/arm/include/asm/vdso_datapage.h b/arch/arm/include/asm/vdso_datapage.h
deleted file mode 100644
index bef68f5..0000000
--- a/arch/arm/include/asm/vdso_datapage.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Adapted from arm64 version.
- *
- * Copyright (C) 2012 ARM Limited
- */
-#ifndef __ASM_VDSO_DATAPAGE_H
-#define __ASM_VDSO_DATAPAGE_H
-
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-#include <vdso/datapage.h>
-#include <asm/page.h>
-
-union vdso_data_store {
-	struct vdso_data	data[CS_BASES];
-	u8			page[PAGE_SIZE];
-};
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
-#endif /* __ASM_VDSO_DATAPAGE_H */
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 219cbc7..4915662 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -21,10 +21,12 @@
 #include <asm/mpu.h>
 #include <asm/procinfo.h>
 #include <asm/suspend.h>
-#include <asm/vdso_datapage.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
+
+#include <vdso/datapage.h>
+
 #include "signal.h"
 
 /*
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index f297d66..d499ad4 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -21,7 +21,6 @@
 #include <asm/cacheflush.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
-#include <asm/vdso_datapage.h>
 #include <clocksource/arm_arch_timer.h>
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
@@ -35,9 +34,6 @@ extern char vdso_start[], vdso_end[];
 /* Total number of pages needed for the data and text portions of the VDSO. */
 unsigned int vdso_total_pages __ro_after_init;
 
-/*
- * The VDSO data page.
- */
 static union vdso_data_store vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = vdso_data_store.data;
 
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 73eb622..7ba4437 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,6 +19,8 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+#include <asm/page.h>
+
 #ifdef CONFIG_ARCH_HAS_VDSO_DATA
 #include <asm/vdso/data.h>
 #else
@@ -121,6 +123,14 @@ struct vdso_data {
 extern struct vdso_data _vdso_data[CS_BASES] __attribute__((visibility("hidden")));
 extern struct vdso_data _timens_data[CS_BASES] __attribute__((visibility("hidden")));
 
+/**
+ * union vdso_data_store - Generic vDSO data page
+ */
+union vdso_data_store {
+	struct vdso_data	data[CS_BASES];
+	u8			page[PAGE_SIZE];
+};
+
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:

