Return-Path: <linux-kernel+bounces-3477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC8C816CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FF71C22B94
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C963D0B0;
	Mon, 18 Dec 2023 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NaJLUqwO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8F200DD;
	Mon, 18 Dec 2023 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBF2DJ020287;
	Mon, 18 Dec 2023 11:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=2B2H49iDz0W9d1l1UKpjzmSYJV0KYD6exsP+wHxqA5A=; b=Na
	JLUqwOqOT38WkcxXbRkTzJ3c4eb1DabZ/kkfrfqrYfNBXoEZfyrKY9F40Uj5fbGh
	iZQE6WRrVvPp26WL9eTPIbMHL+7yNP10FkZ9u1sBlUqiMwfciTgQaZg8TJIGfqEW
	ASUXXqlo1bhLE/OlvHnhStDJB8p1GhRaIL0Q+qR3sY1+/U+LVzFzDlt3V5W4bhHR
	OfIewkNo0OjEHkIYuChIsUJTXfwNLIOCuzRR51an3shAZ1AzkF9m+1mhDLN4mNEO
	vFAy+3erTwNN7FD2oRnGyFqoHUDx+5N/eGGqxClrvtmAGo8sOPM9t3+I2W5Q9Q1p
	EXRxkP0KNzLzoZIZVu0g==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2n1781tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:04 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBe0Hn004853;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00ae-3;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX77m029983;
	Mon, 18 Dec 2023 11:33:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6J0029963;
	Mon, 18 Dec 2023 11:33:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 620202358; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 27/34] media: iris: implement vb2 ops for buf_queue and firmware response
Date: Mon, 18 Dec 2023 17:02:22 +0530
Message-Id: <1702899149-21321-28-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gK5mxoCh8tKNMrmSfHTLRqXEaSkNTTdK
X-Proofpoint-GUID: gK5mxoCh8tKNMrmSfHTLRqXEaSkNTTdK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Implement vb2 ops for buf queue. Below are the different
buffer attributes:
BUF_ATTR_DEFERRED - buffer queued by client but not submitted
to firmware.
BUF_ATTR_READ_ONLY - processed buffer received from firmware
as read only. These buffers are held in firmware as reference
for future frame processing.
BUF_ATTR_PENDING_RELEASE - buffers requested to be released
from firmware.
BUF_ATTR_QUEUED - buffers submitted to firmware.
BUF_ATTR_DEQUEUED - buffers received from firmware.
BUF_ATTR_BUFFER_DONE - buffers sent back to vb2.

Buffers are submitted and received via HFI_CMD_BUFFER.
Firmware associates below flags during buffer response:
HFI_BUF_FW_FLAG_RELEASE_DONE - buffer released in firmware.
HFI_BUF_FW_FLAG_READONLY - buffer used as reference in firmware.

Input buffers dequeued from firmware are sent directly to vb2.

Output buffers if read only, are sent to vb2 and also maintained
in read only list. If the same read only buffer is received form
client, HFI_BUF_HOST_FLAG_READONLY is attached to the buffer and
submitted to firmware. Once the buffer is received from firmware
as non read only, it is removed from read only list.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/hfi_defines.h  |   6 +
 .../media/platform/qcom/vcodec/iris/iris_buffer.h  |   1 -
 .../media/platform/qcom/vcodec/iris/iris_common.h  |   9 +
 .../media/platform/qcom/vcodec/iris/iris_helpers.c | 369 +++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_helpers.h |  11 +-
 .../platform/qcom/vcodec/iris/iris_hfi_packet.c    |  28 ++
 .../platform/qcom/vcodec/iris/iris_hfi_packet.h    |   2 +
 .../platform/qcom/vcodec/iris/iris_hfi_response.c  | 392 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_state.c   |   8 +
 .../media/platform/qcom/vcodec/iris/iris_state.h   |   1 +
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.c |  81 +++++
 drivers/media/platform/qcom/vcodec/iris/iris_vb2.h |   1 +
 .../media/platform/qcom/vcodec/iris/iris_vdec.c    |  49 +++
 .../media/platform/qcom/vcodec/iris/iris_vdec.h    |   1 +
 .../media/platform/qcom/vcodec/iris/iris_vidc.c    |   2 +
 15 files changed, 959 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
index dfd1a4c..104ef9c 100644
--- a/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
+++ b/drivers/media/platform/qcom/vcodec/iris/hfi_defines.h
@@ -238,4 +238,10 @@ enum hfi_buffer_host_flags {
 	HFI_BUF_HOST_FLAGS_CB_NON_SECURE	= 0x00000200,
 };
 
+enum hfi_buffer_firmware_flags {
+	HFI_BUF_FW_FLAG_NONE		= 0x00000000,
+	HFI_BUF_FW_FLAG_RELEASE_DONE	= 0x00000001,
+	HFI_BUF_FW_FLAG_READONLY	= 0x00000010,
+};
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
index 8769c3d..59c4a10 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_buffer.h
@@ -58,7 +58,6 @@ int iris_destroy_internal_buffer(struct iris_inst *inst,
 int iris_destroy_internal_buffers(struct iris_inst *inst,
 				  u32 plane);
 int iris_release_input_internal_buffers(struct iris_inst *inst);
-
 int iris_alloc_and_queue_session_int_bufs(struct iris_inst *inst,
 					  enum iris_buffer_type buffer_type);
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_common.h b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
index 0fbd139..5fd96d3 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_common.h
@@ -23,6 +23,8 @@
 
 #define NUM_MBS_4k (((4096 + 15) >> 4) * ((2304 + 15) >> 4))
 
+#define MAX_DPB_COUNT 32
+
 #define MAX_DPB_LIST_ARRAY_SIZE (16 * 4)
 #define MAX_DPB_LIST_PAYLOAD_SIZE (16 * 4 * 4)
 
@@ -69,6 +71,13 @@ enum iris_buffer_type {
 	BUF_VPSS,
 };
 
+enum iris_buffer_flags {
+	BUF_FLAG_KEYFRAME	= 0x00000008,
+	BUF_FLAG_PFRAME		= 0x00000010,
+	BUF_FLAG_BFRAME		= 0x00000020,
+	BUF_FLAG_ERROR		= 0x00000040,
+};
+
 enum iris_buffer_attributes {
 	BUF_ATTR_DEFERRED		= BIT(0),
 	BUF_ATTR_READ_ONLY		= BIT(1),
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
index 7868566..a5b8aef 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -57,6 +57,18 @@ enum iris_buffer_type v4l2_type_to_driver(u32 type)
 	}
 }
 
