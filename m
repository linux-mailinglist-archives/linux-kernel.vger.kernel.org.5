Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BDD7BEA79
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378349AbjJITUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378347AbjJITUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:20:31 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4817CB7;
        Mon,  9 Oct 2023 12:20:29 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5859b2eaa55so3099729a12.1;
        Mon, 09 Oct 2023 12:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696879229; x=1697484029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/g1j9HiKSnjL7yGbF4RkqOe02EOquhx1LcTcmnYbMcQ=;
        b=d8Hnk7Bj6/UvyUw9VsWfqDm8xXFvwsIvuXD3TmazhYOhiRcC1fI56MWKRtwrqPYhSA
         hUY/upG0S/ggvoAqpARnwbcNxrfLgKdqKIHWjgqI3cPKJSSKHTt47z1lnyetoWFT7MHI
         q+l0b6dqBx+/qOXER8FoYfj6JRHUjReQP1uqYraJf+JCkP+PwwFB4B698jINwyPBTh12
         8X4X9VzMrG77dXhVOCxTlGUISqau8YWDtab4YWJmTuz/Zpsg52IWbXOI3mQHRximxd34
         eIPuM8RQuNDLaoTixN3eg/QJChoI7P2INeBUtrxOghzEJnyJBmkr89QqzqyldD/wHmsb
         SX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696879229; x=1697484029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/g1j9HiKSnjL7yGbF4RkqOe02EOquhx1LcTcmnYbMcQ=;
        b=VhIY7n7/A2gbRklpf6IW3EeebgtcHa56c61npsWqu4EWsjjBK0XUHf+ueHvNz2RMKN
         auyw62qHB3n2dpwrwq0eXNQV9MHCgHcMF76Ak5frM67XO6hOinufDlYCDgEC7RjlUqWg
         x8IQUf5zmak3r/ebQJB7KKFrzsPOZ6U7CBU9R/bUQjGTVJmaeVLNYTHnrA4qcED6evAu
         rmk21getZ2NsOPq6aOTKVRnEwqRSTzndt6M2kGLclVGHmUcfd2D4+KbAb7kwXxMV7ffi
         C456Vb3NszJyAN+J2KSYpuZ1NFDM7jNca2FBktS4PV/v9hk59fxo9lYmGFflpP7NncmI
         cKHw==
X-Gm-Message-State: AOJu0YwCtz6rHqAU5ZoSryScKDHpvqIFM4ACQYeftE4jgaECQF5SYkhT
        qEijR+eS+szEvaP/ItQgAe8=
X-Google-Smtp-Source: AGHT+IFrYk6upoIKzXF/DQuWt1tnCOakUk+x6ZLBPpUhsKG7M6OsjazGNh91QAd63xstpiP5gi4DYQ==
X-Received: by 2002:a17:90b:88e:b0:269:3771:7342 with SMTP id bj14-20020a17090b088e00b0026937717342mr12380407pjb.18.1696879228566;
        Mon, 09 Oct 2023 12:20:28 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a199700b00278ff752eacsm9472837pji.50.2023.10.09.12.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:20:28 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org, hughd@google.com,
        mm-commits@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Subject: [PATCH v3] selftests:proc Add /proc/$(pid)/statm output validation
Date:   Tue, 10 Oct 2023 00:50:10 +0530
Message-Id: <20231009192010.10456-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004201701.87CB5C433C7@smtp.kernel.org>
References: <20231004201701.87CB5C433C7@smtp.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /proc/${pid}/statm validation

/proc/$(pid)/statm output is expected to be:
 "0 0 0 * 0 0 0\n"
Here * can be any value

Read output of /proc/$(pid)/statm
and check except for 4th position,
all other positions have value zero.

Fixes: 5bc73bb3451b (proc: test how it holds up with mapping'less process)
Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---

 Changes in V3:
- Remove wrong comment "/proc/${pid}/statm is under
  CONFIG_PROC_PAGE_MONITOR"
- read() function usage is change

 Changes in V2:
- 4th field if zero it will assert
- field other than 4th field is checked for zero value
- clean up of function test_proc_pid_statm()

 tools/testing/selftests/proc/proc-empty-vm.c | 60 ++++++++++++++++++--
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index b16c13688b88..bc76e8bba7e4 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -38,6 +38,8 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
+#include "../kselftest.h"
+
 #ifdef __amd64__
 #define TEST_VSYSCALL
 #endif
@@ -302,6 +304,57 @@ static int test_proc_pid_smaps_rollup(pid_t pid)
 	}
 }
 
+static int test_proc_pid_statm(pid_t pid)
+{
+	char buf[4096];
+	char *tok;
+	char *string, *p;
+	int non_zero_value_indx = 4;
+	int i = 1, len;
+        size_t left;
+
+	snprintf(buf, sizeof(buf), "/proc/%u/statm", pid);
+
+	/*
+	 *  Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
+	 */
+	int fd = open(buf, O_RDONLY);
+
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			return EXIT_SUCCESS;
+		}
+		perror("open /proc/${pid}/statm");
+		return EXIT_FAILURE;
+	} else {
+		memset(buf, 0, sizeof(buf));
+		left = ARRAY_SIZE(buf);
+		p = buf;
+		while ((len = read(fd, p, left)) > 0) {
+			p += len;
+			left -= len;
+		}
+		close(fd);
+		string = buf;
+
+		while ((tok = strsep(&string, " ")) != NULL) {
+			if (i == non_zero_value_indx) {
+				if (!strncmp(tok, "0", 1))
+					goto err_statm;
+			} else {
+				if (strncmp(tok, "0", 1))
+					goto err_statm;
+			}
+			i++;
+		}
+	}
+
+	return EXIT_SUCCESS;
+
+err_statm:
+	assert(0);
+}
+
 int main(void)
 {
 	int rv = EXIT_SUCCESS;
@@ -388,11 +441,8 @@ int main(void)
 		if (rv == EXIT_SUCCESS) {
 			rv = test_proc_pid_smaps_rollup(pid);
 		}
-		/*
-		 * TODO test /proc/${pid}/statm, task_statm()
-		 * ->start_code, ->end_code aren't updated by munmap().
-		 * Output can be "0 0 0 2 0 0 0\n" where "2" can be anything.
-		 */
+		if (rv == EXIT_SUCCESS)
+			rv = test_proc_pid_statm(pid);
 
 		/* Cut the rope. */
 		int wstatus;
-- 
2.34.1

