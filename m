Return-Path: <linux-kernel+bounces-102290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6736687B039
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2421F28D3AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FED053E2D;
	Wed, 13 Mar 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfdT3VKn"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB8153E03;
	Wed, 13 Mar 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351746; cv=none; b=Yi5ul2S6NN8BQB2zEiFt8CBQ1Fd+kMrxn9lz226lcW6gzegIjaH4hxMOf1rdYISavaPzEyOdxA14yWL8MTX7KbEd+RAfLExGXW95miEstf4CaKdzF0aFmrjueNC3S/sTcJSQ58TmMLxqqKmBMTuCkCLfppYfeYCJmdJn+9z3yVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351746; c=relaxed/simple;
	bh=l4aa7dMZOppEVtMCbeeOP1g60YPKOSk0JjgK6J6Vn3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pWuEmlNCIQ5xqL5JvadtrprnZ3ZogsdQ7ziRYB1fpbZhJykt9QbfdUjF9vkLpFULUwD3mnQyJpx6jgyjw/zl47PAYEasZXbJ3re1DDR3UyVbqQcQlZLThCx9AFB37xp22A0bUgGpl7n+c0fFre2ClUIhz3xce/yo7rDOYJE0UfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfdT3VKn; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e649a2548cso123583b3a.3;
        Wed, 13 Mar 2024 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710351744; x=1710956544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xb6wljFD0LnTtDE1JnDzedxQZT1gVS3KdmlKFwDQbVE=;
        b=WfdT3VKnxoRcGPT6aw4DKsD1Yrei1a40qw8S9E1YTFXeBraAPvgkiy+bosEllTId1y
         18s2VnxeaD8OBmvuQDdJ/MwFZIVDPoOmDgyyHXz2cErqEYwDOJwsOSfuqjnSOkTfq6KP
         iky289xvNcGqw9DGfUZ1CTOrrH36jNUi9Dv5aP1oTVBm4qXCJlAwf6cd0cCpLhkweFJB
         tDYCTLJSNCEYHTHf6HLFqDMGHHdaVldhTdRZrNACyb/jgeVQcFGcVRwAP6/xIbWW8mfg
         vVoKBqCZxrIQmdfos4GLaz2vwKiaVvCfKtUV5uzKTdws6RP4AKLULUSPzdAQLrjhmRw7
         d1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710351744; x=1710956544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb6wljFD0LnTtDE1JnDzedxQZT1gVS3KdmlKFwDQbVE=;
        b=cggH9WrJGHOAmlATbZFyyARNiu+djUbFnVLt0Jt9spuwpDLkxOe8+FMcksdrzYQvpn
         C9w65lzi2fz09mTQBXMs3A47GN61MPA/CgQa97a1yKOzxGTfcE3qzpiSazNjjkPXlVSr
         2hDv2+a0k97OopcL7/R1lV5oibNDfVC3cA4AtvAaNGKuVjZL7TKbQEHEclEz3OruxEHn
         oR9qIlaSp4kBPGHQli9gjbOB4oBO0pGNXv5dGZLtHnwMQh5iLgUh5caxppmeE6AhG67J
         EnsC8CRmHbeXcjxi9AzUD5dkxXjPs763q+LxKeBQwKuhgAXue+Kjw+DOV600sZ3EZiJI
         PXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx2jhubBBCZTEVVwrlP55Zg8b/G0XN+Tcl8fqBPH8BTYrwwfCAORxvvaphNRL0sZWhD1pMZm4nO+pxicscdZ1XzjsoPTgk9nZWEx1eZqoqYA/IQ8t/AllqKEVp7eofNXbyzsnZy+fa
X-Gm-Message-State: AOJu0YzU9/TkqIsiHoip3anTMOYk4YJWLgYkUusb0OibdNCnD5aLyRmL
	mDA/sVJVfrpNlKlxYOaijRm4RjMYiYw3ewqrg4sjzcE7mS5xf0Lc
