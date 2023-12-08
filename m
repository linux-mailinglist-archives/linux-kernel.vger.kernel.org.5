Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FB880A0F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573598AbjLHKa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573661AbjLHKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:30:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963421BFD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:28:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E3BC433C9;
        Fri,  8 Dec 2023 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702031328;
        bh=c9wlW1E1FDo8FxkgpVxLOzRtzdXB3eV3Ja8e79iiw3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AbpVdnfpsJ/aC6SSScCHBqjgOPMvcknjQnTyvOvG2u5HaGeryQI5Y1Smm5aigBEcE
         WrquRlTN5rpbzFrzfUQ1/ws42QWTJ49u4E90ZO0hq/4zGMsR6PJE05JlMApnXj7vBS
         iGa4a3CWHOAurdpZEt60Dg0+6tZJpZyq/Ee9kO6CIGzrtalyv4QMhM2zgfL6VkvFee
         IfTIdNGk7iwqzc6rs8wgUszJHC9YxyivKgz1pkC7QBS8Qaj3QtNR/aPZ17kzgGiiRo
         7H82TIjfsFxnWF2Q0961VMu6ODGkjoCxVkGj0zec+p+6GvtnuSJdkNSDqk6xXmPR7d
         IoY9UQ+Pe8Mvg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v4 22/33] tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
Date:   Fri,  8 Dec 2023 19:28:42 +0900
Message-Id: <170203132201.579004.3148503140553102819.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170203105427.579004.8033550792660734570.stgit@devnote2>
References: <170203105427.579004.8033550792660734570.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Rename ftrace_regs_return_value to ftrace_regs_get_return_value as same as
other ftrace_regs_get/set_* APIs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Newly added.
---
 arch/loongarch/include/asm/ftrace.h |    2 +-
 arch/powerpc/include/asm/ftrace.h   |    2 +-
 arch/s390/include/asm/ftrace.h      |    2 +-
 arch/x86/include/asm/ftrace.h       |    2 +-
 include/linux/ftrace.h              |    2 +-
 kernel/trace/fgraph.c               |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index a11996eb5892..a9c3d0f2f941 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -70,7 +70,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index 9e5a39b6a311..7e138e0e3baf 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -69,7 +69,7 @@ ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 5a82b08f03cd..01e775c98425 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -88,7 +88,7 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 0b306c82855d..a061f8832b20 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -64,7 +64,7 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(&(fregs)->regs, n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(&(fregs)->regs)
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(&(fregs)->regs)
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(&(fregs)->regs, ret)
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 79875a00c02b..da2a23f5a9ed 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -187,7 +187,7 @@ static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
 	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
 #define ftrace_regs_get_stack_pointer(fregs) \
 	kernel_stack_pointer(ftrace_get_regs(fregs))
-#define ftrace_regs_return_value(fregs) \
+#define ftrace_regs_get_return_value(fregs) \
 	regs_return_value(ftrace_get_regs(fregs))
 #define ftrace_regs_set_return_value(fregs, ret) \
 	regs_set_return_value(ftrace_get_regs(fregs), ret)
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 0ac242d22724..ff830e7f8966 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -783,7 +783,7 @@ static void fgraph_call_retfunc(struct ftrace_regs *fregs,
 	trace.rettime = trace_clock_local();
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	if (fregs)
-		trace.retval = ftrace_regs_return_value(fregs);
+		trace.retval = ftrace_regs_get_return_value(fregs);
 	else
 		trace.retval = fgraph_ret_regs_return_value(ret_regs);
 #endif

