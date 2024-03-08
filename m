Return-Path: <linux-kernel+bounces-97454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8300876AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7C02836AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C075A7B1;
	Fri,  8 Mar 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kwcZ02Oy"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA55788F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922366; cv=none; b=dnPr4gowzWemX0HplOO52ryev0ZtnIQP8n0wJKNwzcdH2OvYj05c4sW7NLACbhdQRDMWJkROgIqu+pwPzhxvdp8pyBhzWvb21b58OF7cFakwikVXS/cInF15PQk1LcCyNRjgyZxg9PEQFuDfzr4m4A3yMasOY7+lr4tvkfdaTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922366; c=relaxed/simple;
	bh=IaoDcAIGwiU84s3iFQFa7IKKT21z3ZbSgM4n2pSHuEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXFCelqIGJJs44lNOPtScXtbFPENd0r8DA89NC2UOf4jOQjsp8X8DzGMY93FrM36bFnLfuZX3QxjV0+3qCheU9fEZt7S/mgLT6/YX84p0Y7ZwXRo6oNTtX5C70P5MQhLOfsCxYcFzSNKGF4d10I3gQBGSKWk5nKGwoAOcEVP5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kwcZ02Oy; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso880653a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709922364; x=1710527164; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcFiymo+h5H2KYUaV+euAHpHhZgWsCrhqFiINsYj2NQ=;
        b=kwcZ02Oy/o/ZXB1sCbZCkfBAbmzPmnTyAlhjCMT1q/A9RrgI0MhXoO+LvXaOnHPnYR
         03WKVoNAxN3AxZx/muhCKDkNY+F/spTbZqD/rklz8hjfOIOeICc7LW63l2sDjXvIyT7F
         8dyxsZYxVJx5mrGOLojXiaxyh+vTwDRSPTEMEJe4M7/CrI7H05D8oUJtokxjWPVU+C6h
         6uVLm5Dt7grcvwjJSSsZ4JFOp9O3criJ9v+JCNPqpJWQ4efRhJornfDE4ytU9l52RIa7
         xCHhPVcd9Pl17/sjtVjxmHDwVY7Y9JF9GgOP69KHTnyUkanJm14kKqmTbSaybqlhruz6
         Jheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709922364; x=1710527164;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcFiymo+h5H2KYUaV+euAHpHhZgWsCrhqFiINsYj2NQ=;
        b=LqyJvdPhyCupSRj5q0ScXjnIRPpIsQAD4/IggUlaZGZCKWgQKPMQxQZk2fyYGjGvI1
         KxCnuypEQbh7+boyIr4a2Shba8K0ygMoGCtWsQ4ICoi/cQGFhMFxYZY7MJQ0XvuM4+Bg
         yaNOAOd7EW+rEf3anDvbVV9yINYYwn+DLprU3LTffw1hI21/i5J0PZeXOXrZjWr/8X0n
         516Hy1MICirbwZcOyR1kGIN+h+hdkU/uEOKHL/yq7JUlvKqgskgQli6R0Mjx3V6Q9soK
         svw/jm6b/1Ocf7VbVhLAQYP6rA3ea5Ft1fB/yAJ4n/KONTSfU2EhTQrhPzYuk17o3zyh
         puuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQWxRtFCKmmmj52qjV/G0vKz4ac0tQ4n9fNfAegNXti873FvKyIE43FC0i4oIgo9AeGVZPozACifmkCVjsj+LE1nbGlfSAL5WE0dlv
X-Gm-Message-State: AOJu0YzKLlYfqRuuPNbkERXX2Y8Q94uamZbH84xBx3tNd7LcUrJbUXZL
	quo6VEz/im2UA0ohpBqlU/kg94nZLV4VZVnc6pSD8sZiQns/I/jgAeJXHs/zFp0=
X-Google-Smtp-Source: AGHT+IELgIan5yqE5It2h51GkqWwvF9l27KtLGyPFkczN95qZpobIHsNS+k43j4taa98KTiCzaJaSA==
X-Received: by 2002:a17:90a:fd0e:b0:299:4269:b8c9 with SMTP id cv14-20020a17090afd0e00b002994269b8c9mr954346pjb.26.1709922364103;
        Fri, 08 Mar 2024 10:26:04 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ac20d00b0029bb1bb298dsm44821pjt.35.2024.03.08.10.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:26:03 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 08 Mar 2024 10:25:57 -0800
Subject: [PATCH v9 3/4] riscv: Decouple emulated unaligned accesses from
 access speed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-disable_misaligned_probe_config-v9-3-a388770ba0ce@rivosinc.com>
References: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
In-Reply-To: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709922358; l=4202;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=IaoDcAIGwiU84s3iFQFa7IKKT21z3ZbSgM4n2pSHuEQ=;
 b=D3NiSToMkJgM3ochOOiN4oilLBmEEQASczQi6/yCbCi3BMgcdcf1bmege+8fRzDPEEdyES10L
 ZsVeSsvKAlqBFE64TiUx0lgNGZdkZt6k+7+Hmox2EI2GfuHZcyBynmQ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Detecting if a system traps into the kernel on an unaligned access
can be performed separately from checking the speed of unaligned
accesses. This decoupling will make it possible to selectively enable
or disable each of these checks.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/cpufeature.h  |  2 +-
 arch/riscv/kernel/cpufeature.c       | 25 +++++++++++++++++++++----
 arch/riscv/kernel/traps_misaligned.c | 15 +++++++--------
 3 files changed, 29 insertions(+), 13 deletions(-)

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
index c2ed4e689bf9..e55718179f42 100644
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
@@ -623,7 +623,7 @@ bool check_unaligned_access_emulated(int cpu)
 	return misaligned_emu_detected;
 }
 
-void unaligned_emulation_finish(void)
+bool check_unaligned_access_emulated_all_cpus(void)
 {
 	int cpu;
 
@@ -632,13 +632,12 @@ void unaligned_emulation_finish(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	for_each_online_cpu(cpu) {
-		if (per_cpu(misaligned_access_speed, cpu) !=
-					RISCV_HWPROBE_MISALIGNED_EMULATED) {
-			return;
-		}
-	}
+	for_each_online_cpu(cpu)
+		if (!check_unaligned_access_emulated(cpu))
+			return false;
+
 	unaligned_ctl = true;
+	return true;
 }
 
 bool unaligned_ctl_available(void)

-- 
2.43.2


