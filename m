Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F05766E60
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjG1N2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbjG1N2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:28:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A71449FE;
        Fri, 28 Jul 2023 06:27:36 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SBrSNE011914;
        Fri, 28 Jul 2023 13:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=X7nFhXYJYyC4Y/Q3Um9IJu6eQkTiTHgAxauTw8MQB6w=;
 b=N3mm9nlLKN8ek/Ee4v3BhMmyOrk4GC7NclMopS+14l1szeWLVAYSwmBz8+CcAUB8FGmE
 BzXKacxSwcxgO1wcgLXMrL8EBCao8kqi+hJeTXI6TcnviLfzJCJwvJJcwrIgJrwfviER
 g1ZiAPX3qa5ESLamVEvDSBZ+bMFf693I45L/wf1qmBggaGd1/5lj9InJyUMTXBi+YmA8
 4UdqUvE2dTlT42bokOjl0cbFz4bEAdatiXYLcA1zDJeELeF0LK+BPNr3yZbxBXpdP8as
 HvC5VRD8amecCTTxVJWGPd36Wymo3w0OpKwS7Hee9DTdnf/XkjQw5UfkkeQaZBf7+iwk LQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s468qs150-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:34 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDQXIm014493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:33 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:26:30 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 24/33] iris: vidc: add debug files
Date:   Fri, 28 Jul 2023 18:53:35 +0530
Message-ID: <1690550624-14642-25-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MIpiyj7b-8yRl8TkwQkmxvVlWP1rK50h
X-Proofpoint-ORIG-GUID: MIpiyj7b-8yRl8TkwQkmxvVlWP1rK50h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this implements the debugging framework.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../platform/qcom/iris/vidc/inc/msm_vidc_debug.h   | 186 +++++++
 .../platform/qcom/iris/vidc/src/msm_vidc_debug.c   | 581 +++++++++++++++++++++
 2 files changed, 767 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/src/msm_vidc_debug.c

diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h
new file mode 100644
index 0000000..ffced01
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_debug.h
@@ -0,0 +1,186 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __MSM_VIDC_DEBUG__
+#define __MSM_VIDC_DEBUG__
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+
+struct msm_vidc_core;
+struct msm_vidc_inst;
+
+#ifndef VIDC_DBG_LABEL
+#define VIDC_DBG_LABEL "msm_vidc"
+#endif
+
+/* Allow only 6 prints/sec */
+#define VIDC_DBG_SESSION_RATELIMIT_INTERVAL (1 * HZ)
+#define VIDC_DBG_SESSION_RATELIMIT_BURST 6
+
+#define VIDC_DBG_TAG_INST VIDC_DBG_LABEL ": %4s: %s: "
+#define VIDC_DBG_TAG_CORE VIDC_DBG_LABEL ": %4s: %08x: %s: "
+#define FW_DBG_TAG VIDC_DBG_LABEL ": %6s: "
+#define DEFAULT_SID ((u32)-1)
+
+#ifndef MSM_VIDC_EMPTY_BRACE
+#define MSM_VIDC_EMPTY_BRACE {},
+#endif
+
+extern unsigned int msm_vidc_debug;
+extern unsigned int msm_fw_debug;
+extern bool msm_vidc_fw_dump;
+
+/* do not modify the log message as it is used in test scripts */
+#define FMT_STRING_SET_CTRL \
+	"%s: state %s, name %s, id 0x%x value %d\n"
+#define FMT_STRING_STATE_CHANGE \
+	"%s: state changed to %s from %s\n"
+#define FMT_STRING_MSG_SFR \
+	"SFR Message from FW: %s\n"
+#define FMT_STRING_FAULT_HANDLER \
+	"%s: faulting address: %lx\n"
+#define FMT_STRING_SET_CAP \
+	"set cap: name: %24s, cap value: %#10x, hfi: %#10llx\n"
+
+/* To enable messages OR these values and
+ * echo the result to debugfs file.
+ *
+ * To enable all messages set msm_vidc_debug = 0x101F
+ */
+
+enum vidc_msg_prio_drv {
+	VIDC_ERR        = 0x00000001,
+	VIDC_HIGH       = 0x00000002,
+	VIDC_LOW        = 0x00000004,
+	VIDC_PERF       = 0x00000008,
+	VIDC_PKT        = 0x00000010,
+	VIDC_BUS        = 0x00000020,
+	VIDC_STAT       = 0x00000040,
+	VIDC_ENCODER    = 0x00000100,
+	VIDC_DECODER    = 0x00000200,
+	VIDC_PRINTK     = 0x10000000,
+	VIDC_FTRACE     = 0x20000000,
+};
+
+enum vidc_msg_prio_fw {
+	FW_LOW          = 0x00000001,
+	FW_MED          = 0x00000002,
+	FW_HIGH         = 0x00000004,
+	FW_ERROR        = 0x00000008,
+	FW_FATAL        = 0x00000010,
+	FW_PERF         = 0x00000020,
+	FW_CACHE_LOW    = 0x00000100,
+	FW_CACHE_MED    = 0x00000200,
+	FW_CACHE_HIGH   = 0x00000400,
+	FW_CACHE_ERROR  = 0x00000800,
+	FW_CACHE_FATAL  = 0x00001000,
+	FW_CACHE_PERF   = 0x00002000,
+	FW_PRINTK       = 0x10000000,
+	FW_FTRACE       = 0x20000000,
+};
+
+#define DRV_LOG        (VIDC_ERR | VIDC_PRINTK)
+#define DRV_LOGSHIFT   (0)
+#define DRV_LOGMASK    (0x0FFFFFFF)
+
+#define FW_LOG         (FW_ERROR | FW_FATAL | FW_PRINTK)
+#define FW_LOGSHIFT    (0)
+#define FW_LOGMASK     (0x0FFFFFFF)
+
+#define dprintk_inst(__level, __level_str, inst, __fmt, ...) \
+	do { \
+		if (inst && (msm_vidc_debug & (__level))) { \
+			pr_info(VIDC_DBG_TAG_INST __fmt, \
+				__level_str, \
+				inst->debug_str, \
+				##__VA_ARGS__); \
+		} \
+	} while (0)
+
+#define i_vpr_e(inst, __fmt, ...) dprintk_inst(VIDC_ERR,  "err ", inst, __fmt, ##__VA_ARGS__)
+#define i_vpr_i(inst, __fmt, ...) dprintk_inst(VIDC_HIGH, "high", inst, __fmt, ##__VA_ARGS__)
+#define i_vpr_h(inst, __fmt, ...) dprintk_inst(VIDC_HIGH, "high", inst, __fmt, ##__VA_ARGS__)
+#define i_vpr_l(inst, __fmt, ...) dprintk_inst(VIDC_LOW,  "low ", inst, __fmt, ##__VA_ARGS__)
+#define i_vpr_p(inst, __fmt, ...) dprintk_inst(VIDC_PERF, "perf", inst, __fmt, ##__VA_ARGS__)
+#define i_vpr_t(inst, __fmt, ...) dprintk_inst(VIDC_PKT,  "pkt ", inst, __fmt, ##__VA_ARGS__)
+#define i_vpr_b(inst, __fmt, ...) dprintk_inst(VIDC_BUS,  "bus ", inst, __fmt, ##__VA_ARGS__)
+#define i_vpr_s(inst, __fmt, ...) dprintk_inst(VIDC_STAT, "stat", inst, __fmt, ##__VA_ARGS__)
+
+#define i_vpr_hp(inst, __fmt, ...) \
+	dprintk_inst(VIDC_HIGH | VIDC_PERF, "high", inst, __fmt, ##__VA_ARGS__)
+#define i_vpr_hs(inst, __fmt, ...) \
+	dprintk_inst(VIDC_HIGH | VIDC_STAT, "stat", inst, __fmt, ##__VA_ARGS__)
+
+#define dprintk_core(__level, __level_str, __fmt, ...) \
+	do { \
+		if (msm_vidc_debug & (__level)) { \
+			pr_info(VIDC_DBG_TAG_CORE __fmt, \
+				__level_str, \
+				DEFAULT_SID, \
+				"codec", \
+				##__VA_ARGS__); \
+		} \
+	} while (0)
+
+#define d_vpr_e(__fmt, ...) dprintk_core(VIDC_ERR,  "err ", __fmt, ##__VA_ARGS__)
+#define d_vpr_h(__fmt, ...) dprintk_core(VIDC_HIGH, "high", __fmt, ##__VA_ARGS__)
+#define d_vpr_l(__fmt, ...) dprintk_core(VIDC_LOW,  "low ", __fmt, ##__VA_ARGS__)
+#define d_vpr_p(__fmt, ...) dprintk_core(VIDC_PERF, "perf", __fmt, ##__VA_ARGS__)
+#define d_vpr_t(__fmt, ...) dprintk_core(VIDC_PKT,  "pkt ", __fmt, ##__VA_ARGS__)
+#define d_vpr_b(__fmt, ...) dprintk_core(VIDC_BUS,  "bus ", __fmt, ##__VA_ARGS__)
+#define d_vpr_s(__fmt, ...) dprintk_core(VIDC_STAT, "stat", __fmt, ##__VA_ARGS__)
+#define d_vpr_hs(__fmt, ...) \
+	dprintk_core(VIDC_HIGH | VIDC_STAT, "high", __fmt, ##__VA_ARGS__)
+
+#define dprintk_ratelimit(__level, __level_str, __fmt, ...) \
+	do { \
+		if (msm_vidc_check_ratelimit()) { \
+			dprintk_core(__level, __level_str, __fmt, ##__VA_ARGS__); \
+		} \
+	} while (0)
+
+#define dprintk_firmware(__level, __fmt, ...)	\
+	do { \
+		if ((msm_fw_debug & (__level)) & FW_PRINTK) { \
+			pr_info(FW_DBG_TAG __fmt, \
+				"fw", \
+				##__VA_ARGS__); \
+		} \
+	} while (0)
+
+enum msm_vidc_debugfs_event {
+	MSM_VIDC_DEBUGFS_EVENT_ETB,
+	MSM_VIDC_DEBUGFS_EVENT_EBD,
+	MSM_VIDC_DEBUGFS_EVENT_FTB,
+	MSM_VIDC_DEBUGFS_EVENT_FBD,
+};
+
+enum msm_vidc_bug_on_error {
+	MSM_VIDC_BUG_ON_FATAL             = BIT(0),
+	MSM_VIDC_BUG_ON_NOC               = BIT(1),
+	MSM_VIDC_BUG_ON_WD_TIMEOUT        = BIT(2),
+};
+
+struct dentry *msm_vidc_debugfs_init_drv(void);
+struct dentry *msm_vidc_debugfs_init_core(struct msm_vidc_core *core);
+struct dentry *msm_vidc_debugfs_init_inst(struct msm_vidc_inst *inst,
+					  struct dentry *parent);
+void msm_vidc_debugfs_deinit_inst(struct msm_vidc_inst *inst);
+void msm_vidc_debugfs_update(struct msm_vidc_inst *inst,
+			     enum msm_vidc_debugfs_event e);
+int msm_vidc_check_ratelimit(void);
+
+static inline bool is_stats_enabled(void)
+{
+	return !!(msm_vidc_debug & VIDC_STAT);
+}
+
+#endif
diff --git a/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_debug.c b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_debug.c
new file mode 100644
index 0000000..489e8dc
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/src/msm_vidc_debug.c
@@ -0,0 +1,581 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "msm_vidc.h"
+#include "msm_vidc_core.h"
+#include "msm_vidc_debug.h"
+#include "msm_vidc_driver.h"
+#include "msm_vidc_inst.h"
+#include "msm_vidc_internal.h"
+
+#define MAX_DEBUG_LEVEL_STRING_LEN 15
+#define MSM_VIDC_MIN_STATS_DELAY_MS     200
+#define MSM_VIDC_MAX_STATS_DELAY_MS     10000
+
+unsigned int msm_vidc_debug = DRV_LOG;
+unsigned int msm_fw_debug = FW_LOG;
+
+static int debug_level_set_drv(const char *val,
+			       const struct kernel_param *kp)
+{
+	struct msm_vidc_core *core = NULL;
+	unsigned int dvalue;
+	int ret;
+
+	if (!kp || !kp->arg || !val) {
+		d_vpr_e("%s: Invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = kstrtouint(val, 0, &dvalue);
+	if (ret)
+		return ret;
+
+	msm_vidc_debug = dvalue;
+
+	core = *(struct msm_vidc_core **)kp->arg;
+
+	if (!core) {
+		d_vpr_e("%s: Invalid core/capabilities\n", __func__);
+		return 0;
+	}
+
+	/* check if driver is more than default level */
+	if ((dvalue & DRV_LOGMASK) & ~(DRV_LOG)) {
+		core->capabilities[HW_RESPONSE_TIMEOUT].value = 4 * HW_RESPONSE_TIMEOUT_VALUE;
+		core->capabilities[SW_PC_DELAY].value         = 4 * SW_PC_DELAY_VALUE;
+		core->capabilities[FW_UNLOAD_DELAY].value     = 4 * FW_UNLOAD_DELAY_VALUE;
+	} else {
+		/* reset timeout values, if user reduces the logging */
+		core->capabilities[HW_RESPONSE_TIMEOUT].value = HW_RESPONSE_TIMEOUT_VALUE;
+		core->capabilities[SW_PC_DELAY].value         = SW_PC_DELAY_VALUE;
+		core->capabilities[FW_UNLOAD_DELAY].value     = FW_UNLOAD_DELAY_VALUE;
+	}
+
+	d_vpr_h("timeout for driver: hw_response %u, sw_pc %u, fw_unload %u, debug_level %#x\n",
+		core->capabilities[HW_RESPONSE_TIMEOUT].value,
+		core->capabilities[SW_PC_DELAY].value,
+		core->capabilities[FW_UNLOAD_DELAY].value,
+		msm_vidc_debug);
+
+	return 0;
+}
+
+static int debug_level_set_fw(const char *val,
+			      const struct kernel_param *kp)
+{
+	struct msm_vidc_core *core = NULL;
+	unsigned int dvalue;
+	int ret;
+
+	if (!kp || !kp->arg || !val) {
+		d_vpr_e("%s: Invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = kstrtouint(val, 0, &dvalue);
+	if (ret)
+		return ret;
+
+	msm_fw_debug = dvalue;
+
+	core = *(struct msm_vidc_core **)kp->arg;
+
+	if (!core) {
+		d_vpr_e("%s: Invalid core/capabilities\n", __func__);
+		return 0;
+	}
+
+	/* check if firmware is more than default level */
+	if ((dvalue & FW_LOGMASK) & ~(FW_LOG)) {
+		core->capabilities[HW_RESPONSE_TIMEOUT].value = 4 * HW_RESPONSE_TIMEOUT_VALUE;
+		core->capabilities[SW_PC_DELAY].value         = 4 * SW_PC_DELAY_VALUE;
+		core->capabilities[FW_UNLOAD_DELAY].value     = 4 * FW_UNLOAD_DELAY_VALUE;
+	} else {
+		/* reset timeout values, if user reduces the logging */
+		core->capabilities[HW_RESPONSE_TIMEOUT].value = HW_RESPONSE_TIMEOUT_VALUE;
+		core->capabilities[SW_PC_DELAY].value         = SW_PC_DELAY_VALUE;
+		core->capabilities[FW_UNLOAD_DELAY].value     = FW_UNLOAD_DELAY_VALUE;
+	}
+
+	d_vpr_h("timeout for firmware: hw_response %u, sw_pc %u, fw_unload %u, debug_level %#x\n",
+		core->capabilities[HW_RESPONSE_TIMEOUT].value,
+		core->capabilities[SW_PC_DELAY].value,
+		core->capabilities[FW_UNLOAD_DELAY].value,
+		msm_fw_debug);
+
+	return 0;
+}
+
+static int debug_level_get_drv(char *buffer, const struct kernel_param *kp)
+{
+	return scnprintf(buffer, PAGE_SIZE, "%#x", msm_vidc_debug);
+}
+
+static int debug_level_get_fw(char *buffer, const struct kernel_param *kp)
+{
+	return scnprintf(buffer, PAGE_SIZE, "%#x", msm_fw_debug);
+}
+
+static const struct kernel_param_ops msm_vidc_debug_fops = {
+	.set = debug_level_set_drv,
+	.get = debug_level_get_drv,
+};
+
+static const struct kernel_param_ops msm_fw_debug_fops = {
+	.set = debug_level_set_fw,
+	.get = debug_level_get_fw,
+};
+
+static int fw_dump_set(const char *val, const struct kernel_param *kp)
+{
+	unsigned int dvalue;
+	int ret;
+
+	if (!kp || !kp->arg || !val) {
+		d_vpr_e("%s: Invalid params\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = kstrtouint(val, 0, &dvalue);
+	if (ret)
+		return ret;
+
+	msm_vidc_fw_dump = dvalue;
+
+	d_vpr_h("fw dump %s\n", msm_vidc_fw_dump ? "Enabled" : "Disabled");
+
+	return 0;
+}
+
+static int fw_dump_get(char *buffer, const struct kernel_param *kp)
+{
+	return scnprintf(buffer, PAGE_SIZE, "%#x", msm_vidc_fw_dump);
+}
+
+static const struct kernel_param_ops msm_vidc_fw_dump_fops = {
+	.set = fw_dump_set,
+	.get = fw_dump_get,
+};
+
+module_param_cb(msm_vidc_debug, &msm_vidc_debug_fops, &g_core, 0644);
+module_param_cb(msm_fw_debug, &msm_fw_debug_fops, &g_core, 0644);
+module_param_cb(msm_vidc_fw_dump, &msm_vidc_fw_dump_fops, &g_core, 0644);
+
+bool msm_vidc_fw_dump = !true;
+EXPORT_SYMBOL(msm_vidc_fw_dump);
+
+#define MAX_DBG_BUF_SIZE 4096
+
+struct core_inst_pair {
+	struct msm_vidc_core *core;
+	struct msm_vidc_inst *inst;
+};
+
+/* debug fs support */
+
+static u32 write_str(char *buffer, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	u32 len;
+
+	va_start(args, fmt);
+	len = vscnprintf(buffer, size, fmt, args);
+	va_end(args);
+	return len;
+}
+
+static ssize_t core_info_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct msm_vidc_core *core = file->private_data;
+	char *cur, *end, *dbuf = NULL;
+	ssize_t len = 0;
+
+	if (!core) {
+		d_vpr_e("%s: invalid params %pK\n", __func__, core);
+		return 0;
+	}
+
+	dbuf = vzalloc(MAX_DBG_BUF_SIZE);
+	if (!dbuf) {
+		d_vpr_e("%s: allocation failed\n", __func__);
+		return -ENOMEM;
+	}
+
+	cur = dbuf;
+	end = cur + MAX_DBG_BUF_SIZE;
+
+	cur += write_str(cur, end - cur, "Core state: %d\n", core->state);
+
+	cur += write_str(cur, end - cur,
+		"FW version : %s\n", core->fw_version);
+	cur += write_str(cur, end - cur,
+		"register_base: 0x%x\n", core->resource->register_base_addr);
+	cur += write_str(cur, end - cur, "irq: %u\n", core->resource->irq);
+
+	len = simple_read_from_buffer(buf, count, ppos, dbuf, cur - dbuf);
+
+	vfree(dbuf);
+	return len;
+}
+
+static const struct file_operations core_info_fops = {
+	.open = simple_open,
+	.read = core_info_read,
+};
+
+static ssize_t stats_delay_write_ms(struct file *filp, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	int rc = 0;
+	struct msm_vidc_core *core = filp->private_data;
+	char kbuf[MAX_DEBUG_LEVEL_STRING_LEN] = {0};
+	u32 delay_ms = 0;
+
+	if (!core) {
+		d_vpr_e("%s: invalid params %pK\n", __func__, core);
+		return 0;
+	}
+
+	/* filter partial writes and invalid commands */
+	if (*ppos != 0 || count >= sizeof(kbuf) || count == 0) {
+		d_vpr_e("returning error - pos %lld, count %lu\n", *ppos, count);
+		rc = -EINVAL;
+	}
+
+	rc = simple_write_to_buffer(kbuf, sizeof(kbuf) - 1, ppos, buf, count);
+	if (rc < 0) {
+		d_vpr_e("%s: User memory fault\n", __func__);
+		rc = -EFAULT;
+		goto exit;
+	}
+
+	rc = kstrtoint(kbuf, 0, &delay_ms);
+	if (rc) {
+		d_vpr_e("returning error err %d\n", rc);
+		rc = -EINVAL;
+		goto exit;
+	}
+	delay_ms = clamp_t(u32, delay_ms, MSM_VIDC_MIN_STATS_DELAY_MS, MSM_VIDC_MAX_STATS_DELAY_MS);
+	core->capabilities[STATS_TIMEOUT_MS].value = delay_ms;
+	d_vpr_h("Stats delay is updated to - %d ms\n", delay_ms);
+
+exit:
+	return rc;
+}
+
+static ssize_t stats_delay_read_ms(struct file *file, char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	size_t len;
+	char kbuf[MAX_DEBUG_LEVEL_STRING_LEN];
+	struct msm_vidc_core *core = file->private_data;
+
+	if (!core) {
+		d_vpr_e("%s: invalid params %pK\n", __func__, core);
+		return 0;
+	}
+
+	len = scnprintf(kbuf, sizeof(kbuf), "%u\n", core->capabilities[STATS_TIMEOUT_MS].value);
+	return simple_read_from_buffer(buf, count, ppos, kbuf, len);
+}
+
+static const struct file_operations stats_delay_fops = {
+	.open = simple_open,
+	.write = stats_delay_write_ms,
+	.read = stats_delay_read_ms,
+};
+
+struct dentry *msm_vidc_debugfs_init_drv(void)
+{
+	struct dentry *dir = NULL;
+
+	dir = debugfs_create_dir("msm_vidc", NULL);
+	if (IS_ERR_OR_NULL(dir)) {
+		dir = NULL;
+		goto failed_create_dir;
+	}
+
+	return dir;
+
+failed_create_dir:
+	debugfs_remove_recursive(dir);
+
+	return NULL;
+}
+
+struct dentry *msm_vidc_debugfs_init_core(struct msm_vidc_core *core)
+{
+	struct dentry *dir = NULL;
+	char debugfs_name[MAX_DEBUGFS_NAME];
+	struct dentry *parent;
+
+	if (!core->debugfs_parent) {
+		d_vpr_e("%s: invalid params\n", __func__);
+		goto failed_create_dir;
+	}
+	parent = core->debugfs_parent;
+
+	snprintf(debugfs_name, MAX_DEBUGFS_NAME, "core");
+	dir = debugfs_create_dir(debugfs_name, parent);
+	if (IS_ERR_OR_NULL(dir)) {
+		dir = NULL;
+		d_vpr_e("Failed to create debugfs for msm_vidc\n");
+		goto failed_create_dir;
+	}
+	if (!debugfs_create_file("info", 0444, dir, core, &core_info_fops)) {
+		d_vpr_e("debugfs_create_file: fail\n");
+		goto failed_create_dir;
+	}
+
+	if (!debugfs_create_file("stats_delay_ms", 0644, dir, core, &stats_delay_fops)) {
+		d_vpr_e("debugfs_create_file: fail\n");
+		goto failed_create_dir;
+	}
+failed_create_dir:
+	return dir;
+}
+
+static int inst_info_open(struct inode *inode, struct file *file)
+{
+	d_vpr_l("Open inode ptr: %pK\n", inode->i_private);
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t inst_info_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	struct core_inst_pair *idata = file->private_data;
+	struct msm_vidc_core *core;
+	struct msm_vidc_inst *inst;
+	char *cur, *end, *dbuf = NULL;
+	int i, j;
+	ssize_t len = 0;
+	struct v4l2_format *f;
+
+	if (!idata || !idata->core || !idata->inst) {
+		d_vpr_e("%s: invalid params %pK\n", __func__, idata);
+		return 0;
+	}
+
+	core = idata->core;
+	inst = idata->inst;
+
+	inst = get_inst(core, inst->session_id);
+	if (!inst) {
+		d_vpr_h("%s: instance has become obsolete", __func__);
+		return 0;
+	}
+
+	dbuf = vzalloc(MAX_DBG_BUF_SIZE);
+	if (!dbuf) {
+		d_vpr_e("%s: allocation failed\n", __func__);
+		len = -ENOMEM;
+		goto failed_alloc;
+	}
+	cur = dbuf;
+	end = cur + MAX_DBG_BUF_SIZE;
+
+	f = &inst->fmts[OUTPUT_PORT];
+	cur += write_str(cur, end - cur, "==============================\n");
+	cur += write_str(cur, end - cur, "INSTANCE: %pK (%s)\n", inst,
+		inst->domain == MSM_VIDC_ENCODER ? "Encoder" : "Decoder");
+	cur += write_str(cur, end - cur, "==============================\n");
+	cur += write_str(cur, end - cur, "core: %pK\n", inst->core);
+	cur += write_str(cur, end - cur, "height: %d\n", f->fmt.pix_mp.height);
+	cur += write_str(cur, end - cur, "width: %d\n", f->fmt.pix_mp.width);
+	cur += write_str(cur, end - cur, "fps: %d\n",
+			inst->capabilities[FRAME_RATE].value >> 16);
+	cur += write_str(cur, end - cur, "state: %d\n", inst->state);
+	cur += write_str(cur, end - cur, "-----------Formats-------------\n");
+	for (i = 0; i < MAX_PORT; i++) {
+		if (i != INPUT_PORT && i != OUTPUT_PORT)
+			continue;
+		f = &inst->fmts[i];
+		cur += write_str(cur, end - cur, "capability: %s\n",
+			i == INPUT_PORT ? "Output" : "Capture");
+		cur += write_str(cur, end - cur, "planes : %d\n",
+			f->fmt.pix_mp.num_planes);
+		cur += write_str(cur, end - cur,
+			"type: %s\n", i == INPUT_PORT ?
+			"Output" : "Capture");
+		cur += write_str(cur, end - cur, "count: %u\n",
+				inst->bufq[i].vb2q->num_buffers);
+
+		for (j = 0; j < f->fmt.pix_mp.num_planes; j++)
+			cur += write_str(cur, end - cur,
+				"size for plane %d: %u\n",
+				j, f->fmt.pix_mp.plane_fmt[j].sizeimage);
+
+		cur += write_str(cur, end - cur, "\n");
+	}
+	cur += write_str(cur, end - cur, "-------------------------------\n");
+	cur += write_str(cur, end - cur, "ETB Count: %d\n",
+		inst->debug_count.etb);
+	cur += write_str(cur, end - cur, "EBD Count: %d\n",
+		inst->debug_count.ebd);
+	cur += write_str(cur, end - cur, "FTB Count: %d\n",
+		inst->debug_count.ftb);
+	cur += write_str(cur, end - cur, "FBD Count: %d\n",
+		inst->debug_count.fbd);
+
+	len = simple_read_from_buffer(buf, count, ppos,
+				      dbuf, cur - dbuf);
+
+	vfree(dbuf);
+failed_alloc:
+	put_inst(inst);
+	return len;
+}
+
+static int inst_info_release(struct inode *inode, struct file *file)
+{
+	d_vpr_l("Release inode ptr: %pK\n", inode->i_private);
+	file->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations inst_info_fops = {
+	.open = inst_info_open,
+	.read = inst_info_read,
+	.release = inst_info_release,
+};
+
+struct dentry *msm_vidc_debugfs_init_inst(struct msm_vidc_inst *inst, struct dentry *parent)
+{
+	struct dentry *dir = NULL, *info = NULL;
+	char debugfs_name[MAX_DEBUGFS_NAME];
+	struct core_inst_pair *idata = NULL;
+
+	snprintf(debugfs_name, MAX_DEBUGFS_NAME, "inst_%d", inst->session_id);
+
+	idata = vzalloc(sizeof(*idata));
+	if (!idata) {
+		i_vpr_e(inst, "%s: allocation failed\n", __func__);
+		goto exit;
+	}
+
+	idata->core = inst->core;
+	idata->inst = inst;
+
+	dir = debugfs_create_dir(debugfs_name, parent);
+	if (IS_ERR_OR_NULL(dir)) {
+		dir = NULL;
+		i_vpr_e(inst,
+			"%s: Failed to create debugfs for msm_vidc\n",
+			__func__);
+		goto failed_create_dir;
+	}
+
+	info = debugfs_create_file("info", 0444, dir,
+				   idata, &inst_info_fops);
+	if (IS_ERR_OR_NULL(info)) {
+		i_vpr_e(inst, "%s: debugfs_create_file: fail\n",
+			__func__);
+		goto failed_create_file;
+	}
+
+	dir->d_inode->i_private = info->d_inode->i_private;
+	return dir;
+
+failed_create_file:
+	debugfs_remove_recursive(dir);
+	dir = NULL;
+failed_create_dir:
+	vfree(idata);
+exit:
+	return dir;
+}
+
+void msm_vidc_debugfs_deinit_inst(struct msm_vidc_inst *inst)
+{
+	struct dentry *dentry = NULL;
+
+	if (!inst->debugfs_root)
+		return;
+
+	dentry = inst->debugfs_root;
+	if (dentry->d_inode) {
+		i_vpr_l(inst, "%s: Destroy %pK\n",
+			__func__, dentry->d_inode->i_private);
+		vfree(dentry->d_inode->i_private);
+		dentry->d_inode->i_private = NULL;
+	}
+	debugfs_remove_recursive(dentry);
+	inst->debugfs_root = NULL;
+}
+
+void msm_vidc_debugfs_update(struct msm_vidc_inst *inst,
+			     enum msm_vidc_debugfs_event e)
+{
+	switch (e) {
+	case MSM_VIDC_DEBUGFS_EVENT_ETB:
+		inst->debug_count.etb++;
+		if (inst->debug_count.ebd &&
+		    inst->debug_count.ftb > inst->debug_count.fbd) {
+		}
+		break;
+	case MSM_VIDC_DEBUGFS_EVENT_EBD:
+		inst->debug_count.ebd++;
+		/*
+		 * Host needs to ensure FW at least have 2 buffers available always
+		 * one for HW processing and another for fw processing in parallel
+		 * to avoid FW starving for buffers
+		 */
+		if (inst->debug_count.etb < (inst->debug_count.ebd + 2)) {
+			i_vpr_p(inst,
+				"EBD: FW needs input buffers. Processed etb %llu ebd %llu ftb %llu fbd %llu\n",
+				inst->debug_count.etb, inst->debug_count.ebd,
+				inst->debug_count.ftb, inst->debug_count.fbd);
+		}
+		if (inst->debug_count.fbd &&
+		    inst->debug_count.ftb < (inst->debug_count.fbd + 2))
+			i_vpr_p(inst,
+				"EBD: FW needs output buffers. Processed etb %llu ebd %llu ftb %llu fbd %llu\n",
+				inst->debug_count.etb, inst->debug_count.ebd,
+				inst->debug_count.ftb, inst->debug_count.fbd);
+		break;
+	case MSM_VIDC_DEBUGFS_EVENT_FTB:
+		inst->debug_count.ftb++;
+		if (inst->debug_count.ebd &&
+		    inst->debug_count.etb > inst->debug_count.ebd) {
+		}
+		break;
+	case MSM_VIDC_DEBUGFS_EVENT_FBD:
+		inst->debug_count.fbd++;
+		/*
+		 * Host needs to ensure FW at least have 2 buffers available always
+		 * one for HW processing and another for fw processing in parallel
+		 * to avoid FW starving for buffers
+		 */
+		if (inst->debug_count.ftb < (inst->debug_count.fbd + 2)) {
+			i_vpr_p(inst,
+				"FBD: FW needs output buffers. Processed etb %llu ebd %llu ftb %llu fbd %llu\n",
+				inst->debug_count.etb, inst->debug_count.ebd,
+				inst->debug_count.ftb, inst->debug_count.fbd);
+		}
+		if (inst->debug_count.ebd &&
+		    inst->debug_count.etb < (inst->debug_count.ebd + 2))
+			i_vpr_p(inst,
+				"FBD: FW needs input buffers. Processed etb %llu ebd %llu ftb %llu fbd %llu\n",
+				inst->debug_count.etb, inst->debug_count.ebd,
+				inst->debug_count.ftb, inst->debug_count.fbd);
+		break;
+	default:
+		i_vpr_e(inst, "invalid event in debugfs: %d\n", e);
+		break;
+	}
+}
+
+int msm_vidc_check_ratelimit(void)
+{
+	static DEFINE_RATELIMIT_STATE(_rs,
+				VIDC_DBG_SESSION_RATELIMIT_INTERVAL,
+				VIDC_DBG_SESSION_RATELIMIT_BURST);
+	return __ratelimit(&_rs);
+}
-- 
2.7.4

