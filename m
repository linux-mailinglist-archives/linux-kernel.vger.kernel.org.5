Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E7B7C4BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344828AbjJKHaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbjJKHab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:30:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636FB9;
        Wed, 11 Oct 2023 00:30:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9d407bb15so390895ad.0;
        Wed, 11 Oct 2023 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697009429; x=1697614229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=481kwyoPSHDX+4JF1QVKBTbkhSw4SWArgmqeSO/N9bg=;
        b=UHYHENiL+xJf7bciSOA3dL/eRpnZS4WwMhYKst9b+acW69GS4DVz8Mhrrfi73zArGe
         yspclcIwO3HNtFaF+/PfgFFV5lTIDPDkl9uG8T2DsKU/dPUeqXOw+JZ22FzgTVzERW9y
         avd/SQuheFvxYD0bAH/+OJQAHerjsYV8P70+XEWwDAB4EspbV8xWu2miuR/A5zwp1EDL
         6UsMuDDV7YQTWl0fESJOuBJSFoSYvBKj4zwo32yvY+glrXhbeStNU2Z6AsRwHnNjLRJI
         5GEi9ahiP8YMaOIMLbiGuEMoJDLKKYJSo83B3iMmuKIiO4cpF0SHKajhMCIkQO7PDXKv
         Rh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009429; x=1697614229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=481kwyoPSHDX+4JF1QVKBTbkhSw4SWArgmqeSO/N9bg=;
        b=hda+55eFdITvlaG6hTO5c15sbJlHV/y+lRIgFKzY088Fhujdaq/lwtPbcWOK0w0tPC
         a3wAzn5NAVguVl7KxaOcXU994EBVRDJ4MTA8S6ot96ZtZqJs7m8foI0ON2vq41PaOvU0
         ZgCdUwS41m0nRQMBeVRU8Kv7ulliRVwqofsIEIYxKNBmXG6BPBBz7Qk1xrBhw1EsQvji
         gHmpaApctx/TiOJdpHAIpm2XIDd3HIYnFm+6psm5EN/z96dMh2HH0TJPOUa98cQ3q50m
         MfrGFCpcxA2IV5WSPuRyh3adgqBC8OErCoCVLnfUU3zshOqcjbc5Vd/n/Icgh3iOhpJR
         22YA==
X-Gm-Message-State: AOJu0Yxp5siA5tCz/znW1m971tEBWtjxae6vGpl1XUQLKgvKmgov+YNj
        yzfssbIq0xtSl5HnTFW9tfE=
X-Google-Smtp-Source: AGHT+IEmMVessNgXQdctBaoEjzu3v9Hkz36qlqr9ZgEJpfbYpmyP0b6kG6ar/DJxrRBysDOssMM0ww==
X-Received: by 2002:a17:902:82c4:b0:1c6:694:1dda with SMTP id u4-20020a17090282c400b001c606941ddamr19079607plz.63.1697009428492;
        Wed, 11 Oct 2023 00:30:28 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902758600b001c61e628e9dsm1011352pll.77.2023.10.11.00.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 00:30:27 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     dan.carpenter@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v2] media: nuvoton: npcm-video: Fix sleeping in atomic context
Date:   Wed, 11 Oct 2023 15:30:03 +0800
Message-Id: <20231011073003.1637086-1-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Change to use mutex instead of spinlock for buffer list lock to fix
sleeping in atomic context warnings reported by the Smatch tool.

Fixes: 70721089985c ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 drivers/media/platform/nuvoton/npcm-video.c | 30 +++++++++------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index b9e6782f59b4..ea32d9588bb5 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -26,7 +26,6 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/sched.h>
-#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/v4l2-controls.h>
 #include <linux/videodev2.h>
