Return-Path: <linux-kernel+bounces-3475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37E816CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4746AB20B25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308F83C6AC;
	Mon, 18 Dec 2023 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XdPExALJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBF3A292;
	Mon, 18 Dec 2023 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAsbmO017739;
	Mon, 18 Dec 2023 11:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=bQmJDd4OHQmCq8/fSTL5KeqyMd4FZGSIiAMOA3pckZc=; b=Xd
	PExALJaihoLtpzxTg4ezkPIAnyIwDFq+QJaJrXMi/cfpPNyzrorubj04xj8CPzcJ
	nYvQm+AwgJHa2OIbpCHBeuM7hmE9Hg7vDzlZEF32VJiuGYmXsqIT6Pi43gTdXifM
	BUfB4lfEpqIDJmvwRSgI2HiiRqWY6IVCpe7Lq7otlxcyxX/5m3DL4z/9C+fwuEC4
	i2SKwsg8J96/5mypd84yOigC42YMb5w2VGTQ39skeDw9LW+pbMiP2ZyOjZuC0oK7
	aPLkLhSo65yoa5HwXrM2t4+5UUgNKp8Nq6wgKrbqHBWVoJ3KJxMnECHQhHM4r+CZ
	TcQaqeDHO4PpmkrImKUg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v156dm7qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:05 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0FS004875;
	Mon, 18 Dec 2023 11:40:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ac-5;
	Mon, 18 Dec 2023 11:40:02 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX77o029983;
	Mon, 18 Dec 2023 11:36:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX8AN030059;
	Mon, 18 Dec 2023 11:36:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 471CE2307; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 16/34] media: iris: implement iris v4l2_ctrl_ops and prepare capabilities
Date: Mon, 18 Dec 2023 17:02:11 +0530
Message-Id: <1702899149-21321-17-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l4slAT7wbzXowxPp0aK2oLY-Z9ETT4lx
X-Proofpoint-GUID: l4slAT7wbzXowxPp0aK2oLY-Z9ETT4lx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Implement iris v4l2_ctrl_ops - s_ctrl and g_volatile_ctrl.

Core capability structure has all the supported capabilities
for all supported codecs. Initializes instance capability
from core capability based on the codec type.

Add following to each capability:
Children: define dependencies for a specific capability.
Adjust: define function to adjust the value of capability
        based on client configuration or dependency with
	other capability.
Set: define function to set the adjusted value to firmware.

