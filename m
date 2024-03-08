Return-Path: <linux-kernel+bounces-97257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B08767B8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4CC1C20E0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A4921A14;
	Fri,  8 Mar 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="eVtdgRvP"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0761DFDE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709913049; cv=none; b=F44pzo9S96xCdwIVQ25ipbEz9kaDyVRjuSfGCaIUXS/vtkc27BJApS3iqHcdphJjHQmN8JpG5AEKh8YuguwUf02xQZqUHH9UNISNDmhuaB3ullOgS4RKqdKofUhEJi0usA2HaGaddyuoPuelWoa9OP657kahtrIUnn4m3nvPwXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709913049; c=relaxed/simple;
	bh=ozJI79HqGE92jgwvFuOdH4xM0GwWyR9/93hWEIkAQRg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=id4HCSSs9xBMGB06lgdW7tW4bdFXV9f3Q7HrP4p4zgd80/balopalCENyG8q7mit2RY02BOIL42NUdc5VZtVGv1RoNd3MNhscX39R35BwM1NHnhT1rjgzDCBeq5KVwHEzivpMleiBZA22JbfaZoJHYADWm6V0jf1P4U61EJXS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=eVtdgRvP; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709913028;
	bh=RKzkR9vje7Jpn9cyD5wBQ0iJFQUWAC2XF40CQ7KS6RU=;
	h=From:To:Cc:Subject:Date;
	b=eVtdgRvPwChoGirDalsQK9w6I+eVrDjt3LlT3ePTmWVrWA6HoPcQ7+MCdwo2dzSli
	 jlliaLNBITHiwvWD9bNVLQuQVrOvRVrKiz+pDqGAvbnD3hnUjdJtmTL94MO0c+Wgor
	 Mil92/2poqdOB6xBiwrbqeEyb5swkWu6juk+jR8g=
Received: from localhost.localdomain ([2409:8961:2b04:1689:623f:173e:f19f:c2])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id C9827248; Fri, 08 Mar 2024 23:50:24 +0800
X-QQ-mid: xmsmtpt1709913024tdm381xel
Message-ID: <tencent_06797E65CFC655DCD4F0414B9380E95ECC08@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvT2vJnAjZfUSDvuECqJ34yFFveLCtZatygK/gwXZNBtww4iUmeBk
	 2l+f/U3LWNLv1aPUUuH4vUP0RrmHJYKYlrB0A34v9K4Kj1rpRp5N8wOlAJf237JLeUPZbDNvHhWu
	 r4MKhzDTz0Fydch2mR5Osz3s/kA5+CHGx8DGV4Eiz/m4m+MmasefEeS7XVepqC12HfqAhdcAETjB
	 oDaCn8Njvj+bxW6oBpYQn8FGleCucIeN6k/Anira2+7YQv6aJxjVKbRt6WIGIkUQGIVWOhI6on5i
	 9Kgy3naIOwCTvSopy2ejS+kFCPkvEsE/aRmgiXPBAlgEcxgahgSye0pFpinqPuEgy/uOYgotLlw7
	 hgEwBbnN7G5DGliYAKy0vqg5Nokb41DcuTth6a3BgsgjLX+1nP9NamZS0+Ucka5XmUFss3X0o+Yh
	 E3XnrFuHou/Gll7NXSveqbfwZpT5VULiPBPu1LDIzzBMMWi3Zk2Gr7W5XwdgbmZ2aArvYcGeSjPr
	 sBvt7X3mbT9YiBnJyg0i+Y2hi+xBZXuSbt50z77c3nPzdbaZF4xzxB+5pueIt2c4PfvcJZQZ8Ba6
	 BT/2FecNeLkpNYNsjpLTgaDdGpSfz2vRjVjDsHei9vPp/qGxdh5tFQW314EvHkSrdhnOSsGhncuS
	 BxxM+48eItdb25FOLJIQ3zszPKKq1apbYLFwB9EY7fQRq82WnzB5hb+aDmF0ghGAp6KMGzW/71B7
	 qnZoGcAK5sNeDj7DHm/suF3FOLGO856jqWkTLKZQN39wYIzQNAlqhvHdG7ff/KcGjEuc6lNnwin7
	 9jSfF2synbzNH8bx+jasxcKooAHv/DH+/dY/XU3kLiEX5tU2bPiCuwndbO4M2Hp/aXBuIK8xYFix
	 Gi7BZwwBuAWroXpXtUvWXiJEy/CKem4Jv1ydxoiqgdtPORRGa1uI5taHSfxuvA1Lc7yp9Q6OPoe5
	 gV8sOoQzbPcccHamc3PzBdeHJ6WqucGYJxArkRr3xRlJas+CEUbkUSKSWLiLETsXL2Tp5D4Mh82G
	 bf/VdDod/6ZfcjRm08iIkXx7CYBPrPVP5I1YEOeA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array
