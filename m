Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADB080C3D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjLKJAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjLKJAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:00:42 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA857101;
        Mon, 11 Dec 2023 01:00:48 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35d3b220b64so17157655ab.2;
        Mon, 11 Dec 2023 01:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702285248; x=1702890048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czq/4nF48yftDC4HVsuA9AE8CVBtJqYm6rZADq2HVZo=;
        b=QS4m+ryRa9v39QRMBV0FZZwlBoPjLzLecfYF2XkwRojLx9UZ+f9EVUzeU96btWQthN
         EP7aF5AyWV0qtHVHEzKFWNoVyPJp6AYF11vshyfhgePOY/Bf7L3NxXp0WOxOLGt0VNYX
         z2yukxmsa52nj9lHES2c2z+vyTsT5pN3n+DFnZpdsq35JY6BYg9JUFZi7zZDstz+KBFx
         bUXZRsRsgPEdOt7Fw2dGe7LWES0zsySk6bCQVU22GMxQgZa0k42oJ002g8pTpvCZca4e
         6xg/hIbQfy4/WZmqCPE3uh0R4wuLc0DzyTpDUAKzAonv54eskklyFZ08hGzy8e8m6VWH
         xeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285248; x=1702890048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czq/4nF48yftDC4HVsuA9AE8CVBtJqYm6rZADq2HVZo=;
        b=Z3EZ0DZAYS3P/kEctcmaNVKWysbbVXFUsbFNdXN09riDv6TpzT++ebWzqmig/WOP40
         RfGs+kxH/HsSa631vQ7mxZeXmi0v19B4O85hAzPYvKfNQy8pyMLtiRRKRBhiwAXfQI5L
         b1zEQwwUmxLi0/r++VGh4lO6exhLSbgdJ/ppt/X+T4IhvcRmMF5gNhMmJnlY7fsVlsHN
         o+cYwxLlOB1I4r3Zo7YaMY5KHeDGPUTsMmUkDuvNU0GxN//ef6htzyGGwAKnlTsYtoWQ
         a6y8mvr/nBxgu3Lc20itiCbdEQA5pAm/S77c56RCm+41rT9rFjkbUi+ri2BJRzbc8GIB
         q7fg==
X-Gm-Message-State: AOJu0YxJ0lUF77q2MmkCQt6ZPH/gErg3+oh5CvmJaP10M3Dd1eON1mwk
        SMbKPt57jg4wckRunTuMIW0=
X-Google-Smtp-Source: AGHT+IEwn0/n8T+SvHlYhFYyRFqYBOgn7wrNpFzhJLamLhEf4Eabi+8VursYqb2tcOSwbmwGTCML4A==
X-Received: by 2002:a05:6e02:1587:b0:35d:59a2:6464 with SMTP id m7-20020a056e02158700b0035d59a26464mr6212743ilu.55.1702285247890;
        Mon, 11 Dec 2023 01:00:47 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id f14-20020a056e020b4e00b0035b0b05189bsm2211216ilu.38.2023.12.11.01.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:00:47 -0800 (PST)
From:   Hongyu Jin <hongyu.jin.cn@gmail.com>
To:     agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        axboe@kernel.dk, ebiggers@kernel.org
Cc:     zhiguo.niu@unisoc.com, ke.wang@unisoc.com, yibin.ding@unisoc.com,
        hongyu.jin@unisoc.com, linux-kernel@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH v3 1/5] block: Optimize bio io priority setting
Date:   Mon, 11 Dec 2023 16:59:56 +0800
Message-Id: <20231211090000.9578-2-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
References: <df68c38e-3e38-eaf1-5c32-66e43d68cae3@ewheeler.net>
 <20231211090000.9578-1-hongyu.jin.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hongyu Jin <hongyu.jin@unisoc.com>

Current call bio_set_ioprio() for each cloned bio and splited bio,
and the io priority can't be passed to module that implement
struct gendisk::fops::submit_bio, such as device-mapper.

Move bio_set_ioprio() into submit_bio(), only call bio_set_ioprio()
once set the priority of origin bio, cloned and splited bio
auto inherit the priority of origin bio in clone process.

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

