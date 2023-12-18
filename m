Return-Path: <linux-kernel+bounces-3482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F8E816CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5793B281AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE22B40BF3;
	Mon, 18 Dec 2023 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N+0Eut/L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E9374D7;
	Mon, 18 Dec 2023 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIArvvt003529;
	Mon, 18 Dec 2023 11:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=vLyhCEyyM++iSdmMnhPhEeX/SePVJRxrjXz9jo/+Aj8=; b=N+
	0Eut/LJZRxg02e4C1Pq0XZJWmA2o4pKqGbF+DGTm1hKe9dDm1I+C875LyLUgNZB4
	i8u44/b2WaAbAmNEdlDHI7GbPhRL6YNcQq+tJ8TJmhTYG4FHg5jkFKuNdvpbEBAe
	wElL0Yq6p3QhGVNRoE9liJ0OMbO9WzDOUGt8RcJ2cwQeAAZZSE02SRwvtrw8hGGt
	zYEg+sCMeyTO+zlCCW1IwGXfjexNkArDAseOameOEc8qvVGpoNbLHyv2io+0kWFU
	0ZXC572Z7yYF+I5vSMhjT/4rJGEo546GUg+ctAwD/1quxwM2T7pjPI4zLwUBI7gL
	//9mXB1vkyhrXtG1+xXQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mb9g4xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX6PL029956;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ad-1;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX8rc030072;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX853030069;
	Mon, 18 Dec 2023 11:36:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 6C0E7238B; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 31/34] media: iris: add platform specific instance capabilities for encoder
Date: Mon, 18 Dec 2023 17:02:26 +0530
Message-Id: <1702899149-21321-32-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jEWxbDd7IENax4tQu8kZHHd5C7UvPkHF
X-Proofpoint-GUID: jEWxbDd7IENax4tQu8kZHHd5C7UvPkHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Capabilities are set of video specifications and features supported
by a specific platform(SOC). Each capability is defined with
min, max, range, default value and corresponding HFI.

Also, platform data defines different resource details for
a specific platform(SOC). This change defines resource tables
for sm8550 platform data and use for initializing these resources.

Add Children, Set, Adjust functions for to each capability for
Encoder.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  | 128 ++-
 .../media/platform/qcom/vcodec/iris/iris_common.h  |   4 +
 .../media/platform/qcom/vcodec/iris/iris_ctrls.c   | 981 ++++++++++++++++++++-
 .../media/platform/qcom/vcodec/iris/iris_ctrls.h   |  35 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  16 +-
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |  53 ++
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   7 +-
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  10 +-
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |   5 +
 .../platform/qcom/vcodec/iris/iris_hfi_response.c  |   6 +
 .../platform/qcom/vcodec/iris/iris_instance.h      |   6 +
 .../platform/qcom/vcodec/iris/platform_common.h    |  74 +-
 .../platform/qcom/vcodec/iris/platform_sm8550.c    | 768 +++++++++++++++-
 .../platform/qcom/vcodec/iris/vpu_iris3_power.c    |   3 +
 14 files changed, 2024 insertions(+), 72 deletions(-)

diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index 872674e..bc32c99 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -45,6 +45,8 @@ enum hfi_property_mode_type {
 #define HFI_BITMASK_BITSTREAM_WIDTH		0xffff0000
 #define HFI_BITMASK_BITSTREAM_HEIGHT		0x0000ffff
 
+#define HFI_LEVEL_NONE				0xFFFFFFFF
+
 #define HFI_BITMASK_FRAME_MBS_ONLY_FLAG		0x00000001
 
 #define HFI_TRUE				0x00000001
@@ -68,14 +70,14 @@ enum hfi_codec_type {
 #define HFI_PROP_CODEC				0x03000100
 
 enum hfi_color_format {
-	HFI_COLOR_FMT_OPAQUE        = 0,
-	HFI_COLOR_FMT_NV12          = 1,
-	HFI_COLOR_FMT_NV12_UBWC     = 2,
-	HFI_COLOR_FMT_P010          = 3,
-	HFI_COLOR_FMT_TP10_UBWC     = 4,
-	HFI_COLOR_FMT_RGBA8888      = 5,
-	HFI_COLOR_FMT_RGBA8888_UBWC = 6,
-	HFI_COLOR_FMT_NV21          = 7,
+	HFI_COLOR_FMT_OPAQUE		= 0,
+	HFI_COLOR_FMT_NV12		= 1,
+	HFI_COLOR_FMT_NV12_UBWC		= 2,
+	HFI_COLOR_FMT_P010		= 3,
+	HFI_COLOR_FMT_TP10_UBWC		= 4,
+	HFI_COLOR_FMT_RGBA8888		= 5,
+	HFI_COLOR_FMT_RGBA8888_UBWC	= 6,
+	HFI_COLOR_FMT_NV21		= 7,
 };
 
 #define HFI_PROP_COLOR_FORMAT			0x03000101
@@ -104,14 +106,108 @@ enum hfi_color_format {
 
 #define HFI_PROP_CABAC_SESSION			0x03000121
 
+#define HFI_PROP_8X8_TRANSFORM                  0x03000122
+
 #define HFI_PROP_BUFFER_HOST_MAX_COUNT		0x03000123
 
 #define HFI_PROP_BUFFER_FW_MIN_OUTPUT_COUNT	0x03000124
 
 #define HFI_PROP_PIC_ORDER_CNT_TYPE		0x03000128
 
+enum hfi_syncframe_request_mode {
+	HFI_SYNC_FRAME_REQUEST_WITHOUT_SEQ_HDR		= 0x00000001,
+	HFI_SYNC_FRAME_REQUEST_WITH_PREFIX_SEQ_HDR	= 0x00000002,
+};
+
+enum hfi_rate_control {
+	HFI_RC_VBR_CFR		= 0x00000000,
+	HFI_RC_CBR_CFR		= 0x00000001,
+	HFI_RC_CQ		= 0x00000002,
+	HFI_RC_OFF		= 0x00000003,
+	HFI_RC_CBR_VFR		= 0x00000004,
+	HFI_RC_LOSSLESS		= 0x00000005,
+};
+
+#define HFI_PROP_RATE_CONTROL			0x0300012a
+
+#define HFI_PROP_QP_PACKED			0x0300012e
+
+#define HFI_PROP_MIN_QP_PACKED			0x0300012f
+
+#define HFI_PROP_MAX_QP_PACKED			0x03000130
+
+enum hfi_layer_enc_type {
+	HFI_HIER_P_SLIDING_WINDOW	= 0x1,
+	HFI_HIER_P_HYBRID_LTR		= 0x2,
+	HFI_HIER_B			= 0x3,
+};
+
+#define HFI_PROP_IR_RANDOM_PERIOD		0x03000131
+
+#define HFI_PROP_MULTI_SLICE_MB_COUNT		0x03000132
+
+#define HFI_PROP_MULTI_SLICE_BYTES_COUNT	0x03000133
+
+#define HFI_PROP_LTR_COUNT			0x03000134
+
+#define HFI_PROP_LTR_MARK			0x03000135
+
+#define HFI_PROP_LTR_USE			0x03000136
+
+#define HFI_PROP_LAYER_ENCODING_TYPE		0x03000138
+
+#define HFI_PROP_LAYER_COUNT			0x03000139
+
+#define HFI_PROP_TOTAL_BITRATE			0x0300013b
+
+#define HFI_PROP_BITRATE_LAYER1			0x0300013c
+
+#define HFI_PROP_BITRATE_LAYER2			0x0300013d
+
+#define HFI_PROP_BITRATE_LAYER3			0x0300013e
+
+#define HFI_PROP_BITRATE_LAYER4			0x0300013f
+
+#define HFI_PROP_BITRATE_LAYER5			0x03000140
+
+#define HFI_PROP_BITRATE_LAYER6			0x03000141
+
+#define HFI_PROP_BASELAYER_PRIORITYID		0x03000142
+
+#define HFI_PROP_REQUEST_SYNC_FRAME		0x03000145
+
+#define HFI_PROP_MAX_GOP_FRAMES			0x03000146
+
+#define HFI_PROP_MAX_B_FRAMES			0x03000147
+
 #define HFI_PROP_QUALITY_MODE			0x03000148
 
+enum hfi_seq_header_mode {
+	HFI_SEQ_HEADER_SEPERATE_FRAME		= 0x00000001,
+	HFI_SEQ_HEADER_JOINED_WITH_1ST_FRAME	= 0x00000002,
+	HFI_SEQ_HEADER_PREFIX_WITH_SYNC_FRAME	= 0x00000004,
+	HFI_SEQ_HEADER_METADATA			= 0x00000008,
+};
+
+#define HFI_PROP_SEQ_HEADER_MODE		0x03000149
+
+enum hfi_rotation {
+	HFI_ROTATION_NONE	= 0x00000000,
+	HFI_ROTATION_90		= 0x00000001,
+	HFI_ROTATION_180	= 0x00000002,
+	HFI_ROTATION_270	= 0x00000003,
+};
+
+#define HFI_PROP_ROTATION			0x0300014b
+
+enum hfi_flip {
+	HFI_DISABLE_FLIP	= 0x00000000,
+	HFI_HORIZONTAL_FLIP	= 0x00000001,
+	HFI_VERTICAL_FLIP	= 0x00000002,
+};
+
+#define HFI_PROP_FLIP				0x0300014c
+
 enum hfi_color_primaries {
 	HFI_PRIMARIES_RESERVED		= 0,
 	HFI_PRIMARIES_BT709		= 1,
@@ -182,7 +278,7 @@ enum hfi_picture_type {
 
 #define HFI_PROP_PICTURE_TYPE			0x03000162
 
-#define HFI_PROP_DEC_DEFAULT_HEADER             0x03000168
+#define HFI_PROP_DEC_DEFAULT_HEADER		0x03000168
 
 #define HFI_PROP_DEC_START_FROM_RAP_FRAME	0x03000169
 
@@ -190,6 +286,12 @@ enum hfi_picture_type {
 
 #define HFI_PROP_DPB_LIST			0x0300017A
 
+#define HFI_PROP_TOTAL_PEAK_BITRATE		0x0300017C
+
+#define HFI_PROP_MAINTAIN_MIN_QUALITY		0x0300017D
+
+#define HFI_PROP_IR_CYCLIC_PERIOD		0x0300017E
+
 #define HFI_PROP_UBWC_STRIDE_SCANLINE		0x03000190
 
 #define HFI_PROP_COMV_BUFFER_COUNT		0x03000193
@@ -214,7 +316,7 @@ enum hfi_picture_type {
 
 #define HFI_SYSTEM_ERROR_BEGIN			0x05000000
 
-#define HFI_SYS_ERROR_WD_TIMEOUT                0x05000001
+#define HFI_SYS_ERROR_WD_TIMEOUT		0x05000001
 
 #define HFI_SYSTEM_ERROR_END			0x05FFFFFF
 
@@ -233,9 +335,9 @@ enum hfi_picture_type {
 #define HFI_INFORMATION_END			0x06FFFFFF
 
 struct hfi_debug_header {
-	u32   size;
-	u32   debug_level;
-	u32   reserved[2];
+	u32 size;
+	u32 debug_level;
+	u32 reserved[2];
 };
 
 enum hfi_buffer_type {
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
index b1273d0..ca5406a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -30,6 +30,10 @@
 
 #define INPUT_TIMER_LIST_SIZE 30
 
+#define CABAC_MAX_BITRATE 160000000
+
+#define CAVLC_MAX_BITRATE 220000000
+
 enum domain_type {
 	ENCODER	= BIT(0),
 	DECODER	= BIT(1),
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
index 94fff74..a648cc1 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
@@ -611,6 +611,45 @@ int prepare_dependency_list(struct iris_inst *inst)
 	return ret;
 }
 
+static inline bool is_layer_bitrate_set(struct iris_inst *inst)
+{
+	u32 layer_br_caps[6] = {L0_BR, L1_BR, L2_BR, L3_BR, L4_BR, L5_BR};
+	u32 cap_id = 0, i, enh_layer_count;
+
+	enh_layer_count = inst->cap[ENH_LAYER_COUNT].value;
+
+	for (i = 0; i <= enh_layer_count; i++) {
+		if (i >= ARRAY_SIZE(layer_br_caps))
+			break;
+
+		cap_id = layer_br_caps[i];
+		if (!(inst->cap[cap_id].flags & CAP_FLAG_CLIENT_SET))
+			return false;
+	}
+
+	return true;
+}
+
+static inline u32 get_cumulative_bitrate(struct iris_inst *inst)
+{
+	u32 layer_br_caps[6] = {L0_BR, L1_BR, L2_BR, L3_BR, L4_BR, L5_BR};
+	u32 cumulative_br = 0;
+	s32 enh_layer_count;
+	u32 cap_id = 0;
+	int i;
+
+	enh_layer_count = inst->cap[ENH_LAYER_COUNT].value;
+
+	for (i = 0; i <= enh_layer_count; i++) {
+		if (i >= ARRAY_SIZE(layer_br_caps))
+			break;
+		cap_id = layer_br_caps[i];
+		cumulative_br += inst->cap[cap_id].value;
+	}
+
+	return cumulative_br;
+}
+
 int set_u32_enum(struct iris_inst *inst,
 		 enum plat_inst_cap_type cap_id)
 {
@@ -635,6 +674,18 @@ int set_u32(struct iris_inst *inst,
 				     &hfi_value, sizeof(u32));
 }
 
+int set_q16(struct iris_inst *inst,
+	    enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_value = inst->cap[cap_id].value;
+	u32 hfi_id = inst->cap[cap_id].hfi_id;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_Q16,
+				     &hfi_value, sizeof(u32));
+}
+
 int set_stage(struct iris_inst *inst,
 	      enum plat_inst_cap_type cap_id)
 {
@@ -662,7 +713,7 @@ int set_pipe(struct iris_inst *inst,
 {
 	u32 work_route, hfi_id;
 
-	work_route = inst->cap[PIPE].value;
+	work_route = inst->cap[cap_id].value;
 	hfi_id = inst->cap[cap_id].hfi_id;
 
 	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
@@ -671,6 +722,419 @@ int set_pipe(struct iris_inst *inst,
 				     &work_route, sizeof(u32));
 }
 
+int set_level(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_value = inst->cap[cap_id].value;
+	u32 hfi_id = inst->cap[cap_id].hfi_id;
+
+	if (!(inst->cap[cap_id].flags & CAP_FLAG_CLIENT_SET))
+		hfi_value = HFI_LEVEL_NONE;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+					 get_port_info(inst, cap_id),
+					 HFI_PAYLOAD_U32_ENUM,
+					 &hfi_value, sizeof(u32));
+}
+
+int set_req_sync_frame(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_id, hfi_val;
+	s32 prepend_sps_pps;
+
+	prepend_sps_pps = inst->cap[PREPEND_SPSPPS_TO_IDR].value;
+	hfi_id = inst->cap[cap_id].hfi_id;
+
+	if (prepend_sps_pps)
+		hfi_val = HFI_SYNC_FRAME_REQUEST_WITH_PREFIX_SEQ_HDR;
+	else
+		hfi_val = HFI_SYNC_FRAME_REQUEST_WITHOUT_SEQ_HDR;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32_ENUM,
+				     &hfi_val, sizeof(u32));
+}
+
+int set_flip(struct iris_inst *inst,
+	     enum plat_inst_cap_type cap_id)
+{
+	u32 hflip, vflip, ret = 0;
+
+	u32 hfi_value = HFI_DISABLE_FLIP;
+	u32 hfi_id = inst->cap[cap_id].hfi_id;
+
+	hflip = inst->cap[HFLIP].value;
+	vflip = inst->cap[VFLIP].value;
+
+	if (hflip)
+		hfi_value |= HFI_HORIZONTAL_FLIP;
+
+	if (vflip)
+		hfi_value |= HFI_VERTICAL_FLIP;
+
+	if (inst->vb2q_dst->streaming) {
+		if (hfi_value != HFI_DISABLE_FLIP) {
+			ret = set_req_sync_frame(inst, REQUEST_I_FRAME);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32_ENUM,
+				     &hfi_value, sizeof(u32));
+}
+
+int set_rotation(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_id, hfi_val;
+
+	hfi_id = inst->cap[cap_id].hfi_id;
+
+	switch (inst->cap[cap_id].value) {
+	case 0:
+		hfi_val = HFI_ROTATION_NONE;
+		break;
+	case 90:
+		hfi_val = HFI_ROTATION_90;
+		break;
+	case 180:
+		hfi_val = HFI_ROTATION_180;
+		break;
+	case 270:
+		hfi_val = HFI_ROTATION_270;
+		break;
+	default:
+		hfi_val = HFI_ROTATION_NONE;
+		break;
+	}
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32,
+				     &hfi_val, sizeof(u32));
+}
+
+int set_header_mode(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 header_mode, hfi_id, hfi_val;
+	s32 prepend_sps_pps;
+
+	prepend_sps_pps = inst->cap[PREPEND_SPSPPS_TO_IDR].value;
+	header_mode = inst->cap[cap_id].value;
+	hfi_id = inst->cap[cap_id].hfi_id;
+
+	if (prepend_sps_pps)
+		hfi_val = HFI_SEQ_HEADER_PREFIX_WITH_SYNC_FRAME;
+	else if (header_mode == V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME)
+		hfi_val = HFI_SEQ_HEADER_JOINED_WITH_1ST_FRAME;
+	else
+		hfi_val = HFI_SEQ_HEADER_SEPERATE_FRAME;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32_ENUM,
+				     &hfi_val, sizeof(u32));
+}
+
+int set_gop_size(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_value, hfi_id;
+
+	if (inst->vb2q_dst->streaming) {
+		if (inst->hfi_layer_type == HFI_HIER_B)
+			return 0;
+	}
+
+	hfi_value = inst->cap[GOP_SIZE].value;
+	hfi_id = inst->cap[cap_id].hfi_id;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32,
+				     &hfi_value, sizeof(u32));
+}
+
+int set_bitrate(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_id, hfi_val;
+
+	if (inst->cap[BIT_RATE].flags & CAP_FLAG_CLIENT_SET)
+		goto set_total_bitrate;
+
+	if (inst->vb2q_dst->streaming)
+		return 0;
+
+set_total_bitrate:
+	hfi_id = inst->cap[cap_id].hfi_id;
+	hfi_val = inst->cap[cap_id].value;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32,
+				     &hfi_val, sizeof(u32));
+}
+
+int set_layer_bitrate(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_value = 0;
+	u32 hfi_id;
+
+	if (!inst->vb2q_dst->streaming)
+		return 0;
+
+	if (inst->cap[BIT_RATE].flags & CAP_FLAG_CLIENT_SET)
+		return 0;
+
+	if (!inst->cap[ENH_LAYER_COUNT].max ||
+	    !is_layer_bitrate_set(inst))
+		return 0;
+
+	hfi_value = inst->cap[BIT_RATE].value;
+	hfi_id = inst->cap[BIT_RATE].hfi_id;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32,
+				     &hfi_value, sizeof(u32));
+}
+
+int set_peak_bitrate(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_id, hfi_val;
+	s32 rc_mode;
+
+	hfi_id = inst->cap[cap_id].hfi_id;
+	hfi_val = inst->cap[cap_id].value;
+
+	rc_mode = inst->cap[BITRATE_MODE].value;
+	if (rc_mode != V4L2_MPEG_VIDEO_BITRATE_MODE_CBR)
+		return 0;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32,
+				     &hfi_val, sizeof(u32));
+}
+
+int set_use_and_mark_ltr(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_id, hfi_val;
+
+	hfi_id = inst->cap[cap_id].hfi_id;
+	hfi_val = inst->cap[cap_id].value;
+
+	if (!inst->cap[LTR_COUNT].value ||
+	    inst->cap[cap_id].value == INVALID_DEFAULT_MARK_OR_USE_LTR)
+		return 0;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32,
+				     &hfi_val, sizeof(u32));
+}
+
+int set_ir_period(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_id = 0, hfi_val;
+
+	hfi_val = inst->cap[cap_id].value;
+
+	if (inst->cap[IR_TYPE].value ==
+	    V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM) {
+		hfi_id = HFI_PROP_IR_RANDOM_PERIOD;
+	} else if (inst->cap[IR_TYPE].value ==
+		   V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC) {
+		hfi_id = HFI_PROP_IR_CYCLIC_PERIOD;
+	}
+
+	return iris_hfi_set_ir_period(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				      get_port_info(inst, cap_id),
+				      HFI_PAYLOAD_U32,
+				      &hfi_val, sizeof(u32));
+}
+
+int set_min_qp(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	s32 i_frame_qp = 0, p_frame_qp = 0, b_frame_qp = 0, min_qp_enable = 0;
+	u32 i_qp_enable = 0, p_qp_enable = 0, b_qp_enable = 0;
+	u32 client_qp_enable = 0, hfi_value = 0;
+	u32 hfi_id;
+
+	if (inst->cap[MIN_FRAME_QP].flags & CAP_FLAG_CLIENT_SET)
+		min_qp_enable = 1;
+
+	if (min_qp_enable ||
+	    (inst->cap[I_FRAME_MIN_QP].flags & CAP_FLAG_CLIENT_SET))
+		i_qp_enable = 1;
+	if (min_qp_enable ||
+	    (inst->cap[P_FRAME_MIN_QP].flags & CAP_FLAG_CLIENT_SET))
+		p_qp_enable = 1;
+	if (min_qp_enable ||
+	    (inst->cap[B_FRAME_MIN_QP].flags & CAP_FLAG_CLIENT_SET))
+		b_qp_enable = 1;
+
+	client_qp_enable = i_qp_enable | p_qp_enable << 1 | b_qp_enable << 2;
+	if (!client_qp_enable)
+		return 0;
+
+	i_frame_qp = max(inst->cap[I_FRAME_MIN_QP].value, inst->cap[MIN_FRAME_QP].value);
+	p_frame_qp = max(inst->cap[P_FRAME_MIN_QP].value, inst->cap[MIN_FRAME_QP].value);
+	b_frame_qp = max(inst->cap[B_FRAME_MIN_QP].value, inst->cap[MIN_FRAME_QP].value);
+
+	hfi_id = inst->cap[cap_id].hfi_id;
+	hfi_value = i_frame_qp | p_frame_qp << 8 | b_frame_qp << 16 |
+		client_qp_enable << 24;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_32_PACKED,
+				     &hfi_value, sizeof(u32));
+}
+
+int set_max_qp(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	s32 i_frame_qp = 0, p_frame_qp = 0, b_frame_qp = 0, max_qp_enable = 0;
+	u32 i_qp_enable = 0, p_qp_enable = 0, b_qp_enable = 0;
+	u32 client_qp_enable = 0, hfi_value = 0;
+	u32 hfi_id;
+
+	if (inst->cap[MAX_FRAME_QP].flags & CAP_FLAG_CLIENT_SET)
+		max_qp_enable = 1;
+
+	if (max_qp_enable ||
+	    (inst->cap[I_FRAME_MAX_QP].flags & CAP_FLAG_CLIENT_SET))
+		i_qp_enable = 1;
+	if (max_qp_enable ||
+	    (inst->cap[P_FRAME_MAX_QP].flags & CAP_FLAG_CLIENT_SET))
+		p_qp_enable = 1;
+	if (max_qp_enable ||
+	    (inst->cap[B_FRAME_MAX_QP].flags & CAP_FLAG_CLIENT_SET))
+		b_qp_enable = 1;
+
+	client_qp_enable = i_qp_enable | p_qp_enable << 1 | b_qp_enable << 2;
+	if (!client_qp_enable)
+		return 0;
+
+	i_frame_qp = min(inst->cap[I_FRAME_MAX_QP].value, inst->cap[MAX_FRAME_QP].value);
+	p_frame_qp = min(inst->cap[P_FRAME_MAX_QP].value, inst->cap[MAX_FRAME_QP].value);
+	b_frame_qp = min(inst->cap[B_FRAME_MAX_QP].value, inst->cap[MAX_FRAME_QP].value);
+
+	hfi_id = inst->cap[cap_id].hfi_id;
+	hfi_value = i_frame_qp | p_frame_qp << 8 | b_frame_qp << 16 |
+		client_qp_enable << 24;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_32_PACKED,
+				     &hfi_value, sizeof(u32));
+}
+
+int set_frame_qp(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 i_qp_enable = 0, p_qp_enable = 0, b_qp_enable = 0;
+	u32 client_qp_enable = 0, hfi_value = 0;
+	s32 i_frame_qp = 0, p_frame_qp = 0, b_frame_qp = 0;
+	s32 rc_type = -1;
+	u32 hfi_id;
+
+	rc_type = inst->hfi_rc_type;
+	if (inst->vb2q_dst->streaming) {
+		if (rc_type != HFI_RC_OFF)
+			return 0;
+	}
+
+	if (rc_type == HFI_RC_OFF) {
+		i_qp_enable = 1;
+		p_qp_enable = 1;
+		b_qp_enable = 1;
+	} else {
+		if (inst->cap[I_FRAME_QP].flags & CAP_FLAG_CLIENT_SET)
+			i_qp_enable = 1;
+		if (inst->cap[P_FRAME_QP].flags & CAP_FLAG_CLIENT_SET)
+			p_qp_enable = 1;
+		if (inst->cap[B_FRAME_QP].flags & CAP_FLAG_CLIENT_SET)
+			b_qp_enable = 1;
+	}
+
+	client_qp_enable = i_qp_enable | p_qp_enable << 1 | b_qp_enable << 2;
+	if (!client_qp_enable)
+		return 0;
+
+	i_frame_qp = inst->cap[I_FRAME_QP].value;
+	p_frame_qp = inst->cap[P_FRAME_QP].value;
+	b_frame_qp = inst->cap[B_FRAME_QP].value;
+
+	hfi_id = inst->cap[cap_id].hfi_id;
+	hfi_value = i_frame_qp | p_frame_qp << 8 | b_frame_qp << 16 |
+		client_qp_enable << 24;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_32_PACKED,
+				     &hfi_value, sizeof(u32));
+}
+
+int set_layer_count_and_type(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_layer_count, hfi_layer_type = 0;
+	int ret, hfi_id;
+
+	if (!inst->vb2q_dst->streaming) {
+		hfi_layer_type = inst->hfi_layer_type;
+		hfi_id = inst->cap[LAYER_TYPE].hfi_id;
+
+		ret = iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+					    get_port_info(inst, LAYER_TYPE),
+					    HFI_PAYLOAD_U32_ENUM,
+					    &hfi_layer_type, sizeof(u32));
+		if (ret)
+			return ret;
+	} else {
+		if (inst->hfi_layer_type == HFI_HIER_B)
+			return 0;
+	}
+
+	hfi_id = inst->cap[ENH_LAYER_COUNT].hfi_id;
+	hfi_layer_count = inst->cap[ENH_LAYER_COUNT].value + 1;
+
+	ret = iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				    get_port_info(inst, ENH_LAYER_COUNT),
+				    HFI_PAYLOAD_U32,
+				    &hfi_layer_count, sizeof(u32));
+
+	return ret;
+}
+
+int set_slice_count(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_value = 0, set_cap_id = 0, hfi_id;
+	s32 slice_mode = -1;
+
+	slice_mode = inst->cap[SLICE_MODE].value;
+
+	if (slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE)
+		return 0;
+
+	if (slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB) {
+		hfi_value = (inst->codec == HEVC) ?
+			(inst->cap[SLICE_MAX_MB].value + 3) / 4 :
+			inst->cap[SLICE_MAX_MB].value;
+		set_cap_id = SLICE_MAX_MB;
+	} else if (slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES) {
+		hfi_value = inst->cap[SLICE_MAX_BYTES].value;
+		set_cap_id = SLICE_MAX_BYTES;
+	}
+
+	hfi_id = inst->cap[set_cap_id].hfi_id;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, set_cap_id),
+				     HFI_PAYLOAD_U32,
+				     &hfi_value, sizeof(u32));
+}
+
 int set_v4l2_properties(struct iris_inst *inst)
 {
 	struct cap_entry *entry = NULL, *temp = NULL;
@@ -723,8 +1187,7 @@ int adjust_profile(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
 	u32 adjusted_value;
 	s32 pix_fmt = -1;
 
-	adjusted_value = ctrl ? ctrl->val :
-		inst->cap[PROFILE].value;
+	adjusted_value = ctrl ? ctrl->val : inst->cap[PROFILE].value;
 
 	pix_fmt = inst->cap[PIX_FMTS].value;
 
@@ -737,3 +1200,515 @@ int adjust_profile(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
 
 	return 0;
 }
+
+int adjust_bitrate(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	u32 layer_br_caps[6] = {L0_BR, L1_BR, L2_BR, L3_BR, L4_BR, L5_BR};
+	u32 adjusted_value, cumulative_bitrate, cap_id, cap_val, i;
+	s32 layer_count, max_bitrate = 0, entropy_mode;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[BIT_RATE].value;
+
+	if (inst->cap[BIT_RATE].flags & CAP_FLAG_CLIENT_SET) {
+		inst->cap[BIT_RATE].value = adjusted_value;
+		return 0;
+	}
+
+	entropy_mode = inst->cap[ENTROPY_MODE].value;
+
+	if (inst->codec == HEVC)
+		max_bitrate = CABAC_MAX_BITRATE;
+
+	if (inst->codec == H264) {
+		if (entropy_mode == V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC)
+			max_bitrate = CABAC_MAX_BITRATE;
+		else
+			max_bitrate = CAVLC_MAX_BITRATE;
+	}
+
+	if (inst->cap[BIT_RATE].value > max_bitrate)
+		inst->cap[BIT_RATE].value = max_bitrate;
+
+	layer_count = inst->cap[ENH_LAYER_COUNT].value;
+	if (!layer_count)
+		return 0;
+
+	if (!is_layer_bitrate_set(inst))
+		return 0;
+
+	cumulative_bitrate = get_cumulative_bitrate(inst);
+
+	if (cumulative_bitrate > max_bitrate) {
+		u32 decrement_in_value = 0;
+		u32 decrement_in_percent = ((cumulative_bitrate - max_bitrate) * 100) /
+				max_bitrate;
+
+		cumulative_bitrate = 0;
+		for (i = 0; i <= layer_count; i++) {
+			if (i >= ARRAY_SIZE(layer_br_caps))
+				break;
+			cap_id = layer_br_caps[i];
+			cap_val = inst->cap[cap_id].value;
+			decrement_in_value = (cap_val * decrement_in_percent) / 100;
+			cumulative_bitrate += (cap_val - decrement_in_value);
+			inst->cap[cap_id].value = cap_val - decrement_in_value;
+		}
+		inst->cap[BIT_RATE].value = cumulative_bitrate;
+	}
+
+	return 0;
+}
+
+int adjust_layer_bitrate(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	u32 old_br = 0, new_br = 0, exceeded_br = 0;
+	u32 client_set_cap_id = INST_CAP_NONE;
+	u32 cumulative_bitrate = 0;
+	s32 max_bitrate;
+
+	if (!ctrl)
+		return 0;
+
+	if (inst->cap[BIT_RATE].flags & CAP_FLAG_CLIENT_SET ||
+	    !inst->vb2q_dst->streaming)
+		return 0;
+
+	if (!inst->cap[ENH_LAYER_COUNT].max)
+		return -EINVAL;
+
+	if (!is_layer_bitrate_set(inst))
+		return 0;
+
+	client_set_cap_id = get_cap_id(inst, ctrl->id);
+	if (!is_valid_cap_id(client_set_cap_id))
+		return -EINVAL;
+
+	cumulative_bitrate = get_cumulative_bitrate(inst);
+	max_bitrate = inst->cap[BIT_RATE].max;
+	old_br = inst->cap[client_set_cap_id].value;
+	new_br = ctrl->val;
+
+	if ((cumulative_bitrate - old_br + new_br) > max_bitrate) {
+		exceeded_br = (cumulative_bitrate - old_br + new_br) - max_bitrate;
+		new_br = ctrl->val - exceeded_br;
+	}
+	inst->cap[client_set_cap_id].value = new_br;
+
+	inst->cap[BIT_RATE].value = get_cumulative_bitrate(inst);
+
+	return 0;
+}
+
+int adjust_peak_bitrate(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	u32 adjusted_value;
+	s32 rc_mode, bitrate;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[PEAK_BITRATE].value;
+
+	rc_mode = inst->cap[BITRATE_MODE].value;
+
+	if (rc_mode != V4L2_MPEG_VIDEO_BITRATE_MODE_CBR)
+		return 0;
+
+	bitrate = inst->cap[BIT_RATE].value;
+
+	if (inst->cap[PEAK_BITRATE].flags & CAP_FLAG_CLIENT_SET) {
+		if (adjusted_value < bitrate)
+			adjusted_value = bitrate;
+	} else {
+		adjusted_value = inst->cap[BIT_RATE].value;
+	}
+
+	inst->cap[PEAK_BITRATE].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_bitrate_mode(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 frame_rc, bitrate_mode, frame_skip;
+
+	bitrate_mode = inst->cap[BITRATE_MODE].value;
+	frame_rc = inst->cap[FRAME_RC_ENABLE].value;
+	frame_skip = inst->cap[FRAME_SKIP_MODE].value;
+
+	if (!frame_rc) {
+		inst->hfi_rc_type = HFI_RC_OFF;
+		return 0;
+	}
+
+	if (bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_VBR) {
+		inst->hfi_rc_type = HFI_RC_VBR_CFR;
+	} else if (bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_CBR) {
+		if (frame_skip)
+			inst->hfi_rc_type = HFI_RC_CBR_VFR;
+		else
+			inst->hfi_rc_type = HFI_RC_CBR_CFR;
+	} else if (bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_CQ) {
+		inst->hfi_rc_type = HFI_RC_CQ;
+	}
+
+	return 0;
+}
+
+int adjust_gop_size(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value, enh_layer_count;
+	u32 min_gop_size, num_subgops;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[GOP_SIZE].value;
+
+	enh_layer_count = inst->cap[ENH_LAYER_COUNT].value;
+
+	if (!enh_layer_count)
+		goto exit;
+
+	/*
+	 * Layer encoding needs GOP size to be multiple of subgop size
+	 * And subgop size is 2 ^ number of enhancement layers.
+	 */
+	min_gop_size = 1 << enh_layer_count;
+	num_subgops = (adjusted_value + (min_gop_size >> 1)) / min_gop_size;
+	if (num_subgops)
+		adjusted_value = num_subgops * min_gop_size;
+	else
+		adjusted_value = min_gop_size;
+
+exit:
+	inst->cap[GOP_SIZE].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_b_frame(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value, enh_layer_count = -1;
+	const u32 max_bframe_size = 7;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[B_FRAME].value;
+
+	enh_layer_count = inst->cap[ENH_LAYER_COUNT].value;
+
+	if (!enh_layer_count || inst->hfi_layer_type != HFI_HIER_B) {
+		adjusted_value = 0;
+		goto exit;
+	}
+
+	adjusted_value = (1 << enh_layer_count) - 1;
+
+	if (adjusted_value > max_bframe_size)
+		adjusted_value = max_bframe_size;
+
+exit:
+	inst->cap[B_FRAME].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_ltr_count(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value, rc_mode, pix_fmt;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[LTR_COUNT].value;
+
+	rc_mode = inst->cap[BITRATE_MODE].value;
+
+	if (rc_mode != V4L2_MPEG_VIDEO_BITRATE_MODE_CBR ||
+	    inst->hfi_rc_type != HFI_RC_OFF)
+		adjusted_value = 0;
+
+	pix_fmt = inst->cap[PIX_FMTS].value;
+	if (is_10bit_colorformat(pix_fmt))
+		adjusted_value = 0;
+
+	inst->cap[LTR_COUNT].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_use_ltr(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value, ltr_count;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[USE_LTR].value;
+
+	ltr_count = inst->cap[LTR_COUNT].value;
+	if (!ltr_count)
+		return 0;
+
+	/*
+	 * USE_LTR is bitmask value, hence should be
+	 * > 0 and <= (2 ^ LTR_COUNT) - 1
+	 */
+	if (adjusted_value <= 0 ||
+	    adjusted_value > (1 << ltr_count) - 1)
+		return 0;
+
+	inst->cap[USE_LTR].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_mark_ltr(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value, ltr_count;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[MARK_LTR].value;
+
+	ltr_count = inst->cap[LTR_COUNT].value;
+	if (!ltr_count)
+		return 0;
+
+	if (adjusted_value < 0 || adjusted_value > ltr_count - 1)
+		return 0;
+
+	inst->cap[MARK_LTR].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_ir_period(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value, pix_fmt, rc_mode;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[IR_PERIOD].value;
+
+	pix_fmt = inst->cap[PIX_FMTS].value;
+	if (is_10bit_colorformat(pix_fmt))
+		adjusted_value = 0;
+
+	rc_mode = inst->cap[BITRATE_MODE].value;
+	if (rc_mode != V4L2_MPEG_VIDEO_BITRATE_MODE_CBR)
+		adjusted_value = 0;
+
+	inst->cap[IR_PERIOD].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_min_quality(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value, pix_fmt, rc_mode, layer_count;
+	u32 width, height, frame_rate;
+	struct v4l2_format *f;
+
+	if (inst->vb2q_dst->streaming)
+		return 0;
+
+	adjusted_value = MAX_SUPPORTED_MIN_QUALITY;
+
+	rc_mode = inst->cap[BITRATE_MODE].value;
+	if (rc_mode != V4L2_MPEG_VIDEO_BITRATE_MODE_VBR)
+		adjusted_value = 0;
+
+	layer_count = inst->cap[ENH_LAYER_COUNT].value;
+	if (layer_count && inst->hfi_layer_type != HFI_HIER_B)
+		adjusted_value = 0;
+
+	pix_fmt = inst->cap[PIX_FMTS].value;
+	if (is_10bit_colorformat(pix_fmt))
+		adjusted_value = 0;
+
+	frame_rate = inst->cap[FRAME_RATE].value >> 16;
+	f = inst->fmt_dst;
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+
+	if (!res_is_less_than(width, height, 1920, 1080))
+		adjusted_value = 0;
+
+	if (frame_rate > 60)
+		adjusted_value = 0;
+
+	inst->cap[MIN_QUALITY].value = adjusted_value;
+
+	return 0;
+}
+
+static int adjust_static_layer_count_and_type(struct iris_inst *inst, s32 layer_count)
+{
+	bool hb_requested = false;
+	s32 max_enh_count = 0;
+
+	if (!layer_count)
+		goto exit;
+
+	if (inst->hfi_rc_type == HFI_RC_CQ) {
+		layer_count = 0;
+		goto exit;
+	}
+
+	if (inst->codec == H264) {
+		if (!inst->cap[LAYER_ENABLE].value) {
+			layer_count = 0;
+			goto exit;
+		}
+		hb_requested = inst->cap[LAYER_TYPE].value ==
+				V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_B;
+	} else if (inst->codec == HEVC) {
+		hb_requested = inst->cap[LAYER_TYPE].value ==
+				V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_B;
+	}
+
+	if (hb_requested && inst->hfi_rc_type != HFI_RC_VBR_CFR) {
+		layer_count = 0;
+		goto exit;
+	}
+
+	inst->hfi_layer_type = hb_requested ? HFI_HIER_B :
+		(inst->codec == H264 && inst->hfi_rc_type == HFI_RC_VBR_CFR) ?
+		HFI_HIER_P_HYBRID_LTR : HFI_HIER_P_SLIDING_WINDOW;
+
+	max_enh_count = inst->hfi_layer_type == HFI_HIER_B ? MAX_ENH_LAYER_HB :
+		inst->hfi_layer_type == HFI_HIER_P_HYBRID_LTR ? MAX_AVC_ENH_LAYER_HYBRID_HP :
+		inst->hfi_layer_type == HFI_HIER_P_SLIDING_WINDOW ?
+		(inst->codec == H264 ? MAX_AVC_ENH_LAYER_SLIDING_WINDOW :
+		 (inst->codec == HEVC && inst->hfi_rc_type == HFI_RC_VBR_CFR) ?
+		 MAX_HEVC_VBR_ENH_LAYER_SLIDING_WINDOW :
+		 MAX_HEVC_NON_VBR_ENH_LAYER_SLIDING_WINDOW) :
+		layer_count;
+
+	layer_count = min(layer_count, max_enh_count);
+
+exit:
+	inst->cap[ENH_LAYER_COUNT].value = layer_count;
+	inst->cap[ENH_LAYER_COUNT].max = layer_count;
+
+	return 0;
+}
+
+int adjust_layer_count(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 client_layer_count;
+	int ret = 0;
+
+	client_layer_count = ctrl ? ctrl->val : inst->cap[ENH_LAYER_COUNT].value;
+
+	if (!inst->vb2q_dst->streaming) {
+		ret = adjust_static_layer_count_and_type(inst, client_layer_count);
+		if (ret)
+			return ret;
+	} else {
+		if (inst->hfi_rc_type == HFI_RC_CBR_CFR ||
+		    inst->hfi_rc_type == HFI_RC_CBR_VFR)
+			return ret;
+
+		if (inst->hfi_layer_type == HFI_HIER_P_HYBRID_LTR ||
+		    inst->hfi_layer_type == HFI_HIER_P_SLIDING_WINDOW)
+			inst->cap[ENH_LAYER_COUNT].value =
+				min(client_layer_count, inst->cap[ENH_LAYER_COUNT].max);
+	}
+
+	return ret;
+}
+
+int adjust_entropy_mode(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value;
+	s32 profile = -1;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[ENTROPY_MODE].value;
+
+	profile = inst->cap[PROFILE].value;
+	if (profile == V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE ||
+	    profile == V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE)
+		adjusted_value = V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC;
+
+	inst->cap[ENTROPY_MODE].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_slice_count(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value, rc_type = -1, slice_mode, enh_layer_count = 0;
+	u32 slice_val, mbpf = 0, mbps = 0, max_mbpf = 0, max_mbps = 0, bitrate = 0;
+	u32 update_cap, max_avg_slicesize, output_width, output_height;
+	u32 min_width, min_height, max_width, max_height, fps;
+
+	slice_mode = ctrl ? ctrl->val : inst->cap[SLICE_MODE].value;
+	if (slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE)
+		return 0;
+
+	bitrate = inst->cap[BIT_RATE].value;
+	enh_layer_count = inst->cap[ENH_LAYER_COUNT].value;
+	if (enh_layer_count && is_layer_bitrate_set(inst))
+		bitrate = get_cumulative_bitrate(inst);
+
+	rc_type = inst->hfi_rc_type;
+	fps = inst->cap[FRAME_RATE].value >> 16;
+	if (fps > MAX_SLICES_FRAME_RATE ||
+	    (rc_type != HFI_RC_OFF && rc_type != HFI_RC_CBR_CFR &&
+	     rc_type != HFI_RC_CBR_VFR && rc_type != HFI_RC_VBR_CFR)) {
+		adjusted_value = V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE;
+		update_cap = SLICE_MODE;
+		goto exit;
+	}
+
+	output_width = inst->fmt_dst->fmt.pix_mp.width;
+	output_height = inst->fmt_dst->fmt.pix_mp.height;
+
+	max_width = (slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB) ?
+		MAX_MB_SLICE_WIDTH : MAX_BYTES_SLICE_WIDTH;
+	max_height = (slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB) ?
+		MAX_MB_SLICE_HEIGHT : MAX_BYTES_SLICE_HEIGHT;
+	min_width = (inst->codec == HEVC) ?
+		MIN_HEVC_SLICE_WIDTH : MIN_AVC_SLICE_WIDTH;
+	min_height = MIN_SLICE_HEIGHT;
+
+	if (output_width < min_width || output_height < min_height ||
+	    output_width > max_width || output_height > max_width) {
+		adjusted_value = V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE;
+		update_cap = SLICE_MODE;
+		goto exit;
+	}
+
+	mbpf = NUM_MBS_PER_FRAME(output_height, output_width);
+	mbps = mbpf * fps;
+	max_mbpf = NUM_MBS_PER_FRAME(max_height, max_width);
+	max_mbps = max_mbpf * MAX_SLICES_FRAME_RATE;
+
+	if (mbpf > max_mbpf || mbps > max_mbps) {
+		adjusted_value = V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE;
+		update_cap = SLICE_MODE;
+		goto exit;
+	}
+
+	if (slice_mode == V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB) {
+		update_cap = SLICE_MAX_MB;
+		slice_val = inst->cap[SLICE_MAX_MB].value;
+		slice_val = max(slice_val, mbpf / MAX_SLICES_PER_FRAME);
+	} else {
+		slice_val = inst->cap[SLICE_MAX_BYTES].value;
+		update_cap = SLICE_MAX_BYTES;
+		if (rc_type != HFI_RC_OFF) {
+			max_avg_slicesize =
+				((bitrate / fps) / 8) / MAX_SLICES_PER_FRAME;
+			slice_val = max(slice_val, max_avg_slicesize);
+		}
+	}
+	adjusted_value = slice_val;
+
+exit:
+	inst->cap[update_cap].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_transform_8x8(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 adjusted_value;
+	s32 profile = -1;
+
+	adjusted_value = ctrl ? ctrl->val : inst->cap[TRANSFORM_8X8].value;
+
+	profile = inst->cap[PROFILE].value;
+	if (profile != V4L2_MPEG_VIDEO_H264_PROFILE_HIGH &&
+	    profile != V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH)
+		adjusted_value = 0;
+
+	inst->cap[TRANSFORM_8X8].value = adjusted_value;
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
index 28ce767..5421d9f 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
@@ -31,5 +31,40 @@ int get_inst_capability(struct iris_inst *inst);
 int set_v4l2_properties(struct iris_inst *inst);
 int adjust_v4l2_properties(struct iris_inst *inst);
 int ctrls_init(struct iris_inst *inst, bool init);
+int set_q16(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_level(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_req_sync_frame(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_flip(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_rotation(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_header_mode(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_gop_size(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_bitrate(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_layer_bitrate(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_peak_bitrate(struct iris_inst *inst,
+		     enum plat_inst_cap_type cap_id);
+int set_use_and_mark_ltr(struct iris_inst *inst,
+			 enum plat_inst_cap_type cap_id);
+int set_ir_period(struct iris_inst *inst,
+		  enum plat_inst_cap_type cap_id);
+int set_min_qp(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_max_qp(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_frame_qp(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_layer_count_and_type(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_slice_count(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int adjust_bitrate(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_layer_bitrate(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_peak_bitrate(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_bitrate_mode(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_gop_size(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_b_frame(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_ltr_count(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_use_ltr(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_mark_ltr(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_ir_period(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_min_quality(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_layer_count(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_entropy_mode(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_slice_count(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_transform_8x8(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index 395a189..d9d22e2 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -40,12 +40,20 @@ bool res_is_less_than(u32 width, u32 height,
 u32 get_port_info(struct iris_inst *inst,
 		  enum plat_inst_cap_type cap_id)
 {
+	if (inst->cap[cap_id].flags & CAP_FLAG_INPUT_PORT &&
+	    inst->cap[cap_id].flags & CAP_FLAG_OUTPUT_PORT) {
+		if (inst->vb2q_dst->streaming)
+			return get_hfi_port(INPUT_MPLANE);
+		else
+			return get_hfi_port(OUTPUT_MPLANE);
+	}
+
 	if (inst->cap[cap_id].flags & CAP_FLAG_INPUT_PORT)
-		return HFI_PORT_BITSTREAM;
+		return get_hfi_port(INPUT_MPLANE);
 	else if (inst->cap[cap_id].flags & CAP_FLAG_OUTPUT_PORT)
-		return HFI_PORT_RAW;
-
-	return HFI_PORT_NONE;
+		return get_hfi_port(OUTPUT_MPLANE);
+	else
+		return HFI_PORT_NONE;
 }
 
 enum iris_buffer_type v4l2_type_to_driver(u32 type)
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index 2850fd5..00e598d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -668,6 +668,59 @@ int iris_hfi_set_property(struct iris_inst *inst,
 	return ret;
 }
 
+int iris_hfi_set_ir_period(struct iris_inst *inst,
+			   u32 packet_type, u32 flag, u32 plane, u32 payload_type,
+			   void *payload, u32 payload_size)
+{
+	u32 sync_frame_req = 0;
+	struct iris_core *core;
+	int ret;
+
+	core = inst->core;
+
+	mutex_lock(&core->lock);
+
+	ret = hfi_create_header(inst->packet, inst->packet_size,
+				inst->session_id, core->header_id++);
+	if (ret)
+		goto exit;
+
+	if (!inst->ir_enabled) {
+		inst->ir_enabled = ((*(u32 *)payload > 0) ? true : false);
+		if (inst->ir_enabled && inst->vb2q_dst->streaming) {
+			sync_frame_req = HFI_SYNC_FRAME_REQUEST_WITH_PREFIX_SEQ_HDR;
+			ret = hfi_create_packet(inst->packet, inst->packet_size,
+						HFI_PROP_REQUEST_SYNC_FRAME,
+						HFI_HOST_FLAGS_NONE,
+						HFI_PAYLOAD_U32_ENUM,
+						HFI_PORT_BITSTREAM,
+						core->packet_id++,
+						&sync_frame_req,
+						sizeof(u32));
+			if (ret)
+				goto exit;
+		}
+	}
+
+	ret = hfi_create_packet(inst->packet, inst->packet_size,
+				packet_type,
+				HFI_HOST_FLAGS_NONE,
+				HFI_PAYLOAD_U32,
+				plane,
+				core->packet_id++,
+				payload,
+				sizeof(u32));
+	if (ret)
+		goto exit;
+
+	ret = iris_hfi_queue_cmd_write(inst->core, inst->packet);
+
+exit:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
 int iris_hfi_queue_buffer(struct iris_inst *inst,
 			  struct iris_buffer *buffer)
 {
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index 465bfc5..95e0523 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -40,9 +40,8 @@ int prepare_pc(struct iris_core *core);
 
 irqreturn_t iris_hfi_isr(int irq, void *data);
 irqreturn_t iris_hfi_isr_handler(int irq, void *data);
-int iris_hfi_queue_buffer(struct iris_inst *inst,
-			  struct iris_buffer *buffer);
-int iris_hfi_release_buffer(struct iris_inst *inst,
-			    struct iris_buffer *buffer);
+int iris_hfi_set_ir_period(struct iris_inst *inst,
+			   u32 packet_type, u32 flag, u32 plane, u32 payload_type,
+			   void *payload, u32 payload_size);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index fab206cf..dd27fa4 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -364,8 +364,8 @@ int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf)
 	return 0;
 }
 
-static int hfi_create_header(u8 *packet, u32 packet_size, u32 session_id,
-			     u32 header_id)
+int hfi_create_header(u8 *packet, u32 packet_size, u32 session_id,
+		      u32 header_id)
 {
 	struct hfi_header *hdr = (struct hfi_header *)packet;
 
@@ -382,9 +382,9 @@ static int hfi_create_header(u8 *packet, u32 packet_size, u32 session_id,
 	return 0;
 }
 
-static int hfi_create_packet(u8 *packet, u32 packet_size, u32 pkt_type,
-			     u32 pkt_flags, u32 payload_type, u32 port,
-			     u32 packet_id, void *payload, u32 payload_size)
+int hfi_create_packet(u8 *packet, u32 packet_size, u32 pkt_type,
+		      u32 pkt_flags, u32 payload_type, u32 port,
+		      u32 packet_id, void *payload, u32 payload_size)
 {
 	struct hfi_header *hdr;
 	struct hfi_packet *pkt;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
index 849b585..82148b7 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -108,5 +108,10 @@ int hfi_packet_sys_interframe_powercollapse(struct iris_core *core,
 					    u8 *pkt, u32 pkt_size);
 int hfi_packet_sys_pc_prep(struct iris_core *core,
 			   u8 *pkt, u32 pkt_size);
+int hfi_create_header(u8 *packet, u32 packet_size, u32 session_id,
+		      u32 header_id);
+int hfi_create_packet(u8 *packet, u32 packet_size, u32 pkt_type,
+		      u32 pkt_flags, u32 payload_type, u32 port,
+		      u32 packet_id, void *payload, u32 payload_size);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
index a4d5d9c..1b667a5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
@@ -758,6 +758,12 @@ static int handle_session_property(struct iris_inst *inst,
 	case HFI_PROP_PICTURE_TYPE:
 		inst->hfi_frame_info.picture_type = payload_ptr[0];
 		break;
+	case HFI_PROP_CABAC_SESSION:
+		if (payload_ptr[0] == 1)
+			inst->cap[ENTROPY_MODE].value = V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC;
+		else
+			inst->cap[ENTROPY_MODE].value = V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC;
+		break;
 	case HFI_PROP_DPB_LIST:
 		ret = handle_dpb_list_property(inst, pkt);
 		if (ret)
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index 3c85e78..70f4c7d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -52,6 +52,9 @@
  * @power: structure of power info
  * @bus_data: structure of bus data
  * @input_timer_list: list head of input timer
+ * @ir_enabled: boolean for intra refresh
+ * @hfi_rc_type: rate control type
+ * @hfi_layer_type: type of HFI layer encoding
  */
 
 struct iris_inst {
@@ -90,6 +93,9 @@ struct iris_inst {
 	struct iris_inst_power		power;
 	struct bus_vote_data		bus_data;
 	struct list_head		input_timer_list;
+	bool				ir_enabled;
+	u32				hfi_rc_type;
+	u32				hfi_layer_type;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index 81de610..443894c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -20,9 +20,29 @@ struct iris_inst;
 #define BIT_DEPTH_8 (8 << 16 | 8)
 #define BIT_DEPTH_10 (10 << 16 | 10)
 
-#define CODED_FRAMES_PROGRESSIVE 0x0
-#define CODED_FRAMES_INTERLACE 0x1
-#define MAX_NUM_CHILD         10
+#define CODED_FRAMES_PROGRESSIVE			0x0
+#define CODED_FRAMES_INTERLACE				0x1
+#define MAX_NUM_CHILD					10
+#define MAX_ENH_LAYER_HB				3
+#define MAX_HEVC_VBR_ENH_LAYER_SLIDING_WINDOW		5
+#define MAX_HEVC_NON_VBR_ENH_LAYER_SLIDING_WINDOW	3
+#define MAX_AVC_ENH_LAYER_SLIDING_WINDOW		3
+#define MAX_AVC_ENH_LAYER_HYBRID_HP			5
+#define MAX_SLICES_FRAME_RATE				60
+#define MAX_MB_SLICE_WIDTH				4096
+#define MAX_MB_SLICE_HEIGHT				2160
+#define MAX_BYTES_SLICE_WIDTH				1920
+#define MAX_BYTES_SLICE_HEIGHT				1088
+#define MIN_HEVC_SLICE_WIDTH				384
+#define MIN_AVC_SLICE_WIDTH				192
+#define MIN_SLICE_HEIGHT				128
+#define MAX_SLICES_PER_FRAME				10
+#define MIN_QP_8BIT					1
+#define MIN_SLICE_BYTE_SIZE				512
+#define MAX_SLICE_BYTE_SIZE				((MAX_BITRATE) >> 3)
+#define MAX_SLICE_MB_SIZE				(((4096 + 15) >> 4) * ((2304 + 15) >> 4))
+#define INVALID_DEFAULT_MARK_OR_USE_LTR			-1
+#define MAX_SUPPORTED_MIN_QUALITY			70
 
 #define DEFAULT_MAX_HOST_BUF_COUNT			64
 #define DEFAULT_MAX_HOST_BURST_BUF_COUNT		256
@@ -128,12 +148,17 @@ enum plat_inst_cap_type {
 	PIX_FMTS,
 	MBPF,
 	QUEUED_RATE,
+	FRAME_RATE,
+	OPERATING_RATE,
 	MB_CYCLES_VSP,
 	MB_CYCLES_VPP,
 	MB_CYCLES_LP,
 	MB_CYCLES_FW,
 	MB_CYCLES_FW_VPP,
 	NUM_COMV,
+	ENTROPY_MODE,
+	BASELAYER_PRIORITY,
+	IR_TYPE,
 	PROFILE,
 	LEVEL,
 	HEVC_TIER,
@@ -148,6 +173,48 @@ enum plat_inst_cap_type {
 	BIT_DEPTH,
 	DEFAULT_HEADER,
 	RAP_FRAME,
+	MIN_FRAME_QP,
+	MAX_FRAME_QP,
+	B_FRAME,
+	I_FRAME_QP,
+	P_FRAME_QP,
+	B_FRAME_QP,
+	BIT_RATE,
+	PEAK_BITRATE,
+	BITRATE_MODE,
+	FRAME_SKIP_MODE,
+	FRAME_RC_ENABLE,
+	GOP_SIZE,
+	MIN_QUALITY,
+	IR_PERIOD,
+	LTR_COUNT,
+	USE_LTR,
+	MARK_LTR,
+	I_FRAME_MIN_QP,
+	P_FRAME_MIN_QP,
+	B_FRAME_MIN_QP,
+	I_FRAME_MAX_QP,
+	P_FRAME_MAX_QP,
+	B_FRAME_MAX_QP,
+	LAYER_TYPE,
+	LAYER_ENABLE,
+	L0_BR,
+	L1_BR,
+	L2_BR,
+	L3_BR,
+	L4_BR,
+	L5_BR,
+	ENH_LAYER_COUNT,
+	TRANSFORM_8X8,
+	SLICE_MODE,
+	SLICE_MAX_MB,
+	SLICE_MAX_BYTES,
+	HFLIP,
+	VFLIP,
+	ROTATION,
+	HEADER_MODE,
+	PREPEND_SPSPPS_TO_IDR,
+	REQUEST_I_FRAME,
 	INST_CAP_MAX,
 };
 
@@ -164,6 +231,7 @@ enum plat_inst_cap_flags {
 
 struct plat_inst_cap {
 	enum plat_inst_cap_type cap_id;
+	enum domain_type domain;
 	enum codec_type codec;
 	s32 min;
 	s32 max;
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
index 7ae9715..6d5192a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
@@ -13,11 +13,19 @@
 #include "platform_common.h"
 #include "resources.h"
 
-#define CODECS_ALL     (H264 | HEVC | VP9)
-
-#define DEFAULT_FPS        30
-#define MINIMUM_FPS         1
-#define MAXIMUM_FPS       480
+#define CODECS_ALL	(H264 | HEVC | VP9)
+#define ENC		ENCODER
+#define DEC		DECODER
+
+#define DEFAULT_FPS			30
+#define MINIMUM_FPS			1
+#define MAXIMUM_FPS			480
+#define MAX_BITRATE			245000000
+#define DEFAULT_BITRATE			20000000
+#define MAX_LTR_FRAME_COUNT		2
+#define MAX_BASE_LAYER_PRIORITY_ID	63
+#define MAX_QP				51
+#define DEFAULT_QP			20
 
 static struct codec_info codec_data_sm8550[] = {
 	{
@@ -68,21 +76,37 @@ static struct plat_core_cap core_data_sm8550[] = {
 };
 
 static struct plat_inst_cap instance_cap_data_sm8550[] = {
-	{FRAME_WIDTH, CODECS_ALL, 96, 8192, 1, 1920},
+	{FRAME_WIDTH, DEC, CODECS_ALL, 96, 8192, 1, 1920},
+
+	{FRAME_WIDTH, DEC, VP9, 96, 4096, 1, 1920},
+
+	{FRAME_WIDTH, ENC, CODECS_ALL, 128, 8192, 1, 1920},
 
-	{FRAME_WIDTH, VP9, 96, 4096, 1, 1920},
+	{FRAME_WIDTH, ENC, HEVC, 96, 8192, 1, 1920},
 
-	{FRAME_HEIGHT, CODECS_ALL, 96, 8192, 1, 1080},
+	{FRAME_HEIGHT, DEC, CODECS_ALL, 96, 8192, 1, 1080},
 
-	{FRAME_HEIGHT, VP9, 96, 4096, 1, 1080},
+	{FRAME_HEIGHT, DEC, VP9, 96, 4096, 1, 1080},
 
-	{PIX_FMTS, H264,
+	{FRAME_HEIGHT, ENC, CODECS_ALL, 128, 8192, 1, 1080},
+
+	{FRAME_HEIGHT, ENC, HEVC, 96, 8192, 1, 1080},
+
+	{PIX_FMTS, DEC, H264,
 		FMT_NV12,
 		FMT_NV12C,
 		FMT_NV12 | FMT_NV21 | FMT_NV12C,
 		FMT_NV12C},
 
-	{PIX_FMTS, HEVC,
+	{PIX_FMTS, ENC, H264,
+		FMT_NV12,
+		FMT_NV12C,
+		FMT_NV12 | FMT_NV21 | FMT_NV12C,
+		FMT_NV12C,
+		0, 0,
+		CAP_FLAG_NONE},
+
+	{PIX_FMTS, DEC, HEVC,
 		FMT_NV12,
 		FMT_TP10C,
 		FMT_NV12 | FMT_NV21 | FMT_NV12C | FMT_TP10C,
@@ -91,37 +115,73 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		CAP_FLAG_NONE,
 		{PROFILE}},
 
-	{PIX_FMTS, VP9,
+	{PIX_FMTS, ENC, HEVC,
+		FMT_NV12,
+		FMT_TP10C,
+		FMT_NV12 | FMT_NV21 | FMT_NV12C | FMT_TP10C,
+		FMT_NV12C,
+		0, 0,
+		CAP_FLAG_NONE,
+		{PROFILE, MIN_QUALITY, IR_PERIOD, LTR_COUNT}},
+
+	{PIX_FMTS, DEC, VP9,
 		FMT_NV12,
 		FMT_TP10C,
 		FMT_NV12 | FMT_NV21 | FMT_NV12C | FMT_TP10C,
 		FMT_NV12C},
 
-	{MBPF, CODECS_ALL, 36, 138240, 1, 138240},
+	{MBPF, DEC, CODECS_ALL, 36, 138240, 1, 138240},
 
 	/* (4096 * 2304) / 256 */
-	{MBPF, VP9, 36, 36864, 1, 36864},
+	{MBPF, DEC, VP9, 36, 36864, 1, 36864},
+
+	/* (8192 * 4320) / 256 */
+	{MBPF, ENC, CODECS_ALL, 64, 138240, 1, 138240},
+
+	{MBPF, ENC, HEVC, 36, 138240, 1, 138240},
 
-	{QUEUED_RATE, CODECS_ALL,
+	{QUEUED_RATE, DEC | ENC, CODECS_ALL,
 		(MINIMUM_FPS << 16), INT_MAX,
 		1, (DEFAULT_FPS << 16)},
 
-	{MB_CYCLES_VSP, CODECS_ALL, 25, 25, 1, 25},
+	{FRAME_RATE, ENC, CODECS_ALL,
+		(MINIMUM_FPS << 16), (MAXIMUM_FPS << 16),
+		1, (DEFAULT_FPS << 16),
+		0,
+		HFI_PROP_FRAME_RATE,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		NULL,
+		set_q16},
+
+	{OPERATING_RATE, ENC, CODECS_ALL,
+		(MINIMUM_FPS << 16), (MAXIMUM_FPS << 16),
+		1, (DEFAULT_FPS << 16)},
+
+	{MB_CYCLES_VSP, DEC, CODECS_ALL, 25, 25, 1, 25},
+
+	{MB_CYCLES_VSP, DEC, VP9, 60, 60, 1, 60},
+
+	{MB_CYCLES_VSP, ENC, CODECS_ALL, 25, 25, 1, 25},
 
-	{MB_CYCLES_VSP, VP9, 60, 60, 1, 60},
+	{MB_CYCLES_VPP, DEC, CODECS_ALL, 200, 200, 1, 200},
 
-	{MB_CYCLES_VPP, CODECS_ALL, 200, 200, 1, 200},
+	{MB_CYCLES_VPP, ENC, CODECS_ALL, 675, 675, 1, 675},
 
-	{MB_CYCLES_LP, CODECS_ALL, 200, 200, 1, 200},
+	{MB_CYCLES_LP, DEC, CODECS_ALL, 200, 200, 1, 200},
 
-	{MB_CYCLES_FW, CODECS_ALL, 489583, 489583, 1, 489583},
+	{MB_CYCLES_LP, ENC, CODECS_ALL, 320, 320, 1, 320},
 
-	{MB_CYCLES_FW_VPP, CODECS_ALL, 66234, 66234, 1, 66234},
+	{MB_CYCLES_FW, DEC | ENC, CODECS_ALL, 489583, 489583, 1, 489583},
 
-	{NUM_COMV, CODECS_ALL,
+	{MB_CYCLES_FW_VPP, DEC, CODECS_ALL, 66234, 66234, 1, 66234},
+
+	{MB_CYCLES_FW_VPP, ENC, CODECS_ALL, 48405, 48405, 1, 48405},
+
+	{NUM_COMV, DEC, CODECS_ALL,
 		0, INT_MAX, 1, 0},
 
-	{PROFILE, H264,
+	{PROFILE, DEC, H264,
 		V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
 		V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH,
 		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
@@ -137,7 +197,23 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_u32_enum},
 
-	{PROFILE, HEVC,
+	{PROFILE, ENC, H264,
+		V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE,
+		V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH,
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE) |
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH) |
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE) |
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_MAIN) |
+		BIT(V4L2_MPEG_VIDEO_H264_PROFILE_HIGH),
+		V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
+		V4L2_CID_MPEG_VIDEO_H264_PROFILE,
+		HFI_PROP_PROFILE,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{ENTROPY_MODE, TRANSFORM_8X8},
+		NULL,
+		set_u32_enum},
+
+	{PROFILE, ENC | DEC, HEVC,
 		V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
 		V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
 		BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN) |
@@ -151,7 +227,7 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		adjust_profile,
 		set_u32_enum},
 
-	{PROFILE, VP9,
+	{PROFILE, DEC, VP9,
 		V4L2_MPEG_VIDEO_VP9_PROFILE_0,
 		V4L2_MPEG_VIDEO_VP9_PROFILE_2,
 		BIT(V4L2_MPEG_VIDEO_VP9_PROFILE_0) |
@@ -164,7 +240,7 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_u32_enum},
 
-	{LEVEL, H264,
+	{LEVEL, DEC, H264,
 		V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
 		V4L2_MPEG_VIDEO_H264_LEVEL_6_2,
 		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_0) |
@@ -195,7 +271,36 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_u32_enum},
 
-	{LEVEL, HEVC,
+	{LEVEL, ENC, H264,
+		V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
+		V4L2_MPEG_VIDEO_H264_LEVEL_6_0,
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1B) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_1_3) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_2_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_3_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_4_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_0) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_1) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_5_2) |
+		BIT(V4L2_MPEG_VIDEO_H264_LEVEL_6_0),
+		V4L2_MPEG_VIDEO_H264_LEVEL_5_0,
+		V4L2_CID_MPEG_VIDEO_H264_LEVEL,
+		HFI_PROP_LEVEL,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		NULL,
+		set_level},
+
+	{LEVEL, DEC, HEVC,
 		V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
 		V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2,
 		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_1) |
@@ -219,7 +324,31 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_u32_enum},
 
-	{LEVEL, VP9,
+	{LEVEL, ENC, HEVC,
+		V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
+		V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2,
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_LEVEL_6_2),
+		V4L2_MPEG_VIDEO_HEVC_LEVEL_5,
+		V4L2_CID_MPEG_VIDEO_HEVC_LEVEL,
+		HFI_PROP_LEVEL,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		NULL,
+		set_level},
+
+	{LEVEL, DEC, VP9,
 		V4L2_MPEG_VIDEO_VP9_LEVEL_1_0,
 		V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
 		BIT(V4L2_MPEG_VIDEO_VP9_LEVEL_1_0) |
@@ -242,7 +371,7 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_u32_enum},
 
-	{HEVC_TIER, HEVC,
+	{HEVC_TIER, DEC | ENC, HEVC,
 		V4L2_MPEG_VIDEO_HEVC_TIER_MAIN,
 		V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
 		BIT(V4L2_MPEG_VIDEO_HEVC_TIER_MAIN) |
@@ -255,7 +384,566 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_u32_enum},
 
-	{DISPLAY_DELAY_ENABLE, CODECS_ALL,
+	{HFLIP, ENC, CODECS_ALL,
+		0, 1, 1, 0,
+		V4L2_CID_HFLIP,
+		HFI_PROP_FLIP,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		NULL,
+		set_flip},
+
+	{VFLIP, ENC, CODECS_ALL,
+		0, 1, 1, 0,
+		V4L2_CID_VFLIP,
+		HFI_PROP_FLIP,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		NULL,
+		set_flip},
+
+	{ROTATION, ENC, CODECS_ALL,
+		0, 270, 90, 0,
+		V4L2_CID_ROTATE,
+		HFI_PROP_ROTATION,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		NULL,
+		set_rotation},
+
+	{HEADER_MODE, ENC, CODECS_ALL,
+		V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE,
+		V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
+		BIT(V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE) |
+		BIT(V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME),
+		V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE,
+		V4L2_CID_MPEG_VIDEO_HEADER_MODE,
+		HFI_PROP_SEQ_HEADER_MODE,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		NULL,
+		set_header_mode},
+
+	{PREPEND_SPSPPS_TO_IDR, ENC, CODECS_ALL,
+		0, 1, 1, 0,
+		V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR},
+
+	{REQUEST_I_FRAME, ENC, H264 | HEVC,
+		0, 0, 0, 0,
+		V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME,
+		HFI_PROP_REQUEST_SYNC_FRAME,
+		CAP_FLAG_INPUT_PORT | CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		NULL,
+		set_req_sync_frame},
+
+	{BIT_RATE, ENC, H264 | HEVC,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_BITRATE,
+		HFI_PROP_TOTAL_BITRATE,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{PEAK_BITRATE, L0_BR},
+		adjust_bitrate,
+		set_bitrate},
+
+	{PEAK_BITRATE, ENC, H264 | HEVC,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_BITRATE_PEAK,
+		HFI_PROP_TOTAL_PEAK_BITRATE,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		adjust_peak_bitrate,
+		set_peak_bitrate},
+
+	{BITRATE_MODE, ENC, H264 | HEVC,
+		V4L2_MPEG_VIDEO_BITRATE_MODE_VBR,
+		V4L2_MPEG_VIDEO_BITRATE_MODE_CBR,
+		BIT(V4L2_MPEG_VIDEO_BITRATE_MODE_VBR) |
+		BIT(V4L2_MPEG_VIDEO_BITRATE_MODE_CBR),
+		V4L2_MPEG_VIDEO_BITRATE_MODE_VBR,
+		V4L2_CID_MPEG_VIDEO_BITRATE_MODE,
+		HFI_PROP_RATE_CONTROL,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{LTR_COUNT, IR_PERIOD, I_FRAME_QP, P_FRAME_QP,
+		 B_FRAME_QP, ENH_LAYER_COUNT, BIT_RATE,
+		 MIN_QUALITY, PEAK_BITRATE, SLICE_MODE},
+		adjust_bitrate_mode,
+		set_u32_enum},
+
+	{FRAME_SKIP_MODE, ENC, H264 | HEVC,
+		V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_DISABLED,
+		V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_BUF_LIMIT,
+		BIT(V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_DISABLED) |
+		BIT(V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_LEVEL_LIMIT) |
+		BIT(V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_BUF_LIMIT),
+		V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_DISABLED,
+		V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE,
+		0,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+
+	{FRAME_RC_ENABLE, ENC, H264 | HEVC,
+		0, 1, 1, 1,
+		V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE},
+
+	{GOP_SIZE, ENC, CODECS_ALL,
+		0, INT_MAX, 1, 2 * DEFAULT_FPS - 1,
+		V4L2_CID_MPEG_VIDEO_GOP_SIZE,
+		HFI_PROP_MAX_GOP_FRAMES,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		adjust_gop_size,
+		set_gop_size},
+
+	{B_FRAME, ENC, H264 | HEVC,
+		0, 7, 1, 0,
+		V4L2_CID_MPEG_VIDEO_B_FRAMES,
+		HFI_PROP_MAX_B_FRAMES,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		adjust_b_frame,
+		set_u32},
+
+	{LTR_COUNT, ENC, H264 | HEVC,
+		0, MAX_LTR_FRAME_COUNT, 1, 0,
+		V4L2_CID_MPEG_VIDEO_LTR_COUNT,
+		HFI_PROP_LTR_COUNT,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		adjust_ltr_count,
+		set_u32},
+
+	{USE_LTR, ENC, H264 | HEVC,
+		0,
+		((1 << MAX_LTR_FRAME_COUNT) - 1),
+		0, 0,
+		V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES,
+		HFI_PROP_LTR_USE,
+		CAP_FLAG_INPUT_PORT | CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		adjust_use_ltr,
+		set_use_and_mark_ltr},
+
+	{MARK_LTR, ENC, H264 | HEVC,
+		INVALID_DEFAULT_MARK_OR_USE_LTR,
+		(MAX_LTR_FRAME_COUNT - 1),
+		1, INVALID_DEFAULT_MARK_OR_USE_LTR,
+		V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX,
+		HFI_PROP_LTR_MARK,
+		CAP_FLAG_INPUT_PORT | CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		adjust_mark_ltr,
+		set_use_and_mark_ltr},
+
+	{BASELAYER_PRIORITY, ENC, H264,
+		0, MAX_BASE_LAYER_PRIORITY_ID, 1, 0,
+		V4L2_CID_MPEG_VIDEO_BASELAYER_PRIORITY_ID,
+		HFI_PROP_BASELAYER_PRIORITYID,
+		CAP_FLAG_OUTPUT_PORT},
+
+	{IR_TYPE, ENC, H264 | HEVC,
+		V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM,
+		V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC,
+		BIT(V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM) |
+		BIT(V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC),
+		V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM,
+		V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE,
+		0,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+
+	{IR_PERIOD, ENC, H264 | HEVC,
+		0, INT_MAX, 1, 0,
+		V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD,
+		0,
+		CAP_FLAG_INPUT_PORT | CAP_FLAG_OUTPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		adjust_ir_period,
+		set_ir_period},
+
+	{MIN_QUALITY, ENC, H264 | HEVC,
+		0, MAX_SUPPORTED_MIN_QUALITY, 70, MAX_SUPPORTED_MIN_QUALITY,
+		0,
+		HFI_PROP_MAINTAIN_MIN_QUALITY,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		adjust_min_quality,
+		set_u32},
+
+	{MIN_FRAME_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, MIN_QP_8BIT,
+		V4L2_CID_MPEG_VIDEO_H264_MIN_QP,
+		HFI_PROP_MIN_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		NULL,
+		set_min_qp},
+
+	{MIN_FRAME_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, MIN_QP_8BIT,
+		V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP,
+		HFI_PROP_MIN_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		NULL,
+		set_min_qp},
+
+	{MAX_FRAME_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, MAX_QP,
+		V4L2_CID_MPEG_VIDEO_H264_MAX_QP,
+		HFI_PROP_MAX_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		NULL,
+		set_max_qp},
+
+	{MAX_FRAME_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, MAX_QP,
+		V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP,
+		HFI_PROP_MAX_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		NULL,
+		set_max_qp},
+
+	{I_FRAME_MIN_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, MIN_QP_8BIT,
+		V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MIN_QP},
+
+	{I_FRAME_MIN_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, MIN_QP_8BIT,
+		V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_MIN_QP},
+
+	{P_FRAME_MIN_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, MIN_QP_8BIT,
+		V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MIN_QP},
+
+	{P_FRAME_MIN_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, MIN_QP_8BIT,
+		V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_MIN_QP},
+
+	{B_FRAME_MIN_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, MIN_QP_8BIT,
+		V4L2_CID_MPEG_VIDEO_H264_B_FRAME_MIN_QP},
+
+	{B_FRAME_MIN_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, MIN_QP_8BIT,
+		V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_MIN_QP},
+
+	{I_FRAME_MAX_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, MAX_QP,
+		V4L2_CID_MPEG_VIDEO_H264_I_FRAME_MAX_QP},
+
+	{I_FRAME_MAX_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, MAX_QP,
+		V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_MAX_QP},
+
+	{P_FRAME_MAX_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, MAX_QP,
+		V4L2_CID_MPEG_VIDEO_H264_P_FRAME_MAX_QP},
+
+	{P_FRAME_MAX_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, MAX_QP,
+		V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_MAX_QP},
+
+	{B_FRAME_MAX_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, MAX_QP,
+		V4L2_CID_MPEG_VIDEO_H264_B_FRAME_MAX_QP},
+
+	{B_FRAME_MAX_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, MAX_QP,
+		V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_MAX_QP},
+
+	{I_FRAME_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, DEFAULT_QP,
+		V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP,
+		HFI_PROP_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		NULL,
+		set_frame_qp},
+
+	{I_FRAME_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, DEFAULT_QP,
+		V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP,
+		HFI_PROP_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		NULL,
+		set_frame_qp},
+
+	{P_FRAME_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, DEFAULT_QP,
+		V4L2_CID_MPEG_VIDEO_HEVC_P_FRAME_QP,
+		HFI_PROP_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		NULL,
+		set_frame_qp},
+
+	{P_FRAME_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, DEFAULT_QP,
+		V4L2_CID_MPEG_VIDEO_H264_P_FRAME_QP,
+		HFI_PROP_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		NULL,
+		set_frame_qp},
+
+	{B_FRAME_QP, ENC, HEVC,
+		MIN_QP_8BIT, MAX_QP, 1, DEFAULT_QP,
+		V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP,
+		HFI_PROP_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		NULL,
+		set_frame_qp},
+
+	{B_FRAME_QP, ENC, H264,
+		MIN_QP_8BIT, MAX_QP, 1, DEFAULT_QP,
+		V4L2_CID_MPEG_VIDEO_H264_B_FRAME_QP,
+		HFI_PROP_QP_PACKED,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		NULL,
+		set_frame_qp},
+
+	{LAYER_TYPE, ENC, HEVC,
+		V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_B,
+		V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_P,
+		BIT(V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_B) |
+		BIT(V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_P),
+		V4L2_MPEG_VIDEO_HEVC_HIERARCHICAL_CODING_P,
+		V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_TYPE,
+		HFI_PROP_LAYER_ENCODING_TYPE,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{LTR_COUNT}},
+
+	{LAYER_TYPE, ENC, H264,
+		V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_B,
+		V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_P,
+		BIT(V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_B) |
+		BIT(V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_P),
+		V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODING_P,
+		V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_TYPE,
+		HFI_PROP_LAYER_ENCODING_TYPE,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{LTR_COUNT}},
+
+	{LAYER_ENABLE, ENC, H264,
+		0, 1, 1, 0,
+		V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING,
+		HFI_PROP_LAYER_ENCODING_TYPE,
+		CAP_FLAG_OUTPUT_PORT},
+
+	{LAYER_ENABLE, ENC, HEVC,
+		0, 1, 1, 0,
+		0,
+		0,
+		CAP_FLAG_OUTPUT_PORT},
+
+	{ENH_LAYER_COUNT, ENC, HEVC,
+		0, 5, 1, 0,
+		V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_LAYER,
+		HFI_PROP_LAYER_COUNT,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{GOP_SIZE, B_FRAME, BIT_RATE, MIN_QUALITY, SLICE_MODE,
+		 LTR_COUNT},
+		adjust_layer_count,
+		set_layer_count_and_type},
+
+	{ENH_LAYER_COUNT, ENC, H264,
+		0, 5, 1, 0,
+		V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER,
+		HFI_PROP_LAYER_COUNT,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{GOP_SIZE, B_FRAME, BIT_RATE, MIN_QUALITY, SLICE_MODE,
+		 LTR_COUNT},
+		adjust_layer_count,
+		set_layer_count_and_type},
+
+	{L0_BR, ENC, H264,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L0_BR,
+		HFI_PROP_BITRATE_LAYER1,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L1_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L0_BR, ENC, HEVC,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L0_BR,
+		HFI_PROP_BITRATE_LAYER1,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L1_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L1_BR, ENC, H264,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L1_BR,
+		HFI_PROP_BITRATE_LAYER2,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L2_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L1_BR, ENC, HEVC,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L1_BR,
+		HFI_PROP_BITRATE_LAYER2,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L2_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L2_BR, ENC, H264,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L2_BR,
+		HFI_PROP_BITRATE_LAYER3,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L3_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L2_BR, ENC, HEVC,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L2_BR,
+		HFI_PROP_BITRATE_LAYER3,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L3_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L3_BR, ENC, H264,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L3_BR,
+		HFI_PROP_BITRATE_LAYER4,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L4_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L3_BR, ENC, HEVC,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L3_BR,
+		HFI_PROP_BITRATE_LAYER4,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L4_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L4_BR, ENC, H264,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L4_BR,
+		HFI_PROP_BITRATE_LAYER5,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L5_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L4_BR, ENC, HEVC,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L4_BR,
+		HFI_PROP_BITRATE_LAYER5,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{L5_BR},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L5_BR, ENC, H264,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L5_BR,
+		HFI_PROP_BITRATE_LAYER6,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{L5_BR, ENC, HEVC,
+		1, MAX_BITRATE, 1, DEFAULT_BITRATE,
+		V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L5_BR,
+		HFI_PROP_BITRATE_LAYER6,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+		CAP_FLAG_DYNAMIC_ALLOWED,
+		{0},
+		adjust_layer_bitrate,
+		set_layer_bitrate},
+
+	{ENTROPY_MODE, ENC, H264,
+		V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC,
+		V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC,
+		BIT(V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC) |
+		BIT(V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC),
+		V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC,
+		V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE,
+		HFI_PROP_CABAC_SESSION,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{BIT_RATE},
+		adjust_entropy_mode,
+		set_u32},
+
+	{SLICE_MODE, ENC, H264 | HEVC,
+		V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE,
+		V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES,
+		BIT(V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE) |
+		BIT(V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB) |
+		BIT(V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_BYTES),
+		V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE,
+		V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE,
+		0,
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{STAGE},
+		adjust_slice_count,
+		set_slice_count},
+
+	{SLICE_MAX_BYTES, ENC, H264 | HEVC,
+		MIN_SLICE_BYTE_SIZE, MAX_SLICE_BYTE_SIZE,
+		1, MIN_SLICE_BYTE_SIZE,
+		V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_BYTES,
+		HFI_PROP_MULTI_SLICE_BYTES_COUNT,
+		CAP_FLAG_OUTPUT_PORT},
+
+	{SLICE_MAX_MB, ENC, H264 | HEVC,
+		1, MAX_SLICE_MB_SIZE, 1, 1,
+		V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_MB,
+		HFI_PROP_MULTI_SLICE_MB_COUNT,
+		CAP_FLAG_OUTPUT_PORT},
+
+	{TRANSFORM_8X8, ENC, H264,
+		0, 1, 1, 1,
+		V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM,
+		HFI_PROP_8X8_TRANSFORM,
+		CAP_FLAG_OUTPUT_PORT,
+		{0},
+		adjust_transform_8x8,
+		set_u32},
+
+	{DISPLAY_DELAY_ENABLE, DEC, CODECS_ALL,
 		0, 1, 1, 0,
 		V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE,
 		HFI_PROP_DECODE_ORDER_OUTPUT,
@@ -264,7 +952,7 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		NULL},
 
-	{DISPLAY_DELAY, CODECS_ALL,
+	{DISPLAY_DELAY, DEC, CODECS_ALL,
 		0, 1, 1, 0,
 		V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY,
 		HFI_PROP_DECODE_ORDER_OUTPUT,
@@ -273,7 +961,7 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		NULL},
 
-	{OUTPUT_ORDER, CODECS_ALL,
+	{OUTPUT_ORDER, DEC, CODECS_ALL,
 		0, 1, 1, 0,
 		0,
 		HFI_PROP_DECODE_ORDER_OUTPUT,
@@ -282,7 +970,7 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		adjust_output_order,
 		set_u32},
 
-	{INPUT_BUF_HOST_MAX_COUNT, CODECS_ALL,
+	{INPUT_BUF_HOST_MAX_COUNT, ENC | DEC, CODECS_ALL,
 		DEFAULT_MAX_HOST_BUF_COUNT, DEFAULT_MAX_HOST_BURST_BUF_COUNT,
 		1, DEFAULT_MAX_HOST_BUF_COUNT,
 		0,
@@ -292,7 +980,7 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_u32},
 
-	{STAGE, CODECS_ALL,
+	{STAGE, ENC | DEC, CODECS_ALL,
 		STAGE_1,
 		STAGE_2, 1,
 		STAGE_2,
@@ -303,7 +991,7 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_stage},
 
-	{PIPE, CODECS_ALL,
+	{PIPE, ENC | DEC, CODECS_ALL,
 		PIPE_1,
 		PIPE_4, 1,
 		PIPE_4,
@@ -314,26 +1002,26 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_pipe},
 
-	{POC, H264, 0, 2, 1, 1,
+	{POC, DEC, H264, 0, 2, 1, 1,
 		0,
 		HFI_PROP_PIC_ORDER_CNT_TYPE},
 
-	{CODED_FRAMES, H264 | HEVC,
+	{CODED_FRAMES, DEC, H264 | HEVC,
 		CODED_FRAMES_PROGRESSIVE, CODED_FRAMES_PROGRESSIVE,
 		0, CODED_FRAMES_PROGRESSIVE,
 		0,
 		HFI_PROP_CODED_FRAMES},
 
-	{BIT_DEPTH, CODECS_ALL, BIT_DEPTH_8, BIT_DEPTH_10, 1, BIT_DEPTH_8,
+	{BIT_DEPTH, DEC, CODECS_ALL, BIT_DEPTH_8, BIT_DEPTH_10, 1, BIT_DEPTH_8,
 		0,
 		HFI_PROP_LUMA_CHROMA_BIT_DEPTH},
 
-	{DEFAULT_HEADER, CODECS_ALL,
+	{DEFAULT_HEADER, DEC, CODECS_ALL,
 		0, 1, 1, 0,
 		0,
 		HFI_PROP_DEC_DEFAULT_HEADER},
 
-	{RAP_FRAME, CODECS_ALL,
+	{RAP_FRAME, DEC, CODECS_ALL,
 		0, 1, 1, 1,
 		0,
 		HFI_PROP_DEC_START_FROM_RAP_FRAME,
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
index 5a02f24..58498af 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
@@ -42,6 +42,9 @@ u64 iris_calc_freq_iris3(struct iris_inst *inst, u32 data_size)
 
 	if (inst->codec == VP9) {
 		vsp_cycles = div_u64(vsp_cycles * 170, 100);
+	} else if (inst->cap[ENTROPY_MODE].value ==
+		V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC) {
+		vsp_cycles = div_u64(vsp_cycles * 135, 100);
 	} else {
 		base_cycles = 0;
 		vsp_cycles = div_u64(vsp_cycles, 2);
-- 
2.7.4


