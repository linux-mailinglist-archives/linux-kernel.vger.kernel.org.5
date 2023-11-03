Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE48D7E007C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbjKCHOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbjKCHOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:14:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10839186
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:14:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0c6d62ec8so2045750276.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698995646; x=1699600446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+Y4aAo8C6IbKqVz5f3X4NpALK1Dj9LZiyAbgnrCgxE=;
        b=2oHnRD6sMtlEeFJZV/+V48HSRZQVbceyd4LxeuXmOuXwL4wqYLOSfcSu15XbJKJH7f
         ufJ+pu3gIGoy8B5YbKG1E1kEwSdIdUHr4wuO0vzjexpHpxnO3ZEFRbCrrvdY5iCmTrBR
         gkgTCIYCtWNjcrzB0PaVzUe7DCaV9getmFI0DV6kEcZ/2uBV7d/GRKZuNHCx4UvTOH57
         l8euXpQ5izmLnbIGXqJKghdf5STiIMawyfZue8obMt103hGXPd2iPWPW4Qpq7zIDvKlm
         1NYoIaRDg7vav0ocRP4W2SIv2QImJ1V8do9NtwgIYoeqBhrzqIzq9R/JFvE3I++r2VFA
         JOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698995646; x=1699600446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+Y4aAo8C6IbKqVz5f3X4NpALK1Dj9LZiyAbgnrCgxE=;
        b=aAgtejtO2lrGmz6sLuQL+iDg+oB8sP/XiTuCgUHxpaoWBfxk7P0zcpHcFbFemJmwKt
         aogJ7AYoBNJejpENOuO5MoB4CpR5DNx7YAc+cXXlTCd8plokMHQvfcQ+iot055CqZM74
         IttjyymOJOUmNxpEJ1XuI+PkwniXmftdfVaFjodz6j9IVWBkPx5Jh9Do36MtIaKXDUzT
         YL+Bhky0DHUgwEFxrwxtuqjAri26PsETgs824pEcj5KI62OMQydck8AQOaHMqqHryyBZ
         n/yW/PPRu5jWMwfsCWtawQmZwosM5G1w0jENMOr7lPyUzPZNJxdNOQ/EKBZztSVZfIqG
         wjCw==
X-Gm-Message-State: AOJu0Ywg8AK0n3lDDXTY7/Kt7nxMufqNuxuX9NDxb9bIvKSK5Q6AXUbU
        WBkd0WCsIA9CQ4MwLfqDbHm9Rv44Q+QVS9FE
X-Google-Smtp-Source: AGHT+IFO/PR24I3UyPKyVM2QYWaRsCFtstN3wYd7icQb7ZXufKoz/563krjOqVD0NEnjgGQwO0ZsMUsgUdTuKaXZ
X-Received: from jchowdhary2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:434b])
 (user=jchowdhary job=sendgmr) by 2002:a05:6902:1083:b0:da0:567d:f819 with
 SMTP id v3-20020a056902108300b00da0567df819mr491506ybu.10.1698995646197; Fri,
 03 Nov 2023 00:14:06 -0700 (PDT)
Date:   Fri,  3 Nov 2023 07:13:52 +0000
In-Reply-To: <915ef27a-11c8-49ba-8f8a-b4524b85c75a@ideasonboard.com>
Mime-Version: 1.0
References: <915ef27a-11c8-49ba-8f8a-b4524b85c75a@ideasonboard.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231103071353.1577383-1-jchowdhary@google.com>
Subject: [PATCH v4] usb:gadget:uvc Do not use worker thread to pump isoc usb requests
From:   Jayant Chowdhary <jchowdhary@google.com>
To:     dan.scally@ideasonboard.com, jchowdhary@google.com,
        stern@rowland.harvard.edu, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, gregkh@linuxfoundation.org
Cc:     Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use an async work queue to perform the function of pumping
usb requests to the usb controller, it is possible that amongst other
factors, thread scheduling affects at what cadence we're able to pump
requests. This could mean isoc usb requests miss their uframes - resulting
in video stream flickers on the host device.

