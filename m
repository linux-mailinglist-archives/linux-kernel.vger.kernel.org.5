Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDF79DA7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjILVCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237389AbjILVCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:02:05 -0400
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A91110F7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 14:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552520; bh=58f8S58hGLc55LVOlzdj03pCgZGCPKKPjdrJvEFLlxM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gYcNwQADmP1Xy+oVtpwebWniIEhVXai8PrZXZNWfv7HliRcSnbLvNjfIDDMaLoqSi0bhFDq9kpSNQftUSH5ZWgKGPfiDey2Zc0jGG50QDS2WYi/1L1dyzmcnhz4NgWCXGzenlsHX9WfbpZWHO3UsONJKABLwEv2QNARaK00T3x+wVyhM776UjMC+TIW1HWln/k5X3QyndHbVxqtCa11811xOQIhwhp2n2TPHbzKsCnEWvmZ1hosGpUNVPTDwsL9X2dwBqp87KRQcuUPVmHPdb/wXFZ2emDM3ZfIhUe+7VaHepclyd+qjs97Hftwea1/rudVxKWHVp1HKwSAgIePTpQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1694552520; bh=nke1FgPtN7HuL5JUvLQKRf3P+VI0b9i61KDq3Mka/+w=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=V5mCL73c0+8QaeqTwxhSDZiIyyxrbRqiGyYU6TJMsX3RT3OG5wp8WXsmdW+xMicTO6wHYTz2GWRtNyfFWi/2V+ko9GYvmEuT8IyLatiEvJ9So2UQnkg++ZjbxklAz+nJMvRbjk0c7Qu3HzR+9VAgoZvHkp6XCKnHp6EyzOdpQd71EebIP7IX8r9o/PtcONc+3WKAZ2Qg97pGfzTQIqy3JRyP4WO9Abl0TRN5ScNOelx4z+kT0BcafhdsupAP+qkrVtt4/oGjYDdB2/IfVJA6q+/dI45SRwcGT9nHj0VJCRfjfexhS55qQ9CpP9XH89mzQ82pjHkFAOYzNXcqqgrn+g==
X-YMail-OSG: YqvJewsVM1neq3jwsLsfd6Hx0yo0jBLsUx.UJ2xuJ5EVJPFSDuWzOPnZZ02X2fW
 c7DxeHzhuP3VhK0w8UyAZznTj3pkzypATlm5tnVDiSREV3rdbwToWo9lE2YvHeL_vEFh5GWuyeUK
 i9rKKomw0YTQdH2qfDBvewCxmVtXb2x63Qx5Hh0NmQbU1BpXhbP4OnVb0rHZoJVSu567OBOZmCFV
 R.6ESIZs8FjkGqWjt8QQGtwp8GOEOTzrAGwoN9VlZ9rcsUKId5TE9G4LGp2lf_X0h5EqFguXUzu5
 1WD2zsONnCLhZzLahoLngxp7C55msnjh0yGrQF743hj6ch3t2yVNgXx0MrzZK4_LGGHka7fYof5e
 YJ7PL1aUxNM5_3OUxKnOsEMVTRWUVX94MQDpxT9u9L9gmv7C8XLa5h0BzRBECM3Adpj9z3_3rsyB
 aIY_HSlu8e_kfOAqiR.7RIC86Jo0l0cdJXcBICFnsBczSjXwYNJ3rNMdOpcZDGSgHbWfj3LhbIbj
 l4dPiOSNtAKIRynHbOQW9z68CI7ZjyUqwnjMYJQb02GBbR4qt1bnVoQIou2qIGd3TBLMJReIClB.
 PTvnHu0PeezEk21MOJjgswLyDZhQz9YI8t259dxhaVMdQQU9wFn1._TeBjgko6MxlaTLGSXWI8hD
 WA_hHH70LSEfuPNCjZGkj4RXy2lbvfUXgeL3bf0afYY_WwksWXlgcqdJYo8JyIZIt0h3IxCo.7Ub
 1UX81ykMd2I1eFttpoAzgSWG37DW43x_k6v9HUy6y2_RfNT.0bNEMD7_D8.nanjKZaZN6alcVBOq
 OutAUe999_KTtGh2B85ZSwJgCHKbqLLpm1A.YLYuBaVTWNcJBryS.gJtD9cVRUv3kflrs4WorC6t
 yBrtNXKBNqQE4sl4asj6Bb6I5LvZGX3zM748.o.XNJJZxLBGjdigtuUbw0hDWqqE4YcunMciVYDh
 VfkGgfQ0aadiPqA.Ysv1f76sEb8Hb8kCVajzKGcpAD2pByX5yBlQZZSkg7o6SFOwvTXdDWB0ENhX
 qkHAZa8HN8TlCmNKXJOzjXA7jtMQt_1AsgT5SZAsDdaBjWkwbe6Pawl8AxFtIZdzwpjnujaZSEFw
 75HUcXAbYGc5lf_dym_iqU8YeoaRP5T_uyIDz.6wljTlxWkepRVjVY6j7f937f9D_jn9bYTaqgAh
 hfS200W318VZmj7TbP3VSHocLASjOTt4WhWLEY6Slht945IaZ0Iv7Hmy1l4eOPQ1Fep3YNmZlIMI
 o.t9mcUOXrB2iO78AmfZl0gemsWH1I1K4gYlm0Pbm8vii5nov0AYyYLuikJZmetc8NYd2Z5ju2Gx
 QL_pJ1I0KbyMzP.2oOeB3LJZvIP845H63yklbA8xLcvtrW2s6TrsBDy3oIPuhTd1Vy4PBQOb3aEo
 TMw9yC0i2QSLziTPfpkkvDLHZnPtce4uLY3qald86fULfb2zxA808mdqFr7P3MeIaU0_r41F0aS1
 59aKiTi8bQTXhM3fSoCqLcb.ThqDGl_YFQX1pbbL9pA5hhj593mY2d5dDyw.GhG8xPcvmzZmdprK
 T7jSasF9IO9epSUADsTDMF0w5N9kLOXNHG2wDnmjWitoyqMirXlqX.Ou8ukB.BO4iIpHW7fwpjJs
 xQus0oWkD9eqf0OTEXiJJou35tWT7KETJw9v1fB3gaXkICxYnM3IMmGeAT12OoDb8lLwBFQmS8Yy
 KTmZgxNG1iJahiPs5pMInIyMeDUDi4D9WgE7piOgbVi58fiPUCKZZeQ9VYoHNsKk0mKopv1PV78_
 _IZ90TtN3aouvX0CAyekbLMjGDBF8h4uxeWHl.ClgVPHkPZdPXSAHnA8AVYbX2iCetVhHJasK7f_
 5fki2YKGTzg34Ya7pXEyql9nf7WQmofd61WtRaQnxoLai99a5qYBYAURN2ykbb2uRcgaJ.NOSj5N
 2XJey3PRKozlr6tr4F.wlsZvdLG5qlxcRGQjNQGx_faiq493l.JU08mIhKGZ3ynRkysmkLLBOOoW
 3M7FGt_ToMYQBMTb6EPYZIatB9ArAEcCcWWd_mpYoqUJxb0yD7ZjGR3GHXp26wJb.P6CDlKSUo13
 PR8_jdTsLbbG63kucjxvSjtc2896NUKUGWfyYZjEQOv7UjkefHyhGsVKZjuwcpciCI1OYARI8k2p
 QAgZ48rpmPAHfhFVViw9AktJwhTjvSh7gcfOIGkpQjbcZIMOlf2CnP4qcRybn4_H7lb2fl8GsdhF
 TdR5WDEClysV7EtpqL11QMe3tDGJLqlpa61Tdwuc7apHHX7L_
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 58f93548-bf4d-45b8-9546-b58469569388
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Sep 2023 21:02:00 +0000
Received: by hermes--production-ne1-7b767b77cc-84nnk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dca4072a6b7e00ec57f039d5e03e840b;
          Tue, 12 Sep 2023 21:01:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v15 11/11] LSM: selftests for Linux Security Module syscalls
