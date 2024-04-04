Return-Path: <linux-kernel+bounces-131154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84858983CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B0751F23B1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F461757F5;
	Thu,  4 Apr 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtKwDt+y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17EAErrx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82E73534;
	Thu,  4 Apr 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221881; cv=none; b=o5uMU0AhC0rWn4GXAjIQxcqRXljdCFM9b/L/rYqTVNd8FdwBW279QvJJgwc/x5dp4gPgnlO4Mm6obEsZfuRCqscKiFBgvbAO8o1Rp3Qi7LBfqWi28zp59IIHxQODeeG5MtPnE429deja0/iiw4hi8TbdLCf67CEIRJ3rNJdbnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221881; c=relaxed/simple;
	bh=AqAz0fyma+WM2G84E5d3MtT1EoU8OPK2OMlvjH+i+dA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l9+/qIJe5XUBFIDjJiZ+m8UfaVcyPm3HSEAu7GnbcvzxTQ2th5QcM23+Yk6Ycv5EgNO+xt2LOyEySpIadIJLRgMMArvmjs5gWPcWTm8L8bSN+NebR/7aQ8Jxd72ZFOWPfBElB3aAoimKmP+9G/8stxFi17vzbOROZxMcGo5iuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtKwDt+y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17EAErrx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Apr 2024 09:11:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712221877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvptYDHDez2UUHmswjm6sdWDlCifqw+Q9g5teQtxm6Q=;
	b=XtKwDt+y0e/1tduINY/PQso4f4FpbVJ8B53C47IGfKjluqog05xDaKx9o9vmvs/dh4ZBT1
	pgaPiGFWi7qmyHVSaRymXe0mYzhUg/T26jxGtkesTuYgvbCJZhvx2SlAMvHQxdwzAxbMqH
	1u6dwxxa/dL5zoRxt/ijT7hI3Sht+n1jZfwLz2Z5K2sTddG8e1uzqVxrIT3ii3KEQxZ3RW
	UrAt5LVpwPfirkABHpMgXV0BEulqSX8q1X9KQikJivglqAZePldDVOUrO7skLToIkGBLbI
	L7Cco64rCPoUP03ZSmGsVcB9XicYqV8a98ALcfMqyx9NNGWgM0/naCilAgF47w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712221877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DvptYDHDez2UUHmswjm6sdWDlCifqw+Q9g5teQtxm6Q=;
	b=17EAErrxQRhkohMd/wZf5pLV1eIuRNHrGG+dgQJy7+Zs4yVoqtxw/4wdrdkiqyQi4Y8yQs
	TDqEQm6bMyKCsYBg==
From: "tip-bot2 for Jason A. Donenfeld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/coco: Require seeding RNG with RDRAND on CoCo systems
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Elena Reshetova <elena.reshetova@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Theodore Ts'o" <tytso@mit.edu>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240326160735.73531-1-Jason@zx2c4.com>
References: <20240326160735.73531-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171222187676.10875.5470106472891910438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     99485c4c026f024e7cb82da84c7951dbe3deb584
Gitweb:        https://git.kernel.org/tip/99485c4c026f024e7cb82da84c7951dbe3deb584
Author:        Jason A. Donenfeld <Jason@zx2c4.com>
AuthorDate:    Tue, 26 Mar 2024 17:07:35 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Apr 2024 10:40:19 +02:00

x86/coco: Require seeding RNG with RDRAND on CoCo systems

There are few uses of CoCo that don't rely on working cryptography and
hence a working RNG. Unfortunately, the CoCo threat model means that the
VM host cannot be trusted and may actively work against guests to
extract secrets or manipulate computation. Since a malicious host can
modify or observe nearly all inputs to guests, the only remaining source
of entropy for CoCo guests is RDRAND.

If RDRAND is broken -- due to CPU hardware fault -- the RNG as a whole
is meant to gracefully continue on gathering entropy from other sources,
but since there aren't other sources on CoCo, this is catastrophic.
This is mostly a concern at boot time when initially seeding the RNG, as
after that the consequences of a broken RDRAND are much more
theoretical.

