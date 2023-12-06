Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CBD80676E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376833AbjLFGgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376817AbjLFGgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:36:16 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6DFD50
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 22:36:21 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231206063620epoutp036f8f04c0447963424c4538450dfd51f8~eKqD6NK9F1412814128epoutp03P
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 06:36:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231206063620epoutp036f8f04c0447963424c4538450dfd51f8~eKqD6NK9F1412814128epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701844580;
        bh=vepg69CbxY1XGg/g/XjN/S8Tifwfegf2/tX6ujsYAT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXtEycGbH4DD3/XK3YHxc32MGuYBORUwIu1QKiH/6U2qEHDjCqp8623z6iVFlvdmh
         jeBNKELSVNNzkTEHDjdjyC1EodO18xum+1ikK2ug7IAyTBv9qE90z6eMfmkaF0W6fE
         pjpFHB6yalggscnCZYGUqaHwkTqqhaEpGLzQaGI8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231206063619epcas5p35492d2846f2fb95c395b07f7eefff027~eKqDUFsW62921929219epcas5p37;
        Wed,  6 Dec 2023 06:36:19 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4SlSNK5m0pz4x9Px; Wed,  6 Dec
        2023 06:36:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.E5.09672.16610756; Wed,  6 Dec 2023 15:36:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20231206063114epcas5p4637c47d1bc778bf293fd9d98b89bbb8a~eKlnrxMUD1337113371epcas5p4E;
        Wed,  6 Dec 2023 06:31:14 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231206063114epsmtrp2d9d273771faabbe98586997754cfb74f~eKlnq3kuj1483414834epsmtrp2L;
        Wed,  6 Dec 2023 06:31:14 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-0b-65701661e770
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.96.07368.23510756; Wed,  6 Dec 2023 15:31:14 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231206063111epsmtip2600b59416722f951ba2287560dea7ea3~eKlk3rvne0460504605epsmtip2J;
        Wed,  6 Dec 2023 06:31:11 +0000 (GMT)
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
Subject: [Patch v5 03/11] media: s5p-mfc: Add initial support for MFCv12
Date:   Wed,  6 Dec 2023 12:00:37 +0530
Message-Id: <20231206063045.97234-4-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231206063045.97234-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0wbZRjH896114OlciljvOLA7uKwYMrajZZD6SYOl4vo7DQ6MTF40KMg
        pW16LZv4ayMiiIDMDSLIBhmMxQIra8fvllRGJCuMbW7gUGAgGIQtw4GQRccipUX/+zw/vt8n
        7/O+L46KerEwPEtvZk16Rkdigbz2y1HRUmabkZWNfC2hfu+s4lPuxR941NSZdoyqfziHUHfq
        l3lUn6NNQDW7hhGqtn+YT425uxDqRtUEjyr7Yxql7DOjfGp64TB1s7sGo0pa2/jUt9d6Eaql
        f0JANdofIdTZtr8EVIGrX0B9fryB/2II/XPDEkp3VU8I6HrnPELbrV9i9PioE6MdDZ/RZZes
        gH6cf1pAL9sjaM/KskAd+G52QibLaFiTmNWnGzRZeq2KTH4zdX+qQimTS+XxVBwp1jM5rIpM
        elUtPZClWz8jKc5ldJb1lJrhOHLX3gSTwWJmxZkGzqwiWaNGZ4w1xnBMDmfRa2P0rPl5uUy2
        W7He+H525lyjAzE+KgZHf7E5sGNgjCsGATgkYqG1YgotBoG4iOgB8O7cfX+wBKDTU+cPVgHs
        +O57/qakuLcS8xVcAK7OnvQHBQhcnfQgxQDHMUIKr3bovIKtxHEAZ4rM3h6UGEBhXXkVz1sI
        Jmhota9suPKInXCwbhHzaoWECjpWFL5hT8OmVjfq5QBiLzzVXMf3+kDiNg4XimYQX1MSPFdb
        6udguDBwSeDjMLh834X5OB3OnJ1HfayDNucpno/3QfetGp53LkpEQVv3Ll86HFZ4LmxYosQT
        sPSfWb+9EHae2eRIWDP+0L+U7fBy0zngYxrWlNxGfDs5AeD4yq9oOYio/n9EHQBW8CRr5HK0
        LKcw7tGzR/67tnRDjh1sPOTo5E7w29SfMX0AwUEfgDhKbhXqrhlYkVDDfJjHmgypJouO5fqA
        Yn1/J9CwkHTD+k/Qm1PlsfGyWKVSGRu/RyknQ4V3C05rRISWMbPZLGtkTZs6BA8IO4a8POh8
        p/rvlisB/e+pLF9Nf9IwMgCW9LtFZX3hFy6WdJ/fEi7Vjewvd8hGbOKgB0UvWEpyK60PDoSE
        zGWEKkKa12Zf+6AlundyUtKamJ9Yffj6Rwd7CrVDRPuW3H2TeUH46wcjojyhH3NRyOPSakQc
        JBG6d7q+iFb3bEvIm0/iD77SM5RSyxXCxgHyXiTybLJmx0Wh6ipZfiOxPio00lmVkVIpbcxK
        U9Wr8SVzVeH1o11xOYdsImzYYRvVnlS7im996v5J0rSYsf2QKu2lhHxyNmU44M7ajrey7q0B
        uuONQeTINx4J8bbyZlyMUvLMjw3nn6rowdOutD43xmDBQ4IWksdlMvJo1MQx/wJpVWwLUQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvK6RaEGqwatJehZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYv6Rc6wWNw/sZLK4OPMui0Xfi4fMFpseX2O1
        ePgq3OLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsli09Qu7ReveI+wWLY1LWB1EPa4v+cTs
        sXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j36tqxi9PjXNJfd4/MmOY9TXz+zB3BFcdmkpOZk
        lqUW6dslcGU8X7aZqeBPF2PFrfWb2RoYbxZ3MXJySAiYSHTtm8bWxcjFISSwm1Fi8vJWFoiE
        jMT/tmPsELawxMp/z9khipqZJOZ0f2HuYuTgYBPQlTi7PQckLiLQyihxfWUnE4jDLHCbWWLT
        hIdg3cICHhKrNn1lBbFZBFQlTi94zwbSzCtgK7H5qynEAnmJ1RsOMIPYnAJ2ElPWLGAFKREC
        Kll50nECI98CRoZVjJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjBEaOlsYPx3vx/eocY
        mTgYDzFKcDArifDmnM9PFeJNSaysSi3Kjy8qzUktPsQozcGiJM5rOGN2ipBAemJJanZqakFq
        EUyWiYNTqoEpcN2MB18ZXr7o5syU9ZPZfmzOrhXJ/zql1/dEenSHB5d2uq6eajNTVM2v/uw5
        BgveDPOoaRp7jm08fYafXWZzglzAoosFdwQsQx6v72UufDDL7rjautRDUhc3ixfOSS+5XHCr
        OnvTxKXfgjZeuHr/8Mdb32xCv4q19kgcU56/WlC9uvnrvTk3/i4I39KzwlvLYF/xSafzPFvt
        8s8xmizLUnyyhM/Q68SLKd7tec+WSN033yblPCW93HH536mRnbcZf0Znymd+yF0hK+vIl7RA
        2d3sQvmD2JSo11fjC271/hXxZ45hvcE/4XLsXFlD3QknYllM9upcV3tzJzFx9aY8UT/TSZdP
        umTlNik2VzMrsRRnJBpqMRcVJwIArsEufAcDAAA=
