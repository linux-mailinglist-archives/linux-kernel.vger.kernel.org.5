Return-Path: <linux-kernel+bounces-84184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C547E86A373
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C057FB27BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5968558123;
	Tue, 27 Feb 2024 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GHw4wsZD"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD155E64
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075688; cv=none; b=GQxGzPv1PHwfwyP2FvLXbSPWLn/CjfwRIOqYdRW9pbacyVRqksmCH747OpOIiYbirKM6hACXVKpkBsythzBBUHhP5WaMm90XwKogCAxVH+6cp0vbt+bfWHsWJOweW8HD/2q44iC+NbBmaFSiPkn5I8XZa5d91B+IE2OMZJuMl/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075688; c=relaxed/simple;
	bh=FIKUIM4cKSVyEkUBl0pcvvgptmqYyEYMEJk4xH3+RPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYzV2duIO8LDbQzcSZori/8I6N3U7ip4b/j0o1jWCn5MhHh3wZ4wAKHm7Zu+xAHtK1/0v2VoV6u6n2UKjFjak0smDcYW6NvFyg/hCNNLATrEnwCzAZ+wtcMpR5dGDTH2mlEPZcRddzIDB9/S18WvOXArNTNSTUFpz5H49M1CTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GHw4wsZD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e435542d41so3336535b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709075686; x=1709680486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svCQgcim0qS8HobSqFzLIllKVh8GBVm+yi9TnpsVINE=;
        b=GHw4wsZDbQB5vZMp6bLXcd/heyX78Woi+LvZLmkDobYvsqyd4fW8sZBSZyQ+J7UKTu
         wTtmg8J7N2RZm3zOyLbBnFowx52dbOoS8ryWT/e+WHdXIWEba2W8wHt6tdi7LBmD6Blf
         iWGvew11BCusJxlusLuVavo6GOUxaTM5NgRpoFz/K9gJ1ZcrFZRxafVSFE1u8l8V2GTF
         KfiFZva3YcGbl+HxitF7L21j/fFyY01evSezIFXoTRr6W7yuDSDrzQ+Mzrz3NWipjoMN
         HYe5L+OGEKoELI69mNScnchcDml3M+7CY3DKzMx5A0TsDDSU2/oC05QNQiQtcZo5Iugd
         RZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075686; x=1709680486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svCQgcim0qS8HobSqFzLIllKVh8GBVm+yi9TnpsVINE=;
        b=CLcv1kzwjspG/q8M+Rzsyn7NmFdYSLVrOkGHdonWdeuKEY9btG781yWp9d0sXK/yxc
         mRggoXddk/N0uznnoDntR1HJ6zmg0rNA4xEpiOmeVMGNDLfDxvI5Ymyw5dAXIsWCoxgB
         luMCdi7ob5g1YdyUVqO7J0ikxWbrzkxcFvEviTbCRSzpza5ZLIK63aohuu3EZl/iPrkt
         /ely9CfFQxyBRDY8zsbhFi5i7OMf1ICz7OTNKwtofQxzNStEB1rldeUhg9mf7PjLgKcs
         bJkmBaabkQdn6zrf96LShmxOZ3jhYWkysekVrMGVy30I7GwvgSx/R9l1Kb+z0LdvBEz9
         NLyw==
X-Forwarded-Encrypted: i=1; AJvYcCVnyc/jwBMLEpllbNJbBlhuSmtLTMwbMndfolzXVYlEXczY6hcfMIqPg9dmn5u8Py93+lCWERDEUMI6BJO7k4h5aFyM4zgezmak8XK1
X-Gm-Message-State: AOJu0YwvViF4dycraRagY5yBO11nhAQsaMtSVb4sPGClbPuCD7eKJ7r8
	AFRYLGDQlOAK4OoWV4B47YK+eN0qF7qVXr69ikndJ6K1v/hqz7wh1Ke3tNUpioQ=
X-Google-Smtp-Source: AGHT+IF8IAuQDUd9c3gsSxCKNPV1m9ipFhKdbj4A0pgM+pt1Q9livMnjIjkI8QeyVVPshG5EgxUwnw==
X-Received: by 2002:a05:6a20:d809:b0:1a1:15dd:fb4c with SMTP id iv9-20020a056a20d80900b001a115ddfb4cmr1810635pzb.3.1709075685819;
        Tue, 27 Feb 2024 15:14:45 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id l9-20020a635709000000b005ce998b9391sm5455645pgb.67.2024.02.27.15.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:14:45 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 27 Feb 2024 15:13:14 -0800
