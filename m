Return-Path: <linux-kernel+bounces-95004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E45874802
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEEB287D92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 06:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAF1D54A;
	Thu,  7 Mar 2024 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IbiRlpQ1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB251D52C;
	Thu,  7 Mar 2024 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792491; cv=none; b=gw3ByTyIbK1XhmgIxXGek2FSW0kPfaWMGSEqR8k2B9YrTJreAdthNDBFO4+lNV1Wfvch/vl88Kd/xUeCgmhZHBQb6+Tp3lLEbPKWMjqEWwf1MjT1CNLMsUDTo/8pzqO1Vk0ferD8rAnhjlbD8BAcrZe+s1/0x6qu2UgKgYDvk8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792491; c=relaxed/simple;
	bh=NB0V9ZMbh0n8v6FdusmK6Klq3SaJdy3GbChrhe48r6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7TOpMP+4QredQRFUckcvH0upG4RUt15CCww4yFWLy1UPomYZuALB0f+2Zdgise21D4yytPT5huYD7ZS736+qnWSW5erx+TRGTbQjaUc3bu2cRcfNljIdRFvX+LAXMTwfD+Fch8T5ZLrd9CZ/78vOzW8K9l+x3ABXH8JZE8zyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IbiRlpQ1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42742VL0002795;
	Thu, 7 Mar 2024 06:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=pWeCKtT5I+tef83voKNCtpCxn1PreoTgBeMnqPKBdSs=; b=Ib
	iRlpQ11GsCStzAG2zUOuEZaaFMKxSRC0fvB0sN09JEUbXU4R9YDT8e7t3R44JspE
	VpvOApime0joWFuV4WPmK3Ai1MCGQcJv4g+1nwFVBRyJFG+KnB9RLofrWBWcS6ME
	zNHme7gHO4dkN1Qgo+8yT7ntsCfZFD7/O7CY9RaKTuH/fmcC+3UokVR7ToQ2YaHE
	ZcLVFj6mbMdqmHMCgi13bvZx8Coy4n6RE4IEbqxbMJ+8ATyZtD/RMgA5JM1WlPbC
	S1kD75N/c8nCPzCvJ5F7X47axPusP83DXLzfMpq9HFabTdfUItY6jcdQ7ddmyRj9
	6asAmuPW1ifN9ddHGl/A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wq2mfrkhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 06:21:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4276LNNL014300
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 06:21:23 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Mar 2024 22:21:17 -0800
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
Subject: [PATCH v16 2/9] usb: dwc3: core: Access XHCI address space temporarily to read port info
Date: Thu, 7 Mar 2024 11:50:45 +0530
Message-ID: <20240307062052.2319851-3-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: nJFBpYxYLF_VOPzGaDv2wLcqnMBhGFJr
X-Proofpoint-ORIG-GUID: nJFBpYxYLF_VOPzGaDv2wLcqnMBhGFJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403070044

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
---
 drivers/usb/dwc3/core.c | 61 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  5 ++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3b68e8e45b8b..02edafb4c2e3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -39,6 +39,7 @@
 #include "io.h"
 
 #include "debug.h"
+#include "../host/xhci-ext-caps.h"
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
@@ -1882,10 +1883,56 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_read_port_info(struct dwc3 *dwc)
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
+	if (IS_ERR(base))
+		return PTR_ERR(base);
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
@@ -1969,6 +2016,20 @@ static int dwc3_probe(struct platform_device *pdev)
 			goto err_disable_clks;
 	}
 
+	/*
+	 * Currently only DWC3 controllers that are host-only capable
+	 * can have more than one port.
+	 */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
+		ret = dwc3_read_port_info(dwc);
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
index df544ec730d2..4c52fef99838 100644
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


