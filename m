Return-Path: <linux-kernel+bounces-1654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9729781519D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A8E284B19
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2D1482C8;
	Fri, 15 Dec 2023 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sGR3dj0Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB54778B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--arakesh.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbcda1ff95bso950788276.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702674480; x=1703279280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GRqAFzXiOHT+uI9y2fcqSO7bCGQ2RPswJt9PYrloaog=;
        b=sGR3dj0Ybnxv6XK1fid3RuxGpe8SQK+ZwVr6c7hkrrJammT+YVev8BuvGK9zB9RUI1
         i5fDBTVPBCx7S9aFKpYsA0g+EsnH1BP7bRc6CU5dXPXEnpj+PusWECeRQO0DJ3EiXzgl
         8cBGVDFds/6jQunY0+sMgXUkyXtOfsH1oIm7s02Be5iqfCkzBAhVj/FBr98kJKhuOoLC
         1QNcKWsF5y/Oa+5Xofvuz9ByVULzGAo+0jvWHu1Nh0OWwXolcj/gpX1sGNX2Wvh7QPRh
         47ZrfrIymLbA+YLTZqZU5Cr2OnGMih3JlEzqWqeOW5U0dsbe9LpnWzAvJPcbBNywlG8A
         7Dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702674480; x=1703279280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRqAFzXiOHT+uI9y2fcqSO7bCGQ2RPswJt9PYrloaog=;
        b=apq5QS9jm6NA70e1kURAB5QIg7W+jJI07mT/i3oYViTJT3LfC9Z1Dk6uuvjA06nTXQ
         3ZAnqG7cWu+K8F7hjmNb0YXgyh17pGp+Xfg8BVJbS/6z8oJv64bGt3Vcr7crsIYqWo+R
         ehIllgyWXZVZjXALqL/ahypVPA5xTYqjr/MUHKijLN3XsnilxPXDJQMax0f696T3yuRd
         foHpg4re4S4dH57rUEoLKVj7JO3AamiXuGFYvIO3ykThx848O0pdi7p25VMlW4tL5CT1
         FlxIvKPjw2kaKLVEj8SPYb3nLfNboBVE7EvrYiNCBXVe6n5jVVmU8apKmEsUTZFDUbmw
         sOrQ==
X-Gm-Message-State: AOJu0Yx2iCfTCSZg7g7kd9OGdOIvmhzRYiXEJFfVZNUtJUK5J92+nrDp
	ND/b7m+trcLIz2intGuMQvAf9i1SV2ZJ
X-Google-Smtp-Source: AGHT+IGoEfefmli+kT1wQVOb42W4jmeu+lkN1ROnMQT3eo8U5b4xqZN/U6oOs/9t+y9dJGKwT/sRPZfIzONu
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a5b:786:0:b0:db9:772b:1020 with SMTP id
 b6-20020a5b0786000000b00db9772b1020mr134630ybq.5.1702674479792; Fri, 15 Dec
 2023 13:07:59 -0800 (PST)
Date: Fri, 15 Dec 2023 13:07:45 -0800
In-Reply-To: <20231215210746.821494-1-arakesh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231215210746.821494-1-arakesh@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231215210746.821494-2-arakesh@google.com>
Subject: [PATCH 2/2] usb: gadget: uvc: Remove nested locking
From: Avichal Rakesh <arakesh@google.com>
To: dan.scally@ideasonboard.com, gregkh@linuxfoundation.org, 
	laurent.pinchart@ideasonboard.com
Cc: etalvala@google.com, jchowdhary@google.com, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, Avichal Rakesh <arakesh@google.com>
Content-Type: text/plain; charset="UTF-8"

When handling error status from uvcg_video_usb_req_queue,
uvc_video_complete currently calls uvcg_queue_cancel with
video->req_lock held. uvcg_queue_cancel internally locks
queue->irqlock, which nests queue->irqlock inside
video->req_lock. This isn't a functional bug at the
moment, but does open up possibilities for ABBA
deadlocks in the future.

This patch fixes the accidental nesting by dropping
video->req_lock before calling uvcg_queue_cancel.

Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
 drivers/usb/gadget/function/uvc_video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index e5db1be14ca3..d15b9b4c4fcc 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -469,13 +469,15 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 			 * Put request back in req_free for it to be cleaned
 			 * up later.
 			 */
-			uvcg_queue_cancel(queue, 0);
 			list_add_tail(&to_queue->list, &video->req_free);
 		}
 	} else {
 		uvc_video_free_request(ureq, ep);
+		ret = 0;
 	}
 	spin_unlock_irqrestore(&video->req_lock, flags);
+	if (ret < 0)
+		uvcg_queue_cancel(queue, 0);
 }
 
 static int
-- 
2.43.0.472.g3155946c3a-goog


