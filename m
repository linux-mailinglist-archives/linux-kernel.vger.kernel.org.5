Return-Path: <linux-kernel+bounces-117474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F53D88ABCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F0329C764
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0514A14532A;
	Mon, 25 Mar 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DvvLcanG"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F31442EF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384299; cv=none; b=ZHKS7fEcYydq+5ZvtXL1I0Dk4eybR8ih+xKgTP4Li3FeKZk7/xHG6jRjfTC/wF470n5futDVMufTYdAAOh5OJ86QGOQkV39XUnDGZpJ6T2NUnanb4/LdoUZslUJ/9P8S62J24idtQrcyZQ3Cgr3X7LwjzrXfjnIb71Pne9rnpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384299; c=relaxed/simple;
	bh=JlvQ9Yfn11uIbhjEgaTFQsmPGd/1yuqa1pSRCbtCi84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfuZgNE8PSP7VHDS+rsuWzQyNgYUj5+FP4b0WSVTtNHoeufLM3Mv/UI1n0Lq5xAiMzBXDRyYAR8AEfymWz71iHH6aDXSaB798fNPw/8xam9U0YH7/rn0Q/yj5fHSCdSjOulLUCwqxgQ8bTT6nuP9PTFuY/h/dvCHc/n6IjYahSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DvvLcanG; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e6a5bd015dso2200021a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711384297; x=1711989097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Nvi44hWY4ZiLch2QLFxmRlfeQ6MV7x23bO6+n52bYE=;
        b=DvvLcanGWrqOM87X8pEfRNoLZSMOy9ii0EBYfXZWKEwbRaj5Leivm63pWXJzIZj7Z/
         rVSKAFEb/2cKNeaKJH2vCt8a/PXjrFhpN5WMUkQttzM5vLFt5hfog0/0rsChxU0Yp05T
         m3dJlpWPEq+QBGqrgd0pDPeIo3YuX3fX+rF48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384297; x=1711989097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Nvi44hWY4ZiLch2QLFxmRlfeQ6MV7x23bO6+n52bYE=;
        b=SSMouERNLCwmoQRyqCE9lCnNHjjgqdoxppgcMoLU0gMOIOD0NUKyroBDKqT4E6Ratr
         gpiv09O0nq9tTj6JI0dKLg1KQ/aD6Xns7rAJaAIJZU9cWqS/Cpq1/vW3RKtz8DZ9cO+1
         ZNftapaYVQEadys1w+e+GuGISRorBCV8NwroYZX4MP1ntExqSx3LmJqx2LtusbkLPzVN
         pgSFVM87Nv0UnHV7ReQ4KGRdFdZw7dG1axSqjGkT66AxOzBqr9r30XlmI/YVr90pZ5UO
         3vwRT2Imhv5IakSUaC87U2BEMJX3f96tmrOqoorDaSU93qyiS+sZJNG19kDVHjgPt1hz
         IpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlAmUg2od7Bon/TW4hvJ1AQKTKsIITj6ol67zaDjW3jUsyKbmqXuETc1KxTiDRnenicb+intuwj4QaTE3jydW3v+ZgFFihkqCc6Kr2
X-Gm-Message-State: AOJu0YzGL5ES+2OYUesedg7/5rcD8aaVyGjxGyedyKh8OuELg2B7aK7m
	6PLNTtvA822Op/Ztg5sy/5XkTP9ml1sQRt2UIsF6RJUNfIHG7yxs2o86SOXYtg==
X-Google-Smtp-Source: AGHT+IGL6ElCSHpsFv9WEDn+/Rwz1Qq56BdY9L8OznTxh2JDZ+MC9Fj8h5NC3ublq3EXy1tW8YR6uA==
X-Received: by 2002:a9d:69d9:0:b0:6e4:e561:6ba7 with SMTP id v25-20020a9d69d9000000b006e4e5616ba7mr9350669oto.25.1711384297319;
        Mon, 25 Mar 2024 09:31:37 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id jr9-20020a0562142a8900b006905c8b37bbsm376330qvb.133.2024.03.25.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:31:36 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 16:31:34 +0000
