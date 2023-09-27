Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2C97B0F12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjI0WsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjI0WsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:48:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1971193
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d817775453dso18004640276.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695854887; x=1696459687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZRzZZUde58Au/vMHi9s1sr9e50uKHmMzB9hG9Emfi8=;
        b=MMvujdwYKXKRJprzFVBYU59g7lhPDJ0NYYc+URTCje5ajJID/En3NEuZG+lz8RD9tV
         WWxKmKcftzQipUbpFKnOu9WlGo4pxV59clWT1V/Ej/cp0yXW9ghY7OFnLLOYHn3OEOIC
         sOd7uukOAwhh5eFkOVR29lkdC3XtuLwgmfT+E1U2hbw06uScFMsnKwxnupGieEJgfmP0
         ir+/r/gstasy2rg2eu7aHe2RwlOsZzgJoCj6NSm+2svhonHu+n4TpvEAdDnZDo9WMJ+j
         d63j4WT8a7+4GiaEVdC0nna5m0l4c+D3I+k+MlQwV+qY9uDE5KF04DH/TqZnbLa/7YB6
         WPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695854887; x=1696459687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZRzZZUde58Au/vMHi9s1sr9e50uKHmMzB9hG9Emfi8=;
        b=bVCS5tMsXcpOnSse4LlCvxF5bmPz2O8vPzUNRJkq6x+CrddGG0dcrwDJEBQkBf+K09
         5yAFByDL1Z/JhCRIjmVpGXArsgIiMa1II6n9lFVUDjCz1c327IAkwxeI0h+crQ99YrrX
         49ylMlW/JQC4wdtOf5QRaBNU1tf5x99gEo+A6U0f5+ByIJ+RhsF+Yl4x45UmkP1gVszm
         wbwNs4SPlA6EPAjakdNpjMMMhNTKVTdN1HfMjDcB4vL5DQvAivkXl8UeMOlYzMJZwHPK
         CpTsOBiwM3F7ZDnKHTQW2dWAW6qHNLSn27DKU1QQGPdvCYQsxFT/8mm2n3PJhhVnldcr
         Cmyw==
X-Gm-Message-State: AOJu0Yx6R9ewwRyN3l3qYiIuFNRcXd7ruRnPGu7wJTbS/ef0JJ7lmKRp
        KCD/9Tk1hmu5TBCp75UIqrb8Lclr8ZGANoa/w9w=
X-Google-Smtp-Source: AGHT+IHxA01ww/gyg3znhBfLop3CsLNtadfoLfadsJ+aTBN8Cew9KjwVh2b0BcNDR7oyVphEb0igmcTzaPy309ZP/TI=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:77c8:0:b0:d86:56f4:e4a3 with SMTP
 id s191-20020a2577c8000000b00d8656f4e4a3mr47419ybc.13.1695854886912; Wed, 27
 Sep 2023 15:48:06 -0700 (PDT)
