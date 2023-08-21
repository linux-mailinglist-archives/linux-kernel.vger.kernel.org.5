Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2977827E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjHUL1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjHUL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:27:34 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4172FD8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692617251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ezMO0iJUqJFBWxwZvawEEwxXJbo/S2Voqg9EbMmdBwM=;
  b=WMcb6rLcftK2wvWySlsZ4Wk9tY7Ty4vJyCHq6lsfdigRH1vv7B36xoFb
   HW/M1sbprofSPeezCWxQqyXbiLbXYn54LNduqdwXWLhx09cu453Ac8ORV
   K0UHlhBH8AsTjEiVQ5OSVDcj+KR/TmJIILdZVMkgGXMPKCC0s1oX42Jdx
   U=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 120127126
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:emQNbK6aPM3w3Xjpokz74AxRtJHHchMFZxGqfqrLsTDasY5as4F+v
 mEYDTvTaK6KZjf3edpxPovi8kgD75HSz4BlSFZl+3tmHi5G8cbLO4+Ufxz6V8+wwm8vb2o8t
 plDNYOQRCwQZiWBzvt4GuG59RGQ7YnRGvynTraCYnsrLeNdYH9JoQp5nOIkiZJfj9G8Agec0
 fv/uMSaM1K+s9JOGjt8B5mr9lU35ZwehBtC5gZlPaAR5QeE/5UoJMl3yZ+ZfiOQrrZ8RoZWd
 86bpJml82XQ+QsaC9/Nut4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5iXBYoUm9Fii3hojxE4
 I4lWapc6+seFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpdFLjoH4EweZOUlFuhL7W5m6
 PEZKgomYBm/nMnpg7+xa/lKiPY/I5y+VG8fkikIITDxCP8nRdbIQrnQ5M8e1zA17ixMNa+AP
 YxDM2MpNUmeJUQVYT/7C7pn9AusrlD5fydVtxS+oq0v7nKI5AdwzKLsIJzefdniqcB9xxzA/
 ziZpj6nav0cHMed6yWl73mluujKsRPjSotISf6f+vE/1TV/wURMUUZLBDNXu8KRjk+4RsIaK
 EEO/CcqhbY9+VbtTdTnWRC85nmesXY0UcJ4Guk75QfdjKbZiy6BC3QJVCxpadoorsY6SDUmk
 FiTkLvBFWwxmL6YU3SQ8vGTtzzaESoNKm4HbygJZQgI+d/upMc0lB2nZtxqGrPzi9r6FCvYy
 jWG6iM5gt07occV1qn93lnfhzuqjpHMQkg+4QC/dmSk7UVzY5SkfIu2wUPG9vsGJ4GcJnGOp
 nULmMi26OEIEIGDkzGLTOwRHbavofGfP1X0nVFrD7El9jKw52Ske4FApj1zTHqFKe5dJ2WvO
 hWK/1oMutkKZiDCgbJLj5yZFskrz5LLG93ZTduLLddEQ4hXej2b83Q7DaKP5FzFnE8pmKA5H
 J6Ud8ewEHoXYZhaICqKq/Q1iuFymH1nrY/HbdWilkn8j+LCDJKAYe1dWGZieNzV+09tTO/91
 99Ef/WHxBxEOAEVSnmGqNVDRbzmwJVSOHwXlyC1XrXaSuaFMDt7YxM0/V/GU9U+95m5bs+So
 hmAtrZwkTITf0HvJwSQcWxEY7jyR5t5pn9TFXVybAz1hiZ/PtvysPZ3m34LkV4PrrAL8BKJZ
 6NdJ5Xo7gpnFFwrBAjxnbGi9dc/JXxHdCqFPja/YShXQnKTb1WhxzMQRSO2rHNmJnPu5aMDT
 0iIiluzrWwrG14zU647qZuHkzuMgJTqsLstDxaZfIECKRqEHUoDA3WZs8Lb6vokcX3rrgZ2H
 S7PafvEjYEhe7MIzeQ=
IronPort-HdrOrdr: A9a23:WMHK16lHw+C1ojlciogQVoC6fI7pDfIC3DAbv31ZSRFFG/Fw9v
 rAoB1/73TJYVkqKRYdcLy7WZVoOEmskKKdgrN+AV7dZniDhILyFvAA0WKK+VSJcUCTygc679
 YHT0EUMr3N5DZB/L3HCSCDYrQd6ejC3Ke0hfrPi1dBJDsaEZ2INj0JczpzxHcGPDV7OQ==
X-Talos-CUID: 9a23:KT3HRG+uu862WIAnAWGVv1MZG8IfWXPU8Gz7fAy1A0d5brOnVVDFrQ==
X-Talos-MUID: 9a23:lknUSQtPc0FhRq+SOM2nnzNAK+d16K2SD0UhoY0UspPZdgt8NGLI
X-IronPort-AV: E=Sophos;i="6.01,190,1684814400"; 
   d="scan'208";a="120127126"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>, <x86@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, <David.Kaplan@amd.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/4] x86/srso: Rename fam17 SRSO infrastructure to srso_fam17_*()
Date:   Mon, 21 Aug 2023 12:27:21 +0100
Message-ID: <20230821112723.3995187-3-andrew.cooper3@citrix.com>
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

