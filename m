Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC1878B90B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjH1UDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbjH1UD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:03:26 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469D1B4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252992; bh=NMqYtLgXItMJ8wXuC/GuaE3Kf9k8LrGktkI9+3eBY5Q=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=IRmwwv1l3e94nvrTmONpvkU7Pnya2GpBqWNuk82HKw5+xaEfbY/RLQSUtzLIM6cwfgmUfo4TZG+zoVof84jryJ57S6hUnP1GNr0BRoGju5H6t9TpXXbkp+7uaaF5n6FyEjbospGLwivRLOwIOpfahhDD/xln3ikLtTxE0WdwTVgumzBzrdYpa1t6lvwOPLLlgCsaDvvRqNN9o2fKG86e5ypVGOrRg/Mrbxj4kTIRFNYlAWLn+CstQz2sJAxJDT9Qj5dgAI27Iv8HduVlnSRcrb7XiKYZTJYKwj0apq+7MTwKLgp67zfsIKStRugd0iNr2sqVA+3sEac0uU2Dpgg5fw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693252992; bh=y4FtJx9Wsy9oC/F9PZZM7HSeHUWYSBtq8xGVNbr07Rw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sV3M2JKJiOk66PoDNhpvdbFqBZtK0V5T+sd/Zb7d/kwdn+N65EjDPMjDae7xXCbjtRoBkfguoItgj3ZRJfxmVrZzo0bYpXSr7+TilcxemCBzPDuCjdz1BRM0ZHVOivzElc+lkrugiVpUj7bZap2SevdoYoYw1DzchsSYrxovfUjV3ULdr43oAhu65Z1eVwyvXrjYkwk4yww3u8uK7Q7IC/KOM/Ggb6VJz/7mNXjiTvp1c3IHzBCx96WRJxOPFW2bvGDHzzh5UIvwTWiSFr+QPPNd7q5hGJx+cocbsiY4dLqxk2FP+oumSvgi26BxDQJ3M2EqjJ0hwmH+FiB9icYgug==
X-YMail-OSG: j2VPz2UVM1mHolda.UYIjEUXe2QeQTY9HD7U5FTHbgavptQFysV1MQfE2k7NjjD
 dqMtlYbCN4Ggy0eQQyw31xBaLVNPRTdO_Dhw00gQvVrsll.50THdGAixnQ1sUiKwS2Tj_gAlF7VN
 n_aZAx3MZoujUzx1Mp_twptuobXZECnl0CKi93fMIzWIeUpfnoFi2jvNRx26GgNJt7RXmFu0t5Pt
 6zimeg76iNunWKZs61SNVouLL.LRNtLwMJYHiJE8Ke4m0uJiuuNKL_uNdvdzPFAM3qxYXKqxXRVA
 1oqRvsuuTsOcCeWsAudJPYYivWCObfdhKmefNQb5eet8GvDtFtzYe8ZSJ3K0bhlFpq4U3PVY0y97
 8tR33i39FW28aNUrcWbAe89aOQCpI1FqIpcoci6k9qjKynjme.e8xPFqf9zJM6Ldpnqwrx9oOsTJ
 PXEPZLtnrtT.OHMyML23kw4lbMr9vo6PKWsLyQWVmLv6dLUE_iiq__LRAt_PEnS_2wGJ1By6Bvw6
 PNonxriGJmAOP5FZ8f6aqKgxIpzM1eETYchRXgCGE9yoIdtuLEETSDS5hYiGZq4IGcGvRSuJFF8y
 v5vAW5hNBZ.vC2wauUdf.JWLslAGsnCWlTvpMrvcKYdP6Zc1.wgN9NOfKz_ji2RJko5mwVUJc895
 sP24js6QBNGlmwXcwoRS3Lnj_R9p6F1w2sRhV0uLSiBHEuylvwJAd1as_dg9Pb1gOYdCeGbKWZ1S
 zosfbe3h9pYiYYEb4KVJNweDafUoMbSHhrYq9QJYqtE2aqYV3By8BPxqd9GzbovRg69LDg6bdwQb
 Z3dWgNE3HtdTzK82wPqTXZqae3guCY79OcZeWtQ3UxCSG8.z8QMpM4bFwQ5r.rpR0534O.3t1Y_4
 TuMbF1BEQS67tWXzp5LSIw0ScNoqvEJo8hoDEsXCv.PQLhEbLyM8LgAWxpQuU.JYFuiVE2tL9v4Z
 9zkuji0Vcc6dX6tDKKRrCIlOBcvI52OytMErTUHC_C16cPNrhWf5uPYYlt4_Vwl2UsC6UIHK_UIZ
 7NwzcB5bT9vKvjUNpLDWWtbFT8DqmScV1.H7ApjBWVPrmlsH0lbrtXLTZx6wsBNijy5u5VcKuigC
 VGmd0PfP3cBqp3hyeP5S7N2E55y7tKij6JSIKfoec.qcQdAh2cP4ZzMRn8J72Tj72Gh_.9r8GYkX
 ZY3lil2_yGNZwXWHG.dD4VOEU83__x2k.1PYV5qDZT8ElXtkuB.d9JcAIxtsBjXK2oBVbnh.VnV.
 stvoTP2nRyAsqIDs8sQuKRmA2.mGp80f.LinhwB.CLcFhWunx6b1i0ZXOmS9cFtySAWQprfm7fxm
 IZEY3zTt9JO8_.dGMEWRO9Ii7iiDL0F46BJY6_9QoJAfItBMQlVlRrDL1dsn0pELKNlKCichrlNl
 JATrxIJ8CMZvk8zokwdMaa1PuXe4QhtHQ4WOkP29r83iskd_RQ.LljBLjTDDOdY7DrlKpmjTfG2c
 gtQlY7eJ3s1mmB3bJ82HikEmtrABZSyEpsVlT3C22b2AiDmXGmsCyhWtKzjxOPjSibLbeN7rrePL
 .yQJHPRYvKAAPXHc61KunHus2HO1jrMiUNMh2txdEsyByp__Hjc_.LkgpQHJRbRpNEB0zIcO3LLR
 MCks2pJvhYxsjYlEMOR21WSCzDrUHSiapRaOiNalSEck5DwmvyZ6QKcHzdkD05AISONN6fq_yOKR
 id1PH_SE4AxoGumB3XwNuyhm7zARLFZrL7escPfKqFL7USJ05wL176mWSbGFQlF7KIiOpoq3DBHK
 UACI.x8XIQ7ImONC4NzYf2JQiJdeapM1Eb98nLKDelRhiOKOxVtUmRl4mj2W9atoIgl58v4BVRfh
 NjT16TlCyaIZHb5d_gK3wlABgYw7dShj8URfI6P74SMQfNWs6AoCUUeopMrphR7DWfX1QDh0AhpW
 zRKQhUxAsR5P_mGcuw_en_2T1O06rUZSSGpRGGzV5orJsuOUM0yUvN9cYiSso.Ny6SxYRHCd_hRx
 5UP3nI7h0JCOy2nXnrvLmN6GU1RJ6bN_yrQaw_8lUPv3q5g.4mr8qqYAz1UtYQuCFUxeNOqqvyS.
 xWfXujfn17sCfE3EtT.lAcwR4KJ7ItD.W6YQbU9Ar13gysGElL5eZtIQeRDeQ9Cnis8vU3bDCNhv
 pCtGcT.4gAolabOLLLjbYnKR_rzvq3O6jffhN6TyNKeiAcPWyW68UzOP6O.ymoHaxWfWMHN379BY
 WrdivPHM95njIB.HtxiHQterdambwCRYrDOCG7DUdgS5QmeiMUZ9gTInu0A1rRo4p_nqA19A_UGL
 xfH1SPNksXC8Rxe6zT4btc10pSc8-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f8954986-0e28-4003-8d3b-fcd647ed39ee
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Aug 2023 20:03:12 +0000
Received: by hermes--production-gq1-6b7c87dcf5-6x8bf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 29138cd0d16732a579d2f4720912c9a5;
          Mon, 28 Aug 2023 20:03:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: [PATCH v14 11/11] LSM: selftests for Linux Security Module syscalls
