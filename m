Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91307827E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjHUL1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjHUL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:27:34 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59DADC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692617252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1HW46bmN5gTCDyixXWuEoooskgAuCfkqmMG1YurF3o=;
  b=Htu+yT5Qc6GDVWpIWqhQLJI1U5kBHWplgLOHV6m+gBAnqmPTIannV7Ri
   OUT1RV2k7Z7D8jriSOyqQ8r/GFzJUdSTLFYc5wQMhEFDDJvkutZ3SSIr0
   RuWhFnm2J0hJrgk3G7Kk5BWI/tt5bWJ1uiJj4QZW4U7q4TWPEjs6404si
   E=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 120127127
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:hHN6NKiFkwIOvBECYc0MmnzvX161yRAKZh0ujC45NGQN5FlHY01je
 htvDzqOaPvcYGunf9siOtjg/U4PvZTQy981QAc6pS4yEyIb9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsx+qyr0N8klgZmP6sT7AWHzyN94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tQFJTEPVDuNjt6t6+34R+NNluItHtXkadZ3VnFIlVk1DN4jSJHHBa7L+cVZzHE7gcUm8fT2P
 pRDL2A1NVKZPkMJYw1MYH49tL7Aan3XWjtUsl+K44Ew5HDe1ldZ27nxKtvFPNeNQK25m27B/
 DqfpTugWE5y2Nq37RSU9mK0ibD0vD7Kat8iNeOj3+BFjwjGroAUIEJPDgbqyRWjsWa6WtRCO
 wkX9zAooKwa6kOmVJ/+Uge+rXrCuQQTM/JaC8Uz7ACAzPqS7wvxLnAJUjNbevQnssEsTDAn3
 1PPmMnmbRR/4OO9Sn+H8LqQ6zSoNkA9L3cFZCoOSgYt4NT5pow3yBXVQb5LGqe/k5vwHj792
 RiDqSR4jLIW5eYn3ru68Rbkiiqor57hRws5oA7QWwqN6AJ6IoSifY2z7kbz9utbIcCSSVzpl
 Hcelsed7MgKDJeQhCKKXeMBFa2o4PDDNyfT6XZzEJ0x3zCs/WO/Z4dW4SE4KEoBDyofUWa3O
 gmJ41oXvcINeiLwNsebfr5dFew3wKniL//rX8zPRYUNb5JQZCmJzj1hMBv4M3/WrGAglqQ2O
 JG+eMmqDGoHBakP8AdaV9vxwpdwmHlgmDq7qYTTik3+jOHAPCL9paItagPmUwwv0E+TTOw5G
 f57PtDC9RhQWfaWjsL/od9KdgBiwZTW6PnLRy1rmgyreVMO9IIJUaW5LVYdl2tNxv89qwsw1
 ivhMnK0MXKm7ZE9FS2Ea2p4dJTkVotloHQwMEQEZAj5gSV+P9rwsfpDJvPbmIXLE8Q5kZZJo
 wQtIZ3cUpyjtByZk9jiUXUNhNM7L0n67e5/FyGkfCI+b/Zdq//ho7fZkv/U3HBWVEKf7JJuy
 4BMIyuHGfLvsSw+VpeJAB9upnvt1UUgdBVaBhSYf4gNIBS9r+CH6UXZ15cKHi3FEj2brhPy6
 upcKU5wSTXly2PtzOT0uA==
IronPort-HdrOrdr: A9a23:cQUcIatyvo+o8kzCqn2H7Z777skDWNV00zEX/kB9WHVpm62j+P
 xG+c5x6faaskd3ZJhNo7G90dC7MBbhHP1Oj7X5Q43SODUO41HYT72KhLGKq1eMdxEWkNQts5
 uIGJIfNDSfNykAsS/S2njbL/8QhPWB7aC0laP/4h5WPHtXgnhbnn5E49CgYzVLeDU=
X-Talos-CUID: 9a23:9lNV42G3leq6dm1oqmJ6+U8WIOsre0HG5yiTLkWZGUBneqGaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AW9TRnQx5xV3VRbOir4XtU7JxDziaqICAGUQdiZp?=
 =?us-ascii?q?ZgOiZBB4tCxbDlx2pbYByfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.01,190,1684814400"; 
   d="scan'208";a="120127127"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>, <x86@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, <David.Kaplan@amd.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RFC 4/4] x86/srso: Use CALL-based return thunks to reduce overhead
