Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFF67827DF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjHUL1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjHUL1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:27:32 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4262DD8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692617249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yDTMOJRMdi7G06/9ODMa+FNPZC6UKKWUpLyRjS0ysBg=;
  b=WP3c69eBaNo7WojizAfWbTNxfajsNy6ZzKEUON+QUovVj5PNF7NU/DTp
   B3Itt9kwp52p4kdix5t4QzYnVPpRVqE+nuhOMb47oHB71NGEvpJxucnwB
   /cuKhIsgZlVC/7K7MYNVnKyH89an33qi05KvapbGYVCdvmD/GGlNysd54
   c=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 120127123
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:x5N5n6m73bi0L4iBLErouBzo5gwoJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIaDTqGM/jfMWf3eo8nPdiwpkNT68KBzIA2GQBo+yo2ESMWpZLJC+rCIxarNUt+DCFhoGFPt
 JxCN4aafKjYaleG+39B55C49SEUOZmgH+a6U6icfHgqH2eIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWfVSowFaYCEpNg064gE0p5K2aVA8w5ARkPqgb5gaGzRH5MbpETU2PByqgKmVrNrbSq
 9brlNmR4m7f9hExPdKp+p6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTbZLwXXx/mTSR9+2d/
 f0W3XCGpaXFCYWX8AgVe0Ew/yiTpsSq8pefSZS0mZT7I0Er7xIAahihZa07FdRwxwp5PY1B3
 eEVKTI3RR6Ku/mdn/G2QMh8oMoRMMa+aevzulk4pd3YJfMvQJSFSKTW/95Imjw3g6iiH96HO
 ZBfM2A2Kk2dPVsWYAx/5JEWxY9EglHWdTFCpU3Tjq0w+2XJlyR60aT3McqTcduPLSlQth/C/
 jucoD2jWXn2MvSg7z+iwGqqqtbfhBLAAdMXSYGZy8xD1Qj7Kms7V0RNCArTTeOCokq/Xc9Pb
 k8Z4CwjqYAs+0GxCNrwRRu1pDiDpBF0c9BIO+Q+6QyLmuzY7m6xHmUYQyRTQN0gutU/STEj2
 hmOhdyBLSw/7pWWRGib+7PSqim9UQAXNWgDYCUDQCMG7sPlrYV1iQjAJv5pGaSoyNjyFjzq6
 zmPoG41gLB7peICyaS3u3POmzaloLDASwJz7QLSNkqj7wA/bom/Zpev93DA8O1Nao2eSzGps
 2IJlMuexOQPC4ydmiuQRukEALCu4bCCKjK0qUJgG4kJ8zWr5mK5eoZR8HdyKS9U3t0sIGGzJ
 hWJ4EUIucEVZSHxBUNqX26vI9knzKraPtrsauv/MZlDaLlhUgG14C47MCZ8wFvRuEQrlKg+P
 7KSfsCtEWsWBMxb8damewsO+eR1n35jnAs/Ubi+lk36iuTGOBZ5XJ9faDOzgvYFALRoSek/2
 /JWLIO0xhpWS4USiQGHoNdIfTjmwZXWbK0aSvC7lMbYe2KK+0l7UZc9JI/NnKQ8xMxoeh/gp
 C3VZ6Oh4AOXaYf7AQuLcGt/T7jkQIxyq3k2VQR1YwfyhiV9PdnysftOH3fSQVXA3LY/pcOYs
 tFfI5nQahixYmqvF8shgWnV89U5KUXDafOmNCu5ejkvF6OMtCSQkuIIijDHrXFUZgLu7JtWn
 lFV/l+DKXb1b1g4XZm+hTPG5w/ZgEXxb8orABuVc4cLKRSzmGWoQgSo5sIKzwg3AU2r7lOnO
 8y+WH/0ecGlT1cJzeT0
IronPort-HdrOrdr: A9a23:lvpwYKwd3imXRF7y0NA/KrPwAr1zdoMgy1knxilNoH1uHfBw8v
 rEoB11726StN98YhAdcKm7Scy9qBDnm6Kdn7NhWYtKBzOW21dARbsKheGOrwEIfReOkNK1vp
 0BT0ERMqyKMbFSt7eZ3CCIV/om3dmb4OSJqI7lvg1QpNhRGthdBtFCe36mLnE=
X-Talos-CUID: 9a23:jSS1lGzJmSR4BV0X7DoaBgUJF8EnSFbTxUvLCBD7BGxIWJube0OfrfY=
X-Talos-MUID: 9a23:toBYzwm8gNBloAweJLPRdnpdEsJP0byoJHkdiKQ94piBaBBRBgW02WE=
X-IronPort-AV: E=Sophos;i="6.01,190,1684814400"; 
   d="scan'208";a="120127123"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>, <x86@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, <David.Kaplan@amd.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/4] x86/srso: Rename srso_alias_*() to srso_fam19_*()
Date:   Mon, 21 Aug 2023 12:27:20 +0100
Message-ID: <20230821112723.3995187-2-andrew.cooper3@citrix.com>
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

The 'alias' name name is an internal detail of how the logic works.  Rename it
to state which microarchitecture is is applicable to.

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
---
 arch/x86/include/asm/nospec-branch.h |  4 ++--
 arch/x86/kernel/cpu/bugs.c           |  2 +-
 arch/x86/kernel/vmlinux.lds.S        |  8 +++----
 arch/x86/lib/retpoline.S             | 34 ++++++++++++++--------------
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c55cc243592e..93e8de0bf94e 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -350,11 +350,11 @@ static inline void __x86_return_thunk(void) {}
 
 extern void retbleed_return_thunk(void);
 extern void srso_return_thunk(void);
