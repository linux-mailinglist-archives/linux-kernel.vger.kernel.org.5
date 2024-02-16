Return-Path: <linux-kernel+bounces-68020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6B1857518
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A05E28467B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7BD446D2;
	Fri, 16 Feb 2024 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k09hN7aq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043A14A99;
	Fri, 16 Feb 2024 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056003; cv=none; b=qD/QB7PQTLK/m528AI88C9hZlD2jAil38TDuZieDkXr4wVpD2RgrS+FMpj7JgW7+V0TQJQJEVHsd4xIAm3jqb72P6leCUcjRA+NmRl++bz5ewBBFTuKwVXXbkNqBO+JWO672wBaigKj7cmzaaqM7xS5fbQdMkD4m415C0gtMXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056003; c=relaxed/simple;
	bh=rGBI8/1xyEocU+KperBTW20R1SZDCmNOw8fTHGOWAOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6JE2JT1Szp43LRAId1rl/2kaHi1wk/Lvq+tdnP3W4zMt2TfqftHcZqdYR5VTikbUD5jScXkAwkv/wRVUyKDvSCW1aUEnbFGbbWoOjKdhxNG78FCQpCC4v1DsknbnPHPkn77vCooy0mH+XwnjunwX2sngWF/XA48tAGDHRTFSTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k09hN7aq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G3qVgo013853;
	Fri, 16 Feb 2024 03:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=J6PqM7y/z1h8FCZqkEAQ
	KxaiOCjo8iRGi6WtYbn5R9E=; b=k09hN7aqd3jeqQciEIpXcuRWjb0tmQ+ubApe
	Ohria9N39d/BAZMEvWxZR0DN1bLO1fyFgrvCWkoVo5NhMUFYB+YTi9mGbrzcjpAV
	kIFOj7DMqp6Ji2hlVKRVVpYh3tqSyUjRD4jsemVsFbGY5gyzNoSnk/N3W5ZWjqui
	oSJYAl76PQm5xZKKqBwaByOU3ycv8Dq2KZmbzcv8eRSBXaWd1hn58iHZ1SxgQEiX
	KkPbzOGzkCTM7WboFQi/XLZ9JW/MY1cbaHk4C2j11wZ3ftLrWZspHWGdfnlsx4aj
	sDQ8fk2pyP9do2QH7Orhj/y6zAY7SD2AXB/weugPPePEygn1gA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9e4h2p19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3xZgD014647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:35 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:59:34 -0800
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
Subject: [PATCH v16 07/50] xhci: add helper that checks for unhandled events on a event ring
Date: Thu, 15 Feb 2024 19:58:40 -0800
Message-ID: <20240216035923.23392-8-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216035923.23392-1-quic_wcheng@quicinc.com>
References: <20240216035923.23392-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: oN3VWIRrsr5aN2obPndp3NIzUOQjTBCr
X-Proofpoint-ORIG-GUID: oN3VWIRrsr5aN2obPndp3NIzUOQjTBCr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_03,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160031

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Add unhandled_event_trb() that returns true in case xHC hardware has
written new event trbs to the event ring that driver has not yet handled.

Change-Id: I0d60c9155bad0a72bcb0c7f33f95013e3b1db709
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index ad008a5abc81..275164dc449d 100644
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
@@ -2973,9 +2979,8 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 	}
 
 	event = ir->event_ring->dequeue;
-	/* Does the HC or OS own the TRB? */
-	if ((le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE) !=
-	    ir->event_ring->cycle_state)
+
+	if (!unhandled_event_trb(ir->event_ring))
 		return 0;
 
 	trace_xhci_handle_event(ir->event_ring, &event->generic);

