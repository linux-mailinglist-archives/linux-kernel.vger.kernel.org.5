Return-Path: <linux-kernel+bounces-3450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334EB816C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 847C6B2328C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81111BDD1;
	Mon, 18 Dec 2023 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M9u23Pn6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436BB1A59B;
	Mon, 18 Dec 2023 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIArs70008055;
	Mon, 18 Dec 2023 11:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=inJAjKri0vli8p2oISrlOgpqbAM5ecoVH66wMnG6Rqw=; b=M9
	u23Pn6j0G+GxeMfPPrUV5BjvK6tuodz84LROAyRv/AHqBSpR+z6BBMDAdINBuokR
	4gOSYZPreW+LPyifNyR11oTIVtNdZlkOdZfrbbyfXWjKDU4tBZ8di+9mq0ViZjMV
	Tr79CBIDgeY7F1uBTNXzn4V3uYGu3WiqUFsX+h+amzke4HyP9pLBqjcRSmGtLOmI
	p7dZkjMhTlu0a81IoxUkXVYiOUzKmLLE4tKrsjPBcOGEzw2szlFTxcJaZXhvpBDk
	JwjgvVjSsT5b41Oo6fX9R2MCfq0IULRja9mlAvMi+6aj0JG/GDn3JUuLVPjk417b
	Nbx9QMVKtxjW79z+rMbg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2m49g5sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:36:12 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7qK030018;
	Mon, 18 Dec 2023 11:36:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyjh-1;
	Mon, 18 Dec 2023 11:33:09 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX54a029912;
	Mon, 18 Dec 2023 11:33:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6sI029966;
	Mon, 18 Dec 2023 11:33:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 5F827234B; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 26/34] media: iris: implement vb2 streaming ops on capture and output planes
Date: Mon, 18 Dec 2023 17:02:21 +0530
Message-Id: <1702899149-21321-27-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k_TfUofMAz_uHiWPsvyal0H5DAGv77kg
X-Proofpoint-GUID: k_TfUofMAz_uHiWPsvyal0H5DAGv77kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

During stream on, set some mandatory properties
to firmware to start a session. Subscribe for different
bitstream parameters to get notified for change in any of
the subscribed parameters. Set all v4l2 properties set
by client, to firmware prepared with the dependency graph.
Also, configure the hardware internal buffers required
for frame processing. Send HFI_CMD_START on capture and
output planes to start the processing on respective planes.
The instance state is changed accordingly.

During stream off, send HFI_CMD_STOP to firmware which is
a synchronous command. After the response is received from
firmware, the session is closed on firmware and
instance state is changed accordingly.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |  12 ++
 .../media/platform/qcom/vcodec/iris/iris_buffer.c  |  21 +++
 .../media/platform/qcom/vcodec/iris/iris_buffer.h  |   3 +
 .../media/platform/qcom/vcodec/iris/iris_ctrls.c   |  28 ++++
 .../media/platform/qcom/vcodec/iris/iris_ctrls.h   |   1 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  51 ++++++
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   1 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c | 173 +++++++++++++++++++--
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   7 +
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  14 ++
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |   2 +-
 .../platform/qcom/vcodec/iris/iris_instance.h      |   4 +
 .../media/platform/qcom/vcodec/iris/iris_state.c   |  38 +++++
 .../media/platform/qcom/vcodec/iris/iris_state.h   |   3 +
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c |  78 ++++++++++
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.h |   2 +
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    | 138 +++++++++++++++-
 .../media/platform/qcom/vcodec/iris/iris_vdec.h    |   6 +-
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    |   4 +
 19 files changed, 566 insertions(+), 20 deletions(-)

diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index 0ef6bad..dfd1a4c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -14,6 +14,8 @@
 #define HFI_CMD_INIT				0x01000001
 #define HFI_CMD_OPEN				0x01000003
 #define HFI_CMD_CLOSE				0x01000004
+#define HFI_CMD_START				0x01000005
+#define HFI_CMD_STOP				0x01000006
 #define HFI_CMD_BUFFER				0x01000009
 
 #define HFI_PROP_IMAGE_VERSION			0x03000001
