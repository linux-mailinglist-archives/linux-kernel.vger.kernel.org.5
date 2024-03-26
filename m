Return-Path: <linux-kernel+bounces-118799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6088BF83
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88012E3449
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C2880021;
	Tue, 26 Mar 2024 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jct6hplu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3773533;
	Tue, 26 Mar 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448986; cv=none; b=oUfto7VmeI6JnPUnsXhf0pv4z31XcYp8IxpAqgvTNItWKYZTh+O7Mkp8+cupcqVMYGeIq8qTfiBN0bhP9QfQQ6kxo4egPEF5+1QjYSb3JJa1u7TAjGJzUbrMFmmQxxOKSzHcjjho4NxkAqeHGkoD8psYnCx+VmMvZFWpNa4nYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448986; c=relaxed/simple;
	bh=CzpPya17rTt1Zek9UJn68nt2er922OD0kuS2fjisXSc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=up2P31KK+wImepA1GwMtnPmjc2dmnYQFj3m0TwI+lwa/A6RNlMSMUyCn4oS1ezjcbtwU14YHNca/O23EjM1Ea1QJrxDi1sJDCD+ktkfUCypAGmYpgzA8ZdMxwoIzaPPMuqyHf8IyfW0V3Voj+wRZdKbJh7Adp+/k+I5t+uHt32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jct6hplu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q6Zcxr015198;
	Tue, 26 Mar 2024 10:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=O1jhtF+6LeV7nIcb4IBhtIsdKOL+6JFICh68FWa7Nc4=; b=Jc
	t6hpluGpH/0IyERK0hDzq2dEn4DLId35Nwtlk9acTzCLgJR3VcsgLDTLUMjp1VX9
	+YFgYqV6rWe7JA8smY5At7b5u3gpn3DYjDBWLARHlcVuCjtn5ACtqK9Jew1D1o64
	wu4Aywoxth30L6COSxXVlmkJr/dO8NVEeoELx3Mkb48y5kivw22dlsUBw231epPH
	tkm1KciYgq1OEMjb7DOOPEGxlni5zpbDN59qVkldxlkbUVyhVDpIMRSip0ZMCcJz
	CjuTiFW+PZduwFqZ8BRSxdinZDSGc995+7wiT5OTlkOLAU5Ne8GmqcpyXXiSdLOP
	MR3lO2y1bS8IrQ7UEzeg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3s7n0mkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:29:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QATNvH019504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 10:29:23 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 03:29:17 -0700
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
Subject: [PATCH v17 9/9] usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
Date: Tue, 26 Mar 2024 15:58:09 +0530
Message-ID: <20240326102809.2940123-10-quic_kriskura@quicinc.com>
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
X-Proofpoint-GUID: KqcLm5xMXE9mP6QZ7WPg-9XLeGkjHZad
X-Proofpoint-ORIG-GUID: KqcLm5xMXE9mP6QZ7WPg-9XLeGkjHZad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260071

Power event IRQ is used for wakeup in cases:
a) where the controller is super speed capable and missing an
ss_phy interrupt.
b) where the GIC is not capable of detecting DP/DM hs phy irq's.

Power event IRQ stat register indicates whether high speed phy
entered and exited L2 successfully during suspend and resume.
Indicate the same for all ports of multiport.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index f8d3c9ecf461..2d06f83a4f4b 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -52,6 +52,13 @@
 #define APPS_USB_AVG_BW 0
 #define APPS_USB_PEAK_BW MBps_to_icc(40)
 
+static const u32 pwr_evnt_irq_stat_reg[DWC3_MAX_PORTS] = {
+	0x58,
+	0x1dc,
+	0x228,
+	0x238,
+};
+
 struct dwc3_qcom_port {
 	int			qusb2_phy_irq;
 	int			dp_hs_phy_irq;
@@ -421,9 +428,11 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
 	if (qcom->is_suspended)
 		return 0;
 
-	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
-	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
-		dev_err(qcom->dev, "HS-PHY not in L2\n");
+	for (i = 0; i < qcom->num_ports; i++) {
+		val = readl(qcom->qscratch_base + pwr_evnt_irq_stat_reg[i]);
+		if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
+			dev_err(qcom->dev, "port-%d HS-PHY not in L2\n", i + 1);
+	}
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--)
 		clk_disable_unprepare(qcom->clks[i]);
@@ -472,8 +481,11 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, bool wakeup)
 		dev_warn(qcom->dev, "failed to enable interconnect: %d\n", ret);
 
 	/* Clear existing events from PHY related to L2 in/out */
-	dwc3_qcom_setbits(qcom->qscratch_base, PWR_EVNT_IRQ_STAT_REG,
-			  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+	for (i = 0; i < qcom->num_ports; i++) {
+		dwc3_qcom_setbits(qcom->qscratch_base,
+				  pwr_evnt_irq_stat_reg[i],
+				  PWR_EVNT_LPM_IN_L2_MASK | PWR_EVNT_LPM_OUT_L2_MASK);
+	}
 
 	qcom->is_suspended = false;
 
-- 
2.34.1


