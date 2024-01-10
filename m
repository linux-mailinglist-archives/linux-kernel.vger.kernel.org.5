Return-Path: <linux-kernel+bounces-21827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86D8294E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8C91F24ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674FC3EA6B;
	Wed, 10 Jan 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVeMmdAa"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E863EA82;
	Wed, 10 Jan 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3b84173feso7686205ad.1;
        Wed, 10 Jan 2024 00:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704874349; x=1705479149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYaz82mYYzCwX1xxNWNg9eztYs/P62dbK5BPPUgSW7A=;
        b=bVeMmdAa/ZnF9uxmuvX0BQN6P9WSbE46OShI8wg4e4R5wFZBJUyXohtUnHb5iks8/o
         YbW8wxO9xnA5N+A6FhJK4OTtj6YQtX9VvfstnIJY+kli1XVUUCONHtPSrou7nqK3AyVO
         xKotmeXzgWAvpX7rUO8E7exlnwAe5OIQLBzFUgifq5Cq6DSxd9Mw0gUv2u1fibB2ygw0
         uLlUuHifuf+/anVaG4TrmGGdW/bQoawdVwi3ME+I+nKya+IWKjJgoJ6AJRHP3W6IGwzS
         sIzbrU10XwkuOcLpa/Zv6EJIOeY2lQsQ9yXdDlYKkVwkcSzZwFUm/qKP5JD9ENCr2yN/
         QOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704874349; x=1705479149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYaz82mYYzCwX1xxNWNg9eztYs/P62dbK5BPPUgSW7A=;
        b=RmShWWfO9gAz9ylv6DUkNVFS3SB9wSfyN11ZT/0Sx4Nqko6dWW64UJisU2eFSltSZe
         KTjX4CMw0nOeEu4qRKrvXyr109AqcHVSaUANYpyqK7BdXKhmEKeMdALtCwAm2x84sPE0
         x2TPmpmvaY0QHQmAauT7VAjvT1cZPBms73WC9Ccb3P1YzfE/+5srmHZEJHRdwN765avQ
         bNdr8zSAjOJfMm+1PukPmiSWoZf+8hsg4N5gvR7dQsoMHyLMQTG63wJnCcnsJSdnMwvz
         5dX4OQG2IfkXpFLC/HLPfQAESYvE+8hT3HN89QxQfJOYNghHbCAEJ6dCOeqWs6LUpMZl
         ixAg==
X-Gm-Message-State: AOJu0YzmIGf1nGOV0doTdS7PBh7L0u3idgat8J1FjGDFuOFlj6dBNZqM
	nLF4N4YRheFfIylYWB91B20=
X-Google-Smtp-Source: AGHT+IHpdXji4t0wxJVbSPH8Z2/slBHqUAFGgIFZITd1/McXsQZu63Yz4Pa307KIahaW3bvcuHPVrw==
X-Received: by 2002:a17:902:9a90:b0:1d4:e308:d6fb with SMTP id w16-20020a1709029a9000b001d4e308d6fbmr1207351plp.5.1704874349630;
        Wed, 10 Jan 2024 00:12:29 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902b68c00b001cf51972586sm3044243pls.292.2024.01.10.00.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 00:12:29 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [RESEND PATCH v2 2/2] lib min_heap: Optimize number of comparisons in min_heapify()
Date: Wed, 10 Jan 2024 16:12:13 +0800
Message-Id: <20240110081213.2289636-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110081213.2289636-1-visitorckw@gmail.com>
References: <20240110081213.2289636-1-visitorckw@gmail.com>
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


