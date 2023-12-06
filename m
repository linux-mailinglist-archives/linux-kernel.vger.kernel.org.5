Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87FD806A32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377141AbjLFI42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:56:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A0B1B712;
        Wed,  6 Dec 2023 00:56:19 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB30C6607328;
        Wed,  6 Dec 2023 08:56:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701852977;
        bh=TgI3qKyXQE4nJ0neaxYowY3Ze86kUKNRWqmF0RW0Np0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+qL49y+Vc1ickyATWCNuVD4s/Ypfau460Ke5QCc/8BOWJvd/phbYINCGeGTBzbUR
         5vsggI8hqnvjp5+QUrFiNZ/qosDzNMXSXKWyeUOE5iznmkcEneUJkC9H873FUeEi9o
         VjJaIFTtRSkW18t3ZtBSTnHxA1m80i3mRtTos+lTo410BBkNvmZX1tb1kY7nqmwtQw
         sLRju+Und5VjS9XgaJ70GTTchvA6fKLcOA1zD98I9adewx8K3aMi+EjekkTeq37XO/
         g8o7FR0tagukXp3/obmg4USoTwZTEToP4YDtmEge1gljfkJkQJSjcA9046Vjcv0V8N
         O+HDihXVrnsgA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 1/2] videobuf2: core: Rename min_buffers_needed field to vb2_queue