To avoid this, we make the async_wq thread only produce isoc usb_requests
with uvc buffers encoded into them. The process of queueing to the
endpoint is done by the uvc_video_complete() handler. In case no
usb_requests are ready with encoded information, we just queue a zero
length request to the endpoint from the complete handler.

For bulk endpoints the async_wq thread still queues usb requests to the
endpoint.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
Suggested-by: Avichal Rakesh <arakesh@google.com>
Suggested-by: Alan Stern <stern@rowland.harvard.edu>
---
 Based on top of
 https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:
 v1->v2: Added self Signed-Off-by and addressed review comments
 v2->v3: Encode to usb requests in async_wq; queue to ep in complete handler
	 for isoc transfers.
 v3->v4: Address review comments around code style.

 drivers/usb/gadget/function/uvc.h       |   8 +
 drivers/usb/gadget/function/uvc_video.c | 195 +++++++++++++++++++-----
 2 files changed, 165 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index e8d4c87f1e09..5ff454528bd8 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -105,7 +105,15 @@ struct uvc_video {
 	bool is_enabled; /* tracks whether video stream is enabled */
 	unsigned int req_size;
 	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
+
+	/* USB requests that the video pump thread can encode into */
 	struct list_head req_free;
+
+	/*
+	 * USB requests video pump thread has already encoded into. These are
+	 * ready to be queued to the endpoint.
+	 */
+	struct list_head req_ready;
 	spinlock_t req_lock;
 
 	unsigned int req_int_count;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 53feb790a4c3..e99c5b567f66 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -268,6 +268,99 @@ static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_request *req)
 	return ret;
 }
 