Date:   Tue, 12 Sep 2023 13:56:56 -0700
Message-ID: <20230912205658.3432-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912205658.3432-1-casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add selftests for the three system calls supporting the LSM
infrastructure. This set of tests is limited by the differences
in access policy enforced by the existing security modules.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/lsm/.gitignore        |   1 +
 tools/testing/selftests/lsm/Makefile          |  17 ++
 tools/testing/selftests/lsm/common.c          |  89 ++++++
 tools/testing/selftests/lsm/common.h          |  33 +++
 tools/testing/selftests/lsm/config            |   3 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 275 ++++++++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     | 140 +++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  74 +++++
 10 files changed, 634 insertions(+)
 create mode 100644 tools/testing/selftests/lsm/.gitignore
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/common.c
 create mode 100644 tools/testing/selftests/lsm/common.h
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 935334123b04..377cc124e615 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19309,6 +19309,7 @@ W:	http://kernsec.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/uapi/linux/lsm.h
 F:	security/
+F:	tools/testing/selftests/lsm/
 X:	security/selinux/
 
 SELINUX SECURITY MODULE
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 42806add0114..fc589775ca4c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -42,6 +42,7 @@ TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
 TARGETS += lkdtm
+TARGETS += lsm
 TARGETS += membarrier
 TARGETS += memfd
 TARGETS += memory-hotplug
