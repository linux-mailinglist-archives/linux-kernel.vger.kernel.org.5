Return-Path: <linux-kernel+bounces-69536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A61858AF0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40A4B2A33D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B46153E2B;
	Sat, 17 Feb 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k5Yb1TGo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAC1B945;
	Sat, 17 Feb 2024 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708128656; cv=none; b=Nd2eUtgsTaPXZExIeT6zmX4CscmDzLAizkp3dA6+0zfNzfLONfqw33acw1lRwxSeHOFbWrxFgYG/Ef4nqvItRMKNtXxMLQjBUuZquQQecDQf4etnJKuEPPis1smMgzrKCIEXMptkarY4ZCgjIKoETZ1Hx4Q9K+5pHTZBOpz6EHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708128656; c=relaxed/simple;
	bh=hs4hOMRK/AhgI6g/f560aidScIAqcjT9ZAylJA9+NLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpyawjqB4SO2h/ThR/EwzAhKguPjGl7WVXvKvz/6Yi++ZIph2ytdF3plgwdCwkXFprb+tLU9y3uiMS70G6en6x083gTVTU+lE7IV+l/f2dk+0fgBxkP8WBGH1C8ef4mki9enx92SlCLSnvKsQwd+oaUJJ37IABXCCh7O3iMq258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k5Yb1TGo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GNxGqq008114;
	Sat, 17 Feb 2024 00:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=C5LVq8sSKytjkg0b0teZ
	7jvmVQi6C7MSy2MGsv4DU1M=; b=k5Yb1TGoqCVYddEmHrTsj0Zgz+qI9Fv5IOBa
	+FP7Sk7Npm6QsGYdQ6usn5cKRRvBElyK8PCda+++IP8nBDQ+CEWteEwuEKlTDteJ
	XBBYr2VJZbf88l38u50vMSlOR/4BLtCECj6h5PIWEtEvjXztiZymtw3lvv7nGTjk
	UcTFaHbhaBDHYcxzmOjK8agnpfZzZhrJY2N9zLiAVfeqY0fBFXaVhi2D5K2WYfrt
	McDcAeP8xlGYZRQUpnjZoR52rTUH5wrvsTPQyZrERIkg8lM6sL1iHYT7AkNwRhof
	VsN47xh0jwdHcHnopxfW7nof9yBAwKhcHIBqmV3VW3Pe9VMqNA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9wxf2cmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:10:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41H0AUou017193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 00:10:30 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 16:10:29 -0800
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
Subject: [PATCH v17 01/51] xhci: Add interrupt pending autoclear flag to each interrupter
Date: Fri, 16 Feb 2024 16:09:27 -0800
Message-ID: <20240217001017.29969-2-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: R4mFVp93FtM6leMTFkKZcNw6zT1Q9nsW
X-Proofpoint-ORIG-GUID: R4mFVp93FtM6leMTFkKZcNw6zT1Q9nsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_23,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=866
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160189

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
index f0d8a607ff21..3d9ec78bfb9f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3063,6 +3063,19 @@ static void xhci_update_erst_dequeue(struct xhci_hcd *xhci,
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
@@ -3112,12 +3125,8 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
 
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
index 32d27134cc48..36c3ba64da51 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1432,6 +1432,7 @@ struct xhci_interrupter {
 	struct xhci_erst	erst;
 	struct xhci_intr_reg __iomem *ir_set;
 	unsigned int		intr_num;
+	bool			ip_autoclear;
 	/* For interrupter registers save and restore over suspend/resume */
 	u32	s3_irq_pending;
 	u32	s3_irq_control;

