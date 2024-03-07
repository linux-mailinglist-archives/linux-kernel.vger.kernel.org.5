Return-Path: <linux-kernel+bounces-95012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88988874820
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D2C3B231FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED92E41F;
	Thu,  7 Mar 2024 06:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HsDo8UPh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80431F94C;
	Thu,  7 Mar 2024 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792559; cv=none; b=f8FiAyGxHMTh3ICgC2uN7JT46AHWbu7xy7+hw1LLUcmLAU9fliloJu+jJ+c+BEsFJxSCQL9SLV1c9vIFS5MDZT+vaaKbaE+EymXTo3jQL6BC5Io889gvvHKWyrGjDNCMBBggaFoGFx4vXlEtw7jf1Phhh5gQyrn6QpVUv/rZQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792559; c=relaxed/simple;
	bh=+0kpsGkeX6uxJ4O5RgdQaq/byz8xHlLjfEe5Mauzd2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOw1E0Ia2XtXxpwyG/gHywGtW1xPTKEgrMfVl2ozFJRX8ssf9/b3s5HEln7c62EWz6UvdLQcRQsnC4cjGwfgQvOEqLuWNk2TmAjzhXHwCT2/HcfpSPs7mpcqjNP3C8zQjUBbto04kFUv6YcSKvGV7UdLBqduqfWViw7oleSG1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HsDo8UPh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42769xuj024155;
	Thu, 7 Mar 2024 06:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=t/3cHQVkeZtrBKiYoFpyxH5VSjGkCQf9zp1xi+LeNNA=; b=Hs
	Do8UPhOWzGvt2bDUSiixe3e7B4Cj8orknbgZl3TWzeWRYmp4iYhDyJPlYcFwbdrn
	r8/h499C5vIOh5dJN6hpDTBZ01OXUHzOOtTo4u1xHuz/OIm3LV+h95jpERDqTi54
	bOJSktWAOLzsji7PZDW5Mp8LW/9ZVTZdhw3SS2qiPnnGdw2Cm1QCpu92FiPGTwSp
	t+EXO/WnbuvUgt7kHZ5f+d5OC0BuaXmrIefz7IB9VFQ1qI+Icdy6nKo4dcNDF+9p
	R++l2KmijSII5Gv0DQy11qeTGXCTH4YfXo6FQYNgmP4BiBBn7NAY//0u8yxjQAaF
	DF6ky9nRF6ErMKeBPf0A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq316gj3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 06:22:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4276M9l1031508
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 06:22:09 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 22:22:04 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi
	<balbi@kernel.org>, Johan Hovold <johan@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH v16 9/9] usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
Date: Thu, 7 Mar 2024 11:50:52 +0530
Message-ID: <20240307062052.2319851-10-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
References: <20240307062052.2319851-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bPmHffU9aaH-o4IJsfAqPemltRAg1xfy
X-Proofpoint-ORIG-GUID: bPmHffU9aaH-o4IJsfAqPemltRAg1xfy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=890 suspectscore=0 adultscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070045

Power event IRQ is used for wakeup in cases:
a) where the controller is super speed capable and missing an
ss_phy interrupt.
b) where the GIC is not capable of detecting DP/DM hs phy irq's.

Power event IRQ stat register indicates whether high speed phy
entered and exited L2 successfully during suspend and resume.
Indicate the same for all ports of multiport.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index c0a6de50ec09..365f01a6b581 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -52,6 +52,13 @@
 #define APPS_USB_AVG_BW 0
 #define APPS_USB_PEAK_BW MBps_to_icc(40)
 
+static const u32 pwr_evnt_irq_stat_reg[DWC3_MAX_PORTS] = {
+	0x58,
+	0x1dc,
+	0x228,
+	0x238,
+};
+
 struct dwc3_qcom_port {
 	int			qusb2_phy_irq;
 	int			dp_hs_phy_irq;
@@ -421,9 +428,11 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 	if (qcom->is_suspended)
 		return 0;
 
-	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
-	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
-		dev_err(qcom->dev, "HS-PHY not in L2\n");
+	for (i = 0; i < qcom->num_ports; i++) {
+		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg[i]);
+		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
+			dev_err(qcom->dev, "port-%d HS-PHY not in L2\n", i + 1);
+	}
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--)
 		clk_disable_unprepare(qcom->clks[i]);
@@ -471,9 +480,12 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 	if (ret)
 		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
 
+	for (i = 0; i < qcom->num_ports; i++) {
 	/* Clear existing events from PHY related to L2 in/out */
-	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
-			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+		dwc3_qcom_setbits(qcom->qscratch_base,
+				  pwr_evnt_irq_stat_reg[i],
+				  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+	}
 
 	qcom->is_suspended = false;
 
-- 
2.34.1


