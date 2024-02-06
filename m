Return-Path: <linux-kernel+bounces-54349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0228F84AE06
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E47BB22305
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385038175C;
	Tue,  6 Feb 2024 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dtnReETh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A006381210;
	Tue,  6 Feb 2024 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196776; cv=none; b=DPxk+z0lR3nekFUS3wesAp3Sa0M1ndluzffqmFDl5korDhygluY3SbdlBd61BsvoFFP+jwDo8aKA0K0XUysCijidHXMkj7YgxnO8xo2UG7yHb88ongpvKerOsrKNNpDmRd4SS9jGQzdLcXDdZYPBEUaKd4d/PuJlmM9ej1n51wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196776; c=relaxed/simple;
	bh=2qjEzOYprnuMH6B5dsb4/WIDi79TYFvCmRqPSlx7HvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hLGA9ytcFvDy2bZv8hUSSMJ96g11C8z9HlI7sZPBCS9sY8cDxLzdL3q1l5IH6CQJab2K2IxrMsHRCghBt8s1bVVCc3jjhydfmRTQX34cByNCmwMj1X6AeoDHTJl4YX2z9DR95Ool3euuvLsxAhGWQHxE6SqjuiagyjfjbEFvyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dtnReETh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4162AqqA002080;
	Tue, 6 Feb 2024 05:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=o/P1KcsnY9SgxLKbc1UBuMHvYAuD79UZUIx9HmYzM1s=; b=dt
	nReEThFOLueUxV3OlCyjXWt7tTNO5Agj5wDS7QEnHAXPu5HE5wpjmLl6YopzeRrY
	as0wM0JtqiI0258jEug3ou7Vu/BG9yYI4he0oRRtpYznDJuflghz0dsRXelOjBTK
	PVpx1CUKJen7N+cUezAxAQrYOnrwF87obj4IURRlw2MAkavXlH8R6Np6NEDFDLLR
	Y1mSnLiHELFclTFzviXTV9XFBaAmqg6aP8Odt9QIfT1p66fvUx/mYOyOCCFjfq4S
	fgk7TcWucBZCnE1HU1NG1BHkEyHP6k8Hvh7uaZOEMRX1rkS06xlBnE1W56YTiBAK
	T9aFto6LuKHv24fvPHhg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w31wnsp23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 05:19:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4165JSDm010292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 05:19:28 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 5 Feb 2024 21:19:23 -0800
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
Subject: [PATCH v14 8/9] usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
Date: Tue, 6 Feb 2024 10:48:24 +0530
Message-ID: <20240206051825.1038685-9-quic_kriskura@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 0IBJM1i0d3_FMV1Eo87kczfBsInxoR2N
X-Proofpoint-GUID: 0IBJM1i0d3_FMV1Eo87kczfBsInxoR2N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=570 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060035

DWC3 Qcom wrapper currently supports only wakeup configuration
for single port controllers. Read speed of each port connected
to the controller and enable wakeup for each of them accordingly.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 72 ++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index a20d63a791bd..572dc3fdae12 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -78,6 +78,7 @@ struct dwc3_qcom_port {
 	int			dp_hs_phy_irq;
 	int			dm_hs_phy_irq;
 	int			ss_phy_irq;
+	enum usb_device_speed	usb2_speed;
 };
 
 struct dwc3_qcom {
@@ -336,7 +337,8 @@ static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
 	return dwc->xhci;
 }
 
-static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
+static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom,
+						       int port_index)
 {
 	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 	struct usb_device *udev;
@@ -347,14 +349,8 @@ static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct dwc3_qcom *qcom)
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
@@ -387,23 +383,29 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
+	int i;
+
 	dwc3_qcom_disable_wakeup_irq(qcom->qusb2_phy_irq);
 
-	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq);
-	} else {
-		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq);
-		dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq);
-	}
+	for (i = 0; i < qcom->num_ports; i++) {
+		if (qcom->port_info[i].usb2_speed == USB_SPEED_LOW) {
+			dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].dm_hs_phy_irq);
+		} else if ((qcom->port_info[i].usb2_speed == USB_SPEED_HIGH) ||
+				(qcom->port_info[i].usb2_speed == USB_SPEED_FULL)) {
+			dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].dp_hs_phy_irq);
+		} else {
+			dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].dp_hs_phy_irq);
+			dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].dm_hs_phy_irq);
+		}
 
-	dwc3_qcom_disable_wakeup_irq(qcom->port_info[0].ss_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->port_info[i].ss_phy_irq);
+	}
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
+	int i;
+
 	dwc3_qcom_enable_wakeup_irq(qcom->qusb2_phy_irq, 0);
 
 	/*
@@ -414,22 +416,24 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 	 * disconnect and remote wakeup. When no device is connected, configure both
 	 * DP and DM lines as rising edge to detect HS/HS/LS device connect scenario.
 	 */
+	for (i = 0; i < qcom->num_ports; i++) {
+		qcom->port_info[i].usb2_speed = dwc3_qcom_read_usb2_speed(qcom, i);
+		if (qcom->port_info[i].usb2_speed == USB_SPEED_LOW) {
+			dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].dm_hs_phy_irq,
+						    IRQ_TYPE_EDGE_FALLING);
+		} else if ((qcom->port_info[i].usb2_speed == USB_SPEED_HIGH) ||
+				(qcom->port_info[i].usb2_speed == USB_SPEED_FULL)) {
+			dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].dp_hs_phy_irq,
+						    IRQ_TYPE_EDGE_FALLING);
+		} else {
+			dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].dp_hs_phy_irq,
+						    IRQ_TYPE_EDGE_RISING);
+			dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].dm_hs_phy_irq,
+						    IRQ_TYPE_EDGE_RISING);
+		}
 
-	if (qcom->usb2_speed == USB_SPEED_LOW) {
-		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq,
-					    IRQ_TYPE_EDGE_FALLING);
-	} else if ((qcom->usb2_speed == USB_SPEED_HIGH) ||
-			(qcom->usb2_speed == USB_SPEED_FULL)) {
-		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq,
-					    IRQ_TYPE_EDGE_FALLING);
-	} else {
-		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dp_hs_phy_irq,
-					    IRQ_TYPE_EDGE_RISING);
-		dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].dm_hs_phy_irq,
-					    IRQ_TYPE_EDGE_RISING);
+		dwc3_qcom_enable_wakeup_irq(qcom->port_info[i].ss_phy_irq, 0);
 	}
-
-	dwc3_qcom_enable_wakeup_irq(qcom->port_info[0].ss_phy_irq, 0);
 }
 
 static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
@@ -455,10 +459,8 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 	 * The role is stable during suspend as role switching is done from a
 	 * freezable workqueue.
 	 */
-	if (dwc3_qcom_is_host(qcom) && wakeup) {
-		qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
+	if (dwc3_qcom_is_host(qcom) && wakeup)
 		dwc3_qcom_enable_interrupts(qcom);
-	}
 
 	qcom->is_suspended = true;
 
-- 
2.34.1


