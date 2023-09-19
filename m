Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DA67A5EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjISJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjISJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:53:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72E1A8;
        Tue, 19 Sep 2023 02:53:11 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:53:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695117189;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LWKVOZmSHQVat7OI2yqnNr29aoiVQYjvpRWKvK5Rjo=;
        b=B/xoHrvrAJzyRgUwLakZeAAmmLmNeOFZLoMMDeHdaOtW1S6JLx/EnBlYOVCEViraceHZws
        BLPiKF/r7LEX9g03HuXRaF0wv3yG7EYG2lE8wA9tOccc+3JeTUiR0S3Tp4oWRvkGOAUuUU
        JRV4ZpWf5gF+MXje7v9856dV2E8Rme0MsAFKw7EaPErzQjCf/qy9TZa20CV35p5v7nUkdp
        Oz0jELtKL+07gf/4+5ipi4FZu/QzrUJl+WV0efH7z7kEy6kHpSr47bgqjtq6putPkGl79V
        zdRGsrOOUdX31yPpWZkd7a793IS2x2k7i7JjyYUw10aA3cANn0OEipDwgj1CWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695117189;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LWKVOZmSHQVat7OI2yqnNr29aoiVQYjvpRWKvK5Rjo=;
        b=yIeuW7sXhniJxUIIO1PT9JA8E1SxrSM+cLqoxR+0AAfImNTSSBwyckLx9TpACezDEtbJWz
        PALLCtfr4QZdRqDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/retpoline: Remove .text..__x86.return_thunk section
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <291aad1dcb2d27c6241fe3f182d66119857757fd.1693889988.git.jpoimboe@kernel.org>
References: <291aad1dcb2d27c6241fe3f182d66119857757fd.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169511718913.27769.5314218173944719644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     c8b840f7767b3178cc5fd92b70cc4c06c37943ac
Gitweb:        https://git.kernel.org/tip/c8b840f7767b3178cc5fd92b70cc4c06c37943ac
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:05:02 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Sep 2023 11:42:48 +02:00

x86/retpoline: Remove .text..__x86.return_thunk section

The '.text..__x86.return_thunk' section has no purpose.  Remove it and
let the return thunk code live in '.text..__x86.indirect_thunk'.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/291aad1dcb2d27c6241fe3f182d66119857757fd.1693889988.git.jpoimboe@kernel.org
---
 arch/x86/kernel/vmlinux.lds.S | 3 ---
 arch/x86/lib/retpoline.S      | 2 --
 2 files changed, 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 54a5596..9cdb1a7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -132,10 +132,7 @@ SECTIONS
 		LOCK_TEXT
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
-#ifdef CONFIG_RETPOLINE
 		*(.text..__x86.indirect_thunk)
-		*(.text..__x86.return_thunk)
-#endif
 		STATIC_CALL_TEXT
 
 		ALIGN_ENTRY_TEXT_BEGIN
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 415521d..49f2be7 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -129,8 +129,6 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 
 #ifdef CONFIG_RETHUNK
 
-	.section .text..__x86.return_thunk
-
 #ifdef CONFIG_CPU_SRSO
 
 /*
