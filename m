Return-Path: <linux-kernel+bounces-80199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AEA862BB8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353BA1C20E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8505817736;
	Sun, 25 Feb 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuriimG1"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558915E97
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878569; cv=none; b=a1X37kjthjYDVHuBbESqciHCu9SQNx0JcMqBnwMlSt0tn66eAN4mjOgX69R6q9y6UbPkzWC4fnZk0mKHF1KPV4vWYVWPSIqvMSP4E1z1OUltLHWXfGLfbk2EOoPj0paWED7XYmGJNlnXVsg5Acx/r+mFjsVf8HGdMHCWDjU3oek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878569; c=relaxed/simple;
	bh=7O5Gz8u7xupo2qRRhxZakxJOlukNTG1XgXAoAo7w7IA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MaDN0YR9tN7fVD9UyVtyqndYacFJ2gnDjttFPom8d0gSWFHgMBAd7FFHYKBqJKuT/nYK6N8hMllrrGjHH3WWc67uCpqG2RweDeNlhqGpRZdmXC2tCA4jKMNdwVtjZv+lI6G5G068WsJa51EpgAZMEcCtUsh/0x2jibAxYKBojjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuriimG1; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b276979aso1864140a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708878567; x=1709483367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lXvAa2y1FtQ+aXeb6G9nK/jsZYHoMqoYGfLIBXaBaWM=;
        b=KuriimG1Gdg7UAGyx6CoyURv96HZX9NPc4sdVLrZ4G1sKKUD1NAULL95ESl+nFIQDw
         VuKNBZ8cqe4dV7i5h9afiJhLNp9AKBNkcmSvj/bSnbTDKfG1NX8YWpxUTnMxibZPfZlv
         4JUuVd429PsZIfyj6YdONaejeGTAYVyZkUZvUgp5SMpIsNqbmCBEPpp/qNX7EakSMGf8
         jTslaVk0Ye5G7jfwsU+p/iDCO/IiKnmZ/bIFsaBDkNDPB7KT8tZWUfcbXclCuslMFnNJ
         FjYPqafeHGrN/4FXGfZJ2d7EuxyE0SNM4HnlonzLIJ6Jo3y7a30u5f3QX6KcoOrSEE32
         HtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878567; x=1709483367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXvAa2y1FtQ+aXeb6G9nK/jsZYHoMqoYGfLIBXaBaWM=;
        b=kk4Gos5LKm66YkweLjckJMZnartojR5vV7SEnf/O7DnLPgmYOiJ6JzoD4CuXm+uO4K
         LiQAXqPTvo8DnZ2vQW6S/fs4URbSwdV7kFPA5BFKwP7mLRxvItQEFhKiUFlDjQqp5vnr
         l8H99zmtgGB/lTNRrDjcz5lv85GEW7cDi4AyoQ6WwfrdB7GHTQCeFwDtY1RhUp+LGM01
         kxOPzlMpHezb56HvymSNK2YpQ+AEvAVK97aKofN1Aa82CjTuKjnboljNxHYYllYOMOqn
         V05OxIOLQ38Sa1fB0dlQ97Mfs302ryEtkPiUYk3I39UaESNMuIA19BADMBVrEnLR45Xb
         61Hg==
X-Gm-Message-State: AOJu0YxcveKsTjCJj8PM8xIvzQH8wE+FpLEjtxWIGbkQXRdZJtfVchfY
	xH7rPjvBIdsGejvHqSwJKc4filtpn04BEjMHVVyiiwlmXD72kFN91ozmZpBE
