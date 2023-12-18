Return-Path: <linux-kernel+bounces-3440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F05DB816C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5CD1F2391A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF701C6A7;
	Mon, 18 Dec 2023 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LlyFTxRB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC91A732;
	Mon, 18 Dec 2023 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIB476Z031195;
	Mon, 18 Dec 2023 11:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=HQcOzUhk8zNeXD1GwDBA8FVDCbBz6VQpKL6SA2SwzOY=; b=Ll
	yFTxRBgaZcpplidbCzjh2ut0w+YX+AToqIH8TOoGO/fZbm1YzgSSAJ1Yf2cn+y0K
	4MBs46xG/ynbW+9e5Q8CzCTxmy6Puk842pMxgwdn8Y9ehXGSHU9J4zmwSWavPWQd
	BUci9q2g5gaKFUn9tu9VRGARqCWqsb0RIZvUvJYyHHDI1XpAy3j4a8NVh7KlNMJF
	sXcJZq1ZSkT24QZWo7teceC4j7SFKFdkKJ+oziVGqDmVV4fM/tVXhtxHmz6JvjmV
	7EeVF1Rg/BgxHu8J08KJIt1fASulsRNS5k1eNOG3+licffEaVOC55jJfyUjx8z9b
	KuxahDI78AHvJ8z45ijg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2jx0gb98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:08 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX5Qx029941;
	Mon, 18 Dec 2023 11:33:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyg8-1;
	Mon, 18 Dec 2023 11:33:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX54W029912;
	Mon, 18 Dec 2023 11:33:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX50W029904;
	Mon, 18 Dec 2023 11:33:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 2691C22BD; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 03/34] media: introduce common helpers for buffer size calculation
