Return-Path: <linux-kernel+bounces-50827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26350847E80
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598B11C21E9E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED5C2C2;
	Sat,  3 Feb 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cP6Z6uDO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF563D1;
	Sat,  3 Feb 2024 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927867; cv=none; b=pW1XuXvS+Neu4x9Mi281zVcD316LtNjDV8RF4QQwx5sJwQp4lizTzGbjDzk6+Co3Yi7Q9NTxlRZhaEfkHZReJKRN1HuP5uk8lO3zBmXucgB0yHjoVVpD6up4n7yOfCtGQ3tW6d3c6elIk07qDhqwZOydFWGnY95ov/4xiCCjtmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927867; c=relaxed/simple;
	bh=u1nuq17zD0xhgBZbYsuMjFfbINv/RaVLoPTPOjJ2BuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/d1PAOfZgK1PuciT0Ltir2idkLfF7ISaVvEAM460fg2JaJu0Zj2DIONLoUW7+4ZD2ry2oUsNPV1xrQWfo+DKCliR57/fN0lKT7BY5QM8oXjZlRCpqFZMyrGmZB1BA+IFlB3+EWsVqr5nmiJhUFg1KxZQMGwcAenc2b+2Dp3zIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cP6Z6uDO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4132PUCt002860;
	Sat, 3 Feb 2024 02:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=cPeqWAOHiC/DRr2Pu2t5
	FImj3arw3vFei7pmew6OZTU=; b=cP6Z6uDOl2quqgTKT9mluYa60go76oXDvGp2
	vjl4WQh4/NAFagKC52RYY37V05M/XcXYzhPODr1TYLCMuJ00IfHxWRver9Fddsz7
	xeqk0NSkE9OJI8TlituzReFgjm3auFNjsIXhn3dJbrrL6x/Tmd3C5ZFqawudMJ6+
	moA/8o1olzeoWS31yla5hApN9Gj3Gw+1CGEnedGWbnTrp9Vy6utQBYpMwDcOEtPj
	Mp1PVHM9EXCWiop/s1BdFtuL8edPwZdwS4ZTnJkK+IuQERyycR1Zsuf0tz8nIb9U
	jHurEEv7y8YJCpYIuHhUX7TLSY990m/Hey41qEiHB7primOEXw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwjjuht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 02:37:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4132bIVc003506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 02:37:18 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 18:37:18 -0800
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
Subject: [PATCH v13 04/53] xhci: Add helper to set an interrupters interrupt moderation interval
Date: Fri, 2 Feb 2024 18:35:56 -0800
Message-ID: <20240203023645.31105-5-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: tZfZScfQ2utlznKT4y6RWKKTlslZSepE
X-Proofpoint-ORIG-GUID: tZfZScfQ2utlznKT4y6RWKKTlslZSepE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402030014

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Add a helper to set the interrupt moderation interval for an interrupter.
Each interrupter can have its own moderation value.

Hardware has a 16bit register for the moderation value, each step is 250ns.

Helper function imod_interval argument is in nanoseconds.

Values from 0 to 16383750 (250 x 0xffff) are accepted.
0 means no interrupt throttling.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0886829d53e5..b405b8236134 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -346,6 +346,23 @@ static int xhci_disable_interrupter(struct xhci_interrupter *ir)
 	return 0;
 }
 
+/* interrupt moderation interval imod_interval in nanoseconds */
+static int xhci_set_interrupter_moderation(struct xhci_interrupter *ir,
+					   u32 imod_interval)
+{
+	u32 imod;
+
+	if (!ir || !ir->ir_set || imod_interval > U16_MAX * 250)
+		return -EINVAL;
+
+	imod = readl(&ir->ir_set->irq_control);
+	imod &= ~ER_IRQ_INTERVAL_MASK;
+	imod |= (imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
+	writel(imod, &ir->ir_set->irq_control);
+
+	return 0;
+}
+
 static void compliance_mode_recovery(struct timer_list *t)
 {
 	struct xhci_hcd *xhci;
@@ -528,7 +545,6 @@ static int xhci_run_finished(struct xhci_hcd *xhci)
  */
 int xhci_run(struct usb_hcd *hcd)
 {
-	u32 temp;
 	u64 temp_64;
 	int ret;
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
@@ -551,12 +567,7 @@ int xhci_run(struct usb_hcd *hcd)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
 			"ERST deq = 64'h%0lx", (long unsigned int) temp_64);
 
-	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
-			"// Set the interrupt modulation register");
-	temp = readl(&ir->ir_set->irq_control);
-	temp &= ~ER_IRQ_INTERVAL_MASK;
-	temp |= (xhci->imod_interval / 250) & ER_IRQ_INTERVAL_MASK;
-	writel(temp, &ir->ir_set->irq_control);
+	xhci_set_interrupter_moderation(ir, xhci->imod_interval);
 
 	if (xhci->quirks & XHCI_NEC_HOST) {
 		struct xhci_command *command;

