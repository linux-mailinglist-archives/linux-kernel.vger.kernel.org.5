Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC547DA1AE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346387AbjJ0UUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0UUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:20:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5031AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:20:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da1176f3d96so1003835276.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698438005; x=1699042805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep/ELVWkKr4CeruSxLnrkZQE2W1VuCadmVO/eYOPMRk=;
        b=Oy5ULI1xCGvq5/en2OQihjQfOfkMVL/ir4JroB3PvAbiXYSRxKBdvYwrL6iFL0u1wf
         XJe+1MuOP0DmfK+XCpRNuhfTwjjpDP2lmFEcvVnb+plCbDIr3O5pCpZbrAx3Xf10wVkU
         mo/durMepm5yw1gTYpkxov2+HhW5bc1nFSxkbExN5xT6s5UbtElRXtybrrgKpjCJ7AGJ
         hi6+4kJpIvK4GW8rkIws9joNEv8K4fIXHCCcofB9pTvICi16s5GrMVU6kOwVROqUp+J3
         ZNdDMtM1+aDjcOIOMi1L/i9I4avSlilZ3M/rof0Hei0YkR7PeTpsmKEPqifivzydF+b9
         Qo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698438005; x=1699042805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ep/ELVWkKr4CeruSxLnrkZQE2W1VuCadmVO/eYOPMRk=;
        b=YYdPu8FJLL70tlEYicg3RvKJbofs1eKyyONtOsqv4PUvQgKr1fLcvku+yfSVQAXHqn
         KuYl5Lyq2NomBRRn3oVzIl5v9vqfc58jDYrfNn/5zIiiQtYvQcVn77vnXu4wEdDviIYU
         UE+6AH5+sZgJEs/fIXrUJUbhMRXWAvQjYymhoyU8oVgXNQ9lNSyxTlkCu/o49gET0WaR
         Ju4tz5aBR5W6ztHXhiItH1+LHfS/eN9TGgpiPy/jmQW+drv7CRYTwtv+lmVATUfS6RbE
         Ja6l5ayNH0X53N/RlLywkxkW1otCexEUZ667QGt2jwMaPN4AwE6ie0MBdbJKPyOrKNpU
         O4hw==
X-Gm-Message-State: AOJu0YxEfsVFUtfdlt+K3a6XFWaOWhoyWMR7a7crVwO+qYkRWjYjLs14
        gSAMlp/TGF1fSyLI9OzpaMtSn6hOFEzt
X-Google-Smtp-Source: AGHT+IFB9G9q7Is4pJEknHTJS5eFPTHHnCkwDLKEwYWeFgLBRgi/NQCBEbrnfQhOGzei2olRAPf/peqV0McJ
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a25:cfca:0:b0:d9a:556d:5f8a with SMTP id
 f193-20020a25cfca000000b00d9a556d5f8amr67456ybg.12.1698438005024; Fri, 27 Oct
 2023 13:20:05 -0700 (PDT)
Date:   Fri, 27 Oct 2023 13:19:56 -0700
In-Reply-To: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
Mime-Version: 1.0
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231027201959.1869181-1-arakesh@google.com>
Subject: [PATCH v9 1/4] usb: gadget: uvc: prevent use of disabled endpoint
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

Currently the set_alt callback immediately disables the endpoint and queues
the v4l2 streamoff event. However, as the streamoff event is processed
asynchronously, it is possible that the video_pump thread attempts to queue
requests to an already disabled endpoint.

This change moves disabling usb endpoint to the end of streamoff event
callback. As the endpoint's state can no longer be used, video_pump is
now guarded by uvc->state as well. To be consistent with the actual
streaming state, uvc->state is now toggled between CONNECTED and STREAMING
from the v4l2 event callback only.

Link: https://lore.kernel.org/20230615171558.GK741@pendragon.ideasonboard.com/
Link: https://lore.kernel.org/20230531085544.253363-1-dan.scally@ideasonboard.com/
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1 -> v2: Rebased to ToT and reworded commit message.
v2 -> v3: Fix email threading goof-up
v3 -> v4: Address review comments & re-rebase to ToT
v4 -> v5: Add Reviewed-by & Tested-by
v5 -> v6: No change
v6 -> v7: No change
v7 -> v8: No change. Getting back in review queue
v8 -> v9: Fix typo. No functional change.

 drivers/usb/gadget/function/f_uvc.c     | 11 +++++------
 drivers/usb/gadget/function/f_uvc.h     |  2 +-
 drivers/usb/gadget/function/uvc.h       |  2 +-
 drivers/usb/gadget/function/uvc_v4l2.c  | 20 +++++++++++++++++---
 drivers/usb/gadget/function/uvc_video.c |  3 ++-
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index faa398109431..ae08341961eb 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -263,10 +263,13 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
 	return 0;
 }

