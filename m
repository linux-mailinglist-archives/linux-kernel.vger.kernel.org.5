Return-Path: <linux-kernel+bounces-85472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E04D86B67D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20671C255BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC39615E5D3;
	Wed, 28 Feb 2024 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="D2IrTjkj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47716161B6E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142840; cv=none; b=kEB6rlDOgieX8AkilM2G3TbLyg7kAurJo/tyFmymmfw+bobfyPiJxaz2WexhJONaDWXAd3HZ+Ff0VptzEzqJmPWHzj3UFVrqZjU3kdLnQic9MsgswOrW3yX+g/2Q3LnqORe5ZINH2Ra9jLGv4WROWHoR5/eNKhUWQ9R42pt/TAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142840; c=relaxed/simple;
	bh=1Bd28xktdVPNsM8n0LsBzvjun5YufbV6tfnuehsJA7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNhBBpCJpcnL2OzLeugHJ7//Sho0XoOzSaageLmgkBA+bwan6eGTk5jYuGUjjQRRSTnQXvuHFW7UhofBP1ezxUD6GHZmTRR7DWEudbWYXe6Ofz6olC/QDzjm0F54/6J8CFvQ9DDQdWaO7ei9IObGTBCIBSNWbKasp8p4sfJHK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=D2IrTjkj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412b81ff401so234325e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709142836; x=1709747636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2KLsPuh1XpNjZ2CAToQLQwQXyB2VEROM3hvTLFmqyk=;
        b=D2IrTjkjDsw+RKk6jHaPEfsFKyrJOMcpjZfnctDFKLMJHzu/vzHLgb6BAX+Y9piSA+
         vg2xGX/EnGpKh7FWvkTbCz4IL1Y1znrUR+u0372XlXpKYczQslLlEYhJ1qEbgZF2lGxp
         85zMkCYpoIFsPiunabG4TkWEpw4wKBlTfuJ0mH08iioPGUulUWcfBv+ghqnSpbtl2Ze6
         U+fGIpIsnA9hlVHiLXNTVd7L4ihI399UhRIn7JsZ6ILHztxWQ64HveUAadAGrEVD9RNC
         25pXfKiuFpCdqq3el5BnwIO7LFrCugy0zB69AL07Ir2aGGrKvNthocvfQGFlIFxxTwht
         qi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142836; x=1709747636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2KLsPuh1XpNjZ2CAToQLQwQXyB2VEROM3hvTLFmqyk=;
        b=WZVhjGiizSXp16Ff8yhznASrqvNqDPolkeTf+fhGq7PCQO5E1jzP6iumwk8pcdiSpT
         tU1HeLekAn5qnWAl6llJmbEmUekq81xw0DoNyem8ykWCaOtUDokdCEQQmIKtllCWqhrj
         ekIsHKdFIwetalYnqXcSo3xKiZThjGdnaEz1LknfofpK2NTnKWDTqh3W5MgK6ixqfbi4
         imOM7l770Be1st9OyAYDzCD4+55ImRn1wM3D+bKH+swsBFaKthQ6QyI7E4rL646FXRqo
         sqqauOuyAoFyTtgPcug4YM+QBYobTX1msvnLI2B5nkaRWm24ya9HI5ykCWsAKGwCO86q
         zgzw==
X-Forwarded-Encrypted: i=1; AJvYcCVRpaAHn3e6zH4KsOd2DdMZd6KimFTCzgngk9KYjDJB29+3ipiMSi7Bnq+V9KypdVZknxHMhE5mGc3qaAGarP/vKfRjyIETi8cMQ0tX
X-Gm-Message-State: AOJu0Yx0Fcw4FQ7KWVYT4ULIsfWwFqMPyu2eAp8mQ/1G5/xTryo0yplL
	nbkjTP4HzQ+OQdop+i8BgIpZQMdTPnaLAjoqDFVIZ6zrSKh2uBMDdV6PPNaIfvg=
X-Google-Smtp-Source: AGHT+IFzsKFwkm6/PUuNhQXzmzQ00xQ91ajZbuZqPe2v3cVZIJEAYjZNYyL+734jbdq5mZCUaY5k7A==
X-Received: by 2002:a05:600c:190a:b0:412:b15c:9769 with SMTP id j10-20020a05600c190a00b00412b15c9769mr174697wmq.25.1709142836667;
        Wed, 28 Feb 2024 09:53:56 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c500c00b00412abfb0ed0sm2880142wmr.0.2024.02.28.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:53:56 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH 2/2] riscv: Fix text patching when IPI are used
Date: Wed, 28 Feb 2024 18:51:49 +0100
Message-Id: <20240228175149.162646-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228175149.162646-1-alexghiti@rivosinc.com>
References: <20240228175149.162646-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, we use stop_machine() to patch the text and when we use IPIs for
remote icache flushes (which is emitted in patch_text_nosync()), the system
hangs.

So instead, make sure every cpu executes the stop_machine() patching
function and emit a local icache flush there.

Co-developed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/ftrace.c     | 42 ++++++++++++++++++++++++++++++----
 arch/riscv/kernel/patch.c      | 18 +++++++++------
 3 files changed, 50 insertions(+), 11 deletions(-)

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
index f5aa24d9e1c1..5654966c4e7d 100644
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
@@ -134,6 +134,40 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
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
+		/*
+		 * Make sure the patching store is effective *before* we
+		 * increment the counter which releases all waiting cpus
+		 * by using the release version of atomic increment.
+		 */
+		atomic_inc_return_release(&param->cpu_count);
+	} else {
+		while (atomic_read(&param->cpu_count) <= num_online_cpus())
+			cpu_relax();
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
index 0b5c16dfe3f4..82d8508c765b 100644
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
 
@@ -232,15 +230,21 @@ static int patch_text_cb(void *data)
 	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
 		for (i = 0; ret == 0 && i < patch->ninsns; i++) {
 			len = GET_INSN_LENGTH(patch->insns[i]);
-			ret = patch_text_nosync(patch->addr + i * len,
-						&patch->insns[i], len);
+			ret = patch_insn_write(patch->addr + i * len, &patch->insns[i], len);
 		}
-		atomic_inc(&patch->cpu_count);
+		/*
+		 * Make sure the patching store is effective *before* we
+		 * increment the counter which releases all waiting cpus
+		 * by using the release version of atomic increment.
+		 */
+		atomic_inc_return_release(&patch->cpu_count);
 	} else {
 		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
 			cpu_relax();
 	}
 
+	local_flush_icache_all();
+
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_text_cb);
-- 
2.39.2


