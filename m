Return-Path: <linux-kernel+bounces-3441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF485816C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73330281F64
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631601CA9D;
	Mon, 18 Dec 2023 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LQspHlPT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398E1B286;
	Mon, 18 Dec 2023 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIArsDF026901;
	Mon, 18 Dec 2023 11:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=4sLJrCCYfSes228+tKDxIKdmEKAMGeK6QCzBbNNSTD4=; b=LQ
	spHlPT700/t/JailUFCIpFAuZ27YLa0mxbQkoPX1K43MbR0CO2wNOCp7wGk5zEUS
	xj7NVjRh0Fg4vsK0lHtNU1fONVAiCokTCuAZ0cSKfyq+g7B9wX7XZDKW78hzl2UQ
	a+11E3U5ZpKYswLbYh1B3QwoPfgXf4CaJJpxd8xwIIRRM0C/s+fO446XBvBAQRB4
	Z87F/R0b1NDH+28ZPL+MM1SdYekXawK8K10nit+KVyDvgIoBUm5YCC302357tkXE
	a4wh+Lj4zsxmFEJLg20jVR7Zr36QdPk7DSpqh3xiElb0EYrI0jQtn1UO79tSm2EC
	OOyM/9Zzy1EkS2pwM2bA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mjfr3a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:12 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX5MD029943;
	Mon, 18 Dec 2023 11:33:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyhn-1;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX72p029995;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6B1029969;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 3CF6D22F5; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 12/34] media: iris: add video processing unit(VPU) specific register handling
Date: Mon, 18 Dec 2023 17:02:07 +0530
Message-Id: <1702899149-21321-13-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rD8SNUoVX7ts_0OH9eqoGmsZ6moBsFK6
X-Proofpoint-ORIG-GUID: rD8SNUoVX7ts_0OH9eqoGmsZ6moBsFK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312180083
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Registers are defined differently for different VPUs.
Define ops for VPU specific handling to accommodate
different VPUs. Implement boot sequence of firmware and interrupt
programming.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   |   4 +-
 .../media/platform/qcom/vcodec/iris/iris_core.h    |   3 +
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c |   7 +
 .../media/platform/qcom/vcodec/iris/iris_probe.c   |   7 +
 .../media/platform/qcom/vcodec/iris/vpu_common.c   |  71 +++++++++
 .../media/platform/qcom/vcodec/iris/vpu_common.h   |  32 ++++
 .../media/platform/qcom/vcodec/iris/vpu_iris3.c    | 166 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/vpu_iris3.h    |  13 ++
 8 files changed, 302 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_common.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_common.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/vpu_iris3.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index a2d5d74..90241b5 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -7,6 +7,8 @@ iris-objs += iris_probe.o \
              iris_helpers.o \
              iris_hfi.o \
              iris_hfi_packet.o \
-             resources.o
+             resources.o \
+             vpu_common.o \
+             vpu_iris3.o
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index de0cfef..64678fd 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -12,6 +12,7 @@
 #include "../hfi_queue.h"
 #include "iris_state.h"
 #include "resources.h"
