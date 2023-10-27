Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ADB7D9B50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345942AbjJ0O0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345934AbjJ0O0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:26:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D13D7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:26:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507c8316abcso2724147e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698416786; x=1699021586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ziy+hDit/33rDQvA9Pj8jeQpZiJtdj7ZUvgfQi/0pS4=;
        b=EAFQlb3oH9MQnFszCW5meMTs0moxUlLT4W894ygT9togQQ/03ErfCBff22BnxviEBD
         God1WpLPhlFN26IF96qyWwqv2WVS3TL1ZlSkYNFzVyVIjJ5q2KdwagiZIyog3mGut3H0
         ETxbLq+K0Mm59reD9udea2jjQXLC+bt14QswZbmyvouhsAIZ3J21ao/ABT8UMDLJiUTr
         bny2Sx3AdurdM+XLmQpuBv/IORo/gzUpOaQsMn4x1HaVXCsyfVZoqEO0FKfBrA9zp/FV
         4Brfen1jdOPh35NWps49r5iG9bcMcQDnQsnMDZ4nKMwBCZq3VMF2FYu6N5nEzkw4dBOU
         waiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698416786; x=1699021586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ziy+hDit/33rDQvA9Pj8jeQpZiJtdj7ZUvgfQi/0pS4=;
        b=AWALTuK/2ijv8Y+Sxh47/4w0zoUs0Bs8nO/h4klLKH9+/zZ5tQUFj0XadjFlMiUgWK
         ZBWpW7el3RD4VZyamAUldEOh3RO25r2H4wMBmwFUKqmhQ+0kWhUhSODwMSm5+zSsknSZ
         jXBaCa50KYVOswH0bOsYM7BvI5pnubJNYH3H2hQ7OmcvuLdFQdlq2uXg+B3t5FbEnZD3
         ggJajDRvriS7myMkNiMVmFmV43WyT379BnijXxno6OcdlrNQokNNBb6LtsfjeN01vFWp
         S1Ahw0DxI8KcrwsxahG2XjWU54bu1CBq7dygcNNggqvFtTEnyD/Hblw1hCHn+oy0ACDM
         lnbw==
X-Gm-Message-State: AOJu0Yz3NV4nQRvPayPrJ1iic/y6KkuuEPgUgCii+ZF+UC+nU2xnZPv8
        KW9OJXejCyOjyuYkQz70ETZDG3uvFA==
X-Google-Smtp-Source: AGHT+IHe/82GatF388jAduX2K2rRwyDt7TK9JdHSSo0WNw321PAdNS5mONW0mcCH+weUP8EA0rrfCA==
X-Received: by 2002:ac2:4546:0:b0:507:9fe7:f321 with SMTP id j6-20020ac24546000000b005079fe7f321mr1974991lfm.54.1698416786100;
        Fri, 27 Oct 2023 07:26:26 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709060e1900b009c65e13c33dsm1235812eji.122.2023.10.27.07.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:26:25 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:26:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH 2/2] proc: test ProtectionKey in proc-empty-vm test
Message-ID: <ac05efa7-d2a0-48ad-b704-ffdd5450582e@p183>
References: <76f42cce-b1ab-45ec-b6b2-4c64f0dccb90@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76f42cce-b1ab-45ec-b6b2-4c64f0dccb90@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>

Check ProtectionKey field in /proc/*/smaps output, if system supports
protection keys feature.

[test support in the beginning of the program,
 use syscall, not glibc pkey_alloc(3) which may not compile,
 --adobriyan]

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-empty-vm.c |   79 ++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 18 deletions(-)

--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -23,6 +23,9 @@
  *	/proc/${pid}/smaps
  *	/proc/${pid}/smaps_rollup
  */
+#undef _GNU_SOURCE
+#define _GNU_SOURCE
+
 #undef NDEBUG
 #include <assert.h>
 #include <errno.h>
@@ -34,6 +37,7 @@
 #include <sys/mman.h>
 #include <sys/ptrace.h>
 #include <sys/resource.h>