@@ -120,7 +119,7 @@ struct npcm_video {
 	struct mutex video_lock; /* v4l2 and videobuf2 lock */
 
 	struct list_head buffers;
-	spinlock_t lock; /* buffer list lock */
+	struct mutex buffer_lock; /* buffer list lock */
 	unsigned long flags;
 	unsigned int sequence;
 
@@ -782,7 +781,6 @@ static int npcm_video_start_frame(struct npcm_video *video)
 {
 	struct npcm_video_buffer *buf;
 	struct regmap *vcd = video->vcd_regmap;
-	unsigned long flags;
 	unsigned int val;
 	int ret;
 
@@ -798,17 +796,17 @@ static int npcm_video_start_frame(struct npcm_video *video)
 		return -EBUSY;
 	}
 
-	spin_lock_irqsave(&video->lock, flags);
+	mutex_lock(&video->buffer_lock);
 	buf = list_first_entry_or_null(&video->buffers,
 				       struct npcm_video_buffer, link);
 	if (!buf) {
-		spin_unlock_irqrestore(&video->lock, flags);
+		mutex_unlock(&video->buffer_lock);
 		dev_dbg(video->dev, "No empty buffers; skip capture frame\n");
 		return 0;
 	}
 
 	set_bit(VIDEO_CAPTURING, &video->flags);
-	spin_unlock_irqrestore(&video->lock, flags);
+	mutex_unlock(&video->buffer_lock);
 
 	npcm_video_vcd_state_machine_reset(video);
 
@@ -834,14 +832,13 @@ static void npcm_video_bufs_done(struct npcm_video *video,
 				 enum vb2_buffer_state state)
 {
 	struct npcm_video_buffer *buf;
-	unsigned long flags;
 
-	spin_lock_irqsave(&video->lock, flags);
+	mutex_lock(&video->buffer_lock);
 	list_for_each_entry(buf, &video->buffers, link)
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
 
 	INIT_LIST_HEAD(&video->buffers);
-	spin_unlock_irqrestore(&video->lock, flags);
+	mutex_unlock(&video->buffer_lock);
 }
 
 static void npcm_video_get_diff_rect(struct npcm_video *video, unsigned int index)
@@ -1071,12 +1068,12 @@ static irqreturn_t npcm_video_irq(int irq, void *arg)
 
 	if (status & VCD_STAT_DONE) {
 		regmap_write(vcd, VCD_INTE, 0);
-		spin_lock(&video->lock);
+		mutex_lock(&video->buffer_lock);
 		clear_bit(VIDEO_CAPTURING, &video->flags);
 		buf = list_first_entry_or_null(&video->buffers,
 					       struct npcm_video_buffer, link);
 		if (!buf) {
-			spin_unlock(&video->lock);
+			mutex_unlock(&video->buffer_lock);
 			return IRQ_NONE;
 		}
 
@@ -1093,7 +1090,7 @@ static irqreturn_t npcm_video_irq(int irq, void *arg)
 			size = npcm_video_hextile(video, index, dma_addr, addr);
 			break;
 		default:
-			spin_unlock(&video->lock);
+			mutex_unlock(&video->buffer_lock);
 			return IRQ_NONE;
 		}
 
@@ -1104,7 +1101,7 @@ static irqreturn_t npcm_video_irq(int irq, void *arg)
 
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 		list_del(&buf->link);
-		spin_unlock(&video->lock);
+		mutex_unlock(&video->buffer_lock);
 
 		if (npcm_video_start_frame(video))
 			dev_err(video->dev, "Failed to capture next frame\n");
@@ -1508,13 +1505,12 @@ static void npcm_video_buf_queue(struct vb2_buffer *vb)
 	struct npcm_video *video = vb2_get_drv_priv(vb->vb2_queue);
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct npcm_video_buffer *nvb = to_npcm_video_buffer(vbuf);
-	unsigned long flags;
 	bool empty;
 
-	spin_lock_irqsave(&video->lock, flags);
+	mutex_lock(&video->buffer_lock);
 	empty = list_empty(&video->buffers);
 	list_add_tail(&nvb->link, &video->buffers);
-	spin_unlock_irqrestore(&video->lock, flags);
+	mutex_unlock(&video->buffer_lock);
 
 	if (test_bit(VIDEO_STREAMING, &video->flags) &&
 	    !test_bit(VIDEO_CAPTURING, &video->flags) && empty) {
@@ -1744,8 +1740,8 @@ static int npcm_video_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	video->dev = &pdev->dev;
-	spin_lock_init(&video->lock);
 	mutex_init(&video->video_lock);
+	mutex_init(&video->buffer_lock);
 	INIT_LIST_HEAD(&video->buffers);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
-- 
2.34.1

