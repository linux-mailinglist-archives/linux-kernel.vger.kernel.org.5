Return-Path: <linux-kernel+bounces-21739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4F182939B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C24B24738
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E732C80;
	Wed, 10 Jan 2024 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c4V0veSQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5F8C1A;
	Wed, 10 Jan 2024 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A307fi013283;
	Wed, 10 Jan 2024 06:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=B5ouaHYiX5AW
	dbZ7NSH7SvAb5JmdaWdv865fJJ5wI9Y=; b=c4V0veSQI3N4KmTf17J1RxsG1cau
	vH9SUaqDvTs4W2CxxZZcMOWpTXFvpzUVGwr0y6VDmdmH7iASJ99TPw0I0KwLHtUd
	RNkVC49ZVJNvxJgLXAhwad2niVvn6Ig3F3YdTSfmQijbMJxKRXSr5Q2+mL5/n7+x
	Olc/T/8U/PCslPmYc7KZ0jLRKsvPJiSzjrwfvIsLMl+1hG7I/iJRLt0k0f22UQKX
	t2mNQU6idQLUsgXWMuM105ZqL2Zdik/PYzQWYv5LtYMhqQd1uSWKz6NZ/IQqbsxR
	5GivRhoU+umvA8Wgla3tp6ECLXhH24R42AOH3PwvXZd3YJYg0OXsnmddng==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9vfhghg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 06:12:41 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40A6CbAs006500;
	Wed, 10 Jan 2024 06:12:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3veyxku493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 10 Jan 2024 06:12:37 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40A6Cb5m006494;
	Wed, 10 Jan 2024 06:12:37 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 40A6Cb6e006493;
	Wed, 10 Jan 2024 06:12:37 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 32E1B2511; Wed, 10 Jan 2024 11:42:36 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2] media: venus: flush all buffers in output plane streamoff
Date: Wed, 10 Jan 2024 11:42:14 +0530
Message-Id: <1704867134-5522-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xkb_cSNPdyGiOr_mKzcLSTF42cKVBzKm
X-Proofpoint-ORIG-GUID: Xkb_cSNPdyGiOr_mKzcLSTF42cKVBzKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=862 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100049
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For scenarios, when source change is followed by VIDIOC_STREAMOFF
on output plane, driver should discard any queued OUTPUT
buffers, which are not decoded or dequeued.
Flush with HFI_FLUSH_INPUT does not have any actual impact.
So, fix it, by invoking HFI_FLUSH_ALL, which will flush all
queued buffers.

Fixes: 85872f861d4c ("media: venus: Mark last capture buffer")
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
Changes since v1:
- Added fixes tag (Bryan)

 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 29130a9..0d2ab95 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1255,7 +1255,7 @@ static int vdec_stop_output(struct venus_inst *inst)
 		break;
 	case VENUS_DEC_STATE_INIT:
 	case VENUS_DEC_STATE_CAPTURE_SETUP:
-		ret = hfi_session_flush(inst, HFI_FLUSH_INPUT, true);
+		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
 		break;
 	default:
 		break;
-- 
2.7.4