@@ -45,6 +47,16 @@ enum hfi_property_mode_type {
 
 #define HFI_PROP_IMAGE_VERSION			0x03000001
 
+enum hfi_codec_type {
+	HFI_CODEC_DECODE_AVC	= 1,
+	HFI_CODEC_ENCODE_AVC	= 2,
+	HFI_CODEC_DECODE_HEVC	= 3,
+	HFI_CODEC_ENCODE_HEVC	= 4,
+	HFI_CODEC_DECODE_VP9	= 5,
+};
+
+#define HFI_PROP_CODEC				0x03000100
+
 enum hfi_color_format {
 	HFI_COLOR_FMT_OPAQUE        = 0,
 	HFI_COLOR_FMT_NV12          = 1,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
index 1ee840e..ab25026 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.c
@@ -560,3 +560,24 @@ int iris_release_input_internal_buffers(struct iris_inst *inst)
 
 	return ret;
 }
+
+int iris_alloc_and_queue_session_int_bufs(struct iris_inst *inst,
+					  enum iris_buffer_type buffer_type)
+{
+	int ret;
+
+	if (buffer_type != BUF_PERSIST)
+		return -EINVAL;
+
+	ret = iris_get_internal_buf_info(inst, buffer_type);
+	if (ret)
+		return ret;
+
+	ret = iris_create_internal_buffers(inst, buffer_type);
+	if (ret)
+		return ret;
+
+	ret = iris_queue_internal_buffers(inst, buffer_type);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
index bdef15f..8769c3d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
@@ -59,4 +59,7 @@ int iris_destroy_internal_buffers(struct iris_inst *inst,
 				  u32 plane);
 int iris_release_input_internal_buffers(struct iris_inst *inst);
 
+int iris_alloc_and_queue_session_int_bufs(struct iris_inst *inst,
+					  enum iris_buffer_type buffer_type);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
index 28977e8..94fff74 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
@@ -113,6 +113,20 @@ static int adjust_cap(struct iris_inst *inst,
 	return cap->adjust(inst, ctrl);
 }
 
+static int set_cap(struct iris_inst *inst, enum plat_inst_cap_type cap_id)
+{
+	struct plat_inst_cap *cap;
+
+	cap = &inst->cap[cap_id];
+	if (!inst->cap[cap_id].cap_id)
+		return 0;
+
+	if (!cap->set)
+		return 0;
+
+	return cap->set(inst, cap_id);
+}
+
 static int adjust_dynamic_property(struct iris_inst *inst,
 				   enum plat_inst_cap_type cap_id,
 				   struct v4l2_ctrl *ctrl,
@@ -657,6 +671,20 @@ int set_pipe(struct iris_inst *inst,
 				     &work_route, sizeof(u32));
 }
 
+int set_v4l2_properties(struct iris_inst *inst)
+{
+	struct cap_entry *entry = NULL, *temp = NULL;
+	int ret = 0;
+
+	list_for_each_entry_safe(entry, temp, &inst->caps_list, list) {
+		ret = set_cap(inst, entry->cap_id);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 int adjust_v4l2_properties(struct iris_inst *inst)
 {
 	struct cap_entry *entry = NULL, *temp = NULL;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
index 22ee6c4b..28ce767 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
@@ -28,6 +28,7 @@ int prepare_dependency_list(struct iris_inst *inst);
 int iris_init_instance_caps(struct iris_core *core);
 int iris_init_core_caps(struct iris_core *core);
 int get_inst_capability(struct iris_inst *inst);
+int set_v4l2_properties(struct iris_inst *inst);
 int adjust_v4l2_properties(struct iris_inst *inst);
 int ctrls_init(struct iris_inst *inst, bool init);
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index 4cad673..7868566 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -9,6 +9,7 @@
 #include "iris_hfi.h"
 #include "iris_hfi_packet.h"
 #include "iris_instance.h"
+#include "iris_vidc.h"
 
 int check_core_lock(struct iris_core *core)
 {
@@ -377,3 +378,53 @@ struct iris_inst *to_instance(struct iris_core *core, u32 session_id)
 
 	return NULL;
 }
+
+static int kill_session(struct iris_inst *inst)
+{
+	if (!inst->session_id)
+		return 0;
+
+	close_session(inst);
+	iris_inst_change_state(inst, IRIS_INST_ERROR);
+
+	return 0;
+}
+
+int session_streamoff(struct iris_inst *inst, u32 plane)
+{
+	enum signal_session_response signal_type;
+	u32 hw_response_timeout_val;
+	struct iris_core *core;
+	int ret;
+
+	ret = iris_hfi_stop(inst, plane);
+	if (ret)
+		goto error;
+
+	core = inst->core;
+	hw_response_timeout_val = core->cap[HW_RESPONSE_TIMEOUT].value;
+	mutex_unlock(&inst->lock);
+	ret = wait_for_completion_timeout(&inst->completions[signal_type],
+					  msecs_to_jiffies(hw_response_timeout_val));
+	if (!ret) {
+		ret = -ETIMEDOUT;
+		process_inst_timeout(inst);
+	} else {
+		ret = 0;
+	}
+	mutex_lock(&inst->lock);
+
+	if (ret)
+		goto error;
+
+	ret = iris_inst_state_change_streamoff(inst, plane);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	kill_session(inst);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index cb22adf..47a017d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -34,6 +34,7 @@ bool is_split_mode_enabled(struct iris_inst *inst);
 int signal_session_msg_receipt(struct iris_inst *inst,
 			       enum signal_session_response cmd);
 struct iris_inst *to_instance(struct iris_core *core, u32 session_id);
+int session_streamoff(struct iris_inst *inst, u32 plane);
 
 u32 v4l2_codec_from_driver(struct iris_inst *inst, enum codec_type codec);
 enum codec_type v4l2_codec_to_driver(struct iris_inst *inst, u32 v4l2_codec);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index d15ce5a..e0da3be 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -219,9 +219,7 @@ int iris_hfi_session_open(struct iris_inst *inst)
 	return ret;
 }
 
-int iris_hfi_session_subscribe_mode(struct iris_inst *inst,
-				    u32 cmd, u32 plane, u32 payload_type,
-				    void *payload, u32 payload_size)
+int iris_hfi_session_close(struct iris_inst *inst)
 {
 	struct iris_core *core;
 	int ret;
@@ -238,14 +236,126 @@ int iris_hfi_session_subscribe_mode(struct iris_inst *inst,
 	}
 
 	ret = hfi_packet_session_command(inst,
-					 cmd,
+					 HFI_CMD_CLOSE,
+					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+					 HFI_HOST_FLAGS_INTR_REQUIRED |
+					 HFI_HOST_FLAGS_NON_DISCARDABLE),
+					 HFI_PORT_NONE,
+					 inst->session_id,
+					 HFI_PAYLOAD_NONE,
+					 NULL,
+					 0);
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
+int iris_hfi_session_set_codec(struct iris_inst *inst)
+{
+	struct iris_core *core;
+	int ret;
+	u32 codec;
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
+	codec = get_hfi_codec(inst);
+	ret = hfi_packet_session_property(inst,
+					  HFI_PROP_CODEC,
+					  HFI_HOST_FLAGS_NONE,
+					  HFI_PORT_NONE,
+					  HFI_PAYLOAD_U32_ENUM,
+					  &codec,
+					  sizeof(u32));
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
+int iris_hfi_session_set_default_header(struct iris_inst *inst)
+{
+	struct iris_core *core;
+	u32 default_header = false;
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
+	default_header = inst->cap[DEFAULT_HEADER].value;
+	ret = hfi_packet_session_property(inst,
+					  HFI_PROP_DEC_DEFAULT_HEADER,
+					  HFI_HOST_FLAGS_NONE,
+					  get_hfi_port(INPUT_MPLANE),
+					  HFI_PAYLOAD_U32,
+					  &default_header,
+					  sizeof(u32));
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
+int iris_hfi_start(struct iris_inst *inst, u32 plane)
+{
+	struct iris_core *core;
+	int ret = 0;
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
+	if (plane != INPUT_MPLANE && plane != OUTPUT_MPLANE)
+		goto unlock;
+
+	ret = hfi_packet_session_command(inst,
+					 HFI_CMD_START,
 					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
 					 HFI_HOST_FLAGS_INTR_REQUIRED),
 					 get_hfi_port(plane),
 					 inst->session_id,
-					 payload_type,
-					 payload,
-					 payload_size);
+					 HFI_PAYLOAD_NONE,
+					 NULL,
+					 0);
 	if (ret)
 		goto unlock;
 
@@ -257,10 +367,10 @@ int iris_hfi_session_subscribe_mode(struct iris_inst *inst,
 	return ret;
 }
 
-int iris_hfi_session_close(struct iris_inst *inst)
+int iris_hfi_stop(struct iris_inst *inst, u32 plane)
 {
 	struct iris_core *core;
-	int ret;
+	int ret = 0;
 
 	if (!inst->packet)
 		return -EINVAL;
@@ -273,12 +383,15 @@ int iris_hfi_session_close(struct iris_inst *inst)
 		goto unlock;
 	}
 
+	if (plane != INPUT_MPLANE && plane != OUTPUT_MPLANE)
+		goto unlock;
+
 	ret = hfi_packet_session_command(inst,
-					 HFI_CMD_CLOSE,
+					 HFI_CMD_STOP,
 					 (HFI_HOST_FLAGS_RESPONSE_REQUIRED |
 					 HFI_HOST_FLAGS_INTR_REQUIRED |
 					 HFI_HOST_FLAGS_NON_DISCARDABLE),
-					 HFI_PORT_NONE,
+					 get_hfi_port(plane),
 					 inst->session_id,
 					 HFI_PAYLOAD_NONE,
 					 NULL,
@@ -294,6 +407,44 @@ int iris_hfi_session_close(struct iris_inst *inst)
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
 irqreturn_t iris_hfi_isr(int irq, void *data)
 {
 	disable_irq_nosync(irq);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index d6b3fca..f054c2d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -19,6 +19,13 @@ int iris_hfi_session_subscribe_mode(struct iris_inst *inst,
 int iris_hfi_set_property(struct iris_inst *inst,
 			  u32 packet_type, u32 flag, u32 plane, u32 payload_type,
 			  void *payload, u32 payload_size);
+
+int iris_hfi_session_set_codec(struct iris_inst *inst);
+int iris_hfi_session_set_default_header(struct iris_inst *inst);
+
+int iris_hfi_start(struct iris_inst *inst, u32 plane);
+int iris_hfi_stop(struct iris_inst *inst, u32 plane);
+
 int iris_hfi_queue_buffer(struct iris_inst *inst,
 			  struct iris_buffer *buffer);
 int iris_hfi_release_buffer(struct iris_inst *inst,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index dc7157d..b8785a9 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -76,6 +76,20 @@ static u32 hfi_buf_type_from_driver(enum iris_buffer_type buffer_type)
 	}
 }
 
+u32 get_hfi_codec(struct iris_inst *inst)
+{
+	switch (inst->codec) {
+	case H264:
+		return HFI_CODEC_DECODE_AVC;
+	case HEVC:
+		return HFI_CODEC_DECODE_HEVC;
+	case VP9:
+		return HFI_CODEC_DECODE_VP9;
+	default:
+		return 0;
+	}
+}
+
 u32 get_hfi_colorformat(u32 colorformat)
 {
 	u32 hfi_colorformat = HFI_COLOR_FMT_NV12_UBWC;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
index f813116..cf0960b6 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -81,8 +81,8 @@ enum hfi_packet_port_type {
 
 u32 get_hfi_port_from_buffer_type(enum iris_buffer_type buffer_type);
 u32 get_hfi_port(u32 plane);
-
 u32 get_hfi_colorformat(u32 colorformat);
+u32 get_hfi_codec(struct iris_inst *inst);
 u32 get_hfi_color_primaries(u32 primaries);
 u32 get_hfi_transfer_char(u32 characterstics);
 u32 get_hfi_matrix_coefficients(u32 coefficients);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index 4f51d68..cddf143 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -40,10 +40,12 @@
  * @fw_min_count: minimnum count of buffers needed by fw
  * @state: instance state
  * @ipsc_properties_set: boolean to set ipsc properties to fw
+ * @opsc_properties_set: boolean to set opsc properties to fw
  * @hfi_frame_info: structure of frame info
  * @src_subcr_params: subscription params to fw on input port
  * @dst_subcr_params: subscription params to fw on output port
  * @dpb_list_payload: array of dpb buffers
+ * @once_per_session_set: boolean to set once per session property
  */
 
 struct iris_inst {
@@ -70,10 +72,12 @@ struct iris_inst {
 	u32				fw_min_count;
 	enum iris_inst_state		state;
 	bool				ipsc_properties_set;
+	bool				opsc_properties_set;
 	struct iris_hfi_frame_info	hfi_frame_info;
 	struct subscription_params	src_subcr_params;
 	struct subscription_params	dst_subcr_params;
 	u32				dpb_list_payload[MAX_DPB_LIST_ARRAY_SIZE];
+	bool				once_per_session_set;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
index 4cf6b69..6553029 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
@@ -193,3 +193,41 @@ bool allow_s_ctrl(struct iris_inst *inst, u32 cap_id)
 		(inst->state == IRIS_INST_INPUT_STREAMING ||
 		inst->state == IRIS_INST_STREAMING)));
 }
+
+int iris_inst_state_change_streamon(struct iris_inst *inst, u32 plane)
+{
+	enum iris_inst_state new_state = IRIS_INST_ERROR;
+
+	if (plane == INPUT_MPLANE) {
+		if (inst->state == IRIS_INST_OPEN)
+			new_state = IRIS_INST_INPUT_STREAMING;
+		else if (inst->state == IRIS_INST_OUTPUT_STREAMING)
+			new_state = IRIS_INST_STREAMING;
+	} else if (plane == OUTPUT_MPLANE) {
+		if (inst->state == IRIS_INST_OPEN)
+			new_state = IRIS_INST_OUTPUT_STREAMING;
+		else if (inst->state == IRIS_INST_INPUT_STREAMING)
+			new_state = IRIS_INST_STREAMING;
+	}
+
+	return iris_inst_change_state(inst, new_state);
+}
+
+int iris_inst_state_change_streamoff(struct iris_inst *inst, u32 plane)
+{
+	enum iris_inst_state new_state = IRIS_INST_ERROR;
+
+	if (plane == INPUT_MPLANE) {
+		if (inst->state == IRIS_INST_INPUT_STREAMING)
+			new_state = IRIS_INST_OPEN;
+		else if (inst->state == IRIS_INST_STREAMING)
+			new_state = IRIS_INST_OUTPUT_STREAMING;
+	} else if (plane == OUTPUT_MPLANE) {
+		if (inst->state == IRIS_INST_OUTPUT_STREAMING)
+			new_state = IRIS_INST_OPEN;
+		else if (inst->state == IRIS_INST_STREAMING)
+			new_state = IRIS_INST_INPUT_STREAMING;
+	}
+
+	return iris_inst_change_state(inst, new_state);
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.h b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
index 35263e8..28d5380 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
@@ -47,4 +47,7 @@ bool allow_streamon(struct iris_inst *inst, u32 type);
 bool allow_streamoff(struct iris_inst *inst, u32 type);
 bool allow_s_ctrl(struct iris_inst *inst, u32 cap_id);
 
+int iris_inst_state_change_streamon(struct iris_inst *inst, u32 plane);
+int iris_inst_state_change_streamoff(struct iris_inst *inst, u32 plane);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
index 66b5295..d599366 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
@@ -6,9 +6,12 @@
 #include "iris_buffer.h"
 #include "iris_ctrls.h"
 #include "iris_core.h"
+#include "iris_ctrls.h"
 #include "iris_helpers.h"
+#include "iris_hfi.h"
 #include "iris_instance.h"
 #include "iris_vb2.h"
+#include "iris_vdec.h"
 
 int iris_vb2_queue_setup(struct vb2_queue *q,
 			 unsigned int *num_buffers, unsigned int *num_planes,
@@ -90,6 +93,81 @@ int iris_vb2_queue_setup(struct vb2_queue *q,
 	return ret;
 }
 
+int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	if (!q)
+		return -EINVAL;
+
+	inst = vb2_get_drv_priv(q);
+	if (!inst || !inst->core)
+		return -EINVAL;
+
+	if (q->type != INPUT_MPLANE && q->type != OUTPUT_MPLANE) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	if (!inst->once_per_session_set) {
+		inst->once_per_session_set = true;
+		ret = iris_hfi_session_set_codec(inst);
+		if (ret)
+			goto error;
+
+		ret = iris_hfi_session_set_default_header(inst);
+		if (ret)
+			goto error;
+
+		ret = iris_alloc_and_queue_session_int_bufs(inst, BUF_PERSIST);
+		if (ret)
+			goto error;
+	}
+
+	if (q->type == INPUT_MPLANE)
+		ret = vdec_streamon_input(inst);
+	else if (q->type == OUTPUT_MPLANE)
+		ret = vdec_streamon_output(inst);
+	if (ret)
+		goto error;
+
+	return ret;
+error:
+	iris_inst_change_state(inst, IRIS_INST_ERROR);
+
+	return ret;
+}
+
+void iris_vb2_stop_streaming(struct vb2_queue *q)
+{
+	struct iris_inst *inst;
+	int ret = 0;
+
+	if (!q)
+		return;
+
+	inst = vb2_get_drv_priv(q);
+	if (!inst)
+		return;
+
+	if (q->type != INPUT_MPLANE && q->type != OUTPUT_MPLANE)
+		goto error;
+
+	if (q->type == INPUT_MPLANE)
+		ret = session_streamoff(inst, INPUT_MPLANE);
+	else if (q->type == OUTPUT_MPLANE)
+		ret = session_streamoff(inst, OUTPUT_MPLANE);
+
+	if (ret)
+		goto error;
+
+	return;
+
+error:
+	iris_inst_change_state(inst, IRIS_INST_ERROR);
+}
+
 void *iris_vb2_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
 			     struct dma_buf *dbuf, unsigned long size)
 {
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
index 4342034..fc0e804 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
@@ -11,6 +11,8 @@
 int iris_vb2_queue_setup(struct vb2_queue *q,
 			 unsigned int *num_buffers, unsigned int *num_planes,
 			 unsigned int sizes[], struct device *alloc_devs[]);
+int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count);
+void iris_vb2_stop_streaming(struct vb2_queue *q);
 
 /* vb2_mem_ops */
 void *iris_vb2_alloc(struct vb2_buffer *vb, struct device *dev, unsigned long size);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index ac47fc0..0d8ca4b 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -340,7 +340,7 @@ int vdec_subscribe_event(struct iris_inst *inst, const struct v4l2_event_subscri
 	return ret;
 }
 
-int vdec_subscribe_property(struct iris_inst *inst, u32 plane)
+static int vdec_subscribe_property(struct iris_inst *inst, u32 plane)
 {
 	const u32 *subcribe_prop = NULL;
 	u32 subscribe_prop_size = 0;
@@ -597,7 +597,7 @@ static int vdec_set_tier(struct iris_inst *inst)
 				     sizeof(u32));
 }
 
-int vdec_subscribe_src_change_param(struct iris_inst *inst)
+static int vdec_subscribe_src_change_param(struct iris_inst *inst)
 {
 	const u32 *src_change_param;
 	u32 src_change_param_size;
@@ -925,7 +925,7 @@ static int vdec_set_ubwc_stride_scanline(struct iris_inst *inst)
 				     sizeof(u32) * 4);
 }
 
-int vdec_set_output_property(struct iris_inst *inst)
+static int vdec_set_output_property(struct iris_inst *inst)
 {
 	int ret;
 
@@ -940,7 +940,7 @@ int vdec_set_output_property(struct iris_inst *inst)
 	return vdec_set_ubwc_stride_scanline(inst);
 }
 
-int vdec_subscribe_dst_change_param(struct iris_inst *inst)
+static int vdec_subscribe_dst_change_param(struct iris_inst *inst)
 {
 	u32 prop_type, payload_size, payload_type;
 	struct subscription_params subsc_params;
@@ -1063,3 +1063,133 @@ int vdec_subscribe_dst_change_param(struct iris_inst *inst)
 
 	return ret;
 }
+
+static int process_streamon_input(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = iris_hfi_start(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = iris_inst_state_change_streamon(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+int vdec_streamon_input(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = check_session_supported(inst);
+	if (ret)
+		return ret;
+
+	ret = set_v4l2_properties(inst);
+	if (ret)
+		return ret;
+
+	ret = iris_get_internal_buffers(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = iris_destroy_internal_buffers(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = iris_create_input_internal_buffers(inst);
+	if (ret)
+		return ret;
+
+	ret = iris_queue_input_internal_buffers(inst);
+	if (ret)
+		return ret;
+
+	if (!inst->ipsc_properties_set) {
+		ret = vdec_subscribe_src_change_param(inst);
+		if (ret)
+			return ret;
+		inst->ipsc_properties_set = true;
+	}
+
+	ret = vdec_subscribe_property(inst, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = process_streamon_input(inst);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int process_streamon_output(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = iris_hfi_start(inst, OUTPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = iris_inst_state_change_streamon(inst, OUTPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+int vdec_streamon_output(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = check_session_supported(inst);
+	if (ret)
+		return ret;
+
+	ret = vdec_set_output_property(inst);
+	if (ret)
+		goto error;
+
+	if (!inst->opsc_properties_set) {
+		memcpy(&inst->dst_subcr_params,
+		       &inst->src_subcr_params,
+		       sizeof(inst->src_subcr_params));
+		ret = vdec_subscribe_dst_change_param(inst);
+		if (ret)
+			goto error;
+		inst->opsc_properties_set = true;
+	}
+
+	ret = vdec_subscribe_property(inst, OUTPUT_MPLANE);
+	if (ret)
+		goto error;
+
+	ret = iris_get_internal_buffers(inst, OUTPUT_MPLANE);
+	if (ret)
+		goto error;
+
+	ret = iris_destroy_internal_buffers(inst, OUTPUT_MPLANE);
+	if (ret)
+		goto error;
+
+	ret = iris_create_output_internal_buffers(inst);
+	if (ret)
+		goto error;
+
+	ret = process_streamon_output(inst);
+	if (ret)
+		goto error;
+
+	ret = iris_queue_output_internal_buffers(inst);
+	if (ret)
+		goto error;
+
+	return ret;
+
+error:
+	session_streamoff(inst, OUTPUT_MPLANE);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
index e0db653..0722da1 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
@@ -14,11 +14,9 @@ int vdec_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f);
 int vdec_try_fmt(struct iris_inst *inst, struct v4l2_format *f);
 int vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f);
 int vdec_subscribe_event(struct iris_inst *inst, const struct v4l2_event_subscription *sub);
-int vdec_subscribe_property(struct iris_inst *inst, u32 plane);
-int vdec_set_output_property(struct iris_inst *inst);
 int vdec_init_src_change_param(struct iris_inst *inst);
 int vdec_src_change(struct iris_inst *inst);
-int vdec_subscribe_src_change_param(struct iris_inst *inst);
-int vdec_subscribe_dst_change_param(struct iris_inst *inst);
+int vdec_streamon_input(struct iris_inst *inst);
+int vdec_streamon_output(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index 5c76821..14d0077 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -176,6 +176,8 @@ int vidc_open(struct file *filp)
 
 	inst->core = core;
 	inst->session_id = hash32_ptr(inst);
+	inst->ipsc_properties_set = false;
+	inst->opsc_properties_set = false;
 	iris_inst_change_state(inst, IRIS_INST_OPEN);
 	mutex_init(&inst->lock);
 	mutex_init(&inst->ctx_q_lock);
@@ -908,6 +910,8 @@ static const struct v4l2_file_operations v4l2_file_ops = {
 
 static const struct vb2_ops iris_vb2_ops = {
 	.queue_setup                    = iris_vb2_queue_setup,
+	.start_streaming                = iris_vb2_start_streaming,
+	.stop_streaming                 = iris_vb2_stop_streaming,
 };
 
 static struct vb2_mem_ops iris_vb2_mem_ops = {
-- 
2.7.4


