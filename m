Return-Path: <linux-kernel+bounces-130907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02305897F89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFEF1F232DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D428495FD;
	Thu,  4 Apr 2024 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lWaV4Jje"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9043F5A10E;
	Thu,  4 Apr 2024 05:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207623; cv=none; b=gZHdQR8yEKC5ZAWFi9navAZhdFm0HElhskVg+Gl3BMapxzc6P6WnVj15bWhJNQyJAFrkiuz8z7zWWqOR3RIAFR5mmyTxzp7d5B4xCvOewMOvEnJQQKqJgIaabPIDGE+Vp4ygbJJzpKxTnhGBPs85/f+SiSvRFXQEmOb2kGQDc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207623; c=relaxed/simple;
	bh=ZSDvGlTYxkKevkDkn5Z97Ng0EKeJvDIdNRcWa558Hi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gB0q9c8Ir5iKIhI1ojsNNt3UqSbE0emOFhgK3PkGEpJ4m3gP9La65IyC+tDL9IrB4Y0npLj9oZRWhrs8Cj2deWAzu+MpNAa/mg84X9LTtAPblq4d2AO/g/0Jm+v8jMzHnIVFLrgzjJQaxWHAfSE5KHT+3XWkDBVSax8r5JIQJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lWaV4Jje; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4344w5V3018013;
	Thu, 4 Apr 2024 05:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=fKNyg1fb52c492bqSBVRoiI1D3/Zu8qRsrt5JaBCZNM=; b=lW
	aV4JjeiwrvJjm4ptFd162dTjy7EZQ4421e+P9HuKNk8rnKSm+gr2G4Ol79QaHN20
	3uKEdE4yQA2IqIf/MkEjAzAAevMWTep20TjqjD7glrTHaFfCJxRIuINYMVnUXB2M
	EyVTq52MY/UA82s8eHHZTTWAiTjLUb+Vc4xuIdYqZosHRG4g5E40gSmEX8a6Sc0J
	GZm4u7b7p13q201EtuzSJGMaxOnKwQRCRT+LVN3oV3ZdtMRGD/xTWrKfHyRPbegu
	B4TgTpr7LTHeHssYcDBqTvG2keivei8oJW5IquM8EJ8LizL0GHDsFm6bBvdlesuy
	HJl9IXhK8wpY239YMN2g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9en38mhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 05:13:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4345DZW4024475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 05:13:35 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 3 Apr 2024 22:13:29 -0700
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
Subject: [PATCH v19 8/9] usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
Date: Thu, 4 Apr 2024 10:42:28 +0530
Message-ID: <20240404051229.3082902-9-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
References: <20240404051229.3082902-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: uNipBs2rlLF-lc0G62UMtcYS3eKKjDNo
X-Proofpoint-ORIG-GUID: uNipBs2rlLF-lc0G62UMtcYS3eKKjDNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_01,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=965 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040033

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


