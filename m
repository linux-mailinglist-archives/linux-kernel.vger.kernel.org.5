Return-Path: <linux-kernel+bounces-54348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E0484AE01
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561FF28451C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E481205;
	Tue,  6 Feb 2024 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BQChPMIQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7904811FB;
	Tue,  6 Feb 2024 05:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196771; cv=none; b=qgZRRKM5UC0sAHeKYMaB2TaQUH8I5Od/8zfHqQk8M4h5hWGZE8VzYh9nmIxflTmDcJKmnjppRM2Zyg2julEZ1xBxVTVCbf/OVYfyk6ppwxD/7IaryBHCeSm/dpT0tSD/peo9q4/NC0+z1hBH1wA70ydh67oAjjnEy1spsodQ1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196771; c=relaxed/simple;
	bh=K6vv5PUv7Hvs2Nb47hS9AI/MSIxACvXEuFq55bLagLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpAsLAkeEV9kiN4pgpcLM3kLNCqxLQiGJbaY3FFX6waTwUs/gpeldMKRLWisyRZcG3fYslMbEfBDSfiffzNCTMeUFvNQjG5ofxqml0EJS9iUBs1Crq9/x5+g3U7Zk3fjDd87H6B7gD2IlqAq9+hm05OcZgMXy8Do9Ui2STkyYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BQChPMIQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4164VVpZ025246;
	Tue, 6 Feb 2024 05:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=A5LORlwoq8/VmItymSyQS74CIvvcuo3DBsXKTBRhhTU=; b=BQ
	ChPMIQb/sL1mqVm6aupPh09grqXnpRy6+684GSkeFF/pmnZqwLAsh4R1dwHCOzbi
	pmtwihCT8MVTC3LXVZ0FPpcatQKKziFiZpLM0wyQPo6pLvs/mU7LqAGVSlaH3M+3
	aVnB98xMr6ywNYwHKQN0hph3hqppbaKPk6yN4u0Q2R35DCN8Zn9YwQ7GlRrNmKza
	93N/goSAERS0J1lnMwnD07rh3GHzY1BPTsFoSQ+OXDqVwt+qVCO1A3ASuVzt58Di
	GNrTJPTK7n0QY0wIppoU/MTnENJaEi4kwXHrC6/sz/kN8p2Y9NH1KcMqqInzEvV8
	h5rOl/ZgLASr0mTxoRMw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w31wnsp1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 05:19:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4165JMpv026417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 05:19:22 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 21:19:17 -0800
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
	<balbi@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH v14 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue driver
Date: Tue, 6 Feb 2024 10:48:23 +0530
Message-ID: <20240206051825.1038685-8-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-ORIG-GUID: mzYQx3B5EGQj9NX0pZIjfNz6wlnx-WS9
X-Proofpoint-GUID: mzYQx3B5EGQj9NX0pZIjfNz6wlnx-WS9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=794 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060035

On multiport supported controllers, each port has its own DP/DM
and SS (if super speed capable) interrupts. As per the bindings,
their interrupt names differ from standard ones having "_x" added
as suffix (x indicates port number). Refactor dwc3_qcom_setup_irq()
call to parse multiport interrupts along with non-multiport ones.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 222 +++++++++++++++++++++++++----------
 1 file changed, 161 insertions(+), 61 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 08df29584366..a20d63a791bd 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -53,17 +53,33 @@
 #define APPS_USB_AVG_BW 0
 #define APPS_USB_PEAK_BW MBps_to_icc(40)
 
+#define NUM_PHY_IRQ		4
+
+enum dwc3_qcom_phy_index {
+	DP_HS_PHY_IRQ_INDEX,
+	DM_HS_PHY_IRQ_INDEX,
+	SS_PHY_IRQ_INDEX,
+	QUSB2_PHY_IRQ_INDEX,
+};
+
 struct dwc3_acpi_pdata {
 	u32			qscratch_base_offset;
 	u32			qscratch_base_size;
 	u32			dwc3_core_base_size;
-	int			qusb2_phy_irq_index;
-	int			dp_hs_phy_irq_index;
-	int			dm_hs_phy_irq_index;
-	int			ss_phy_irq_index;
+	/*
+	 * The phy_irq_index corresponds to ACPI indexes of (in order)
+	 * DP/DM/SS/QUSB2 IRQ's respectively.
+	 */
+	int			phy_irq_index[NUM_PHY_IRQ];
 	bool			is_urs;
 };
 
