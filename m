Return-Path: <linux-kernel+bounces-115141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B465888D61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC328D988
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27E28E54D;
	Mon, 25 Mar 2024 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbZSxk5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD90181CFD;
	Sun, 24 Mar 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324141; cv=none; b=UjFd7a3/lj0IIUwOqNgpapexYjclR+Sr1+DtnQa74ppsXTYTDIxZ7p/a+XKlL5hWQ62Vh++BNnrSDDXUT8a7hYeevN1uwo4Wr3YQdyrhhSYAcLeD1AhljmBnEKs9w08EhcvcrPTBkopnel1WoOEVhRF37JTOan4Prs0ijOrWPsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324141; c=relaxed/simple;
	bh=oqK8V1hYn9cnmP/x01f7f4fW4CTXRYn8qwhuMOtNFZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hK3ZUvendL2TPpVXreooUEzibEmcwycznANujFZe/SMy4oDwehL8AU8vGfz29wkBecAwNoZONwSti9iHXbV7mDfYvzRICtEBwJYpvj2JIW07haXvVxkGsJduqGW0cdCnh95f5M0+tAhhSdgcoaNYGV6nnz8Kufa/n6ZWPZzFyJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbZSxk5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F77C43394;
	Sun, 24 Mar 2024 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324141;
	bh=oqK8V1hYn9cnmP/x01f7f4fW4CTXRYn8qwhuMOtNFZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbZSxk5MwtzAJaijEj0aXxN7URsDOVER6I6KNEvCBM6d2lDuhzjkDph/u5lB0tMxO
	 sa5hIcRlqnd3sGzYCzFKWGZNPxF8uzWPq6pkLknwllKQG+SKFFvs64vn+5mZcNCs6g
	 8Kmb//KlmGzLKcSsGM/2nsniePKXl2VsyleNjNM2QFv6V+5Uw0mG+VusAyZ+Kz8rbG
	 AxT0XdikOEUE2vsD/HMX5TwA6czJh/uD53tidNmjxIJ3OaRbEzUTcBRMirm1T9CDub
	 EQ7ZWt3IRscPoUwC6ZYAyCkhVQ4JnCuXpN9dn/u4s87HKkjc56x1UcImlHO/TZSX7v
	 aTpAkfQRfLHHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 137/183] media: rename VFL_TYPE_GRABBER to _VIDEO
Date: Sun, 24 Mar 2024 19:45:50 -0400
Message-ID: <20240324234638.1355609-138-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 238e4a5baa361256ae1641ad9455bb2bb359273f ]

We currently have the following devnode types:

enum vfl_devnode_type {
        VFL_TYPE_GRABBER        = 0,
        VFL_TYPE_VBI,
        VFL_TYPE_RADIO,
        VFL_TYPE_SUBDEV,
        VFL_TYPE_SDR,
        VFL_TYPE_TOUCH,
        VFL_TYPE_MAX /* Shall be the last one */
};

They all make sense, except for the first: GRABBER really refers to /dev/videoX
devices, which can be capture, output or m2m, so 'grabber' doesn't even refer to
their function anymore.

Let's call a spade a spade and rename this to VFL_TYPE_VIDEO.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: d0b07f712bf6 ("media: ttpci: fix two memleaks in budget_av_attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/media/kapi/v4l2-dev.rst                  |  4 ++--
 .../translations/zh_CN/video4linux/v4l2-framework.txt  |  4 ++--
 drivers/media/v4l2-core/v4l2-dev.c                     | 10 +++++-----
 drivers/media/v4l2-core/v4l2-ioctl.c                   |  4 ++--
 include/media/v4l2-dev.h                               |  6 ++++--
 samples/v4l/v4l2-pci-skeleton.c                        |  2 +-
 6 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/media/kapi/v4l2-dev.rst b/Documentation/media/kapi/v4l2-dev.rst
index 4c5a15c53dbfb..63c064837c008 100644
--- a/Documentation/media/kapi/v4l2-dev.rst
+++ b/Documentation/media/kapi/v4l2-dev.rst
@@ -185,7 +185,7 @@ This will create the character device for you.
 
 .. code-block:: c
 
