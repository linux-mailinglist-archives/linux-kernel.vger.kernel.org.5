Return-Path: <linux-kernel+bounces-30021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 695958317C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB9B1C23B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09349250E1;
	Thu, 18 Jan 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XQaDf76p"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94724B3F;
	Thu, 18 Jan 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575612; cv=none; b=pb51eDLQO2g9rSU9Z3XVUgKA0YhAmcmtfJSAlOXdnXkV9vbfIq0PinZ9zoZnKZJvBFOSvldKIQJN0fcYwQxIavhMrQfbdQCpQfXOAvpwdsl44Tn0eaEzO+DcN0XYwcKzIAZBerkZgB+ti3khODucKJhL+atpJlpFJKQO/nmbzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575612; c=relaxed/simple;
	bh=njl+4s9ucBPJS+rYjNkxAFc6ufgNQfyh4wCkCXVtlhI=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=fR0UbJI/xGirVgJS/AmaTVjLl6d4sEfQ0tvFXsXSED8L+0geBtF1onLvcZuLIajC9yXOnA5k9IsdL17N1N1zfXDF/BsVLDV+ruRRXwDWhLv/8ExndEt0QU8xA6N27A3KdvqvhXCvhpW8P7CPD8oefr6Emgs9uadCemd2BOKSFw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XQaDf76p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40IApeHZ002321;
	Thu, 18 Jan 2024 11:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=k7e488f8T/22mILip1JNpJeR+7w+Dp6g5cKW05xibVg=; b=XQ
	aDf76pMKM/CMqT6eFxYUG+Yh/BL+ocwKLLiARxY6GEKmU0OviwjdKHKD+q3jnGq1
	72YXnfIPfXeTezNO8/48S2RIHesNkLt1Vf4jHmoYcrv2d0EHnPd3cw6oyzg37EQy
	PwMGOSeZR5BxYJlFhKBfOPr/pwwzcRV7t/1jklgp441Y+PLZb4BhGf5PjMXnjXWp
	GIYx+ho4W5cga82cgUNMjYbMtXAs+HESiv26RuGtO1b5dsk/4b9baiUTO2GOzOPE
	/+K5VX248dvRr9gTtrDUVVbIzDQFnRStPU9NS243KLmgX+Am0Ot1Et77RHaf1jgV
	MQZwWmhV+568LJOesZww==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpejp2sc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 11:00:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40IB04s2013741
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 11:00:04 GMT
Received: from hu-sachinku-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 03:00:00 -0800
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
Subject: [PATCH 2/2] media: venus: add new rate control type MBR for encoder
Date: Thu, 18 Jan 2024 16:29:34 +0530
Message-ID: <20240118105934.137919-3-quic_sachinku@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118105934.137919-1-quic_sachinku@quicinc.com>
References: <20240118105934.137919-1-quic_sachinku@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UUg9-N3-eji76B3whJpbNFchK4J_bpDi
X-Proofpoint-GUID: UUg9-N3-eji76B3whJpbNFchK4J_bpDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_06,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=890 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401180079

There is no limit on the maximum level of the bit rate with
the existing VBR rate control.
V4L2_MPEG_VIDEO_BITRATE_MODE_MBR rate control will limit the
frame maximum bit rate range to the +/- 10% of the configured
bit-rate value. Encoder will choose appropriate quantization
parameter and do the smart bit allocation to set the frame
maximum bitrate level.

Signed-off-by: Sachin Kumar Garg <quic_sachinku@quicinc.com>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c  | 38 +++++++++++++------
 .../media/platform/qcom/venus/hfi_helper.h    |  1 +
 drivers/media/platform/qcom/venus/venc.c      |  2 +
 .../media/platform/qcom/venus/venc_ctrls.c    |  5 ++-
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 3418d2dd9371..95fc27e0dc7d 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -645,17 +645,33 @@ static int pkt_session_set_property_1x(struct hfi_session_set_property_pkt *pkt,
 	case HFI_PROPERTY_PARAM_VENC_RATE_CONTROL: {
 		u32 *in = pdata;
 
-		switch (*in) {
-		case HFI_RATE_CONTROL_OFF:
-		case HFI_RATE_CONTROL_CBR_CFR:
-		case HFI_RATE_CONTROL_CBR_VFR:
-		case HFI_RATE_CONTROL_VBR_CFR:
-		case HFI_RATE_CONTROL_VBR_VFR:
-		case HFI_RATE_CONTROL_CQ:
-			break;
-		default:
-			ret = -EINVAL;
-			break;
+		if (hfi_ver == HFI_VERSION_4XX) {
+			switch (*in) {
+			case HFI_RATE_CONTROL_OFF:
+			case HFI_RATE_CONTROL_CBR_CFR:
+			case HFI_RATE_CONTROL_CBR_VFR:
+			case HFI_RATE_CONTROL_VBR_CFR:
+			case HFI_RATE_CONTROL_VBR_VFR:
+			case HFI_RATE_CONTROL_CQ:
+			case HFI_RATE_CONTROL_MBR_CFR:
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+		} else {
+			switch (*in) {
+			case HFI_RATE_CONTROL_OFF:
+			case HFI_RATE_CONTROL_CBR_CFR:
+			case HFI_RATE_CONTROL_CBR_VFR:
+			case HFI_RATE_CONTROL_VBR_CFR:
+			case HFI_RATE_CONTROL_VBR_VFR:
+			case HFI_RATE_CONTROL_CQ:
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
 		}
 
 		pkt->data[1] = *in;
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


