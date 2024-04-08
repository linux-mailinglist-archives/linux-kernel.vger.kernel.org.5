Return-Path: <linux-kernel+bounces-135442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A60AF89C2C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583682834EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D8785654;
	Mon,  8 Apr 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XJkVODbw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8E77F13;
	Mon,  8 Apr 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583003; cv=none; b=rIVDsyzUx90jAbDa4V6mFFMJs0ncJGAkFQuJzoRhGrATAyFqkZsa/9fDx5xNFxtCFkAKSxzia2XJiNhhxa5rtywhBEY4T3/uaIf2KE2Xtd4b+J0xTUexb/lH9AzqIbjuLC9t2gTbCd+8U7MtFa7mYhIqblm2EznjfU/XOYuFSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583003; c=relaxed/simple;
	bh=DJni/6bUqO2bQMZgZbMWJPlxcfj2sl/sdPk1XdE4/Kg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+UESCDfnQbfneylwde67EIirCDoXjt1Kb7YWqVPre8ZvkJLVUr5FZqHxdtFym+vVdeAoxcSoi2kYCWC0Yp3j379Tyx5zTNf1wZnT3HMGxZmzHeJBy9pLPpIStVj4koddjET2jje7oKOTScwiu65nKB3ADm7eiA1ND8LKKWkcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XJkVODbw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 438BRUi1021797;
	Mon, 8 Apr 2024 13:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=3n+8ObZLWvKTuu3QE/Z3jjt7neNEkljIrCI1e1Y1hOU=; b=XJ
	kVODbwe27EtavTt3f5a1IQi3FBkTwcg6NxZKWbgAgmHA9/KocuM4qwhn/E3dcvIN
	ZcUKGrcKSF9Otb79yEBsPUmViuR0lILeAtFcudObVRB3u/u3imqj3u8i31BISyiP
	sEt11FEETzUoOin1cN5jF71XMhu0tW68Zs/jQSqoOPapoVf0QTM7TcgbaOlMRPjM
	LDA2JlvU0Dezu+vMFg/cOxXWedE1k5/x0VESsqgbNe1ui5iOFZN3cvCGahHk9fZN
	+tyF8AwqP5VLKeJesk/OR+4Xc3KvI3cL8L0/UevTLMFdDkjP6bGC/0DeBhSXotsM
	KoipRI8Y3draqbagr1Fw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg0gwjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 13:29:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 438DTtKP022427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 13:29:55 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 8 Apr 2024 06:29:50 -0700
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
Subject: [PATCH v20 2/9] usb: dwc3: core: Access XHCI address space temporarily to read port info
Date: Mon, 8 Apr 2024 18:59:18 +0530
Message-ID: <20240408132925.1880571-3-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
References: <20240408132925.1880571-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: BldgfiExZy-ux0RlyLOfzMZvKs-fs5om
X-Proofpoint-ORIG-GUID: BldgfiExZy-ux0RlyLOfzMZvKs-fs5om
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_11,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080104

All DWC3 Multi Port controllers that exist today only support host mode.
Temporarily map XHCI address space for host-only controllers and parse
XHCI Extended Capabilities registers to read number of usb2 ports and
usb3 ports present on multiport controller. Each USB Port is at least HS
capable.

The port info for usb2 and usb3 phy are identified as num_usb2_ports
and num_usb3_ports. The intention is as follows:

Wherever we need to perform phy operations like:

LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
{
	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
}

If number of usb2 ports is 3, loop can go from index 0-2 for
usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
if the first 2 ports are SS capable or some other ports like (2 and 3)
are SS capable. So instead, num_usb2_ports is used to loop around all
phy's (both hs and ss) for performing phy operations. If any
usb3_generic_phy turns out to be NULL, phy operation just bails out.
num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
phy's as we need to know how many SS capable ports are there for this.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/usb/dwc3/core.c | 61 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  5 ++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 31684cdaaae3..ddab30531f8a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -39,6 +39,7 @@
 #include "io.h"
 
 #include "debug.h"
+#include "../host/xhci-ext-caps.h"
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
@@ -1881,10 +1882,56 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_get_num_ports(struct dwc3 *dwc)
+{
+	void __iomem *base;
+	u8 major_revision;
+	u32 offset;
+	u32 val;
+
+	/*
+	 * Remap xHCI address space to access XHCI ext cap regs since it is
+	 * needed to get information on number of ports present.
+	 */
+	base = ioremap(dwc->xhci_resources[0].start,
+		       resource_size(&dwc->xhci_resources[0]));
+	if (!base)
+		return -ENOMEM;
+
+	offset = 0;
+	do {
+		offset = xhci_find_next_ext_cap(base, offset,
+						XHCI_EXT_CAPS_PROTOCOL);
+		if (!offset)
+			break;
+
+		val = readl(base + offset);
+		major_revision = XHCI_EXT_PORT_MAJOR(val);
+
+		val = readl(base + offset + 0x08);
+		if (major_revision == 0x03) {
+			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
+		} else if (major_revision <= 0x02) {
+			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
+		} else {
+			dev_warn(dwc->dev, "unrecognized port major revision %d\n",
+				 major_revision);
+		}
+	} while (1);
+
+	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
+		dwc->num_usb2_ports, dwc->num_usb3_ports);
+
+	iounmap(base);
+
+	return 0;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
 	struct resource		*res, dwc_res;
+	unsigned int		hw_mode;
 	void __iomem		*regs;
 	struct dwc3		*dwc;
 	int			ret;
@@ -1968,6 +2015,20 @@ static int dwc3_probe(struct platform_device *pdev)
 			goto err_disable_clks;
 	}
 
+	/*
+	 * Currently only DWC3 controllers that are host-only capable
+	 * can have more than one port.
+	 */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		ret = dwc3_get_num_ports(dwc);
+		if (ret)
+			goto err_disable_clks;
+	} else {
+		dwc->num_usb2_ports = 1;
+		dwc->num_usb3_ports = 1;
+	}
+
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 7e80dd3d466b..341e4c73cb2e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1039,6 +1039,8 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @num_usb2_ports: number of USB2 ports
+ * @num_usb3_ports: number of USB3 ports
  * @phys_ready: flag to indicate that PHYs are ready
  * @ulpi: pointer to ulpi interface
  * @ulpi_ready: flag to indicate that ULPI is initialized
@@ -1187,6 +1189,9 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	u8			num_usb2_ports;
+	u8			num_usb3_ports;
+
 	bool			phys_ready;
 
 	struct ulpi		*ulpi;
-- 
2.34.1


