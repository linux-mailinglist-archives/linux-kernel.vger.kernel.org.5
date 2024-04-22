Return-Path: <linux-kernel+bounces-154149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C921D8AD836
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317F6B21002
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFAC15E1E7;
	Mon, 22 Apr 2024 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d2w0/2gU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D613E88B;
	Mon, 22 Apr 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826210; cv=none; b=eU+dFbdzQgfhAdu+D8kZjDwLPVPPq8S5EtKEksz7jlS/m9yeE2sij1ipl4WdOZi9Tgqk0RFbJTJLH8B+ixv0pflsUpsiJDlRffBalaXf5OIioVfHAqGWYYd0ZBEPSTSeiohEJxRDbyOJw1v7lL0N+p9wsAmqoc87tT11PaM2Op4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826210; c=relaxed/simple;
	bh=SI/xXqTaKb918srbROgcUJ5EMq0uUfJ689ErJLs6vMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EzhsvdjP2ZJTXRmvPDW2U2zD6/pLyL0hAgh1BCVUrmSyvn+PbVnLaFYsRoM76Jlsx27jQOWLrIp+OWZzkCAAO3t4TNvAf4b0YJAkD/YlbASo/ki4YCtCHHdBfDf7ppJNh/0mY7QgcJjOXNyFWxLSw7TX+cPc6y23M3AlMS8J3AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d2w0/2gU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MLpgCg008228;
	Mon, 22 Apr 2024 22:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=R0hg4dDBYEp27ZuNyVb3
	W+iuKNUNsrbwtnpJmQVwa24=; b=d2w0/2gUPy4GLpMM2FOk6WJZ1xAly7/mm3Hq
	Iagse6S4lqEubpHETD0QunqvJn19hhuB2nXjoZLIl/Pi5qwMhWZ3UHEOrAMgrJ4P
	vYe1w1lQ1R7DIj4eeOiSUy6eeHIamlVzU87jy75sGxiHJ2qUCyoRe4eurxi2VoRd
	b5VaUho+6J2dk4W+kzVH8sxLc0DLeI+T2+1EFfgfbczGyzjjuH0FeoTJF/JuC+Au
	p+SyQroqRgoxtzibLRQCToBqw7PIybmDnQubMSkE5cXjmQ2lVY5lpgHPoHXVSm25
	TEQcYYv47MjDp83WR2FIQYjFUtqLwHayMiZehbL+UzU64nujYw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnr0mha51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MMnIWv021872
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:18 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 15:49:17 -0700
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v19 06/41] usb: host: xhci-sideband: Expose a sideband interrupter enable API
Date: Mon, 22 Apr 2024 15:48:31 -0700
Message-ID: <20240422224906.15868-7-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240422224906.15868-1-quic_wcheng@quicinc.com>
References: <20240422224906.15868-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: B0tEuBCjri3wXonhBVcHcBdPY1vrPmor
X-Proofpoint-ORIG-GUID: B0tEuBCjri3wXonhBVcHcBdPY1vrPmor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=992 lowpriorityscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220096

Some use cases maybe require that the secondary interrupter's events to
be handled by the OS.  In this case, configure the IMOD and the
skip_events property to enable the interrupter's events.  By default,
assume that the secondary interrupter doesn't want to enable OS event
handling.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-sideband.c  | 28 ++++++++++++++++++++++++++++
 include/linux/usb/xhci-sideband.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index 0944bf31d772..504a6f1586b5 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -237,6 +237,30 @@ xhci_sideband_get_event_buffer(struct xhci_sideband *sb)
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_get_event_buffer);
 
+/**
+ * xhci_sideband_enable_interrupt - enable interrupt for secondary interrupter
+ * @sb: sideband instance for this usb device
+ * @imod_interval: number of event ring segments to allocate
+ *
+ * Enables OS owned event handling for a particular interrupter if client
+ * requests for it.  In addition, set the IMOD interval for this particular
+ * interrupter.
+ *
+ * Returns 0 on success, negative error otherwise
+ */
+int xhci_sideband_enable_interrupt(struct xhci_sideband *sb, u32 imod_interval)
+{
+	if (!sb || !sb->ir)
+		return -ENODEV;
+
+	xhci_set_interrupter_moderation(sb->ir, imod_interval);
+	sb->ir->skip_events = false;
+	xhci_enable_interrupter(sb->ir);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_enable_interrupt);
+
 /**
  * xhci_sideband_create_interrupter - creates a new interrupter for this sideband
  * @sb: sideband instance for this usb device
@@ -275,6 +299,8 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 	}
 
 	sb->ir->ip_autoclear = ip_autoclear;
+	/* skip events for secondary interrupters by default */
+	sb->ir->skip_events = true;
 
 out:
 	mutex_unlock(&sb->mutex);
@@ -297,6 +323,8 @@ xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 		return;
 
 	mutex_lock(&sb->mutex);
+	if (!sb->ir->skip_events)
+		xhci_disable_interrupter(sb->ir);
 	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
 
 	sb->ir = NULL;
diff --git a/include/linux/usb/xhci-sideband.h b/include/linux/usb/xhci-sideband.h
index 1035dae43cee..a749ae307ba7 100644
--- a/include/linux/usb/xhci-sideband.h
+++ b/include/linux/usb/xhci-sideband.h
@@ -54,6 +54,8 @@ xhci_sideband_get_endpoint_buffer(struct xhci_sideband *sb,
 struct sg_table *
 xhci_sideband_get_event_buffer(struct xhci_sideband *sb);
 
+int xhci_sideband_enable_interrupt(struct xhci_sideband *sb, u32 imod_interval);
+
 int
 xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 				 bool ip_autoclear);

