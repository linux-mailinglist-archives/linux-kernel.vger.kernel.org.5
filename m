Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6BF7D68C0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjJYKfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343695AbjJYKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:34:45 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0791DD44
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:34:35 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231025103433epoutp04cc1dad548213755deafb02fa77087e7c~RU0EaCMka2132021320epoutp04i
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:34:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231025103433epoutp04cc1dad548213755deafb02fa77087e7c~RU0EaCMka2132021320epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698230073;
        bh=ZcJZG9kQBZ6WJuUCfp5Ibsvxb5snOWQGt2jHMB/jFBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYNEZ3FK2tBh16j9npcPpTBqkPrkdtQHn2vClg0ZNIXW64PTEfVwaf9dF7ytDGFHa
         /lDF3QKL6Hhs47+dP7Y9F7bl30THI0Q+t3Gk5VcLlkrWXLq6lZhR+Nl0Yh7WysqG35
         1RSuD0QBfV4lGkk1fJ2BVbi0CdZzaRJCq05Ih5QY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20231025103432epcas5p4885f507fb22696961448a26641fd0a0d~RU0Dh2F2A2195921959epcas5p4D;
        Wed, 25 Oct 2023 10:34:32 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4SFlfZ6VlHz4x9Py; Wed, 25 Oct
        2023 10:34:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.F8.08567.63FE8356; Wed, 25 Oct 2023 19:34:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102240epcas5p1551ac81bc2cd45f6c84e2eebc11571c4~RUpsLgkY12162221622epcas5p1A;
        Wed, 25 Oct 2023 10:22:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231025102240epsmtrp243c295b64b2dd0aa79b63e3afd05d3a7~RUpsKmQy50922409224epsmtrp22;
        Wed, 25 Oct 2023 10:22:40 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-52-6538ef367618
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.30.18939.07CE8356; Wed, 25 Oct 2023 19:22:40 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231025102237epsmtip1bcb54aa19bc5cf663c99e9dfec1aea66~RUppItTNr0612206122epsmtip1h;
        Wed, 25 Oct 2023 10:22:36 +0000 (GMT)
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
Subject: [Patch v4 03/11] media: s5p-mfc: Add initial support for MFCv12
Date:   Wed, 25 Oct 2023 15:52:08 +0530
Message-Id: <20231025102216.50480-4-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231025102216.50480-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHc997/QGh5A1cdmkGY0/cBqTQjlIvCwUnxL45XTBmMzNDaOgT
        kP5KWzbdlgwR3CATh7oIjJ/yM4DgKkgr1JUKY6s/EDXgpGwCMwgyWIRRxtCtpeD++9xzv+d8
        zz33Xi7uN8zmczPVBkanlisptjdx6Wro6wLJPGKE3dci0UNTKQtZ53sJ9KDyEhvVLk9h6Lfa
        BQLZLnZyUKvlJoYaB6wsVNV3k4W6eicI9IvVjKGh0jECFT0ax5FxcpiFxmf2oTuXy9no6wud
        LFQyeAVD5/vGOKh+ZAhDDcZVDJ3rXOSgfEsfB+UdrWNtg3RrZSugR+qe4LS5bIxD1/ZMY7Sx
        uYBNO4Z72PTFui/o/P4Vgi7qaAb0s9wKDr1gDKLtfy1wknz2Z8VmMHIFowtm1GkaRaY6XUq9
        uzclISVaIhQJRDFoKxWslqsYKZW4K0mwI1PpOjwV/LFcme0KJcn1eioyLlanyTYwwRkavUFK
        MVqFUivWRujlKn22Oj1CzRjeEgmFb0a7hKlZGbdKjCzt6HFwuL7GhueAWU0h8OJCUgyHm85i
        bvYjuwG89UdUIfB28RMAzWUO7PkiN+97zkbGaMWXuGfDDGBf0e11VT4Gl0euswsBl8smBfBG
        l9KdsIk8CuDkVwa3BifPEnCybWGtkj9Jw4Jfe9a8CXILvD73E8vNPFIKHcfusTxur8CWC1bc
        zV5kHKxeyuW4C0FykQvPT1kJtxkkE2FH8RGP3h/ODHSsd8qHC3MWtofT4OS5adzDStjec4bw
        cDy03i1fK4OTobD9cqQnHAi/tbettYaTvvDEP79jnjgPmio3+DVY7lheb/NleLWlHniYhr3O
        VcIzk2IAf56+w/4GBJX9b1ENQDMIYLR6VTqTFq0VqZlPnt9amkZlBGsPPCzRBO5VPYuwAYwL
        bABycWoT78NdiPHjKeRHPmV0mhRdtpLR20C0a37FOP/FNI3rh6gNKSJxjFAskUjEMVESEfUS
        73F+hcKPTJcbmCyG0TK6jTyM68XPwbxmj8dv9yZ/aFz9KFDZ+nSuzee+PS4glNcc/rBJMWrf
        ufuDBFqEyfQFvrXS+P117w32dj9NLevah4Iepep3rAxuHpLmbnmcrAj7rrGWE5Q68GODTCtz
        HmuHuffnqyJjnLaW/qb2PU57virvbyH1fl7v2+H24tOlu5N2UIcEAnJis2rOYVrMSQgMOrFX
        XLOdPDPlvN0wM3XwroIlOqyRlZw86dN/6tWAB9M2JJHFj1+ZOHCtwXJwm3VnimWS7zsdxt/a
        Zpn7zD/WJMPs5oE3kvtT40J6BlZOLZnMe5L/FS6F3HCGLSe+0/XCgdHWmsQoTsjnVYeawh2Y
        YvZPVvUcVFGEPkMuCsN1evl/13kp2GkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJTrfgjUWqwddF/BZPd8xktTjw/iCL
        xYN529gsFv94zmRxf/FnFotDm7eyW6zZe47JYvnxA6wW84+cY7XYfvARi8XNAzuZLC7OvMti
        0ffiIbPFpsfXWC0evgq3uLxrDptFz4atrBYzzu9jslh75C67xdLrF5kslm36w2SxaOsXdovW
        vUfYLVoal7A6SHismbeG0eP6kk/MHjtn3WX3WLznJZPHplWdbB53ru1h89i8pN6j9egvFo++
        LasYPf41zWX3+LxJzuPU18/sATxRXDYpqTmZZalF+nYJXBkXZmxiLbjdxlixdOEh5gbGN/ld
        jJwcEgImErfntjOD2EIC2xkl+q8HQsRlJP63HWOHsIUlVv57DmRzAdU0M0kcmjGFsYuRg4NN
        QFfi7PYckLiIQCujxPWVnUwgDrPAehaJIxuWgHULC3hIdN7bwwRiswioSpx5d4IVxOYVsJW4
        03yDFWKDvMTqDQfAruAUsJNY8K2JHeIiW4n7938wTmDkW8DIsIpRNLWgODc9N7nAUK84Mbe4
        NC9dLzk/dxMjOLq0gnYwLlv/V+8QIxMH4yFGCQ5mJRHeSB+LVCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQam+ftnpGfkyfDw3Mqo+PXj+4u2QN2EiNoj
        kuoauQ/W7VGWqDwetEzl9wLz4+ppVvl3Nq6bcUlcmLPRtSOqXMWRV/vflL8POQ/Ieh+QbRBw
        99uTt/m4VvX68Mx9RxZsvV9TPnHp1sjz21rWTujWbrZm4HnLXfhBLJAhYCGT8iq/0mjDKhf/
        Ry9k+ra2zTmwVGHm2sZLat/bcw+L3Hh59+iutZYLk94FnC8TZ3h58UQo680ZXa03A9pma1xf
        WjZJkKk44khuifCidqcD+/5ZM8x5pfPCVpcpiPn1Z83C0N+ud86KKt36nSF8Klwlz6zteSvD
        YyXelyw155t5jSf/jzNX3euWlGrJmnPgbkAMv7cSS3FGoqEWc1FxIgDB/pVzHQMAAA==
