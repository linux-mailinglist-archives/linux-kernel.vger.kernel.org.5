Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2EC7D14FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377949AbjJTRgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377939AbjJTRgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:36:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CC0124
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:36:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9b9aeb4962so1488123276.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697823396; x=1698428196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dvfxkLD/8r79lzQNiiWwUNyjecc96GlFwHFwp2Vnnrk=;
        b=g6qV6FY8GwIbu7Fx1w4A9VsltnvhRD7oMmiXbvgNNyD6l1OmzvDH1Sn5HMx0+/63MC
         wl75yJ5uvjyDTxC9IA3qXOoHUBTPWywO06HwVqvwVHrg/bWH9Dg1nAFl9yJQdf1y3rk/
         oxeC3BKTtzF46nvBj0Tq287QFYaWPg2oIDSrw8qTb6xGvwPude3SbohOrrgS/584Bult
         tHp6OBDlTl1T0VqzBEIDZDu65jl3K1TIkpRxYgj7F7rYwSP/AH1g7dPH7N2Rj+k7G4Zi
         jZk0QvMKXjPjQpvCkjQKBs/zQBpCR7czGNzKfB2rbinuU2gguaA1UJ8q0SdI+7h6NuN/
         BsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823396; x=1698428196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvfxkLD/8r79lzQNiiWwUNyjecc96GlFwHFwp2Vnnrk=;
        b=cR9eKCvbqY2lCqyf5sox3M3iyNiretP+tPB1QaPh0vN0O/TKSWXHR4LgkP9G5Q1oH4
         hLOdbv+ia5dGkV8AzVopbZ4KWQn8cij3jqMtWIP2I3GSFfWGqzOHd78H5erh4I1kS8rJ
         gJOMWRmw0P9xotlkA5zYjOvcsnWiTB1D/eRuYscI8V//2E1i7G73/l9dO8qtZFHX29jv
         5irh319Gq4cd+u1GRTJpDeRHtvqTCA4F87p/1m+AKVD8CDGK2rqX03eo9HKQYlBUkfO4
         C/WZXabmiNFNOMfThyDaHJVhldaovgnWUWuyBqdeokqB38A8K/rsV3Vn0JluZ9e+1xHJ
         7k8A==
X-Gm-Message-State: AOJu0Yw+F4vgVnJonBbP4ZK8RRKIbr4e02BkS5VRnBj+1NTIgidR30+J
        Xb0/vPGm98RDWfHMzzJNo0Xg4KOsJVXi
X-Google-Smtp-Source: AGHT+IGLmJ5qAg6PEoLkIr7FJC5SNvomNDguC7jAUIPnXFmTQS1WD61B25wcNwAuHnZh3QkCD8HukVO2g80G
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a5b:f03:0:b0:d9a:d233:b2a3 with SMTP id
 x3-20020a5b0f03000000b00d9ad233b2a3mr57003ybr.1.1697823396520; Fri, 20 Oct
 2023 10:36:36 -0700 (PDT)
Date:   Fri, 20 Oct 2023 10:36:25 -0700
In-Reply-To: <20231020173626.2978356-1-arakesh@google.com>
Mime-Version: 1.0
References: <20231019185319.2714000-1-arakesh@google.com> <20231020173626.2978356-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231020173626.2978356-3-arakesh@google.com>
Subject: [PATCH v7 3/4] usb: gadget: uvc: move video disable logic to its own function
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Cc:     etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.grzeschik@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors the video disable logic in uvcg_video_enable
into its own separate function 'uvcg_video_disable'.

Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v6: Introduced this patch to make the next one easier to review
v6 -> v7: Add Suggested-by

 drivers/usb/gadget/function/uvc_video.c | 37 +++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index c180866c8e34..80b8eaea2d39 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -493,13 +493,33 @@ static void uvcg_video_pump(struct work_struct *work)
 	return;
 }

+/*
+ * Disable video stream
+ */
+static int
+uvcg_video_disable(struct uvc_video *video)
+{
+	struct uvc_request *ureq;
+
+	cancel_work_sync(&video->pump);
+	uvcg_queue_cancel(&video->queue, 0);
+
+	list_for_each_entry(ureq, &video->ureqs, list) {
+		if (ureq->req)
+			usb_ep_dequeue(video->ep, ureq->req);
+	}
+
+	uvc_video_free_requests(video);
+	uvcg_queue_enable(&video->queue, 0);
+	return 0;
+}
+
 /*
  * Enable or disable the video stream.
  */
 int uvcg_video_enable(struct uvc_video *video, int enable)
 {
 	int ret;
-	struct uvc_request *ureq;

 	if (video->ep == NULL) {
 		uvcg_info(&video->uvc->func,
@@ -507,19 +527,8 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
 		return -ENODEV;
 	}

-	if (!enable) {
-		cancel_work_sync(&video->pump);
-		uvcg_queue_cancel(&video->queue, 0);
-
-		list_for_each_entry(ureq, &video->ureqs, list) {
-			if (ureq->req)
-				usb_ep_dequeue(video->ep, ureq->req);
-		}
-
-		uvc_video_free_requests(video);
-		uvcg_queue_enable(&video->queue, 0);
-		return 0;
-	}
+	if (!enable)
+		return uvcg_video_disable(video);

 	if ((ret = uvcg_queue_enable(&video->queue, 1)) < 0)
 		return ret;
--
2.42.0.758.gaed0368e0e-goog
