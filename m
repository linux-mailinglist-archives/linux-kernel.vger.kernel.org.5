Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313AB80676B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376826AbjLFGgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376815AbjLFGgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:36:10 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AFFD40
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:36:14 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231206063612epoutp041626a884bddd22a642a0e5c7d8c2d9ca~eKp9FVyN_0472304723epoutp04n
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:36:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231206063612epoutp041626a884bddd22a642a0e5c7d8c2d9ca~eKp9FVyN_0472304723epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701844572;
        bh=/UqqBcBMcUGk18ljZ0TV7heihXmtjTjPk3xYqr0D6xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cr019Nlp6gRP0LiHy+isAOPCqn788wYXvE5z+xiOMbcqTdiLFOkrQL7mQVDpkP/Qd
         3iy+uOZSY/jLdsYyZUkixvGyOBLD3qbt8AosUWRo74HwjBdL+u07+ItF5I8pvB2Kb7
         E7BNWm9BgT2l5VWtiGwpzNoua4IBduUhlI3b3W1o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231206063612epcas5p2a4b0ffb84f94f01dbb670436795e8ded~eKp8dxpRO1436714367epcas5p2C;
        Wed,  6 Dec 2023 06:36:12 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SlSNB3Jyhz4x9QG; Wed,  6 Dec
        2023 06:36:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.45.08567.A5610756; Wed,  6 Dec 2023 15:36:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231206063111epcas5p112aeeca899892a154c9a68c8e8873647~eKlk3-OLf1408814088epcas5p1_;
        Wed,  6 Dec 2023 06:31:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231206063111epsmtrp2632d41593bccfef526053816e36c0f2c~eKlk2AYtQ1483414834epsmtrp2E;
        Wed,  6 Dec 2023 06:31:11 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-80-6570165aae87
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.33.08817.F2510756; Wed,  6 Dec 2023 15:31:11 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063108epsmtip27b9a7035d75aee06a3b682b7ea39976b~eKliEDDTy3080830808epsmtip2k;
        Wed,  6 Dec 2023 06:31:08 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-samsung-soc@vger.kernel.org,
        andi@etezian.org, gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com,
        linux-fsd@tesla.com, Smitha T Murthy <smithatmurthy@gmail.com>