Date:   Mon, 21 Aug 2023 12:27:23 +0100
Message-ID: <20230821112723.3995187-5-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRSO safety depends on having a CALL to an {ADD,LEA}/RET sequence which
has been made safe in the BTB.  Specifically, there needs to be no pertubance
to the RAS between a correctly predicted CALL and the subsequent RET.

Use the new infrastructure to CALL to a return thunk.  Remove
srso_fam1?_safe_ret() symbols and point srso_fam1?_return_thunk().

This removes one taken branch from every function return, which will reduce
the overhead of the mitigation.  It also removes one of three moving pieces
from the SRSO mess.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: x86@kernel.org
CC: linux-kernel@vger.kernel.org
CC: Borislav Petkov <bp@alien8.de>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Babu Moger <babu.moger@amd.com>
CC: David.Kaplan@amd.com
CC: Nikolay Borisov <nik.borisov@suse.com>
CC: gregkh@linuxfoundation.org
CC: Thomas Gleixner <tglx@linutronix.de>

RFC:

  vmlinux.o: warning: objtool: srso_fam17_return_thunk(): can't find starting instruction

Any objtool whisperers know what's going on, and particularly why
srso_fam19_return_thunk() appears to be happy?

Also, depends on the resolution of the RFC in the previous patch.
---
 arch/x86/kernel/cpu/bugs.c    |  4 ++-
 arch/x86/kernel/vmlinux.lds.S |  6 ++---
 arch/x86/lib/retpoline.S      | 47 ++++++++++++++---------------------
 3 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index de2f84aa526f..c4d580b485a7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2458,8 +2458,10 @@ static void __init srso_select_mitigation(void)
 		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
 			/*
 			 * Enable the return thunk for generated code
-			 * like ftrace, static_call, etc.
+			 * like ftrace, static_call, etc.  These
+			 * ret-thunks need to call to their target.
 			 */
+			x86_return_thunk_use_call = true;
 			setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 			setup_force_cpu_cap(X86_FEATURE_UNRET);
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 127ccdbf6d95..ed7d4020c2b4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -522,7 +522,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_RETHUNK
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
-. = ASSERT((srso_fam17_safe_ret & 0x3f) == 0, "srso_fam17_safe_ret not cacheline-aligned");
+. = ASSERT((srso_fam17_return_thunk & 0x3f) == 0, "srso_fam17_return_thunk not cacheline-aligned");
 #endif
 
 #ifdef CONFIG_CPU_SRSO
@@ -536,8 +536,8 @@ INIT_PER_CPU(irq_stack_backing_store);
  * Instead do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((ABSOLUTE(srso_fam19_untrain_ret) | srso_fam19_safe_ret) -
-		(ABSOLUTE(srso_fam19_untrain_ret) & srso_fam19_safe_ret)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_fam19_untrain_ret) | srso_fam19_return_thunk) -
+		(ABSOLUTE(srso_fam19_untrain_ret) & srso_fam19_return_thunk)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index d8732ae21122..2b1c92632158 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -133,11 +133,11 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 #ifdef CONFIG_RETHUNK
 
 /*
- * srso_fam19_untrain_ret() and srso_fam19_safe_ret() are placed at
+ * srso_fam19_untrain_ret() and srso_fam19_return_thunk() are placed at
  * special addresses:
  *
  * - srso_fam19_untrain_ret() is 2M aligned
- * - srso_fam19_safe_ret() is also in the same 2M page but bits 2, 8, 14
+ * - srso_fam19_return_thunk() is also in the same 2M page but bits 2, 8, 14
  * and 20 in its virtual address are set (while those bits in the
  * srso_fam19_untrain_ret() function are cleared).
  *
@@ -145,7 +145,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  * target buffer of Zen3/4 generations, leading to any potential
  * poisoned entries at that BTB slot to get evicted.
  *
- * As a result, srso_fam19_safe_ret() becomes a safe return.
+ * As a result, srso_fam19_return_thunk() becomes a safe return.
  */
 #ifdef CONFIG_CPU_SRSO
 	.section .text..__x86.rethunk_untrain
