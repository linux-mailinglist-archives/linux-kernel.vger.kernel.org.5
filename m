Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0687B48A0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjJAQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:31:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F300DA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 09:31:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b2cee40de8so516151766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696177905; x=1696782705; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8El4cLkGGgUHcgt3nQ8HQbnvPdNnTiEsIlTuhgH/0tI=;
        b=PzijhWEdeM+eS6vuuo9HiaFuW4OkFt1wGfnGQ0UyoC4XeKeS2j9942rUD3QUyf3d47
         eKUMjgzOCiwOfj6GZPJ32gDzJJM9b20VWWimAqExar15Y15wkcJ7g6LAJ9aoajRVl+9w
         41A5eyaGuNT68ifJg6YFiQgMLdujZMK74cKCyaeAMJBDhXDEH4FmoF/w5Uec7YCmPKxu
         Sssk3NGEb6/H+DiLsAPjD9IMaAxRjoLXjV1s9i9GWdko4g16el+JQB2210iNM9rzNrY2
         nmO3KdpdLylF+VODJpiyVUqofSxkydCnvBvIx7nnpvl10VdVHobJR+Vvb6EYbjnbQZhG
         X2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696177905; x=1696782705;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8El4cLkGGgUHcgt3nQ8HQbnvPdNnTiEsIlTuhgH/0tI=;
        b=ePJPsq/Jq5n6LVIFBnYA57mtjnTM5B6syi6uQ/CV4uZVqKR4n0z0uXwHjrRivo4BBm
         xvhhgHzvM3InTiVVxJQcX3WejdF4ZDyJj/5/bH4bZhkG08Z8H4Xf9+4KNjB4glB642ax
         gYXIK8X6j0+DSF54Hu/8SZ3CjPADgq+1IctQeHW+SvjrEuundgZQiiTgZr4ukCG8u1Ol
         fB0UVWJPjq7x8o3PJK16OMOPRTZbi2v1iDKREf1ADNggQ8PHlH/ZSUNGepHVUz8285Vk
         Rze+ZlN9ZKFf/i3CvdRimKGrJs28gtVR+61Mb3KILehdYnqwxVgiBSefzAf7nMdwfLI7
         +Pag==
X-Gm-Message-State: AOJu0YxRiNhf+bSTs+bD9iBJoMOGFJYg2BtMLJlnkz2iKPYs4BgM6h2C
        dmruTj9poKtgR4Jl6T4pNoamNsxaRQ==
X-Google-Smtp-Source: AGHT+IFwrCXMco7zopCn1O4Ic44wBqlsP1u0BUtv9sQGz1p92g0mnDC2cPgzBTESnR9ao8lOAH67bA==
X-Received: by 2002:a17:907:2d88:b0:9ae:5879:78dd with SMTP id gt8-20020a1709072d8800b009ae587978ddmr8962209ejc.1.1696177904348;
        Sun, 01 Oct 2023 09:31:44 -0700 (PDT)
Received: from p183 ([46.53.250.67])
        by smtp.gmail.com with ESMTPSA id gx10-20020a170906f1ca00b0099cb349d570sm15652838ejb.185.2023.10.01.09.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 09:31:43 -0700 (PDT)
Date:   Sun, 1 Oct 2023 19:31:41 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86_64: test that userspace stack is in fact NX
Message-ID: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is how it works:

* fault and fill the stack from rsp with int3 down until rlimit allows,
* fill upwards with int3 too, overwrite libc stuff, argv, envp,
* try to exec int3 on each page and catch it with either SIGSEGV or
  SIGTRAP handler.

Note: trying to execute _every_ int3 takes 30-40 seconds even on fast
machine, so only 1 int3 per page is tried.

Tested on F37 kernel and on custom kernel which did

	vm_flags |= VM_EXEC;

to stack VMA.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/x86/Makefile   |    3 
 tools/testing/selftests/x86/nx_stack.c |  167 +++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -19,6 +19,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
 			corrupt_xstate_header amx lam test_shadow_stack
+TARGETS_C_64BIT_ONLY += nx_stack
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -109,3 +110,5 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
 # state.
 $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
 $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