Subject: [Patch v5 02/11] media: s5p-mfc: Rename IS_MFCV10 macro
Date:   Wed,  6 Dec 2023 12:00:36 +0530
Message-Id: <20231206063045.97234-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231206063045.97234-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHc+69vb0Q2e4q6FmnjHRjG2ZAq1APDBgJ4O4UE5ZFN/2nu4E7
        2vT2kbZMcdkGKlMMq5CAylMmsExEaVCeLQwLGY7wyIJDwbJNHhtYNxGE+ChsrRe2/z6/3/l+
        z+93fuccCpc4SCml0Vs4k57lZaQ/0dITFhZ+cJORk7tdQWimrVSEuh9cJ9DvVS0kqnn8J4Z+
        q1kkkPNqsxg1dA5h6HzvkAiNdbdj6OfSCQJZZ+/iqGlqVITu3vsIjXRUkKjA1ixC54a7MHS5
        d0KMvmvyYOhC8yMxyuvsFaPjubWixCDmVu0CzrSXTYiZGsccxjTV55OMa9RBMldrv2Ks1+oB
        s3q0UswsNgUz/UuL4jT/g9o4NcdmcKYQTp9uyNDoM+Nlez5UJamilXJFuCIG7ZSF6FkdFy9L
        Tk0L36XhvWeUhXzG8lneVBprNssiE+JMhiwLF6I2mC3xMs6YwRujjBFmVmfO0mdG6DlLrEIu
        3x7tFX6iVU8u2wjjYuzhyR/25YAJxSngR0E6Cv463EacAv6UhLYDOH3iNCkECwD+0jeKC8Ey
        gJ68R2DdMl+5RPpYQncCWLecJYjyMOgYHfY6KIqkw+FgK+/TBNK5AE6dtPg0ON2Hw+rCUsK3
        sJFOhEP2eZGPCToULlXmPy8QQMfD1vZZUij2Krxk68Z97EcnwOKGapFvI0jfpmCuu3ito2Q4
        23hszbAR3uu7JhZYChf/7lzLp8OpC3O4wDxsdBQTAr8Lu29WEL6mcToMNnZECumtsKT/CuZj
        nH4BfvNsGhPyAbCtap3fgBWuxyKBt8CeS3Vr7TDQ7SkQC0MpAvDi+CBRCILL/i9RDUA9eJkz
        mnWZXHq0UaHnDv13aekGXRN4/oy3JbeB2+dXI5wAo4ATQAqXBQbwwwZOEpDBZh/hTAaVKYvn
        zE4Q7R1gES4NSjd4/4HeolJExcijlEplVMwOpUK2OcCdV5khoTNZC6flOCNnWvdhlJ80B5vj
        B9zl/d/u9t+kC34v9VOdzXx2vy5xn71OvTn0dfbOM03B+Ib7+8cOuHZVRci1I4dmFuJyR146
        vlLFSqHU9gfz4l8/PXWODTxkNlR32ZPu/Kg8uT2iv8apKuSssQ1vl+94LbO28clOLTX8irNG
        +b3VzvQ2DFS4bwTisYPYBxJH14k3h2LKroTO1d86ndKhSAns+TzhndScr1PHb0zefKu9xVQ6
        uzLdgG9dOsPH9Uhzj1k9T8+ov7Tt/fjA4d3v142rpZrkL7KTx/Xah62RKyrSU/JEWX9k1Tml
        sZTA8t6O6fzCsw9cfny+K6l1KPtcYJHx6MXr1svzW/6xFqTU3p/pUskIs5pVbMNNZvZfAdMJ
        BU8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvK6+aEGqwZGtmhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGU8+raBpeCzVcWj/aENjHcNuxg5OSQETCQ+zP3K1sXIxSEksJtR4k3XVxaIhIzE
        /7Zj7BC2sMTKf8/ZIYqamSRmNK0Dcjg42AR0Jc5uzwGJiwi0MkpcX9nJBOIwC9xmltg04SFY
        t7CAg8S53R9YQWwWAVWJr3M7GUFsXgFbie07X7BBbJCXWL3hADOIzSlgJzFlzQJWkAVCQDUr
        TzpOYORbwMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOF60tHYw7ln1Qe8QIxMH
        4yFGCQ5mJRHenPP5qUK8KYmVValF+fFFpTmpxYcYpTlYlMR5v73uTRESSE8sSc1OTS1ILYLJ
        MnFwSjUwteUF/bVKrD7zWOaZ9r43GgY3zXkXfl//5Pn/aw82s2sKmSXfO776ns7UOZX1wWyn
        eVreO/b/Wsi/Ru/I8p5Mp5CXkcenLi7/mT7VZG5eyZ+n07WsV9/avlJJL+asi3tqRnmSzNUY
        If+GDbkHjmzS+M3q81fYNlHZPGDi18SztdZrJr456SvpuXzNNJ8VNze/aJFV4RKN6gjcl/ht
        c+TUCj6m93ahmltXWF5bf/PS1L0XXyZuOnlG4Ohy9dVr1rOabI8I+jK77cAlddHN09b8kez6
        /iB5HeuUy/Fqf+eWbU7Rudwi5WRmdePukVyTledDFvLzCbCJHhIs2KovVxBUvSboRk3j35NR
        uj83T+NePE+JpTgj0VCLuag4EQCmKxfiBgMAAA==
X-CMS-MailID: 20231206063111epcas5p112aeeca899892a154c9a68c8e8873647
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063111epcas5p112aeeca899892a154c9a68c8e8873647
References: <20231206063045.97234-1-aakarsh.jain@samsung.com>
        <CGME20231206063111epcas5p112aeeca899892a154c9a68c8e8873647@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renames macro IS_MFCV10 to IS_MFCV10_PLUS so that the MFCv10 code can
be resued for MFCv12 support. Since some part of MFCv10 specific code
holds good for MFCv12 also.

Cc: linux-fsd@tesla.com
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 10 +++----
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 28 +++++++++----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index 5304f42c8c72..2ae2f23c4741 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -771,11 +771,11 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define HAS_PORTNUM(dev)	(dev ? (dev->variant ? \
 				(dev->variant->port_num ? 1 : 0) : 0) : 0)
 #define IS_TWOPORT(dev)		(dev->variant->port_num == 2 ? 1 : 0)
