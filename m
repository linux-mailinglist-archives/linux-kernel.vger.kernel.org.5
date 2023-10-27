Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3871E7DA1AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbjJ0UUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0UUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:20:11 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07431B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:20:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b02ed0f886so4738947b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698438008; x=1699042808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhqTHx+LqMazygh0ctOMGj9jIaaBIvzmi3aKCCPNWqo=;
        b=a7f7UG4/QLHhQ5SM3b7M3pXPz6rjvtzDxYhyYdd3XU9VCVUkdt86vH2ttiiOx6M0d7
         Ebyydw+xJt+JSUpNNR5qjVrnAYG5Ns7BJ+XILNuk/uLZVjqKvC28AszIDrKC9IUpSyJ9
         dgYEvg7g/InSb6bh6PTr5Df0zY40uwmeEpA8KV33qkrn0HJZIaRVlDSsnj+MseEDXmSB
         6LYK4bIZAcFD9dei0bfxoSPVTEE+zT1ZG0Hjm/xowr2h8XTVm6oizmgaElg7/hLchEX0
         kdAzuNBdXVEDpPp1Un26mxjTMS7b7Mkh0kf3A/z0TuDyRGjsVw4Tq+nuEmif66t/O7b7
         YbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698438008; x=1699042808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhqTHx+LqMazygh0ctOMGj9jIaaBIvzmi3aKCCPNWqo=;
        b=JXG47E4+DrCCHDqbvCxhpM6Yx38YSuWzZa8Gvp8h9e+my2nCoStfyuWb2vygT/Gi7Q
         AS86BVyoJXk3+uPA1NfW3798ulr8GMod/DE7REVpQaEmQo5VNXgLDdoJctSWwYLNAAC+
         ao6FywoWxEKyf+C0m2rn9wewUdVj9j/C10dR1KbJi4xiL9atYexSoZgEiSjB0a+MwqgY
         tDnv/7Mg5ILDEDnwc8oVZW7FZMz/sSygVR+2ChP4u1Fv7NcPnMMAoPnfrHs9aGTl9TeC
         4JNxasJt+N99gqFUNf8q0xQo5+bbG+DgfoAMtGkU7BJI0R0YMkaFcMHwfV4fpD1GLv+Q
         /nDw==
X-Gm-Message-State: AOJu0YzLYoGX6USiysEcK0jR0AI8aW8r2HdSl5Dih3j5wex2Z83JfO7h
        A/ggK3ZtFesHxsCrNPf4UWjipkUkLMkJ
X-Google-Smtp-Source: AGHT+IE25UfC9X5rLRJ9cwifey42umt75WSobwNeijQGQrlpujeBb9axSO/GNLsMTA6QHdrICiFFIECeT2j0
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a0d:df48:0:b0:5a7:b496:5983 with SMTP id
 i69-20020a0ddf48000000b005a7b4965983mr74286ywe.9.1698438008227; Fri, 27 Oct
 2023 13:20:08 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:19:57 -0700
In-Reply-To: <20231027201959.1869181-1-arakesh@google.com>
Mime-Version: 1.0
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com> <20231027201959.1869181-1-arakesh@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027201959.1869181-2-arakesh@google.com>
Subject: [PATCH v9 2/4] usb: gadget: uvc: Allocate uvc_requests one at a time
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

Currently, the uvc gadget driver allocates all uvc_requests as one array
and deallocates them all when the video stream stops. This includes
de-allocating all the usb_requests associated with those uvc_requests.
This can lead to use-after-free issues if any of those de-allocated
usb_requests were still owned by the usb controller.