-extern void srso_alias_return_thunk(void);
+extern void srso_fam19_return_thunk(void);
 
 extern void retbleed_untrain_ret(void);
 extern void srso_untrain_ret(void);
-extern void srso_alias_untrain_ret(void);
+extern void srso_fam19_untrain_ret(void);
 
 extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f081d26616ac..92bec0d719ce 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2464,7 +2464,7 @@ static void __init srso_select_mitigation(void)
 
 			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-				x86_return_thunk = srso_alias_return_thunk;
+				x86_return_thunk = srso_fam19_return_thunk;
 			} else {
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
 				x86_return_thunk = srso_return_thunk;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 83d41c2601d7..c9b6f8b83187 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -147,10 +147,10 @@ SECTIONS
 
 #ifdef CONFIG_CPU_SRSO
 		/*
-		 * See the comment above srso_alias_untrain_ret()'s
+		 * See the comment above srso_fam19_untrain_ret()'s
 		 * definition.
 		 */
-		. = srso_alias_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
+		. = srso_fam19_untrain_ret | (1 << 2) | (1 << 8) | (1 << 14) | (1 << 20);
 		*(.text..__x86.rethunk_safe)
 #endif
 		ALIGN_ENTRY_TEXT_END
@@ -536,8 +536,8 @@ INIT_PER_CPU(irq_stack_backing_store);
  * Instead do: (A | B) - (A & B) in order to compute the XOR
  * of the two function addresses:
  */
-. = ASSERT(((ABSOLUTE(srso_alias_untrain_ret) | srso_alias_safe_ret) -
-		(ABSOLUTE(srso_alias_untrain_ret) & srso_alias_safe_ret)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
+. = ASSERT(((ABSOLUTE(srso_fam19_untrain_ret) | srso_fam19_safe_ret) -
+		(ABSOLUTE(srso_fam19_untrain_ret) & srso_fam19_safe_ret)) == ((1 << 2) | (1 << 8) | (1 << 14) | (1 << 20)),
 		"SRSO function pair won't alias");
 #endif
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index cd86aeb5fdd3..772757ea26a7 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -133,58 +133,58 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 #ifdef CONFIG_RETHUNK
 
 /*
- * srso_alias_untrain_ret() and srso_alias_safe_ret() are placed at
+ * srso_fam19_untrain_ret() and srso_fam19_safe_ret() are placed at
  * special addresses:
  *
- * - srso_alias_untrain_ret() is 2M aligned
- * - srso_alias_safe_ret() is also in the same 2M page but bits 2, 8, 14
+ * - srso_fam19_untrain_ret() is 2M aligned
+ * - srso_fam19_safe_ret() is also in the same 2M page but bits 2, 8, 14
  * and 20 in its virtual address are set (while those bits in the
- * srso_alias_untrain_ret() function are cleared).
+ * srso_fam19_untrain_ret() function are cleared).
  *
  * This guarantees that those two addresses will alias in the branch
  * target buffer of Zen3/4 generations, leading to any potential
  * poisoned entries at that BTB slot to get evicted.
  *
- * As a result, srso_alias_safe_ret() becomes a safe return.
+ * As a result, srso_fam19_safe_ret() becomes a safe return.
  */
 #ifdef CONFIG_CPU_SRSO
 	.section .text..__x86.rethunk_untrain
 
-SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_fam19_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ASM_NOP2
 	lfence
-	jmp srso_alias_return_thunk
-SYM_FUNC_END(srso_alias_untrain_ret)
-__EXPORT_THUNK(srso_alias_untrain_ret)
+	jmp srso_fam19_return_thunk
+SYM_FUNC_END(srso_fam19_untrain_ret)
+__EXPORT_THUNK(srso_fam19_untrain_ret)
 
 	.section .text..__x86.rethunk_safe
 #else
 /* dummy definition for alternatives */
-SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_fam19_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_alias_untrain_ret)
+SYM_FUNC_END(srso_fam19_untrain_ret)
 #endif
 
-SYM_START(srso_alias_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_START(srso_fam19_safe_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	lea 8(%_ASM_SP), %_ASM_SP
 	UNWIND_HINT_FUNC
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_alias_safe_ret)
+SYM_FUNC_END(srso_fam19_safe_ret)
 
 	.section .text..__x86.return_thunk
 
-SYM_CODE_START(srso_alias_return_thunk)
+SYM_CODE_START(srso_fam19_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	call srso_alias_safe_ret
+	call srso_fam19_safe_ret
 	ud2
-SYM_CODE_END(srso_alias_return_thunk)
+SYM_CODE_END(srso_fam19_return_thunk)
 
 /*
  * Some generic notes on the untraining sequences:
@@ -311,7 +311,7 @@ SYM_CODE_END(srso_return_thunk)
 SYM_FUNC_START(entry_untrain_ret)
 	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
 		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
-		      "jmp srso_alias_untrain_ret", X86_FEATURE_SRSO_ALIAS
+		      "jmp srso_fam19_untrain_ret", X86_FEATURE_SRSO_ALIAS
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
-- 
2.30.2

