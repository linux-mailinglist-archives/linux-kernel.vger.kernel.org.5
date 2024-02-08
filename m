Return-Path: <linux-kernel+bounces-58819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBC984ED42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4EFB2C978
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81215C5F1;
	Thu,  8 Feb 2024 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nVQssM6t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BAD50A69;
	Thu,  8 Feb 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434081; cv=none; b=k6o0/4y/uCFNBri65Z74+SllONLrClYptR88RqhxkOlMpcFqeaNeNwxCf9YZQVjeyPFSvvwH7NAzc7v4qXekdwSyTe6MCm1TQgP8qE6SZED3J5wVO76aJhem3qOpBA/XcchQibwep9AtxarEK1UOSPEzpQdQ7Ho2sDZhUC3exJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434081; c=relaxed/simple;
	bh=/ctydeO9BP9IDNCKzOW84UaD1pWVBJmsNl/Vixk3Z5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkZY9ipzkBQjDdj7Uk898r/G9UvOY4bhQDSMXLCt0S2R3OrJKeAhQlVSAqYmnZNqxqCV8dW2ATBH6NqHhwXuWEFZQDJof4NU5FlWioP02M0rPiV7+fqyF3TZSgt1P3zyHEBmoWRJd24rmHHhbtYpoG+wj5cA4h1z2Xzahs5/0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nVQssM6t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418KhRQ8019816;
	Thu, 8 Feb 2024 23:14:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=2sOcjxKmnstL/5ftZf58
	41vds3YmEI4sRJLRwbFI4Jw=; b=nVQssM6tWjWN+AaUAvEFXjHBVSCl3GR1MBZh
	mZFhvLraLcunmZDyhyQSOKFzRqUd/Mw3Y5IvW5xNhYUS0CpIBDF2tixyabrxLKvA
	e5i3Er14Y8SwtwFliKeNPHTCCF+mgIsluMGAeCDQ3Oj4J7km9R1eCIZVTsGocVh2
	o4TSc7EJUvSZsRWRMpToJBnc1zBvyCf7aNJV1GnM7uw54YQTiQxp/trSTsoi+A3I
	rP040Qj3+mrKgJfiPDqCnFzjPAZjpewOwzYoHMv+LNfy2jE9fPswvNXeQdbS3Aoe
	csJQq7b6ZIahHEpZ3Diw/VNZmh+oPErw4ooZShyXh8w1GYpPgg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4frwujtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NEGP5009144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:16 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:15 -0800
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
Subject: [PATCH v14 01/53] xhci: fix possible null pointer dereference at secondary interrupter removal
Date: Thu, 8 Feb 2024 15:13:14 -0800
Message-ID: <20240208231406.27397-2-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UP_Bh-r2YyQE-WRxE1odBi-VgumwIQ2N
X-Proofpoint-GUID: UP_Bh-r2YyQE-WRxE1odBi-VgumwIQ2N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080131

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Don't try to remove a secondary interrupter that is known to be invalid.
Also check if the interrupter is valid inside the spinlock that protects
the array of interrupters.

Found by smatch static checker

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-usb/ffaa0a1b-5984-4a1f-bfd3-9184630a97b9@moroto.mountain/
Fixes: c99b38c41234 ("xhci: add support to allocate several interrupters")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240125152737.2983959-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-mem.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 4460fa7e9fab..d00d4d937236 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1861,14 +1861,14 @@ void xhci_remove_secondary_interrupter(struct usb_hcd *hcd, struct xhci_interrup
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	unsigned int intr_num;
 
+	spin_lock_irq(&xhci->lock);
+
 	/* interrupter 0 is primary interrupter, don't touch it */
-	if (!ir || !ir->intr_num || ir->intr_num >= xhci->max_interrupters)
+	if (!ir || !ir->intr_num || ir->intr_num >= xhci->max_interrupters) {
 		xhci_dbg(xhci, "Invalid secondary interrupter, can't remove\n");
-
-	/* fixme, should we check xhci->interrupter[intr_num] == ir */
-	/* fixme locking */
-
-	spin_lock_irq(&xhci->lock);
+		spin_unlock_irq(&xhci->lock);
+		return;
+	}
 
 	intr_num = ir->intr_num;
 

