Return-Path: <linux-kernel+bounces-107753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C67F880147
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10720B23B49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B907F7F6;
	Tue, 19 Mar 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="u7slaV2I"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6E65BA1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710863911; cv=none; b=TrdJBRSM3EG0IFhhHPQ/NRrTqWZcozdZfdPCEa/sLZvhU2xT2aMGyHPcE5/QT+NYIhT1Sga+xAqnuY/bmClCIYMww5tyxBU5OLnk0+aeA5KETBUI206KMPdoNGyjxooPnWFSA91NinyLfbuqd/KPKZexqKaHJVLjR4f5WAidlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710863911; c=relaxed/simple;
	bh=7sRfioFmtmF5F5YgminWOfmHP22Uae5P7Pyi525wbTA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=j5rPM+9IHJjj3K9FhKsI+GwoZ3vJRynyxX/lJx5NaDbGnpAaIaBYRIDelVgaDDfHdIDj8o6DSm4GVASOSTsvqaJUTJGSDajux/LmB/fgEeoVhGAtCNlVIjw7JYNbedgubyEKAW5oO5McjIc6Dl5ATzVimj3u/GbQ0Z7f8ElR3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=u7slaV2I; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710863895;
	bh=9UgUOj1ogZO5bIld9wyvdw1ttRAAZG74D3bk6rSCtuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u7slaV2IsypbdWqPANFoYCW1pmDMsBf3EhWb98UM0G8Y4sZFF2QZRgGWW5liqC1dJ
	 F+v2MkDyZ2pnmLV0cX0LxcOwBUExmrX/j97DSTgJaXcGrnnwuD/MpcjpAyFrAuz6rD
	 4EeZivvMNhnV71yDl/YS6/imkeExpG4p5JfPvldU=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:1774:d6f7:f5f5:b6a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E8996A1C; Tue, 19 Mar 2024 23:58:09 +0800
X-QQ-mid: xmsmtpt1710863892t5sd3mjlu
Message-ID: <tencent_45CCF47E36CFFE5531D485417D93D0E96B08@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeie6hk/FLpFtin0oH91yemkGfAix76v5JVUBr5mjJYe5eBbLUoaMH
	 bjWs3I5KLgvdXdtG7xgwXOxoSMhVRFsLlD/7I2XO2d7dy+x9BuxrJXBwuMtaMWoVnaDrEHzB4jva
	 MQWZVQgulARvIBtmCy9kSNDCxWkf9tG4TYjbNMZTvfjh8uQTBWwiR3S/3zZ1bQQj6t5EcRzcSWsH
	 JgSfyTzU6Qs4DcKCZ3mwpk7FvvLP35rIntSRZS7BX0uBOBw432gTbatZhZB8KV7/WNkWRuCyVfJ6
	 A3+SfKoqrErryyMkvfBDxdALzjmdPQlciclSNt8FlrL/AuF7Ly0f1Z5nlfE71E/gipm/9nn8PRB8
	 ynO4DvpyLoYBRFgeRa3v6nuk/nL09TYLEZU0mgIBqpG129On+Fq+0pi6pTaqEnJeZ0E/bxraccnu
	 k1ic/U2TYLimcrjCPVTw3lWs3jksQXE0PT4LoOpzYfq07SzBPLy6o4gmLGeGXj7KF7bmVGfeHJFW
	 yuJ1QYtacsFo6WL+GknH8ew6QxMTAMsmLdkNe9inrfnePVoHIgTlM6c2YdGNio5PoPklCzKbyM4W
	 FH/Qre6S696xL1wUy9vF/ch6EBYx0iCeQyqYLvYkgHwyEDKkgHiOG1s7ZeTQWvlmDRMkLwzS1NaM
	 I5nASwVoDiIbGa6Oxst+IDEtK05vOsgSXaS7th+NNsNZpSj+7hbwvhpoeZKZbUGT5CJwuysQkASs
	 k2LTK+KNaB16DUyafZSYPn5KfPlXnE+DTXyuhNDI61fLYycD131dX4AMUwJKiUzRgho0upXFTCYS
	 4qEePMRsbADExlUdvN1VjIDxTbcY8wdSzo6RDuJNakfcpNOwJ1477ClFqCQUbQaNTpYT898Hf7pD
	 atBVjvzzkyCRCdzpLqJB7J3CzpTelFbzL1DwLYHUMOnFI3+vy9dGyiKbUO/YyG41R6bVoMCTWUxQ
	 cyBjSbGIYzoJ78rzrkirQXCqaZWXcXfC7+5+TbKxbIP76hfI6h7jXKbauy0UQyPcViuoQFQbdCwi
	 MMA4nHh9SWNO8nBfJyUeMDtDSyMKY=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>,
	Wen Yang <wenyang.linux@foxmail.com>,
	Iurii Zaikin <yzaikin@google.com>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 2/9] kernel/sysctl-test: add some kunit test cases for min/max detection
Date: Tue, 19 Mar 2024 23:57:43 +0800
X-OQ-MSGID: <1c47c8e61b9e3fe6cdbaa67935cd85b0edd8c323.1710863674.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
References: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
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


