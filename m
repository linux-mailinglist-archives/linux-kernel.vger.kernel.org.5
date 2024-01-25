Return-Path: <linux-kernel+bounces-37943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF183B8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD775287BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56FA10A31;
	Thu, 25 Jan 2024 04:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="h7GPAiHu"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683E9107B6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 04:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706156594; cv=none; b=SLXKSme0Jr+Wf2+z2DGrj313dfbKjfDFI2A1gPyRXcezOtaO66rN2DswP8pB7PXqRf5R5Bkm8eLKeWZIwOW3qD0EgkpQIEPUiCU4HDrLmvptMVDWVD1+4BR4++RbmX0vxqPBhsBhj/wggJ6WnIIKrkVcr/CTP2+8S2pCjb7B1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706156594; c=relaxed/simple;
	bh=/bIGEHzKWZAAbhSw9Bpm0/wGOXPFjFzSm8DGgPpgj+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j96p1WGBQwEP13w87CeUJY7dr0PozhujHBdQC2FXWIPmSnDkDu6xQrf+UWn5F7sRkpZ1DtT3A45tsBUiaTo2MOwUL/rf154BMmrfRuxPXhCdg29x5VmwZSVRhm3h6TDBs547Mfljru6Mcvnw/MPkdvGCos345V+R4Ak83mGtLTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=h7GPAiHu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddcfbc5a5fso124523b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706156593; x=1706761393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CK8ubEYcDvykwCMVvaVm7hDmlbmdtschWrNEGYNue+E=;
        b=h7GPAiHuaTpHONndoIkZGUtPofIEjE9y7c1BGnNpYC+idAKCriUL1fk+LqcMmgL5L4
         3D6wp57EZ1LJbBO6JWHE5TnXTyfvW4ASGK/0aAdP2PISkwzX8kG67ZwMy1I2avjOyHCi
         wKnC/okAn+VDgqHcbntEUsON34ugcTYs2whV/IT9Ra5Ejd+n7n/mhIhog7DrXkRWcu3Z
         u7kUWe/a+Zc+y4HAWc2JE+ihuMgOpnNY1nZsskWrJWjvQ8e+w/B34g1mBBdGRXKt6nlR
         zwlIB4JAso/sCHXocOIx5SyE20twFmQ9bK3Wge0tDVU0aeWidE6u2IK/IB2rcp2qBO1+
         tvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706156593; x=1706761393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK8ubEYcDvykwCMVvaVm7hDmlbmdtschWrNEGYNue+E=;
        b=k6L2a8gauTlZkzhO5MdH5bhRRpo+t70OLfZbEOspc1xFCE7FXxDyhSfBDL5XGLFPq5
         A0yrJAB0+inPVM+Wk1yEtAxpjfC/T6osVZsF8eMo4lWKB/ulE+a5/BJQ4Vio/ouXfEaL
         sMw4X/Z8GFp9c8h7jn20jF+LZW1npWLZx5wAU03fI/T7M6KZW09A9OTYYS88lAirakJ9
         NDX5dQO9J6309MsFmo1PXsQYJb5m7BBUV736Lpae3Qsq7H+I2SXoD6cEpZPkRBpQEdrk
         WqztX4okTgm5Fv/R/gXKKaRyKFz4W7pk1CqpN+8TRrVrooxL5BopY2IXRGdM1c7iSDAs
         AQjg==
X-Gm-Message-State: AOJu0Ywt/xeDz+9bJKP6Apwa58e6yyVOGK/kfRZeEeKTFObj/Sh5z+ZA
	sr6vr+e9bPmHA+4I7PHko7gmtbswSRjrfjHACUbW9NjZVHBBTI04mFV5YvFpktgLZq17dnIR5XT
	k
X-Google-Smtp-Source: AGHT+IEl9KllwvoXTMIWVk+ArtZ7zyceTl8372dHYcA/tM8YUg/OWolL1Pt0csL+DiWBK4p74V5Vyg==
X-Received: by 2002:a62:5e46:0:b0:6d9:ac49:4e36 with SMTP id s67-20020a625e46000000b006d9ac494e36mr240715pfb.68.1706156592719;
        Wed, 24 Jan 2024 20:23:12 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ko9-20020a056a00460900b006dab36287bfsm14549743pfb.207.2024.01.24.20.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 20:23:12 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jan 2024 20:23:09 -0800
Subject: [PATCH v10 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-fencei-v10-2-a25971f4301d@rivosinc.com>
References: <20240124-fencei-v10-0-a25971f4301d@rivosinc.com>
In-Reply-To: <20240124-fencei-v10-0-a25971f4301d@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706156588; l=4389;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=/bIGEHzKWZAAbhSw9Bpm0/wGOXPFjFzSm8DGgPpgj+8=;
 b=8nd39leSJgLs2+elKTrJ95kIaaY5aY3jfw+V51ahKwhAF0kjRhP+syJrfXGka8Ue4mqYnRD8T
 /tR3VNLNInECWRfmUrpbWrqv21ojl5MkNzkfjR0C0nh/CuHH4cG3+3t
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
index 000000000000..24aafa23a72b
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
2.34.1


