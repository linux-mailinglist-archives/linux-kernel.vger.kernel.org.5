Return-Path: <linux-kernel+bounces-70297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B902F8595C0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA531F22508
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC2B10A0D;
	Sun, 18 Feb 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b+SldZ+f"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4463A7;
	Sun, 18 Feb 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708245924; cv=none; b=X7EvG0AdlxC4+ht3x4DocXPazsrgCR+hBRsZAq25O9iy/eE/9PS4DR21GZezL7IF0NBDSHuWccmWUB5PJSr75LPN4mgZEv0aDPQVQPRYiUKc4wQeAhqkihsD5anrGVClxeDku2zswXGYQ+OooYsmsF21usfh8YVLDj64Ru7pFuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708245924; c=relaxed/simple;
	bh=s0e8d/D7C6nbPI5ya3os5qMDpMCA/WnNjDAq9XnA/K8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fmZVtwPYKOLu8ejLC8w22Itx1Zhx9/W3TmFGwsy5u7j+rtN2tCSaUqSlCJVS/ULIU7tCRv0u/bPR/6mko9TASw+0zdyY45LFJOlOt7Cqy+qD2RW/zAWIfAYwVRlIhWdPQWwYS7WkNl4iMWdaioQC73TChBRnKChrajb5LNKsF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b+SldZ+f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41I8jEvA024377;
	Sun, 18 Feb 2024 08:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=kY1
	NBOAgu/U1j9Fa6JABYuoNXSOLLP0J8W+rur07U+Q=; b=b+SldZ+fMZRrJk4/Gff
	bDZ44zibb11s3RtrMZEbRUREnY/UzvUnkZNNzpIDDhHnRy7VYqQXJMu9814j8GiE
	NNVrdq4rhSG15IgRl6BmFyrV61bQtepBDO9KWz/Ibow0xRfm7HOXBpUGptykXfvv
	RhzTUyB/pPjzYQZjPjQiMEqz3fKH7pSFU+VJp2yTGflhenFqXes+xeD+QsOwKzpK
	jj0F2mdStySvQdMbTPB0mJ5uBJ5dneEpH7veyRKN8ntUbEnHspVnny6sP9YxpCGd
	BTVto7XYbFtwKMB386dwXeIaUvovbjuwGFw2dVM7ol//4V/icXosCknQ66r/ckR2
	LXg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wan17hhnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 08:45:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41I8jDBH016301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 08:45:13 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 18 Feb 2024 00:45:09 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 18 Feb 2024 14:13:39 +0530
Subject: [PATCH] bus: mhi: host: Change the trace string for the userspace
 tools mapping
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240218-ftrace_string-v1-1-27da85c1f844@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADzD0WUC/x3MQQqAIBBA0avIrBPUQqOrRITYZLOxGCWC8O5Jy
 7f4/4WMTJhhEi8w3pTpTA26ExAOnyJK2prBKDMoo0e5F/YB11yYUpTOOues8d72AVpzMe70/L9
 5qfUDP0PxY18AAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Steven Rostedt
	<rostedt@goodmis.org>
CC: <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708245908; l=2059;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=s0e8d/D7C6nbPI5ya3os5qMDpMCA/WnNjDAq9XnA/K8=;
 b=OWRiAqsu0nVhFU0aJFmTLUTPLcCmTsVx/NztAgu7GRyT3yw8kXW1O1ARRFwMfTgOwSANcluOt
 DI3bWfEJ7XQDZ4lxAFHFM4Dk+cEFJjy4vj4FsBwB9ZS4LSD3UhhZ7Rh
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: c64ZYWOqttvm1mQxeQ6eQL5AHsR9l3xc
X-Proofpoint-GUID: c64ZYWOqttvm1mQxeQ6eQL5AHsR9l3xc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_06,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=956 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402180065

User space tools can't map strings if we use directly, as the string
address is internal to kernel.

So add trace point strings for the user space tools to map strings
properly.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/bus/mhi/host/main.c  | 4 ++--
 drivers/bus/mhi/host/trace.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 2d38f6005da6..15d657af9b5b 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -1340,7 +1340,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 	enum mhi_cmd_type cmd = MHI_CMD_NOP;
 	int ret;
 
-	trace_mhi_channel_command_start(mhi_cntrl, mhi_chan, to_state, "Updating");
+	trace_mhi_channel_command_start(mhi_cntrl, mhi_chan, to_state, TPS("Updating"));
 	switch (to_state) {
 	case MHI_CH_STATE_TYPE_RESET:
 		write_lock_irq(&mhi_chan->lock);
@@ -1407,7 +1407,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
 		write_unlock_irq(&mhi_chan->lock);
 	}
 
-	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, "Updated");
+	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, TPS("Updated"));
 exit_channel_update:
 	mhi_cntrl->runtime_put(mhi_cntrl);
 	mhi_device_put(mhi_cntrl->mhi_dev);
diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
index d12a98d44272..368515dcb22d 100644
--- a/drivers/bus/mhi/host/trace.h
+++ b/drivers/bus/mhi/host/trace.h
@@ -84,6 +84,8 @@ DEV_ST_TRANSITION_LIST
 #define dev_st_trans(a, b)		{ DEV_ST_TRANSITION_##a, b },
 #define dev_st_trans_end(a, b)		{ DEV_ST_TRANSITION_##a, b }
 
+#define TPS(x)	tracepoint_string(x)
+
 TRACE_EVENT(mhi_gen_tre,
 
 	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,

---
base-commit: ceeb64f41fe6a1eb9fc56d583983a81f8f3dd058
change-id: 20240218-ftrace_string-7677762aa63c

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