Date: Mon, 18 Dec 2023 17:01:58 +0530
Message-Id: <1702899149-21321-4-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2cwTLidpDbCdBte__SHwa2lVRyEoD1tB
X-Proofpoint-GUID: 2cwTLidpDbCdBte__SHwa2lVRyEoD1tB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=916 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Introduce helper to calculate size of pixel buffer and
use in venus driver.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/buffers.c       | 103 ++++++++++++
 drivers/media/platform/qcom/vcodec/buffers.h       |  15 ++
 drivers/media/platform/qcom/vcodec/venus/Makefile  |   4 +-
 drivers/media/platform/qcom/vcodec/venus/helpers.c | 172 ++++-----------------
 drivers/media/platform/qcom/vcodec/venus/helpers.h |   2 +-
 .../platform/qcom/vcodec/venus/hfi_plat_bufs.h     |   4 +-
 .../platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c  |  10 +-
 drivers/media/platform/qcom/vcodec/venus/vdec.c    |   5 +-
 8 files changed, 157 insertions(+), 158 deletions(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/buffers.c
 create mode 100644 drivers/media/platform/qcom/vcodec/buffers.h

diff --git a/drivers/media/platform/qcom/vcodec/buffers.c b/drivers/media/platform/qcom/vcodec/buffers.c
new file mode 100644
index 0000000..58ab3b0
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/buffers.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/videodev2.h>
+
+#include "buffers.h"
+
+u32 video_raw_buffer_size(u32 colorformat,
+			  u32 pix_width,
+			  u32 pix_height)
+{
+	u32 size = 0;
+	u32 y_plane, uv_plane, y_stride,
+	uv_stride, y_sclines, uv_sclines;
+	u32 y_ubwc_plane = 0, uv_ubwc_plane = 0;
+	u32 y_meta_stride = 0, y_meta_scanlines = 0;
+	u32 uv_meta_stride = 0, uv_meta_scanlines = 0;
+	u32 y_meta_plane = 0, uv_meta_plane = 0;
+
+	if (!pix_width || !pix_height)
+		goto invalid_input;
+
+	switch (colorformat) {
+	case V4L2_PIX_FMT_NV12:
+	case V4L2_PIX_FMT_NV21:
+		y_stride = ALIGN(pix_width, 128);
+		uv_stride = ALIGN(pix_width, 128);
+		y_sclines = ALIGN(pix_height, 32);
+		uv_sclines = ALIGN((pix_height + 1) >> 1, 16);
+		y_plane = y_stride * y_sclines;
+		uv_plane = uv_stride * uv_sclines;
+		size = y_plane + uv_plane;
+		break;
+	case V4L2_PIX_FMT_QC08C:
+		y_stride = ALIGN(pix_width, 128);
+		uv_stride = ALIGN(pix_width, 128);
+		y_sclines = ALIGN(pix_height, 32);
+		uv_sclines = ALIGN((pix_height + 1) >> 1, 32);
+		y_meta_stride = ALIGN(DIV_ROUND_UP(pix_width, 32), 64);
+		uv_meta_stride = ALIGN(DIV_ROUND_UP((pix_width + 1) >> 1, 16), 64);
+		y_ubwc_plane =
+			ALIGN(y_stride * y_sclines, 4096);
+		uv_ubwc_plane =
+			ALIGN(uv_stride * uv_sclines, 4096);
+		y_meta_scanlines =
+			ALIGN(DIV_ROUND_UP(pix_height, 8), 16);
+		y_meta_plane =
+			ALIGN(y_meta_stride * y_meta_scanlines, 4096);
+		uv_meta_scanlines =
+			ALIGN(DIV_ROUND_UP((pix_height + 1) >> 1, 8), 16);
+		uv_meta_plane =
+			ALIGN(uv_meta_stride * uv_meta_scanlines, 4096);
+		size = (y_ubwc_plane + uv_ubwc_plane + y_meta_plane +
+			uv_meta_plane);
+		break;
+	case V4L2_PIX_FMT_QC10C:
+		y_stride =
+			ALIGN(ALIGN(pix_width, 192) * 4 / 3, 256);
+		uv_stride =
+			ALIGN(ALIGN(pix_width, 192) * 4 / 3, 256);
+		y_sclines =
+			ALIGN(pix_height, 16);
+		uv_sclines =
+			ALIGN((pix_height + 1) >> 1, 16);
+		y_ubwc_plane =
+			ALIGN(y_stride * y_sclines, 4096);
+		uv_ubwc_plane =
+			ALIGN(uv_stride * uv_sclines, 4096);
+		y_meta_stride =
+			ALIGN(DIV_ROUND_UP(pix_width, 48), 64);
+		y_meta_scanlines =
+			ALIGN(DIV_ROUND_UP(pix_height, 4), 16);
+		y_meta_plane =
+			ALIGN(y_meta_stride * y_meta_scanlines, 4096);
+		uv_meta_stride =
+			ALIGN(DIV_ROUND_UP((pix_width + 1) >> 1, 24), 64);
+		uv_meta_scanlines =
+			ALIGN(DIV_ROUND_UP((pix_height + 1) >> 1, 4), 16);
+		uv_meta_plane =
+			ALIGN(uv_meta_stride * uv_meta_scanlines, 4096);
+
+		size = y_ubwc_plane + uv_ubwc_plane + y_meta_plane +
+			uv_meta_plane;
+		break;
+	case V4L2_PIX_FMT_P010:
+		y_stride = ALIGN(pix_width * 2, 128);
+		uv_stride = ALIGN(pix_width * 2, 128);
+		y_sclines = ALIGN(pix_height, 32);
+		uv_sclines = ALIGN((pix_height + 1) >> 1, 16);
+		y_plane = y_stride * y_sclines;
+		uv_plane = uv_stride * uv_sclines;
+
+		size = y_plane + uv_plane;
+		break;
+	default:
+		break;
+	}
+
+invalid_input:
+
+	return ALIGN(size, 4096);
+}
diff --git a/drivers/media/platform/qcom/vcodec/buffers.h b/drivers/media/platform/qcom/vcodec/buffers.h
new file mode 100644
index 0000000..ac1d052
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/buffers.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _BUFFERS_H_
+#define _BUFFERS_H_
+
+#include <linux/types.h>
+
+u32 video_raw_buffer_size(u32 colorformat,
+			  u32 pix_width,
+			  u32 pix_height);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/venus/Makefile b/drivers/media/platform/qcom/vcodec/venus/Makefile
index 1941ef4..6abd54a 100644
--- a/drivers/media/platform/qcom/vcodec/venus/Makefile
+++ b/drivers/media/platform/qcom/vcodec/venus/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Qualcomm Venus driver
 
-venus-core-objs += ../firmware.o \
-		   ../hfi_queue.o
+venus-core-objs += ../firmware.o ../hfi_queue.o ../buffers.o
 
 venus-core-objs += core.o helpers.o firmware_no_tz.o \
 		   hfi_venus.o hfi_msgs.o hfi_cmds.o hfi.o \
@@ -10,6 +9,7 @@ venus-core-objs += core.o helpers.o firmware_no_tz.o \
 		   hfi_platform.o hfi_platform_v4.o \
 		   hfi_platform_v6.o hfi_plat_bufs_v6.o \
 
+venus-dec-objs += ../buffers.o
 venus-dec-objs += vdec.o vdec_ctrls.o
 venus-enc-objs += venc.o venc_ctrls.o
 
diff --git a/drivers/media/platform/qcom/vcodec/venus/helpers.c b/drivers/media/platform/qcom/vcodec/venus/helpers.c
index 8295542..95e4424 100644
--- a/drivers/media/platform/qcom/vcodec/venus/helpers.c
+++ b/drivers/media/platform/qcom/vcodec/venus/helpers.c
@@ -12,6 +12,7 @@
 #include <media/v4l2-mem2mem.h>
 #include <asm/div64.h>
 
+#include "../buffers.h"
 #include "core.h"
 #include "helpers.h"
 #include "hfi_helper.h"
@@ -616,6 +617,27 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
 	return 0;
 }
 
