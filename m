Return-Path: <linux-kernel+bounces-89298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A086EDF0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA6F1F22373
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8322A11725;
	Sat,  2 Mar 2024 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hejeb6Bu"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42955B65E
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709343946; cv=none; b=NwhHih0dUK+Ef3gCmCqBIo4gdGJFpSXyW54Ar1GUGVN71D9dDbtAkDg3XDGw3tmgcUvn+r0c2fnFyY+3jgBSmRoeoC/1K0TOYEDzUP1aaDXRY39l2S2Gw77al5Kxo3qskrw+XJpOz7O7heLODgfyhYc/xF3m+Eyov1W4GyzB/1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709343946; c=relaxed/simple;
	bh=YiWDyhZlyEbMfbqz0FsXl9yfSIL66FQp7h5UIvYeHJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRUm4F5/wCpBNkqxH2ozhozWwhhL22/zgvWII2XYSsaI8doV7j2R2vSgxyPKgOVOVN8quG/TFMTskES8cEdDHLwP+xML5czYoswx4SHgGsos4s3ZQt2shnoskEaskywMzB6wWZNEqN2mgF8HGP1BIGQ5tkKQnbu5KokWI+r+3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hejeb6Bu; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b276979aso2054435a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709343944; x=1709948744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3Qfvs3PS/SqaY35b4e9kYVL30tzyoJAgDQ9SsWZHOI=;
        b=hejeb6BuPgkStXMXukbkPY1DHTGFo5s7MKouOQdb4Qn0OMvr/Lu3xvRooStKbU4wSE
         sJrdQcNblcS/xIX+E6WufGU5JrS3G9vc2FsKFOgzbnLQYW5RABUSvI2NoH2ZqG60+PdD
         H2VeoMq74d24O+nUDbRsDY21UR40OmlZp7bH6MoQ5RSJOB3STj0XxMleMRakaMvse7Rs
         8Ek45b7m8GBAoPYjSln7Dzidi2q02xOcAHpP96qdzRE4dTS7vuvkECs5VIoonCjDO8X6
         GNfGWHvL2qlOtDvu37I0uzZNPvJEOyxs7rp9ef1+jkotg+IJvopUBRbn/wmrixAbiI1a
         +46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709343944; x=1709948744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3Qfvs3PS/SqaY35b4e9kYVL30tzyoJAgDQ9SsWZHOI=;
        b=nOsze59Bp+xK1GVxnI6kCv19a4ZWmjGwyf9LbUxeChPzl4I+2RJmm8VbdeoPxeeYy1
         qesBxnHlbLHiLNQCQMdmrw2O5p1wnaiKwrum0sknYcpD/VK36bF0EroqPU2Fy8HQ1qMQ
         dIKq0ZPTnJcI8JKPlAdq/wt81nquu0+hCCVX1GXn4p6+rvwPSEE9n+L4bzBuaUUBWe0v
         u+9PbdmqhK1rkClR2/8OautVLYpHY5hAQa6vOKKwcgtvAXiaNbmbWV+DxikLw6A/uokO
         HNu77j+2weL1YBezYpuOaWJ+WxP2VxwEzcVUI4vIjTnGL/sSq5yIW9mS6cUOJSJFUPnu
         KDRg==
X-Forwarded-Encrypted: i=1; AJvYcCVF+0cPzx0HDDNi2CwHXB3kdOxCROztk4FnXPZ/ou6N456AuNuckR8ql44Ca1w5B6W2HzqQO7bX9aESWzGFHpi01QtmK0DZpmMZvgtE
X-Gm-Message-State: AOJu0YyDFGQzwA23AaO8CVbpoO3hmJy2SDqvDfeOCPGoPO3Wyt4g5I8D
	XUpWBRq0zFaY/nhaWRJQwXPeRhku5OrwHEvVNHXw07O62+LPvCChvKgqnfn3I/2gnUTj6OVP9hb
	L
X-Google-Smtp-Source: AGHT+IEs+Cr6aC23Fswwh3ZFwN8l50fRomu8sFf+KE5jvSmniBN5OXcfGMAgT+IVT61A2SBTamH2BQ==
X-Received: by 2002:a17:903:595:b0:1db:4746:5fdd with SMTP id jv21-20020a170903059500b001db47465fddmr2542481plb.43.1709343944235;
        Fri, 01 Mar 2024 17:45:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001d71729ec9csm4129039plj.188.2024.03.01.17.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:45:43 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 01 Mar 2024 17:45:34 -0800