diff --git a/tools/testing/selftests/lsm/.gitignore b/tools/testing/selftests/lsm/.gitignore
new file mode 100644
index 000000000000..bd68f6c3fd07
--- /dev/null
+++ b/tools/testing/selftests/lsm/.gitignore
@@ -0,0 +1 @@
+/*_test
diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
new file mode 100644
index 000000000000..3f80c0bc093d
--- /dev/null
+++ b/tools/testing/selftests/lsm/Makefile
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# First run: make -C ../../../.. headers_install
+
+CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
+LOCAL_HDRS += common.h
+
+TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
+		  lsm_set_self_attr_test
+
+include ../lib.mk
+
+$(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
+$(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
+$(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c
+
+EXTRA_CLEAN = $(OUTPUT)/common.o
diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests/lsm/common.c
new file mode 100644
index 000000000000..9ad258912646
--- /dev/null
+++ b/tools/testing/selftests/lsm/common.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Security Module infrastructure tests
+ *
+ * Copyright © 2023 Casey Schaufler <casey@schaufler-ca.com>
+ */
+
+#define _GNU_SOURCE
+#include <linux/lsm.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "common.h"
+
+#define PROCATTR "/proc/self/attr/"
+
+int read_proc_attr(const char *attr, char *value, size_t size)
+{
+	int fd;
+	int len;
+	char *path;
+
+	len = strlen(PROCATTR) + strlen(attr) + 1;
+	path = calloc(len, 1);
+	if (path == NULL)
+		return -1;
+	sprintf(path, "%s%s", PROCATTR, attr);
+
+	fd = open(path, O_RDONLY);
+	free(path);
+
+	if (fd < 0)
+		return -1;
+	len = read(fd, value, size);
+
+	close(fd);
+
+	/* Ensure value is terminated */
+	if (len <= 0 || len == size)
+		return -1;
+	value[len] = '\0';
+
+	path = strchr(value, '\n');
+	if (path)
+		*path = '\0';
+
+	return 0;
+}
+
+int read_sysfs_lsms(char *lsms, size_t size)
+{
+	FILE *fp;
+	size_t red;
+
+	fp = fopen("/sys/kernel/security/lsm", "r");
+	if (fp == NULL)
+		return -1;
+	red = fread(lsms, 1, size, fp);
+	fclose(fp);
+
+	if (red <= 0 || red == size)
+		return -1;
+	lsms[red] = '\0';
+	return 0;
+}
+
+int attr_lsm_count(void)
+{
+	char *names = calloc(sysconf(_SC_PAGESIZE), 1);
+	int count = 0;
+
+	if (!names)
+		return 0;
+
+	if (read_sysfs_lsms(names, sysconf(_SC_PAGESIZE)))
+		return 0;
+
+	if (strstr(names, "selinux"))
+		count++;
+	if (strstr(names, "smack"))
+		count++;
+	if (strstr(names, "apparmor"))
+		count++;
+
+	return count;
+}
diff --git a/tools/testing/selftests/lsm/common.h b/tools/testing/selftests/lsm/common.h
new file mode 100644
index 000000000000..d404329e5eeb
--- /dev/null
+++ b/tools/testing/selftests/lsm/common.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Linux Security Module infrastructure tests
+ *
+ * Copyright © 2023 Casey Schaufler <casey@schaufler-ca.com>
+ */
+
+#ifndef lsm_get_self_attr
+static inline int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+				    size_t *size, __u32 flags)
+{
+	return syscall(__NR_lsm_get_self_attr, attr, ctx, size, flags);
+}
+#endif
+
+#ifndef lsm_set_self_attr
+static inline int lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+				    size_t size, __u32 flags)
+{
+	return syscall(__NR_lsm_set_self_attr, attr, ctx, size, flags);
+}
+#endif
+
+#ifndef lsm_list_modules
+static inline int lsm_list_modules(__u64 *ids, size_t *size, __u32 flags)
+{
+	return syscall(__NR_lsm_list_modules, ids, size, flags);
+}
+#endif
+
+extern int read_proc_attr(const char *attr, char *value, size_t size);
+extern int read_sysfs_lsms(char *lsms, size_t size);
+int attr_lsm_count(void);
diff --git a/tools/testing/selftests/lsm/config b/tools/testing/selftests/lsm/config
new file mode 100644
index 000000000000..1c0c4c020f9c
--- /dev/null
+++ b/tools/testing/selftests/lsm/config
@@ -0,0 +1,3 @@
+CONFIG_SYSFS=y
+CONFIG_SECURITY=y
+CONFIG_SECURITYFS=y
diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
new file mode 100644
index 000000000000..e0e313d9047a
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Security Module infrastructure tests
+ * Tests for the lsm_get_self_attr system call
+ *
+ * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
+ */
+
+#define _GNU_SOURCE
+#include <linux/lsm.h>
+#include <fcntl.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "../kselftest_harness.h"
+#include "common.h"
+
+static struct lsm_ctx *next_ctx(struct lsm_ctx *ctxp)
+{
+	void *vp;
+
+	vp = (void *)ctxp + sizeof(*ctxp) + ctxp->ctx_len;
+	return (struct lsm_ctx *)vp;
+}
+
+TEST(size_null_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+
+	ASSERT_NE(NULL, ctx);
+	errno = 0;
+	ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, NULL, 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	free(ctx);
+}
+
+TEST(ctx_null_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	size_t size = page_size;
+	int rc;
+
+	rc = lsm_get_self_attr(LSM_ATTR_CURRENT, NULL, &size, 0);
+
+	if (attr_lsm_count()) {
+		ASSERT_NE(-1, rc);
+		ASSERT_NE(1, size);
+	} else {
+		ASSERT_EQ(-1, rc);
+	}
+}
+
+TEST(size_too_small_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	size_t size = 1;
+
+	ASSERT_NE(NULL, ctx);
+	errno = 0;
+	ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size, 0));
+	if (attr_lsm_count()) {
+		ASSERT_EQ(E2BIG, errno);
+	} else {
+		ASSERT_EQ(EOPNOTSUPP, errno);
+	}
+	ASSERT_NE(1, size);
+
+	free(ctx);
+}
+
+TEST(flags_zero_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	__u64 *syscall_lsms = calloc(page_size, 1);
+	size_t size;
+	int lsmcount;
+	int i;
+
+	ASSERT_NE(NULL, ctx);
+	errno = 0;
+	size = page_size;
+	ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
+					LSM_FLAG_SINGLE));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(page_size, size);
+
+	lsmcount = syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0);
+	ASSERT_LE(1, lsmcount);
+	ASSERT_NE(NULL, syscall_lsms);
+
+	for (i = 0; i < lsmcount; i++) {
+		errno = 0;
+		size = page_size;
+		ctx->id = syscall_lsms[i];
+
+		if (syscall_lsms[i] == LSM_ID_SELINUX ||
+		    syscall_lsms[i] == LSM_ID_SMACK ||
+		    syscall_lsms[i] == LSM_ID_APPARMOR) {
+			ASSERT_EQ(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx,
+						       &size, LSM_FLAG_SINGLE));
+		} else {
+			ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx,
+							&size,
+							LSM_FLAG_SINGLE));
+		}
+	}
+
+	free(ctx);
+}
+
+TEST(flags_overset_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	size_t size;
+
+	ASSERT_NE(NULL, ctx);
+
+	errno = 0;
+	size = page_size;
+	ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx,
+					&size, 0));
+	ASSERT_EQ(EOPNOTSUPP, errno);
+
+	errno = 0;
+	size = page_size;
+	ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
+					LSM_FLAG_SINGLE |
+					(LSM_FLAG_SINGLE << 1)));
+	ASSERT_EQ(EINVAL, errno);
+
+	free(ctx);
+}
+
+TEST(basic_lsm_get_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	size_t size = page_size;
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	struct lsm_ctx *tctx = NULL;
+	__u64 *syscall_lsms = calloc(page_size, 1);
+	char *attr = calloc(page_size, 1);
+	int cnt_current = 0;
+	int cnt_exec = 0;
+	int cnt_fscreate = 0;
+	int cnt_keycreate = 0;
+	int cnt_prev = 0;
+	int cnt_sockcreate = 0;
+	int lsmcount;
+	int count;
+	int i;
+
+	ASSERT_NE(NULL, ctx);
+	ASSERT_NE(NULL, syscall_lsms);
+
+	lsmcount = syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0);
+	ASSERT_LE(1, lsmcount);
+
+	for (i = 0; i < lsmcount; i++) {
+		switch (syscall_lsms[i]) {
+		case LSM_ID_SELINUX:
+			cnt_current++;
+			cnt_exec++;
+			cnt_fscreate++;
+			cnt_keycreate++;
+			cnt_prev++;
+			cnt_sockcreate++;
+			break;
+		case LSM_ID_SMACK:
+			cnt_current++;
+			break;
+		case LSM_ID_APPARMOR:
+			cnt_current++;
+			cnt_exec++;
+			cnt_prev++;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (cnt_current) {
+		size = page_size;
+		count = lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size, 0);
+		ASSERT_EQ(cnt_current, count);
+		tctx = ctx;
+		ASSERT_EQ(0, read_proc_attr("current", attr, page_size));
+		ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+	if (cnt_exec) {
+		size = page_size;
+		count = lsm_get_self_attr(LSM_ATTR_EXEC, ctx, &size, 0);
+		ASSERT_GE(cnt_exec, count);
+		if (count > 0) {
+			tctx = ctx;
+			if (read_proc_attr("exec", attr, page_size) == 0)
+				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		}
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+	if (cnt_fscreate) {
+		size = page_size;
+		count = lsm_get_self_attr(LSM_ATTR_FSCREATE, ctx, &size, 0);
+		ASSERT_GE(cnt_fscreate, count);
+		if (count > 0) {
+			tctx = ctx;
+			if (read_proc_attr("fscreate", attr, page_size) == 0)
+				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		}
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+	if (cnt_keycreate) {
+		size = page_size;
+		count = lsm_get_self_attr(LSM_ATTR_KEYCREATE, ctx, &size, 0);
+		ASSERT_GE(cnt_keycreate, count);
+		if (count > 0) {
+			tctx = ctx;
+			if (read_proc_attr("keycreate", attr, page_size) == 0)
+				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		}
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+	if (cnt_prev) {
+		size = page_size;
+		count = lsm_get_self_attr(LSM_ATTR_PREV, ctx, &size, 0);
+		ASSERT_GE(cnt_prev, count);
+		if (count > 0) {
+			tctx = ctx;
+			ASSERT_EQ(0, read_proc_attr("prev", attr, page_size));
+			ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+			for (i = 1; i < count; i++) {
+				tctx = next_ctx(tctx);
+				ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+			}
+		}
+	}
+	if (cnt_sockcreate) {
+		size = page_size;
+		count = lsm_get_self_attr(LSM_ATTR_SOCKCREATE, ctx, &size, 0);
+		ASSERT_GE(cnt_sockcreate, count);
+		if (count > 0) {
+			tctx = ctx;
+			if (read_proc_attr("sockcreate", attr, page_size) == 0)
+				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
+		}
+		for (i = 1; i < count; i++) {
+			tctx = next_ctx(tctx);
+			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
+		}
+	}
+
+	free(ctx);
+	free(attr);
+	free(syscall_lsms);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
new file mode 100644
index 000000000000..445c02f09c74
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Security Module infrastructure tests
+ * Tests for the lsm_list_modules system call
+ *
+ * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
+ */
+
+#define _GNU_SOURCE
+#include <linux/lsm.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "../kselftest_harness.h"
+#include "common.h"
+
+TEST(size_null_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__u64 *syscall_lsms = calloc(page_size, 1);
+
+	ASSERT_NE(NULL, syscall_lsms);
+	errno = 0;
+	ASSERT_EQ(-1, lsm_list_modules(syscall_lsms, NULL, 0));
+	ASSERT_EQ(EFAULT, errno);
+
+	free(syscall_lsms);
+}
+
+TEST(ids_null_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	size_t size = page_size;
+
+	errno = 0;
+	ASSERT_EQ(-1, lsm_list_modules(NULL, &size, 0));
+	ASSERT_EQ(EFAULT, errno);
+	ASSERT_NE(1, size);
+}
+
+TEST(size_too_small_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__u64 *syscall_lsms = calloc(page_size, 1);
+	size_t size = 1;
+
+	ASSERT_NE(NULL, syscall_lsms);
+	errno = 0;
+	ASSERT_EQ(-1, lsm_list_modules(syscall_lsms, &size, 0));
+	ASSERT_EQ(E2BIG, errno);
+	ASSERT_NE(1, size);
+
+	free(syscall_lsms);
+}
+
+TEST(flags_set_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	__u64 *syscall_lsms = calloc(page_size, 1);
+	size_t size = page_size;
+
+	ASSERT_NE(NULL, syscall_lsms);
+	errno = 0;
+	ASSERT_EQ(-1, lsm_list_modules(syscall_lsms, &size, 7));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(page_size, size);
+
+	free(syscall_lsms);
+}
+
+TEST(correct_lsm_list_modules)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	size_t size = page_size;
+	__u64 *syscall_lsms = calloc(page_size, 1);
+	char *sysfs_lsms = calloc(page_size, 1);
+	char *name;
+	char *cp;
+	int count;
+	int i;
+
+	ASSERT_NE(NULL, sysfs_lsms);
+	ASSERT_NE(NULL, syscall_lsms);
+	ASSERT_EQ(0, read_sysfs_lsms(sysfs_lsms, page_size));
+
+	count = lsm_list_modules(syscall_lsms, &size, 0);
+	ASSERT_LE(1, count);
+	cp = sysfs_lsms;
+	for (i = 0; i < count; i++) {
+		switch (syscall_lsms[i]) {
+		case LSM_ID_CAPABILITY:
+			name = "capability";
+			break;
+		case LSM_ID_SELINUX:
+			name = "selinux";
+			break;
+		case LSM_ID_SMACK:
+			name = "smack";
+			break;
+		case LSM_ID_TOMOYO:
+			name = "tomoyo";
+			break;
+		case LSM_ID_IMA:
+			name = "ima";
+			break;
+		case LSM_ID_APPARMOR:
+			name = "apparmor";
+			break;
+		case LSM_ID_YAMA:
+			name = "yama";
+			break;
+		case LSM_ID_LOADPIN:
+			name = "loadpin";
+			break;
+		case LSM_ID_SAFESETID:
+			name = "safesetid";
+			break;
+		case LSM_ID_LOCKDOWN:
+			name = "lockdown";
+			break;
+		case LSM_ID_BPF:
+			name = "bpf";
+			break;
+		case LSM_ID_LANDLOCK:
+			name = "landlock";
+			break;
+		default:
+			name = "INVALID";
+			break;
+		}
+		ASSERT_EQ(0, strncmp(cp, name, strlen(name)));
+		cp += strlen(name) + 1;
+	}
+
+	free(sysfs_lsms);
+	free(syscall_lsms);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
new file mode 100644
index 000000000000..e9712c6cf596
--- /dev/null
+++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Security Module infrastructure tests
+ * Tests for the lsm_set_self_attr system call
+ *
+ * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
+ */
+
+#define _GNU_SOURCE
+#include <linux/lsm.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include "../kselftest_harness.h"
+#include "common.h"
+
+TEST(ctx_null_lsm_set_self_attr)
+{
+	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT, NULL,
+					sizeof(struct lsm_ctx), 0));
+}
+
+TEST(size_too_small_lsm_set_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	size_t size = page_size;
+
+	ASSERT_NE(NULL, ctx);
+	if (attr_lsm_count()) {
+		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
+					       0));
+	}
+	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT, ctx, 1, 0));
+
+	free(ctx);
+}
+
+TEST(flags_zero_lsm_set_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	struct lsm_ctx *ctx = calloc(page_size, 1);
+	size_t size = page_size;
+
+	ASSERT_NE(NULL, ctx);
+	if (attr_lsm_count()) {
+		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
+					       0));
+	}
+	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT, ctx, size, 1));
+
+	free(ctx);
+}
+
+TEST(flags_overset_lsm_set_self_attr)
+{
+	const long page_size = sysconf(_SC_PAGESIZE);
+	char *ctx = calloc(page_size, 1);
+	size_t size = page_size;
+	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
+
+	ASSERT_NE(NULL, ctx);
+	if (attr_lsm_count()) {
+		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, tctx, &size,
+					       0));
+	}
+	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, tctx,
+					size, 0));
+
+	free(ctx);
+}
+
+TEST_HARNESS_MAIN
-- 
2.41.0

