Return-Path: <linux-kernel+bounces-9592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF7781C81C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC511F25745
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB7199A4;
	Fri, 22 Dec 2023 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEswjhFV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C618AEF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d4bef65786so1552202b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703240655; x=1703845455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZVtAklavGTH0ChBjbCr10B7CRN0g8Fxr7pwyrunV9Wg=;
        b=aEswjhFVbtl4tVqHQuo2E9+S5v6MEYNdo5S31anwKqFyeU0cNQleA+jGCiaBeq7mN/
         2fm8BST1OUgrwKqdAITKNmD4J84yfKOZWYf44uk7rGy4NjaNfFvocdH9MLsDaI+P7QyZ
         61eYYtvFUpk+7Qa7PlDFoMf0hMTUDQO+2orFET4SJUFP5PGsT5Pde0JotUmhpevJOhlt
         l9wY6fZek+PHsXWSnZdyXrZ0a0EQTtWJSX/2gcP64+OUbqBc/D89HuRivBskF3MDdZw3
         zhVFijIf+OE8XF2xgK4tl6uC98OxKyNVivupqMhhgUgVOvhG2quoKAUnZHwPlG44Z3OD
         QFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703240655; x=1703845455;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVtAklavGTH0ChBjbCr10B7CRN0g8Fxr7pwyrunV9Wg=;
        b=G1WLOHZCSfXN8SjQfRI/MAMSkutEHmLee5nhHVs9h2Gp+zLUUe0Yk4AxiCUD70KYD7
         HhkQxdmrN85iqbLZvZffgH4rxg+MTbD+E70b8otJhTr+Vf1F0xeZknqeOcZrcBZdE657
         bCV0RRk6+Y/8o0Ot2iCDvskCCg58ytMCCxnuaF8uSL9eV0GqswoyFjQaKANAKnaqxb2H
         P+mt7dqyqI5w3VK/0ZfCuAHMyIUlwOBfAnVzEGxP4bpK23O5U7yXWRCwIm5qBRTYvU+t
         Dq+lWEyPswXkXNXTjdWhGs7jALxfOLwh/kTkSly8bVJJGjRmpPEDdYWP+Vvneulj8DyY
         1USg==
X-Gm-Message-State: AOJu0YyzyTbN4ZNiF+eNlIZ9s6DAHdt21/NxedV8/IpQ1ngMZgGnVOlv
	1hfugSE2mjmcPQo8yd8JU/PKU7QHrmEoES53
X-Google-Smtp-Source: AGHT+IFG6ajXG6vALhMWO57ARn52j3Kb6LdriotQIo1jxt6hAcExEanAl4pobD+1sBFGtt0fLivXqg==
X-Received: by 2002:a05:6a20:12c9:b0:190:85d9:9d4a with SMTP id v9-20020a056a2012c900b0019085d99d4amr1304221pzg.97.1703240655043;
        Fri, 22 Dec 2023 02:24:15 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id gx1-20020a056a001e0100b006d9912e9a77sm364074pfb.6.2023.12.22.02.24.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 22 Dec 2023 02:24:14 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 3/3] mm, lru_gen: try to prefetch next page when canning LRU
Date: Fri, 22 Dec 2023 18:22:55 +0800
Message-ID: <20231222102255.56993-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222102255.56993-1-ryncsn@gmail.com>
References: <20231222102255.56993-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Prefetch for inactive/active LRU have been long exiting, apply the same
optimization for MGLRU.

Tested in a 4G memcg on a EPYC 7K62 with:

  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 16 -B binary &

  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys \
    --key-minimum=1 --key-maximum=16000000 -d 1024 \
    --ratio=1:0 --key-pattern=P:P -c 2 -t 16 --pipeline 8 -x 6

Average result of 18 test runs:

Before:           44017.78 Ops/sec
After patch 1-3:  44890.50 Ops/sec (+1.8%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index af1266129c1b..1e9d69e18443 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3764,10 +3764,12 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
-			if (unlikely(list_is_first(&folio->lru, head)))
+			if (unlikely(list_is_first(&folio->lru, head))) {
 				prev = NULL;
-			else
+			} else {
 				prev = lru_to_folio(&folio->lru);
+				prefetchw(&prev->flags);
+			}
 
 			new_gen = folio_inc_gen(lruvec, folio, false, &batch);
 			lru_gen_try_inc_bulk(lrugen, folio, bulk_gen, new_gen, type, zone, &batch);
@@ -4434,10 +4436,12 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
 			scanned += delta;
-			if (unlikely(list_is_first(&folio->lru, head)))
+			if (unlikely(list_is_first(&folio->lru, head))) {
 				prev = NULL;
-			else
+			} else {
 				prev = lru_to_folio(&folio->lru);
+				prefetchw(&prev->flags);
+			}
 
 			if (sort_folio(lruvec, folio, sc, tier, bulk_gen, &batch))
 				sorted += delta;
-- 
2.43.0


