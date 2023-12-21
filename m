Return-Path: <linux-kernel+bounces-8203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8722581B399
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5BA1F24D46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FA6671F8;
	Thu, 21 Dec 2023 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPWjJSsM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C2566ABE;
	Thu, 21 Dec 2023 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5942c83c97fso86855eaf.1;
        Thu, 21 Dec 2023 02:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703154714; x=1703759514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZD8z1FUk2T6KpKO8Jv7plBSlXMXIfnWviiaK22s/Yk=;
        b=GPWjJSsMIX+S3jutBEKjFkju+JHLnaFsn0gZTUpMMIWnfcE57khr0GHlYlguaIyBny
         f2spOk/eqykVuD2C34nKjBUPHdpoXpWZTkspiBmSU6ttGnM2lCjMbCYOLZjIIAAxR7xH
         eiUptCTccWSHxxKw5lqBLmTRcIym0YOBBajyVnVsmMQj9CqsV4/32hMphOxpsdADbSEs
         oGh66bvD1dFhdZzimV8s+wdtqKWevvgI+8NJAOBvH6E0jyy3wKu7xikUv22vyWLIDoEY
         2oKkQNb3CP87lWBX+v5rVWlcuJ/PfUiFET6Ev1B+kYq3e/rEdZ3Ry61TZ4XF83D2nmas
         Sgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703154714; x=1703759514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ZD8z1FUk2T6KpKO8Jv7plBSlXMXIfnWviiaK22s/Yk=;
        b=KzB16BArKZVrSoWlR9au1Bxv9+f0ClngQejnS8YQTcK/PvF62VAwQfRRAtPoFnS8LB
         fQGegoYAIl2oOjrHRgiqPxYnKvy9ROHnKlIFFzm24yKGPkTC+uBEWXlnbWQrBYXhOO0q
         AnLyiVIAPlfu8tntMkWwGi6PynwOFwgW97Boet3rdS9SAxmYPgo0piiR4uVyREi0+HVh
         c1aS2UlMnTaIjuCAsYY9mhP5wekWPq9cB/4m5PtrqBojJPlOSfbggffBOwInjHjJDpew
         WOTFIIQT/QHxLQBw8Xb9aEy9Ap/v4cJW7EEG9e8hMlTQYTpmpuF5uG7u0Vxo5M6w0C72
         6rmw==
X-Gm-Message-State: AOJu0Yx8Hf1+k57crQnlbktnS6LLetW8ECyK/cfcjqj0A3SmxVoo3QTr
	SVB78TktI8/vjglWKrGoU5Y=
X-Google-Smtp-Source: AGHT+IG5a94rfK3uT3XPdn2OxFh4sx+GVG7NBoYw/A1PULj7Ma78X3JQMJYzi2oaM2ItLwKm6PCCdA==
X-Received: by 2002:a05:6358:91d:b0:170:8017:d357 with SMTP id r29-20020a056358091d00b001708017d357mr941327rwi.25.1703154714098;
        Thu, 21 Dec 2023 02:31:54 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id a25-20020a634d19000000b005c6617b52e6sm1274539pgb.5.2023.12.21.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 02:31:53 -0800 (PST)
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
Subject: [PATCH v7 1/5] block: Fix bio IO priority setting
Date: Thu, 21 Dec 2023 18:31:35 +0800
Message-Id: <20231221103139.15699-2-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221103139.15699-1-hongyu.jin.cn@gmail.com>
References: <20231220100333.107049-6-hongyu.jin.cn@gmail.com>
 <20231221103139.15699-1-hongyu.jin.cn@gmail.com>
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


