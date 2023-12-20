Return-Path: <linux-kernel+bounces-6683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9513B819C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B6E61F267ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D2B20326;
	Wed, 20 Dec 2023 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY1tCjnn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8E121345;
	Wed, 20 Dec 2023 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3dc30ae01so12983995ad.0;
        Wed, 20 Dec 2023 02:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066635; x=1703671435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZD8z1FUk2T6KpKO8Jv7plBSlXMXIfnWviiaK22s/Yk=;
        b=BY1tCjnnWwP1L30doQcnHKGIqU9qUlXONgsp/JX0RtY3uypWTFgGmM7ETfHGpbDOTo
         VBMEjTHfo8kyf3+Dvwq5FOKtch3KkOjA8agWAS4059AjGdwIf+7hB/sQf6Hr7fGUpzwe
         pTlI3S36icF1MUKp9rMv5rS16bbwGM4DiYQkHyA2XafzKqns+BrApS/7semClNlU2BFR
         jJjob4Vj/Aup1c+scE7tWFiAoP8ckbspSAh7oAcmkFiNxBLxo+uG5oo61SKRP7nHoAT3
         6LBffd4EfKyjMBRO4XzsUftoEFZj9OCt8sB89HO0YUelI/GGrvEv/fjk82atbUWt7+02
         ncvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066635; x=1703671435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZD8z1FUk2T6KpKO8Jv7plBSlXMXIfnWviiaK22s/Yk=;
        b=Gzcw362t9Vfk6dwMC6slzJKZDne9e9i2JGvYSir/aUTIshMMcozJTPN5LQ1qwAsHUY
         M/jd53hqMe8TF/YAtG5453LgyaVrUlog188D7k9daHk6q6DG6Aoi3W1RKNrhquLab4mB
         lbLIH7U96EbwUh8RaAVXVfyemN8/xCDdaGsaX8+6EknPQOebyNgotwpENTT6Ugc5Jt6Q
         lb7a8poukhAh8y7DfNX7En2rA9izhpTMBcg6k1BOJQHvMusED0lvW36sqoDUKSjivGkY
         rsMm0TcOJ6h8aXoUBVBP5tlST9x9Uk0seWyXQD5hzmz0qFKofzpQmwEWB61Ww/9IYAcU
         qsSA==
X-Gm-Message-State: AOJu0Yylj/aXkqXlXMWpPPlI6lFXih50zIIBCg4DE21jGoYDahfBu8Wt
	C9oabixYNIr3Rmj+705gWZM=
X-Google-Smtp-Source: AGHT+IF7ZiYJ4GnoDvucGYc1U7p/pTj2piTcD+H+C1aMmX1RkhKX0TVTSy6/AzZMmH1wFQj5/23ryQ==
X-Received: by 2002:a17:902:e810:b0:1d3:eb97:9446 with SMTP id u16-20020a170902e81000b001d3eb979446mr1466202plg.9.1703066635364;
        Wed, 20 Dec 2023 02:03:55 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902fe8300b001d3b7c5776asm5721619plm.160.2023.12.20.02.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:03:54 -0800 (PST)
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
Subject: [PATCH v6 1/5] block: Fix bio IO priority setting
Date: Wed, 20 Dec 2023 18:03:29 +0800
Message-Id: <20231220100333.107049-2-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220100333.107049-1-hongyu.jin.cn@gmail.com>
References: <20231213104216.27845-6-hongyu.jin.cn@gmail.com>
 <20231220100333.107049-1-hongyu.jin.cn@gmail.com>
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
index 2eca76ccf4ee..d707ec056f34 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -49,6 +49,7 @@
 #include "blk-pm.h"
 #include "blk-cgroup.h"
 #include "blk-throttle.h"
+#include "blk-ioprio.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -817,6 +818,14 @@ void submit_bio_noacct(struct bio *bio)
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
@@ -839,6 +848,7 @@ void submit_bio(struct bio *bio)
 		count_vm_events(PGPGOUT, bio_sectors(bio));
 	}
 
+	bio_set_ioprio(bio);
 	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ac18f802c027..351e8283eda1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,7 +40,6 @@
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
-#include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
@@ -2919,14 +2918,6 @@ static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
 	return true;
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
@@ -2957,8 +2948,6 @@ void blk_mq_submit_bio(struct bio *bio)
 			return;
 	}
 
-	bio_set_ioprio(bio);
-
 	if (plug) {
 		rq = rq_list_peek(&plug->cached_rq);
 		if (rq && rq->q != q)
-- 
2.34.1


