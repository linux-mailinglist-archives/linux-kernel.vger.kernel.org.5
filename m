Return-Path: <linux-kernel+bounces-50873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E65847F96
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71FA1C2039E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7953756B74;
	Sat,  3 Feb 2024 02:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jaiohrep"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096274E1A0;
	Sat,  3 Feb 2024 02:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927888; cv=none; b=Ok06IXr6ShyvVLpM4ET6lSy9K1I4sWkD34vVe61Ec5KWJl6qAfeEsWTqOqYO6rOm0AxSdeWvXVnodE2QrZ1abB4miCSkoW3+x5Ke4Am+Rd6eXS8XGz5JT4bxfxAQgo/p221EriEQxfOQdk2vcJhZBJ1V4691x6+6upo/XgpSr4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927888; c=relaxed/simple;
	bh=+Lw1+4MAX2LtZpd2jn62R4vA+ALFex1PxyuYDKU/fN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDCa3ctjH0E3cnw7H/vfWjFlTeqbIp3Lo3aYRmOaEUwIfUVoaE64WtAwXWeMi6IRpKsBEKymXV82ZDUPwVL3sK3tP3Crkt5vxXr6U50qhgefP9H+xSOaGDJadvtbWG967bbsC7sqIOkU7K+Qrjf65yvT42uL1nkpVx3edWvEj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jaiohrep; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4132ZuF8017479;
	Sat, 3 Feb 2024 02:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=CAxjiLONN0FsfVJGEMs1
	T7t8zj114/9U4ixQ4PoMPaY=; b=jaiohrepamOKfO8BbE/a533XAI5VD0bRfJz4
	bX26gdW1mr+A67OiSbGBJCvFjJEvLhdX6jvAt3dbmtyo02Grt1gIFeQA+EAQ8cSg
	wYrNS8QB2MK8XRMs1YvdVJaLZmZVB/Ar3xOAUg7irbIrtwcbX3y8fpk0KH69S9Gq
	mKlyZ4A3n41NThWEAoP6SnZrDk337u14P6cCOfBXwibeCU2jtKmqu854dmkMuh11
	P4WvGMbM+dOEOFJBP0aYcS+pm+YBiU3JMgvZaixmU3OMqGzUydofot1sCnL+XlGw
	3T7txG1Ulo+PX+g+d86Wup0/rig2ymwKhwj+iDZ/zKBSyekuHw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1ctq0038-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 02:37:47 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4132bIS0024737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 02:37:18 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 18:37:17 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v13 03/53] xhci: Add interrupt pending autoclear flag to each interrupter
Date: Fri, 2 Feb 2024 18:35:55 -0800
Message-ID: <20240203023645.31105-4-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203023645.31105-1-quic_wcheng@quicinc.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: q7cebITxJ1ZVuiESB51Q9TXisl32Mn_g
X-Proofpoint-GUID: q7cebITxJ1ZVuiESB51Q9TXisl32Mn_g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=736 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402030015

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Each interrupter has an interrupt pending (IP) bit that should be cleared
in the interrupt handler. This is done automatically for systems using
MSI/MSI-X interrupts.

Secondary interrupters used by audio offload may not actually trigger
MSI/MSI-X messages, so driver may need to clear the IP bit manually for
these, even if the primary interrupter IP is cleared automatically.

Add an ip_autoclear flag to each interrupter that driver can configure
when requesting an interrupt for that xHC interrupter, and move
the interrupt pending clearing code to its own helper function.
Use this ip_autoclear flag instead of the current hcd->msi_enabled
to check if IP flag is cleared by software.

[Moved ip_autoclear into xhci and set based on msi_enabled -wcheng]

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 21 +++++++++++++++------
 drivers/usb/host/xhci.c      |  3 +++
 drivers/usb/host/xhci.h      |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 33806ae966f9..f8e78068c36f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3013,6 +3013,19 @@ static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 	xhci_write_64(xhci, temp_64, &ir->ir_set->erst_dequeue);
 }
 
+/* Clear the interrupt pending bit for a specific interrupter. */
+static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci,
+					 struct xhci_interrupter *ir)
+{
+	if (!ir->ip_autoclear) {
+		u32 irq_pending;
+
+		irq_pending = readl(&ir->ir_set->irq_pending);
+		irq_pending |= IMAN_IP;
+		writel(irq_pending, &ir->ir_set->irq_pending);
+	}
+}
+
 /*
  * xHCI spec says we can get an interrupt, and if the HC has an error condition,
  * we might get bad data out of the event ring.  Section 4.10.2.7 has a list of
@@ -3062,12 +3075,8 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 
 	/* This is the handler of the primary interrupter */
 	ir = xhci->interrupters[0];
-	if (!hcd->msi_enabled) {
-		u32 irq_pending;
-		irq_pending = readl(&ir->ir_set->irq_pending);
-		irq_pending |= IMAN_IP;
-		writel(irq_pending, &ir->ir_set->irq_pending);
-	}
+
+	xhci_clear_interrupt_pending(xhci, ir);
 
 	if (xhci->xhc_state & XHCI_STATE_DYING ||
 	    xhci->xhc_state & XHCI_STATE_HALTED) {
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index c057c42c36f4..0886829d53e5 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -538,6 +538,9 @@ int xhci_run(struct usb_hcd *hcd)
 	 */
 
 	hcd->uses_new_polling = 1;
+	if (hcd->msi_enabled)
+		ir->ip_autoclear = true;
+
 	if (!usb_hcd_is_primary_hcd(hcd))
 		return xhci_run_finished(xhci);
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index c6349e7e1e95..daee202cd369 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1431,6 +1431,7 @@ struct xhci_interrupter {
 	struct xhci_erst	erst;
 	struct xhci_intr_reg __iomem *ir_set;
 	unsigned int		intr_num;
+	bool			ip_autoclear;
 	/* For interrupter registers save and restore over suspend/resume */
 	u32	s3_irq_pending;
 	u32	s3_irq_control;

