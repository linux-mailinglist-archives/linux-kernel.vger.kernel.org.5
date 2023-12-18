Return-Path: <linux-kernel+bounces-3481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DF816CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DA31F253BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040640BE9;
	Mon, 18 Dec 2023 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m9IQQP6A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD096381B2;
	Mon, 18 Dec 2023 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAslf2028697;
	Mon, 18 Dec 2023 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=N8s5yYXwEHYgj9TDxp9LJSATexqdj9j0R5d1BKVwOlA=; b=m9
	IQQP6A6smD7brqB/UO4AswFn7kCbqLzWTEuMvD95J0FVOlt4zkAqwshSbs5YfkHR
	Lq6exVdweHFAVEVsNEIvurkiuxOzeGfgfwA+5K35jmUYQnDz8Q36oDH9rfHotujt
	/mMq7h2UbSo4HF4bBxt6uTx0uzUuZvbSiScwAFwDYP+Ky8yMu8e+Sx/jValqFVFX
	tPa9gJAqMm5WDPnQFM68OdDM+2shC+CJjVyPJ26bd5R2A69yPjN1NMxw8zSt5h+A
	2Pq7KSmeyZ+tDLrAQWX5D/pLQd6P3HCiy3DFddH9SZWC2Pe7oSCGY5t0Tbk5Yb0D
	uMV+WgnuOnmn8wunhPog==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2ghdgnc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:04 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0x0004854;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ag-4;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX8ra030072;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX8qi030067;
	Mon, 18 Dec 2023 11:36:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 6E9B2238D; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 32/34] media: iris: implement iris v4l2 ioctl ops supported by encoder
