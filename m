Return-Path: <linux-kernel+bounces-118797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C21B88BF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508AE2E291F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE25676057;
	Tue, 26 Mar 2024 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AuZiXfl/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCB6FE39;
	Tue, 26 Mar 2024 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448974; cv=none; b=csblnhpG4EqhGx72YtgXWdC8yFJcFT6gNzdtgf1WLODpwALVc1ayXEqgdlLF+z9tR3JHWpSXr5KCSWVEFc9nTtcxd7oVpUgl/lC5fa0JNxJp9kn3BRnVSLsIh+jZbaa+WI+4whbf6vladJxHru94sCz2lpPxqwnTjbOrfODms9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448974; c=relaxed/simple;
	bh=g/gMyjsqQ22fLdCNTI45E80dldGLuj+eXV1369dM+ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dM2BAhmp6bGR6neS2uz2n3oelUDcu5QePoOuGi+vYJCtUz6ifpQtiWiStIoCP8gw/0ZnLE5mSCTWqHD1WiLc9IHgaN+ULLKH2IhM+vHeKj/mCJ8yijGc1GPQjDpjsALTWjVWbjzAIkBnA2QZ6dFwUqaRfgBz9YwIxpJlRW9Yn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AuZiXfl/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q3MaQ3001400;
	Tue, 26 Mar 2024 10:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=HwSBOG3nJJKloMjzDX7N5b91r/pE2tf29mjlH+amUiA=; b=Au
	ZiXfl/kpM6w3758/LWFYPRzQuXHPMRtE/JcazCYaKp7PWMrXYx/MAut2u5b9vj0X
	0g/bjnZyFTstm1ymNo7Ow2iRKxcXc2+JzHWzdIwIpeoZWFzhLj6ghRxPm8+Vwcgd
	1Ls3gj6QLZhT692j+IELo6jzoUh9SypR22mUk6XEyOD5OvQ0EBpwibJH6wneO3Un
	cvOwQGh56S3UhYKrXj06Tp5f135BgRkr1aELLykheVyhPdmdCNEqzkgv+R8WLhdV
	clc5LRfDO8j0PR5hRIPKOZNdcxlfIolnvh81WvrB6tWm82wcHCdBDmgKdnGQ8V9X
	m0KRn7V+peIUHXfygtIQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3j54hguk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:29:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QATB4X024419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:29:11 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 03:29:05 -0700
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
Subject: [PATCH v17 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue driver
Date: Tue, 26 Mar 2024 15:58:07 +0530
Message-ID: <20240326102809.2940123-8-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326102809.2940123-1-quic_kriskura@quicinc.com>
References: <20240326102809.2940123-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: 1aDD3bqMy3_xlwvz1nd480oSeXrT1mJA
X-Proofpoint-ORIG-GUID: 1aDD3bqMy3_xlwvz1nd480oSeXrT1mJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260072

On multiport supported controllers, each port has its own DP/DM
and SS (if super speed capable) interrupts. As per the bindings,
their interrupt names differ from standard ones having "_x" added
as suffix (x indicates port number). Identify from the interrupt
names whether the controller is a multiport controller or not.
Refactor dwc3_qcom_setup_irq() call to parse multiport interrupts
along with non-multiport ones accordingly..

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 137 ++++++++++++++++++++++++++---------
 1 file changed, 103 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index cae5dab8fcfc..38452104337c 100644
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
@@ -517,42 +521,107 @@ static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
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
+	char irq_name[14];
+	int port_index;
+	int irq;
+
+	irq = platform_get_irq_byname_optional(pdev, "dp_hs_phy_1");
+	if (irq <= 0)
+		return 1;
+
+	for (port_index = 2; port_index <= DWC3_MAX_PORTS; port_index++) {
+		sprintf(irq_name, "dp_hs_phy_%d", port_index);
+
+		irq = platform_get_irq_byname_optional(pdev, irq_name);
+		if (irq <= 0)
+			return port_index - 1;
+	}
+
+	return DWC3_MAX_PORTS;
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


