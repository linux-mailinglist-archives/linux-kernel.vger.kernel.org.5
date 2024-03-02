Return-Path: <linux-kernel+bounces-89299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1E886EDF1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40ADBB2449E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C60312E56;
	Sat,  2 Mar 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AuLh5pEA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4452811717
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709343949; cv=none; b=Fh3GUNSU1U5M9mQMJyTJ1RqnGI4org1P2nfiH6K2HfdF2mdu0RvWfNpEtdderzk6WQ9CHKBPmvfn89Zt8JkWMuhpP+/AUqx0kaKdI5nrVynXUnreYtgzbc5Mym+ZtF1Oklz819LSMHe+bHPBi5Znl7enpk4esf554H3vtnsnqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709343949; c=relaxed/simple;
	bh=ehRyG26oucn1ovQh8rKwT5tcwjcYYD6506Zz4CQdLg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tu+7d6mTfZMsJxb8dDXIzeEyBxTZu8Y6EvwPKsMT3tdx5WHLESor07r0bosha5oG4WSd3fJNOnDTHEqCi2UJOoFkJOZJ/euQHLI9Dg0sHqEIxSdreRSxOdgrfNBxonwRgosdhl+AtvtW6XJ83nUtPHUv5UIqmyb0ZABXzQDJ1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AuLh5pEA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcd6a3da83so20695665ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709343946; x=1709948746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=559sKojVnuOwSWDYhc8RTDphfpbI9INqfdKUkTLytU4=;
        b=AuLh5pEAaOY/pFBautWeudd8XjmNmTLrOagqlBANskfpnvrBKIelAxMMG+SWE40TDe
         L268RKSiFlM700Z50Tso5YGS5G2KoXT+tQiHw8ks2VyNb2ncSjV4vXbP2fFfkE3h1RHH
         KxP2iTPijv0XO/tDbrNK9XX+v40uKlwVhyuUpcwfkKLs41a5a2PGhns8dgRF9sKc9Z00
         NbndmFgGE17o5LdIVS3SDW2Awrl4ukqYBooJpnBkRPemo+Lvt0rhXaAHnaf1tkeHNH2V
         omf1o5YlhG2OhNwcADKn0lGq+lY3PNRThPg5WS+BdwsTGd6Pebs8oPq1CtHMPrL8Ma4O
         Ktkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709343946; x=1709948746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=559sKojVnuOwSWDYhc8RTDphfpbI9INqfdKUkTLytU4=;
        b=ZCL378ZwIdca3AsW/FL/Pv8eJhvgdevB3pF+Is3SLkqNL2vTNHWhgvALUWC2qHSOmM
         ZmU3jh0iGHM/iBr4n7CkirXDukq/Lcc5hD3b8gYsZzl1QBRWPmE0m6X1AD2nNEaPHnGN
         PiAbVOfh9O+o9bu8W/LpLOZa/kKAfffyMWyOyoZ4xP2sNyZDp9CTDYe2kEy4OszqTOkF
         BSZN4a53XsLVI/UGzRYJxMkwAkPG3DG1Beu9n25K02ctBtayvmR15M7LP8OtLvQ/UHa9
         8oRD0aE777PsolbUiaz3TdJTHISvalZf5UUr+JBvtHvRiUYNVSmNaRSCBi/g9IIE95S1
         Pdog==
X-Forwarded-Encrypted: i=1; AJvYcCXI64SrgO0zMddqhcCvqSUcHcRmyI9y3rhodyb7t2Po1mrCKrfA1evyyDglkSx7Rn/etVYXhwDwpJGiSaUKuOZJ/JJnyYH8PI6NxOXa
X-Gm-Message-State: AOJu0Yw6jVGSj0e2raYFR1hRBwGOBAGdOp7lrH0eqJRPUvV013R2mfLW
	W8uhGwEuV4eAffTM9PKy4VbCPGJKKUTKs/INmAaP4gNVvCtnv7bRrnQa08yo2N1+baAjU7U+6nr
	p
