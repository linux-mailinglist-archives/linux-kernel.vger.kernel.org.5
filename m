Return-Path: <linux-kernel+bounces-12370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FF81F3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80736B225EC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D25163B1;
	Thu, 28 Dec 2023 01:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RbDzr93O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B533F7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6bcc78so1364706b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727747; x=1704332547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB0U1us+sHbYZzCVyIg23Xjh36gyEMV3F74ABUc7NA8=;
        b=RbDzr93O9f8Q/vVlCjgidlyK5aK8cgopcvJ0LmfHTp6G6O2AZqBp4gHxRIRTY1fk+l
         nJIHT/9NmtPDtWpBhWa/3IWalcwgc+gzmYxFFQUYwlQ//wi40lEdMeaQVUi67ff9T9QB
         QB+xbZJoaj4LNwpccEwKt9gdPV0EYmInXrXCyDv7F0VNGPKomv6Qa8jM5duiKfUUE2OA
         wXgg7jtVkZ1rNbrVcky/2b8qlZLZRXLbKLJb5ZZ4d8T+qBomhLYtJ7Z1bNkF0Hd7lpBC
         fDSMyQWsFXcEM6WN2/Iw2PbP7XLGVKiAJYWuXN8azyelJYaTSJkcHq2fIN8B7d+iw0/D
         eoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727747; x=1704332547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UB0U1us+sHbYZzCVyIg23Xjh36gyEMV3F74ABUc7NA8=;
        b=c8OuTSL69Rk4BLyDgs4NhdBgQGrxpY9ODL7rqrPvR8H6DvK0ByoV+fcXsDmr0IOqBx
         MAQeM1K2wMfBzEz1Y0Pyw3pH23uP7bW06kXRt8ZZdofCZOxtzdW56jT4CRGWE3j7nu2Y
         lV+E2WuEJmD+5ppISlMh+e8BpYdtBx7aBrTtOyTuioogVHEtjwYNEl66T8PE8+Au925H
         cuG1Qzt+vvohFcik5skkPu+CNbaf59uDL5ir40GqnVCklGI4HUxuEykX3l6IptbnXuCY
         a3JKcmCm86QB1pt2JKuzIzi89o+WbQMfgq6dYoup6I3teOVs9nJLoWw+a+N3TVX0scUX
         /DoQ==
X-Gm-Message-State: AOJu0YxcNT4a3LWF2jpE3wp2pT60VeOmoAPVIaXN2TQcexyBcLo+ODrU
	oA4EmHOdGfIhj2NFEvoB14P0V3LlXjwdNA==
X-Google-Smtp-Source: AGHT+IGpivtFhMAB3UbcfS1StWXrUWSkj+hLT17JMH2Q4rov0k82hYGdvWTiR/shQbloO22mN5mO3A==
X-Received: by 2002:a05:6808:148e:b0:3bb:c453:df38 with SMTP id e14-20020a056808148e00b003bbc453df38mr2614480oiw.60.1703727747728;
        Wed, 27 Dec 2023 17:42:27 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:27 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 04/14] arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Dec 2023 17:41:54 -0800
Message-ID: <20231228014220.3562640-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231228014220.3562640-1-samuel.holland@sifive.com>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arm64 provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Remove file name from header comment

 arch/arm64/Kconfig           |  1 +
 arch/arm64/Makefile          |  9 ++++++++-
 arch/arm64/include/asm/fpu.h | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/fpu.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..485ac389ac11 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -30,6 +30,7 @@ config ARM64
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9a2d3723cd0f..4a65f24c7998 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,7 +36,14 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
 $(warning Detected assembler with broken .inst; disassembly will be unreliable)
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only	\
+# The GCC option -ffreestanding is required in order to compile code containing
+# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
+CC_FLAGS_FPU	:= -ffreestanding
+# Enable <arm_neon.h>
+CC_FLAGS_FPU	+= -isystem $(shell $(CC) -print-file-name=include)
+CC_FLAGS_NO_FPU	:= -mgeneral-regs-only
+
+KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
 		   $(compat_vdso) $(cc_has_k_constraint)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
diff --git a/arch/arm64/include/asm/fpu.h b/arch/arm64/include/asm/fpu.h
new file mode 100644
index 000000000000..2ae50bdce59b
--- /dev/null
+++ b/arch/arm64/include/asm/fpu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef __ASM_FPU_H
+#define __ASM_FPU_H
+
+#include <asm/neon.h>
+
+#define kernel_fpu_available()	cpu_has_neon()
+#define kernel_fpu_begin()	kernel_neon_begin()
+#define kernel_fpu_end()	kernel_neon_end()
+
+#endif /* ! __ASM_FPU_H */
-- 
2.42.0


