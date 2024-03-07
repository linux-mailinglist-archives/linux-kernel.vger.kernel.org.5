Return-Path: <linux-kernel+bounces-95011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E23187481C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26A81F26A66
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3A2335BC;
	Thu,  7 Mar 2024 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j6YpMIMK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDC2E41F;
	Thu,  7 Mar 2024 06:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792545; cv=none; b=lUM+B3qLvx0rwWW3qQh/+GBKEEdqNYwEq8YOd07tS2oNdPuhG16Z756X6TdD7j7ah9ftkXaQEtZq9DmuVcL0DA5UOrhvxKpzIzk2xCwpQ9mZJ0WffKMAA734XK1San5J5rvbsDXp1mbo3setIpRJf/tVAQdjNwC0ehyR5o320jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792545; c=relaxed/simple;
	bh=voaf8H5IJ1EtJ4O6BP/uxch6/PcHuK61TIeM4tUw9XY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5poRfLUe1ATNNuipC1CPKL7Npi2tO3cYtyJ5rk6j4XogLbBmRkCR0PFdLPI9qP+KQkr9TXg+s6MxnQV+lVUFFq19wGTwTqc+sZEjTYcSOgm8SOk8DlaNa293tWvmsb85FZqhJfCbQ3fIXeln+AGRe40apSW5fhojzqSC4h3KT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j6YpMIMK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4275Em9q027517;
	Thu, 7 Mar 2024 06:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=D4XhdDIc65Kwe56/ja9K7fcsweKO14Gf7K9MsQyKi30=; b=j6
	YpMIMKy6RTteeAqhLZ2thikh7gMNlbrJWRu0RZZMeaaF2pO1iN6RAtZbSIu/DnSS
	1BmGxf7Wx1b4xS9pjrmfq2VbO7uEH+yPr+lc8TWldx6DyGqQXwX1mRqeUE7Oookg
	EPc1piLOUp2Gwxr2cdi0/apT1DFqTaX0UcQIY3Hy0VxU6cH+NLzOrSfGPAIpO/3M
	Y7F7iS8RNt0GhtoqE4ZlTZut8UzajtNn4OO+TfyB8ixbOTBVaX0RzgXbwGOa6BeK
	URCqVnL61E0c+KBY0QtRNcyRt2Rbs21fQqND89MiARBPetSkfVMsp7ILYWYL/ToF
	C8ADAVv5cq01syD20AOA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq790r4fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 06:22:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4276LvqH014966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 06:21:57 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 22:21:52 -0800
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
Subject: [PATCH v16 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue driver
Date: Thu, 7 Mar 2024 11:50:50 +0530
Message-ID: <20240307062052.2319851-8-quic_kriskura@quicinc.com>
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
X-Proofpoint-ORIG-GUID: tRqTFJdjSaBzdcL9zzxOWrQ8lhFio5mx
X-Proofpoint-GUID: tRqTFJdjSaBzdcL9zzxOWrQ8lhFio5mx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070045

On multiport supported controllers, each port has its own DP/DM
and SS (if super speed capable) interrupts. As per the bindings,
their interrupt names differ from standard ones having "_x" added
as suffix (x indicates port number). Identify from the interrupt
names whether the controller is a multiport controller or not.
Refactor dwc3_qcom_setup_irq() call to parse multiport interrupts
along with non-multiport ones accordingly..

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 146 +++++++++++++++++++++++++++--------
 1 file changed, 112 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index cae5dab8fcfc..dcb3b3ded205 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -52,6 +52,13 @@
 #define APPS_USB_AVG_BW 0
 #define APPS_USB_PEAK_BW MBps_to_icc(40)
 
+struct dwc3_qcom_port {
+	int			qusb2_phy_irq;
+	int			dp_hs_phy_irq;
+	int			dm_hs_phy_irq;
+	int			ss_phy_irq;
+};
+
 struct dwc3_qcom {
 	struct device		*dev;
 	void __iomem		*qscratch_base;
@@ -59,11 +66,8 @@ struct dwc3_qcom {
 	struct clk		**clks;
 	int			num_clocks;
 	struct reset_control	*resets;
-
-	int			qusb2_phy_irq;
-	int			dp_hs_phy_irq;
-	int			dm_hs_phy_irq;
-	int			ss_phy_irq;
+	struct dwc3_qcom_port	ports[DWC3_MAX_PORTS];
+	u8			num_ports;
 	enum usb_device_speed	usb2_speed;
 
 	struct extcon_dev	*edev;
@@ -354,24 +358,24 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_disable_wakeup_irq(qcom->qusb2_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(qcom->ports[0].qusb2_phy_irq);
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq);
 	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
 			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq);
 	} else {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq);
 	}
 
