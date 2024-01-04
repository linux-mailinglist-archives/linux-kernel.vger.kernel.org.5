Return-Path: <linux-kernel+bounces-17254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C962824A78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BCB1C226A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52D2C851;
	Thu,  4 Jan 2024 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9X8YWpQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C99D2C6B4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--arakesh.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e9de9795dfso19201827b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 13:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704405013; x=1705009813; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vr/OBsTWvGDiBKievrq74k8mPQfV1kdauoMo8LQ/tKk=;
        b=C9X8YWpQAaJNrOHmiZHduX+qHhz74Buc/ehbei978YX1JakLX4HJf/AoBdZP9ufDqs
         vvXWD61C9AEYH9xLk1kolhEY4mzoer5I+ecudx+8HXH6opiVSv1CBLcBi2eT4r8eT32V
         IzKr31cNxn/81GKBN4kqhOWrW7WwzHlYb7hhjjwy7ogeDR8TYSeJ9rdaw7kwbtEQ37YF
         l/mqWLnF7/tylc8aUSboY4IQCz379tSCosTl1blcjV0IcaWdhVYE2g87pWjms8e7+PW5
         hfs+j++0z8yKo+InDS3Cla57/whu5IHKPT0lRJB6k0Wwk0cOckyJ+WwObWdAwGTcfc9w
         +9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704405013; x=1705009813;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr/OBsTWvGDiBKievrq74k8mPQfV1kdauoMo8LQ/tKk=;
        b=PaRL9uYkSwqjlKh/5enPCmYikLW9GtNo1NqbpoouIUtA7JWDE2wWkHFnbxyOqCATzr
         V8bz08oeJywQ4Mldw+y0QwO2ovB0ULGcpccMmbEAYK7qpYw/p+36UV1GyyEYr+CKsk2M
         J06Gtqd32LP2FE1XwtmQFUZ6ZFmaecMionYZO7Ryw7aEJJYKdyQ3L74SHUi/1Y2rsbag
         LWGJQpY5IOtV9cnwakAxY52uakDD1lmGmMYSJUPQWM8NsVAIBC5nFanX3LplCZj074b/
         SdqMY0plukWZyciEd4NMbkkcq09KsFO1RPx4BEn/hbjYSgt9I547MYO5kxhWV27SV9Zv
         cL3A==
X-Gm-Message-State: AOJu0YxNQ3YO29GG5WR24DFLaQLMPcBscq1x2dYzJLmc0Mmd0VdFyLZf
	3po/+VNGBf55cBrZtO0DOG9QfpZm9r2fpH0VY8c=
X-Google-Smtp-Source: AGHT+IHX11kdbCtYUTemM/UsbhmAPpGN/iCqaRNkAgvtkryuwnIP7VFMH0PU+nqEjfZUwAMuJZiUdTuwaCLp
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a25:ef11:0:b0:dbe:9dbe:adb6 with SMTP id
 g17-20020a25ef11000000b00dbe9dbeadb6mr436407ybd.4.1704405013049; Thu, 04 Jan
 2024 13:50:13 -0800 (PST)
Date: Thu,  4 Jan 2024 13:50:08 -0800
In-Reply-To: <20231215210746.821494-1-arakesh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231215210746.821494-1-arakesh@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240104215009.2252452-1-arakesh@google.com>
Subject: [PATCH v2 1/2] usb: gadget: uvc: Fix use are free during STREAMOFF
From: Avichal Rakesh <arakesh@google.com>
To: arakesh@google.com, gregkh@linuxfoundation.org
Cc: dan.scally@ideasonboard.com, etalvala@google.com, jchowdhary@google.com, 
	laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There is a path that may lead to freed memory being referenced,
causing kernel panics.

The kernel panic has the following stack trace:

Workqueue: uvcgadget uvcg_video_pump.c51fb85fece46625450f86adbf92c56c.cfi_jt
pstate: 60c00085 (nZCv daIf +PAN +UAO -TCO BTYPE=--)
pc : __list_del_entry_valid+0xc0/0xd4
lr : __list_del_entry_valid+0xc0/0xd4
Call trace:
  __list_del_entry_valid+0xc0/0xd4
  uvc_video_free_request+0x60/0x98
  uvcg_video_pump+0x1cc/0x204
  process_one_work+0x21c/0x4b8
  worker_thread+0x29c/0x574
  kthread+0x158/0x1b0
  ret_from_fork+0x10/0x30

The root cause is that uvcg_video_usb_req_queue frees the uvc_request
if is_enabled is false and returns an error status. video_pump also
frees the associated request if uvcg_video_usb_req_queue returns an
error status, leading to double free and accessing garbage memory.

To fix the issue, this patch removes freeing logic from
uvcg_video_usb_req_queue, and lets the callers to the function handle
queueing errors as they see fit.

Fixes: 6acba0345b68 ("usb:gadget:uvc Do not use worker thread to pump isoc usb requests")
Tested-by: Avichal Rakesh <arakesh@google.com>
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
v1 -> v2: Address review comment; add "Fixes" tag; fix goofy line wrap

 drivers/usb/gadget/function/uvc_video.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 98ba524c27f5..7f18dc471be3 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -276,10 +276,9 @@ static int uvcg_video_usb_req_queue(struct uvc_video *video,
 	bool is_bulk = video->max_payload_size;
 	struct list_head *list = NULL;

-	if (!video->is_enabled) {
-		uvc_video_free_request(req->context, video->ep);
+	if (!video->is_enabled)
 		return -ENODEV;
-	}
+
 	if (queue_to_ep) {
 		struct uvc_request *ureq = req->context;
 		/*
@@ -464,8 +463,15 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 		 * and this thread for isoc endpoints.
 		 */
 		ret = uvcg_video_usb_req_queue(video, to_queue, !is_bulk);
-		if (ret < 0)
+		if (ret < 0) {
+			/*
+			 * Endpoint error, but the stream is still enabled.
+			 * Put request back in req_free for it to be cleaned
+			 * up later.
+			 */
 			uvcg_queue_cancel(queue, 0);
+			list_add_tail(&to_queue->list, &video->req_free);
+		}
 	} else {
 		uvc_video_free_request(ureq, ep);
 	}
--
2.43.0.472.g3155946c3a-goog

