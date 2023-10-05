Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81F97B9F90
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjJEOZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjJEOX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:23:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A488A6E;
        Thu,  5 Oct 2023 01:28:41 -0700 (PDT)
Date:   Thu, 05 Oct 2023 08:28:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696494517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evv78FngNWctCCQEqys9FY9hmwWT89p4vAJNsmIFnPQ=;
        b=aObYPq5udMMfdIGZTa6kExWAL97kTfvpDf0PUvExGbpnJItcBgr3hihVemDnGJs2xKylUO
        Ewj5jkyhwpEcOkzfar04mYCplHjOSK/gwOqCh8Jje9a97Js/NiI2HMpJ7FqaUvzL8easUk
        HCjsyQH/LoJv91BcCcQfg5jLxmp7+R+5GClvXtpJFT/zbGapevsuWuu69uv1/0aKHhp/lZ
        +81Xv/3T2I7lRKMvQyGDOFYO596MYw0GoAWiL7PLjkA1AVxJAuHiT+vhJaw5wRwp2i7sKz
        3KN3xkbJi6Ed6pvQWO7MBxZ//2b9PmM7sHIg/8Jl1y5z/FXKnQgqPsAyZgpjlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696494517;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evv78FngNWctCCQEqys9FY9hmwWT89p4vAJNsmIFnPQ=;
        b=5olFckmS8ifLH2QY1VVYjppNKgUwC/cjygXTXciZV4oXgZmwdU3XCFU8qI/omCPK6myLNi
        qi1YS26NDE8n40Cg==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/64: Remove obsolete comment on tracing vs. SYSRET
Cc:     Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230721161018.50214-2-brgerst@gmail.com>
References: <20230721161018.50214-2-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <169649451666.3135.702628742900040217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     eb43c9b1517b48e2ff0d3a584aca197338987d7b
Gitweb:        https://git.kernel.org/tip/eb43c9b1517b48e2ff0d3a584aca197338987d7b
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 21 Jul 2023 12:10:12 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 10:06:42 +02:00

x86/entry/64: Remove obsolete comment on tracing vs. SYSRET

This comment comes from a time when the kernel attempted to use SYSRET
on all returns to userspace, including interrupts and exceptions.  Ever
since commit fffbb5dc ("Move opportunistic sysret code to syscall code
path"), SYSRET is only used for returning from system calls. The
specific tracing issue listed in this comment is not possible anymore.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20230721161018.50214-2-brgerst@gmail.com
---
 arch/x86/entry/entry_64.S | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f71664d..7574639 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -166,22 +166,9 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	jne	swapgs_restore_regs_and_return_to_usermode
 
 	/*
-	 * SYSCALL clears RF when it saves RFLAGS in R11 and SYSRET cannot
-	 * restore RF properly. If the slowpath sets it for whatever reason, we
-	 * need to restore it correctly.
-	 *
-	 * SYSRET can restore TF, but unlike IRET, restoring TF results in a
-	 * trap from userspace immediately after SYSRET.  This would cause an
-	 * infinite loop whenever #DB happens with register state that satisfies
-	 * the opportunistic SYSRET conditions.  For example, single-stepping
-	 * this user code:
-	 *
-	 *           movq	$stuck_here, %rcx
-	 *           pushfq
-	 *           popq %r11
-	 *   stuck_here:
-	 *
-	 * would never get past 'stuck_here'.
+	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
+	 * restoring TF results in a trap from userspace immediately after
+	 * SYSRET.
 	 */
 	testq	$(X86_EFLAGS_RF|X86_EFLAGS_TF), %r11
 	jnz	swapgs_restore_regs_and_return_to_usermode