+
+$(OUTPUT)/nx_stack_64: CFLAGS += -Wl,-z,noexecstack
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/x86/nx_stack.c
@@ -0,0 +1,167 @@
+/*
+ * Copyright (c) 2023 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/*
+ * Test that userspace stack is NX.
+ * Requires linking with -Wl,-z,noexecstack .
+ *
+ * Fill the stack with int3's and then try to execute some of them:
+ * SIGSEGV -- good, SIGTRAP -- bad.
+ */
+#undef _GNU_SOURCE
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/resource.h>
+#include <unistd.h>
+
+#define PAGE_SIZE 4096
+
+/*
+ * This is memset(rsp, 0xcc, -1); but down.
+ * It will SIGSEGV when bottom of the stack is reached.
+ * Byte-size access is important! (see rdi tweaking in the signal handler).
+ */
+void make_stack1(void);
+asm(
+".pushsection .text\n"
+".globl make_stack1\n"
+".align 16\n"
+"make_stack1:\n"
+	"mov %rsp, %rdi\n"
+	"mov $0xcc, %eax\n"
+	"mov $-1, %rcx\n"
+	"std\n"
+	"rep stosb\n"
+	"hlt\n"
+".type make_stack1,@function\n"
+".size make_stack1,.-make_stack1\n"
+".popsection\n"
+);
+
+/*
+ * memset(p, 0xcc, -1);
+ * It will SIGSEGV when top of the stack is reached.
+ * Byte-size access is important! (see rdi tweaking in the signal handler).
+ */
+void make_stack2(uint64_t p);
+asm(
+".pushsection .text\n"
+".globl make_stack2\n"
+".align 16\n"
+"make_stack2:\n"
+	"mov $0xcc, %eax\n"
+	"mov $-1, %rcx\n"
+	"cld\n"
+	"rep stosb\n"
+	"hlt\n"
+".type make_stack2,@function\n"
+".size make_stack2,.-make_stack2\n"
+".popsection\n"
+);
+
+static volatile int test_state = 0;
+static volatile uint64_t stack_min_addr;
+
+static void sigsegv(int _, siginfo_t *__, void *uc_)
+{
+	ucontext_t *uc = uc_;
+
+	if (test_state == 0) {
+		/* Stack is faulted and cleared from rsp to the lowest address. */
+		stack_min_addr = ++uc->uc_mcontext.gregs[REG_RDI];
+		if (1) {
+			printf("stack min %016lx\n", stack_min_addr);
+		}
+		uc->uc_mcontext.gregs[REG_RIP] = (uintptr_t)&make_stack2;
+		test_state = 1;
+	} else if (test_state == 1) {
+		/* Stack has been cleared from top to bottom. */
+		uint64_t stack_max_addr = uc->uc_mcontext.gregs[REG_RDI];
+		if (1) {
+			printf("stack max %016lx\n", stack_max_addr);
+		}
+		uc->uc_mcontext.gregs[REG_RIP] = stack_max_addr - PAGE_SIZE;
+		test_state = 2;
+	} else if (test_state == 2) {
+		/* SIGSEGV while trying to execute int3 on stack -- PASS. */
+		uc->uc_mcontext.gregs[REG_RIP] -= PAGE_SIZE;
+		if (uc->uc_mcontext.gregs[REG_RIP] == stack_min_addr) {
+			/* One more SIGSEGV and test ends. */
+			test_state = 3;
+		}
+	} else {
+		_exit(EXIT_SUCCESS);
+	}
+}
+
+static void sigtrap(int _, siginfo_t *__, void *uc_)
+{
+	/* SIGTRAP while trying to execute int3 on stack -- FAIL. */
+	_exit(EXIT_FAILURE);
+}
+
+int main(void)
+{
+	{
+		struct sigaction act = {};
+		sigemptyset(&act.sa_mask);
+		act.sa_flags = SA_SIGINFO;
+		act.sa_sigaction = &sigsegv;
+		int rv = sigaction(SIGSEGV, &act, NULL);
+		assert(rv == 0);
+	}
+	{
+		struct sigaction act = {};
+		sigemptyset(&act.sa_mask);
+		act.sa_flags = SA_SIGINFO;
+		act.sa_sigaction = &sigtrap;
+		int rv = sigaction(SIGTRAP, &act, NULL);
+		assert(rv == 0);
+	}
+	{
+		struct rlimit rlim;
+		int rv = getrlimit(RLIMIT_STACK, &rlim);
+		assert(rv == 0);
+		// Cap stack at time-honored 8 MiB value.
+		rlim.rlim_max = rlim.rlim_cur;
+		if (rlim.rlim_max > 8 * 1024 * 1024) {
+			rlim.rlim_max = 8 * 1024 * 1024;
+		}
+		rv = setrlimit(RLIMIT_STACK, &rlim);
+		assert(rv == 0);
+	}
+	{
+		/*
+		 * Regular stack is overwritten completely during testing.
+		 * All the useful work is done in the signal handlers.
+		 */
+		const size_t len = (MINSIGSTKSZ + PAGE_SIZE - 1) / PAGE_SIZE * PAGE_SIZE;
+		void *p = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+		assert(p != MAP_FAILED);
+		stack_t ss = {};
+		ss.ss_sp = p;
+		ss.ss_size = len;
+		int rv = sigaltstack(&ss, NULL);
+		assert(rv == 0);
+	}
+	make_stack1();
+	__builtin_trap();
+}
