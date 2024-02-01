Return-Path: <linux-kernel+bounces-47710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166A284518E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800BBB2C535
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E084158D7B;
	Thu,  1 Feb 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="H88Eiw37"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068E1586D5
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706769649; cv=none; b=qDXKkZcomVWPfvXErrq7wU9TB+pnzQ06LxKVU4mQvp7/X4WL7EYRkLWEkEkyHUygcYxgOdfVJvrhp9G4weMLRYra/eSOGYCCa1asdklUcA/oxuBEsGwnGaK75rMfCbwCzhjv5NqfC3TX2DbTKKYYk4+LqTAuyaj+ifhXujmSxOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706769649; c=relaxed/simple;
	bh=wzSLJadpkHjmp9X2BoqvKpkVX4rq2iE3DOomMnQVqdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWRM1Hie+lVlg08hFGES2Mxw7squl6d3P8Xn4IUbi/bflpj90mysHenVW0gxrJ8HNJb+6+Apqg5SSqIuI8VY6fSlui1jFnzmsSSBRbxhxq8MjubvDeqxnxtv2DjitiCNoSqgLVLp5+OGdrDXmPqilWulho5aLbrIb7X7j+8Q9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=H88Eiw37; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bba50cd318so508744b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706769647; x=1707374447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKa7kvpXjsFDP6A15VTktM7IVUcEVRchGZclVVqoNrQ=;
        b=H88Eiw3773xOC7trmqvPF/7voSs4bn5tr8lZBn48rAp+zRN4tUrMpE7ERNUa0ryDgD
         OdHx7UF9NL9RQLqaz9SYrTGxfyeF94x3qtz4areb4tV8ZG4WmXzs1LwGPCC2OSpco1uf
         a48s1JRZ/fNR1ITmEcWOpDuHM+JiaUbo1b9uLBuNO6csGQaJ21q3VOWPuifmXaXQ23TU
         COBJsNIQOGV29/ZzLc0j1PaBl3kJGQxqY7Xft90akGqrDKTVizEp3pc2PwCS5sqGLh9E
         Zs2oBFH9YLyMbaqWwb28tvlKIl6WG1l/WKexENxGNwkHcaxYo096AQ2o1X6jyHXM/g01
         0+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706769647; x=1707374447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKa7kvpXjsFDP6A15VTktM7IVUcEVRchGZclVVqoNrQ=;
        b=oktbu0FDo77RUDQ5MOQnxl0khCCRaRC1LrPpJujHDYE4gfY5k9IIZpLV3eRO8oDng8
         KG3QiKilGHWyYa2rhg2C2uczNWavdI70ftY8zpEevbFY62UmpQJjjClxLfRp/YzVoWcA
         JYGiJpb07NTSe0nOVtUxfbspbs+JkNlfsAaMYzCGg7Fu25Sjzfk37zLIZfsG46VbWPSV
         BzbwBKVSfBPbbz+YNtAVpsrUpcT0av+1P2i/uR5eA5e2+LeaQYBrL8LsYAfTEqHCE38o
         VuK8G99WCtEVMxUCX5vhqg5el6+IG68uezytobQZfQLzXhPIIeY1wRJ/6KOppQrhLo+D
         Bi0Q==
X-Gm-Message-State: AOJu0Yyvsl2aSuSIDWD6ulKArxV+60mdoo0fXL3S3+3JvQTAhNpuNCMQ
	GnbJE+X2pjmix0D9Wfb+MZJG8e/teNKH5L6uvBbitIObPnVcNEH+v0RwW11bSM4=
X-Google-Smtp-Source: AGHT+IF4PEyL+aACVF9FFYS7e1wHd0GV0cED13/y15ZUL2wuwBw24vqCvuBiM7X0g61MtzAFyKhtyA==
X-Received: by 2002:a05:6808:ec2:b0:3bd:db8e:b1d8 with SMTP id q2-20020a0568080ec200b003bddb8eb1d8mr4149440oiv.31.1706769646931;
        Wed, 31 Jan 2024 22:40:46 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id y9-20020aa79e09000000b006ddc7af02c1sm10925764pfq.9.2024.01.31.22.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:40:46 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 31 Jan 2024 22:40:23 -0800
Subject: [PATCH 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-disable_misaligned_probe_config-v1-2-98d155e9cda8@rivosinc.com>
References: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
In-Reply-To: <20240131-disable_misaligned_probe_config-v1-0-98d155e9cda8@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706769643; l=3922;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=wzSLJadpkHjmp9X2BoqvKpkVX4rq2iE3DOomMnQVqdY=;
 b=DTn4IwM4ZIGuqtofPt6Obk2d6Ns8T0POg2dAYgBso9mTIalwSw7BMF2KHtVOxaqOzJGsrbvkF
 /jb1oVOA2joBeZ7x66cEr8DJ1S+QAdH1efsmP1wIb6hgiOKp5c/RKnH
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
set to have fast misaligned access without needing to probe.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h  | 7 +++++++
 arch/riscv/kernel/cpufeature.c       | 4 ++++
 arch/riscv/kernel/sys_hwprobe.c      | 4 ++++
 arch/riscv/kernel/traps_misaligned.c | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index dfdcca229174..7d8d64783e38 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -137,10 +137,17 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
 
 static __always_inline bool has_fast_misaligned_accesses(void)
 {
 	return static_branch_likely(&fast_misaligned_access_speed_key);
 }
+#else
+static __always_inline bool has_fast_misaligned_accesses(void)
+{
+	return true;
+}
+#endif
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89920f84d0a3..d787846c0b68 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -43,10 +43,12 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 /* Performance information */
 DEFINE_PER_CPU(long, misaligned_access_speed);
 
 static cpumask_t fast_misaligned_access;
+#endif
 
 /**
  * riscv_isa_extension_base() - Get base extension word
@@ -706,6 +708,7 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 static int check_unaligned_access(void *param)
 {
 	int cpu = smp_processor_id();
@@ -946,6 +949,7 @@ static int check_unaligned_access_all_cpus(void)
 }
 
 arch_initcall(check_unaligned_access_all_cpus);
+#endif /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
 
 void riscv_user_isa_enable(void)
 {
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index a7c56b41efd2..3f1a6edfdb08 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -149,6 +149,7 @@ static bool hwprobe_ext0_has(const struct cpumask *cpus, unsigned long ext)
 
 static u64 hwprobe_misaligned(const struct cpumask *cpus)
 {
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	int cpu;
 	u64 perf = -1ULL;
 
@@ -168,6 +169,9 @@ static u64 hwprobe_misaligned(const struct cpumask *cpus)
 		return RISCV_HWPROBE_MISALIGNED_UNKNOWN;
 
 	return perf;
+#else
+	return RISCV_HWPROBE_MISALIGNED_FAST;
+#endif
 }
 
 static void hwprobe_one_pair(struct riscv_hwprobe *pair,
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8ded225e8c5b..c24f79d769f6 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -413,7 +413,9 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_EMULATED;
+#endif
 
 	if (!unaligned_enabled)
 		return -1;
@@ -596,6 +598,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 	return 0;
 }
 
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 bool check_unaligned_access_emulated(int cpu)
 {
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
@@ -640,6 +643,7 @@ void unaligned_emulation_finish(void)
 	}
 	unaligned_ctl = true;
 }
+#endif
 
 bool unaligned_ctl_available(void)
 {

-- 
2.43.0