+#include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
@@ -42,6 +46,43 @@
 #define TEST_VSYSCALL
 #endif
 
+#if defined __amd64__
+	#ifndef SYS_pkey_alloc
+		#define SYS_pkey_alloc 330
+	#endif
+	#ifndef SYS_pkey_free
+		#define SYS_pkey_free 331
+	#endif
+#elif defined __i386__
+	#ifndef SYS_pkey_alloc
+		#define SYS_pkey_alloc 381
+	#endif
+	#ifndef SYS_pkey_free
+		#define SYS_pkey_free 382
+	#endif
+#else
+	#error "SYS_pkey_alloc"
+#endif
+
+static int g_protection_key_support;
+
+static int protection_key_support(void)
+{
+	long rv = syscall(SYS_pkey_alloc, 0, 0);
+	if (rv > 0) {
+		syscall(SYS_pkey_free, (int)rv);
+		return 1;
+	} else if (rv == -1 && errno == ENOSYS) {
+		return 0;
+	} else if (rv == -1 && errno == EINVAL) {
+		// ospke=n
+		return 0;
+	} else {
+		fprintf(stderr, "%s: error: rv %ld, errno %d\n", __func__, rv, errno);
+		exit(EXIT_FAILURE);
+	}
+}
+
 /*
  * 0: vsyscall VMA doesn't exist	vsyscall=none
  * 1: vsyscall VMA is --xp		vsyscall=xonly
@@ -84,10 +125,6 @@ static const char proc_pid_smaps_vsyscall_1[] =
 "SwapPss:               0 kB\n"
 "Locked:                0 kB\n"
 "THPeligible:           0\n"
-/*
- * "ProtectionKey:" field is conditional. It is possible to check it as well,
- * but I don't have such machine.
- */
 ;
 
 static const char proc_pid_smaps_vsyscall_2[] =
@@ -115,10 +152,6 @@ static const char proc_pid_smaps_vsyscall_2[] =
 "SwapPss:               0 kB\n"
 "Locked:                0 kB\n"
 "THPeligible:           0\n"
-/*
- * "ProtectionKey:" field is conditional. It is possible to check it as well,
- * but I'm too tired.
- */
 ;
 
 static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
@@ -240,19 +273,27 @@ static int test_proc_pid_smaps(pid_t pid)
 		}
 		perror("open /proc/${pid}/smaps");
 		return EXIT_FAILURE;
+	}
+	ssize_t rv = read(fd, buf, sizeof(buf));
+	close(fd);
+
+	assert(0 <= rv);
+	assert(rv <= sizeof(buf));
+
+	if (g_vsyscall == 0) {
+		assert(rv == 0);
 	} else {
-		ssize_t rv = read(fd, buf, sizeof(buf));
-		close(fd);
-		if (g_vsyscall == 0) {
-			assert(rv == 0);
-		} else {
-			size_t len = strlen(g_proc_pid_smaps_vsyscall);
-			/* TODO "ProtectionKey:" */
-			assert(rv > len);
-			assert(memcmp(buf, g_proc_pid_smaps_vsyscall, len) == 0);
+		size_t len = strlen(g_proc_pid_smaps_vsyscall);
+		assert(rv > len);
+		assert(memcmp(buf, g_proc_pid_smaps_vsyscall, len) == 0);
+
+		if (g_protection_key_support) {
+#define PROTECTION_KEY "ProtectionKey:         0\n"
+			assert(memmem(buf, rv, PROTECTION_KEY, strlen(PROTECTION_KEY)));
 		}
-		return EXIT_SUCCESS;
 	}
+
+	return EXIT_SUCCESS;
 }
 
 static const char g_smaps_rollup[] =
@@ -419,6 +460,8 @@ int main(void)
 		abort();
 	}
 
+	g_protection_key_support = protection_key_support();
+
 	pid_t pid = fork();
 	if (pid == -1) {
 		perror("fork");
