Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BA7D68B1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343589AbjJYKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343709AbjJYKe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:34:28 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90A192
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:34:22 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231025103420epoutp04e8b829bdc98b12964c533c29810af73a~RUz4qGCj82230022300epoutp04A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:34:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231025103420epoutp04e8b829bdc98b12964c533c29810af73a~RUz4qGCj82230022300epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698230060;
        bh=4sRCkFeZSknIsbu4AQ3FB4Q/Ua0z6puaIaxhn3WZ7ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4Zp51UANhIAj+OYlWjHjTp4iGngzMTudDyYz9Hj/cNnoOP5alq65x/uEu67E8EyI
         KOuzcne26WlL0pNXDNCm3FZn8dnSdVGuM8M6snPDX0ZlPucvhP2Xf7CkmtsbAW5qKJ
         +3pYAa3KZcmmoiYQCJCuGdzS/n64XQVByRKI099g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231025103420epcas5p17d06886d27f9e9c7a7d745649f32799d~RUz4CWZyc1501915019epcas5p1m;
        Wed, 25 Oct 2023 10:34:20 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SFlfK4qhyz4x9Pw; Wed, 25 Oct
        2023 10:34:17 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.C8.08567.92FE8356; Wed, 25 Oct 2023 19:34:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231025102237epcas5p28a5ad9db8d7dea072a6986d530810dde~RUppHC1aa1158711587epcas5p2s;
        Wed, 25 Oct 2023 10:22:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025102237epsmtrp2c04b52087f6b228cb98c9228eebc2c36~RUppGBc2a0882508825epsmtrp2D;
        Wed, 25 Oct 2023 10:22:37 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-1f-6538ef2925c1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.C2.08755.C6CE8356; Wed, 25 Oct 2023 19:22:36 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102233epsmtip13fa6652b60084234370ea38270c727b4~RUpmBwPAU0054700547epsmtip1I;
        Wed, 25 Oct 2023 10:22:33 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        linux-samsung-soc@vger.kernel.org, andi@etezian.org,
        gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, aakarsh.jain@samsung.com,
        linux-fsd@tesla.com, Smitha T Murthy <smithatmurthy@gmail.com>
