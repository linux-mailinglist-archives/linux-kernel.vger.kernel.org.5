Return-Path: <linux-kernel+bounces-94539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAAE874123
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4B91F220DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E3146010;
	Wed,  6 Mar 2024 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Lvi/ZvPC"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE11428E1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709755474; cv=none; b=PydJ0UDxIlCioV6TP1nxlH78cnr9+ZR9IpM/p5t3ndYY4AikSZa38i+TJK9k+U83xB+XeS6QEamMnkPL71TMG7EzjmJq3eAYD1oAOgWVgUPnpZ4XsYdN0pw/3wB2ngl2K/A2g8Nb2bG/OW9Fdop3zYUsqM/pFmKQpJjPjgfl1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709755474; c=relaxed/simple;
	bh=DInkzEsYPrFJ+waSF/dYqKLd0uhEiOzVtX3I13D+1lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r12qHuJcsh8BOhQDpYzylhNYSHtuGEvHXpkCKwhdVOn2mZKxHLe5FWLUib/JQkowJ0itE7/FUpPZoKo6V2TPonmjN1XO7juNixZb/qpyRRrjy19ZRYYgS14YLFE0/ASwj2EB1e7m7nK/S3O9AwP+v7UoxJGWewgLPbk6GXIJj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Lvi/ZvPC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd3bdb6e9eso818535ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709755472; x=1710360272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3h3l0Ycd0txaXwqtGKXZSurBo/SuGyYiZV4XuZZpag=;
        b=Lvi/ZvPCvAo71WaarlpMKCkkcK+EiKd7t/j7dLIKWJ2gGXsnrIjtyVC1IYwPnBm1RR
         fuQ9NRKQVreHum0NgOZIvsMZoo+ld/gQAEoR5E2iO+dAbgjvcvmjm5Kkh8NAyvLZLlkV
         hgKt4EyGvDLtOOYPeZx5PiesUKZiulK44QmcVjvnIaACdE0jR62LzwvV4Z75tJcci4L5
         wilqGLf94/mzheUHo8BxaNnKVl+0XmneP/lNRWUVUwXojmE5RjSpZOmEV2R4e0H6l+O1
         r/oYpbhpNtsIFPp+XslKUHhzXugwBTsufC5CQn2bSxtLJmNZyV2ZwuNVCr3MqellS0f8
         6ULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709755472; x=1710360272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3h3l0Ycd0txaXwqtGKXZSurBo/SuGyYiZV4XuZZpag=;
        b=em82XrpfxyXDU7erccaAXiUOtXnrcBEmDJQX0JnEJdP31PKEhnmkmfiMntzuiEbi4U
         M9ToblgaZ2Wzf1KzIt9S6QGyzea8XLOR6Z3njMc/ekJqowYxU6zN8o9WnwG/f6cKqc/n
         dqC0+EvlZ3N3COnMq/7DEviLiKaEkPniwenTjERZ32h6fcNL9TQZG5Hu+SAHD0SfLFu1
         1btqvT4IZKkvC+j2402QxSUyrAslG2VJXWo4fS1Yv8KI03s/FMmgbBoucPGKhhptYlxd
         tAzakXkhVj/lxcu5jb72ZSkpbyha9OOfx3f0RU46E/ZiE8fF8TYzvP+fXeF9dUlS6VkK
         Wwmw==
X-Forwarded-Encrypted: i=1; AJvYcCWo97YqXl/RyY6coVf22vbTfGk2P69PUUGViyX3Skj/Tz6prrbTqOM1+uJHL3qs/sEEtyUbamuAPHM5nQAphdIOwyMxhRL220l4LQ1W
X-Gm-Message-State: AOJu0YxlLfzDyXtyIed9+mCJZxV7sW5+eEAhycTK9vmhkcjk+C8kEYBt
	rg7mlWR8WCgPSGudvNhdRyQuMdpF+Av20Wry56XvOG68G/BnySHdBK5GJzaxWZg=
X-Google-Smtp-Source: AGHT+IHwpkx1HSST01gu7iFAZHNQnervC8qd68WqCPj80KESLMWRMKOAlsGOCO401jQFYD/w7wCfRw==
X-Received: by 2002:a17:903:24d:b0:1dc:7845:537c with SMTP id j13-20020a170903024d00b001dc7845537cmr5928989plh.1.1709755472694;
        Wed, 06 Mar 2024 12:04:32 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001dd42bbb08asm874913plx.253.2024.03.06.12.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:04:32 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 06 Mar 2024 12:00:03 -0800
Subject: [PATCH v7 3/4] riscv: Decouple emulated unaligned accesses from
 access speed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-disable_misaligned_probe_config-v7-3-6c90419e7a96@rivosinc.com>
References: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
In-Reply-To: <20240306-disable_misaligned_probe_config-v7-0-6c90419e7a96@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709755467; l=4180;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=DInkzEsYPrFJ+waSF/dYqKLd0uhEiOzVtX3I13D+1lQ=;
 b=jrlrelGypAUGPhL6WOlc+U5QG80c/2NUPxE//1G2xYp5fWrZqTju7D+5BYoGVZA8TyX+Yol9r
 f30a8KDNUw1DJosvrzrZ5/YaWsWWUht2zEvTFVWwrFNokvMxtasqojP
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


