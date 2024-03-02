Return-Path: <linux-kernel+bounces-89476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4E786F0DB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084791C21321
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC61B18627;
	Sat,  2 Mar 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bY6HrhP4"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4510FA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709393288; cv=none; b=hpokMPxhpb/+j57idj86JZfzbC1HMYkx5HdDUGNv8kP7aTeVVdU0q4toTQ8UWXIlzMEGMOMxGMj7rhgP9C6GLwkvxxweWc8p/tkqdZeWcgeKys2+5txTNBqUbvnVjhfGylZhpf8FIJX0XMH4q/EtDx/1rrH4i6rt8nENqF8BjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709393288; c=relaxed/simple;
	bh=ozJI79HqGE92jgwvFuOdH4xM0GwWyR9/93hWEIkAQRg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=J+cwq+HDYVxDIohFlP92ThK2iEbOOk7AAcTE0OiUg7BjjBn90JBHlEGlCec8dVxjEKbExRm+1/LYFM0FGT0qrXGHuAKIfTsPBSw17XoxPMakMTWph3epIHGdZhSh6vTk1TK6cD8I+3DzCOY1Rqb/awMUkPp1pcVOj2v/i+f8aq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bY6HrhP4; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709393272;
	bh=RKzkR9vje7Jpn9cyD5wBQ0iJFQUWAC2XF40CQ7KS6RU=;
	h=From:To:Cc:Subject:Date;
	b=bY6HrhP4mrltjm5z+JRlsbWOlI40D4rFcLkYrkbnO2s796GRusDwBkY2mk0FtzJLX
	 fIdQON74cptaamJqnU7Jn+t1EyYrwo/YBurQ10ZkJIEsPJ5QFfCfu0Yr1T++pgLEsg
	 t3wO8qth1aekOKv5HEog3DrkfzmeD8Gj+BCxbN34=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:643:4925:a13c:f154])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 6F130068; Sat, 02 Mar 2024 23:27:49 +0800
X-QQ-mid: xmsmtpt1709393269t45gsp29s
Message-ID: <tencent_8599CCEFED19AF4A8A5A358862B226FD8A05@qq.com>
X-QQ-XMAILINFO: M8Cd2byC8kc4sMgNs5MGDF9+GKnvRAeMWeudfJpSJWOKgDLy4JjyRY4yaKhYXI
	 Fk6N+J3l4VVZfZ24yyrbbTlj0lJwYP73EUX+yOvVESoLSOn2skrxm1NhD1vOqN108gOPfz2uzda8
	 xHYjHylF0W7vLZkFFfHvGCJS66sryl6bMxGWVkf1LmSL+TKncKq+qIJe+EuLMO89fi87kDaqCW6+
	 KEM4yU9ikwzOqEICJgcoDiyMP9bTZ70rIBVLotVSfCcbf/JoaFp/QgG74xs4RH4ctJCfzaxidOQ4
	 fUBqWDrit+5rzgSCLA28CzQhUqBlml2ffs5YiNCW8cvSCZvdD3xhQwL1xj96hnvabZ7XHFs6bxjG
	 pPW44vPXizET4TgiP7q+kgsEyhPVuTu9Zu5t1iYumnrX1xCnYOQySxwPUjZjhMjlZJZVlSYBSnG+
	 5TI3ZdnHhacwVtxaS4AWkwG8pRDU3BHHg3RwX8IUqZjJFiC6k3EpAH32EJsuYlqMcP9+mGuEqUeu
	 z6CZO6ttpsGRUogGb8kRqYcDVYCK6y92dkTn/F6gSJrb2wBH9TQ+zoZE9VYpXYP4ee3UVNtrBZ+s
	 ntrjzXIO8j3fcyDp62BQo43X0nYpxHYEeCzN5Z5Z36p9neoGmiS4MncVkvbQDingbyVF0/T1YmGk
	 HLdxyTUCmB+s6Fjha1KG/Gf5D+iEUH9i0y49OBb4xb+UA3Xy8be+Qizf8ydTmtRbFpDRhwh5/okt
	 5E2odme9PeBbiskM8/bvruJ4Z3bQvwg5CRgyjurFAIUTYNXjDOQJ4lDBW8OIz45roVBmetiS/Ryr
	 Vbax0qBEMRC8S/qMVlCEud+LE3L8lKsvAqczf4KQhfLZqEcZkn2dNj4bje1NlK4nrrrwrCFg61HJ
	 Kr1DfXbVNnrALUGrE/bzPjz7hmKrWQS5CUuyAr0eMTqCk+x5MtHBJqtUJzqnmjGrbYJfbyo4nYft
	 4Y9HgH/PrYQykSVq0KqMZ2lhWtPu3vVTNlzmgo9CKevyR0L+waZn/6eZfaY5J64nCbTaVIDxV67A
	 dcs0H2nZgU/RCSxxhvwxUjS30vAf45IKtC9riEFM5XG7l/9+s2gDghnOKYM5GHFmWjSFNiuZKEa9
	 GsQoIQACcDLNzpO9w=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array
Date: Sat,  2 Mar 2024 23:27:45 +0800
X-OQ-MSGID: <20240302152745.129411-1-wenyang.linux@foxmail.com>
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


