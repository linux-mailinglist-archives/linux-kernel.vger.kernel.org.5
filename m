Return-Path: <linux-kernel+bounces-23985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1882B4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D28CB21042
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB245646A;
	Thu, 11 Jan 2024 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV7L8mTQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8E55C3E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3eb299e2eso35979405ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704998024; x=1705602824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FtBGRSINF6KI+RQqf15dVUHoZl7wlhzwJWjlp3npicI=;
        b=WV7L8mTQK650Xu/cZzejuMMoTwolQGrq8Kjy9Rrg75rq/GKwheFZ2TiLBzst72L2El
         PX8+pgvayjS+JzbumqxxrHumo9FEpA22dI4RDU3RKR5I7qml/ovHv6CF5YPEdIUonZfM
         tdCrC+zp1j9IQk9QTZX13MDZWCbmMTiD9leQHJ8eEMFJ+GmzehSYEOCRw6Df1BnSJCMh
         GG+2pbgP2cesw9heqs88OoonqSNywbesdYVTHPqov/VsyLwIiOeP9yseMDqmG4Kh4HD1
         a40ya4a6TqyVKkNDcM7ASN8u6JgxkFxH6RX3+oW1PTX4dAbmSMZf+9prv2ER85de2W/9
         Fksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998024; x=1705602824;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtBGRSINF6KI+RQqf15dVUHoZl7wlhzwJWjlp3npicI=;
        b=oKQdYTO8wlbNhPdI05D8Mchscre6yN5gNbKcuX0aYYCV+l2o287JWavptHn+Mz7JW6
         ujYp6h7FCZntqsIillsaaleXQ8fz3LYiNv+12GbFnlLEBG6kP3xAHHNFrET8hwuq8aOX
         FRvdsIkLpCBKozU4yulYsLlT7v4bPJDQYUaMilBbG7EamQ21Kckg8Xee4E5/dT1Xd6C/
         mf5gaYQq4j0Wag42ihJ2HU6mgWBNZ83mBzKivUJx9jYPy2SNxOiWq9P1MHZZLW14D2O+
         VuQFOPeXwz0vV1I9PxEYoyC6+hfhEDMqM5QxF7b2ujlxzAi22ZmzzYrydsJ90TVRnXbM
         j93A==
X-Gm-Message-State: AOJu0Yw/lr4XxjvBwopM8C1KQM57CNvRPEMLr71wbN7gHqxnw/ai5KTX
	D7R9TMqplfK7dFlgyn7ibkI=
X-Google-Smtp-Source: AGHT+IFBEjyW6RvYROEJiwKiMLp56a9P4SPF8Qzgo7qO9Q/w+d/Lqk+mkTK5izHiT22OVPgAbeFUzw==
X-Received: by 2002:a17:902:ea91:b0:1d4:ca2e:2bfb with SMTP id x17-20020a170902ea9100b001d4ca2e2bfbmr149921plb.42.1704998023664;
        Thu, 11 Jan 2024 10:33:43 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170902fc8300b001d08e080042sm1483267plb.43.2024.01.11.10.33.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jan 2024 10:33:43 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 3/3] mm, lru_gen: try to prefetch next page when canning LRU
Date: Fri, 12 Jan 2024 02:33:21 +0800
Message-ID: <20240111183321.19984-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111183321.19984-1-ryncsn@gmail.com>
References: <20240111183321.19984-1-ryncsn@gmail.com>
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

Ramdisk based swap test in a 4G memcg on a EPYC 7K62 with:

  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 16 -B binary &

  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys \
    --key-minimum=1 --key-maximum=16000000 -d 1024 \
    --ratio=1:0 --key-pattern=P:P -c 2 -t 16 --pipeline 8 -x 6

Average result of 18 test runs:

Before:           44017.78 Ops/sec
After patch 1-3:  44890.50 Ops/sec (+1.8%)

Ramdisk fio test in a 4G memcg on a EPYC 7K62 with:

  fio -name=mglru --numjobs=16 --directory=/mnt --size=960m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=zipf:0.5 --norandommap \
    --time_based --ramp_time=1m --runtime=5m --group_reporting

Before this patch:
bw (  MiB/s): min= 7644, max= 9293, per=100.00%, avg=8777.77, stdev=16.59, samples=9568
iops        : min=1956954, max=2379053, avg=2247108.51, stdev=4247.22, samples=9568

After this patch (+7.5%):
bw (  MiB/s): min= 8462, max= 9902, per=100.00%, avg=9444.77, stdev=16.43, samples=9568
iops        : min=2166433, max=2535135, avg=2417858.23, stdev=4205.15, samples=9568

Prefetch is highly related to timing and architecture so it may only help in
certain cases, some extra test showed at least no regression here for
the series:

Ramdisk memtier test above in a 8G memcg on an Intel i7-9700:

  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys --key-minimum=1 \
    --key-maximum=36000000 --key-pattern=P:P -c 1 -t 12 \
    --ratio 1:0 --pipeline 8 -d 1024 -x 4

Average result of 12 test runs:

Before:           61241.96 Ops/sec
After patch 1-3:  61268.53 Ops/sec (+0.0%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 57b6549946c3..4ef83db40adb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3773,10 +3773,12 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
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
@@ -4452,10 +4454,12 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
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


