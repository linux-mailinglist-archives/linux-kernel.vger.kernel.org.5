Return-Path: <linux-kernel+bounces-163372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EB58B6A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795831C21412
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E34182B1;
	Tue, 30 Apr 2024 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjnSgcWG"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E8F17BA2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456163; cv=none; b=ZAr3DQfY6U09R4TwPxOTjOHR9xOY1s0K5qqAdhWtTQwsRRCGOmf/vEu0KyoadjE2+gdyDHL5izp1CcDHzskzsCiw0dOSEOqKPzPNIc4iBaffq+MLCTGtcuVsxDR/1bioOne6DJSf8q9/gQrtnLjEoxBanbAy+z11TCurklYQVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456163; c=relaxed/simple;
	bh=PNYrYyYv4eHjpOSamBCLUjfjiprCXpFCpafVy0szpbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mNY2FVIa3Byt89ZEUEnhjjkqJjxItDBXweCGqBKWTZWkWmnYsk2FgEJWz8LD/C315Bgr5hjd4XM7jDMqwxt1aUz6MGelZRn3SHcxeLlrFsKOIE2Hfn/b/TvQ93ayRK4lksl00XgheV0gj7qRoeDmfnc2wqOW7D7n0NMWFPUodt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjnSgcWG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2a2d37b8c4fso1385211a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714456161; x=1715060961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0fMPPj46Qp9Sg0NPGxAizPfZ+s49pg0DYfNoSEytAc=;
        b=RjnSgcWGSCSxzlQoOuqIPDB9AWWEECXq/055l3C0VWJs9LJqPz3jOcESHVqA6sMtK+
         og7a5ZgRDmlLBaVXuuiZHpqRlPoJJ8cpC7j7vKdXfOnJD3ez0ldcd9IXXys3S/RY/WSG
         xwGvTtcHPrtn2CFX1LjkEQixL+o0yxh+GnF+/H7Tp+dQrmFUFeFP87eJajhdcmTg6WQw
         qWqDP6JXClmmralZmBH1Pa+O/gIrlbc0W1Ebsb+oXwhFWzA5G3zYUvU5iEh3aji9DcFA
         a+NUm/9DkxfGgxcEop0J3ifHS1deuDVkfSl0pqkCf5NvHGJXSX5MYr9Q6zoPiu+70KVS
         pLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714456161; x=1715060961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0fMPPj46Qp9Sg0NPGxAizPfZ+s49pg0DYfNoSEytAc=;
        b=jzDaIzIj0aRLBSrSAtIN96/wAHupM9yInZPO98lGNmvYkEfuTU3xy9rcQuVwhC+zlv
         Hl0+bvZSKzMQtd738Jgw/H2vVHFgbwQGFiXj/VJEwIfXCLLaXc455JW0r43tm8V28wxQ
         ttq20ZbvKG9dYbQppj1Du0OzegnPdCCdAGtaP/h2NinDN8urw9zMe+Ou2i046l5YtSFr
         guJOa0bZWjxDYO80+JvCYbHJedcKxToQZ+K3fQ6xaioab0mNu2gKnEQVLepderhKmqi4
         si3gkItkAKV6lANytgxKDKPcqb4S8knjTUiRRAbLfR3FdwK2PzYLYVeRrfj/igdDYsM2
         3FaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbrXQQRxf/phW8cnKLRlskrSdLLSBFlrRxHlu/zfA7ZoORxl+01COLjQhRN84UIQ+QLzVtCDaA5VrCe9xLnXJ17fds3Ux9Rp/PkHmm
X-Gm-Message-State: AOJu0Yxs3Oq1vpaw+VTrHInCEqsNblCE2Zozvh8l1C8PC1P9si8+OEhR
	2OP8aQe/O2N6849wogWM0W5/X2IfvoLAOHJI6kDcM7wiNDKTKIicKKNPt8EO
X-Google-Smtp-Source: AGHT+IGjt8NOtejcO58lYbWns5NP5Zbrd14l6NNYepZX92px/Z18s2Xcub0kMt4YZ64HmbpowtKrig==
X-Received: by 2002:a17:90a:fa4f:b0:2a5:3249:d230 with SMTP id dt15-20020a17090afa4f00b002a53249d230mr12473415pjb.3.1714456161134;
        Mon, 29 Apr 2024 22:49:21 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090adb4c00b0029df9355e79sm20471652pjx.13.2024.04.29.22.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:49:20 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 1/2] lib/find_bit_benchmark: Add benchmark test for fns()
Date: Tue, 30 Apr 2024 13:49:11 +0800
Message-Id: <20240430054912.124237-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430054912.124237-1-visitorckw@gmail.com>
References: <20240430054912.124237-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a benchmark test for the fns(). It measures the total time
taken by fns() to process 1,000,000 test data generated using
get_random_long() for each n in the range [0, BITS_PER_LONG].

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 lib/find_bit_benchmark.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index d3fb09e6eff1..8712eacf3bbd 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -146,6 +146,28 @@ static int __init test_find_next_and_bit(const void *bitmap,
 	return 0;
 }
 
+static int __init test_fns(void)
+{
+	const unsigned long round = 1000000;
+	s64 time[BITS_PER_LONG + 1];
+	unsigned int i, n;
+	volatile unsigned long x, y;
+
+	for (n = 0; n <= BITS_PER_LONG; n++) {
+		time[n] = ktime_get();
+		for (i = 0; i < round; i++) {
+			x = get_random_long();
+			y = fns(x, n);
+		}
+		time[n] = ktime_get() - time[n];
+	}
+
+	for (n = 0; n <= BITS_PER_LONG; n++)
+		pr_err("fns: n = %2u: %12lld ns\n", n, time[n]);
+
+	return 0;
+}
+
 static int __init find_bit_test(void)
 {
 	unsigned long nbits = BITMAP_LEN / SPARSE;
@@ -186,6 +208,9 @@ static int __init find_bit_test(void)
 	test_find_first_and_bit(bitmap, bitmap2, BITMAP_LEN);
 	test_find_next_and_bit(bitmap, bitmap2, BITMAP_LEN);
 
+	pr_err("\nStart testing for fns()\n");
+	test_fns();
+
 	/*
 	 * Everything is OK. Return error just to let user run benchmark
 	 * again without annoying rmmod.
-- 
2.34.1


