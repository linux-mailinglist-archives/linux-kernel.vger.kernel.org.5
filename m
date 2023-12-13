Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27420810F13
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378042AbjLMK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377966AbjLMK54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:57:56 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC6101
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:57:56 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231213105751epoutp04f2696cace44958f58b326e6997aaeaa7~gXvZ49KPw0269002690epoutp04F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:57:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231213105751epoutp04f2696cace44958f58b326e6997aaeaa7~gXvZ49KPw0269002690epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465071;
        bh=5NWIKLliTPnxZ+Ha6XnywRmgrmqqEYPDv7pEMJbD1Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IKoMY8NKv2TQYbkZakcE/sFcxNzOKIYlGZVIYlEsgJARdGQDVqPBTMJVEhS0WSNCz
         k3GweyRaW/Bzu1GRmf9wN1QNOnaS66TtQS6Sd4lXxnJB9+bHhAu4JvsktKvqYF2Cpi
         1lkr7/5IygGK5gpTr5XcB0VykPKYIuZmwjmGMbeU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20231213105751epcas5p2be570a099a85f3bcb455b2306358115b~gXvZdIreR1865618656epcas5p2Y;
        Wed, 13 Dec 2023 10:57:51 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Sqsrs4ytPz4x9Pw; Wed, 13 Dec
        2023 10:57:49 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.F9.08567.D2E89756; Wed, 13 Dec 2023 19:57:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231213081118epcas5p1bfa3f9790c9c48f1bac20c5683fed00d~gVd_eVUP-0249502495epcas5p1D;
        Wed, 13 Dec 2023 08:11:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231213081118epsmtrp1678bb67e6aa62cf73fba9d07149902e3~gVd_dSwJj2318823188epsmtrp1p;
        Wed, 13 Dec 2023 08:11:18 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-f3-65798e2d0712
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.4B.08755.52769756; Wed, 13 Dec 2023 17:11:17 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081115epsmtip21ddca92db6516b87f5b52f64121afba7~gVd7us7lW1347913479epsmtip23;
        Wed, 13 Dec 2023 08:11:14 +0000 (GMT)
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
Subject: [Patch v6 02/10] media: s5p-mfc: Rename IS_MFCV10 macro
Date:   Wed, 13 Dec 2023 13:40:57 +0530
Message-Id: <20231213081105.25817-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHd+69fcAGu6vgzlBZ0yEMEh4dpTsYXssad6MmYw9joizs0t5B
        Q7lt2jLm/mD4qA/CEIzdgIGtPEwsUrC8oYx3jGSgTl5O6lQ047GNpQWFwXCU4vbf5/fN9/c4
        v3MOHxe0cwP4SlbPaFlaJeJ6Ey39oaHh4YVHmaim34PQk7ZSDupZ6CXQg4stXFS1/BuGfq1y
        EaivsZmHrnaNYMg0MMJBd3vaMXS71EGgwpmHOLJNj3PQw7lD6E5HORcVNDRzUMnNHzFUN+Dg
        ocu2NQxVNi/ykKFrgIdOHqvmJPlTE9VOnGovc/CoKvssRtksZ7nU1LidSzVWf0MVNlkAtX68
        gke5bIHU0JKLl+x9ODMug6EVjFbIsHK1Qsmmx4v2f5L6fmqMNEocLo5F74qELJ3FxItkB5LD
        9ypVG2cUCb+kVdkbUjKt04kiE+K06mw9I8xQ6/TxIkajUGkkmggdnaXLZtMjWEa/RxwV9U7M
        hvHzzAxr93aNa89XJvsSkQcc4nzgxYekBNa15PHygTdfQHYCaJ65yfEETgDLmp5vBU8BfFY3
        CPIBfzPlxF8yj94F4Gl7L+EuJSANGBxt2OX2cMlwONyqcst+5DEAp8/o3X6cvI5Dc1Hppn8b
        mQRdFZ1ct58gd8PeGZlb9iHjYeviGvBM9yasbejB3exFJsA/j3cDdx1ITvKhyXke85hkcPj+
        SZ6Ht8G5601bHABnz53aYjmcrpzFPayC9fYLhIcTYc9oOeGeASdDYX1HpEfeBY1D1s3yOOkL
        v119vNXKB7ZdfMHBsHxqmePhnbC/tmZrPRRcWjniWU8xgJbH/2BFILDs/w5mACzgDUajy0pn
        5DEaMcvk/HdjcnWWDWy+4TBZG5g0rUf0AYwP+gDk4yI/nxttOYzAR0Ef/ZrRqlO12SpG1wdi
        NtZXjAf4y9Ubn4DVp4olsVESqVQqiY2WikWv+8wbKhQCMp3WM5kMo2G0L/IwvldAHqY8GE0n
        8TsJo+IKza11GtJjvF6eaHze/4Oho5K3cuSQw1oTfbp1auc525MPlH9//Fkw5rwgTVyYSLlr
        7H3mF2KQnhq9cm/GKP/+sua7t1+KPNtS4qqZE8t7V+dDYuf/GFmUmO7M1ChWzaxpZfWWxmbZ
        e49dv3Xidm5g5mJ2Gc+byEl5cMmqsvoqp80L1ur3wrgd0a8Ic8UJEYMhj7Z/Ub/sx5XFYyjl
        viX5zL63gj/dkWYe+UVvHw5eMvgOvsZv/ci5byyorXv0Wk/e1cJcU2FQkcDkPTZecOPna860
        4t2PCtLYxBL6sHHQeDDjqYMV5ux/lYr7yT9A9qFzaG3H2OSYiNBl0OIwXKuj/wWwXUwoTAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK5qemWqwZEpVhZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGWs2y9W8NmqYv6erywNjHcNuxg5OCQETCSaP7h0MXJxCAnsZpTovLWKtYuREygu
        I/G/7Rg7hC0ssfLfc3aIomYmiRNz+plAmtkEdCXObs8BiYsItDJKXF/ZyQTiMAvcZpbYNOEh
        WLewgIPE57m72UAaWARUJQ6+cAEJ8wrYSmz/8ocRYoG8xOoNB5hBbE4BO4l3TfvB4kJANct3
        32aewMi3gJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcLRoae5g3L7qg94hRiYO
        xkOMEhzMSiK8J3eUpwrxpiRWVqUW5ccXleakFh9ilOZgURLnFX/RmyIkkJ5YkpqdmlqQWgST
        ZeLglGpgWnzEaem5orfHT11kXGX9Z5H4S6GM7qAn3T/O/z1U4K9rWTf3/33vtxdK1m8qN908
        c2f1lp7uL433z/0xc5c7LbxevlPqinLHvYVNi75rrT759/QlnpBDEf5emlsS8w3Wr47a5qR8
        +Zy20gSBbWvO+UnM4HrOYMTlEZb9OeIRf6zF2quvYkT33iu6lvnu4Knflp8Dav8eNxRq9owz
        X6X5TeHn66XXTHSU007d8HyuZlQ5O1dHfPkRy+ygs1vWfv+0906r+wf5m4ebnk/+Xbgz7Fx6
        85wzQWe+Ht/Cz75QLejpn7NHT024ZbQ+6ExH/5dVUQ+q2VkV1hU//XXr1hqWNIdGDu0TPG9d
        DrhENenxTFuqxFKckWioxVxUnAgAszLPVQUDAAA=
X-CMS-MailID: 20231213081118epcas5p1bfa3f9790c9c48f1bac20c5683fed00d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081118epcas5p1bfa3f9790c9c48f1bac20c5683fed00d
References: <20231213081105.25817-1-aakarsh.jain@samsung.com>
        <CGME20231213081118epcas5p1bfa3f9790c9c48f1bac20c5683fed00d@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
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

