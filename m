Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48207F55BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjKWBD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjKWBDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:03:25 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDD5D41
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:03:26 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1ef36a04931so260872fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 17:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700701406; x=1701306206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRpHyXch1ds04YbL7CZ2Ig0iTMSbi0Lx8xBxrq50UvE=;
        b=bCqtQHYPKkhpBnS9siWNvo1CyvtRLFZYofRZBLFX1bi0f2xAnoc2MF1qOJXPO1n9MS
         y+sKurVISO0HWw/Nm1MQ2n6D+E5IeRR6y1LZsaXiCypkroGlh/HERRPXOvWzARHWOQMw
         2TfjBpHYKW/KPZSM4OLo4ynh2gyBiFJeuHQ7FhLUev2Des3vVUxmgiEvJYDUtC6vkNIE
         0ZqB7wms7zY3rOpa/COGNNyojhib161bXnrqxYnSiVkJRB3XUcO4gTbog4V77NNqhOLn
         DtIknkbM3mN++HzEuvJBjYbthVwRyqLQAoHTBIek09VmUPyKzBaqTNctqr1ChhB27Lrs
         f5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700701406; x=1701306206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRpHyXch1ds04YbL7CZ2Ig0iTMSbi0Lx8xBxrq50UvE=;
        b=ijENG2gE2ErPvL74mBPpwsahVQHr9n7C6NdLQ+jkPT9/Vg58n64MNi2A1cnQqTSd7l
         oIT2NFFBpXMkBzLze6tr+n0YdDkY1ZcBL3N8Derx46hWi4LWLqlYadfWfs4iNIGixjou
         tscLfuNqsXolORx28uEmcIUKoDLJYGEAwSN8WKssBhtRfT1p1tsq4JTntUlLB2JRWD77
         cwUB3t6CL71+XoAvTJaOoSaWafLmYR0juK7WEt9N0ykDI3ozkjxv5u33SS0/hFtlnB9O
         8bHjRyvkf9Jf0GUjHdQbwi98XQyvgGWWFoXsDJT85iYX/YuacE3BeRjWcwBkE5CyJPD/
         i73Q==
X-Gm-Message-State: AOJu0YxwfTKWA0jppptEzSDcawLStED0G9O8AER1z6SLDvhmIy/x4i4j
        3HsMs/F/tPUrRR/5r8fXV/myAQ==
X-Google-Smtp-Source: AGHT+IG/XANLuHhNMbyQI/+iMPS/2BcEpeebTXYFvGzaxHzLqTfuC+EYQtgGPk0ne/nd3MEaxF3m8A==
X-Received: by 2002:a05:6871:e712:b0:1f9:5cba:10f with SMTP id qa18-20020a056871e71200b001f95cba010fmr5497463oac.38.1700701405717;
        Wed, 22 Nov 2023 17:03:25 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id oq12-20020a0568707d8c00b001dcfaba6d22sm65834oab.46.2023.11.22.17.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 17:03:25 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 22 Nov 2023 17:03:21 -0800
Subject: [PATCH 2/2] documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX
 prctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-fencei-v1-2-bec0811cb212@rivosinc.com>
References: <20231122-fencei-v1-0-bec0811cb212@rivosinc.com>
In-Reply-To: <20231122-fencei-v1-0-bec0811cb212@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700701402; l=4185;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=F832qgYu+P4UC1wEyL5OBUM++FIUPLUyooQDvSDBU3I=;
 b=/ejB/nGO+n9Z+OwncZfeezfO5rxKwLReqPaxBO6PJUO73xRriSsewPuRVrfnOHqcsPpeCAPhp
 4G2AJ2iToI0BoKeRwOjWiYIGh2mXR9CiOFIiNGPhqdaEzyhT3a1toPw
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide documentation that explains how to properly do CMODX in riscv.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/cmodx.rst | 98 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 2 files changed, 99 insertions(+)

diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
new file mode 100644
index 000000000000..20f327d85116
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
+(icache) is not guaranteed to be synchronized on RISC-V hardware. Therefore, the
+program must enforce its own synchonization with the unprivileged fence.i
+instruction.
+
+However, the default Linux ABI prohibits the use of fence.i in userspace
+applications. At any point the scheduler may migrate a task onto a new hart. If
+migration occurs after the userspace synchronized the icache and instruction
+storage with fence.i, the icache will no longer be clean. This is due to the
+behavior of fence.i only affecting the hart that it is called on. Thus, the hart
+that the task has been migrated to, may not have synchronized instruction
+storage and icache.
+
+There are two ways to solve this problem: use the riscv_flush_icache() syscall,
+or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl(). The syscall should be used
+when the application very rarely needs to flush the icache. If the icache will
+need to be flushed many times in the lifetime of the application, the prctl
+should be used.
+
+The prctl informs the kernel that it must emit synchronizing instructions upon
+task migration. The program itself must emit synchonizing instructions when
+necessary as well.
+
+1.  prctl() Interface
+---------------------
+
+Before the program emits their first icache flushing instruction, the program
+must call this prctl().
+
+* prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, unsigned long ctx, unsigned long per_thread)
+
+	Sets the icache flushing context. If per_thread is 0, context will be
+	applied per process, otherwise if per_thread is 1 context will be
+	per-thread. Any other number will have undefined behavior.
+
+	* :c:macro:`PR_RISCV_CTX_SW_FENCEI`: Allow fence.i to be called in
+	  userspace.
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
+		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI, 0);
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
2.42.0

