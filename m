Return-Path: <linux-kernel+bounces-36472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56E83A163
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121971F2176B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91547101C1;
	Wed, 24 Jan 2024 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnmrEcc6"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A0F9C1;
	Wed, 24 Jan 2024 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706074571; cv=none; b=Gx+d2rWpwbRIQ+GvFqEERViA/te366hpHoXr8wUQSQZIVChCUGZtmr4LzO6dUMZTyJh4983xJ90kg4cB/iTEI5bnG9vWlSCORAvFCCbll69h883b4HRLrOtuD+6kkpuC3/GI18dAzBsa0aRLjTmApz9QeboZAoUF5IGflDW3S/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706074571; c=relaxed/simple;
	bh=vzhS6Yw0l/Z58XSVDLaOu78FXLMhzplmG4xTTfPt9C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9sCXAZBuOCQAXCIwo+9SdGB9RK3BmFrsq0RWpHmZtJptAi27icDU9H+uA59w1HJLdw72zMV20OAmFvdEMD4d4exqM+2Ilpi0ggF7PeD8d1x9UrC5UbcbUpvdd6wTkCLUupxXX5pERkrzbuPwbfsq9qXgRXadF4S8h3Buacjr7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnmrEcc6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d720c7fc04so28464795ad.2;
        Tue, 23 Jan 2024 21:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706074569; x=1706679369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKyOiEcqJPFq+lUKHVHdFYPT0CvR+VKFddHQFhQnJeY=;
        b=RnmrEcc6BHc1+cv/Dp0jnPwCv0n4jPV7TbEx+jzOGlxJ94cVL+sG7kfZScVsmdghzs
         sSRsm71lcCvCs7gVNeQC+McDE0F1So1VRfo+Od9AkOeHo4CJwHTFwJ4EZlngGhntLP3e
         wFBYiY/3nAmWsCt0Tw3IGi646kXLLnnK9wpqZXPsGBu59baK/8o8feJJBcjREMyWQoDw
         /z8K6WveAJ/nj52CuJmQRdxGhcwBrhg8UnuqC5tW5Qx1h8u3hwfi7b5KS2/0Sq5j2hAi
         tiERzBVdl0UBvYAaAxjB+fnQRlmt/xmmh86YAaRzp8ZYOQ5hkdPASmuis4EZK/PtfSUV
         eQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706074569; x=1706679369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKyOiEcqJPFq+lUKHVHdFYPT0CvR+VKFddHQFhQnJeY=;
        b=D9WXVzWEQeoQ1VERTmcuBH9QNTjxKVvfinOYIm9SoyHKI99eFkRjsGtO/ouKd/Cxlw
         HI6NfpB933Gonfuf71ItbsFhNJq7DD1r/C8LZF0iSg07bvlDrfpyYkxEqMd/MFZ2dw/L
         jPzr0gIOlC4y+KQCRut/o3evvLVMVxTP3yRjx7ZVOhhGosC1XKN2WqiXWMF+Mx2ztFd5
         XEzANv3QaNZItYpeysOjr8HABYOktwTMgnlMmtG9q1IS8yW8r402Gjdq3RRkPWZTVAaz
         v2B3/4vEyvbLADSSCm9Q+aSHpUFOCQdVgZgqYN4oTXR/LVg0hgsFol//SOHI5+lpYPmH
         M0pQ==
X-Gm-Message-State: AOJu0YypIg4UvHB8Gj3eoL/VI+jefutkuRo/1pJ06jV6YBtn0Yw2ukqJ
	50urhLD4+WBbwUE1jLDP8baCrUmX2FBt1e25Tb94mJP87+pqUe4C
X-Google-Smtp-Source: AGHT+IFvPUKiLFPOToglddyZowKK8F5ajBLiJeYrmszzYx2ohL1cCnYFiS65XZxb9RVhy1DlScJb4A==
X-Received: by 2002:a17:902:a982:b0:1d7:5bde:7c2f with SMTP id bh2-20020a170902a98200b001d75bde7c2fmr197526plb.21.1706074569565;
        Tue, 23 Jan 2024 21:36:09 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id kt6-20020a170903088600b001d755acec64sm4015663plb.189.2024.01.23.21.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 21:36:09 -0800 (PST)
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
Subject: [PATCH v8 1/5] block: Fix bio IO priority setting
Date: Wed, 24 Jan 2024 13:35:52 +0800
Message-Id: <20240124053556.126468-2-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
References: <20231221103139.15699-6-hongyu.jin.cn@gmail.com>
 <20240124053556.126468-1-hongyu.jin.cn@gmail.com>
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
 block/blk-mq.c   | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 11342af420d0..de771093b526 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -49,6 +49,7 @@
 #include "blk-pm.h"
 #include "blk-cgroup.h"
 #include "blk-throttle.h"
+#include "blk-ioprio.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -833,6 +834,14 @@ void submit_bio_noacct(struct bio *bio)
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
@@ -855,6 +864,7 @@ void submit_bio(struct bio *bio)
 		count_vm_events(PGPGOUT, bio_sectors(bio));
 	}
 
+	bio_set_ioprio(bio);
 	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..2dc01551e27c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,7 +40,6 @@
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
-#include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
@@ -2944,14 +2943,6 @@ static bool blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
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
@@ -2976,7 +2967,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	blk_status_t ret;
 
 	bio = blk_queue_bounce(bio, q);
-	bio_set_ioprio(bio);
 
 	if (plug) {
 		rq = rq_list_peek(&plug->cached_rq);
-- 
2.34.1


