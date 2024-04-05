Return-Path: <linux-kernel+bounces-133178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B8389A002
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801FFB23485
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167B16F28C;
	Fri,  5 Apr 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Ev+RxpEA"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081C15FA95
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328106; cv=none; b=PXAtaTDmZnP1a012lB9rr3jMyCpYdrxo/KI7+IYy97JBASzPHBUJNs/SYHlH+HWrpiEa23N9C8UVvws48odU0HEeaU04bapGw/EWc/0InmBXFaIJf/4CnFFUNV6MFrRN7sv2uTXGO33Z5A8ymZ2U9J5n6qerlNCdDfuHkMIrols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328106; c=relaxed/simple;
	bh=5NpUT3miNBD5LFLqv76YWlD13uZF47++BIZwJIrolzs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=g9D7FXuvh9vke71ZXng2sFcq2IGC5ciJtJaINGWpC8pYVkPN/UDfr6ZiB/jO0KoP9z1IPPmAhnDQYq7i356tmdBQoJw4AxfiaDDUXF1HqsC8sFKc8G0eAxqB6gpVV94SwLd3ytPtmOSadt/GoHRaNgTt4XqudP+1CXSk56zoB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Ev+RxpEA; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1712328095;
	bh=h1szTFKuBBT4B0FZ8+/wAdJnH1vl0StVKZ/7ccts1xY=;
	h=From:To:Cc:Subject:Date;
	b=Ev+RxpEAYMA/GEH//o8AG6Flti1KIAefp3fh5W2YotrYAYqWPHE6nUJHtfvkpxk5a
	 xL3yngAK2zxgJmBKApSvVtjtnkm0ykrN73FXVx6OZuQwxEf1eBSXl83naCn/R0/4+T
	 oMKcd9hxE9bqNEt/BC0g2poSqHvbkw3kYbz78skM=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:dc34:caba:9ec4:65ef])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id A4A1A43D; Fri, 05 Apr 2024 22:41:10 +0800
X-QQ-mid: xmsmtpt1712328070towhp7ula
Message-ID: <tencent_70C2A71330E3F84D3D1F55F9521B04BD4C0A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Gbp5H5tlpB41qttfa717xaaHZ5yVNQnf2eLmcW3VXfJh6LSKxS2
	 xuPbZl6YI8yqvyhXxb1kfHSdRRgKB981Q+B6yphCujW141/wlwS6fXsWJ6Xuxrl4xC0EpiozlkxE
	 uuBFV/7JOIUzzf7+NmIV77QLDpXjYLMxVPGpSiqghzwPw1a/siBSyWFepsPgKDTdgqFK8pZRNUMz
	 hW/XefP7uT4AgsG0qI/hokbk6WdGr8zm79xgyn7jQtqTnMb5hBadEl382rXxBWzS8FovGGtG59Wv
	 IOfIblTlt7shydIekdqShzbt/L2YD3QgkO5XfrAHfg5kzTmHQMkhniaai/ryqbap7bwkwID6WOJP
	 2mE5mvttygZ23nwOQhyebzm43ICWRCfkQeK/F27PJGWAo5VEfTQB0z/NnJ7o6QOkRTWvAOBrDEeY
	 xTA8kXe6sgQgRlDCv2SZJJb1UkCCUmL5A1q6hXQiVOQmVJ8pN8/A/cIHnOrlD10uvMzAP99r2aIT
	 jaWK/dYCW/WovCCfRQj37/eex9rl1YihbCoLIFZpurPXhiBRQ6zXn2OJccB3RpC4Ocxxfbp6nBdD
	 DvwormNku63rTaEbVsI9sPAaK5IcEDxwMAujHCIN18OwGCNIMKJbHzvbEG4lxhLk9rKfFT+IWIzk
	 76qVgvW2XVJvpklPdvwmUZw6Phjy88Ffrox97bHi3/+w9j79QOlC2ybQuN8U4d/9gtYEgpmh/mSO
	 4szk1jgT/UJmFUcSlXjXWd3jEJ/fmWQs8I/KImRzkr1a4hGRlhLuwFIzI06mi+HlS00GHp3PyKj2
	 zOzj2mfyDvxZVz1v3cXLkhx+0PIj84H1Dw35e1BSmkHHxz5PbJH1yz6NT0BgrG/r0gaeuyiun1Ir
	 GTXFA4RIsZsSUiTkdG4h7x8a9RWtWvuB9NVkrQWmGXKxdvtW+HtA4CgHomhX7HGkSS38tyl50Nbg
	 orl0QhF/9WxDDRgT4PalxZWF8vIi7n5VbG3/V7MszZzCFCBch9JHCS/ynOA4LHtJLm88mTh84oML
	 u2w7zR3jgZ4yMzNUrfnUf6xscmzUbF9EA3N5KZRQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array
Date: Fri,  5 Apr 2024 22:40:59 +0800
X-OQ-MSGID: <20240405144059.93871-1-wenyang.linux@foxmail.com>
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

This patch moves boundary checking forward to module loading,
thereby reporting errors in advance, and also adds a kunit test case.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
v3: 
- kunit: using register_sysctl, and thus unnecessary sentries were removed
- kunit: using constant ctl_tables
v2:
- kunit: detect registration failure with KUNIT_EXPECT_NULL

 fs/proc/proc_sysctl.c | 12 +++++++++++
 kernel/sysctl-test.c  | 49 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c       | 14 ++++---------
 3 files changed, 65 insertions(+), 10 deletions(-)

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
index 6ef887c19c48..4e7dcc9187e2 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -367,6 +367,54 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
 
+/*
+ * Test that registering an invalid extra value is not allowed.
+ */
+static void sysctl_test_register_sysctl_sz_invalid_extra_value(
+		struct kunit *test)
+{
+	unsigned char data = 0;
+	struct ctl_table table_foo[] = {
+		{
+			.procname	= "foo",
+			.data		= &data,
+			.maxlen		= sizeof(u8),
+			.mode		= 0644,
+			.proc_handler	= proc_dou8vec_minmax,
+			.extra1		= SYSCTL_FOUR,
+			.extra2		= SYSCTL_ONE_THOUSAND,
+		},
+	};
+
+	struct ctl_table table_bar[] = {
+		{
+			.procname	= "bar",
+			.data		= &data,
+			.maxlen		= sizeof(u8),
+			.mode		= 0644,
+			.proc_handler	= proc_dou8vec_minmax,
+			.extra1		= SYSCTL_NEG_ONE,
+			.extra2		= SYSCTL_ONE_HUNDRED,
+		},
+	};
+
+	struct ctl_table table_qux[] = {
+		{
+			.procname	= "qux",
+			.data		= &data,
+			.maxlen		= sizeof(u8),
+			.mode		= 0644,
+			.proc_handler	= proc_dou8vec_minmax,
+			.extra1		= SYSCTL_ZERO,
+			.extra2		= SYSCTL_TWO_HUNDRED,
+		},
+	};
+
+	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
+	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
+	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
+}
+
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -378,6 +426,7 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	KUNIT_CASE(sysctl_test_register_sysctl_sz_invalid_extra_value),
 	{}
 };
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 81cc974913bb..3efe3a991743 100644
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