+struct dwc3_qcom_port {
+	int			dp_hs_phy_irq;
+	int			dm_hs_phy_irq;
+	int			ss_phy_irq;
+};
+
 struct dwc3_qcom {
 	struct device		*dev;
 	void __iomem		*qscratch_base;
@@ -74,9 +90,7 @@ struct dwc3_qcom {
 	struct reset_control	*resets;
 
 	int			qusb2_phy_irq;
-	int			dp_hs_phy_irq;
-	int			dm_hs_phy_irq;
-	int			ss_phy_irq;
+	struct dwc3_qcom_port	port_info[DWC3_MAX_PORTS];
 	enum usb_device_speed	usb2_speed;
 
 	struct extcon_dev	*edev;
@@ -91,6 +105,7 @@ struct dwc3_qcom {
 	bool			pm_suspended;
 	struct icc_path		*icc_path_ddr;
 	struct icc_path		*icc_path_apps;
+	u8			num_ports;
 };
 
 static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
@@ -375,16 +390,16 @@ static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 	dwc3_qcom_disable_wakeup_irq(qcom->qusb2_phy_irq);
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq);
 	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
 			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq);
 	} else {
-		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
-		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq);
 	}
 
-	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].ss_phy_irq);
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
@@ -401,20 +416,20 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	 */
 
 	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
-						IRQ_TYPE_EDGE_FALLING);
+		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq,
+					    IRQ_TYPE_EDGE_FALLING);
 	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
 			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
-						IRQ_TYPE_EDGE_FALLING);
+		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq,
+					    IRQ_TYPE_EDGE_FALLING);
 	} else {
-		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq,
-						IRQ_TYPE_EDGE_RISING);
-		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq,
-						IRQ_TYPE_EDGE_RISING);
+		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq,
+					    IRQ_TYPE_EDGE_RISING);
+		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq,
+					    IRQ_TYPE_EDGE_RISING);
 	}
 
-	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].ss_phy_irq, 0);
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
@@ -535,6 +550,74 @@ static int dwc3_qcom_get_irq(struct platform_device *pdev,
 	return ret;
 }
 
+static int dwc3_qcom_get_irq_index(const char *irq_name)
+{
+	/*
+	 * Parse IRQ index based on prefixes from interrupt name.
+	 * Return -1 incase of an invalid interrupt name.
+	 */
+	int irq_index = -1;
+
+	if (strncmp(irq_name, "dp_hs_phy", strlen("dp_hs_phy")) == 0)
+		irq_index = DP_HS_PHY_IRQ_INDEX;
+	else if (strncmp(irq_name, "dm_hs_phy", strlen("dm_hs_phy")) == 0)
+		irq_index = DM_HS_PHY_IRQ_INDEX;
+	else if (strncmp(irq_name, "ss_phy", strlen("ss_phy")) == 0)
+		irq_index = SS_PHY_IRQ_INDEX;
+	else if (strncmp(irq_name, "qusb2_phy", strlen("qusb2_phy")) == 0)
+		irq_index = QUSB2_PHY_IRQ_INDEX;
+	return irq_index;
+}
+
+static int dwc3_qcom_get_port_index(const char *irq_name, int irq_index)
+{
+	int port_index = -1;
+
+	switch (irq_index) {
+	case DP_HS_PHY_IRQ_INDEX:
+		if (strcmp(irq_name, "dp_hs_phy_irq") == 0)
+			port_index = 1;
+		else
+			sscanf(irq_name, "dp_hs_phy_%d", &port_index);
+		break;
+	case DM_HS_PHY_IRQ_INDEX:
+		if (strcmp(irq_name, "dm_hs_phy_irq") == 0)
+			port_index = 1;
+		else
+			sscanf(irq_name, "dm_hs_phy_%d", &port_index);
+		break;
+	case SS_PHY_IRQ_INDEX:
+		if (strcmp(irq_name, "ss_phy_irq") == 0)
+			port_index = 1;
+		else
+			sscanf(irq_name, "ss_phy_%d", &port_index);
+		break;
+	case QUSB2_PHY_IRQ_INDEX:
+		port_index = 1;
+		break;
+	}
+
+	if (port_index <= 0 || port_index > DWC3_MAX_PORTS)
+		port_index = -1;
+
+	return port_index;
+}
+
+static int dwc3_qcom_get_acpi_index(struct dwc3_qcom *qcom, int irq_index,
+				    int port_index)
+{
+	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
+
+	/*
+	 * Currently multiport supported targets don't have an ACPI variant.
+	 * So return -1 if we are not dealing with first port of the controller.
+	 */
+	if (!pdata || port_index != 1)
+		return -1;
+
+	return pdata->phy_irq_index[irq_index];
+}
+
 static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
 				 const char *name)
 {
@@ -554,44 +637,67 @@ static int dwc3_qcom_request_irq(struct dwc3_qcom *qcom, int irq,
 static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 {
 	struct dwc3_qcom *qcom = platform_get_drvdata(pdev);
-	const struct dwc3_acpi_pdata *pdata = qcom->acpi_pdata;
+	struct device_node *np = pdev->dev.of_node;
+	const char **irq_names;
+	int port_index;
+	int acpi_index;
+	int irq_count;
+	int irq_index;
 	int irq;
 	int ret;
+	int i;
 
-	irq = dwc3_qcom_get_irq(pdev, "qusb2_phy",
-				pdata ? pdata->qusb2_phy_irq_index : -1);
-	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "hs_phy_irq");
-		if (ret)
-			return ret;
-		qcom->qusb2_phy_irq = irq;
-	}
+	irq_count = of_property_count_strings(np, "interrupt-names");
+	if (irq_count < 0)
+		return -EINVAL;
 
-	irq = dwc3_qcom_get_irq(pdev, "dp_hs_phy_irq",
-				pdata ? pdata->dp_hs_phy_irq_index : -1);
-	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "dp_hs_phy_irq");
-		if (ret)
-			return ret;
-		qcom->dp_hs_phy_irq = irq;
-	}
+	irq_names = devm_kcalloc(&pdev->dev, irq_count, sizeof(*irq_names), GFP_KERNEL);
+	if (!irq_names)
+		return -ENOMEM;
 
