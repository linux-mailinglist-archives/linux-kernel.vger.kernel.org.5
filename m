Return-Path: <linux-kernel+bounces-97845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AF2877071
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C45281936
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B52D04F;
	Sat,  9 Mar 2024 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UENNEBn2"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15D414294
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709980328; cv=none; b=Oi36mzI2Bdz6S/Xbifif7diDUPZZufNi9qBPov8BUxR32duCVjPWQg0+knF67z7t1Qs1icHnJy29oZmHDZB+BcKhMT3d8AEVQ50qwq071DtTH9itIFHk/6MMEMiEZcEMCeV6MVtkXbT8M075wxLnEw9CxZgW1B5zcfxfbDBy7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709980328; c=relaxed/simple;
	bh=7sRfioFmtmF5F5YgminWOfmHP22Uae5P7Pyi525wbTA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jmkC5yp4mMgUQaIw9x6kGSCskR7EYszqDjdsj12NXeUOGoFqYqXNAKyUfTBBOtkV0uKp4T/+EcLNs9VDKEduCdgZORl/D8bvTAGdkjcERMC6J6j+S7rI0WRE0aMi5pvkmtntMk3bd2h6MnHdy4OcoyHVTt9oFOfIp7d2Ts3bVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UENNEBn2; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709980317;
	bh=9UgUOj1ogZO5bIld9wyvdw1ttRAAZG74D3bk6rSCtuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UENNEBn2eiyxOnUq8XdtiHJKTGsuHSEAcIuRWvmTzf6hNi+fiAa/tXAd0T8kgh0Bb
	 wDjog3ZXfdJ2uU0cZHr0EvTx/EkPbf4Ei2cO8fwRn2Xs0ZNVo6/Ql84UjsfIfmk2xG
	 I/IjeOD78TKoU7jfZoZwAo3sz7W9EXZV1JGSXuBM=
Received: from localhost.localdomain ([2409:8961:2a0b:4ad8:c972:9bc3:984f:98a9])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7EF8DC9A; Sat, 09 Mar 2024 18:31:47 +0800
X-QQ-mid: xmsmtpt1709980314tjkyv9h75
Message-ID: <tencent_0BABB4A98B82F82601D38999FBFD4C9EB709@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIesaiix6IN1yS5ygEoqXXyN+IslzLUtY+Er5oA+1n9G1snUkEK8T
	 Ocd5Xcvxc3fvMlzlqGGfRhUTAHl3ybUlvlB2j/NZx2rpwvO25c/rfN4Iow+0NsG7KFukMleZomTM
	 kqAAunIQFChuxPcMyRWm6H2kr7SPcTk9zgD/txg4WRwsCKUWaMijjykFbnFtJ9lGigin492R+m1k
	 46u1sOM8MYAIK01SQHRjT4D6lGTlBlY5az27U4ONWE4cAPUnKkp3IQ7EBFb9O28k35GKEZE7UaKN
	 DdNaixnhe5qD5yrzAVZBD2DfDmU8cwRbD2Nn5Z2eavqX3b0uiu9BgW+X6yL2wFhFl3IQ4URZwtcC
	 zE4+nG/rnKfxGrHJimPlQYR2D3BufBR0NN+XcDpLBtdR2FK/3nhATWWlcgB4wJSgMfeRJf6VW5bL
	 nBBJ3kz9GHcHgH1U6vLvxP+ZACBFlrW/BS08yxWRINwy1XxkbKUDYZWtFVUiibv3dRXLwrnaxOsa
	 tE7at/nk0q3XI187Z7nFEtZ9KUPmjEmKdMmI+kvXql/IGtCEBSKScM1yqdJYqmVFVPGpKlMzfK39
	 jk/oUwpxx+tvHB5DFrmyM5y0GUlWYS9XsVR9LWZSMPNefdk//saIlqPCsCyZ5GLh8jfwlq4zGRko
	 Ft4Fq97VuntqFmIiltGXo2LoKQH5be4mo2qsZJGyiwaP21xWNtBvdG80GeLgmKDOjkMuKerJ/81n
	 l0AM1kcYgh/NNyTrf+iPhUvfaSVp2hTMfvSFnf8TQPbJn6iohgo/Rq0k/h/jCEAnmOejTj1dIcHm
	 b8LdWHOeuu+LUBGyHYi+toFC6s3zWUvsO2CWcgKYJMXkzvIPiL9k4hICFQOwywnKxqMzoTYT7w0x
	 QcouPJbREwUNL2dQcGH3Ri+6mx2N+Th+b+ZOpVFPmta0uonqY2bJG1Q3qxOZiq2G4LyB/htBA0V4
	 xtNqTEEPd1P8RkzjZIglDjwj3PEhTwzoT6v+QDzDfwSPprMrBwrGkXw+fUQ97PBWK1Ah0cblDbQ+
	 sDUH3aNrXpBy40UjWgQv/qhAZPIUo=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	Iurii Zaikin <yzaikin@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] kernel/sysctl-test: add some kunit test cases for min/max detection
