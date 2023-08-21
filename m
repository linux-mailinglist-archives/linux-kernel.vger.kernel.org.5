Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382317827E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjHUL1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjHUL1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:27:32 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB57E1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1692617251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AaBbIkfn9p9l4yJMvNsYXhE/NOocQB5JtPt6Lay/R1A=;
  b=Vp6cpnVJEeWrVvG7sCVhmYqG2ek6leq0l+e/uZxKV5Lz2RQYn9YQ3jCO
   biCWBriNH0d0ufbx1rsaiAETivtHcnfxWN0WsdPPbtOU+zR5eS3bPT3BS
   XwBYr0Q8asBwCWnyb+wZXBEIool35+h2gkYLgZ+EyWkYgsbeKH3pJOu7Y
   M=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 120127125
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:wZCvNqJW9S9PnCNLFE+ReJUlxSXFcZb7ZxGr2PjKsXjdYENShTwEm
 2RJUDqOPfeNYjP9eY13a4vi/R5Su5LQx99iTFdlqX01Q3x08seUXt7xwmUcnc+xBpaaEB84t
 ZV2hv3odp1coqr0/0/1WlTZhSAgk/rOHvykU7Ss1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 Jb5rta31GWNglaYCUpKrfrawP9TlK6q4mhA7gZnPaojUGL2zBH5MrpOfcldEFOgKmVkNrbSb
 /rOyri/4lTY838FYj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnVaPpIAHOgdcS9qZwChxLid/
 jnvWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I+QrvBIAzt03ZHzaM7H09c5qDGBMz
 9cWIQwWRU/AiuiX0JS1ePVj05FLwMnDZOvzu1llxDDdS/0nXYrCU+PB4towMDUY354UW6yEP
 oxANGQpNU6bC/FMEg5/5JYWteGknHTgNRZfr0qYv/Ef6GnP1g1hlrPqNbI5f/TTH50MxBnB/
 D+uE2LRPQ4+GMzF5Gq8wHOy39fAu3nFW9wIC+jtnhJtqALKnTFCYPEMbnO/oP+kmgu9VshZJ
 kg85CUjt+4x+VatQ927WAe3yFaOpjYVX9tdFb185Azl4rLZ/wuDFEAFSDBbYdArvcNwQiYlv
 neZz43BBjF1trCRD3WH+d+8ryu1OC0fKmIqZiIeSwYBpd75r+kbhBvFU5BmF6G4lPX8HD22y
 DePxAASjqsSgYgo3r2/9Fbvijeg4JPOS2Yd4ATUGGii9AJiY5CNfJGz5B7Q6vMoBImDQ1aCv
 FAAms6D/O4JEJeBnTCMR+NLG6umj96ZPznMqVpuGYQ97TOr+m7lcY043d1lDB43aIBeI2avO
 RKN/1oLv/e/IUdGc4dqboOzMe8kxJT7PoumW/r1fvxAUIR+IVrvED5VWWac2GXkkU4JmK45O
 IuGfcvEMUv2GZiL3xLtGb5DjOZDKjQWgDqKGMull0jPPa+2Pib9dFsTDLeZggnVBougqR6dz
 dtQPtDiJ/53ALynOXm/HWL+wDk3wZkH6XLe8JU/mg2reFAO9IQd5xj5mOhJRmCdt/4J/tokB
 1nkMqOi9HLxhGfcNSKBYW15ZbXkUP5X9CxqZ3FxYwr3hiV/MO5DCZvzkLNtIdEaGBFLl6YoH
 5Hphe3eahiwdtg302tENsSsxGCTXB+qmRiPL0KYjMsXJvZdq/jy0oa8JGPHrXBeZhdbQONi+
 9VMICuHG8tcL+mjZe6KAM+SI6SZ5CdNxbMsBxqZfbG+uizEqeBXFsA4tddvS+lkFPkJ7mLyO
 9q+afvAmdTwng==
IronPort-HdrOrdr: A9a23:I3T4iK72RiRWBsIBHwPXwObXdLJyesId70hD6qkRc3Nom6mj/P
 xG885rsiMc5AxxZJhYo6HkBEDiex3hHOBOkO0s1OyZLWrbUQKTRekJgOffKlvbakvDH4VmtZ
 uIHZIOc+EYJGIK7/rS0U2VFMsh3cnC0I3Av5al8561d3ASV0i31XYANjqm
