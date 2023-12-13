Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF600810F21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378299AbjLMK7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378486AbjLMK6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:58:48 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08CA1A8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:58:38 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231213105836epoutp026805f739d53fa8d4ec57052b8637fc9f~gXwDTyVLR0121201212epoutp02K
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:58:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231213105836epoutp026805f739d53fa8d4ec57052b8637fc9f~gXwDTyVLR0121201212epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702465116;
        bh=QRIKg5ntMFYI3z90I/oWiYnds6z2whvDZ1XrYDx+4Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eZ8hLGpiy5Oab03kmf86K28vwneJ6ecaa7VgbEw0ZkAs4V3Qc6QKKT9E/Zf3RAizN
         2JuhNLDszCuTt/VZPpNkiCAXHlK9kDuSocoIPMVTre02oDUdpekrkPvlMCt3QNfPVY
         9UmnYqinKA4KCFDYQJdDw8Oqqa198N/etI0m6ByM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231213105835epcas5p1854bbac27f2cac0fb7c9326ef8347cbb~gXwC1uZT11042610426epcas5p19;
        Wed, 13 Dec 2023 10:58:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Sqssj6f8Fz4x9Pw; Wed, 13 Dec
        2023 10:58:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.78.09672.95E89756; Wed, 13 Dec 2023 19:58:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231213081121epcas5p1db0ef76c8ae06a2d1b195153c67acbb6~gVeCBq0v-0204702047epcas5p1I;
        Wed, 13 Dec 2023 08:11:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231213081121epsmtrp1ee474f858f28c527ae59d8979fd7aa60~gVeCApCBp2335123351epsmtrp1W;
        Wed, 13 Dec 2023 08:11:21 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-41-65798e595b14
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.4B.08755.92769756; Wed, 13 Dec 2023 17:11:21 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231213081118epsmtip25c482908816bfb43b9bd229faa5b1e0c~gVd_jS6NF1539415394epsmtip2l;
        Wed, 13 Dec 2023 08:11:18 +0000 (GMT)
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
Subject: [Patch v6 03/10] media: s5p-mfc: Add initial support for MFCv12
Date:   Wed, 13 Dec 2023 13:40:58 +0530
Message-Id: <20231213081105.25817-4-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213081105.25817-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmpm5kX2WqwYZefYunO2ayWhx4f5DF
        4sG8bWwWi388Z7K4v/gzi8WhzVvZLdbsPcdkMf/IOVaLmwd2MllcnHmXxaLvxUNmi02Pr7Fa
        PHwVbnF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWSza+oXdonXvEXaLlsYlrA6iHteXfGL2
        2DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R59W1Yxevxrmsvu8XmTnMepr5/ZA7iism0yUhNT
        UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgH5UUihLzCkFCgUk
        Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRn7Gldyliw
        r5ex4uK1qUwNjFdLuxg5OSQETCTmLz7N0sXIxSEksJtRYnH7SnYI5xOjxM+22YwQzjdGiVPP
        GthhWk6c3s0KkdjLKNFy6AEzhNPKJHHlSQvQMA4ONgFdibPbc0AaRAQaGSUed5SA1DALHGeW
        WDBhJgtIQljAQ+Lx/x1gNouAqsS3/oNsIL28ArYSt7eWQSyTl1i94QAziM0pYCfxrmk/2EUS
        Ajc4JDqvPWCFKHKR+PP9ODOELSzx6vgWqEulJF72t0HZyRKPF72EqsmRWL9nCguEbS9x4Moc
        sJuZBTQl1u/ShwjLSkw9tY4JxGYW4JPo/f2ECSLOK7FjHoytJjHnzg+oE2QkDq9eyghhe0hs
        P7EcGnITGSV63s1lncAoNwthxQJGxlWMkqkFxbnpqcWmBcZ5qeXwaEvOz93ECE7IWt47GB89
        +KB3iJGJg/EQowQHs5II78kd5alCvCmJlVWpRfnxRaU5qcWHGE2B4TeRWUo0OR+YE/JK4g1N
        LA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamDKu/Foe7Yi41TXwlOn77SJ
        KM/P9b/pKnM28fn+znPC970ThMS8j8k/12HqElTuvviSf75wwgHmo+fsFSbUeT90X5VgPkux
        MnGW7THzeFH16P6Gln1N6jtPccokHg2sf37tZf3T92ufpC17d/3CnK1PDsRuXRkRy1HErMdo
        fnJB9RKVZC89++tugZdez3wfUlU7q/AoZ9VBSVabjUaLPs/dvm7TT3Nm37O/QtY9fBgX9sVL
        pDaU59+NFX9/fakVvXllwVSfo9nPz/+UUrx2drHYvKq8b9/f7ovSjuUz8UieuDsixPjCfsX1
        blO45jReCOF1TKv7//z5VvkbZ5YmPj4WOzv6i9G0J1U2u65k8M0oUWIpzkg01GIuKk4EAG2x
        4Z9RBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvK5memWqwbNeTYunO2ayWhx4f5DF
        4sG8bWwWi388Z7K4v/gzi8WhzVvZLdbsPcdkMf/IOVaLmwd2MllcnHmXxaLvxUNmi02Pr7Fa
        PHwVbnF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWSza+oXdonXvEXaLlsYlrA6iHteXfGL2
        2DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R59W1Yxevxrmsvu8XmTnMepr5/ZA7iiuGxSUnMy
        y1KL9O0SuDL2tC5lLNjXy1hx8dpUpgbGq6VdjJwcEgImEidO72btYuTiEBLYzSix9uReZoiE
        jMT/tmPsELawxMp/z9khipqZJPr6V7N0MXJwsAnoSpzdngMSFxFoZZS4vrKTCcRhFrjNLLFp
        wkOwbmEBD4nH/3ewgNgsAqoS3/oPsoE08wrYStzeWgaxQF5i9YYDYIs5Bewk3jXtZwSxhYBK
        lu++zTyBkW8BI8MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgmNHS3MG4fdUHvUOM
        TByMhxglOJiVRHhP7ihPFeJNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1
        CCbLxMEp1cBUKLZ558p8r5yeJ4xybPEZP8sqbwZEy+UGdV769ielLi3knW5x/VbOw7fPnnin
        du2Q6PVpcYu+NjjGpYl8z7Dp2mBbNeFh/6R9xz4pTZJP/p1kvPF9kf6ENWaZZ1ScFl/+7RfP
        fvX7BwPlffq88w1fhQv/4WBWe/zH8U/L8x/Lbs6ud1uxu2bVjP67r6KTq47cerDm2/JTJ1l1
        u5L+PAybUjSxYC7LPA8WsXf3Jyj8dPj1Labm9JQzly59CbzDHiuje6rl6BNpvVSvL/PtXkkw
        OZr9mb1p91ydj4/CJPd3PWfVu7706qGzPRZts56e+uHH7vFRWlG46gmbbWe49LeNP2dY7Jgn
        cui9fJRhAn//ZyWW4oxEQy3mouJEABy3S2QIAwAA
