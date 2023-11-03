Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D047E0203
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377604AbjKCKt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377009AbjKCKtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:49:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47149D7;
        Fri,  3 Nov 2023 03:49:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50939d39d0fso2464128e87.1;
        Fri, 03 Nov 2023 03:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699008560; x=1699613360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=169suXpT7VRk77RVMMxsU7CLDbBWKNlomsFKTGqmE1I=;
        b=jWC6Ktl3EVp/8CBJtltpllVDllp3F+6M0HHwJ0sMNSxc21enJbyqaJLvJJ54gQ9qvC
         OoEtl8QTmEGytyNEocR+2KA6hskzxsQw2R2O/p718RzPPvNyq92cng/EMq0SUeWT7Wsj
         DCtG49VfKJVMC+znHJZ8TI5QPlzemCHQbWSyNlTsDiDDHmc9lEfFux6nRlSWpC3Lo/mI
         eRrg6cElVXpMO7Hlr/s8xQpO32j9QZYZdS2GwttLD1xjhgPyCnLpV7mcWw0YY93FVB93
         tAmMpzzHV4deFygzBOgBoE3KNeLFVH7BdBq0E0VEoSELf6SzTEZqZmpid8x6WxfWszWe
         fmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699008560; x=1699613360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=169suXpT7VRk77RVMMxsU7CLDbBWKNlomsFKTGqmE1I=;
        b=uf1fxZnvnGg/Cxf7UHiqqlRqTLBgKna3tqp/TPIn9mptR/8q5EB1aM9S+db2shMtxP
         cHaQYsBj6d3T92+mgJQCz0gbCWxw4G2yR61C+nI2G1vONXCB1BxDBb72cN07Vj2PU8LR
         LWfNqzXoRqUoSjDntdBtl8INTMtnvM6YUOOn/P06tWLIf+jsgwcOyosC5mUyZHKzvbOI
         25iZfVlrm92nITjoudPmHGPKjKrudCFm9xj6kfxKtD1wnDAGxWtwb98o9/pffx94kQa1
         rCSztsvtKrJj9dV9E9yIwfa25+KyZ5r4ugaoAizDG/2a3Z32KIA0uLLX/BbehXpAeHOD
         8+Hg==
X-Gm-Message-State: AOJu0YxAJJLUosNXF2ePzQiTBvUwderV4E8FEwDbQJyeO3fUkNmT363M
        euwxDdPipAcwi27RwqRwuU0=
X-Google-Smtp-Source: AGHT+IEeabyMF3vRQYMn5EqbLcLU3WxqQqNwp4yyFq1/XAL4nlRyOlm3C+YkCQAucC83J48/UHyXuA==
X-Received: by 2002:a05:6512:3b91:b0:503:9eb:d277 with SMTP id g17-20020a0565123b9100b0050309ebd277mr22314584lfv.49.1699008560046;
        Fri, 03 Nov 2023 03:49:20 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d4891000000b0032dbf32bd56sm1549322wrq.37.2023.11.03.03.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 03:49:19 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/acpi: Use %rip-relative addressing in wakeup_64.S
Date:   Fri,  3 Nov 2023 11:48:22 +0100
Message-ID: <20231103104900.409470-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instruction with %rip-relative address operand is one byte shorter than
its absolute address counterpart and is also compatible with position
independent executable (-fpie) build.

No functional changes intended.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/kernel/acpi/wakeup_64.S | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index d5d8a352eafa..94ff83f3d3fe 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -17,7 +17,7 @@
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
 SYM_FUNC_START(wakeup_long64)
-	movq	saved_magic, %rax
+	movq	saved_magic(%rip), %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
 	je	2f
@@ -33,14 +33,14 @@ SYM_FUNC_START(wakeup_long64)
 	movw	%ax, %es
 	movw	%ax, %fs
 	movw	%ax, %gs
-	movq	saved_rsp, %rsp
+	movq	saved_rsp(%rip), %rsp
 
-	movq	saved_rbx, %rbx
-	movq	saved_rdi, %rdi
-	movq	saved_rsi, %rsi
-	movq	saved_rbp, %rbp
+	movq	saved_rbx(%rip), %rbx
+	movq	saved_rdi(%rip), %rdi
+	movq	saved_rsi(%rip), %rsi
+	movq	saved_rbp(%rip), %rbp
 
-	movq	saved_rip, %rax
+	movq	saved_rip(%rip), %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 SYM_FUNC_END(wakeup_long64)
@@ -72,11 +72,11 @@ SYM_FUNC_START(do_suspend_lowlevel)
 
 	movq	$.Lresume_point, saved_rip(%rip)
 
-	movq	%rsp, saved_rsp
-	movq	%rbp, saved_rbp
-	movq	%rbx, saved_rbx
-	movq	%rdi, saved_rdi
-	movq	%rsi, saved_rsi
+	movq	%rsp, saved_rsp(%rip)
+	movq	%rbp, saved_rbp(%rip)
+	movq	%rbx, saved_rbx(%rip)
+	movq	%rdi, saved_rdi(%rip)
+	movq	%rsi, saved_rsi(%rip)
 
 	addq	$8, %rsp
 	movl	$3, %edi
-- 
2.41.0