Date:   Mon, 28 Aug 2023 12:58:01 -0700
Message-ID: <20230828195802.135055-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828195802.135055-1-casey@schaufler-ca.com>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add selftests for the three system calls supporting the LSM
infrastructure. This set of tests is limited by the differences
in access policy enforced by the existing security modules.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 MAINTAINERS                                   |   1 +
 security/security.c                           |   2 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/lsm/.gitignore        |   1 +
 tools/testing/selftests/lsm/Makefile          |  17 ++
 tools/testing/selftests/lsm/common.c          |  89 ++++++
 tools/testing/selftests/lsm/common.h          |  33 +++
 tools/testing/selftests/lsm/config            |   3 +
 .../selftests/lsm/lsm_get_self_attr_test.c    | 275 ++++++++++++++++++
 .../selftests/lsm/lsm_list_modules_test.c     | 140 +++++++++
 .../selftests/lsm/lsm_set_self_attr_test.c    |  74 +++++
 11 files changed, 635 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/lsm/.gitignore
 create mode 100644 tools/testing/selftests/lsm/Makefile
 create mode 100644 tools/testing/selftests/lsm/common.c
 create mode 100644 tools/testing/selftests/lsm/common.h
 create mode 100644 tools/testing/selftests/lsm/config
 create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
 create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f7fa85ba9a56..11ea4810207e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19156,6 +19156,7 @@ W:	http://kernsec.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
 F:	include/uapi/linux/lsm.h
 F:	security/
+F:	tools/testing/selftests/lsm/
 X:	security/selinux/
 
 SELINUX SECURITY MODULE
diff --git a/security/security.c b/security/security.c
index 1cd3123a18f8..d17cf0cae8e4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3880,7 +3880,7 @@ int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
 		/*
 		 * Only flag supported is LSM_FLAG_SINGLE
 		 */
-		if (flags & LSM_FLAG_SINGLE)
+		if (flags != LSM_FLAG_SINGLE)
 			return -EINVAL;
 		if (uctx &&
 		    copy_struct_from_user(&lctx, sizeof(lctx), uctx, left))
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 666b56f22a41..bde7c217b23f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -39,6 +39,7 @@ TARGETS += landlock
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

