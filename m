Return-Path: <linux-kernel+bounces-71599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84085A79D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D46DB24575
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2FD3D558;
	Mon, 19 Feb 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQVndt3p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="znuj+4xx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24AF3AC08
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357208; cv=none; b=kVxbiACk2j8tdSpq0kV7kG+aHcQR4ZPlfdaLrLOlKFTCRz2HZll+AYOjGcLv9oKGaIhEOhFL5VQESBuwpyA/K0bqdrS1n9sn1AvWYOJ+qOocdi9d7htuKMkZmigwhx8bzr4OO9Cp2X1p9aUQiGfyXQOyQWvk/RAi6tMc+aQjR1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357208; c=relaxed/simple;
	bh=4nSPlxQK2Qa4EXTdhd2aosfODHzGKDI3DJ3vUm8YPFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lg8GAzo3eP/ZeIcvnvWbdpkmEcR3tBD4rRz1X5OwlwkJvrRVot1N1DNbQHBqr5Um028OYXRHy03O1qwD7Q46FfOcU9NfC5AHBqBbuVM9cojTk4DGN1/fWAMOQeAjzDC70SJAZ5ygjhe1qcUmwmHxh6yeyNbIt8PBtClBvivoRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQVndt3p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=znuj+4xx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708357205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlKcGbQq5n1Lw3ANMVFZoMmufVy08yz4U/pR4YBIv6o=;
	b=DQVndt3p0yfttx5AUPeZCN3iTtdWAV24hcFQuNtKUGHDfWkmTmFOzBwJ4tX79ZpwmjQqlo
	wsPmcs6vqvJKWsSFuoHbpNZFIBeMUIyKj8ntew1GN8JErgcphPgfCzSBjXIRVnkRuvh00b
	3U7UjOc9gWh78q87i+720c5EaQDtDSmfqsqibDcmLbYUmEjYhfpJ3v/IUgZ9nkm9TA4czC
	rzJjPBcvSHRkv3zGbOzlOmEhJsH3SlIyGHObDLQy1LHy84ud7HDnQ+KIym5dKFkKnBuUr0
	gtlWnwlHDN4wVXCuystRefqWOwCqZWRdd076BoftdfAE+sZOnUPycjEXnz/h6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708357205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlKcGbQq5n1Lw3ANMVFZoMmufVy08yz4U/pR4YBIv6o=;
	b=znuj+4xxxhEIGTq4lLn9ezO0YtooAhxLQ7RA0DFKxuk+jNtat7QB8A5H1hpkVLW5Edcw52
	0IGraAgMTD7ge5DQ==
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/10] vdso/arm: make union vdso_data_store available for all
Date: Mon, 19 Feb 2024 16:39:33 +0100
Message-Id: <20240219153939.75719-5-anna-maria@linutronix.de>
In-Reply-To: <20240219153939.75719-1-anna-maria@linutronix.de>
References: <20240219153939.75719-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vDSO data page "union vdso_data_store" is defined in an arm header file
and also defined in several other places.

Move the definition from arm header file into the generic vdso datapage
header to make it also usable for others and to prevent code duplication.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/elf.h           |  1 -
 arch/arm/include/asm/vdso_datapage.h | 26 --------------------------
 arch/arm/kernel/asm-offsets.c        |  4 +++-
 arch/arm/kernel/vdso.c               |  4 ----
 include/vdso/datapage.h              | 10 ++++++++++
 5 files changed, 13 insertions(+), 32 deletions(-)
 delete mode 100644 arch/arm/include/asm/vdso_datapage.h

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index d68101655b74..9f21e170320f 100644
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
index bef68f59928d..000000000000
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
index 219cbc7e5d13..4915662842ff 100644
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
index f297d66a8a76..d499ad461b00 100644
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
index 73eb622e7663..7ba44379a095 100644
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
-- 
2.39.2


