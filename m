Return-Path: <linux-kernel+bounces-144795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B588A4ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10561B25A16
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE84E3CF58;
	Mon, 15 Apr 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LUuephRa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDFB3A1DA;
	Mon, 15 Apr 2024 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170967; cv=none; b=nm2kpdMp+YFClwKjN4djE4mqwAeuLKR1inTHXziuD8drpEnjLKS85wzkjLQO/wTQs0PMcQPJcGmQF6k0Iqhj8UphiA1ksFeTFPpw3qcj6qT6leDLPV/ADygroo6C3/ZkpPgRG5UWKmUluYNcSUIxayYeD69QVvCTauCn0NINDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170967; c=relaxed/simple;
	bh=g6kpKgzAHMgSKzudjehksGcsUcrpnUB9QtZmpGZ9ZdU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=j6kS89TFwYvGD2B1LSWbDsjTeb9kw+jkXH8V9HnxAIr69fFuhhNyzIS4u4rrUziCNaHt2ecEilzaOwlsFRgUjt53xrqdeZb9WN3ubrTKSdlJiE1+layPpYAWS3rup1awSBAYkbec5q6mQdAI/6vlJsDWQ4C6Idq3prmNkCurk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LUuephRa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F7C5Wn018166;
	Mon, 15 Apr 2024 08:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=gU29RZ0V3i24
	VCBgtUmCcC2PIz+t/ZVqq7W32gQcB4o=; b=LUuephRag7nN6GAAlOEYIdMEJSbt
	iLnuQUhbRr1V4kW+KW1qJtGjDXeyeRBP0juWwMS8GvYsIuMSUpiTJ2eVdgm03Gty
	KJsm+uJ6A4KZslAtLxOCTvoZNf2puY7fYC4Hq/jjJUPBVUzFlkTonhVM31x3ya/B
	VJApiCVJsUqI9ulY06BXFwGAVacMuLk4xG84Ob3O13sv3ppj/bp5iQBW09qjhE92
	LrRT5vEa8stPV7Klo1Zvpw4H5lo9fRH4fbMVeZFVSZps7lcFXkhOdh0bgnQWQUYk
	1S6wnoTHprDTuE7Zh/E/B7s+EpCYiAC8DbNviSiG0orjXTR8Hl0CWSEZ/A==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgwqfgeyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 08:49:23 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43F8n89u005845;
	Mon, 15 Apr 2024 08:49:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 3xfk4kh5pq-1;
	Mon, 15 Apr 2024 08:49:08 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43F8n7gL005840;
	Mon, 15 Apr 2024 08:49:08 GMT
Received: from cbsp-sh-gv.qualcomm.com (CBSP-SH-gv.ap.qualcomm.com [10.231.249.68])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTP id 43F8n7Oh005839;
	Mon, 15 Apr 2024 08:49:07 +0000
Received: by cbsp-sh-gv.qualcomm.com (Postfix, from userid 4098150)
	id D245D5AF9; Mon, 15 Apr 2024 16:49:06 +0800 (CST)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: mani@kernel.org, quic_jhugo@quicinc.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        quic_mrana@quicinc.com, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v3 0/3] Add sysfs entry to EDL mode
Date: Mon, 15 Apr 2024 16:49:02 +0800
Message-Id: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CAW1G567_-oDGaQHkKJjkUQu5lorpukZ
X-Proofpoint-ORIG-GUID: CAW1G567_-oDGaQHkKJjkUQu5lorpukZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=778 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404150058
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add EDL sysfs entry for mhi controller that provides edl_trigger callback.
Add mhi_pci_generic_edl_trigger for qualcomm sdx55,sdx65 and sdx75 as
edl_trigger callback.

v2->v3:
1. Update Documentation/ABI/stable/sysfs-bus-mhi with description of
   force_edl sysfs entry.

2. Add comments about edl_trigger callback in mhi_controller struct.

3. Follow reverse christmas tree in mhi_pci_generic_edl_trigger.

4. Add a new API in MHI to allow controller to get CHDB address and avoid
   duplicating the definition of CHDBOFF.

v1->v2:
1. Move all process needed by qualcomm sdx55,sdx65,sdx75 to enter EDL into
   mhi_pci_generic_edl_trigger() as the callback to edl_trigger.

2. MHI stack creates EDL sysfs entry to invoke edl_trigger callback so
   that devices need different mechanism to enter EDL can provide its own
   edl_trigger callabck .

Qiang Yu (3):
  bus: mhi: host: Add sysfs entry to force device to enter EDL
  bus: mhi: host: Add a new API for getting channel doorbell address
  bus: mhi: host: pci_generic: Add edl callback to enter EDL

 Documentation/ABI/stable/sysfs-bus-mhi | 11 ++++++++
 drivers/bus/mhi/host/init.c            | 35 +++++++++++++++++++++++++
 drivers/bus/mhi/host/main.c            | 17 ++++++++++++
 drivers/bus/mhi/host/pci_generic.c     | 47 ++++++++++++++++++++++++++++++++++
 include/linux/mhi.h                    |  9 +++++++
 5 files changed, 119 insertions(+)

-- 
2.7.4