This patch is 1 of 2 patches addressing the use-after-free issue.
Instead of bulk allocating all uvc_requests as an array, this patch
allocates uvc_requests one at a time, which should allows for similar
granularity when deallocating the uvc_requests. This patch has no
functional changes other than allocating each uvc_request separately,
and similarly freeing each of them separately.

Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.com
Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1 -> v2: Rebased to ToT
v2 -> v3: Fix email threading goof-up
v3 -> v4: Address review comments & re-rebase to ToT
v4 -> v5: Address more review comments. Add Reviewed-by & Tested-by.
v5 -> v6: No change
v6 -> v7: No change
v7 -> v8: No change. Getting back in review queue
v8 -> v9: Address review comments.

 drivers/usb/gadget/function/uvc.h       |  3 +-
 drivers/usb/gadget/function/uvc_video.c | 89 ++++++++++++++-----------
 2 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 989bc6b4e93d..993694da0bbc 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -81,6 +81,7 @@ struct uvc_request {
 	struct sg_table sgt;
 	u8 header[UVCG_REQUEST_HEADER_LEN];
 	struct uvc_buffer *last_buf;
+	struct list_head list;
 };

 struct uvc_video {
@@ -102,7 +103,7 @@ struct uvc_video {

 	/* Requests */
 	unsigned int req_size;
-	struct uvc_request *ureq;
+	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
 	struct list_head req_free;
 	spinlock_t req_lock;

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index c334802ac0a4..f8f9209fee50 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -227,6 +227,24 @@ uvc_video_encode_isoc(struct usb_request *req, struct uvc_video *video,
  * Request handling
  */

+static void
+uvc_video_free_request(struct uvc_request *ureq, struct usb_ep *ep)
+{
+	sg_free_table(&ureq->sgt);
+	if (ureq->req && ep) {
+		usb_ep_free_request(ep, ureq->req);
+		ureq->req = NULL;
+	}
+
+	kfree(ureq->req_buffer);
+	ureq->req_buffer = NULL;
+
+	if (!list_empty(&ureq->list))
+		list_del_init(&ureq->list);
+
+	kfree(ureq);
+}
+
 static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
 {
 	int ret;
@@ -293,27 +311,12 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 static int
 uvc_video_free_requests(struct uvc_video *video)
 {
-	unsigned int i;
-
-	if (video->ureq) {
-		for (i = 0; i < video->uvc_num_requests; ++i) {
-			sg_free_table(&video->ureq[i].sgt);
+	struct uvc_request *ureq, *temp;

-			if (video->ureq[i].req) {
-				usb_ep_free_request(video->ep, video->ureq[i].req);
-				video->ureq[i].req = NULL;
-			}
-
-			if (video->ureq[i].req_buffer) {
-				kfree(video->ureq[i].req_buffer);
-				video->ureq[i].req_buffer = NULL;
-			}
-		}
-
-		kfree(video->ureq);
-		video->ureq = NULL;
-	}
+	list_for_each_entry_safe(ureq, temp, &video->ureqs, list)
+		uvc_video_free_request(ureq, video->ep);

+	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	video->req_size = 0;
 	return 0;
@@ -322,39 +325,45 @@ uvc_video_free_requests(struct uvc_video *video)
 static int
 uvc_video_alloc_requests(struct uvc_video *video)
 {
+	struct uvc_request *ureq;
 	unsigned int req_size;
 	unsigned int i;
 	int ret = -ENOMEM;

 	BUG_ON(video->req_size);
+	BUG_ON(!list_empty(&video->ureqs));

 	req_size = video->ep->maxpacket
 		 * max_t(unsigned int, video->ep->maxburst, 1)
 		 * (video->ep->mult);

-	video->ureq = kcalloc(video->uvc_num_requests, sizeof(struct uvc_request), GFP_KERNEL);
-	if (video->ureq == NULL)
-		return -ENOMEM;
+	for (i = 0; i < video->uvc_num_requests; i++) {
+		ureq = kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
+		if (ureq == NULL)
+			goto error;
+
+		INIT_LIST_HEAD(&ureq->list);
+
+		list_add_tail(&ureq->list, &video->ureqs);

-	for (i = 0; i < video->uvc_num_requests; ++i) {
-		video->ureq[i].req_buffer = kmalloc(req_size, GFP_KERNEL);
-		if (video->ureq[i].req_buffer == NULL)
+		ureq->req_buffer = kmalloc(req_size, GFP_KERNEL);
+		if (ureq->req_buffer == NULL)
 			goto error;

-		video->ureq[i].req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
-		if (video->ureq[i].req == NULL)
+		ureq->req = usb_ep_alloc_request(video->ep, GFP_KERNEL);
+		if (ureq->req == NULL)
 			goto error;

-		video->ureq[i].req->buf = video->ureq[i].req_buffer;
-		video->ureq[i].req->length = 0;
-		video->ureq[i].req->complete = uvc_video_complete;
-		video->ureq[i].req->context = &video->ureq[i];
-		video->ureq[i].video = video;
-		video->ureq[i].last_buf = NULL;
+		ureq->req->buf = ureq->req_buffer;
+		ureq->req->length = 0;
+		ureq->req->complete = uvc_video_complete;
+		ureq->req->context = ureq;
+		ureq->video = video;
+		ureq->last_buf = NULL;

-		list_add_tail(&video->ureq[i].req->list, &video->req_free);
+		list_add_tail(&ureq->req->list, &video->req_free);
 		/* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
-		sg_alloc_table(&video->ureq[i].sgt,
+		sg_alloc_table(&ureq->sgt,
 			       DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
 					    PAGE_SIZE) + 2, GFP_KERNEL);
 	}
@@ -489,8 +498,8 @@ static void uvcg_video_pump(struct work_struct *work)
  */
 int uvcg_video_enable(struct uvc_video *video, int enable)
 {
-	unsigned int i;
 	int ret;
+	struct uvc_request *ureq;

 	if (video->ep == NULL) {
 		uvcg_info(&video->uvc->func,
@@ -502,9 +511,10 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
 		cancel_work_sync(&video->pump);
 		uvcg_queue_cancel(&video->queue, 0);

-		for (i = 0; i < video->uvc_num_requests; ++i)
-			if (video->ureq && video->ureq[i].req)
-				usb_ep_dequeue(video->ep, video->ureq[i].req);
+		list_for_each_entry(ureq, &video->ureqs, list) {
+			if (ureq->req)
+				usb_ep_dequeue(video->ep, ureq->req);
+		}

 		uvc_video_free_requests(video);
 		uvcg_queue_enable(&video->queue, 0);
@@ -536,6 +546,7 @@ int uvcg_video_enable(struct uvc_video *video, int enable)
  */
 int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 {
+	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
 	spin_lock_init(&video->req_lock);
 	INIT_WORK(&video->pump, uvcg_video_pump);
--
2.42.0.820.g83a721a137-goog
