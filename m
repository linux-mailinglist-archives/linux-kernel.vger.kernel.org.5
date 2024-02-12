Return-Path: <linux-kernel+bounces-62545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21C85229D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6341C2281B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9600D51C55;
	Mon, 12 Feb 2024 23:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="okLmbxmk"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3550A70
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780997; cv=none; b=Ue+CfQ3dmD83QB8rH8uTVchJL9XD5wQu6LKeUaOxajAmojJrNBeMdT0vAlJf1mbet5C7ZLaKpfVAeIe8yPmsmvbtpXlp1TYyxM9XJeAvGBxtUM+ezSOelORurvlIKBcFrDxklQ3+wdFVJS7Et0fo5ggiNZGHIZP7fYceCsmLkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780997; c=relaxed/simple;
	bh=h5IjKPzf39ifTQj2Z0xAqATqlmjtpC61zariLMJKI0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XcMMXdzYvzAD5PZ5mGIokMRRoLGWybej/d2EKvTqCJIiTnIYcifkAljtF1uvKygPnXjcB5NZWZdWqmB9NpN9QeHPAS+ydF8NjdIZcdjMo3BRdoLaiXzTqZERsjJJt/ynpg0+evQx4XjAhUDKL2VnWX9D82pyCs+a3vL1eeiEkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=okLmbxmk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2971562c3ceso1790322a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707780995; x=1708385795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7cnan8PSAVXC3cUypQgKZqafgG+bekGNiKDSOb6OW5c=;
        b=okLmbxmkTuNXAYv90pOm7DssvdKt39xjXkYFgWttX0SxHB0Bl9wjPCM58z4kUpEbsZ
         soGnCo2gjNnbND7vR+axbFApO32czykT0/SYRp3YUE1rdTxmNlY81+3a4baL3JzrgO2S
         aEMIh73tGc55Q67V1FWqqK3ChT3ALPk243DdKiaaAzdBfWKrs4g3rHN41fQwA/ooLB00
         K0YQTB0LS0u/IDkidU7tjV3RW3RakyIg8e6bFlog5/mcArGaXIzSI7lv2MNDies1H0kC
         UylvUoCtZhs99x8Hm9EFQbq4y85obQtOlM9hydfzbbuLH3f2EVDMooPdBbBXpiwCm734
         RMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707780995; x=1708385795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cnan8PSAVXC3cUypQgKZqafgG+bekGNiKDSOb6OW5c=;
        b=HQ5xEskvvvITkkK+i8a9iaq2v3LE1xLIyVlNE2zxrPCgOqt11JvcQoqnSP2UH4szVt
         +MtDHIYof067pbhUBhJRhkQQvhl+43JVWtTHKZqiydT7lkBCZu0NmjtY2v6zcMsIzwNH
         RdSkH45gKVPZOnCvmgp4YCR0JbW7DAZvCpyH5U5bLKf84E563PMSk3QgtJJZ4/Dijtk/
         XnBDhYWCyjAaNQzNjQHJZaBGEzXR7UBGF3aMQFz5M8IiohUEvoMMSptaer25Bqh6KfDK
         4ItJZyfIMYk37uS8uJh6IPONCPbq5I64KUcDlhPqUQIjeYRSjMcp1hCGu4w9D7XVSjxT
         H2xw==
X-Forwarded-Encrypted: i=1; AJvYcCWeqENHV8jJ/BbruV6Jew7TI+Juq0YbuCyYPiz62WWxSlCJ+807vk5ChIsWz32Bv8kRy7pMGA398u4Oz6BXTx+HcVI/vVM7rx5TjTaj
X-Gm-Message-State: AOJu0Ywd8JLZA5F++54WLArp9ORR6z/3cHtshwOTurRSccHaCF3GKmx8
	n7xAklMRXfLCkM5voyTofnrtHB9YNc8mBFyiDm/13Hyk1amMpFBR4zv95/LI7LA=
