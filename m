Return-Path: <linux-kernel+bounces-139359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB948A01D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722B41C23353
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B262D1836D7;
	Wed, 10 Apr 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="PA2t/VkV"
Received: from ma-mailsvcp-mx-lapp03.apple.com (ma-mailsvcp-mx-lapp03.apple.com [17.32.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7515AAD6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.32.222.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783851; cv=none; b=XH6nRiUyW45aFS6mEyvYiGF5PLzKaqv7UjXYp83xBIezuMP1wshyYTPnlflbyH2HU/Bdr2X59y2maTfDqq1ZHdOjh7iso4qbFHUJQZl7tXc0Dl59Zx1yAxAPhTwRzL4KwVunssB2D7jjhMsFx7eUtXr770MHJws4+AnFCnfCOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783851; c=relaxed/simple;
	bh=vYHuIWRn7bUVvMhmCLOeig2A4IFV4Kk+rNUf26YkI80=;
	h=MIME-version:Content-type:From:To:Cc:Subject:Date:Message-id:
	 In-reply-to:References; b=Mr0BfXHy3EIHQgbueVcOQffzFXh8FxSHqagfMoZEUH9c0r7hQRa+UFGml07ldu3xIDKwHadEMRDhtjIvb8mi8o1MIW/vu/mEwCvzSQ0TJ3fx6xLeGqzUnrAVV06OxOaSkqxYxRzKH3yb8jR3CNEi5qsusLWO79ckEUN6vcMcRDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=PA2t/VkV; arc=none smtp.client-ip=17.32.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Received: from rn-mailsvcp-mta-lapp02.rno.apple.com
 (rn-mailsvcp-mta-lapp02.rno.apple.com [10.225.203.150])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SBQ0098JWH2QO30@ma-mailsvcp-mx-lapp03.apple.com> for
 linux-kernel@vger.kernel.org; Wed, 10 Apr 2024 14:17:29 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=mime-version : content-transfer-encoding : content-type : from : to : cc :
 subject : date : message-id : in-reply-to : references; s=20180706;
 bh=G9jQUdD7//iJtAa3FmKyScYKKpXXABg16KVWFOcjrN0=;
 b=PA2t/VkVuuJbRIW4HpVcWdkgWHEOa4HpktwV8eCahKb3A/mn7EsjTY3YJezYxeLJG6rE
 ppml5OXRrObtimYIImR1DXf6SyyBUr2T39y5s/rkLJ1jqguJVTM9bt9725GJv80TW3OW
 35oIeHPVgal2Si2wPboCxpk9jYguwU13XBB7DZP+E6CLjvXFPAiSwi+9/fCaq82IcLjG
 /z/sz4cM8rE9zkR/pDvUiim3w3x8ZT5GpJ4h0NCkucqeubhKYF8//zoDjf/ZuqVc1c2+
 cWaia9dsD0GJpht7quuNtjk4mh2X+S+DVWIHIjWOuPke+RGAD4BwsT9ZIs8FeGx7k0Pg kw==
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp02.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SBQ010GJWH10WF0@rn-mailsvcp-mta-lapp02.rno.apple.com>;
 Wed, 10 Apr 2024 14:17:26 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SBQ00E00WFDM000@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 10 Apr 2024 14:17:25 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 062083411fbdfe5b9668648d0dddd4c2
X-Va-E-CD: 80e10fab8d6a64bd923ac65d9b1dcb25
X-Va-R-CD: e95ffb981bb941f6bb1ef4b98a1da371
X-Va-ID: 05cd24ae-872c-43b5-88c5-32a38de55b14
X-Va-CD: 0
X-V-A:
X-V-T-CD: 062083411fbdfe5b9668648d0dddd4c2
X-V-E-CD: 80e10fab8d6a64bd923ac65d9b1dcb25
X-V-R-CD: e95ffb981bb941f6bb1ef4b98a1da371
X-V-ID: afe264df-f93d-4142-ba4f-102893a7e028
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_06,2024-04-09_01,2023-05-22_02
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset=UTF-8
Received: from mr41p01nt-relayp01.apple.com ([17.115.0.54])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0SBQ00HCRWGK4E00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Wed,
 10 Apr 2024 14:17:21 -0700 (PDT)
From: Zayd Qumsieh <zayd_qumsieh@apple.com>
To: zayd_qumsieh@apple.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>,
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>,
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>,
 Baoquan He <bhe@redhat.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>,
 Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/3] tso: aarch64: allow linux kernel to read/write ACTLR.TSOEN
Date: Wed, 10 Apr 2024 14:16:39 -0700
Message-id: <20240410211652.16640-2-zayd_qumsieh@apple.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-reply-to: <20240410211652.16640-1-zayd_qumsieh@apple.com>
References: <20240410211652.16640-1-zayd_qumsieh@apple.com>

Create a couple simplistic functions that can read / modify the
ACTLR.TSOEN bit on Apple Silicon. Setting this bit to 1 will change
the CPU's memory model to x86-64's TSO memory model. Clearing it will
set the CPU's memory model to the standard ARM64 memory model.

Signed-off-by: Zayd Qumsieh <zayd_qumsieh@apple.com>
---
 arch/arm64/Kconfig              | 13 +++++++++
 arch/arm64/include/asm/sysreg.h |  7 +++++
 arch/arm64/include/asm/tso.h    | 17 +++++++++++
 arch/arm64/kernel/Makefile      |  2 +-
 arch/arm64/kernel/tso.c         | 52 +++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/tso.h
 create mode 100644 arch/arm64/kernel/tso.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..35162e5a0705 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+# Copyright © 2024 Apple Inc. All rights reserved.
 config ARM64
 	def_bool y
 	select ACPI_APMT if ACPI
@@ -2079,6 +2080,18 @@ config ARM64_MTE
 
 	  Documentation/arch/arm64/memory-tagging-extension.rst.
 
+config ARM64_TSO
+	bool "ARM64 Apple Silicon TSO support"
+	default y
+	help
+	  Apple Silicon TSO mode allows the CPU's memory model to be
+	  dynamically switched between the default ARM64 memory model
+	  and x86_64's memory model (TSO).
+
+	  Selecting this option allows the feature to be detected at
+	  runtime. If the CPU doesn't implement TSO mode, then this
+	  feature will be disabled.
+
 endmenu # "ARMv8.5 architectural features"
 
 menu "ARMv8.7 architectural features"
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9e8999592f3a..5464217c6bfd 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -4,6 +4,8 @@
  *
  * Copyright (C) 2014 ARM Ltd.
  * Author: Catalin Marinas <catalin.marinas@arm.com>
+ *
+ * Copyright © 2024 Apple Inc. All rights reserved.
  */
 
 #ifndef __ASM_SYSREG_H
@@ -277,6 +279,9 @@
 #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
 
 #define SYS_ACTLR_EL1			sys_reg(3, 0, 1, 0, 1)
+#define SYS_ACTLR_EL1_TSOEN_SHIFT       1
+#define SYS_ACTLR_EL1_TSOEN_MASK        (1 << SYS_ACTLR_EL1_TSOEN_SHIFT)
+
 #define SYS_RGSR_EL1			sys_reg(3, 0, 1, 0, 5)
 #define SYS_GCR_EL1			sys_reg(3, 0, 1, 0, 6)
 
@@ -394,6 +399,8 @@
 #define SYS_CNTKCTL_EL1			sys_reg(3, 0, 14, 1, 0)
 
 #define SYS_AIDR_EL1			sys_reg(3, 1, 0, 0, 7)
+#define SYS_AIDR_EL1_TSO_SHIFT          9
+#define SYS_AIDR_EL1_TSO_MASK           (1 << SYS_AIDR_EL1_TSO_SHIFT)
 
 #define SYS_RNDR_EL0			sys_reg(3, 3, 2, 4, 0)
 #define SYS_RNDRRS_EL0			sys_reg(3, 3, 2, 4, 1)
diff --git a/arch/arm64/include/asm/tso.h b/arch/arm64/include/asm/tso.h
new file mode 100644
index 000000000000..d9e1a7602c44
--- /dev/null
+++ b/arch/arm64/include/asm/tso.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright © 2024 Apple Inc. All rights reserved.
+ */
+
+#ifndef __ASM_TSO_H
+#define __ASM_TSO_H
+
+#ifdef CONFIG_ARM64_TSO
+
+#include <linux/sched.h>
+#include <linux/types.h>
+
+int modify_tso_enable(bool tso_enable);
+
+#endif /* CONFIG_ARM64_TSO */
+#endif /* __ASM_TSO_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 763824963ed1..a2a7c74fb00d 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -33,7 +33,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   return_address.o cpuinfo.o cpu_errata.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
-			   syscall.o proton-pack.o idle.o patching.o pi/
+			   syscall.o proton-pack.o idle.o patching.o tso.o pi/ \
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/tso.c b/arch/arm64/kernel/tso.c
new file mode 100644
index 000000000000..b3964db7aa66
--- /dev/null
+++ b/arch/arm64/kernel/tso.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2024 Apple Inc. All rights reserved.
+ */
+
+#include <linux/types.h>
+
+#include <asm/cputype.h>
+#include <asm/processor.h>
+#include <asm/sysreg.h>
+#include <asm/tso.h>
+
+#ifdef CONFIG_ARM64_TSO
+
+static bool tso_supported(void)
+{
+	unsigned int cpuid_implementor = read_cpuid_implementor();
+	u64 aidr = read_sysreg(aidr_el1);
+
+	return (cpuid_implementor == ARM_CPU_IMP_APPLE) &&
+		(aidr & SYS_AIDR_EL1_TSO_MASK);
+}
+
+static int tso_enabled(void)
+{
+	if (!tso_supported())
+		return -EOPNOTSUPP;
+
+	u64 actlr_el1 = read_sysreg(actlr_el1);
+
+	return !!(actlr_el1 & SYS_ACTLR_EL1_TSOEN_MASK);
+}
+
+int modify_tso_enable(bool tso_enable)
+{
+	if (!tso_supported())
+		return -EOPNOTSUPP;
+
+	u64 actlr_el1_old = read_sysreg(actlr_el1);
+	u64 actlr_el1_new =
+		(actlr_el1_old & ~SYS_ACTLR_EL1_TSOEN_MASK) |
+		(tso_enable << SYS_ACTLR_EL1_TSOEN_SHIFT);
+
+	write_sysreg(actlr_el1_new, actlr_el1);
+
+	if (tso_enabled() != tso_enable)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+#endif /* CONFIG_ARM64_TSO */
-- 
2.39.3 (Apple Git-146)


