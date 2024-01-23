Return-Path: <linux-kernel+bounces-35884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B53839826
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76AA11F26E63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3CE82D7B;
	Tue, 23 Jan 2024 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/iIC96H"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7F2823CE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035564; cv=none; b=n82uhof7wHeXk/ra7ew+RmK+Vq1Bt+auEYq+cfEy7xb68A3bw8+8ZFY4xGaVV/ETbfHEAGb3MgB2Kl4kPyEkQSeMLQ90JvrP6zTnhKzyoEY/imSsI3utGjwN3jZT/SbmPjkikNeWAhK6yU/+pB67Utsmr2y+p4m67ozEXfMEhW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035564; c=relaxed/simple;
	bh=pUJVm7bcozh/5KgKizUKApaz91PNtWNQEpLGeh1RoSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKpAR+a3m6UEArXIRDyHq0m+MDpXkVJUJQY9wzOj7K4MSvJ6emaOoxyrDNe07FdDpop2MUutprIseaOAwS5k4mdMXF5sncYY4MHM3tlxprTUV8cjyx7fGd/VuW3WvnHaqv7BGPbb2pose8VnGh2sSrTtn7ekCaTiKIqiXvk+4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/iIC96H; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d75ea3a9b6so18104685ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706035562; x=1706640362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4tUupe0pRs64+ug0l5Lv4L/wYRNFF+WyGC/Eo0dQs5k=;
        b=a/iIC96HNMAGu3lomm1coyyOEQ37dAAcMmgvciHVallQj4g9zSzVylSuWojnDFX2NP
         VTz2YBKPIoy4rm1peNvWvmiBv8k2ztykdfreI2vlnWE3SqpgaiXSGr4qIxfE22o8BWSf
         MEs2bhWejMq72xccNenWCayISmgP3brOYgJ1DD/82FCIPYUpRKrqIQ47mlL/ghKnRF61
         pXai4r7riqDMIYsbfuO6L9AXcd+qbP/kjGkp3jqRqzvTnLeOFghWrXm4OxGjhdJQaF1m
         8YwoJTn6BiqYCV0+roYzUaNjDgWrBxUhbuUQ4PxZgZ8ovKNQr9R8fEGXEthk1Rs2iBwW
         NxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035562; x=1706640362;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tUupe0pRs64+ug0l5Lv4L/wYRNFF+WyGC/Eo0dQs5k=;
        b=XJxfvlgM673suA57xoOxXo3oLlj43fVTROkr7my57qYzxtjIlEFwaNfBuK/QBC1m+X
         U13RA1h23tJolIjPg7+L9vXRmMCE/SQdBU/U19J5VErqm8WvaNnLq1yRlRi5ovM5FNzj
         pBrZfuiUt/oXIN2ML83SNa29ZarRAgOznsLS7fnAfm6TVR3YXLqQNFtRwkxBmYxkPbi/
         E09r1YElIUpqd2qAN3UaYIN7HVafSkkyCjugxT/Jv5XfxVlgGkDEj3AlizqbrY7QAOLw
         zc7MPJ5A2X4AKpnFDqL16/bcukfjX22qMog70ra0/9WFDv0QDHophjB7/QN5OFh0BocQ
         MpOw==
X-Gm-Message-State: AOJu0YxAN7C/rYfAeynrieBTWqB4WM0S5Sou8JLFBRg330jCpodnHu8f
	P8vOHHgpkAGoiEbkhK+o+78Pm3VgNERISb7vSmAB8NVC8zhdz2Rb
X-Google-Smtp-Source: AGHT+IHzOTaNc2ALEPfuFIm2wjtMBHoRPdcf8S7u1UHGQhnOuc8VCGjIMwWrNjGtijcUP07sJotD5A==
X-Received: by 2002:a17:902:bc41:b0:1d7:2bd6:23e6 with SMTP id t1-20020a170902bc4100b001d72bd623e6mr6093896plz.128.1706035562123;
        Tue, 23 Jan 2024 10:46:02 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([1.203.117.98])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902b70500b001d74c285b55sm4035196pls.67.2024.01.23.10.45.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Jan 2024 10:46:01 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>,
	Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v3 1/3] mm, lru_gen: try to prefetch next page when scanning LRU
Date: Wed, 24 Jan 2024 02:45:50 +0800
Message-ID: <20240123184552.59758-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123184552.59758-1-ryncsn@gmail.com>
References: <20240123184552.59758-1-ryncsn@gmail.com>
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

Test 1: Ramdisk fio ro test in a 4G memcg on a EPYC 7K62:
  fio -name=mglru --numjobs=16 --directory=/mnt --size=960m \
    --buffered=1 --ioengine=io_uring --iodepth=128 \
    --iodepth_batch_submit=32 --iodepth_batch_complete=32 \
    --rw=randread --random_distribution=zipf:0.5 --norandommap \
    --time_based --ramp_time=1m --runtime=6m --group_reporting

