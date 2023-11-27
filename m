Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCA07FA763
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjK0Q7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbjK0Q6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:58:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2B430C7;
        Mon, 27 Nov 2023 08:55:49 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA5E4660742B;
        Mon, 27 Nov 2023 16:55:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701104147;
        bh=yC3FV0N0XOijdcBv3yWO8BmzCgseS3Y6Nq1H8uXjYec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MINNiUeoz/GUMUqWdqXdfQ65v0Ab6vh2Hp0YWf072N/P008c+syLugxYV7eNvXefT
         18oTjv9H7wIv3zOWAGkBSiwmn1HFWBMl5HbDwqcX5zBCfUTqx+izbQab3L6f8vOAli
         MYW1XuK5bpjjK4wgGAO5lVPyoQY6iT2LkcBIAbRM0wmj7+MzZtZJ1yqF0F93nlGClx
         9kX5ZUKfPeyvqmeqH5dftIOshujd1EFKrCs9p/V1lI95/hTIjrUNNNEcaaaDTsOW2W
         Nh45ooSVSyWMEPANbvxmdkzKT2WY6luoZSeZTu3CsqVl4yg7MS/VfVFqYTcIk9Mec6
         0mOYES0sV/9IQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 54/55] media: meson: vdec: Use min_dma_buffers_needed field
Date:   Mon, 27 Nov 2023 17:54:53 +0100
Message-Id: <20231127165454.166373-55-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
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

vdec driver use a firmware and comments said that a
minimum number of buffers need to be present before
start streaming.
That is 'min_dma_buffers_needed' purpose so use it instead
of 'min_buffers_needed' field.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Neil Armstrong <neil.armstrong@linaro.org>
CC: Kevin Hilman <khilman@baylibre.com>
CC: Jerome Brunet <jbrunet@baylibre.com>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: linux-amlogic@lists.infradead.org
---
 drivers/staging/media/meson/vdec/vdec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 1e2369f104c8..6c2e3e5c6e6f 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -184,7 +184,7 @@ static void process_num_buffers(struct vb2_queue *q,
 	 * we need all of them to be queued into the driver
 	 */
 	sess->num_dst_bufs = q_num_bufs + *num_buffers;
-	q->min_buffers_needed = max(fmt_out->min_buffers, sess->num_dst_bufs);
+	q->min_dma_buffers_needed = max(fmt_out->min_buffers, sess->num_dst_bufs);
 }
 
 static int vdec_queue_setup(struct vb2_queue *q, unsigned int *num_buffers,
@@ -825,7 +825,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->mem_ops = &vb2_dma_contig_memops;
 	src_vq->drv_priv = sess;
 	src_vq->buf_struct_size = sizeof(struct dummy_buf);
-	src_vq->min_buffers_needed = 1;
+	src_vq->min_dma_buffers_needed = 1;
 	src_vq->dev = sess->core->dev;
 	src_vq->lock = &sess->lock;
 	ret = vb2_queue_init(src_vq);
@@ -839,7 +839,7 @@ static int m2m_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->mem_ops = &vb2_dma_contig_memops;
 	dst_vq->drv_priv = sess;
 	dst_vq->buf_struct_size = sizeof(struct dummy_buf);
-	dst_vq->min_buffers_needed = 1;
+	dst_vq->min_dma_buffers_needed = 1;
 	dst_vq->dev = sess->core->dev;
 	dst_vq->lock = &sess->lock;
 	return vb2_queue_init(dst_vq);
-- 
2.39.2

