Return-Path: <linux-kernel+bounces-15998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C58236CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3252875DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492491DA38;
	Wed,  3 Jan 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdp2Crew"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595951DA22
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d437a2a4c7so18534505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 12:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704315196; x=1704919996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYaz82mYYzCwX1xxNWNg9eztYs/P62dbK5BPPUgSW7A=;
        b=Tdp2CrewIbAHRUk4n+pBaxA2OFdUjwdwTw1vpI+fcGI6ktQiHXE3HLoHfByhTt7B9J
         Qff2O1niNjssRiv3LwLPFONX5rw0/8s6huYLgTzsWeutUJAKrUFFKTJFTX/sX6W3WSGw
         Cg9e/4ZRjyQK+toqfvcBi4DmVJDc8hbV7woOVSXRgawHKT1dHmY44mCRMkWiYhWlPMue
         MsoeFd2TeaqQKJ6puVGW1qJvev6YxuPWmxJSnMEZkDuTR6iZRNtvfIo7GOVLu7lro84X
         LNdbGbdIYQ0Easb0ihtzpWVwlairqqsRErHxigR9bIihssL1cwQS0ilt24s9aYj/SGrH
         vaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704315196; x=1704919996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYaz82mYYzCwX1xxNWNg9eztYs/P62dbK5BPPUgSW7A=;
        b=VAkxe9MQ4TwzDZoKSGHb2DWD4UrbtBu7i8nYIcbSBXgXgRkmat+hCObNsnJhj51+a4
         iqw1aBehBkj0oTQLZHJ6lc+yEw7Nu28NXTszS6k+3nIzZcSleC3hOlyUZs1WUCJhL32k
         uUkkPxgfdkPYuDSENsY4xhcPFC0UNViZ12pArl1JOb0WNXZEF/Wa3UsFVHuL14pWZv9d
         3Tsuvoc/ZhGEcQ68gsUKumGJFKrxJ6wUMVwiuxsqX8llzzR6OPw5uqsksE6AtOzqvPYu
         PbusnHCUQEYpdUJJGEpIzoPQuQfuoSu6VIGU1W+sxPuxnVXTo7MAb2Z8R+hC80M4A1qS
         SOKA==
X-Gm-Message-State: AOJu0YzjX/G4qJ8iswcYWvYIdBV9C8vPAYBsNe3veBwTgVZ++/0id2qk
	8INqnTvQoSEqSA0wGlD2JMU=
X-Google-Smtp-Source: AGHT+IExLOnTv0W1LVVOICKJH4TFBkPWrlo6VuUHn/Mjcq5NQLpSOdRfBiCw5gTx+xcMdTIz7xSEfQ==
X-Received: by 2002:a17:903:18b:b0:1d3:9a7d:a39b with SMTP id z11-20020a170903018b00b001d39a7da39bmr21061978plg.5.1704315195665;
        Wed, 03 Jan 2024 12:53:15 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b001d47d37d361sm13900434plr.154.2024.01.03.12.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 12:53:15 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: irogers@google.com,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 2/2] lib min_heap: Optimize number of comparisons in min_heapify()
Date: Thu,  4 Jan 2024 04:52:59 +0800
Message-Id: <20240103205259.2108410-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103205259.2108410-1-visitorckw@gmail.com>
References: <20240103205259.2108410-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize the min_heapify() function, resulting in a significant
reduction of approximately 50% in the number of comparisons for large
random inputs, while maintaining identical results.

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