X-Google-Smtp-Source: AGHT+IHkeeNDKASqKCFWKPcxxx0ceTz8eshdE31HG5PvTq7zkOO+xglud9UHs0LZWnefKOa7kM00pw==
X-Received: by 2002:a17:902:ee85:b0:1dc:6b72:6467 with SMTP id a5-20020a170902ee8500b001dc6b726467mr3720552pld.38.1709343945829;
        Fri, 01 Mar 2024 17:45:45 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001d71729ec9csm4129039plj.188.2024.03.01.17.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:45:45 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 01 Mar 2024 17:45:35 -0800
Subject: [PATCH v6 4/4] riscv: Set unaligned access speed at compile time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-disable_misaligned_probe_config-v6-4-612ebd69f430@rivosinc.com>
References: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
In-Reply-To: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709343937; l=25936;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ehRyG26oucn1ovQh8rKwT5tcwjcYYD6506Zz4CQdLg8=;
 b=TS+KRxnINTELtdnFfgWPlT5jCmHLEQ0O8nEfbhYhwJsFc6gHI+5Ar96mgTDcJvt0TKoNDAhF9
 ZdXg6vBlt2GBkssU/WP/b4b5CUJq1To9oh9mE2a6X50ZPs5MELbziIr
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Introduce Kconfig options to set the kernel unaligned access support.
These options provide a non-portable alternative to the runtime
unaligned access probe.

To support this, the unaligned access probing code is moved into it's
own file and gated behind a new RISCV_PROBE_UNALIGNED_ACCESS_SUPPORT
option.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig                         |  58 ++++--
 arch/riscv/include/asm/cpufeature.h        |  26 +--
 arch/riscv/kernel/Makefile                 |   4 +-
 arch/riscv/kernel/cpufeature.c             | 272 ----------------------------
 arch/riscv/kernel/sys_hwprobe.c            |  21 +++
 arch/riscv/kernel/traps_misaligned.c       |   2 +
 arch/riscv/kernel/unaligned_access_speed.c | 282 +++++++++++++++++++++++++++++
 7 files changed, 369 insertions(+), 296 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..60b6de35599d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -688,27 +688,61 @@ config THREAD_SIZE_ORDER
 	  affects irq stack size, which is equal to thread stack size.
 
 config RISCV_MISALIGNED
-	bool "Support misaligned load/store traps for kernel and userspace"
+	bool
 	select SYSCTL_ARCH_UNALIGN_ALLOW
-	default y
 	help
-	  Say Y here if you want the kernel to embed support for misaligned
-	  load/store for both kernel and userspace. When disable, misaligned
-	  accesses will generate SIGBUS in userspace and panic in kernel.
+	  Embed support for misaligned load/store for both kernel and userspace.
+	  When disabled, misaligned accesses will generate SIGBUS in userspace
+	  and panic in kernel.
+
+choice
+	prompt "Unaligned Accesses Support"
+	default RISCV_PROBE_UNALIGNED_ACCESS
+	help
+	  This selects the hardware support for unaligned accesses. This
+	  information is used by the kernel to perform optimizations. It is also
+	  exposed to user space via the hwprobe syscall. The hardware will be
+	  probed at boot by default.
+
+config RISCV_PROBE_UNALIGNED_ACCESS
+	bool "Probe for hardware unaligned access support"
+	select RISCV_MISALIGNED
+	help
+	  During boot, the kernel will run a series of tests to determine the
+	  speed of unaligned accesses. This probing will dynamically determine
+	  the speed of unaligned accesses on the boot hardware. The kernel will
+	  also check if unaligned memory accesses will trap into the kernel and
+	  handle such traps accordingly.
+
+config RISCV_EMULATED_UNALIGNED_ACCESS
+	bool "Assume the system expects emulated unaligned memory accesses"
+	select RISCV_MISALIGNED
+	help
+	  Assume that the system expects unaligned memory accesses to be
+	  emulated. The kernel will check if unaligned memory accesses will
+	  trap into the kernel and handle such traps accordingly.
+
+config RISCV_SLOW_UNALIGNED_ACCESS
+	bool "Assume the system supports slow unaligned memory accesses"
+	depends on NONPORTABLE
+	help
+	  Assume that the system supports slow unaligned memory accesses. The
+	  kernel may not be able to run at all on systems that do not support
+	  unaligned memory accesses.
 
 config RISCV_EFFICIENT_UNALIGNED_ACCESS
