Return-Path: <linux-kernel+bounces-29695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187F48311ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8627DB21159
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78A9468;
	Thu, 18 Jan 2024 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SA+1KVm9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB38C9442;
	Thu, 18 Jan 2024 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705549995; cv=none; b=iFc5cpCuQInj0uVcEmSrJ/Ssm0NyW3gZrVPS6KqDx8gXOeqUA+/rIXya28gRAjsTGkp7LYFuaktl06DjtniUQZiqOR1LNe9vtBdhNBoCXl4fUTLR7dokaYGfJMPDnyu10vdXjGBSBfm6aXs+3QYukHlOuOU5miMb3K2GSC5dhok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705549995; c=relaxed/simple;
	bh=uKYbhZDXVvMeXe/BI115uaGmj5x/sAaoCFBNqhAx4FQ=;
	h=Received:DKIM-Signature:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:X-B4-Tracking:To:CC:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=q0kYLpEYgPklaCEfkVoWKpY4aMjf4tBM9wTT2eTe+ULbk34uMC+Snk6jKhJiBt8C2B5aRDt2Em8+A0xjzXNVQds7XoB7hB8TrGcXvGcWn2/ALAlfyspIIIzEalB+FVQTPq5iMC+UX7e1BS6MP6OBpgTsN/oN1ICsfEzMsbdKp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SA+1KVm9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I3cZcd026378;
	Thu, 18 Jan 2024 03:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=/FF
	S3uofgLqX7Hi094cPwBpyKwpIgFMIcpb4zu6EQVg=; b=SA+1KVm9MeAe5IUG1bm
	Y8GI1Fc7C8xGg5h4/pUPRJVCg61PfrF3bDexGc1S/Qs5+ZGB+aCSr9JZ1xzxtC7+
	78xmkWRHqRdCgvzkjjZRG/1XLQ0O5P2xi5RSSwCoBkiOfCqYPcTE9oZWlv4UvL8r
	AIJfi91mToBcfhh50EzRFvkgHTbNnQX9gXL6hwcd9jvJG/lgv2KMEz45LnRLmDGS
	iQegA6nJeG38tSb9azkt9fIF2j4JW2Lt+k8k6pA8D6F/pioBXomPYum2ZlJcWfAk
	jPTO4iz8eOqoTZ4YEBaebNzfJCIMSeemJ6RwdxclxVxQkO6lulnW8wdlDaWRV2v1
	l7A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpm1fryvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 03:53:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40I3r8xm000642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 03:53:08 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 19:53:08 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Wed, 17 Jan 2024 19:52:56 -0800
Subject: [PATCH] soc: qcom: aoss: Add tracepoints in qmp_send()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240117-qcom-aoss-tracepoints-v1-1-4f935920cf4b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJegqGUC/x2NQQrCQAwAv1JyNlBTROtXxEM2Rhuo2bqpUij9e
 xePMzDMCqHFNODarFD0Z2HZKxwPDcjA/lK0R2Wglrq2pzN+JL+RcwTOhUWnbD4HyunSkTBpoh5
 qmzgUU2GXodb+Hccqp6JPW/6z233bdiFk/cJ8AAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>, Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705549988; l=3208;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=uKYbhZDXVvMeXe/BI115uaGmj5x/sAaoCFBNqhAx4FQ=;
 b=v1Pt0gFw703gRW4WAVGjoJZQXLexyeFDcc78IjpHFygfKPmBivQxzhewC0byT7DhL46FuO0f7
 jg6JeJnNQWrCDen0UBLavYTBmczzgIJIKBw6UQIsx52JcCeB08vGRsJ
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _DXbOpG5chHE19HvBflBfqGol2Ikenx7
X-Proofpoint-GUID: _DXbOpG5chHE19HvBflBfqGol2Ikenx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_14,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180025

Add tracepoint for tracing the messages being sent and the success
thereof. This is useful as the system has a variety of clients sending
requests to the always-on subsystem.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/soc/qcom/Makefile     |  1 +
 drivers/soc/qcom/qcom_aoss.c  |  7 +++++++
 drivers/soc/qcom/trace-aoss.h | 48 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 05b3d54e8dc9..9268e15e1719 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_rpmh-rsc.o := -I$(src)
+CFLAGS_qcom_aoss.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index aff0cfb71482..db94b2d17e7d 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -13,6 +13,9 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/qcom_aoss.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace-aoss.h"
+
 #define QMP_DESC_MAGIC			0x0
 #define QMP_DESC_VERSION		0x4
 #define QMP_DESC_FEATURES		0x8
@@ -235,6 +238,8 @@ int qmp_send(struct qmp *qmp, const char *fmt, ...)
 
 	mutex_lock(&qmp->tx_lock);
 
+	trace_aoss_send(buf);
+
 	/* The message RAM only implements 32-bit accesses */
 	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
 			 buf, sizeof(buf) / sizeof(u32));
@@ -256,6 +261,8 @@ int qmp_send(struct qmp *qmp, const char *fmt, ...)
 		ret = 0;
 	}
 
+	trace_aoss_send_done(buf, ret);
+
 	mutex_unlock(&qmp->tx_lock);
 
 	return ret;
diff --git a/drivers/soc/qcom/trace-aoss.h b/drivers/soc/qcom/trace-aoss.h
new file mode 100644
index 000000000000..48cd3f0f4cb8
--- /dev/null
+++ b/drivers/soc/qcom/trace-aoss.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_aoss
+
+#if !defined(_TRACE_RPMH_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RPMH_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(aoss_send,
+	TP_PROTO(const char *msg),
+	TP_ARGS(msg),
+	TP_STRUCT__entry(
+		__string(msg, msg)
+	),
+	TP_fast_assign(
+		__assign_str(msg, msg);
+	),
+	TP_printk("%s", __get_str(msg))
+);
+
+TRACE_EVENT(aoss_send_done,
+	TP_PROTO(const char *msg, int ret),
+	TP_ARGS(msg, ret),
+	TP_STRUCT__entry(
+		__string(msg, msg)
+		__field(int, ret)
+	),
+	TP_fast_assign(
+		__assign_str(msg, msg);
+		__entry->ret = ret;
+	),
+	TP_printk("%s: %d", __get_str(msg), __entry->ret)
+);
+
+#endif /* _TRACE_RPMH_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace-aoss
+
+#include <trace/define_trace.h>

---
base-commit: 943b9f0ab2cfbaea148dd6ac279957eb08b96904
change-id: 20230927-qcom-aoss-tracepoints-c5832ca2eb29

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