The naming is inconsistent.  Rename it to fam17 to state the microarchitecture
it is applicable to, and to mirror the srso_fam19_*() change.

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
 arch/x86/kernel/vmlinux.lds.S        |  2 +-
 arch/x86/lib/retpoline.S             | 32 ++++++++++++++--------------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 93e8de0bf94e..a4c686bc4b1f 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -349,11 +349,11 @@ static inline void __x86_return_thunk(void) {}
 #endif
 
 extern void retbleed_return_thunk(void);
-extern void srso_return_thunk(void);
+extern void srso_fam17_return_thunk(void);
 extern void srso_fam19_return_thunk(void);
 
 extern void retbleed_untrain_ret(void);
-extern void srso_untrain_ret(void);
+extern void srso_fam17_untrain_ret(void);
 extern void srso_fam19_untrain_ret(void);
 
 extern void entry_untrain_ret(void);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 92bec0d719ce..893d14a9f282 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2467,7 +2467,7 @@ static void __init srso_select_mitigation(void)
 				x86_return_thunk = srso_fam19_return_thunk;
 			} else {
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
-				x86_return_thunk = srso_return_thunk;
+				x86_return_thunk = srso_fam17_return_thunk;
 			}
 			srso_mitigation = SRSO_MITIGATION_SAFE_RET;
 		} else {
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index c9b6f8b83187..127ccdbf6d95 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -522,7 +522,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 
 #ifdef CONFIG_RETHUNK
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
-. = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
+. = ASSERT((srso_fam17_safe_ret & 0x3f) == 0, "srso_fam17_safe_ret not cacheline-aligned");
 #endif
 
 #ifdef CONFIG_CPU_SRSO
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 772757ea26a7..d8732ae21122 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -194,13 +194,13 @@ SYM_CODE_END(srso_fam19_return_thunk)
  *
  * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
  * Retbleed sequence because the return sequence done there
- * (srso_safe_ret()) is longer and the return sequence must fully nest
+ * (srso_fam17_safe_ret()) is longer and the return sequence must fully nest
  * (end before) the untraining sequence. Therefore, the untraining
  * sequence must fully overlap the return sequence.
  *
  * Regarding alignment - the instructions which need to be untrained,
  * must all start at a cacheline boundary for Zen1/2 generations. That
- * is, instruction sequences starting at srso_safe_ret() and
+ * is, instruction sequences starting at srso_fam17_safe_ret() and
  * the respective instruction sequences at retbleed_return_thunk()
  * must start at a cacheline boundary.
  */
@@ -268,49 +268,49 @@ __EXPORT_THUNK(retbleed_untrain_ret)
 
 /*
  * SRSO untraining sequence for Zen1/2, similar to retbleed_untrain_ret()
- * above. On kernel entry, srso_untrain_ret() is executed which is a
+ * above. On kernel entry, srso_fam17_untrain_ret() is executed which is a
  *
  * movabs $0xccccc30824648d48,%rax
  *
- * and when the return thunk executes the inner label srso_safe_ret()
+ * and when the return thunk executes the inner label srso_fam17_safe_ret()
  * later, it is a stack manipulation and a RET which is mispredicted and
  * thus a "safe" one to use.
  */
 	.align 64
-	.skip 64 - (srso_safe_ret - srso_untrain_ret), 0xcc
-SYM_START(srso_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
+	.skip 64 - (srso_fam17_safe_ret - srso_fam17_untrain_ret), 0xcc
+SYM_START(srso_fam17_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_NOENDBR
 	.byte 0x48, 0xb8
 
 /*
  * This forces the function return instruction to speculate into a trap
- * (UD2 in srso_return_thunk() below).  This RET will then mispredict
+ * (UD2 in srso_fam17_return_thunk() below).  This RET will then mispredict
  * and execution will continue at the return site read from the top of
  * the stack.
  */
-SYM_INNER_LABEL(srso_safe_ret, SYM_L_GLOBAL)
+SYM_INNER_LABEL(srso_fam17_safe_ret, SYM_L_GLOBAL)
 	lea 8(%_ASM_SP), %_ASM_SP
 	ret
 	int3
 	int3
 	/* end of movabs */
 	lfence
-	call srso_safe_ret
+	call srso_fam17_safe_ret
 	ud2
-SYM_CODE_END(srso_safe_ret)
-SYM_FUNC_END(srso_untrain_ret)
-__EXPORT_THUNK(srso_untrain_ret)
+SYM_CODE_END(srso_fam17_safe_ret)
+SYM_FUNC_END(srso_fam17_untrain_ret)
+__EXPORT_THUNK(srso_fam17_untrain_ret)
 
-SYM_CODE_START(srso_return_thunk)
+SYM_CODE_START(srso_fam17_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	call srso_safe_ret
+	call srso_fam17_safe_ret
 	ud2
-SYM_CODE_END(srso_return_thunk)
+SYM_CODE_END(srso_fam17_return_thunk)
 
 SYM_FUNC_START(entry_untrain_ret)
 	ALTERNATIVE_2 "jmp retbleed_untrain_ret", \
-		      "jmp srso_untrain_ret", X86_FEATURE_SRSO, \
+		      "jmp srso_fam17_untrain_ret", X86_FEATURE_SRSO, \
 		      "jmp srso_fam19_untrain_ret", X86_FEATURE_SRSO_ALIAS
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
-- 
2.30.2