-	bool "Assume the CPU supports fast unaligned memory accesses"
+	bool "Assume the system supports fast unaligned memory accesses"
 	depends on NONPORTABLE
 	select DCACHE_WORD_ACCESS if MMU
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	help
-	  Say Y here if you want the kernel to assume that the CPU supports
-	  efficient unaligned memory accesses.  When enabled, this option
-	  improves the performance of the kernel on such CPUs.  However, the
-	  kernel will run much more slowly, or will not be able to run at all,
-	  on CPUs that do not support efficient unaligned memory accesses.
+	  Assume that the system supports fast unaligned memory accesses. When
+	  enabled, this option improves the performance of the kernel on such
+	  systems.  However, the kernel will run much more slowly, or will not
+	  be able to run at all, on systems that do not support efficient
+	  unaligned memory accesses.
 
-	  If unsure what to do here, say N.
+endchoice
 
 endmenu # "Platform type"
 
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 6fec91845aa0..357972cd8f82 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -28,37 +28,41 @@ struct riscv_isainfo {
 
 DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
-DECLARE_PER_CPU(long, misaligned_access_speed);
-
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 void riscv_user_isa_enable(void);
 
-#ifdef CONFIG_RISCV_MISALIGNED
-bool unaligned_ctl_available(void);
+#if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
 void unaligned_emulation_finish(void);
+bool unaligned_ctl_available(void);
+DECLARE_PER_CPU(long, misaligned_access_speed);
 #else
 static inline bool unaligned_ctl_available(void)
 {
 	return false;
 }
-
-static inline bool check_unaligned_access_emulated(int cpu)
-{
-	return false;
-}
-
-static inline void unaligned_emulation_finish(void) {}
 #endif
 
+#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
 DECLARE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
 
 static __always_inline bool has_fast_unaligned_accesses(void)
 {
 	return static_branch_likely(&fast_unaligned_access_speed_key);
 }
+#elif defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+static __always_inline bool has_fast_unaligned_accesses(void)
+{
+	return true;
+}
+#else
+static __always_inline bool has_fast_unaligned_accesses(void)
+{
+	return false;
+}
+#endif
 
 unsigned long riscv_get_elf_hwcap(void);
 
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index f71910718053..c8085126a6f9 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -38,7 +38,6 @@ extra-y += vmlinux.lds
 obj-y	+= head.o
 obj-y	+= soc.o
 obj-$(CONFIG_RISCV_ALTERNATIVE) += alternative.o
-obj-y	+= copy-unaligned.o
 obj-y	+= cpu.o
 obj-y	+= cpufeature.o
 obj-y	+= entry.o
@@ -62,6 +61,9 @@ obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
+obj-$(CONFIG_RISCV_MISALIGNED)	+= unaligned_access_speed.o
+obj-$(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)	+= copy-unaligned.o
+
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index abb3a2f53106..319670af5704 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -11,7 +11,6 @@
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/ctype.h>
-#include <linux/jump_label.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
 #include <linux/module.h>
@@ -21,20 +20,12 @@
 #include <asm/cacheflush.h>
 #include <asm/cpufeature.h>
 #include <asm/hwcap.h>
-#include <asm/hwprobe.h>
 #include <asm/patch.h>
 #include <asm/processor.h>
 #include <asm/vector.h>
 
-#include "copy-unaligned.h"
-
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
-#define MISALIGNED_ACCESS_JIFFIES_LG2 1
-#define MISALIGNED_BUFFER_SIZE 0x4000
-#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
-#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
-
 unsigned long elf_hwcap __read_mostly;
 
 /* Host ISA bitmap */
@@ -43,11 +34,6 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
-/* Performance information */
-DEFINE_PER_CPU(long, misaligned_access_speed);
-
-static cpumask_t fast_misaligned_access;
-
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -706,264 +692,6 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
-static int check_unaligned_access(void *param)
-{
-	int cpu = smp_processor_id();
-	u64 start_cycles, end_cycles;
-	u64 word_cycles;
-	u64 byte_cycles;
-	int ratio;
-	unsigned long start_jiffies, now;
-	struct page *page = param;
-	void *dst;
-	void *src;
-	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
-
-	if (IS_ENABLED(CONFIG_RISCV_MISALIGNED) &&
-	    per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
-		return 0;
-
-	/* Make an unaligned destination buffer. */
-	dst = (void *)((unsigned long)page_address(page) | 0x1);
-	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
-	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
-	src += 2;
-	word_cycles = -1ULL;
-	/* Do a warmup. */
-	__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-	preempt_disable();
-	start_jiffies = jiffies;
-	while ((now = jiffies) == start_jiffies)
-		cpu_relax();
-
-	/*
-	 * For a fixed amount of time, repeatedly try the function, and take
-	 * the best time in cycles as the measurement.
-	 */
-	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
-		start_cycles = get_cycles64();
-		/* Ensure the CSR read can't reorder WRT to the copy. */
-		mb();
-		__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-		/* Ensure the copy ends before the end time is snapped. */
-		mb();
-		end_cycles = get_cycles64();
-		if ((end_cycles - start_cycles) < word_cycles)
-			word_cycles = end_cycles - start_cycles;
-	}
-
-	byte_cycles = -1ULL;
-	__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-	start_jiffies = jiffies;
-	while ((now = jiffies) == start_jiffies)
-		cpu_relax();
-
-	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
-		start_cycles = get_cycles64();
-		mb();
-		__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
-		mb();
-		end_cycles = get_cycles64();
-		if ((end_cycles - start_cycles) < byte_cycles)
-			byte_cycles = end_cycles - start_cycles;
-	}
-
-	preempt_enable();
-
-	/* Don't divide by zero. */
-	if (!word_cycles || !byte_cycles) {
-		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
-			cpu);
-
-		return 0;
-	}
-
-	if (word_cycles < byte_cycles)
-		speed = RISCV_HWPROBE_MISALIGNED_FAST;
-
-	ratio = div_u64((byte_cycles * 100), word_cycles);
-	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
-		cpu,
-		ratio / 100,
-		ratio % 100,
-		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
-
-	per_cpu(misaligned_access_speed, cpu) = speed;
-
-	/*
-	 * Set the value of fast_misaligned_access of a CPU. These operations
-	 * are atomic to avoid race conditions.
-	 */
-	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
-		cpumask_set_cpu(cpu, &fast_misaligned_access);
-	else
-		cpumask_clear_cpu(cpu, &fast_misaligned_access);
-
-	return 0;
-}
-
-static void check_unaligned_access_nonboot_cpu(void *param)
-{
-	unsigned int cpu = smp_processor_id();
-	struct page **pages = param;
-
-	if (smp_processor_id() != 0)
-		check_unaligned_access(pages[cpu]);
-}
-
-DEFINE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
-
-static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
-{
-	if (cpumask_weight(mask) == weight)
-		static_branch_enable_cpuslocked(&fast_unaligned_access_speed_key);
-	else
-		static_branch_disable_cpuslocked(&fast_unaligned_access_speed_key);
-}
-
-static void set_unaligned_access_static_branches_except_cpu(int cpu)
-{
-	/*
-	 * Same as set_unaligned_access_static_branches, except excludes the
-	 * given CPU from the result. When a CPU is hotplugged into an offline
-	 * state, this function is called before the CPU is set to offline in
-	 * the cpumask, and thus the CPU needs to be explicitly excluded.
-	 */
-
-	cpumask_t fast_except_me;
-
-	cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
-	cpumask_clear_cpu(cpu, &fast_except_me);
-
-	modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
-}
-
-static void set_unaligned_access_static_branches(void)
-{
-	/*
-	 * This will be called after check_unaligned_access_all_cpus so the
-	 * result of unaligned access speed for all CPUs will be available.
-	 *
-	 * To avoid the number of online cpus changing between reading
-	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
-	 * held before calling this function.
-	 */
-
-	cpumask_t fast_and_online;
-
-	cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
-
-	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
-}
-
-static int lock_and_set_unaligned_access_static_branch(void)
-{
-	cpus_read_lock();
-	set_unaligned_access_static_branches();
-	cpus_read_unlock();
-
-	return 0;
-}
-
-arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
-
-static int riscv_online_cpu(unsigned int cpu)
-{
-	static struct page *buf;
-
-	/* We are already set since the last check */
-	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
-		goto exit;
-
-	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
-	if (!buf) {
-		pr_warn("Allocation failure, not measuring misaligned performance\n");
-		return -ENOMEM;
-	}
-
-	check_unaligned_access(buf);
-	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
-
-exit:
-	set_unaligned_access_static_branches();
-
-	return 0;
-}
-
-static int riscv_offline_cpu(unsigned int cpu)
-{
-	set_unaligned_access_static_branches_except_cpu(cpu);
-
-	return 0;
-}
-
-/* Measure unaligned access speed on all CPUs present at boot in parallel. */
-static int check_unaligned_access_speed_all_cpus(void)
-{
-	unsigned int cpu;
-	unsigned int cpu_count = num_possible_cpus();
-	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
-				     GFP_KERNEL);
-
-	if (!bufs) {
-		pr_warn("Allocation failure, not measuring misaligned performance\n");
-		return 0;
-	}
-
-	/*
-	 * Allocate separate buffers for each CPU so there's no fighting over
-	 * cache lines.
-	 */
-	for_each_cpu(cpu, cpu_online_mask) {
-		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
-		if (!bufs[cpu]) {
-			pr_warn("Allocation failure, not measuring misaligned performance\n");
-			goto out;
-		}
-	}
-
-	/* Check everybody except 0, who stays behind to tend jiffies. */
-	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
-
-	/* Check core 0. */
-	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
-
-	/*
-	 * Setup hotplug callbacks for any new CPUs that come online or go
-	 * offline.
-	 */
-	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
-				  riscv_online_cpu, riscv_offline_cpu);
-
-out:
-	for_each_cpu(cpu, cpu_online_mask) {
-		if (bufs[cpu])
-			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
-	}
-
-	kfree(bufs);
-	return 0;
-}
-
-#ifdef CONFIG_RISCV_MISALIGNED
-static int check_unaligned_access_all_cpus(void)
-{
-	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
-
-	if (!all_cpus_emulated)
-		return check_unaligned_access_speed_all_cpus();
-
-	return 0;
-}
-#else
-static int check_unaligned_access_all_cpus(void)
-{
-	return check_unaligned_access_speed_all_cpus();
-}
-#endif
-
-arch_initcall(check_unaligned_access_all_cpus);
-
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index a7c56b41efd2..dad02f5faec3 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -147,8 +147,10 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
 	return (pair.value & ext);
 }
 
