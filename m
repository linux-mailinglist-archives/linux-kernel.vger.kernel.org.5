Return-Path: <linux-kernel+bounces-58825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3784ED68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E558283F92
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501115103F;
	Thu,  8 Feb 2024 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FTjnsN7f"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD0C50A64;
	Thu,  8 Feb 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434082; cv=none; b=o/GRnR69Ni/gsgOmqiBKBfQVhn8g+lGaEHa0HDracfLKdkVmm5xN99DvcRFUx/MHGsMAZHWFyvm2k0VMgZWNRpp/sswHRKcmpi1EUc2BnuwuOGRPOc6e/wNHRbbQDSvDbcdz/Ie8LgdPrZ0eK6vWILhBzLXc0uAeCP6MTgt2mps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434082; c=relaxed/simple;
	bh=SI/xXqTaKb918srbROgcUJ5EMq0uUfJ689ErJLs6vMk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHke/d2EWjvjzXu5cmuWFSnEIeM17N+K6u7iRVYkP8+ZC0l26X3aDqEOQb6sXySCZiFoLXrVpR7w/GLZfjPhrAbJXBbJpEW59kfhfwSo2SHk7H3Dlnu6yPZ8jIhaZQBdxFx2aoHoo7WpHldTuu8FQEjfEaQ7uFyIZgJr6yYW/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FTjnsN7f; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418NEMq7019885;
	Thu, 8 Feb 2024 23:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=R0hg4dDBYEp27ZuNyVb3
	W+iuKNUNsrbwtnpJmQVwa24=; b=FTjnsN7fdVxAc2UvYiKmD7fm7FQr8NGOD5oG
	hylWH/q5ztdYWV8QEYQDwtQT4b2FDgKSFbl7k3VjeoMq0/zmueXyAGq4n5u+PLPh
	tzLFBZftaxflalTmf6LOk+ormn9pJSykakdjhC/mwJVG8xDlBQh3GQoLtKSPS/c7
	vLXmo9Xj+G27ySI4NjYgG63iNECeqvF9Ng3kkO0wd4O7y9QyBcbHt3NEJsMazCI7
	j9eZwsf4qvLXNmtpT54g6bVPXSAMUJM4ZaaT9PXWVWXsRC3hmTkK0RbTVQUggwKw
	dqfE83RXKDmy78hEKncHWD3az8clMAWuRd29aK8kwEaX2MmROQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4m3ak1pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NEKeM009184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:20 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:20 -0800
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
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v14 17/53] usb: host: xhci-sideband: Expose a sideband interrupter enable API
Date: Thu, 8 Feb 2024 15:13:30 -0800
Message-ID: <20240208231406.27397-18-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UMRFRDIAwbd-beul10c12h01cINUObdh
X-Proofpoint-GUID: UMRFRDIAwbd-beul10c12h01cINUObdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=864 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080131

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