Date:   Wed, 27 Sep 2023 22:48:01 +0000
In-Reply-To: <20230927224757.1154247-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230927224757.1154247-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3282; i=samitolvanen@google.com;
 h=from:subject; bh=R9zKwYTLpHe6QQ7XyQD72MWWY4El/ER6AIXVUR/GJUM=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBlFLEdZRzIvfGvPyQVjyzKduUT/iUIvXAAcWfD+
 dGjTCtj8a6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZRSxHQAKCRBMtfaEi7xW
 7vxkC/4lyaxKokcSbtqaj17rhTY1rhzJjWKwRCnuvZWzRstnDuir45jKziPslpAWi1iVs4RHF5x
 qreszbKjdycXuhJYRxcRe6hhHwB+MraLf+Jmo9RRUrC5vJrRwF4G4jMYJlYoEvCtKXrin9W7kYA
 lSX1MRkRZB7fwcX+42TsHFgVDTdkCgHi2VXX9HyMdy1BEjocetNYmgpwSy3jb/2sYwU9rOeEP+d
 xPuWVYmhdclejB1IRxi1FlxFV9dtGt/8drHYZaS0+mhI+6oC98fA8xqDLchezP4eqDL2BbTrAop
 m4GCYz2lwbxsAvQuj/G8ryvpfdC9INZUpo49ZnuqH9bAEQFLNBDL8W24eDJfiIggFROFKvicuWf
 bmwVX9GWrCQzHkG6Z9sT735briNXedUmD5tg1TizousIT92Wq54P/gQRA4WXCwWgeZMTTTQ7m2M 4Akymo49EdgXk6dPjkQb4//KenjqGWTqBerQSlGLryhBvRQrAAVQW0OWp3/+xHxCLiuOs=
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230927224757.1154247-11-samitolvanen@google.com>
Subject: [PATCH v4 3/6] riscv: Move global pointer loading to a macro
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Clement Leger <cleger@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Clang 17, -fsanitize=shadow-call-stack uses the newly declared
platform register gp for storing shadow call stack pointers. As
this is obviously incompatible with gp relaxation, in preparation
for CONFIG_SHADOW_CALL_STACK support, move global pointer loading
to a single macro, which we can cleanly disable when SCS is used
instead.

Link: https://reviews.llvm.org/rGaa1d2693c256
Link: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/riscv/include/asm/asm.h      |  8 ++++++++
 arch/riscv/kernel/entry.S         |  6 ++----
 arch/riscv/kernel/head.S          | 15 +++------------
 arch/riscv/kernel/suspend_entry.S |  5 +----
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 8e446be2d57c..f34dd1a526a1 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -109,6 +109,14 @@
 	REG_L \dst, 0(\dst)
 .endm
 
+/* load __global_pointer to gp */
+.macro load_global_pointer
+.option push
+.option norelax
+	la gp, __global_pointer$
+.option pop
+.endm
+
 	/* save all GPs except x1 ~ x5 */
 	.macro save_from_x6_to_x31
 	REG_S x6,  PT_T1(sp)
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index a306562636e4..6215dcf2e83b 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -75,10 +75,8 @@ _save_context:
 	csrw CSR_SCRATCH, x0
 
 	/* Load the global pointer */
-.option push
-.option norelax
-	la gp, __global_pointer$
-.option pop
+	load_global_pointer
+
 	move a0, sp /* pt_regs */
 	la ra, ret_from_exception
 
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 3710ea5d160f..a0484d95d8fb 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -110,10 +110,7 @@ relocate_enable_mmu:
 	csrw CSR_TVEC, a0
 
 	/* Reload the global pointer */
-.option push
-.option norelax
-	la gp, __global_pointer$
-.option pop
+	load_global_pointer
 
 	/*
 	 * Switch to kernel page tables.  A full fence is necessary in order to
@@ -134,10 +131,7 @@ secondary_start_sbi:
 	csrw CSR_IP, zero
 
 	/* Load the global pointer */
-	.option push
-	.option norelax
-		la gp, __global_pointer$
-	.option pop
+	load_global_pointer
 
 	/*
 	 * Disable FPU & VECTOR to detect illegal usage of
@@ -228,10 +222,7 @@ pmp_done:
 #endif /* CONFIG_RISCV_M_MODE */
 
 	/* Load the global pointer */
-.option push
-.option norelax
-	la gp, __global_pointer$
-.option pop
+	load_global_pointer
 
 	/*
 	 * Disable FPU & VECTOR to detect illegal usage of
diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
index f7960c7c5f9e..d5cf8b575777 100644
--- a/arch/riscv/kernel/suspend_entry.S
+++ b/arch/riscv/kernel/suspend_entry.S
@@ -61,10 +61,7 @@ END(__cpu_suspend_enter)
 
 SYM_TYPED_FUNC_START(__cpu_resume_enter)
 	/* Load the global pointer */
-	.option push
-	.option norelax
-		la gp, __global_pointer$
-	.option pop
+	load_global_pointer
 
 #ifdef CONFIG_MMU
 	/* Save A0 and A1 */
-- 
2.42.0.515.g380fc7ccd1-goog

