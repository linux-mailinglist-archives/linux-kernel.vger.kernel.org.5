Return-Path: <linux-kernel+bounces-149308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5368A8F50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00111C20D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB0E8595F;
	Wed, 17 Apr 2024 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZplvNQh"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712385643;
	Wed, 17 Apr 2024 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396640; cv=none; b=Wk7ql/KUH/hpIK+WWe9cCU+zGltD/+8bEpuOCo982YnYnbs63Tke98ZE+O9RLJlgMbtGNmbIvS1Omb4lYWKxvSKJBh/b2IHBQrEE6Z+nXlJZWZ6mJPuGcMtpuFv9ucMZgvRhIgf1imgoYKWX38w+O55h1eWdXIGi2wxjMxWwJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396640; c=relaxed/simple;
	bh=Q55/y/Py6wGAEkNsAoVRPheNiQ6NXdeUvjSJ8BZePr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=REObSQ5Sxza5DLWw+lOJRIsUoLzvmX2BU1AN6iOtvr4c/c+YIukTKCpeDpEsR5bTa+SGmgALb1fM3rFBs3ZPlwQUnwrOWe4VYqqJcHDl1x/1x8uqKSWP73v9nfmpsQUZ+PoMmzeHM7A4h29QMdPOsDp5DnJWljuG+fPsM+UM6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZplvNQh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-349fd1d3723so42101f8f.0;
        Wed, 17 Apr 2024 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713396637; x=1714001437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ygRTexVbFwrX95qfvQ7K6N90wEiHzCEHw2SfjvfjGAA=;
        b=YZplvNQheCURxo7b1YpxaTZLOwMui0587h8phEeNYxAE9O4clE1QmBnOvJoi1OCAYT
         o8tF35v2V1OHyWr9sdFLoPLvWY+mbm5UuLEz6kCCOZW6ft2BKIBpT44UcBhOpihURJpz
         JTnTXaQtrUehfe1RPpbifF+g89pgRyLCuHcWl/EctyCEmJaMEW963ZUL6ZKEHcNFZUVU
         diLj7KfrQf1ro/WBxlVQxLkg1eKREfvfJkx4TMhegs/bqlK4d04Hv9bOLIVlU/aauPA+
         MTmPGihX2oAU9GciTIubbK5SixAp+221Y1mTNbIfn0qiqP9j70pgQxA4irAonW8EKvsM
         R0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396637; x=1714001437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ygRTexVbFwrX95qfvQ7K6N90wEiHzCEHw2SfjvfjGAA=;
        b=Fw0bijktSLQQP6lDoUx9PNyOofcwykN+Jt70zWMUYifjIBFHFtOCBlrsu/GabkcvKg
         fzSEQm7vvbn4FByrQEvhKFgXciKO72aR0CizllERKVMBrJsFQ45N0bWfeJaXBk4N9sa6
         UQ5GrdoM9KGJ9q0MU8s90DqEPymbT0HicBocVnlZEGQD9H5SdtWB0OaG03yryfOMqWXd
         BXK6HP8RAb10Lw/oBMceWIz98trP1OagD/5sLKXY8orT2XMNg8fOiIt2NjVzZ5WhZrsU
         ynbbcnqg4HgG/RgAPQidDCj7YBQwEEYo4RHLu7aMyg2cXH4S0I3cg1DmOXD1b4vSM0gv
         mXWw==
X-Forwarded-Encrypted: i=1; AJvYcCVywf7JAvPTXN40Oa1lvBvwcRnEYOeq3/uxUlIravw9VEF1J0bzDQ4OPkVFYtUgMr1XBETrWLwYMce86PBLLO/6FBZtPe4Ltac09r1YABRrmmjbjuLfBcETnqgQV5J4wi2mnsQ3rByhP76yGkKt
X-Gm-Message-State: AOJu0YxxrEbuQ2h7Fo6ql1MoWEEJIJ0Nx47e8xPRCub1HcMIXqyzmUE6
	JMNy9uoN2HIKQfewPjrvxLW93YONTrXh3QxcgboRrgg8W0eClIt+
X-Google-Smtp-Source: AGHT+IHReswB6rKWrUhG9JDmbLoVK5JbqzOSFJfGxTY+jILtBXGHg1widcm9TXs5WkdMKh5itRRZnQ==
X-Received: by 2002:a05:600c:1c91:b0:418:9a5b:d51 with SMTP id k17-20020a05600c1c9100b004189a5b0d51mr732600wms.0.1713396636363;
        Wed, 17 Apr 2024 16:30:36 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:84f3:c12a:44bb:b4a5])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b004163703fd6asm5849936wmo.1.2024.04.17.16.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:30:35 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: keescook@chromium.org,
	andy@kernel.org,
	akpm@linux-foundation.org
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kunit-dev@googlegroups.com,
	skhan@linuxfoundation.org