-	err = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	err = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (err) {
 		video_device_release(vdev); /* or kfree(my_vdev); */
 		return err;
@@ -201,7 +201,7 @@ types exist:
 ========================== ====================	 ==============================
 :c:type:`vfl_devnode_type` Device name		 Usage
 ========================== ====================	 ==============================
-``VFL_TYPE_GRABBER``       ``/dev/videoX``       for video input/output devices
+``VFL_TYPE_VIDEO``         ``/dev/videoX``       for video input/output devices
 ``VFL_TYPE_VBI``           ``/dev/vbiX``         for vertical blank data (i.e.
 						 closed captions, teletext)
 ``VFL_TYPE_RADIO``         ``/dev/radioX``       for radio tuners
diff --git a/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt b/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
index 66c7c568bd866..9c39ee58ea507 100644
--- a/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
+++ b/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
@@ -649,7 +649,7 @@ video_device注册
 
 接下来你需要注册视频设备：这会为你创建一个字符设备。
 
-	err = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	err = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (err) {
 		video_device_release(vdev); /* or kfree(my_vdev); */
 		return err;
@@ -660,7 +660,7 @@ video_device注册
 
 注册哪种设备是根据类型（type）参数。存在以下类型：
 
-VFL_TYPE_GRABBER: 用于视频输入/输出设备的 videoX
+VFL_TYPE_VIDEO: 用于视频输入/输出设备的 videoX
 VFL_TYPE_VBI: 用于垂直消隐数据的 vbiX (例如，隐藏式字幕，图文电视)
 VFL_TYPE_RADIO: 用于广播调谐器的 radioX
 
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 1bf543932e4f9..ddc861868ce08 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -542,13 +542,13 @@ static void determine_valid_ioctls(struct video_device *vdev)
 			      V4L2_CAP_META_OUTPUT;
 	DECLARE_BITMAP(valid_ioctls, BASE_VIDIOC_PRIVATE);
 	const struct v4l2_ioctl_ops *ops = vdev->ioctl_ops;
-	bool is_vid = vdev->vfl_type == VFL_TYPE_GRABBER &&
+	bool is_vid = vdev->vfl_type == VFL_TYPE_VIDEO &&
 		      (vdev->device_caps & vid_caps);
 	bool is_vbi = vdev->vfl_type == VFL_TYPE_VBI;
 	bool is_radio = vdev->vfl_type == VFL_TYPE_RADIO;
 	bool is_sdr = vdev->vfl_type == VFL_TYPE_SDR;
 	bool is_tch = vdev->vfl_type == VFL_TYPE_TOUCH;
-	bool is_meta = vdev->vfl_type == VFL_TYPE_GRABBER &&
+	bool is_meta = vdev->vfl_type == VFL_TYPE_VIDEO &&
 		       (vdev->device_caps & meta_caps);
 	bool is_rx = vdev->vfl_dir != VFL_DIR_TX;
 	bool is_tx = vdev->vfl_dir != VFL_DIR_RX;
@@ -777,7 +777,7 @@ static int video_register_media_controller(struct video_device *vdev)
 	vdev->entity.function = MEDIA_ENT_F_UNKNOWN;
 
 	switch (vdev->vfl_type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		intf_type = MEDIA_INTF_T_V4L_VIDEO;
 		vdev->entity.function = MEDIA_ENT_F_IO_V4L;
 		break;
@@ -885,7 +885,7 @@ int __video_register_device(struct video_device *vdev,
 
 	/* Part 1: check device type */
 	switch (type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		name_base = "video";
 		break;
 	case VFL_TYPE_VBI:
@@ -929,7 +929,7 @@ int __video_register_device(struct video_device *vdev,
 	 * of 128-191 and just pick the first free minor there
 	 * (new style). */
 	switch (type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		minor_offset = 0;
 		minor_cnt = 64;
 		break;
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index b8edef9160864..682ba53b1a7a7 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -959,12 +959,12 @@ static int check_fmt(struct file *file, enum v4l2_buf_type type)
 			      V4L2_CAP_META_OUTPUT;
 	struct video_device *vfd = video_devdata(file);
 	const struct v4l2_ioctl_ops *ops = vfd->ioctl_ops;
-	bool is_vid = vfd->vfl_type == VFL_TYPE_GRABBER &&
+	bool is_vid = vfd->vfl_type == VFL_TYPE_VIDEO &&
 		      (vfd->device_caps & vid_caps);
 	bool is_vbi = vfd->vfl_type == VFL_TYPE_VBI;
 	bool is_sdr = vfd->vfl_type == VFL_TYPE_SDR;
 	bool is_tch = vfd->vfl_type == VFL_TYPE_TOUCH;
-	bool is_meta = vfd->vfl_type == VFL_TYPE_GRABBER &&
+	bool is_meta = vfd->vfl_type == VFL_TYPE_VIDEO &&
 		       (vfd->device_caps & meta_caps);
 	bool is_rx = vfd->vfl_dir != VFL_DIR_TX;
 	bool is_tx = vfd->vfl_dir != VFL_DIR_RX;
diff --git a/include/media/v4l2-dev.h b/include/media/v4l2-dev.h
index 48531e57cc5a8..5e7c0f8acd054 100644
--- a/include/media/v4l2-dev.h
+++ b/include/media/v4l2-dev.h
@@ -24,7 +24,8 @@
 /**
  * enum vfl_devnode_type - type of V4L2 device node
  *
- * @VFL_TYPE_GRABBER:	for video input/output devices
+ * @VFL_TYPE_VIDEO:	for video input/output devices
+ * @VFL_TYPE_GRABBER:	deprecated, same as VFL_TYPE_VIDEO
  * @VFL_TYPE_VBI:	for vertical blank data (i.e. closed captions, teletext)
  * @VFL_TYPE_RADIO:	for radio tuners
  * @VFL_TYPE_SUBDEV:	for V4L2 subdevices
@@ -33,7 +34,8 @@
  * @VFL_TYPE_MAX:	number of VFL types, must always be last in the enum
  */
 enum vfl_devnode_type {
-	VFL_TYPE_GRABBER	= 0,
+	VFL_TYPE_VIDEO,
+	VFL_TYPE_GRABBER = VFL_TYPE_VIDEO,
 	VFL_TYPE_VBI,
 	VFL_TYPE_RADIO,
 	VFL_TYPE_SUBDEV,
diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
index f6a551bd57ef1..3fa6582b4a689 100644
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -879,7 +879,7 @@ static int skeleton_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	vdev->tvnorms = SKEL_TVNORMS;
 	video_set_drvdata(vdev, skel);
 
-	ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (ret)
 		goto free_hdl;
 
-- 
2.43.0