Date: Sat,  9 Mar 2024 18:31:19 +0800
X-OQ-MSGID: <2eca088f772b719a2919687b11e10a0d6e964447.1709978655.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1709978655.git.wenyang.linux@foxmail.com>
References: <cover.1709978655.git.wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Add some kunit test cases and explicitly check the newly added min/max
initialization behavior. Including basic parsing tests, min/max overflow,
and writing data, etc

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sysctl-test.c | 300 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 300 insertions(+)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 6ef887c19c48..0a2b19ae2a8c 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -367,6 +367,300 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
 
+/*
+ * Test that writing the int value and check if the min/max are met
+ */
+static void sysctl_test_api_dointvec_write_single_with_minmax_check(
+		struct kunit *test)
+{
+	int data = 0;
+	struct ctl_table table = CTL_TABLE_ENTRY_MINMAX("foo",
+							&data,
+							sizeof(int),
+							0644,
+							proc_dointvec_minmax,
+							SYSCTL_NUMERIC_NEG_ONE,
+							SYSCTL_NUMERIC_ONE_HUNDRED);
+	size_t max_len = 32, len;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	loff_t pos = 0;
+	int i;
+
+	for (i = SYSCTL_NUMERIC_NEG_ONE; i <= SYSCTL_NUMERIC_ONE_HUNDRED; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, 0,
+				proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, i, data);
+	}
+
+	data = 0;
+	for (i = -10; i < SYSCTL_NUMERIC_NEG_ONE; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, -EINVAL,
+				proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, 0, data);
+	}
+
+	for (i = SYSCTL_NUMERIC_ONE_HUNDRED + 1; i < 110; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, -EINVAL,
+				proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, 0, data);
+	}
+}
+
+/*
+ * Test that writing the int value and check if the min is met
+ */
+static void sysctl_test_api_dointvec_write_single_with_min_check(
+		struct kunit *test)
+{
+	size_t max_len = 32, len;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	int data = 0, i;
+	loff_t pos = 0;
+	struct ctl_table table = CTL_TABLE_ENTRY_MIN("bar",
+			&data,
+			sizeof(int),
+			0644,
+			proc_dointvec_minmax,
+			-10);
+
+	for (i = -10; i <= SYSCTL_NUMERIC_ONE_HUNDRED; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, 0,
+				proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, i, data);
+	}
+
+	data = 0;
+	for (i = -20; i < -10; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, -EINVAL,
+				proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, 0, data);
+	}
+}
+
+/*
+ * Test that writing the int value and check if the max is met
+ */
+static void sysctl_test_api_dointvec_write_single_with_max_check(
+		struct kunit *test)
+{
+	size_t max_len = 32, len;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	loff_t pos = 0;
+	int data = 0, i;
+	struct ctl_table table = CTL_TABLE_ENTRY_MAX("qux",
+			&data,
+			sizeof(int),
+			0644,
+			proc_dointvec_minmax,
+			SYSCTL_NUMERIC_ONE_HUNDRED);
+
+	for (i = -20; i <= SYSCTL_NUMERIC_ONE_HUNDRED; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, 0,
+				proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, i, data);
+	}
+
+	data = 0;
+	for (i = SYSCTL_NUMERIC_ONE_HUNDRED + 1; i < SYSCTL_NUMERIC_TWO_HUNDRED; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, -EINVAL,
+				proc_dointvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, 0, data);
+	}
+}
+
+/*
+ * Test that writing the unsigned int value and check if the min/max are met
+ */
+static void sysctl_test_api_douintvec_write_single_with_minmax_check(
+		struct kunit *test)
+{
+	unsigned int data = 0;
+	struct ctl_table table1 = CTL_TABLE_ENTRY_MINMAX("foo",
+							 &data,
+							 sizeof(unsigned int),
+							 0644,
+							 proc_douintvec_minmax,
+							 SYSCTL_NUMERIC_ZERO,
+							 SYSCTL_NUMERIC_ONE_THOUSAND);
+	size_t max_len = 32, len;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	loff_t pos = 0;
+	int i;
+
+	for (i = SYSCTL_NUMERIC_ZERO; i <= SYSCTL_NUMERIC_ONE_THOUSAND; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, 0, proc_douintvec_minmax(&table1, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, i, data);
+	}
+
+	data = 0;
+	for (i = -10; i < 0; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, -EINVAL, proc_douintvec_minmax(&table1, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, 0, data);
+	}
+
+	for (i = SYSCTL_NUMERIC_ONE_THOUSAND + 1; i < SYSCTL_NUMERIC_ONE_THOUSAND + 10; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%d", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, -EINVAL, proc_douintvec_minmax(&table1, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, 0, data);
+	}
+}
+
+/*
+ * Test that writing the unsigned int value and check if the min is met
+ */
+static void sysctl_test_api_douintvec_write_single_with_min_check(
+		struct kunit *test)
+{
+	size_t max_len = 32, len;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	loff_t pos = 0;
+	unsigned int data = 0, i;
+	struct ctl_table table = CTL_TABLE_ENTRY_MIN("bar",
+			&data,
+			sizeof(unsigned int),
+			0644,
+			proc_douintvec_minmax,
+			SYSCTL_NUMERIC_FOUR);
+
+	for (i = SYSCTL_NUMERIC_FOUR; i <= SYSCTL_NUMERIC_ONE_THOUSAND; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%u", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, 0,
+				proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, i, data);
+	}
+
+	data = 0;
+	for (i = SYSCTL_NUMERIC_ZERO; i < SYSCTL_NUMERIC_FOUR; i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%u", i),
+				max_len);
+		len = strlen(buffer);
+
+		KUNIT_EXPECT_EQ(test, -EINVAL,
+				proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, 0, data);
+	}
+}
+
+/*
+ * Test that writing the unsigned int value and check if the max is met
+ */
+static void sysctl_test_api_douintvec_write_single_with_max_check(
+		struct kunit *test)
+{
+	size_t max_len = 32, len;
+	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
+	char __user *user_buffer = (char __user *)buffer;
+	loff_t pos = 0;
+	unsigned int data = 0, i;
+	struct ctl_table table = CTL_TABLE_ENTRY_MAX("bar",
+			&data,
+			sizeof(unsigned int),
+			0644,
+			proc_douintvec_minmax,
+			SYSCTL_NUMERIC_TWO_THOUSAND);
+
+	for (i = SYSCTL_NUMERIC_ONE_THOUSAND; i <= SYSCTL_NUMERIC_TWO_THOUSAND;
+			i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%u", i),
+				max_len);
+		len = strlen(buffer);
+		KUNIT_EXPECT_EQ(test, 0,
+				proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, i, data);
+	}
+
+	data = 0;
+	for (i = SYSCTL_NUMERIC_TWO_THOUSAND + 1;
+			i <  SYSCTL_NUMERIC_THREE_THOUSAND;
+			i++) {
+		pos = 0;
+		KUNIT_ASSERT_LT(test,
+				(size_t)snprintf(buffer, max_len, "%u", i),
+				max_len);
+		len = strlen(buffer);
+
+		KUNIT_EXPECT_EQ(test, -EINVAL,
+				proc_douintvec_minmax(&table, KUNIT_PROC_WRITE,
+					user_buffer, &len, &pos));
+		KUNIT_EXPECT_EQ(test, 0, data);
+	}
+}
+
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -378,6 +672,12 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_single_with_minmax_check),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_single_with_min_check),
+	KUNIT_CASE(sysctl_test_api_dointvec_write_single_with_max_check),
+	KUNIT_CASE(sysctl_test_api_douintvec_write_single_with_minmax_check),
+	KUNIT_CASE(sysctl_test_api_douintvec_write_single_with_min_check),
+	KUNIT_CASE(sysctl_test_api_douintvec_write_single_with_max_check),
 	{}
 };
 
-- 
2.25.1