X-Talos-CUID: =?us-ascii?q?9a23=3ACln2fmoD9u4L7FGdq1Qg3YPmUd0oc3/n53nZH1S?=
 =?us-ascii?q?TViVkQpyFb1Gi5Kwxxg=3D=3D?=
X-Talos-MUID: 9a23:gqgJDwUM+g0cYsPq/ADzoB1ybuo42pavFhk1nrNchcraLzMlbg==
X-IronPort-AV: E=Sophos;i="6.01,190,1684814400"; 
   d="scan'208";a="120127125"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>, <x86@kernel.org>,
        "Borislav Petkov" <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, <David.Kaplan@amd.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RFC 3/4] x86/ret-thunk: Support CALL-ing to the ret-thunk
Date:   Mon, 21 Aug 2023 12:27:22 +0100
Message-ID: <20230821112723.3995187-4-andrew.cooper3@citrix.com>
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

This will be used to improve the SRSO mitigation.

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

RFC: __static_call_transform() with Jcc interpreted as RET isn't safe with a
transformation to CALL.  Where does this pattern come from?
---
 arch/x86/include/asm/nospec-branch.h |  1 +
 arch/x86/kernel/alternative.c        |  4 +++-
 arch/x86/kernel/cpu/bugs.c           |  1 +
 arch/x86/kernel/ftrace.c             |  8 +++++---
 arch/x86/kernel/static_call.c        | 10 ++++++----
 arch/x86/net/bpf_jit_comp.c          |  5 ++++-
 6 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index a4c686bc4b1f..5d5677bcf749 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -360,6 +360,7 @@ extern void entry_untrain_ret(void);
 extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
+extern bool x86_return_thunk_use_call;
 
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 extern void __x86_return_skl(void);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 099d58d02a26..215793fa53f5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -704,8 +704,10 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 
 	/* Patch the custom return thunks... */
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+		u8 op = x86_return_thunk_use_call ? CALL_INSN_OPCODE : JMP32_INSN_OPCODE;
+
 		i = JMP32_INSN_SIZE;
-		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
+		__text_gen_insn(bytes, op, addr, x86_return_thunk, i);
 	} else {
 		/* ... or patch them out if not needed. */
 		bytes[i++] = RET_INSN_OPCODE;
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 893d14a9f282..de2f84aa526f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -64,6 +64,7 @@ EXPORT_SYMBOL_GPL(x86_pred_cmd);
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
 void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
+bool x86_return_thunk_use_call __ro_after_init;
 
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
 static void update_spec_ctrl(u64 val)
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 12df54ff0e81..f383e4a90ce2 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -363,9 +363,11 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		goto fail;
 
 	ip = trampoline + size;
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
-	else
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+		u8 op = x86_return_thunk_use_call ? CALL_INSN_OPCODE : JMP32_INSN_OPCODE;
+
+		__text_gen_insn(ip, op, ip, x86_return_thunk, JMP32_INSN_SIZE);
+	} else
 		memcpy(ip, retq, sizeof(retq));
 
 	/* No need to test direct calls on created trampolines */
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 77a9316da435..b8ff0fdfa49e 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -81,9 +81,11 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 		break;
 
 	case RET:
-		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
-		else
+		if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+			u8 op = x86_return_thunk_use_call ? CALL_INSN_OPCODE : JMP32_INSN_OPCODE;
+
+			code = text_gen_insn(op, insn, x86_return_thunk);
+		} else
 			code = &retinsn;
 		break;
 
@@ -91,7 +93,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 		if (!func) {
 			func = __static_call_return;
 			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
-				func = x86_return_thunk;
+				func = x86_return_thunk; /* XXX */
 		}
 
 		buf[0] = 0x0f;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 438adb695daa..8e61a97b6d67 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -443,7 +443,10 @@ static void emit_return(u8 **pprog, u8 *ip)
 	u8 *prog = *pprog;
 
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
-		emit_jump(&prog, x86_return_thunk, ip);
+		if (x86_return_thunk_use_call)
+			emit_call(&prog, x86_return_thunk, ip);
+		else
+			emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
 		if (IS_ENABLED(CONFIG_SLS))
-- 
2.30.2