+u32 to_v4l2_raw_fmt(u32 hfi_color_fmt)
+{
+	switch (hfi_color_fmt) {
+	case HFI_COLOR_FORMAT_NV12:
+		return V4L2_PIX_FMT_NV12;
+	case HFI_COLOR_FORMAT_NV21:
+		return V4L2_PIX_FMT_NV21;
+	case HFI_COLOR_FORMAT_NV12_UBWC:
+		return V4L2_PIX_FMT_QC08C;
+	case HFI_COLOR_FORMAT_YUV420_TP10_UBWC:
+		return V4L2_PIX_FMT_QC10C;
+	case HFI_COLOR_FORMAT_P010:
+		return V4L2_PIX_FMT_P010;
+	default:
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(to_v4l2_raw_fmt);
+
 static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
 			       struct hfi_buffer_requirements *req)
 {
@@ -639,20 +661,20 @@ static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
 		params.out_width = inst->out_width;
 		params.out_height = inst->out_height;
 		params.codec = inst->fmt_out->pixfmt;
-		params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_cap->pixfmt);
+		params.color_fmt = inst->fmt_cap->pixfmt;
 		params.dec.max_mbs_per_frame = mbs_per_frame_max(inst);
 		params.dec.buffer_size_limit = 0;
 		params.dec.is_secondary_output =
 			inst->opb_buftype == HFI_BUFFER_OUTPUT2;
 		if (params.dec.is_secondary_output)
-			params.hfi_dpb_color_fmt = inst->dpb_fmt;
+			params.dpb_color_fmt = to_v4l2_raw_fmt(inst->dpb_fmt);
 		params.dec.is_interlaced =
 			inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE;
 	} else {
 		params.width = inst->out_width;
 		params.height = inst->out_height;
 		params.codec = inst->fmt_cap->pixfmt;
-		params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_out->pixfmt);
+		params.color_fmt = inst->fmt_out->pixfmt;
 		params.enc.work_mode = VIDC_WORK_MODE_2;
 		params.enc.rc_type = HFI_RATE_CONTROL_OFF;
 		if (enc_ctr->bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_CQ)
@@ -942,146 +964,10 @@ int venus_helper_set_profile_level(struct venus_inst *inst, u32 profile, u32 lev
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_profile_level);
 