Subject: [PATCH v3 2/3] media: uvcvideo: Refactor the status irq API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-guenter-mini-v3-2-c4bc61d84e03@chromium.org>
References: <20240325-guenter-mini-v3-0-c4bc61d84e03@chromium.org>
In-Reply-To: <20240325-guenter-mini-v3-0-c4bc61d84e03@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Max Staudt <mstaudt@chromium.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.12.4

There are two different use-cases of uvc_status():
	- adding/removing a user when the camera is open/closed
	- stopping/starting when the camera is suspended/resumed

Make the API reflect these two use-cases and move all the refcounting
and locking logic to the uvc_status.c file.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 13 ++-------
 drivers/media/usb/uvc/uvc_status.c | 57 ++++++++++++++++++++++++++++++++++++--
 drivers/media/usb/uvc/uvc_v4l2.c   | 22 ++++-----------
 drivers/media/usb/uvc/uvcvideo.h   | 10 ++++---
 4 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 17fc945c8deb6..b579644ac0745 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2116,7 +2116,6 @@ static int uvc_probe(struct usb_interface *intf,
 	INIT_LIST_HEAD(&dev->streams);
 	kref_init(&dev->ref);
 	atomic_set(&dev->nmappings, 0);
-	mutex_init(&dev->lock);
 
 	dev->udev = usb_get_dev(udev);
 	dev->intf = usb_get_intf(intf);
@@ -2282,10 +2281,7 @@ static int uvc_suspend(struct usb_interface *intf, pm_message_t message)
 	/* Controls are cached on the fly so they don't need to be saved. */
 	if (intf->cur_altsetting->desc.bInterfaceSubClass ==
 	    UVC_SC_VIDEOCONTROL) {
-		mutex_lock(&dev->lock);
-		if (dev->users)
-			uvc_status_stop(dev);
-		mutex_unlock(&dev->lock);
+		uvc_status_suspend(dev);
 		return 0;
 	}
 
@@ -2316,12 +2312,7 @@ static int __uvc_resume(struct usb_interface *intf, int reset)
 				return ret;
 		}
 
-		mutex_lock(&dev->lock);
-		if (dev->users)
-			ret = uvc_status_start(dev, GFP_NOIO);
-		mutex_unlock(&dev->lock);
-
-		return ret;
+		return uvc_status_resume(dev);
 	}
 
 	list_for_each_entry(stream, &dev->streams, list) {
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index a78a88c710e24..ff66482346dde 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -262,6 +262,8 @@ int uvc_status_init(struct uvc_device *dev)
 
 	uvc_input_init(dev);
 
+	mutex_init(&dev->status_lock);
+
 	dev->status = kzalloc(sizeof(*dev->status), GFP_KERNEL);
 	if (!dev->status)
 		return -ENOMEM;
@@ -292,7 +294,7 @@ int uvc_status_init(struct uvc_device *dev)
 
 void uvc_status_unregister(struct uvc_device *dev)
 {
-	usb_kill_urb(dev->int_urb);
+	uvc_status_suspend(dev);
 	uvc_input_unregister(dev);
 }
 
@@ -302,18 +304,22 @@ void uvc_status_cleanup(struct uvc_device *dev)
 	kfree(dev->status);
 }
 
-int uvc_status_start(struct uvc_device *dev, gfp_t flags)
+static int _uvc_status_start(struct uvc_device *dev, gfp_t flags)
 {
+	lockdep_assert_held(&dev->status_lock);
+
 	if (dev->int_urb == NULL)
 		return 0;
 
 	return usb_submit_urb(dev->int_urb, flags);
 }
 
-void uvc_status_stop(struct uvc_device *dev)
+static void _uvc_status_stop(struct uvc_device *dev)
 {
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
+	lockdep_assert_held(&dev->status_lock);
+
 	/*
 	 * Prevent the asynchronous control handler from requeing the URB. The
 	 * barrier is needed so the flush_status change is visible to other
@@ -350,3 +356,48 @@ void uvc_status_stop(struct uvc_device *dev)
 	 */
 	smp_store_release(&dev->flush_status, false);
 }
