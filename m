Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACF97B0ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjI0Qze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjI0Qzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:55:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75391
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:55:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c60778a3bfso73454315ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695833730; x=1696438530; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4l9UDvCbv8erE71IF5bB14OddV2GDc72p6otw4VVCo8=;
        b=EfRIJhO9aa7+sojALJ1siRldzm0R/BH51LRXo8aFc7Tzxmf6mPNq5DQ/2GvajhVS8v
         DPOSlPv5o3uM/n7l5OE/FLKSGpJyyCBLCoJBoGaVs+YyHG2WnL4c64f8pHPrXo8kglAj
         FKn+r1hhXFxWF41iYjVqZODqBRtlhDZvNIlM9gR+CjKQahpHqyQ7UVAVOu0JaiIsPKa6
         +u/crPQyl6pZfDhObYCElsvj/pHdG/p+iyxaZsJukhOTXFRElSJINGwUndFSCctrV5Lo
         Me9nLS3wnea+rUNhqQ3Aqb9ryi8F/lI0LVJhQ4l5IRNSaL8+c5zf1EMVnleCjHiotWqa
         xUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833730; x=1696438530;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4l9UDvCbv8erE71IF5bB14OddV2GDc72p6otw4VVCo8=;
        b=iS8loIk1KAMQtD98c1jPMl1RRQR/wTNb0dkNzize8jTdbkMU3jhICWWv6wifC+twpE
         as7hduOnJALpiGyx3KuSu58jXSyVMDuMDqqxJM7kf2Q9mdMS+RgaUvf11JEWoZ16JmwN
         DpwZYboRmDEZr7MlXTqdUiB+8j3dJLgRzOpNsV0sUlthHQx/+4yTgK2vv3DBoQxcdePU
         JZroHDgQXTO+KQUiABB9zVN1XRrCdZkljt+FxdolPqbtDatkWSIDEfvEvOISqtNJbjVD
         nrCoNaoPRh7VcqMmJ//QTDaUyWC8fYWi0fqqtdRQHYA8M8XOXmErS6Dzv8323brt52YG
         x8xQ==
X-Gm-Message-State: AOJu0YzH3/gBlYUptIqbSc5N9Pn2NvCjjlP/8COzSNgAwhZdT0JYhmOC
        PdhU/xQ7fDfMStyQ/q2o/+ti5o+ZQ2dk/g==
X-Google-Smtp-Source: AGHT+IGWIL8MNB2aNny7VvLXmLZnLXuGexINxd6mcLllIv9ZwN5xF64TeTVfNog1WEGt/rSPD7LLjA==
X-Received: by 2002:a17:902:b58c:b0:1b9:e241:ad26 with SMTP id a12-20020a170902b58c00b001b9e241ad26mr2096808pls.9.1695833730513;
        Wed, 27 Sep 2023 09:55:30 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902744a00b001c61e628e98sm6267704plt.175.2023.09.27.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 09:55:29 -0700 (PDT)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     kherbst@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, bskeggs@redhat.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] drm/nouveau/flcn/msgq: fix potential deadlock on &msgq->lock
Date:   Wed, 27 Sep 2023 16:55:17 +0000
Message-Id: <20230927165517.45066-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &msgq->lock is acquired under both irq context from
gp102_sec2_intr() and softirq context from gm20b_pmu_recv(),
thus irq should be disabled while acquiring that lock, otherwise
there would be potential deadlock.

gm20b_pmu_recv()
--> nvkm_falcon_msgq_recv()
--> nvkm_falcon_msgq_open()
--> spin_lock(&msgq->lock)
<interrupt>
   --> gp102_sec2_intr()
   --> nvkm_falcon_msgq_recv()
   --> nvkm_falcon_msgq_open()
   --> spin_lock(&msgq->lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential problem, I change to spin_lock_irq() and
spin_unlock_irq() on the lock.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c b/drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c
index 16b246fda666..5c3b43216ee8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/msgq.c
@@ -25,7 +25,7 @@
 static void
 nvkm_falcon_msgq_open(struct nvkm_falcon_msgq *msgq)
 {
-	spin_lock(&msgq->lock);
+	spin_lock_irq(&msgq->lock);
 	msgq->position = nvkm_falcon_rd32(msgq->qmgr->falcon, msgq->tail_reg);
 }
 
@@ -37,7 +37,7 @@ nvkm_falcon_msgq_close(struct nvkm_falcon_msgq *msgq, bool commit)
 	if (commit)
 		nvkm_falcon_wr32(falcon, msgq->tail_reg, msgq->position);
 
-	spin_unlock(&msgq->lock);
+	spin_unlock_irq(&msgq->lock);
 }
 
 bool
-- 
2.17.1