-static u32 get_framesize_raw_nv12(u32 width, u32 height)
-{
-	u32 y_stride, uv_stride, y_plane;
-	u32 y_sclines, uv_sclines, uv_plane;
-	u32 size;
-
-	y_stride = ALIGN(width, 128);
-	uv_stride = ALIGN(width, 128);
-	y_sclines = ALIGN(height, 32);
-	uv_sclines = ALIGN(((height + 1) >> 1), 16);
-
-	y_plane = y_stride * y_sclines;
-	uv_plane = uv_stride * uv_sclines + SZ_4K;
-	size = y_plane + uv_plane + SZ_8K;
-
-	return ALIGN(size, SZ_4K);
-}
-
-static u32 get_framesize_raw_nv12_ubwc(u32 width, u32 height)
-{
-	u32 y_meta_stride, y_meta_plane;
-	u32 y_stride, y_plane;
-	u32 uv_meta_stride, uv_meta_plane;
-	u32 uv_stride, uv_plane;
-	u32 extradata = SZ_16K;
-
-	y_meta_stride = ALIGN(DIV_ROUND_UP(width, 32), 64);
-	y_meta_plane = y_meta_stride * ALIGN(DIV_ROUND_UP(height, 8), 16);
-	y_meta_plane = ALIGN(y_meta_plane, SZ_4K);
-
-	y_stride = ALIGN(width, 128);
-	y_plane = ALIGN(y_stride * ALIGN(height, 32), SZ_4K);
-
-	uv_meta_stride = ALIGN(DIV_ROUND_UP(width / 2, 16), 64);
-	uv_meta_plane = uv_meta_stride * ALIGN(DIV_ROUND_UP(height / 2, 8), 16);
-	uv_meta_plane = ALIGN(uv_meta_plane, SZ_4K);
-
-	uv_stride = ALIGN(width, 128);
-	uv_plane = ALIGN(uv_stride * ALIGN(height / 2, 32), SZ_4K);
-
-	return ALIGN(y_meta_plane + y_plane + uv_meta_plane + uv_plane +
-		     max(extradata, y_stride * 48), SZ_4K);
-}
-
-static u32 get_framesize_raw_p010(u32 width, u32 height)
-{
-	u32 y_plane, uv_plane, y_stride, uv_stride, y_sclines, uv_sclines;
-
-	y_stride = ALIGN(width * 2, 128);
-	uv_stride = ALIGN(width * 2, 128);
-	y_sclines = ALIGN(height, 32);
-	uv_sclines = ALIGN((height + 1) >> 1, 16);
-	y_plane = y_stride * y_sclines;
-	uv_plane = uv_stride * uv_sclines;
-
-	return ALIGN((y_plane + uv_plane), SZ_4K);
-}
-
-static u32 get_framesize_raw_p010_ubwc(u32 width, u32 height)
-{
-	u32 y_stride, uv_stride, y_sclines, uv_sclines;
-	u32 y_ubwc_plane, uv_ubwc_plane;
-	u32 y_meta_stride, y_meta_scanlines;
-	u32 uv_meta_stride, uv_meta_scanlines;
-	u32 y_meta_plane, uv_meta_plane;
-	u32 size;
-
-	y_stride = ALIGN(width * 2, 256);
-	uv_stride = ALIGN(width * 2, 256);
-	y_sclines = ALIGN(height, 16);
-	uv_sclines = ALIGN((height + 1) >> 1, 16);
-
-	y_ubwc_plane = ALIGN(y_stride * y_sclines, SZ_4K);
-	uv_ubwc_plane = ALIGN(uv_stride * uv_sclines, SZ_4K);
-	y_meta_stride = ALIGN(DIV_ROUND_UP(width, 32), 64);
-	y_meta_scanlines = ALIGN(DIV_ROUND_UP(height, 4), 16);
-	y_meta_plane = ALIGN(y_meta_stride * y_meta_scanlines, SZ_4K);
-	uv_meta_stride = ALIGN(DIV_ROUND_UP((width + 1) >> 1, 16), 64);
-	uv_meta_scanlines = ALIGN(DIV_ROUND_UP((height + 1) >> 1, 4), 16);
-	uv_meta_plane = ALIGN(uv_meta_stride * uv_meta_scanlines, SZ_4K);
-
-	size = y_ubwc_plane + uv_ubwc_plane + y_meta_plane + uv_meta_plane;
-
-	return ALIGN(size, SZ_4K);
-}
-
-static u32 get_framesize_raw_yuv420_tp10_ubwc(u32 width, u32 height)
-{
-	u32 y_stride, uv_stride, y_sclines, uv_sclines;
-	u32 y_ubwc_plane, uv_ubwc_plane;
-	u32 y_meta_stride, y_meta_scanlines;
-	u32 uv_meta_stride, uv_meta_scanlines;
-	u32 y_meta_plane, uv_meta_plane;
-	u32 extradata = SZ_16K;
-	u32 size;
-
-	y_stride = ALIGN(width * 4 / 3, 256);
-	uv_stride = ALIGN(width * 4 / 3, 256);
-	y_sclines = ALIGN(height, 16);
-	uv_sclines = ALIGN((height + 1) >> 1, 16);
-
-	y_ubwc_plane = ALIGN(y_stride * y_sclines, SZ_4K);
-	uv_ubwc_plane = ALIGN(uv_stride * uv_sclines, SZ_4K);
-	y_meta_stride = ALIGN(DIV_ROUND_UP(width, 48), 64);
-	y_meta_scanlines = ALIGN(DIV_ROUND_UP(height, 4), 16);
-	y_meta_plane = ALIGN(y_meta_stride * y_meta_scanlines, SZ_4K);
-	uv_meta_stride = ALIGN(DIV_ROUND_UP((width + 1) >> 1, 24), 64);
-	uv_meta_scanlines = ALIGN(DIV_ROUND_UP((height + 1) >> 1, 4), 16);
-	uv_meta_plane = ALIGN(uv_meta_stride * uv_meta_scanlines, SZ_4K);
-
-	size = y_ubwc_plane + uv_ubwc_plane + y_meta_plane + uv_meta_plane;
-	size += max(extradata + SZ_8K, y_stride * 48);
-
-	return ALIGN(size, SZ_4K);
-}
-
-u32 venus_helper_get_framesz_raw(u32 hfi_fmt, u32 width, u32 height)
-{
-	switch (hfi_fmt) {
-	case HFI_COLOR_FORMAT_NV12:
-	case HFI_COLOR_FORMAT_NV21:
-		return get_framesize_raw_nv12(width, height);
-	case HFI_COLOR_FORMAT_NV12_UBWC:
-		return get_framesize_raw_nv12_ubwc(width, height);
-	case HFI_COLOR_FORMAT_P010:
-		return get_framesize_raw_p010(width, height);
-	case HFI_COLOR_FORMAT_P010_UBWC:
-		return get_framesize_raw_p010_ubwc(width, height);
-	case HFI_COLOR_FORMAT_YUV420_TP10_UBWC:
-		return get_framesize_raw_yuv420_tp10_ubwc(width, height);
-	default:
-		return 0;
-	}
-}
-EXPORT_SYMBOL_GPL(venus_helper_get_framesz_raw);
-
 u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
 {
-	u32 hfi_fmt, sz;
 	bool compressed;
+	u32 sz;
 
 	switch (v4l2_fmt) {
 	case V4L2_PIX_FMT_MPEG:
@@ -1112,11 +998,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
 		return ALIGN(sz, SZ_4K);
 	}
 
-	hfi_fmt = to_hfi_raw_fmt(v4l2_fmt);
-	if (!hfi_fmt)
-		return 0;
-
-	return venus_helper_get_framesz_raw(hfi_fmt, width, height);
+	return video_raw_buffer_size(v4l2_fmt, width, height);
 }
 EXPORT_SYMBOL_GPL(venus_helper_get_framesz);
 