X-CMS-MailID: 20231206063114epcas5p4637c47d1bc778bf293fd9d98b89bbb8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063114epcas5p4637c47d1bc778bf293fd9d98b89bbb8a
References: <20231206063045.97234-1-aakarsh.jain@samsung.com>
        <CGME20231206063114epcas5p4637c47d1bc778bf293fd9d98b89bbb8a@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MFCv12, with a new register file and necessary hw
control, decoder, encoder and structural changes. Add luma dbp, chroma
dpb and mv sizes for each codec as per the UM for MFCv12, along with
appropriate alignment.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../platform/samsung/s5p-mfc/regs-mfc-v12.h   | 50 +++++++++++
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c  | 30 +++++++
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 15 +++-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  6 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    |  5 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  8 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 83 +++++++++++++++----
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  6 +-
 9 files changed, 170 insertions(+), 35 deletions(-)
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
new file mode 100644
index 000000000000..d987bba1ffbd
--- /dev/null
+++ b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Register definition file for Samsung MFC V12.x Interface (FIMV) driver
+ *
+ * Copyright (c) 2020 Samsung Electronics Co., Ltd.
+ *     http://www.samsung.com/
+ */
+
+#ifndef _REGS_MFC_V12_H
+#define _REGS_MFC_V12_H
+
+#include <linux/sizes.h>
+#include "regs-mfc-v10.h"
+
+/* MFCv12 Context buffer sizes */
+#define MFC_CTX_BUF_SIZE_V12		(30 * SZ_1K)
+#define MFC_H264_DEC_CTX_BUF_SIZE_V12	(2 * SZ_1M)
+#define MFC_OTHER_DEC_CTX_BUF_SIZE_V12	(30 * SZ_1K)
+#define MFC_H264_ENC_CTX_BUF_SIZE_V12	(100 * SZ_1K)
+#define MFC_HEVC_ENC_CTX_BUF_SIZE_V12	(40 * SZ_1K)
+#define MFC_OTHER_ENC_CTX_BUF_SIZE_V12	(25 * SZ_1K)
+
+/* MFCv12 variant defines */
+#define MAX_FW_SIZE_V12			(SZ_1M)
+#define MAX_CPB_SIZE_V12		(7 * SZ_1M)
+#define MFC_VERSION_V12			0xC0
+#define MFC_NUM_PORTS_V12		1
+#define S5P_FIMV_CODEC_VP9_ENC		27
+
+/* Encoder buffer size for MFCv12 */
+#define ENC_V120_BASE_SIZE(x, y) \
+	((((x) + 3) * ((y) + 3) * 8) \
+	+ ((((y) * 64) + 2304) * ((x) + 7) / 8))
+
+#define ENC_V120_H264_ME_SIZE(x, y) \
+	ALIGN((ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP((x) * (y), 64) * 32)), 256)
+
+#define ENC_V120_MPEG4_ME_SIZE(x, y) \
+	ALIGN((ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP((x) * (y), 128) * 16)), 256)
+
+#define ENC_V120_VP8_ME_SIZE(x, y) \
+	ALIGN(ENC_V120_BASE_SIZE((x), (y)), 256)
+
+#define ENC_V120_HEVC_ME_SIZE(x, y)     \
+	ALIGN(((((x) + 3) * ((y) + 3) * 32)       \
+	+ ((((y) * 128) + 2304) * ((x) + 3) / 4)), 256)
+
+#endif /*_REGS_MFC_V12_H*/
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index e30e54935d79..dee9ef017997 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -790,6 +790,8 @@ static int s5p_mfc_open(struct file *file)
 	INIT_LIST_HEAD(&ctx->dst_queue);
 	ctx->src_queue_cnt = 0;
 	ctx->dst_queue_cnt = 0;
