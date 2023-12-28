Return-Path: <linux-kernel+bounces-12375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B0E81F3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5046B2232A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0B579EF;
	Thu, 28 Dec 2023 01:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A3vs/6WJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147B6FDE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d099d316a8so5281263b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1703727752; x=1704332552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FK4PuyaVW5o+fowKBsFSathMMiGJoXogQryv4/PrHo=;
        b=A3vs/6WJqtpqWypgk3xYBHVrxyzR+FXXJ2nkBmSRynPIfG1DxMKQsrPZDBjh3V0acI
         mKMM6M5ABYc4vGkyBE0QL25Te1qrX0cFdhjJBjSOrbA/7QPlLlNk0S9eVAhsrfLMbY4b
         nEFfJje/WknaBfQia1fQnYPbzgoA/6OVKgH7MX9uqz045O0hXqrALfB1FqYU7n4A5uEB
         qx9DN6tTO/7sg/4rHlxwGDfgcq986CjQrxJUP0oaVyqt0Iwfe8YBPMT+ni8s2triDgJr
         1mjdgZJbfi/e7X2BGupObKbUkNSPqD0Ld2Paq7Z0LO00yT6W4Y327PD8wkZYRoldTcId
         rQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727752; x=1704332552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FK4PuyaVW5o+fowKBsFSathMMiGJoXogQryv4/PrHo=;
        b=eg64Ef7bmhYfJCcd6bkPyaapfH34OzdNZo7OL2egOkf0tOeaQCz8IS2KrjI2HaIAsn
         5GsRV6/XpAOXH2vgsED10f6NYCLVfRtOfqf72jtKhlojWBwkXTEWZeeKw0Vd76MxleR0
         7dBlv9UKz5GcutGVDELPWfcrA18l4rMJHqYA0iNix6WwirT5qznpZX3b0/xmW4XKu7G8
         3R9ep9THiUysVyDsieVvymwwA8+UcOfxKbm7qdF5FP8qsRU4dUMXvMZKQ7Jz/qjWgpzn
         yEeHBtNIfLhHv3zPrIqp2ElNCA89fEVVlA7hTjLnD3as9ekyH2PyQWBHaZJELAfPGA5M
         VT/A==
X-Gm-Message-State: AOJu0YxJYLS9cs80AMB5mbV6Zw+IpLfqBK5e1/0G8to4JxjpVq7Lmsek
	dYMNHMmMkmaWCTE3q+HSrqbxg4GTkcLrVQ==
X-Google-Smtp-Source: AGHT+IGDcwpDNI+ACJS8JwK6slMdt2P3zgEqkBXVCA8XIoKmVvXUWVJm0n6YvZtcZMejj6VORWJ3pQ==
X-Received: by 2002:a05:6a21:612:b0:194:f17b:f877 with SMTP id ll18-20020a056a21061200b00194f17bf877mr9226487pzb.61.1703727752746;
        Wed, 27 Dec 2023 17:42:32 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:42:32 -0800 (PST)
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
Subject: [PATCH v2 08/14] powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Dec 2023 17:41:58 -0800
Message-ID: <20231228014220.3562640-9-samuel.holland@sifive.com>
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

PowerPC provides an equivalent to the common kernel-mode FPU API, but in
a different header and using different function names. The PowerPC API
also requires a non-preemptible context. Add a wrapper header, and
export the CFLAGS adjustments.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/Makefile          |  5 ++++-
 arch/powerpc/include/asm/fpu.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/fpu.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6f105ee4f3cf..e96cb5b7c571 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -137,6 +137,7 @@ config PPC
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_HUGEPD			if HUGETLB_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT	if PPC_FPU
 	select ARCH_HAS_MEMBARRIER_CALLBACKS
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEMREMAP_COMPAT_ALIGN	if PPC_64S_HASH_MMU
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index f19dbaa1d541..91106970a8c1 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -142,6 +142,9 @@ CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option, $(MULTIPLEWORD))
 
 CFLAGS-$(CONFIG_PPC32)	+= $(call cc-option,-mno-readonly-in-sdata)
 
+CC_FLAGS_FPU		:= $(call cc-option,-mhard-float)
+CC_FLAGS_NO_FPU		:= $(call cc-option,-msoft-float)
+
 ifdef CONFIG_FUNCTION_TRACER
 ifdef CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY
 KBUILD_CPPFLAGS	+= -DCC_USING_PATCHABLE_FUNCTION_ENTRY
@@ -163,7 +166,7 @@ asinstr := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
 
 KBUILD_CPPFLAGS	+= -I $(srctree)/arch/$(ARCH) $(asinstr)
 KBUILD_AFLAGS	+= $(AFLAGS-y)
-KBUILD_CFLAGS	+= $(call cc-option,-msoft-float)
+KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU)
 KBUILD_CFLAGS	+= $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
diff --git a/arch/powerpc/include/asm/fpu.h b/arch/powerpc/include/asm/fpu.h
new file mode 100644
index 000000000000..ca584e4bc40f
--- /dev/null
+++ b/arch/powerpc/include/asm/fpu.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef _ASM_POWERPC_FPU_H
+#define _ASM_POWERPC_FPU_H
+
+#include <linux/preempt.h>
+
+#include <asm/cpu_has_feature.h>
+#include <asm/switch_to.h>
+
+#define kernel_fpu_available()	(!cpu_has_feature(CPU_FTR_FPU_UNAVAILABLE))
+
+static inline void kernel_fpu_begin(void)
+{
+	preempt_disable();
+	enable_kernel_fp();
+}
+
+static inline void kernel_fpu_end(void)
+{
+	disable_kernel_fp();
+	preempt_enable();
+}
+
+#endif /* ! _ASM_POWERPC_FPU_H */
-- 
2.42.0