-	irq = dwc3_qcom_get_irq(pdev, "dm_hs_phy_irq",
-				pdata ? pdata->dm_hs_phy_irq_index : -1);
-	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "dm_hs_phy_irq");
-		if (ret)
-			return ret;
-		qcom->dm_hs_phy_irq = irq;
-	}
+	ret = of_property_read_string_array(np, "interrupt-names",
+					    irq_names, irq_count);
+	if (!ret)
+		return ret;
 
-	irq = dwc3_qcom_get_irq(pdev, "ss_phy_irq",
-				pdata ? pdata->ss_phy_irq_index : -1);
-	if (irq > 0) {
-		ret = dwc3_qcom_request_irq(qcom, irq, "ss_phy_irq");
-		if (ret)
-			return ret;
-		qcom->ss_phy_irq = irq;
+	for (i = 0; i < irq_count; i++) {
+		irq_index = dwc3_qcom_get_irq_index(irq_names[i]);
+		if (irq_index == -1) {
+			dev_err(&pdev->dev, "Unknown interrupt-name \"%s\" found\n", irq_names[i]);
+			continue;
+		}
+		port_index = dwc3_qcom_get_port_index(irq_names[i], irq_index);
+		if (port_index == -1) {
+			dev_err(&pdev->dev, "Invalid interrupt-name suffix \"%s\"\n", irq_names[i]);
+			continue;
+		}
+
+		acpi_index = dwc3_qcom_get_acpi_index(qcom, irq_index, port_index);
+
+		irq = dwc3_qcom_get_irq(pdev, irq_names[i], acpi_index);
+		if (irq > 0) {
+			ret = dwc3_qcom_request_irq(qcom, irq, irq_names[i]);
+			if (ret)
+				return ret;
+
+			switch (irq_index) {
+			case DP_HS_PHY_IRQ_INDEX:
+				qcom->port_info[port_index - 1].dp_hs_phy_irq = irq;
+				break;
+			case DM_HS_PHY_IRQ_INDEX:
+				qcom->port_info[port_index - 1].dm_hs_phy_irq = irq;
+				break;
+			case SS_PHY_IRQ_INDEX:
+				qcom->port_info[port_index - 1].ss_phy_irq = irq;
+				break;
+			case QUSB2_PHY_IRQ_INDEX:
+				qcom->qusb2_phy_irq = irq;
+				break;
+			}
+
+			if (qcom->num_ports < port_index)
+				qcom->num_ports = port_index;
+		}
 	}
 
 	return 0;
@@ -1053,20 +1159,14 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
-	.qusb2_phy_irq_index = 1,
-	.dp_hs_phy_irq_index = 4,
-	.dm_hs_phy_irq_index = 3,
-	.ss_phy_irq_index = 2
+	.phy_irq_index = {4, 3, 2, 1},
 };
 
 static const struct dwc3_acpi_pdata sdm845_acpi_urs_pdata = {
 	.qscratch_base_offset = SDM845_QSCRATCH_BASE_OFFSET,
 	.qscratch_base_size = SDM845_QSCRATCH_SIZE,
 	.dwc3_core_base_size = SDM845_DWC3_CORE_SIZE,
-	.qusb2_phy_irq_index = 1,
-	.dp_hs_phy_irq_index = 4,
-	.dm_hs_phy_irq_index = 3,
-	.ss_phy_irq_index = 2,
+	.phy_irq_index = {4, 3, 2, 1},
 	.is_urs = true,
 };
 
-- 
2.34.1