Date: Mon, 18 Dec 2023 17:02:27 +0530
Message-Id: <1702899149-21321-33-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xg1w6oxGrxLf3k8OAReWWYDLMPGW0hk5
X-Proofpoint-ORIG-GUID: xg1w6oxGrxLf3k8OAReWWYDLMPGW0hk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Implement all iris v4l2 ioctls ops supported by encoder.
Add state checks to ensure ioctl are allowed in valid
instance state only. Codec format can be changed by client
during s_fmt. Update the v4l2 control values according
to the updated codec format.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   1 +
 .../media/platform/qcom/vcodec/iris/iris_core.h    |   8 +-
 .../media/platform/qcom/vcodec/iris/iris_ctrls.c   |  59 ++-
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  89 +++-
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   3 +
 .../platform/qcom/vcodec/iris/iris_instance.h      |   5 +
 .../media/platform/qcom/vcodec/iris/iris_probe.c   |   3 +-
 .../media/platform/qcom/vcodec/iris/iris_state.c   |   5 +-
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    |  80 +---
 .../media/platform/qcom/vcodec/iris/iris_venc.c    | 525 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_venc.h    |  24 +
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    | 415 ++++++++++++++--
 .../platform/qcom/vcodec/iris/platform_common.h    |   2 +
 .../platform/qcom/vcodec/iris/platform_sm8550.c    |   1 +
 14 files changed, 1088 insertions(+), 132 deletions(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_venc.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_venc.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 4c8f8f6..b95d627 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -6,6 +6,7 @@ iris-objs += iris_probe.o \
              iris_vidc.o \
              iris_vb2.o \
              iris_vdec.o \
+             iris_venc.o \
              iris_state.o \
              iris_ctrls.o \
              iris_helpers.o \
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index c56eb24..baced21 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -25,7 +25,8 @@
  * @vdev_dec: iris video device structure for decoder
  * @vdev_enc: iris video device structure for encoder
  * @v4l2_file_ops: iris v4l2 file ops
- * @v4l2_ioctl_ops: iris v4l2 ioctl ops
+ * @v4l2_ioctl_ops_dec: iris v4l2 ioctl ops for decoder
+ * @v4l2_ioctl_ops_enc: iris v4l2 ioctl ops for encoder
  * @bus_tbl: table of iris buses
  * @bus_count: count of iris buses
  * @power_domain_tbl: table of iris power domains
@@ -52,6 +53,7 @@
  * @packet_id: id of packet
  * @vpu_ops: a pointer to vpu ops
  * @session_ops: a pointer to session level ops
+ * @enc_codecs_count: supported codec count for encoder
  * @dec_codecs_count: supported codec count for decoder
  * @platform_data: a structure for platform data
  * @cap: an array for supported core capabilities
@@ -69,7 +71,8 @@ struct iris_core {
 	struct video_device			*vdev_dec;
 	struct video_device			*vdev_enc;
 	const struct v4l2_file_operations	*v4l2_file_ops;
-	const struct v4l2_ioctl_ops		*v4l2_ioctl_ops;
+	const struct v4l2_ioctl_ops		*v4l2_ioctl_ops_dec;
+	const struct v4l2_ioctl_ops		*v4l2_ioctl_ops_enc;
 	struct bus_info				*bus_tbl;
 	u32					bus_count;
 	struct power_domain_info		*power_domain_tbl;
@@ -97,6 +100,7 @@ struct iris_core {
 	const struct vpu_ops			*vpu_ops;
 	const struct vpu_session_ops		*session_ops;
 	u32					dec_codecs_count;
+	u32					enc_codecs_count;
 	struct platform_data			*platform_data;
 	struct plat_core_cap			cap[CORE_CAP_MAX + 1];
 	struct plat_inst_caps			*inst_caps;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
index a648cc1..af99ac73 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
@@ -217,7 +217,7 @@ static int set_dynamic_property(struct iris_inst *inst,
 	return ret;
 }
 
-static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+static int iris_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 {
 	enum plat_inst_cap_type cap_id;
 	struct iris_inst *inst = NULL;
@@ -242,7 +242,7 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 	return ret;
 }
 
-static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
+static int iris_op_s_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct cap_entry *entry = NULL, *temp = NULL;
 	struct list_head children_list, firmware_list;
@@ -273,7 +273,8 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
 
 	cap[cap_id].flags |= CAP_FLAG_CLIENT_SET;
 
-	if (!inst->vb2q_src->streaming) {
+	if ((inst->domain == ENCODER && !inst->vb2q_dst->streaming) ||
+	    (inst->domain == DECODER && !inst->vb2q_src->streaming)) {
 		inst->cap[cap_id].value = ctrl->val;
 	} else {
 		ret = adjust_dynamic_property(inst, cap_id, ctrl,
@@ -300,16 +301,16 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
 }
 
 static const struct v4l2_ctrl_ops ctrl_ops = {
-	.s_ctrl = vdec_op_s_ctrl,
-	.g_volatile_ctrl = vdec_op_g_volatile_ctrl,
+	.s_ctrl = iris_op_s_ctrl,
+	.g_volatile_ctrl = iris_op_g_volatile_ctrl,
 };
 
 int ctrls_init(struct iris_inst *inst, bool init)
 {
 	int num_ctrls = 0, ctrl_idx = 0;
+	u64 codecs_count, step_or_mask;
 	struct plat_inst_cap *cap;
 	struct iris_core *core;
-	u64 step_or_mask;
 	int idx = 0;
 	int ret = 0;
 
@@ -324,8 +325,11 @@ int ctrls_init(struct iris_inst *inst, bool init)
 		return -EINVAL;
 
 	if (init) {
+		codecs_count = inst->domain == ENCODER ?
+			core->enc_codecs_count :
+			core->dec_codecs_count;
 		ret = v4l2_ctrl_handler_init(&inst->ctrl_handler,
-					     INST_CAP_MAX * core->dec_codecs_count);
+					     INST_CAP_MAX * codecs_count);
 		if (ret)
 			return ret;
 	}
@@ -451,29 +455,49 @@ static int update_inst_capability(struct plat_inst_cap *in,
 int iris_init_instance_caps(struct iris_core *core)
 {
 	struct plat_inst_cap *inst_plat_cap_data = NULL;
-	u8 dec_codecs_count = 0;
-	int num_inst_cap;
-	u32 dec_valid_codecs;
+	u8 enc_codecs_count = 0, dec_codecs_count = 0;
+	u32 enc_valid_codecs, dec_valid_codecs;
 	int i, j, check_bit = 0;
+	u8 codecs_count = 0;
+	int num_inst_cap;
 	int ret = 0;
 
 	inst_plat_cap_data = core->platform_data->inst_cap_data;
 	if (!inst_plat_cap_data)
 		return -EINVAL;
 
+	enc_valid_codecs = core->cap[ENC_CODECS].value;
+	enc_codecs_count = hweight32(enc_valid_codecs);
+	core->enc_codecs_count = enc_codecs_count;
+
 	dec_valid_codecs = core->cap[DEC_CODECS].value;
 	dec_codecs_count = hweight32(dec_valid_codecs);
 	core->dec_codecs_count = dec_codecs_count;
 
+	codecs_count = enc_codecs_count + dec_codecs_count;
 	core->inst_caps = devm_kzalloc(core->dev,
-				       dec_codecs_count * sizeof(struct plat_inst_caps),
+				       codecs_count * sizeof(struct plat_inst_caps),
 				       GFP_KERNEL);
 	if (!core->inst_caps)
 		return -ENOMEM;
 
-	for (i = 0; i < dec_codecs_count; i++) {
+	for (i = 0; i < enc_codecs_count; i++) {
+		while (check_bit < (sizeof(enc_valid_codecs) * 8)) {
+			if (enc_valid_codecs & BIT(check_bit)) {
+				core->inst_caps[i].domain = ENCODER;
+				core->inst_caps[i].codec = enc_valid_codecs &
+						BIT(check_bit);
+				check_bit++;
+				break;
+			}
+			check_bit++;
+		}
+	}
+
+	for (; i < codecs_count; i++) {
 		while (check_bit < (sizeof(dec_valid_codecs) * 8)) {
 			if (dec_valid_codecs & BIT(check_bit)) {
+				core->inst_caps[i].domain = DECODER;
 				core->inst_caps[i].codec = dec_valid_codecs &
 						BIT(check_bit);
 				check_bit++;
@@ -486,9 +510,9 @@ int iris_init_instance_caps(struct iris_core *core)
 	num_inst_cap = core->platform_data->inst_cap_data_size;
 
 	for (i = 0; i < num_inst_cap; i++) {
-		for (j = 0; j < dec_codecs_count; j++) {
-			if ((inst_plat_cap_data[i].codec &
-				core->inst_caps[j].codec)) {
+		for (j = 0; j < codecs_count; j++) {
+			if ((inst_plat_cap_data[i].domain & core->inst_caps[j].domain) &&
+			    (inst_plat_cap_data[i].codec & core->inst_caps[j].codec)) {
 				ret = update_inst_capability(&inst_plat_cap_data[i],
 							     &core->inst_caps[j]);
 				if (ret)
@@ -503,11 +527,14 @@ int iris_init_instance_caps(struct iris_core *core)
 int get_inst_capability(struct iris_inst *inst)
 {
 	struct iris_core *core;
+	u32 codecs_count = 0;
 	int i;
 
 	core = inst->core;
 
-	for (i = 0; i < core->dec_codecs_count; i++) {
+	codecs_count = core->enc_codecs_count + core->dec_codecs_count;
+
+	for (i = 0; i < codecs_count; i++) {
 		if (core->inst_caps[i].codec == inst->codec) {
 			memcpy(&inst->cap[0], &core->inst_caps[i].cap[0],
 			       (INST_CAP_MAX + 1) * sizeof(struct plat_inst_cap));
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index d9d22e2..c84bb51 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -7,6 +7,7 @@
 
 #include "hfi_defines.h"
 #include "iris_core.h"
+#include "iris_ctrls.h"
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_hfi_packet.h"
@@ -273,7 +274,7 @@ int close_session(struct iris_inst *inst)
 	return ret;
 }
 
-static int check_core_mbps_mbpf(struct iris_inst *inst)
+int check_core_mbps_mbpf(struct iris_inst *inst)
 {
 	u32 mbpf = 0, mbps = 0, total_mbpf = 0, total_mbps = 0;
 	struct iris_core *core;
@@ -284,7 +285,9 @@ static int check_core_mbps_mbpf(struct iris_inst *inst)
 
 	mutex_lock(&core->lock);
 	list_for_each_entry(instance, &core->instances, list) {
-		fps = inst->cap[QUEUED_RATE].value >> 16;
+		fps = max3(inst->cap[QUEUED_RATE].value >> 16,
+			   inst->cap[FRAME_RATE].value >> 16,
+			   inst->cap[OPERATING_RATE].value >> 16);
 		mbpf = get_mbpf(inst);
 		mbps = mbpf * fps;
 		total_mbpf += mbpf;
@@ -814,6 +817,88 @@ int session_streamoff(struct iris_inst *inst, u32 plane)
 	return ret;
 }
 
+int process_resume(struct iris_inst *inst)
+{
+	enum iris_inst_sub_state clear_sub_state = IRIS_INST_SUB_NONE;
+	int ret;
+
+	if (inst->sub_state & IRIS_INST_SUB_DRC &&
+	    inst->sub_state & IRIS_INST_SUB_DRC_LAST) {
+		clear_sub_state = IRIS_INST_SUB_DRC | IRIS_INST_SUB_DRC_LAST;
+
+		if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+			ret = iris_hfi_resume(inst, INPUT_MPLANE, HFI_CMD_SETTINGS_CHANGE);
+			if (ret)
+				return ret;
+			clear_sub_state |= IRIS_INST_SUB_INPUT_PAUSE;
+		}
+		if (inst->sub_state & IRIS_INST_SUB_OUTPUT_PAUSE) {
+			ret = iris_hfi_resume(inst, OUTPUT_MPLANE, HFI_CMD_SETTINGS_CHANGE);
+			if (ret)
+				return ret;
+			clear_sub_state |= IRIS_INST_SUB_OUTPUT_PAUSE;
+		}
+	} else if (inst->sub_state & IRIS_INST_SUB_DRAIN &&
+		   inst->sub_state & IRIS_INST_SUB_DRAIN_LAST) {
+		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
+		if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
+			ret = iris_hfi_resume(inst, INPUT_MPLANE, HFI_CMD_DRAIN);
+			if (ret)
+				return ret;
+			clear_sub_state |= IRIS_INST_SUB_INPUT_PAUSE;
+		}
+		if (inst->sub_state & IRIS_INST_SUB_OUTPUT_PAUSE) {
+			ret = iris_hfi_resume(inst, OUTPUT_MPLANE, HFI_CMD_DRAIN);
+			if (ret)
+				return ret;
+			clear_sub_state |= IRIS_INST_SUB_OUTPUT_PAUSE;
+		}
+	}
+
+	ret = iris_inst_change_sub_state(inst, clear_sub_state, 0);
+
+	return ret;
+}
+
+int codec_change(struct iris_inst *inst, u32 v4l2_codec)
+{
+	bool session_init = false;
+	int ret;
+
+	if (!inst->codec)
+		session_init = true;
+
+	if (inst->codec &&
+	    ((inst->domain == DECODER && inst->fmt_src->fmt.pix_mp.pixelformat == v4l2_codec) ||
+	     (inst->domain == ENCODER && inst->fmt_dst->fmt.pix_mp.pixelformat == v4l2_codec)))
+		return 0;
+
+	inst->codec = v4l2_codec_to_driver(inst, v4l2_codec);
+	if (!inst->codec)
+		return -EINVAL;
+
+	if (inst->domain == DECODER)
+		inst->fmt_src->fmt.pix_mp.pixelformat = v4l2_codec;
+	else if (inst->domain == ENCODER)
+		inst->fmt_dst->fmt.pix_mp.pixelformat = v4l2_codec;
+
+	ret = get_inst_capability(inst);
+	if (ret)
+		return ret;
+
+	ret = ctrls_init(inst, session_init);
+	if (ret)
+		return ret;
+
+	ret = update_buffer_count(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = update_buffer_count(inst, OUTPUT_MPLANE);
+
+	return ret;
+}
+
 int iris_pm_get(struct iris_core *core)
 {
 	int ret;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index c628b2e..39cec8c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -41,6 +41,7 @@ enum codec_type v4l2_codec_to_driver(struct iris_inst *inst, u32 v4l2_codec);
 u32 v4l2_colorformat_from_driver(struct iris_inst *inst, enum colorformat_type colorformat);
 enum colorformat_type v4l2_colorformat_to_driver(struct iris_inst *inst, u32 v4l2_colorformat);
 struct vb2_queue *get_vb2q(struct iris_inst *inst, u32 type);
+int check_core_mbps_mbpf(struct iris_inst *inst);
 int check_session_supported(struct iris_inst *inst);
 
 struct iris_buffer *get_driver_buf(struct iris_inst *inst, u32 plane, u32 index);
@@ -51,6 +52,8 @@ int iris_vb2_buffer_done(struct iris_inst *inst,
 int iris_release_nonref_buffers(struct iris_inst *inst);
 void iris_destroy_buffers(struct iris_inst *inst);
 int session_streamoff(struct iris_inst *inst, u32 plane);
+int process_resume(struct iris_inst *inst);
+int codec_change(struct iris_inst *inst, u32 v4l2_codec);
 int iris_pm_get(struct iris_core *core);
 int iris_pm_put(struct iris_core *core, bool autosuspend);
 int iris_pm_get_put(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index 70f4c7d..a1547c5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -8,6 +8,7 @@
 
 #include <media/v4l2-ctrls.h>
 
+#include "hfi_defines.h"
 #include "iris_buffer.h"
 #include "iris_common.h"
 #include "iris_core.h"
@@ -29,6 +30,7 @@
  * @fmt_dst: structure of v4l2_format for destination
  * @ctrl_handler: reference of v4l2 ctrl handler
  * @crop: structure of crop info
+ * @compose: structure of compose info
  * @packet: HFI packet
  * @packet_size: HFI packet size
  * @completions: structure of signal completions
@@ -36,6 +38,7 @@
  * @num_ctrls: supported number of controls
  * @caps_list: list head of capability
  * @codec: codec type
+ * @domain: domain type: encoder or decoder
  * @buffers: structure of buffer info
  * @fw_min_count: minimnum count of buffers needed by fw
  * @state: instance state
@@ -70,6 +73,7 @@ struct iris_inst {
 	struct v4l2_format		*fmt_dst;
 	struct v4l2_ctrl_handler	ctrl_handler;
 	struct rect_desc		crop;
+	struct rect_desc		compose;
 	void				*packet;
 	u32				packet_size;
 	struct completion		completions[MAX_SIGNAL];
@@ -77,6 +81,7 @@ struct iris_inst {
 	u32				num_ctrls;
 	struct list_head		caps_list;
 	enum codec_type			codec;
+	enum domain_type		domain;
 	struct iris_buffers_info	buffers;
 	u32				fw_min_count;
 	enum iris_inst_state		state;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index b487e83..49d2701 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -42,13 +42,13 @@ static int iris_register_video_device(struct iris_core *core, enum domain_type t
 
 	vdev->release = video_device_release;
 	vdev->fops = core->v4l2_file_ops;
-	vdev->ioctl_ops = core->v4l2_ioctl_ops;
 	vdev->vfl_dir = VFL_DIR_M2M;
 	vdev->v4l2_dev = &core->v4l2_dev;
 	vdev->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
 
 	if (type == DECODER) {
 		strscpy(vdev->name, "qcom-iris-decoder", sizeof(vdev->name));
+		vdev->ioctl_ops = core->v4l2_ioctl_ops_dec;
 
 		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 		if (ret)
@@ -57,6 +57,7 @@ static int iris_register_video_device(struct iris_core *core, enum domain_type t
 		core->vdev_dec = vdev;
 	} else if (type == ENCODER) {
 		strscpy(vdev->name, "qcom-iris-encoder", sizeof(vdev->name));
+		vdev->ioctl_ops = core->v4l2_ioctl_ops_enc;
 
 		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 		if (ret)
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
index 952ba2a..e853aec 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
@@ -198,8 +198,9 @@ bool allow_s_ctrl(struct iris_inst *inst, u32 cap_id)
 {
 	return ((inst->state == IRIS_INST_OPEN) ||
 		((inst->cap[cap_id].flags & CAP_FLAG_DYNAMIC_ALLOWED) &&
-		(inst->state == IRIS_INST_INPUT_STREAMING ||
-		inst->state == IRIS_INST_STREAMING)));
+		 ((inst->state == IRIS_INST_INPUT_STREAMING && inst->domain == DECODER) ||
+		  (inst->state == IRIS_INST_OUTPUT_STREAMING && inst->domain == ENCODER) ||
+		  (inst->state == IRIS_INST_STREAMING))));
 }
 
 int iris_inst_state_change_streamon(struct iris_inst *inst, u32 plane)
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 371615e..300d0e9 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -22,39 +22,6 @@ struct vdec_prop_type_handle {
 	int (*handle)(struct iris_inst *inst);
 };
 
-static int vdec_codec_change(struct iris_inst *inst, u32 v4l2_codec)
-{
-	bool session_init = false;
-	int ret;
-
-	if (!inst->codec)
-		session_init = true;
-
-	if (inst->codec && inst->fmt_src->fmt.pix_mp.pixelformat == v4l2_codec)
-		return 0;
-
-	inst->codec = v4l2_codec_to_driver(inst, v4l2_codec);
-	if (!inst->codec)
-		return -EINVAL;
-
-	inst->fmt_src->fmt.pix_mp.pixelformat = v4l2_codec;
-	ret = get_inst_capability(inst);
-	if (ret)
-		return ret;
-
-	ret = ctrls_init(inst, session_init);
-	if (ret)
-		return ret;
-
-	ret = update_buffer_count(inst, INPUT_MPLANE);
-	if (ret)
-		return ret;
-
-	ret = update_buffer_count(inst, OUTPUT_MPLANE);
-
-	return ret;
-}
-
 int vdec_inst_init(struct iris_inst *inst)
 {
 	struct v4l2_format *f;
@@ -93,7 +60,7 @@ int vdec_inst_init(struct iris_inst *inst)
 	inst->buffers.output.size = f->fmt.pix_mp.plane_fmt[0].sizeimage;
 	inst->fw_min_count = 0;
 
-	ret = vdec_codec_change(inst, inst->fmt_src->fmt.pix_mp.pixelformat);
+	ret = codec_change(inst, inst->fmt_src->fmt.pix_mp.pixelformat);
 
 	return ret;
 }
@@ -233,7 +200,7 @@ int vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f)
 	if (f->type == INPUT_MPLANE) {
 		if (inst->fmt_src->fmt.pix_mp.pixelformat !=
 			f->fmt.pix_mp.pixelformat) {
-			ret = vdec_codec_change(inst, f->fmt.pix_mp.pixelformat);
+			ret = codec_change(inst, f->fmt.pix_mp.pixelformat);
 			if (ret)
 				return ret;
 		}
@@ -1304,49 +1271,6 @@ int vdec_qbuf(struct iris_inst *inst, struct vb2_buffer *vb2)
 	return ret;
 }
 
-static int process_resume(struct iris_inst *inst)
-{
-	enum iris_inst_sub_state clear_sub_state = IRIS_INST_SUB_NONE;
-	int ret;
-
-	if (inst->sub_state & IRIS_INST_SUB_DRC &&
-	    inst->sub_state & IRIS_INST_SUB_DRC_LAST) {
-		clear_sub_state = IRIS_INST_SUB_DRC | IRIS_INST_SUB_DRC_LAST;
-
-		if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
-			ret = iris_hfi_resume(inst, INPUT_MPLANE, HFI_CMD_SETTINGS_CHANGE);
-			if (ret)
-				return ret;
-			clear_sub_state |= IRIS_INST_SUB_INPUT_PAUSE;
-		}
-		if (inst->sub_state & IRIS_INST_SUB_OUTPUT_PAUSE) {
-			ret = iris_hfi_resume(inst, OUTPUT_MPLANE, HFI_CMD_SETTINGS_CHANGE);
-			if (ret)
-				return ret;
-			clear_sub_state |= IRIS_INST_SUB_OUTPUT_PAUSE;
-		}
-	} else if (inst->sub_state & IRIS_INST_SUB_DRAIN &&
-			   inst->sub_state & IRIS_INST_SUB_DRAIN_LAST) {
-		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
-		if (inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
-			ret = iris_hfi_resume(inst, INPUT_MPLANE, HFI_CMD_DRAIN);
-			if (ret)
-				return ret;
-			clear_sub_state |= IRIS_INST_SUB_INPUT_PAUSE;
-		}
-		if (inst->sub_state & IRIS_INST_SUB_OUTPUT_PAUSE) {
-			ret = iris_hfi_resume(inst, OUTPUT_MPLANE, HFI_CMD_DRAIN);
-			if (ret)
-				return ret;
-			clear_sub_state |= IRIS_INST_SUB_OUTPUT_PAUSE;
-		}
-	}
-
-	ret = iris_inst_change_sub_state(inst, clear_sub_state, 0);
-
-	return ret;
-}
-
 int vdec_start_cmd(struct iris_inst *inst)
 {
 	int ret;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_venc.c b/drivers/media/platform/qcom/vcodec/iris/iris_venc.c
new file mode 100644
index 0000000..802db40
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_venc.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "hfi_defines.h"
+#include "iris_buffer.h"
+#include "iris_common.h"
+#include "iris_ctrls.h"
+#include "iris_helpers.h"
+#include "iris_hfi.h"
+#include "iris_hfi_packet.h"
+#include "iris_power.h"
+#include "iris_venc.h"
+
+int venc_inst_init(struct iris_inst *inst)
+{
+	struct v4l2_format *f;
+	int ret;
+
+	inst->fmt_src = kzalloc(sizeof(*inst->fmt_src), GFP_KERNEL);
+	if (!inst->fmt_src)
+		return -ENOMEM;
+
+	inst->fmt_dst  = kzalloc(sizeof(*inst->fmt_dst), GFP_KERNEL);
+	if (!inst->fmt_dst)
+		return -ENOMEM;
+
+	inst->vb2q_src = kzalloc(sizeof(*inst->vb2q_src), GFP_KERNEL);
+	if (!inst->vb2q_src)
+		return -ENOMEM;
+
+	inst->vb2q_dst = kzalloc(sizeof(*inst->vb2q_dst), GFP_KERNEL);
+	if (!inst->vb2q_dst)
+		return -ENOMEM;
+
+	f = inst->fmt_dst;
+	f->type = OUTPUT_MPLANE;
+	f->fmt.pix_mp.width = DEFAULT_WIDTH;
+	f->fmt.pix_mp.height = DEFAULT_HEIGHT;
+	f->fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
+	f->fmt.pix_mp.num_planes = 1;
+	f->fmt.pix_mp.plane_fmt[0].bytesperline = 0;
+	f->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_OUTPUT);
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_DEFAULT;
+	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
+	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+	inst->buffers.output.min_count = iris_get_buf_min_count(inst, BUF_OUTPUT);
+	inst->buffers.output.actual_count = inst->buffers.output.min_count;
+	inst->buffers.output.size = f->fmt.pix_mp.plane_fmt[0].sizeimage;
+
+	inst->crop.left = 0;
+	inst->crop.top = 0;
+	inst->crop.width = f->fmt.pix_mp.width;
+	inst->crop.height = f->fmt.pix_mp.height;
+
+	inst->compose.left = 0;
+	inst->compose.top = 0;
+	inst->compose.width = f->fmt.pix_mp.width;
+	inst->compose.height = f->fmt.pix_mp.height;
+
+	f = inst->fmt_src;
+	f->type = INPUT_MPLANE;
+	f->fmt.pix_mp.pixelformat = V4L2_PIX_FMT_QC08C;
+	f->fmt.pix_mp.width = DEFAULT_WIDTH;
+	f->fmt.pix_mp.height = DEFAULT_HEIGHT;
+	f->fmt.pix_mp.num_planes = 1;
+	f->fmt.pix_mp.plane_fmt[0].bytesperline = ALIGN(DEFAULT_WIDTH, 128);
+	f->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_INPUT);
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_DEFAULT;
+	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
+	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+	inst->buffers.input.min_count = iris_get_buf_min_count(inst, BUF_INPUT);
+	inst->buffers.input.actual_count = inst->buffers.input.min_count;
+	inst->buffers.input.size = f->fmt.pix_mp.plane_fmt[0].sizeimage;
+
+	inst->hfi_rc_type = HFI_RC_VBR_CFR;
+	inst->hfi_layer_type = HFI_HIER_P_SLIDING_WINDOW;
+
+	ret = codec_change(inst, inst->fmt_dst->fmt.pix_mp.pixelformat);
+
+	return ret;
+}
+
+void venc_inst_deinit(struct iris_inst *inst)
+{
+	kfree(inst->fmt_dst);
+	kfree(inst->fmt_src);
+}
+
+int venc_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f)
+{
+	struct iris_core *core;
+	u32 array[32] = {0};
+	u32 i = 0;
+
+	core = inst->core;
+
+	if (f->type == OUTPUT_MPLANE) {
+		u32 codecs = core->cap[ENC_CODECS].value;
+		u32 idx = 0;
+
+		for (i = 0; i <= 31; i++) {
+			if (codecs & BIT(i)) {
+				if (idx >= ARRAY_SIZE(array))
+					break;
+				array[idx] = codecs & BIT(i);
+				idx++;
+			}
+		}
+		if (!array[f->index])
+			return -EINVAL;
+		f->pixelformat = v4l2_codec_from_driver(inst, array[f->index]);
+		if (!f->pixelformat)
+			return -EINVAL;
+		f->flags = V4L2_FMT_FLAG_COMPRESSED;
+		strscpy(f->description, "codec", sizeof(f->description));
+	} else if (f->type == INPUT_MPLANE) {
+		u32 formats = inst->cap[PIX_FMTS].step_or_mask;
+		u32 idx = 0;
+
+		for (i = 0; i <= 31; i++) {
+			if (formats & BIT(i)) {
+				if (idx >= ARRAY_SIZE(array))
+					break;
+				array[idx] = formats & BIT(i);
+				idx++;
+			}
+		}
+		if (!array[f->index])
+			return -EINVAL;
+		f->pixelformat = v4l2_colorformat_from_driver(inst, array[f->index]);
+		if (!f->pixelformat)
+			return -EINVAL;
+		strscpy(f->description, "colorformat", sizeof(f->description));
+	}
+
+	memset(f->reserved, 0, sizeof(f->reserved));
+
+	return 0;
+}
+
+int venc_try_fmt(struct iris_inst *inst, struct v4l2_format *f)
+{
+	struct v4l2_pix_format_mplane *pixmp = &f->fmt.pix_mp;
+	u32 pix_fmt;
+
+	memset(pixmp->reserved, 0, sizeof(pixmp->reserved));
+
+	if (f->type == INPUT_MPLANE) {
+		pix_fmt = v4l2_colorformat_to_driver(inst, f->fmt.pix_mp.pixelformat);
+		if (!pix_fmt) {
+			f->fmt.pix_mp.pixelformat = inst->fmt_src->fmt.pix_mp.pixelformat;
+			f->fmt.pix_mp.width = inst->fmt_src->fmt.pix_mp.width;
+			f->fmt.pix_mp.height = inst->fmt_src->fmt.pix_mp.height;
+		}
+	} else if (f->type == OUTPUT_MPLANE) {
+		pix_fmt = v4l2_codec_to_driver(inst, f->fmt.pix_mp.pixelformat);
+		if (!pix_fmt) {
+			f->fmt.pix_mp.width = inst->fmt_dst->fmt.pix_mp.width;
+			f->fmt.pix_mp.height = inst->fmt_dst->fmt.pix_mp.height;
+			f->fmt.pix_mp.pixelformat = inst->fmt_dst->fmt.pix_mp.pixelformat;
+		}
+	} else {
+		return -EINVAL;
+	}
+
+	if (pixmp->field == V4L2_FIELD_ANY)
+		pixmp->field = V4L2_FIELD_NONE;
+	pixmp->num_planes = 1;
+
+	return 0;
+}
+
+static int venc_s_fmt_output(struct iris_inst *inst, struct v4l2_format *f)
+{
+	struct v4l2_format *fmt;
+	enum codec_type codec;
+	u32 codec_align;
+	u32 width, height;
+	int ret = 0;
+
+	venc_try_fmt(inst, f);
+
+	fmt = inst->fmt_dst;
+	if (fmt->fmt.pix_mp.pixelformat != f->fmt.pix_mp.pixelformat) {
+		ret = codec_change(inst, f->fmt.pix_mp.pixelformat);
+		if (ret)
+			return ret;
+	}
+	fmt->type = OUTPUT_MPLANE;
+
+	codec = v4l2_codec_to_driver(inst, f->fmt.pix_mp.pixelformat);
+
+	codec_align = (codec == HEVC) ? 32 : 16;
+	width = inst->compose.width;
+	height = inst->compose.height;
+	if (inst->cap[ROTATION].value == 90 || inst->cap[ROTATION].value == 270) {
+		width = inst->compose.height;
+		height = inst->compose.width;
+	}
+	fmt->fmt.pix_mp.width = ALIGN(width, codec_align);
+	fmt->fmt.pix_mp.height = ALIGN(height, codec_align);
+	fmt->fmt.pix_mp.num_planes = 1;
+	fmt->fmt.pix_mp.plane_fmt[0].bytesperline = 0;
+	fmt->fmt.pix_mp.plane_fmt[0].sizeimage =
+		iris_get_buffer_size(inst, BUF_OUTPUT);
+	if (f->fmt.pix_mp.colorspace != V4L2_COLORSPACE_DEFAULT &&
+	    f->fmt.pix_mp.colorspace != V4L2_COLORSPACE_REC709)
+		f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_DEFAULT;
+	fmt->fmt.pix_mp.colorspace = f->fmt.pix_mp.colorspace;
+	fmt->fmt.pix_mp.xfer_func = f->fmt.pix_mp.xfer_func;
+	fmt->fmt.pix_mp.ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
+	fmt->fmt.pix_mp.quantization = f->fmt.pix_mp.quantization;
+	inst->buffers.output.min_count = iris_get_buf_min_count(inst, BUF_OUTPUT);
+	if (inst->buffers.output.actual_count <
+		inst->buffers.output.min_count) {
+		inst->buffers.output.actual_count =
+			inst->buffers.output.min_count;
+	}
+	inst->buffers.output.size =
+		fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
+
+	memcpy(f, fmt, sizeof(struct v4l2_format));
+
+	return ret;
+}
+
+static int venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
+{
+	u32 pix_fmt, width, height, size, bytesperline;
+	struct v4l2_format *fmt, *output_fmt;
+	int ret = 0;
+
+	venc_try_fmt(inst, f);
+
+	pix_fmt = v4l2_colorformat_to_driver(inst, f->fmt.pix_mp.pixelformat);
+	inst->cap[PIX_FMTS].value = pix_fmt;
+
+	width = f->fmt.pix_mp.width;
+	height = f->fmt.pix_mp.height;
+
+	bytesperline = pix_fmt == FMT_TP10C ?
+		ALIGN(ALIGN(f->fmt.pix_mp.width, 192) * 4 / 3, 256) :
+		ALIGN(f->fmt.pix_mp.width, 128);
+
+	fmt = inst->fmt_src;
+	fmt->type = INPUT_MPLANE;
+	fmt->fmt.pix_mp.width = width;
+	fmt->fmt.pix_mp.height = height;
+	fmt->fmt.pix_mp.num_planes = 1;
+	fmt->fmt.pix_mp.pixelformat = f->fmt.pix_mp.pixelformat;
+	fmt->fmt.pix_mp.plane_fmt[0].bytesperline = bytesperline;
+	size = iris_get_buffer_size(inst, BUF_INPUT);
+	fmt->fmt.pix_mp.plane_fmt[0].sizeimage = size;
+	fmt->fmt.pix_mp.colorspace = f->fmt.pix_mp.colorspace;
+	fmt->fmt.pix_mp.xfer_func = f->fmt.pix_mp.xfer_func;
+	fmt->fmt.pix_mp.ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
+	fmt->fmt.pix_mp.quantization = f->fmt.pix_mp.quantization;
+
+	output_fmt = inst->fmt_dst;
+	output_fmt->fmt.pix_mp.colorspace = fmt->fmt.pix_mp.colorspace;
+	output_fmt->fmt.pix_mp.xfer_func = fmt->fmt.pix_mp.xfer_func;
+	output_fmt->fmt.pix_mp.ycbcr_enc = fmt->fmt.pix_mp.ycbcr_enc;
+	output_fmt->fmt.pix_mp.quantization = fmt->fmt.pix_mp.quantization;
+
+	inst->buffers.input.min_count = iris_get_buf_min_count(inst, BUF_INPUT);
+	if (inst->buffers.input.actual_count <
+	    inst->buffers.input.min_count) {
+		inst->buffers.input.actual_count =
+			inst->buffers.input.min_count;
+	}
+	inst->buffers.input.size = size;
+
+	if (f->fmt.pix_mp.width != inst->crop.width ||
+	    f->fmt.pix_mp.height != inst->crop.height) {
+		inst->crop.top = 0;
+		inst->crop.left = 0;
+		inst->crop.width = f->fmt.pix_mp.width;
+		inst->crop.height = f->fmt.pix_mp.height;
+
+		inst->compose.top = 0;
+		inst->compose.left = 0;
+		inst->compose.width = f->fmt.pix_mp.width;
+		inst->compose.height = f->fmt.pix_mp.height;
+
+		ret = venc_s_fmt_output(inst, output_fmt);
+		if (ret)
+			return ret;
+	}
+
+	memcpy(f, fmt, sizeof(struct v4l2_format));
+
+	return ret;
+}
+
+int venc_s_fmt(struct iris_inst *inst, struct v4l2_format *f)
+{
+	int ret;
+
+	if (f->type == INPUT_MPLANE)
+		ret = venc_s_fmt_input(inst, f);
+	else if (f->type == OUTPUT_MPLANE)
+		ret = venc_s_fmt_output(inst, f);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+
+int venc_s_selection(struct iris_inst *inst, struct v4l2_selection *s)
+{
+	struct v4l2_format *output_fmt;
+	int ret;
+
+	if (s->type != INPUT_MPLANE && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
+		return -EINVAL;
+
+	switch (s->target) {
+	case V4L2_SEL_TGT_CROP:
+		if (s->r.left || s->r.top) {
+			s->r.left = 0;
+			s->r.top = 0;
+		}
+		if (s->r.width > inst->fmt_src->fmt.pix_mp.width)
+			s->r.width = inst->fmt_src->fmt.pix_mp.width;
+
+		if (s->r.height > inst->fmt_src->fmt.pix_mp.height)
+			s->r.height = inst->fmt_src->fmt.pix_mp.height;
+
+		inst->crop.left = s->r.left;
+		inst->crop.top = s->r.top;
+		inst->crop.width = s->r.width;
+		inst->crop.height = s->r.height;
+		inst->compose.left = inst->crop.left;
+		inst->compose.top = inst->crop.top;
+		inst->compose.width = inst->crop.width;
+		inst->compose.height = inst->crop.height;
+		output_fmt = inst->fmt_dst;
+		ret = venc_s_fmt_output(inst, output_fmt);
+		if (ret)
+			return ret;
+		break;
+	case V4L2_SEL_TGT_COMPOSE:
+		if (s->r.left < inst->crop.left)
+			s->r.left = inst->crop.left;
+
+		if (s->r.top < inst->crop.top)
+			s->r.top = inst->crop.top;
+
+		if (s->r.width > inst->crop.width)
+			s->r.width = inst->crop.width;
+
+		if (s->r.height > inst->crop.height)
+			s->r.height = inst->crop.height;
+		inst->compose.left = s->r.left;
+		inst->compose.top = s->r.top;
+		inst->compose.width = s->r.width;
+		inst->compose.height = s->r.height;
+
+		output_fmt = inst->fmt_dst;
+		ret = venc_s_fmt_output(inst, output_fmt);
+		if (ret)
+			return ret;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+int venc_s_param(struct iris_inst *inst, struct v4l2_streamparm *s_parm)
+{
+	struct v4l2_fract *timeperframe = NULL;
+	u32 q16_rate, max_rate, default_rate;
+	u64 us_per_frame = 0, input_rate = 0;
+	bool is_frame_rate = false;
+	int ret = 0;
+
+	if (s_parm->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		timeperframe = &s_parm->parm.output.timeperframe;
+		max_rate = inst->cap[OPERATING_RATE].max >> 16;
+		default_rate = inst->cap[OPERATING_RATE].value >> 16;
+		s_parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	} else {
+		timeperframe = &s_parm->parm.capture.timeperframe;
+		is_frame_rate = true;
+		max_rate = inst->cap[FRAME_RATE].max >> 16;
+		default_rate = inst->cap[FRAME_RATE].value >> 16;
+		s_parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	}
+
+	if (!timeperframe->denominator || !timeperframe->numerator) {
+		if (!timeperframe->numerator)
+			timeperframe->numerator = 1;
+		if (!timeperframe->denominator)
+			timeperframe->denominator = default_rate;
+	}
+
+	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
+	us_per_frame = div64_u64(us_per_frame, timeperframe->denominator);
+
+	if (!us_per_frame) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	input_rate = (u64)USEC_PER_SEC;
+	input_rate = div64_u64(input_rate, us_per_frame);
+
+	q16_rate = (u32)input_rate << 16;
+	if (is_frame_rate)
+		inst->cap[FRAME_RATE].value = q16_rate;
+	else
+		inst->cap[OPERATING_RATE].value = q16_rate;
+
+	if ((s_parm->type == INPUT_MPLANE && inst->vb2q_src->streaming) ||
+	    (s_parm->type == OUTPUT_MPLANE && inst->vb2q_dst->streaming)) {
+		ret = check_core_mbps_mbpf(inst);
+		if (ret)
+			goto reset_rate;
+		ret = input_rate > max_rate;
+		if (ret) {
+			ret = -ENOMEM;
+			goto reset_rate;
+		}
+	}
+
+	if (is_frame_rate)
+		inst->cap[FRAME_RATE].flags |= CAP_FLAG_CLIENT_SET;
+	else
+		inst->cap[OPERATING_RATE].flags |= CAP_FLAG_CLIENT_SET;
+
+	if (inst->vb2q_dst->streaming) {
+		ret = iris_hfi_set_property(inst,
+					    HFI_PROP_FRAME_RATE,
+					    HFI_HOST_FLAGS_NONE,
+					    HFI_PORT_BITSTREAM,
+					    HFI_PAYLOAD_Q16,
+					    &q16_rate,
+					    sizeof(u32));
+		if (ret)
+			goto exit;
+	}
+
+	return ret;
+
+reset_rate:
+	if (ret) {
+		if (is_frame_rate)
+			inst->cap[FRAME_RATE].value = default_rate << 16;
+		else
+			inst->cap[OPERATING_RATE].value = default_rate << 16;
+	}
+exit:
+	return ret;
+}
+
+int venc_g_param(struct iris_inst *inst, struct v4l2_streamparm *s_parm)
+{
+	struct v4l2_fract *timeperframe = NULL;
+
+	if (s_parm->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		timeperframe = &s_parm->parm.output.timeperframe;
+		timeperframe->numerator = 1;
+		timeperframe->denominator =
+			inst->cap[OPERATING_RATE].value >> 16;
+		s_parm->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	} else {
+		timeperframe = &s_parm->parm.capture.timeperframe;
+		timeperframe->numerator = 1;
+		timeperframe->denominator =
+			inst->cap[FRAME_RATE].value >> 16;
+		s_parm->parm.capture.capability = V4L2_CAP_TIMEPERFRAME;
+	}
+
+	return 0;
+}
+
+int venc_subscribe_event(struct iris_inst *inst,
+			 const struct v4l2_event_subscription *sub)
+{
+	int ret;
+
+	switch (sub->type) {
+	case V4L2_EVENT_EOS:
+		ret = v4l2_event_subscribe(&inst->fh, sub, MAX_EVENTS, NULL);
+		break;
+	case V4L2_EVENT_CTRL:
+		ret = v4l2_ctrl_subscribe_event(&inst->fh, sub);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+int venc_start_cmd(struct iris_inst *inst)
+{
+	vb2_clear_last_buffer_dequeued(inst->vb2q_dst);
+
+	return process_resume(inst);
+}
+
+int venc_stop_cmd(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = iris_hfi_drain(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = iris_inst_change_sub_state(inst, 0, IRIS_INST_SUB_DRAIN);
+
+	iris_scale_power(inst);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_venc.h b/drivers/media/platform/qcom/vcodec/iris/iris_venc.h
new file mode 100644
index 0000000..24da63f
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_venc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_VENC_H_
+#define _IRIS_VENC_H_
+
+#include "iris_instance.h"
+
+int venc_inst_init(struct iris_inst *inst);
+void venc_inst_deinit(struct iris_inst *inst);
+int venc_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f);
+int venc_try_fmt(struct iris_inst *inst, struct v4l2_format *f);
+int venc_s_fmt(struct iris_inst *inst, struct v4l2_format *f);
+int venc_s_selection(struct iris_inst *inst, struct v4l2_selection *s);
+int venc_s_param(struct iris_inst *inst, struct v4l2_streamparm *s_parm);
+int venc_g_param(struct iris_inst *inst, struct v4l2_streamparm *s_parm);
+int venc_subscribe_event(struct iris_inst *inst,
+			 const struct v4l2_event_subscription *sub);
+int venc_start_cmd(struct iris_inst *inst);
+int venc_stop_cmd(struct iris_inst *inst);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index 437d6b4..aa19978 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -15,6 +15,7 @@
 #include "iris_instance.h"
 #include "iris_power.h"
 #include "iris_vdec.h"
+#include "iris_venc.h"
 #include "iris_vidc.h"
 #include "iris_vb2.h"
 
@@ -30,7 +31,11 @@ static int vidc_v4l2_fh_init(struct iris_inst *inst)
 	if (inst->fh.vdev)
 		return -EINVAL;
 
-	v4l2_fh_init(&inst->fh, core->vdev_dec);
+	if (inst->domain == ENCODER)
+		v4l2_fh_init(&inst->fh, core->vdev_enc);
+	else if (inst->domain == DECODER)
+		v4l2_fh_init(&inst->fh, core->vdev_dec);
+
 	inst->fh.ctrl_handler = &inst->ctrl_handler;
 	v4l2_fh_add(&inst->fh);
 
@@ -160,9 +165,20 @@ int vidc_open(struct file *filp)
 {
 	struct iris_core *core = video_drvdata(filp);
 	struct iris_inst *inst = NULL;
+	struct video_device *vdev;
+	u32 session_type = 0;
 	int i = 0;
 	int ret;
 
+	vdev = video_devdata(filp);
+	if (strcmp(vdev->name, "qcom-iris-decoder") == 0)
+		session_type = DECODER;
+	else if (strcmp(vdev->name, "qcom-iris-encoder") == 0)
+		session_type = ENCODER;
+
+	if (session_type != DECODER && session_type != ENCODER)
+		return -EINVAL;
+
 	ret = iris_pm_get(core);
 	if (ret)
 		return ret;
@@ -182,6 +198,7 @@ int vidc_open(struct file *filp)
 	}
 
 	inst->core = core;
+	inst->domain = session_type;
 	inst->session_id = hash32_ptr(inst);
 	inst->ipsc_properties_set = false;
 	inst->opsc_properties_set = false;
@@ -213,7 +230,12 @@ int vidc_open(struct file *filp)
 	if (ret)
 		goto fail_remove_session;
 
-	vdec_inst_init(inst);
+	if (inst->domain == DECODER)
+		ret = vdec_inst_init(inst);
+	else if (inst->domain == ENCODER)
+		ret = venc_inst_init(inst);
+	if (ret)
+		goto fail_fh_deinit;
 
 	ret = vidc_vb2_queue_init(inst);
 	if (ret)
@@ -238,7 +260,11 @@ int vidc_open(struct file *filp)
 	iris_core_deinit(core);
 	vidc_vb2_queue_deinit(inst);
 fail_inst_deinit:
-	vdec_inst_deinit(inst);
+	if (inst->domain == DECODER)
+		vdec_inst_deinit(inst);
+	else if (inst->domain == ENCODER)
+		venc_inst_deinit(inst);
+fail_fh_deinit:
 	vidc_v4l2_fh_deinit(inst);
 fail_remove_session:
 	vidc_remove_session(inst);
@@ -264,7 +290,11 @@ int vidc_close(struct file *filp)
 	core = inst->core;
 
 	v4l2_ctrl_handler_free(&inst->ctrl_handler);
-	vdec_inst_deinit(inst);
+	if (inst->domain == DECODER)
+		vdec_inst_deinit(inst);
+	else if (inst->domain == ENCODER)
+		venc_inst_deinit(inst);
+
 	mutex_lock(&inst->lock);
 	iris_pm_get(core);
 	close_session(inst);
@@ -342,7 +372,7 @@ static __poll_t vidc_poll(struct file *filp, struct poll_table_struct *pt)
 static int vidc_enum_fmt(struct file *filp, void *fh, struct v4l2_fmtdesc *f)
 {
 	struct iris_inst *inst;
-	int ret;
+	int ret = 0;
 
 	inst = get_vidc_inst(filp, fh);
 	if (!inst)
@@ -354,7 +384,10 @@ static int vidc_enum_fmt(struct file *filp, void *fh, struct v4l2_fmtdesc *f)
 		goto unlock;
 	}
 
-	ret = vdec_enum_fmt(inst, f);
+	if (inst->domain == DECODER)
+		ret = vdec_enum_fmt(inst, f);
+	else if (inst->domain == ENCODER)
+		ret = venc_enum_fmt(inst, f);
 
 unlock:
 	mutex_unlock(&inst->lock);
@@ -365,7 +398,7 @@ static int vidc_enum_fmt(struct file *filp, void *fh, struct v4l2_fmtdesc *f)
 static int vidc_try_fmt(struct file *filp, void *fh, struct v4l2_format *f)
 {
 	struct iris_inst *inst;
-	int ret;
+	int ret = 0;
 
 	inst = get_vidc_inst(filp, fh);
 	if (!inst)
@@ -382,7 +415,10 @@ static int vidc_try_fmt(struct file *filp, void *fh, struct v4l2_format *f)
 		goto unlock;
 	}
 
-	ret = vdec_try_fmt(inst, f);
+	if (inst->domain == DECODER)
+		ret = vdec_try_fmt(inst, f);
+	else if (inst->domain == ENCODER)
+		ret = venc_try_fmt(inst, f);
 
 unlock:
 	mutex_unlock(&inst->lock);
@@ -393,7 +429,7 @@ static int vidc_try_fmt(struct file *filp, void *fh, struct v4l2_format *f)
 static int vidc_s_fmt(struct file *filp, void *fh, struct v4l2_format *f)
 {
 	struct iris_inst *inst;
-	int ret;
+	int ret = 0;
 
 	inst = get_vidc_inst(filp, fh);
 	if (!inst)
@@ -410,7 +446,10 @@ static int vidc_s_fmt(struct file *filp, void *fh, struct v4l2_format *f)
 		goto unlock;
 	}
 
-	ret = vdec_s_fmt(inst, f);
+	if (inst->domain == DECODER)
+		ret = vdec_s_fmt(inst, f);
+	else if (inst->domain == ENCODER)
+		ret = venc_s_fmt(inst, f);
 
 unlock:
 	mutex_unlock(&inst->lock);
@@ -488,6 +527,70 @@ static int vidc_enum_framesizes(struct file *filp, void *fh,
 	return ret;
 }
 
+static int vidc_enum_frameintervals(struct file *filp, void *fh,
+				    struct v4l2_frmivalenum *fival)
+
+{
+	enum colorformat_type colorfmt;
+	struct iris_inst *inst;
+	struct iris_core *core;
+	u32 fps, mbpf;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !fival)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (inst->domain == DECODER) {
+		ret = -ENOTTY;
+		goto unlock;
+	}
+
+	core = inst->core;
+
+	if (fival->index) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	colorfmt = v4l2_colorformat_to_driver(inst, fival->pixel_format);
+	if (colorfmt == FMT_NONE) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (fival->width > inst->cap[FRAME_WIDTH].max ||
+	    fival->width < inst->cap[FRAME_WIDTH].min ||
+	    fival->height > inst->cap[FRAME_HEIGHT].max ||
+	    fival->height < inst->cap[FRAME_HEIGHT].min) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	mbpf = NUM_MBS_PER_FRAME(fival->height, fival->width);
+	fps = core->cap[MAX_MBPS].value / mbpf;
+
+	fival->type = V4L2_FRMIVAL_TYPE_STEPWISE;
+	fival->stepwise.min.numerator = 1;
+	fival->stepwise.min.denominator =
+			min_t(u32, fps, inst->cap[FRAME_RATE].max);
+	fival->stepwise.max.numerator = 1;
+	fival->stepwise.max.denominator = 1;
+	fival->stepwise.step.numerator = 1;
+	fival->stepwise.step.denominator = inst->cap[FRAME_RATE].max;
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
 static int vidc_reqbufs(struct file *filp, void *fh, struct v4l2_requestbuffers *b)
 {
 	struct vb2_queue *vb2q = NULL;
@@ -751,7 +854,11 @@ static int vidc_querycap(struct file *filp, void *fh, struct v4l2_capability *ca
 	strscpy(cap->driver, VIDC_DRV_NAME, sizeof(cap->driver));
 	strscpy(cap->bus_info, VIDC_BUS_NAME, sizeof(cap->bus_info));
 	memset(cap->reserved, 0, sizeof(cap->reserved));
-	strscpy(cap->card, "iris_decoder", sizeof(cap->card));
+
+	if (inst->domain == DECODER)
+		strscpy(cap->card, "iris_decoder", sizeof(cap->card));
+	else if (inst->domain == ENCODER)
+		strscpy(cap->card, "iris_encoder", sizeof(cap->card));
 
 unlock:
 	mutex_unlock(&inst->lock);
@@ -839,7 +946,7 @@ static int vidc_querymenu(struct file *filp, void *fh, struct v4l2_querymenu *qm
 static int vidc_subscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subscription *sub)
 {
 	struct iris_inst *inst;
-	int ret;
+	int ret = 0;
 
 	inst = container_of(fh, struct iris_inst, fh);
 
@@ -849,7 +956,10 @@ static int vidc_subscribe_event(struct v4l2_fh *fh, const struct v4l2_event_subs
 		goto unlock;
 	}
 
-	ret = vdec_subscribe_event(inst, sub);
+	if (inst->domain == DECODER)
+		ret = vdec_subscribe_event(inst, sub);
+	else if (inst->domain == ENCODER)
+		ret = venc_subscribe_event(inst, sub);
 
 unlock:
 	mutex_unlock(&inst->lock);
@@ -893,28 +1003,152 @@ static int vidc_g_selection(struct file *filp, void *fh, struct v4l2_selection *
 		goto unlock;
 	}
 
-	if (s->type != OUTPUT_MPLANE && s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE) {
+	if (s->type != OUTPUT_MPLANE && s->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
+	    inst->domain == DECODER) {
 		ret = -EINVAL;
 		goto unlock;
 	}
 
-	switch (s->target) {
-	case V4L2_SEL_TGT_CROP_BOUNDS:
-	case V4L2_SEL_TGT_CROP_DEFAULT:
-	case V4L2_SEL_TGT_CROP:
-	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
-	case V4L2_SEL_TGT_COMPOSE_PADDED:
-	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
-	case V4L2_SEL_TGT_COMPOSE:
-		s->r.left = inst->crop.left;
-		s->r.top = inst->crop.top;
-		s->r.width = inst->crop.width;
-		s->r.height = inst->crop.height;
-		break;
-	default:
+	if (s->type != INPUT_MPLANE && s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
+	    inst->domain == ENCODER) {
 		ret = -EINVAL;
+		goto unlock;
 	}
 
+	if (inst->domain == DECODER) {
+		switch (s->target) {
+		case V4L2_SEL_TGT_CROP_BOUNDS:
+		case V4L2_SEL_TGT_CROP_DEFAULT:
+		case V4L2_SEL_TGT_CROP:
+		case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+		case V4L2_SEL_TGT_COMPOSE_PADDED:
+		case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+		case V4L2_SEL_TGT_COMPOSE:
+			s->r.left = inst->crop.left;
+			s->r.top = inst->crop.top;
+			s->r.width = inst->crop.width;
+			s->r.height = inst->crop.height;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+	} else if (inst->domain == ENCODER) {
+		switch (s->target) {
+		case V4L2_SEL_TGT_CROP_BOUNDS:
+		case V4L2_SEL_TGT_CROP_DEFAULT:
+		case V4L2_SEL_TGT_CROP:
+			s->r.left = inst->crop.left;
+			s->r.top = inst->crop.top;
+			s->r.width = inst->crop.width;
+			s->r.height = inst->crop.height;
+			break;
+		case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+		case V4L2_SEL_TGT_COMPOSE_PADDED:
+		case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+		case V4L2_SEL_TGT_COMPOSE:
+			s->r.left = inst->compose.left;
+			s->r.top = inst->compose.top;
+			s->r.width = inst->compose.width;
+			s->r.height = inst->compose.height;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+	}
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_s_selection(struct file *filp, void *fh, struct v4l2_selection *s)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !s)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+	if (inst->domain == DECODER) {
+		ret = -EINVAL;
+		goto unlock;
+	} else if (inst->domain == ENCODER) {
+		ret = venc_s_selection(inst, s);
+	}
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_s_parm(struct file *filp, void *fh, struct v4l2_streamparm *a)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !a)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
+	    a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (inst->domain == ENCODER)
+		ret = venc_s_param(inst, a);
+	else
+		ret = -EINVAL;
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
+static int vidc_g_parm(struct file *filp, void *fh, struct v4l2_streamparm *a)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !a)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
+	    a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (inst->domain == ENCODER)
+		ret = venc_g_param(inst, a);
+	else
+		ret = -EINVAL;
+
 unlock:
 	mutex_unlock(&inst->lock);
 
@@ -955,6 +1189,39 @@ static int vidc_try_dec_cmd(struct file *filp, void *fh,
 	return ret;
 }
 
+static int vidc_try_enc_cmd(struct file *filp, void *fh,
+			    struct v4l2_encoder_cmd *enc)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !enc)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (inst->domain != ENCODER) {
+		ret = -ENOTTY;
+		goto unlock;
+	}
+
+	if (enc->cmd != V4L2_ENC_CMD_STOP && enc->cmd != V4L2_ENC_CMD_START) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+	enc->flags = 0;
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
 static int vidc_dec_cmd(struct file *filp, void *fh,
 			struct v4l2_decoder_cmd *dec)
 {
@@ -1002,6 +1269,60 @@ static int vidc_dec_cmd(struct file *filp, void *fh,
 	return ret;
 }
 
+static int vidc_enc_cmd(struct file *filp, void *fh,
+			struct v4l2_encoder_cmd *enc)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = get_vidc_inst(filp, fh);
+	if (!inst || !enc)
+		return -EINVAL;
+
+	mutex_lock(&inst->lock);
+	if (IS_SESSION_ERROR(inst)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	if (inst->domain != ENCODER) {
+		ret = -ENOTTY;
+		goto unlock;
+	}
+
+	if (enc->cmd != V4L2_ENC_CMD_START &&
+	    enc->cmd != V4L2_ENC_CMD_STOP) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (enc->cmd == V4L2_ENC_CMD_STOP && inst->state == IRIS_INST_OPEN) {
+		ret = 0;
+		goto unlock;
+	}
+
+	if (!allow_cmd(inst, enc->cmd)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = iris_pm_get(inst->core);
+	if (ret)
+		goto unlock;
+
+	if (enc->cmd == V4L2_ENC_CMD_START)
+		ret = venc_start_cmd(inst);
+	else if (enc->cmd == V4L2_ENC_CMD_STOP)
+		ret = venc_stop_cmd(inst);
+
+	iris_pm_put(inst->core, true);
+
+unlock:
+	mutex_unlock(&inst->lock);
+
+	return ret;
+}
+
 static struct v4l2_file_operations v4l2_file_ops = {
 	.owner                          = THIS_MODULE,
 	.open                           = vidc_open,
@@ -1027,7 +1348,7 @@ static struct vb2_mem_ops iris_vb2_mem_ops = {
 	.unmap_dmabuf                   = iris_vb2_unmap_dmabuf,
 };
 
-static const struct v4l2_ioctl_ops v4l2_ioctl_ops = {
+static const struct v4l2_ioctl_ops v4l2_ioctl_ops_dec = {
 	.vidioc_enum_fmt_vid_cap        = vidc_enum_fmt,
 	.vidioc_enum_fmt_vid_out        = vidc_enum_fmt,
 	.vidioc_try_fmt_vid_cap_mplane  = vidc_try_fmt,
@@ -1055,12 +1376,44 @@ static const struct v4l2_ioctl_ops v4l2_ioctl_ops = {
 	.vidioc_decoder_cmd             = vidc_dec_cmd,
 };
 
+static const struct v4l2_ioctl_ops v4l2_ioctl_ops_enc = {
+	.vidioc_enum_fmt_vid_cap        = vidc_enum_fmt,
+	.vidioc_enum_fmt_vid_out        = vidc_enum_fmt,
+	.vidioc_try_fmt_vid_cap_mplane  = vidc_try_fmt,
+	.vidioc_try_fmt_vid_out_mplane  = vidc_try_fmt,
+	.vidioc_s_fmt_vid_cap_mplane    = vidc_s_fmt,
+	.vidioc_s_fmt_vid_out_mplane    = vidc_s_fmt,
+	.vidioc_g_fmt_vid_cap_mplane    = vidc_g_fmt,
+	.vidioc_g_fmt_vid_out_mplane    = vidc_g_fmt,
+	.vidioc_enum_framesizes         = vidc_enum_framesizes,
+	.vidioc_enum_frameintervals     = vidc_enum_frameintervals,
+	.vidioc_reqbufs                 = vidc_reqbufs,
+	.vidioc_querybuf                = vidc_querybuf,
+	.vidioc_create_bufs             = vidc_create_bufs,
+	.vidioc_prepare_buf             = vidc_prepare_buf,
+	.vidioc_qbuf                    = vidc_qbuf,
+	.vidioc_dqbuf                   = vidc_dqbuf,
+	.vidioc_streamon                = vidc_streamon,
+	.vidioc_streamoff               = vidc_streamoff,
+	.vidioc_querycap                = vidc_querycap,
+	.vidioc_queryctrl               = vidc_queryctrl,
+	.vidioc_querymenu               = vidc_querymenu,
+	.vidioc_subscribe_event         = vidc_subscribe_event,
+	.vidioc_unsubscribe_event       = vidc_unsubscribe_event,
+	.vidioc_g_selection             = vidc_g_selection,
+	.vidioc_s_selection             = vidc_s_selection,
+	.vidioc_s_parm                  = vidc_s_parm,
+	.vidioc_g_parm                  = vidc_g_parm,
+	.vidioc_try_encoder_cmd         = vidc_try_enc_cmd,
+	.vidioc_encoder_cmd             = vidc_enc_cmd,
+};
+
 int init_ops(struct iris_core *core)
 {
 	core->v4l2_file_ops = &v4l2_file_ops;
 	core->vb2_ops = &iris_vb2_ops;
 	core->vb2_mem_ops = &iris_vb2_mem_ops;
-	core->v4l2_ioctl_ops = &v4l2_ioctl_ops;
-
+	core->v4l2_ioctl_ops_dec = &v4l2_ioctl_ops_dec;
+	core->v4l2_ioctl_ops_enc = &v4l2_ioctl_ops_enc;
 	return 0;
 }
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index 443894c..effecbb 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -115,6 +115,7 @@ struct iris_inst_power {
 enum plat_core_cap_type {
 	CORE_CAP_NONE = 0,
 	DEC_CODECS,
+	ENC_CODECS,
 	MAX_SESSION_COUNT,
 	MAX_MBPF,
 	MAX_MBPS,
@@ -249,6 +250,7 @@ struct plat_inst_cap {
 
 struct plat_inst_caps {
 	enum codec_type codec;
+	enum domain_type domain;
 	struct plat_inst_cap cap[INST_CAP_MAX + 1];
 };
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
index 6d5192a..ef0aad7 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
@@ -63,6 +63,7 @@ static struct color_format_info color_format_data_sm8550[] = {
 
 static struct plat_core_cap core_data_sm8550[] = {
 	{DEC_CODECS, H264 | HEVC | VP9},
+	{ENC_CODECS, H264 | HEVC},
 	{MAX_SESSION_COUNT, 16},
 	{MAX_MBPF, 278528}, /* ((8192x4352)/256) * 2 */
 	{MAX_MBPS, 7833600}, /* max_load 7680x4320@60fps */
-- 
2.7.4


