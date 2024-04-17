Return-Path: <linux-kernel+bounces-148634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92578A855B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 512BB1F251A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95CE14039E;
	Wed, 17 Apr 2024 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxsQ3RyS"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017E13DDA8;
	Wed, 17 Apr 2024 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713362061; cv=none; b=apdetfZD1/Ikif0FiHyPCLkbz8FI0eRn8A70m0gFG+3YfHUM2uRU1oUzq2mL0lvrC5fp+ljtb6i5SoFRHplic16GJcxaeg7jJwFdQSPJKybPqFWMegO9dLH0ahCl/eFveQPMcYTFHj8ZnkCeMm1sxtVZmyovbqmHivepXhGYmtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713362061; c=relaxed/simple;
	bh=oO5xNCeJ9OsBvzLGvumkVboyrx0//YEJXbMHItroUlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RhL+HFTM4rNVg2dYZwXKXuhRMdY7du+i/AGH8w9CP0PqZnAuT1VUi2TOl8cuRCq2njJhPafEFtgtsy+qzbGMz0sYfJDkJNRNe5UPiIe61G9+YAfh0HLFsXXm0/DkCM6LQcdSJ/7DNIS54ZCv9ejGhixwWjCBKUkWGR4K/ihECSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxsQ3RyS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-349bd110614so123609f8f.3;
        Wed, 17 Apr 2024 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713362058; x=1713966858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5vg0U50e4xDyO2PA6e2sxZvZFwMtgUryAok0Y43g0Q=;
        b=PxsQ3RySvBwtbVqbwUO+G1JsQdny/4JcxVHLDfNepmsOHrrrnfZ9ScALECTW2/NcSZ
         FPMayKqTKWsu4cPcpHl0CXzbv7QL7Hlvx4uy7MnzVN0oOz6YudYwEnaOwUXROdFGrlQ0
         E423cuoO/JAh8/5C+qGOyXzwcZa6NDc0JRSDdo0Pab6mDxCa4Z2G7QrZJHnhSiFsX9Rn
         GL0slKhjrYgQAY3s/KgQkxlQQQyUjuJNyPnyvPZRKHqQBc/soUUT2YLHOycz/YG3pgPZ
         Z6gNdsc0xc/5loz2k2St/wDJak/Rp87p8nSTW4YJRu/vqVkeUPs/ADi7jY/7g4MnzWue
         HO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713362058; x=1713966858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5vg0U50e4xDyO2PA6e2sxZvZFwMtgUryAok0Y43g0Q=;
        b=Fi1EWs+HvDrw8cY30Ld/tHaQGj1OAFNh4YUV1Ws4fKpFvaGhZu23GTN4+5OBPPQbtV
         X9CSRID8nVuJt5rS6vUhS2CJ34E7A/ohKaFppoDnRY73uA622OhYBFTP8kMgtXPKTToE
         SGDMsQrhDxqF0g8mLcLrWCKIgw9WqpaJhrHlsrVxtmAGEAxC+ETE+2rBsKP9FRdLh8L4
         edehDh9Q1754vaoDPLrpJ52qHNTQ4TR1DRhtyc5cNDWVm7TgSswZLpK3mDMOuNv/VNDt
         1sQfX/KevSZnDSNYW0I+EJmjaTLnzFcQKFfljZ29DwqBh3t03Y8ANsFqGpz16+NYZWmP
         k62g==
X-Forwarded-Encrypted: i=1; AJvYcCU5SGv0iG0Edh+0p5zfwfMLGXIDTmmv9yUkuqtcOtDVmpfJp4FGBkKgQEByH41zwTGS56HNmPpfo5XkigRNTthUplZx44byfWvj+kgnC3nZvTBjMAMfC8QTJ6TtzUFXimed2PBLQwAIIeKKB1V9
X-Gm-Message-State: AOJu0YwY7LmqBpv3/g+IyxUjIqHI9gkYend5ZNFhmBeU042QEKOg/l+2
	9ZfTz7EE0pbLYyf1J7p//Djf2mx2NUNbwYUtboZD+EGNUiUfJgU7
X-Google-Smtp-Source: AGHT+IEOVnDxlkoeZvUW+igp5qIhaPzBI1duqV8WNIKedcZWb8S7UwIbytbnJy5v3WANTHb15qvSlA==
X-Received: by 2002:a05:600c:1c19:b0:418:90ac:3494 with SMTP id j25-20020a05600c1c1900b0041890ac3494mr3633642wms.2.1713362057792;
        Wed, 17 Apr 2024 06:54:17 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b00416e2c8b290sm2997607wmo.1.2024.04.17.06.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 06:54:17 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: keescook@chromium.org,
	andy@kernel.org,
	akpm@linux-foundation.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] string: Implement KUnit test for str*cmp functions
