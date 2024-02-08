Return-Path: <linux-kernel+bounces-58829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B35084ED97
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68818B2CF8E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7C16027E;
	Thu,  8 Feb 2024 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RJkMzGjw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD6351C3F;
	Thu,  8 Feb 2024 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434084; cv=none; b=Ny9cNfdEg9oc9OzTvuqTDx9eEs1dZ2as7/Ou8VXVx7QZPpsbTr3RTDinQHo2YskONhMJEAXjoTfEuP15owYUu8adiClqQ4pkAa7+79UlEIew8KQV1RdUVrF0XRPh7q6NwSoO45FU87cJT7blmqVr/ji6d9eA9mZ9hnfCm/F3b04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434084; c=relaxed/simple;
	bh=noUq46uIIl4c54Ml8nUqG/zmcTMdZmp/uQzsEWtdfvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVilKygTAVuAwfjT26sFXRNC6mlJD4YITgA4YJfzI+9hlmcbUDlWyX35exj6aHPCqpOvxYBqkyf52s4cGD1zDUx+lWCREbZkQJ2jniV+Gh9fCpyZJZBdrMGHZq4b25ZpHf8BCJfo/AgqPK31EQdeKS6I2AjovUqTUcrICcxHQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RJkMzGjw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418MJO4H021321;
	Thu, 8 Feb 2024 23:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=YEmwQFMFTsyU12bZ+DA3
	QUirFGkywDIHtACo1YVzlzE=; b=RJkMzGjwFkBj/rqez8OKgz2SxZRALnqMcvow
	soxiggxZKe+RQjt13YexYCUTCwGysFMzI22VDi3wRpVnq+2G8GAMaHMHGX/13EOU
	EqGVXGIfKULg0huUaKuN0A+8K5VrE4EZdiLr8sRdRmCGc1BIr0t6FTCl3TpLHyV0
	8yTfDRsrQla+YWW7L96zggFSnuOS0EvlnsuZx3ONvohBcFXY8NUbsWqmD0eDG/jG
	N2XLiL7c38chzJvNWf3CJTFZdd4TZc5jGMa3ZuVGus4z2R0TshXv2IhlG0Azijbp
	1Mg/RxUo+hGeJYX+DD+2hvWlaWuT/GU9h+OILxggnHKnuFjmbA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4h0ukb1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NEJ9B012210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:19 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:18 -0800
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
Subject: [PATCH v14 11/53] xhci: Decouple handling an event from checking for unhandled events
Date: Thu, 8 Feb 2024 15:13:24 -0800
Message-ID: <20240208231406.27397-12-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Z9RkZonsmHQ_n7Xk2MMhib9GFMFc9VDx
X-Proofpoint-GUID: Z9RkZonsmHQ_n7Xk2MMhib9GFMFc9VDx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=744 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080131

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Some sequences, will require traversing through the entire event ring
without handling the event TRB.  This is ideal for when secondary
interrupters that are utilized by external entities need to clean up the
interrupter's event rings during halting of the XHCI HCD.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 293239d8fab0..6ef95f67970a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2912,25 +2912,18 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 }
 
 /*
- * This function handles all OS-owned events on the event ring.  It may drop
+ * This function handles one OS-owned event on the event ring. It may drop
  * xhci->lock between event processing (e.g. to pass up port status changes).
- * Returns >0 for "possibly more events to process" (caller should call again),
- * otherwise 0 if done.  In future, <0 returns should indicate error code.
  */
-static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
+static int xhci_handle_event_trb(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
+				 union xhci_trb *event)
 {
-	union xhci_trb *event;
 	u32 trb_type;
 
-	event = ir->event_ring->dequeue;
-
-	if (!unhandled_event_trb(ir->event_ring))
-		return 0;
-
 	trace_xhci_handle_event(ir->event_ring, &event->generic);
 
 	/*
-	 * Barrier between reading the TRB_CYCLE (valid) flag above and any
+	 * Barrier between reading the TRB_CYCLE (valid) flag before, and any
 	 * speculative reads of the event's flags/data below.
 	 */
 	rmb();
@@ -2960,15 +2953,11 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 	 * to make sure a watchdog timer didn't mark the host as non-responsive.
 	 */
 	if (xhci->xhc_state & XHCI_STATE_DYING) {
-		xhci_dbg(xhci, "xHCI host dying, returning from "
-				"event handler.\n");
-		return 0;
+		xhci_dbg(xhci, "xHCI host dying, returning from event handler.\n");
+		return -ENODEV;
 	}
 
-	/* Are there more items on the event ring?  Caller will call us again to
-	 * check.
-	 */
-	return 1;
+	return 0;
 }
 
 /*
@@ -3018,9 +3007,14 @@ static void xhci_clear_interrupt_pending(struct xhci_hcd *xhci,
 	}
 }
 
+/*
+ * Handle all OS-owned events on an interrupter event ring. It may drop
+ * and reaquire xhci->lock between event processing.
+ */
 static int xhci_handle_events(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 {
 	int event_loop = 0;
+	int err;
 	u64 temp;
 
 	xhci_clear_interrupt_pending(xhci, ir);
@@ -3041,7 +3035,10 @@ static int xhci_handle_events(struct xhci_hcd *xhci, struct xhci_interrupter *ir
 		return -ENODEV;
 	}
 
-	while (xhci_handle_event(xhci, ir) > 0) {
+	/* Process all OS owned event TRBs on this event ring */
+	while (unhandled_event_trb(ir->event_ring)) {
+		err = xhci_handle_event_trb(xhci, ir, ir->event_ring->dequeue);
+
 		/*
 		 * If half a segment of events have been handled in one go then
 		 * update ERDP, and force isoc trbs to interrupt more often
@@ -3057,6 +3054,9 @@ static int xhci_handle_events(struct xhci_hcd *xhci, struct xhci_interrupter *ir
 
 		/* Update SW event ring dequeue pointer */
 		inc_deq(xhci, ir->event_ring);
+
+		if (err)
+			break;
 	}
 
 	xhci_update_erst_dequeue(xhci, ir, true);

