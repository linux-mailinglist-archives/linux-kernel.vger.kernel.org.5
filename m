Return-Path: <linux-kernel+bounces-3437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B43B7816C36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1841F2387D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0291B27C;
	Mon, 18 Dec 2023 11:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NjoabHjr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FE1A27E;
	Mon, 18 Dec 2023 11:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIBScQb021562;
	Mon, 18 Dec 2023 11:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=HWrsGR9dQBQYAECyvELmVJvsiibu4cOF7NAEek6IDMw=; b=Nj
	oabHjr+gMf44d+g9AkB7ma5F/Uo/Lbd5BOYAxAaPUBtkSV0JtCzDADxoR5adag40
	xFeV5lhcuXy3n8XYa25wA/C63kkzlA0CXrSzXMN6zrNn1zUaMP05tm+cIkGfzNdo
	2SCTIwRxP0h0SHQFzdjtoJEATOStcKj8poNU/Iyw9z+0BaA/QlX1MVMTNm0CYV2m
	AUNbgXQs9Hw2nFNv7FAqW72Rk1JuWedHM5A0JcdCO9W7oieCxfDGVRaEmqaGDGca
	rPGxGxmxIgKkQ5PXR6uO7tYMqz0+TBppZFtAbyHsjHwdNFwthYTZfZ+OUljKHmaZ
	cURi2vWBYEecfk3Fb5tA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2mjfr3a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:33:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX7t0030046;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ykyyhe-1;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBVmqr028240;
	Mon, 18 Dec 2023 11:33:07 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX6ki029964;
	Mon, 18 Dec 2023 11:33:07 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 3802122D8; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 10/34] media: iris: add PIL functionality for video firmware
Date: Mon, 18 Dec 2023 17:02:05 +0530
Message-Id: <1702899149-21321-11-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rlMvPhtwa_nFYWHeQKKLBMx4fwLr5wWF
X-Proofpoint-ORIG-GUID: rlMvPhtwa_nFYWHeQKKLBMx4fwLr5wWF
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

Load/unload firmware in memory via mdt loader.
Firmware loading is part of core initialization
and unloading is part of core de-initialization.
This also changes the core states accordingly.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/vcodec/iris/Makefile   | 10 ++-
 .../media/platform/qcom/vcodec/iris/iris_core.c    | 70 +++++++++++++++++++++
 .../media/platform/qcom/vcodec/iris/iris_core.h    |  8 +++
 .../media/platform/qcom/vcodec/iris/iris_helpers.c | 15 +++++
 .../media/platform/qcom/vcodec/iris/iris_helpers.h | 13 ++++
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c | 72 ++++++++++++++++++++++
 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h | 14 +++++
 .../media/platform/qcom/vcodec/iris/iris_probe.c   | 19 +++++-
 .../media/platform/qcom/vcodec/iris/iris_state.c   |  9 ++-
 9 files changed, 225 insertions(+), 5 deletions(-)
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_core.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
 create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_hfi.h

diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
index 59798e5d..74bd344 100644
--- a/drivers/media/platform/qcom/vcodec/iris/Makefile
+++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
@@ -1,7 +1,11 @@
-iris-objs += ../hfi_queue.o
+iris-objs += ../hfi_queue.o ../firmware.o
 
 iris-objs += iris_probe.o \
-             resources.o \
-             iris_state.o
+             iris_state.o \
+             iris_core.o \
+             iris_state.o \
+             iris_helpers.o \
+             iris_hfi.o \
+             resources.o
 
 obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.c b/drivers/media/platform/qcom/vcodec/iris/iris_core.c
