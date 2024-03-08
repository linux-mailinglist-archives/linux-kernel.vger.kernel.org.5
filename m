Return-Path: <linux-kernel+bounces-97017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D0876475
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8B22821A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737518C3B;
	Fri,  8 Mar 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MmeNv1j2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789310A34;
	Fri,  8 Mar 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901705; cv=none; b=UrPbVswEQriRO1ZIckluO3AtMwtUIvTEcKXowjr1/scWk5Nzpg0peF66xkGyAWDJBxbMVJhuiUkGjI1EnAqZZV6gApuM2tb3SfEvIXMRRhCsW/8UElHFlxhO1umYR5kuqPtn7+waHzi1KbWSfmorInDMSdpUbRirD5OgPU988Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901705; c=relaxed/simple;
	bh=pICe2GlJL7NcXxK2+pFuQf8AqphEs57jHM44QIo2Vcc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=J3pCyNWzpI94oS8GlxtcgK3REbWKTk+yDPjlARGocyyqxvoInmJTA+Xn31tJof7Mzu9lqxkAKSWbG0l0u9RcHsCTXfupxjKPh5Hm+CuTDuIbxbEXfShW63bCN0PYsPsEQxrTyu3/nwn8WmO+w8OIsip2h4SfWVnuHTjP9QeEVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MmeNv1j2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4283tO98012824;
	Fri, 8 Mar 2024 12:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=xWK+KGxSm6EY
	uf9aKqHSC0xJscIex/nm/iyXNhqPd/o=; b=MmeNv1j2bvvUXSnA9lMPzNInCs/K
	wv0HfF1gBYsEFdUHq4RDY0KHmb9TxXNNyNxjsSfyVBeONBn+x+GzjNk7ZTsBivFJ
	/Bx9SoOYNAg2JDCbMnccKGxtKiqiPrGYVFFwVg1d0VkBj18vE0dLB7g+W9XcNj+Y
	IBPHY2tHq2COVv6H6q+EbCTgq2xeHvienHbbf6nCvUC1vOW0ELP2CmP3eQObiXjP
	o92iJsDXWiJjrmbchqs34MCbRipMSgX08kxWldwSoUl/1DMDCBnsRDUTZOFeAW4T
	bV7wUZCP/tucJTtLvmz1exd9MMO7skNjR809bhFJfXBYU6QTNs1OAl/vRw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqn8m1rsg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:41:36 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 428CfW9u024479;
	Fri, 8 Mar 2024 12:41:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3wkw6m415d-1;
	Fri, 08 Mar 2024 12:41:32 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428CfWWW024474;
	Fri, 8 Mar 2024 12:41:32 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com [10.213.106.28])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 428CfW5o024472;
	Fri, 08 Mar 2024 12:41:32 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id 68FA95001D9; Fri,  8 Mar 2024 18:11:31 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v2] slimbus: qcom-ngd-ctrl: Reduce auto suspend delay
Date: Fri,  8 Mar 2024 18:11:29 +0530
Message-Id: <20240308124129.7833-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N7kfrcuy2M1ezXttnyc7DxW46hEm_5JO
X-Proofpoint-ORIG-GUID: N7kfrcuy2M1ezXttnyc7DxW46hEm_5JO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=658 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080101
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently we have auto suspend delay of 1s which is
very high and it takes long time to driver for runtime
suspend after use case is done.

Hence to optimize runtime PM ops, reduce auto suspend
delay to 100ms.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
v1 -> v2:
- Remove macro and add value inline.
- Link to v1: https://lore.kernel.org/linux-arm-msm/d784e46d-974d-4bf3-a2d3-491e7ad19701@linaro.org/T/
---
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index efeba8275a66..5e132273c6c4 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -81,7 +81,6 @@
 #define SLIM_USR_MC_DISCONNECT_PORT	0x2E
 #define SLIM_USR_MC_REPEAT_CHANGE_VALUE	0x0
 
-#define QCOM_SLIM_NGD_AUTOSUSPEND	MSEC_PER_SEC
 #define SLIM_RX_MSGQ_TIMEOUT_VAL	0x10000
 
 #define SLIM_LA_MGR	0xFF
@@ -1571,7 +1570,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctrl);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, QCOM_SLIM_NGD_AUTOSUSPEND);
+	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_set_suspended(dev);
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation


