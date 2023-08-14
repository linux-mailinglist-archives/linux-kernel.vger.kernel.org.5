Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DEE77C227
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjHNVLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjHNVLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:11:01 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9544310C1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:10:58 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a76d882052so3837656b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692047458; x=1692652258;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TM97GMZQGDrpz3N3/7Cs6kHLre7psxGQ8f/O7bWlHpY=;
        b=RQEQj2sqTzdWi5T1dH0fXULOAszAWJH7CGh/uduVeOkqIbGJ3IJA5jCYb2cMZa/Qdi
         BBToEZd0mPEEZ2GWcjc3SQwgQMDSd4goFzHhDDfaMcdCb2V0qNjhm+UhcdsBrf5G/wGt
         lRf1Ym4NlSZgEk9WLl4eYdjQJaPnU4eY2v4tUtxE+WyJKHlaxVNE2QNeYAoeWoAJgAUJ
         QbvumZVIE1ufe1Vr0Xjs693cjPiVqxjInCIrz70bAwYBvxn8xEJgY1FjRW6OoHgCeFvm
         2egxgDjUQTSQl4ZWK0s1rpirrd1Rjk0PLwLm2oK5K1WJXC2QF2vMhNtaV8Eq2lzwpXjQ
         zsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692047458; x=1692652258;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TM97GMZQGDrpz3N3/7Cs6kHLre7psxGQ8f/O7bWlHpY=;
        b=Nm3QqdTh5mqdw2lQPFUatSfLREY7+6PvqzFsCMbWWI/L2y2zaTKIx6XISEauV25Av+
         rN3XMq4TSw8PhwCW7uG2OTfx/v9su2n/wQaANhtpgypi58PiykBUrcJgyS1TUzumsZtH
         u86+mTDyIKiAQWXjamrXlKxwB/xELmv+48Z/actSCYe1ADZbIthUp1Ba1W6bVhBPeDJp
         gtu5WWBMCU/10b5Xcdj08of07Yd9caJVSbG0BvmWuLsybZ3GUUQ6VTXbN3GWzlLxGrK1
         2d5jJBCbWQr+g3ejqhbyRdkBz0ztqzK1/P0ye/2i9NZBSZCNK6GAIRr37B5OsG8P9diR
         mRTQ==
X-Gm-Message-State: AOJu0YzOPnL+C/EVD9qBzpy8uYKLQ8I+hLXVppd+B9u69w058SaynLH9
        G4li2bU+ElJdxKNKgGh5kj4=
X-Google-Smtp-Source: AGHT+IFqeOMx2lDqPMVG9GEKOKxnznHE+rGjm5BCm1tJ7izi8rAmDnnINDGBvXM3/lsSFZCSdKpwJw==
X-Received: by 2002:a05:6808:2114:b0:3a7:3ab9:e589 with SMTP id r20-20020a056808211400b003a73ab9e589mr11654420oiw.35.1692047457939;
        Mon, 14 Aug 2023 14:10:57 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id x22-20020a056808145600b003a3bf96e055sm4894754oiv.8.2023.08.14.14.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:10:57 -0700 (PDT)
Date:   Mon, 14 Aug 2023 18:10:52 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: vme_user: fix check blank lines not necessary
Message-ID: <ZNqYXAe/wIRl8qEe@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all CHECK: Blank lines aren't necessary after an open brace '{'
and CHECK: Blank lines aren't necessary before a close brace '}'
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---

Changes in v2:
- Re-added previously removed line not reported by checkpatch,
noted by Greg KH

 drivers/staging/vme_user/vme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5eb0d780c77f..bbf82b1be9f1 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -308,7 +308,6 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
 		if (((slave_image->address_attr & address) == address) &&
 		    ((slave_image->cycle_attr & cycle) == cycle) &&
 		    (slave_image->locked == 0)) {
-
 			slave_image->locked = 1;
 			mutex_unlock(&slave_image->mtx);
 			allocated_image = slave_image;
@@ -510,7 +509,6 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
 		    ((master_image->cycle_attr & cycle) == cycle) &&
 		    ((master_image->width_attr & dwidth) == dwidth) &&
 		    (master_image->locked == 0)) {
-
 			master_image->locked = 1;
 			spin_unlock(&master_image->lock);
 			allocated_image = master_image;
@@ -682,7 +680,6 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
 		count = length - offset;
 
 	return bridge->master_read(image, buf, count, offset);
-
 }
 EXPORT_SYMBOL(vme_master_read);
 
@@ -887,7 +884,6 @@ struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route)
 		mutex_lock(&dma_ctrlr->mtx);
 		if (((dma_ctrlr->route_attr & route) == route) &&
 		    (dma_ctrlr->locked == 0)) {
-
 			dma_ctrlr->locked = 1;
 			mutex_unlock(&dma_ctrlr->mtx);
 			allocated_ctrlr = dma_ctrlr;
-- 
2.41.0