-	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(qcom->ports[0].ss_phy_irq);
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_enable_wakeup_irq(qcom->qusb2_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(qcom->ports[0].qusb2_phy_irq, 0);
 
 	/*
 	 * Configure DP/DM line interrupts based on the USB2 device attached to
@@ -383,20 +387,20 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	 */
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
-						IRQ_TYPE_EDGE_FALLING);
+		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq,
+					    IRQ_TYPE_EDGE_FALLING);
 	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
 			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
-						IRQ_TYPE_EDGE_FALLING);
+		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq,
+					    IRQ_TYPE_EDGE_FALLING);
 	} else {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
-						IRQ_TYPE_EDGE_RISING);
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
-						IRQ_TYPE_EDGE_RISING);
+		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq,
+					    IRQ_TYPE_EDGE_RISING);
+		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq,
+					    IRQ_TYPE_EDGE_RISING);
 	}
 
-	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(qcom->ports[0].ss_phy_irq, 0);
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
@@ -517,42 +521,116 @@ static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
 	return ret;
 }
 
-static int dwc3_qcom_setup_irq(struct platform_device *pdev)
+static int dwc3_qcom_setup_port_irq(struct platform_device *pdev, int port_num, bool is_multiport)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	const char *irq_name;
 	int irq;
 	int ret;
 
-	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
+	if (is_multiport)
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_%d", port_num + 1);
+	else
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_irq");
+	if (!irq_name)
+		return -ENOMEM;
+
+	irq = platform_get_irq_byname_optional(pdev, irq_name);
 	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "qusb2_phy");
+		ret = dwc3_qcom_request_irq(qcom, irq, irq_name);
 		if (ret)
 			return ret;
-		qcom->qusb2_phy_irq = irq;
+		qcom->ports[port_num].dp_hs_phy_irq = irq;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
+	if (is_multiport)
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dm_hs_phy_%d", port_num + 1);
+	else
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dm_hs_phy_irq");
+	if (!irq_name)
+		return -ENOMEM;
+
+	irq = platform_get_irq_byname_optional(pdev, irq_name);
 	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "dp_hs_phy_irq");
+		ret = dwc3_qcom_request_irq(qcom, irq, irq_name);
 		if (ret)
 			return ret;
-		qcom->dp_hs_phy_irq = irq;
+		qcom->ports[port_num].dm_hs_phy_irq = irq;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "dm_hs_phy_irq");
+	if (is_multiport)
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ss_phy_%d", port_num + 1);
+	else
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ss_phy_irq");
+	if (!irq_name)
+		return -ENOMEM;
+
+	irq = platform_get_irq_byname_optional(pdev, irq_name);
 	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "dm_hs_phy_irq");
+		ret = dwc3_qcom_request_irq(qcom, irq, irq_name);
 		if (ret)
 			return ret;
-		qcom->dm_hs_phy_irq = irq;
+		qcom->ports[port_num].ss_phy_irq = irq;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "ss_phy_irq");
+	if (is_multiport)
+		return 0;
+
+	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
 	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "ss_phy_irq");
+		ret = dwc3_qcom_request_irq(qcom, irq, "qusb2_phy");
+		if (ret)
+			return ret;
+		qcom->ports[port_num].qusb2_phy_irq = irq;
+	}
+
+	return 0;
+}
+
+static int dwc3_qcom_find_num_ports(struct platform_device *pdev)
+{
+	const char *irq_name;
+	int port_index;
+	int irq;
+
+	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
+	if (irq > 0)
+		return 1;
+
+	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
+	if (irq > 0)
+		return 1;
+
+	for (port_index = 0; port_index < DWC3_MAX_PORTS; port_index++) {
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_%d", port_index + 1);
+		if (!irq_name)
+			return -ENOMEM;
+
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq <= 0)
+			return port_index;
+	}
+
+	return port_index;
+}
+
+static int dwc3_qcom_setup_irq(struct platform_device *pdev)
+{
+	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	bool is_multiport;
+	int ret;
+	int i;
+
+	qcom->num_ports = dwc3_qcom_find_num_ports(pdev);
+	if (qcom->num_ports < 0)
+		return -ENOMEM;
+
+	is_multiport = (qcom->num_ports > 1) ? true : false;
+
+	for (i = 0; i < qcom->num_ports; i++) {
+		ret = dwc3_qcom_setup_port_irq(pdev, i, is_multiport);
 		if (ret)
 			return ret;
-		qcom->ss_phy_irq = irq;
 	}
 
 	return 0;
-- 
2.34.1