Before this patch:
bw (  MiB/s): min= 7758, max= 9239, per=100.00%, avg=8747.59, stdev=16.51, samples=11488
iops        : min=1986251, max=2365323, avg=2239380.87, stdev=4225.93, samples=11488

After this patch (+7.2%):
bw (  MiB/s): min= 8360, max= 9771, per=100.00%, avg=9381.31, stdev=15.67, samples=11488
iops        : min=2140296, max=2501385, avg=2401613.91, stdev=4010.41, samples=11488

Test 2: Ramdisk fio hybrid test for 30m in a 4G memcg on a EPYC 7K62 (3 times):
  fio --buffered=1 --numjobs=8 --size=960m --directory=/mnt \
    --time_based --ramp_time=1m --runtime=30m \
    --ioengine=io_uring --iodepth=128 --iodepth_batch_submit=32 \
    --iodepth_batch_complete=32 --norandommap \
    --name=mglru-ro --rw=randread --random_distribution=zipf:0.7 \
    --name=mglru-rw --rw=randrw --random_distribution=zipf:0.7

Before this patch:
 READ: 6622.0 MiB/s. Stdev: 22.090722
WRITE: 1256.3 MiB/s. Stdev: 5.249339

After this patch (+4.6%, +3.3%):
 READ: 6926.6 MiB/s, Stdev: 37.950260
WRITE: 1297.3 MiB/s, Stdev: 7.408704

Test 3: 30m of MySQL test in 6G memcg (12 times):
  echo 'set GLOBAL innodb_buffer_pool_size=16106127360;' | \
    mysql -u USER -h localhost --password=PASS

  sysbench /usr/share/sysbench/oltp_read_only.lua \
    --mysql-user=USER --mysql-password=PASS --mysql-db=DB \
    --tables=48 --table-size=2000000 --threads=16 --time=1800 run

Before this patch
Avg: 134743.714545 qps. Stdev: 582.242189

After this patch (+0.2%):
Avg: 135005.779091 qps. Stdev: 295.299027

Test 4: Build linux kernel in 2G memcg with make -j48 with SSD swap
        (for memory stress, 18 times):

Before this patch:
Avg: 1456.768899 s. Stdev: 20.106973

After this patch (+0.0%):
Avg: 1455.659254 s. Stdev: 15.274481

Test 5: Memtier test in a 4G cgroup using brd as swap (18 times):
  memcached -u nobody -m 16384 -s /tmp/memcached.socket \
    -a 0766 -t 16 -B binary &
  memtier_benchmark -S /tmp/memcached.socket \
    -P memcache_binary -n allkeys \
    --key-minimum=1 --key-maximum=16000000 -d 1024 \
    --ratio=1:0 --key-pattern=P:P -c 1 -t 16 --pipeline 8 -x 3

Before this patch:
Avg: 50317.984000 Ops/sec. Stdev: 2568.965458

After this patch (-5.7%):
Avg: 47691.343500 Ops/sec. Stdev: 3925.772473

It seems prefetch is helpful in most cases, but the memtier test is
either hitting a case where prefetch causes higher cache miss or it's
just too noisy (high stdev).

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/vmscan.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4f9c854ce6cc..03631cedb3ab 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3681,15 +3681,26 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 	/* prevent cold/hot inversion if force_scan is true */
 	for (zone = 0; zone < MAX_NR_ZONES; zone++) {
 		struct list_head *head = &lrugen->folios[old_gen][type][zone];
+		struct folio *prev = NULL;
 
-		while (!list_empty(head)) {
-			struct folio *folio = lru_to_folio(head);
+		if (!list_empty(head))
+			prev = lru_to_folio(head);
+
+		while (prev) {
+			struct folio *folio = prev;
 
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) != type, folio);
 			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
+			if (unlikely(list_is_first(&folio->lru, head))) {
+				prev = NULL;
+			} else {
+				prev = lru_to_folio(&folio->lru);
+				prefetchw(&prev->flags);
+			}
+
 			new_gen = folio_inc_gen(lruvec, folio, false);
 			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
 
@@ -4341,11 +4352,15 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	for (i = MAX_NR_ZONES; i > 0; i--) {
 		LIST_HEAD(moved);
 		int skipped_zone = 0;
+		struct folio *prev = NULL;
 		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
 		struct list_head *head = &lrugen->folios[gen][type][zone];
 
-		while (!list_empty(head)) {
-			struct folio *folio = lru_to_folio(head);
+		if (!list_empty(head))
+			prev = lru_to_folio(head);
+
+		while (prev) {
+			struct folio *folio = prev;
 			int delta = folio_nr_pages(folio);
 
 			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
@@ -4355,6 +4370,13 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 			scanned += delta;
 
+			if (unlikely(list_is_first(&folio->lru, head))) {
+				prev = NULL;
+			} else {
+				prev = lru_to_folio(&folio->lru);
+				prefetchw(&prev->flags);
+			}
+
 			if (sort_folio(lruvec, folio, sc, tier))
 				sorted += delta;
 			else if (isolate_folio(lruvec, folio, sc)) {
-- 
2.43.0