-#define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60 ? 1 : 0)
-#define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70 ? 1 : 0)
-#define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80 ? 1 : 0)
-#define IS_MFCV10(dev)		(dev->variant->version >= 0xA0 ? 1 : 0)
-#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10(dev))
+#define IS_MFCV6_PLUS(dev)	((dev)->variant->version >= 0x60)
+#define IS_MFCV7_PLUS(dev)	((dev)->variant->version >= 0x70)
+#define IS_MFCV8_PLUS(dev)	((dev)->variant->version >= 0x80)
+#define IS_MFCV10_PLUS(dev)	((dev)->variant->version >= 0xA0)
+#define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
 
 #define MFC_V5_BIT	BIT(0)
 #define MFC_V6_BIT	BIT(1)
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index 6d3c92045c05..54b54b2fa9b1 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -236,7 +236,7 @@ int s5p_mfc_init_hw(struct s5p_mfc_dev *dev)
 	else
 		mfc_write(dev, 0x3ff, S5P_FIMV_SW_RESET);
 
-	if (IS_MFCV10(dev))
+	if (IS_MFCV10_PLUS(dev))
 		mfc_write(dev, 0x0, S5P_FIMV_MFC_CLOCK_OFF_V10);
 
 	mfc_debug(2, "Will now wait for completion of firmware transfer\n");
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index c0df5ac9fcff..882166e4ac50 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -72,9 +72,9 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			  ctx->luma_size, ctx->chroma_size, ctx->mv_size);
 		mfc_debug(2, "Totals bufs: %d\n", ctx->total_dpb_count);
 	} else if (ctx->type == MFCINST_ENCODER) {
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev))
 			ctx->tmv_buffer_size = 0;
-		} else if (IS_MFCV8_PLUS(dev))
+		else if (IS_MFCV8_PLUS(dev))
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V8(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
@@ -82,7 +82,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
 			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
 			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
@@ -133,7 +133,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 	switch (ctx->codec_mode) {
 	case S5P_MFC_CODEC_H264_DEC:
 	case S5P_MFC_CODEC_H264_MVC_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
@@ -152,7 +152,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			(ctx->mv_count * ctx->mv_size);
 		break;
 	case S5P_MFC_CODEC_MPEG4_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else if (IS_MFCV7_PLUS(dev)) {
 			ctx->scratch_buf_size =
@@ -172,7 +172,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_VC1RCV_DEC:
 	case S5P_MFC_CODEC_VC1_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else
 			ctx->scratch_buf_size =
@@ -189,7 +189,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_H263_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else
 			ctx->scratch_buf_size =
@@ -201,7 +201,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank1.size = ctx->scratch_buf_size;
 		break;
 	case S5P_MFC_CODEC_VP8_DEC:
-		if (IS_MFCV10(dev))
+		if (IS_MFCV10_PLUS(dev))
 			mfc_debug(2, "Use min scratch buffer size\n");
 		else if (IS_MFCV8_PLUS(dev))
 			ctx->scratch_buf_size =
@@ -230,7 +230,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			DEC_VP9_STATIC_BUFFER_SIZE;
 		break;
 	case S5P_MFC_CODEC_H264_ENC:
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
@@ -254,7 +254,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
@@ -273,7 +273,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_VP8_ENC:
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
@@ -452,7 +452,7 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
-		if (IS_MFCV10(dev)) {
+		if (IS_MFCV10_PLUS(dev)) {
 			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
 					ctx->img_height);
 		} else {
@@ -668,7 +668,7 @@ static int s5p_mfc_set_enc_ref_buffer_v6(struct s5p_mfc_ctx *ctx)
 
 	mfc_debug(2, "Buf1: %p (%d)\n", (void *)buf_addr1, buf_size1);
 
-	if (IS_MFCV10(dev)) {
+	if (IS_MFCV10_PLUS(dev)) {
 		/* start address of per buffer is aligned */
 		for (i = 0; i < ctx->pb_count; i++) {
 			writel(buf_addr1, mfc_regs->e_luma_dpb + (4 * i));
@@ -2455,7 +2455,7 @@ const struct s5p_mfc_regs *s5p_mfc_init_regs_v6_plus(struct s5p_mfc_dev *dev)
 	R(e_h264_options, S5P_FIMV_E_H264_OPTIONS_V8);
 	R(e_min_scratch_buffer_size, S5P_FIMV_E_MIN_SCRATCH_BUFFER_SIZE_V8);
 
-	if (!IS_MFCV10(dev))
+	if (!IS_MFCV10_PLUS(dev))
 		goto done;
 
 	/* Initialize registers used in MFC v10 only.
-- 
2.17.1

