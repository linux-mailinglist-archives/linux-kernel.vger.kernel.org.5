Return-Path: <linux-kernel+bounces-116286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F540889DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF64284995
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48D3CC1CC;
	Mon, 25 Mar 2024 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzakJSxJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC795149DE7;
	Sun, 24 Mar 2024 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324142; cv=none; b=maOy6yWzcn5VaNdUKBGofugMNMQDChmv4D6G4u8rSofPM7XAfMjEu90DD/7hg3kSAB0aicozXJ8iOextH2nstRfpjn+RjfTK79QA0RPP3ar+AhZ2mYEY+KW56kwb1ZznyrfRznxTa+9RJZbjDEq6C0ZzTFWoY7c0bENX1Bus6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324142; c=relaxed/simple;
	bh=4tULCppFs3vveufcOYGvqh7Mcyobk/ZQr/eLimMwwHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN2XKpkMoquVP4V8/6fUe+z0HytOxlA59oFpUF8jzVtlDfDG9IuGnlI8gxpNA9j2TQSLslReqeLDnzqGPiX86HO4BwfuNmV1zWD7AQwl0f03XSqGxtU6FXVW13dhJ/dZ13VWyeT/uX4N/HZRs5GkkFXOp7mSKAQqvxtV7stBCgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzakJSxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BD1C433F1;
	Sun, 24 Mar 2024 23:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324142;
	bh=4tULCppFs3vveufcOYGvqh7Mcyobk/ZQr/eLimMwwHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzakJSxJEIxfYIBVZEHIgo1EkWqv4f05IXVIaVwpuqSd9A2MKjj9t4d1iCyxPkEUx
	 dXswF+Lt/Vjvxo54LIXqk5onuQnxzF3J5G5POX6fwWMTol1F9llXj5l7jNs8uXsDSb
	 AQMr3GIAX/AplIjs5Hco8olIRQoQtffJTHoayoHZ4fi4CivUG6V89W5HQ5KmbrMlvJ
	 JnJSic7Smmxe1MQRGmNFx38/4LMaYDZo876mEcWtgPbH9Ppv1DhXPChCY3rjlX6nj7
	 4Vlvwxt3r84s7DDWkLjjZS4zeBXBZGaaI81zgYy2d5ftjCd5IpJi08eVqbcTgyB8hh
	 nvBHE+nEXsMtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 138/183] media: media/pci: rename VFL_TYPE_GRABBER to _VIDEO
Date: Sun, 24 Mar 2024 19:45:51 -0400
Message-ID: <20240324234638.1355609-139-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 3e30a927af3ca86f6556faf437da44ca8bcf54a4 ]

'GRABBER' is a weird name, all other types map to the /dev
device names. Rename to 'VIDEO' to be consistent with the
other types.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: d0b07f712bf6 ("media: ttpci: fix two memleaks in budget_av_attach")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/bt8xx/bttv-driver.c          |  4 ++--
 drivers/media/pci/cobalt/cobalt-v4l2.c         |  2 +-
 drivers/media/pci/cx18/cx18-streams.c          | 12 ++++++------
 drivers/media/pci/cx23885/cx23885-417.c        |  2 +-
 drivers/media/pci/cx23885/cx23885-video.c      |  2 +-
 drivers/media/pci/cx25821/cx25821-video.c      |  2 +-
 drivers/media/pci/cx88/cx88-blackbird.c        |  2 +-
 drivers/media/pci/cx88/cx88-video.c            |  2 +-
 drivers/media/pci/dt3155/dt3155.c              |  2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c       |  2 +-
 drivers/media/pci/ivtv/ivtv-streams.c          | 12 ++++++------
 drivers/media/pci/meye/meye.c                  |  2 +-
 drivers/media/pci/saa7134/saa7134-core.c       |  2 +-
 drivers/media/pci/saa7134/saa7134-empress.c    |  2 +-
 drivers/media/pci/saa7146/hexium_gemini.c      |  2 +-
 drivers/media/pci/saa7146/hexium_orion.c       |  2 +-
 drivers/media/pci/saa7146/mxb.c                |  2 +-
 drivers/media/pci/saa7164/saa7164-encoder.c    |  2 +-
 drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c |  2 +-
 drivers/media/pci/solo6x10/solo6x10-v4l2.c     |  2 +-
 drivers/media/pci/sta2x11/sta2x11_vip.c        |  2 +-
 drivers/media/pci/ttpci/av7110_v4l.c           |  2 +-
 drivers/media/pci/ttpci/budget-av.c            |  2 +-
 drivers/media/pci/tw5864/tw5864-video.c        |  2 +-
 drivers/media/pci/tw68/tw68-video.c            |  2 +-
 drivers/media/pci/tw686x/tw686x-video.c        |  2 +-
 26 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index a0be1ca89b29a..cdde56889fe2a 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -2964,7 +2964,7 @@ static int bttv_open(struct file *file)
 
 	dprintk("open dev=%s\n", video_device_node_name(vdev));
 
