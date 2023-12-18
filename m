Return-Path: <linux-kernel+bounces-3474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764B2816CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3552815AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C563B18A;
	Mon, 18 Dec 2023 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VwhnCAj2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA19B39AE0;
	Mon, 18 Dec 2023 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIAssR1018364;
	Mon, 18 Dec 2023 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=Fn5MQyElIA/ne+j5QqgL6eLBCk/yCOj7dBOuGhLSDLY=; b=Vw
	hnCAj2m/ZguBQ/kyO8yLolpbgB7v3QRrs+7APsLIez2aX7o6FUIFxdihm3phRqyR
	5zfSWPSS67V9jM3mPEzDfXg1gYDoPBUy8b9YH65wngMYqlR4I1HsU/57dLvzDw8V
	w1U3qQf1KhairlIFbIu+oVdvK9Sveqwn+XN7kmuFHRjAWihskIQrPDIg9Y/rK53D
	Xq1N7lzzsDF+CdZ2+sh7OaPFm4hL2OIeTkVNTCjS4hGaiI+K7u37mLcNk+kE7XY8
	uxxQJcU5DiUHceXFjVl8IHIZhdIExG72pDt1yHFQshM0mMyhevQ46LwP8ObFqcay
	D6HssxSZxBptbxHF8cyA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v156dm7qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:04 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX6PO029956;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ad-4;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX77k029983;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6Iw029963;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 420872305; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 14/34] media: iris: implement iris v4l2 file ops
Date: Mon, 18 Dec 2023 17:02:09 +0530
Message-Id: <1702899149-21321-15-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VPU_gMY1KiK2LJPhnV5D2jrAguq5PQvN
X-Proofpoint-GUID: VPU_gMY1KiK2LJPhnV5D2jrAguq5PQvN
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

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Implements iris v4l2 file ops - open, close and poll.

Open:
Configure the vb2 queue and v4l2 file handler. Initialize
a video instance and add the instance to core instance list.
Open a session in video firmware via HFI_CMD_OPEN.

