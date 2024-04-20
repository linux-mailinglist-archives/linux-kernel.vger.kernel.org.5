Return-Path: <linux-kernel+bounces-152139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541958AB9BE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F3B1F21904
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A484316F;
	Sat, 20 Apr 2024 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nLuSpm4k"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB673F8D6;
	Sat, 20 Apr 2024 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713588622; cv=none; b=Xb9kxCSjx25lVgzYgfiv0kWeC0g1W6O29OJX4zhFJiO2V6qe0m0lJInvHCVWe0P5I6X6+UXn+JnERb/tLR3lQzsVi0G3UUFPvuN03Phi15A7eB1EBXANPbPq/Rozn7LPC1HCyo3AlefUhNAVpRSG7hUr1cJOoMDRbm40VTQ4jcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713588622; c=relaxed/simple;
	bh=YVkIw7DgewVq3TVr3KbyecW8Zew7ckYFRjU2pFfUQ5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqqPb4AVmudr3k8YSP6gBPbZdh/TwvXtIiBVsA7peIksQGHDEnOEj+TRFvHvhWREgXx7TOPXlbgWLBl1/xC2T9lDqv5l2levT7KauX7mWZEXsVZX+qLNInDxS7hBRr2oU0cYe0bQ/Ny+t2sqO9HsCFkjpTln0SxUvaeydz+sJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nLuSpm4k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43K4ncjJ004636;
	Sat, 20 Apr 2024 04:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=8eFsn6tci9SXWkk51b18J8sHwR83J9tUKFJVQ+MA0P0=; b=nL
	uSpm4k4Ti76TZ9jMht4/Sb+YMJM4/6KaSjm9P4DYhVYf7utzPe+tyy6OjWNr5RLi
	kHeGNCi2F7gCXBXM5AP6Mm2uzcCQoN7V8X4zsoc515rsCTt+lwmUdo4/i6nV/XPN
	Kvk3jMDBcA0kslKVK5Yxv91OVUUb2Otw+WZcVmmO/GO6NHmebl5n9FtAmYZnmnEu
	5ceTWyqlH8WuGs75SJU0O32rYYx+AzkwsNJEkMe6a3WrNd2/iqJWZ8O5EguSYTXk
	aTOd2r6lGL2eOk+Q9iUfqHjUcmWNRSiyy6OCii5EAPLg1OQl06NXbplJUwfpR6uj
	nAiweqNGYauuNEOdHkJQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6vr80bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 04:50:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43K4oFmH001910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 04:50:15 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 21:50:10 -0700
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
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: [PATCH v21 9/9] usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
Date: Sat, 20 Apr 2024 10:19:01 +0530
Message-ID: <20240420044901.884098-10-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420044901.884098-1-quic_kriskura@quicinc.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: donBu3u2KTyfVvakkFL0V6vnNhkSaxxF
X-Proofpoint-ORIG-GUID: donBu3u2KTyfVvakkFL0V6vnNhkSaxxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_03,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=909 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200032

Power event IRQ is used for wakeup either when the controller is
SuperSpeed capable but is missing an SuperSpeed PHY interrupt, or when
the GIC is not capable of detecting DP/DM High-Speed PHY interrupts.

The Power event IRQ stat register indicates whether the High-Speed
phy entered and exited L2 successfully during suspend and resume.
Indicate the same for all ports of a multiport controller.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index b6f13bb14e2c..88fb6706a18d 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -36,7 +36,6 @@
 #define PIPE3_PHYSTATUS_SW			BIT(3)
 #define PIPE_UTMI_CLK_DIS			BIT(8)
 
-#define PWR_EVNT_IRQ_STAT_REG			0x58
 #define PWR_EVNT_LPM_IN_L2_MASK			BIT(4)
 #define PWR_EVNT_LPM_OUT_L2_MASK		BIT(5)
 
@@ -55,6 +54,13 @@
 /* Qualcomm SoCs with multiport support has up to 4 ports */
 #define DWC3_QCOM_MAX_PORTS	4
 
+static const u32 pwr_evnt_irq_stat_reg[DWC3_QCOM_MAX_PORTS] = {
+	0x58,
+	0x1dc,
+	0x228,
+	0x238,
+};
+
 struct dwc3_qcom_port {
 	int			qusb2_phy_irq;
 	int			dp_hs_phy_irq;
@@ -424,9 +430,11 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
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
@@ -475,8 +483,11 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
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


