Return-Path: <linux-kernel+bounces-6579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CFE819A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98B71C22311
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD111DA2F;
	Wed, 20 Dec 2023 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLtx9+xe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC931CF99
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ce4fe4ed18so504934b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703061157; x=1703665957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ne7yGHbQWRglnBQdA19H8Fg0BI9lYEcjh4Rj4uebcc=;
        b=SLtx9+xedh6yZQFXuDxGUpFGvjl31N+1geNBQA8863fIaONonJtpsm5Gb4mJ0AHFtK
         /evgTBSKwLG7ci8r52Ai8741+W6YxVgyOqMBSHNM61iY/dT4r901efxJkWnsGuhrOsXA
         3zqxhzKhpvNFXAC5tqNCT7L41IiMKaopCQ0Idiz0YgZCtkP6CUbxgN6BqcJTQsdSgyn1
         y6FEaMwuC4CVJN/yYK8AWSxeAf+dvQiibCaG3r121cUkWV+01E7xp/nB/oKrKJZRD7SR
         roxyDsubKKjW6dmT7DpKaZ5WRDq2++9tjuMICQv4CrW5AkdLwhg6eCPbS6RaKY67i67F
         Uo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703061157; x=1703665957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ne7yGHbQWRglnBQdA19H8Fg0BI9lYEcjh4Rj4uebcc=;
        b=WUrKvWGEZGj7J/x9xEG5d/olabFWUW1biiv5j1N4a0Cy2G1l2Fz2KnadiS3yyMXda4
         reA1LQ1NUT8P3RygCu1MgqPMZqm99Mb9xaEwbcX29KguLJ/hF2O8toaS18U7ATBhOqoe
         SaFWL7PW2AQYN85aQTU//MjF0WA0x+vh/HP1WMiDFrpe8RmHNnlrwqJTw78uXHcTrxj4
         JuS6FwVOrARRRk1OV11WT2h5/6YF3xCZT9/LX9YYWnBo/14yh019eI/0IlR4ufa2TbW4
         oBHZ3pQzJg+V5yd2y+NkkzDkgRP6TxJPV3Ylmkuxp/1xuxG2qH7i7S/M7bDahwkc13os
         zo9w==
X-Gm-Message-State: AOJu0Yy0wQg+I8D2b5cMeYKnowDOkiwAHXxnD1OTyMAN/pkjHT7c0vo4
	TqEVPC498SwO9p7FEfqHDC0v4NTArrA=
X-Google-Smtp-Source: AGHT+IFE1/eQbvGMQq2qn/ZZhge+DWd685YRTvVToO/QCBHDCEK34Q4nohVRmLcIDQWB3hf8rET6rA==
X-Received: by 2002:aa7:9315:0:b0:6d9:383b:d91a with SMTP id cz21-20020aa79315000000b006d9383bd91amr4311701pfb.1.1703061156941;
        Wed, 20 Dec 2023 00:32:36 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id r13-20020aa79ecd000000b006d49ed3eff2sm6583815pfq.75.2023.12.20.00.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:32:36 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: irogers@google.com,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] min_heap: Optimize number of comparisons in min_heapify()
Date: Wed, 20 Dec 2023 16:32:24 +0800
Message-Id: <20231220083224.3712113-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220083224.3712113-1-visitorckw@gmail.com>
References: <20231220083224.3712113-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch optimizes the min_heapify() function, resulting in a
significant reduction of approximately 50% in the number of comparisons
for large random inputs, while maintaining identical results.

The current implementation performs two comparisons per level to
identify the minimum among three elements. In contrast, the proposed
bottom-up variation uses only one comparison per level to assess two
children until reaching the leaves. Then, it sifts up until the correct
position is determined.

Typically, the process of sifting down proceeds to the leaf level,
resulting in O(1) secondary comparisons instead of log2(n). This
optimization significantly reduces the number of costly indirect
function calls and improves overall performance.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 include/linux/min_heap.h | 42 +++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
index 18a581310eb3..d52daf45861b 100644
--- a/include/linux/min_heap.h
+++ b/include/linux/min_heap.h
@@ -35,31 +35,33 @@ static __always_inline
 void min_heapify(struct min_heap *heap, int pos,
 		const struct min_heap_callbacks *func)
 {
-	void *left, *right, *parent, *smallest;
+	void *left, *right;
 	void *data = heap->data;
+	void *root = data + pos * func->elem_size;
+	int i = pos, j;
 
+	/* Find the sift-down path all the way to the leaves. */
 	for (;;) {
-		if (pos * 2 + 1 >= heap->nr)
+		if (i * 2 + 2 >= heap->nr)
 			break;
+		left = data + (i * 2 + 1) * func->elem_size;
+		right = data + (i * 2 + 2) * func->elem_size;
+		i = func->less(left, right) ? i * 2 + 1 : i * 2 + 2;
+	}
 
-		left = data + ((pos * 2 + 1) * func->elem_size);
-		parent = data + (pos * func->elem_size);
-		smallest = parent;
-		if (func->less(left, smallest))
-			smallest = left;
-
-		if (pos * 2 + 2 < heap->nr) {
-			right = data + ((pos * 2 + 2) * func->elem_size);
-			if (func->less(right, smallest))
-				smallest = right;
-		}
-		if (smallest == parent)
-			break;
-		func->swp(smallest, parent);
-		if (smallest == left)
-			pos = (pos * 2) + 1;
-		else
-			pos = (pos * 2) + 2;
+	/* Special case for the last leaf with no sibling. */
+	if (i * 2 + 2 == heap->nr)
+		i = i * 2 + 1;
+
+	/* Backtrack to the correct location. */
+	while (i != pos && func->less(root, data + i * func->elem_size))
+		i = (i - 1) / 2;
+
+	/* Shift the element into its correct place. */
+	j = i;
+	while (i != pos) {
+		i = (i - 1) / 2;
+		func->swp(data + i * func->elem_size, data + j * func->elem_size);
 	}
 }
 
-- 
2.25.1