@@ -155,7 +155,8 @@ SYM_START(srso_fam19_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	ASM_NOP2
 	lfence
-	jmp srso_fam19_return_thunk
+	call srso_fam19_return_thunk
+	ud2
 SYM_FUNC_END(srso_fam19_untrain_ret)
 __EXPORT_THUNK(srso_fam19_untrain_ret)
 
@@ -169,23 +170,17 @@ SYM_START(srso_fam19_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 SYM_FUNC_END(srso_fam19_untrain_ret)
 #endif
 
-SYM_START(srso_fam19_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
-	lea 8(%_ASM_SP), %_ASM_SP
+SYM_START(srso_fam19_return_thunk, SYM_L_GLOBAL, SYM_A_NONE)
 	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	lea 8(%_ASM_SP), %_ASM_SP
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_fam19_safe_ret)
+SYM_FUNC_END(srso_fam19_return_thunk)
 
 	.section .text..__x86.return_thunk
 
-SYM_CODE_START(srso_fam19_return_thunk)
-	UNWIND_HINT_FUNC
-	ANNOTATE_NOENDBR
-	call srso_fam19_safe_ret
-	ud2
-SYM_CODE_END(srso_fam19_return_thunk)
-
 /*
  * Some generic notes on the untraining sequences:
  *
@@ -194,13 +189,13 @@ SYM_CODE_END(srso_fam19_return_thunk)
  *
  * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
  * Retbleed sequence because the return sequence done there
- * (srso_fam17_safe_ret()) is longer and the return sequence must fully nest
+ * (srso_fam17_return_thunk()) is longer and the return sequence must fully nest
  * (end before) the untraining sequence. Therefore, the untraining
  * sequence must fully overlap the return sequence.
  *
  * Regarding alignment - the instructions which need to be untrained,
  * must all start at a cacheline boundary for Zen1/2 generations. That
- * is, instruction sequences starting at srso_fam17_safe_ret() and
+ * is, instruction sequences starting at srso_fam17_return_thunk() and
  * the respective instruction sequences at retbleed_return_thunk()
  * must start at a cacheline boundary.
  */
@@ -272,12 +267,12 @@ __EXPORT_THUNK(retbleed_untrain_ret)
  *
  * movabs $0xccccc30824648d48,%rax
  *
- * and when the return thunk executes the inner label srso_fam17_safe_ret()
+ * and when the return thunk executes the inner label srso_fam17_return_thunk()
  * later, it is a stack manipulation and a RET which is mispredicted and
  * thus a "safe" one to use.
  */
 	.align 64
-	.skip 64 - (srso_fam17_safe_ret - srso_fam17_untrain_ret), 0xcc
+	.skip 64 - (srso_fam17_return_thunk - srso_fam17_untrain_ret), 0xcc
 SYM_START(srso_fam17_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	.byte 0x48, 0xb8
@@ -288,26 +283,22 @@ SYM_START(srso_fam17_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
  * and execution will continue at the return site read from the top of
  * the stack.
  */
-SYM_INNER_LABEL(srso_fam17_safe_ret, SYM_L_GLOBAL)
+SYM_INNER_LABEL(srso_fam17_return_thunk, SYM_L_GLOBAL)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
 	lea 8(%_ASM_SP), %_ASM_SP
+	ANNOTATE_UNRET_SAFE
 	ret
 	int3
 	int3
 	/* end of movabs */
 	lfence
-	call srso_fam17_safe_ret
+	call srso_fam17_return_thunk
 	ud2
-SYM_CODE_END(srso_fam17_safe_ret)
+SYM_CODE_END(srso_fam17_return_thunk)
 SYM_FUNC_END(srso_fam17_untrain_ret)
 __EXPORT_THUNK(srso_fam17_untrain_ret)
 
-SYM_CODE_START(srso_fam17_return_thunk)
-	UNWIND_HINT_FUNC
-	ANNOTATE_NOENDBR
-	call srso_fam17_safe_ret
-	ud2
-SYM_CODE_END(srso_fam17_return_thunk)
-
 SYM_FUNC_START(entry_untrain_ret)
 	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
 		      "jmp srso_fam17_untrain_ret", X86_FEATURE_SRSO, \
-- 
2.30.2