+u32 v4l2_type_from_driver(enum iris_buffer_type buffer_type)
+{
+	switch (buffer_type) {
+	case BUF_INPUT:
+		return INPUT_MPLANE;
+	case BUF_OUTPUT:
+		return OUTPUT_MPLANE;
+	default:
+		return 0;
+	}
+}
+
 int get_mbpf(struct iris_inst *inst)
 {
 	int height = 0, width = 0;
@@ -390,13 +402,359 @@ static int kill_session(struct iris_inst *inst)
 	return 0;
 }
 
+struct iris_buffer *get_driver_buf(struct iris_inst *inst, u32 plane, u32 index)
+{
+	struct iris_buffer *iter = NULL;
+	struct iris_buffer *buf = NULL;
+	enum iris_buffer_type buf_type;
+	struct iris_buffers *buffers;
+
+	bool found = false;
+
+	buf_type = v4l2_type_to_driver(plane);
+	if (!buf_type)
+		return NULL;
+
+	buffers = iris_get_buffer_list(inst, buf_type);
+	if (!buffers)
+		return NULL;
+
+	list_for_each_entry(iter, &buffers->list, list) {
+		if (iter->index == index) {
+			found = true;
+			buf = iter;
+			break;
+		}
+	}
+
+	if (!found)
+		return NULL;
+
+	return buf;
+}
+
+static void process_requeued_readonly_buffers(struct iris_inst *inst,
+					      struct iris_buffer *buf)
+{
+	struct iris_buffer *ro_buf, *dummy;
+
+	list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
+		if (ro_buf->device_addr != buf->device_addr)
+			continue;
+		if (ro_buf->attr & BUF_ATTR_READ_ONLY &&
+		    !(ro_buf->attr & BUF_ATTR_PENDING_RELEASE)) {
+			buf->attr |= BUF_ATTR_READ_ONLY;
+
+			list_del_init(&ro_buf->list);
+			kfree(ro_buf);
+			break;
+		}
+	}
+}
+
+int queue_buffer(struct iris_inst *inst, struct iris_buffer *buf)
+{
+	int ret;
+
+	if (buf->type == BUF_OUTPUT)
+		process_requeued_readonly_buffers(inst, buf);
+
+	ret = iris_hfi_queue_buffer(inst, buf);
+	if (ret)
+		return ret;
+
+	buf->attr &= ~BUF_ATTR_DEFERRED;
+	buf->attr |= BUF_ATTR_QUEUED;
+
+	return ret;
+}
+
+int queue_deferred_buffers(struct iris_inst *inst, enum iris_buffer_type buf_type)
+{
+	struct iris_buffers *buffers;
+	struct iris_buffer *buf;
+	int ret = 0;
+
+	buffers = iris_get_buffer_list(inst, buf_type);
+	if (!buffers)
+		return -EINVAL;
+
+	list_for_each_entry(buf, &buffers->list, list) {
+		if (!(buf->attr & BUF_ATTR_DEFERRED))
+			continue;
+		ret = queue_buffer(inst, buf);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int iris_release_nonref_buffers(struct iris_inst *inst)
+{
+	u32 fw_ro_count = 0, nonref_ro_count = 0;
+	struct iris_buffer *ro_buf;
+	bool found = false;
+	int ret = 0;
+	int i = 0;
+
+	list_for_each_entry(ro_buf, &inst->buffers.read_only.list, list) {
+		if (!(ro_buf->attr & BUF_ATTR_READ_ONLY))
+			continue;
+		if (ro_buf->attr & BUF_ATTR_PENDING_RELEASE)
+			continue;
+		fw_ro_count++;
+	}
+
+	if (fw_ro_count <= MAX_DPB_COUNT)
+		return 0;
+
+	/*
+	 * Mark the read only buffers present in read_only list as
+	 * non-reference if it's not part of dpb_list_payload.
+	 * dpb_list_payload details:
+	 * payload[0-1]           : 64 bits base_address of DPB-1
+	 * payload[2]             : 32 bits addr_offset  of DPB-1
+	 * payload[3]             : 32 bits data_offset  of DPB-1
+	 */
+	list_for_each_entry(ro_buf, &inst->buffers.read_only.list, list) {
+		found = false;
+		if (!(ro_buf->attr & BUF_ATTR_READ_ONLY))
+			continue;
+		if (ro_buf->attr & BUF_ATTR_PENDING_RELEASE)
+			continue;
+		for (i = 0; (i + 3) < MAX_DPB_LIST_ARRAY_SIZE; i = i + 4) {
+			if (ro_buf->device_addr == inst->dpb_list_payload[i] &&
+			    ro_buf->data_offset == inst->dpb_list_payload[i + 3]) {
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			nonref_ro_count++;
+	}
+
+	if (nonref_ro_count <= inst->buffers.output.min_count)
+		return 0;
+
+	list_for_each_entry(ro_buf, &inst->buffers.read_only.list, list) {
+		found = false;
+		if (!(ro_buf->attr & BUF_ATTR_READ_ONLY))
+			continue;
+		if (ro_buf->attr & BUF_ATTR_PENDING_RELEASE)
+			continue;
+		for (i = 0; (i + 3) < MAX_DPB_LIST_ARRAY_SIZE; i = i + 4) {
+			if (ro_buf->device_addr == inst->dpb_list_payload[i] &&
+			    ro_buf->data_offset == inst->dpb_list_payload[i + 3]) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			ro_buf->attr |= BUF_ATTR_PENDING_RELEASE;
+			ret = iris_hfi_release_buffer(inst, ro_buf);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return ret;
+}
+
+int iris_vb2_buffer_done(struct iris_inst *inst,
+			 struct iris_buffer *buf)
+{
+	struct vb2_v4l2_buffer *vbuf;
+	struct vb2_queue *q = NULL;
+	struct vb2_buffer *iter;
+	struct vb2_buffer *vb2;
+	int type, state;
+	bool found;
+
+	type = v4l2_type_from_driver(buf->type);
+	if (!type)
+		return -EINVAL;
+
+	if (type == INPUT_MPLANE)
+		q = inst->vb2q_src;
+	else if (type == OUTPUT_MPLANE)
+		q = inst->vb2q_dst;
+	if (!q || !q->streaming)
+		return -EINVAL;
+
+	found = false;
+	list_for_each_entry(iter, &q->queued_list, queued_entry) {
+		if (iter->state != VB2_BUF_STATE_ACTIVE)
+			continue;
+		if (iter->index == buf->index) {
+			found = true;
+			vb2 = iter;
+			break;
+		}
+	}
+	if (!found)
+		return -EINVAL;
+
+	if (buf->flags & BUF_FLAG_ERROR)
+		state = VB2_BUF_STATE_ERROR;
+	else
+		state = VB2_BUF_STATE_DONE;
+
+	vbuf = to_vb2_v4l2_buffer(vb2);
+	vbuf->flags = buf->flags;
+	vb2->timestamp = buf->timestamp;
+	vb2->planes[0].bytesused = buf->data_size + vb2->planes[0].data_offset;
+	vb2_buffer_done(vb2, state);
+
+	return 0;
+}
+
+static int iris_flush_deferred_buffers(struct iris_inst *inst,
+				       enum iris_buffer_type type)
+{
+	struct iris_buffer *buf, *dummy;
+	struct iris_buffers *buffers;
+
+	buffers = iris_get_buffer_list(inst, type);
+	if (!buffers)
+		return -EINVAL;
+
+	list_for_each_entry_safe(buf, dummy, &buffers->list, list) {
+		if (buf->attr & BUF_ATTR_DEFERRED) {
+			if (!(buf->attr & BUF_ATTR_BUFFER_DONE)) {
+				buf->attr |= BUF_ATTR_BUFFER_DONE;
+				buf->data_size = 0;
+				iris_vb2_buffer_done(inst, buf);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int iris_flush_read_only_buffers(struct iris_inst *inst,
+					enum iris_buffer_type type)
+{
+	struct iris_buffer *ro_buf, *dummy;
+
+	if (type != BUF_OUTPUT)
+		return 0;
+
+	list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
+		if (ro_buf->attr & BUF_ATTR_READ_ONLY)
+			continue;
+		if (ro_buf->attach && ro_buf->sg_table)
+			dma_buf_unmap_attachment(ro_buf->attach, ro_buf->sg_table,
+						 DMA_BIDIRECTIONAL);
+		if (ro_buf->attach && ro_buf->dmabuf)
+			dma_buf_detach(ro_buf->dmabuf, ro_buf->attach);
+		ro_buf->attach = NULL;
+		ro_buf->sg_table = NULL;
+		ro_buf->dmabuf = NULL;
+		ro_buf->device_addr = 0x0;
+		list_del_init(&ro_buf->list);
+		kfree(ro_buf);
+	}
+
+	return 0;
+}
+
+void iris_destroy_buffers(struct iris_inst *inst)
+{
+	struct iris_buffer *buf, *dummy;
+	struct iris_buffers *buffers;
+
+	static const enum iris_buffer_type ext_buf_types[] = {
+		BUF_INPUT,
+		BUF_OUTPUT,
+	};
+	static const enum iris_buffer_type internal_buf_types[] = {
+		BUF_BIN,
+		BUF_COMV,
+		BUF_NON_COMV,
+		BUF_LINE,
+		BUF_DPB,
+		BUF_PERSIST,
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(internal_buf_types); i++) {
+		buffers = iris_get_buffer_list(inst, internal_buf_types[i]);
+		if (!buffers)
+			continue;
+		list_for_each_entry_safe(buf, dummy, &buffers->list, list)
+			iris_destroy_internal_buffer(inst, buf);
+	}
+
+	list_for_each_entry_safe(buf, dummy, &inst->buffers.read_only.list, list) {
+		if (buf->attach && buf->sg_table)
+			dma_buf_unmap_attachment(buf->attach, buf->sg_table, DMA_BIDIRECTIONAL);
+		if (buf->attach && buf->dmabuf)
+			dma_buf_detach(buf->dmabuf, buf->attach);
+		list_del_init(&buf->list);
+		kfree(buf);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ext_buf_types); i++) {
+		buffers = iris_get_buffer_list(inst, ext_buf_types[i]);
+		if (!buffers)
+			continue;
+		list_for_each_entry_safe(buf, dummy, &buffers->list, list) {
+			if (buf->attach && buf->sg_table)
+				dma_buf_unmap_attachment(buf->attach, buf->sg_table,
+							 DMA_BIDIRECTIONAL);
+			if (buf->attach && buf->dmabuf)
+				dma_buf_detach(buf->dmabuf, buf->attach);
+			list_del_init(&buf->list);
+			kfree(buf);
+		}
+	}
+}
+
+static int get_num_queued_buffers(struct iris_inst *inst,
+				  enum iris_buffer_type type)
+{
+	struct iris_buffers *buffers;
+	struct iris_buffer *vbuf;
+	int count = 0;
+
+	if (type == BUF_INPUT)
+		buffers = &inst->buffers.input;
+	else if (type == BUF_OUTPUT)
+		buffers = &inst->buffers.output;
+	else
+		return count;
+
+	list_for_each_entry(vbuf, &buffers->list, list) {
+		if (vbuf->type != type)
+			continue;
+		if (!(vbuf->attr & BUF_ATTR_QUEUED))
+			continue;
+		count++;
+	}
+
+	return count;
+}
+
 int session_streamoff(struct iris_inst *inst, u32 plane)
 {
 	enum signal_session_response signal_type;
+	enum iris_buffer_type buffer_type;
 	u32 hw_response_timeout_val;
 	struct iris_core *core;
+	int count = 0;
 	int ret;
 
+	if (plane == INPUT_MPLANE) {
+		signal_type = SIGNAL_CMD_STOP_INPUT;
+		buffer_type = BUF_INPUT;
+	} else if (plane == OUTPUT_MPLANE) {
+		signal_type = SIGNAL_CMD_STOP_OUTPUT;
+		buffer_type = BUF_OUTPUT;
+	} else {
+		return -EINVAL;
+	}
+
 	ret = iris_hfi_stop(inst, plane);
 	if (ret)
 		goto error;
@@ -417,14 +775,25 @@ int session_streamoff(struct iris_inst *inst, u32 plane)
 	if (ret)
 		goto error;
 
+	/* no more queued buffers after streamoff */
+	count = get_num_queued_buffers(inst, buffer_type);
+	if (count) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	ret = iris_inst_state_change_streamoff(inst, plane);
 	if (ret)
 		goto error;
 
+	iris_flush_deferred_buffers(inst, buffer_type);
+	iris_flush_read_only_buffers(inst, buffer_type);
 	return 0;
 
 error:
 	kill_session(inst);
+	iris_flush_deferred_buffers(inst, buffer_type);
+	iris_flush_read_only_buffers(inst, buffer_type);
 
 	return ret;
 }
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
index 47a017d..3a9889e 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -24,6 +24,7 @@ bool res_is_less_than(u32 width, u32 height,
 u32 get_port_info(struct iris_inst *inst,
 		  enum plat_inst_cap_type cap_id);
 enum iris_buffer_type v4l2_type_to_driver(u32 type);
+u32 v4l2_type_from_driver(enum iris_buffer_type buffer_type);
 int get_mbpf(struct iris_inst *inst);
 int close_session(struct iris_inst *inst);
 
@@ -34,7 +35,6 @@ bool is_split_mode_enabled(struct iris_inst *inst);
 int signal_session_msg_receipt(struct iris_inst *inst,
 			       enum signal_session_response cmd);
 struct iris_inst *to_instance(struct iris_core *core, u32 session_id);
-int session_streamoff(struct iris_inst *inst, u32 plane);
 
 u32 v4l2_codec_from_driver(struct iris_inst *inst, enum codec_type codec);
 enum codec_type v4l2_codec_to_driver(struct iris_inst *inst, u32 v4l2_codec);
@@ -43,4 +43,13 @@ enum colorformat_type v4l2_colorformat_to_driver(struct iris_inst *inst, u32 v4l
 struct vb2_queue *get_vb2q(struct iris_inst *inst, u32 type);
 int check_session_supported(struct iris_inst *inst);
 
+struct iris_buffer *get_driver_buf(struct iris_inst *inst, u32 plane, u32 index);
+int queue_buffer(struct iris_inst *inst, struct iris_buffer *buf);
+int queue_deferred_buffers(struct iris_inst *inst, enum iris_buffer_type buf_type);
+int iris_vb2_buffer_done(struct iris_inst *inst,
+			 struct iris_buffer *buf);
+int iris_release_nonref_buffers(struct iris_inst *inst);
+void iris_destroy_buffers(struct iris_inst *inst);
+int session_streamoff(struct iris_inst *inst, u32 plane);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
index b8785a9..8dafd04 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.c
@@ -76,6 +76,34 @@ static u32 hfi_buf_type_from_driver(enum iris_buffer_type buffer_type)
 	}
 }
 
+u32 hfi_buf_type_to_driver(enum hfi_buffer_type buf_type)
+{
+	switch (buf_type) {
+	case HFI_BUFFER_BITSTREAM:
+		return BUF_INPUT;
+	case HFI_BUFFER_RAW:
+		return BUF_OUTPUT;
+	case HFI_BUFFER_BIN:
+		return BUF_BIN;
+	case HFI_BUFFER_ARP:
+		return BUF_ARP;
+	case HFI_BUFFER_COMV:
+		return BUF_COMV;
+	case HFI_BUFFER_NON_COMV:
+		return BUF_NON_COMV;
+	case HFI_BUFFER_LINE:
+		return BUF_LINE;
+	case HFI_BUFFER_DPB:
+		return BUF_DPB;
+	case HFI_BUFFER_PERSIST:
+		return BUF_PERSIST;
+	case HFI_BUFFER_VPSS:
+		return BUF_VPSS;
+	default:
+		return 0;
+	}
+}
+
 u32 get_hfi_codec(struct iris_inst *inst)
 {
 	switch (inst->codec) {
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
index cf0960b6..8999c28 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_packet.h
@@ -6,6 +6,7 @@
 #ifndef _IRIS_HFI_PACKET_H_
 #define _IRIS_HFI_PACKET_H_
 
+#include "hfi_defines.h"
 #include "iris_core.h"
 #include "iris_instance.h"
 
@@ -89,6 +90,7 @@ u32 get_hfi_matrix_coefficients(u32 coefficients);
 u32 get_v4l2_color_primaries(u32 hfi_primaries);
 u32 get_v4l2_transfer_char(u32 hfi_characterstics);
 u32 get_v4l2_matrix_coefficients(u32 hfi_coefficients);
+u32 hfi_buf_type_to_driver(enum hfi_buffer_type buf_type);
 int get_hfi_buffer(struct iris_buffer *buffer, struct hfi_buffer *buf);
 
 int hfi_packet_sys_init(struct iris_core *core,
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
index 4ca9314..b1236dd 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi_response.c
@@ -4,6 +4,7 @@
  */
 
 #include "hfi_defines.h"
+#include "iris_buffer.h"
 #include "iris_helpers.h"
 #include "iris_hfi_packet.h"
 #include "iris_hfi_response.h"
@@ -21,6 +22,11 @@ struct iris_inst_hfi_range {
 	int (*handle)(struct iris_inst *inst, struct hfi_packet *pkt);
 };
 
+struct iris_hfi_buffer_handle {
+	enum hfi_buffer_type type;
+	int (*handle)(struct iris_inst *inst, struct hfi_buffer *buffer);
+};
+
 struct iris_hfi_packet_handle {
 	enum hfi_buffer_type type;
 	int (*handle)(struct iris_inst *inst, struct hfi_packet *pkt);
@@ -44,6 +50,94 @@ static void print_sfr_message(struct iris_core *core)
 	}
 }
 
+static bool is_valid_hfi_buffer_type(u32 buffer_type)
+{
+	if (buffer_type != HFI_BUFFER_BITSTREAM &&
+	    buffer_type != HFI_BUFFER_RAW &&
+	    buffer_type != HFI_BUFFER_BIN &&
+	    buffer_type != HFI_BUFFER_ARP &&
+	    buffer_type != HFI_BUFFER_COMV &&
+	    buffer_type != HFI_BUFFER_NON_COMV &&
+	    buffer_type != HFI_BUFFER_LINE &&
+	    buffer_type != HFI_BUFFER_DPB &&
+	    buffer_type != HFI_BUFFER_PERSIST &&
+	    buffer_type != HFI_BUFFER_VPSS) {
+		return false;
+	}
+
+	return true;
+}
+
+static bool is_valid_hfi_port(u32 port, u32 buffer_type)
+{
+	if (port == HFI_PORT_NONE &&
+	    buffer_type != HFI_BUFFER_PERSIST)
+		return false;
+
+	if (port != HFI_PORT_BITSTREAM && port != HFI_PORT_RAW)
+		return false;
+
+	return true;
+}
+
+static int get_driver_buffer_flags(struct iris_inst *inst, u32 hfi_flags)
+{
+	u32 driver_flags = 0;
+
+	if (inst->hfi_frame_info.picture_type & HFI_PICTURE_IDR)
+		driver_flags |= BUF_FLAG_KEYFRAME;
+	else if (inst->hfi_frame_info.picture_type & HFI_PICTURE_P)
+		driver_flags |= BUF_FLAG_PFRAME;
+	else if (inst->hfi_frame_info.picture_type & HFI_PICTURE_B)
+		driver_flags |= BUF_FLAG_BFRAME;
+	else if (inst->hfi_frame_info.picture_type & HFI_PICTURE_I)
+		driver_flags |= BUF_FLAG_KEYFRAME;
+	else if (inst->hfi_frame_info.picture_type & HFI_PICTURE_CRA)
+		driver_flags |= BUF_FLAG_KEYFRAME;
+	else if (inst->hfi_frame_info.picture_type & HFI_PICTURE_BLA)
+		driver_flags |= BUF_FLAG_KEYFRAME;
+
+	if (inst->hfi_frame_info.data_corrupt)
+		driver_flags |= BUF_FLAG_ERROR;
+
+	if (inst->hfi_frame_info.overflow)
+		driver_flags |= BUF_FLAG_ERROR;
+
+	return driver_flags;
+}
+
+static bool validate_packet_payload(struct hfi_packet *pkt)
+{
+	u32 payload_size = 0;
+
+	switch (pkt->payload_info) {
+	case HFI_PAYLOAD_U32:
+	case HFI_PAYLOAD_S32:
+	case HFI_PAYLOAD_Q16:
+	case HFI_PAYLOAD_U32_ENUM:
+	case HFI_PAYLOAD_32_PACKED:
+		payload_size = 4;
+		break;
+	case HFI_PAYLOAD_U64:
+	case HFI_PAYLOAD_S64:
+	case HFI_PAYLOAD_64_PACKED:
+		payload_size = 8;
+		break;
+	case HFI_PAYLOAD_STRUCTURE:
+		if (pkt->type == HFI_CMD_BUFFER)
+			payload_size = sizeof(struct hfi_buffer);
+		break;
+	default:
+		payload_size = 0;
+		break;
+	}
+
+	if (pkt->size < sizeof(struct hfi_packet) + payload_size)
+		return false;
+
+	return true;
+}
+
 static int validate_packet(u8 *response_pkt, u8 *core_resp_pkt, u32 core_resp_pkt_size)
 {
 	u32 response_pkt_size = 0;
@@ -168,6 +262,293 @@ static int handle_session_close(struct iris_inst *inst,
 	return 0;
 }
 
+static int handle_read_only_buffer(struct iris_inst *inst,
+				   struct iris_buffer *buf)
+{
+	struct iris_buffer *ro_buf, *iter;
+	bool found = false;
+
+	list_for_each_entry(iter, &inst->buffers.read_only.list, list) {
+		if (iter->device_addr == buf->device_addr) {
+			found = true;
+			ro_buf = iter;
+			break;
+		}
+	}
+
+	if (!found) {
+		ro_buf = kzalloc(sizeof(*ro_buf), GFP_KERNEL);
+		if (!ro_buf)
+			return -ENOMEM;
+		ro_buf->index = -1;
+		ro_buf->inst = inst;
+		ro_buf->type = buf->type;
+		ro_buf->fd = buf->fd;
+		ro_buf->dmabuf = buf->dmabuf;
+		ro_buf->device_addr = buf->device_addr;
+		ro_buf->data_offset = buf->data_offset;
+		INIT_LIST_HEAD(&ro_buf->list);
+		list_add_tail(&ro_buf->list, &inst->buffers.read_only.list);
+	}
+	ro_buf->attr |= BUF_ATTR_READ_ONLY;
+
+	return 0;
+}
+
+static int handle_non_read_only_buffer(struct iris_inst *inst,
+				       struct hfi_buffer *buffer)
+{
+	struct iris_buffer *ro_buf;
+
+	list_for_each_entry(ro_buf, &inst->buffers.read_only.list, list) {
+		if (ro_buf->device_addr == buffer->base_address) {
+			ro_buf->attr &= ~BUF_ATTR_READ_ONLY;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int handle_release_output_buffer(struct iris_inst *inst,
+					struct hfi_buffer *buffer)
+{
+	struct iris_buffer *buf, *iter;
+	bool found = false;
+
+	list_for_each_entry(iter, &inst->buffers.read_only.list, list) {
+		if (iter->device_addr == buffer->base_address &&
+		    iter->attr & BUF_ATTR_PENDING_RELEASE) {
+			found = true;
+			buf = iter;
+			break;
+		}
+	}
+	if (!found)
+		return -EINVAL;
+
+	buf->attr &= ~BUF_ATTR_READ_ONLY;
+	buf->attr &= ~BUF_ATTR_PENDING_RELEASE;
+
+	return 0;
+}
+
+static int handle_input_buffer(struct iris_inst *inst,
+			       struct hfi_buffer *buffer)
+{
+	struct iris_buffers *buffers;
+	struct iris_buffer *buf, *iter;
+	bool found;
+
+	buffers = iris_get_buffer_list(inst, BUF_INPUT);
+	if (!buffers)
+		return -EINVAL;
+
+	found = false;
+	list_for_each_entry(iter, &buffers->list, list) {
+		if (iter->index == buffer->index) {
+			found = true;
+			buf = iter;
+			break;
+		}
+	}
+	if (!found)
+		return -EINVAL;
+
+	if (!(buf->attr & BUF_ATTR_QUEUED))
+		return 0;
+
+	buf->data_size = buffer->data_size;
+	buf->attr &= ~BUF_ATTR_QUEUED;
+	buf->attr |= BUF_ATTR_DEQUEUED;
+
+	buf->flags = get_driver_buffer_flags(inst, buffer->flags);
+
+	return 0;
+}
+
+static int handle_output_buffer(struct iris_inst *inst,
+				struct hfi_buffer *hfi_buffer)
+{
+	struct iris_buffers *buffers;
+	struct iris_buffer *buf, *iter;
+	bool found;
+	int ret = 0;
+
+	if (hfi_buffer->flags & HFI_BUF_FW_FLAG_RELEASE_DONE)
+		return handle_release_output_buffer(inst, hfi_buffer);
+
+	if (!(hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY))
+		ret = handle_non_read_only_buffer(inst, hfi_buffer);
+
+	buffers = iris_get_buffer_list(inst, BUF_OUTPUT);
+	if (!buffers)
+		return -EINVAL;
+
+	found = false;
+	list_for_each_entry(iter, &buffers->list, list) {
+		if (!(iter->attr & BUF_ATTR_QUEUED))
+			continue;
+
+		found = (iter->index == hfi_buffer->index &&
+				iter->device_addr == hfi_buffer->base_address &&
+				iter->data_offset == hfi_buffer->data_offset);
+
+		if (found) {
+			buf = iter;
+			break;
+		}
+	}
+	if (!found)
+		return 0;
+
+	buf->data_offset = hfi_buffer->data_offset;
+	buf->data_size = hfi_buffer->data_size;
+	buf->timestamp = hfi_buffer->timestamp;
+
+	buf->attr &= ~BUF_ATTR_QUEUED;
+	buf->attr |= BUF_ATTR_DEQUEUED;
+
+	if (inst->buffers.dpb.size && hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY)
+		iris_inst_change_state(inst, IRIS_INST_ERROR);
+
+	if (hfi_buffer->flags & HFI_BUF_FW_FLAG_READONLY) {
+		buf->attr |= BUF_ATTR_READ_ONLY;
+		ret = handle_read_only_buffer(inst, buf);
+	} else {
+		buf->attr &= ~BUF_ATTR_READ_ONLY;
+	}
+
+	buf->flags = get_driver_buffer_flags(inst, hfi_buffer->flags);
+
+	return ret;
+}
+
+static int handle_dequeue_buffers(struct iris_inst *inst)
+{
+	struct iris_buffers *buffers;
+	struct iris_buffer *dummy;
+	struct iris_buffer *buf;
+	int ret = 0;
+	int i;
+	static const enum iris_buffer_type buffer_type[] = {
+		BUF_INPUT,
+		BUF_OUTPUT,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(buffer_type); i++) {
+		buffers = iris_get_buffer_list(inst, buffer_type[i]);
+		if (!buffers)
+			return -EINVAL;
+
+		list_for_each_entry_safe(buf, dummy, &buffers->list, list) {
+			if (buf->attr & BUF_ATTR_DEQUEUED) {
+				buf->attr &= ~BUF_ATTR_DEQUEUED;
+				if (!(buf->attr & BUF_ATTR_BUFFER_DONE)) {
+					buf->attr |= BUF_ATTR_BUFFER_DONE;
+					ret = iris_vb2_buffer_done(inst, buf);
+					if (ret)
+						ret = 0;
+				}
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int handle_release_internal_buffer(struct iris_inst *inst,
+					  struct hfi_buffer *buffer)
+{
+	struct iris_buffers *buffers;
+	struct iris_buffer *buf, *iter;
+	int ret = 0;
+	bool found;
+
+	buffers = iris_get_buffer_list(inst, hfi_buf_type_to_driver(buffer->type));
+	if (!buffers)
+		return -EINVAL;
+
+	found = false;
+	list_for_each_entry(iter, &buffers->list, list) {
+		if (iter->device_addr == buffer->base_address) {
+			found = true;
+			buf = iter;
+			break;
+		}
+	}
+	if (!found)
+		return -EINVAL;
+
+	buf->attr &= ~BUF_ATTR_QUEUED;
+
+	if (buf->attr & BUF_ATTR_PENDING_RELEASE)
+		ret = iris_destroy_internal_buffer(inst, buf);
+
+	return ret;
+}
+
+static int handle_session_buffer(struct iris_inst *inst,
+				 struct hfi_packet *pkt)
+{
+	struct hfi_buffer *buffer;
+	u32 hfi_handle_size = 0;
+	int i, ret = 0;
+	const struct iris_hfi_buffer_handle *hfi_handle_arr = NULL;
+	static const struct iris_hfi_buffer_handle input_hfi_handle[] = {
+		{HFI_BUFFER_BITSTREAM,      handle_input_buffer               },
+		{HFI_BUFFER_BIN,            handle_release_internal_buffer    },
+		{HFI_BUFFER_COMV,           handle_release_internal_buffer    },
+		{HFI_BUFFER_NON_COMV,       handle_release_internal_buffer    },
+		{HFI_BUFFER_LINE,           handle_release_internal_buffer    },
+		{HFI_BUFFER_PERSIST,        handle_release_internal_buffer    },
+	};
+	static const struct iris_hfi_buffer_handle output_hfi_handle[] = {
+		{HFI_BUFFER_RAW,            handle_output_buffer              },
+		{HFI_BUFFER_DPB,            handle_release_internal_buffer    },
+	};
+
+	if (pkt->payload_info == HFI_PAYLOAD_NONE)
+		return 0;
+
+	if (!validate_packet_payload(pkt)) {
+		iris_inst_change_state(inst, IRIS_INST_ERROR);
+		return 0;
+	}
+
+	buffer = (struct hfi_buffer *)((u8 *)pkt + sizeof(*pkt));
+	if (!is_valid_hfi_buffer_type(buffer->type))
+		return 0;
+
+	if (!is_valid_hfi_port(pkt->port, buffer->type))
+		return 0;
+
+	if (pkt->port == HFI_PORT_BITSTREAM) {
+		hfi_handle_size = ARRAY_SIZE(input_hfi_handle);
+		hfi_handle_arr = input_hfi_handle;
+	} else if (pkt->port == HFI_PORT_RAW) {
+		hfi_handle_size = ARRAY_SIZE(output_hfi_handle);
+		hfi_handle_arr = output_hfi_handle;
+	}
+
+	if (!hfi_handle_arr || !hfi_handle_size)
+		return -EINVAL;
+
+	for (i = 0; i < hfi_handle_size; i++) {
+		if (hfi_handle_arr[i].type == buffer->type) {
+			ret = hfi_handle_arr[i].handle(inst, buffer);
+			if (ret)
+				return ret;
+			break;
+		}
+	}
+
+	if (i == hfi_handle_size)
+		return -EINVAL;
+
+	return ret;
+}
+
 static int handle_src_change(struct iris_inst *inst,
 			     struct hfi_packet *pkt)
 {
@@ -191,6 +572,7 @@ static int handle_session_command(struct iris_inst *inst,
 	static const struct iris_hfi_packet_handle hfi_pkt_handle[] = {
 		{HFI_CMD_OPEN,              NULL                    },
 		{HFI_CMD_CLOSE,             handle_session_close    },
+		{HFI_CMD_BUFFER,            handle_session_buffer   },
 		{HFI_CMD_SETTINGS_CHANGE,   handle_src_change       },
 		{HFI_CMD_SUBSCRIBE_MODE,    NULL                    },
 	};
@@ -386,6 +768,7 @@ static int handle_session_response(struct iris_core *core,
 {
 	struct hfi_packet *packet;
 	struct iris_inst *inst;
+	bool dequeue = false;
 	u8 *pkt, *start_pkt;
 	int ret = 0;
 	int i, j;
@@ -423,6 +806,7 @@ static int handle_session_response(struct iris_core *core,
 				handle_session_error(inst, packet);
 
 			if (packet->type > be[i].begin && packet->type < be[i].end) {
+				dequeue |= (packet->type == HFI_CMD_BUFFER);
 				ret = be[i].handle(inst, packet);
 				if (ret)
 					iris_inst_change_state(inst, IRIS_INST_ERROR);
@@ -431,7 +815,15 @@ static int handle_session_response(struct iris_core *core,
 		}
 	}
 
+	if (dequeue) {
+		ret = handle_dequeue_buffers(inst);
+		if (ret)
+			goto unlock;
+	}
+
 	memset(&inst->hfi_frame_info, 0, sizeof(struct iris_hfi_frame_info));
+
+unlock:
 	mutex_unlock(&inst->lock);
 
 	return ret;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
index 6553029..04e7dc8 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
@@ -170,6 +170,14 @@ bool allow_reqbufs(struct iris_inst *inst, u32 type)
 		(type == INPUT_MPLANE && inst->state == IRIS_INST_OUTPUT_STREAMING);
 }
 
+bool allow_qbuf(struct iris_inst *inst, u32 type)
+{
+	return (type == INPUT_MPLANE && inst->state == IRIS_INST_INPUT_STREAMING) ||
+		(type == INPUT_MPLANE && inst->state == IRIS_INST_STREAMING) ||
+		(type == OUTPUT_MPLANE && inst->state == IRIS_INST_OUTPUT_STREAMING) ||
+		(type == OUTPUT_MPLANE && inst->state == IRIS_INST_STREAMING);
+}
+
 bool allow_streamon(struct iris_inst *inst, u32 type)
 {
 	return (type == INPUT_MPLANE && inst->state == IRIS_INST_OPEN) ||
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.h b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
index 28d5380..47558ed 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.h
@@ -43,6 +43,7 @@ int iris_inst_change_state(struct iris_inst *inst,
 
 bool allow_s_fmt(struct iris_inst *inst, u32 type);
 bool allow_reqbufs(struct iris_inst *inst, u32 type);
+bool allow_qbuf(struct iris_inst *inst, u32 type);
 bool allow_streamon(struct iris_inst *inst, u32 type);
 bool allow_streamoff(struct iris_inst *inst, u32 type);
 bool allow_s_ctrl(struct iris_inst *inst, u32 cap_id);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
index d599366..f34434fc 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.c
@@ -95,6 +95,7 @@ int iris_vb2_queue_setup(struct vb2_queue *q,
 
 int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 {
+	enum iris_buffer_type buf_type;
 	struct iris_inst *inst;
 	int ret = 0;
 
@@ -132,6 +133,16 @@ int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret)
 		goto error;
 
+	buf_type = v4l2_type_to_driver(q->type);
+	if (!buf_type) {
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = queue_deferred_buffers(inst, buf_type);
+	if (ret)
+		goto error;
+
 	return ret;
 error:
 	iris_inst_change_state(inst, IRIS_INST_ERROR);
@@ -168,9 +179,33 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
 	iris_inst_change_state(inst, IRIS_INST_ERROR);
 }
 
+void iris_vb2_buf_queue(struct vb2_buffer *vb2)
+{
+	struct iris_inst *inst;
+	int ret;
+
+	inst = vb2_get_drv_priv(vb2->vb2_queue);
+	if (!inst || !inst->core)
+		return;
+
+	if (!vb2->planes[0].bytesused && vb2->type == INPUT_MPLANE) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	ret = vdec_qbuf(inst, vb2);
+
+exit:
+	if (ret) {
+		iris_inst_change_state(inst, IRIS_INST_ERROR);
+		vb2_buffer_done(vb2, VB2_BUF_STATE_ERROR);
+	}
+}
+
 void *iris_vb2_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
 			     struct dma_buf *dbuf, unsigned long size)
 {
+	struct iris_buffer *ro_buf, *dummy;
 	enum iris_buffer_type buf_type;
 	struct iris_buffers *buffers;
 	struct iris_buffer *iter;
@@ -203,6 +238,16 @@ void *iris_vb2_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
 	buf->inst = inst;
 	buf->dmabuf = dbuf;
 
+	if (buf->type == BUF_OUTPUT) {
+		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
+			if (ro_buf->dmabuf != buf->dmabuf)
+				continue;
+			buf->attach = ro_buf->attach;
+			ro_buf->attach = NULL;
+			return buf;
+		}
+	}
+
 	buf->attach = dma_buf_attach(dbuf, dev);
 	if (IS_ERR(buf->attach)) {
 		buf->attach = NULL;
@@ -214,6 +259,7 @@ void *iris_vb2_attach_dmabuf(struct vb2_buffer *vb, struct device *dev,
 
 int iris_vb2_map_dmabuf(void *buf_priv)
 {
+	struct iris_buffer *ro_buf, *dummy;
 	struct iris_buffer *buf = buf_priv;
 	struct iris_core *core;
 	struct iris_inst *inst;
@@ -229,6 +275,17 @@ int iris_vb2_map_dmabuf(void *buf_priv)
 		return -EINVAL;
 	}
 
+	if (buf->type == BUF_OUTPUT) {
+		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
+			if (ro_buf->dmabuf != buf->dmabuf)
+				continue;
+			buf->sg_table = ro_buf->sg_table;
+			buf->device_addr = ro_buf->device_addr;
+			ro_buf->sg_table = NULL;
+			return 0;
+		}
+	}
+
 	buf->sg_table = dma_buf_map_attachment(buf->attach, DMA_BIDIRECTIONAL);
 	if (IS_ERR(buf->sg_table))
 		return -EINVAL;
@@ -246,6 +303,7 @@ int iris_vb2_map_dmabuf(void *buf_priv)
 
 void iris_vb2_unmap_dmabuf(void *buf_priv)
 {
+	struct iris_buffer *ro_buf, *dummy;
 	struct iris_buffer *buf = buf_priv;
 	struct iris_core *core;
 	struct iris_inst *inst;
@@ -266,6 +324,17 @@ void iris_vb2_unmap_dmabuf(void *buf_priv)
 		return;
 	}
 
+	if (buf->type == BUF_OUTPUT) {
+		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
+			if (ro_buf->dmabuf != buf->dmabuf)
+				continue;
+			ro_buf->sg_table = buf->sg_table;
+			buf->sg_table = NULL;
+			buf->device_addr = 0x0;
+			return;
+		}
+	}
+
 	if (buf->attach && buf->sg_table) {
 		dma_buf_unmap_attachment(buf->attach, buf->sg_table, DMA_BIDIRECTIONAL);
 		buf->sg_table = NULL;
@@ -275,6 +344,7 @@ void iris_vb2_unmap_dmabuf(void *buf_priv)
 
 void iris_vb2_detach_dmabuf(void *buf_priv)
 {
+	struct iris_buffer *ro_buf, *dummy;
 	struct iris_buffer *buf = buf_priv;
 	struct iris_core *core;
 	struct iris_inst *inst;
@@ -291,11 +361,22 @@ void iris_vb2_detach_dmabuf(void *buf_priv)
 		buf->sg_table = NULL;
 	}
 
+	if (buf->type == BUF_OUTPUT) {
+		list_for_each_entry_safe(ro_buf, dummy, &inst->buffers.read_only.list, list) {
+			if (ro_buf->dmabuf != buf->dmabuf)
+				continue;
+			ro_buf->attach = buf->attach;
+			buf->attach = NULL;
+			goto exit;
+		}
+	}
+
 	if (buf->attach && buf->dmabuf) {
 		dma_buf_detach(buf->dmabuf, buf->attach);
 		buf->attach = NULL;
 	}
 
+exit:
 	buf->dmabuf = NULL;
 	buf->inst = NULL;
 }
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
index fc0e804..0757f01 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vb2.h
@@ -13,6 +13,7 @@ int iris_vb2_queue_setup(struct vb2_queue *q,
 			 unsigned int sizes[], struct device *alloc_devs[]);
 int iris_vb2_start_streaming(struct vb2_queue *q, unsigned int count);
 void iris_vb2_stop_streaming(struct vb2_queue *q);
+void iris_vb2_buf_queue(struct vb2_buffer *vb2);
 
 /* vb2_mem_ops */
 void *iris_vb2_alloc(struct vb2_buffer *vb, struct device *dev, unsigned long size);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
index 0d8ca4b..7eb74c3 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.c
@@ -1193,3 +1193,52 @@ int vdec_streamon_output(struct iris_inst *inst)
 
 	return ret;
 }
+
+static int vb2_buffer_to_driver(struct vb2_buffer *vb2,
+				struct iris_buffer *buf)
+{
+	struct vb2_v4l2_buffer *vbuf;
+
+	if (!vb2 || !buf)
+		return -EINVAL;
+
+	vbuf = to_vb2_v4l2_buffer(vb2);
+
+	buf->fd = vb2->planes[0].m.fd;
+	buf->data_offset = vb2->planes[0].data_offset;
+	buf->data_size = vb2->planes[0].bytesused - vb2->planes[0].data_offset;
+	buf->buffer_size = vb2->planes[0].length;
+	buf->timestamp = vb2->timestamp;
+	buf->flags = vbuf->flags;
+	buf->attr = 0;
+
+	return 0;
+}
+
+int vdec_qbuf(struct iris_inst *inst, struct vb2_buffer *vb2)
+{
+	struct iris_buffer *buf = NULL;
+	int ret = 0;
+
+	buf = get_driver_buf(inst, vb2->type, vb2->index);
+	if (!buf)
+		return -EINVAL;
+
+	ret = vb2_buffer_to_driver(vb2, buf);
+	if (ret)
+		return ret;
+
+	if (!allow_qbuf(inst, vb2->type)) {
+		buf->attr |= BUF_ATTR_DEFERRED;
+		return 0;
+	}
+
+	ret = queue_buffer(inst, buf);
+	if (ret)
+		return ret;
+
+	if (vb2->type == OUTPUT_MPLANE)
+		ret = iris_release_nonref_buffers(inst);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
index 0722da1..d666c54 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vdec.h
@@ -18,5 +18,6 @@ int vdec_init_src_change_param(struct iris_inst *inst);
 int vdec_src_change(struct iris_inst *inst);
 int vdec_streamon_input(struct iris_inst *inst);
 int vdec_streamon_output(struct iris_inst *inst);
+int vdec_qbuf(struct iris_inst *inst, struct vb2_buffer *vb2);
 
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
index 14d0077..0165340 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_vidc.c
@@ -252,6 +252,7 @@ int vidc_close(struct file *filp)
 	iris_inst_change_state(inst, IRIS_INST_CLOSE);
 	vidc_vb2_queue_deinit(inst);
 	vidc_v4l2_fh_deinit(inst);
+	iris_destroy_buffers(inst);
 	vidc_remove_session(inst);
 	mutex_unlock(&inst->lock);
 	mutex_destroy(&inst->ctx_q_lock);
@@ -912,6 +913,7 @@ static const struct vb2_ops iris_vb2_ops = {
 	.queue_setup                    = iris_vb2_queue_setup,
 	.start_streaming                = iris_vb2_start_streaming,
 	.stop_streaming                 = iris_vb2_stop_streaming,
+	.buf_queue                      = iris_vb2_buf_queue,
 };
 
 static struct vb2_mem_ops iris_vb2_mem_ops = {
-- 
2.7.4


