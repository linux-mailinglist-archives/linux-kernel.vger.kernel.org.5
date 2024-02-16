Return-Path: <linux-kernel+bounces-67925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A13BA85731C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126C8B20951
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505351B27D;
	Fri, 16 Feb 2024 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PWeWRPzc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B51B279;
	Fri, 16 Feb 2024 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045163; cv=none; b=Cq4tl+O/bKlU3XU1vj3jcA/AtmOxY/ly+POCyqSARfgtXwbVQkoMQhOGsVEnTYd5qz+3HUPLMcTbaFIb7upi5ywRjyNWufn0oW+xfW03Cp3nsAduF5B5uz8urX6skqwKGByMw4UDq6I3OGjoBnfvVDYfGsJO26RKEyg7qWbQWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045163; c=relaxed/simple;
	bh=NRXjFzS0nnNmzSxTucdj3vJaSHT9ef4xaygHRxkLbpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoBVYctDE7IeQy6Hv3SK8ASAXfxurhNlFxysRqMtG8fQhkVAfmPb7BhdL+ilh3FYNfWI8wRUAEW1QVcECxz9cHzm5at8LqsOHAUFS0ZT6eVSHshPqn9n1ZjGcCU91rL0g94n5OuaPYaWCURYTf+HOkldb//3akZgcfo6AZ+TJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PWeWRPzc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G0O1kQ012315;
	Fri, 16 Feb 2024 00:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=6hLSC0P0VKt266qnWPbAPQ8wDNWTmchm4YXSaE8Dgw8=; b=PW
	eWRPzcG/r2VqnvFCv+u581/C631m+xLiMn9VDLIITO1+ClmTjdzBl5Z51JqZD+QK
	gpsrAm17pRQO6WxDfNgNa/ixwXfjevNsjBwmiOcilbi4xpsK4dz2ih+WsxiLWLWU
	Almz95E4cXWnJt3L4nSM9NA6uozg7p+1GUtuGSpzRRu4He9SX8d1aBNRHn7FB3st
	KAWzmmfMpCPHnrHtTsQryBUfjqarWgRZgsSxbTs9HBt/zH7NdcyNaZoMrXmy8V8h
	tdRk8lRwvdvUQ5cQfcLzeWD8eFYEoZD0McFw5gs+7rjaSmcQvfRkLR/5e8xxxqmG
	itt+YY0hJfkU3SPnRUng==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w96c3ua6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 00:59:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G0x3bI007403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 00:59:03 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 16:58:59 -0800
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
Subject: [PATCH v15 9/9] usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
Date: Fri, 16 Feb 2024 06:27:56 +0530
Message-ID: <20240216005756.762712-10-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216005756.762712-1-quic_kriskura@quicinc.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a_fH6bV6e2o_ljH11Qsj70g_Itf53KrR
X-Proofpoint-GUID: a_fH6bV6e2o_ljH11Qsj70g_Itf53KrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_24,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160006

Power event IRQ stat registers are present for each port
connected to controller. Add support for modifying all power event
irq stat registers present in wrapper.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 572dc3fdae12..e789745a9468 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -37,7 +37,11 @@
 #define PIPE3_PHYSTATUS_SW			BIT(3)
 #define PIPE_UTMI_CLK_DIS			BIT(8)
 
-#define PWR_EVNT_IRQ_STAT_REG			0x58
+#define PWR_EVNT_IRQ1_STAT_REG			0x58
+#define PWR_EVNT_IRQ2_STAT_REG			0x1dc
+#define PWR_EVNT_IRQ3_STAT_REG			0x228
+#define PWR_EVNT_IRQ4_STAT_REG			0x238
+
 #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
 #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
 
@@ -109,6 +113,13 @@ struct dwc3_qcom {
 	u8			num_ports;
 };
 
+static const u32 pwr_evnt_irq_stat_reg_offset[DWC3_MAX_PORTS] = {
+	PWR_EVNT_IRQ1_STAT_REG,
+	PWR_EVNT_IRQ2_STAT_REG,
+	PWR_EVNT_IRQ3_STAT_REG,
+	PWR_EVNT_IRQ4_STAT_REG,
+};
+
 static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
 {
 	u32 reg;
@@ -444,9 +455,11 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 	if (qcom->is_suspended)
 		return 0;
 
-	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
-	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
-		dev_err(qcom->dev, "HS-PHY not in L2\n");
+	for (i = 0; i < qcom->num_ports; i++) {
+		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg_offset[i]);
+		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
+			dev_err(qcom->dev, "Port-%d HS-PHY not in L2\n", i + 1);
+	}
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--)
 		clk_disable_unprepare(qcom->clks[i]);
@@ -491,9 +504,12 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 	if (ret)
 		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
 
-	/* Clear existing events from PHY related to L2 in/out */
-	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
-			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+	for (i = 0; i < qcom->num_ports; i++) {
+		/* Clear existing events from PHY related to L2 in/out */
+		dwc3_qcom_setbits(qcom->qscratch_base,
+				  pwr_evnt_irq_stat_reg_offset[i],
+				  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+	}
 
 	qcom->is_suspended = false;
 
-- 
2.34.1


