Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8117E71CB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345149AbjKISzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345118AbjKISzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:55:24 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0C34223
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 10:55:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc2b8deb23so2248355ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699556119; x=1700160919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1F+zsKAZ6psJ2Y0k9zWx71Sew29B0knPhWsJIJOxq3o=;
        b=nJ9H2dZ5jfpxDUqi2CZIPnWDURnEBcZNZHZ+T8EiMx8v+1ctYuvaBvSBJZl/0knjId
         xlPGa8DE02n1CtQL6Uqv+R2cPdTtQeQnlbWzoZGcdOu3GEC5bsoCpV2LX8kSBfsWRg87
         x6T1bRElFapEzfvnJR3H/51baJbYr17f2c5a62u4nUFnbDP15266iXjIEIX61k15BmoD
         SX9gY1ZghByO+SZThrT1HU0Z50y9L3q2QPXU9B0stYZaOVD2NF2NFLMvBq/lU5LY5qUJ
         JsDuzWYVaP6TqR5eLWhVtnWXMfrYfO3SCCYrA/q7CmYR13yQfJpZFQB1jGcnIw78e6Z6
         zjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556119; x=1700160919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1F+zsKAZ6psJ2Y0k9zWx71Sew29B0knPhWsJIJOxq3o=;
        b=AysjxRnr5GY8IW9hr/QlsVn+OOxotmesmq7/9j5MQ+NfXjzTc1Bu1dCDVXZqIeJ+VL
         kgOL6BZbObk/bAXsjwuNWdOv+lsSG01fHA5NkalKNKXEYOhitBQjwS4nS8XVom6rkVjn
         6JNkfNxHWGcgAqUPwIq21DPQDZgRmwWa+62Uk8K2Uj14lY1jQM+4xOt/i3C1VuNeUKjc
         44BEZAWuOR8coV5hJmvtE0N14hcvYHDvdaZS/hlNbnRNGV6OZQ2snEtZ+K6v0x57yMez
         16oj2WMOcNQ4aTcII9/1lskgv4ojH0iga4OW/6gZmXMwRlFm+4hCRqE3HuILFv+5AT+S
         un3Q==
X-Gm-Message-State: AOJu0YxRLTkMhA7mEA2+00Mz5jjQ6tDkyWeq7XRamNx2L+K8EW5iDVny
        t1ef5QSPXNmqQD2R0xhaSVc=
X-Google-Smtp-Source: AGHT+IHq3DPWkkVhxoXkHb0d97mTfbvuE+JfpLRcZwmkaEMx/WorUBpsxL7/EBbJgr1HmsufXxjk0Q==
X-Received: by 2002:a17:903:2349:b0:1cc:3c2c:fa1a with SMTP id c9-20020a170903234900b001cc3c2cfa1amr6422376plh.4.1699556118862;
        Thu, 09 Nov 2023 10:55:18 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902d71300b001c61921d4d2sm3821837ply.302.2023.11.09.10.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:55:18 -0800 (PST)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     bleung@chromium.org, tzungbi@kernel.org
Cc:     groeck@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 7/7] platform/chrome: Implement quickselect for median calculation
Date:   Fri, 10 Nov 2023 02:54:39 +0800
Message-Id: <20231109185439.1535962-8-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109185439.1535962-1-visitorckw@gmail.com>
References: <20231109185439.1535962-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cros_ec_sensor_ring_median function currently uses an inefficient
sorting algorithm (> O(n)) to find the median of an array. This patch
replaces the sorting approach with the quickselect algorithm, which
achieves an average time complexity of O(n).

The algorithm employs the median-of-three rule to select the pivot,
mitigating worst-case scenarios and reducing the expected number of
necessary comparisons. This strategy enhances the algorithm's
efficiency and ensures a more balanced partitioning.

In the worst case, the runtime of quickselect could regress to O(n^2).
To address this, alternative algorithms like median-of-medians that
can guarantee O(n) even in the worst case. However, due to higher
overhead and increased complexity, quickselect remains a pragmatic
choice for our use case.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 71 ++++++++++++++-----
 1 file changed, 54 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index 9e17f7483ca0..4ac718be38b0 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -133,33 +133,70 @@ int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
 	return ret;
 }
 
-static int cros_ec_sensor_ring_median_cmp(const void *pv1, const void *pv2)
+static void cros_ec_sensor_ring_median_swap(s64 *a, s64 *b)
 {
-	s64 v1 = *(s64 *)pv1;
-	s64 v2 = *(s64 *)pv2;
-
-	if (v1 > v2)
-		return 1;
-	else if (v1 < v2)
-		return -1;
-	else
-		return 0;
+	s64 tmp = *a;
+	*a = *b;
+	*b = tmp;
 }
 
 /*
  * cros_ec_sensor_ring_median: Gets median of an array of numbers
  *
- * For now it's implemented using an inefficient > O(n) sort then return
- * the middle element. A more optimal method would be something like
- * quickselect, but given that n = 64 we can probably live with it in the
- * name of clarity.
+ * It's implemented using the quickselect algorithm, which achieves an
+ * average time complexity of O(n) the middle element. In the worst case,
+ * the runtime of quickselect could regress to O(n^2). To mitigate this,
+ * algorithms like median-of-medians exist, which can guarantee O(n) even
+ * in the worst case. However, these algorithms come with a higher
+ * overhead and are more complex to implement, making quickselect a
+ * pragmatic choice for our use case.
  *
- * Warning: the input array gets modified (sorted)!
+ * Warning: the input array gets modified!
  */
 static s64 cros_ec_sensor_ring_median(s64 *array, size_t length)
 {
-	sort(array, length, sizeof(s64), cros_ec_sensor_ring_median_cmp, NULL);
-	return array[length / 2];
+	const int k = length / 2;
+	int lo = 0;
+	int hi = length - 1;
+
+	while (lo <= hi) {
+		int mid = lo + (hi - lo) / 2;
+		int pivot, pivot_index;
+		int i = lo - 1;
+
+		/* We employ the median-of-three rule to choose the pivot, mitigating
+		 * worst-case scenarios such as already sorted arrays and aiming to reduce
+		 * the expected number of necessary comparisons. This strategy enhances the
+		 * algorithm's performance and ensures a more balanced partitioning.
+         */
+		if (array[lo] > array[mid])
+			cros_ec_sensor_ring_median_swap(&array[lo],
+							&array[mid]);
+		if (array[lo] > array[hi])
+			cros_ec_sensor_ring_median_swap(&array[lo], &array[hi]);
+		if (array[mid] < array[hi])
+			cros_ec_sensor_ring_median_swap(&array[mid],
+							&array[hi]);
+
+		pivot = array[hi];
+
+		for (int j = lo; j < hi; j++)
+			if (array[j] < pivot)
+				cros_ec_sensor_ring_median_swap(&array[++i],
+								&array[j]);
+
+		cros_ec_sensor_ring_median_swap(&array[i + 1], &array[hi]);
+		pivot_index = i + 1;
+		if (pivot_index == k)
+			return array[pivot_index];
+		if (pivot_index > k)
+			hi = pivot_index - 1;
+		else
+			lo = pivot_index + 1;
+	}
+
+	/* Should never reach here. */
+	return -1;
 }
 
 /*
-- 
2.25.1