X-CMS-MailID: 20231025102240epcas5p1551ac81bc2cd45f6c84e2eebc11571c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025102240epcas5p1551ac81bc2cd45f6c84e2eebc11571c4
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
        <CGME20231025102240epcas5p1551ac81bc2cd45f6c84e2eebc11571c4@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c | 83 ++++++++++++++++---
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h |  6 +-
 9 files changed, 175 insertions(+), 30 deletions(-)
 create mode 100644 drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h

diff --git a/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h b/drivers/media/platform/samsung/s5p-mfc/regs-mfc-v12.h
new file mode 100644
index 000000000000..6c68a45082d0
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
+	(((x + 3) * (y + 3) * 8) \
+	+ (((y * 64) + 2304) * (x + 7) / 8))
+
+#define ENC_V120_H264_ME_SIZE(x, y) \
+	ALIGN((ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 64) * 32)), 256)
+
+#define ENC_V120_MPEG4_ME_SIZE(x, y) \
+	ALIGN((ENC_V120_BASE_SIZE(x, y) \
+	+ (DIV_ROUND_UP(x * y, 128) * 16)), 256)
+
+#define ENC_V120_VP8_ME_SIZE(x, y) \
+	ALIGN(ENC_V120_BASE_SIZE(x, y), 256)
+
+#define ENC_V120_HEVC_ME_SIZE(x, y)     \
+	ALIGN((((x + 3) * (y + 3) * 32)       \
+	+ (((y * 128) + 2304) * (x + 3) / 4)), 256)
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
index e6ec4a43b290..dd2e9f7704ab 100644
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
 #define IS_MFCV7_PLUS(dev)	(dev->variant->version >= 0x70)
 #define IS_MFCV8_PLUS(dev)	(dev->variant->version >= 0x80)
 #define IS_MFCV10_PLUS(dev)	(dev->variant->version >= 0xA0)
