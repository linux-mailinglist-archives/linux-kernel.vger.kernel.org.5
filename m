Return-Path: <linux-kernel+bounces-80939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97673866E49
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF47B27918
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17858229;
	Mon, 26 Feb 2024 08:44:31 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8385B57892;
	Mon, 26 Feb 2024 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937071; cv=none; b=l/Tsmrees2QZiJqZ7KNN65vl7SLqANtBBx9xewCJREemhR4woc5s++m/8VIooCs716S9r0CLY0STydt8kGhQZsF0uQdV3scHR6VGy+cbEhYv5CX2K/n4Jcxw5zL5pX+K1v8eeZazBNs6fO1VEQOcw/FqhCXhhdw3YEl9PfjHu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937071; c=relaxed/simple;
	bh=fgYQVMxpAmTgYDCZIFPEaCK+FRLJh6UXAq9wyXsuRvM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=HeDlH8pXMtw1Y+q5XcI/ANuA+M76WXa93yySRMDvxPaoIeoMGAlDnzvcJ1cpsERbGe5WDvOsDV8NGAPdLwfFmabk7w4U7qMmP47wY0DjLT+VzG3N2miwECbua5yA5+mfCwh7CoW5l1BafCdA29f2PuXNZUN1WJevSnBM8XSsoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F01A31A06F5;
	Mon, 26 Feb 2024 09:44:27 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BF4E1A0138;
	Mon, 26 Feb 2024 09:44:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 811F8183AD17;
	Mon, 26 Feb 2024 16:44:25 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v13 12/16] media: uapi: Declare interface types for Audio
Date: Mon, 26 Feb 2024 16:28:25 +0800
Message-Id: <1708936109-11587-13-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1708936109-11587-1-git-send-email-shengjiu.wang@nxp.com>
References: <1708936109-11587-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Declare the interface types that will be used by Audio.
The type is MEDIA_INTF_T_V4L_AUDIO.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../userspace-api/media/mediactl/media-types.rst    |  5 +++++
 drivers/media/v4l2-core/v4l2-dev.c                  |  4 ++++
 drivers/media/v4l2-core/v4l2-mem2mem.c              | 13 +++++++++----
 include/uapi/linux/media.h                          |  1 +
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/userspace-api/media/mediactl/media-types.rst b/Documentation/userspace-api/media/mediactl/media-types.rst
index 6332e8395263..adfb37430f8e 100644
--- a/Documentation/userspace-api/media/mediactl/media-types.rst
+++ b/Documentation/userspace-api/media/mediactl/media-types.rst
@@ -265,6 +265,7 @@ Types and flags used to represent the media graph elements
 .. _MEDIA-INTF-T-V4L-SUBDEV:
 .. _MEDIA-INTF-T-V4L-SWRADIO:
 .. _MEDIA-INTF-T-V4L-TOUCH:
+.. _MEDIA-INTF-T-V4L-AUDIO:
 .. _MEDIA-INTF-T-ALSA-PCM-CAPTURE:
 .. _MEDIA-INTF-T-ALSA-PCM-PLAYBACK:
 .. _MEDIA-INTF-T-ALSA-CONTROL:
@@ -322,6 +323,10 @@ Types and flags used to represent the media graph elements
        -  Device node interface for Touch device (V4L)
        -  typically, /dev/v4l-touch?
 
+    *  -  ``MEDIA_INTF_T_V4L_AUDIO``
+       -  Device node interface for Audio device (V4L)
+       -  typically, /dev/v4l-audio?
+
     *  -  ``MEDIA_INTF_T_ALSA_PCM_CAPTURE``
        -  Device node interface for ALSA PCM Capture
        -  typically, /dev/snd/pcmC?D?c
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index bac008fcedc6..ca8462a61e1f 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -844,6 +844,10 @@ static int video_register_media_controller(struct video_device *vdev)
 		intf_type = MEDIA_INTF_T_V4L_SUBDEV;
 		/* Entity will be created via v4l2_device_register_subdev() */
 		break;
+	case VFL_TYPE_AUDIO:
+		intf_type = MEDIA_INTF_T_V4L_AUDIO;
+		/* Entity will be created via v4l2_device_register_subdev() */
+		break;
 	default:
 		return 0;
 	}
diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index 75517134a5e9..cda5e255305f 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -1143,10 +1143,15 @@ int v4l2_m2m_register_media_controller(struct v4l2_m2m_dev *m2m_dev,
 	if (ret)
 		goto err_rm_links0;
 
-	/* Create video interface */
-	m2m_dev->intf_devnode = media_devnode_create(mdev,
-			MEDIA_INTF_T_V4L_VIDEO, 0,
-			VIDEO_MAJOR, vdev->minor);
+	if (vdev->vfl_type == VFL_TYPE_AUDIO)
+		m2m_dev->intf_devnode = media_devnode_create(mdev,
+				MEDIA_INTF_T_V4L_AUDIO, 0,
+				VIDEO_MAJOR, vdev->minor);
+	else
+		/* Create video interface */
+		m2m_dev->intf_devnode = media_devnode_create(mdev,
+				MEDIA_INTF_T_V4L_VIDEO, 0,
+				VIDEO_MAJOR, vdev->minor);
 	if (!m2m_dev->intf_devnode) {
 		ret = -ENOMEM;
 		goto err_rm_links1;
diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
index 1c80b1d6bbaf..9ff6dec7393a 100644
--- a/include/uapi/linux/media.h
+++ b/include/uapi/linux/media.h
@@ -260,6 +260,7 @@ struct media_links_enum {
 #define MEDIA_INTF_T_V4L_SUBDEV			(MEDIA_INTF_T_V4L_BASE + 3)
 #define MEDIA_INTF_T_V4L_SWRADIO		(MEDIA_INTF_T_V4L_BASE + 4)
 #define MEDIA_INTF_T_V4L_TOUCH			(MEDIA_INTF_T_V4L_BASE + 5)
+#define MEDIA_INTF_T_V4L_AUDIO			(MEDIA_INTF_T_V4L_BASE + 6)
 
 #define MEDIA_INTF_T_ALSA_BASE			0x00000300
 #define MEDIA_INTF_T_ALSA_PCM_CAPTURE		(MEDIA_INTF_T_ALSA_BASE)
-- 
2.34.1