+#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
 static u64 hwprobe_misaligned(const struct cpumask *cpus)
 {
+	return RISCV_HWPROBE_MISALIGNED_FAST;
 	int cpu;
 	u64 perf = -1ULL;
 
@@ -169,6 +171,25 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 
 	return perf;
 }
+#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
+static u64 hwprobe_misaligned(const struct cpumask *cpus)
+{
+	if (unaligned_ctl_available())
+		return RISCV_HWPROBE_MISALIGNED_EMULATED;
+	else
+		return RISCV_HWPROBE_MISALIGNED_SLOW;
+}
+#elif defined(CONFIG_RISCV_SLOW_UNALIGNED_ACCESS)
+static u64 hwprobe_misaligned(const struct cpumask *cpus)
+{
+	return RISCV_HWPROBE_MISALIGNED_SLOW;
+}
+#elif defined(CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS)
+static u64 hwprobe_misaligned(const struct cpumask *cpus)
+{
+	return RISCV_HWPROBE_MISALIGNED_FAST;
+}
+#endif
 
 static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			     const struct cpumask *cpus)
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 1e3cec3f5d93..6153158adcb7 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -413,7 +413,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
+#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
 	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
+#endif
 
 	if (!unaligned_enabled)
 		return -1;
diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel/unaligned_access_speed.c
new file mode 100644
index 000000000000..52264ea4f0bd
--- /dev/null
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Rivos Inc.
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/jump_label.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/types.h>
+#include <asm/cpufeature.h>
+#include <asm/hwprobe.h>
+
+#include "copy-unaligned.h"
+
+#define MISALIGNED_ACCESS_JIFFIES_LG2 1
+#define MISALIGNED_BUFFER_SIZE 0x4000
+#define MISALIGNED_BUFFER_ORDER get_order(MISALIGNED_BUFFER_SIZE)
+#define MISALIGNED_COPY_SIZE ((MISALIGNED_BUFFER_SIZE / 2) - 0x80)
+
+DEFINE_PER_CPU(long, misaligned_access_speed);
+
+#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
+static cpumask_t fast_misaligned_access;
+static int check_unaligned_access(void *param)
+{
+	int cpu = smp_processor_id();
+	u64 start_cycles, end_cycles;
+	u64 word_cycles;
+	u64 byte_cycles;
+	int ratio;
+	unsigned long start_jiffies, now;
+	struct page *page = param;
+	void *dst;
+	void *src;
+	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
+
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+		return 0;
+
+	/* Make an unaligned destination buffer. */
+	dst = (void *)((unsigned long)page_address(page) | 0x1);
+	/* Unalign src as well, but differently (off by 1 + 2 = 3). */
+	src = dst + (MISALIGNED_BUFFER_SIZE / 2);
+	src += 2;
+	word_cycles = -1ULL;
+	/* Do a warmup. */
+	__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+	preempt_disable();
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	/*
+	 * For a fixed amount of time, repeatedly try the function, and take
+	 * the best time in cycles as the measurement.
+	 */
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		/* Ensure the CSR read can't reorder WRT to the copy. */
+		mb();
+		__riscv_copy_words_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		/* Ensure the copy ends before the end time is snapped. */
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < word_cycles)
+			word_cycles = end_cycles - start_cycles;
+	}
+
+	byte_cycles = -1ULL;
+	__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+	start_jiffies = jiffies;
+	while ((now = jiffies) == start_jiffies)
+		cpu_relax();
+
+	while (time_before(jiffies, now + (1 << MISALIGNED_ACCESS_JIFFIES_LG2))) {
+		start_cycles = get_cycles64();
+		mb();
+		__riscv_copy_bytes_unaligned(dst, src, MISALIGNED_COPY_SIZE);
+		mb();
+		end_cycles = get_cycles64();
+		if ((end_cycles - start_cycles) < byte_cycles)
+			byte_cycles = end_cycles - start_cycles;
+	}
+
+	preempt_enable();
+
+	/* Don't divide by zero. */
+	if (!word_cycles || !byte_cycles) {
+		pr_warn("cpu%d: rdtime lacks granularity needed to measure unaligned access speed\n",
+			cpu);
+
+		return 0;
+	}
+
+	if (word_cycles < byte_cycles)
+		speed = RISCV_HWPROBE_MISALIGNED_FAST;
+
+	ratio = div_u64((byte_cycles * 100), word_cycles);
+	pr_info("cpu%d: Ratio of byte access time to unaligned word access is %d.%02d, unaligned accesses are %s\n",
+		cpu,
+		ratio / 100,
+		ratio % 100,
+		(speed == RISCV_HWPROBE_MISALIGNED_FAST) ? "fast" : "slow");
+
+	per_cpu(misaligned_access_speed, cpu) = speed;
+
+	/*
+	 * Set the value of fast_misaligned_access of a CPU. These operations
+	 * are atomic to avoid race conditions.
+	 */
+	if (speed == RISCV_HWPROBE_MISALIGNED_FAST)
+		cpumask_set_cpu(cpu, &fast_misaligned_access);
+	else
+		cpumask_clear_cpu(cpu, &fast_misaligned_access);
+
+	return 0;
+}
+
+static void check_unaligned_access_nonboot_cpu(void *param)
+{
+	unsigned int cpu = smp_processor_id();
+	struct page **pages = param;
+
+	if (smp_processor_id() != 0)
+		check_unaligned_access(pages[cpu]);
+}
+
+DEFINE_STATIC_KEY_FALSE(fast_unaligned_access_speed_key);
+
+static void modify_unaligned_access_branches(cpumask_t *mask, int weight)
+{
+	if (cpumask_weight(mask) == weight)
+		static_branch_enable_cpuslocked(&fast_unaligned_access_speed_key);
+	else
+		static_branch_disable_cpuslocked(&fast_unaligned_access_speed_key);
+}
+
+static void set_unaligned_access_static_branches_except_cpu(int cpu)
+{
+	/*
+	 * Same as set_unaligned_access_static_branches, except excludes the
+	 * given CPU from the result. When a CPU is hotplugged into an offline
+	 * state, this function is called before the CPU is set to offline in
+	 * the cpumask, and thus the CPU needs to be explicitly excluded.
+	 */
+
+	cpumask_t fast_except_me;
+
+	cpumask_and(&fast_except_me, &fast_misaligned_access, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &fast_except_me);
+
+	modify_unaligned_access_branches(&fast_except_me, num_online_cpus() - 1);
+}
+
+static void set_unaligned_access_static_branches(void)
+{
+	/*
+	 * This will be called after check_unaligned_access_all_cpus so the
+	 * result of unaligned access speed for all CPUs will be available.
+	 *
+	 * To avoid the number of online cpus changing between reading
+	 * cpu_online_mask and calling num_online_cpus, cpus_read_lock must be
+	 * held before calling this function.
+	 */
+
+	cpumask_t fast_and_online;
+
+	cpumask_and(&fast_and_online, &fast_misaligned_access, cpu_online_mask);
+
+	modify_unaligned_access_branches(&fast_and_online, num_online_cpus());
+}
+
+static int lock_and_set_unaligned_access_static_branch(void)
+{
+	cpus_read_lock();
+	set_unaligned_access_static_branches();
+	cpus_read_unlock();
+
+	return 0;
+}
+
+arch_initcall_sync(lock_and_set_unaligned_access_static_branch);
+
+static int riscv_online_cpu(unsigned int cpu)
+{
+	static struct page *buf;
+
+	/* We are already set since the last check */
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+		goto exit;
+
+	buf = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+	if (!buf) {
+		pr_warn("Allocation failure, not measuring misaligned performance\n");
+		return -ENOMEM;
+	}
+
+	check_unaligned_access(buf);
+	__free_pages(buf, MISALIGNED_BUFFER_ORDER);
+
+exit:
+	set_unaligned_access_static_branches();
+
+	return 0;
+}
+
+static int riscv_offline_cpu(unsigned int cpu)
+{
+	set_unaligned_access_static_branches_except_cpu(cpu);
+
+	return 0;
+}
+
+/* Measure unaligned access speed on all CPUs present at boot in parallel. */
+static int check_unaligned_access_speed_all_cpus(void)
+{
+	unsigned int cpu;
+	unsigned int cpu_count = num_possible_cpus();
+	struct page **bufs = kzalloc(cpu_count * sizeof(struct page *),
+				     GFP_KERNEL);
+
+	if (!bufs) {
+		pr_warn("Allocation failure, not measuring misaligned performance\n");
+		return 0;
+	}
+
+	/*
+	 * Allocate separate buffers for each CPU so there's no fighting over
+	 * cache lines.
+	 */
+	for_each_cpu(cpu, cpu_online_mask) {
+		bufs[cpu] = alloc_pages(GFP_KERNEL, MISALIGNED_BUFFER_ORDER);
+		if (!bufs[cpu]) {
+			pr_warn("Allocation failure, not measuring misaligned performance\n");
+			goto out;
+		}
+	}
+
+	/* Check everybody except 0, who stays behind to tend jiffies. */
+	on_each_cpu(check_unaligned_access_nonboot_cpu, bufs, 1);
+
+	/* Check core 0. */
+	smp_call_on_cpu(0, check_unaligned_access, bufs[0], true);
+
+	/*
+	 * Setup hotplug callbacks for any new CPUs that come online or go
+	 * offline.
+	 */
+	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "riscv:online",
+				  riscv_online_cpu, riscv_offline_cpu);
+
+out:
+	for_each_cpu(cpu, cpu_online_mask) {
+		if (bufs[cpu])
+			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
+	}
+
+	kfree(bufs);
+	return 0;
+}
+
+static int check_unaligned_access_all_cpus(void)
+{
+	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
+
+	if (!all_cpus_emulated)
+		return check_unaligned_access_speed_all_cpus();
+
+	return 0;
+}
+#else /* CONFIG_RISCV_PROBE_UNALIGNED_ACCESS */
+static int check_unaligned_access_all_cpus(void)
+{
+	check_unaligned_access_emulated_all_cpus();
+
+	return 0;
+}
+#endif
+
+arch_initcall(check_unaligned_access_all_cpus);

-- 
2.43.2