X-Google-Smtp-Source: AGHT+IEy/UYemr39prYxAVOYTN6/oNrnyC8e1djNHt7JTfEtK270DmcLzYDcyfo+8s8sJcI5kCZL/w==
X-Received: by 2002:a17:90a:b395:b0:296:2f9b:8c2f with SMTP id e21-20020a17090ab39500b002962f9b8c2fmr5593744pjr.40.1707780995399;
        Mon, 12 Feb 2024 15:36:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmdXilEjO7FPIdqZaOyYuCeviPFS0SqLHZnCp/3gpSUAcvcq1RseNEO4AQ/xLKhhErZIkjWUUVEw5LUaDtfKBINEqVwe12bA0TS73NEdLCj0rsj6xYtj9GqmqLqCqspVc9Geyq4JxEFeQttHJs/GpyH2RJ64YcR66d5DidBGbD+P1Sch0aN2vyW5MoX0cYMAefu6Sy8YSXfxlVpECJIheAf2i3t89jVImJooAddlrWE0aRH/4eW2IIYaSDoNl7ag3Yqhg+MW5+vYxv+CdWiPLnOWRcKcGDj+JacCAKTOZR6O+fI38OmdnlEuSYvVkPBmFFgRpVBZAxwDuUhRNoW3gFK7cs7YYZsJGBF8XfBhnrvJpJvFtSRRVl/3ScCqdZozSE+tCpO8hsi07wpOMfzWAyq46aGvtGkQ6rfgLZhsCCIK8g9wgsDGoqAIfPXygy4RuRdRw=
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b001da153682c5sm888693plk.261.2024.02.12.15.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:36:34 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 12 Feb 2024 15:36:28 -0800
Subject: [PATCH v11 3/4] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-fencei-v11-3-e1327f25fe10@rivosinc.com>
References: <20240212-fencei-v11-0-e1327f25fe10@rivosinc.com>
In-Reply-To: <20240212-fencei-v11-0-e1327f25fe10@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707780989; l=4601;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=h5IjKPzf39ifTQj2Z0xAqATqlmjtpC61zariLMJKI0A=;
 b=vJDezW43wOShNn6FckmWv22EMLkCD0nM7x+UHVRHI3N8+Z+FmM5YXkveip/sA8wovq7Ws6bKO
 BP+ZSS/Sc9LDs5LKYhUoWvOeHEH9nKsMNE7+MESOdiw9PK7Yb73MHqV
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Provide documentation that explains how to properly do CMODX in riscv.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 Documentation/arch/riscv/cmodx.rst | 98 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 2 files changed, 99 insertions(+)

diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
new file mode 100644
index 000000000000..1c0ca06b6c97
--- /dev/null
+++ b/Documentation/arch/riscv/cmodx.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================================================
+Concurrent Modification and Execution of Instructions (CMODX) for RISC-V Linux
+==============================================================================
+
+CMODX is a programming technique where a program executes instructions that were
+modified by the program itself. Instruction storage and the instruction cache
+(icache) are not guaranteed to be synchronized on RISC-V hardware. Therefore, the
+program must enforce its own synchronization with the unprivileged fence.i
+instruction.
+
+However, the default Linux ABI prohibits the use of fence.i in userspace
+applications. At any point the scheduler may migrate a task onto a new hart. If
+migration occurs after the userspace synchronized the icache and instruction
+storage with fence.i, the icache on the new hart will no longer be clean. This
+is due to the behavior of fence.i only affecting the hart that it is called on.
+Thus, the hart that the task has been migrated to may not have synchronized
+instruction storage and icache.
+
+There are two ways to solve this problem: use the riscv_flush_icache() syscall,
+or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fence.i in
+userspace. The syscall performs a one-off icache flushing operation. The prctl
+changes the Linux ABI to allow userspace to emit icache flushing operations.
+
+As an aside, "deferred" icache flushes can sometimes be triggered in the kernel.
+At the time of writing, this only occurs during the riscv_flush_icache() syscall
+and when the kernel uses copy_to_user_page(). These deferred flushes happen only
+when the memory map being used by a hart changes. If the prctl() context caused
+an icache flush, this deferred icache flush will be skipped as it is redundant.
+Therefore, there will be no additional flush when using the riscv_flush_icache()
+syscall inside of the prctl() context.
+
+prctl() Interface
+---------------------
+
+Call prctl() with ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` as the first argument. The
+remaining arguments will be delegated to the riscv_set_icache_flush_ctx
+function detailed below.
+
+.. kernel-doc:: arch/riscv/mm/cacheflush.c
+	:identifiers: riscv_set_icache_flush_ctx
+
+Example usage:
+
+The following files are meant to be compiled and linked with each other. The
+modify_instruction() function replaces an add with 0 with an add with one,
+causing the instruction sequence in get_value() to change from returning a zero
+to returning a one.
+
+cmodx.c::
+
+	#include <stdio.h>
+	#include <sys/prctl.h>
+
+	extern int get_value();
+	extern void modify_instruction();
+
+	int main()
+	{
+		int value = get_value();
+		printf("Value before cmodx: %d\n", value);
+
+		// Call prctl before first fence.i is called inside modify_instruction
+		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, PR_RISCV_SCOPE_PER_PROCESS);
+		modify_instruction();
+		// Call prctl after final fence.i is called in process
+		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_OFF, PR_RISCV_CTX_SW_FENCEI, PR_RISCV_SCOPE_PER_PROCESS);
+
+		value = get_value();
+		printf("Value after cmodx: %d\n", value);
+		return 0;
+	}
+
+cmodx.S::
+
+	.option norvc
+
+	.text
+	.global modify_instruction
+	modify_instruction:
+	lw a0, new_insn
+	lui a5,%hi(old_insn)
+	sw  a0,%lo(old_insn)(a5)
+	fence.i
+	ret
+
+	.section modifiable, "awx"
+	.global get_value
+	get_value:
+	li a0, 0
+	old_insn:
+	addi a0, a0, 0
+	ret
+
+	.data
+	new_insn:
+	addi a0, a0, 1
diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
index 4dab0cb4b900..eecf347ce849 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -13,6 +13,7 @@ RISC-V architecture
     patch-acceptance
     uabi
     vector
+    cmodx
 
     features
 

-- 
2.43.0