Subject: [Patch v4 02/11] media: s5p-mfc: Rename IS_MFCV10 macro
Date:   Wed, 25 Oct 2023 15:52:07 +0530
Message-Id: <20231025102216.50480-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0zTVxTHc3+PtrAxf0NkF9QK3UsgVKptd2HgjBDzG3MZROfmJELT/lII
        7a9dW9ymcwNjlSHqcBCEIPKe46HQytNiykORJuAIC4wMxhiPASM24zU2xK2lsP33Oeeek+/3
        nHsvD/cc4PjyklgDo2NlKgHHnWjoCAgIDrAjJqQ/3R9NNuWRyGpvI9AvhQ0cVLryG4ZGSxcI
        1G6u56Lq1l4MfdtlJdHNzl4SNbb9SqAhazOG+vJGCHRlegxHpvEBEo3NfoD6Wwo4KLO2nkTX
        H9/HUE3nCBeVD/ZhqML0FEMl9YtcZGzt5KLzaWXkAUhXF1YDerBsHqeb80e4dKllBqNNlV9x
        6OEBC4c2l31JGx/8TdBX7lYC+tm5G1x6wcSnbUsL3JjnP0oOT2RkCkbnx7ByjSKJVUYI3jkS
        HxkvkYaIgkWh6A2BHytTMxGCqMMxwYeSVI7hBX6nZKoURypGptcL9uwP12lSDIxfokZviBAw
        WoVKK9YK9TK1PoVVClnGECYKCdkrcRQmJCcOjJaQ2sawT79fG8ZSQYUoA7jxICWGF4uMXCd7
        UvcAXM54OwO4O3geQLPRznEFywBaHtjBZsdEv51wHbQCWPmolusKjBhc7swnMwCPx6GCYU+j
        ytngRaUBOJ5ucNbgVC4Bx28vrOttpQ7Ap2NthJMJ6lU4VzdPOtmDioBXf+7DXGq7YFWtFXey
        G7UfFi2fWxeD1AoPrlz8a8NSFDw/aCFcvBXOdt3lutgXLjxp5bhYDsdLZnAXq+AdS/ZG/VvQ
        +kMB4TSNUwHwTsseV3onzLHdXveAUy/Ay6sTG348YFPhJr8GC4ZXSBfvgB1V5Rt2aDhWNU26
        lpIF4PS1WuxrwM//X6IIgErgw2j1aiUjl2hFLPPJf7cm16hNYP2BB0Y1gR9vPhO2A4wH2gHk
        4QIvj+OHEePpoZB9dprRaeJ1KSpG3w4kjgVm4b7b5BrHD2EN8SJxaIhYKpWKQ/dJRYKXPH43
        3lB4UkqZgUlmGC2j2+zDeG6+qZj3pEZ0/OGxxxcKDlYN2RJUYErqaW35859r6e7CoBnB66f1
        cvxedtD4Yl5c7WL3SasOBr1Lm4jViW/4nKIPE3CfV4RzAf0I8xq9f7ZuJzvkffXRbp9bEuPU
        KbGNfX82sqa4RmS+FJsT2/XQa7XQ5m4Jk0d3HszZYl6qq+4Iz4wbWfL3zj6xbea56/vKG4o/
        vhSZ2d2Ttr2Hf+LF2Y5JyReFO6bipn6KFReUND9JtVdnH4l2V5auFZ+NfK/CLDmTdQHkxvl3
        J9dnVaj5lTm3vjt59JiQX5OzPV9xoLn+5V6f3WtTuy4rD/kMbzkaWLx3uilapJ49Y5v7I+3z
        iTdz2ZjptCIBoU+UiQJxnV72L6ewx5xpBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJTjfnjUWqwcF2c4unO2ayWhx4f5DF
        4sG8bWwWi388Z7K4v/gzi8WhzVvZLdbsPcdksfz4AVaL+UfOsVpsP/iIxeLmgZ1MFhdn3mWx
        6HvxkNli0+NrrBYPX4VbXN41h82iZ8NWVosZ5/cxWaw9cpfdYun1i0wWyzb9YbJYtPULu0Xr
        3iPsFi2NS1gdJDzWzFvD6HF9ySdmj52z7rJ7LN7zkslj06pONo871/aweWxeUu/RevQXi0ff
        llWMHv+a5rJ7fN4k53Hq62f2AJ4oLpuU1JzMstQifbsEroxr9xexFmy3qrjw9w5TA+Mywy5G
        Tg4JAROJJ5ffs3QxcnEICexmlFiz6jIrREJG4n/bMXYIW1hi5b/n7BBFzUwSa5Z0A3VwcLAJ
        6Eqc3Z4DEhcRaGWUuL6ykwnEYRZYzyJxZMMSsG5hAQeJPw8PsoDYLAKqEm82fgLbwCtgK9F/
        7yITxAZ5idUbDjCD2JwCdhILvjWB9QoB1dy//4NxAiPfAkaGVYySqQXFuem5xYYFhnmp5XrF
        ibnFpXnpesn5uZsYwVGmpbmDcfuqD3qHGJk4GA8xSnAwK4nwRvpYpArxpiRWVqUW5ccXleak
        Fh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgSTZeLglGpgCrsbZsv/Jly+I+/XyXWet7ntYuzl
        Nj7iKd3IvSZJ64gIT2iCRuR/21n9ovMi3rcFsZ49ssLj09YgKaGSf4zp4VMK1Wq3vFKfkHxH
        wtTwxIGsqocxv/oObf661ZGj3ekft2vehWUFclP2zJhmopXobPQ4q73Nu2jXWtZJBqov+M8y
        7zvULvBr5SsGs0miexqWNYh2hqfobtz07qBN7/lfk8+fmpt3Z/HUBwaTHmX6W+45rJ19bvvC
        r0Hui4WSlIPMvblkb6xzMkw8sd36z+NZbPKfH1Y8Pfj9cPet//7H/l+8uIZn8gkT7mnCNSxT
        9qpeqeDQe/6y+JDimfLGDK/O7tNuYT+CWG7UzVp9mztykxJLcUaioRZzUXEiAFfR2CMhAwAA
X-CMS-MailID: 20231025102237epcas5p28a5ad9db8d7dea072a6986d530810dde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102237epcas5p28a5ad9db8d7dea072a6986d530810dde
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102237epcas5p28a5ad9db8d7dea072a6986d530810dde@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renames macro IS_MFCV10 to IS_MFCV10_PLUS so that the MFCv10 code can
be resued for MFCv12 support. Since some part of MFCv10 specific code
holds good for MFCv12 also.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 10 +++----
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 28 +++++++++----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index 5304f42c8c72..e6ec4a43b290 100644
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
+#define IS_MFCV6_PLUS(dev)	(dev->variant->version >= 0x60)
+#define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70)
+#define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80)
+#define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0)
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