Date:   Wed,  6 Dec 2023 09:56:07 +0100
Message-Id: <20231206085608.33246-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206085608.33246-1-benjamin.gaignard@collabora.com>
References: <20231206085608.33246-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename min_buffers_needed into min_queued_buffers and update
the documentation about it.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c      |  2 +-
 drivers/input/touchscreen/sur40.c             |  2 +-
 drivers/media/common/saa7146/saa7146_fops.c   |  2 +-
 .../media/common/videobuf2/videobuf2-core.c   | 22 +++++++++----------
 drivers/media/dvb-core/dvb_vb2.c              |  2 +-
 drivers/media/i2c/video-i2c.c                 |  2 +-
 drivers/media/pci/bt8xx/bttv-driver.c         |  2 +-
 drivers/media/pci/cobalt/cobalt-v4l2.c        |  2 +-
 drivers/media/pci/cx18/cx18-streams.c         |  2 +-
 drivers/media/pci/cx23885/cx23885-417.c       |  2 +-
 drivers/media/pci/cx23885/cx23885-dvb.c       |  2 +-
 drivers/media/pci/cx23885/cx23885-video.c     |  4 ++--
 drivers/media/pci/cx25821/cx25821-video.c     |  2 +-
 drivers/media/pci/cx88/cx88-blackbird.c       |  2 +-
 drivers/media/pci/cx88/cx88-dvb.c             |  2 +-
 drivers/media/pci/cx88/cx88-video.c           |  4 ++--
 drivers/media/pci/dt3155/dt3155.c             |  2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c      |  2 +-
 drivers/media/pci/mgb4/mgb4_vin.c             |  2 +-
 drivers/media/pci/mgb4/mgb4_vout.c            |  2 +-
 drivers/media/pci/tw5864/tw5864-video.c       |  2 +-
 drivers/media/pci/tw68/tw68-video.c           |  2 +-
 drivers/media/pci/tw686x/tw686x-video.c       |  2 +-
 drivers/media/pci/zoran/zoran_driver.c        |  5 +----
 drivers/media/platform/amphion/vpu_v4l2.c     |  4 ++--
 drivers/media/platform/aspeed/aspeed-video.c  |  2 +-
 drivers/media/platform/atmel/atmel-isi.c      |  2 +-
 .../platform/chips-media/coda/coda-common.c   |  2 +-
 .../platform/microchip/microchip-isc-base.c   |  2 +-
 drivers/media/platform/nuvoton/npcm-video.c   |  2 +-
 drivers/media/platform/nxp/imx7-media-csi.c   |  2 +-
 .../platform/nxp/imx8-isi/imx8-isi-video.c    |  2 +-
 drivers/media/platform/qcom/venus/vdec.c      |  4 ++--
 drivers/media/platform/qcom/venus/venc.c      |  4 ++--
 .../platform/renesas/rcar-vin/rcar-dma.c      |  2 +-
 drivers/media/platform/renesas/renesas-ceu.c  |  2 +-
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  |  2 +-
 drivers/media/platform/renesas/sh_vou.c       |  2 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c |  2 +-
 drivers/media/platform/st/sti/hva/hva-v4l2.c  |  4 ++--
 drivers/media/platform/st/stm32/stm32-dcmi.c  |  2 +-
 .../st/stm32/stm32-dcmipp/dcmipp-bytecap.c    |  4 ++--
 .../platform/sunxi/sun4i-csi/sun4i_dma.c      |  2 +-
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       |  2 +-
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  |  4 ++--
 .../sunxi/sun8i-rotate/sun8i_rotate.c         |  4 ++--
 .../media/platform/ti/am437x/am437x-vpfe.c    |  2 +-
 drivers/media/platform/ti/cal/cal-video.c     |  2 +-
 .../media/platform/ti/davinci/vpif_capture.c  |  2 +-
 .../media/platform/ti/davinci/vpif_display.c  |  2 +-
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   |  2 +-
 drivers/media/platform/ti/omap/omap_vout.c    |  2 +-
 .../media/test-drivers/vimc/vimc-capture.c    |  2 +-
 drivers/media/test-drivers/vivid/vivid-core.c |  2 +-
 drivers/media/usb/cx231xx/cx231xx-417.c       |  2 +-
 drivers/media/usb/cx231xx/cx231xx-video.c     |  4 ++--
 drivers/media/usb/dvb-usb/cxusb-analog.c      |  2 +-
 drivers/media/usb/gspca/gspca.c               |  6 ++---
 .../media/deprecated/atmel/atmel-isc-base.c   |  2 +-
 drivers/staging/media/imx/imx-media-capture.c |  2 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c        |  2 +-
 drivers/staging/media/meson/vdec/vdec.c       |  4 +---
 .../staging/media/starfive/camss/stf-video.c  |  2 +-
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c |  2 +-
 .../media/sunxi/sun6i-isp/sun6i_isp_params.c  |  2 +-
 drivers/staging/media/tegra-video/vi.c        |  2 +-
 include/media/videobuf2-core.h                |  4 ++--
 samples/v4l/v4l2-pci-skeleton.c               |  2 +-
 68 files changed, 91 insertions(+), 96 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 20094b9899f0..a2c4b3b87f93 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2546,7 +2546,7 @@ static const struct vb2_queue mxt_queue = {
 	.ops = &mxt_queue_ops,
 	.mem_ops = &vb2_vmalloc_memops,
 	.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC,
-	.min_buffers_needed = 1,
+	.min_queued_buffers = 1,
 };
 
 static int mxt_vidioc_querycap(struct file *file, void *priv,
diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index e7d2a52169a0..ae3aab428337 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -1124,7 +1124,7 @@ static const struct vb2_queue sur40_queue = {
 	.ops = &sur40_queue_ops,
 	.mem_ops = &vb2_dma_sg_memops,
 	.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC,
-	.min_buffers_needed = 3,
+	.min_queued_buffers = 3,
 };
 
 static const struct v4l2_file_operations sur40_video_fops = {
diff --git a/drivers/media/common/saa7146/saa7146_fops.c b/drivers/media/common/saa7146/saa7146_fops.c
index 79214459387a..a7047e548245 100644
--- a/drivers/media/common/saa7146/saa7146_fops.c
+++ b/drivers/media/common/saa7146/saa7146_fops.c
@@ -387,7 +387,7 @@ int saa7146_register_device(struct video_device *vfd, struct saa7146_dev *dev,
 	q->gfp_flags = __GFP_DMA32;
 	q->buf_struct_size = sizeof(struct saa7146_buf);
 	q->lock = &dev->v4l2_lock;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->dev = &dev->pci->dev;
 	err = vb2_queue_init(q);
 	if (err)
diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 8c1df829745b..7b6d89641e66 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -865,7 +865,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	/*
 	 * Make sure the requested values and current defaults are sane.
 	 */
-	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
+	num_buffers = max_t(unsigned int, *count, q->min_queued_buffers);
 	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
 	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
 	/*
@@ -917,7 +917,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * There is no point in continuing if we can't allocate the minimum
 	 * number of buffers needed by this vb2_queue.
 	 */
-	if (allocated_buffers < q->min_buffers_needed)
+	if (allocated_buffers < q->min_queued_buffers)
 		ret = -ENOMEM;
 
 	/*
@@ -1653,7 +1653,7 @@ EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
  * @q:		videobuf2 queue
  *
  * Attempt to start streaming. When this function is called there must be
- * at least q->min_buffers_needed buffers queued up (i.e. the minimum
+ * at least q->min_queued_buffers queued up (i.e. the minimum
  * number of buffers required for the DMA engine to function). If the
  * @start_streaming op fails it is supposed to return all the driver-owned
  * buffers back to vb2 in state QUEUED. Check if that happened and if
@@ -1846,7 +1846,7 @@ int vb2_core_qbuf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb,
 	 * then we can finally call start_streaming().
 	 */
 	if (q->streaming && !q->start_streaming_called &&
-	    q->queued_count >= q->min_buffers_needed) {
+	    q->queued_count >= q->min_queued_buffers) {
 		ret = vb2_start_streaming(q);
 		if (ret) {
 			/*
@@ -2210,9 +2210,9 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
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
 
@@ -2224,7 +2224,7 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
 	 * Tell driver to start streaming provided sufficient buffers
 	 * are available.
 	 */
-	if (q->queued_count >= q->min_buffers_needed) {
+	if (q->queued_count >= q->min_queued_buffers) {
 		ret = vb2_start_streaming(q);
 		if (ret)
 			goto unprepare;
@@ -2504,7 +2504,7 @@ int vb2_core_queue_init(struct vb2_queue *q)
 		return -EINVAL;
 
 	if (WARN_ON(q->max_num_buffers > MAX_BUFFER_INDEX) ||
-	    WARN_ON(q->min_buffers_needed > q->max_num_buffers))
+	    WARN_ON(q->min_queued_buffers > q->max_num_buffers))
 		return -EINVAL;
 
 	if (WARN_ON(q->requires_requests && !q->supports_requests))
@@ -2512,13 +2512,13 @@ int vb2_core_queue_init(struct vb2_queue *q)
 
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
diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
index 167ff82a6fed..192a8230c4aa 100644
--- a/drivers/media/dvb-core/dvb_vb2.c
+++ b/drivers/media/dvb-core/dvb_vb2.c
@@ -171,7 +171,7 @@ int dvb_vb2_init(struct dvb_vb2_ctx *ctx, const char *name, int nonblocking)
 	q->io_modes = VB2_MMAP;
 	q->drv_priv = ctx;
 	q->buf_struct_size = sizeof(struct dvb_buffer);
-	q->min_buffers_needed = 1;
+	q->min_queued_buffers = 1;
 	q->ops = &dvb_vb2_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->buf_ops = &dvb_vb2_buf_ops;
diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index ebf2ac98a068..56dbe07a1c99 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -795,7 +795,7 @@ static int video_i2c_probe(struct i2c_client *client)
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->drv_priv = data;
 	queue->buf_struct_size = sizeof(struct video_i2c_buffer);
-	queue->min_buffers_needed = 1;
+	queue->min_queued_buffers = 1;
 	queue->ops = &video_i2c_video_qops;
 	queue->mem_ops = &vb2_vmalloc_memops;
 
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
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 5d3b0ffd3d08..ed08bf4178f0 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1589,7 +1589,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	vbq->mem_ops = &vb2_dma_sg_memops;
 	vbq->buf_struct_size = sizeof(struct cio2_buffer);
 	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	vbq->min_buffers_needed = 1;
+	vbq->min_queued_buffers = 1;
 	vbq->drv_priv = cio2;
 	vbq->lock = &q->lock;
 	r = vb2_queue_init(vbq);
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
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 87afb4a18d5d..7058a3046292 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -649,7 +649,7 @@ static int vpu_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_q
 		src_vq->mem_ops = &vb2_vmalloc_memops;
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
-	src_vq->min_buffers_needed = 1;
+	src_vq->min_queued_buffers = 1;
 	src_vq->dev = inst->vpu->dev;
 	src_vq->lock = &inst->lock;
 	ret = vb2_queue_init(src_vq);
@@ -666,7 +666,7 @@ static int vpu_m2m_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_q
 		dst_vq->mem_ops = &vb2_vmalloc_memops;
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct vpu_vb2_buffer);
-	dst_vq->min_buffers_needed = 1;
+	dst_vq->min_queued_buffers = 1;
 	dst_vq->dev = inst->vpu->dev;
 	dst_vq->lock = &inst->lock;
 	ret = vb2_queue_init(dst_vq);
diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index d08aa7f73d4f..fc6050e3be0d 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -2034,7 +2034,7 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
 	vbq->drv_priv = video;
 	vbq->buf_struct_size = sizeof(struct aspeed_video_buffer);
 	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	vbq->min_buffers_needed = ASPEED_VIDEO_V4L2_MIN_BUF_REQ;
+	vbq->min_queued_buffers = ASPEED_VIDEO_V4L2_MIN_BUF_REQ;
 
 	rc = vb2_queue_init(vbq);
 	if (rc) {
diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index da58f33b6b0a..a442765193ef 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1244,7 +1244,7 @@ static int atmel_isi_probe(struct platform_device *pdev)
 	q->ops = &isi_video_qops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->dev = &pdev->dev;
 
 	ret = vb2_queue_init(q);
diff --git a/drivers/media/platform/chips-media/coda/coda-common.c b/drivers/media/platform/chips-media/coda/coda-common.c
index f1d85758f6dd..7da0194ec850 100644
--- a/drivers/media/platform/chips-media/coda/coda-common.c
+++ b/drivers/media/platform/chips-media/coda/coda-common.c
@@ -2546,7 +2546,7 @@ static int coda_queue_init(struct coda_ctx *ctx, struct vb2_queue *vq)
 	 * would need to be reflected in job_ready(). Currently we expect all
 	 * queues to have at least one buffer queued.
 	 */
-	vq->min_buffers_needed = 1;
+	vq->min_queued_buffers = 1;
 	vq->dev = ctx->dev->dev;
 
 	return vb2_queue_init(vq);
diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 540cb1378289..f3a5cbacadbe 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1780,7 +1780,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	q->mem_ops		= &vb2_dma_contig_memops;
 	q->timestamp_flags	= V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock			= &isc->lock;
-	q->min_buffers_needed	= 1;
+	q->min_queued_buffers	= 1;
 	q->dev			= isc->dev;
 
 	ret = vb2_queue_init(q);
diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
index 267e301f2b26..a1fcb616b256 100644
--- a/drivers/media/platform/nuvoton/npcm-video.c
+++ b/drivers/media/platform/nuvoton/npcm-video.c
@@ -1612,7 +1612,7 @@ static int npcm_video_setup_video(struct npcm_video *video)
 	vbq->drv_priv = video;
 	vbq->buf_struct_size = sizeof(struct npcm_video_buffer);
 	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	vbq->min_buffers_needed = 3;
+	vbq->min_queued_buffers = 3;
 
 	rc = vb2_queue_init(vbq);
 	if (rc) {
diff --git a/drivers/media/platform/nxp/imx7-media-csi.c b/drivers/media/platform/nxp/imx7-media-csi.c
index 651151da3ab4..0ea87eb21b5d 100644
--- a/drivers/media/platform/nxp/imx7-media-csi.c
+++ b/drivers/media/platform/nxp/imx7-media-csi.c
@@ -1676,7 +1676,7 @@ static int imx7_csi_video_init(struct imx7_csi *csi)
 	vq->mem_ops = &vb2_dma_contig_memops;
 	vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	vq->lock = &csi->vdev_mutex;
-	vq->min_buffers_needed = 2;
+	vq->min_queued_buffers = 2;
 	vq->dev = csi->dev;
 
 	ret = vb2_queue_init(vq);
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
 
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index dbf305cec120..29130a9441e7 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1641,7 +1641,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct venus_buffer);
 	src_vq->allow_zero_bytesused = 1;
-	src_vq->min_buffers_needed = 0;
+	src_vq->min_queued_buffers = 0;
 	src_vq->dev = inst->core->dev;
 	src_vq->lock = &inst->ctx_q_lock;
 	ret = vb2_queue_init(src_vq);
@@ -1656,7 +1656,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct venus_buffer);
 	dst_vq->allow_zero_bytesused = 1;
-	dst_vq->min_buffers_needed = 0;
+	dst_vq->min_queued_buffers = 0;
 	dst_vq->dev = inst->core->dev;
 	dst_vq->lock = &inst->ctx_q_lock;
 	return vb2_queue_init(dst_vq);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 44b13696cf82..3ec2fb8d9fab 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -1398,7 +1398,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->drv_priv = inst;
 	src_vq->buf_struct_size = sizeof(struct venus_buffer);
 	src_vq->allow_zero_bytesused = 1;
-	src_vq->min_buffers_needed = 1;
+	src_vq->min_queued_buffers = 1;
 	src_vq->dev = inst->core->dev;
 	src_vq->lock = &inst->ctx_q_lock;
 	if (inst->core->res->hfi_version == HFI_VERSION_1XX)
@@ -1415,7 +1415,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->drv_priv = inst;
 	dst_vq->buf_struct_size = sizeof(struct venus_buffer);
 	dst_vq->allow_zero_bytesused = 1;
-	dst_vq->min_buffers_needed = 1;
+	dst_vq->min_queued_buffers = 1;
 	dst_vq->dev = inst->core->dev;
 	dst_vq->lock = &inst->ctx_q_lock;
 	return vb2_queue_init(dst_vq);
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
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index c6d7e01c8949..aebd3c12020b 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -1431,7 +1431,7 @@ static int rkisp1_register_capture(struct rkisp1_capture *cap)
 	q->ops = &rkisp1_vb2_ops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->buf_struct_size = sizeof(struct rkisp1_buffer);
-	q->min_buffers_needed = RKISP1_MIN_BUFFERS_NEEDED;
+	q->min_queued_buffers = RKISP1_MIN_BUFFERS_NEEDED;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock = &node->vlock;
 	q->dev = cap->rkisp1->dev;
diff --git a/drivers/media/platform/st/sti/hva/hva-v4l2.c b/drivers/media/platform/st/sti/hva/hva-v4l2.c
index cfe83e9dc01b..161a5c0fbc4e 100644
--- a/drivers/media/platform/st/sti/hva/hva-v4l2.c
+++ b/drivers/media/platform/st/sti/hva/hva-v4l2.c
@@ -1142,7 +1142,7 @@ static int hva_queue_init(void *priv, struct vb2_queue *src_vq,
 
 	src_vq->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
 	src_vq->buf_struct_size = sizeof(struct hva_frame);
-	src_vq->min_buffers_needed = MIN_FRAMES;
+	src_vq->min_queued_buffers = MIN_FRAMES;
 	src_vq->dev = ctx->hva_dev->dev;
 
 	ret = queue_init(ctx, src_vq);
@@ -1151,7 +1151,7 @@ static int hva_queue_init(void *priv, struct vb2_queue *src_vq,
 
 	dst_vq->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
 	dst_vq->buf_struct_size = sizeof(struct hva_stream);
-	dst_vq->min_buffers_needed = MIN_STREAMS;
+	dst_vq->min_queued_buffers = MIN_STREAMS;
 	dst_vq->dev = ctx->hva_dev->dev;
 
 	return queue_init(ctx, dst_vq);
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
 
diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
index 0cd9b088bd97..9f768f011fa2 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
@@ -424,7 +424,7 @@ static int dcmipp_bytecap_start_streaming(struct vb2_queue *vq,
 	reg_set(vcap, DCMIPP_P0FSCR, DCMIPP_P0FSCR_PIPEN);
 
 	/*
-	 * vb2 framework guarantee that we have at least 'min_buffers_needed'
+	 * vb2 framework guarantee that we have at least 'min_queued_buffers'
 	 * buffers in the list at this moment
 	 */
 	vcap->next = list_first_entry(&vcap->buffers, typeof(*buf), list);
@@ -889,7 +889,7 @@ struct dcmipp_ent_device *dcmipp_bytecap_ent_init(struct device *dev,
 	q->ops = &dcmipp_bytecap_qops;
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 1;
+	q->min_queued_buffers = 1;
 	q->dev = dev;
 
 	/* DCMIPP requires 16 bytes aligned buffers */
diff --git a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
index 95b5633b7914..d1371e130113 100644
--- a/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
+++ b/drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c
@@ -411,7 +411,7 @@ int sun4i_csi_dma_register(struct sun4i_csi *csi, int irq)
 	for (i = 0; i < CSI_MAX_BUFFER; i++)
 		csi->current_buf[i] = NULL;
 
-	q->min_buffers_needed = 3;
+	q->min_queued_buffers = 3;
 	q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	q->io_modes = VB2_MMAP | VB2_DMABUF;
 	q->lock = &csi->lock;
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index cf6aadbc130b..14c0dc827c52 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -1010,7 +1010,7 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 	queue->buf_struct_size = sizeof(struct sun6i_csi_buffer);
 	queue->ops = &sun6i_csi_capture_queue_ops;
 	queue->mem_ops = &vb2_dma_contig_memops;
-	queue->min_buffers_needed = 2;
+	queue->min_queued_buffers = 2;
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->lock = &capture->lock;
 	queue->dev = csi_dev->dev;
diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index 90ab1d77b6a5..954fabec27f6 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -673,7 +673,7 @@ static int deinterlace_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	src_vq->drv_priv = ctx;
 	src_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
-	src_vq->min_buffers_needed = 1;
+	src_vq->min_queued_buffers = 1;
 	src_vq->ops = &deinterlace_qops;
 	src_vq->mem_ops = &vb2_dma_contig_memops;
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
@@ -688,7 +688,7 @@ static int deinterlace_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	dst_vq->drv_priv = ctx;
 	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
-	dst_vq->min_buffers_needed = 2;
+	dst_vq->min_queued_buffers = 2;
 	dst_vq->ops = &deinterlace_qops;
 	dst_vq->mem_ops = &vb2_dma_contig_memops;
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
diff --git a/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c b/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
index 0b025ec91826..a12323ca89fa 100644
--- a/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
+++ b/drivers/media/platform/sunxi/sun8i-rotate/sun8i_rotate.c
@@ -536,7 +536,7 @@ static int rotate_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	src_vq->drv_priv = ctx;
 	src_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
-	src_vq->min_buffers_needed = 1;
+	src_vq->min_queued_buffers = 1;
 	src_vq->ops = &rotate_qops;
 	src_vq->mem_ops = &vb2_dma_contig_memops;
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
@@ -551,7 +551,7 @@ static int rotate_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->io_modes = VB2_MMAP | VB2_DMABUF;
 	dst_vq->drv_priv = ctx;
 	dst_vq->buf_struct_size = sizeof(struct v4l2_m2m_buffer);
-	dst_vq->min_buffers_needed = 2;
+	dst_vq->min_queued_buffers = 2;
 	dst_vq->ops = &rotate_qops;
 	dst_vq->mem_ops = &vb2_dma_contig_memops;
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
diff --git a/drivers/media/platform/ti/am437x/am437x-vpfe.c b/drivers/media/platform/ti/am437x/am437x-vpfe.c
index f18acf9286a2..77e12457d149 100644
--- a/drivers/media/platform/ti/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/ti/am437x/am437x-vpfe.c
@@ -2234,7 +2234,7 @@ static int vpfe_probe_complete(struct vpfe_device *vpfe)
 	q->buf_struct_size = sizeof(struct vpfe_cap_buffer);
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock = &vpfe->lock;
-	q->min_buffers_needed = 1;
+	q->min_queued_buffers = 1;
 	q->dev = vpfe->pdev;
 
 	err = vb2_queue_init(q);
diff --git a/drivers/media/platform/ti/cal/cal-video.c b/drivers/media/platform/ti/cal/cal-video.c
index e1c5e68e945b..e1ba5dfc217e 100644
--- a/drivers/media/platform/ti/cal/cal-video.c
+++ b/drivers/media/platform/ti/cal/cal-video.c
@@ -1010,7 +1010,7 @@ int cal_ctx_v4l2_init(struct cal_ctx *ctx)
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock = &ctx->mutex;
-	q->min_buffers_needed = 3;
+	q->min_queued_buffers = 3;
 	q->dev = ctx->cal->dev;
 
 	ret = vb2_queue_init(q);
diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index fc42b4bc37e6..c31a5566fc5a 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1429,7 +1429,7 @@ static int vpif_probe_complete(void)
 		q->mem_ops = &vb2_dma_contig_memops;
 		q->buf_struct_size = sizeof(struct vpif_cap_buffer);
 		q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-		q->min_buffers_needed = 1;
+		q->min_queued_buffers = 1;
 		q->lock = &common->lock;
 		q->dev = vpif_dev;
 
diff --git a/drivers/media/platform/ti/davinci/vpif_display.c b/drivers/media/platform/ti/davinci/vpif_display.c
index 9dbab1003c1d..02ede1fe12cb 100644
--- a/drivers/media/platform/ti/davinci/vpif_display.c
+++ b/drivers/media/platform/ti/davinci/vpif_display.c
@@ -1169,7 +1169,7 @@ static int vpif_probe_complete(void)
 		q->mem_ops = &vb2_dma_contig_memops;
 		q->buf_struct_size = sizeof(struct vpif_disp_buffer);
 		q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-		q->min_buffers_needed = 1;
+		q->min_queued_buffers = 1;
 		q->lock = &common->lock;
 		q->dev = vpif_dev;
 		err = vb2_queue_init(q);
diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index ada61391c8d2..59b30fc43144 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -873,7 +873,7 @@ static int ti_csi2rx_init_vb2q(struct ti_csi2rx_dev *csi)
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->dev = dmaengine_get_dma_device(csi->dma.chan);
 	q->lock = &csi->mutex;
-	q->min_buffers_needed = 1;
+	q->min_queued_buffers = 1;
 
 	ret = vb2_queue_init(q);
 	if (ret)
diff --git a/drivers/media/platform/ti/omap/omap_vout.c b/drivers/media/platform/ti/omap/omap_vout.c
index 72ce903717d3..1c56b6a87ced 100644
--- a/drivers/media/platform/ti/omap/omap_vout.c
+++ b/drivers/media/platform/ti/omap/omap_vout.c
@@ -1404,7 +1404,7 @@ static int __init omap_vout_setup_video_data(struct omap_vout_device *vout)
 	vq->ops = &omap_vout_vb2_ops;
 	vq->mem_ops = &vb2_dma_contig_memops;
 	vq->lock = &vout->lock;
-	vq->min_buffers_needed = 1;
+	vq->min_queued_buffers = 1;
 	vfd->queue = vq;
 
 	ret = vb2_queue_init(vq);
diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index aa944270e716..2a2d19d23bab 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -432,7 +432,7 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
 	q->mem_ops = vimc_allocator == VIMC_ALLOCATOR_DMA_CONTIG
 		   ? &vb2_dma_contig_memops : &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->lock = &vcapture->lock;
 	q->dev = v4l2_dev->dev;
 
diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 353f035fcd19..b6b010deb143 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -898,7 +898,7 @@ static int vivid_create_queue(struct vivid_dev *dev,
 	q->mem_ops = allocators[dev->inst] == 1 ? &vb2_dma_contig_memops :
 						  &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = supports_requests[dev->inst] ? 0 : min_buffers_needed;
+	q->min_queued_buffers = supports_requests[dev->inst] ? 0 : min_buffers_needed;
 	q->lock = &dev->mutex;
 	q->dev = dev->v4l2_dev.dev;
 	q->supports_requests = supports_requests[dev->inst];
diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index 45973fe690b2..3b75d062e602 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1782,7 +1782,7 @@ int cx231xx_417_register(struct cx231xx *dev)
 	q->ops = &cx231xx_video_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 1;
+	q->min_queued_buffers = 1;
 	q->lock = &dev->lock;
 	err = vb2_queue_init(q);
 	if (err)
diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/cx231xx/cx231xx-video.c
index c8eb4222319d..8f347bbeeb32 100644
--- a/drivers/media/usb/cx231xx/cx231xx-video.c
+++ b/drivers/media/usb/cx231xx/cx231xx-video.c
@@ -1811,7 +1811,7 @@ int cx231xx_register_analog_devices(struct cx231xx *dev)
 	q->ops = &cx231xx_video_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 1;
+	q->min_queued_buffers = 1;
 	q->lock = &dev->lock;
 	ret = vb2_queue_init(q);
 	if (ret)
@@ -1871,7 +1871,7 @@ int cx231xx_register_analog_devices(struct cx231xx *dev)
 	q->ops = &cx231xx_vbi_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 1;
+	q->min_queued_buffers = 1;
 	q->lock = &dev->lock;
 	ret = vb2_queue_init(q);
 	if (ret)
diff --git a/drivers/media/usb/dvb-usb/cxusb-analog.c b/drivers/media/usb/dvb-usb/cxusb-analog.c
index deba5224cb8d..b5d8c6b75ae1 100644
--- a/drivers/media/usb/dvb-usb/cxusb-analog.c
+++ b/drivers/media/usb/dvb-usb/cxusb-analog.c
@@ -1632,7 +1632,7 @@ static int cxusb_medion_register_analog_video(struct dvb_usb_device *dvbdev)
 	cxdev->videoqueue.buf_struct_size =
 		sizeof(struct cxusb_medion_vbuffer);
 	cxdev->videoqueue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	cxdev->videoqueue.min_buffers_needed = 6;
+	cxdev->videoqueue.min_queued_buffers = 6;
 	cxdev->videoqueue.lock = &cxdev->dev_lock;
 
 	ret = vb2_queue_init(&cxdev->videoqueue);
diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index 770714c34295..e8c8bdb9c40b 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -1257,7 +1257,7 @@ static int vidioc_g_parm(struct file *filp, void *priv,
 {
 	struct gspca_dev *gspca_dev = video_drvdata(filp);
 
-	parm->parm.capture.readbuffers = gspca_dev->queue.min_buffers_needed;
+	parm->parm.capture.readbuffers = gspca_dev->queue.min_queued_buffers;
 
 	if (!gspca_dev->sd_desc->get_streamparm)
 		return 0;
@@ -1273,7 +1273,7 @@ static int vidioc_s_parm(struct file *filp, void *priv,
 {
 	struct gspca_dev *gspca_dev = video_drvdata(filp);
 
-	parm->parm.capture.readbuffers = gspca_dev->queue.min_buffers_needed;
+	parm->parm.capture.readbuffers = gspca_dev->queue.min_queued_buffers;
 
 	if (!gspca_dev->sd_desc->set_streamparm) {
 		parm->parm.capture.capability = 0;
@@ -1517,7 +1517,7 @@ int gspca_dev_probe2(struct usb_interface *intf,
 	q->ops = &gspca_qops;
 	q->mem_ops = &vb2_vmalloc_memops;
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_buffers_needed = 2;
+	q->min_queued_buffers = 2;
 	q->lock = &gspca_dev->usb_lock;
 	ret = vb2_queue_init(q);
 	if (ret)
diff --git a/drivers/staging/media/deprecated/atmel/atmel-isc-base.c b/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
index 468568b5bb7a..305b103153d7 100644
--- a/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
+++ b/drivers/staging/media/deprecated/atmel/atmel-isc-base.c
@@ -1871,7 +1871,7 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
 	q->mem_ops		= &vb2_dma_contig_memops;
 	q->timestamp_flags	= V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock			= &isc->lock;
-	q->min_buffers_needed	= 1;
+	q->min_queued_buffers	= 1;
 	q->dev			= isc->dev;
 
 	ret = vb2_queue_init(q);
diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index ce02199e7b1b..f7504eb65bb4 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -1022,7 +1022,7 @@ imx_media_capture_device_init(struct device *dev, struct v4l2_subdev *src_sd,
 	vq->mem_ops = &vb2_dma_contig_memops;
 	vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	vq->lock = &priv->mutex;
-	vq->min_buffers_needed = 2;
+	vq->min_queued_buffers = 2;
 	vq->dev = priv->dev;
 
 	ret = vb2_queue_init(vq);
diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 0fe2b858da83..a66f034380c0 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -1198,7 +1198,7 @@ static int imgu_v4l2_node_setup(struct imgu_device *imgu, unsigned int pipe,
 	vbq->buf_struct_size = imgu->buf_struct_size;
 	vbq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	/* can streamon w/o buffers */
-	vbq->min_buffers_needed = 0;
+	vbq->min_queued_buffers = 0;
 	vbq->drv_priv = imgu;
 	vbq->lock = &node->lock;
 	r = vb2_queue_init(vbq);
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
diff --git a/drivers/staging/media/starfive/camss/stf-video.c b/drivers/staging/media/starfive/camss/stf-video.c
index 0b305f21eb53..989b5e82bae9 100644
--- a/drivers/staging/media/starfive/camss/stf-video.c
+++ b/drivers/staging/media/starfive/camss/stf-video.c
@@ -513,7 +513,7 @@ int stf_video_register(struct stfcamss_video *video,
 	q->buf_struct_size = sizeof(struct stfcamss_buffer);
 	q->dev = video->stfcamss->dev;
 	q->lock = &video->q_lock;
-	q->min_buffers_needed = STFCAMSS_MIN_BUFFERS;
+	q->min_queued_buffers = STFCAMSS_MIN_BUFFERS;
 	ret = vb2_queue_init(q);
 	if (ret < 0) {
 		dev_err(video->stfcamss->dev,
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
diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index e0bb59ee3c09..af6e3a0d8df4 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1174,7 +1174,7 @@ static int tegra_channel_init(struct tegra_vi_channel *chan)
 	chan->queue.ops = &tegra_channel_queue_qops;
 	chan->queue.mem_ops = &vb2_dma_contig_memops;
 	chan->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	chan->queue.min_buffers_needed = 2;
+	chan->queue.min_queued_buffers = 2;
 	chan->queue.dev = vi->dev;
 	ret = vb2_queue_init(&chan->queue);
 	if (ret < 0) {
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 5557d78b6f20..6d11cb724e95 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -546,7 +546,7 @@ struct vb2_buf_ops {
  * @gfp_flags:	additional gfp flags used when allocating the buffers.
  *		Typically this is 0, but it may be e.g. %GFP_DMA or %__GFP_DMA32
  *		to force the buffer allocation to a specific memory zone.
- * @min_buffers_needed: the minimum number of buffers needed before
+ * @min_queued_buffers: the minimum number of queued buffers needed before
  *		@start_streaming can be called. Used when a DMA engine
  *		cannot be started unless at least this number of buffers
  *		have been queued into the driver.
@@ -614,7 +614,7 @@ struct vb2_queue {
 	unsigned int			buf_struct_size;
 	u32				timestamp_flags;
 	gfp_t				gfp_flags;
-	u32				min_buffers_needed;
+	u32				min_queued_buffers;
 
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

