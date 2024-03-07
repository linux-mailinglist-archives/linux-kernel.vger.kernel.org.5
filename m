Return-Path: <linux-kernel+bounces-96054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206CC87569C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB9B217B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5CB1369A9;
	Thu,  7 Mar 2024 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="H+MfpdE5"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA813665C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838359; cv=none; b=AmLsK4lgfIBy/bTRVY2C5odCkV41kPefVIaCeCPa7FtL8Y2Tjo8Om5HwlmO5E0LEXzTVE/R2pbL0JD5btFlaT1bWs479xIlBvRvuZQPhwsp5C4rqeRD7dZl+wvC/eNeYJZDdd1mGEHTfxsv6DunPfW7zR6PK1ynzun5MexnwqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838359; c=relaxed/simple;
	bh=IaoDcAIGwiU84s3iFQFa7IKKT21z3ZbSgM4n2pSHuEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WcZz81vAPKkfkt70WypZgs++tTxB2j3tufQA3t+OOHBJLxAS2TmjORb3IyEQweFXP1tuHMGWDCeoHRUldYkUf36uGQG0e/elD07wKhazbL1GjXeiwu/d2Ydl19EwONZ0nuoVk/BcvvkBcDfbeJxOxezEp3VlVWPfUC/En588jlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=H+MfpdE5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d944e8f367so10903525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709838357; x=1710443157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcFiymo+h5H2KYUaV+euAHpHhZgWsCrhqFiINsYj2NQ=;
        b=H+MfpdE5RjxaxOzspqY43kXNOK/QIzBYdzkWuPqbc2gKU8BIpd1l+Kd4246DOsYewe
         SFFs4ZfP0ZcZh38GiWtwDedjFAKLlbiJbxlNjVXCfKKIIQjcf4IiWlDdo0h6wBRNAFRq
         OGDljpX+/bIuvMqaBVj0hXXi+ei7MAM2mJd37A0+L8E2hZAy+SUfJ0EsHxUCZ6ChZL7k
         jjsrYktpXHkFr0jsVsRW8WadGupSOcZ2gQYm3PP/utq0NRusF8IM+DUAdpaCX5at75CI
         ErQMOK3qo+Ca2V/DX9j1sMagGcfb5TpcK6IUjS3nd/L8xMyclMPGAnuqE+2lA9cHU3Zm
         h/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838357; x=1710443157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcFiymo+h5H2KYUaV+euAHpHhZgWsCrhqFiINsYj2NQ=;
        b=Ty/4ZR3ddwz6Qk7BtnvUJuNyxmlWzs4ioU8TViJI7XGPSMBlLs3bK80VqVjqolWVPp
         ZGXBMUFTqpfcKT/prz7XwTm7At1Qu0EUOZjnY33ZeedtH1AbCG0xh5CCQSHzKjjwYltZ
         W5AqKTMtQIr2bbbktm7qDkl8F+/9j/UvqTZdb5vMsNa7ZFBopDZ/xJtQ3kJyvpI3osK3
         +9oZUNvZL7/f5V4xr10bxPrJnWPi49TTQPE8I7TtNh+IrZycd+wnlbefFx01usq7qUT5
         dJEsCn+Y1XPm+QlQyz3LLnjNdAZlobDjF2hX9J82bnkdMMPXY8zUKKqz5EOMLm9oq4YS
         vJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVTvm2Wnuk+qY9wcy/8xdpvUISi6AXB2LVh8iCPd2/nIDbpsYXEWiBJVOkXRyCGCxrLzJA+54iEVsYrP4KV1HuZgtQ8hazG9TMlGwvf
X-Gm-Message-State: AOJu0YwxW+5aGXu+sDF1jwpiyyA1Zq5QSurvy4R31gQpRjM7DL9vT8us
	Kog7IQ6k35vPGjGQiYAyXqDQmjnqX/dkqb5tLuKVjv4dERHstlKB9UVjvt0iQhc/nGnJ1uj3dKi
	f
X-Google-Smtp-Source: AGHT+IGWkAQ/GgJHU1goRENWlzlo1nOGmjqZXS1Ap4YlB/sVxOCqmhx+oHH8w+U3FcSQCMZmvqiyag==
X-Received: by 2002:a17:902:b202:b0:1dc:fb12:abbc with SMTP id t2-20020a170902b20200b001dcfb12abbcmr7992411plr.61.1709838357144;
        Thu, 07 Mar 2024 11:05:57 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001dd526af36csm1747338plk.295.2024.03.07.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:05:56 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 07 Mar 2024 11:05:47 -0800
Subject: [PATCH v8 3/4] riscv: Decouple emulated unaligned accesses from
 access speed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-disable_misaligned_probe_config-v8-3-55d696cb398b@rivosinc.com>
References: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
In-Reply-To: <20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709838351; l=4202;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=IaoDcAIGwiU84s3iFQFa7IKKT21z3ZbSgM4n2pSHuEQ=;
 b=Gd/AFd9UPYuU9gsHq8mkyXcCsBgVRVzPdcuQYH+roI4KVNNrqQUITF4Emy6vygu23m3rPxwio
 U5tr57dBkG8BJE6C+mIDw5LFGt6Z3a+kGFeNFUsbIiIjDF7+dODt76C
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


