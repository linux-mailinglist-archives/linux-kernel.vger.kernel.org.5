Return-Path: <linux-kernel+bounces-87889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CC786DA8A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1A21F23DFB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3877482E9;
	Fri,  1 Mar 2024 04:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SWQoA8yv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A55847F54;
	Fri,  1 Mar 2024 04:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709266178; cv=none; b=mk960xKWnNzSR5aSIBcbjs62XUxVeGTz+QdAFjTn+Q49EbQGEsh9fachZI0tt6f4isnlBYCw1QWv8TqehK+GNFi0THMDbqE9IpXScYh/ubtRrLM0UymmuxkpCQn3PTQhcv6GctBtXgXv36P49UlZek31iPpL0PBKqXs9k5hi3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709266178; c=relaxed/simple;
	bh=sNWAXgHYKNn8YPbGhQ36rxyCN8OCQlMk1eMAZ69y28U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tz0WG0KWOqCy96K67Gxwmcs77mnAoyp1wTEht8Sg0bqUGkOeXJDcNewO+gmmSb6PNNktWMLm64x1ee3jyKm7HSiJjQMzxh8Mnoz2NlHTDW/NdPoIO4agBR3eq5pREkISnJQwYKRDh5s20fEWpNdzBjNTmyDfkByBLZD0lBfJmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SWQoA8yv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42145vlK000988;
	Fri, 1 Mar 2024 04:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=uF5QC2T
	TNjSpqnVNU/KNC6VIdKhgi0qvbXfeSBNURwU=; b=SWQoA8yvr4hy/WXvu0vfESg
	JLP/lPRc9K2vI/m0D2BZkaXHp9Ovwjnv9XLEdeSI/CcQF224ZR9bnArHYjZJAP/z
	wZ4VOrNB3yGcSuflKBPWrp9IMNGgOTFJP9UCIV9LItfwuZGxaDQ0tPNj6p/xI4oz
	jJ2pfbt+MMvUoybebzXEa6gaFUqi9EddozyHTPRSPo0cIVU9BnLsF/lCHE3MlZVx
	sWZZxpQNcnt3gTUHTPWm4XoMrITeb/BpVxTqJR6l1Q4xibX4YkXb7SQagsgDarHT
	DZHHrwgcb05xLUHFnH4iGLPGjB40ANgvQg8eSjJZCCtvajOfHwdbVCW0Btc0l/w=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wjupp22qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Mar 2024 04:09:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42149ToU021776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Mar 2024 04:09:29 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 29 Feb 2024 20:09:23 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Johan Hovold
	<johan+linaro@kernel.org>, Rob Herring <robh@kernel.org>,
        Min-Hua Chen
	<minhuadotchen@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_subbaram@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] usb: typec: ucsi: Fix race between typec_switch and role_switch
Date: Fri, 1 Mar 2024 09:39:14 +0530
Message-ID: <20240301040914.458492-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-ORIG-GUID: m-9ZUAEmMu4UC56HHXhKjG3qoDiPrGu4
X-Proofpoint-GUID: m-9ZUAEmMu4UC56HHXhKjG3qoDiPrGu4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_01,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403010031

When orientation switch is enabled in ucsi glink, there is a xhci
probe failure seen when booting up in host mode in reverse
orientation.

During bootup the following things happen in multiple drivers:

a) DWC3 controller driver initializes the core in device mode when the
dr_mode is set to DRD. It relies on role_switch call to change role to
host.

b) QMP driver initializes the lanes to TYPEC_ORIENTATION_NORMAL as a
normal routine. It relies on the typec_switch_set call to get notified
of orientation changes.

c) UCSI core reads the UCSI_GET_CONNECTOR_STATUS via the glink and
provides initial role switch to dwc3 controller.

When booting up in host mode with orientation TYPEC_ORIENTATION_REVERSE,
then we see the following things happening in order:

a) UCSI gives initial role as host to dwc3 controller ucsi_register_port.
Upon receiving this notification, the dwc3 core needs to program GCTL from
PRTCAP_DEVICE to PRTCAP_HOST and as part of this change, it asserts GCTL
Core soft reset and waits for it to be  completed before shifting it to
host. Only after the reset is done will the dwc3_host_init be invoked and
xhci is probed. DWC3 controller expects that the usb phy's are stable
during this process i.e., the phy init is already done.

b) During the 100ms wait for GCTL core soft reset, the actual notification
from PPM is received by ucsi_glink via pmic glink for changing role to
host. The pmic_glink_ucsi_notify routine first sends the orientation
change to QMP and then sends role to dwc3 via ucsi framework. This is
happening exactly at the time GCTL core soft reset is being processed.

c) When QMP driver receives typec switch to TYPEC_ORIENTATION_REVERSE, it
then re-programs the phy at the instant GCTL core soft reset has been
asserted by dwc3 controller due to which the QMP PLL lock fails in
qmp_combo_usb_power_on.

d) After the 100ms of GCTL core soft reset is completed, the dwc3 core
goes for initializing the host mode and invokes xhci probe. But at this
point the QMP is non-responsive and as a result, the xhci plat probe fails
during xhci_reset.

Fix this by passing orientation switch to available ucsi instances if
their gpio configuration is available before ucsi_register is invoked so
that by the time, the pmic_glink_ucsi_notify provides typec_switch to QMP,
the lane is already configured and the call would be a NOP thus not racing
with role switch.

Cc: <stable@vger.kernel.org>
Fixes: c6165ed2f425 ("usb: ucsi: glink: use the connector orientation GPIO to provide switch events")
Suggested-by: Wesley Cheng <quic_wcheng@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 0bd3f6dee678..466df7b9f953 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -255,6 +255,20 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 static void pmic_glink_ucsi_register(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
+	int orientation;
+	int i;
+
+	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
+		if (!ucsi->port_orientation[i])
+			continue;
+		orientation = gpiod_get_value(ucsi->port_orientation[i]);
+
+		if (orientation >= 0) {
+			typec_switch_set(ucsi->port_switch[i],
+					 orientation ? TYPEC_ORIENTATION_REVERSE
+					     : TYPEC_ORIENTATION_NORMAL);
+		}
+	}
 
 	ucsi_register(ucsi->ucsi);
 }
-- 
2.34.1


