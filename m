Return-Path: <linux-kernel+bounces-58812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E096284EC8F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BFB2892D8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134A53812;
	Thu,  8 Feb 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F8n6wV8j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6EF50A6A;
	Thu,  8 Feb 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434080; cv=none; b=Sm/lJsd1YtQcW4aWdzsy2ni2qlA/p02pjsbJ71sQttBy/UScYA1Iz/n2A/G0MidDvdBokPiepPRm6ee6FAx06URm/ccV22zw7KvjZrnEmTUu8wLbhe1jQMy1EzfIwh7ddu0IXBuyqLxA2ZltwKbfEg4k6yQxRwBQ8Ek4O5vKSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434080; c=relaxed/simple;
	bh=AUzYa+W3vXThhkfZrkvq18z95m/MUhJSaK13Esrt9IU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjD2vG+QzThH7SlwRH0jvHACrr4XNDzLd6mQYfkZOczW0xNNbDBdnnjeP7DCd6FQu8A1JVPpjayXRX952ZxpmzMt3+3xBM1T5oQp+0ZNgt1CGXnZKfH0krKSfHVHHRUv831a17Zq1qWeBDMyvUiRZoZvnSgW75PvQmNIFh+c+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F8n6wV8j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418Mqt56008173;
	Thu, 8 Feb 2024 23:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=jumcsyHAMPRdK6BBRrtX
	rViYw1o9e9jHI3H7NDZD9Tc=; b=F8n6wV8jo+3D4QCffSq7/J+CRknaj8BZan6H
	2vdUiWpqscI0/NfaYSGm+ykyvuspkiZ0VT3wwpqeCRrEihJJGdo5du54zYJ9pDmd
	0VkDAklAesRtj3IxJDOSfUQXyPz6MiqIZjlFqW7H7OFxACOkf2igx0A8EAUhJD2B
	YwfsfK3s9vwIchro7lznOQKxAF4nGVJCSy1CCChHzq+D/1z/Ot4KmTGI4BDHGKCf
	rtpjLiWM6drs9M0wv1W3+dyO2sUQlveN6i3ADBHCQl5Qg2B/ESk0jK2clEImVWwd
	ObuWTOGN5xZho6cSIsFdHfUzWx5L9m/MgosNPZEGL9It62hnYQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4sns2aan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NEGtP022030
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:16 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:16 -0800
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
Subject: [PATCH v14 02/53] xhci: fix off by one check when adding a secondary interrupter.
Date: Thu, 8 Feb 2024 15:13:15 -0800
Message-ID: <20240208231406.27397-3-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: VLcCHzYUv4yxZ_dA3mNz8QIsNh7SR_HZ
X-Proofpoint-GUID: VLcCHzYUv4yxZ_dA3mNz8QIsNh7SR_HZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402080131

From: Mathias Nyman <mathias.nyman@linux.intel.com>

The sanity check of interrupter index when adding a new interrupter is
off by one. intr_num needs to be smaller than xhci->max_interrupter to
fit the array of interrupters.

Luckily this doesn't cause any real word harm as xhci_add_interrupter()
is always called with a intr_num value smaller than xhci->max_interrupters
in any current kernel.

Should not be needed for stable as 6.7 kernel and older only supports
one interrupter, with intr_num always being zero.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-usb/e9771296-586d-456a-ac24-a82de79bb2e6@moroto.mountain/
Fixes: 4bf398e15aa4 ("xhci: split allocate interrupter into separate alloacte and add parts")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240125152737.2983959-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index d00d4d937236..a7716202a8dd 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2322,7 +2322,7 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
 	u64 erst_base;
 	u32 erst_size;
 
-	if (intr_num > xhci->max_interrupters) {
+	if (intr_num >= xhci->max_interrupters) {
 		xhci_warn(xhci, "Can't add interrupter %d, max interrupters %d\n",
 			  intr_num, xhci->max_interrupters);
 		return -EINVAL;

