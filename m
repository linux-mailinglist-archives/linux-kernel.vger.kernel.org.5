Return-Path: <linux-kernel+bounces-14509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C15B0821E0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92B41C20617
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B12C14F68;
	Tue,  2 Jan 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM3HUjIj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3614F62
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28bc870c540so7315983a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704207027; x=1704811827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCgO/9ttUPkNH7K3G/yJnpUY2imlxWqPy44q0o7/7cg=;
        b=bM3HUjIjdkKuziGFOvXltDwZisIBomDfioRKmjqsY9RlP6Fd4Nz/EsRAro9S4Dcj/r
         3WeQA7enlJk2n3voOhzq3bKaRNQYtz83aNvXTBOAk7Df8cyRhkWvrfc4T4P4XYggMt5d
         Tobd5t1iq2eVa6XsXNrDRvVllUbGDO0f1h/dHPHex539uPleK2IT41xTve0Xy1GWOBJh
         I7VrKAjrpcb7BOp56UpBxjyJ3NnzUNvGesfsxFk9Rt1Ox8ja7C9MSi01bD7YQUr3Gw/A
         XXit4g53IyRfcNbWdUVosITLKaVCvr59NktFRPvrodJICkdqSAYO8WQd2bfTXFUOOyPO
         vcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207027; x=1704811827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCgO/9ttUPkNH7K3G/yJnpUY2imlxWqPy44q0o7/7cg=;
        b=n3yKr5rGr8Z7n+Yruy7EANNwS8O2cmLu7ZkLang2tLK5bg+2oCcIUJwQUbUZxvxidd
         gsXitSqlBUFQ2r5oH/zL0jmOx8DQw+o0KV5cEOsg+cpI1DBgrV5nfJSj+e+a/RlrM9AK
         nxpes4w2lz1Zym2pmS3qpx7WZggXZOZhfPUNYDqFhs9G6xrwUJJCWYjJXc71itdURD5d
         cvkclUKqs79GwKNSdrl5GfmfdqYpM+4XjumWFFCQ/odNbD6FwdESKYDdVQwH6BQVwSZ8
         PkS6afrQJm6KnAGM+svx2grsN8UI3TnqPjX9wkAYq9HMpHUm4yGg39sOkmrYOAeJzUxC
         pnwQ==
X-Gm-Message-State: AOJu0YzwDy6l8qrXIuhyUGXU4OnvifV4WBnUMBiRkf86++9KpY80Wj/6
	3+rdRqovuqZiJhMmLGQPD8RRiMjOqCe19w==
X-Google-Smtp-Source: AGHT+IEp/OYVuT1KyjbMk8HhRA8LrmsYNrUwPzBctDSGWxhQxggYuqj7FbqKq9gKzAV7mA4P8VLVlA==
X-Received: by 2002:a17:90b:4b52:b0:28b:e79e:f8d9 with SMTP id mi18-20020a17090b4b5200b0028be79ef8d9mr8228754pjb.84.1704207027515;
        Tue, 02 Jan 2024 06:50:27 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a005300b0028be216595csm25836878pjb.4.2024.01.02.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:50:27 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v2 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
Date: Tue,  2 Jan 2024 22:49:05 +0800
Message-ID: <20240102144905.110047-4-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102144905.110047-1-ytcoode@gmail.com>
References: <20240102144905.110047-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of crash_exclude_mem_range() is to remove all memory ranges
that overlap with [mstart-mend]. However, the current logic only removes
the first overlapping memory range.

Commit a2e9a95d2190 ("kexec: Improve & fix crash_exclude_mem_range() to
handle overlapping ranges") attempted to address this issue, but it did not
fix all error cases.

Let's fix and simplify the logic of crash_exclude_mem_range().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/crash_core.c | 80 ++++++++++++++++-----------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index efe87d501c8c..c51d0a54296b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -565,9 +565,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 int crash_exclude_mem_range(struct crash_mem *mem,
 			    unsigned long long mstart, unsigned long long mend)
 {
-	int i, j;
+	int i;
 	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
 
 	for (i = 0; i < mem->nr_ranges; i++) {
 		start = mem->ranges[i].start;
@@ -575,72 +574,51 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 		p_start = mstart;
 		p_end = mend;
 
-		if (mstart > end || mend < start)
+		if (p_start > end)
 			continue;
 
+		/*
+		 * Because the memory ranges in mem->ranges are stored in
+		 * ascending order, when we detect `p_end < start`, we can
+		 * immediately exit the for loop, as the subsequent memory
+		 * ranges will definitely be outside the range we are looking
+		 * for.
+		 */
+		if (p_end < start)
+			break;
+
 		/* Truncate any area outside of range */
-		if (mstart < start)
+		if (p_start < start)
 			p_start = start;
-		if (mend > end)
+		if (p_end > end)
 			p_end = end;
 
 		/* Found completely overlapping range */
 		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
+			memmove(&mem->ranges[i], &mem->ranges[i + 1],
+				(mem->nr_ranges - (i + 1)) * sizeof(mem->ranges[i]));
+			i--;
 			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
+		} else if (p_start > start && p_end < end) {
 			/* Split original range */
+			if (mem->nr_ranges >= mem->max_nr_ranges)
+				return -ENOMEM;
+
+			memmove(&mem->ranges[i + 2], &mem->ranges[i + 1],
+				(mem->nr_ranges - (i + 1)) * sizeof(mem->ranges[i]));
+
 			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
+			mem->ranges[i + 1].start = p_end + 1;
+			mem->ranges[i + 1].end = end;
+
+			i++;
+			mem->nr_ranges++;
 		} else if (p_start != start)
 			mem->ranges[i].end = p_start - 1;
 		else
 			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
 	}
 
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
 	return 0;
 }
 
-- 
2.43.0


