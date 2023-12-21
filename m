Return-Path: <linux-kernel+bounces-8630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFCE81BA62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C05E1F238C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D759539F6;
	Thu, 21 Dec 2023 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kuGqfnHn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58E539F8;
	Thu, 21 Dec 2023 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLDw7fR026094;
	Thu, 21 Dec 2023 15:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=I/U
	x/t5vBHviDOr73BQf5hZoG+ErO3yOItGQwBSmyt8=; b=kuGqfnHnPatmZBdibfh
	t19WgGGHX9TTr+xxBpfmwmBrekpnOMLE1E2Aflc9zEjrscH1olUsdDFuhjtfN1EX
	rCtD9mlS15yOgto27A6hZILQTNdt61Q6WnMPGjTBIVDlLPJfczMZV+pDp59GmN61
	Wo/FYyX1ZkEJB4RaJnKzJ3bZ9bYm3vBJZPFH12iHhn+ZJInKBuhOLNSiqNq7gBf8
	PMoYTB+CnUIdRKKrtcToelR+FFWqvkQKaf1Mlhc8WQMWvkRNk1Nun+U/0iw4P4HJ
	yeZY83xEq08VVb7eCtJUMKu41vsu979VC+CCZkbgLHyqmdJ6SKwoD/KjPjF5Dt8W
	ZgA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4pq386np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 15:16:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLFG85m012246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 15:16:08 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 07:16:05 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 21 Dec 2023 07:16:04 -0800
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Make QMI message rules const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231221-qmi_elem_info-const-v1-1-81db0a9e6616@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALNWhGUC/22NQQrCMBBFryKzNtKJNjWuvIeUUsaJHbCJTWpRS
 u9uLLhz+R7892dIHIUTnDYzRJ4kSfAZcLsB6lp/YyXXzKALvUeNpRp6afjOfSPeBUXBp1EZqiq
 LlTtqLiEvH5GdvNbqpc7cSRpDfK8nE37tr2f+9iZUqJw9OGMLcq015+EpJJ52FHqol2X5AKSsF
 ue4AAAA
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y4lYcOS900awVgkkB0MX_DVKXLMKkamZ
X-Proofpoint-ORIG-GUID: y4lYcOS900awVgkkB0MX_DVKXLMKkamZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 mlxlogscore=892 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210115

Commit ff6d365898d4 ("soc: qcom: qmi: use const for struct
qmi_elem_info") allows QMI message encoding/decoding rules
to be const, so do that for qcom-ngd-ctrl.c.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 77aa6d26476c..efeba8275a66 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -220,7 +220,7 @@ struct slimbus_power_resp_msg_v01 {
 	struct qmi_response_type_v01 resp;
 };
 
-static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -262,7 +262,7 @@ static struct qmi_elem_info slimbus_select_inst_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,
@@ -284,7 +284,7 @@ static struct qmi_elem_info slimbus_select_inst_resp_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_UNSIGNED_4_BYTE,
 		.elem_len   = 1,
@@ -324,7 +324,7 @@ static struct qmi_elem_info slimbus_power_req_msg_v01_ei[] = {
 	},
 };
 
-static struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
+static const struct qmi_elem_info slimbus_power_resp_msg_v01_ei[] = {
 	{
 		.data_type  = QMI_STRUCT,
 		.elem_len   = 1,

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20231215-qmi_elem_info-const-6c77917f82e5


