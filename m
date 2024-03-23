Return-Path: <linux-kernel+bounces-112302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8CF88781C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2751C20DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E0A3B2BF;
	Sat, 23 Mar 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="exNiKUgk"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B81798E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711190889; cv=none; b=GAHnJZqFvI7qZOUQ4AMMG2cV8YpEcgLTJzoGxXuxMOEwAY9wRKpyEJZGc+BEBJtVlD6JPB0JQfLRi768cp34mxP4sSCR73j/7tgod53iTYNAPT/2Cd58cRbRqh4ZLoIQdqF91z4LAy0jF8FMbneseQWUYxoda1ZVS1Buzd+VhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711190889; c=relaxed/simple;
	bh=2J+19GA36C3nuOsP8fOrVXxQYN5UxCEC69hOZuSlfsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RTcly/Y1/rJzev2EdYa+hzTU7MTHWrOy9t2fJiWAbOsf43s7noxrZ8Q4sAbIOsraVI9U1Pyrvr8ZmUTXTuq21/48HwAlke9AQdZQM7cWruwHJrkq+eCJXccf6rDmTIRt8rnUjwVYkRZi7IUkaeYAaY5lbKvSpUphFDqeCd1JFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=exNiKUgk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430c63d4da9so22230911cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711190887; x=1711795687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bd6fdlI9ivmm+oqWJlfdPWn+cEoU+QJKRh2PjxHjMI=;
        b=exNiKUgkPVeJrVZRMYqon4vzAixCLq40/VYRx00XxuG2Xwanvxutu+JTsFoWxs6xY0
         8URdQIuEr7la+xsOtkqB0iA94F5kXIAt8nx3Mn4gHCxB8DHCneoZt40NiWHSTRDLVFvH
         fx6V1KaLsDYk9yplOWIxu2KyK5XNDBaBomrq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711190887; x=1711795687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bd6fdlI9ivmm+oqWJlfdPWn+cEoU+QJKRh2PjxHjMI=;
        b=XUFCXWOf8bA1BQJvznopx+4FlwkyB7BW7r96yWaJaVdyh4slgkBmxW423ESaI3JffR
         /tLH+WPi/n6PcuCaRZHKxPhNxeNIfDUTJbdBUbtoynEsB1wVGUyABd76//8UqckucxEI
         bpmPsvxlbncx+4CGQM4ik6QjZbh5p7Rgbzyfe9s7ougOjDaKtZckF75jT6h3DqQjud6/
         ekuSSbaSsuijrZ2gskNygrAd5HRquzoJLJBjlv+7MrwNPOV727F3zab9dM///Dc7wAO/
         3NqN/HVYHJims3YuIkbNV3AB1NrZhwKe1StwXz4k7eSzGutIJEUFEcGPyIkCT8jN/bPm
         td0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4tim82zHCf9eTNt6w4poKJkSWhPAqa1yeSPzQoto7NFdWxaphmvEM1MU/kfJybpGSx3Fz8mJrjvluNaXRiqkMWlncCsC0QLvHSqo1
X-Gm-Message-State: AOJu0YxJ3KUa7tVaUHgFO4sA5JvOJ0kD14rqxbicuX/OIZu6j6QBYM4j
	rXXRJy2zEC5sPmlUx3D/LMYp9SJW8SmX4mGhqqOlIoYdqdGyi/QSnFBKeOBV7w==
X-Google-Smtp-Source: AGHT+IGU9gLLTUYwi1LmYqhPdNKwd2ZkooWIAWRM80xxMT4ZAM7SGocug7CMLBdcfAAHwxp85vbwGw==
X-Received: by 2002:ac8:5d10:0:b0:431:378d:afa with SMTP id f16-20020ac85d10000000b00431378d0afamr2514208qtx.34.1711190886913;
        Sat, 23 Mar 2024 03:48:06 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id gd14-20020a05622a5c0e00b0042f21fe66f7sm697213qtb.73.2024.03.23.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 03:48:06 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 23 Mar 2024 10:48:04 +0000
Subject: [PATCH v10 3/6] media: uvcvideo: Quirk for invalid dev_sof in
 Logitech C922
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240323-resend-hwtimestamp-v10-3-b08e590d97c7@chromium.org>
References: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
In-Reply-To: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.12.4