+/* This function must be called with video->req_lock held. */
+static int uvcg_video_usb_req_queue(struct uvc_video *video,
+	struct usb_request *req, bool queue_to_ep)
+{
+	bool is_bulk = video->max_payload_size;
+
+	if (!video->is_enabled) {
+		uvc_video_free_request(req->context, video->ep);
+		return -ENODEV;
+	}
+	if (queue_to_ep) {
+		struct uvc_request *ureq = req->context;
+		/*
+		 * With USB3 handling more requests at a higher speed, we can't
+		 * afford to generate an interrupt for every request. Decide to
+		 * interrupt:
+		 *
+		 * - When no more requests are available in the free queue, as
+		 *   this may be our last chance to refill the endpoint's
+		 *   request queue.
+		 *
+		 * - When this is request is the last request for the video
+		 *   buffer, as we want to start sending the next video buffer
+		 *   ASAP in case it doesn't get started already in the next
+		 *   iteration of this loop.
+		 *
+		 * - Four times over the length of the requests queue (as
+		 *   indicated by video->uvc_num_requests), as a trade-off
+		 *   between latency and interrupt load.
+		 */
+		if (list_empty(&video->req_free) || ureq->last_buf ||
+			!(video->req_int_count %
+			DIV_ROUND_UP(video->uvc_num_requests, 4))) {
+			video->req_int_count = 0;
+			req->no_interrupt = 0;
+		} else {
+			req->no_interrupt = 1;
+		}
+		video->req_int_count++;
+		return uvcg_video_ep_queue(video, req);
+	} else {
+		/*
+		* If we're not queing to the ep, for isoc we're queing
+		* to the req_ready list, otherwise req_free.
+		*/
+		struct list_head *list =
+			is_bulk ? &video->req_free : &video->req_ready;
+		list_add_tail(&req->list, list);
+	}
+	return 0;
+}
+
+/*
+ * Must only be called from uvcg_video_enable - since after that we only want to
+ * queue requests to the endpoint from the uvc_video_complete complete handler.
+ * This function is needed in order to 'kick start' the flow of requests from
+ * gadget driver to the usb controller.
+ */
+static void uvc_video_ep_queue_initial_requests(struct uvc_video *video)
+{
+	struct usb_request *req = NULL;
+	unsigned long flags = 0;
+	unsigned int count = 0;
+	int ret = 0;
+	/*
+	 * We only queue half of the free list since we still want to have
+	 * some free usb_requests in the free list for the video_pump async_wq
+	 * thread to encode uvc buffers into. Otherwise we could get into a
+	 * situation where the free list does not have any usb requests to
+	 * encode into - we always end up queueing 0 length requests to the
+	 * end point.
+	 */
+	unsigned half_list_size = video->uvc_num_requests / 2;
+	spin_lock_irqsave(&video->req_lock, flags);
+	/*
+	 * Take these requests off the free list and queue them all to the
+	 * endpoint. Since we queue the requests with the req_lock held,
+	 */
+	while (count < half_list_size) {
+		req = list_first_entry(&video->req_free, struct usb_request,
+					list);
+		list_del(&req->list);
+		req->length = 0;
+		ret = uvcg_video_ep_queue(video, req);
+		if (ret < 0) {
+			uvcg_queue_cancel(&video->queue, /*disconnect*/0);
+			break;
+		}
+		count++;
+	}
+	spin_unlock_irqrestore(&video->req_lock, flags);
+}
+
 static void
 uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 {
@@ -276,6 +369,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_video_queue *queue = &video->queue;
 	struct uvc_buffer *last_buf = NULL;
 	unsigned long flags;
+	bool is_bulk = video->max_payload_size;
+	int ret = 0;
 
 	spin_lock_irqsave(&video->req_lock, flags);
 	if (!video->is_enabled) {
@@ -329,7 +424,45 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	 * back to req_free
 	 */
 	if (video->is_enabled) {
-		list_add_tail(&req->list, &video->req_free);
+		/*
+		 * Here we check whether any request is available in the ready
+		 * list. If it is, queue it to the ep and add the current
+		 * usb_request to the req_free list - for video_pump to fill in.
+		 * Otherwise, just use the current usb_request to queue a 0
+		 * length request to the ep. Since we always add to the req_free
+		 * list if we dequeue from the ready list, there will never
+		 * be a situation where the req_free list is completely out of
+		 * requests and cannot recover.
+		 */
+		struct usb_request *to_queue = req;
+		to_queue->length = 0;
+		if (!list_empty(&video->req_ready)) {
+			to_queue = list_first_entry(&video->req_ready,
+				struct usb_request, list);
+			list_del(&to_queue->list);
+			/* Add it to the free list. */
+			list_add_tail(&req->list, &video->req_free);
+		}
+		/*
+		 * Queue to the endpoint. The actual queueing to ep will
+		 * only happen on one thread - the async_wq for bulk endpoints
+		 * and this thread for isoc endpoints.
+		 */
+		ret = uvcg_video_usb_req_queue(video, to_queue, !is_bulk);
+		if(ret < 0) {
+			uvcg_queue_cancel(queue, 0);
+		}
+		/*
+		 * Queue work to the wq as well since it is possible that a
+		 * buffer may not have been completely encoded with the set of
+		 * in-flight usb requests for whih the complete callbacks are
+		 * firing.
+		 * In that case, if we do not queue work to the worker thread,
+		 * the buffer will never be marked as complete - and therefore
+		 * not be returned to userpsace. As a result,
+		 * dequeue -> queue -> dequeue flow of uvc buffers will not
+		 * happen.
+		 */
 		queue_work(video->async_wq, &video->pump);
 	} else {
 		uvc_video_free_request(ureq, ep);
@@ -347,6 +480,7 @@ uvc_video_free_requests(struct uvc_video *video)
 
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
+	INIT_LIST_HEAD(&video->req_ready);
 	video->req_size = 0;
 	return 0;
 }
@@ -424,8 +558,7 @@ static void uvcg_video_pump(struct work_struct *work)
 	struct usb_request *req = NULL;
 	struct uvc_buffer *buf;
 	unsigned long flags;
-	bool buf_done;
-	int ret;
+	int ret = 0;
 
 	while (true) {
 		if (!video->ep->enabled)
@@ -454,7 +587,6 @@ static void uvcg_video_pump(struct work_struct *work)
 
 		if (buf != NULL) {
 			video->encode(req, video, buf);
-			buf_done = buf->state == UVC_BUF_STATE_DONE;
 		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
 			/*
 			 * No video buffer available; the queue is still connected and
@@ -462,7 +594,6 @@ static void uvcg_video_pump(struct work_struct *work)
 			 * prevent missed ISOC transfers.
 			 */
 			req->length = 0;
-			buf_done = false;
 		} else {
 			/*
 			 * Either the queue has been disconnected or no video buffer
@@ -473,45 +604,26 @@ static void uvcg_video_pump(struct work_struct *work)
 			break;
 		}
 
-		/*
-		 * With USB3 handling more requests at a higher speed, we can't
-		 * afford to generate an interrupt for every request. Decide to
-		 * interrupt:
-		 *
-		 * - When no more requests are available in the free queue, as
-		 *   this may be our last chance to refill the endpoint's
-		 *   request queue.
-		 *
-		 * - When this is request is the last request for the video
-		 *   buffer, as we want to start sending the next video buffer
-		 *   ASAP in case it doesn't get started already in the next
-		 *   iteration of this loop.
-		 *
-		 * - Four times over the length of the requests queue (as
-		 *   indicated by video->uvc_num_requests), as a trade-off
-		 *   between latency and interrupt load.
-		 */
-		if (list_empty(&video->req_free) || buf_done ||
-		    !(video->req_int_count %
-		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
-			video->req_int_count = 0;
-			req->no_interrupt = 0;
-		} else {
-			req->no_interrupt = 1;
-		}
-
-		/* Queue the USB request */
-		ret = uvcg_video_ep_queue(video, req);
 		spin_unlock_irqrestore(&queue->irqlock, flags);
 
+		/* Queue the USB request. */
+		spin_lock_irqsave(&video->req_lock, flags);
+		/* For bulk end points we queue from the worker thread
+		 * since we would preferably not want to wait on requests
+		 * to be ready, in the uvcg_video_complete() handler.
+		 * For isoc endpoints we add the request to the ready list
+		 * and only queue it to the endpoint from the complete handler.
+		 */
+		ret = uvcg_video_usb_req_queue(video, req, is_bulk);
+		spin_unlock_irqrestore(&video->req_lock, flags);
+
 		if (ret < 0) {
 			uvcg_queue_cancel(queue, 0);
 			break;
 		}
 
-		/* Endpoint now owns the request */
+		/* The request is owned by  the endpoint / ready list. */
 		req = NULL;
-		video->req_int_count++;
 	}
 
 	if (!req)
@@ -567,7 +679,7 @@ uvcg_video_disable(struct uvc_video *video)
 
 	spin_lock_irqsave(&video->req_lock, flags);
 	/*
-	 * Remove all uvc_reqeusts from ureqs with list_del_init
+	* Remove all uvc_requests from ureqs with list_del_init
 	 * This lets uvc_video_free_request correctly identify
 	 * if the uvc_request is attached to a list or not when freeing
 	 * memory.
@@ -580,8 +692,14 @@ uvcg_video_disable(struct uvc_video *video)
 		uvc_video_free_request(req->context, video->ep);
 	}
 
+	list_for_each_entry_safe(req, temp, &video->req_ready, list) {
+		list_del(&req->list);
+		uvc_video_free_request(req->context, video->ep);
+	}
+
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
+	INIT_LIST_HEAD(&video->req_ready);
 	video->req_size = 0;
 	spin_unlock_irqrestore(&video->req_lock, flags);
 
@@ -635,7 +753,7 @@ int uvcg_video_enable(struct uvc_video *video)
 
 	video->req_int_count = 0;
 
-	queue_work(video->async_wq, &video->pump);
+	uvc_video_ep_queue_initial_requests(video);
 
 	return ret;
 }
@@ -648,6 +766,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 	video->is_enabled = false;
 	INIT_LIST_HEAD(&video->ureqs);
 	INIT_LIST_HEAD(&video->req_free);
+	INIT_LIST_HEAD(&video->req_ready);
 	spin_lock_init(&video->req_lock);
 	INIT_WORK(&video->pump, uvcg_video_pump);
 
-- 
2.42.0.869.gea05f2083d-goog

