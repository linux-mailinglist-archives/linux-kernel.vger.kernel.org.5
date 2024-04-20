Return-Path: <linux-kernel+bounces-152137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42B8AB9B6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8541C208E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680683BB35;
	Sat, 20 Apr 2024 04:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oalOFfqL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078293A1A2;
	Sat, 20 Apr 2024 04:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713588610; cv=none; b=KqRhLcHvS4vBj4g0LX48ZVBCVs99Dj6PQyAtSYkH1M+C/RdSyZ2xL3BXVW14wyZ7K3aG1VBN6nRuavqaYKraVb+8y6y5xBmbjETqXbx7gfZgWZDjGim6DOA+3e+XOtFMKjg1ca43FOb0zTqFv1cP1yNLqFxhO/3Y2Q/sPeH0rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713588610; c=relaxed/simple;
	bh=y16fNdPA8tZ3X7MXIYUN3hOYGnMHQrQLFJ0gWZqA0gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cq8BjsvtL8JJ3iT3f1/5nYypGZqbQFPn6rhNgVqd7aytLdSgTjjEv6OK7gN6BJJ+Ty0cwIkijqeB0HO1FFrmGQm5J8FhwT/FC9SduSdOBsqRg/4h2cnq6qPYlORNExNTEGAG/NlqmkDZL0pc8uMgfy0Kej4ZNEBB9ZFY2a/tbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oalOFfqL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43K4jwbb029966;
	Sat, 20 Apr 2024 04:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Q+mq6ToUTs1O6F7pIHDNmizG7b2Ecb9/u/v4oUJz1W8=; b=oa
	lOFfqLAUuUZdhihjlsn1qi93UIvUi/GPIdOv6tZcBZqJhoAJrESnNNFGgzeEx26E
	YeX0iLE+NyV2POSqh/f0JAyaq4bCllclEFqqkXgt8Htu7JNjM1fYqb3ov+/+STA7
	JqupeLWAE8FBPSZM/f02NOOXkVa/2dtUUU6X508OEbQfAo//K57klTSwfXYODudS
	EMVcA+2qcEbB3loEt9uJlgdwjACmtbD3o+nQIUFcH+N8gGSknFCGHMn1sKDr7gtz
	rfQSqU3nTDIDuPTBIMAjiNUNDlJmLFPtCQ0qU4BT7XeQ6ulqqEDVqUXTHEFH6lot
	2kCi/EZlVaREXEppuHiA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm6fkg189-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 04:50:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43K4o2JK018280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 04:50:03 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 19 Apr 2024 21:49:57 -0700
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
Subject: [PATCH v21 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue driver
Date: Sat, 20 Apr 2024 10:18:59 +0530
Message-ID: <20240420044901.884098-8-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: NU9Y6i38j9DZMYZag3bB_dLSyMxWC_yn
X-Proofpoint-ORIG-GUID: NU9Y6i38j9DZMYZag3bB_dLSyMxWC_yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_03,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200033

On multiport supported controllers, each port has its own DP/DM and
SuperSpeed (if super speed capable) interrupts. As per the bindings,
their interrupt names differ from single-port ones by having a "_x"
added as suffix (x being the port number). Identify from the interrupt
names whether the controller is a multiport controller or not.
Refactor dwc3_qcom_setup_irq() call to parse multiportinterrupts along
with non-multiport ones accordingly.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 140 ++++++++++++++++++++++++++---------
 1 file changed, 106 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index cae5dab8fcfc..5ddb694dd8e7 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -52,6 +52,16 @@
 #define APPS_USB_AVG_BW 0
 #define APPS_USB_PEAK_BW MBps_to_icc(40)
 
+/* Qualcomm SoCs with multiport support has up to 4 ports */
+#define DWC3_QCOM_MAX_PORTS	4
+
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
@@ -59,11 +69,8 @@ struct dwc3_qcom {
 	struct clk		**clks;
 	int			num_clocks;
 	struct reset_control	*resets;
-
-	int			qusb2_phy_irq;
-	int			dp_hs_phy_irq;
-	int			dm_hs_phy_irq;
-	int			ss_phy_irq;
+	struct dwc3_qcom_port	ports[DWC3_QCOM_MAX_PORTS];
+	u8			num_ports;
 	enum usb_device_speed	usb2_speed;
 
 	struct extcon_dev	*edev;
@@ -354,24 +361,24 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 
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
@@ -383,20 +390,20 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
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
@@ -517,42 +524,107 @@ static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
 	return ret;
 }
 
-static int dwc3_qcom_setup_irq(struct platform_device *pdev)
+static int dwc3_qcom_setup_port_irq(struct platform_device *pdev, int port_index, bool is_multiport)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
+	const char *irq_name;
 	int irq;
 	int ret;
 
-	irq = platform_get_irq_byname_optional(pdev, "qusb2_phy");
+	if (is_multiport)
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dp_hs_phy_%d", port_index + 1);
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
+		qcom->ports[port_index].dp_hs_phy_irq = irq;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_irq");
+	if (is_multiport)
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "dm_hs_phy_%d", port_index + 1);
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
+		qcom->ports[port_index].dm_hs_phy_irq = irq;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "dm_hs_phy_irq");
+	if (is_multiport)
+		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ss_phy_%d", port_index + 1);
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
+		qcom->ports[port_index].ss_phy_irq = irq;
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
+		qcom->ports[port_index].qusb2_phy_irq = irq;
+	}
+
+	return 0;
+}
+
+static int dwc3_qcom_find_num_ports(struct platform_device *pdev)
+{
+	char irq_name[14];
+	int port_num;
+	int irq;
+
+	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_1");
+	if (irq <= 0)
+		return 1;
+
+	for (port_num = 2; port_num <= DWC3_QCOM_MAX_PORTS; port_num++) {
+		sprintf(irq_name, "dp_hs_phy_%d", port_num);
+
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq <= 0)
+			return port_num - 1;
+	}
+
+	return DWC3_QCOM_MAX_PORTS;
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
+	is_multiport = (qcom->num_ports > 1);
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


