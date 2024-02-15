Return-Path: <linux-kernel+bounces-66524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE9855DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937411F21782
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFF117555;
	Thu, 15 Feb 2024 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UdqcpEBX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84313ADC;
	Thu, 15 Feb 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989040; cv=none; b=AqcjF4INHQcI6TyZlzrVJ8rLLwZJ7a/x3vwv7d1AZJyKuag76MD6mm3LZRIQomQlSFd1PqufYNtmbv93tFXzq5ucIJjSomO6ui4vJp/kLEU6mo+TLvkLwQ9qPqA0C6pJIwHR2dOyzodyU0x3kE0YrOBx894xBoZ/5Cb4KcFGCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989040; c=relaxed/simple;
	bh=2hhvK9xbgfKF7Xgbpeug5EvyYsxUkXVRqps22ve/YP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=COpPa9HWUTcKqmeOrrft1sJ45SNCc+9xkG3zXJYxTq8krPFEvzcuP0BzNCbEW9+VDr6qo910n9wWwqWxIxnV1yXnlLahztmysXsPDwHYbMy6JlHz4dv7b/i70lAKoQ6TwD6AjaS6jDjcpjq8OHMuJLGSod8Cx7p4hFs5W3mxVfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UdqcpEBX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F5OF2q013013;
	Thu, 15 Feb 2024 09:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=ifi
	q1vPBEWQlt0VVJ4SsxcubAQPrEQWDquNnzLUfXOw=; b=UdqcpEBXOtWJXnO0ojO
	mA5NbJh3mFk+JtmWtdr8D4GThU8Nm15Yg8zuhnvPxRQYc0OtGtLlSFj2lp/g3egM
	L5gCaVt7oEZRHkaNBA8woKb/ZbDSnbAviCR8ygWJTJagwr3lvNwDOS8HmiVyN+OV
	KYWLqFQ72wVI8lspfzSr3yljpqVVPsog5XMdfd/iL1CskHMSvXo2T4ZeffwgZHKu
	gUYMHp2d81S3YvjnKftSpG/UCa5gn/W0i1sVEDW49pnLA/y0/Ijrlu+DOHIyLM3o
	rNwRXb6detBdvx6rmOn0+eOlqX6GCscRXhtNh3X4BFK/Pufp1XlWC8w5wnCAkG2n
	t6w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w96c3s1pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 09:23:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41F9Ntcd024697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 09:23:55 GMT
Received: from hu-mkshah-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 01:23:53 -0800
From: Maulik Shah <quic_mkshah@quicinc.com>
Date: Thu, 15 Feb 2024 14:53:50 +0530
Subject: [PATCH] soc: qcom: qcom_stats: Add DSPs and apss subsystem stats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240215-qcom_stats-v1-1-4a2cf83d0bdd@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACXYzWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0NT3cLk/Nz44pLEkmJdExOjFCPDFEszk2QLJaCGgqLUtMwKsGHRsbW
 1AChqr2pcAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Maulik
 Shah" <quic_mkshah@quicinc.com>
X-Mailer: b4 0.12.5-dev-2aabd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707989033; l=1014;
 i=quic_mkshah@quicinc.com; s=20240109; h=from:subject:message-id;
 bh=2hhvK9xbgfKF7Xgbpeug5EvyYsxUkXVRqps22ve/YP8=;
 b=hSfvQn8ceJJe7ssuYnoCwGwBTUQ0TyMG1aBm+7p2pv0UIcwv/gQhYFTmZrRlWHJUI0ePCVfZJ
 vYuBD8WFWTZCwFC5p/LzA9ovgyzBjdI7711JfeoVM3WE8tm8YgHMAcY
X-Developer-Key: i=quic_mkshah@quicinc.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z4r43cNQGIbtGx53jlFFFR99Yx-ussvI
X-Proofpoint-GUID: z4r43cNQGIbtGx53jlFFFR99Yx-ussvI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=953 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150073

Add SMEM items for compute, general purpose DSPs and application processor
subsystem stats.

Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
---
 drivers/soc/qcom/qcom_stats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 0216fc24f2ca..c429d5154aae 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -35,11 +35,15 @@ static const struct subsystem_data subsystems[] = {
 	{ "wpss", 605, 13 },
 	{ "adsp", 606, 2 },
 	{ "cdsp", 607, 5 },
+	{ "cdsp1", 607, 12 },
+	{ "gpdsp0", 607, 17 },
+	{ "gpdsp1", 607, 18 },
 	{ "slpi", 608, 3 },
 	{ "gpu", 609, 0 },
 	{ "display", 610, 0 },
 	{ "adsp_island", 613, 2 },
 	{ "slpi_island", 613, 3 },
+	{ "apss", 631, QCOM_SMEM_HOST_ANY },
 };
 
 struct stats_config {

---
base-commit: 943b9f0ab2cfbaea148dd6ac279957eb08b96904
change-id: 20240215-qcom_stats-442d21d964c8

Best regards,
-- 
Maulik Shah <quic_mkshah@quicinc.com>