Close:
De-initialize the instance and remove it from core
instance list. Close the session in firmware via HFI_CMD_CLOSE.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   2 +
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |   2 +
 .../media/platform/qcom/vcodec/iris/iris_common.h  |  26 ++
 .../media/platform/qcom/vcodec/iris/iris_core.c    |  42 ++-
 .../media/platform/qcom/vcodec/iris/iris_core.h    |   8 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c |  62 +++++
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |   2 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c | 115 +++++++-
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h |   3 +
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  28 ++
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |   7 +
 .../platform/qcom/vcodec/iris/iris_instance.h      |  48 ++++
 .../media/platform/qcom/vcodec/iris/iris_probe.c   |  10 +
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    |  47 ++++
 .../media/platform/qcom/vcodec/iris/iris_vdec.h    |  14 +
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    | 298 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_vidc.h    |  15 ++
 17 files changed, 719 insertions(+), 10 deletions(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_common.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_instance.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_vidc.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index c50e3241..3c076d0 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -3,6 +3,8 @@ iris-objs += ../hfi_queue.o ../firmware.o
 iris-objs += iris_probe.o \
              iris_state.o \
              iris_core.o \
+             iris_vidc.o \
+             iris_vdec.o \
              iris_state.o \
              iris_helpers.o \
              iris_hfi.o \
diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index fb383b2..423ba1a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -9,6 +9,8 @@
 #define HFI_VIDEO_ARCH_LX			0x1
 
 #define HFI_CMD_INIT				0x01000001
+#define HFI_CMD_OPEN				0x01000003
+#define HFI_CMD_CLOSE				0x01000004
 
 #define HFI_PROP_IMAGE_VERSION			0x03000001
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
new file mode 100644
index 0000000..3e4dd71
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _IRIS_COMMON_H_
+#define _IRIS_COMMON_H_
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/videobuf2-v4l2.h>
+
+#define INPUT_MPLANE V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE
+#define OUTPUT_MPLANE V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE
+#define DEFAULT_WIDTH 320
+#define DEFAULT_HEIGHT 240
+#define DEFAULT_BUF_SIZE 115200
+
+enum signal_session_response {
+	SIGNAL_CMD_STOP_INPUT = 0,
+	SIGNAL_CMD_STOP_OUTPUT,
+	SIGNAL_CMD_CLOSE,
+	MAX_SIGNAL,
+};
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.c b/drivers/media/platform/qcom/vcodec/iris/iris_core.c
index ba8960d..174fad9 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.c
@@ -3,12 +3,14 @@
  * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/delay.h>
+
 #include "iris_core.h"
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_state.h"
 
-static int iris_core_deinit_locked(struct iris_core *core)
+int iris_core_deinit_locked(struct iris_core *core)
 {
 	int ret;
 
@@ -68,3 +70,41 @@ int iris_core_init(struct iris_core *core)
 
 	return ret;
 }
+
+int iris_core_init_wait(struct iris_core *core)
+{
+	const int interval = 10;
+	int max_tries, count = 0, ret = 0;
+
+	mutex_lock(&core->lock);
+	if (!core_in_valid_state(core)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (core->state == IRIS_CORE_INIT)
+		goto unlock;
+
+	max_tries = core->cap[HW_RESPONSE_TIMEOUT].value / interval;
+	while (count < max_tries) {
+		if (core->state != IRIS_CORE_INIT_WAIT)
+			break;
+		msleep(interval);
+		count++;
+	}
+
+	if (core->state == IRIS_CORE_INIT) {
+		ret = 0;
+		goto unlock;
+	} else {
+		iris_change_core_state(core, IRIS_CORE_ERROR);
+		iris_core_deinit_locked(core);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index 3c8497a..b47520a 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -33,6 +33,8 @@
  * @clk_count: count of iris clocks
  * @reset_tbl: table of iris reset clocks
  * @reset_count: count of iris reset clocks
+ * @vb2_ops: iris vb2 ops
+ * @vb2_mem_ops: iris vb2 memory ops
  * @state: current state of core
  * @iface_q_table: Interface queue table memory
  * @command_queue: shared interface queue to send commands to firmware
@@ -49,6 +51,7 @@
  * @vpu_ops: a pointer to vpu ops
  * @platform_data: a structure for platform data
  * @cap: an array for supported core capabilities
+ * @instances: a list_head of all instances
  */
 
 struct iris_core {
@@ -67,6 +70,8 @@ struct iris_core {
 	u32					clk_count;
 	struct reset_info			*reset_tbl;
 	u32					reset_count;
+	const struct vb2_ops			*vb2_ops;
+	struct vb2_mem_ops			*vb2_mem_ops;
 	enum iris_core_state			state;
 	struct mem_desc				iface_q_table;
 	struct iface_q_info			command_queue;
@@ -83,9 +88,12 @@ struct iris_core {
 	const struct vpu_ops			*vpu_ops;
 	struct platform_data			*platform_data;
 	struct plat_core_cap			cap[CORE_CAP_MAX + 1];
+	struct list_head			instances;
 };
 
 int iris_core_init(struct iris_core *core);
+int iris_core_init_wait(struct iris_core *core);
 int iris_core_deinit(struct iris_core *core);
+int iris_core_deinit_locked(struct iris_core *core);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index c31dfd5..872268d 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -4,6 +4,8 @@
  */
 
 #include "iris_helpers.h"
+#include "iris_hfi.h"
+#include "iris_instance.h"
 
 int check_core_lock(struct iris_core *core)
 {
@@ -32,3 +34,63 @@ int iris_init_core_caps(struct iris_core *core)
 
 	return 0;
 }
+
+static int process_inst_timeout(struct iris_inst *inst)
+{
+	struct iris_inst *instance;
+	struct iris_core *core;
+	bool found = false;
+	int ret = 0;
+
+	core = inst->core;
+
+	mutex_lock(&core->lock);
+	list_for_each_entry(instance, &core->instances, list) {
+		if (instance == inst) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	iris_change_core_state(core, IRIS_CORE_ERROR);
+
+	iris_core_deinit_locked(core);
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+int close_session(struct iris_inst *inst)
+{
+	u32 hw_response_timeout_val;
+	bool wait_for_response;
+	struct iris_core *core;
+	int ret;
+
+	core = inst->core;
+	hw_response_timeout_val = core->cap[HW_RESPONSE_TIMEOUT].value;
+	wait_for_response = true;
+	ret = iris_hfi_session_close(inst);
+	if (ret)
+		wait_for_response = false;
+
+	kfree(inst->packet);
+	inst->packet = NULL;
+
+	if (wait_for_response) {
+		ret = wait_for_completion_timeout(&inst->completions[SIGNAL_CMD_CLOSE],
+						  msecs_to_jiffies(hw_response_timeout_val));
+		if (!ret) {
+			ret = -ETIMEDOUT;
+			process_inst_timeout(inst);
+		}
+	}
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index 4c7ddbf..b9a6485 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -7,8 +7,10 @@
 #define _IRIS_HELPERS_H_
 
 #include "iris_core.h"
+#include "iris_instance.h"
 
 int check_core_lock(struct iris_core *core);
 int iris_init_core_caps(struct iris_core *core);
+int close_session(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index b0390b542..d144ae5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -8,6 +8,7 @@
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_hfi_packet.h"
+#include "hfi_defines.h"
 #include "vpu_common.h"
 
 static int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt)
@@ -43,6 +44,27 @@ static int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt)
 	return ret;
 }
 
+static bool validate_session(struct iris_core *core,
+			     struct iris_inst *inst)
+{
+	struct iris_inst *temp;
+	bool valid = false;
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return false;
+
+	list_for_each_entry(temp, &core->instances, list) {
+		if (temp == inst) {
+			valid = true;
+			break;
+		}
+	}
+
+	return valid;
+}
+
 static int sys_init(struct iris_core *core)
 {
 	int ret;
@@ -69,14 +91,6 @@ static int sys_image_version(struct iris_core *core)
 	return ret;
 }
 
-#define CP_START           0
-#define CP_SIZE            0x25800000
-#define CP_NONPIXEL_START  0x01000000
-#define CP_NONPIXEL_SIZE   0x24800000
-
-#define FW_NAME "vpu30_4v.mbn"
-#define IRIS_PAS_ID 9
-
 int iris_hfi_core_init(struct iris_core *core)
 {
 	u32 cp_nonpixel_start, cp_nonpixel_size;
@@ -152,7 +166,90 @@ int iris_hfi_core_deinit(struct iris_core *core)
 	if (core->state == IRIS_CORE_DEINIT)
 		return 0;
 
-	unload_fw(IRIS_PAS_ID);
+	unload_fw(core->platform_data->pas_id);
+
+	return ret;
+}
+
+int iris_hfi_session_open(struct iris_inst *inst)
+{
+	struct iris_core *core;
+	int ret;
+
+	inst->packet_size = 4096;
+	inst->packet = kzalloc(inst->packet_size, GFP_KERNEL);
+	if (!inst->packet)
+		return -ENOMEM;
+
+	core = inst->core;
+	mutex_lock(&core->lock);
+
+	if (!validate_session(core, inst)) {
+		ret = -EINVAL;
+		goto fail_free_packet;
+	}
+
+	ret = hfi_packet_session_command(inst,
+					 HFI_CMD_OPEN,
+					 HFI_HOST_FLAGS_RESPONSE_REQUIRED |
+					 HFI_HOST_FLAGS_INTR_REQUIRED,
+					 HFI_PORT_NONE,
+					 0,
+					 HFI_PAYLOAD_U32,
+					 &inst->session_id,
+					 sizeof(u32));
+	if (ret)
+		goto fail_free_packet;
+
+	ret = iris_hfi_queue_cmd_write(core, inst->packet);
+	if (ret)
+		goto fail_free_packet;
+
+	mutex_unlock(&core->lock);
+
+	return ret;
+
+fail_free_packet:
+	kfree(inst->packet);
+	inst->packet = NULL;
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+int iris_hfi_session_close(struct iris_inst *inst)
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
 
 	return ret;
 }
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
index fcf9f28..8a057cc 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -6,9 +6,12 @@
 #ifndef _IRIS_HFI_H_
 #define _IRIS_HFI_H_
 
+#include "iris_instance.h"
 #include "iris_core.h"
 
 int iris_hfi_core_init(struct iris_core *core);
 int iris_hfi_core_deinit(struct iris_core *core);
+int iris_hfi_session_open(struct iris_inst *inst);
+int iris_hfi_session_close(struct iris_inst *inst);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index f31dd84..1ed572e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -211,3 +211,31 @@ int hfi_packet_image_version(struct iris_core *core,
 
 	return ret;
 }
+
+int hfi_packet_session_command(struct iris_inst *inst, u32 pkt_type,
+			       u32 flags, u32 port, u32 session_id,
+			       u32 payload_type, void *payload,
+			       u32 payload_size)
+{
+	struct iris_core *core;
+	int ret;
+
+	core = inst->core;
+
+	ret = hfi_create_header(inst->packet, inst->packet_size,
+				session_id, core->header_id++);
+	if (ret)
+		return ret;
+
+	ret = hfi_create_packet(inst->packet,
+				inst->packet_size,
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
index e36612c..9e476e9 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -6,6 +6,9 @@
 #ifndef _IRIS_HFI_PACKET_H_
 #define _IRIS_HFI_PACKET_H_
 
+#include "iris_core.h"
+#include "iris_instance.h"
+
 struct hfi_header {
 	u32 size;
 	u32 session_id;
@@ -67,5 +70,9 @@ int hfi_packet_sys_init(struct iris_core *core,
 			u8 *pkt, u32 pkt_size);
 int hfi_packet_image_version(struct iris_core *core,
 			     u8 *pkt, u32 pkt_size);
+int hfi_packet_session_command(struct iris_inst *inst, u32 pkt_type,
+			       u32 flags, u32 port, u32 session_id,
+			       u32 payload_type, void *payload,
+			       u32 payload_size);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_instance.h b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
new file mode 100644
index 0000000..1bbb533
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_instance.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_INSTANCE_H_
+#define _IRIS_INSTANCE_H_
+
+#include <media/v4l2-ctrls.h>
+
+#include "iris_core.h"
+#include "iris_common.h"
+
+/**
+ * struct iris_inst - holds per video instance parameters
+ *
+ * @list: used for attach an instance to the core
+ * @core: pointer to core structure
+ * @session_id: id of current video session
+ * @vb2q_src: source vb2 queue
+ * @vb2q_dst: destination vb2 queue
+ * @ctx_q_lock: lock to serialize queues related ioctls
+ * @fh: reference of v4l2 file handler
+ * @fmt_src: structure of v4l2_format for source
+ * @fmt_dst: structure of v4l2_format for destination
+ * @ctrl_handler: reference of v4l2 ctrl handler
+ * @packet: HFI packet
+ * @packet_size: HFI packet size
+ * @completions: structure of signal completions
+ */
+
+struct iris_inst {
+	struct list_head		list;
+	struct iris_core		*core;
+	u32				session_id;
+	struct vb2_queue		*vb2q_src;
+	struct vb2_queue		*vb2q_dst;
+	struct mutex			ctx_q_lock;/* lock to serialize queues related ioctls */
+	struct v4l2_fh			fh;
+	struct v4l2_format		*fmt_src;
+	struct v4l2_format		*fmt_dst;
+	struct v4l2_ctrl_handler	ctrl_handler;
+	void				*packet;
+	u32				packet_size;
+	struct completion		completions[MAX_SIGNAL];
+};
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index 9d6a6c5..4f20da8 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -11,6 +11,7 @@
 #include "iris_core.h"
 #include "iris_helpers.h"
 #include "resources.h"
+#include "iris_vidc.h"
 
 static int iris_register_video_device(struct iris_core *core)
 {
@@ -85,6 +86,8 @@ static int iris_probe(struct platform_device *pdev)
 	if (!core->packet)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&core->instances);
+
 	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(core->reg_base))
 		return PTR_ERR(core->reg_base);
@@ -107,6 +110,13 @@ static int iris_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = init_ops(core);
+	if (ret) {
+		dev_err_probe(core->dev, ret,
+			      "%s: init ops failed with %d\n", __func__, ret);
+		return ret;
+	}
+
 	ret = init_resources(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
new file mode 100644
index 0000000..984be34
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_common.h"
+#include "iris_vdec.h"
+
+void vdec_inst_init(struct iris_inst *inst)
+{
+	struct v4l2_format *f;
+
+	inst->fmt_src  = kzalloc(sizeof(*inst->fmt_src), GFP_KERNEL);
+	inst->fmt_dst  = kzalloc(sizeof(*inst->fmt_dst), GFP_KERNEL);
+	inst->vb2q_src = kzalloc(sizeof(*inst->vb2q_src), GFP_KERNEL);
+	inst->vb2q_dst = kzalloc(sizeof(*inst->vb2q_dst), GFP_KERNEL);
+
+	f = inst->fmt_src;
+	f->type = INPUT_MPLANE;
+	f->fmt.pix_mp.width = DEFAULT_WIDTH;
+	f->fmt.pix_mp.height = DEFAULT_HEIGHT;
+	f->fmt.pix_mp.pixelformat = V4L2_PIX_FMT_H264;
+	f->fmt.pix_mp.num_planes = 1;
+	f->fmt.pix_mp.plane_fmt[0].bytesperline = 0;
+	f->fmt.pix_mp.plane_fmt[0].sizeimage = DEFAULT_BUF_SIZE;
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+
+	f = inst->fmt_dst;
+	f->type = OUTPUT_MPLANE;
+	f->fmt.pix_mp.pixelformat = V4L2_PIX_FMT_QC08C;
+	f->fmt.pix_mp.width = ALIGN(DEFAULT_WIDTH, 128);
+	f->fmt.pix_mp.height = ALIGN(DEFAULT_HEIGHT, 32);
+	f->fmt.pix_mp.num_planes = 1;
+	f->fmt.pix_mp.plane_fmt[0].bytesperline = ALIGN(DEFAULT_WIDTH, 128);
+	f->fmt.pix_mp.plane_fmt[0].sizeimage = DEFAULT_BUF_SIZE;
+	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_DEFAULT;
+	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
+	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+}
+
+void vdec_inst_deinit(struct iris_inst *inst)
+{
+	kfree(inst->fmt_dst);
+	kfree(inst->fmt_src);
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
new file mode 100644
index 0000000..dc8f43f
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_VDEC_H_
+#define _IRIS_VDEC_H_
+
+#include "iris_instance.h"
+
+void vdec_inst_init(struct iris_inst *inst);
+void vdec_inst_deinit(struct iris_inst *inst);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
new file mode 100644
index 0000000..d02da8b
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_common.h"
+#include "iris_helpers.h"
+#include "iris_hfi.h"
+#include "iris_instance.h"
+#include "iris_vdec.h"
+#include "iris_vidc.h"
+
+static int vidc_v4l2_fh_init(struct iris_inst *inst)
+{
+	struct iris_core *core;
+
+	core = inst->core;
+
+	if (inst->fh.vdev)
+		return -EINVAL;
+
+	v4l2_fh_init(&inst->fh, core->vdev_dec);
+	inst->fh.ctrl_handler = &inst->ctrl_handler;
+	v4l2_fh_add(&inst->fh);
+
+	return 0;
+}
+
+static int vidc_v4l2_fh_deinit(struct iris_inst *inst)
+{
+	if (!inst->fh.vdev)
+		return 0;
+
+	v4l2_fh_del(&inst->fh);
+	inst->fh.ctrl_handler = NULL;
+	v4l2_fh_exit(&inst->fh);
+
+	return 0;
+}
+
+static int vb2q_init(struct iris_inst *inst,
+		     struct vb2_queue *q, enum v4l2_buf_type type)
+{
+	struct iris_core *core;
+
+	core = inst->core;
+
+	q->lock = &inst->ctx_q_lock;
+	q->type = type;
+	q->io_modes = VB2_MMAP | VB2_DMABUF;
+	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	q->ops = core->vb2_ops;
+	q->mem_ops = core->vb2_mem_ops;
+	q->drv_priv = inst;
+	q->copy_timestamp = 1;
+	q->min_buffers_needed = 0;
+	return vb2_queue_init(q);
+}
+
+static int vidc_vb2_queue_init(struct iris_inst *inst)
+{
+	int ret;
+
+	ret = vb2q_init(inst, inst->vb2q_src, INPUT_MPLANE);
+	if (ret)
+		return ret;
+
+	ret = vb2q_init(inst, inst->vb2q_dst, OUTPUT_MPLANE);
+	if (ret)
+		goto fail_vb2q_src_deinit;
+
+	return ret;
+
+fail_vb2q_src_deinit:
+	vb2_queue_release(inst->vb2q_src);
+
+	return ret;
+}
+
+static int vidc_vb2_queue_deinit(struct iris_inst *inst)
+{
+	vb2_queue_release(inst->vb2q_src);
+	kfree(inst->vb2q_src);
+	inst->vb2q_src = NULL;
+
+	vb2_queue_release(inst->vb2q_dst);
+	kfree(inst->vb2q_dst);
+	inst->vb2q_dst = NULL;
+
+	return 0;
+}
+
+static int vidc_add_session(struct iris_inst *inst)
+{
+	struct iris_core *core;
+	struct iris_inst *i;
+	u32 count = 0;
+	int ret = 0;
+
+	core = inst->core;
+
+	mutex_lock(&core->lock);
+	if (core->state != IRIS_CORE_INIT) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+	list_for_each_entry(i, &core->instances, list)
+		count++;
+
+	if (count < core->cap[MAX_SESSION_COUNT].value)
+		list_add_tail(&inst->list, &core->instances);
+	else
+		ret = -EAGAIN;
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+static int vidc_remove_session(struct iris_inst *inst)
+{
+	struct iris_inst *i, *temp;
+	struct iris_core *core;
+
+	core = inst->core;
+
+	mutex_lock(&core->lock);
+	list_for_each_entry_safe(i, temp, &core->instances, list) {
+		if (i->session_id == inst->session_id) {
+			list_del_init(&i->list);
+			break;
+		}
+	}
+	mutex_unlock(&core->lock);
+
+	return 0;
+}
+
+static struct iris_inst *get_vidc_inst(struct file *filp, void *fh)
+{
+	if (!filp || !filp->private_data)
+		return NULL;
+
+	return container_of(filp->private_data,
+					struct iris_inst, fh);
+}
+
+int vidc_open(struct file *filp)
+{
+	struct iris_core *core = video_drvdata(filp);
+	struct iris_inst *inst = NULL;
+	int i = 0;
+	int ret;
+
+	ret = iris_core_init(core);
+	if (ret)
+		return ret;
+
+	ret = iris_core_init_wait(core);
+	if (ret)
+		return ret;
+
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+
+	inst->core = core;
+	inst->session_id = hash32_ptr(inst);
+	mutex_init(&inst->ctx_q_lock);
+	for (i = 0; i < MAX_SIGNAL; i++)
+		init_completion(&inst->completions[i]);
+
+	ret = vidc_add_session(inst);
+	if (ret)
+		goto fail_free_inst;
+
+	ret = vidc_v4l2_fh_init(inst);
+	if (ret)
+		goto fail_remove_session;
+
+	vdec_inst_init(inst);
+
+	ret = vidc_vb2_queue_init(inst);
+	if (ret)
+		goto fail_inst_deinit;
+
+	ret = iris_hfi_session_open(inst);
+	if (ret) {
+		dev_err(core->dev, "%s: session open failed\n", __func__);
+		goto fail_core_deinit;
+	}
+	filp->private_data = &inst->fh;
+
+	return 0;
+
+fail_core_deinit:
+	iris_core_deinit(core);
+	vidc_vb2_queue_deinit(inst);
+fail_inst_deinit:
+	vdec_inst_deinit(inst);
+	vidc_v4l2_fh_deinit(inst);
+fail_remove_session:
+	vidc_remove_session(inst);
+fail_free_inst:
+	mutex_destroy(&inst->ctx_q_lock);
+	kfree(inst);
+
+	return ret;
+}
+
+int vidc_close(struct file *filp)
+{
+	struct iris_inst *inst;
+
+	inst = get_vidc_inst(filp, NULL);
+	if (!inst)
+		return -EINVAL;
+
+	vdec_inst_deinit(inst);
+	close_session(inst);
+	vidc_vb2_queue_deinit(inst);
+	vidc_v4l2_fh_deinit(inst);
+	vidc_remove_session(inst);
+	mutex_destroy(&inst->ctx_q_lock);
+	kfree(inst);
+
+	filp->private_data = NULL;
+
+	return 0;
+}
+
+static __poll_t get_poll_flags(struct iris_inst *inst, u32 plane)
+{
+	struct vb2_buffer *vb = NULL;
+	struct vb2_queue *q = NULL;
+	unsigned long flags = 0;
+	__poll_t poll = 0;
+
+	if (plane == INPUT_MPLANE)
+		q = inst->vb2q_src;
+	else if (plane == OUTPUT_MPLANE)
+		q = inst->vb2q_dst;
+
+	if (!q)
+		return EPOLLERR;
+
+	spin_lock_irqsave(&q->done_lock, flags);
+	if (!list_empty(&q->done_list))
+		vb = list_first_entry(&q->done_list, struct vb2_buffer,
+				      done_entry);
+	if (vb && (vb->state == VB2_BUF_STATE_DONE ||
+		   vb->state == VB2_BUF_STATE_ERROR)) {
+		if (plane == OUTPUT_MPLANE)
+			poll |= EPOLLIN | EPOLLRDNORM;
+		else if (plane == INPUT_MPLANE)
+			poll |= EPOLLOUT | EPOLLWRNORM;
+	}
+	spin_unlock_irqrestore(&q->done_lock, flags);
+
+	return poll;
+}
+
+static __poll_t vidc_poll(struct file *filp, struct poll_table_struct *pt)
+{
+	struct iris_inst *inst;
+	__poll_t poll = 0;
+
+	inst = get_vidc_inst(filp, NULL);
+	if (!inst)
+		return EPOLLERR;
+
+	poll_wait(filp, &inst->fh.wait, pt);
+	poll_wait(filp, &inst->vb2q_src->done_wq, pt);
+	poll_wait(filp, &inst->vb2q_dst->done_wq, pt);
+
+	if (v4l2_event_pending(&inst->fh))
+		poll |= EPOLLPRI;
+
+	poll |= get_poll_flags(inst, INPUT_MPLANE);
+	poll |= get_poll_flags(inst, OUTPUT_MPLANE);
+
+	return poll;
+}
+
+static const struct v4l2_file_operations v4l2_file_ops = {
+	.owner                          = THIS_MODULE,
+	.open                           = vidc_open,
+	.release                        = vidc_close,
+	.unlocked_ioctl                 = video_ioctl2,
+	.poll                           = vidc_poll,
+};
+
+int init_ops(struct iris_core *core)
+{
+	core->v4l2_file_ops = &v4l2_file_ops;
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.h b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.h
new file mode 100644
index 0000000..aebff44
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_VIDC_H_
+#define _IRIS_VIDC_H_
+
+#include "iris_core.h"
+
+int init_ops(struct iris_core *core);
+int vidc_open(struct file *filp);
+int vidc_close(struct file *filp);
+
+#endif
-- 
2.7.4


