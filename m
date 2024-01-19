Return-Path: <linux-kernel+bounces-30967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E748326F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D49284F44
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6F93C47B;
	Fri, 19 Jan 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QZjAvf+j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87625772;
	Fri, 19 Jan 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705657734; cv=none; b=l1Q5R57bmWsbf7GLWNYVqZgbob3HY4fkGYsu2VFFnz8prjJDipqXOva3k1elv/dqRu2a8fxf3IjW4LUzJqvt+oJyzqJ9/ibJJWwQ37lUcP6wkJUdu42xje/c8kF4AoyjAXBTQAKR4MhjTmEbLXfpIhiZpZzgybqt7XhNweNmUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705657734; c=relaxed/simple;
	bh=qHqcD1XjlCcztEDcxsidNeeRlVSfFXwOAuGVi+/+A+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k0KklHxkIM6lmUnTGcpiaZijujBK5vz7pgo5XRNT6fOw0AQKVGy4CMyave3XfevxddNIKNHOBny5yVQGsGLXG2B6MuCdx+hwBdU404dlMjKmz5Vk2NV2Ik7JeAenTUGy5XA5QGKPa7otunEYGZtDNgyWbEz98xqDPcWbP9UqX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QZjAvf+j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J8gi3f021328;
	Fri, 19 Jan 2024 09:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=GezNeHHYLAtAJNmL7Tj8YSoACy84Zqr//JdvOEMbiDI=; b=QZ
	jAvf+jlL1wlwp8xin5I1smDsJF5enh9LzHO0dePRQMvVxWZhlvVgUR1soxtAzOI/
	Yb3WdiBKz6ejr8zeixWyGsUSjymdrTdX7PV7fGQiEwgFkdPvbvywRF+uTKjb9doJ
	9bF+7w71VfCSXIl74P+qGV7XCVqoy1de5aopbs4O4/zzuTqx9Gk0ErnEsFVVWXsm
	eiH5vHaXB5VRvbiYS6a212BDOUr/6jfNkCwqlydm8wyauHdv50yWAkkTdB2rLuhU
	SpA5ZO2heqVVTtCLY4lltF6QPGBD6KDfYrhvOP4iCSjgFcL6rkpQ7ECwnz+bGbT9
	QDhrONVDXxu0GXHVxbBQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqn89g6f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 09:48:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J9ml3G028367
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 09:48:47 GMT
Received: from hu-uaggarwa-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jan 2024 01:48:45 -0800
From: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        "Uttkarsh
 Aggarwal" <quic_uaggarwa@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v3] usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
Date: Fri, 19 Jan 2024 15:18:25 +0530
Message-ID: <20240119094825.26530-1-quic_uaggarwa@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kmENgVCmMH71Onh7VV_fAZtBusRnAycv
X-Proofpoint-ORIG-GUID: kmENgVCmMH71Onh7VV_fAZtBusRnAycv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=900 clxscore=1011
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190042

In current scenario if Plug-out and Plug-In performed continuously
there could be a chance while checking for dwc->gadget_driver in
dwc3_gadget_suspend, a NULL pointer dereference may occur.

Call Stack:

	CPU1:                           CPU2:
	gadget_unbind_driver            dwc3_suspend_common
	dwc3_gadget_stop                dwc3_gadget_suspend
                                        dwc3_disconnect_gadget

CPU1 basically clears the variable and CPU2 checks the variable.
Consider CPU1 is running and right before gadget_driver is cleared
and in parallel CPU2 executes dwc3_gadget_suspend where it finds
dwc->gadget_driver which is not NULL and resumes execution and then
CPU1 completes execution. CPU2 executes dwc3_disconnect_gadget where
it checks dwc->gadget_driver is already NULL because of which the
NULL pointer deference occur.

Cc: <stable@vger.kernel.org>
Fixes: 9772b47a4c29 ("usb: dwc3: gadget: Fix suspend/resume during device mode")
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
---

changes in v3:
Corrected fixes tag and typo mistake in commit message dw3_gadget_stop -> dwc3_gadget_stop.

Link to v2:
https://lore.kernel.org/linux-usb/CAKzKK0r8RUqgXy1o5dndU21KuTKtyZ5rn5Fb9sZqTPZqAjT_9A@mail.gmail.com/T/#t

Changes in v2:
Added cc and fixes tag missing in v1.

Link to v1:
https://lore.kernel.org/linux-usb/20240110095532.4776-1-quic_uaggarwa@quicinc.com/T/#u

 drivers/usb/dwc3/gadget.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 019368f8e9c4..564976b3e2b9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4709,15 +4709,13 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	unsigned long flags;
 	int ret;
 
-	if (!dwc->gadget_driver)
-		return 0;
-
 	ret = dwc3_gadget_soft_disconnect(dwc);
 	if (ret)
 		goto err;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	dwc3_disconnect_gadget(dwc);
+	if (dwc->gadget_driver)
+		dwc3_disconnect_gadget(dwc);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return 0;
-- 
2.17.1


