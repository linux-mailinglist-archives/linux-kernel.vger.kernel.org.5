Return-Path: <linux-kernel+bounces-21273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD6C828CDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BF51C24B45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928153D0C9;
	Tue,  9 Jan 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tOSB6VHy"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524243C482
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so2584305b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704825810; x=1705430610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1NNXG/cc6Ss9zFsC2xjmXCCDBeblJidGJDKM2XVVV0=;
        b=tOSB6VHykhe00dCiINpfjpyxNqbdE3/3KIHmLnFwVmX1P4o/QHFhlh7sYPYvtpFK5b
         ob88tGRsgf4zHwaNJJB/1vh5m8zM2M2HJxhjA8OG9fX7mscv3alwqpP5nOZNTTGFbQuJ
         xhSoQe+MoLeakS+XcslD8Qn8C8Tn0jIsRI2jz9I5xB9bdP2+fTf3S5fdbOvspMKwS0Vr
         ck0h2xS+KvMNoqiRIOnF6sPWCNdKbC9t3tofB4cALm8ISSVZ02tZRJgzE1/hhx/fY/zQ
         wkLfXBBTOp3QyJH8oiiPFX65hq/DiTkfQCNmr8QRJh2C8mYunlgeKJULC9wMEAJcloao
         3h8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704825810; x=1705430610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1NNXG/cc6Ss9zFsC2xjmXCCDBeblJidGJDKM2XVVV0=;
        b=WYS4ZHKsmqEctoYRPRGRn/a2EZjGOc+IAXtpbV61R7HwPqBqGNwbFUOA5sW0FaYa/r
         FmHr+s8Ooc1askwsoYz5W1ELxi2xdvXItpc4eBm8palQigOnkKj4exaDkW+cdg6TDlCz
         AhcbuXM8vas2TDeLXJdfPkTWiU24U1dsg2QU4OdJRQKpRSg3wpmy3K71vvcs4fHiteAD
         dOE3q9VBaz85TBWjDTS4tu4eOLyMFItVobjNLmdPpb0KKpS1yz77X/18/VtTSxct3a00
         vtoE2YUFBp4LL0Zk1kXFFZVsFKQNi5MdBjUebzzDIBbhWy3PF/rHkdifdKJ328estw4J
         3k9Q==
X-Gm-Message-State: AOJu0YysrefxYX5gR8NWhOoHHSeDVumJ+1n5wimvuPtFIIzEBQHxmWdL
	yyUH2HRdyNWUL8NcMxKw31zhcKR7zemN7A==
X-Google-Smtp-Source: AGHT+IGQlBFgMVz5mTuTuO8bTSRghm89zYg7Wg6yrGXtc9FJWyLD8udHcY6dup6zfxmsWGuwNK74iQ==
X-Received: by 2002:a05:6870:7884:b0:203:18e9:804a with SMTP id hc4-20020a056870788400b0020318e9804amr6057763oab.86.1704825810491;
        Tue, 09 Jan 2024 10:43:30 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j2-20020a9d7682000000b006ce2c31dd9bsm450423otl.20.2024.01.09.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 10:43:30 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 09 Jan 2024 10:43:26 -0800
Subject: [PATCH v6 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240109-fencei-v6-2-04116e51445c@rivosinc.com>
References: <20240109-fencei-v6-0-04116e51445c@rivosinc.com>
In-Reply-To: <20240109-fencei-v6-0-04116e51445c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704825806; l=3808;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=ABgVzoDksDxj5OqFX0a7CWpy1eY9QNcsIJ1Zy7mwIys=;
 b=j5GVuprP0qn0h0qUpUY2k2ew7NlFi46kdG1k0oqIUc112oHNCCD9SA9tXCDEIg4X1qkZqh5ZH
 tINoTxCG7+yAyv173/RET8VuEsm9gqic+JA7gneMpiQeImMmqHv0Dot
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Provide documentation that explains how to properly do CMODX in riscv.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/arch/riscv/cmodx.rst | 88 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 2 files changed, 89 insertions(+)

diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
new file mode 100644
index 000000000000..afd7086c222c
--- /dev/null
+++ b/Documentation/arch/riscv/cmodx.rst
@@ -0,0 +1,88 @@
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
+		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, 0);
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


