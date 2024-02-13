Return-Path: <linux-kernel+bounces-62792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A6385266B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D214B22925
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85DB5FBA0;
	Tue, 13 Feb 2024 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HPNqv1Gg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928E224F2;
	Tue, 13 Feb 2024 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785700; cv=none; b=P3+p3lYAGXv5bSXZDszvwo6ToL/5dz74LX68dAUczs0GAZ10EVvV6SeWbjcJ7lHAlrjuytq3Ji2rt+boE11xBc0+sX6pqWBSQsnWu55NkJTCu/fsu8eWDAWkNCdkwAYT0CYaaVoS9wJjeoBkw5FH1aczX2YHzY9i7lXPrFk9EzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785700; c=relaxed/simple;
	bh=kBRKQewBFwebBlSfn7sxo02gwubgl581TIfyTJo/ozk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TibbPba0WPR6FtqOoLgUALIwsGH2HXalmBmuNAmhs72jLvU12zO45TanagYoglHArYwFSfDKOL/nb+wgPhf0Mc8qoRw3+8mFjJOztrrl+oX8k87ZjhmIGJCmzdOeIT06VElRSNOFxGUpCZ7LqlLNVGZMAIihoI6ufwZT3KhglXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HPNqv1Gg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CMwliE025287;
	Tue, 13 Feb 2024 00:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=N1alWV4PWu2ZQmDggZ7z
	suZUodSQzl50W127f+/3e+0=; b=HPNqv1Gg716mlkkJTtcJ+Lv18FAV9rSkdvfJ
	3u7ehFw07Ho9053cHFrhrTOMJiaBsM6S96Ho8cAiWCNrZi27AqtbxZcih0ctRztw
	aMXRWnT/68nh6ALmOXPxZpgegkOQoenSh24u9nW3GeegY5lrNzCTmQ41kJijTrPD
	MeeGr03SJYbGX0qH6yyK6MgrmrHuRQCZZv6XbJos0h0TUFtT5P6VGXBgDe9zp4Mq
	t1bquPKRhuXs91gqzMVrUr9x5iJAdyR5bNSDgIyg5dYBmc6O5+OEPnW586u3hDFe
	lIQ+ADh9ZHHxvnUQuxXScW9B/ltngQzlpdfnNuxfa16OVVHdRA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7nk91505-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D0sY31031064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:34 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:54:33 -0800
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
Subject: [PATCH v15 04/50] xhci: remove unnecessary event_ring_deq parameter from xhci_handle_event()
Date: Mon, 12 Feb 2024 16:53:36 -0800
Message-ID: <20240213005422.3121-5-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240213005422.3121-1-quic_wcheng@quicinc.com>
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: OlCt0Szcx28euu3VdDh37AGo-G15EOcX
X-Proofpoint-ORIG-GUID: OlCt0Szcx28euu3VdDh37AGo-G15EOcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=994 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402130005

From: Mathias Nyman <mathias.nyman@linux.intel.com>

The event_ring_deq parameter is used to check if the event ring dequeue
position is updated while calling by xhci_handle_event(), meaning there was
an actual event on the ring to handle. In this case the driver needs to
inform hardware about the updated dequeue position.
Basically event_ring_deq just stores the old event ring dequeue position
before calling the event handler.

Keeping track of software event dequeue updates this way is no longer
useful as driver anyways reads the current hardware dequeue position
within the handle event, and checks if it needs to be updated.

The driver might anyway need to modify the EHB (event handler busy) bit in
the same register as the dequeue pointer even if the actual dequeue
position did not change.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 37 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1b619a290446..a9d2e876d62b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2982,30 +2982,26 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
  */
 static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
 				     struct xhci_interrupter *ir,
-				     union xhci_trb *event_ring_deq,
 				     bool clear_ehb)
 {
 	u64 temp_64;
 	dma_addr_t deq;
 
 	temp_64 = xhci_read_64(xhci, &ir->ir_set->erst_dequeue);
-	/* If necessary, update the HW's version of the event ring deq ptr. */
-	if (event_ring_deq != ir->event_ring->dequeue) {
-		deq = xhci_trb_virt_to_dma(ir->event_ring->deq_seg,
-				ir->event_ring->dequeue);
-		if (deq == 0)
-			xhci_warn(xhci, "WARN something wrong with SW event ring dequeue ptr\n");
-		/*
-		 * Per 4.9.4, Software writes to the ERDP register shall
-		 * always advance the Event Ring Dequeue Pointer value.
-		 */
-		if ((temp_64 & ERST_PTR_MASK) == (deq & ERST_PTR_MASK))
-			return;
+	deq = xhci_trb_virt_to_dma(ir->event_ring->deq_seg,
+				   ir->event_ring->dequeue);
+	if (deq == 0)
+		xhci_warn(xhci, "WARN something wrong with SW event ring dequeue ptr\n");
+	/*
+	 * Per 4.9.4, Software writes to the ERDP register shall always advance
+	 * the Event Ring Dequeue Pointer value.
+	 */
+	if ((temp_64 & ERST_PTR_MASK) == (deq & ERST_PTR_MASK) && !clear_ehb)
+		return;
 
-		/* Update HC event ring dequeue pointer */
-		temp_64 = ir->event_ring->deq_seg->num & ERST_DESI_MASK;
-		temp_64 |= deq & ERST_PTR_MASK;
-	}
+	/* Update HC event ring dequeue pointer */
+	temp_64 = ir->event_ring->deq_seg->num & ERST_DESI_MASK;
+	temp_64 |= deq & ERST_PTR_MASK;
 
 	/* Clear the event handler busy flag (RW1C) */
 	if (clear_ehb)
@@ -3034,7 +3030,6 @@ static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci,
 irqreturn_t xhci_irq(struct usb_hcd *hcd)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
-	union xhci_trb *event_ring_deq;
 	struct xhci_interrupter *ir;
 	irqreturn_t ret = IRQ_NONE;
 	u64 temp_64;
@@ -3092,15 +3087,13 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		goto out;
 	}
 
-	event_ring_deq = ir->event_ring->dequeue;
 	/* FIXME this should be a delayed service routine
 	 * that clears the EHB.
 	 */
 	while (xhci_handle_event(xhci, ir) > 0) {
 		if (event_loop++ < TRBS_PER_SEGMENT / 2)
 			continue;
-		xhci_update_erst_dequeue(xhci, ir, event_ring_deq, false);
-		event_ring_deq = ir->event_ring->dequeue;
+		xhci_update_erst_dequeue(xhci, ir, false);
 
 		/* ring is half-full, force isoc trbs to interrupt more often */
 		if (ir->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
@@ -3109,7 +3102,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 		event_loop = 0;
 	}
 
-	xhci_update_erst_dequeue(xhci, ir, event_ring_deq, true);
+	xhci_update_erst_dequeue(xhci, ir, true);
 	ret = IRQ_HANDLED;
 
 out:

