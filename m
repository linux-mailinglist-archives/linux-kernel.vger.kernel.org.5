Return-Path: <linux-kernel+bounces-55607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A32C084BEE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0BA289A15
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367B1B940;
	Tue,  6 Feb 2024 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kIsP/7aO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C341B944
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252373; cv=none; b=a3M7u5Ju0KszxykUZXmwVX+cEO+zlXMj1oI44tAp2IrADQV1nOx/17bMFRGDyKzIa9D+/uUfzZeq6ET8b2rNYckGXn0rjJwA51SapHOuRUWqe97ji6wog4hOksJVGZU38h7WVEaS6D9QUhSLQ3pjz9/vSA5b4MRGY9wFogW3Hkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252373; c=relaxed/simple;
	bh=Cte0mjf8jhkIpFc/0wwZCX06Fv91K7ojr+u3gO5FxnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rQpaOGb67JQfq+d/KYrn5TRCsqTY7tarYK/uX1493celAnKYezfWqhrwBoJQX9I2VZ7QkRESE1r66SYjB4wo9pAH6hlyLbNoqdY1gtfdtSBEREDsF0gpETIM9oYzTWP1Qa9+6ylxftz6YXBQEKQH7ME7zQ4fJ3pb3MprtvpGcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kIsP/7aO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b13332ca7so3746868f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 12:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707252369; x=1707857169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=faLdI7A4r1MDpBrjBMxPLIztplo9D7QJ5kY725lxPV0=;
        b=kIsP/7aOtddedb2cOYEX4SKA3QjrEX/xn/SG//P6SL05HygUeToKPj7EnTfKsSrLGT
         G/8GBoE/wX0J88azlIg6sDE1MK9bFLS6KaUtDCvN1c7NMUEUC8p2UWnFJ5uXBbafQmhu
         V7oEfdEuWrzj/Ggm36jtMGQipLqlIiiu+YzuzXGDMJhz6RUWhhQaBs3HkiMFbiLN8YI2
         ks7rEQ3MaUYtfRNACrwajReqmHNfpUaNi1F9QAeycX3fPzO8Kak2zlJKFzxSWJNzG3Zg
         ptZJ6+WgdDv1hbNw/uxeFsP3s1aphc2Fu7uyTmNEXBiveWATtZ1PDYl1HAPqQhds/UXc
         Fbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707252369; x=1707857169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faLdI7A4r1MDpBrjBMxPLIztplo9D7QJ5kY725lxPV0=;
        b=dnIwI3JRaVFm+5/pS5FQSItRFlV8e/kcIUYV/XTh5q9pCDUs4wlayEnxv9TZ/m3/4I
         kavsT+cqm4hDDzXP0/3ac4eXf5THUMIEBvNgltepfxPnnkwoDddeapEm6QkwunwN7scH
         /Gbbu6nTdZyTxo/2fAsC8Cj6dAK2RGbZ2IeKtLGOvilmlki8VIeCcUF8H2xwQTjd4R8C
         TpVRPIYVG8s0XMgIHSEY/VyNnxcxrKya7KoAEHVXuq/X9aOfMJufPIZPWTkGNgx95ZRN
         NikvnCYYI5TQ8b6pkpT+pjPVWtjIpPy5bk854ZEhkQvaqsQsHQlWCJZOXlQWH0qJFg32
         bnTg==
X-Forwarded-Encrypted: i=1; AJvYcCUU/WjM2QC34K+/yxQMMp5znc+YL0AvfEERS/UJq0B/o9dSp6bF3A/2wDWDuTU4D8p5mIi4CgmxBXVdkdXFauWcyEl+0OMcsCzQsMfZ
X-Gm-Message-State: AOJu0YyPgNP1ENsccUMKq06IEiP5JFzFvemCEtLnLhX2EQTxBuFE3sjj
	vlfGA+IUz7f51lCTSlJoonN/DD3kRLdsoUR6MVNEYgid46m8gt+ZWpaypCw63/c=
X-Google-Smtp-Source: AGHT+IEUtpL/V/H84vcSbqDS07tiuujHFSTGM+gwxTOny5I+aPToo6WgrtaTz+5XzqRCMAXtUfnEdw==
X-Received: by 2002:adf:ed0e:0:b0:33a:ed2c:fea0 with SMTP id a14-20020adfed0e000000b0033aed2cfea0mr1730381wro.1.1707252369535;
        Tue, 06 Feb 2024 12:46:09 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVs9epp2rKTOZ8O1zlNog/fyR+3mQaCqPMlHSXF7JTIzPZX/1yRh8TSFwpxnlO9lctKVmUqTGRVgOPMLFH+6G6DBquk/RRImJP0cRNRhH82uFzI1tLbHCWZ3HwqQUYxDCha/mIXc4Cstm0th3V8rst8evMx2LQZyYzWMas3RalQdY1CWy2MycJzsGijgQpZkA09Codu0yESXB0n2qQNyg1cMDYzhcNQ2wAVh1cYWqK9whDhOa+cwtQBZaRKrSSyrftwGbyM2ycPGd0C3uWonieJ/HrgNshSMPzageTxbLgyuKaAjkTO6DyT6hyc5nF2/slPvAczakuicpDsvo63Yh4SJsIaC5Wbs8j/msxoTSgjL5lMfohxVa1bnGxhaKwkUGWtllj3kA==
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l12-20020a5d4bcc000000b0033905a60689sm2899741wrt.45.2024.02.06.12.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:46:09 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH] riscv: Fix text patching when icache flushes use IPIs
Date: Tue,  6 Feb 2024 21:46:07 +0100
Message-Id: <20240206204607.527195-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, we use stop_machine() to patch the text and when we use IPIs for
remote icache flushes, the system hangs since the irqs are disabled on all
cpus.

So instead, make sure every cpu executes the stop_machine() patching
function which emits a local icache flush and then avoids the use of
IPIs.

Co-developed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/ftrace.c     | 38 ++++++++++++++++++++++++++++++----
 arch/riscv/kernel/patch.c      | 11 +++++-----
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index e88b52d39eac..9f5d6e14c405 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_RISCV_PATCH_H
 #define _ASM_RISCV_PATCH_H
 
+int patch_insn_write(void *addr, const void *insn, size_t len);
 int patch_text_nosync(void *addr, const void *insns, size_t len);
 int patch_text_set_nosync(void *addr, u8 c, size_t len);
 int patch_text(void *addr, u32 *insns, int ninsns);
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index f5aa24d9e1c1..1694a1861d1e 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -8,6 +8,7 @@
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
 #include <linux/memory.h>
+#include <linux/stop_machine.h>
 #include <asm/cacheflush.h>
 #include <asm/patch.h>
 
@@ -75,8 +76,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 		make_call_t0(hook_pos, target, call);
 
 	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
-	if (patch_text_nosync
-	    ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -88,7 +88,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	make_call_t0(rec->ip, addr, call);
 
-	if (patch_text_nosync((void *)rec->ip, call, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -99,7 +99,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 {
 	unsigned int nops[2] = {NOP4, NOP4};
 
-	if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -134,6 +134,36 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
 	return ret;
 }
+
+struct ftrace_modify_param {
+	int command;
+	atomic_t cpu_count;
+};
+
+static int __ftrace_modify_code(void *data)
+{
+	struct ftrace_modify_param *param = data;
+
+	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
+		ftrace_modify_all_code(param->command);
+		atomic_inc(&param->cpu_count);
+	} else {
+		while (atomic_read(&param->cpu_count) <= num_online_cpus())
+			cpu_relax();
+		smp_mb();
+	}
+
+	local_flush_icache_all();
+
+	return 0;
+}
+
+void arch_ftrace_update_code(int command)
+{
+	struct ftrace_modify_param param = { command, ATOMIC_INIT(0) };
+
+	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
+}
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 37e87fdcf6a0..ec7760a4d6cd 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -188,7 +188,7 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
 }
 NOKPROBE_SYMBOL(patch_text_set_nosync);
 
-static int patch_insn_write(void *addr, const void *insn, size_t len)
+int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	size_t patched = 0;
 	size_t size;
@@ -211,11 +211,9 @@ NOKPROBE_SYMBOL(patch_insn_write);
 
 int patch_text_nosync(void *addr, const void *insns, size_t len)
 {
-	u32 *tp = addr;
 	int ret;
 
-	ret = patch_insn_write(tp, insns, len);
-
+	ret = patch_insn_write(addr, insns, len);
 	if (!ret)
 		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
 
@@ -232,8 +230,7 @@ static int patch_text_cb(void *data)
 	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
 		for (i = 0; ret == 0 && i < patch->ninsns; i++) {
 			len = GET_INSN_LENGTH(patch->insns[i]);
-			ret = patch_text_nosync(patch->addr + i * len,
-						&patch->insns[i], len);
+			ret = patch_insn_write(patch->addr + i * len, &patch->insns[i], len);
 		}
 		atomic_inc(&patch->cpu_count);
 	} else {
@@ -242,6 +239,8 @@ static int patch_text_cb(void *data)
 		smp_mb();
 	}
 
+	local_flush_icache_all();
+
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_text_cb);
-- 
2.39.2