+#define IS_MFCV12(dev)		(dev->variant->version >= 0xC0)
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
index f62703cebb77..e4d6e7c117b5 100644
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
index 882166e4ac50..fb3f0718821d 100644
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
@@ -82,7 +84,44 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 			ctx->tmv_buffer_size = S5P_FIMV_NUM_TMV_BUFFERS_V6 *
 			ALIGN(S5P_FIMV_TMV_BUFFER_SIZE_V6(mb_width, mb_height),
 			S5P_FIMV_TMV_BUFFER_ALIGN_V6);
-		if (IS_MFCV10_PLUS(dev)) {
+		if (IS_MFCV12(dev)) {
+			lcu_width = S5P_MFC_LCU_WIDTH(ctx->img_width);
+			lcu_height = S5P_MFC_LCU_HEIGHT(ctx->img_height);
+			if (ctx->codec_mode == S5P_FIMV_CODEC_HEVC_ENC &&
+								ctx->is_10bit) {
+				ctx->luma_dpb_size =
+					width64 * height32 +
+					ALIGN(DIV_ROUND_UP(lcu_width * 32, 4),
+							16) * height32 + 128;
+				if (ctx->is_422)
+					ctx->chroma_dpb_size =
+						ctx->luma_dpb_size;
+				else
+					ctx->chroma_dpb_size =
+						width64 * height32 / 2 +
+						ALIGN(DIV_ROUND_UP(lcu_width *
+						32, 4), 16) * height32 / 2 + 128;
+			} else if (ctx->codec_mode == S5P_FIMV_CODEC_VP9_ENC &&
+					ctx->is_10bit) {
+				ctx->luma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) *
+					height32 + 64;
+				ctx->chroma_dpb_size =
+					ALIGN(ctx->img_width * 2, 128) *
+					height32 / 2 + 64;
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
@@ -230,7 +269,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
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
@@ -254,7 +297,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
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
@@ -273,7 +320,11 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
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
@@ -297,9 +348,14 @@ static int s5p_mfc_alloc_codec_buffers_v6(struct s5p_mfc_ctx *ctx)
 		ctx->bank2.size = 0;
 		break;
 	case S5P_MFC_CODEC_HEVC_ENC:
+		if (IS_MFCV12(dev))
+			ctx->me_buffer_size =
+				ENC_V120_HEVC_ME_SIZE(lcu_width, lcu_height);
+		else
+			ctx->me_buffer_size =
+				ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width,
+							lcu_height), 16);
 		mfc_debug(2, "Use min scratch buffer size\n");
-		ctx->me_buffer_size =
-			ALIGN(ENC_V100_HEVC_ME_SIZE(lcu_width, lcu_height), 16);
 		ctx->scratch_buf_size = ALIGN(ctx->scratch_buf_size, 256);
 		ctx->bank1.size =
 			ctx->scratch_buf_size + ctx->tmv_buffer_size +
@@ -452,12 +508,15 @@ static void s5p_mfc_dec_calc_dpb_size_v6(struct s5p_mfc_ctx *ctx)
 
 	if (ctx->codec_mode == S5P_MFC_CODEC_H264_DEC ||
 			ctx->codec_mode == S5P_MFC_CODEC_H264_MVC_DEC) {
-		if (IS_MFCV10_PLUS(dev)) {
-			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V10(ctx->img_width,
-					ctx->img_height);
+		if (IS_MFCV12(dev)) {
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width,
+					ctx->img_height, 1024);
+		} else if (IS_MFCV10_PLUS(dev)) {
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width,
+					ctx->img_height, 512);
 		} else {
-			ctx->mv_size = S5P_MFC_DEC_MV_SIZE_V6(ctx->img_width,
-					ctx->img_height);
+			ctx->mv_size = S5P_MFC_DEC_MV_SIZE(ctx->img_width,
+					ctx->img_height, 128);
 		}
 	} else if (ctx->codec_mode == S5P_MFC_CODEC_HEVC_DEC) {
 		ctx->mv_size = s5p_mfc_dec_hevc_mv_size(ctx->img_width,
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_opr_v6.h
index e4dd03c5454c..30269f3e68e8 100644
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
+					(((MB_HEIGHT(y)+1)/2)*2) * 64 + offset)
 #define S5P_MFC_LCU_WIDTH(x_size)	DIV_ROUND_UP(x_size, 32)
 #define S5P_MFC_LCU_HEIGHT(y_size)	DIV_ROUND_UP(y_size, 32)
 
-- 
2.17.1

