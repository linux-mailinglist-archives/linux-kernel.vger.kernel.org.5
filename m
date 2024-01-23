Return-Path: <linux-kernel+bounces-36189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C83839D41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62879286077
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989956766;
	Tue, 23 Jan 2024 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1hkWzx9y"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C15466F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052686; cv=none; b=NRTN0ZcGEZHMjPhzQEUUvt9H552LL3PzSjXbAc4UCSSARmEwU0KrOvytaiaedjpTabfP2JDGSSycipzeS66xw7B5ojy0+5+GFsw7HH/7AVb30l6Wq5RYJ7S/jARjU2Yt/jl31Kc5/eJGPABCaBWAwQHc2hztAhAOnkLhMs0e5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052686; c=relaxed/simple;
	bh=s1vPZ9pBqnCgTaBmMZz76e14UF6RK2nnhmaQL0fr1PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EQO4FWMGLCc/9onmGs1YApg0jv5KUtDLkhdPQ4+Wf0aY+SRm9H6+8cq4AboG8fGt0/B4qH59nj6C2j1oXJ/bnzltBG3famTEq5XaEkeUxY5acpkW409TkBjFwXDBab6XmMB95Wg1lAivNTkhmWpWojGZJ4TpkhjRuMVvCgoVmbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1hkWzx9y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-290b1e19101so1697213a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706052684; x=1706657484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypj/UfIhrHcfkXvw9Dauu4SlRhzY7WsoxY+bpEphFSM=;
        b=1hkWzx9yfbFvtu2kbt79azyWxGP5klJuNLd8LpolL8auuYdNQ9QIO/kxRipHEuG49H
         PgMJfuRzF5oitkGew1wIvbyusHpZ+fzayK5Rar9iXRxJjlJAo01OvaNXHm+BPvYNtop0
         jtexfPvct+ouwZ2Guj/1A1G4o8ddgXKXVnRx/YGscnjq+nGawFUj6eIgEiVjuoHVTRqr
         z9ObsVAqsW4o3QwjJAjnBErocLVLYeg6QlpYfCF+VzT2VtUlndVXQsya0/wRIC/bP5Sk
         riVZdJXVP7ELAo5woX34Oj1iRPlmnafieTLDtULHSQY31skZpWbyzt8FqMURWI7S4dgt
         SzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706052684; x=1706657484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypj/UfIhrHcfkXvw9Dauu4SlRhzY7WsoxY+bpEphFSM=;
        b=ckmENAPNeOoD9oEiZ3bMkAKOZ4R8EFjGhMrXU+l0V9se64QdMdcIOrwtKesW0YyzRJ
         LAZjrr+VBTS8C+DqaNe92nDDBYWO2x1U13gzeGihSQ/mwhxRVdWSoYfdvWa/r2yRfKtW
         bE+U6xowMCV+RrTAxCtwo0qncWZPa5y43kJu8RexHkUm9uWV6xJoXj7hoP6vacr6YoZn
         44dLL9OlFdUDbEwSoJGliqlzHChzCGgJlbJ48Z1/yR+h0kDVbViXN8ZHrzG35N+2OYJ+
         UF3PDJc8zeq/TX1uFu5RV+lAtdQ0wP+gnAdzaIBcEahQq6G+SQDD0s8KuQVnPixBaQAD
         J9mQ==
X-Gm-Message-State: AOJu0YysC/EHJ/jwN47j/96MxGB1phsUBKx3JNQzpXc2duWfDQD91sIu
	kCiFFPiXkm2lgA1FqcNZpn/osL12Gxd8WbzqeQvMD53hwqCBFh1uhQ0zzQZFV4I=
X-Google-Smtp-Source: AGHT+IHToLOk9K0v/hNzUDffZhy+RECx2WTKxjTAijS0JAdyRvVF5awESDE1uNYxsm2LWaQ36Vie/g==
X-Received: by 2002:a17:90a:4b4c:b0:28d:1581:29e6 with SMTP id o12-20020a17090a4b4c00b0028d158129e6mr432143pjl.13.1706052684090;
        Tue, 23 Jan 2024 15:31:24 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id eu15-20020a17090af94f00b0028d19ddb1afsm12150698pjb.33.2024.01.23.15.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 15:31:23 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 23 Jan 2024 15:29:52 -0800
Subject: [PATCH v9 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-fencei-v9-2-71411bfe8d71@rivosinc.com>
References: <20240123-fencei-v9-0-71411bfe8d71@rivosinc.com>
In-Reply-To: <20240123-fencei-v9-0-71411bfe8d71@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706052680; l=4373;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=s1vPZ9pBqnCgTaBmMZz76e14UF6RK2nnhmaQL0fr1PM=;
 b=Ur9C/GYjVRc9cfGP6lbfdLcd5+hrocoQQ3dJe0KO4KsYN3HCUO6zjvu2mV8SSw3XAXQTLvrtX
 FAcuM9z45lnCp+iAcp2yvi2SBh+OuWVcEO/LKKTp8kBQdt/sOG6QIjp
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Provide documentation that explains how to properly do CMODX in riscv.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/arch/riscv/cmodx.rst | 96 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 2 files changed, 97 insertions(+)

diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
new file mode 100644
index 000000000000..2ad46129d812
--- /dev/null
+++ b/Documentation/arch/riscv/cmodx.rst
@@ -0,0 +1,96 @@
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
+storage with fence.i, the icache will no longer be clean. This is due to the
+behavior of fence.i only affecting the hart that it is called on. Thus, the hart
+that the task has been migrated to may not have synchronized instruction storage
+and icache.
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


