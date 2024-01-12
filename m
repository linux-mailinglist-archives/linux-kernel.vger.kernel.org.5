Return-Path: <linux-kernel+bounces-25121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205E82C829
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B112F287596
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9CB1B267;
	Fri, 12 Jan 2024 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PuOQUF4A"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A61A5BF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3e05abcaeso50804195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705103785; x=1705708585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEBcVc42XhLbclEOiOTeHrqKkg/yMaKrCrHZS6upbrE=;
        b=PuOQUF4AJD7+KafeAsSxhpKUyYK7t6UWeME/pXneBCX6ojv/HZ+cmWWu0F50Yd3s7c
         K8cVdhoSFFw8bmRUwp4d872XWunUUNy5KDtrVnBz808YJ0nxIaScampqMavlhPYBlbAl
         yRORTgj9R4dFY408jqf1N3oyGTBrFYtF0kASRvdzkZgtVsXo7hdQRscc8F+NvSJnF5Te
         mo277vhfUQIQuQwRZe+Dsu67gKy7cM1PXuFsTv2VuKZPyLA9zJSSYloznQBwiztZJVIX
         tVxgJMIZzfv6A2NcE3FIs3I7YMHHHCmWV1tvIuR5HKvAV2zTdQpQvnSucb+RSTqNrNX4
         sKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705103785; x=1705708585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEBcVc42XhLbclEOiOTeHrqKkg/yMaKrCrHZS6upbrE=;
        b=LySVNbWFtjBz9hUTdlFYFlma3c83bY850mCGsZOP6gN5DJWEz9vRUEl5HZulWVDAkD
         rGr6JBIEAdJXTARrD7zMlz4RrwIDt/3LXjpuJFBGYKCAeC8oFt0jd/rCMkptoQh4v/Ip
         rdLilCWfpn6x0dijXarDESYsVRYPIN2my8SqIQlmvv3/7rjxzYxrTYdyht9HFNgBuqwE
         u4fbkLN6HPmXuHxav6O1vlt8zNMcmgVLGSrZeEBFDz7h/y3DBgrWtPXnMf41H8VSzg8T
         tAzt7TffOj7D5NLpTZ6I1gUbKjRMANNQWWhKW9/79qGOVJQLSG47ICPQZJ321n8Z5Vqz
         BtlQ==
X-Gm-Message-State: AOJu0YywRbFfwjoi4iXqvUrgMPoZ2grf9Lu0DCLgssRba0mJD6oc5lLx
	pb2+8DqjkVL4dqFaBHN5brEr/rKMlX2meg==
X-Google-Smtp-Source: AGHT+IFNdcduop6iNi3vxZZxI1uKfQ5Yqs5N4fZW2gQaUsy/gPP8ax5VZ32FIDZCspddllFQdOuY/A==
X-Received: by 2002:a17:90a:39ce:b0:28c:b190:7f85 with SMTP id k14-20020a17090a39ce00b0028cb1907f85mr1693150pjf.13.1705103785134;
        Fri, 12 Jan 2024 15:56:25 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001d3b3ac2d7bsm3725537plb.245.2024.01.12.15.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:56:24 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 12 Jan 2024 15:56:21 -0800
Subject: [PATCH v7 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-fencei-v7-2-78f0614e1db0@rivosinc.com>
References: <20240112-fencei-v7-0-78f0614e1db0@rivosinc.com>
In-Reply-To: <20240112-fencei-v7-0-78f0614e1db0@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705103781; l=3833;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=K6GU1jCnXJT3SY9+VUk3ZVtE1kDzv2SIhv7zwH/+BBM=;
 b=IIwtYnkypsYDf9+vi3bTkqQxfW18T9+8GE7LkRi/XsBDie8HMeanSj33rnURU6I++o2xxUcr+
 RMM+6s5z2kOCPBLVFCEEsc9wRzO3ABlP9+RAZmyIWBEBaj1qTOBw6p7
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
index 000000000000..7ae8ababa039
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


