Return-Path: <linux-kernel+bounces-3453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE4B816C90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4621F23A29
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086831CA89;
	Mon, 18 Dec 2023 11:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o7WcZUgd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC261B272;
	Mon, 18 Dec 2023 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBDcoC018040;
	Mon, 18 Dec 2023 11:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=Q03KspE6e+LrgwjDhfZcLcqLHb5nu3RQ3Bq6dmATH3A=; b=o7
	WcZUgdsmECrQYua8jt+o82o2lOwgf5OxfMCF/Nt+3MlAxc0e3TbELuHnjLuFsOba
	9d4DJnICVVvwRD8M/E+xDW0W206PQ+GQYZMzQrqbfKp0/CaW9XC93mhLTN3EeoDB
	qntx/IktP86E5kZj6+9W6A3Y3JyB+JjLJbmeplx5JUeC7GTIM1PuXsN8WMqSRDG/
	irb0Th6zn/6zqSCIGLU8R1QEvoqflRBbAN3vMrcmSsU9ET7wE7Izw9BdK8oQb+WD
	hByaLabj7+SmlHF0enS8S76v+pPTk9xUq8fU2kH37cpLKitxVmD8Yt34p419mXh/
	aJwLSMUaHE2YN5wHD1MQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2n1781gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:36:13 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX5R2029941;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyva-1;
	Mon, 18 Dec 2023 11:36:09 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7pT030023;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX8SW030061;
	Mon, 18 Dec 2023 11:36:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 5A85B2346; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 24/34] media: iris: subscribe input and output properties to firmware
Date: Mon, 18 Dec 2023 17:02:19 +0530
Message-Id: <1702899149-21321-25-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YOXUHpHcWpeRvUFeQefdpbGqd7L_sRey
X-Proofpoint-GUID: YOXUHpHcWpeRvUFeQefdpbGqd7L_sRey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Driver can subscribe to different properties for which
it expects a response from firmware. Different SOCs
firmware can support different properties which can be
subscribed by driver.
HFI_CMD_SUBSCRIBE_MODE with HFI_MODE_PROPERTY - to subscribe
any property to firmware.

Also, set below mandatory properties on capture plane:
HFI_PROP_COLOR_FORMAT
HFI_PROP_LINEAR_STRIDE_SCANLINE
HFI_PROP_UBWC_STRIDE_SCANLINE.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |  31 +++++
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |  38 +++++
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   3 +
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  42 ++++++
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |   3 +
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    | 154 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_vdec.h    |   2 +
 .../platform/qcom/vcodec/iris/platform_common.h    |   8 ++
 .../platform/qcom/vcodec/iris/platform_sm8550.c    |  29 ++++
 9 files changed, 310 insertions(+)

diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index ce4eaff..a6078a5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -25,6 +25,29 @@
 #define HFI_PROP_UBWC_BANK_SWZL_LEVEL3		0x03000008
 #define HFI_PROP_UBWC_BANK_SPREADING		0x03000009
 
+enum hfi_property_mode_type {
+	HFI_MODE_NONE					= 0x00000000,
+	HFI_MODE_PORT_SETTINGS_CHANGE			= 0x00000001,
+	HFI_MODE_PROPERTY				= 0x00000002,
+};
+
+#define HFI_CMD_SUBSCRIBE_MODE		0x0100000B
+
+enum hfi_color_format {
+	HFI_COLOR_FMT_OPAQUE        = 0,
+	HFI_COLOR_FMT_NV12          = 1,
+	HFI_COLOR_FMT_NV12_UBWC     = 2,
+	HFI_COLOR_FMT_P010          = 3,
+	HFI_COLOR_FMT_TP10_UBWC     = 4,
+	HFI_COLOR_FMT_RGBA8888      = 5,
+	HFI_COLOR_FMT_RGBA8888_UBWC = 6,
+	HFI_COLOR_FMT_NV21          = 7,
+};
+
+#define HFI_PROP_COLOR_FORMAT			0x03000101
+
+#define HFI_PROP_LINEAR_STRIDE_SCANLINE		0x03000104
+
 #define HFI_PROP_PROFILE			0x03000107
 
 #define HFI_PROP_LEVEL				0x03000108