+#include "vpu_common.h"
 
 /**
  * struct iris_core - holds core parameters valid for all instances
@@ -44,6 +45,7 @@
  * @sys_init_id: id of sys init packet
  * @header_id: id of packet header
  * @packet_id: id of packet
+ * @vpu_ops: a pointer to vpu ops
  */
 
 struct iris_core {
@@ -75,6 +77,7 @@ struct iris_core {
 	u32					sys_init_id;
 	u32					header_id;
 	u32					packet_id;
+	const struct vpu_ops			*vpu_ops;
 };
 
 int iris_core_init(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
index fe16448..7b3cbbc 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -8,6 +8,7 @@
 #include "iris_helpers.h"
 #include "iris_hfi.h"
 #include "iris_hfi_packet.h"
+#include "vpu_common.h"
 
 static int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt)
 {
@@ -33,6 +34,8 @@ static int iris_hfi_queue_cmd_write(struct iris_core *core, void *pkt)
 	packet_size = header->size;
 
 	if (!write_queue(q_info, pkt, packet_size, &rx_req)) {
+		call_vpu_op(core, raise_interrupt, core);
+	} else {
 		dev_err(core->dev, "queue full\n");
 		return -ENODATA;
 	}
@@ -108,6 +111,10 @@ int iris_hfi_core_init(struct iris_core *core)
 	if (ret)
 		goto error;
 
+	ret = call_vpu_op(core, boot_firmware, core);
+	if (ret)
+		goto error;
+
 	ret = sys_init(core);
 	if (ret)
 		goto error;
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index 570c64e..773481f 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -92,6 +92,13 @@ static int iris_probe(struct platform_device *pdev)
 	if (core->irq < 0)
 		return core->irq;
 
+	ret = init_vpu(core);
+	if (ret) {
+		dev_err_probe(core->dev, ret,
+			      "%s: init vpu failed with %d\n", __func__, ret);
+		return ret;
+	}
+
 	ret = init_resources(core);
 	if (ret) {
 		dev_err_probe(core->dev, ret,
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_common.c b/drivers/media/platform/qcom/vcodec/iris/vpu_common.c
new file mode 100644
index 0000000..3282510
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_common.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "vpu_iris3.h"
+#include "iris_core.h"
+#include "iris_helpers.h"
+#include "vpu_common.h"
+
+int write_register(struct iris_core *core, u32 reg, u32 value)
+{
+	void __iomem *base_addr;
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return ret;
+
+	base_addr = core->reg_base;
+	base_addr += reg;
+	writel_relaxed(value, base_addr);
+
+	/* Make sure value is written into the register */
+	wmb();
+
+	return ret;
+}
+
+int read_register(struct iris_core *core, u32 reg, u32 *value)
+{
+	void __iomem *base_addr;
+
+	base_addr = core->reg_base;
+
+	*value = readl_relaxed(base_addr + reg);
+
+	/* Make sure value is read correctly from the register */
+	rmb();
+
+	return 0;
+}
+
+static const struct compat_handle compat_handle[] = {
+	{
+		.compat                  = "qcom,sm8550-iris",
+		.init                    = init_iris3,
+	},
+};
+
+int init_vpu(struct iris_core *core)
+{
+	struct device *dev = NULL;
+	int i, ret = 0;
+
+	dev = core->dev;
+
+	for (i = 0; i < ARRAY_SIZE(compat_handle); i++) {
+		if (of_device_is_compatible(dev->of_node, compat_handle[i].compat)) {
+			ret = compat_handle[i].init(core);
+			if (ret)
+				return ret;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(compat_handle))
+		return -EINVAL;
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_common.h b/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
new file mode 100644
index 0000000..790496a
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_common.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _VPU_COMMON_H_
+#define _VPU_COMMON_H_
+
+#include <linux/types.h>
+
+struct iris_core;
+
+#define call_vpu_op(d, op, ...)			\
+	(((d) && (d)->vpu_ops && (d)->vpu_ops->op) ? \
+	((d)->vpu_ops->op(__VA_ARGS__)) : 0)
+
+struct compat_handle {
+	const char *compat;
+	int (*init)(struct iris_core *core);
+};
+
+struct vpu_ops {
+	int (*boot_firmware)(struct iris_core *core);
+	int (*raise_interrupt)(struct iris_core *core);
+};
+
+int init_vpu(struct iris_core *core);
+
+int write_register(struct iris_core *core, u32 reg, u32 value);
+int read_register(struct iris_core *core, u32 reg, u32 *value);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
new file mode 100644
index 0000000..95bf223
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/delay.h>
+
+#include "vpu_iris3.h"
+
+#define VIDEO_ARCH_LX 1
+
+#define CPU_BASE_OFFS_IRIS3     0x000A0000
+
+#define CPU_CS_BASE_OFFS_IRIS3      (CPU_BASE_OFFS_IRIS3)
+#define CPU_IC_BASE_OFFS_IRIS3      (CPU_BASE_OFFS_IRIS3)
+
+#define CPU_CS_VCICMDARG0_IRIS3     (CPU_CS_BASE_OFFS_IRIS3 + 0x24)
+#define CPU_CS_VCICMDARG1_IRIS3     (CPU_CS_BASE_OFFS_IRIS3 + 0x28)
+
+/* HFI_CTRL_INIT */
+#define CPU_CS_SCIACMD_IRIS3        (CPU_CS_BASE_OFFS_IRIS3 + 0x48)
+
+/* HFI_CTRL_STATUS */
+#define CPU_CS_SCIACMDARG0_IRIS3    (CPU_CS_BASE_OFFS_IRIS3 + 0x4C)
+#define CPU_CS_SCIACMDARG0_HFI_CTRL_INIT_IDLE_MSG_BMSK_IRIS3     0x40000000
+
+#define CPU_CS_H2XSOFTINTEN_IRIS3   (CPU_CS_BASE_OFFS_IRIS3 + 0x148)
+
+#define CPU_CS_X2RPMH_IRIS3         (CPU_CS_BASE_OFFS_IRIS3 + 0x168)
+
+/* UC_REGION_ADDR */
+#define CPU_CS_SCIBARG1_IRIS3       (CPU_CS_BASE_OFFS_IRIS3 + 0x64)
+
+/* UC_REGION_ADDR */
+#define CPU_CS_SCIBARG2_IRIS3       (CPU_CS_BASE_OFFS_IRIS3 + 0x68)
+
+/* HFI_QTBL_INFO */
+#define CPU_CS_SCIACMDARG1_IRIS3    (CPU_CS_BASE_OFFS_IRIS3 + 0x50)
+
+/* HFI_QTBL_ADDR */
+#define CPU_CS_SCIACMDARG2_IRIS3    (CPU_CS_BASE_OFFS_IRIS3 + 0x54)
+
+/* SFR_ADDR */
+#define CPU_CS_SCIBCMD_IRIS3        (CPU_CS_BASE_OFFS_IRIS3 + 0x5C)
+
+#define UC_REGION_ADDR_IRIS3        CPU_CS_SCIBARG1_IRIS3
+#define UC_REGION_SIZE_IRIS3	    CPU_CS_SCIBARG2_IRIS3
+
+#define QTBL_INFO_IRIS3             CPU_CS_SCIACMDARG1_IRIS3
+#define QTBL_ADDR_IRIS3             CPU_CS_SCIACMDARG2_IRIS3
+
+#define SFR_ADDR_IRIS3              CPU_CS_SCIBCMD_IRIS3
+
+#define CTRL_INIT_IRIS3             CPU_CS_SCIACMD_IRIS3
+
+#define CTRL_STATUS_IRIS3           CPU_CS_SCIACMDARG0_IRIS3
+#define CPU_CS_SCIACMDARG0_HFI_CTRL_ERROR_STATUS_BMSK_IRIS3	0xfe
+#define CTRL_ERROR_STATUS__M_IRIS3 \
+		CPU_CS_SCIACMDARG0_HFI_CTRL_ERROR_STATUS_BMSK_IRIS3
+
+#define CPU_IC_SOFTINT_IRIS3        (CPU_IC_BASE_OFFS_IRIS3 + 0x150)
+#define CPU_IC_SOFTINT_H2A_SHFT_IRIS3	0x0
+
+static int setup_ucregion_memory_map_iris3(struct iris_core *core)
+{
+	int ret;
+	u32 value;
+
+	value = (u32)core->iface_q_table.device_addr;
+	ret = write_register(core, UC_REGION_ADDR_IRIS3, value);
+	if (ret)
+		return ret;
+
+	value = SHARED_QSIZE;
+	ret = write_register(core, UC_REGION_SIZE_IRIS3, value);
+	if (ret)
+		return ret;
+
+	value = (u32)core->iface_q_table.device_addr;
+	ret = write_register(core, QTBL_ADDR_IRIS3, value);
+	if (ret)
+		return ret;
+
+	ret = write_register(core, QTBL_INFO_IRIS3, 0x01);
+	if (ret)
+		return ret;
+
+	value = (u32)((u64)core->iface_q_table.kernel_vaddr);
+	ret = write_register(core, CPU_CS_VCICMDARG0_IRIS3, value);
+	if (ret)
+		return ret;
+
+	value = (u32)((u64)core->iface_q_table.kernel_vaddr >> 32);
+	ret = write_register(core, CPU_CS_VCICMDARG1_IRIS3, value);
+	if (ret)
+		return ret;
+
+	if (core->sfr.device_addr) {
+		value = (u32)core->sfr.device_addr + VIDEO_ARCH_LX;
+		ret = write_register(core, SFR_ADDR_IRIS3, value);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int boot_firmware_iris3(struct iris_core *core)
+{
+	u32 ctrl_init = 0, ctrl_status = 0, count = 0, max_tries = 1000;
+	int ret;
+
+	ret = setup_ucregion_memory_map_iris3(core);
+	if (ret)
+		return ret;
+
+	ctrl_init = BIT(0);
+
+	ret = write_register(core, CTRL_INIT_IRIS3, ctrl_init);
+	if (ret)
+		return ret;
+
+	while (!ctrl_status && count < max_tries) {
+		ret = read_register(core, CTRL_STATUS_IRIS3, &ctrl_status);
+		if (ret)
+			return ret;
+
+		if ((ctrl_status & CTRL_ERROR_STATUS__M_IRIS3) == 0x4) {
+			dev_err(core->dev, "invalid setting for UC_REGION\n");
+			break;
+		}
+
+		usleep_range(50, 100);
+		count++;
+	}
+
+	if (count >= max_tries) {
+		dev_err(core->dev, "Error booting up vidc firmware\n");
+		return -ETIME;
+	}
+
+	ret = write_register(core, CPU_CS_H2XSOFTINTEN_IRIS3, 0x1);
+	if (ret)
+		return ret;
+
+	ret = write_register(core, CPU_CS_X2RPMH_IRIS3, 0x0);
+
+	return ret;
+}
+
+static int raise_interrupt_iris3(struct iris_core *core)
+{
+	return write_register(core, CPU_IC_SOFTINT_IRIS3, 1 << CPU_IC_SOFTINT_H2A_SHFT_IRIS3);
+}
+
+static const struct vpu_ops iris3_ops = {
+	.boot_firmware = boot_firmware_iris3,
+	.raise_interrupt = raise_interrupt_iris3,
+};
+
+int init_iris3(struct iris_core *core)
+{
+	core->vpu_ops = &iris3_ops;
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.h b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.h
new file mode 100644
index 0000000..1424a5f
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _VPU_IRIS3_H_
+#define _VPU_IRIS3_H_
+
+#include "iris_core.h"
+
+int init_iris3(struct iris_core *core);
+
+#endif
-- 
2.7.4