Subject: [PATCH v5 2/2] riscv: Set unaligned access speed at compile time
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-disable_misaligned_probe_config-v5-2-b6853846e27a@rivosinc.com>
References: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
In-Reply-To: <20240227-disable_misaligned_probe_config-v5-0-b6853846e27a@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709075681; l=20787;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=FIKUIM4cKSVyEkUBl0pcvvgptmqYyEYMEJk4xH3+RPY=;
 b=1yWTsOOgHZeHEU+K9hy1vH95FbaibOy0r025m5CQdybG2lP5Z+i8mjkcDtBFCVoQ9tKn5BDTF
 mxWdBBjvZqpCMTSNa5CqgAyMB9JitdWDpZpJqjc1l6lzRxogFS3t6r+
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
 arch/riscv/Kconfig                        |  47 +++++-
 arch/riscv/include/asm/cpufeature.h       |  32 +++-
 arch/riscv/kernel/Makefile                |   6 +-
 arch/riscv/kernel/cpufeature.c            | 255 ------------------------------
 arch/riscv/kernel/probe_emulated_access.c |  64 ++++++++
 arch/riscv/kernel/sys_hwprobe.c           |  23 +++
 arch/riscv/kernel/traps_misaligned.c      |  54 +------
 7 files changed, 163 insertions(+), 318 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..ad0a9c1f8802 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -690,25 +690,58 @@ config THREAD_SIZE_ORDER
 config RISCV_MISALIGNED
 	bool "Support misaligned load/store traps for kernel and userspace"
 	select SYSCTL_ARCH_UNALIGN_ALLOW
+	depends on RISCV_PROBE_UNALIGNED_ACCESS || RISCV_EMULATED_UNALIGNED_ACCESS
 	default y
 	help
 	  Say Y here if you want the kernel to embed support for misaligned
 	  load/store for both kernel and userspace. When disable, misaligned
 	  accesses will generate SIGBUS in userspace and panic in kernel.
 
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
+	help
+	  During boot, the kernel will run a series of tests to determine the
+	  speed of unaligned accesses. This probing will dynamically determine
+	  the speed of unaligned accesses on the boot hardware.
+
+config RISCV_EMULATED_UNALIGNED_ACCESS
+	bool "Assume the system expects emulated unaligned memory accesses"
+	help
+	  Assume that the system expects emulated unaligned memory accesses.
+	  When enabled, this option notifies the kernel and userspace that
+	  unaligned memory accesses will be emulated by either the kernel or
+	  firmware.
+
+config RISCV_SLOW_UNALIGNED_ACCESS
+	bool "Assume the system supports slow unaligned memory accesses"
+	depends on NONPORTABLE
+	help
+	  Assume that the system supports slow unaligned memory accesses. The
+	  kernel may not be able to run at all on systems that do not support
+	  unaligned memory accesses.
+
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
index 466e1f591919..cd166b0e52c4 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -28,17 +28,29 @@ struct riscv_isainfo {
 
 DECLARE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
-DECLARE_PER_CPU(long, misaligned_access_speed);
-
 /* Per-cpu ISA extensions. */
 extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 void riscv_user_isa_enable(void);
 
-#ifdef CONFIG_RISCV_MISALIGNED
+#if defined(CONFIG_RISCV_MISALIGNED)
+#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
 bool unaligned_ctl_available(void);
 bool check_unaligned_access_emulated(int cpu);
 void unaligned_emulation_finish(void);
+#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
+static inline bool unaligned_ctl_available(void)
+{
+	return true;
+}
+
+static inline bool check_unaligned_access_emulated(int cpu)
+{
+	return true;
+}
+
+static inline void unaligned_emulation_finish(void) {}
+#endif
 #else
 static inline bool unaligned_ctl_available(void)
 {
@@ -53,12 +65,26 @@ static inline bool check_unaligned_access_emulated(int cpu)
 static inline void unaligned_emulation_finish(void) {}
 #endif
 
+#if defined(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS)
+DECLARE_PER_CPU(long, misaligned_access_speed);
+
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
index f71910718053..3355ef87684a 100644
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
@@ -62,6 +61,11 @@ obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
+ifeq ($(CONFIG_RISCV_PROBE_UNALIGNED_ACCESS), y)
+obj-y	+= copy-unaligned.o
+obj-y	+= unaligned_access_speed.o
+obj-$(CONFIG_RISCV_MISALIGNED)	+= probe_emulated_access.o
+endif
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
 obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 7878cddccc0d..319670af5704 100644
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
@@ -706,247 +692,6 @@ unsigned long riscv_get_elf_hwcap(void)
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
-	if (check_unaligned_access_emulated(cpu))
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
-/* Measure unaligned access on all CPUs present at boot in parallel. */
-static int check_unaligned_access_all_cpus(void)
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
-	unaligned_emulation_finish();
-	for_each_cpu(cpu, cpu_online_mask) {
-		if (bufs[cpu])
-			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
-	}
-
-	kfree(bufs);
-	return 0;
-}
-
-arch_initcall(check_unaligned_access_all_cpus);
-
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))
diff --git a/arch/riscv/kernel/probe_emulated_access.c b/arch/riscv/kernel/probe_emulated_access.c
new file mode 100644
index 000000000000..5f65b31c7558
--- /dev/null
+++ b/arch/riscv/kernel/probe_emulated_access.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Rivos Inc.
+ */
+
+#include <linux/cache.h>
+#include <linux/cpumask.h>
+#include <linux/types.h>
+#include <linux/percpu-defs.h>
+#include <linux/printk.h>
+#include <asm/cpufeature.h>
+#include <asm/hwprobe.h>
+
+static bool unaligned_ctl __read_mostly;
+
+bool check_unaligned_access_emulated(int cpu)
+{
+	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
+	unsigned long tmp_var, tmp_val;
+	bool misaligned_emu_detected;
+
+	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
+
+	__asm__ __volatile__ (
+		"       "REG_L" %[tmp], 1(%[ptr])\n"
+		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
+
+	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
+	/*
+	 * If unaligned_ctl is already set, this means that we detected that all
+	 * CPUS uses emulated misaligned access at boot time. If that changed
+	 * when hotplugging the new cpu, this is something we don't handle.
+	 */
+	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
+		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
+		while (true)
+			cpu_relax();
+	}
+
+	return misaligned_emu_detected;
+}
+
+void unaligned_emulation_finish(void)
+{
+	int cpu;
+
+	/*
+	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
+	 * accesses emulated since tasks requesting such control can run on any
+	 * CPU.
+	 */
+	for_each_present_cpu(cpu) {
+		if (per_cpu(misaligned_access_speed, cpu) !=
+					RISCV_HWPROBE_MISALIGNED_EMULATED) {
+			return;
+		}
+	}
+	unaligned_ctl = true;
+}
+
+bool unaligned_ctl_available(void)
+{
+	return unaligned_ctl;
+}
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index a7c56b41efd2..69df8eaad9e7 100644
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
 
