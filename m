Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E307CF430
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbjJSJkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjJSJks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:40:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB56B8;
        Thu, 19 Oct 2023 02:40:46 -0700 (PDT)
Date:   Thu, 19 Oct 2023 09:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697708444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUJTtqQy8fxReyCCLvdrNXSV2ZMQEboWT57HId+dVGE=;
        b=GVsg1dGe2b5VqgRj8oOnpSoxwVcc4fUyoxTH6aK82wRyJbigYF2CbmxqxwibTExKCC1UOy
        hCaROgeG5utE114eJUhlilEQ11Xe0P4ndEh70LW79pm9LW4rvLF5dQQSB5ppgNgZzPz7D4
        Za3AsBmftO1S3kcvg2nmLNjndtnLoU88IOgwvHn5ZXi5P7+1Yf3ggYrV2SONgxAzSZjcFN
        H56Fl5w3CoQb99rG5wWRgNDaWxVICkzbk3IqHTlzFzNs/Z8V9Qcy1oOjorVKag/+DHtXKE
        aatsRpL45IklnWsQU/2ej0lqP3Q/0W7XydHMPGBINT3e+lCwxssiuiiv8WL8Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697708444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yUJTtqQy8fxReyCCLvdrNXSV2ZMQEboWT57HId+dVGE=;
        b=OxQf2vEeXbrfrcCTSabG30/pepop5YpP2nMyiL10w1ldPbi7ZKvPtFAoXeC9s5AZzFB6wx
        l7nxghLbpd0OnFBA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Cc:     David Howells <dhowells@redhat.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
References: <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
MIME-Version: 1.0
Message-ID: <169770844297.3135.7611435585309229027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     59e6ce1eaaa2d9b2f9c89a108ce3fc7510bcd7ea
Gitweb:        https://git.kernel.org/tip/59e6ce1eaaa2d9b2f9c89a108ce3fc7510bcd7ea
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 19 Oct 2023 11:09:41 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 11:25:19 +02:00

Revert "x86/retpoline: Remove .text..__x86.return_thunk section"

This reverts commit e92626af3234708fe30f53b269d210d202b95206.

David Howells reported his box freezing without being able to see
a panic. However, it managed to issue a warning beforehand:

  missing return thunk: __x86_indirect_thunk_r15+0xa/0x5f-0x0: eb 74 66 66 2e
  WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:755 apply_returns+0xca/0x247
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.0-rc5-next-20231013-build3+ #3044
  Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
  RIP: 0010:apply_returns+0xca/0x247

this happened with linux-next and with gcc 13. Looking at the compiler
output and particularly paying attention to the two JMP instructions:

  <__x86_indirect_thunk_r14>:
         e8 01 00 00 00          call   ffffffff81d71206 <__x86_indirect_thunk_r14+0x6>
         cc                      int3
         4c 89 34 24             mov    %r14,(%rsp)
         e9 91 00 00 00          jmp    ffffffff81d712a0 <__x86_return_thunk>
         66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
         00 00 00 00
         66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

  <__x86_indirect_thunk_r15>:
         e8 01 00 00 00          call   ffffffff81d71226 <__x86_indirect_thunk_r15+0x6>
         cc                      int3
         4c 89 3c 24             mov    %r15,(%rsp)
         eb 74                   jmp    ffffffff81d712a0 <__x86_return_thunk>

the second JMP is a short JMP one. This is likely some new gcc
optimization to size the JMP offsets and generate a small one if it
fits.

However, the apply_returns() logic does not expect a short JMP:

  if (op == JMP32_INSN_OPCODE)
        dest = addr + insn.length + insn.immediate.value;

and that JMP32_INSN_OPCODE is 0xe9.

Now, if __x86_return_thunk is in another section, the compiler cannot do
those shortcuts and will have to generate a JMP with a s32 offset.

As a matter of fact, the removal of the section  broke another case, see

  https://lore.kernel.org/r/20231010171020.462211-2-david.kaplan@amd.com

so revert for now until all the possible code generation issues have
been assessed, addressed and verified properly.

Reported-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local
---
 arch/x86/kernel/vmlinux.lds.S | 3 +++
 arch/x86/lib/retpoline.S      | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9cdb1a7..54a5596 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -132,7 +132,10 @@ SECTIONS
 		LOCK_TEXT
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
+#ifdef CONFIG_RETPOLINE
 		*(.text..__x86.indirect_thunk)
+		*(.text..__x86.return_thunk)
+#endif
 		STATIC_CALL_TEXT
 
 		ALIGN_ENTRY_TEXT_BEGIN
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 6376d01..d410aba 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -129,6 +129,8 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 
 #ifdef CONFIG_RETHUNK
 
+	.section .text..__x86.return_thunk
+
 #ifdef CONFIG_CPU_SRSO
 
 /*
