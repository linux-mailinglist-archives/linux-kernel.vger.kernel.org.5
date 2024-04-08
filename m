Return-Path: <linux-kernel+bounces-135451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EB389C2FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59521B2982B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB58F130E45;
	Mon,  8 Apr 2024 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ti4YtRDl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7012FB0F;
	Mon,  8 Apr 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583048; cv=none; b=b1trBf2goJArpoyXB3SA4JLbixA1siwJ4zGLe1sSKn3Y1R8JaWz0fz7ZUut6LbRXpaMEV0BHRctBC5hUA8FKYxVaJFHtcUSQeToxWvHe2auG4deXQv3Vp+KOS285RpkIEpU46jH5ZsMWHrm9wesC8o0jBucE5tNWF4c7DO1ZyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583048; c=relaxed/simple;
	bh=NNdTGMeI3BKJSbRWKcY6O6EwK/hyTYU9C4WsrkgvkGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqoH6UGZGE+EVcKvW5JjR/NF+eRedo4l6gy0w/u6sY0KqApfAdiDmgogntDJC/jZK+moq5ItEImIy/tyticxXMV3pKzNSaVce1fhU6Cp0aI+l9qSZO0rsB1t06g+ZghlGVstjxiDSzoCWAWJRQ2r0RZlZEpGZBS3Cl+8c1cZiF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ti4YtRDl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4386cEKx022412;
	Mon, 8 Apr 2024 13:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=PTV5+DQ7ryKEZGv3mJS+ywNkymvYkqTD/TtVct3tAaE=; b=Ti
	4YtRDlkF8J+8EnNeeN26QBselNe81iSqnUXwOA7Wt9EzvJD39Vk1W762toY1zL+/
	diDanINEFyc6rxnfwIS4mWFR1mDpR9JQAoeXY5dJF/EWh0oI/6Vbq7QoG7i/ilz4
	uEG+MncMs1r/EToGCZhH4+/HmyJiehgphmhGdK4d451zwNwSRBumrqejZZgVwgn7
	H2aer37S0uHeQj1BH/ruADsfo1Xd6NHGhjTFfSI9COppQ2qvhzTCt0I9KgEBcx6m
	adWVfm3vBVf0+iMjjtWibrY+xEQXrRo37aBujzw+M7ZoPaorOoTcTFMEWSQFjt9P
	pF3QZbHAO2MneazT+uRg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg2rvnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 13:30:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438DUexl027062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 13:30:40 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 8 Apr 2024 06:30:34 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
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
	<quic_kriskura@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v20 9/9] usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
Date: Mon, 8 Apr 2024 18:59:25 +0530
Message-ID: <20240408132925.1880571-10-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CWw8j9w_-d6Ts9q8FHgy7NvY2rBs_wUn
X-Proofpoint-GUID: CWw8j9w_-d6Ts9q8FHgy7NvY2rBs_wUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_11,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080104

Power event IRQ is used for wakeup in cases:
a) where the controller is super speed capable and missing an
ss_phy interrupt.
b) where the GIC is not capable of detecting DP/DM hs phy irq's.

Power event IRQ stat register indicates whether high speed phy
entered and exited L2 successfully during suspend and resume.
Indicate the same for all ports of multiport.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 12182e0f8f45..d3e6d5d5e8bf 100644
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
@@ -472,8 +481,11 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
 
 	/* Clear existing events from PHY related to L2 in/out */
-	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
-			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+	for (i = 0; i < qcom->num_ports; i++) {
+		dwc3_qcom_setbits(qcom->qscratch_base,
+				  pwr_evnt_irq_stat_reg[i],
+				  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+	}
 
 	qcom->is_suspended = false;
 
-- 
2.34.1


