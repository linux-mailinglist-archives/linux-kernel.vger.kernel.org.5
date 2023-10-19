Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56427D021F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346514AbjJSSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346428AbjJSSxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:53:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45951124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:53:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7fb3f311bso131089737b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697741612; x=1698346412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QionUCvuT3m0k3agh1AZNJhfdHG7qgHMaPeO/bL+n4o=;
        b=YJN9YgOH35FSE5qFIIYKCdF6xAHhJGAW2alUm6/yltMyH/sm5hzjTuCC6je/iLzSgc
         9vjtUF32y/4nHgsa4o2li6zWXz+Q1jUcC5iI8MijZMgatNZ+zdyPp7YswK1tZs1dbSAW
         J6bJikaRGCPGk7TSBBHrHPFggM0HnHlnMpbPLj7Oqkq4kM48MzmuAKf0gFU+dQE9yIcx
         LbGLa/XZCCXwQ2PP0sLl6RcQvPy4iuiqJI005zuS56kN6UTqUFOstz7Tzuh/tqW3lEDa
         a9+Axwp1YP3t+NIZCQ3VFAciN0FkCa73n8Cq5701eQRrVvMJD92UWNvxhtWPLxH0lpHz
         4NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697741612; x=1698346412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QionUCvuT3m0k3agh1AZNJhfdHG7qgHMaPeO/bL+n4o=;
        b=P1xoy3lfWm5JrEICYkaMN+byZF9kxrf9K9476YDndZQzRw66kvp8SuSjwiJrJzLW+K
         ItcMn01TPA2LRlGd9Qb+uLIuLREaekwRK3apBeGXQ4mXZXVdhFUooWZO9EOgpj2BZXZ0
         dkrVAm7aBEyPM10HNXDHZ7jHklE2EwRnXNCCWJNiyFPvJ0je8LPrg2tUs3uaBxVx5ZSj
         7LlOlJMI7c0zOYswjLwQIDiI669kFr3HtbF1U5I0uE+d/2dfFeCp/hFY5ngjVKOLg/5r
         g8RjsBCwy4BHPBep7VvjuJxhgnAh4bQ0qEiqJMzDorqRNPpX4PTqasUr6BLuZeKbCBWc
         72Jg==
X-Gm-Message-State: AOJu0Ywjv8kWqsB9c8wFnsU6EE93VIM6vGhypzP2Vn9y3Kc8eEmtFl0z
        BC3DZIE30zqkBDIs1VXoCVgO9YsHTJuW
X-Google-Smtp-Source: AGHT+IEk97ye1XaX5Un4njRJ74jhPtt4z3P97XlgQktDFvpYiWSjbv6fhaikcH7jj0ZjZwKPkeI1P2Mhv06A
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a25:e7c2:0:b0:d9c:a59b:203c with SMTP id
 e185-20020a25e7c2000000b00d9ca59b203cmr65805ybh.4.1697741612510; Thu, 19 Oct
 2023 11:53:32 -0700 (PDT)
Date:   Thu, 19 Oct 2023 11:53:18 -0700
In-Reply-To: <20231019185319.2714000-1-arakesh@google.com>
Mime-Version: 1.0
References: <20230930184821.310143-1-arakesh@google.com> <20231019185319.2714000-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231019185319.2714000-4-arakesh@google.com>
Subject: [PATCH v6 3/4] usb: gadget: uvc: move video disable logic to its own function
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors the video disable logic in uvcg_video_enable
into its own separate function 'uvcg_video_disable'.

Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v6: Introduced this patch to make the next one easier to review

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
