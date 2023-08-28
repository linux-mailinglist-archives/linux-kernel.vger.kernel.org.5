Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C593678B8DE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjH1T7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbjH1T6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:58:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DE1189
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d74a012e6a6so4432254276.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693252724; x=1693857524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GN6X1nlK+F0kjkEC50FG9os31FAuUCJYmCM49+1obnI=;
        b=q81rXqLshiF0sln/xS3h/1Wt74xT2Rdg2j7FkroNKWNJx+s5YHbY+oxX80kCoOEdXg
         Z7tbUBEmnha1x55o337Yu6Lp+PK9LnYIpjNDnXpf7Vvob1fBYdUFHdVNRYzgfh16aSLv
         eFNKGP5rRTkOAMSM3mrjAPNqs5knGLIBbNRZAC6qGU+CNi/lzLXAiQhO62xa0d/tNvJ+
         HZQCnftScs5HC5H/QHtUIo0uBGDaDIJXYW2D2SPFvrSpGGn81MfWM1OEFhJRudgn2+le
         WexQrz+RIoMq4d/FZyHuGt5KMF8ZH4GobjeJX5y+t0Ma6T4e2S48xP0NJhR5CYYZChPH
         OKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693252724; x=1693857524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GN6X1nlK+F0kjkEC50FG9os31FAuUCJYmCM49+1obnI=;
        b=GEyoWvVVKpe4fVkd5Y7FcmKYnxaOtIH8wdoTXyG/jv2Xd1KrgzEUE+nKWalR/iD1dJ
         W5574ZI+82dE4zwi63/3iybRDQQTakPd1GcO/xYCUu+p0KHgfuEFW8+5HnpCDqZ8JTJU
         QQwecIwGFzOWTB/8dKZJ5ZtI4Wdzp4hL87VZetRtEtjHe8HfXczOcWrLvJ2Mfe+0F0Qp
         6h05ZcUb/MHU7nPAEjWdB5LeTvuTI1e4vQwzCYGHY2LnBcosQ/g9LoaMMIsppzpmid49
         0c/JKYWo6G+afVlFIyBo4hahU3vD86L2bT5ho884eVHBuEJnGq18fy303HcbYT75Emli
         oSIg==
X-Gm-Message-State: AOJu0YzhnvWgasedoyqBOHHsBQdyL+es3z61JRGSxBzBDFYdYvgCQzYF
        i4BCbiW6JeavF90x1CpP/yF729b+0lcwpheSi70=
X-Google-Smtp-Source: AGHT+IH/uHwJj6+qOeylfRyEPqpB+nnMtItRxR7gf+ULc0gWYu3yZPJVS4kkyblR9fUvFWo2HvJU3EuGasR5rTd2B1w=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:9011:0:b0:d5d:b03c:49b2 with SMTP
 id s17-20020a259011000000b00d5db03c49b2mr820198ybl.11.1693252723904; Mon, 28
 Aug 2023 12:58:43 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:58:37 +0000
In-Reply-To: <20230828195833.756747-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230828195833.756747-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3271; i=samitolvanen@google.com;
 h=from:subject; bh=Chgku5okNNw1TPF+7h/tJxx5VnEIks6hZ2ypKsZTKYg=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBk7PxqRbtkifAND8x/XfLzfQWcnICH3txr02qPt
 4eiKf2aYjSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZOz8agAKCRBMtfaEi7xW
 7sqPC/4yfD8F4LJhON/0j9LDQmdASW7omk5GP9QTz9u9V2kMfasvvS5/J6shUYxruhqnrbLQBUp
 oZG+GjK1FZXYmm2NhWg4FLwoGp73evhYqS3wI+Ft3xabSmr5Na3lU51SZXDGqV8uyQ7euwUibuM
 1IB+PWku6qCOxTHa+PmjyOlXV/KauzFtIzwmz+0x5d45qcRehgOD29B8x93CCG4ocGo16RTP8LI
 F/iGt9KvESUFJHI8k0VjTovZNvf6YxjaSUpyeHxe3VVQSccGWV/T3h55eOORae0j0Myri46bWi6
 G6OIOjCjM5wvPYvwQTVyYFnbv5wTS0DJqhUWZt3ZEVviB/dFtXNBfxwtPWVuNItQMaZQ/8iaxqH
 ZZt1G2FWe/DvsQ5lHk95L6xpiDHTU8W8m68q4rh/0qju4f8K6jxJcN6sSbo2s98UyF1YVfErhSD UX5opXBgLT/rq9utajC5hslrYEgFPNP1pUHjVWRg8zD8f17xYD7/57e0gz+NISpgLceIs=
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230828195833.756747-11-samitolvanen@google.com>
Subject: [PATCH v3 3/6] riscv: Move global pointer loading to a macro
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0.rc2.253.gd59a3bf2b4-goog

