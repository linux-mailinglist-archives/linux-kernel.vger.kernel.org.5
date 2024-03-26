Return-Path: <linux-kernel+bounces-118900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE588C0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2461F63EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8C381AAE;
	Tue, 26 Mar 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="emGF4dzP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACD71722;
	Tue, 26 Mar 2024 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452886; cv=none; b=cAoa9k53n8OqEwKdEsylpAvvIDNijrOwQqO17SZUfo9qkOFFWSR8cIz+dgE+oo8jQF2ou4R753yPNAzvl7MqzaMkxnB/4hyeTZCvYDKx5olCq0q7wywhcVqxj6WQEYmB/YT6tJVsoqubUmSISVqKR5oP6AhGvIhvLK1KlMkfWQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452886; c=relaxed/simple;
	bh=ZSDvGlTYxkKevkDkn5Z97Ng0EKeJvDIdNRcWa558Hi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSln2t6hpqznxnpOqnFejXXyAB57CG5jLz9ctwAOZw83sqUj5WrbNDubk4zvTMvgF+79+HEbjwlgXbkpmQRPTgJB2UwJjnqFswq4CB2INrZdV5aU1/tW3U3wXqG6qyfpN2pBFzdQz0YWfb1KfWgC8MRA8aeGSjXTdcCzO4gMUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=emGF4dzP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q7vpEl013241;
	Tue, 26 Mar 2024 11:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=fKNyg1fb52c492bqSBVRoiI1D3/Zu8qRsrt5JaBCZNM=; b=em
	GF4dzPk2Mbl/fAFjZ+mA8K1Eqz8t9yD2UNQ/aH2lNygDi/qE2b5WF9jMR3Dd8+lC
	yfjw++GzJMiGBBfN+2cu6cDAd8ZF2y0KJX5yOuQEHR8yRszcAIiVk1CNKooSAJbf
	bWPfhu6nf3FMoId9lILSEK9X7bpWjde5G5bzEYCBDLNQrGkpeeP0SwH7AUfr9XrV
	3rtAk3OM4iK2l0uP1CN9aIFVpTiuRospQB/Hx4hkWhLG6AZ1zlC0Ss58vvuXkbeP
	+aHRGr1T0ZrVfVwC1V51Dz9XVrkf6h8hbzqNB68t4JYzMELbt9lkXX4QB72GRpvR
	4MtQxq4A9LjS2DhqjpyQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3rghrxaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 11:34:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QBY0Cq021328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 11:34:00 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 04:33:55 -0700
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
Subject: [PATCH v18 8/9] usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
Date: Tue, 26 Mar 2024 17:02:52 +0530
Message-ID: <20240326113253.3010447-9-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
References: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: nN14PtXXXlpE1qD9GbCwYL5QfDr1CwgJ
X-Proofpoint-ORIG-GUID: nN14PtXXXlpE1qD9GbCwYL5QfDr1CwgJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 mlxlogscore=917
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260080

DWC3 Qcom wrapper currently supports only wakeup configuration
for single port controllers. Read speed of each port connected
to the controller and enable wakeup for each of them accordingly.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 71 +++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 35eb338514bc..12182e0f8f45 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -57,6 +57,7 @@ struct dwc3_qcom_port {
 	int			dp_hs_phy_irq;
 	int			dm_hs_phy_irq;
 	int			ss_phy_irq;
+	enum usb_device_speed	usb2_speed;
 };
 
 struct dwc3_qcom {
@@ -68,7 +69,6 @@ struct dwc3_qcom {
 	struct reset_control	*resets;
 	struct dwc3_qcom_port	ports[DWC3_MAX_PORTS];
 	u8			num_ports;
-	enum usb_device_speed	usb2_speed;
 
 	struct extcon_dev	*edev;
 	struct extcon_dev	*host_edev;
@@ -307,7 +307,7 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 	return dwc->xhci;
 }
 
-static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
+static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom, int port_index)
 {
 	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 	struct usb_device *udev;
@@ -318,14 +318,8 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
 	 */
 	hcd = platform_get_drvdata(dwc->xhci);
 
-	/*
-	 * It is possible to query the speed of all children of
-	 * USB2.0 root hub via usb_hub_for_each_child(). DWC3 code
-	 * currently supports only 1 port per controller. So
-	 * this is sufficient.
-	 */
 #ifdef CONFIG_USB
-	udev = usb_hub_find_child(hcd->self.root_hub, 1);
+	udev = usb_hub_find_child(hcd->self.root_hub, port_index + 1);
 #else
 	udev = NULL;
 #endif
@@ -356,26 +350,26 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 	disable_irq_nosync(irq);
 }
 
