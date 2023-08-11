Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29479779B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbjHKXgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbjHKXgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:36:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578D710E6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:36:06 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-564f73e2c59so3068183a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691796966; x=1692401766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqSttns2QMMHKhEq1iT/6N0civk3/DgixVYj3d7z750=;
        b=X34fuYj30ll5ylhB7Aqg1vD8KbeZ19k7cBalDKC4+jHgFwr/RyYNj6Pr6V61x2DfL+
         EJCnT8nIK0diol/XAn3zkp0CBQHYK32A+lAxwsdw8V0WmgFSaGLh6MeDrKTy+O1YtGQL
         lRW4ToSimJ7KM73g7/WgJ/lZD0oHxf4tn3qUdGyg4O4aRd94vZCmXlgckCK9wtoEnTIx
         By1wmnSVOyT/6qltlLMq/NHoH3JbmEp+o19oXoVJJzJxY75DUC/F8bAwXqxVHXMraBwG
         CNQJwBuxXfuA8b8ReBpbrRr4G875agXduf79V73IbjdTK0GMrf/tPtRPCyES9mwJzUQL
         9upw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796966; x=1692401766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqSttns2QMMHKhEq1iT/6N0civk3/DgixVYj3d7z750=;
        b=GinBnmCNfhfGJsLQMsbdj8C5iUf8Dk47IEteW+tS8ZXg6f/Xk3I8zpPKa5HTxJDi0h
         Hcvoz4gdM7ZzdGyvoIK7Eo1H0m/fEMWCcLa4U/5EUSYgSQdviPyFD/LaFtyZk6eZn4Tk
         MIEVkn6uKF3O6Aw6jVWJhOviDgVjWv4nTWxE3tW8HSfH7YOI+B+d98oEBCBidwl3NmB9
         nO2nn31Wupv9F9QIPyOrviGcE86f2e+/p0YLGddxqOhMGkrIKJ1TJyBlqNHyoshbcAo0
         ewo6FzvoZgmkAo6Ng7SNGoZm5w50df9lPnQOTFuGHFHjoT5nqXepzUXeaoLPPimVBNzr
         4PXw==
X-Gm-Message-State: AOJu0Yy0KKq/NMbeHDB2LDzyk8GnXFOWI8tOHUC6eFp290rBFWfh3ftm
        IxV0rOErr46YwIW18H6mToA0c87wNdl6WDtOVQI=
X-Google-Smtp-Source: AGHT+IHmoLAUiv8fk25rU3LsIqT4bGf0NYp3Jdy7r9PrFn7vgSF/A8z6XY7y0W3PdKsPxdaEB7q92Ncr+0mp/5dgQt8=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:da90:b0:1bc:8249:2547 with
 SMTP id j16-20020a170902da9000b001bc82492547mr1100101plx.12.1691796965861;
 Fri, 11 Aug 2023 16:36:05 -0700 (PDT)
Date:   Fri, 11 Aug 2023 23:36:00 +0000
In-Reply-To: <20230811233556.97161-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230811233556.97161-7-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3217; i=samitolvanen@google.com;
 h=from:subject; bh=tt28FmYKneUlEuS934Ul5UfwYg3GE/8Wy9t+zpPCYws=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk1sXcZHCAlTnd4EYJhbusgalCGC+w098BuJsGg
 pjfWx3ysWCJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZNbF3AAKCRBMtfaEi7xW
 7vtjC/9aDXQZ1XeqW1KEFEIdmhB56J7RualjvUaGwqw1lObaqRwOTOHqVWWF23giW/63wj+kC2d
 uHjLduotttcVZkHZsC6bSVritbMUdqcBJPktHpbake9N1DDHjOKuNQV7Nb8/N4fdKLoTbsIhX8J
 c9wUZRHH+uECCk0s/Vthl8g0IjkG8bxxiTWZPmj9U6cBnZreRQNTMLyS0VAeDbMe1fDLYwCxUOD
 m7jKpu3cmKHJ0+q07Tw7ImOGqjT+v/47NwVRAfE3wnQ2qG23TXar0JY6Ve/GXc8Cl5iQqIkW8I6
 vqNSlOuam4C9fCr1mNVlroRnndKOjNwoqNMGFOpCRRtZboI2i9jEI4sy77bqFyu9Z2AaZODMEky
 Z8lDTU3yZB+Dfy0y9jrRLlFmdooFQZZqg92id+407SgbATsSpewepWk6+xfbx/2ctL/zCdrzrKE Wqbc1Mw5wnbcu9O9FXMhy5KyHuHKxN0/EpYpF8+0511pfnh6hGOTgck63WxCg0nkRDL/o=
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811233556.97161-10-samitolvanen@google.com>
Subject: [PATCH 3/5] riscv: Move global pointer loading to a macro
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Guo Ren <guoren@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
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
---
 arch/riscv/include/asm/asm.h      |  8 ++++++++
 arch/riscv/kernel/entry.S         |  6 ++----
 arch/riscv/kernel/head.S          | 15 +++------------
 arch/riscv/kernel/suspend_entry.S |  5 +----
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 13815a7f907a..c53388f784a2 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -103,6 +103,14 @@
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
index 39875f5e08a6..2b4248c6b0a9 100644
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
index 11c3b94c4534..79b5a863c782 100644
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
index 12b52afe09a4..556a4b166d8c 100644
--- a/arch/riscv/kernel/suspend_entry.S
+++ b/arch/riscv/kernel/suspend_entry.S
@@ -60,10 +60,7 @@ END(__cpu_suspend_enter)
 
 ENTRY(__cpu_resume_enter)
 	/* Load the global pointer */
-	.option push
-	.option norelax
-		la gp, __global_pointer$
-	.option pop
+	load_global_pointer
 
 #ifdef CONFIG_MMU
 	/* Save A0 and A1 */
-- 
2.41.0.640.ga95def55d0-goog