diff --git a/drivers/media/platform/qcom/vcodec/venus/helpers.h b/drivers/media/platform/qcom/vcodec/venus/helpers.h
index 358e4f3..9b72d18 100644
--- a/drivers/media/platform/qcom/vcodec/venus/helpers.h
+++ b/drivers/media/platform/qcom/vcodec/venus/helpers.h
@@ -11,6 +11,7 @@
 struct venus_inst;
 struct venus_core;
 
+u32 to_v4l2_raw_fmt(u32 hfi_color_fmt);
 bool venus_helper_check_codec(struct venus_inst *inst, u32 v4l2_pixfmt);
 struct vb2_v4l2_buffer *venus_helper_find_buf(struct venus_inst *inst,
 					      unsigned int type, u32 idx);
@@ -29,7 +30,6 @@ void venus_helper_m2m_device_run(void *priv);
 void venus_helper_m2m_job_abort(void *priv);
 int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
 			    struct hfi_buffer_requirements *req);
-u32 venus_helper_get_framesz_raw(u32 hfi_fmt, u32 width, u32 height);
 u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height);
 int venus_helper_set_input_resolution(struct venus_inst *inst,
 				      unsigned int width, unsigned int height);
diff --git a/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h
index 25e6074..20f684e 100644
--- a/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h
+++ b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs.h
@@ -15,8 +15,8 @@ struct hfi_plat_buffers_params {
 	u32 out_width;
 	u32 out_height;
 	u32 codec;
-	u32 hfi_color_fmt;
-	u32 hfi_dpb_color_fmt;
+	u32 color_fmt;
+	u32 dpb_color_fmt;
 	enum hfi_version version;
 	u32 num_vpp_pipes;
 	union {
diff --git a/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c
index f5a6559..3e06516 100644
--- a/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c
+++ b/drivers/media/platform/qcom/vcodec/venus/hfi_plat_bufs_v6.c
@@ -6,6 +6,7 @@
 #include <linux/sizes.h>
 #include <linux/videodev2.h>
 
+#include "../buffers.h"
 #include "hfi.h"
 #include "hfi_plat_bufs.h"
 #include "helpers.h"
@@ -1233,13 +1234,11 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
 						       buffer_size_limit);
 	} else if (buftype == HFI_BUFFER_OUTPUT || buftype == HFI_BUFFER_OUTPUT2) {
 		hfi_bufreq_set_count_min(bufreq, version, out_min_count);
-		bufreq->size =
-			venus_helper_get_framesz_raw(params->hfi_color_fmt,
+		bufreq->size = video_raw_buffer_size(params->color_fmt,
 						     out_width, out_height);
 		if (buftype == HFI_BUFFER_OUTPUT &&
 		    params->dec.is_secondary_output)
-			bufreq->size =
-				venus_helper_get_framesz_raw(params->hfi_dpb_color_fmt,
+			bufreq->size = video_raw_buffer_size(params->dpb_color_fmt,
 							     out_width, out_height);
 	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {
 		bufreq->size = dec_ops->scratch(width, height, is_interlaced);
@@ -1297,8 +1296,7 @@ static int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
 
 	if (buftype == HFI_BUFFER_INPUT) {
 		hfi_bufreq_set_count_min(bufreq, version, MIN_INPUT_BUFFERS);
-		bufreq->size =
-			venus_helper_get_framesz_raw(params->hfi_color_fmt,
+		bufreq->size = video_raw_buffer_size(params->color_fmt,
 						     width, height);
 	} else if (buftype == HFI_BUFFER_OUTPUT ||
 		   buftype == HFI_BUFFER_OUTPUT2) {
diff --git a/drivers/media/platform/qcom/vcodec/venus/vdec.c b/drivers/media/platform/qcom/vcodec/venus/vdec.c
index dbf305c..e6316be 100644
--- a/drivers/media/platform/qcom/vcodec/venus/vdec.c
+++ b/drivers/media/platform/qcom/vcodec/venus/vdec.c
@@ -15,6 +15,7 @@
 #include <media/v4l2-mem2mem.h>
 #include <media/videobuf2-dma-contig.h>
 
+#include "../buffers.h"
 #include "hfi_venus_io.h"
 #include "hfi_parser.h"
 #include "core.h"
@@ -777,9 +778,9 @@ static int vdec_output_conf(struct venus_inst *inst)
 		return ret;
 
 	inst->output_buf_size =
-			venus_helper_get_framesz_raw(out_fmt, width, height);
+			video_raw_buffer_size(to_v4l2_raw_fmt(out_fmt), width, height);
 	inst->output2_buf_size =
-			venus_helper_get_framesz_raw(out2_fmt, width, height);
+			video_raw_buffer_size(to_v4l2_raw_fmt(out2_fmt), width, height);
 
 	if (is_ubwc_fmt(out_fmt)) {
 		inst->opb_buftype = HFI_BUFFER_OUTPUT2;
-- 
2.7.4


