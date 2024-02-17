Return-Path: <linux-kernel+bounces-69529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227DC858ABA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1EC1F22C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4182562A;
	Sat, 17 Feb 2024 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cbc32zVv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E646AF;
	Sat, 17 Feb 2024 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128653; cv=none; b=O4TdSOKFBmpe+nzctnRITj81vbtXGHRzbT1nIiiW6sFb9BDfGQH+NgU237uezKqQG46pJ/5r7H+V6M/Bal5M7RrlMm/+GtZGpBFNDoqBnWyWblNW3Ipp1cEIXbzaZiwP239rlvRZ7IgvaKFxv/GGD7h5pgw3RMCYbyOnVJHd0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128653; c=relaxed/simple;
	bh=T0Bz4tOu/rdAXCR6ELsKlQZZcwkBguPM55G+9SlfyZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XoTncDwCSDOsac50zpw/QkbGc7TXAiAADzt/SArxYhLkqMJGV8vucSNhM5oUgbmraH1+8Foyw/6+oicuJjr0VsqZmwcZm7RQdEh4yMLw09aXCXcYq5x4AhSevnXJDDU/zgWlufxdXkWZCPvQfRDmY5CzLrPErV/qWA9c4D592Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cbc32zVv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GNdvHg003939;
	Sat, 17 Feb 2024 00:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=N/sdaIjFxyUNa9Ia2otk
	7BCcqD1+y5SdVh+JS6yQIKc=; b=cbc32zVvnmMWG14Jn2pcKmmWx4y63KuneoOK
	e2+csISbZXtWs9PQZPt4/dM0rxlod4yM92diMvnWJ1rMymQg94ii14VMQPOhx7Oa
	pwKmXq5zrPFoI7D1UtzA4mRWy9jplIHmqhSLzo68dCbhdF0D5//2yb69oSMyL5eb
	9myYg9UWz/8m4N4FVAzsdiMtizxg8t2Ry9dGf/vnAeB2BCx64Du57Iikb2QOlYb0
	zTQT/yvZ87vko3nnnezaFgf1fXSRmDHK6tqM5bqhPTK0R1QhkH6e4DOFxcPU3XxA
	oHmK25zS797vc3XC6ZngkyLMMdyj1BHn7wazchlfG7WGjIDXog==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9xdxa96a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:10:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41H0AVpR028868
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
Subject: [PATCH v17 07/51] xhci: add helper that checks for unhandled events on a event ring
Date: Fri, 16 Feb 2024 16:09:33 -0800
Message-ID: <20240217001017.29969-8-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: OqtcXmgp5hk9BQ4aiYJBSZLcWBvz_Vry
X-Proofpoint-GUID: OqtcXmgp5hk9BQ4aiYJBSZLcWBvz_Vry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160189

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Add unhandled_event_trb() that returns true in case xHC hardware has
written new event trbs to the event ring that driver has not yet handled.

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

