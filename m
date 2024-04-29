Return-Path: <linux-kernel+bounces-161886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0CE8B52B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657DB282009
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D97171C9;
	Mon, 29 Apr 2024 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G3LmW3uB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB514AB0;
	Mon, 29 Apr 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377370; cv=none; b=LbYg3zJS1T4eWSuaTbXgMoRLdUOgxHz3xXRvPj2l1TVG9naX40CwbAvq8rjaBI3mH85XNPy5zgGKNUADZ3pmGp7lxhr+VVPIaQjl6easgN06guv4g+/SQ611rIxzF5K9nHuvbZJXNwvcUXR1MXFppznOmNTPP/dSgmyaJKwF5ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377370; c=relaxed/simple;
	bh=r6S5MOacY5QRk302Bfmb2I3E++F09XEoC/O/+83ErDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GqlgD/A1cgcXgJqzzKVgbyIUH3qUiWsBlXM38iuzaGKZRVPE6VKemyR9zmNqgmTrh7bBowdsHdh5EKr6jL7K6UZRsZXefpvz2I001Nyww0ibaFLBdssPyTipqtoc/Idpiykee3Aa23/sAx43x5tquRsvYmTMMjIZsrG0N5SyweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G3LmW3uB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T4dxlB009472;
	Mon, 29 Apr 2024 07:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Mdq8xm1
	TDA9azyRgISTqabXD2DV2KdmkzikPaa6Dr2I=; b=G3LmW3uBRaaMNBs+BSddfvr
	ax1675BjlE78WTwp0GLE/AqVZ25LFeH8CRDLTs6/0lAOZ9gQ8RWhDV53eCR1OEqj
	ICcwYwJq3LsMYC9Z1sf/mBUxvOR78eYIoiwHaPmhkXiy2hvJ8/WoHbGCJXTCTY4a
	iZNN4HwRHYDOw1vIIjbz9hRzPR/UJ3qkvHZVT89nebChXbVvMbw9H8sXiIW72hEz
	h+TOMAuIRFA07iK1+RXu4ene9+mGdjxNlG+WRbGRtJ0l6wCy0tSYiSmtqWMUR3t3
	eHH9DLffGdMdkbd9UOrAOUgWw+1eIaJ+/oe9MJLyncR47OXPHmWOhe8EwrVDtcg=
	=
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrtnek0ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:56:03 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T7u2sT020554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 07:56:02 GMT
Received: from hu-sudeepgo-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 00:55:59 -0700
From: Sudeepgoud Patil <quic_sudeepgo@quicinc.com>
To: <quic_bjorande@quicinc.com>, <andersson@kernel.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <quic_deesin@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        "Konrad
 Dybcio" <konrad.dybcio@linaro.org>
Subject: [PATCH V1] soc: qcom: smp2p: Introduce tracepoint support
Date: Mon, 29 Apr 2024 13:25:24 +0530
Message-ID: <20240429075528.1723133-1-quic_sudeepgo@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8KLYj2xStve0AFmBV336ust-fV1VGiLD
X-Proofpoint-ORIG-GUID: 8KLYj2xStve0AFmBV336ust-fV1VGiLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_05,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290049

Introduce tracepoint support for smp2p providing useful logging
for communication between clients.

Signed-off-by: Sudeepgoud Patil <quic_sudeepgo@quicinc.com>
Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
---
 drivers/soc/qcom/Makefile      |  1 +
 drivers/soc/qcom/smp2p.c       | 10 ++++
 drivers/soc/qcom/trace-smp2p.h | 99 ++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/soc/qcom/trace-smp2p.h

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index ca0bece0dfff..30c1bf645501 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -23,6 +23,7 @@ qcom_rpmh-y			+= rpmh.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= rpm-proc.o smd-rpm.o
 obj-$(CONFIG_QCOM_SMEM) +=	smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
+CFLAGS_smp2p.o := -I$(src)
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_SOCINFO)	+= socinfo.o
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index a21241cbeec7..dde8513641ae 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -20,6 +20,9 @@
 #include <linux/soc/qcom/smem_state.h>
 #include <linux/spinlock.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace-smp2p.h"