new file mode 100644
index 0000000..ba8960d
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_core.h"
+#include "iris_helpers.h"
+#include "iris_hfi.h"
+#include "iris_state.h"
+
+static int iris_core_deinit_locked(struct iris_core *core)
+{
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return ret;
+
+	if (core->state == IRIS_CORE_DEINIT)
+		return 0;
+
+	iris_hfi_core_deinit(core);
+
+	iris_change_core_state(core, IRIS_CORE_DEINIT);
+
+	return ret;
+}
+
+int iris_core_deinit(struct iris_core *core)
+{
+	int ret;
+
+	mutex_lock(&core->lock);
+	ret = iris_core_deinit_locked(core);
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
+
+int iris_core_init(struct iris_core *core)
+{
+	int ret = 0;
+
+	mutex_lock(&core->lock);
+	if (core_in_valid_state(core)) {
+		goto unlock;
+	} else if (core->state == IRIS_CORE_ERROR) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (iris_change_core_state(core, IRIS_CORE_INIT_WAIT)) {
+		iris_change_core_state(core, IRIS_CORE_ERROR);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = iris_hfi_core_init(core);
+	if (ret) {
+		iris_change_core_state(core, IRIS_CORE_ERROR);
+		dev_err(core->dev, "%s: core init failed\n", __func__);
+		iris_core_deinit_locked(core);
+		goto unlock;
+	}
+
+unlock:
+	mutex_unlock(&core->lock);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
index 77124f9..2740ff1 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_core.h
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
@@ -11,6 +11,7 @@
 
 #include "../hfi_queue.h"
 #include "iris_state.h"
+#include "resources.h"
 
 /**
  * struct iris_core - holds core parameters valid for all instances
@@ -36,6 +37,8 @@
  * @message_queue: shared interface queue to receive responses from firmware
  * @debug_queue: shared interface queue to receive debug info from firmware
  * @sfr: SFR register memory
+ * @lock: a lock for this strucure
+ * @use_tz: a flag that suggests presence of trustzone
  */
 
 struct iris_core {
@@ -60,6 +63,11 @@ struct iris_core {
 	struct iface_q_info			message_queue;
 	struct iface_q_info			debug_queue;
 	struct mem_desc				sfr;
+	struct mutex				lock; /* lock for core structure */
+	unsigned int				use_tz;
 };
 
+int iris_core_init(struct iris_core *core);
+int iris_core_deinit(struct iris_core *core);
+
 #endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
new file mode 100644
index 0000000..22c706a
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "iris_helpers.h"
+
+int check_core_lock(struct iris_core *core)
+{
+	bool fatal = !mutex_is_locked(&core->lock);
+
+	WARN_ON(fatal);
+
+	return fatal ? -EINVAL : 0;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
new file mode 100644
index 0000000..314a8d75
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_helpers.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_HELPERS_H_
+#define _IRIS_HELPERS_H_
+
+#include "iris_core.h"
+
+int check_core_lock(struct iris_core *core);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
new file mode 100644
index 0000000..4f51a8c
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "../firmware.h"
+#include "iris_helpers.h"
+#include "iris_hfi.h"
+
+#define CP_START           0
+#define CP_SIZE            0x25800000
+#define CP_NONPIXEL_START  0x01000000
+#define CP_NONPIXEL_SIZE   0x24800000
+
+#define FW_NAME "vpu30_4v.mbn"
+#define IRIS_PAS_ID 9
+
+int iris_hfi_core_init(struct iris_core *core)
+{
+	phys_addr_t mem_phys = 0;
+	size_t mem_size = 0;
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return ret;
+
+	ret = hfi_queue_init(core->dev, &core->iface_q_table, &core->sfr,
+			     &core->command_queue, &core->message_queue,
+			     &core->debug_queue, core);
+	if (ret)
+		goto error;
+
+	core->use_tz = use_tz(core->dev);
+	if (!core->use_tz)
+		goto error;
+
+	ret = load_fw(core->dev, FW_NAME, &mem_phys, &mem_size,
+		      IRIS_PAS_ID, core->use_tz);
+	if (ret)
+		goto error;
+
+	ret = auth_reset_fw(IRIS_PAS_ID);
+	if (ret)
+		goto error;
+
+	ret = protect_secure_region(CP_START, CP_SIZE, CP_NONPIXEL_START,
+				    CP_NONPIXEL_SIZE, IRIS_PAS_ID);
+
+	return ret;
+
+error:
+	dev_err(core->dev, "%s(): failed with ret %d\n", __func__, ret);
+
+	return ret;
+}
+
+int iris_hfi_core_deinit(struct iris_core *core)
+{
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return ret;
+
+	if (core->state == IRIS_CORE_DEINIT)
+		return 0;
+
+	unload_fw(IRIS_PAS_ID);
+
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
new file mode 100644
index 0000000..fcf9f28
--- /dev/null
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_hfi.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _IRIS_HFI_H_
+#define _IRIS_HFI_H_
+
+#include "iris_core.h"
+
+int iris_hfi_core_init(struct iris_core *core);
+int iris_hfi_core_deinit(struct iris_core *core);
+
+#endif
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
index fd349a3..f39b4aa 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
@@ -51,6 +51,7 @@ static void iris_remove(struct platform_device *pdev)
 	if (!core)
 		return;
 
+	iris_core_deinit(core);
 	hfi_queue_deinit(core->dev, &core->iface_q_table, &core->sfr,
 			 &core->command_queue, &core->message_queue,
 			 &core->debug_queue);
@@ -58,6 +59,9 @@ static void iris_remove(struct platform_device *pdev)
 	video_unregister_device(core->vdev_dec);
 
 	v4l2_device_unregister(&core->v4l2_dev);
+
+	mutex_destroy(&core->lock);
+	core->state = IRIS_CORE_DEINIT;
 }
 
 static int iris_probe(struct platform_device *pdev)
@@ -72,6 +76,9 @@ static int iris_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	core->dev = dev;
 
+	core->state = IRIS_CORE_DEINIT;
+	mutex_init(&core->lock);
+
 	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(core->reg_base))
 		return PTR_ERR(core->reg_base);
@@ -120,10 +127,20 @@ static int iris_probe(struct platform_device *pdev)
 		goto err_vdev_unreg;
 	}
 
+	ret = iris_core_init(core);
+	if (ret) {
+		dev_err_probe(core->dev, ret, "%s: core init failed\n", __func__);
+		goto err_queue_deinit;
+	}
+
 	return ret;
 
+err_queue_deinit:
+	hfi_queue_deinit(core->dev, &core->iface_q_table, &core->sfr,
+			 &core->command_queue, &core->message_queue,
+			 &core->debug_queue);
 err_vdev_unreg:
-	iris_unregister_video_device(core);
+	video_unregister_device(core->vdev_dec);
 err_v4l2_unreg:
 	v4l2_device_unregister(&core->v4l2_dev);
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_state.c b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
index 22557af..83bbc6b 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_state.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_state.c
@@ -4,6 +4,7 @@
  */
 
 #include "iris_core.h"
+#include "iris_helpers.h"
 #include "iris_state.h"
 
 #define IRIS_STATE(name)[IRIS_CORE_##name] = "CORE_"#name
@@ -52,6 +53,12 @@ static bool iris_allow_core_state_change(struct iris_core *core,
 int iris_change_core_state(struct iris_core *core,
 			   enum iris_core_state request_state)
 {
+	int ret;
+
+	ret = check_core_lock(core);
+	if (ret)
+		return ret;
+
 	if (core->state == request_state)
 		return 0;
 
@@ -60,5 +67,5 @@ int iris_change_core_state(struct iris_core *core,
 
 	core->state = request_state;
 
-	return 0;
+	return ret;
 }
-- 
2.7.4


