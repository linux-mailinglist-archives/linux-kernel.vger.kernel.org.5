Return-Path: <linux-kernel+bounces-2905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0681640C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DBCB215CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361422904;
	Mon, 18 Dec 2023 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+QVVJl2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057EB1FDC;
	Mon, 18 Dec 2023 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c66b093b86so2634319a12.0;
        Sun, 17 Dec 2023 17:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702862911; x=1703467711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk71sp729csxdUViLno20l6lcdfkMyL/Wdv2yhvpzTA=;
        b=E+QVVJl2n126lI8rwMg9hI4d6p3bP3nYU4/ksGeRv6CU1qZjRKWMOjOXxj0QXxqURU
         RG3dpKspn3XRdoiplLw5iUjBHRJvMxVwGVeerYZy6huZOqCc7ha+GmAq10YzltYmIs/F
         yfUA+rhlr1wDkpvl98qchx9AMMpPZNNpsrHYmPRZOyAMNDzQy2FA74HC3DcHU9FbUoXt
         xXIKqv6z3d1E5/QXD8vK3oENiN2hvHCics0NkroP53X2hd6VBGfM1KE2TkeGd+ETPKD+
         qpYTV6wzgWwpOgOju0ZGysmXnNe3DJ7QBI8uXA2xddgwvSVNlBUNKh7b3AHtc49gaM8O
         6kuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702862911; x=1703467711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk71sp729csxdUViLno20l6lcdfkMyL/Wdv2yhvpzTA=;
        b=c7XUXGtUlK323dZZUyS3gPwLyESrvu4sH6wlzCmqDdy/pnXv7v0JckU0R0a5BlxI1z
         nJQwX9AKL01CK/6w/pocOtfiJQZgxvBzZKIZFu81BrQjYqcDuNy+6gtr3naTrcelarLQ
         Bw8rvz8NGQmmwTa2hpCuTWG0RKea8KLJtzqq6gNu3tD14NrAVnFoKsF6Ldv6HvUng0qn
         LD4hziMTcDo0WiWFJDA+3gQjPspenlEMgew/Gh9HVRkZ9nlvmKrcvI2Byv2Q9fQQ5DSj
         LJBJk8oaRwXjeVnm8KDIezeEhKhTPHorx6j3jkOP3vuVl+MqxIssXO+esPnDoY1I+2HA
         thaA==
X-Gm-Message-State: AOJu0YxAC4NoA5X/acJF3DAk3legv6HGvLXAzUGdbJzgYSYwk/wIK6Dv
	amipiegRpfSCB5Rh4lSNW11d4cdWAco=
X-Google-Smtp-Source: AGHT+IGIW8V+FXQE4QZVdghGOek1twkpYnBAF4/L86R85oU2yDUkfD2Mvu4T3PVI8IobBVO/NvrNFw==
X-Received: by 2002:a05:6a21:3e05:b0:194:38c1:51f2 with SMTP id bk5-20020a056a213e0500b0019438c151f2mr1810279pzc.59.1702862911236;
        Sun, 17 Dec 2023 17:28:31 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s6-20020a625e06000000b006d64c4cb661sm1414014pfb.200.2023.12.17.17.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 17:28:30 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v5 RESEND 1/5] block: Fix bio IO priority setting
Date: Mon, 18 Dec 2023 09:27:42 +0800
Message-Id: <20231218012746.24442-2-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
References: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
 <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

Move bio_set_ioprio() into submit_bio():
1. Only call bio_set_ioprio() once to set the priority of original bio,
   the bio that cloned and splited from original bio will auto inherit
   the priority of original bio in clone process.

2. The IO priority can be passed to module that implement
   struct gendisk::fops::submit_bio, help resolve some
   of the IO priority loss issues.

This patch depends on commit 82b74cac2849 ("blk-ioprio: Convert from
rqos policy to direct call")

Fixes: a78418e6a04c ("block: Always initialize bio IO priority on submit")

Co-developed-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>
---
 block/blk-core.c | 10 ++++++++++
 block/blk-mq.c   | 11 -----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index fdf25b8d6e78..68158c327aea 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -49,6 +49,7 @@
 #include "blk-pm.h"
 #include "blk-cgroup.h"
 #include "blk-throttle.h"
+#include "blk-ioprio.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -809,6 +810,14 @@ void submit_bio_noacct(struct bio *bio)
 }
 EXPORT_SYMBOL(submit_bio_noacct);
 
+static void bio_set_ioprio(struct bio *bio)
+{
+	/* Nobody set ioprio so far? Initialize it based on task's nice value */
+	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
+		bio->bi_ioprio = get_current_ioprio();
+	blkcg_set_ioprio(bio);
+}
+
 /**
  * submit_bio - submit a bio to the block device layer for I/O
  * @bio: The &struct bio which describes the I/O
@@ -831,6 +840,7 @@ void submit_bio(struct bio *bio)
 		count_vm_events(PGPGOUT, bio_sectors(bio));
 	}
 
+	bio_set_ioprio(bio);
 	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..a6e2609df9c9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,7 +40,6 @@
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
-#include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
@@ -2922,14 +2921,6 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	return rq;
 }
 
-static void bio_set_ioprio(struct bio *bio)
-{
-	/* Nobody set ioprio so far? Initialize it based on task's nice value */
-	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
-		bio->bi_ioprio = get_current_ioprio();
-	blkcg_set_ioprio(bio);
-}
-
 /**
  * blk_mq_submit_bio - Create and send a request to block device.
  * @bio: Bio pointer.
@@ -2963,8 +2954,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
 
-	bio_set_ioprio(bio);
-
 	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
 	if (!rq) {
 		if (!bio)
-- 
2.34.1


