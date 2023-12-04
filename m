Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56040803533
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbjLDNkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbjLDNkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:40:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803A61728;
        Mon,  4 Dec 2023 05:39:35 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 61BDC6607090;
        Mon,  4 Dec 2023 13:39:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701697174;
        bh=zab2+gIouwIIrR/jbmb5javdyyicwi0wlU6M2LP0J9A=;
        h=From:To:Cc:Subject:Date:From;
        b=C3yEGz1AtsCUnmpYiP7RLQXkPIce0mD2t6t13sSe+HsAsgmtqTIsHHlJTq9Cjr8UB
         yxd+/D5gj5vb/Q2Xn2xa/+Cm0dSm+QmKtPLNGHpqnZMBbntWdcJQcQnQY/c1DElN36
         GH8ZIKXJhoJ/XIEihNuqnJtaTlHcrzZrQwvP7DIh7QVCY5yZfy+oJQYdzonOdHwXGc
         Snums99MRWSrOz6lMgX7YhAV3hz/kHb2QGEZUTVyKOB+7Df6/JcVwXGX+3Upe7tfR3
         dJZQzdA3SrxkcBOtex3l6FhtjXub9TqfPvKqNqOfukHfFro2aXICKFeDSdcw3g6ixZ
         zjuwSHAqyBe6g==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        linux-renesas-soc@vger.kernel.org,
        Andy Walls <awalls@md.metrocast.net>,
        Martin Tuma <martin.tuma@digiteqautomotive.com>,
        Bluecherry Maintainers <maintainers@bluecherrydvr.com>,
        Anton Sviridenko <anton@corp.bluecherry.net>,
        Andrey Utkin <andrey.utkin@corp.bluecherry.net>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Corentin Labbe <clabbe@baylibre.com>,
        mjpeg-users@lists.sourceforge.net,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 36/36] videobuf2: core: Rename min_buffers_needed field to vb2_queue
