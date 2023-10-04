Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6317B7D5D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242128AbjJDKjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242139AbjJDKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:38:58 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32B9EA;
        Wed,  4 Oct 2023 03:38:50 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3949ec6C012636;
        Wed, 4 Oct 2023 12:38:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=GR7/PkrCPiZ87Ql+mCFVzbYkH3KLy87NbQlZNSov48c=; b=3P
        tHnOtOY7aC9ROLY6+AfIM0r8jWDyzGLFBwf7FMPUfLF2nWJ2eUX+gFiHqxatfhyd
        5jlPiwgfl19c7RV69rdjf1kgftMVwxmxUnjOLRSEngnMcgH57/kqvc21QeToBgVf
        xdG4K8RHtoOjvJZ9j7Poca9+QidjamszsHqJMduxUWIz9Nq1NpXtZ3IQFwGgCcxx
        JIT7DLp5Rcd0uFgVI88dhQP5yQb+jh299gwfgCC60JXXhMM+TwHNVVeh1iqzkTS+
        bIbWEC03kGCLExX8GgCphMvahOsKVTw9OcKjnDLD4NqdeX3WrdoWQ1yDGtDPU5f/
        GAjOSvLsY9wcx/ZIjHgQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3te93g0p4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 12:38:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7FD4A100053;
        Wed,  4 Oct 2023 12:38:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 76DB323151D;
        Wed,  4 Oct 2023 12:38:32 +0200 (CEST)
Received: from localhost (10.201.20.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 12:38:32 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
Subject: [RFC 5/6] media: hantro: h1: NV12 single-plane support
Date:   Wed, 4 Oct 2023 12:37:19 +0200
Message-ID: <20231004103720.3540436-6-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004103720.3540436-1-hugues.fruchet@foss.st.com>
References: <20231004103720.3540436-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_02,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of NV12 single-plane input frame.

Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
---
 .../platform/verisilicon/hantro_h1_jpeg_enc.c | 42 +++++++++++--------
 .../platform/verisilicon/hantro_h1_vp8_enc.c  | 13 +++++-
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c b/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
index 12d69503d6ba..9cba30945421 100644
--- a/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
+++ b/drivers/media/platform/verisilicon/hantro_h1_jpeg_enc.c
@@ -42,9 +42,13 @@ static void hantro_h1_jpeg_enc_set_buffers(struct hantro_dev *vpu,
 					   struct vb2_buffer *src_buf,
 					   struct vb2_buffer *dst_buf)
 {
+	const u32 src_addr_regs[] = { H1_REG_ADDR_IN_PLANE_0,
+				      H1_REG_ADDR_IN_PLANE_1,
+				      H1_REG_ADDR_IN_PLANE_2 };
 	struct v4l2_pix_format_mplane *pix_fmt = &ctx->src_fmt;
-	dma_addr_t src[3];
+	size_t luma_size;
 	u32 size_left;
+	int i;
 
 	size_left = vb2_plane_size(dst_buf, 0) - ctx->vpu_dst_fmt->header_size;
 	if (WARN_ON(vb2_plane_size(dst_buf, 0) < ctx->vpu_dst_fmt->header_size))
@@ -57,23 +61,25 @@ static void hantro_h1_jpeg_enc_set_buffers(struct hantro_dev *vpu,
 			   H1_REG_ADDR_OUTPUT_STREAM);
 	vepu_write_relaxed(vpu, size_left, H1_REG_STR_BUF_LIMIT);
 
-	if (pix_fmt->num_planes == 1) {
-		src[0] = vb2_dma_contig_plane_dma_addr(src_buf, 0);
-		/* single plane formats we supported are all interlaced */
-		vepu_write_relaxed(vpu, src[0], H1_REG_ADDR_IN_PLANE_0);
-	} else if (pix_fmt->num_planes == 2) {
-		src[0] = vb2_dma_contig_plane_dma_addr(src_buf, 0);
-		src[1] = vb2_dma_contig_plane_dma_addr(src_buf, 1);
-		vepu_write_relaxed(vpu, src[0], H1_REG_ADDR_IN_PLANE_0);
-		vepu_write_relaxed(vpu, src[1], H1_REG_ADDR_IN_PLANE_1);
-	} else {
-		src[0] = vb2_dma_contig_plane_dma_addr(src_buf, 0);
-		src[1] = vb2_dma_contig_plane_dma_addr(src_buf, 1);
-		src[2] = vb2_dma_contig_plane_dma_addr(src_buf, 2);
-		vepu_write_relaxed(vpu, src[0], H1_REG_ADDR_IN_PLANE_0);
-		vepu_write_relaxed(vpu, src[1], H1_REG_ADDR_IN_PLANE_1);
-		vepu_write_relaxed(vpu, src[2], H1_REG_ADDR_IN_PLANE_2);
-	}
+	luma_size = hantro_rounded_luma_size(ctx->src_fmt.width,
+					     ctx->src_fmt.height);
+
+	vepu_write_relaxed(vpu,
+			   vb2_dma_contig_plane_dma_addr(src_buf, 0) +
+			   src_buf->planes[0].data_offset,
+			   src_addr_regs[0]);
+	vepu_write_relaxed(vpu,
+			   vb2_dma_contig_plane_dma_addr(src_buf, 0) +
+			   src_buf->planes[0].data_offset +
+			   luma_size,
+			   src_addr_regs[1]);
+
+	for (i = 1; i < pix_fmt->num_planes; ++i)
+		/* Multiplanes. */
+		vepu_write_relaxed(vpu,
+				   vb2_dma_contig_plane_dma_addr(src_buf, i) +
+				   src_buf->planes[i].data_offset,
+				   src_addr_regs[i]);
 }
 
 static void
diff --git a/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c b/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
index b7a635fb73b0..05aa0dd9c09c 100644
--- a/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
+++ b/drivers/media/platform/verisilicon/hantro_h1_vp8_enc.c
@@ -1129,7 +1129,18 @@ hantro_h1_vp8_enc_set_buffers(struct hantro_dev *vpu, struct hantro_ctx *ctx, u3
 			   H1_REG_ADDR_REC_CHROMA);
 
 	/* Source buffer. */
-	for (i = 0; i < src_fmt->num_planes; ++i)
+	vepu_write_relaxed(vpu,
+			   vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0) +
+			   src_buf->vb2_buf.planes[0].data_offset,
+			   src_addr_regs[0]);
+	vepu_write_relaxed(vpu,
+			   vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0) +
+			   src_buf->vb2_buf.planes[0].data_offset +
+			   luma_size,
+			   src_addr_regs[1]);
+
+	for (i = 1; i < src_fmt->num_planes; ++i)
+		/* Multiplanes. */
 		vepu_write_relaxed(vpu,
 				   vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, i) +
 				   src_buf->vb2_buf.planes[i].data_offset,
-- 
2.25.1

