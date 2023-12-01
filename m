Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB7A8004B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377745AbjLAHVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377723AbjLAHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:21:38 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A94171B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:21:44 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d7e56f6845so137963a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701415304; x=1702020104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lx4pJqeLQkX2l7a2Uj8+Wz4Hfj2Aqr7p88PvDjFel2Y=;
        b=mWuGAM1vd2+xRH1c4JT24WoZleNOtHMdZrZMmF+mYnte5zuiYj0rIza5sRPTmbRVso
         67XXLhjHSj/Iw2KnPO9Eff/RP8pzft/57GaZ1ZWdIPE/mB6UfLhUQGF+6INqmWrS2aBQ
         tGnPJOWdgCcntyJ85DKgOXtqr24KHKu5m1D36t5loNprLLYfNR9S57Lx8tQTMZWfJJxd
         YLkkQyHZ59jmcCqPplqwOYAYBDYD4onUgD9/Ls/e842s9aXm6AO1p5o07nlaMVFrfFcK
         f0eDc++ungNNmnL1DBsGBzb4XctP542AmyHxDpqhbm+GLCie9Gbt9tR9kcfT0YQvpry6
         7aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701415304; x=1702020104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx4pJqeLQkX2l7a2Uj8+Wz4Hfj2Aqr7p88PvDjFel2Y=;
        b=bap31DkKSS75JbBBkaWarwsShI0XqOMZ//yvKOQX5z9GMBv5hyBUjkwAXxKlsg4Z8B
         iLLclSqVfvbPrwKY25pd3Xi5Hq32EWwpmiAkm6OIqhU5Cog2LFnK33kLX/0dr/APjBw7
         THaLXoPuZXY4mVT/Mg3pV8WB13h7XMs2yKJOlUMb45QXY9A0nTFtg1z7DOcFlESSWiCz
         xMdarSgdLQJlRGpr2cBxe/eoakhaoAzvE39gk5ExzS/LpoBiYCFNs/+IV9wq3TJP4I3i
         c3ZpzLldGd7HGmAcatBlT+iO8LpEtoZYnpbljQa1annDNf/DzGfefA4dRIITclpXeieL
         +Hbw==
X-Gm-Message-State: AOJu0YxSyZaWh4bAkohZft8/2bwHmy84Fk5zAUf3cVOA+hTSa+RLME3F
        ENpQeJYGEM9r/aDRBqxvXdcuqw==
X-Google-Smtp-Source: AGHT+IFUcUIHDgdwfCVYyL4o5c4BDgr02ibZtA9XEgfKC9fOQ43iDs6oEK1YpPurFoi/zLQbnMhzVw==
X-Received: by 2002:a05:6830:150c:b0:6d6:4c92:1ad with SMTP id k12-20020a056830150c00b006d64c9201admr1969626otp.32.1701415303914;
        Thu, 30 Nov 2023 23:21:43 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id v23-20020a0568301bd700b006d7f8da1b57sm412662ota.62.2023.11.30.23.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:21:43 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 30 Nov 2023 23:21:36 -0800
Subject: [PATCH v2 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-fencei-v2-2-2cb623ab1b1f@rivosinc.com>
References: <20231130-fencei-v2-0-2cb623ab1b1f@rivosinc.com>
In-Reply-To: <20231130-fencei-v2-0-2cb623ab1b1f@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701415300; l=4185;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=hE84m76gkQJA/iXGNtGqIi6V8ZB1KoiveuBHwIO+MBE=;
 b=90cANh8VzeUQk9JDEqGGsPwauGfJ6Mm0G/dna22vaYJocuBEYP+Hg5WpcF+z54R62WrCk1Mfs
 SpgzhUMflqNB+n5Nj8uLozaWjA+tq/gtSV/pMwLAtm8+uDSZ7w4nVJA
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
2.34.1