+
+int uvc_status_resume(struct uvc_device *dev)
+{
+	int ret = 0;
+
+	mutex_lock(&dev->status_lock);
+	if (dev->status_users)
+		ret = _uvc_status_start(dev, GFP_NOIO);
+	mutex_unlock(&dev->status_lock);
+
+	return ret;
+}
+
+void uvc_status_suspend(struct uvc_device *dev)
+{
+	mutex_lock(&dev->status_lock);
+	if (dev->status_users)
+		_uvc_status_stop(dev);
+	mutex_unlock(&dev->status_lock);
+}
+
+int uvc_status_get(struct uvc_device *dev)
+{
+	int ret = 0;
+
+	mutex_lock(&dev->status_lock);
+	if (!dev->status_users)
+		ret = _uvc_status_start(dev, GFP_KERNEL);
+	if (!ret)
+		dev->status_users++;
+	mutex_unlock(&dev->status_lock);
+
+	return ret;
+}
+
+void uvc_status_put(struct uvc_device *dev)
+{
+	mutex_lock(&dev->status_lock);
+	if (dev->status_users == 1)
+		_uvc_status_stop(dev);
+	WARN_ON(!dev->status_users);
+	if (dev->status_users)
+		dev->status_users--;
+	mutex_unlock(&dev->status_lock);
+}
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index f4988f03640ae..97c5407f66032 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -628,20 +628,13 @@ static int uvc_v4l2_open(struct file *file)
 		return -ENOMEM;
 	}
 
-	mutex_lock(&stream->dev->lock);
-	if (stream->dev->users == 0) {
-		ret = uvc_status_start(stream->dev, GFP_KERNEL);
-		if (ret < 0) {
-			mutex_unlock(&stream->dev->lock);
-			usb_autopm_put_interface(stream->dev->intf);
-			kfree(handle);
-			return ret;
-		}
+	ret = uvc_status_get(stream->dev);
+	if (ret) {
+		usb_autopm_put_interface(stream->dev->intf);
+		kfree(handle);
+		return ret;
 	}
 
-	stream->dev->users++;
-	mutex_unlock(&stream->dev->lock);
-
 	v4l2_fh_init(&handle->vfh, &stream->vdev);
 	v4l2_fh_add(&handle->vfh);
 	handle->chain = stream->chain;
@@ -670,10 +663,7 @@ static int uvc_v4l2_release(struct file *file)
 	kfree(handle);
 	file->private_data = NULL;
 
-	mutex_lock(&stream->dev->lock);
-	if (--stream->dev->users == 0)
-		uvc_status_stop(stream->dev);
-	mutex_unlock(&stream->dev->lock);
+	uvc_status_put(stream->dev);
 
 	usb_autopm_put_interface(stream->dev->intf);
 	return 0;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 6fb0a78b1b009..00b600eb058cc 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -555,8 +555,6 @@ struct uvc_device {
 
 	const struct uvc_device_info *info;
 
-	struct mutex lock;		/* Protects users */
-	unsigned int users;
 	atomic_t nmappings;
 
 	/* Video control interface */
@@ -578,6 +576,8 @@ struct uvc_device {
 	struct usb_host_endpoint *int_ep;
 	struct urb *int_urb;
 	struct uvc_status *status;
+	struct mutex status_lock; /* Protects status_users */
+	unsigned int status_users;
 	bool flush_status;
 
 	struct input_dev *input;
@@ -744,8 +744,10 @@ int uvc_register_video_device(struct uvc_device *dev,
 int uvc_status_init(struct uvc_device *dev);
 void uvc_status_unregister(struct uvc_device *dev);
 void uvc_status_cleanup(struct uvc_device *dev);
-int uvc_status_start(struct uvc_device *dev, gfp_t flags);
-void uvc_status_stop(struct uvc_device *dev);
+int uvc_status_resume(struct uvc_device *dev);
+void uvc_status_suspend(struct uvc_device *dev);
+int uvc_status_get(struct uvc_device *dev);
+void uvc_status_put(struct uvc_device *dev);
 
 /* Controls */
 extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;

-- 
2.44.0.396.g6e790dbe36-goog