-static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
+static void dwc3_qcom_disable_port_interrupts(struct dwc3_qcom_port *port)
 {
-	dwc3_qcom_disable_wakeup_irq(qcom->ports[0].qusb2_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(port->qusb2_phy_irq);
 
-	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq);
+	if (port->usb2_speed == USB_SPEED_LOW) {
+		dwc3_qcom_disable_wakeup_irq(port->dm_hs_phy_irq);
+	} else if ((port->usb2_speed == USB_SPEED_HIGH) ||
+			(port->usb2_speed == USB_SPEED_FULL)) {
+		dwc3_qcom_disable_wakeup_irq(port->dp_hs_phy_irq);
 	} else {
-		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq);
-		dwc3_qcom_disable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(port->dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(port->dm_hs_phy_irq);
 	}
 
-	dwc3_qcom_disable_wakeup_irq(qcom->ports[0].ss_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(port->ss_phy_irq);
 }
 
-static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
+static void dwc3_qcom_enable_port_interrupts(struct dwc3_qcom_port *port)
 {
-	dwc3_qcom_enable_wakeup_irq(qcom->ports[0].qusb2_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(port->qusb2_phy_irq, 0);
 
 	/*
 	 * Configure DP/DM line interrupts based on the USB2 device attached to
@@ -386,21 +380,37 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	 * DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
 	 */
 
-	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq,
+	if (port->usb2_speed == USB_SPEED_LOW) {
+		dwc3_qcom_enable_wakeup_irq(port->dm_hs_phy_irq,
 					    IRQ_TYPE_EDGE_FALLING);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq,
+	} else if ((port->usb2_speed == USB_SPEED_HIGH) ||
+			(port->usb2_speed == USB_SPEED_FULL)) {
+		dwc3_qcom_enable_wakeup_irq(port->dp_hs_phy_irq,
 					    IRQ_TYPE_EDGE_FALLING);
 	} else {
-		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dp_hs_phy_irq,
+		dwc3_qcom_enable_wakeup_irq(port->dp_hs_phy_irq,
 					    IRQ_TYPE_EDGE_RISING);
-		dwc3_qcom_enable_wakeup_irq(qcom->ports[0].dm_hs_phy_irq,
+		dwc3_qcom_enable_wakeup_irq(port->dm_hs_phy_irq,
 					    IRQ_TYPE_EDGE_RISING);
 	}
 
-	dwc3_qcom_enable_wakeup_irq(qcom->ports[0].ss_phy_irq, 0);
+	dwc3_qcom_enable_wakeup_irq(port->ss_phy_irq, 0);
+}
+
+static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
+{
+	int i;
+
+	for (i = 0; i < qcom->num_ports; i++)
+		dwc3_qcom_disable_port_interrupts(&qcom->ports[i]);
+}
+
+static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
+{
+	int i;
+
+	for (i = 0; i < qcom->num_ports; i++)
+		dwc3_qcom_enable_port_interrupts(&qcom->ports[i]);
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
@@ -427,7 +437,8 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 	 * freezable workqueue.
 	 */
 	if (dwc3_qcom_is_host(qcom) && wakeup) {
-		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
+		for (i = 0; i < qcom->num_ports; i++)
+			qcom->ports[i].usb2_speed = dwc3_qcom_read_usb2_speed(qcom, i);
 		dwc3_qcom_enable_interrupts(qcom);
 	}
 
-- 
2.34.1


