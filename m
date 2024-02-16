Return-Path: <linux-kernel+bounces-67924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D6857318
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E377281B59
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0218E27;
	Fri, 16 Feb 2024 00:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iVRERAVq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F371862E;
	Fri, 16 Feb 2024 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708045148; cv=none; b=jwqWLjLA3/9gR4HseF7Xes6gnuuztTYANhQLFVhTP9Pgf1jnkqrszBUSbsZFgXwMQ15v9tbBAZeJBIh1HqNBoGaXv0Y491WSmhQHlhLu8TBJ1zLI5sf7KmukjOTTEH9IIGYxY305rY5Gj/fySOJ5r6BJmtOVXDTzTsv8jfO627o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708045148; c=relaxed/simple;
	bh=EersvRHUmYpjTF9+PoRBQVr6Y2GnWf/kMUgerGRRF88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alc3RglAJSYA0oduV5T6XMv0+n4Nn9vpxN0yhZRMtABfdMoYtkxLQYtgZCDrGt6zeLCRCgTGW95Qv1L7kww21x3j58qJwHBeu5Qj/JtDvKMJu8OeJZh6CWQohbA/OGfhW5OO82Go1jrAVElTzX8Oq7/iWI5UT+tYK/jJg3Oi/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iVRERAVq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41F5pKv4010176;
	Fri, 16 Feb 2024 00:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=5Y65yFTtLxH780URhfn5iL59Nb9gQKn2bUkmLBA8uIc=; b=iV
	RERAVqsRWd0aBiethIO9EblQtgPq21EsSPsjMTblYvnPI1+m/gd11B3OZ+cwkJYd
	oRvb1Yf8mmyiAfCXWz5Hb51OSZhgO0k0taagoLt2d1E81db5dIm3ab+OyONENIZk
	X1xY0Wuezpukm9jBnZNSWQbB71RYOAc28fNxX0yREqg+hwlj3BgcTHv3UMecYWto
	BVtCo3gaPouBgUTH14XQ9Umv254FO96EWwUhVlkZv/LuLDMFwVLY9KUz4CQcSLXr
	nre/cuINGRTbTvllxrW4iA9hDiSaOCplHcEbp9zF6daP29+JGF5j+Fl1DNny/DUh
	AMwU25zhL8o9BYP9dmaw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9435umha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 00:58:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G0wwIu019901
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 00:58:58 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 16:58:54 -0800
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
Subject: [PATCH v15 8/9] usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
Date: Fri, 16 Feb 2024 06:27:55 +0530
Message-ID: <20240216005756.762712-9-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216005756.762712-1-quic_kriskura@quicinc.com>
References: <20240216005756.762712-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: bMBXSrxC0bsM1bjkToBLsNQNkvf6iwdv
X-Proofpoint-ORIG-GUID: bMBXSrxC0bsM1bjkToBLsNQNkvf6iwdv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_24,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=903
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160006

DWC3 Qcom wrapper currently supports only wakeup configuration
for single port controllers. Read speed of each port connected
to the controller and enable wakeup for each of them accordingly.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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


