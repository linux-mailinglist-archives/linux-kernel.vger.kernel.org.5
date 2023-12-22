Return-Path: <linux-kernel+bounces-9407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F5B81C518
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB87B2248D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E84FBF6;
	Fri, 22 Dec 2023 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JS/5uxT7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE21D306;
	Fri, 22 Dec 2023 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM5jhkJ031026;
	Fri, 22 Dec 2023 06:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=BMcIK6+tF1WzlJAS4gMMrCiHhLdtiy0eQaT/jyXeihI=; b=JS
	/5uxT7uDrSRYJPWV0Z7XzPGoZNq+eNaSl1O1vKQcpvQAPb606QF+lkBMmBDt2PTz
	PmOBI32hu49IKDLpY5hkLua98muW6TB6YTP37SKGtaU1k9r9lFmcl9ebdv/oEO2A
	4bga5DNimovymP/FTwirSAzywTONRIDmYsG1+0bCNgAdhMR2YGvFHnWfNrAySyMJ
	aC+m7nbV9wAyi02PwAS4M4QcZr7P3N6uUKff8BMTwSlAGYP5ftrHBdhONpLRsZS7
	J6UR/07sUow7DM8muwkD40nJaq8LxrAe/fV9RyxpNewUZreCcxsxGyAMMo3c/gO0
	rzxagpminbRnzp2X9bCQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4pte23nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 06:27:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM6RkcN005155
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 06:27:46 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 22:27:41 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, "Andy
 Gross" <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Conor
 Dooley" <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH v4 2/2] usb: dwc3: qcom: Rename hs_phy_irq to qusb2_phy_irq
Date: Fri, 22 Dec 2023 11:57:20 +0530
Message-ID: <20231222062720.10128-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231222062720.10128-1-quic_kriskura@quicinc.com>
References: <20231222062720.10128-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: D5PEjfAHsncdCM5NtbY4wkRKQZI1tjz-
X-Proofpoint-ORIG-GUID: D5PEjfAHsncdCM5NtbY4wkRKQZI1tjz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=661 adultscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220043

For wakeup to work, driver needs to enable interrupts that depict what is
happening on the DP/DM lines. On QUSB targets, this is identified by
qusb2_phy whereas on SoCs using Femto PHY, separate {dp,dm}_hs_phy_irq's
are used instead.

The implementation incorrectly names qusb2_phy interrupts as "hs_phy_irq".
Clean this up so that driver would be using only qusb2/(dp & dm) for wakeup
purposes.

For devices running older kernels, this won't break any functionality
because the interrupt configurations in QUSB2 PHY based SoCs is done
by configuring QUSB2PHY_INTR_CTRL register in PHY address space and it was
never armed properly right from the start.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index fdf6d5d3c2ad..dbd6a5b2b289 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -57,7 +57,7 @@ struct dwc3_acpi_pdata {
 	u32			qscratch_base_offset;
 	u32			qscratch_base_size;
 	u32			dwc3_core_base_size;
-	int			hs_phy_irq_index;
+	int			qusb2_phy_irq_index;
 	int			dp_hs_phy_irq_index;
 	int			dm_hs_phy_irq_index;
 	int			ss_phy_irq_index;
@@ -73,7 +73,7 @@ struct dwc3_qcom {
 	int			num_clocks;
 	struct reset_control	*resets;
 
-	int			hs_phy_irq;
+	int			qusb2_phy_irq;
 	int			dp_hs_phy_irq;
 	int			dm_hs_phy_irq;
 	int			ss_phy_irq;
@@ -372,7 +372,7 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(qcom->qusb2_phy_irq);
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
 		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
@@ -389,7 +389,7 @@ static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(qcom->qusb2_phy_irq, 0);
 
 	/*
 	 * Configure DP/DM line interrupts based on the USB2 device attached to
@@ -542,19 +542,19 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 	int irq;
 	int ret;
 
-	irq = dwc3_qcom_get_irq(pdev, "hs_phy_irq",
-				pdata ? pdata->hs_phy_irq_index : -1);
+	irq = dwc3_qcom_get_irq(pdev, "qusb2_phy",
+				pdata ? pdata->qusb2_phy_irq_index : -1);
 	if (irq > 0) {
 		/* Keep wakeup interrupts disabled until suspend */
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
 					IRQF_ONESHOT | IRQF_NO_AUTOEN,
-					"qcom_dwc3 HS", qcom);
+					"qcom_dwc3 QUSB2", qcom);
 		if (ret) {
-			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
+			dev_err(qcom->dev, "qusb2_phy_irq failed: %d\n", ret);
 			return ret;
 		}
-		qcom->hs_phy_irq = irq;
+		qcom->qusb2_phy_irq = irq;
 	}
 
 	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
@@ -1058,7 +1058,7 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
-	.hs_phy_irq_index = 1,
+	.qusb2_phy_irq_index = 1,
 	.dp_hs_phy_irq_index = 4,
 	.dm_hs_phy_irq_index = 3,
 	.ss_phy_irq_index = 2
@@ -1068,7 +1068,7 @@ static const struct dwc3_acpi_pdata sdm845_acpi_urs_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
-	.hs_phy_irq_index = 1,
+	.qusb2_phy_irq_index = 1,
 	.dp_hs_phy_irq_index = 4,
 	.dm_hs_phy_irq_index = 3,
 	.ss_phy_irq_index = 2,
-- 
2.42.0