X-CMS-MailID: 20231213081121epcas5p1db0ef76c8ae06a2d1b195153c67acbb6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231213081121epcas5p1db0ef76c8ae06a2d1b195153c67acbb6
References: <20231213081105.25817-1-aakarsh.jain@samsung.com>
        <CGME20231213081121epcas5p1db0ef76c8ae06a2d1b195153c67acbb6@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 .../platform/samsung/s5p-mfc/s5p_mfc_common.h | 17 +++-
 .../platform/samsung/s5p-mfc/s5p_mfc_ctrl.c   |  2 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_dec.c    |  6 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    |  5 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr.h    |  8 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 83 +++++++++++++++----
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  6 +-
 9 files changed, 172 insertions(+), 35 deletions(-)
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
index 2ae2f23c4741..aa87b3404b33 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -19,7 +19,7 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-v4l2.h>
 #include "regs-mfc.h"
-#include "regs-mfc-v10.h"
+#include "regs-mfc-v12.h"
 
 #define S5P_MFC_NAME		"s5p-mfc"
 
@@ -621,6 +621,8 @@ struct s5p_mfc_codec_ops {
  *			v4l2 control framework
  * @ctrl_handler:	handler for v4l2 framework
  * @scratch_buf_size:	scratch buffer size
+ * @is_10bit:		state to check 10bit support
+ * @is_422:		state to check YUV422 10bit format
  */
 struct s5p_mfc_ctx {
 	struct s5p_mfc_dev *dev;
@@ -720,6 +722,8 @@ struct s5p_mfc_ctx {
 	struct v4l2_ctrl *ctrls[MFC_MAX_CTRLS];
 	struct v4l2_ctrl_handler ctrl_handler;
 	size_t scratch_buf_size;
+	int is_10bit;
+	int is_422;
 };
 
 /*
@@ -775,6 +779,7 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
 #define IS_MFCV7_PLUS(dev)	((dev)->variant->version >= 0x70)
 #define IS_MFCV8_PLUS(dev)	((dev)->variant->version >= 0x80)
 #define IS_MFCV10_PLUS(dev)	((dev)->variant->version >= 0xA0)
+#define IS_MFCV12(dev)		((dev)->variant->version >= 0xC0)
 #define FW_HAS_E_MIN_SCRATCH_BUF(dev) (IS_MFCV10_PLUS(dev))
 
 #define MFC_V5_BIT	BIT(0)
@@ -782,11 +787,15 @@ void s5p_mfc_cleanup_queue(struct list_head *lh, struct vb2_queue *vq);
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

