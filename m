Return-Path: <linux-kernel+bounces-44505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1258422ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D8C2923E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B967A19;
	Tue, 30 Jan 2024 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XKWO2fZ9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF667A00;
	Tue, 30 Jan 2024 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613877; cv=none; b=QsZPSg+NlbuyQUYqvD9z1rz7MxDCP2BzQcjvqVQqFnf8OKkDTTooIa4QVbJS9Us/WskRj4t9zzXiYS4OotBDQb0PKH3OpCHJzYie/FvTMF7kt5v0xvy2OZfjsJXqvPq1KrGTdO2xTEfC8xx6qJaqhPjj2Fuspmflc28+iH6xfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613877; c=relaxed/simple;
	bh=Bz35TTRa8a3uBvuKzhZpF+dDo7xUztE14B9CFHxL7nU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCjQH86wBIT5LDD9tsGzpZkLxseHaVkQR6Y0tu3UZJbmot0vNT6AKLVET2arUCNEUw1uJzZC6jKT3A3OWtrZ3yJTMVYl6zN9ywXdIgBNj8pJziy0QZLLfib5axwG4eerkBlVBPgsvaQsupuSDegf9OH44c/4QPRzkdLCDoCVGog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XKWO2fZ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9Rh2s022976;
	Tue, 30 Jan 2024 11:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=uiCF3OXqUPyaGiKkRjUFI/DkOvlguaMrc70vArbkT24=; b=XK
	WO2fZ9c6Jxke5SBtQTu8uH4NxKVudz30Ufu0i7M2HOqWklSAcQ/Ekpv18TwzcFtD
	q5ke+wsNdZcFqGVY9tpbAi2qVMnHsIlp0oRlGuZntemXEZ9NA9CXtyYPSZoXRypu
	6pCGtTNul/823r8velApSFtXBX/+oSQ8z68F8U8ivtohCBjonMdraG/u4QGx6MuM
	T9U1togjb9TPU0tABrPJKNNtQSxnIqK19yEwwYFJe3V4rZY08+5I2cSRPUCib8gt
	ArIkEN09qUZ7t7Z8S78PGkOQ0G69wxclTQFnWbBCRumQEa9fGhj1h2lzuBKMRKIU
	Pc6lohwKZY0zAfr41nTQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxwwv8ack-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:24:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UBOUbA015606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:24:30 GMT
Received: from hu-sachinku-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 03:24:26 -0800
From: Sachin Kumar Garg <quic_sachinku@quicinc.com>
To: <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 2/2] media: venus: add new rate control type MBR for encoder
Date: Tue, 30 Jan 2024 16:54:00 +0530
Message-ID: <20240130112400.2636143-3-quic_sachinku@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130112400.2636143-1-quic_sachinku@quicinc.com>
References: <20240130112400.2636143-1-quic_sachinku@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gorfjEJiDiRxGyYaIggDmceUlcq636uk
X-Proofpoint-ORIG-GUID: gorfjEJiDiRxGyYaIggDmceUlcq636uk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxlogscore=870 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300083

There is no limit on the maximum level of the bit rate with
the existing VBR rate control.
V4L2_MPEG_VIDEO_BITRATE_MODE_MBR rate control will limit the
frame maximum bit rate range to the +/- 10% of the configured
bit-rate value. Encoder will choose appropriate quantization
parameter and do the smart bit allocation to set the frame
maximum bitrate level.

Signed-off-by: Sachin Kumar Garg <quic_sachinku@quicinc.com>
---
Changes since v1:
- Addressed comment related to code replication
- Addressed comment for handling of MBR RC for non supported SOCs

 drivers/media/platform/qcom/venus/hfi_cmds.c   | 7 +++++++
 drivers/media/platform/qcom/venus/hfi_helper.h | 1 +
 drivers/media/platform/qcom/venus/venc.c       | 2 ++
 drivers/media/platform/qcom/venus/venc_ctrls.c | 5 +++--
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 3418d2dd9371..b6a9e8b54fe1 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -653,6 +653,13 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
 		case HFI_RATE_CONTROL_VBR_VFR:
 		case HFI_RATE_CONTROL_CQ:
 			break;
+		case HFI_RATE_CONTROL_MBR_CFR:
+			if (hfi_ver == HFI_VERSION_4XX) {
+				break;
+			} else {
+				ret = -ENOTSUPP;
+				break;
+			}
 		default:
 			ret = -EINVAL;
 			break;
diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
index e4c05d62cfc7..a0fd857f5c4b 100644
--- a/drivers/media/platform/qcom/venus/hfi_helper.h
+++ b/drivers/media/platform/qcom/venus/hfi_helper.h
@@ -232,6 +232,7 @@
 #define HFI_RATE_CONTROL_VBR_CFR		0x1000003
 #define HFI_RATE_CONTROL_CBR_VFR		0x1000004
 #define HFI_RATE_CONTROL_CBR_CFR		0x1000005
+#define HFI_RATE_CONTROL_MBR_CFR		0x1000006
 #define HFI_RATE_CONTROL_CQ			0x1000008
 
 #define HFI_VIDEO_CODEC_H264			0x00000002
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 3ec2fb8d9fab..8acbb05f6ce8 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -807,6 +807,8 @@ static int venc_set_properties(struct venus_inst *inst)
 						      HFI_RATE_CONTROL_CBR_CFR;
 	else if (ctr->bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_CQ)
 		rate_control = HFI_RATE_CONTROL_CQ;
+	else if (ctr->bitrate_mode == V4L2_MPEG_VIDEO_BITRATE_MODE_MBR)
+		rate_control = HFI_RATE_CONTROL_MBR_CFR;
 
 	ptype = HFI_PROPERTY_PARAM_VENC_RATE_CONTROL;
 	ret = hfi_session_set_property(inst, ptype, &rate_control);
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index d9d2a293f3ef..c9c3b1b45525 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -387,10 +387,11 @@ int venc_ctrl_init(struct venus_inst *inst)
 
 	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_BITRATE_MODE,
-		V4L2_MPEG_VIDEO_BITRATE_MODE_CBR,
+		V4L2_MPEG_VIDEO_BITRATE_MODE_MBR,
 		~((1 << V4L2_MPEG_VIDEO_BITRATE_MODE_VBR) |
 		  (1 << V4L2_MPEG_VIDEO_BITRATE_MODE_CBR) |
-		  (1 << V4L2_MPEG_VIDEO_BITRATE_MODE_CQ)),
+		  (1 << V4L2_MPEG_VIDEO_BITRATE_MODE_CQ)  |
+		  (1 << V4L2_MPEG_VIDEO_BITRATE_MODE_MBR)),
 		V4L2_MPEG_VIDEO_BITRATE_MODE_VBR);
 
 	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
-- 
2.34.1


