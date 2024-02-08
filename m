Return-Path: <linux-kernel+bounces-58811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E384EC95
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FDB287531
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AE053809;
	Thu,  8 Feb 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GuVcHdS3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A450A7B;
	Thu,  8 Feb 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434079; cv=none; b=PuMW5EcESqFez6hFe5KmtwNG3qzedeqmnuDVC48pKhZQUh93fyPfvEUTlvOfhR1HRmomUn5AK9kZblN929CULctdxrCJePFlFkLUgK2biqY8GsVoyQFVa7/kSG0I5fn3yunSQtQA3eEMqRMJnbQmv0ZAZHzsjbqbqOrinV16NWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434079; c=relaxed/simple;
	bh=V8MdAsKTPp0AteG57V12qaeFcyZsxonTIhHZ2e6F4Bs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mibBs+0xJ1I15FT3rGbPxKVqO9t2cPJF5F5ruDA/56nXviuKbmF3Rt8NnH0VfuinQ73WfjjG8ZWe3O/88muFdHbfWLkR2caxIEcX9wXt2i/wfBV2zwP7f2mj9RxiAvJuk1n4f+ejWLX6Sn6YeQEj4Vtd2PEBeBvAbddOULszYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GuVcHdS3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418JMcO8009667;
	Thu, 8 Feb 2024 23:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=r/s48r7Nd+rNVTCx+HL8
	7L+3Njw26bFVh6+6XCcEXOU=; b=GuVcHdS3o0J9/shn+Sed88QrlPvV7YbG5T9R
	UGzXhLiAvO7JfNvOFqfzt6AS+jWCfNdhrU/5m/woFqBeUDedcqVVrtvBldUDN4Rd
	uBUF1p3cJiPFV3f/KFckHe2Ie2flRlc/uKqiM6uSMF2HzlYrIfPcz+cCduyYJEJE
	8Yo4YsbuhHF3LqH26KwLi7jFT7TR5h3XK+mKnrMRRCWQsU/Us6SZcy3ToPOIHe3z
	2EsW9nPLWSWbtZSBc36FU3rlHGuxW4unID+RsDrXvtAwFNgnGmnRmai3WPaVtzDz
	B3s3QRmwg81g3+xBLBZoIp0+MuBe69C7M/gieHDIax68edVtfQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4pavjs01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NEIGm012196
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:18 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:17 -0800
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
Subject: [PATCH v14 08/53] xhci: move event processing for one interrupter to a separate function
Date: Thu, 8 Feb 2024 15:13:21 -0800
Message-ID: <20240208231406.27397-9-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208231406.27397-1-quic_wcheng@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RHkQaFtGU7USGusNuyRqtum-p57dwdnM
X-Proofpoint-GUID: RHkQaFtGU7USGusNuyRqtum-p57dwdnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080131

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
index 0289d77839cf..338b6fddedc3 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3019,6 +3019,46 @@ static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci,
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
@@ -3027,11 +3067,8 @@ static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci,
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
@@ -3064,50 +3101,10 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
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
 

