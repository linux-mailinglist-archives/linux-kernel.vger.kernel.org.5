Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D2679DA84
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjILVD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjILVD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:03:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C2110D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:03:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5958487ca15so65940897b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694552632; x=1695157432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Su3tcyVoOXGTvjYADlVUH9iHtW/BbNEgdwa7PWlndEM=;
        b=vaVDmrEl26Pep/AtPLPwLv6imtcPN6P9V3il/4xD/fqc6mM62wtTMECYTimaPhIBVH
         Kbw+IP24D+nqt7+bXwG7SXzes+HOQj0rLGD4uxLgYK99p+Ddvq9rLmaM8EMd4xQOnZJV
         5dclwzP6No8swISOJPaRqOxa1gU2JCFUG67adUMcKsPaJF9ATua23b6B5zIZgBECDjpr
         YnopTDBgC4ahM3ljf6HDxS4Q2tOnLBpxGWA232D+vrHGEJ9JUiIuzaZuSUaSnFxpK3lr
         apCgYQ5OVUmmjAlx3b3pcwYw06XXp9Mb5s4N8UwZ2sdHJi+fmgX+sO9Xwd2M9/W6YlgE
         UdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552632; x=1695157432;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Su3tcyVoOXGTvjYADlVUH9iHtW/BbNEgdwa7PWlndEM=;
        b=wKycNVgxl2cHdgODAIFkgDRDvkmDSHqHcfM9dAWXSoA5gBjVtxAztx4uoXhWpm7yXs
         GHaY+Qy8fzgXqMwZfHay28CxGl0tUTMj/R/XsXmBi9+PgjKk7d7s9dS0wPv72i23RCyh
         0zpexZ6G0PMq2QycCrx30oKA3W4GeSqJ2q+bp3Zx5kL8cSbv0ou99sHFkaQOLbh+dY7K
         WXjfmvqID92/jRxVM6RGBTa40LSBmbBG7Q7rY2oKHQyCVEGI+SFKvhAkQmiUzoHHD9S6
         x6dCyoWwrpnUFIwSKsZ54+iryD0v1zlaDOS05D9f99prais5PrPs8elNiS9x53wzuUcT
         Z7Ew==
X-Gm-Message-State: AOJu0YxW3+T3EghwvI82+80Np8UW4i20MveSF3tE/MlRYxR4pn4H6Urc
        3CWUgouGnGevy11NBeX2/G9zUKxfw7h93y/SHA==
X-Google-Smtp-Source: AGHT+IF5YHlQSMrIw16r+uVSNv/451o25wdhmlzvVO3INNSaZxue3EcfGr3UbkP9vTp9NIAwIoM31DFP9zrJ7RrLFg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:400c:0:b0:589:a855:7af with SMTP
 id l12-20020a81400c000000b00589a85507afmr17848ywn.7.1694552632259; Tue, 12
 Sep 2023 14:03:52 -0700 (PDT)
Date:   Tue, 12 Sep 2023 21:03:50 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADbSAGUC/4WNWw6DIBREt2Lud2l4RKz9ch+NaRSvSKpigJA2h
 r2XsoH+zZlkzpzg0Rn0cK9OcBiNN3bPwC4VqGXYNRIzZQZOuaAtvZGXx3UO6AM5BjdszxIVYY0
 Uo+TYSD5DHh8OZ/Mu4kefeTE+WPcpP5H92r/KyAgjKOpxamnNJ8k6ba1e8arsBn1K6Qv4Q/Odv QAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694552631; l=4723;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=rBvEsviW5uVxRd+NSePgqHcF5aSjOLLvI+7rzhkkIw4=; b=YWVY/Weu/NSS3aIoj+Urk84igcHFCjWw8w12fSj3X9Av24E/Uzm8nDpKQdRL22iqOFzOi+bSg
 m9up5YJRe7YDO6RlPENJ2k/ZLpyQAWPEF7g/3lhb404Mrq/huWzpBnN
X-Mailer: b4 0.12.3
Message-ID: <20230912-kselftest-param_test-c-v1-1-80a6cffc7374@google.com>
Subject: [PATCH] selftests/rseq: fix kselftest Clang build warnings
From:   Justin Stitt <justinstitt@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang, I am getting many warnings from the selftests/rseq tree.

Here's one such example from rseq tree:
|  param_test.c:1234:10: error: address argument to atomic operation must be a pointer to _Atomic type ('intptr_t *' (aka 'long *') invalid)
|   1234 |         while (!atomic_load(&args->percpu_list_ptr)) {}
|        |                 ^           ~~~~~~~~~~~~~~~~~~~~~~
|  /usr/local/google/home/justinstitt/repos/tc-build/build/llvm/final/lib/clang/18/include/stdatomic.h:140:29: note: expanded from macro 'atomic_load'
|    140 | #define atomic_load(object) __c11_atomic_load(object, __ATOMIC_SEQ_CST)
|        |                             ^                 ~~~~~~

