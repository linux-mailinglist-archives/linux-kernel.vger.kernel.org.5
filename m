Return-Path: <linux-kernel+bounces-111154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9949886872
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074C61C211E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333118AE8;
	Fri, 22 Mar 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VMEW8yuT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/qXDw2X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B507BCA4A;
	Fri, 22 Mar 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097293; cv=none; b=kT5VFbS3hckoI5V0qGjyrb+j7yZX1azc7g6B7uI8QOHF6DtDjtsDRSF1+VPP7kNfR0VEM7BhW4fq6kx9PQrmNVK+0bu4vW4g+MVUP2dFgY7GO/I2DPCkryBtCgmnbLM6AeHbHdjnVwa7gMOjeTmCUBiF1i8RBDH2rgpGsRwi4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097293; c=relaxed/simple;
	bh=DPKjby22JnaFexYMsDx96M66Y+Nar1d3BS8Vx65NNYw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ejxS4tKZqHLF+me8f5UYHVc9QPzxhXU3XD65uA+x9yRRuoy1Vafx0N1e1ztfR5jv0o1pf0lZwQQvdU793RasgdYXjsR30BjwIfvOpruKsGpKbLOeuLejNmiPtdlKKJmDycZTzOfblRgSlmQdFHG4dFcE/4gv+/VbU/0vZtqIx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VMEW8yuT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/qXDw2X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 08:48:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711097290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQSAvH2YmDFljsNTX6p1/+901AO8rlvj48Oxo2l+mlY=;
	b=VMEW8yuTxrBt8DTvMzCyffxbeoYFgh3EPOQ9WUVkFW9VC1saeAOI8pcciILJfdfF2Yc8TX
	6U1oCVY4UDqmOoQTcFje+H0S5/cUGgdJ1fof20MXbFpG1ZhUploktgntKM/I5Mi//fvKaH
	zPpRF6FV6H6mFqiT8udSP4yALkjWL/jowVaqu+6w8vnu6lQOpLTYTTLgkcGw+R4IfbXPaE
	CNLmQk1LqBOTiqut4r1iSqp8iXM9pb7H876efE/9WLkjCaKSJHm3UptjOmdeb7xcBlRZ+j
	A59wosEuQ8iT1/vvTV9YH0eWUzTRYAMIR0ac5khMAhNPOredc1m8JVOGd7Lxbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711097290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nQSAvH2YmDFljsNTX6p1/+901AO8rlvj48Oxo2l+mlY=;
	b=D/qXDw2Xs7feqJtvu9j4ozzVcJI8XoKGTL/31oBU6FHxx6M7yvSSk6MpJTIH+2IwJYsK+z
	mNZmUR6LK/qcvUCw==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/syscall/compat: Remove ia32_unistd.h
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240321211847.132473-3-brgerst@gmail.com>
References: <20240321211847.132473-3-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171109728900.10875.7251932408476939147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e2d168328e3bdd21efa2ba34392f620ce58d2914
Gitweb:        https://git.kernel.org/tip/e2d168328e3bdd21efa2ba34392f620ce58d2914
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 21 Mar 2024 17:18:47 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Mar 2024 09:37:09 +01:00

x86/syscall/compat: Remove ia32_unistd.h

This header is now just a wrapper for unistd_32_ia32.h.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240321211847.132473-3-brgerst@gmail.com
---
 arch/x86/entry/entry_64_compat.S   |  1 -
 arch/x86/include/asm/ia32_unistd.h | 11 -----------
 arch/x86/include/asm/seccomp.h     |  2 +-
 arch/x86/kernel/signal_32.c        |  2 +-
 4 files changed, 2 insertions(+), 14 deletions(-)
 delete mode 100644 arch/x86/include/asm/ia32_unistd.h

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index eabf48c..49cc4b8 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -7,7 +7,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/current.h>
 #include <asm/errno.h>
-#include <asm/ia32_unistd.h>
 #include <asm/thread_info.h>
 #include <asm/segment.h>
 #include <asm/irqflags.h>
diff --git a/arch/x86/include/asm/ia32_unistd.h b/arch/x86/include/asm/ia32_unistd.h
deleted file mode 100644
index 7bcb829..0000000
--- a/arch/x86/include/asm/ia32_unistd.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_IA32_UNISTD_H
-#define _ASM_X86_IA32_UNISTD_H
-
-/*
- * This file contains the system call numbers of the ia32 compat ABI,
- * this is for the kernel only.
- */
-#include <asm/unistd_32_ia32.h>
-
-#endif /* _ASM_X86_IA32_UNISTD_H */
diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index fef16e3..42bcd42 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -9,7 +9,7 @@
 #endif
 
 #ifdef CONFIG_COMPAT
-#include <asm/ia32_unistd.h>
+#include <asm/unistd_32_ia32.h>
 #define __NR_seccomp_read_32		__NR_ia32_read
 #define __NR_seccomp_write_32		__NR_ia32_write
 #define __NR_seccomp_exit_32		__NR_ia32_exit
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index c12624b..ef65453 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -34,7 +34,7 @@
 #include <asm/gsseg.h>
 
 #ifdef CONFIG_IA32_EMULATION
-#include <asm/ia32_unistd.h>
+#include <asm/unistd_32_ia32.h>
 
 static inline void reload_segments(struct sigcontext_32 *sc)
 {

