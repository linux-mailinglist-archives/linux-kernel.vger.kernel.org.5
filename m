Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558BC755FD4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjGQJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjGQJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:51:16 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD051A3;
        Mon, 17 Jul 2023 02:51:15 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-78360b822abso171917839f.2;
        Mon, 17 Jul 2023 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689587474; x=1692179474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcwB+50WnrsP8py0GmyCczQm2hmYLGk+1hGHK9Qssd8=;
        b=H2COhlx61z8Ns4BSCqx04DRIvFD+dsah8oj7ScwfTlakaVfK/hmNgyBgCiEZV9wn49
         lZnRqqSMNGzqDHsfko26Tvdcjvyv5rnEfk1DNATnd1BSJBNRMonWacSi7kVjl0RESo1u
         K2vJPh3Asy9Iwt2WYiYU6J5/xjDKA9SIkdkFtNAcGPn6mO6yZZYyINZRVUXyq+iOjAJn
         k+T4GCyqwrVEix9sUBEblydFtWxmzvWWNa2/qj8XIVisN1vP8fOjGM1ERjz55eIobWtS
         7JZC6SAieh+l+26E9qWgi9cRFu1ERmFGu4dU7jaNzjMO4wbyRajs1wdvfPoszrnCwNU7
         Y6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689587474; x=1692179474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcwB+50WnrsP8py0GmyCczQm2hmYLGk+1hGHK9Qssd8=;
        b=a3mO0B4Wn+vnKGHMK7gegs8gZv9JxwZTqKjG2TgRnq9s+Ly2krP7fs3X2sQMbV7EXy
         Mbn2nkdN8+D01g0DA9zbNUGETdrmtJhGsQUibt28oGWssZ8/BI4hbkhwOzuAsjw1Mqx/
         Lwvb4fZVnmE0JO2BFCI+37vYVuVbpCpJt4alKZROP+lYcRzCGWwmEOb+W/pNuBjkKjKx
         ArVVeATpsy0rtpFqwtZKtObszKywIVTt3QzfuRTcR+4eh9MjBE6hgSwo+urMYC/pXJ5K
         +ItYMvI+ufnSC4UB1YC/hOL25RyTGw0slclEufeLzC8IBuC9exMLoEkx5A5VzYJEycnt
         Oj5w==
X-Gm-Message-State: ABy/qLZE5MA4F658/caXPoDelUUfZKfOFzNzhCLgpeBCSitrtzuLRN8a
        IT5MntGgbajeE6X1FTKcjea7nTQmnj4yxg==
X-Google-Smtp-Source: APBJJlFdf/+zUrmvf62IEu/h0Ce8005lr+fBlUd78kDZAW2R9nniW9R9S7bI2n8dcGtTrzCuxGWMQQ==
X-Received: by 2002:a5e:aa14:0:b0:786:4795:30c9 with SMTP id s20-20020a5eaa14000000b00786479530c9mr10485510ioe.20.1689587474435;
        Mon, 17 Jul 2023 02:51:14 -0700 (PDT)
Received: from JammyHuang-PC.aspeed.com ([118.99.208.177])
        by smtp.gmail.com with ESMTPSA id g11-20020a02b70b000000b0042b3ff53458sm4376819jam.169.2023.07.17.02.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 02:51:14 -0700 (PDT)
From:   Jammy Huang <orbit.huang@gmail.com>
X-Google-Original-From: Jammy Huang <jammy_huang@aspeedtech.com>
To:     eajames@linux.ibm.com, mchehab@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, linux-media@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Jammy Huang <jammy_huang@aspeedtech.com>
Subject: [PATCH v2] media: aspeed: Fix memory overwrite if timing is 1600x900
Date:   Mon, 17 Jul 2023 17:51:11 +0800
Message-Id: <20230717095111.1957-1-jammy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When capturing 1600x900, system could crash when system memory usage is
tight.

The way to reproduce this issue:
1. Use 1600x900 to display on host
2. Mount ISO through 'Virtual media' on OpenBMC's web
3. Run script as below on host to do sha continuously
  #!/bin/bash
  while [ [1] ];
  do
	find /media -type f -printf '"%h/%f"\n' | xargs sha256sum
  done
4. Open KVM on OpenBMC's web

The size of macro block captured is 8x8. Therefore, we should make sure
the height of src-buf is 8 aligned to fix this issue.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 v2 changes
  - Add how to reproduce this issue.
---
 drivers/media/platform/aspeed/aspeed-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 374eb7781936..14594f55a77f 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1130,7 +1130,7 @@ static void aspeed_video_get_resolution(struct aspeed_video *video)
 static void aspeed_video_set_resolution(struct aspeed_video *video)
 {
 	struct v4l2_bt_timings *act = &video->active_timings;
-	unsigned int size = act->width * act->height;
+	unsigned int size = act->width * ALIGN(act->height, 8);
 
 	/* Set capture/compression frame sizes */
 	aspeed_video_calc_compressed_size(video, size);
@@ -1147,7 +1147,7 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
 		u32 width = ALIGN(act->width, 64);
 
 		aspeed_video_write(video, VE_CAP_WINDOW, width << 16 | act->height);
-		size = width * act->height;
+		size = width * ALIGN(act->height, 8);
 	} else {
 		aspeed_video_write(video, VE_CAP_WINDOW,
 				   act->width << 16 | act->height);

base-commit: 2605e80d3438c77190f55b821c6575048c68268e
-- 
2.25.1

