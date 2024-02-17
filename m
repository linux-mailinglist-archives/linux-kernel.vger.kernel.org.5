Return-Path: <linux-kernel+bounces-69561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B1C858B9A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4766628CBBB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0829A7B3EF;
	Sat, 17 Feb 2024 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QOshmOFh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882F28DA6;
	Sat, 17 Feb 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128665; cv=none; b=NopFdUjga8g/8aw6dKljeXckZ3LBrM6I8GPYJM0mlzQKENmar+GBEgEhxfAwxhnIS5DJgtXp7HzOfZeTsE/Lqxmxrqs1b4y6dfcVWMoFfFR93uS2MuSRisD4NSowtFoCZMDm1/fF9zLeAk+urNTrdn1x5i/hRo9x5LFHxQ49Efg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128665; c=relaxed/simple;
	bh=po8gdG/yPnG5R+mSe7hgcl69CxW6YNQ+1kAHPUh6tgE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0bVv/pZ4X+FSMX8Vq+QYrsKxnbpXAqrUbLSIuR45z0IkWHrWgAkK1uB7mWoXhe1C98OB5kb5DKk5pCuD5zP6MfNP6YujdxHBTFUT1Vd9bqeG0LakSIGaR7D5KM7+jYrFpgOFnFtErzWFaIYmCcP649GCd69A3Y5XWlK9IjLYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QOshmOFh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GNqj86030887;
	Sat, 17 Feb 2024 00:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=kRLA1poEYQe3YSdfgMDv
	BSt3LwXq7Py24egG1yDlHO0=; b=QOshmOFhwok0ki3KdzM3kjhxZHP7RVTjJEk1
	smXRdf/ePyDeWS2fzb4VXDctqQ+Z9zyfCY30twMSxS7O2YpaVTUTHRWdFvozx400
	ADEYVj20r134Z9u4yPzRufokhCiM5dWq7bKmECttmZOBf71snEkcc3D1Gtko/e78
	RvM08HqTgW7phVMbocJFv7bLQBouApAYCiB3wit07EbF6HlUMli5qyjYx5OjAxrW
	SBtP30HbanKuIfzaJt870s7ajyzom4hEQEjwIg2fts9WjK+sS64Km4RWP61f92xT
	4glKmcFrYKnyCpAkFnOUPWB6eqPWz4eyedVhqbCpYcfAXtsVGA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wa61nhek2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:10:32 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41H0AVBm011304
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:10:31 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 16:10:31 -0800
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
Subject: [PATCH v17 06/51] xhci: move event processing for one interrupter to a separate function
Date: Fri, 16 Feb 2024 16:09:32 -0800
Message-ID: <20240217001017.29969-7-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240217001017.29969-1-quic_wcheng@quicinc.com>
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _0S3GpP9_YDmyTuZ0tvXHiwQDgVbTFox
X-Proofpoint-ORIG-GUID: _0S3GpP9_YDmyTuZ0tvXHiwQDgVbTFox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402160189

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Split the main XHCI interrupt handler into a different API, so that other
potential interrupters can utilize similar event ring handling.  A scenario
would be if a secondary interrupter required to skip pending events in the
event ring, which would warrant a similar set of operations.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 87 +++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 62bde16f435e..ad008a5abc81 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3069,6 +3069,46 @@ static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci,
 	}
 }
 
+static int xhci_handle_events(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
+{
+	int event_loop = 0;
+	u64 temp;
+
+	xhci_clear_interrupt_pending(xhci, ir);
+
+	if (xhci->xhc_state & XHCI_STATE_DYING ||
+	    xhci->xhc_state & XHCI_STATE_HALTED) {
+		xhci_dbg(xhci, "xHCI dying, ignoring interrupt. Shouldn't IRQs be disabled?\n");
+
+		/* Clear the event handler busy flag (RW1C) */
+		temp = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
+		xhci_write_64(xhci, temp | ERST_EHB, &ir->ir_set->erst_dequeue);
+		return -ENODEV;
+	}
+
+	while (xhci_handle_event(xhci, ir) > 0) {
+		/*
+		 * If half a segment of events have been handled in one go then
+		 * update ERDP, and force isoc trbs to interrupt more often
+		 */
+		if (event_loop++ > TRBS_PER_SEGMENT / 2) {
+			xhci_update_erst_dequeue(xhci, ir, false);
+
+			if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
+				ir->isoc_bei_interval = ir->isoc_bei_interval / 2;
+
+			event_loop = 0;
+		}
+
+		/* Update SW event ring dequeue pointer */
+		inc_deq(xhci, ir->event_ring);
+	}
+
+	xhci_update_erst_dequeue(xhci, ir, true);
+
+	return 0;
+}
+
 /*
  * xHCI spec says we can get an interrupt, and if the HC has an error condition,
  * we might get bad data out of the event ring.  Section 4.10.2.7 has a list of
@@ -3077,11 +3117,8 @@ static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci,
 irqreturn_t xhci_irq(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	struct xhci_interrupter *ir;
 	irqreturn_t ret = IRQ_NONE;
-	u64 temp_64;
 	u32 status;
-	int event_loop = 0;
 
 	spin_lock(&xhci->lock);
 	/* Check if the xHC generated the interrupt, or the irq is shared */
@@ -3114,50 +3151,10 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 	 */
 	status |= STS_EINT;
 	writel(status, &xhci->op_regs->status);
-
-	/* This is the handler of the primary interrupter */
-	ir = xhci->interrupters[0];
-
-	xhci_clear_interrupt_pending(xhci, ir);
-
-	if (xhci->xhc_state & XHCI_STATE_DYING ||
-	    xhci->xhc_state & XHCI_STATE_HALTED) {
-		xhci_dbg(xhci, "xHCI dying, ignoring interrupt. "
-				"Shouldn't IRQs be disabled?\n");
-		/* Clear the event handler busy flag (RW1C);
-		 * the event ring should be empty.
-		 */
-		temp_64 = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
-		xhci_write_64(xhci, temp_64 | ERST_EHB,
-				&ir->ir_set->erst_dequeue);
-		ret = IRQ_HANDLED;
-		goto out;
-	}
-
-	/* FIXME this should be a delayed service routine
-	 * that clears the EHB.
-	 */
-	while (xhci_handle_event(xhci, ir) > 0) {
-		/*
-		 * If half a segment of events have been handled in one go then
-		 * update ERDP, and force isoc trbs to interrupt more often
-		 */
-		if (event_loop++ > TRBS_PER_SEGMENT / 2) {
-			xhci_update_erst_dequeue(xhci, ir, false);
-
-			if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
-				ir->isoc_bei_interval = ir->isoc_bei_interval / 2;
-
-			event_loop = 0;
-		}
-
-		/* Update SW event ring dequeue pointer */
-		inc_deq(xhci, ir->event_ring);
-	}
-
-	xhci_update_erst_dequeue(xhci, ir, true);
 	ret = IRQ_HANDLED;
 
+	/* This is the handler of the primary interrupter */
+	xhci_handle_events(xhci, xhci->interrupters[0]);
 out:
 	spin_unlock(&xhci->lock);
 