+
 /*
  * The Shared Memory Point to Point (SMP2P) protocol facilitates communication
  * of a single 32-bit value between two processors.  Each value has a single
@@ -191,6 +194,7 @@ static void qcom_smp2p_do_ssr_ack(struct qcom_smp2p *smp2p)
 	struct smp2p_smem_item *out = smp2p->out;
 	u32 val;
 
+	trace_smp2p_ssr_ack(smp2p->remote_pid);
 	smp2p->ssr_ack = !smp2p->ssr_ack;
 
 	val = out->flags & ~BIT(SMP2P_FLAGS_RESTART_ACK_BIT);
@@ -213,6 +217,7 @@ static void qcom_smp2p_negotiate(struct qcom_smp2p *smp2p)
 			smp2p->ssr_ack_enabled = true;
 
 		smp2p->negotiation_done = true;
+		trace_smp2p_negotiate(smp2p->remote_pid, smp2p->ssr_ack_enabled);
 	}
 }
 
@@ -251,6 +256,8 @@ static void qcom_smp2p_notify_in(struct qcom_smp2p *smp2p)
 		status = val ^ entry->last_value;
 		entry->last_value = val;
 
+		trace_smp2p_notify_in(smp2p->remote_pid, entry->name, status, val);
+
 		/* No changes of this entry? */
 		if (!status)
 			continue;
@@ -406,6 +413,9 @@ static int smp2p_update_bits(void *data, u32 mask, u32 value)
 	writel(val, entry->value);
 	spin_unlock_irqrestore(&entry->lock, flags);
 
+	trace_smp2p_update_bits(entry->smp2p->remote_pid,
+		entry->name, orig, val);
+
 	if (val != orig)
 		qcom_smp2p_kick(entry->smp2p);
 
diff --git a/drivers/soc/qcom/trace-smp2p.h b/drivers/soc/qcom/trace-smp2p.h
new file mode 100644
index 000000000000..c61afab23f0c
--- /dev/null
+++ b/drivers/soc/qcom/trace-smp2p.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_smp2p
+
+#if !defined(__QCOM_SMP2P_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ)
+#define __QCOM_SMP2P_TRACE_H__
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(smp2p_ssr_ack,
+	TP_PROTO(unsigned int remote_pid),
+	TP_ARGS(remote_pid),
+	TP_STRUCT__entry(
+		__field(u32, remote_pid)
+	),
+	TP_fast_assign(
+		__entry->remote_pid = remote_pid;
+	),
+	TP_printk("%d: SSR detected, doing SSR Handshake",
+		__entry->remote_pid
+	)
+);
+
+TRACE_EVENT(smp2p_negotiate,
+	TP_PROTO(unsigned int remote_pid, bool ssr_ack_enabled),
+	TP_ARGS(remote_pid, ssr_ack_enabled),
+	TP_STRUCT__entry(
+		__field(u32, remote_pid)
+		__field(bool, ssr_ack_enabled)
+	),
+	TP_fast_assign(
+		__entry->remote_pid = remote_pid;
+		__entry->ssr_ack_enabled = ssr_ack_enabled;
+	),
+	TP_printk("%d: state=open ssr_ack=%d",
+		__entry->remote_pid,
+		__entry->ssr_ack_enabled
+	)
+);
+
+TRACE_EVENT(smp2p_notify_in,
+	TP_PROTO(unsigned int remote_pid, const char *name, unsigned long status, u32 val),
+	TP_ARGS(remote_pid, name, status, val),
+	TP_STRUCT__entry(
+		__field(u32, remote_pid)
+		__string(name, name)
+		__field(unsigned long, status)
+		__field(u32, val)
+	),
+	TP_fast_assign(
+		__entry->remote_pid = remote_pid;
+		__assign_str(name, name);
+		__entry->status = status;
+		__entry->val = val;
+	),
+	TP_printk("%d: %s: status:0x%0lx val:0x%0x",
+		__entry->remote_pid,
+		__get_str(name),
+		__entry->status,
+		__entry->val
+	)
+);
+
+TRACE_EVENT(smp2p_update_bits,
+	TP_PROTO(unsigned int remote_pid, const char *name, u32 orig, u32 val),
+	TP_ARGS(remote_pid, name, orig, val),
+	TP_STRUCT__entry(
+		__field(u32, remote_pid)
+		__string(name, name)
+		__field(u32, orig)
+		__field(u32, val)
+	),
+	TP_fast_assign(
+		__entry->remote_pid = remote_pid;
+		__assign_str(name, name);
+		__entry->orig = orig;
+		__entry->val = val;
+	),
+	TP_printk("%d: %s: orig:0x%0x new:0x%0x",
+		__entry->remote_pid,
+		__get_str(name),
+		__entry->orig,
+		__entry->val
+	)
+);
+
+#endif /* __QCOM_SMP2P_TRACE_H__ */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace-smp2p
+
+#include <trace/define_trace.h>
-- 