So, try at boot to seed the RNG using 256 bits of RDRAND output. If this
fails, panic(). This will also trigger if the system is booted without
RDRAND, as RDRAND is essential for a safe CoCo boot.

Add this deliberately to be "just a CoCo x86 driver feature" and not
part of the RNG itself. Many device drivers and platforms have some
desire to contribute something to the RNG, and add_device_randomness()
is specifically meant for this purpose.

Any driver can call it with seed data of any quality, or even garbage
quality, and it can only possibly make the quality of the RNG better or
have no effect, but can never make it worse.

Rather than trying to build something into the core of the RNG, consider
the particular CoCo issue just a CoCo issue, and therefore separate it
all out into driver (well, arch/platform) code.

  [ bp: Massage commit message. ]

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Elena Reshetova <elena.reshetova@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240326160735.73531-1-Jason@zx2c4.com
---
 arch/x86/coco/core.c        | 41 ++++++++++++++++++++++++++++++++++++-
 arch/x86/include/asm/coco.h |  2 ++-
 arch/x86/kernel/setup.c     |  2 ++-
 3 files changed, 45 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index d07be9d..ddd4efd 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -3,13 +3,17 @@
  * Confidential Computing Platform Capability checks
  *
  * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
 #include <linux/export.h>
 #include <linux/cc_platform.h>
+#include <linux/string.h>
+#include <linux/random.h>
 
+#include <asm/archrandom.h>
 #include <asm/coco.h>
 #include <asm/processor.h>
 
@@ -148,3 +152,40 @@ u64 cc_mkdec(u64 val)
 	}
 }
 EXPORT_SYMBOL_GPL(cc_mkdec);
+
+__init void cc_random_init(void)
+{
+	/*
+	 * The seed is 32 bytes (in units of longs), which is 256 bits, which
+	 * is the security level that the RNG is targeting.
+	 */
+	unsigned long rng_seed[32 / sizeof(long)];
+	size_t i, longs;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	/*
+	 * Since the CoCo threat model includes the host, the only reliable
+	 * source of entropy that can be neither observed nor manipulated is
+	 * RDRAND. Usually, RDRAND failure is considered tolerable, but since
+	 * CoCo guests have no other unobservable source of entropy, it's
+	 * important to at least ensure the RNG gets some initial random seeds.
+	 */
+	for (i = 0; i < ARRAY_SIZE(rng_seed); i += longs) {
+		longs = arch_get_random_longs(&rng_seed[i], ARRAY_SIZE(rng_seed) - i);
+
+		/*
+		 * A zero return value means that the guest doesn't have RDRAND
+		 * or the CPU is physically broken, and in both cases that
+		 * means most crypto inside of the CoCo instance will be
+		 * broken, defeating the purpose of CoCo in the first place. So
+		 * just panic here because it's absolutely unsafe to continue
+		 * executing.
+		 */
+		if (longs == 0)
+			panic("RDRAND is defective.");
+	}
+	add_device_randomness(rng_seed, sizeof(rng_seed));
+	memzero_explicit(rng_seed, sizeof(rng_seed));
+}
diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index fb7388b..c086699 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -22,6 +22,7 @@ static inline void cc_set_mask(u64 mask)
 
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
+void cc_random_init(void);
 #else
 #define cc_vendor (CC_VENDOR_NONE)
 
@@ -34,6 +35,7 @@ static inline u64 cc_mkdec(u64 val)
 {
 	return val;
 }
+static inline void cc_random_init(void) { }
 #endif
 
 #endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 0109e6c..e125e05 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -35,6 +35,7 @@
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
 #include <asm/cacheinfo.h>
+#include <asm/coco.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
 #include <asm/gart.h>
@@ -991,6 +992,7 @@ void __init setup_arch(char **cmdline_p)
 	 * memory size.
 	 */
 	mem_encrypt_setup_arch();
+	cc_random_init();
 
 	efi_fake_memmap();
 	efi_find_mirror();