-void uvc_function_setup_continue(struct uvc_device *uvc)
+void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep)
 {
 	struct usb_composite_dev *cdev = uvc->func.config->cdev;

+	if (disable_ep && uvc->video.ep)
+		usb_ep_disable(uvc->video.ep);
+
 	usb_composite_setup_continue(cdev);
 }

@@ -337,15 +340,11 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
 		if (uvc->state != UVC_STATE_STREAMING)
 			return 0;

-		if (uvc->video.ep)
-			usb_ep_disable(uvc->video.ep);
-
 		memset(&v4l2_event, 0, sizeof(v4l2_event));
 		v4l2_event.type = UVC_EVENT_STREAMOFF;
 		v4l2_event_queue(&uvc->vdev, &v4l2_event);

-		uvc->state = UVC_STATE_CONNECTED;
-		return 0;
+		return USB_GADGET_DELAYED_STATUS;

 	case 1:
 		if (uvc->state != UVC_STATE_CONNECTED)
diff --git a/drivers/usb/gadget/function/f_uvc.h b/drivers/usb/gadget/function/f_uvc.h
index 1db972d4beeb..083aef0c65c6 100644
--- a/drivers/usb/gadget/function/f_uvc.h
+++ b/drivers/usb/gadget/function/f_uvc.h
@@ -11,7 +11,7 @@

 struct uvc_device;

-void uvc_function_setup_continue(struct uvc_device *uvc);
+void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep);

 void uvc_function_connect(struct uvc_device *uvc);

diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 6751de8b63ad..989bc6b4e93d 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -177,7 +177,7 @@ struct uvc_file_handle {
  * Functions
  */

-extern void uvc_function_setup_continue(struct uvc_device *uvc);
+extern void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep);
 extern void uvc_function_connect(struct uvc_device *uvc);
 extern void uvc_function_disconnect(struct uvc_device *uvc);

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 3f0a9795c0d4..7cb8d027ff0c 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -451,7 +451,7 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
 	 * Complete the alternate setting selection setup phase now that
 	 * userspace is ready to provide video frames.
 	 */
-	uvc_function_setup_continue(uvc);
+	uvc_function_setup_continue(uvc, 0);
 	uvc->state = UVC_STATE_STREAMING;

 	return 0;
@@ -463,11 +463,18 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
 	struct video_device *vdev = video_devdata(file);
 	struct uvc_device *uvc = video_get_drvdata(vdev);
 	struct uvc_video *video = &uvc->video;
+	int ret = 0;

 	if (type != video->queue.queue.type)
 		return -EINVAL;

-	return uvcg_video_enable(video, 0);
+	uvc->state = UVC_STATE_CONNECTED;
+	ret = uvcg_video_enable(video, 0);
+	if (ret < 0)
+		return ret;
+
+	uvc_function_setup_continue(uvc, 1);
+	return 0;
 }

 static int
@@ -500,6 +507,14 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
 static void uvc_v4l2_disable(struct uvc_device *uvc)
 {
 	uvc_function_disconnect(uvc);
+	/*
+	 * Drop uvc->state to CONNECTED if it was streaming before.
+	 * This ensures that the usb_requests are no longer queued
+	 * to the controller.
+	 */
+	if (uvc->state == UVC_STATE_STREAMING)
+		uvc->state = UVC_STATE_CONNECTED;
+
 	uvcg_video_enable(&uvc->video, 0);
 	uvcg_free_buffers(&uvc->video.queue);
 	uvc->func_connected = false;
@@ -647,4 +662,3 @@ const struct v4l2_file_operations uvc_v4l2_fops = {
 	.get_unmapped_area = uvcg_v4l2_get_unmapped_area,
 #endif
 };
-
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 91af3b1ef0d4..c334802ac0a4 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -384,13 +384,14 @@ static void uvcg_video_pump(struct work_struct *work)
 	struct uvc_video_queue *queue = &video->queue;
 	/* video->max_payload_size is only set when using bulk transfer */
 	bool is_bulk = video->max_payload_size;
+	struct uvc_device *uvc = video->uvc;
 	struct usb_request *req = NULL;
 	struct uvc_buffer *buf;
 	unsigned long flags;
 	bool buf_done;
 	int ret;

-	while (video->ep->enabled) {
+	while (uvc->state == UVC_STATE_STREAMING && video->ep->enabled) {
 		/*
 		 * Retrieve the first available USB request, protected by the
 		 * request lock.
--
2.42.0.820.g83a721a137-goog