Use compiler builtins `__atomic_load_n()` and `__atomic_store_n()` with
accompanying __ATOMIC_ACQUIRE and __ATOMIC_RELEASE, respectively. This
will fix the warnings because the compiler builtins do not expect their
arguments to have _Atomic type. This should also make TSAN happier.

Link: https://github.com/ClangBuiltLinux/linux/issues/1698
Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: Previous RFC https://lore.kernel.org/r/20230908-kselftest-param_test-c-v1-1-e35bd9052d61@google.com
---
 tools/testing/selftests/rseq/param_test.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index bf951a490bb4..20403d58345c 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1231,7 +1231,7 @@ void *test_membarrier_worker_thread(void *arg)
 	}
 
 	/* Wait for initialization. */
-	while (!atomic_load(&args->percpu_list_ptr)) {}
+	while (!__atomic_load_n(&args->percpu_list_ptr, __ATOMIC_ACQUIRE)) {}
 
 	for (i = 0; i < iters; ++i) {
 		int ret;
@@ -1299,22 +1299,22 @@ void *test_membarrier_manager_thread(void *arg)
 	test_membarrier_init_percpu_list(&list_a);
 	test_membarrier_init_percpu_list(&list_b);
 
-	atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
+	__atomic_store_n(&args->percpu_list_ptr, (intptr_t)&list_a, __ATOMIC_RELEASE);
 
-	while (!atomic_load(&args->stop)) {
+	while (!__atomic_load_n(&args->stop, __ATOMIC_ACQUIRE)) {
 		/* list_a is "active". */
 		cpu_a = rand() % CPU_SETSIZE;
 		/*
 		 * As list_b is "inactive", we should never see changes
 		 * to list_b.
 		 */
-		if (expect_b != atomic_load(&list_b.c[cpu_b].head->data)) {
+		if (expect_b != __atomic_load_n(&list_b.c[cpu_b].head->data, __ATOMIC_ACQUIRE)) {
 			fprintf(stderr, "Membarrier test failed\n");
 			abort();
 		}
 
 		/* Make list_b "active". */
-		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
+		__atomic_store_n(&args->percpu_list_ptr, (intptr_t)&list_b, __ATOMIC_RELEASE);
 		if (rseq_membarrier_expedited(cpu_a) &&
 				errno != ENXIO /* missing CPU */) {
 			perror("sys_membarrier");
@@ -1324,27 +1324,27 @@ void *test_membarrier_manager_thread(void *arg)
 		 * Cpu A should now only modify list_b, so the values
 		 * in list_a should be stable.
 		 */
-		expect_a = atomic_load(&list_a.c[cpu_a].head->data);
+		expect_a = __atomic_load_n(&list_a.c[cpu_a].head->data, __ATOMIC_ACQUIRE);
 
 		cpu_b = rand() % CPU_SETSIZE;
 		/*
 		 * As list_a is "inactive", we should never see changes
 		 * to list_a.
 		 */
-		if (expect_a != atomic_load(&list_a.c[cpu_a].head->data)) {
+		if (expect_a != __atomic_load_n(&list_a.c[cpu_a].head->data, __ATOMIC_ACQUIRE)) {
 			fprintf(stderr, "Membarrier test failed\n");
 			abort();
 		}
 
 		/* Make list_a "active". */
-		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
+		__atomic_store_n(&args->percpu_list_ptr, (intptr_t)&list_a, __ATOMIC_RELEASE);
 		if (rseq_membarrier_expedited(cpu_b) &&
 				errno != ENXIO /* missing CPU*/) {
 			perror("sys_membarrier");
 			abort();
 		}
 		/* Remember a value from list_b. */
-		expect_b = atomic_load(&list_b.c[cpu_b].head->data);
+		expect_b = __atomic_load_n(&list_b.c[cpu_b].head->data, __ATOMIC_ACQUIRE);
 	}
 
 	test_membarrier_free_percpu_list(&list_a);
@@ -1401,7 +1401,7 @@ void test_membarrier(void)
 		}
 	}
 
-	atomic_store(&thread_args.stop, 1);
+	__atomic_store_n(&thread_args.stop, 1, __ATOMIC_RELEASE);
 	ret = pthread_join(manager_thread, NULL);
 	if (ret) {
 		errno = ret;

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230908-kselftest-param_test-c-1763b62e762f

Best regards,
--
Justin Stitt <justinstitt@google.com>