+	ctx->is_422 = 0;
+	ctx->is_10bit = 0;
 	/* Get context number */
 	ctx->num = 0;
 	while (dev->ctx[ctx->num]) {
@@ -1660,6 +1662,31 @@ static struct s5p_mfc_variant mfc_drvdata_v10 = {
 	.fw_name[0]     = "s5p-mfc-v10.fw",
 };
 
+static struct s5p_mfc_buf_size_v6 mfc_buf_size_v12 = {
+	.dev_ctx        = MFC_CTX_BUF_SIZE_V12,
+	.h264_dec_ctx   = MFC_H264_DEC_CTX_BUF_SIZE_V12,
+	.other_dec_ctx  = MFC_OTHER_DEC_CTX_BUF_SIZE_V12,
+	.h264_enc_ctx   = MFC_H264_ENC_CTX_BUF_SIZE_V12,
+	.hevc_enc_ctx   = MFC_HEVC_ENC_CTX_BUF_SIZE_V12,
+	.other_enc_ctx  = MFC_OTHER_ENC_CTX_BUF_SIZE_V12,
+};
+
+static struct s5p_mfc_buf_size buf_size_v12 = {
+	.fw     = MAX_FW_SIZE_V12,
+	.cpb    = MAX_CPB_SIZE_V12,
+	.priv   = &mfc_buf_size_v12,
+};
+
+static struct s5p_mfc_variant mfc_drvdata_v12 = {
+	.version        = MFC_VERSION_V12,
+	.version_bit    = MFC_V12_BIT,
+	.port_num       = MFC_NUM_PORTS_V12,
+	.buf_size       = &buf_size_v12,
+	.fw_name[0]     = "s5p-mfc-v12.fw",
+	.clk_names	= {"mfc"},
+	.num_clocks	= 1,
+};
+
 static const struct of_device_id exynos_mfc_match[] = {
 	{
 		.compatible = "samsung,mfc-v5",
@@ -1682,6 +1709,9 @@ static const struct of_device_id exynos_mfc_match[] = {
 	}, {
 		.compatible = "samsung,mfc-v10",
 		.data = &mfc_drvdata_v10,
+	}, {
+		.compatible = "tesla,fsd-mfc",
+		.data = &mfc_drvdata_v12,
 	},
 	{},
 };
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index 2ae2f23c4741..ba0990a6e6a8 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -19,7 +19,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-v4l2.h>
 #include "regs-mfc.h"
-#include "regs-mfc-v10.h"
+#include "regs-mfc-v12.h"
 
 #define S5P_MFC_NAME		"s5p-mfc"
 
@@ -720,6 +720,8 @@ struct s5p_mfc_ctx {
 	struct v4l2_ctrl *ctrls[MFC_MAX_CTRLS];
 	struct v4l2_ctrl_handler ctrl_handler;
 	size_t scratch_buf_size;
+	int is_10bit;
+	int is_422;
 };
 
 /*
@@ -775,6 +777,7 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define IS_MFCV7_PLUS(dev)	((dev)->variant->version >= 0x70)
 #define IS_MFCV8_PLUS(dev)	((dev)->variant->version >= 0x80)
 #define IS_MFCV10_PLUS(dev)	((dev)->variant->version >= 0xA0)
+#define IS_MFCV12(dev)		((dev)->variant->version >= 0xC0)
 #define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
 
 #define MFC_V5_BIT	BIT(0)
@@ -782,11 +785,15 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define MFC_V7_BIT	BIT(2)
 #define MFC_V8_BIT	BIT(3)
 #define MFC_V10_BIT	BIT(5)
+#define MFC_V12_BIT	BIT(7)
 
 #define MFC_V5PLUS_BITS		(MFC_V5_BIT | MFC_V6_BIT | MFC_V7_BIT | \
-					MFC_V8_BIT | MFC_V10_BIT)
+					MFC_V8_BIT | MFC_V10_BIT | MFC_V12_BIT)
 #define MFC_V6PLUS_BITS		(MFC_V6_BIT | MFC_V7_BIT | MFC_V8_BIT | \
-					MFC_V10_BIT)
-#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT)
+					MFC_V10_BIT | MFC_V12_BIT)
+#define MFC_V7PLUS_BITS		(MFC_V7_BIT | MFC_V8_BIT | MFC_V10_BIT | \
+					MFC_V12_BIT)
+
+#define MFC_V10PLUS_BITS	(MFC_V10_BIT | MFC_V12_BIT)
 
 #endif /* S5P_MFC_COMMON_H_ */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
index 54b54b2fa9b1..b49159142c53 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
@@ -130,7 +130,7 @@ int s5p_mfc_reset(struct s5p_mfc_dev *dev)
 			mfc_write(dev, 0, S5P_FIMV_REG_CLEAR_BEGIN_V6 + (i*4));
 
 		/* check bus reset control before reset */
-		if (dev->risc_on)
+		if (dev->risc_on && !IS_MFCV12(dev))
 			if (s5p_mfc_bus_reset(dev))
 				return -EIO;
 		/* Reset
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
index 268ffe4da53c..e219cbcd86d5 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_dec.c
@@ -146,7 +146,7 @@ static struct s5p_mfc_fmt formats[] = {
 		.codec_mode	= S5P_FIMV_CODEC_HEVC_DEC,
 		.type		= MFC_FMT_DEC,
 		.num_planes	= 1,
-		.versions	= MFC_V10_BIT,
+		.versions	= MFC_V10PLUS_BITS,
 		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION |
 				  V4L2_FMT_FLAG_CONTINUOUS_BYTESTREAM,
 	},
@@ -155,7 +155,7 @@ static struct s5p_mfc_fmt formats[] = {
 		.codec_mode	= S5P_FIMV_CODEC_VP9_DEC,
 		.type		= MFC_FMT_DEC,
 		.num_planes	= 1,
-		.versions	= MFC_V10_BIT,
+		.versions	= MFC_V10PLUS_BITS,
 		.flags		= V4L2_FMT_FLAG_DYN_RESOLUTION,
 	},
 };
@@ -355,7 +355,7 @@ static int vidioc_g_fmt(struct file *file, void *priv, struct v4l2_format *f)
 		pix_mp->width = ctx->buf_width;
 		pix_mp->height = ctx->buf_height;
 		pix_mp->field = V4L2_FIELD_NONE;
-		pix_mp->num_planes = 2;
+		pix_mp->num_planes = ctx->dst_fmt->num_planes;
 		/* Set pixelformat to the format in which MFC
 		   outputs the decoded frame */
 		pix_mp->pixelformat = ctx->dst_fmt->fourcc;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index 4b4c129c09e7..d518e329ffbb 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -92,7 +92,7 @@ static struct s5p_mfc_fmt formats[] = {
 		.codec_mode	= S5P_FIMV_CODEC_HEVC_ENC,
 		.type		= MFC_FMT_ENC,
 		.num_planes	= 1,
-		.versions	= MFC_V10_BIT,
+		.versions	= MFC_V10PLUS_BITS,
 	},
 };
 
@@ -1179,7 +1179,8 @@ static int enc_post_seq_start(struct s5p_mfc_ctx *ctx)
 		if (FW_HAS_E_MIN_SCRATCH_BUF(dev)) {
 			ctx->scratch_buf_size = s5p_mfc_hw_call(dev->mfc_ops,
 					get_e_min_scratch_buf_size, dev);
-			ctx->bank1.size += ctx->scratch_buf_size;
+			if (!IS_MFCV12(dev))
+				ctx->bank1.size += ctx->scratch_buf_size;
 		}
 		ctx->state = MFCINST_HEAD_PRODUCED;
 	}
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
index b9831275f3ab..87ac56756a16 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr.h
@@ -166,9 +166,9 @@ struct s5p_mfc_regs {
 	void __iomem *d_decoded_third_addr;/* only v7 */
 	void __iomem *d_used_dpb_flag_upper;/* v7 and v8 */
 	void __iomem *d_used_dpb_flag_lower;/* v7 and v8 */
-	void __iomem *d_min_scratch_buffer_size; /* v10 */
-	void __iomem *d_static_buffer_addr; /* v10 */
-	void __iomem *d_static_buffer_size; /* v10 */
+	void __iomem *d_min_scratch_buffer_size; /* v10 and v12 */
+	void __iomem *d_static_buffer_addr; /* v10 and v12 */
+	void __iomem *d_static_buffer_size; /* v10 and v12 */
 
 	/* encoder registers */
 	void __iomem *e_frame_width;
@@ -268,7 +268,7 @@ struct s5p_mfc_regs {
 	void __iomem *e_vp8_hierarchical_qp_layer0;/* v7 and v8 */
 	void __iomem *e_vp8_hierarchical_qp_layer1;/* v7 and v8 */
 	void __iomem *e_vp8_hierarchical_qp_layer2;/* v7 and v8 */
-	void __iomem *e_min_scratch_buffer_size; /* v10 */
+	void __iomem *e_min_scratch_buffer_size; /* v10 and v12 */
 	void __iomem *e_num_t_layer; /* v10 */
 	void __iomem *e_hier_qp_layer0; /* v10 */
 	void __iomem *e_hier_bit_rate_layer0; /* v10 */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
index 882166e4ac50..a49aa6c1e30b 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c
@@ -60,12 +60,14 @@ static void s5p_mfc_release_dec_desc_buffer_v6(struct s5p_mfc_ctx *ctx)
 static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 {
 	struct s5p_mfc_dev *dev = ctx->dev;
-	unsigned int mb_width, mb_height;
+	unsigned int mb_width, mb_height, width64, height32;
 	unsigned int lcu_width = 0, lcu_height = 0;
 	int ret;
 
 	mb_width = MB_WIDTH(ctx->img_width);
 	mb_height = MB_HEIGHT(ctx->img_height);
+	width64 = ALIGN(ctx->img_width, 64);
+	height32 = ALIGN(ctx->img_height, 32);
 
 	if (ctx->type == MFCINST_DECODER) {
 		mfc_debug(2, "Luma size:%d Chroma size:%d MV size:%d\n",
@@ -82,7 +84,39 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
+			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
+			if (ctx->codec_mode == S5P_FIMV_CODEC_HEVC_ENC && ctx->is_10bit) {
+				ctx->luma_dpb_size =
+					width64 * height32 +
+					ALIGN(DIV_ROUND_UP(lcu_width * 32, 4), 16) * height32 + 128;
+				if (ctx->is_422)
+					ctx->chroma_dpb_size =
+						ctx->luma_dpb_size;
+				else
+					ctx->chroma_dpb_size =
+						width64 * height32 / 2 +
+						ALIGN(DIV_ROUND_UP(lcu_width *
+							32, 4), 16) * height32 / 2 + 128;
+			} else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC &&	ctx->is_10bit) {
+				ctx->luma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) * height32 + 64;
+				ctx->chroma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) * height32 / 2 + 64;
+			} else {
+				ctx->luma_dpb_size =
+					width64 * height32 + 64;
+				if (ctx->is_422)
+					ctx->chroma_dpb_size =
+						ctx->luma_dpb_size;
+				else
+					ctx->chroma_dpb_size =
+						width64 * height32 / 2 + 64;
+			}
+			ctx->luma_dpb_size = ALIGN(ctx->luma_dpb_size + 256, SZ_2K);
+			ctx->chroma_dpb_size = ALIGN(ctx->chroma_dpb_size + 256, SZ_2K);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
 			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
 			if (ctx->codec_mode != S5P_FIMV_CODEC_HEVC_ENC) {
@@ -230,7 +264,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			DEC_VP9_STATIC_BUFFER_SIZE;
 		break;
 	case S5P_MFC_CODEC_H264_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ENC_V120_H264_ME_SIZE(mb_width, mb_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 			ALIGN(ENC_V100_H264_ME_SIZE(mb_width, mb_height), 16);
@@ -254,7 +292,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		break;
 	case S5P_MFC_CODEC_MPEG4_ENC:
 	case S5P_MFC_CODEC_H263_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ENC_V120_MPEG4_ME_SIZE(mb_width, mb_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_MPEG4_ME_SIZE(mb_width,
@@ -265,7 +307,7 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 						mb_width,
 						mb_height);
 		ctx->scratch_buf_size = ALIGN(ctx->scratch_buf_size,
-				S5P_FIMV_SCRATCH_BUFFER_ALIGN_V6);
+					S5P_FIMV_SCRATCH_BUFFER_ALIGN_V6);
 		ctx->bank1.size =
 			ctx->scratch_buf_size + ctx->tmv_buffer_size +
 			(ctx->pb_count * (ctx->luma_dpb_size +
@@ -273,7 +315,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_VP8_ENC:
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			mfc_debug(2, "Use min scratch buffer size\n");
+			ctx->me_buffer_size =
+				ENC_V120_VP8_ME_SIZE(mb_width, mb_height);
+		} else if (IS_MFCV10_PLUS(dev)) {
 			mfc_debug(2, "Use min scratch buffer size\n");
 			ctx->me_buffer_size =
 				ALIGN(ENC_V100_VP8_ME_SIZE(mb_width, mb_height),
@@ -297,9 +343,13 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_HEVC_ENC:
+		if (IS_MFCV12(dev))
+			ctx->me_buffer_size =
+				ENC_V120_HEVC_ME_SIZE(lcu_width, lcu_height);
+		else
+			ctx->me_buffer_size =
+				ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width, lcu_height), 16);
 		mfc_debug(2, "Use min scratch buffer size\n");
-		ctx->me_buffer_size =
-			ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width, lcu_height), 16);
 		ctx->scratch_buf_size = ALIGN(ctx->scratch_buf_size, 256);
 		ctx->bank1.size =
 			ctx->scratch_buf_size + ctx->tmv_buffer_size +
@@ -452,16 +502,15 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
-		if (IS_MFCV10_PLUS(dev)) {
-			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
-					ctx->img_height);
-		} else {
-			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V6(ctx->img_width,
-					ctx->img_height);
-		}
+		if (IS_MFCV12(dev))
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width, ctx->img_height, 1024);
+		else if (IS_MFCV10_PLUS(dev))
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width, ctx->img_height, 512);
+		else
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width, ctx->img_height, 128);
+
 	} else if (ctx->codec_mode == S5P_MFC_CODEC_HEVC_DEC) {
-		ctx->mv_size = s5p_mfc_dec_hevc_mv_size(ctx->img_width,
-				ctx->img_height);
+		ctx->mv_size = s5p_mfc_dec_hevc_mv_size(ctx->img_width, ctx->img_height);
 		ctx->mv_size = ALIGN(ctx->mv_size, 32);
 	} else {
 		ctx->mv_size = 0;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index e4dd03c5454c..ff582eea4217 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
@@ -19,10 +19,8 @@
 
 #define MB_WIDTH(x_size)		DIV_ROUND_UP(x_size, 16)
 #define MB_HEIGHT(y_size)		DIV_ROUND_UP(y_size, 16)
-#define S5P_MFC_DEC_MV_SIZE_V6(x, y)	(MB_WIDTH(x) * \
-					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 128)
-#define S5P_MFC_DEC_MV_SIZE_V10(x, y)	(MB_WIDTH(x) * \
-					(((MB_HEIGHT(y)+1)/2)*2) * 64 + 512)
+#define S5P_MFC_DEC_MV_SIZE(x, y, offset)	(MB_WIDTH(x) * \
+					(((MB_HEIGHT(y) + 1) / 2) * 2) * 64 + (offset))
 #define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
 #define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
 
-- 
2.17.1