@@ -169,6 +171,27 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 
 	return perf;
 }
+#elif defined(CONFIG_RISCV_EMULATED_UNALIGNED_ACCESS)
+static u64 hwprobe_misaligned(const struct cpumask *cpus)
+{
+	return RISCV_HWPROBE_MISALIGNED_EMULATED;
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
+#elif defined(CONFIG_RISCV_UNSUPPORTED_UNALIGNED_ACCESS)
+static u64 hwprobe_misaligned(const struct cpumask *cpus)
+{
+	return RISCV_HWPROBE_MISALIGNED_UNSUPPORTED;
+}
+#endif
 
 static void hwprobe_one_pair(struct riscv_hwprobe *pair,
 			     const struct cpumask *cpus)
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8ded225e8c5b..ba6763dd9895 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -398,8 +398,6 @@ union reg_data {
 	u64 data_u64;
 };
 
-static bool unaligned_ctl __read_mostly;
-
 /* sysctl hooks */
 int unaligned_enabled __read_mostly = 1;	/* Enabled by default */
 
@@ -413,7 +411,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
+#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
 	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
+#endif
 
 	if (!unaligned_enabled)
 		return -1;
@@ -595,53 +595,3 @@ int handle_misaligned_store(struct pt_regs *regs)
 
 	return 0;
 }
-
-bool check_unaligned_access_emulated(int cpu)
-{
-	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
-	unsigned long tmp_var, tmp_val;
-	bool misaligned_emu_detected;
-
-	*mas_ptr = RISCV_HWPROBE_MISALIGNED_UNKNOWN;
-
-	__asm__ __volatile__ (
-		"       "REG_L" %[tmp], 1(%[ptr])\n"
-		: [tmp] "=r" (tmp_val) : [ptr] "r" (&tmp_var) : "memory");
-
-	misaligned_emu_detected = (*mas_ptr == RISCV_HWPROBE_MISALIGNED_EMULATED);
-	/*
-	 * If unaligned_ctl is already set, this means that we detected that all
-	 * CPUS uses emulated misaligned access at boot time. If that changed
-	 * when hotplugging the new cpu, this is something we don't handle.
-	 */
-	if (unlikely(unaligned_ctl && !misaligned_emu_detected)) {
-		pr_crit("CPU misaligned accesses non homogeneous (expected all emulated)\n");
-		while (true)
-			cpu_relax();
-	}
-
-	return misaligned_emu_detected;
-}
-
-void unaligned_emulation_finish(void)
-{
-	int cpu;
-
-	/*
-	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
-	 * accesses emulated since tasks requesting such control can run on any
-	 * CPU.
-	 */
-	for_each_present_cpu(cpu) {
-		if (per_cpu(misaligned_access_speed, cpu) !=
-					RISCV_HWPROBE_MISALIGNED_EMULATED) {
-			return;
-		}
-	}
-	unaligned_ctl = true;
-}
-
-bool unaligned_ctl_available(void)
-{
-	return unaligned_ctl;
-}

-- 
2.43.2