-	if (vdev->vfl_type == VFL_TYPE_GRABBER) {
+	if (vdev->vfl_type == VFL_TYPE_VIDEO) {
 		type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	} else if (vdev->vfl_type == VFL_TYPE_VBI) {
 		type = V4L2_BUF_TYPE_VBI_CAPTURE;
@@ -3905,7 +3905,7 @@ static int bttv_register_video(struct bttv *btv)
 	if (no_overlay <= 0)
 		btv->video_dev.device_caps |= V4L2_CAP_VIDEO_OVERLAY;
 
-	if (video_register_device(&btv->video_dev, VFL_TYPE_GRABBER,
+	if (video_register_device(&btv->video_dev, VFL_TYPE_VIDEO,
 				  video_nr[btv->c.nr]) < 0)
 		goto err;
 	pr_info("%d: registered device %s\n",
diff --git a/drivers/media/pci/cobalt/cobalt-v4l2.c b/drivers/media/pci/cobalt/cobalt-v4l2.c
index c5207501d5e03..0ff37496c9ab7 100644
--- a/drivers/media/pci/cobalt/cobalt-v4l2.c
+++ b/drivers/media/pci/cobalt/cobalt-v4l2.c
@@ -1272,7 +1272,7 @@ static int cobalt_node_register(struct cobalt *cobalt, int node)
 	video_set_drvdata(vdev, s);
 	ret = vb2_queue_init(q);
 	if (!s->is_audio && ret == 0)
-		ret = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	else if (!s->is_dummy)
 		ret = cobalt_alsa_init(s);
 
diff --git a/drivers/media/pci/cx18/cx18-streams.c b/drivers/media/pci/cx18/cx18-streams.c
index b79718519b9ba..3178df3c49224 100644
--- a/drivers/media/pci/cx18/cx18-streams.c
+++ b/drivers/media/pci/cx18/cx18-streams.c
@@ -48,19 +48,19 @@ static struct {
 } cx18_stream_info[] = {
 	{	/* CX18_ENC_STREAM_TYPE_MPG */
 		"encoder MPEG",
-		VFL_TYPE_GRABBER, 0,
+		VFL_TYPE_VIDEO, 0,
 		PCI_DMA_FROMDEVICE,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 		V4L2_CAP_AUDIO | V4L2_CAP_TUNER
 	},
 	{	/* CX18_ENC_STREAM_TYPE_TS */
 		"TS",
-		VFL_TYPE_GRABBER, -1,
+		VFL_TYPE_VIDEO, -1,
 		PCI_DMA_FROMDEVICE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_YUV */
 		"encoder YUV",
-		VFL_TYPE_GRABBER, CX18_V4L2_ENC_YUV_OFFSET,
+		VFL_TYPE_VIDEO, CX18_V4L2_ENC_YUV_OFFSET,
 		PCI_DMA_FROMDEVICE,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_READWRITE |
 		V4L2_CAP_STREAMING | V4L2_CAP_AUDIO | V4L2_CAP_TUNER
@@ -74,13 +74,13 @@ static struct {
 	},
 	{	/* CX18_ENC_STREAM_TYPE_PCM */
 		"encoder PCM audio",
-		VFL_TYPE_GRABBER, CX18_V4L2_ENC_PCM_OFFSET,
+		VFL_TYPE_VIDEO, CX18_V4L2_ENC_PCM_OFFSET,
 		PCI_DMA_FROMDEVICE,
 		V4L2_CAP_TUNER | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_IDX */
 		"encoder IDX",
-		VFL_TYPE_GRABBER, -1,
+		VFL_TYPE_VIDEO, -1,
 		PCI_DMA_FROMDEVICE,
 	},
 	{	/* CX18_ENC_STREAM_TYPE_RAD */
@@ -434,7 +434,7 @@ static int cx18_reg_dev(struct cx18 *cx, int type)
 	name = video_device_node_name(&s->video_dev);
 
 	switch (vfl_type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		CX18_INFO("Registered device %s for %s (%d x %d.%02d kB)\n",
 			  name, s->name, cx->stream_buffers[type],
 			  cx->stream_buf_size[type] / 1024,
diff --git a/drivers/media/pci/cx23885/cx23885-417.c b/drivers/media/pci/cx23885/cx23885-417.c
index 2327fe6126102..434677bd4ad17 100644
--- a/drivers/media/pci/cx23885/cx23885-417.c
+++ b/drivers/media/pci/cx23885/cx23885-417.c
@@ -1545,7 +1545,7 @@ int cx23885_417_register(struct cx23885_dev *dev)
 	if (dev->tuner_type != TUNER_ABSENT)
 		dev->v4l_device->device_caps |= V4L2_CAP_TUNER;
 	err = video_register_device(dev->v4l_device,
-		VFL_TYPE_GRABBER, -1);
+		VFL_TYPE_VIDEO, -1);
 	if (err < 0) {
 		pr_info("%s: can't register mpeg device\n", dev->name);
 		return err;
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index f56b271db8bea..90224a9947022 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -1304,7 +1304,7 @@ int cx23885_video_register(struct cx23885_dev *dev)
 				      V4L2_CAP_AUDIO | V4L2_CAP_VIDEO_CAPTURE;
 	if (dev->tuner_type != TUNER_ABSENT)
 		dev->video_dev->device_caps |= V4L2_CAP_TUNER;
-	err = video_register_device(dev->video_dev, VFL_TYPE_GRABBER,
+	err = video_register_device(dev->video_dev, VFL_TYPE_VIDEO,
 				    video_nr[dev->nr]);
 	if (err < 0) {
 		pr_info("%s: can't register video device\n",
diff --git a/drivers/media/pci/cx25821/cx25821-video.c b/drivers/media/pci/cx25821/cx25821-video.c
index a10261da0db6e..1b80c990cb946 100644
--- a/drivers/media/pci/cx25821/cx25821-video.c
+++ b/drivers/media/pci/cx25821/cx25821-video.c
@@ -757,7 +757,7 @@ int cx25821_video_register(struct cx25821_dev *dev)
 		snprintf(vdev->name, sizeof(vdev->name), "%s #%d", dev->name, i);
 		video_set_drvdata(vdev, chan);
 
-		err = video_register_device(vdev, VFL_TYPE_GRABBER,
+		err = video_register_device(vdev, VFL_TYPE_VIDEO,
 					    video_nr[dev->nr]);
 
 		if (err < 0)
diff --git a/drivers/media/pci/cx88/cx88-blackbird.c b/drivers/media/pci/cx88/cx88-blackbird.c
index d3da7f4297af8..fa4ca002ed191 100644
--- a/drivers/media/pci/cx88/cx88-blackbird.c
+++ b/drivers/media/pci/cx88/cx88-blackbird.c
@@ -1138,7 +1138,7 @@ static int blackbird_register_video(struct cx8802_dev *dev)
 				    V4L2_CAP_VIDEO_CAPTURE;
 	if (dev->core->board.tuner_type != UNSET)
 		dev->mpeg_dev.device_caps |= V4L2_CAP_TUNER;
-	err = video_register_device(&dev->mpeg_dev, VFL_TYPE_GRABBER, -1);
+	err = video_register_device(&dev->mpeg_dev, VFL_TYPE_VIDEO, -1);
 	if (err < 0) {
 		pr_info("can't register mpeg device\n");
 		return err;
diff --git a/drivers/media/pci/cx88/cx88-video.c b/drivers/media/pci/cx88/cx88-video.c
index 547e18da1ad7d..151ffb5fd4042 100644
--- a/drivers/media/pci/cx88/cx88-video.c
+++ b/drivers/media/pci/cx88/cx88-video.c
@@ -1452,7 +1452,7 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
 				     V4L2_CAP_VIDEO_CAPTURE;
 	if (core->board.tuner_type != UNSET)
 		dev->video_dev.device_caps |= V4L2_CAP_TUNER;
-	err = video_register_device(&dev->video_dev, VFL_TYPE_GRABBER,
+	err = video_register_device(&dev->video_dev, VFL_TYPE_VIDEO,
 				    video_nr[core->nr]);
 	if (err < 0) {
 		pr_err("can't register video device\n");
diff --git a/drivers/media/pci/dt3155/dt3155.c b/drivers/media/pci/dt3155/dt3155.c
index 7480f0d3ad0fa..82581aa5a2a39 100644
--- a/drivers/media/pci/dt3155/dt3155.c
+++ b/drivers/media/pci/dt3155/dt3155.c
@@ -550,7 +550,7 @@ static int dt3155_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 					IRQF_SHARED, DT3155_NAME, pd);
 	if (err)
 		goto err_iounmap;
-	err = video_register_device(&pd->vdev, VFL_TYPE_GRABBER, -1);
+	err = video_register_device(&pd->vdev, VFL_TYPE_VIDEO, -1);
 	if (err)
 		goto err_free_irq;
 	dev_info(&pdev->dev, "/dev/video%i is ready\n", pd->vdev.minor);
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 9c0d117e093b1..385b20b22ac35 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1651,7 +1651,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	vdev->queue = &q->vbq;
 	vdev->device_caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING;
 	video_set_drvdata(vdev, cio2);
-	r = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+	r = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (r) {
 		dev_err(&cio2->pci_dev->dev,
 			"failed to register video device (%d)\n", r);
diff --git a/drivers/media/pci/ivtv/ivtv-streams.c b/drivers/media/pci/ivtv/ivtv-streams.c
index 200d2100dbffd..f9de5d1605fe3 100644
--- a/drivers/media/pci/ivtv/ivtv-streams.c
+++ b/drivers/media/pci/ivtv/ivtv-streams.c
@@ -99,7 +99,7 @@ static struct {
 } ivtv_stream_info[] = {
 	{	/* IVTV_ENC_STREAM_TYPE_MPG */
 		"encoder MPG",
-		VFL_TYPE_GRABBER, 0,
+		VFL_TYPE_VIDEO, 0,
 		PCI_DMA_FROMDEVICE, 0,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
@@ -107,7 +107,7 @@ static struct {
 	},
 	{	/* IVTV_ENC_STREAM_TYPE_YUV */
 		"encoder YUV",
-		VFL_TYPE_GRABBER, IVTV_V4L2_ENC_YUV_OFFSET,
+		VFL_TYPE_VIDEO, IVTV_V4L2_ENC_YUV_OFFSET,
 		PCI_DMA_FROMDEVICE, 0,
 		V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_TUNER |
 			V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
@@ -123,7 +123,7 @@ static struct {
 	},
 	{	/* IVTV_ENC_STREAM_TYPE_PCM */
 		"encoder PCM",
-		VFL_TYPE_GRABBER, IVTV_V4L2_ENC_PCM_OFFSET,
+		VFL_TYPE_VIDEO, IVTV_V4L2_ENC_PCM_OFFSET,
 		PCI_DMA_FROMDEVICE, 0,
 		V4L2_CAP_TUNER | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_enc_fops
@@ -137,7 +137,7 @@ static struct {
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_MPG */
 		"decoder MPG",
-		VFL_TYPE_GRABBER, IVTV_V4L2_DEC_MPG_OFFSET,
+		VFL_TYPE_VIDEO, IVTV_V4L2_DEC_MPG_OFFSET,
 		PCI_DMA_TODEVICE, 0,
 		V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
@@ -158,7 +158,7 @@ static struct {
 	},
 	{	/* IVTV_DEC_STREAM_TYPE_YUV */
 		"decoder YUV",
-		VFL_TYPE_GRABBER, IVTV_V4L2_DEC_YUV_OFFSET,
+		VFL_TYPE_VIDEO, IVTV_V4L2_DEC_YUV_OFFSET,
 		PCI_DMA_TODEVICE, 0,
 		V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_AUDIO | V4L2_CAP_READWRITE,
 		&ivtv_v4l2_dec_fops
@@ -315,7 +315,7 @@ static int ivtv_reg_dev(struct ivtv *itv, int type)
 	name = video_device_node_name(&s->vdev);
 
 	switch (vfl_type) {
-	case VFL_TYPE_GRABBER:
+	case VFL_TYPE_VIDEO:
 		IVTV_INFO("Registered device %s for %s (%d kB)\n",
 			name, s->name, itv->options.kilobytes[type]);
 		break;
diff --git a/drivers/media/pci/meye/meye.c b/drivers/media/pci/meye/meye.c
index 0e61c81356ef5..c42e48bc5c1cb 100644
--- a/drivers/media/pci/meye/meye.c
+++ b/drivers/media/pci/meye/meye.c
@@ -1711,7 +1711,7 @@ static int meye_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 	v4l2_ctrl_handler_setup(&meye.hdl);
 	meye.vdev.ctrl_handler = &meye.hdl;
 
-	if (video_register_device(&meye.vdev, VFL_TYPE_GRABBER,
+	if (video_register_device(&meye.vdev, VFL_TYPE_VIDEO,
 				  video_nr) < 0) {
 		v4l2_err(v4l2_dev, "video_register_device failed\n");
 		goto outvideoreg;
diff --git a/drivers/media/pci/saa7134/saa7134-core.c b/drivers/media/pci/saa7134/saa7134-core.c
index 2d582c02adbf9..e4623ed2f8319 100644
--- a/drivers/media/pci/saa7134/saa7134-core.c
+++ b/drivers/media/pci/saa7134/saa7134-core.c
@@ -1214,7 +1214,7 @@ static int saa7134_initdev(struct pci_dev *pci_dev,
 	if (saa7134_no_overlay <= 0)
 		dev->video_dev->device_caps |= V4L2_CAP_VIDEO_OVERLAY;
 
-	err = video_register_device(dev->video_dev,VFL_TYPE_GRABBER,
+	err = video_register_device(dev->video_dev,VFL_TYPE_VIDEO,
 				    video_nr[dev->nr]);
 	if (err < 0) {
 		pr_info("%s: can't register video device\n",
diff --git a/drivers/media/pci/saa7134/saa7134-empress.c b/drivers/media/pci/saa7134/saa7134-empress.c
index e2666d1c68964..141ee18ed827e 100644
--- a/drivers/media/pci/saa7134/saa7134-empress.c
+++ b/drivers/media/pci/saa7134/saa7134-empress.c
@@ -294,7 +294,7 @@ static int empress_init(struct saa7134_dev *dev)
 		dev->empress_dev->device_caps |= V4L2_CAP_TUNER;
 
 	video_set_drvdata(dev->empress_dev, dev);
-	err = video_register_device(dev->empress_dev,VFL_TYPE_GRABBER,
+	err = video_register_device(dev->empress_dev,VFL_TYPE_VIDEO,
 				    empress_nr[dev->nr]);
 	if (err < 0) {
 		pr_info("%s: can't register video device\n",
diff --git a/drivers/media/pci/saa7146/hexium_gemini.c b/drivers/media/pci/saa7146/hexium_gemini.c
index 86d4e2abed82a..3947701cd6c7e 100644
--- a/drivers/media/pci/saa7146/hexium_gemini.c
+++ b/drivers/media/pci/saa7146/hexium_gemini.c
@@ -294,7 +294,7 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
 	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
 	vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
-	ret = saa7146_register_device(&hexium->video_dev, dev, "hexium gemini", VFL_TYPE_GRABBER);
+	ret = saa7146_register_device(&hexium->video_dev, dev, "hexium gemini", VFL_TYPE_VIDEO);
 	if (ret < 0) {
 		pr_err("cannot register capture v4l2 device. skipping.\n");
 		saa7146_vv_release(dev);
diff --git a/drivers/media/pci/saa7146/hexium_orion.c b/drivers/media/pci/saa7146/hexium_orion.c
index 31388597386aa..2eb4bee16b71f 100644
--- a/drivers/media/pci/saa7146/hexium_orion.c
+++ b/drivers/media/pci/saa7146/hexium_orion.c
@@ -368,7 +368,7 @@ static int hexium_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_d
 	vv_data.vid_ops.vidioc_enum_input = vidioc_enum_input;
 	vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
 	vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
-	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium orion", VFL_TYPE_GRABBER)) {
+	if (0 != saa7146_register_device(&hexium->video_dev, dev, "hexium orion", VFL_TYPE_VIDEO)) {
 		pr_err("cannot register capture v4l2 device. skipping.\n");
 		return -1;
 	}
diff --git a/drivers/media/pci/saa7146/mxb.c b/drivers/media/pci/saa7146/mxb.c
index 58fe4c1619eeb..bf0b9b0914cd5 100644
--- a/drivers/media/pci/saa7146/mxb.c
+++ b/drivers/media/pci/saa7146/mxb.c
@@ -714,7 +714,7 @@ static int mxb_attach(struct saa7146_dev *dev, struct saa7146_pci_extension_data
 	vv_data.vid_ops.vidioc_g_register = vidioc_g_register;
 	vv_data.vid_ops.vidioc_s_register = vidioc_s_register;
 #endif
-	if (saa7146_register_device(&mxb->video_dev, dev, "mxb", VFL_TYPE_GRABBER)) {
+	if (saa7146_register_device(&mxb->video_dev, dev, "mxb", VFL_TYPE_VIDEO)) {
 		ERR("cannot register capture v4l2 device. skipping.\n");
 		saa7146_vv_release(dev);
 		return -1;
diff --git a/drivers/media/pci/saa7164/saa7164-encoder.c b/drivers/media/pci/saa7164/saa7164-encoder.c
index df494644b5b64..1d1d32e043f16 100644
--- a/drivers/media/pci/saa7164/saa7164-encoder.c
+++ b/drivers/media/pci/saa7164/saa7164-encoder.c
@@ -1087,7 +1087,7 @@ int saa7164_encoder_register(struct saa7164_port *port)
 	v4l2_ctrl_handler_setup(hdl);
 	video_set_drvdata(port->v4l_device, port);
 	result = video_register_device(port->v4l_device,
-		VFL_TYPE_GRABBER, -1);
+		VFL_TYPE_VIDEO, -1);
 	if (result < 0) {
 		printk(KERN_INFO "%s: can't register mpeg device\n",
 			dev->name);
diff --git a/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c b/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
index 476d7f3b32d63..cbf85231b708f 100644
--- a/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
@@ -1304,7 +1304,7 @@ static struct solo_enc_dev *solo_enc_alloc(struct solo_dev *solo_dev,
 	solo_enc->vfd->queue = &solo_enc->vidq;
 	solo_enc->vfd->lock = &solo_enc->lock;
 	video_set_drvdata(solo_enc->vfd, solo_enc);
-	ret = video_register_device(solo_enc->vfd, VFL_TYPE_GRABBER, nr);
+	ret = video_register_device(solo_enc->vfd, VFL_TYPE_VIDEO, nr);
 	if (ret < 0)
 		goto vdev_release;
 
diff --git a/drivers/media/pci/solo6x10/solo6x10-v4l2.c b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
index 78792067e920f..54434f3c428d0 100644
--- a/drivers/media/pci/solo6x10/solo6x10-v4l2.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
@@ -692,7 +692,7 @@ int solo_v4l2_init(struct solo_dev *solo_dev, unsigned nr)
 	while (erase_off(solo_dev))
 		/* Do nothing */;
 
-	ret = video_register_device(solo_dev->vfd, VFL_TYPE_GRABBER, nr);
+	ret = video_register_device(solo_dev->vfd, VFL_TYPE_VIDEO, nr);
 	if (ret < 0)
 		goto fail;
 
diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
index fd3de3bb0c89b..798574cfad35e 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -1069,7 +1069,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 	vip->video_dev.lock = &vip->v4l_lock;
 	video_set_drvdata(&vip->video_dev, vip);
 
-	ret = video_register_device(&vip->video_dev, VFL_TYPE_GRABBER, -1);
+	ret = video_register_device(&vip->video_dev, VFL_TYPE_VIDEO, -1);
 	if (ret)
 		goto vrelease;
 
diff --git a/drivers/media/pci/ttpci/av7110_v4l.c b/drivers/media/pci/ttpci/av7110_v4l.c
index f3d6c3cdb8721..cabe006658ddb 100644
--- a/drivers/media/pci/ttpci/av7110_v4l.c
+++ b/drivers/media/pci/ttpci/av7110_v4l.c
@@ -831,7 +831,7 @@ int av7110_init_v4l(struct av7110 *av7110)
 	if (FW_VERSION(av7110->arm_app) < 0x2623)
 		vv_data->capabilities &= ~V4L2_CAP_SLICED_VBI_OUTPUT;
 
-	if (saa7146_register_device(&av7110->v4l_dev, dev, "av7110", VFL_TYPE_GRABBER)) {
+	if (saa7146_register_device(&av7110->v4l_dev, dev, "av7110", VFL_TYPE_VIDEO)) {
 		ERR("cannot register capture device. skipping\n");
 		saa7146_vv_release(dev);
 		return -ENODEV;
diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
index e2d482af23677..38cac508bd728 100644
--- a/drivers/media/pci/ttpci/budget-av.c
+++ b/drivers/media/pci/ttpci/budget-av.c
@@ -1470,7 +1470,7 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		vv_data.vid_ops.vidioc_g_input = vidioc_g_input;
 		vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
 
-		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_GRABBER))) {
+		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_VIDEO))) {
 			/* fixme: proper cleanup here */
 			ERR("cannot register capture v4l2 device\n");
 			saa7146_vv_release(dev);
diff --git a/drivers/media/pci/tw5864/tw5864-video.c b/drivers/media/pci/tw5864/tw5864-video.c
index 656142c7a2cc7..a65114e7ca346 100644
--- a/drivers/media/pci/tw5864/tw5864-video.c
+++ b/drivers/media/pci/tw5864/tw5864-video.c
@@ -1162,7 +1162,7 @@ static int tw5864_video_input_init(struct tw5864_input *input, int video_nr)
 	input->gop = GOP_SIZE;
 	input->frame_interval = 1;
 
-	ret = video_register_device(&input->vdev, VFL_TYPE_GRABBER, video_nr);
+	ret = video_register_device(&input->vdev, VFL_TYPE_VIDEO, video_nr);
 	if (ret)
 		goto free_v4l2_hdl;
 
diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
index 2fb82d50c53e5..10986fcd66a55 100644
--- a/drivers/media/pci/tw68/tw68-video.c
+++ b/drivers/media/pci/tw68/tw68-video.c
@@ -962,7 +962,7 @@ int tw68_video_init2(struct tw68_dev *dev, int video_nr)
 	dev->vdev.lock = &dev->lock;
 	dev->vdev.queue = &dev->vidq;
 	video_set_drvdata(&dev->vdev, dev);
-	return video_register_device(&dev->vdev, VFL_TYPE_GRABBER, video_nr);
+	return video_register_device(&dev->vdev, VFL_TYPE_VIDEO, video_nr);
 }
 
 /*
diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw686x/tw686x-video.c
index 9be8c6e4fb693..1ced2b0ddb241 100644
--- a/drivers/media/pci/tw686x/tw686x-video.c
+++ b/drivers/media/pci/tw686x/tw686x-video.c
@@ -1282,7 +1282,7 @@ int tw686x_video_init(struct tw686x_dev *dev)
 		vc->device = vdev;
 		video_set_drvdata(vdev, vc);
 
-		err = video_register_device(vdev, VFL_TYPE_GRABBER, -1);
+		err = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 		if (err < 0)
 			goto error;
 		vc->num = vdev->num;
-- 
2.43.0


