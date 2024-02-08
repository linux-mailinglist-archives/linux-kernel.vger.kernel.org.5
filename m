Return-Path: <linux-kernel+bounces-58838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE884ED96
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC8EB26582
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666B604B8;
	Thu,  8 Feb 2024 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e24GPRU1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F00535A1;
	Thu,  8 Feb 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434090; cv=none; b=a+mfmy7H8C+yiz748NbgdLxAi9zXQP6bfS+PS5pqmpOfZ7+U8dmh2cyOL8RIfavt6/rxSPCU2iluy2dnfsV05hzBEybSwAlM5FwPfD7tmxaDPJQ6lq5vrTwfSJnja9k8RnZrTY6BLwo4AF0yA2Jl41jA61+jAuYICYRSH1Tdg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434090; c=relaxed/simple;
	bh=httnPJJML5QlmnUl6L9g9SMmpTEhPWJw3rWiUQwkot4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aax8PThlSzFUvNWz9sBajgdpm9gKrPtZKUZHMdnnUx+Fpkr7WI20yJvsLrzIp9A+iIJXFlt0SIHSKP6+y//90ITayJqRLUaebvK5SSeZOoO012qwj5/2IakUe9GR6PSHvobkAuV0jmoafhV7B+2szmDbxaMsBQ8XjkD+Xbic2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e24GPRU1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418MlA5J031470;
	Thu, 8 Feb 2024 23:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=v2ItLrNtk2j1QY1c2ABM
	7WgcR1ha0sOr3zVlmeNNouY=; b=e24GPRU1V4U6QFgGWVVKhW8vy3TgUPj0vLdR
	pelgFWziJfpruK8ipMubFs8eHrEgwFQTDUsM4gExPm/+mWBIKFdbxMBpmz0hThsa
	jH6X4v+0GkZAI4DpgI2fw25n3LyD6iVAnlca7O1owa2AjulBOkGUWC5ZQyRj+mNL
	k49iHOQ+t8Fb/V25LqxeJEuq2M0GEYz2Iy6sSvKRVhOgJFI+QwGJbWZx42JStH6r
	+C/OEZRmGox6MkmikYLERxqSiC0mwDj6Q0uDq5j9bIGJ5GnPm7inSPJNQEJNO8Aj
	VIgxe69+60s8Tpo7tJl6FaFUDQE5TuBIsBqOkZJE8/WHOk2bpA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4sns2aaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NEI3o012202
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:18 GMT
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
Subject: [PATCH v14 09/53] xhci: add helper that checks for unhandled events on a event ring
Date: Thu, 8 Feb 2024 15:13:22 -0800
Message-ID: <20240208231406.27397-10-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2LjOZDT6qoQD_SNop_3nA5mBVBIiiktS
X-Proofpoint-GUID: 2LjOZDT6qoQD_SNop_3nA5mBVBIiiktS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402080131

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Add unhandled_event_trb() that returns true in case xHC hardware has
written new event trbs to the event ring that driver has not yet handled.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 338b6fddedc3..48388bc16b24 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -113,6 +113,12 @@ static bool last_td_in_urb(struct xhci_td *td)
 	return urb_priv->num_tds_done == urb_priv->num_tds;
 }
 
+static bool unhandled_event_trb(struct xhci_ring *ring)
+{
+	return ((le32_to_cpu(ring->dequeue->event_cmd.flags) & TRB_CYCLE) ==
+		ring->cycle_state);
+}
+
 static void inc_td_cnt(struct urb *urb)
 {
 	struct urb_priv *urb_priv = urb->hcpriv;
@@ -2923,9 +2929,8 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 	}
 
 	event = ir->event_ring->dequeue;
-	/* Does the HC or OS own the TRB? */
-	if ((le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE) !=
-	    ir->event_ring->cycle_state)
+
+	if (!unhandled_event_trb(ir->event_ring))
 		return 0;
 
 	trace_xhci_handle_event(ir->event_ring, &event->generic);