Date: Fri,  8 Mar 2024 23:50:16 +0800
X-OQ-MSGID: <20240308155016.350518-1-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

The boundary check of u8's extra is currently performed at runtime.
This may result in some kernel modules that can be loaded normally without
any errors, but not works, as follows:

 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sysctl.h>

static struct ctl_table_header *_table_header;
unsigned char _data = 0;
struct ctl_table table[] = {
	{
		.procname       = "foo",
		.data           = &_data,
		.maxlen         = sizeof(u8),
		.mode           = 0644,
		.proc_handler   = proc_dou8vec_minmax,
		.extra1         = SYSCTL_ZERO,
		.extra2         = SYSCTL_ONE_THOUSAND,
	},
	{}
};

static int init_demo(void) {
	if (!_table_header)
		_table_header = register_sysctl("kernel", table);

	pr_info("test: init module.\n");
	return 0;
}

static void cleanup_demo(void) {
	if (_table_header) {
		unregister_sysctl_table(_table_header);
	}

	pr_info("test: cleanup module.\n");
}

module_init(init_demo);
module_exit(cleanup_demo);
MODULE_LICENSE("GPL");

 # insmod test.ko
 # cat /proc/sys/kernel/foo
 cat: /proc/sys/kernel/foo: Invalid argument
 # echo 1 >  /proc/sys/kernel/foo
 -bash: echo: write error: Invalid argument

This patch moves the boundary check forward to module loading and
also adds a kunit test case.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
v2->v1:
- kunit: detect registration failure with KUNIT_EXPECT_NULL

 fs/proc/proc_sysctl.c | 12 ++++++++++++
 kernel/sysctl-test.c  | 30 ++++++++++++++++++++++++++++++
 kernel/sysctl.c       | 14 ++++----------
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 37cde0efee57..136e3f8966c3 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1096,6 +1096,7 @@ static int sysctl_err(const char *path, struct ctl_table *table, char *fmt, ...)
 
 static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 {
+	unsigned int extra;
 	int err = 0;
 
 	if ((table->proc_handler == proc_douintvec) ||
@@ -1107,6 +1108,17 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 	if (table->proc_handler == proc_dou8vec_minmax) {
 		if (table->maxlen != sizeof(u8))
 			err |= sysctl_err(path, table, "array not allowed");
+
+		if (table->extra1) {
+			extra = *(unsigned int *) table->extra1;
+			if (extra > 255U)
+				err |= sysctl_err(path, table, "array not allowed");
+		}
+		if (table->extra2) {
+			extra = *(unsigned int *) table->extra2;
+			if (extra > 255U)
+				err |= sysctl_err(path, table, "array not allowed");
+		}
 	}
 
 	if (table->proc_handler == proc_dobool) {
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 6ef887c19c48..84e759a8328f 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -367,6 +367,35 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
 
+/*
+ * Test that registering an invalid extra value is not allowed.
+ */
+static void sysctl_test_register_sysctl_sz_invalid_extra_value(
+		struct kunit *test)
+{
+	unsigned char data = 0;
+	struct ctl_table table[] = {
+		{
+			.procname	= "foo",
+			.data		= &data,
+			.maxlen		= sizeof(u8),
+			.mode		= 0644,
+			.proc_handler	= proc_dou8vec_minmax,
+			.extra1		= SYSCTL_ZERO,
+			.extra2		= SYSCTL_ONE_THOUSAND,
+		},
+		{}
+	};
+	unsigned int size = ARRAY_SIZE(table);
+
+	KUNIT_EXPECT_NULL(test, register_sysctl_sz("foo", table, size));
+	table[0].extra1 = SYSCTL_ONE_THOUSAND;
+	KUNIT_EXPECT_NULL(test, register_sysctl_sz("foo", table, size));
+	table[0].extra1 = SYSCTL_ONE_HUNDRED;
+	table[0].extra2 = SYSCTL_TWO_HUNDRED;
+	KUNIT_EXPECT_NOT_NULL(test, register_sysctl_sz("foo", table, size));
+}
+
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -378,6 +407,7 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	KUNIT_CASE(sysctl_test_register_sysctl_sz_invalid_extra_value),
 	{}
 };
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f67b39d3d6e5..28888744626a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -977,16 +977,10 @@ int proc_dou8vec_minmax(struct ctl_table *table, int write,
 	if (table->maxlen != sizeof(u8))
 		return -EINVAL;
 
-	if (table->extra1) {
-		min = *(unsigned int *) table->extra1;
-		if (min > 255U)
-			return -EINVAL;
-	}
-	if (table->extra2) {
-		max = *(unsigned int *) table->extra2;
-		if (max > 255U)
-			return -EINVAL;
-	}
+	if (table->extra1)
+		min = *(unsigned char *) table->extra1;
+	if (table->extra2)
+		max = *(unsigned char *) table->extra2;
 
 	tmp = *table;
 
-- 
2.25.1


