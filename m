Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B37FE9B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344693AbjK3H1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjK3H1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:27:15 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1337510EF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:27:21 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c8879a1570so8466871fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701329239; x=1701934039; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WLNcsSt42LaGfjZQ98cMh59wBp+UL1asBOR9zkijns=;
        b=pxJZU+83KLExIo4EmVxqCv8wdgHTuKTa7225bk6VrXC9IIu0WKgfUQ3gvAeWL1jqdj
         rFWYWksY/yTgjUTaoYhuwDosGUv1IgJQR8/+FxzDHdpDpWr3uDEVmX/7xjUSeUe0jBIG
         WPzq/STIBN81BIX6ERFOJXLFz4iIbm7NG/8kG9N2fzWNAG/jUyudqO1p9Q064ve0UJQs
         VUUODqPWM0V9kqERyQswuNGkDOHG310OLZ2kusrCQJKlmDMjCNM/U1NJBn6R+rdytAZ3
         5te/KyV4rbbgfhBAveiw+hBaBNa1fL2Faffj990MNBh8nDlocer0ikj1XG8haVdd/3GL
         Lkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701329239; x=1701934039;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WLNcsSt42LaGfjZQ98cMh59wBp+UL1asBOR9zkijns=;
        b=h5dSIY9AQ+tewh8iam9o6+sh0ryjewQSWJhF18xOanvDokYleqFCSWBwxMPrjelIqL
         qyUz+iUCIzOGrT1smnd7dvKnNOWRIjOPo9N51NBvk6KGX0qzhZWa/WaWgl0XNiXSwUHP
         j8B/aOOmS7ZVEsgbtXbv6Aw2km/ljQXy7euDU32LiJht3xHKygd/rv4SmmLQn3+xO59D
         J5r0NaLUA1J9exaXjyTOptrRMRFzqYpWQRZvQwhjmS4uvXjNZ79zoy5O77Rr7GWebdNM
         wMyZN2d3PxWAGdCOtUUyS3PaR+Uu3dM99zVDCkr2livOV6gbHgof05SxrZ7zTPClZNb5
         AFXQ==
X-Gm-Message-State: AOJu0YzeBIHdifiR3m1fA+CU/L/YVzhjABUCoc/GblK416q6jXTAMu6R
        D/YLBeRMyaqIl6W/swr1UNo3AQ==
X-Google-Smtp-Source: AGHT+IHAz8JwF2cwklTl4K6IgQx7ErykCE5QzPE31FEM/rixp/mIlIv5wVKVj+dAewFSOm0L2zbr/g==
X-Received: by 2002:a2e:8606:0:b0:2c9:af18:2e8c with SMTP id a6-20020a2e8606000000b002c9af182e8cmr5027808lji.10.1701329239279;
        Wed, 29 Nov 2023 23:27:19 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c4f8a00b004053e9276easm4564118wmq.32.2023.11.29.23.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:27:19 -0800 (PST)
Date:   Thu, 30 Nov 2023 10:27:15 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/imagination: fix off by one in pvr_vm_mips_init() error
 handling
Message-ID: <a2d3210b-290f-4397-9c3e-efdcca94d8ac@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the call to vmap() fails the "page_nr" is one element beyond the end
of the mips_data->pt_dma_addr[] and mips_data->pt_pages[] arrays.

The way that this is traditionally written is that we clean up the
partial loop iteration before the goto and then we can say
while (--i >= 0).  At that point we know that all the elements thus
far are initialized so we don't need to have NULL checks.

Fixes: 927f3e0253c1 ("drm/imagination: Implement MIPS firmware processor and MMU support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/imagination/pvr_vm_mips.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm_mips.c b/drivers/gpu/drm/imagination/pvr_vm_mips.c
index 7268cf6e630b..2bc7181a4c3e 100644
--- a/drivers/gpu/drm/imagination/pvr_vm_mips.c
+++ b/drivers/gpu/drm/imagination/pvr_vm_mips.c
@@ -57,6 +57,7 @@ pvr_vm_mips_init(struct pvr_device *pvr_dev)
 							       PAGE_SIZE, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, mips_data->pt_dma_addr[page_nr])) {
 			err = -ENOMEM;
+			__free_page(mips_data->pt_pages[page_nr]);
 			goto err_free_pages;
 		}
 	}
@@ -79,13 +80,11 @@ pvr_vm_mips_init(struct pvr_device *pvr_dev)
 	return 0;
 
 err_free_pages:
-	for (; page_nr >= 0; page_nr--) {
-		if (mips_data->pt_dma_addr[page_nr])
-			dma_unmap_page(from_pvr_device(pvr_dev)->dev,
-				       mips_data->pt_dma_addr[page_nr], PAGE_SIZE, DMA_TO_DEVICE);
+	while (--page_nr >= 0) {
+		dma_unmap_page(from_pvr_device(pvr_dev)->dev,
+			       mips_data->pt_dma_addr[page_nr], PAGE_SIZE, DMA_TO_DEVICE);
 
-		if (mips_data->pt_pages[page_nr])
-			__free_page(mips_data->pt_pages[page_nr]);
+		__free_page(mips_data->pt_pages[page_nr]);
 	}
 
 	return err;
-- 
2.42.0

