Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5530B780E76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbjHRPAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377915AbjHRO7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:59:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53749CD;
        Fri, 18 Aug 2023 07:59:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bdf4752c3cso7357245ad.2;
        Fri, 18 Aug 2023 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692370785; x=1692975585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3cLEemZTaWpxY5Ud6JppKDD+KRnvXP8a0Q/gju7PB0=;
        b=ouDnn0AyYsSTb5kwn1zqGecGxkqk76B7ZzCQf8wDD7IUFCttgUZqkcKemEy506eST+
         9gOte6+cVVktahqA9lcFLWCzZD7ZFm8HUKEhcyizBfwzbWAmJjhdtE3++Ukp+eaksvK9
         a415y8s+AVZ7PO7J/fBQM2D2Ldtxbst0sbFRf8oL3PwcUgeWSlZAt7hbVFRBsdYNts0E
         iAD2yBLViw/8SzdbXwjngQYLu3mBX3DJNJKZKcLckQl8o/+36+gvbq1pFU6YZHDUg7XK
         7Bc3sYe2yb2WyEdx2EHrhIxYBsRiL1TFStghefTBqyGr543gEa/0Yo2ungfOcEpqcIpD
         TKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692370785; x=1692975585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3cLEemZTaWpxY5Ud6JppKDD+KRnvXP8a0Q/gju7PB0=;
        b=hIrQ7FQE0jVtZe2zurcKIsvvQC3r2darroy4Y/q6+sEpkUL3l180VuTAUiFR197qoi
         EeDCVlVDg9Cw9rzNeK+QxO6/wP+g1NOgoGyOW5aKmeXXfPKF2fl/NrLR24b4YosOQbCB
         1JQ+LcO4zECLqazS5hNLgH2d6C+SUB+6dpMoiQZQn/PuXKBcaoKiEQhXQjbWlQYJZ4oX
         4S3GEg5TpD3H/68nIkdQTP5QbU7VP4V2gTRCAqopt1BUJ9z6ekDRXE+wJ9W0pG+SCefu
         3/uXo+uQHWK8W2d7/E85oSdxPJBO9Be86GWUCn6NroE3yBY4oL0P/1q2zRDY4G9k4EeM
         pz2g==
X-Gm-Message-State: AOJu0YycnmT8zjnQbrNmHMhO3LZW2OrYZwxfQhlowdWxP3439BSbNtDR
        VCZoqxJObfws2sG43G5ATZY=
X-Google-Smtp-Source: AGHT+IEx4dcYnmGUbiTQEAo39DjvTIO3+KAAitSZwJ3e8/xFi3fvDLd9aL7Rz1QuxXkeWG44aHO8Sg==
X-Received: by 2002:a17:902:bd45:b0:1be:e851:c070 with SMTP id b5-20020a170902bd4500b001bee851c070mr2236300plx.22.1692370784595;
        Fri, 18 Aug 2023 07:59:44 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001b8013ed362sm1874349plk.96.2023.08.18.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 07:59:43 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] dma-buf/sw_sync: Avoid recursive lock during fence signal
Date:   Fri, 18 Aug 2023 07:59:38 -0700
Message-ID: <20230818145939.39697-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

If a signal callback releases the sw_sync fence, that will trigger a
deadlock as the timeline_fence_release recurses onto the fence->lock
(used both for signaling and the the timeline tree).

To avoid that, temporarily hold an extra reference to the signalled
fences until after we drop the lock.

(This is an alternative implementation of https://patchwork.kernel.org/patch/11664717/
which avoids some potential UAF issues with the original patch.)

v2: Remove now obsolete comment, use list_move_tail() and
    list_del_init()

Reported-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Fixes: d3c6dd1fb30d ("dma-buf/sw_sync: Synchronize signal vs syncpt free")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/dma-buf/sw_sync.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
index 63f0aeb66db6..f0a35277fd84 100644
--- a/drivers/dma-buf/sw_sync.c
+++ b/drivers/dma-buf/sw_sync.c
@@ -191,6 +191,7 @@ static const struct dma_fence_ops timeline_fence_ops = {
  */
 static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 {
+	LIST_HEAD(signalled);
 	struct sync_pt *pt, *next;
 
 	trace_sync_timeline(obj);
@@ -203,21 +204,20 @@ static void sync_timeline_signal(struct sync_timeline *obj, unsigned int inc)
 		if (!timeline_fence_signaled(&pt->base))
 			break;
 
-		list_del_init(&pt->link);
+		dma_fence_get(&pt->base);
+
+		list_move_tail(&pt->link, &signalled);
 		rb_erase(&pt->node, &obj->pt_tree);
 
-		/*
-		 * A signal callback may release the last reference to this
-		 * fence, causing it to be freed. That operation has to be
-		 * last to avoid a use after free inside this loop, and must
-		 * be after we remove the fence from the timeline in order to
-		 * prevent deadlocking on timeline->lock inside
-		 * timeline_fence_release().
-		 */
 		dma_fence_signal_locked(&pt->base);
 	}
 
 	spin_unlock_irq(&obj->lock);
+
+	list_for_each_entry_safe(pt, next, &signalled, link) {
+		list_del_init(&pt->link);
+		dma_fence_put(&pt->base);
+	}
 }
 
 /**
-- 
2.41.0