Subject: [PATCH v2] string_kunit: Add test cases for str*cmp functions
Date: Thu, 18 Apr 2024 00:30:33 +0100
Message-Id: <20240417233033.717596-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, str*cmp functions (strcmp, strncmp, strcasecmp and
strncasecmp) are not covered with tests. Extend the `string_kunit.c`
test by adding the test cases for them.

This patch adds 8 more test cases:

1) strcmp test
2) strcmp test on long strings (2048 chars)
3) strncmp test
4) strncmp test on long strings (2048 chars)
5) strcasecmp test
6) strcasecmp test on long strings
7) strncasecmp test
8) strncasecmp test on long strings

These test cases aim at covering as many edge cases as possible,
including the tests on empty strings, situations when the different
symbol is placed at the end of one of the strings, etc.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- Extend the `string_kunit.c` test instead of creating the separate
KUnit test module for the strcmp function, as it was suggested by
Andy Shevchenko <andy@kernel.org>
- Add prefix to all of the macros to emphasize that they are related
to the strcmp test.
- Add 'strcmp_' prefix to the function which fills the buffers
- Rename the test cases to follow the pattern 'test_<function>', which
is used in other test cases of this module.

 lib/string_kunit.c | 155 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/lib/string_kunit.c b/lib/string_kunit.c
index eabf025cf77c..dd19bd7748aa 100644
--- a/lib/string_kunit.c
+++ b/lib/string_kunit.c
@@ -11,6 +11,12 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#define STRCMP_LARGE_BUF_LEN 2048
+#define STRCMP_CHANGE_POINT 1337
+#define STRCMP_TEST_EXPECT_EQUAL(test, fn, ...) KUNIT_EXPECT_EQ(test, fn(__VA_ARGS__), 0)
+#define STRCMP_TEST_EXPECT_LOWER(test, fn, ...) KUNIT_EXPECT_LT(test, fn(__VA_ARGS__), 0)
+#define STRCMP_TEST_EXPECT_GREATER(test, fn, ...) KUNIT_EXPECT_GT(test, fn(__VA_ARGS__), 0)
+
 static void test_memset16(struct kunit *test)
 {
 	unsigned i, j, k;
@@ -179,6 +185,147 @@ static void test_strspn(struct kunit *test)
 	}
 }
 
+static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
+static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
+
+static void strcmp_fill_buffers(char fill1, char fill2)
+{
+	memset(strcmp_buffer1, fill1, STRCMP_LARGE_BUF_LEN);
+	memset(strcmp_buffer2, fill2, STRCMP_LARGE_BUF_LEN);
+	strcmp_buffer1[STRCMP_LARGE_BUF_LEN - 1] = 0;
+	strcmp_buffer2[STRCMP_LARGE_BUF_LEN - 1] = 0;
+}
+
+static void test_strcmp(struct kunit *test)
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
+static void test_strcmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('B', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'A';
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strcmp, strcmp_buffer1, strcmp_buffer2);
+}
+
+static void test_strncmp(struct kunit *test)
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
+static void test_strncmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('B', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'A';
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strncmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+	/* the strings are equal up to STRCMP_CHANGE_POINT */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_CHANGE_POINT);
+	STRCMP_TEST_EXPECT_GREATER(test, strncmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_CHANGE_POINT + 1);
+}
+
+static void test_strcasecmp(struct kunit *test)
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
+static void test_strcasecmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('b', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'a';
+	STRCMP_TEST_EXPECT_LOWER(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
+}
+
+static void test_strncasecmp(struct kunit *test)
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
+static void test_strncasecmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('b', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'a';
+	STRCMP_TEST_EXPECT_LOWER(test, strncasecmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_CHANGE_POINT);
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_CHANGE_POINT + 1);
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
@@ -186,6 +333,14 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_strchr),
 	KUNIT_CASE(test_strnchr),
 	KUNIT_CASE(test_strspn),
+	KUNIT_CASE(test_strcmp),
+	KUNIT_CASE(test_strcmp_long_strings),
+	KUNIT_CASE(test_strncmp),
+	KUNIT_CASE(test_strncmp_long_strings),
+	KUNIT_CASE(test_strcasecmp),
+	KUNIT_CASE(test_strcasecmp_long_strings),
+	KUNIT_CASE(test_strncasecmp),
+	KUNIT_CASE(test_strncasecmp_long_strings),
 	{}
 };
 
-- 
2.34.1