Subject: [PATCH v6 3/4] riscv: Decouple emulated unaligned accesses from
 access speed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-disable_misaligned_probe_config-v6-3-612ebd69f430@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709343937; l=4205;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=YiWDyhZlyEbMfbqz0FsXl9yfSIL66FQp7h5UIvYeHJo=;
 b=M1VlqbLcYcq1VPmyWChr6/UcHm055g1J1jbZi0Ing9Lqe/dnK3npq+QdKEdNeIF7NX4qlMNrp
 wXdgqrbwSSlALqlnlscL6GXP8VeQb/WoJS8UcYhTBJnToIP2yy3U6iH
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Detecting if a system traps into the kernel on an unaligned access
can be performed separately from checking the speed of unaligned
accesses. This decoupling will make it possible to selectively enable
or disable each of these checks as is done in the following patch.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h  |  2 +-
 arch/riscv/kernel/cpufeature.c       | 25 +++++++++++++++++++++----
 arch/riscv/kernel/traps_misaligned.c | 20 +++++++-------------
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index 466e1f591919..6fec91845aa0 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -37,7 +37,7 @@ void riscv_user_isa_enable(void);
 
 #ifdef CONFIG_RISCV_MISALIGNED
 bool unaligned_ctl_available(void);
-bool check_unaligned_access_emulated(int cpu);
+bool check_unaligned_access_emulated_all_cpus(void);
 void unaligned_emulation_finish(void);
 #else
 static inline bool unaligned_ctl_available(void)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 7878cddccc0d..abb3a2f53106 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -719,7 +719,8 @@ static int check_unaligned_access(void *param)
 	void *src;
 	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
 
-	if (check_unaligned_access_emulated(cpu))
+	if (IS_ENABLED(CONFIG_RISCV_MISALIGNED) &&
+	    per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
 		return 0;
 
 	/* Make an unaligned destination buffer. */
@@ -896,8 +897,8 @@ static int riscv_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-/* Measure unaligned access on all CPUs present at boot in parallel. */
-static int check_unaligned_access_all_cpus(void)
+/* Measure unaligned access speed on all CPUs present at boot in parallel. */
+static int check_unaligned_access_speed_all_cpus(void)
 {
 	unsigned int cpu;
 	unsigned int cpu_count = num_possible_cpus();
@@ -935,7 +936,6 @@ static int check_unaligned_access_all_cpus(void)
 				  riscv_online_cpu, riscv_offline_cpu);
 
 out:
-	unaligned_emulation_finish();
 	for_each_cpu(cpu, cpu_online_mask) {
 		if (bufs[cpu])
 			__free_pages(bufs[cpu], MISALIGNED_BUFFER_ORDER);
@@ -945,6 +945,23 @@ static int check_unaligned_access_all_cpus(void)
 	return 0;
 }
 
+#ifdef CONFIG_RISCV_MISALIGNED
+static int check_unaligned_access_all_cpus(void)
+{
+	bool all_cpus_emulated = check_unaligned_access_emulated_all_cpus();
+
+	if (!all_cpus_emulated)
+		return check_unaligned_access_speed_all_cpus();
+
+	return 0;
+}
+#else
+static int check_unaligned_access_all_cpus(void)
+{
+	return check_unaligned_access_speed_all_cpus();
+}
+#endif
+
 arch_initcall(check_unaligned_access_all_cpus);
 
 void riscv_user_isa_enable(void)
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index c2ed4e689bf9..1e3cec3f5d93 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -596,7 +596,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 	return 0;
 }
 
-bool check_unaligned_access_emulated(int cpu)
+static bool check_unaligned_access_emulated(int cpu)
 {
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
 	unsigned long tmp_var, tmp_val;
@@ -623,22 +623,16 @@ bool check_unaligned_access_emulated(int cpu)
 	return misaligned_emu_detected;
 }
 
-void unaligned_emulation_finish(void)
+bool check_unaligned_access_emulated_all_cpus(void)
 {
 	int cpu;
 
-	/*
-	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
-	 * accesses emulated since tasks requesting such control can run on any
-	 * CPU.
-	 */
-	for_each_online_cpu(cpu) {
-		if (per_cpu(misaligned_access_speed, cpu) !=
-					RISCV_HWPROBE_MISALIGNED_EMULATED) {
-			return;
-		}
-	}
+	for_each_online_cpu(cpu)
+		if (check_unaligned_access_emulated(cpu))
+			return false;
+
 	unaligned_ctl = true;
+	return true;
 }
 
 bool unaligned_ctl_available(void)

-- 
2.43.2