X-Google-Smtp-Source: AGHT+IH8b/mXOe38Syg4PTKroHmU0krHcd1YbSx/KVPor1hISGjzgmm2aTs+OcQDsWYbWcNwRluRmA==
X-Received: by 2002:a17:902:e5d2:b0:1d8:f129:a0bc with SMTP id u18-20020a170902e5d200b001d8f129a0bcmr5872264plf.13.1708878567400;
        Sun, 25 Feb 2024 08:29:27 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902c60200b001dc8f8730f3sm1413985plr.285.2024.02.25.08.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:29:27 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: "Daniel B . Hill" <daniel@gluo.nz>
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH] mean_and_variance: Drop always failing tests
Date: Sun, 25 Feb 2024 08:29:25 -0800
Message-Id: <20240225162925.1708462-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mean_and_variance_test_2 and mean_and_variance_test_4 always fail.
The input parameters to those tests are identical to the input parameters
to tests 1 and 3, yet the expected result for tests 2 and 4 is different
for the mean and stddev tests. That will always fail.

     Expected mean_and_variance_get_mean(mv) == mean[i], but
        mean_and_variance_get_mean(mv) == 22 (0x16)
        mean[i] == 10 (0xa)

Drop the bad tests.

Fixes: 65bc41090720 ("mean and variance: More tests")
Closes: https://lore.kernel.org/lkml/065b94eb-6a24-4248-b7d7-d3212efb4787@roeck-us.net/
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Based on next-20240223. Sorry for the noise if this has already been
addressed.

Tested on top of mainline kernel (v6.8-rc5-329-gab0a97cffa0b)
to avoid other problems seen in next-20240223.

 lib/math/mean_and_variance_test.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/lib/math/mean_and_variance_test.c b/lib/math/mean_and_variance_test.c
index 0d8c2451a858..fe8309f456a3 100644
--- a/lib/math/mean_and_variance_test.c
+++ b/lib/math/mean_and_variance_test.c
@@ -135,20 +135,8 @@ static void mean_and_variance_test_1(struct kunit *test)
 			d, mean, stddev, weighted_mean, weighted_stddev);
 }
 
-static void mean_and_variance_test_2(struct kunit *test)
-{
-	s64 d[]			= { 100, 10, 10, 10, 10, 10, 10 };
-	s64 mean[]		= {  10, 10, 10, 10, 10, 10, 10 };
-	s64 stddev[]		= {   9,  9,  9,  9,  9,  9,  9 };
-	s64 weighted_mean[]	= {  32, 27, 22, 19, 17, 15, 14 };
-	s64 weighted_stddev[]	= {  38, 35, 31, 27, 24, 21, 18 };
-
-	do_mean_and_variance_test(test, 10, 6, ARRAY_SIZE(d), 2,
-			d, mean, stddev, weighted_mean, weighted_stddev);
-}
-
 /* Test behaviour where we switch from one steady state to another: */
-static void mean_and_variance_test_3(struct kunit *test)
+static void mean_and_variance_test_2(struct kunit *test)
 {
 	s64 d[]			= { 100, 100, 100, 100, 100 };
 	s64 mean[]		= {  22,  32,  40,  46,  50 };
@@ -160,18 +148,6 @@ static void mean_and_variance_test_3(struct kunit *test)
 			d, mean, stddev, weighted_mean, weighted_stddev);
 }
 
-static void mean_and_variance_test_4(struct kunit *test)
-{
-	s64 d[]			= { 100, 100, 100, 100, 100 };
-	s64 mean[]		= {  10,  11,  12,  13,  14 };
-	s64 stddev[]		= {   9,  13,  15,  17,  19 };
-	s64 weighted_mean[]	= {  32,  49,  61,  71,  78 };
-	s64 weighted_stddev[]	= {  38,  44,  44,  41,  38 };
-
-	do_mean_and_variance_test(test, 10, 6, ARRAY_SIZE(d), 2,
-			d, mean, stddev, weighted_mean, weighted_stddev);
-}
-
 static void mean_and_variance_fast_divpow2(struct kunit *test)
 {
 	s64 i;
@@ -229,8 +205,6 @@ static struct kunit_case mean_and_variance_test_cases[] = {
 	KUNIT_CASE(mean_and_variance_weighted_advanced_test),
 	KUNIT_CASE(mean_and_variance_test_1),
 	KUNIT_CASE(mean_and_variance_test_2),
-	KUNIT_CASE(mean_and_variance_test_3),
-	KUNIT_CASE(mean_and_variance_test_4),
 	{}
 };
 
-- 
2.39.2


