Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050B077C14D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjHNUIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjHNUI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:08:28 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6E7E7E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:08:26 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b9c9944da8so4119237a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692043706; x=1692648506;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TgiPA+i67nUUA0+3agLGa5vPvztFGOlraYjNpF78eF8=;
        b=CLlxZA6ILiMQ+IEU2O8tzzPf4eKGfyUYC7GBQU30hfMmUpAPU/XOXKGSCVkoCGlK86
         Ho47OXq/ioCGXF57HmvsP2rf73x7fB79/+Ck0NMQjcq8gyu/9tObhXN9L/pyRTqTfw8T
         0JjznQp/4P+o1k8rRNowiJnn7/UWR3qdQiE4wYdzQIVt6ip95IgHQcZwUGSVgAJ0ngH+
         8Avk3Wsya+pnfCvRbBiZpIMMZGe5DVw3ifx29FhBT741o/pzcNDABCcHAMtMvqm2Ib3X
         xCgg7veJ5U2gU9zU7UE6qaLQSGOi9SvzY/eJFe9M4FIOlI0lRP14e/Rv7OIcFIEUzLOo
         iIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043706; x=1692648506;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgiPA+i67nUUA0+3agLGa5vPvztFGOlraYjNpF78eF8=;
        b=Czn1h8y4QgalJ9iznQ6NQ8szZejzgjVxa1L0naBreh2jzTz81nkETQrLTLWw/lHQfr
         3x45ch8oANt6Gzschy/mIc2M0UAkPfSaC3ltcApNYLfb1AcBo0X1gu3JpUp0wTT8qnIS
         vgEw8eqbrRH47RdGGyoHvY8ga/TPmZJL85QnO62B2CNGOsGjV/EYGjkDxfUmbj0BvsRY
         2vKwWQ8VXzDE8KW2/FHsX3ziNzVWUsJMWXMnwR/jL9E17v0HRlhg4Q/iGBlgn31iFalt
         F+XSbmxknhaczFWm+EImZwQWLUhGEfhyN0Nd2AICT0es5tqSQTLp48h/9UifGwyoMWMw
         HVmA==
X-Gm-Message-State: AOJu0Yzv35TSaT+Hld82OF5yBns/nD/+UA6FFQjAWB9bKeb0qZAvpsRA
        rhfAppueOaw5jnsSZBTmdqbWXQJRXYA=
X-Google-Smtp-Source: AGHT+IH4kvNNv55L3m+GtAEetFriGcQyEDgRkaH/qYyq+UQojDO+vQt05Zs3biI9Ies10jcUo9UFhw==
X-Received: by 2002:a05:6870:5887:b0:1bf:7cdc:df0 with SMTP id be7-20020a056870588700b001bf7cdc0df0mr10125283oab.35.1692043706095;
        Mon, 14 Aug 2023 13:08:26 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id c5-20020a056830000500b006b94904baf5sm4587959otp.74.2023.08.14.13.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:08:25 -0700 (PDT)
Date:   Mon, 14 Aug 2023 17:08:19 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: vme_user: fix check unnecessary parentheses
Message-ID: <ZNqJs126kA+KvSTC@alolivei-thinkpadt480s.gru.csb>
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

Fixed all CHECK: Unnecessary parentheses around
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index c7c50406c199..6f08bb21369d 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -307,7 +307,7 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
 		mutex_lock(&slave_image->mtx);
 		if (((slave_image->address_attr & address) == address) &&
 		    ((slave_image->cycle_attr & cycle) == cycle) &&
-		    (slave_image->locked == 0)) {
+		    slave_image->locked == 0) {
 			slave_image->locked = 1;
 			mutex_unlock(&slave_image->mtx);
 			allocated_image = slave_image;
@@ -508,7 +508,7 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
 		if (((master_image->address_attr & address) == address) &&
 		    ((master_image->cycle_attr & cycle) == cycle) &&
 		    ((master_image->width_attr & dwidth) == dwidth) &&
-		    (master_image->locked == 0)) {
+		    master_image->locked == 0) {
 			master_image->locked = 1;
 			spin_unlock(&master_image->lock);
 			allocated_image = master_image;
@@ -882,7 +882,7 @@ struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route)
 		/* Find an unlocked and compatible controller */
 		mutex_lock(&dma_ctrlr->mtx);
 		if (((dma_ctrlr->route_attr & route) == route) &&
-		    (dma_ctrlr->locked == 0)) {
+		    dma_ctrlr->locked == 0) {
 			dma_ctrlr->locked = 1;
 			mutex_unlock(&dma_ctrlr->mtx);
 			allocated_ctrlr = dma_ctrlr;
@@ -1248,9 +1248,9 @@ void vme_bus_error_handler(struct vme_bridge *bridge,
 	list_for_each(handler_pos, &bridge->vme_error_handlers) {
 		handler = list_entry(handler_pos, struct vme_error_handler,
 				     list);
-		if ((aspace == handler->aspace) &&
-		    (address >= handler->start) &&
-		    (address < handler->end)) {
+		if (aspace == handler->aspace &&
+		    address >= handler->start &&
+		    address < handler->end) {
 			if (!handler->num_errors)
 				handler->first_error = address;
 			if (handler->num_errors != UINT_MAX)
@@ -1337,7 +1337,7 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
 		return -EINVAL;
 	}
 
-	if ((level < 1) || (level > 7)) {
+	if (level < 1 || level > 7) {
 		printk(KERN_ERR "Invalid interrupt level\n");
 		return -EINVAL;
 	}
@@ -1386,7 +1386,7 @@ void vme_irq_free(struct vme_dev *vdev, int level, int statid)
 		return;
 	}
 
-	if ((level < 1) || (level > 7)) {
+	if (level < 1 || level > 7) {
 		printk(KERN_ERR "Invalid interrupt level\n");
 		return;
 	}
@@ -1433,7 +1433,7 @@ int vme_irq_generate(struct vme_dev *vdev, int level, int statid)
 		return -EINVAL;
 	}
 
-	if ((level < 1) || (level > 7)) {
+	if (level < 1 || level > 7) {
 		printk(KERN_WARNING "Invalid interrupt level\n");
 		return -EINVAL;
 	}
-- 
2.41.0