Prepare dependency graph for all inter-dependent capabilities.
This is used to adjust the value of capabilities and set the
same to firmware.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   1 +
 .../media/platform/qcom/vcodec/iris/iris_core.h    |   4 +
 .../media/platform/qcom/vcodec/iris/iris_ctrls.c   | 679 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_ctrls.h   |  30 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  31 +-
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |  13 +-
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |  29 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   3 +
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  26 +
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |   3 +
 .../platform/qcom/vcodec/iris/iris_instance.h      |   9 +
 .../media/platform/qcom/vcodec/iris/iris_probe.c   |   8 +
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    |  16 +
 .../platform/qcom/vcodec/iris/platform_common.h    |  13 +
 .../platform/qcom/vcodec/iris/platform_sm8550.c    |  84 ++-
 15 files changed, 921 insertions(+), 28 deletions(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 85fdf63..7fdee5b 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -6,6 +6,7 @@ iris-objs += iris_probe.o \
              iris_vidc.o \
              iris_vdec.o \
              iris_state.o \
+             iris_ctrls.o \
              iris_helpers.o \
              iris_hfi.o \
              iris_hfi_response.o \
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index c125bce..30f7ad7 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -50,8 +50,10 @@
  * @header_id: id of packet header
  * @packet_id: id of packet
  * @vpu_ops: a pointer to vpu ops
+ * @dec_codecs_count: supported codec count for decoder
  * @platform_data: a structure for platform data
  * @cap: an array for supported core capabilities
+ * @inst_caps: a pointer to supported instance capabilities
  * @instances: a list_head of all instances
  * @intr_status: interrupt status
  */
@@ -89,8 +91,10 @@ struct iris_core {
 	u32					header_id;
 	u32					packet_id;
 	const struct vpu_ops			*vpu_ops;
+	u32					dec_codecs_count;
 	struct platform_data			*platform_data;
 	struct plat_core_cap			cap[CORE_CAP_MAX + 1];
+	struct plat_inst_caps			*inst_caps;
 	struct list_head			instances;
 	u32					intr_status;
 };
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
new file mode 100644
index 0000000..6b7aeaa
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#include <linux/vmalloc.h>
+#include <linux/types.h>
+#include <linux/list.h>
+
+#include "platform_common.h"
+#include "iris_helpers.h"
+#include "iris_hfi_packet.h"
+#include "iris_hfi.h"
+#include "iris_ctrls.h"
+
+#define MIN_CAPTURE_BUFFERS 4
+#define MIN_OUTPUT_BUFFERS 4
+
+static inline bool are_all_childrens_visited(struct plat_inst_cap *cap,
+					     bool lookup[INST_CAP_MAX])
+{
+	bool found = true;
+	int i;
+
+	for (i = 0; i < MAX_NUM_CHILD; i++) {
+		if (cap->children[i] == INST_CAP_NONE)
+			continue;
+
+		if (!lookup[cap->children[i]]) {
+			found = false;
+			break;
+		}
+	}
+
+	return found;
+}
+
+static bool is_valid_cap_id(enum plat_inst_cap_type cap_id)
+{
+	return cap_id > INST_CAP_NONE && cap_id < INST_CAP_MAX;
+}
+
+static enum plat_inst_cap_type get_cap_id(struct iris_inst *inst, u32 id)
+{
+	enum plat_inst_cap_type iter = INST_CAP_NONE;
+	enum plat_inst_cap_type cap_id = INST_CAP_NONE;
+
+	do {
+		if (inst->cap[iter].v4l2_id == id) {
+			cap_id = inst->cap[iter].cap_id;
+			break;
+		}
+		iter++;
+	} while (iter < INST_CAP_MAX);
+
+	return cap_id;
+}
+
+static int add_node_list(struct list_head *list, enum plat_inst_cap_type cap_id)
+{
+	struct cap_entry *entry = NULL;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&entry->list);
+	entry->cap_id = cap_id;
+	list_add(&entry->list, list);
+
+	return 0;
+}
+
+static int add_children(struct list_head *list,
+			struct iris_inst *inst,
+			enum plat_inst_cap_type cap_id)
+{
+	struct plat_inst_cap *cap;
+	int i, ret = 0;
+
+	cap = &inst->cap[cap_id];
+
+	for (i = 0; i < MAX_NUM_CHILD; i++) {
+		if (!cap->children[i])
+			break;
+
+		if (!is_valid_cap_id(cap->children[i]))
+			continue;
+
+		ret = add_node_list(list, cap->children[i]);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int adjust_cap(struct iris_inst *inst,
+		      enum plat_inst_cap_type cap_id,
+		      struct v4l2_ctrl *ctrl)
+{
+	struct plat_inst_cap *cap;
+
+	cap = &inst->cap[cap_id];
+	if (!inst->cap[cap_id].cap_id)
+		return 0;
+
+	if (!cap->adjust) {
+		if (ctrl)
+			inst->cap[cap_id].value = ctrl->val;
+		return 0;
+	}
+
+	return cap->adjust(inst, ctrl);
+}
+
+static int adjust_dynamic_property(struct iris_inst *inst,
+				   enum plat_inst_cap_type cap_id,
+				   struct v4l2_ctrl *ctrl,
+				   struct list_head *firmware_list,
+				   struct list_head *children_list,
+				   bool cap_present[INST_CAP_MAX])
+{
+	struct cap_entry *entry = NULL, *temp = NULL;
+	struct plat_inst_cap *cap;
+	s32 prev_value;
+	int ret;
+
+	cap = &inst->cap[0];
+
+	if (!(cap[cap_id].flags & CAP_FLAG_DYNAMIC_ALLOWED))
+		return -EBUSY;
+
+	prev_value = cap[cap_id].value;
+	ret = adjust_cap(inst, cap_id, ctrl);
+	if (ret)
+		return ret;
+
+	ret = add_node_list(firmware_list, cap_id);
+	if (ret)
+		return ret;
+	cap_present[cap->cap_id] = true;
+
+	if (cap[cap_id].value == prev_value)
+		return 0;
+
+	ret = add_children(children_list, inst, cap_id);
+	if (ret)
+		return ret;
+
+	list_for_each_entry_safe(entry, temp, children_list, list) {
+		if (!cap[entry->cap_id].adjust) {
+			list_del_init(&entry->list);
+			kfree(entry);
+			continue;
+		}
+
+		prev_value = cap[entry->cap_id].value;
+		ret = adjust_cap(inst, entry->cap_id, NULL);
+		if (ret)
+			return ret;
+
+		if (cap[entry->cap_id].value != prev_value) {
+			if (!cap_present[cap->cap_id]) {
+				ret = add_node_list(firmware_list, cap_id);
+				if (ret)
+					return ret;
+				cap_present[cap->cap_id] = true;
+			}
+
+			ret = add_children(children_list, inst, entry->cap_id);
+			if (ret)
+				return ret;
+		}
+
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+
+	if (!list_empty(children_list))
+		return -EINVAL;
+
+	return ret;
+}
+
+static int set_dynamic_property(struct iris_inst *inst,
+				struct list_head *firmware_list)
+{
+	struct cap_entry *entry = NULL, *temp = NULL;
+	struct plat_inst_cap *cap;
+	int ret = 0;
+
+	list_for_each_entry_safe(entry, temp, firmware_list, list) {
+		cap = &inst->cap[entry->cap_id];
+		if (cap->set) {
+			ret = cap->set(inst, entry->cap_id);
+			if (ret)
+				return -EINVAL;
+		}
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+
+	return ret;
+}
+
+static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	enum plat_inst_cap_type cap_id;
+	struct iris_inst *inst = NULL;
+	int ret = 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
+		ctrl->val = MIN_CAPTURE_BUFFERS;
+		break;
+	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
+		ctrl->val = MIN_OUTPUT_BUFFERS;
+		break;
+	default:
+		inst = container_of(ctrl->handler, struct iris_inst, ctrl_handler);
+		cap_id = get_cap_id(inst, ctrl->id);
+		if (is_valid_cap_id(cap_id))
+			ctrl->val = inst->cap[cap_id].value;
+		else
+			ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct cap_entry *entry = NULL, *temp = NULL;
+	struct list_head children_list, firmware_list;
+	enum plat_inst_cap_type cap_id;
+	bool cap_present[INST_CAP_MAX];
+	struct plat_inst_cap *cap;
+	struct iris_inst *inst;
+	int ret = 0;
+
+	inst = container_of(ctrl->handler, struct iris_inst, ctrl_handler);
+	cap = &inst->cap[0];
+
+	INIT_LIST_HEAD(&firmware_list);
+	INIT_LIST_HEAD(&children_list);
+	memset(&cap_present, 0, sizeof(cap_present));
+
+	cap_id = get_cap_id(inst, ctrl->id);
+	if (!is_valid_cap_id(cap_id))
+		return -EINVAL;
+
+	cap[cap_id].flags |= CAP_FLAG_CLIENT_SET;
+
+	if (!inst->vb2q_src->streaming) {
+		inst->cap[cap_id].value = ctrl->val;
+	} else {
+		ret = adjust_dynamic_property(inst, cap_id, ctrl,
+					      &firmware_list, &children_list,
+					      cap_present);
+		if (ret)
+			goto free_list;
+
+		ret = set_dynamic_property(inst, &firmware_list);
+	}
+
+free_list:
+	list_for_each_entry_safe(entry, temp, &children_list, list) {
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+
+	list_for_each_entry_safe(entry, temp, &firmware_list, list) {
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+
+	return ret;
+}
+
+static const struct v4l2_ctrl_ops ctrl_ops = {
+	.s_ctrl = vdec_op_s_ctrl,
+	.g_volatile_ctrl = vdec_op_g_volatile_ctrl,
+};
+
+int ctrls_init(struct iris_inst *inst)
+{
+	int num_ctrls = 0, ctrl_idx = 0;
+	struct plat_inst_cap *cap;
+	struct iris_core *core;
+	int idx = 0;
+	int ret = 0;
+
+	core = inst->core;
+	cap = &inst->cap[0];
+
+	for (idx = 0; idx < INST_CAP_MAX; idx++) {
+		if (cap[idx].v4l2_id)
+			num_ctrls++;
+	}
+	if (!num_ctrls)
+		return -EINVAL;
+
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler,
+				     INST_CAP_MAX * core->dec_codecs_count);
+	if (ret)
+		return ret;
+
+	for (idx = 0; idx < INST_CAP_MAX; idx++) {
+		struct v4l2_ctrl *ctrl;
+
+		if (!cap[idx].v4l2_id)
+			continue;
+
+		if (ctrl_idx >= num_ctrls) {
+			ret = -EINVAL;
+			goto error;
+		}
+
+		if (cap[idx].flags & CAP_FLAG_MENU) {
+			ctrl = v4l2_ctrl_new_std_menu(&inst->ctrl_handler,
+						      &ctrl_ops,
+						      cap[idx].v4l2_id,
+						      cap[idx].max,
+						      ~(cap[idx].step_or_mask),
+						      cap[idx].value);
+		} else {
+			ctrl = v4l2_ctrl_new_std(&inst->ctrl_handler,
+						 &ctrl_ops,
+						 cap[idx].v4l2_id,
+						 cap[idx].min,
+						 cap[idx].max,
+						 cap[idx].step_or_mask,
+						 cap[idx].value);
+		}
+		if (!ctrl) {
+			ret = -EINVAL;
+			goto error;
+		}
+
+		ret = inst->ctrl_handler.error;
+		if (ret)
+			goto error;
+
+		if ((cap[idx].flags & CAP_FLAG_VOLATILE) ||
+		    (ctrl->id == V4L2_CID_MIN_BUFFERS_FOR_CAPTURE ||
+		     ctrl->id == V4L2_CID_MIN_BUFFERS_FOR_OUTPUT))
+			ctrl->flags |= V4L2_CTRL_FLAG_VOLATILE;
+
+		ctrl->flags |= V4L2_CTRL_FLAG_EXECUTE_ON_WRITE;
+		ctrl_idx++;
+	}
+	inst->num_ctrls = num_ctrls;
+
+	return 0;
+error:
+	v4l2_ctrl_handler_free(&inst->ctrl_handler);
+
+	return ret;
+}
+
+int iris_init_core_caps(struct iris_core *core)
+{
+	struct plat_core_cap *core_platform_data;
+	int i, num_core_caps;
+
+	core_platform_data = core->platform_data->core_data;
+	if (!core_platform_data)
+		return -EINVAL;
+
+	num_core_caps = core->platform_data->core_data_size;
+
+	for (i = 0; i < num_core_caps && i < CORE_CAP_MAX; i++) {
+		core->cap[core_platform_data[i].type].type = core_platform_data[i].type;
+		core->cap[core_platform_data[i].type].value = core_platform_data[i].value;
+	}
+
+	return 0;
+}
+
+static int update_inst_capability(struct plat_inst_cap *in,
+				  struct plat_inst_caps *capability)
+{
+	if (!in || !capability)
+		return -EINVAL;
+
+	if (in->cap_id >= INST_CAP_MAX)
+		return -EINVAL;
+
+	capability->cap[in->cap_id].cap_id = in->cap_id;
+	capability->cap[in->cap_id].min = in->min;
+	capability->cap[in->cap_id].max = in->max;
+	capability->cap[in->cap_id].step_or_mask = in->step_or_mask;
+	capability->cap[in->cap_id].value = in->value;
+	capability->cap[in->cap_id].flags = in->flags;
+	capability->cap[in->cap_id].v4l2_id = in->v4l2_id;
+	capability->cap[in->cap_id].hfi_id = in->hfi_id;
+	memcpy(capability->cap[in->cap_id].children, in->children,
+	       sizeof(capability->cap[in->cap_id].children));
+	capability->cap[in->cap_id].adjust = in->adjust;
+	capability->cap[in->cap_id].set = in->set;
+
+	return 0;
+}
+
+int iris_init_instance_caps(struct iris_core *core)
+{
+	struct plat_inst_cap *inst_plat_cap_data = NULL;
+	u8 dec_codecs_count = 0;
+	int num_inst_cap;
+	u32 dec_valid_codecs;
+	int i, j, check_bit = 0;
+	int ret = 0;
+
+	inst_plat_cap_data = core->platform_data->inst_cap_data;
+	if (!inst_plat_cap_data)
+		return -EINVAL;
+
+	dec_valid_codecs = core->cap[DEC_CODECS].value;
+	dec_codecs_count = hweight32(dec_valid_codecs);
+	core->dec_codecs_count = dec_codecs_count;
+
+	core->inst_caps = devm_kzalloc(core->dev,
+				       dec_codecs_count * sizeof(struct plat_inst_caps),
+				       GFP_KERNEL);
+	if (!core->inst_caps)
+		return -ENOMEM;
+
+	for (i = 0; i < dec_codecs_count; i++) {
+		while (check_bit < (sizeof(dec_valid_codecs) * 8)) {
+			if (dec_valid_codecs & BIT(check_bit)) {
+				core->inst_caps[i].codec = dec_valid_codecs &
+						BIT(check_bit);
+				check_bit++;
+				break;
+			}
+			check_bit++;
+		}
+	}
+
+	num_inst_cap = core->platform_data->inst_cap_data_size;
+
+	for (i = 0; i < num_inst_cap; i++) {
+		for (j = 0; j < dec_codecs_count; j++) {
+			if ((inst_plat_cap_data[i].codec &
+				core->inst_caps[j].codec)) {
+				ret = update_inst_capability(&inst_plat_cap_data[i],
+							     &core->inst_caps[j]);
+				if (ret)
+					return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+int get_inst_capability(struct iris_inst *inst)
+{
+	struct iris_core *core;
+	int i;
+
+	core = inst->core;
+
+	for (i = 0; i < core->dec_codecs_count; i++) {
+		if (core->inst_caps[i].codec == inst->codec) {
+			memcpy(&inst->cap[0], &core->inst_caps[i].cap[0],
+			       (INST_CAP_MAX + 1) * sizeof(struct plat_inst_cap));
+		}
+	}
+
+	return 0;
+}
+
+int prepare_dependency_list(struct iris_inst *inst)
+{
+	struct cap_entry *entry = NULL, *temp = NULL;
+	struct plat_inst_cap *cap, *temp_cap;
+	int caps_to_prepare, pending_list_counter,
+		pending_at_start = 0;
+	struct list_head prepared_list, pending_list;
+	bool is_prepared[INST_CAP_MAX];
+	bool is_pending[INST_CAP_MAX];
+	int i, ret = 0;
+
+	cap = &inst->cap[0];
+
+	if (!list_empty(&inst->caps_list))
+		return 0;
+
+	INIT_LIST_HEAD(&prepared_list);
+	INIT_LIST_HEAD(&pending_list);
+	memset(&is_prepared, 0, sizeof(is_prepared));
+	memset(&is_pending, 0, sizeof(is_pending));
+
+	for (i = 1; i < INST_CAP_MAX; i++) {
+		temp_cap = &cap[i];
+		if (!is_valid_cap_id(temp_cap->cap_id))
+			continue;
+
+		if (!temp_cap->children[0]) {
+			if (!is_prepared[temp_cap->cap_id]) {
+				ret = add_node_list(&prepared_list, temp_cap->cap_id);
+				if (ret)
+					goto free_list;
+				is_prepared[temp_cap->cap_id] = true;
+			}
+		} else {
+			if (!is_pending[temp_cap->cap_id]) {
+				ret = add_node_list(&pending_list, temp_cap->cap_id);
+				if (ret)
+					goto free_list;
+				is_pending[temp_cap->cap_id] = true;
+			}
+		}
+	}
+
+	list_for_each_entry(entry, &pending_list, list)
+		pending_at_start++;
+
+	caps_to_prepare = pending_at_start;
+	pending_list_counter = pending_at_start;
+
+	list_for_each_entry_safe(entry, temp, &pending_list, list) {
+		list_del_init(&entry->list);
+		is_pending[entry->cap_id] = false;
+		pending_list_counter--;
+		temp_cap = &cap[entry->cap_id];
+
+		if (are_all_childrens_visited(temp_cap, is_prepared)) {
+			list_add(&entry->list, &prepared_list);
+			is_prepared[entry->cap_id] = true;
+			caps_to_prepare--;
+		} else {
+			list_add_tail(&entry->list, &pending_list);
+			is_pending[entry->cap_id] = true;
+		}
+
+		if (!pending_list_counter) {
+			if (pending_at_start == caps_to_prepare) {
+				ret = -EINVAL;
+				goto free_list;
+			}
+			pending_at_start = caps_to_prepare;
+			pending_list_counter = caps_to_prepare;
+		}
+	}
+
+	if (!list_empty(&pending_list)) {
+		ret = -EINVAL;
+		goto free_list;
+	}
+
+	list_replace_init(&prepared_list, &inst->caps_list);
+
+free_list:
+	list_for_each_entry_safe(entry, temp, &pending_list, list) {
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+	list_for_each_entry_safe(entry, temp, &prepared_list, list) {
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+
+	return ret;
+}
+
+int set_u32_enum(struct iris_inst *inst,
+		 enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_value = inst->cap[cap_id].value;
+	u32 hfi_id = inst->cap[cap_id].hfi_id;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32_ENUM,
+				     &hfi_value, sizeof(u32));
+}
+
+int set_u32(struct iris_inst *inst,
+	    enum plat_inst_cap_type cap_id)
+{
+	u32 hfi_value = inst->cap[cap_id].value;
+	u32 hfi_id = inst->cap[cap_id].hfi_id;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32,
+				     &hfi_value, sizeof(u32));
+}
+
+int set_stage(struct iris_inst *inst,
+	      enum plat_inst_cap_type cap_id)
+{
+	struct v4l2_format *inp_f;
+	u32 work_mode = STAGE_2;
+	u32 width, height;
+	u32 hfi_id;
+
+	hfi_id = inst->cap[cap_id].hfi_id;
+
+	inp_f = inst->fmt_src;
+	height = inp_f->fmt.pix_mp.height;
+	width = inp_f->fmt.pix_mp.width;
+	if (res_is_less_than(width, height, 1280, 720))
+		work_mode = STAGE_1;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32,
+				     &work_mode, sizeof(u32));
+}
+
+int set_pipe(struct iris_inst *inst,
+	     enum plat_inst_cap_type cap_id)
+{
+	u32 work_route, hfi_id;
+
+	work_route = inst->cap[PIPE].value;
+	hfi_id = inst->cap[cap_id].hfi_id;
+
+	return iris_hfi_set_property(inst, hfi_id, HFI_HOST_FLAGS_NONE,
+				     get_port_info(inst, cap_id),
+				     HFI_PAYLOAD_U32,
+				     &work_route, sizeof(u32));
+}
+
+int adjust_v4l2_properties(struct iris_inst *inst)
+{
+	struct cap_entry *entry = NULL, *temp = NULL;
+	int ret = 0;
+
+	list_for_each_entry_safe(entry, temp, &inst->caps_list, list) {
+		ret = adjust_cap(inst, entry->cap_id, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int adjust_output_order(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	s32 display_delay = -1, display_delay_enable = -1;
+	u32 adjusted_value;
+
+	adjusted_value = ctrl ? ctrl->val :
+		inst->cap[OUTPUT_ORDER].value;
+
+	display_delay = inst->cap[DISPLAY_DELAY].value;
+	display_delay_enable = inst->cap[DISPLAY_DELAY_ENABLE].value;
+
+	if (display_delay_enable && !display_delay)
+		adjusted_value = 1;
+
+	inst->cap[OUTPUT_ORDER].value = adjusted_value;
+
+	return 0;
+}
+
+int adjust_profile(struct iris_inst *inst, struct v4l2_ctrl *ctrl)
+{
+	u32 adjusted_value;
+	s32 pix_fmt = -1;
+
+	adjusted_value = ctrl ? ctrl->val :
+		inst->cap[PROFILE].value;
+
+	pix_fmt = inst->cap[PIX_FMTS].value;
+
+	if (pix_fmt == FMT_TP10C)
+		adjusted_value = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10;
+	else
+		adjusted_value = V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN;
+
+	inst->cap[PROFILE].value = adjusted_value;
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
new file mode 100644
index 0000000..0f67f4f
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_CTRLS_H_
+#define _IRIS_CTRLS_H_
+
+#include "iris_instance.h"
+
+struct cap_entry {
+	struct list_head list;
+	enum plat_inst_cap_type cap_id;
+};
+
+int set_u32_enum(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_stage(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_pipe(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int set_u32(struct iris_inst *inst, enum plat_inst_cap_type cap_id);
+int adjust_output_order(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int adjust_profile(struct iris_inst *inst, struct v4l2_ctrl *ctrl);
+int vidc_ctrl_handler_deinit(struct iris_inst *inst);
+int prepare_dependency_list(struct iris_inst *inst);
+int iris_init_instance_caps(struct iris_core *core);
+int iris_init_core_caps(struct iris_core *core);
+int get_inst_capability(struct iris_inst *inst);
+int adjust_v4l2_properties(struct iris_inst *inst);
+int ctrls_init(struct iris_inst *inst);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index 872268d..8d8bc3a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -5,6 +5,7 @@
 
 #include "iris_helpers.h"
 #include "iris_hfi.h"
+#include "iris_hfi_packet.h"
 #include "iris_instance.h"
 
 int check_core_lock(struct iris_core *core)
@@ -16,23 +17,29 @@ int check_core_lock(struct iris_core *core)
 	return fatal ? -EINVAL : 0;
 }
 
-int iris_init_core_caps(struct iris_core *core)
+bool res_is_less_than(u32 width, u32 height,
+		      u32 ref_width, u32 ref_height)
 {
-	struct plat_core_cap *core_platform_data;
-	int i, num_core_caps;
+	u32 num_mbs = NUM_MBS_PER_FRAME(height, width);
+	u32 max_side = max(ref_width, ref_height);
 
-	core_platform_data = core->platform_data->core_data;
-	if (!core_platform_data)
-		return -EINVAL;
+	if (num_mbs < NUM_MBS_PER_FRAME(ref_height, ref_width) &&
+	    width < max_side &&
+	    height < max_side)
+		return true;
 
-	num_core_caps = core->platform_data->core_data_size;
+	return false;
+}
 
-	for (i = 0; i < num_core_caps && i < CORE_CAP_MAX; i++) {
-		core->cap[core_platform_data[i].type].type = core_platform_data[i].type;
-		core->cap[core_platform_data[i].type].value = core_platform_data[i].value;
-	}
+u32 get_port_info(struct iris_inst *inst,
+		  enum plat_inst_cap_type cap_id)
+{
+	if (inst->cap[cap_id].flags & CAP_FLAG_INPUT_PORT)
+		return HFI_PORT_BITSTREAM;
+	else if (inst->cap[cap_id].flags & CAP_FLAG_OUTPUT_PORT)
+		return HFI_PORT_RAW;
 
-	return 0;
+	return HFI_PORT_NONE;
 }
 
 static int process_inst_timeout(struct iris_inst *inst)
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index b9a6485..60c79124 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -6,11 +6,22 @@
 #ifndef _IRIS_HELPERS_H_
 #define _IRIS_HELPERS_H_
 
+#include <linux/align.h>
+#include <linux/types.h>
+
 #include "iris_core.h"
 #include "iris_instance.h"
+#include "platform_common.h"
+
+#define NUM_MBS_PER_FRAME(__height, __width) \
+	((ALIGN(__height, 16) / 16) * (ALIGN(__width, 16) / 16))
 
 int check_core_lock(struct iris_core *core);
-int iris_init_core_caps(struct iris_core *core);
+bool res_is_less_than(u32 width, u32 height,
+		      u32 ref_width, u32 ref_height);
+u32 get_port_info(struct iris_inst *inst,
+		  enum plat_inst_cap_type cap_id);
+
 int close_session(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index 4b8d8c7..24ddb98 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -10,6 +10,7 @@
 #include "iris_hfi.h"
 #include "iris_hfi_packet.h"
 #include "iris_hfi_response.h"
+#include "iris_helpers.h"
 #include "vpu_common.h"
 
 static int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt)
@@ -280,3 +281,31 @@ irqreturn_t iris_hfi_isr_handler(int irq, void *data)
 
 	return IRQ_HANDLED;
 }
+
+int iris_hfi_set_property(struct iris_inst *inst,
+			  u32 packet_type, u32 flag, u32 plane, u32 payload_type,
+			  void *payload, u32 payload_size)
+{
+	struct iris_core *core;
+	int ret;
+
+	core = inst->core;
+	mutex_lock(&core->lock);
+
+	ret = hfi_packet_session_property(inst,
+					  packet_type,
+					  flag,
+					  plane,
+					  payload_type,
+					  payload,
+					  payload_size);
+	if (ret)
+		goto unlock;
+
+	ret = iris_hfi_queue_cmd_write(core, inst->packet);
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index 8a62986..bf991bb 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -13,6 +13,9 @@ int iris_hfi_core_init(struct iris_core *core);
 int iris_hfi_core_deinit(struct iris_core *core);
 int iris_hfi_session_open(struct iris_inst *inst);
 int iris_hfi_session_close(struct iris_inst *inst);
+int iris_hfi_set_property(struct iris_inst *inst,
+			  u32 packet_type, u32 flag, u32 plane, u32 payload_type,
+			  void *payload, u32 payload_size);
 
 irqreturn_t iris_hfi_isr(int irq, void *data);
 irqreturn_t iris_hfi_isr_handler(int irq, void *data);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index 1ed572e..749d978 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -239,3 +239,29 @@ int hfi_packet_session_command(struct iris_inst *inst, u32 pkt_type,
 
 	return ret;
 }
+
+int hfi_packet_session_property(struct iris_inst *inst,
+				u32 pkt_type, u32 flags, u32 port,
+				u32 payload_type, void *payload, u32 payload_size)
+{
+	struct iris_core *core;
+	int ret;
+
+	core = inst->core;
+
+	ret = hfi_create_header(inst->packet, inst->packet_size,
+				inst->session_id, core->header_id++);
+	if (ret)
+		return ret;
+
+	ret = hfi_create_packet(inst->packet, inst->packet_size,
+				pkt_type,
+				flags,
+				payload_type,
+				port,
+				core->packet_id++,
+				payload,
+				payload_size);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
index 9e476e9..bea7ed9 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -74,5 +74,8 @@ int hfi_packet_session_command(struct iris_inst *inst, u32 pkt_type,
 			       u32 flags, u32 port, u32 session_id,
 			       u32 payload_type, void *payload,
 			       u32 payload_size);
+int hfi_packet_session_property(struct iris_inst *inst,
+				u32 pkt_type, u32 flags, u32 port,
+				u32 payload_type, void *payload, u32 payload_size);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
index 1bbb533..f6a3066 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -10,6 +10,7 @@
 
 #include "iris_core.h"
 #include "iris_common.h"
+#include "platform_common.h"
 
 /**
  * struct iris_inst - holds per video instance parameters
@@ -27,6 +28,10 @@
  * @packet: HFI packet
  * @packet_size: HFI packet size
  * @completions: structure of signal completions
+ * @cap: array of supported instance capabilities
+ * @num_ctrls: supported number of controls
+ * @caps_list: list head of capability
+ * @codec: codec type
  */
 
 struct iris_inst {
@@ -43,6 +48,10 @@ struct iris_inst {
 	void				*packet;
 	u32				packet_size;
 	struct completion		completions[MAX_SIGNAL];
+	struct plat_inst_cap		cap[INST_CAP_MAX + 1];
+	u32				num_ctrls;
+	struct list_head		caps_list;
+	enum codec_type			codec;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index 8c591da..50fb93e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -13,6 +13,7 @@
 #include "iris_hfi.h"
 #include "resources.h"
 #include "iris_vidc.h"
+#include "iris_ctrls.h"
 
 static int init_iris_isr(struct iris_core *core)
 {
@@ -158,6 +159,13 @@ static int iris_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = iris_init_instance_caps(core);
+	if (ret) {
+		dev_err_probe(core->dev, ret,
+			      "%s: init inst caps failed with %d\n", __func__, ret);
+		return ret;
+	}
+
 	ret = v4l2_device_register(dev, &core->v4l2_dev);
 	if (ret)
 		return ret;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index d02da8b..3a26edb 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -9,6 +9,7 @@
 #include "iris_instance.h"
 #include "iris_vdec.h"
 #include "iris_vidc.h"
+#include "iris_ctrls.h"
 
 static int vidc_v4l2_fh_init(struct iris_inst *inst)
 {
@@ -174,6 +175,10 @@ int vidc_open(struct file *filp)
 	if (ret)
 		goto fail_free_inst;
 
+	INIT_LIST_HEAD(&inst->caps_list);
+	for (i = 0; i < MAX_SIGNAL; i++)
+		init_completion(&inst->completions[i]);
+
 	ret = vidc_v4l2_fh_init(inst);
 	if (ret)
 		goto fail_remove_session;
@@ -184,6 +189,14 @@ int vidc_open(struct file *filp)
 	if (ret)
 		goto fail_inst_deinit;
 
+	ret = get_inst_capability(inst);
+	if (ret)
+		goto fail_queue_deinit;
+
+	ret = ctrls_init(inst);
+	if (ret)
+		goto fail_queue_deinit;
+
 	ret = iris_hfi_session_open(inst);
 	if (ret) {
 		dev_err(core->dev, "%s: session open failed\n", __func__);
@@ -194,7 +207,9 @@ int vidc_open(struct file *filp)
 	return 0;
 
 fail_core_deinit:
+	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	iris_core_deinit(core);
+fail_queue_deinit:
 	vidc_vb2_queue_deinit(inst);
 fail_inst_deinit:
 	vdec_inst_deinit(inst);
@@ -216,6 +231,7 @@ int vidc_close(struct file *filp)
 	if (!inst)
 		return -EINVAL;
 
+	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	vdec_inst_deinit(inst);
 	close_session(inst);
 	vidc_vb2_queue_deinit(inst);
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index e478b02..8305c65 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -7,8 +7,10 @@
 #define _PLATFORM_COMMON_H_
 
 #include <linux/bits.h>
+#include <media/v4l2-ctrls.h>
 
 struct iris_core;
+struct iris_inst;
 
 #define HW_RESPONSE_TIMEOUT_VALUE     (1000)
 
@@ -17,6 +19,7 @@ struct iris_core;
 
 #define CODED_FRAMES_PROGRESSIVE 0x0
 #define CODED_FRAMES_INTERLACE 0x1
+#define MAX_NUM_CHILD         10
 
 #define DEFAULT_MAX_HOST_BUF_COUNT			64
 #define DEFAULT_MAX_HOST_BURST_BUF_COUNT		256
@@ -163,6 +166,16 @@ struct plat_inst_cap {
 	u32 v4l2_id;
 	u32 hfi_id;
 	enum plat_inst_cap_flags flags;
+	enum plat_inst_cap_type children[MAX_NUM_CHILD];
+	int (*adjust)(struct iris_inst *inst,
+		      struct v4l2_ctrl *ctrl);
+	int (*set)(struct iris_inst *inst,
+		   enum plat_inst_cap_type cap_id);
+};
+
+struct plat_inst_caps {
+	enum codec_type codec;
+	struct plat_inst_cap cap[INST_CAP_MAX + 1];
 };
 
 struct platform_data {
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
index c75017e..0759ac5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
@@ -9,6 +9,7 @@
 #include <media/v4l2-ctrls.h>
 
 #include "hfi_defines.h"
+#include "iris_ctrls.h"
 #include "platform_common.h"
 #include "resources.h"
 
@@ -47,7 +48,16 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		FMT_NV12 | FMT_NV21 | FMT_NV12C,
 		FMT_NV12C},
 
-	{PIX_FMTS, HEVC | VP9,
+	{PIX_FMTS, HEVC,
+		FMT_NV12,
+		FMT_TP10C,
+		FMT_NV12 | FMT_NV21 | FMT_NV12C | FMT_TP10C,
+		FMT_NV12C,
+		0, 0,
+		CAP_FLAG_NONE,
+		{PROFILE}},
+
+	{PIX_FMTS, VP9,
 		FMT_NV12,
 		FMT_TP10C,
 		FMT_NV12 | FMT_NV21 | FMT_NV12C | FMT_TP10C,
@@ -88,7 +98,10 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		V4L2_MPEG_VIDEO_H264_PROFILE_HIGH,
 		V4L2_CID_MPEG_VIDEO_H264_PROFILE,
 		HFI_PROP_PROFILE,
-		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		NULL,
+		set_u32_enum},
 
 	{PROFILE, HEVC,
 		V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
@@ -99,7 +112,10 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
 		V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
 		HFI_PROP_PROFILE,
-		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		adjust_profile,
+		set_u32_enum},
 
 	{PROFILE, VP9,
 		V4L2_MPEG_VIDEO_VP9_PROFILE_0,
@@ -109,7 +125,10 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		V4L2_MPEG_VIDEO_VP9_PROFILE_0,
 		V4L2_CID_MPEG_VIDEO_VP9_PROFILE,
 		HFI_PROP_PROFILE,
-		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		NULL,
+		set_u32_enum},
 
 	{LEVEL, H264,
 		V4L2_MPEG_VIDEO_H264_LEVEL_1_0,
@@ -137,7 +156,10 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		V4L2_MPEG_VIDEO_H264_LEVEL_6_1,
 		V4L2_CID_MPEG_VIDEO_H264_LEVEL,
 		HFI_PROP_LEVEL,
-		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		NULL,
+		set_u32_enum},
 
 	{LEVEL, HEVC,
 		V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
@@ -158,7 +180,10 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1,
 		V4L2_CID_MPEG_VIDEO_HEVC_LEVEL,
 		HFI_PROP_LEVEL,
-		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		NULL,
+		set_u32_enum},
 
 	{LEVEL, VP9,
 		V4L2_MPEG_VIDEO_VP9_LEVEL_1_0,
@@ -178,7 +203,10 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		V4L2_MPEG_VIDEO_VP9_LEVEL_6_0,
 		V4L2_CID_MPEG_VIDEO_VP9_LEVEL,
 		HFI_PROP_LEVEL,
-		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		NULL,
+		set_u32_enum},
 
 	{HEVC_TIER, HEVC,
 		V4L2_MPEG_VIDEO_HEVC_TIER_MAIN,
@@ -188,46 +216,69 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		V4L2_MPEG_VIDEO_HEVC_TIER_HIGH,
 		V4L2_CID_MPEG_VIDEO_HEVC_TIER,
 		HFI_PROP_TIER,
-		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU},
+		CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+		{0},
+		NULL,
+		set_u32_enum},
 
 	{DISPLAY_DELAY_ENABLE, CODECS_ALL,
 		0, 1, 1, 0,
 		V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE,
 		HFI_PROP_DECODE_ORDER_OUTPUT,
-		CAP_FLAG_INPUT_PORT},
+		CAP_FLAG_INPUT_PORT,
+		{OUTPUT_ORDER},
+		NULL,
+		NULL},
 
 	{DISPLAY_DELAY, CODECS_ALL,
 		0, 1, 1, 0,
 		V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY,
 		HFI_PROP_DECODE_ORDER_OUTPUT,
-		CAP_FLAG_INPUT_PORT},
+		CAP_FLAG_INPUT_PORT,
+		{OUTPUT_ORDER},
+		NULL,
+		NULL},
 
 	{OUTPUT_ORDER, CODECS_ALL,
 		0, 1, 1, 0,
 		0,
 		HFI_PROP_DECODE_ORDER_OUTPUT,
-		CAP_FLAG_INPUT_PORT},
+		CAP_FLAG_INPUT_PORT,
+		{0},
+		adjust_output_order,
+		set_u32},
 
 	{INPUT_BUF_HOST_MAX_COUNT, CODECS_ALL,
 		DEFAULT_MAX_HOST_BUF_COUNT, DEFAULT_MAX_HOST_BURST_BUF_COUNT,
 		1, DEFAULT_MAX_HOST_BUF_COUNT,
 		0,
 		HFI_PROP_BUFFER_HOST_MAX_COUNT,
-		CAP_FLAG_INPUT_PORT},
+		CAP_FLAG_INPUT_PORT,
+		{0},
+		NULL,
+		set_u32},
 
 	{STAGE, CODECS_ALL,
 		STAGE_1,
 		STAGE_2, 1,
 		STAGE_2,
 		0,
-		HFI_PROP_STAGE},
+		HFI_PROP_STAGE,
+		CAP_FLAG_NONE,
+		{0},
+		NULL,
+		set_stage},
 
 	{PIPE, CODECS_ALL,
 		PIPE_1,
 		PIPE_4, 1,
 		PIPE_4,
 		0,
-		HFI_PROP_PIPE},
+		HFI_PROP_PIPE,
+		CAP_FLAG_NONE,
+		{0},
+		NULL,
+		set_pipe},
 
 	{POC, H264, 0, 2, 1, 1,
 		0,
@@ -252,7 +303,10 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		0, 1, 1, 1,
 		0,
 		HFI_PROP_DEC_START_FROM_RAP_FRAME,
-		CAP_FLAG_INPUT_PORT},
+		CAP_FLAG_INPUT_PORT,
+		{0},
+		NULL,
+		set_u32},
 };
 
 static const struct bus_info sm8550_bus_table[] = {
-- 
2.7.4