X-Google-Smtp-Source: AGHT+IGOeJoSUTHWkZZ/rIXW/FE2nS2JJ2xO6TnUe79InVgeF6RitaqxvJQPu2fxsJDwAI2GVO7b5w==
X-Received: by 2002:a05:6a00:2e9d:b0:6e6:4ebc:3cd with SMTP id fd29-20020a056a002e9d00b006e64ebc03cdmr3236804pfb.27.1710351744140;
        Wed, 13 Mar 2024 10:42:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c26-20020aa78c1a000000b006e3b868b8b8sm8162797pfd.130.2024.03.13.10.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 10:42:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Daniel Diaz <daniel.diaz@linaro.org>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] rtc: test: Split rtc unit test into slow and normal speed test
Date: Wed, 13 Mar 2024 10:42:21 -0700
Message-Id: <20240313174221.1999654-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On slow systems, the rtc unit test may result in soft lockups and/or
generate messages such as

 # rtc_time64_to_tm_test_date_range: Test should be marked slow (runtime: 34.253230015s)
 # rtc_time64_to_tm_test_date_range: pass:1 fail:0 skip:0 total:1

The test covers a date range of 160,000 years, resulting in the long
runtime.

Unit tests running for more than 1 second are supposed to be marked as
slow. Just marking the test as slow would prevent it from running when
slow tests are disabled, which would not be desirable. At the same time,
the current test range of 160,000 years seems to be of limited value.

Split the test into two parts, one covering a range of 1,000 years and
the other covering the current range of 160,000 years. Mark the 160,000
year test as slow to be able to separate it from the faster test.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/rtc/lib_test.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/lib_test.c
index 225c859d6da5..3893a202e9ea 100644
--- a/drivers/rtc/lib_test.c
+++ b/drivers/rtc/lib_test.c
@@ -27,17 +27,17 @@ static void advance_date(int *year, int *month, int *mday, int *yday)
 }
 
 /*
- * Checks every day in a 160000 years interval starting on 1970-01-01
+ * Check every day in specified number of years interval starting on 1970-01-01
  * against the expected result.
  */
-static void rtc_time64_to_tm_test_date_range(struct kunit *test)
+static void rtc_time64_to_tm_test_date_range(struct kunit *test, int years)
 {
 	/*
-	 * 160000 years	= (160000 / 400) * 400 years
-	 *		= (160000 / 400) * 146097 days
-	 *		= (160000 / 400) * 146097 * 86400 seconds
+	 * years	= (years / 400) * 400 years
+	 *		= (years / 400) * 146097 days
+	 *		= (years / 400) * 146097 * 86400 seconds
 	 */
-	time64_t total_secs = ((time64_t) 160000) / 400 * 146097 * 86400;
+	time64_t total_secs = ((time64_t)years) / 400 * 146097 * 86400;
 
 	int year	= 1970;
 	int month	= 1;
@@ -66,8 +66,27 @@ static void rtc_time64_to_tm_test_date_range(struct kunit *test)
 	}
 }
 
+/*
+ * Checks every day in a 160000 years interval starting on 1970-01-01
+ * against the expected result.
+ */
+static void rtc_time64_to_tm_test_date_range_160000(struct kunit *test)
+{
+	rtc_time64_to_tm_test_date_range(test, 160000);
+}
+
+/*
+ * Checks every day in a 1000 years interval starting on 1970-01-01
+ * against the expected result.
+ */
+static void rtc_time64_to_tm_test_date_range_1000(struct kunit *test)
+{
+	rtc_time64_to_tm_test_date_range(test, 1000);
+}
+
 static struct kunit_case rtc_lib_test_cases[] = {
-	KUNIT_CASE(rtc_time64_to_tm_test_date_range),
+	KUNIT_CASE(rtc_time64_to_tm_test_date_range_1000),
+	KUNIT_CASE_SLOW(rtc_time64_to_tm_test_date_range_160000),
 	{}
 };
 
-- 
2.39.2