Date:   Mon,  4 Dec 2023 14:39:20 +0100
Message-Id: <20231204133920.23930-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename min_buffers_needed into min_queued_buffers and update
the documentation about it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: NXP Linux Team <linux-imx@nxp.com>
CC: Hugues Fruchet <hugues.fruchet@foss.st.com>
CC: linux-stm32@st-md-mailman.stormreply.com
CC: "Niklas Söderlund" <niklas.soderlund@ragnatech.se>
CC: Jacopo Mondi <jacopo@jmondi.org>
CC: linux-renesas-soc@vger.kernel.org
CC: Andy Walls <awalls@md.metrocast.net>
CC: Martin Tuma <martin.tuma@digiteqautomotive.com>
CC: Bluecherry Maintainers <maintainers@bluecherrydvr.com>
CC: Anton Sviridenko <anton@corp.bluecherry.net>
CC: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
CC: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC: Corentin Labbe <clabbe@baylibre.com>
CC: mjpeg-users@lists.sourceforge.net
CC: Neil Armstrong <neil.armstrong@linaro.org>
CC: Kevin Hilman <khilman@baylibre.com>
CC: Jerome Brunet <jbrunet@baylibre.com>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-amlogic@lists.infradead.org
---
 .../media/common/videobuf2/videobuf2-core.c   | 29 ++++++++++---------
 drivers/media/pci/bt8xx/bttv-driver.c         |  2 +-
 drivers/media/pci/cobalt/cobalt-v4l2.c        |  2 +-
 drivers/media/pci/cx18/cx18-streams.c         |  2 +-
 drivers/media/pci/cx23885/cx23885-417.c       |  2 +-
 drivers/media/pci/cx23885/cx23885-dvb.c       |  2 +-
 drivers/media/pci/cx23885/cx23885-video.c     |  4 +--
 drivers/media/pci/cx25821/cx25821-video.c     |  2 +-
 drivers/media/pci/cx88/cx88-blackbird.c       |  2 +-
 drivers/media/pci/cx88/cx88-dvb.c             |  2 +-
 drivers/media/pci/cx88/cx88-video.c           |  4 +--
 drivers/media/pci/dt3155/dt3155.c             |  2 +-
 drivers/media/pci/mgb4/mgb4_vin.c             |  2 +-
 drivers/media/pci/mgb4/mgb4_vout.c            |  2 +-
 drivers/media/pci/tw5864/tw5864-video.c       |  2 +-
 drivers/media/pci/tw68/tw68-video.c           |  2 +-
 drivers/media/pci/tw686x/tw686x-video.c       |  2 +-
 drivers/media/pci/zoran/zoran_driver.c        |  5 +---
 .../platform/nxp/imx8-isi/imx8-isi-video.c    |  2 +-
 .../platform/renesas/rcar-vin/rcar-dma.c      |  2 +-
 drivers/media/platform/renesas/renesas-ceu.c  |  2 +-
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  |  2 +-
 drivers/media/platform/renesas/sh_vou.c       |  2 +-
 drivers/media/platform/st/stm32/stm32-dcmi.c  |  2 +-
 drivers/staging/media/meson/vdec/vdec.c       |  4 +--
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c |  2 +-
 .../media/sunxi/sun6i-isp/sun6i_isp_params.c  |  2 +-
 include/media/videobuf2-core.h                |  6 ++--
 samples/v4l/v4l2-pci-skeleton.c               |  2 +-
 29 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index c224d13b3105..b251cde33ca5 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -816,7 +816,7 @@ static bool verify_coherency_flags(struct vb2_queue *q, bool non_coherent_mem)
 int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		     unsigned int flags, unsigned int *count)
 {
-	unsigned int num_buffers, allocated_buffers, num_planes = 0;
+	unsigned int num_buffers, allocated_buffers, min_reqbufs_needed, num_planes = 0;
 	unsigned int q_num_bufs = vb2_get_num_buffers(q);
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
@@ -865,8 +865,11 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	/*
 	 * Make sure the requested values and current defaults are sane.
 	 */
-	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
-	num_buffers = max_t(unsigned int, num_buffers, q->min_reqbufs_allocation);
+	if (q->min_reqbufs_allocation)
+		num_buffers = max_t(unsigned int, *count, q->min_reqbufs_allocation);
+	else
+		num_buffers = max_t(unsigned int, *count, q->min_queued_buffers + 1);
+	min_reqbufs_needed = num_buffers;
 	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
 	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 	/*
@@ -918,7 +921,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * There is no point in continuing if we can't allocate the minimum
 	 * number of buffers needed by this vb2_queue.
 	 */
-	if (allocated_buffers < q->min_buffers_needed)
+	if (allocated_buffers < min_reqbufs_needed)
 		ret = -ENOMEM;
 
 	/*
@@ -1654,7 +1657,7 @@ EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
  * @q:		videobuf2 queue
  *
  * Attempt to start streaming. When this function is called there must be
- * at least q->min_buffers_needed buffers queued up (i.e. the minimum
+ * at least q->min_queued_buffers queued up (i.e. the minimum
  * number of buffers required for the DMA engine to function). If the
  * @start_streaming op fails it is supposed to return all the driver-owned
  * buffers back to vb2 in state QUEUED. Check if that happened and if
@@ -1847,7 +1850,7 @@ int vb2_core_qbuf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb,
 	 * then we can finally call start_streaming().
 	 */
 	if (q->streaming && !q->start_streaming_called &&
-	    q->queued_count >= q->min_buffers_needed) {
+	    q->queued_count >= q->min_queued_buffers) {
 		ret = vb2_start_streaming(q);
 		if (ret) {
 			/*
@@ -2211,9 +2214,9 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
 		return -EINVAL;
 	}
 
-	if (q_num_bufs < q->min_buffers_needed) {
-		dprintk(q, 1, "need at least %u allocated buffers\n",
-				q->min_buffers_needed);
+	if (q_num_bufs < q->min_queued_buffers) {
+		dprintk(q, 1, "need at least %u queued buffers\n",
+			q->min_queued_buffers);
 		return -EINVAL;
 	}
 
@@ -2225,7 +2228,7 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
 	 * Tell driver to start streaming provided sufficient buffers
 	 * are available.
 	 */
-	if (q->queued_count >= q->min_buffers_needed) {
+	if (q->queued_count >= q->min_queued_buffers) {
 		ret = vb2_start_streaming(q);
 		if (ret)
 			goto unprepare;
@@ -2505,7 +2508,7 @@ int vb2_core_queue_init(struct vb2_queue *q)
 		return -EINVAL;
 
 	if (WARN_ON(q->max_num_buffers > MAX_BUFFER_INDEX) ||
-	    WARN_ON(q->min_buffers_needed > q->max_num_buffers))
+	    WARN_ON(q->min_queued_buffers > q->max_num_buffers))
 		return -EINVAL;
 
 	if (WARN_ON(q->requires_requests && !q->supports_requests))
@@ -2513,13 +2516,13 @@ int vb2_core_queue_init(struct vb2_queue *q)
 
 	/*
 	 * This combination is not allowed since a non-zero value of
-	 * q->min_buffers_needed can cause vb2_core_qbuf() to fail if
+	 * q->min_queued_buffers can cause vb2_core_qbuf() to fail if
 	 * it has to call start_streaming(), and the Request API expects
 	 * that queueing a request (and thus queueing a buffer contained
 	 * in that request) will always succeed. There is no method of
 	 * propagating an error back to userspace.
 	 */
-	if (WARN_ON(q->supports_requests && q->min_buffers_needed))
+	if (WARN_ON(q->supports_requests && q->min_queued_buffers))
 		return -EINVAL;
 
 	INIT_LIST_HEAD(&q->queued_list);
diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 09a193bb87df..24ebb66a5988 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -3094,7 +3094,7 @@ static int vdev_init(struct bttv *btv, struct video_device *vfd,
 	q->gfp_flags = __GFP_DMA32;
 	q->buf_struct_size = sizeof(struct bttv_buffer);
 	q->lock = &btv->lock;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->dev = &btv->c.pci->dev;
 	err = vb2_queue_init(q);
 	if (err)
diff --git a/drivers/media/pci/cobalt/cobalt-v4l2.c b/drivers/media/pci/cobalt/cobalt-v4l2.c
index 26bf58d17a3d..77ba08ace29f 100644
--- a/drivers/media/pci/cobalt/cobalt-v4l2.c
+++ b/drivers/media/pci/cobalt/cobalt-v4l2.c
@@ -1260,7 +1260,7 @@ static int cobalt_node_register(struct cobalt *cobalt, int node)
 	q->ops = &cobalt_qops;
 	q->mem_ops = &vb2_dma_sg_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->lock = &s->lock;
 	q->dev = &cobalt->pci_dev->dev;
 	vdev->queue = q;
diff --git a/drivers/media/pci/cx18/cx18-streams.c b/drivers/media/pci/cx18/cx18-streams.c
index cfbc4a907802..acc6418db425 100644
--- a/drivers/media/pci/cx18/cx18-streams.c
+++ b/drivers/media/pci/cx18/cx18-streams.c
@@ -287,7 +287,7 @@ static int cx18_stream_init(struct cx18 *cx, int type)
 		s->vidq.ops = &cx18_vb2_qops;
 		s->vidq.mem_ops = &vb2_vmalloc_memops;
 		s->vidq.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-		s->vidq.min_buffers_needed = 2;
+		s->vidq.min_queued_buffers = 2;
 		s->vidq.gfp_flags = GFP_DMA32;
 		s->vidq.dev = &cx->pci_dev->dev;
 		s->vidq.lock = &cx->serialize_lock;
diff --git a/drivers/media/pci/cx23885/cx23885-417.c b/drivers/media/pci/cx23885/cx23885-417.c
index 434677bd4ad1..fdb96f80c036 100644
--- a/drivers/media/pci/cx23885/cx23885-417.c
+++ b/drivers/media/pci/cx23885/cx23885-417.c
@@ -1525,7 +1525,7 @@ int cx23885_417_register(struct cx23885_dev *dev)
 	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
 	q->gfp_flags = GFP_DMA32;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->drv_priv = dev;
 	q->buf_struct_size = sizeof(struct cx23885_buffer);
 	q->ops = &cx23885_qops;
diff --git a/drivers/media/pci/cx23885/cx23885-dvb.c b/drivers/media/pci/cx23885/cx23885-dvb.c
index 7551ca4a322a..3d01cdc4c7f3 100644
--- a/drivers/media/pci/cx23885/cx23885-dvb.c
+++ b/drivers/media/pci/cx23885/cx23885-dvb.c
@@ -2667,7 +2667,7 @@ int cx23885_dvb_register(struct cx23885_tsport *port)
 		q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
 		q->gfp_flags = GFP_DMA32;
-		q->min_buffers_needed = 2;
+		q->min_queued_buffers = 2;
 		q->drv_priv = port;
 		q->buf_struct_size = sizeof(struct cx23885_buffer);
 		q->ops = &dvb_qops;
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index 9af2c5596121..42fdcf992e48 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -1321,7 +1321,7 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
 	q->gfp_flags = GFP_DMA32;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->drv_priv = dev;
 	q->buf_struct_size = sizeof(struct cx23885_buffer);
 	q->ops = &cx23885_video_qops;
@@ -1338,7 +1338,7 @@ int cx23885_video_register(struct cx23885_dev *dev)
 	q->type = V4L2_BUF_TYPE_VBI_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
 	q->gfp_flags = GFP_DMA32;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->drv_priv = dev;
 	q->buf_struct_size = sizeof(struct cx23885_buffer);
 	q->ops = &cx23885_vbi_qops;
diff --git a/drivers/media/pci/cx25821/cx25821-video.c b/drivers/media/pci/cx25821/cx25821-video.c
index 1b80c990cb94..0bee4b728a60 100644
--- a/drivers/media/pci/cx25821/cx25821-video.c
+++ b/drivers/media/pci/cx25821/cx25821-video.c
@@ -730,7 +730,7 @@ int cx25821_video_register(struct cx25821_dev *dev)
 		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 		q->io_modes |= is_output ? VB2_WRITE : VB2_READ;
 		q->gfp_flags = GFP_DMA32;
-		q->min_buffers_needed = 2;
+		q->min_queued_buffers = 2;
 		q->drv_priv = chan;
 		q->buf_struct_size = sizeof(struct cx25821_buffer);
 		q->ops = &cx25821_video_qops;
diff --git a/drivers/media/pci/cx88/cx88-blackbird.c b/drivers/media/pci/cx88/cx88-blackbird.c
index c1b41a9283c1..d55df8fdb3b6 100644
--- a/drivers/media/pci/cx88/cx88-blackbird.c
+++ b/drivers/media/pci/cx88/cx88-blackbird.c
@@ -1195,7 +1195,7 @@ static int cx8802_blackbird_probe(struct cx8802_driver *drv)
 	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
 	q->gfp_flags = GFP_DMA32;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->drv_priv = dev;
 	q->buf_struct_size = sizeof(struct cx88_buffer);
 	q->ops = &blackbird_qops;
diff --git a/drivers/media/pci/cx88/cx88-dvb.c b/drivers/media/pci/cx88/cx88-dvb.c
index 2087f2491c42..b33b3a5e32ec 100644
--- a/drivers/media/pci/cx88/cx88-dvb.c
+++ b/drivers/media/pci/cx88/cx88-dvb.c
@@ -1776,7 +1776,7 @@ static int cx8802_dvb_probe(struct cx8802_driver *drv)
 		q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 		q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
 		q->gfp_flags = GFP_DMA32;
-		q->min_buffers_needed = 2;
+		q->min_queued_buffers = 2;
 		q->drv_priv = dev;
 		q->buf_struct_size = sizeof(struct cx88_buffer);
 		q->ops = &dvb_qops;
diff --git a/drivers/media/pci/cx88/cx88-video.c b/drivers/media/pci/cx88/cx88-video.c
index c0ef03ed74f9..cefb6b25e921 100644
--- a/drivers/media/pci/cx88/cx88-video.c
+++ b/drivers/media/pci/cx88/cx88-video.c
@@ -1411,7 +1411,7 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
 	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
 	q->gfp_flags = GFP_DMA32;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->drv_priv = dev;
 	q->buf_struct_size = sizeof(struct cx88_buffer);
 	q->ops = &cx8800_video_qops;
@@ -1428,7 +1428,7 @@ static int cx8800_initdev(struct pci_dev *pci_dev,
 	q->type = V4L2_BUF_TYPE_VBI_CAPTURE;
 	q->io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF | VB2_READ;
 	q->gfp_flags = GFP_DMA32;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->drv_priv = dev;
 	q->buf_struct_size = sizeof(struct cx88_buffer);
 	q->ops = &cx8800_vbi_qops;
diff --git a/drivers/media/pci/dt3155/dt3155.c b/drivers/media/pci/dt3155/dt3155.c
index d09cde2f6ee4..dff853e73fdc 100644
--- a/drivers/media/pci/dt3155/dt3155.c
+++ b/drivers/media/pci/dt3155/dt3155.c
@@ -517,7 +517,7 @@ static int dt3155_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pd->vidq.ops = &q_ops;
 	pd->vidq.mem_ops = &vb2_dma_contig_memops;
 	pd->vidq.drv_priv = pd;
-	pd->vidq.min_buffers_needed = 2;
+	pd->vidq.min_queued_buffers = 2;
 	pd->vidq.gfp_flags = GFP_DMA32;
 	pd->vidq.lock = &pd->mux; /* for locking v4l2_file_operations */
 	pd->vidq.dev = &pdev->dev;
diff --git a/drivers/media/pci/mgb4/mgb4_vin.c b/drivers/media/pci/mgb4/mgb4_vin.c
index d72b07b87cd1..2cd78c539889 100644
--- a/drivers/media/pci/mgb4/mgb4_vin.c
+++ b/drivers/media/pci/mgb4/mgb4_vin.c
@@ -849,7 +849,7 @@ struct mgb4_vin_dev *mgb4_vin_create(struct mgb4_dev *mgbdev, int id)
 	vindev->queue.mem_ops = &vb2_dma_sg_memops;
 	vindev->queue.gfp_flags = GFP_DMA32;
 	vindev->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	vindev->queue.min_buffers_needed = 2;
+	vindev->queue.min_queued_buffers = 2;
 	vindev->queue.drv_priv = vindev;
 	vindev->queue.lock = &vindev->lock;
 	vindev->queue.dev = dev;
diff --git a/drivers/media/pci/mgb4/mgb4_vout.c b/drivers/media/pci/mgb4/mgb4_vout.c
index 857fc7bbd21a..241353ee77a5 100644
--- a/drivers/media/pci/mgb4/mgb4_vout.c
+++ b/drivers/media/pci/mgb4/mgb4_vout.c
@@ -523,7 +523,7 @@ struct mgb4_vout_dev *mgb4_vout_create(struct mgb4_dev *mgbdev, int id)
 	voutdev->queue.mem_ops = &vb2_dma_sg_memops;
 	voutdev->queue.gfp_flags = GFP_DMA32;
 	voutdev->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	voutdev->queue.min_buffers_needed = 2;
+	voutdev->queue.min_queued_buffers = 2;
 	voutdev->queue.drv_priv = voutdev;
 	voutdev->queue.lock = &voutdev->lock;
 	voutdev->queue.dev = dev;
diff --git a/drivers/media/pci/tw5864/tw5864-video.c b/drivers/media/pci/tw5864/tw5864-video.c
index 197ed8978102..8b1aae4b6319 100644
--- a/drivers/media/pci/tw5864/tw5864-video.c
+++ b/drivers/media/pci/tw5864/tw5864-video.c
@@ -1114,7 +1114,7 @@ static int tw5864_video_input_init(struct tw5864_input *input, int video_nr)
 	input->vidq.gfp_flags = 0;
 	input->vidq.buf_struct_size = sizeof(struct tw5864_buf);
 	input->vidq.lock = &input->lock;
-	input->vidq.min_buffers_needed = 2;
+	input->vidq.min_queued_buffers = 2;
 	input->vidq.dev = &input->root->pci->dev;
 	ret = vb2_queue_init(&input->vidq);
 	if (ret)
diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
index 79b627ebc92a..cdf5d733b863 100644
--- a/drivers/media/pci/tw68/tw68-video.c
+++ b/drivers/media/pci/tw68/tw68-video.c
@@ -952,7 +952,7 @@ int tw68_video_init2(struct tw68_dev *dev, int video_nr)
 	dev->vidq.gfp_flags = __GFP_DMA32 | __GFP_KSWAPD_RECLAIM;
 	dev->vidq.buf_struct_size = sizeof(struct tw68_buf);
 	dev->vidq.lock = &dev->lock;
-	dev->vidq.min_buffers_needed = 2;
+	dev->vidq.min_queued_buffers = 2;
 	dev->vidq.dev = &dev->pci->dev;
 	ret = vb2_queue_init(&dev->vidq);
 	if (ret)
diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw686x/tw686x-video.c
index 6bc6d143d18c..63be95fce83d 100644
--- a/drivers/media/pci/tw686x/tw686x-video.c
+++ b/drivers/media/pci/tw686x/tw686x-video.c
@@ -1222,7 +1222,7 @@ int tw686x_video_init(struct tw686x_dev *dev)
 		vc->vidq.ops = &tw686x_video_qops;
 		vc->vidq.mem_ops = dev->dma_ops->mem_ops;
 		vc->vidq.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-		vc->vidq.min_buffers_needed = 2;
+		vc->vidq.min_queued_buffers = 2;
 		vc->vidq.lock = &vc->vb_mutex;
 		vc->vidq.gfp_flags = dev->dma_mode != TW686X_DMA_MODE_MEMCPY ?
 				     GFP_DMA32 : 0;
diff --git a/drivers/media/pci/zoran/zoran_driver.c b/drivers/media/pci/zoran/zoran_driver.c
index fa672cc8bc67..2c91f75e8d79 100644
--- a/drivers/media/pci/zoran/zoran_driver.c
+++ b/drivers/media/pci/zoran/zoran_driver.c
@@ -749,9 +749,6 @@ static int zr_vb2_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers, unsi
 
 	zr->buf_in_reserve = 0;
 
-	if (*nbuffers < vq->min_buffers_needed)
-		*nbuffers = vq->min_buffers_needed;
-
 	if (*nplanes) {
 		if (sizes[0] < size)
 			return -EINVAL;
@@ -971,7 +968,7 @@ int zoran_queue_init(struct zoran *zr, struct vb2_queue *vq, int dir)
 	vq->mem_ops = &vb2_dma_contig_memops;
 	vq->gfp_flags = GFP_DMA32;
 	vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	vq->min_buffers_needed = 9;
+	vq->min_queued_buffers = 9;
 	vq->lock = &zr->lock;
 	err = vb2_queue_init(vq);
 	if (err)
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
index 49bca2b01cc6..4091f1c0e78b 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
@@ -1453,7 +1453,7 @@ int mxc_isi_video_register(struct mxc_isi_pipe *pipe,
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->buf_struct_size = sizeof(struct mxc_isi_buffer);
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->lock = &video->lock;
 	q->dev = pipe->isi->dev;
 
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
index 2a77353f10b5..e2c40abc6d3d 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
@@ -1559,7 +1559,7 @@ int rvin_dma_register(struct rvin_dev *vin, int irq)
 	q->ops = &rvin_qops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 4;
+	q->min_queued_buffers = 4;
 	q->dev = vin->dev;
 
 	ret = vb2_queue_init(q);
diff --git a/drivers/media/platform/renesas/renesas-ceu.c b/drivers/media/platform/renesas/renesas-ceu.c
index 2562b30acfb9..167760276796 100644
--- a/drivers/media/platform/renesas/renesas-ceu.c
+++ b/drivers/media/platform/renesas/renesas-ceu.c
@@ -1399,7 +1399,7 @@ static int ceu_notify_complete(struct v4l2_async_notifier *notifier)
 	q->mem_ops		= &vb2_dma_contig_memops;
 	q->buf_struct_size	= sizeof(struct ceu_buffer);
 	q->timestamp_flags	= V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed	= 2;
+	q->min_queued_buffers	= 2;
 	q->lock			= &ceudev->mlock;
 	q->dev			= ceudev->v4l2_dev.dev;
 
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index e6eedd65b71d..d0ffa90bc656 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -767,7 +767,7 @@ int rzg2l_cru_dma_register(struct rzg2l_cru_dev *cru)
 	q->ops = &rzg2l_cru_qops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 4;
+	q->min_queued_buffers = 4;
 	q->dev = cru->dev;
 
 	ret = vb2_queue_init(q);
diff --git a/drivers/media/platform/renesas/sh_vou.c b/drivers/media/platform/renesas/sh_vou.c
index f792aedc9d82..1e74dd601c2b 100644
--- a/drivers/media/platform/renesas/sh_vou.c
+++ b/drivers/media/platform/renesas/sh_vou.c
@@ -1297,7 +1297,7 @@ static int sh_vou_probe(struct platform_device *pdev)
 	q->ops = &sh_vou_qops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->lock = &vou_dev->fop_lock;
 	q->dev = &pdev->dev;
 	ret = vb2_queue_init(q);
diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index 48140fdf40bb..c4610e305546 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -2031,7 +2031,7 @@ static int dcmi_probe(struct platform_device *pdev)
 	q->ops = &dcmi_video_qops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->allow_cache_hints = 1;
 	q->dev = &pdev->dev;
 
diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 1e2369f104c8..167ffe764a41 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -184,7 +184,7 @@ static void process_num_buffers(struct vb2_queue *q,
 	 * we need all of them to be queued into the driver
 	 */
 	sess->num_dst_bufs = q_num_bufs + *num_buffers;
-	q->min_buffers_needed = max(fmt_out->min_buffers, sess->num_dst_bufs);
+	q->min_queued_buffers = max(fmt_out->min_buffers, sess->num_dst_bufs);
 }
 
 static int vdec_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
@@ -825,7 +825,6 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->mem_ops = &vb2_dma_contig_memops;
 	src_vq->drv_priv = sess;
 	src_vq->buf_struct_size = sizeof(struct dummy_buf);
-	src_vq->min_buffers_needed = 1;
 	src_vq->dev = sess->core->dev;
 	src_vq->lock = &sess->lock;
 	ret = vb2_queue_init(src_vq);
@@ -839,7 +838,6 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->mem_ops = &vb2_dma_contig_memops;
 	dst_vq->drv_priv = sess;
 	dst_vq->buf_struct_size = sizeof(struct dummy_buf);
-	dst_vq->min_buffers_needed = 1;
 	dst_vq->dev = sess->core->dev;
 	dst_vq->lock = &sess->lock;
 	return vb2_queue_init(dst_vq);
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
index 1595a9607775..0eea4c2c3627 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
@@ -660,7 +660,7 @@ int sun6i_isp_capture_setup(struct sun6i_isp_device *isp_dev)
 	queue->buf_struct_size = sizeof(struct sun6i_isp_buffer);
 	queue->ops = &sun6i_isp_capture_queue_ops;
 	queue->mem_ops = &vb2_dma_contig_memops;
-	queue->min_buffers_needed = 2;
+	queue->min_queued_buffers = 2;
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->lock = &capture->lock;
 	queue->dev = isp_dev->dev;
diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
index e28be895b486..53d05e8a364b 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
@@ -489,7 +489,7 @@ int sun6i_isp_params_setup(struct sun6i_isp_device *isp_dev)
 	queue->buf_struct_size = sizeof(struct sun6i_isp_buffer);
 	queue->ops = &sun6i_isp_params_queue_ops;
 	queue->mem_ops = &vb2_vmalloc_memops;
-	queue->min_buffers_needed = 1;
+	queue->min_queued_buffers = 1;
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->lock = &params->lock;
 	queue->dev = isp_dev->dev;
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 17cacd696ab4..e8fda582f0d1 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -546,13 +546,15 @@ struct vb2_buf_ops {
  * @gfp_flags:	additional gfp flags used when allocating the buffers.
  *		Typically this is 0, but it may be e.g. %GFP_DMA or %__GFP_DMA32
  *		to force the buffer allocation to a specific memory zone.
- * @min_buffers_needed: the minimum number of buffers needed before
+ * @min_queued_buffers: the minimum number of queued buffers needed before
  *		@start_streaming can be called. Used when a DMA engine
  *		cannot be started unless at least this number of buffers
  *		have been queued into the driver.
  * @min_reqbufs_allocation: the minimum number of buffers allocated when
  *		calling VIDIOC_REQBUFS. Used when drivers need a to
  *		specify a minimum buffers allocation before setup a queue.
+ *		If set to 0 then min_queued_buffers + 1 value is used
+ *		as minimum numbers of buffers value.
  */
 /*
  * Private elements (won't appear at the uAPI book):
@@ -617,7 +619,7 @@ struct vb2_queue {
 	unsigned int			buf_struct_size;
 	u32				timestamp_flags;
 	gfp_t				gfp_flags;
-	u32				min_buffers_needed;
+	u32				min_queued_buffers;
 	u32				min_reqbufs_allocation;
 
 	struct device			*alloc_devs[VB2_MAX_PLANES];
diff --git a/samples/v4l/v4l2-pci-skeleton.c b/samples/v4l/v4l2-pci-skeleton.c
index a65aa9d1e9da..4fe8f58b270f 100644
--- a/samples/v4l/v4l2-pci-skeleton.c
+++ b/samples/v4l/v4l2-pci-skeleton.c
@@ -821,7 +821,7 @@ static int skeleton_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * available before it can be started. The start_streaming() op
 	 * won't be called until at least this many buffers are queued up.
 	 */
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	/*
 	 * The serialization lock for the streaming ioctls. This is the same
 	 * as the main serialization lock, but if some of the non-streaming
-- 
2.39.2

