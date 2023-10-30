Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C0B7DC120
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJ3UWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjJ3UWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:22:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBB6109
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:22:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da307fb7752so1931221276.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698697362; x=1699302162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ObSidP8JTCZls9mTLBjvE7k31kuLSrW0wzxXXc7FEEI=;
        b=zQcl83m0FC2L6KsVk+LJoeCOOH38nj3xIEh0Vvb8feJl2mG8AyGai9LqX2RyTweo4K
         m9sgzHuRR3BQ6ZhiKO/VFP4AYbxcEtUxVJBMyKsDOxhPtuIdxOBV9n+kOW7cqF1r+nLg
         h98s4N4dLmmbpczrd4e89+uMbx69OKXpOsHs0pl+K+S9VS63tuFYKZ829kH+vPTzrvvw
         54DkvsjpW7pQg2gqnUoD9WB5faYhJkNS0tARdK9hEruhzIHLWzBmnsFuLdFcJH2rDYyI
         Ns4VTnQ/iGALyLNmbTMwVkD+mJQxZD4kuIKpmfSx3qszrYWHpJjw50GVrOZhEzCySsW5
         DETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697362; x=1699302162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObSidP8JTCZls9mTLBjvE7k31kuLSrW0wzxXXc7FEEI=;
        b=beWfiPqrRs7UmCV7yOTWLLE+YTR9s3VrY/Uw07yyfk1SGCIRxUK1vLUyIlASXIC7X5
         p2pq1THgOvzOdid8M7s8yU0d/OqQLKdJ0U01vX1VC+Xd6kzNFj6ydi5mY9HgLKpeWaJ7
         9ql7H0sAwtRiujhiPQT9ntYHc1Sf6WfR1yVDb4PKtr+dfNB6iyWMm7WOqHkdA4Fz7eLu
         /AIgqVmyXapfi90BSTRIn5+D9P8ZwxuWBlYC9/WkVLHk6nxxZfynyWn7A536IC3QLjtT
         ALxD0m0bsyEf/cgFlTwQMfegIa78R8OcMTbgHr3tKAHrRuf/RepM29fVN4Lkwqe1hPRk
         zYIA==
X-Gm-Message-State: AOJu0Yy3SiiPiaPHv4K4CFpDR7ngEOR0K0KzGiRkb0SXTLPX5vgTuOaN
        /tL0R/fuTm1qaeKQ6UJUuscF3BQ3Dewy
X-Google-Smtp-Source: AGHT+IGXaBGhYiUyEBAbiUTE/wKmbOQwP9DauDj3LKX2kH18wQf6KMCbKcLl28XaVwWzoVCF4g181quPk6So
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a25:cf09:0:b0:d90:e642:d9fc with SMTP id
 f9-20020a25cf09000000b00d90e642d9fcmr208026ybg.6.1698697361861; Mon, 30 Oct
 2023 13:22:41 -0700 (PDT)
Date:   Mon, 30 Oct 2023 13:22:30 -0700
In-Reply-To: <20231030202231.3263253-1-arakesh@google.com>
Mime-Version: 1.0
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com> <20231030202231.3263253-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231030202231.3263253-3-arakesh@google.com>
Subject: [PATCH v10 3/4] usb: gadget: uvc: move video disable logic to its own function
From:   Avichal Rakesh <arakesh@google.com>
To:     arakesh@google.com, dan.scally@ideasonboard.com
Cc:     etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors the video disable logic in uvcg_video_enable
into its own separate function 'uvcg_video_disable'. This function
is now used anywhere uvcg_video_enable(video, 0) was used.

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v6       : Introduced this patch to make the next one easier to review
v6 -> v7 : Add Suggested-by
v7 -> v8 : No change. Getting back in review queue
v8 -> v9 : Call uvcg_video_disable directly instead of uvcg_video_enable(video, 0)
v9 -> v10: Rebase to ToT (usb-next)

 drivers/usb/gadget/function/uvc_v4l2.c  |  6 ++--
 drivers/usb/gadget/function/uvc_video.c | 40 ++++++++++++++++---------
 drivers/usb/gadget/function/uvc_video.h |  3 +-
 3 files changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 7cb8d027ff0c..904dd283cbf7 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -443,7 +443,7 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 		return -EINVAL;

 	/* Enable UVC video. */
-	ret = uvcg_video_enable(video, 1);
+	ret = uvcg_video_enable(video);
 	if (ret < 0)
 		return ret;

@@ -469,7 +469,7 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 		return -EINVAL;

 	uvc->state = UVC_STATE_CONNECTED;
-	ret = uvcg_video_enable(video, 0);
+	ret = uvcg_video_disable(video);
 	if (ret < 0)
 		return ret;

@@ -515,7 +515,7 @@ static void uvc_v4l2_disable(struct uvc_device *uvc)
 	if (uvc->state == UVC_STATE_STREAMING)
 		uvc->state = UVC_STATE_CONNECTED;

-	uvcg_video_enable(&uvc->video, 0);
+	uvcg_video_disable(&uvc->video);
 	uvcg_free_buffers(&uvc->video.queue);
 	uvc->func_connected = false;
 	wake_up_interruptible(&uvc->func_connected_queue);
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 1619f9664748..c3e8c48f46a9 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -493,31 +493,43 @@ static void uvcg_video_pump(struct work_struct *work)
 }

 /*
- * Enable or disable the video stream.
+ * Disable the video stream
  */
-int uvcg_video_enable(struct uvc_video *video, int enable)
+int
+uvcg_video_disable(struct uvc_video *video)
 {
-	int ret;
 	struct uvc_request *ureq;

 	if (video->ep == NULL) {
 		uvcg_info(&video->uvc->func,
-			  "Video enable failed, device is uninitialized.\n");
+			  "Video disable failed, device is uninitialized.\n");
 		return -ENODEV;
 	}

-	if (!enable) {
-		cancel_work_sync(&video->pump);
-		uvcg_queue_cancel(&video->queue, 0);
+	cancel_work_sync(&video->pump);
+	uvcg_queue_cancel(&video->queue, 0);

-		list_for_each_entry(ureq, &video->ureqs, list) {
-			if (ureq->req)
-				usb_ep_dequeue(video->ep, ureq->req);
-		}
+	list_for_each_entry(ureq, &video->ureqs, list) {
+		if (ureq->req)
+			usb_ep_dequeue(video->ep, ureq->req);
+	}

-		uvc_video_free_requests(video);
-		uvcg_queue_enable(&video->queue, 0);
-		return 0;
+	uvc_video_free_requests(video);
+	uvcg_queue_enable(&video->queue, 0);
+	return 0;
+}
+
+/*
+ * Enable the video stream.
+ */
+int uvcg_video_enable(struct uvc_video *video)
+{
+	int ret;
+
+	if (video->ep == NULL) {
+		uvcg_info(&video->uvc->func,
+			  "Video enable failed, device is uninitialized.\n");
+		return -ENODEV;
 	}

 	if ((ret = uvcg_queue_enable(&video->queue, 1)) < 0)
diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/function/uvc_video.h
index 03adeefa343b..8ef6259741f1 100644
--- a/drivers/usb/gadget/function/uvc_video.h
+++ b/drivers/usb/gadget/function/uvc_video.h
@@ -14,7 +14,8 @@

 struct uvc_video;

-int uvcg_video_enable(struct uvc_video *video, int enable);
+int uvcg_video_enable(struct uvc_video *video);
+int uvcg_video_disable(struct uvc_video *video);

 int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc);

--
2.42.0.820.g83a721a137-goog
