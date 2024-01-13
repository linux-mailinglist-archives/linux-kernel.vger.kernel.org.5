Return-Path: <linux-kernel+bounces-25184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C0882C935
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476801F23268
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2BD19456;
	Sat, 13 Jan 2024 03:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYQdN5bL"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4479479ED
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d48a8ed85bso16564075ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705115660; x=1705720460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqal+qGElrmf6N6lWpG2H/qcx0IZTzvnDRCL9cKnE2o=;
        b=VYQdN5bLCIKT6dS4fEHySeDPh56SMIQWCX8AEZAXVfcpU2RxWgUCmKGy4Lw5vpIPJG
         s7vb89zadCdF6izf6wL2XcEHY5LgI1daDbsyvYJjhjEocAbdHvu1cIQ2CXT4EjjqPxD0
         xQGEcpq+Sl12UignPdcZF6kgrNrOYPTcfrgezMJNShhD4JfME3ZIzLvmV0PInOlSMukP
         DWgUwenOueRfj72MwQbxiywe4zAch0F4mBU69CY8Q1DOMOSzW20p/HVRpb3AnYx3UwKP
         ndNgXupwEzH/ZvPdfs4p9g8jT9961IPrOZZh8eOWLFRtn7fN8wvdFPbiemwKTGe+ePtz
         fiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705115660; x=1705720460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqal+qGElrmf6N6lWpG2H/qcx0IZTzvnDRCL9cKnE2o=;
        b=cceH47Lj3GubOPSiY1YN6cam38r6WL7Z9hyJn+STlYQJNW8qgf1guE0q/uSRRM19ed
         OJErsVuW6lpgjnW6udw53j2LWdSscxi86kWgYDYuw0dmdTRskpVtjtkOuTvW91eyxJo8
         x7yThCVY4gNHavZKGKVFl9vxU5gtn/4jbhsV2V+9IdIZmGMjYVYljpHaYmDbepyXWoqd
         I/0T/C4Rth9i8hqaROsuuISxfd3F4HgHCnBhl1pOzBe8yeyALA7Ny3/JeFAustonJmNq
         GcEoi4tp/wr4V956VNysl+TkQtbMQP+B2TNPqM+Cfk8N9GtrDWx7LGdkkJ4D4MoOsNpF
         Lmzw==
X-Gm-Message-State: AOJu0YwCxKlJ8dwkKqfXjvO4oSafrKH7J7uRC1wkI74/uXdPYAVWzR6f
	Yqbn2c3tYdrNEDLBMgO75TI=
X-Google-Smtp-Source: AGHT+IFKtSa3T0mPlMMdX2BW4DMBTYd6LSyL1TosyP+aE/m6o82TsoSUnGBMmcEqGMR3/36C1abeXQ==
X-Received: by 2002:a17:902:d50e:b0:1d4:e2bc:891c with SMTP id b14-20020a170902d50e00b001d4e2bc891cmr3922221plg.5.1705115660687;
        Fri, 12 Jan 2024 19:14:20 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902f1c200b001d3c3d486bfsm3912551plc.163.2024.01.12.19.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 19:14:20 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: lkml@sdf.org,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 2/2] lib/sort: Optimize heapsort with double-pop variation
Date: Sat, 13 Jan 2024 11:13:52 +0800
Message-Id: <20240113031352.2395118-3-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240113031352.2395118-1-visitorckw@gmail.com>
References: <20240113031352.2395118-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of popping only the maximum element from the heap during each
iteration, we now pop the two largest elements at once. Although this
introduces an additional comparison to determine the second largest
element, it enables a reduction in the height of the tree by one during
the heapify operations starting from root's left/right child. This
reduction in tree height by one leads to a decrease of one comparison
and one swap.

This optimization results in saving approximately 0.5 * n swaps without
increasing the number of comparisons. Additionally, the heap size
during heapify is now one less than the original size, offering a
chance for further reduction in comparisons and swaps.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---

The following experimental data is based on the array generated using
get_random_u32().

| N     | swaps (old) | swaps (new) | comparisons (old) | comparisons (new) |
|-------|-------------|-------------|-------------------|-------------------|
| 1000  | 9054        | 8569        | 10328             | 10320             |
| 2000  | 20137       | 19182       | 22634             | 22587             |
| 3000  | 32062       | 30623       | 35833             | 35752             |
| 4000  | 44274       | 42282       | 49332             | 49306             |
| 5000  | 57195       | 54676       | 63300             | 63294             |
| 6000  | 70205       | 67202       | 77599             | 77557             |
| 7000  | 83276       | 79831       | 92113             | 92032             |
| 8000  | 96630       | 92678       | 106635            | 106617            |
| 9000  | 110349      | 105883      | 121505            | 121404            |
| 10000 | 124165      | 119202      | 136628            | 136617            |

 lib/sort.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index fe4efd4a1410..a0509088f82a 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -215,6 +215,7 @@ void sort_r(void *base, size_t num, size_t size,
 	/* pre-scale counters for performance */
 	size_t n = num * size, a = (num/2) * size;
 	const unsigned int lsbit = size & -size;  /* Used to find parent */
+	size_t shift = 0;
 
 	if (!a)		/* num < 2 || size == 0 */
 		return;
@@ -242,12 +243,21 @@ void sort_r(void *base, size_t num, size_t size,
 	for (;;) {
 		size_t b, c, d;
 
-		if (a)			/* Building heap: sift down --a */
-			a -= size;
-		else if (n -= size)	/* Sorting: Extract root to --n */
+		if (a)			/* Building heap: sift down a */
+			a -= size << shift;
+		else if (n > 3 * size) { /* Sorting: Extract two largest elements */
+			n -= size;
 			do_swap(base, base + n, size, swap_func, priv);
-		else			/* Sort complete */
+			shift = do_cmp(base + size, base + 2 * size, cmp_func, priv) <= 0;
+			a = size << shift;
+			n -= size;
+			do_swap(base + a, base + n, size, swap_func, priv);
+		} else if (n > size) {	/* Sorting: Extract root */
+			n -= size;
+			do_swap(base, base + n, size, swap_func, priv);
+		} else	{		/* Sort complete */
 			break;
+		}
 
 		/*
 		 * Sift element at "a" down into heap.  This is the
-- 
2.25.1