Date: Wed, 17 Apr 2024 14:54:15 +0100
Message-Id: <20240417135415.614284-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, str*cmp functions (strcmp, strncmp, strcasecmp and
strncasecmp) are not covered with tests. Implement the test which
covers them all.

The strcmp test suite consist of 8 test cases:

1) strcmp test
2) strcmp test on long strings (2048 chars)
3) strncmp test
4) strncmp test on long strings (2048 chars)
5) strcasecmp test
6) strcasecmp test on long strings
7) strncasecmp test
8) strncasecmp test on long strings

The test aims at covering as many edge cases as possible, including
the tests on empty strings, situations when the different symbol is
placed at the end of one of the strings, etc.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 MAINTAINERS        |   5 ++
 lib/Kconfig.debug  |  16 +++++
 lib/Makefile       |   1 +
 lib/strcmp_kunit.c | 170 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 192 insertions(+)
 create mode 100644 lib/strcmp_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..e23e6b91e2f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21182,6 +21182,11 @@ W:	http://www.stlinux.com
 F:	Documentation/networking/device_drivers/ethernet/stmicro/
 F:	drivers/net/ethernet/stmicro/stmmac/
 
+STRCMP KUNIT TEST
+M:	Ivan Orlov <ivan.orlov0322@gmail.com>
+S:	Maintained
+F:	lib/strcmp_kunit.c
+
 SUN HAPPY MEAL ETHERNET DRIVER
 M:	Sean Anderson <seanga2@gmail.com>
 S:	Maintained
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c63a5fbf1f1c..a6992631f32e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2763,6 +2763,22 @@ config STRCAT_KUNIT_TEST
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 
+config STRCMP_KUNIT_TEST
+	tristate "Test strcmp() family of functions at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test for strcmp family of functions:
+	  strcmp, strncmp, strcasecmp and strncasecmp.
+
+	  KUnit tests run during boot and output the results to the debug
+	  log in TAP format (https://testanything.org/). Only useful for
+	  kernel devs running KUnit test harness and are not for inclusion
+	  into a production build.
+
+	  For more information on KUnit and unit tests in general, refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
 config STRSCPY_KUNIT_TEST
 	tristate "Test strscpy*() family of functions at runtime" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/Makefile b/lib/Makefile
index ffc6b2341b45..1559d3bbea7d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -404,6 +404,7 @@ CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
+obj-$(CONFIG_STRCMP_KUNIT_TEST) += strcmp_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
 
diff --git a/lib/strcmp_kunit.c b/lib/strcmp_kunit.c
new file mode 100644
index 000000000000..8c444ea35269
--- /dev/null
+++ b/lib/strcmp_kunit.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * KUnit test for the `strcmp` family of functions: `strcmp`, `strncmp`,
+ * `strcasecmp`, `strncasecmp`.
+ */
+
+#include <kunit/test.h>
+#include <linux/string.h>
+
+#define LARGE_BUF_LEN 2048
+#define CHANGE_POINT 1337
+
+#define STRCMP_TEST_EXPECT_EQUAL(test, fn, ...) KUNIT_EXPECT_EQ(test, fn(__VA_ARGS__), 0)
+
+#define STRCMP_TEST_EXPECT_LOWER(test, fn, ...) KUNIT_EXPECT_LT(test, fn(__VA_ARGS__), 0)
+
+#define STRCMP_TEST_EXPECT_GREATER(test, fn, ...) KUNIT_EXPECT_GT(test, fn(__VA_ARGS__), 0)
+
+static char buffer1[LARGE_BUF_LEN];
+static char buffer2[LARGE_BUF_LEN];
+
+static void strcmp_test(struct kunit *test)
+{
+	/* Equal strings */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, "Hello, Kernel!", "Hello, Kernel!");
+	/* First string is lexicographically less than the second */
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Hello, KUnit!", "Hello, Kernel!");
+	/* First string is lexicographically larger than the second */
+	STRCMP_TEST_EXPECT_GREATER(test, strcmp, "Hello, Kernel!", "Hello, KUnit!");
+	/* Empty string is always lexicographically less than any non-empty string */
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "", "Non-empty string");
+	/* Two empty strings should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, "", "");
+	/* Compare two strings which have only one char difference */
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Abacaba", "Abadaba");
+	/* Compare two strings which have the same prefix*/
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Just a string", "Just a string and something else");
+}
+
+static void fill_buffers(char fill1, char fill2)
+{
+	memset(buffer1, fill1, LARGE_BUF_LEN);
+	memset(buffer2, fill2, LARGE_BUF_LEN);
+	buffer1[LARGE_BUF_LEN - 1] = 0;
+	buffer2[LARGE_BUF_LEN - 1] = 0;
+}
+
+static void strcmp_long_strings_test(struct kunit *test)
+{
+	fill_buffers('B', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, buffer1, buffer2);
+
+	buffer1[CHANGE_POINT] = 'A';
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, buffer1, buffer2);
+
+	buffer1[CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strcmp, buffer1, buffer2);
+}
+
+static void strncmp_test(struct kunit *test)
+{
+	/* Equal strings */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Hello, KUnit!", "Hello, KUnit!", 13);
+	/* First string is lexicographically less than the second */
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, "Hello, KUnit!", "Hello, Kernel!", 13);
+	/* Result is always 'equal' when count = 0 */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Hello, Kernel!", "Hello, KUnit!", 0);
+	/* Strings with common prefix are equal if count = length of prefix */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Abacaba", "Abadaba", 3);
+	/* Strings with common prefix are not equal when count = length of prefix + 1 */
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, "Abacaba", "Abadaba", 4);
+	/* If one string is a prefix of another, the shorter string is lexicographically smaller */
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, "Just a string", "Just a string and something else",
+				 strlen("Just a string and something else"));
+	/*
+	 * If one string is a prefix of another, and we check first length
+	 * of prefix chars, the result is 'equal'
+	 */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Just a string", "Just a string and something else",
+				 strlen("Just a string"));
+}
+
+static void strncmp_long_strings_test(struct kunit *test)
+{
+	fill_buffers('B', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, buffer1, buffer2, LARGE_BUF_LEN);
+
+	buffer1[CHANGE_POINT] = 'A';
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, buffer1, buffer2, LARGE_BUF_LEN);
+
+	buffer1[CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strncmp, buffer1, buffer2, LARGE_BUF_LEN);
+	/* the strings are equal up to CHANGE_POINT */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, buffer1, buffer2, CHANGE_POINT);
+	STRCMP_TEST_EXPECT_GREATER(test, strncmp, buffer1, buffer2, CHANGE_POINT + 1);
+}
+
+static void strcasecmp_test(struct kunit *test)
+{
+	/* Same strings in different case should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "Hello, Kernel!", "HeLLO, KErNeL!");
+	/* Empty strings should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "", "");
+	/* Despite ascii code for 'a' is larger than ascii code for 'B', 'a' < 'B' */
+	STRCMP_TEST_EXPECT_LOWER(test, strcasecmp, "a", "B");
+	STRCMP_TEST_EXPECT_GREATER(test, strcasecmp, "B", "a");
+	/* Special symbols and numbers should be processed correctly */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "-+**.1230ghTTT~^", "-+**.1230Ghttt~^");
+}
+
+static void strcasecmp_long_strings_test(struct kunit *test)
+{
+	fill_buffers('b', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, buffer1, buffer2);
+
+	buffer1[CHANGE_POINT] = 'a';
+	STRCMP_TEST_EXPECT_LOWER(test, strcasecmp, buffer1, buffer2);
+
+	buffer1[CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strcasecmp, buffer1, buffer2);
+}
+
+static void strncasecmp_test(struct kunit *test)
+{
+	/* Same strings in different case should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "AbAcAbA", "Abacaba", strlen("Abacaba"));
+	/* strncasecmp should check 'count' chars only */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "AbaCaBa", "abaCaDa", 5);
+	STRCMP_TEST_EXPECT_LOWER(test, strncasecmp, "a", "B", 1);
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, "B", "a", 1);
+	/* Result is always 'equal' when count = 0 */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "Abacaba", "Not abacaba", 0);
+}
+
+static void strncasecmp_long_strings_test(struct kunit *test)
+{
+	fill_buffers('b', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, buffer1, buffer2, LARGE_BUF_LEN);
+
+	buffer1[CHANGE_POINT] = 'a';
+	STRCMP_TEST_EXPECT_LOWER(test, strncasecmp, buffer1, buffer2, LARGE_BUF_LEN);
+
+	buffer1[CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, buffer1, buffer2, LARGE_BUF_LEN);
+
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, buffer1, buffer2, CHANGE_POINT);
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, buffer1, buffer2, CHANGE_POINT + 1);
+}
+
+static struct kunit_case strcmp_test_cases[] = {
+	KUNIT_CASE(strcmp_test),
+	KUNIT_CASE(strcmp_long_strings_test),
+	KUNIT_CASE(strncmp_test),
+	KUNIT_CASE(strncmp_long_strings_test),
+	KUNIT_CASE(strcasecmp_test),
+	KUNIT_CASE(strcasecmp_long_strings_test),
+	KUNIT_CASE(strncasecmp_test),
+	KUNIT_CASE(strncasecmp_long_strings_test),
+	{},
+};
+
+static struct kunit_suite strcmp_test_suite = {
+	.name = "strcmp",
+	.test_cases = strcmp_test_cases,
+};
+
+kunit_test_suite(strcmp_test_suite);
+
+MODULE_AUTHOR("Ivan Orlov <ivan.orlov0322@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.34.1