@@ -49,10 +72,18 @@
 
 #define HFI_PROP_DECODE_ORDER_OUTPUT		0x0300015b
 
+#define HFI_PROP_PICTURE_TYPE			0x03000162
+
 #define HFI_PROP_DEC_DEFAULT_HEADER		0x03000168
 
 #define HFI_PROP_DEC_START_FROM_RAP_FRAME	0x03000169
 
+#define HFI_PROP_NO_OUTPUT			0x0300016a
+
+#define HFI_PROP_DPB_LIST			0x0300017A
+
+#define HFI_PROP_UBWC_STRIDE_SCANLINE		0x03000190
+
 #define HFI_PROP_COMV_BUFFER_COUNT		0x03000193
 
 #define HFI_SYS_ERROR_WD_TIMEOUT		0x05000001
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index 8f1e456..d15ce5a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -219,6 +219,44 @@ int iris_hfi_session_open(struct iris_inst *inst)
 	return ret;
 }
 
+int iris_hfi_session_subscribe_mode(struct iris_inst *inst,
+				    u32 cmd, u32 plane, u32 payload_type,
+				    void *payload, u32 payload_size)
+{
+	struct iris_core *core;
+	int ret;
+
+	if (!inst->packet)
+		return -EINVAL;
+
+	core = inst->core;
+	mutex_lock(&core->lock);
+
+	if (!validate_session(core, inst)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = hfi_packet_session_command(inst,
+					 cmd,
+					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+					 HFI_HOST_FLAGS_INTR_REQUIRED),
+					 get_hfi_port(plane),
+					 inst->session_id,
+					 payload_type,
+					 payload,
+					 payload_size);
+	if (ret)
+		goto unlock;
+
+	ret = iris_hfi_queue_cmd_write(inst->core, inst->packet);
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
 int iris_hfi_session_close(struct iris_inst *inst)
 {
 	struct iris_core *core;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index ca2339e..d6b3fca 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -13,6 +13,9 @@ int iris_hfi_core_init(struct iris_core *core);
 int iris_hfi_core_deinit(struct iris_core *core);
 int iris_hfi_session_open(struct iris_inst *inst);
 int iris_hfi_session_close(struct iris_inst *inst);
+int iris_hfi_session_subscribe_mode(struct iris_inst *inst,
+				    u32 cmd, u32 plane, u32 payload_type,
+				    void *payload, u32 payload_size);
 int iris_hfi_set_property(struct iris_inst *inst,
 			  u32 packet_type, u32 flag, u32 plane, u32 payload_type,
 			  void *payload, u32 payload_size);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index a3544d8..d4cdfcf 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -34,6 +34,24 @@ u32 get_hfi_port_from_buffer_type(enum iris_buffer_type buffer_type)
 	return hfi_port;
 }
 
+u32 get_hfi_port(u32 plane)
+{
+	u32 hfi_port = HFI_PORT_NONE;
+
+	switch (plane) {
+	case INPUT_MPLANE:
+		hfi_port = HFI_PORT_BITSTREAM;
+		break;
+	case OUTPUT_MPLANE:
+		hfi_port = HFI_PORT_RAW;
+		break;
+	default:
+		break;
+	}
+
+	return hfi_port;
+}
+
 static u32 hfi_buf_type_from_driver(enum iris_buffer_type buffer_type)
 {
 	switch (buffer_type) {
@@ -58,6 +76,30 @@ static u32 hfi_buf_type_from_driver(enum iris_buffer_type buffer_type)
 	}
 }
 
+u32 get_hfi_colorformat(u32 colorformat)
+{
+	u32 hfi_colorformat = HFI_COLOR_FMT_NV12_UBWC;
+
+	switch (colorformat) {
+	case V4L2_PIX_FMT_NV12:
+		hfi_colorformat = HFI_COLOR_FMT_NV12;
+		break;
+	case V4L2_PIX_FMT_QC08C:
+		hfi_colorformat = HFI_COLOR_FMT_NV12_UBWC;
+		break;
+	case V4L2_PIX_FMT_QC10C:
+		hfi_colorformat = HFI_COLOR_FMT_TP10_UBWC;
+		break;
+	case V4L2_PIX_FMT_NV21:
+		hfi_colorformat = HFI_COLOR_FMT_NV21;
+		break;
+	default:
+		break;
+	}
+
+	return hfi_colorformat;
+}
+
 int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf)
 {
 	memset(buf, 0, sizeof(*buf));
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
index bf18553..4276d6d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -81,6 +81,9 @@ enum hfi_packet_port_type {
 
 u32 get_hfi_port_from_buffer_type(enum iris_buffer_type buffer_type);
 int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf);
+u32 get_hfi_colorformat(u32 colorformat);
+u32 get_hfi_port(u32 plane);
+
 int hfi_packet_sys_init(struct iris_core *core,
 			u8 *pkt, u32 pkt_size);
 int hfi_packet_image_version(struct iris_core *core,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 64067d5..7d16c96 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -5,10 +5,13 @@
 
 #include <media/v4l2-event.h>
 
+#include "hfi_defines.h"
 #include "iris_buffer.h"
 #include "iris_common.h"
 #include "iris_ctrls.h"
 #include "iris_helpers.h"
+#include "iris_hfi.h"
+#include "iris_hfi_packet.h"
 #include "iris_vdec.h"
 
 static int vdec_codec_change(struct iris_inst *inst, u32 v4l2_codec)
@@ -329,3 +332,154 @@ int vdec_subscribe_event(struct iris_inst *inst, const struct v4l2_event_subscri
 
 	return ret;
 }
+
+int vdec_subscribe_property(struct iris_inst *inst, u32 plane)
+{
+	const u32 *subcribe_prop = NULL;
+	u32 subscribe_prop_size = 0;
+	struct iris_core *core;
+	u32 payload[32] = {0};
+	u32 i;
+
+	core = inst->core;
+
+	payload[0] = HFI_MODE_PROPERTY;
+
+	if (plane == INPUT_MPLANE) {
+		subscribe_prop_size = core->platform_data->dec_input_prop_size;
+		subcribe_prop = core->platform_data->dec_input_prop;
+	} else if (plane == OUTPUT_MPLANE) {
+		if (inst->codec == H264) {
+			subscribe_prop_size = core->platform_data->dec_output_prop_size_avc;
+			subcribe_prop = core->platform_data->dec_output_prop_avc;
+		} else if (inst->codec == HEVC) {
+			subscribe_prop_size = core->platform_data->dec_output_prop_size_hevc;
+			subcribe_prop = core->platform_data->dec_output_prop_hevc;
+		} else if (inst->codec == VP9) {
+			subscribe_prop_size = core->platform_data->dec_output_prop_size_vp9;
+			subcribe_prop = core->platform_data->dec_output_prop_vp9;
+		} else {
+			return -EINVAL;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	for (i = 0; i < subscribe_prop_size; i++)
+		payload[i + 1] = subcribe_prop[i];
+
+	return iris_hfi_session_subscribe_mode(inst,
+					HFI_CMD_SUBSCRIBE_MODE,
+					plane,
+					HFI_PAYLOAD_U32_ARRAY,
+					&payload[0],
+					(subscribe_prop_size + 1) * sizeof(u32));
+}
+
+static int vdec_set_colorformat(struct iris_inst *inst)
+{
+	u32 hfi_colorformat;
+	u32 pixelformat;
+
+	pixelformat = inst->fmt_dst->fmt.pix_mp.pixelformat;
+	hfi_colorformat = get_hfi_colorformat(pixelformat);
+
+	return iris_hfi_set_property(inst,
+					 HFI_PROP_COLOR_FORMAT,
+					 HFI_HOST_FLAGS_NONE,
+					 get_hfi_port(OUTPUT_MPLANE),
+					 HFI_PAYLOAD_U32,
+					 &hfi_colorformat,
+					 sizeof(u32));
+}
+
+static int vdec_set_linear_stride_scanline(struct iris_inst *inst)
+{
+	u32 stride_y, scanline_y, stride_uv, scanline_uv;
+	u32 pixelformat;
+	u32 payload[2];
+
+	pixelformat = inst->fmt_dst->fmt.pix_mp.pixelformat;
+
+	if (!is_linear_colorformat(pixelformat))
+		return 0;
+
+	stride_y = inst->fmt_dst->fmt.pix_mp.width;
+	scanline_y = inst->fmt_dst->fmt.pix_mp.height;
+	stride_uv = stride_y;
+	scanline_uv = scanline_y / 2;
+
+	payload[0] = stride_y << 16 | scanline_y;
+	payload[1] = stride_uv << 16 | scanline_uv;
+
+	return iris_hfi_set_property(inst,
+					 HFI_PROP_LINEAR_STRIDE_SCANLINE,
+					 HFI_HOST_FLAGS_NONE,
+					 get_hfi_port(OUTPUT_MPLANE),
+					 HFI_PAYLOAD_U64,
+					 &payload,
+					 sizeof(u64));
+}
+
+static int vdec_set_ubwc_stride_scanline(struct iris_inst *inst)
+{
+	u32 meta_stride_y, meta_scanline_y, meta_stride_uv, meta_scanline_uv;
+	u32 stride_y, scanline_y, stride_uv, scanline_uv;
+	u32 pix_fmt, width, height;
+	u32 payload[4];
+
+	pix_fmt = inst->fmt_dst->fmt.pix_mp.pixelformat;
+	width = inst->fmt_dst->fmt.pix_mp.width;
+	height = inst->fmt_dst->fmt.pix_mp.height;
+
+	if (is_linear_colorformat(pix_fmt))
+		return 0;
+
+	if (pix_fmt == V4L2_PIX_FMT_QC08C) {
+		stride_y = ALIGN(width, 128);
+		scanline_y = ALIGN(height, 32);
+		stride_uv = ALIGN(width, 128);
+		scanline_uv = ALIGN((height + 1) >> 1, 32);
+		meta_stride_y = ALIGN(DIV_ROUND_UP(width, 32), 64);
+		meta_scanline_y = ALIGN(DIV_ROUND_UP(height, 8), 16);
+		meta_stride_uv = ALIGN(DIV_ROUND_UP((width + 1) >> 1, 16), 64);
+		meta_scanline_uv = ALIGN(DIV_ROUND_UP((height + 1) >> 1, 8), 16);
+	} else {
+		stride_y = ALIGN(ALIGN(width, 192) * 4 / 3, 256);
+		scanline_y = ALIGN(height, 16);
+		stride_uv = ALIGN(ALIGN(width, 192) * 4 / 3, 256);
+		scanline_uv = ALIGN((height + 1) >> 1, 16);
+		meta_stride_y = ALIGN(DIV_ROUND_UP(width, 48), 64);
+		meta_scanline_y = ALIGN(DIV_ROUND_UP(height, 4), 16);
+		meta_stride_uv = ALIGN(DIV_ROUND_UP((width + 1) >> 1, 24), 64);
+		meta_scanline_uv = ALIGN(DIV_ROUND_UP((height + 1) >> 1, 4), 16);
+	}
+
+	payload[0] = stride_y << 16 | scanline_y;
+	payload[1] = stride_uv << 16 | scanline_uv;
+	payload[2] = meta_stride_y << 16 | meta_scanline_y;
+	payload[3] = meta_stride_uv << 16 | meta_scanline_uv;
+
+	return iris_hfi_set_property(inst,
+				     HFI_PROP_UBWC_STRIDE_SCANLINE,
+				     HFI_HOST_FLAGS_NONE,
+				     get_hfi_port(OUTPUT_MPLANE),
+				     HFI_PAYLOAD_U32_ARRAY,
+				     &payload[0],
+				     sizeof(u32) * 4);
+}
+
+int vdec_set_output_property(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = vdec_set_colorformat(inst);
+	if (ret)
+		return ret;
+
+	ret = vdec_set_linear_stride_scanline(inst);
+	if (ret)
+		return ret;
+
+	return vdec_set_ubwc_stride_scanline(inst);
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
index a2f159d..6b0306c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
@@ -14,5 +14,7 @@ int vdec_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f);
 int vdec_try_fmt(struct iris_inst *inst, struct v4l2_format *f);
 int vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f);
 int vdec_subscribe_event(struct iris_inst *inst, const struct v4l2_event_subscription *sub);
+int vdec_subscribe_property(struct iris_inst *inst, u32 plane);
+int vdec_set_output_property(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index abd11fa..fc12bde 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -206,6 +206,14 @@ struct platform_data {
 	u32 core_data_size;
 	struct plat_inst_cap *inst_cap_data;
 	u32 inst_cap_data_size;
+	const u32 *dec_input_prop;
+	unsigned int dec_input_prop_size;
+	const u32 *dec_output_prop_avc;
+	unsigned int dec_output_prop_size_avc;
+	const u32 *dec_output_prop_hevc;
+	unsigned int dec_output_prop_size_hevc;
+	const u32 *dec_output_prop_vp9;
+	unsigned int dec_output_prop_size_vp9;
 };
 
 int init_platform(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
index 85bc677..6a4bfa3 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
@@ -382,6 +382,26 @@ static struct format_capability format_data_sm8550 = {
 	.color_format_info_size = ARRAY_SIZE(color_format_data_sm8550),
 };
 
+static const u32 sm8550_vdec_input_properties[] = {
+	HFI_PROP_NO_OUTPUT,
+};
+
+static const u32 sm8550_vdec_output_properties_avc[] = {
+	HFI_PROP_PICTURE_TYPE,
+	HFI_PROP_DPB_LIST,
+	HFI_PROP_CABAC_SESSION,
+};
+
+static const u32 sm8550_vdec_output_properties_hevc[] = {
+	HFI_PROP_PICTURE_TYPE,
+	HFI_PROP_DPB_LIST,
+};
+
+static const u32 sm8550_vdec_output_properties_vp9[] = {
+	HFI_PROP_PICTURE_TYPE,
+	HFI_PROP_DPB_LIST,
+};
+
 struct platform_data sm8550_data = {
 	.bus_tbl = sm8550_bus_table,
 	.bus_tbl_size = ARRAY_SIZE(sm8550_bus_table),
@@ -409,4 +429,13 @@ struct platform_data sm8550_data = {
 	.inst_cap_data_size = ARRAY_SIZE(instance_cap_data_sm8550),
 	.ubwc_config = ubwc_config_sm8550,
 	.format_data = &format_data_sm8550,
+
+	.dec_input_prop = sm8550_vdec_input_properties,
+	.dec_input_prop_size = ARRAY_SIZE(sm8550_vdec_input_properties),
+	.dec_output_prop_avc = sm8550_vdec_output_properties_avc,
+	.dec_output_prop_size_avc = ARRAY_SIZE(sm8550_vdec_output_properties_avc),
+	.dec_output_prop_hevc = sm8550_vdec_output_properties_hevc,
+	.dec_output_prop_size_hevc = ARRAY_SIZE(sm8550_vdec_output_properties_hevc),
+	.dec_output_prop_vp9 = sm8550_vdec_output_properties_vp9,
+	.dec_output_prop_size_vp9 = ARRAY_SIZE(sm8550_vdec_output_properties_vp9),
 };
-- 
2.7.4


