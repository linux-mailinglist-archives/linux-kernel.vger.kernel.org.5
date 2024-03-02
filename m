Return-Path: <linux-kernel+bounces-89468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CA686F0C2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800E628386A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEFB29A1;
	Sat,  2 Mar 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="WMcUGTgG"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4D31877
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709391859; cv=none; b=h103KkNqpf0ZbGAi13wK6FvZe+jx3700c9d+NsJ//vMfH4ASRHusFTyvvkiGZgMjNQE10+XAK7IaVTnW/8GWDINBmDM2XyNwiRLIE2xvNRI7kXJCCnFxX3U++mWGXDau2IWS3RHwbmNWcKAc1fDfpOrqVoohB6MpLpl2zcElEjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709391859; c=relaxed/simple;
	bh=m73e+2MqGvs4gmpRYL8WGDwBq851Ng6wBqDejLN06fg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=pbsTQP2E653weOfPZYpST8uCWgkDfU3vRl1uN0+y/DxtzS9QTr0mua+VjA765FqcJ+i0VWygmRqTPjOhXkZMj6hc+QGNI4Z265IZljXq0QiXtsb32x+xc4DzvIbso16vgh+ys1TdYYhxssCvv+nNsy2NSZhxluAxthERcm7bsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=WMcUGTgG; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709391840;
	bh=flCSkjm8nfxOMgB/T8eCfmJzMmizL75i09vf3K97ajI=;
	h=From:To:Cc:Subject:Date;
	b=WMcUGTgGDwO9bVwWfHBkFLu0yMeBJZtNlS3CYsRnvizBfR2xlinZ5KB/59xwzt/yF
	 WS/S9JvdMbBBNWQ05d5XHzC6Y43Ar+2jzZOOcN2NayEIL7u50AxAKOtnYAXlsi9c9u
	 ztfRqenMSvfJHeyCkq6sDGobfbfMHyg0u73DkdNA=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:643:4925:a13c:f154])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id F9AA099; Sat, 02 Mar 2024 23:03:57 +0800
X-QQ-mid: xmsmtpt1709391837tsij0uqqu
Message-ID: <tencent_F4E6583FBF67A22A436AA020A5C9A7F44207@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqIr31YICvIFYmkQ1uvZnKT9+0d2DtKhdPGnfEufz9TDuSjWY2hh
	 65fUrBCYfi9eUYVAlD2Kc8CAcX/LlaoA2psnP9YBRWxnB+JzMlr/FfasDPiKWrHrbFZIyV/4bzeo
	 lUKd3sfuFrjsWmF70rboPUkT+Pc/AWQ/snBgoV5m/J7W7elNiNJh/Np3rOrWUk4fDf4Dz4jALbea
	 hbZyFpxWeVIxfq+guCvs+AXZwdSiq6bpZ4WB5bC387D4w9pt/ZUtNBJxYOcErWyVXiBpm+rr2Mxm
	 ZPHyRaGPkbiY5YyiybnHFtVJ8QGR4qjQVULTk9MRA9hJmy1OEOV+FcombZOijAmw+eFD5RpHezpG
	 BzlHtJda2qznyYku2ts3kd2gIvsFvm2BtcR4jGHELhDzqrNwkFDz+ASC4dEEd/hjxX3fetPvVZyC
	 XFAPmTShMBBbdUqjbDvNgOL3C/yJnP/9hT6PygqR9gAAEZXKkJbTPx4KGmMYiBXIbNbOUKXlBKAO
	 Bn0XOfIZw4H0gZsuVzZ3T00e3KLETOd5NPPvW5WV+0FaVJADU+oPQP5zRM/Y5uJTd8bDWyHgY7bH
	 FsRlbv5a5hFlOXlrl4hfPMYC+SnwARUV7DfFxvMnmdgqz22l0Ui8omV3eFHYD0vAwHojXxijqLJs
	 A8++QyLruooYxxPh7AJbcZwgDbmUcF3f0EDHFmehQg2XNyO4DrPRcZ522pAsV5daXdtCw3kYLvw9
	 ePekcNcwmvclL2AN7v3k44VociuPJ8mC97kHYtD3XBp90oF2FTH2zjINOPE2Fkog1qQ+dfh0QiWG
	 E4DZb3qIUlZvZrqPkGZ+hfVuKE/9MwAeNyhP1UOuW5Cc06ti2IVw4WMHB4/nBkRwpl30IuUU70od
	 L8sOUWKD+dOh3DdQgu+y/+uzDq8OYMLGqS3tiHtm6aGiVqLO44WH8OTLnwmOpB/t4wnIJE5GyOfx
	 TeI95tTm6svuDbD5rfYonHra7u3frgbvA7cFNV3FBB0Auy0/VlLziFN4kDF40U+Tz74twvAE1iqR
	 V52TQP+ZzAltnTkz5RkMOIYL0J37I=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array
Date: Sat,  2 Mar 2024 23:03:43 +0800
X-OQ-MSGID: <20240302150343.111766-1-wenyang.linux@foxmail.com>
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
index 6ef887c19c48..3918c9310220 100644
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
+	KUNIT_EXPECT_NOT_NULL(test, register_sysctl_sz("foo", table, size));
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