Logitech C922 internal SOF does not increases at a stable rate of 1kHz.
This causes that the device_sof and the host_sof run at different rates,
breaking the clock domain conversion algorithm. Eg:

30 (6) [-] none 30 614400 B 21.245557 21.395214 34.133 fps ts mono/SoE
31 (7) [-] none 31 614400 B 21.275327 21.427246 33.591 fps ts mono/SoE
32 (0) [-] none 32 614400 B 21.304739 21.459256 34.000 fps ts mono/SoE
33 (1) [-] none 33 614400 B 21.334324 21.495274 33.801 fps ts mono/SoE
* 34 (2) [-] none 34 614400 B 21.529237 21.527297 5.130 fps ts mono/SoE
* 35 (3) [-] none 35 614400 B 21.649416 21.559306 8.321 fps ts mono/SoE
36 (4) [-] none 36 614400 B 21.678789 21.595320 34.045 fps ts mono/SoE
..
99 (3) [-] none 99 614400 B 23.542226 23.696352 33.541 fps ts mono/SoE
100 (4) [-] none 100 614400 B 23.571578 23.728404 34.069 fps ts mono/SoE
101 (5) [-] none 101 614400 B 23.601425 23.760420 33.504 fps ts mono/SoE
* 102 (6) [-] none 102 614400 B 23.798324 23.796428 5.079 fps ts mono/SoE
* 103 (7) [-] none 103 614400 B 23.916271 23.828450 8.478 fps ts mono/SoE
104 (0) [-] none 104 614400 B 23.945720 23.860479 33.957 fps ts mono/SoE

Instead of disabling completely the hardware timestamping for such
hardware we take the assumption that the packet handling jitter is
under 2ms and use the host_sof as dev_sof.

We can think of the UVC hardware clock as a system with a coarse clock
(the SOF) and a fine clock (the PTS). The coarse clock can be replaced
with a clock on the same frequency, if the jitter of such clock is
smaller than its sampling rate. That way we can save some of the
precision of the fine clock.

To probe this point we have run three experiments on the Logitech C922.
On that experiment we run the camera at 33fps and we analyse the
difference in msec between a frame and its predecessor. If we display
the histogram of that value, a thinner histogram will mean a better
meassurement. The results for:
- original hw timestamp: https://ibb.co/D1HJJ4x
- pure software timestamp: https://ibb.co/QC9MgVK
- modified hw timestamp: https://ibb.co/8s9dBdk

This bug in the camera firmware has been confirmed by the vendor.

lsusb -v

Bus 001 Device 044: ID 046d:085c Logitech, Inc. C922 Pro Stream Webcam
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x046d Logitech, Inc.
  idProduct          0x085c C922 Pro Stream Webcam
  bcdDevice            0.16
  iManufacturer           0
  iProduct                2 C922 Pro Stream Webcam
  iSerial                 1 80B912DF
  bNumConfigurations      1

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c |  9 +++++++++
 drivers/media/usb/uvc/uvc_video.c  | 11 +++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index bbd90123a4e76..723e6d5680c2e 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2574,6 +2574,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
+	/* Logitech HD Pro Webcam C922 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x085c,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_INVALID_DEVICE_SOF) },
 	/* Chicony CNF7129 (Asus EEE 100HE) */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index b2e70fcf4eb4c..d6ca383f643e3 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -558,6 +558,17 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	stream->clock.last_sof = dev_sof;
 
 	host_sof = usb_get_current_frame_number(stream->dev->udev);
+
+	/*
+	 * On some devices, like the Logitech C922, the device SOF does not run
+	 * at a stable rate of 1kHz. For those devices use the host SOF instead.
+	 * In the tests performed so far, this improves the timestamp precision.
+	 * This is probably explained by a small packet handling jitter from the
+	 * host, but the exact reason hasn't been fully determined.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
+		dev_sof = host_sof;
+
 	time = uvc_video_get_time();
 
 	/*
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 6fb0a78b1b009..cb9dd50bba8ac 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -73,6 +73,7 @@
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00002000
+#define UVC_QUIRK_INVALID_DEVICE_SOF	0x00004000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
2.44.0.396.g6e790dbe36-goog


